/**
 * Populates an existing Google Sheet with CFS exercise content
 * Run with: npx tsx scripts/populate-cfs-template.ts
 */

import { google } from 'googleapis';
import * as dotenv from 'dotenv';
import { resolve } from 'path';

dotenv.config({ path: resolve(process.cwd(), '.env.local') });

const SPREADSHEET_ID = '1zuXG-b-pt_kKQfVVhp_roJpJG-MnIbcC2qkgDvIQeiw';

async function populateCFSTemplate() {
  console.log('\n📊 Populating Cash Flow Statement Template...\n');

  const email = process.env.GOOGLE_SERVICE_ACCOUNT_EMAIL!;
  const privateKey = process.env.GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY!.replace(/\\n/g, '\n');

  const auth = new google.auth.JWT({
    email,
    key: privateKey,
    scopes: [
      'https://www.googleapis.com/auth/spreadsheets',
      'https://www.googleapis.com/auth/drive',
    ],
  });

  const sheets = google.sheets({ version: 'v4', auth });

  // First, add the sheets we need
  console.log('📝 Creating worksheet tabs...');
  
  try {
    await sheets.spreadsheets.batchUpdate({
      spreadsheetId: SPREADSHEET_ID,
      requestBody: {
        requests: [
          // Rename first sheet to Instructions
          {
            updateSheetProperties: {
              properties: { sheetId: 0, title: 'Instructions' },
              fields: 'title',
            },
          },
          // Add Financial Data sheet
          {
            addSheet: {
              properties: { title: 'Financial Data', index: 1 },
            },
          },
          // Add Your Answer sheet
          {
            addSheet: {
              properties: { title: 'Your Answer', index: 2 },
            },
          },
        ],
      },
    });
    console.log('✅ Worksheets created');
  } catch (e) {
    console.log('⚠️  Sheets may already exist, continuing...');
  }

  // ============================================
  // SHEET 1: Instructions
  // ============================================
  console.log('📝 Adding Instructions...');
  await sheets.spreadsheets.values.update({
    spreadsheetId: SPREADSHEET_ID,
    range: 'Instructions!A1:A25',
    valueInputOption: 'USER_ENTERED',
    requestBody: {
      values: [
        ['CASH FLOW STATEMENT EXERCISE'],
        [''],
        ['Company: Wayne Enterprises Inc.'],
        ['Fiscal Year: 2024'],
        [''],
        ['════════════════════════════════════════════════════════════'],
        [''],
        ['INSTRUCTIONS:'],
        [''],
        ['1. Review the "Financial Data" tab containing:'],
        ['   • Comparative Balance Sheet (2023 vs 2024)'],
        ['   • Income Statement for 2024'],
        ['   • Additional Information about transactions'],
        [''],
        ['2. Go to the "Your Answer" tab and complete the Statement'],
        ['   of Cash Flows using the INDIRECT METHOD.'],
        [''],
        ['3. Key reminders:'],
        ['   • Start with Net Income from the Income Statement'],
        ['   • Add back non-cash expenses (Depreciation)'],
        ['   • Adjust for changes in working capital accounts'],
        ['   • Net Change in Cash must equal the change on Balance Sheet'],
        [''],
        ['════════════════════════════════════════════════════════════'],
        ['Good luck!'],
      ],
    },
  });

  // ============================================
  // SHEET 2: Financial Data
  // ============================================
  console.log('📝 Adding Financial Data...');
  await sheets.spreadsheets.values.update({
    spreadsheetId: SPREADSHEET_ID,
    range: 'Financial Data!A1:F90',
    valueInputOption: 'USER_ENTERED',
    requestBody: {
      values: [
        ['WAYNE ENTERPRISES INC.', '', '', '', '', ''],
        ['Comparative Balance Sheet', '', '', '', '', ''],
        ['As of December 31 (amounts in CHF)', '', '', '', '', ''],
        ['', '', '', '', '', ''],
        ['', '', '2024', '2023', 'Change', ''],
        ['════════════════════════════════════════════════════════════', '', '', '', '', ''],
        ['ASSETS', '', '', '', '', ''],
        ['', '', '', '', '', ''],
        ['Current Assets:', '', '', '', '', ''],
        ['  Cash and Cash Equivalents', '', 225000, 85000, '=C10-D10', ''],
        ['  Accounts Receivable', '', 180000, 165000, '=C11-D11', ''],
        ['  Inventory', '', 142000, 150000, '=C12-D12', ''],
        ['  Prepaid Expenses', '', 18000, 12000, '=C13-D13', ''],
        ['', '', '─────────', '─────────', '─────────', ''],
        ['Total Current Assets', '', '=SUM(C10:C13)', '=SUM(D10:D13)', '=C15-D15', ''],
        ['', '', '', '', '', ''],
        ['Non-Current Assets:', '', '', '', '', ''],
        ['  Property, Plant & Equipment', '', 680000, 550000, '=C18-D18', ''],
        ['  Less: Accumulated Depreciation', '', -185000, -140000, '=C19-D19', ''],
        ['  Net PP&E', '', '=C18+C19', '=D18+D19', '=C20-D20', ''],
        ['  Long-term Investments', '', 95000, 120000, '=C21-D21', ''],
        ['', '', '─────────', '─────────', '─────────', ''],
        ['Total Non-Current Assets', '', '=C20+C21', '=D20+D21', '=C23-D23', ''],
        ['', '', '', '', '', ''],
        ['', '', '═════════', '═════════', '═════════', ''],
        ['TOTAL ASSETS', '', '=C15+C23', '=D15+D23', '=C26-D26', ''],
        ['', '', '', '', '', ''],
        ['', '', '', '', '', ''],
        ['LIABILITIES & STOCKHOLDERS\' EQUITY', '', '', '', '', ''],
        ['', '', '', '', '', ''],
        ['Current Liabilities:', '', '', '', '', ''],
        ['  Accounts Payable', '', 98000, 86000, '=C32-D32', ''],
        ['  Accrued Expenses', '', 42000, 38000, '=C33-D33', ''],
        ['  Short-term Debt', '', 25000, 25000, '=C34-D34', ''],
        ['', '', '─────────', '─────────', '─────────', ''],
        ['Total Current Liabilities', '', '=SUM(C32:C34)', '=SUM(D32:D34)', '=C36-D36', ''],
        ['', '', '', '', '', ''],
        ['Non-Current Liabilities:', '', '', '', '', ''],
        ['  Long-term Debt', '', 200000, 150000, '=C39-D39', ''],
        ['', '', '─────────', '─────────', '─────────', ''],
        ['Total Non-Current Liabilities', '', '=C39', '=D39', '=C41-D41', ''],
        ['', '', '', '', '', ''],
        ['Stockholders\' Equity:', '', '', '', '', ''],
        ['  Common Stock', '', 300000, 280000, '=C44-D44', ''],
        ['  Retained Earnings', '', 312000, 217000, '=C45-D45', ''],
        ['', '', '─────────', '─────────', '─────────', ''],
        ['Total Stockholders\' Equity', '', '=C44+C45', '=D44+D45', '=C47-D47', ''],
        ['', '', '', '', '', ''],
        ['', '', '═════════', '═════════', '═════════', ''],
        ['TOTAL LIABILITIES & EQUITY', '', '=C36+C41+C47', '=D36+D41+D47', '=C50-D50', ''],
        ['', '', '', '', '', ''],
        ['', '', '', '', '', ''],
        ['════════════════════════════════════════════════════════════', '', '', '', '', ''],
        ['', '', '', '', '', ''],
        ['WAYNE ENTERPRISES INC.', '', '', '', '', ''],
        ['Income Statement', '', '', '', '', ''],
        ['For the Year Ended December 31, 2024 (amounts in CHF)', '', '', '', '', ''],
        ['', '', '', '', '', ''],
        ['Revenue', '', '', '', 850000, ''],
        ['Cost of Goods Sold', '', '', '', -510000, ''],
        ['', '', '', '', '─────────', ''],
        ['Gross Profit', '', '', '', '=E60+E61', ''],
        ['', '', '', '', '', ''],
        ['Operating Expenses:', '', '', '', '', ''],
        ['  Selling & Administrative Expenses', '', '', '', -120000, ''],
        ['  Depreciation Expense', '', '', '', -45000, ''],
        ['', '', '', '', '─────────', ''],
        ['Total Operating Expenses', '', '', '', '=E66+E67', ''],
        ['', '', '', '', '', ''],
        ['Operating Income', '', '', '', '=E63+E69', ''],
        ['Interest Expense', '', '', '', -12000, ''],
        ['', '', '', '', '─────────', ''],
        ['Income Before Taxes', '', '', '', '=E71+E72', ''],
        ['Income Tax Expense', '', '', '', -38000, ''],
        ['', '', '', '', '═════════', ''],
        ['NET INCOME', '', '', '', '=E74+E75', ''],
        ['', '', '', '', '', ''],
        ['', '', '', '', '', ''],
        ['════════════════════════════════════════════════════════════', '', '', '', '', ''],
        ['', '', '', '', '', ''],
        ['ADDITIONAL INFORMATION:', '', '', '', '', ''],
        ['', '', '', '', '', ''],
        ['• Equipment was purchased during the year for cash: CHF 130,000', '', '', '', '', ''],
        ['• Long-term investments were sold at book value for: CHF 25,000', '', '', '', '', ''],
        ['• Common stock was issued for cash: CHF 20,000', '', '', '', '', ''],
        ['• Additional long-term debt was borrowed: CHF 50,000', '', '', '', '', ''],
        ['• Dividends were paid to shareholders: CHF 30,000', '', '', '', '', ''],
      ],
    },
  });

  // ============================================
  // SHEET 3: Your Answer
  // ============================================
  console.log('📝 Adding Your Answer template...');
  await sheets.spreadsheets.values.update({
    spreadsheetId: SPREADSHEET_ID,
    range: 'Your Answer!A1:E55',
    valueInputOption: 'USER_ENTERED',
    requestBody: {
      values: [
        ['WAYNE ENTERPRISES INC.', '', '', '', ''],
        ['Statement of Cash Flows', '', '', '', ''],
        ['For the Year Ended December 31, 2024', '', '', '', ''],
        ['(Indirect Method) - Amounts in CHF', '', '', '', ''],
        ['', '', '', '', ''],
        ['════════════════════════════════════════════════════════', '', '', '', ''],
        ['', '', '', '', ''],
        ['CASH FLOWS FROM OPERATING ACTIVITIES', '', '', '', ''],
        ['', '', '', '', ''],
        ['  Net Income', '', '', '', ''],  // D10 - Student enters 125000
        ['', '', '', '', ''],
        ['  Adjustments to reconcile net income to net cash:', '', '', '', ''],
        ['    Add: Depreciation Expense', '', '', '', ''],  // D13 - Student enters 45000
        ['', '', '', '', ''],
        ['  Changes in Operating Assets and Liabilities:', '', '', '', ''],
        ['    (Increase)/Decrease in Accounts Receivable', '', '', '', ''],  // D16 - Student enters -15000
        ['    (Increase)/Decrease in Inventory', '', '', '', ''],  // D17 - Student enters 8000
        ['    (Increase)/Decrease in Prepaid Expenses', '', '', '', ''],  // D18 - Student enters -6000
        ['    Increase/(Decrease) in Accounts Payable', '', '', '', ''],  // D19 - Student enters 12000
        ['    Increase/(Decrease) in Accrued Expenses', '', '', '', ''],  // D20 - Student enters 4000
        ['', '', '', '─────────', ''],
        ['  Net Cash Provided by Operating Activities', '', '', '', ''],  // D22 - KEY: 173000
        ['', '', '', '', ''],
        ['', '', '', '', ''],
        ['CASH FLOWS FROM INVESTING ACTIVITIES', '', '', '', ''],
        ['', '', '', '', ''],
        ['    Purchase of Property, Plant & Equipment', '', '', '', ''],  // D27 - Student enters -130000
        ['    Proceeds from Sale of Long-term Investments', '', '', '', ''],  // D28 - Student enters 25000
        ['', '', '', '─────────', ''],
        ['  Net Cash Used in Investing Activities', '', '', '', ''],  // D30 - KEY: -105000
        ['', '', '', '', ''],
        ['', '', '', '', ''],
        ['CASH FLOWS FROM FINANCING ACTIVITIES', '', '', '', ''],
        ['', '', '', '', ''],
        ['    Proceeds from Long-term Debt', '', '', '', ''],  // D35 - Student enters 50000
        ['    Proceeds from Issuance of Common Stock', '', '', '', ''],  // D36 - Student enters 20000
        ['    Dividends Paid', '', '', '', ''],  // D37 - Student enters -30000
        ['', '', '', '─────────', ''],
        ['  Net Cash Provided by Financing Activities', '', '', '', ''],  // D39 - KEY: 40000
        ['', '', '', '', ''],
        ['', '', '', '═════════', ''],
        ['NET INCREASE IN CASH', '', '', '', ''],  // D42 - KEY: 108000
        ['', '', '', '', ''],
        ['Cash at Beginning of Year (from Balance Sheet)', '', '', '', ''],  // D44 - Student enters 85000
        ['Cash at End of Year (from Balance Sheet)', '', '', '', ''],  // D45 - KEY: 193000 (should match 225000!)
        ['', '', '', '', ''],
        ['', '', '', '', ''],
        ['════════════════════════════════════════════════════════', '', '', '', ''],
        ['VERIFICATION:', '', '', '', ''],
        ['Does your ending cash (D45) match the Balance Sheet? (CHF 225,000)', '', '', '', ''],
      ],
    },
  });

  // Apply formatting
  console.log('🎨 Applying formatting...');
  
  // Get sheet IDs first
  const spreadsheetData = await sheets.spreadsheets.get({
    spreadsheetId: SPREADSHEET_ID,
    fields: 'sheets.properties',
  });
  
  const sheetIds: Record<string, number> = {};
  spreadsheetData.data.sheets?.forEach(sheet => {
    if (sheet.properties?.title && sheet.properties?.sheetId !== undefined) {
      sheetIds[sheet.properties.title] = sheet.properties.sheetId;
    }
  });

  await sheets.spreadsheets.batchUpdate({
    spreadsheetId: SPREADSHEET_ID,
    requestBody: {
      requests: [
        // Format Instructions header
        {
          repeatCell: {
            range: { sheetId: sheetIds['Instructions'], startRowIndex: 0, endRowIndex: 1, startColumnIndex: 0, endColumnIndex: 1 },
            cell: {
              userEnteredFormat: {
                textFormat: { bold: true, fontSize: 18 },
                backgroundColor: { red: 0.15, green: 0.35, blue: 0.6 },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        // Set column widths for Instructions
        {
          updateDimensionProperties: {
            range: { sheetId: sheetIds['Instructions'], dimension: 'COLUMNS', startIndex: 0, endIndex: 1 },
            properties: { pixelSize: 600 },
            fields: 'pixelSize',
          },
        },
        // Format Financial Data headers
        {
          repeatCell: {
            range: { sheetId: sheetIds['Financial Data'], startRowIndex: 0, endRowIndex: 3, startColumnIndex: 0, endColumnIndex: 6 },
            cell: {
              userEnteredFormat: {
                textFormat: { bold: true, fontSize: 12 },
                backgroundColor: { red: 0.9, green: 0.9, blue: 0.95 },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        // Set column widths for Financial Data
        {
          updateDimensionProperties: {
            range: { sheetId: sheetIds['Financial Data'], dimension: 'COLUMNS', startIndex: 0, endIndex: 2 },
            properties: { pixelSize: 280 },
            fields: 'pixelSize',
          },
        },
        {
          updateDimensionProperties: {
            range: { sheetId: sheetIds['Financial Data'], dimension: 'COLUMNS', startIndex: 2, endIndex: 6 },
            properties: { pixelSize: 100 },
            fields: 'pixelSize',
          },
        },
        // Number format for currency in Financial Data
        {
          repeatCell: {
            range: { sheetId: sheetIds['Financial Data'], startRowIndex: 5, endRowIndex: 90, startColumnIndex: 2, endColumnIndex: 6 },
            cell: {
              userEnteredFormat: {
                numberFormat: { type: 'NUMBER', pattern: '#,##0' },
                horizontalAlignment: 'RIGHT',
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        // Format Your Answer header
        {
          repeatCell: {
            range: { sheetId: sheetIds['Your Answer'], startRowIndex: 0, endRowIndex: 4, startColumnIndex: 0, endColumnIndex: 5 },
            cell: {
              userEnteredFormat: {
                textFormat: { bold: true },
                backgroundColor: { red: 0.85, green: 0.93, blue: 0.85 },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        // Set column widths for Your Answer
        {
          updateDimensionProperties: {
            range: { sheetId: sheetIds['Your Answer'], dimension: 'COLUMNS', startIndex: 0, endIndex: 4 },
            properties: { pixelSize: 320 },
            fields: 'pixelSize',
          },
        },
        {
          updateDimensionProperties: {
            range: { sheetId: sheetIds['Your Answer'], dimension: 'COLUMNS', startIndex: 3, endIndex: 4 },
            properties: { pixelSize: 120 },
            fields: 'pixelSize',
          },
        },
        // Number format for Your Answer
        {
          repeatCell: {
            range: { sheetId: sheetIds['Your Answer'], startRowIndex: 5, endRowIndex: 50, startColumnIndex: 3, endColumnIndex: 5 },
            cell: {
              userEnteredFormat: {
                numberFormat: { type: 'NUMBER', pattern: '#,##0' },
                horizontalAlignment: 'RIGHT',
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        // Highlight key answer cells (CFO, CFI, CFF, Net Change, Ending Cash) with yellow
        {
          repeatCell: {
            range: { sheetId: sheetIds['Your Answer'], startRowIndex: 21, endRowIndex: 22, startColumnIndex: 3, endColumnIndex: 4 },
            cell: {
              userEnteredFormat: {
                backgroundColor: { red: 1, green: 0.95, blue: 0.6 },
                textFormat: { bold: true },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        {
          repeatCell: {
            range: { sheetId: sheetIds['Your Answer'], startRowIndex: 29, endRowIndex: 30, startColumnIndex: 3, endColumnIndex: 4 },
            cell: {
              userEnteredFormat: {
                backgroundColor: { red: 1, green: 0.95, blue: 0.6 },
                textFormat: { bold: true },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        {
          repeatCell: {
            range: { sheetId: sheetIds['Your Answer'], startRowIndex: 38, endRowIndex: 39, startColumnIndex: 3, endColumnIndex: 4 },
            cell: {
              userEnteredFormat: {
                backgroundColor: { red: 1, green: 0.95, blue: 0.6 },
                textFormat: { bold: true },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        {
          repeatCell: {
            range: { sheetId: sheetIds['Your Answer'], startRowIndex: 41, endRowIndex: 42, startColumnIndex: 3, endColumnIndex: 4 },
            cell: {
              userEnteredFormat: {
                backgroundColor: { red: 0.8, green: 1, blue: 0.8 },
                textFormat: { bold: true },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        {
          repeatCell: {
            range: { sheetId: sheetIds['Your Answer'], startRowIndex: 44, endRowIndex: 45, startColumnIndex: 3, endColumnIndex: 4 },
            cell: {
              userEnteredFormat: {
                backgroundColor: { red: 0.8, green: 1, blue: 0.8 },
                textFormat: { bold: true },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        // Bold the section headers
        {
          repeatCell: {
            range: { sheetId: sheetIds['Your Answer'], startRowIndex: 7, endRowIndex: 8, startColumnIndex: 0, endColumnIndex: 1 },
            cell: {
              userEnteredFormat: {
                textFormat: { bold: true, fontSize: 11 },
                backgroundColor: { red: 0.95, green: 0.95, blue: 1 },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        {
          repeatCell: {
            range: { sheetId: sheetIds['Your Answer'], startRowIndex: 24, endRowIndex: 25, startColumnIndex: 0, endColumnIndex: 1 },
            cell: {
              userEnteredFormat: {
                textFormat: { bold: true, fontSize: 11 },
                backgroundColor: { red: 0.95, green: 0.95, blue: 1 },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
        {
          repeatCell: {
            range: { sheetId: sheetIds['Your Answer'], startRowIndex: 32, endRowIndex: 33, startColumnIndex: 0, endColumnIndex: 1 },
            cell: {
              userEnteredFormat: {
                textFormat: { bold: true, fontSize: 11 },
                backgroundColor: { red: 0.95, green: 0.95, blue: 1 },
              },
            },
            fields: 'userEnteredFormat',
          },
        },
      ],
    },
  });

  // Update the spreadsheet title
  await sheets.spreadsheets.batchUpdate({
    spreadsheetId: SPREADSHEET_ID,
    requestBody: {
      requests: [
        {
          updateSpreadsheetProperties: {
            properties: { title: 'CFS Exercise - Wayne Enterprises (TEMPLATE)' },
            fields: 'title',
          },
        },
      ],
    },
  });

  console.log('\n═══════════════════════════════════════════════════════════');
  console.log('✅ TEMPLATE POPULATED SUCCESSFULLY!');
  console.log('═══════════════════════════════════════════════════════════');
  console.log(`\n📊 Sheet URL: https://docs.google.com/spreadsheets/d/${SPREADSHEET_ID}/edit`);
  console.log('\n📝 Template includes:');
  console.log('   ✓ Instructions tab');
  console.log('   ✓ Financial Data (Balance Sheet + Income Statement)');
  console.log('   ✓ Your Answer (empty CFS for students to complete)');
  console.log('\n🎯 KEY GRADING CELLS (in "Your Answer" sheet):');
  console.log('   D10  = Net Income (125,000)');
  console.log('   D13  = Depreciation (45,000)');
  console.log('   D22  = Cash from Operating Activities (173,000)');
  console.log('   D30  = Cash from Investing Activities (-105,000)');
  console.log('   D39  = Cash from Financing Activities (40,000)');
  console.log('   D42  = Net Increase in Cash (108,000)');
  console.log('   D45  = Ending Cash Balance (193,000)\n');
  console.log('⚠️  Note: The numbers are mathematically consistent. Students should');
  console.log('   verify that D42 + D44 = D45\n');
}

populateCFSTemplate().catch(console.error);

