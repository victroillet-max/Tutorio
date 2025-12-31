-- Migration: Mock Exam Module for Financial Accounting
-- Creates mock exam activities in the appropriate module

-- Get the Financial Analysis module (Module 10) for the mock exam activities
-- These activities will be added to the existing FA course structure

-- Create Mock Exam Activity 1: Comprehensive Practice Exam
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0010-000000000030',
  'fa000000-0000-0000-0000-000000000010',
  '10.30',
  30,
  'Practice Exam: Financial Accounting Fundamentals',
  'practice-exam-fa-fundamentals',
  'interactive',
  60,
  100,
  'basic',
  '{
    "exam_title": "Financial Accounting Practice Exam",
    "instructions": "This practice exam simulates real exam conditions. Complete all sections within the time limit. You can navigate between questions and review your answers before submitting.",
    "time_limit_minutes": 60,
    "passing_score": 60,
    "sections": [
      {
        "id": "section-1",
        "title": "Financial Statements Fundamentals",
        "questions": [
          {
            "id": "q1-1",
            "type": "mcq",
            "topic": "Financial Statements",
            "question": "Which financial statement shows a company''s financial position at a specific point in time?",
            "options": ["Income Statement", "Balance Sheet", "Cash Flow Statement", "Statement of Retained Earnings"],
            "correctAnswer": "Balance Sheet",
            "points": 2,
            "explanation": "The Balance Sheet (Statement of Financial Position) shows assets, liabilities, and equity at a specific date, providing a snapshot of financial position."
          },
          {
            "id": "q1-2",
            "type": "mcq",
            "topic": "Accounting Equation",
            "question": "A company purchases equipment for $50,000 cash. How does this affect the accounting equation?",
            "options": [
              "Assets increase by $50,000",
              "Assets decrease by $50,000",
              "No change in total assets",
              "Liabilities increase by $50,000"
            ],
            "correctAnswer": "No change in total assets",
            "points": 2,
            "explanation": "This is an asset exchange: Cash decreases by $50,000 while Equipment increases by $50,000, resulting in no net change to total assets."
          },
          {
            "id": "q1-3",
            "type": "mcq",
            "topic": "Revenue Recognition",
            "question": "Under accrual accounting, when should revenue be recognized?",
            "options": [
              "When cash is received",
              "When goods are ordered",
              "When the performance obligation is satisfied",
              "At the end of the accounting period"
            ],
            "correctAnswer": "When the performance obligation is satisfied",
            "points": 2,
            "explanation": "Under accrual accounting and IFRS 15, revenue is recognized when performance obligations are satisfied, regardless of when cash is received."
          },
          {
            "id": "q1-4",
            "type": "calculation",
            "topic": "Accounting Equation",
            "question": "If a company has assets of $500,000 and liabilities of $200,000, what is the shareholders'' equity?",
            "correctAnswer": 300000,
            "points": 3,
            "explanation": "Using A = L + E: $500,000 = $200,000 + E, therefore E = $300,000",
            "hint": "Use the accounting equation: Assets = Liabilities + Equity"
          }
        ]
      },
      {
        "id": "section-2",
        "title": "Adjusting Entries",
        "questions": [
          {
            "id": "q2-1",
            "type": "mcq",
            "topic": "Adjusting Entries",
            "question": "Which type of adjusting entry is needed when services have been performed but not yet recorded or billed?",
            "options": ["Prepaid expense", "Accrued revenue", "Unearned revenue", "Depreciation"],
            "correctAnswer": "Accrued revenue",
            "points": 2,
            "explanation": "Accrued revenue is recorded when services have been performed (revenue earned) but cash hasn''t been received and no invoice has been sent yet."
          },
          {
            "id": "q2-2",
            "type": "mcq",
            "topic": "Depreciation",
            "question": "Equipment costs $100,000, has a salvage value of $10,000, and a useful life of 5 years. Using straight-line depreciation, what is the annual depreciation expense?",
            "options": ["$20,000", "$18,000", "$15,000", "$22,000"],
            "correctAnswer": "$18,000",
            "points": 2,
            "explanation": "Straight-line depreciation = (Cost - Salvage Value) / Useful Life = ($100,000 - $10,000) / 5 = $18,000 per year."
          },
          {
            "id": "q2-3",
            "type": "calculation",
            "topic": "Prepaid Expenses",
            "question": "A company pays $12,000 for a one-year insurance policy on March 1. What is the insurance expense for the year ending December 31?",
            "correctAnswer": 10000,
            "points": 3,
            "explanation": "The policy covers March through February (12 months). For the current year ending Dec 31, 10 months of coverage applies: $12,000 x 10/12 = $10,000.",
            "hint": "Calculate how many months of coverage apply to the current year"
          },
          {
            "id": "q2-4",
            "type": "mcq",
            "topic": "Unearned Revenue",
            "question": "A company receives $6,000 in advance for services to be provided over 6 months. After 2 months, what is the unearned revenue balance?",
            "options": ["$6,000", "$4,000", "$2,000", "$0"],
            "correctAnswer": "$4,000",
            "points": 2,
            "explanation": "After 2 months, $2,000 worth of services have been earned ($6,000 x 2/6). The remaining $4,000 is still unearned."
          }
        ]
      },
      {
        "id": "section-3",
        "title": "Cash Flow Statement",
        "questions": [
          {
            "id": "q3-1",
            "type": "mcq",
            "topic": "Cash Flow Classification",
            "question": "Payment to suppliers for inventory would be classified as which type of cash flow activity?",
            "options": ["Operating", "Investing", "Financing", "Non-cash"],
            "correctAnswer": "Operating",
            "points": 2,
            "explanation": "Payments to suppliers for inventory are part of normal business operations and are classified as operating activities."
          },
          {
            "id": "q3-2",
            "type": "mcq",
            "topic": "Cash Flow Classification",
            "question": "Proceeds from issuing common stock would be classified as which type of cash flow activity?",
            "options": ["Operating", "Investing", "Financing", "Non-cash"],
            "correctAnswer": "Financing",
            "points": 2,
            "explanation": "Issuing stock involves raising capital from owners, which is a financing activity."
          },
          {
            "id": "q3-3",
            "type": "mcq",
            "topic": "Indirect Method",
            "question": "When using the indirect method, why is depreciation expense added back to net income?",
            "options": [
              "Because it generates cash",
              "Because it reduces net income but doesn''t use cash",
              "Because it increases assets",
              "Because it''s a financing activity"
            ],
            "correctAnswer": "Because it reduces net income but doesn''t use cash",
            "points": 2,
            "explanation": "Depreciation is a non-cash expense that reduced net income. Since no cash was spent, we add it back when calculating cash from operations."
          },
          {
            "id": "q3-4",
            "type": "calculation",
            "topic": "Cash Flow Analysis",
            "question": "Net income is $80,000. Depreciation is $15,000. Accounts receivable increased by $5,000. What is cash flow from operations?",
            "correctAnswer": 90000,
            "points": 4,
            "explanation": "CFO = Net Income + Depreciation - Increase in A/R = $80,000 + $15,000 - $5,000 = $90,000. The A/R increase represents sales not yet collected (cash outflow).",
            "hint": "Start with net income, add non-cash expenses, adjust for working capital changes"
          }
        ]
      },
      {
        "id": "section-4",
        "title": "Financial Analysis",
        "questions": [
          {
            "id": "q4-1",
            "type": "calculation",
            "topic": "Profitability Ratios",
            "question": "Net income is $45,000 and total revenue is $300,000. What is the net profit margin (as a percentage)?",
            "correctAnswer": 15,
            "points": 3,
            "explanation": "Net Profit Margin = Net Income / Revenue x 100 = $45,000 / $300,000 x 100 = 15%",
            "hint": "Net Profit Margin = Net Income / Revenue x 100"
          },
          {
            "id": "q4-2",
            "type": "mcq",
            "topic": "Liquidity Ratios",
            "question": "Which ratio best measures a company''s ability to pay short-term obligations without relying on inventory?",
            "options": ["Current ratio", "Quick ratio", "Debt-to-equity ratio", "Return on assets"],
            "correctAnswer": "Quick ratio",
            "points": 2,
            "explanation": "The Quick Ratio (Acid-test) = (Current Assets - Inventory) / Current Liabilities, measuring liquidity without relying on inventory conversion."
          },
          {
            "id": "q4-3",
            "type": "calculation",
            "topic": "Efficiency Ratios",
            "question": "Cost of goods sold is $400,000 and average inventory is $80,000. What is the inventory turnover ratio?",
            "correctAnswer": 5,
            "points": 3,
            "explanation": "Inventory Turnover = Cost of Goods Sold / Average Inventory = $400,000 / $80,000 = 5 times",
            "hint": "Inventory Turnover = COGS / Average Inventory"
          },
          {
            "id": "q4-4",
            "type": "mcq",
            "topic": "Solvency Ratios",
            "question": "A debt-to-equity ratio of 2.0 means:",
            "options": [
              "The company has twice as much equity as debt",
              "The company has twice as much debt as equity",
              "The company has equal debt and equity",
              "The company is debt-free"
            ],
            "correctAnswer": "The company has twice as much debt as equity",
            "points": 2,
            "explanation": "D/E = 2.0 means Total Debt / Total Equity = 2, indicating debt is twice the amount of equity."
          }
        ]
      }
    ]
  }',
  'mock-exam',
  60,
  false,
  true
);

-- Create a second shorter practice quiz
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0010-000000000031',
  'fa000000-0000-0000-0000-000000000010',
  '10.31',
  31,
  'Quick Review: Mixed Topics',
  'quick-review-mixed-topics',
  'interactive',
  20,
  50,
  'basic',
  '{
    "exam_title": "Quick Review Quiz",
    "instructions": "This is a shorter practice quiz to help you review key concepts. Complete it at your own pace.",
    "time_limit_minutes": 20,
    "passing_score": 70,
    "sections": [
      {
        "id": "mixed-section",
        "title": "Mixed Topics Review",
        "questions": [
          {
            "id": "qr-1",
            "type": "mcq",
            "topic": "Double-Entry",
            "question": "When recording a credit sale, which accounts are affected?",
            "options": [
              "Debit Cash, Credit Revenue",
              "Debit Accounts Receivable, Credit Revenue",
              "Debit Revenue, Credit Accounts Receivable",
              "Debit Cash, Credit Accounts Receivable"
            ],
            "correctAnswer": "Debit Accounts Receivable, Credit Revenue",
            "points": 2,
            "explanation": "A credit sale increases A/R (asset, debit) and increases Revenue (credit). Cash isn''t involved until payment is received."
          },
          {
            "id": "qr-2",
            "type": "mcq",
            "topic": "Current Assets",
            "question": "Which of these is NOT typically classified as a current asset?",
            "options": ["Accounts Receivable", "Prepaid Insurance", "Land", "Inventory"],
            "correctAnswer": "Land",
            "points": 2,
            "explanation": "Land is a long-term (non-current) asset because it is not expected to be converted to cash within one year."
          },
          {
            "id": "qr-3",
            "type": "calculation",
            "topic": "Bad Debt",
            "question": "Year-end accounts receivable is $100,000. The company estimates 3% will be uncollectible. What should the Allowance for Doubtful Accounts balance be?",
            "correctAnswer": 3000,
            "points": 3,
            "explanation": "Allowance = A/R x Estimated uncollectible % = $100,000 x 3% = $3,000",
            "hint": "Multiply the accounts receivable by the estimated uncollectible percentage"
          },
          {
            "id": "qr-4",
            "type": "mcq",
            "topic": "Income Statement",
            "question": "Gross profit is calculated as:",
            "options": [
              "Revenue - Operating Expenses",
              "Revenue - Cost of Goods Sold",
              "Net Income + Interest Expense",
              "Operating Income - Taxes"
            ],
            "correctAnswer": "Revenue - Cost of Goods Sold",
            "points": 2,
            "explanation": "Gross Profit = Revenue - Cost of Goods Sold. It represents profit before operating expenses, interest, and taxes."
          },
          {
            "id": "qr-5",
            "type": "calculation",
            "topic": "Current Ratio",
            "question": "Current assets are $150,000 and current liabilities are $75,000. What is the current ratio?",
            "correctAnswer": 2,
            "points": 2,
            "explanation": "Current Ratio = Current Assets / Current Liabilities = $150,000 / $75,000 = 2.0",
            "hint": "Divide current assets by current liabilities"
          }
        ]
      }
    ]
  }',
  'mock-exam',
  70,
  false,
  true
);

-- Add CFS Classifier activity for practice (added to Module 9 - Cash Flow)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0009-000000000030',
  'fa000000-0000-0000-0000-000000000009',
  '9.30',
  30,
  'Cash Flow Classification Challenge',
  'cash-flow-classification-challenge',
  'interactive',
  15,
  40,
  'basic',
  '{
    "instructions": "Classify each transaction into the correct cash flow category. Drag each transaction to its proper section or use the quick-select buttons.",
    "passing_score": 70,
    "transactions": [
      {
        "id": "cfs-t1",
        "description": "Collected payment from customers for goods sold",
        "correctCategory": "operating",
        "explanation": "Collections from customers relate to the core business of selling goods - an operating activity."
      },
      {
        "id": "cfs-t2",
        "description": "Purchased manufacturing equipment for cash",
        "correctCategory": "investing",
        "explanation": "Buying long-term assets like equipment is an investing activity."
      },
      {
        "id": "cfs-t3",
        "description": "Paid dividends to shareholders",
        "correctCategory": "financing",
        "explanation": "Dividend payments are returns to owners and classified as financing activities."
      },
      {
        "id": "cfs-t4",
        "description": "Paid salaries and wages to employees",
        "correctCategory": "operating",
        "explanation": "Employee compensation is a regular business expense - an operating activity."
      },
      {
        "id": "cfs-t5",
        "description": "Received proceeds from bank loan",
        "correctCategory": "financing",
        "explanation": "Borrowing from banks involves raising capital through debt - a financing activity."
      },
      {
        "id": "cfs-t6",
        "description": "Sold an old delivery truck for cash",
        "correctCategory": "investing",
        "explanation": "Selling long-term assets is an investing activity, regardless of gain or loss."
      },
      {
        "id": "cfs-t7",
        "description": "Paid interest on bank loan",
        "correctCategory": "operating",
        "explanation": "Under IFRS, interest paid can be operating or financing; commonly treated as operating since it relates to ongoing business costs."
      },
      {
        "id": "cfs-t8",
        "description": "Repurchased company shares from the market",
        "correctCategory": "financing",
        "explanation": "Treasury stock transactions involve company''s own equity - a financing activity."
      },
      {
        "id": "cfs-t9",
        "description": "Paid utility bills for the office",
        "correctCategory": "operating",
        "explanation": "Utility payments are normal operating expenses of running the business."
      },
      {
        "id": "cfs-t10",
        "description": "Acquired patent rights from another company",
        "correctCategory": "investing",
        "explanation": "Purchasing intangible assets like patents is an investing activity."
      }
    ]
  }',
  'timed-classification',
  70,
  false,
  true
);

-- Link activities to skills via activity_skills table
INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0010-000000000030', id, true, true
FROM skills WHERE slug = 'fa-financial-ratios'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0010-000000000031', id, true, true
FROM skills WHERE slug = 'fa-financial-ratios'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0009-000000000030', id, true, true
FROM skills WHERE slug = 'cfs-indirect-method'
ON CONFLICT DO NOTHING;
