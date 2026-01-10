# Interactive Activity QA Report

**Date:** January 9, 2026  
**Tested By:** Automated QA Review  
**Test Account:** victor.troillet@ehl.ch  
**Environment:** localhost:3000 (Development)

---

## Executive Summary

This report documents a comprehensive review of all interactive activity types in the Tutorio application. Testing covered lesson viewers, quizzes, code exercises, checkpoints, interactive exercises, and spreadsheet activities.

### Overall Status

| Category | Status | Issues Found |
|----------|--------|--------------|
| Lessons | PASS | 0 |
| Quizzes | PASS | 0 |
| Checkpoints | PASS | 0 |
| Interactive Exercises | PARTIAL | 1 Minor |
| Code Exercises | PASS (Fixed) | 1 Critical (RESOLVED) |
| Spreadsheet Exercises | FAIL | 1 Major |

---

## Critical Issues (Resolved)

### 1. Code Exercises: Pyodide CDN Blocked by CSP - FIXED

**Severity:** CRITICAL  
**Status:** RESOLVED  
**Impact:** All Python code exercises were completely non-functional  
**Location:** `next.config.ts` line 31-32

**Symptoms (Before Fix):**
- "Run Code" button remained permanently disabled
- Console error: `Loading the script 'https://cdn.jsdelivr.net/pyodide/v0.24.1/full/pyodide.js' violates the following Content Security Policy directive`

**Root Cause:**
The Content Security Policy in `next.config.ts` did not include the Pyodide CDN in the `script-src` directive.

**Fix Applied:**
Updated `next.config.ts` to include cdn.jsdelivr.net in both `script-src` and `connect-src`:

```typescript
// next.config.ts - Updated line 31-32
{
  key: "Content-Security-Policy",
  value:
    "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://js.stripe.com https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; img-src 'self' data: https:; font-src 'self' https://fonts.gstatic.com https://fonts.googleapis.com; frame-src https://js.stripe.com https://hooks.stripe.com https://docs.google.com https://*.google.com; connect-src 'self' https://*.supabase.co wss://*.supabase.co https://api.openai.com https://api.stripe.com https://cdn.jsdelivr.net;",
}
```

**Verification:**
- Tested code exercise at `/skills/ds-lists-basics/for-practice`
- "Run Code" button now enables after Pyodide loads
- Code execution works
- Test results display correctly (0/2 tests passing with detailed feedback)

**Files Modified:**
- `next.config.ts`

---

## Major Issues

### 2. Spreadsheet Exercises: Missing Grading Criteria Data

**Severity:** MAJOR  
**Impact:** CFS Builder exercises show "0 points total" with no input fields  
**Location:** Database / Activity Content

**Symptoms:**
- Activities like "Complete CFS Builder Challenge" and "CFS Case Study: Wayne Enterprises" display:
  - "Enter Your Answers" heading
  - "0 points total"
  - No actual input fields or grading criteria
  - "Check Answers" button present but no fields to check

**Activities Tested:**
- `/skills/cfs-interpretation/complete-cfs-builder-challenge` - BROKEN
- `/skills/cfs-interpretation/cfs-case-study-wayne-enterprises` - BROKEN

**Root Cause:**
The API endpoint `/api/sheets?action=criteria` returns empty grading criteria for these activities. The database likely has missing or malformed `content` data for these spreadsheet activities.

**Recommended Fix:**
1. Check the `activities` table for records with `interactive_type = 'cfs-builder'` or `'spreadsheet'`
2. Verify the `content` JSONB field contains proper `grading_criteria` arrays
3. Expected content structure:

```json
{
  "title": "CFS Builder Challenge",
  "instructions": "Complete the Cash Flow Statement",
  "grading_criteria": [
    {
      "cell": "B5",
      "label": "Net Income",
      "expected_value": 125000,
      "points": 10,
      "tolerance": 0
    }
  ]
}
```

4. Run a database migration or seed script to populate missing criteria

**Files to Check:**
- `src/app/api/sheets/route.ts`
- `src/components/activities/spreadsheet-exercise-viewer.tsx`
- `supabase/seed.sql` or relevant migration files

---

## Minor Issues

### 3. Some Python Skills Show "No Activities Yet"

**Severity:** MINOR  
**Impact:** UX inconsistency - Skills marked as "Mastered" but have no content

**Symptoms:**
- Skills like "Print & Output" show "0 Activities" and "No Activities Yet"
- But course progress shows 100% complete

**Activities Tested:**
- `/skills/py-print-output` - Shows "0 Activities"

**Recommendation:**
Either populate activities for these skills or update the skill status to reflect that they're concept-only skills.

---

## Passed Tests (Working Correctly)

### Lesson Viewer (LessonViewer)
- **Status:** PASS
- **Activities Tested:** "Advanced Bond Accounting"
- **Features Verified:**
  - Title and metadata display (duration, XP)
  - Markdown rendering (headings, tables, code blocks, blockquotes, lists, emphasis)
  - "Complete Lesson" button visible
  - Navigation (Previous/Next)
  - AI tutor "Ask Bob" button
  - No console errors

### Quiz Viewer (QuizViewer)
- **Status:** PASS
- **Activities Tested:** "Adjusting Entries Quiz"
- **Features Verified:**
  - Question text displays correctly
  - MCQ options (A, B, C, D) functional
  - Question counter (Question X of Y)
  - Progress indicator (X/Y answered)
  - Answer selection works
  - Correct/incorrect feedback with explanations
  - Options disabled after selection
  - Progress counter updates
  - "Next Question" button enables after answer
  - Navigation works

### Checkpoint Viewer (CheckpointViewer)
- **Status:** PASS
- **Activities Tested:** "Module 8 Checkpoint"
- **Features Verified:**
  - Start screen with checkpoint info
  - Passing score requirement displayed (75%)
  - Question count displayed (4 questions)
  - "Start Checkpoint" button functional
  - Questions display correctly after starting
  - MCQ options work
  - Progress tracking (X/Y answered)
  - Question navigation dots

### Interactive Exercises (Choice-based)
- **Status:** PASS
- **Activities Tested:** "Bonds Payable Basics"
- **Features Verified:**
  - Instructions display correctly
  - Step progress tracking (1/5, 2/5, etc.)
  - Multiple choice buttons functional
  - Selection highlighting (active state)
  - "Check Answer" button enables after selection
  - Navigation works

### Interactive Exercises (Numeric Input)
- **Status:** PASS
- **Activities Tested:** "Prepaid Expense Practice"
- **Features Verified:**
  - Spinbutton input fields
  - Step-by-step progress
  - "Complete Exercise" button visible

---

## Testing Environment Details

### Courses Accessed:
1. Financial Accounting Fundamentals (92% complete, Advanced Plan)
2. Computational Thinking (100% complete, Advanced Plan)
3. Managerial Accounting (0% complete, Free Demo)

### Activity Types Coverage:

| Activity Type | Type Value | Viewer Component | Status |
|--------------|------------|------------------|--------|
| Lessons | `lesson` | LessonViewer | PASS |
| Quizzes | `quiz` | QuizViewer | PASS |
| Code Exercises | `code` | CodeEditor | PASS (Fixed) |
| Challenges | `challenge` | CodeEditor | PASS (Fixed) |
| Checkpoints | `checkpoint` | CheckpointViewer | PASS |
| Mock Exams | `mock_exam` | CheckpointViewer | Not Tested |
| Interactives | `interactive` | InteractiveViewer | PARTIAL |

### Interactive Subtypes Tested:

| Interactive Type | Status | Notes |
|-----------------|--------|-------|
| Choice-based | PASS | Button selections work |
| Numeric input | PASS | Spinbutton inputs work |
| spreadsheet/cfs-builder | FAIL | Missing grading criteria |

---

## Recommended Actions (Priority Order)

### Completed

1. ~~**Fix CSP for Pyodide**~~ - DONE - Updated `next.config.ts` to include `https://cdn.jsdelivr.net` in `script-src` and `connect-src`

### Immediate (Before Production)

2. **Populate Spreadsheet Grading Criteria** - Update database records for CFS activities with proper `grading_criteria` content

### Short-term

3. **Add Activities to Empty Skills** - Populate "Print & Output" and similar foundation skills

### Testing Recommendations

4. **After Data Fix:** Re-test spreadsheet exercises with grading functionality

---

## Appendix: Console Errors Observed

```
[ERROR] Loading the script 'https://cdn.jsdelivr.net/pyodide/v0.24.1/full/pyodide.js' 
violates the following Content Security Policy directive: 
"script-src 'self' 'unsafe-inline' 'unsafe-eval' https://js.stripe.com". 
Note that 'script-src-elem' was not explicitly set, so 'script-src' is used as a fallback.
@ code-editor.tsx:210
```

---

## Files Referenced

- `src/app/(protected)/skills/[skillSlug]/[activitySlug]/page.tsx` - Activity routing
- `src/components/activities/lesson-viewer.tsx` - Lesson display
- `src/components/activities/quiz-viewer.tsx` - Quiz functionality
- `src/components/activities/checkpoint-viewer.tsx` - Checkpoint/exam handling
- `src/components/activities/code-editor.tsx` - Python code execution
- `src/components/activities/interactive-viewer.tsx` - Interactive routing
- `src/components/activities/spreadsheet-exercise-viewer.tsx` - Spreadsheet exercises
- `next.config.ts` - CSP configuration
- `src/app/api/sheets/route.ts` - Spreadsheet API

---

*Report generated from automated testing session on January 9, 2026*

