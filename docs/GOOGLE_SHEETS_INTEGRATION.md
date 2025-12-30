# Google Sheets Integration for Financial Analysis Course

This document describes the complete Google Sheets API integration for Tutorio's Financial Analysis course, enabling spreadsheet-based exercises with automatic grading.

## Overview

The integration allows:
- **Per-user sheet copies**: Each user gets their own copy of a template Google Sheet
- **Embedded editing**: Users can work on sheets directly within the app
- **Automatic grading**: Key cells are checked against expected values
- **Progress tracking**: Completion status is saved and synced with activity progress

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Frontend (React)                         │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │              GoogleSheetsViewer Component                   ││
│  │  - Displays embedded sheet iframe                           ││
│  │  - Handles create/grade/reset actions                       ││
│  │  - Shows grading results                                    ││
│  └─────────────────────────────────────────────────────────────┘│
└───────────────────────────────┬─────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                      API Routes (/api/sheets)                   │
│  GET  - Get user's sheet status                                 │
│  POST - Create new sheet copy for user                          │
│  PUT  - Grade sheet exercise                                    │
│  DELETE - Reset/delete user's sheet                             │
└───────────────────────────────┬─────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                   Server Actions & Service                      │
│  ┌─────────────────────┐    ┌─────────────────────────────────┐│
│  │  actions.ts         │    │  GoogleSheetsService            ││
│  │  - getUserSheet     │───▶│  - copyTemplateForUser          ││
│  │  - createUserSheet  │    │  - readCellValues               ││
│  │  - gradeUserSheet   │    │  - gradeSheetExercise           ││
│  │  - resetUserSheet   │    │  - deleteSheet                  ││
│  └─────────────────────┘    └──────────────┬──────────────────┘│
└─────────────────────────────────────────────┼───────────────────┘
                                              │
              ┌───────────────────────────────┼───────────────────┐
              │                               ▼                   │
              │                   Google APIs                     │
              │  ┌─────────────────┐  ┌──────────────────────┐   │
              │  │  Sheets API v4  │  │     Drive API v3     │   │
              │  │  - Read cells   │  │  - Copy files        │   │
              │  │  - Get metadata │  │  - Set permissions   │   │
              │  └─────────────────┘  │  - Delete files      │   │
              │                       └──────────────────────┘   │
              └───────────────────────────────────────────────────┘
                                              │
                                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         Supabase                                │
│  ┌─────────────────────┐  ┌───────────────────────────────────┐│
│  │    user_sheets      │  │    sheet_grading_criteria         ││
│  │  - user_id          │  │  - activity_id                    ││
│  │  - activity_id      │  │  - cell_reference                 ││
│  │  - user_sheet_id    │  │  - expected_value                 ││
│  │  - is_completed     │  │  - points                         ││
│  │  - completion_data  │  │  - hint_on_error                  ││
│  └─────────────────────┘  └───────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
```

## Setup Guide

### 1. Create a Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the following APIs:
   - Google Sheets API
   - Google Drive API

### 2. Create a Service Account

1. Go to **IAM & Admin** > **Service Accounts**
2. Click **Create Service Account**
3. Name it (e.g., `tutorio-sheets-service`)
4. Grant it no roles (we'll handle permissions via sharing)
5. Create a key (JSON format)
6. Download and securely store the JSON key file

### 3. Configure Environment Variables

Add to your `.env.local`:

```bash
# Google Sheets Integration
GOOGLE_SERVICE_ACCOUNT_EMAIL=your-service-account@project.iam.gserviceaccount.com
GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
GOOGLE_SHEETS_FOLDER_ID=your-folder-id  # Optional: folder for user copies
```

**Important**: The private key must include the newline characters. In most deployment platforms, you can paste the key as-is, but in `.env` files, wrap it in quotes.

### 4. Create a Template Folder (Optional but Recommended)

1. In Google Drive, create a folder for student sheet copies
2. Share the folder with your service account email (Editor access)
3. Copy the folder ID from the URL and set it as `GOOGLE_SHEETS_FOLDER_ID`

### 5. Install Dependencies

```bash
npm install googleapis
```

### 6. Run Database Migration

```bash
npx supabase migration up
```

Or apply migration 049 manually.

## Creating Sheet-Based Exercises

### Step 1: Create the Template Sheet

1. Create a Google Sheet with:
   - Clear instructions
   - Pre-filled data (e.g., comparative balance sheets)
   - Designated cells for student answers
   - Professional formatting

2. Share the sheet with your service account email (Viewer access)

3. Copy the sheet ID from the URL:
   ```
   https://docs.google.com/spreadsheets/d/SHEET_ID_HERE/edit
   ```

### Step 2: Set Up the Activity

Create an activity with:

```sql
INSERT INTO activities (
  module_id,
  external_id,
  order_index,
  title,
  slug,
  type,
  interactive_type,
  content,
  passing_score,
  xp,
  is_published
) VALUES (
  'module-uuid',
  'FA-CFS-001',
  1,
  'Build a Cash Flow Statement',
  'cfs-builder',
  'interactive',
  'google-sheets',
  '{
    "template_sheet_id": "YOUR_TEMPLATE_SHEET_ID",
    "exercise_title": "Wayne Enterprises Cash Flow Statement",
    "instructions": "Using the indirect method, prepare a complete Statement of Cash Flows from the provided financial data."
  }',
  70,
  50,
  true
);
```

### Step 3: Define Grading Criteria

```sql
INSERT INTO sheet_grading_criteria (
  activity_id,
  cell_reference,
  cell_name,
  expected_value,
  expected_type,
  tolerance,
  is_required,
  points,
  sort_order,
  hint_on_error
) VALUES 
  ('activity-uuid', 'Sheet1!D18', 'Cash from Operations', '175000', 'number', 0.01, true, 10, 1, 'Remember to add back depreciation'),
  ('activity-uuid', 'Sheet1!D25', 'Cash from Investing', '-55000', 'number', 0.01, true, 8, 2, 'Equipment purchases use cash'),
  ('activity-uuid', 'Sheet1!D32', 'Cash from Financing', '20000', 'number', 0.01, true, 8, 3, NULL),
  ('activity-uuid', 'Sheet1!D36', 'Net Change in Cash', '140000', 'number', 0.01, true, 10, 4, 'Must equal CFO + CFI + CFF');
```

### Using the Helper Function

```sql
SELECT setup_sheets_exercise(
  'activity-uuid'::UUID,
  'your-template-sheet-id',
  'Cash Flow Statement Exercise',
  'Build a complete CFS using the indirect method.',
  '[
    {"cell": "D18", "name": "Cash from Operations", "expected": "175000", "points": 10},
    {"cell": "D25", "name": "Cash from Investing", "expected": "-55000", "points": 8},
    {"cell": "D32", "name": "Cash from Financing", "expected": "20000", "points": 8},
    {"cell": "D36", "name": "Net Change in Cash", "expected": "140000", "points": 10}
  ]'::JSONB
);
```

## Grading Configuration

### Expected Types

| Type | Description | Example |
|------|-------------|---------|
| `number` | Numeric value with optional tolerance | `175000` |
| `text` | Exact text match (case-insensitive) | `"Increase"` |
| `boolean` | True/false | `true` |
| `formula` | Check formula result | `"=SUM(B2:B10)"` |

### Tolerance

For numeric values, tolerance is expressed as a percentage:
- `0` = Exact match
- `0.01` = 1% tolerance (default)
- `0.05` = 5% tolerance

### Points System

- Each criterion has a `points` value
- Total points = sum of all criteria points
- Score % = (earned points / total points) × 100
- Exercise passes if score % ≥ activity's `passing_score`

## User Experience Flow

```
1. User opens activity
   │
   ▼
2. "Start Exercise" button shown
   │
   ▼
3. User clicks button → Sheet copy created
   │
   ▼
4. Embedded sheet displayed in app
   │
   ├──▶ User works in embedded sheet OR
   │    opens in Google Sheets (new tab)
   │
   ▼
5. User clicks "Check Answers"
   │
   ▼
6. System reads specified cells via API
   │
   ▼
7. Cells compared against expected values
   │
   ▼
8. Results displayed with feedback
   │
   ├──▶ Passed: Activity marked complete
   │
   └──▶ Failed: User can retry
```

## Security Considerations

1. **Service Account Access**: Only the service account can read cell values. Users cannot access other users' sheets.

2. **Row-Level Security**: Database records are protected by RLS policies.

3. **Template Protection**: Template sheets should be shared as "Viewer" with the service account. Copies inherit this structure.

4. **No Sensitive Data**: Avoid storing sensitive information in templates.

## Best Practices

### Template Design

1. **Clear Structure**: Use consistent cell references across exercises
2. **Locked Cells**: Lock template cells that shouldn't be edited
3. **Validation**: Add data validation where appropriate
4. **Formatting**: Use conditional formatting to highlight answer cells

### Grading Setup

1. **Key Cells Only**: Don't grade every cell—focus on key outputs
2. **Meaningful Hints**: Provide helpful feedback for common errors
3. **Reasonable Tolerance**: Allow for rounding differences
4. **Balanced Points**: Weight cells by importance

### Performance

1. **Batch Reads**: The system reads all cells in one API call
2. **Caching**: User sheet records are cached in the database
3. **Lazy Loading**: Sheet is only created when user starts

## Troubleshooting

### "Failed to create sheet copy"

- Check service account has access to template
- Verify template sheet ID is correct
- Ensure APIs are enabled in Google Cloud

### "Failed to read cell values"

- Verify cell references are correct (include sheet name if not Sheet1)
- Check service account still has access to user's copy
- Ensure cell reference format is correct (e.g., `Sheet1!A1`)

### Sheet Not Displaying

- Check browser allows third-party cookies
- Verify embed URL is correctly formatted
- Try opening in Google Sheets directly

### Grading Returns Wrong Results

- Verify expected values match actual cell format
- Check for hidden characters in cell references
- Ensure numeric cells aren't formatted as text

## API Reference

### GET /api/sheets

Query params:
- `activityId` - Activity UUID
- `action` - Optional: `status` or `criteria`

### POST /api/sheets

Body:
```json
{
  "activityId": "uuid",
  "templateSheetId": "google-sheet-id",
  "exerciseTitle": "Exercise Name"
}
```

### PUT /api/sheets

Body:
```json
{
  "activityId": "uuid"
}
```

### DELETE /api/sheets

Query params:
- `activityId` - Activity UUID

## Future Enhancements

- [ ] Real-time collaboration indicators
- [ ] Version history comparison
- [ ] Partial credit for close answers
- [ ] Formula validation (not just result)
- [ ] Export completed sheets as PDF
- [ ] Peer review features

