-- Migration: Additional Practice Exercises (Tutoring-style)
-- Creates interactive exercises for adjustments, journal entries, and financial statement preparation
-- Note: All company names and scenarios are original

-- Practice Exercise 1: Toy Store Adjustments (inspired by retail sector)
-- Added to Module 4 (Adjustments)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0004-000000000030',
  'fa000000-0000-0000-0000-000000000004',
  '4.30',
  30,
  'Practice: ToyWorld Adjusting Entries',
  'practice-toyworld-adjusting-entries',
  'interactive',
  20,
  80,
  'basic',
  '{
    "scenario": "ToyWorld is a retail toy store. It is December 31st, year-end, and you need to prepare the adjusting entries before closing the books. Review each situation carefully and record the appropriate adjusting journal entry.",
    "company_name": "ToyWorld Retail Inc.",
    "passing_score": 75,
    "account_options": [
      {"name": "Cash", "type": "Asset"},
      {"name": "Accounts Receivable", "type": "Asset"},
      {"name": "Prepaid Insurance", "type": "Asset"},
      {"name": "Prepaid Rent", "type": "Asset"},
      {"name": "Supplies", "type": "Asset"},
      {"name": "Equipment", "type": "Asset"},
      {"name": "Accumulated Depreciation", "type": "Contra-Asset"},
      {"name": "Accounts Payable", "type": "Liability"},
      {"name": "Wages Payable", "type": "Liability"},
      {"name": "Interest Payable", "type": "Liability"},
      {"name": "Unearned Revenue", "type": "Liability"},
      {"name": "Notes Payable", "type": "Liability"},
      {"name": "Common Stock", "type": "Equity"},
      {"name": "Retained Earnings", "type": "Equity"},
      {"name": "Sales Revenue", "type": "Revenue"},
      {"name": "Service Revenue", "type": "Revenue"},
      {"name": "Insurance Expense", "type": "Expense"},
      {"name": "Rent Expense", "type": "Expense"},
      {"name": "Supplies Expense", "type": "Expense"},
      {"name": "Wages Expense", "type": "Expense"},
      {"name": "Depreciation Expense", "type": "Expense"},
      {"name": "Interest Expense", "type": "Expense"}
    ],
    "transactions": [
      {
        "id": "tw-adj-1",
        "date": "Dec 31",
        "description": "Prepaid Insurance: On July 1, ToyWorld paid CHF 12,000 for a one-year insurance policy. Record the insurance expense for the year.",
        "solution": [
          {"account": "Insurance Expense", "type": "Expense", "debit": 6000, "credit": 0},
          {"account": "Prepaid Insurance", "type": "Asset", "debit": 0, "credit": 6000}
        ],
        "hint": "6 months have passed since July 1. Calculate: CHF 12,000 x 6/12"
      },
      {
        "id": "tw-adj-2",
        "date": "Dec 31",
        "description": "Depreciation: Store equipment cost CHF 48,000 with a 4-year useful life and no salvage value. Record annual depreciation using straight-line method.",
        "solution": [
          {"account": "Depreciation Expense", "type": "Expense", "debit": 12000, "credit": 0},
          {"account": "Accumulated Depreciation", "type": "Contra-Asset", "debit": 0, "credit": 12000}
        ],
        "hint": "Straight-line: CHF 48,000 / 4 years = CHF 12,000 per year"
      },
      {
        "id": "tw-adj-3",
        "date": "Dec 31",
        "description": "Accrued Wages: Employees worked the last 3 days of December but will be paid in January. Daily wages total CHF 2,500.",
        "solution": [
          {"account": "Wages Expense", "type": "Expense", "debit": 7500, "credit": 0},
          {"account": "Wages Payable", "type": "Liability", "debit": 0, "credit": 7500}
        ],
        "hint": "3 days x CHF 2,500 per day = CHF 7,500"
      },
      {
        "id": "tw-adj-4",
        "date": "Dec 31",
        "description": "Unearned Revenue: On November 1, a corporate client paid CHF 15,000 in advance for gift cards to be redeemed over 5 months. Record the revenue earned through December 31.",
        "solution": [
          {"account": "Unearned Revenue", "type": "Liability", "debit": 6000, "credit": 0},
          {"account": "Sales Revenue", "type": "Revenue", "debit": 0, "credit": 6000}
        ],
        "hint": "2 months passed (Nov & Dec). CHF 15,000 x 2/5 = CHF 6,000 earned"
      },
      {
        "id": "tw-adj-5",
        "date": "Dec 31",
        "description": "Supplies: The supplies account shows CHF 3,200. A physical count reveals CHF 800 of supplies remaining. Record the adjustment.",
        "solution": [
          {"account": "Supplies Expense", "type": "Expense", "debit": 2400, "credit": 0},
          {"account": "Supplies", "type": "Asset", "debit": 0, "credit": 2400}
        ],
        "hint": "Supplies used = CHF 3,200 - CHF 800 remaining = CHF 2,400"
      }
    ]
  }',
  'journal-entry-builder',
  75,
  false,
  true
);

-- Practice Exercise 2: Bakery CFS (inspired by food service)
-- Added to Module 9 (Cash Flow Statement)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0009-000000000035',
  'fa000000-0000-0000-0000-000000000009',
  '9.35',
  35,
  'Practice: Artisan Bakery Cash Flow Statement',
  'practice-artisan-bakery-cfs',
  'interactive',
  30,
  85,
  'basic',
  '{
    "exam_title": "Artisan Bakery Co. - Cash Flow Statement Practice",
    "instructions": "Artisan Bakery Co. is an expanding bakery chain. Using their financial data, prepare the Statement of Cash Flows for the year using the indirect method.",
    "time_limit_minutes": 30,
    "passing_score": 70,
    "sections": [
      {
        "id": "data-section",
        "title": "Financial Data Review",
        "questions": [
          {
            "id": "ab-data",
            "type": "mcq",
            "topic": "Data Overview",
            "question": "ARTISAN BAKERY FINANCIAL DATA:\n\nIncome Statement:\n- Net Income: CHF 95,000\n- Depreciation (ovens & equipment): CHF 18,000\n\nBalance Sheet Changes:\n- Cash: To be calculated\n- Accounts Receivable: Increased CHF 12,000\n- Inventory (flour, ingredients): Increased CHF 8,000\n- Prepaid Rent: Decreased CHF 3,000\n- Baking Equipment: Increased CHF 75,000\n- Accounts Payable: Increased CHF 15,000\n- Wages Payable: Decreased CHF 4,000\n- Bank Loan: Increased CHF 50,000\n- Dividends Paid: CHF 25,000\n\nWhat is the first step in preparing CFO using the indirect method?",
            "options": [
              "Calculate cash collections",
              "Start with Net Income",
              "Calculate working capital changes",
              "List all cash transactions"
            ],
            "correctAnswer": "Start with Net Income",
            "points": 2,
            "explanation": "The indirect method starts with Net Income and adjusts for non-cash items and working capital changes."
          }
        ]
      },
      {
        "id": "operating-section",
        "title": "Operating Activities",
        "questions": [
          {
            "id": "ab-op1",
            "type": "calculation",
            "topic": "Net Income Start",
            "question": "What is the starting Net Income for CFO?",
            "correctAnswer": 95000,
            "points": 2,
            "explanation": "We begin with Net Income of CHF 95,000."
          },
          {
            "id": "ab-op2",
            "type": "calculation",
            "topic": "Depreciation",
            "question": "What depreciation amount is added back?",
            "correctAnswer": 18000,
            "points": 2,
            "explanation": "Depreciation of CHF 18,000 is added back as a non-cash expense."
          },
          {
            "id": "ab-op3",
            "type": "calculation",
            "topic": "Working Capital Net",
            "question": "Calculate the net working capital adjustment:\n- A/R increased CHF 12,000 (subtract)\n- Inventory increased CHF 8,000 (subtract)\n- Prepaid decreased CHF 3,000 (add)\n- A/P increased CHF 15,000 (add)\n- Wages Payable decreased CHF 4,000 (subtract)",
            "correctAnswer": -6000,
            "points": 5,
            "explanation": "WC adjustment = -12,000 - 8,000 + 3,000 + 15,000 - 4,000 = -CHF 6,000",
            "hint": "Asset increases and liability decreases use cash (subtract). Asset decreases and liability increases provide cash (add)."
          },
          {
            "id": "ab-op4",
            "type": "calculation",
            "topic": "Total CFO",
            "question": "Calculate total Cash Flow from Operations: CHF 95,000 + 18,000 - 6,000",
            "correctAnswer": 107000,
            "points": 4,
            "explanation": "CFO = CHF 95,000 + CHF 18,000 - CHF 6,000 = CHF 107,000"
          }
        ]
      },
      {
        "id": "investing-section",
        "title": "Investing Activities",
        "questions": [
          {
            "id": "ab-inv1",
            "type": "calculation",
            "topic": "Equipment Purchase",
            "question": "Baking Equipment increased by CHF 75,000. What is the investing cash flow? (Enter as negative for outflow)",
            "correctAnswer": -75000,
            "points": 3,
            "explanation": "Equipment purchase is a cash outflow of CHF 75,000."
          }
        ]
      },
      {
        "id": "financing-section",
        "title": "Financing Activities",
        "questions": [
          {
            "id": "ab-fin1",
            "type": "calculation",
            "topic": "Loan Proceeds",
            "question": "Bank Loan increased by CHF 50,000. What cash was received?",
            "correctAnswer": 50000,
            "points": 3,
            "explanation": "New borrowing provides cash inflow of CHF 50,000."
          },
          {
            "id": "ab-fin2",
            "type": "calculation",
            "topic": "Total CFF",
            "question": "Calculate total CFF: Loan CHF 50,000 less Dividends CHF 25,000",
            "correctAnswer": 25000,
            "points": 3,
            "explanation": "CFF = CHF 50,000 - CHF 25,000 = CHF 25,000"
          }
        ]
      },
      {
        "id": "summary-section",
        "title": "Summary & Verification",
        "questions": [
          {
            "id": "ab-sum1",
            "type": "calculation",
            "topic": "Net Cash Change",
            "question": "Calculate Net Change in Cash: CFO CHF 107,000 + CFI -CHF 75,000 + CFF CHF 25,000",
            "correctAnswer": 57000,
            "points": 5,
            "explanation": "Net Change = CHF 107,000 - CHF 75,000 + CHF 25,000 = CHF 57,000 increase"
          },
          {
            "id": "ab-sum2",
            "type": "mcq",
            "topic": "Analysis",
            "question": "Artisan Bakery has positive CFO (107K), negative CFI (-75K), and positive CFF (25K). What does this pattern suggest?",
            "options": [
              "The company is in financial distress",
              "The company is growing and investing in expansion with operational cash supplemented by borrowing",
              "The company is mature and returning cash to shareholders",
              "The company is liquidating assets"
            ],
            "correctAnswer": "The company is growing and investing in expansion with operational cash supplemented by borrowing",
            "points": 3,
            "explanation": "Strong CFO funding investments, with additional financing to support growth, is typical of an expanding business."
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

-- Practice Exercise 3: Multi-Step Income Statement Practice
-- Added to Module 3 (Income Statement)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0003-000000000031',
  'fa000000-0000-0000-0000-000000000003',
  '3.31',
  31,
  'Practice: Building a Multi-Step Income Statement',
  'practice-multi-step-income-statement',
  'interactive',
  20,
  70,
  'basic',
  '{
    "exam_title": "Multi-Step Income Statement Practice",
    "instructions": "Using the adjusted trial balance data provided, construct a multi-step income statement. Pay attention to the proper classification of each account.",
    "time_limit_minutes": 20,
    "passing_score": 75,
    "sections": [
      {
        "id": "income-data",
        "title": "Income Statement Construction",
        "questions": [
          {
            "id": "is-data",
            "type": "mcq",
            "topic": "Data Review",
            "question": "ADJUSTED TRIAL BALANCE (Income-related accounts):\n- Sales Revenue: CHF 850,000\n- Sales Returns: CHF 12,000\n- Cost of Goods Sold: CHF 510,000\n- Salaries Expense: CHF 125,000\n- Rent Expense: CHF 48,000\n- Utilities Expense: CHF 18,000\n- Depreciation Expense: CHF 24,000\n- Advertising Expense: CHF 15,000\n- Interest Expense: CHF 8,000\n- Income Tax Expense: CHF 27,000\n\nWhat is Net Sales Revenue?",
            "options": ["CHF 850,000", "CHF 838,000", "CHF 862,000", "CHF 340,000"],
            "correctAnswer": "CHF 838,000",
            "points": 3,
            "explanation": "Net Sales = Sales Revenue - Sales Returns = CHF 850,000 - CHF 12,000 = CHF 838,000"
          },
          {
            "id": "is-gross",
            "type": "calculation",
            "topic": "Gross Profit",
            "question": "Calculate Gross Profit: Net Sales CHF 838,000 - COGS CHF 510,000",
            "correctAnswer": 328000,
            "points": 3,
            "explanation": "Gross Profit = CHF 838,000 - CHF 510,000 = CHF 328,000"
          },
          {
            "id": "is-opex",
            "type": "calculation",
            "topic": "Operating Expenses",
            "question": "Calculate total Operating Expenses: Salaries 125K + Rent 48K + Utilities 18K + Depreciation 24K + Advertising 15K",
            "correctAnswer": 230000,
            "points": 4,
            "explanation": "Operating Expenses = 125,000 + 48,000 + 18,000 + 24,000 + 15,000 = CHF 230,000"
          },
          {
            "id": "is-opinc",
            "type": "calculation",
            "topic": "Operating Income",
            "question": "Calculate Operating Income: Gross Profit CHF 328,000 - Operating Expenses CHF 230,000",
            "correctAnswer": 98000,
            "points": 3,
            "explanation": "Operating Income = CHF 328,000 - CHF 230,000 = CHF 98,000"
          },
          {
            "id": "is-ebt",
            "type": "calculation",
            "topic": "Income Before Tax",
            "question": "Calculate Income Before Tax: Operating Income CHF 98,000 - Interest Expense CHF 8,000",
            "correctAnswer": 90000,
            "points": 3,
            "explanation": "Income Before Tax = CHF 98,000 - CHF 8,000 = CHF 90,000"
          },
          {
            "id": "is-net",
            "type": "calculation",
            "topic": "Net Income",
            "question": "Calculate Net Income: Income Before Tax CHF 90,000 - Income Tax CHF 27,000",
            "correctAnswer": 63000,
            "points": 3,
            "explanation": "Net Income = CHF 90,000 - CHF 27,000 = CHF 63,000"
          },
          {
            "id": "is-margin",
            "type": "mcq",
            "topic": "Ratio Analysis",
            "question": "With Net Sales of CHF 838,000 and Net Income of CHF 63,000, approximately what is the net profit margin?",
            "options": ["5.0%", "7.5%", "10.0%", "12.5%"],
            "correctAnswer": "7.5%",
            "points": 3,
            "explanation": "Net Profit Margin = CHF 63,000 / CHF 838,000 = 7.5%. This indicates a reasonably healthy profit margin."
          }
        ]
      }
    ]
  }',
  'mock-exam',
  75,
  false,
  true
);

-- Practice Exercise 4: Trial Balance to Financial Statements
-- Added to Module 4 (Adjustments)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0004-000000000031',
  'fa000000-0000-0000-0000-000000000004',
  '4.31',
  31,
  'Practice: Trial Balance Analysis',
  'practice-trial-balance-analysis',
  'interactive',
  15,
  60,
  'basic',
  '{
    "instructions": "Review the account balances and place each in the correct debit or credit column to create a trial balance. Remember: Assets and Expenses have normal debit balances; Liabilities, Equity, and Revenues have normal credit balances.",
    "passing_score": 80,
    "accounts": [
      {"name": "Cash", "balance": 45000, "normalBalance": "debit"},
      {"name": "Accounts Receivable", "balance": 28000, "normalBalance": "debit"},
      {"name": "Supplies", "balance": 3500, "normalBalance": "debit"},
      {"name": "Equipment", "balance": 85000, "normalBalance": "debit"},
      {"name": "Accumulated Depreciation", "balance": 17000, "normalBalance": "credit"},
      {"name": "Accounts Payable", "balance": 22000, "normalBalance": "credit"},
      {"name": "Unearned Revenue", "balance": 8000, "normalBalance": "credit"},
      {"name": "Common Stock", "balance": 50000, "normalBalance": "credit"},
      {"name": "Retained Earnings", "balance": 35500, "normalBalance": "credit"},
      {"name": "Service Revenue", "balance": 95000, "normalBalance": "credit"},
      {"name": "Salaries Expense", "balance": 48000, "normalBalance": "debit"},
      {"name": "Rent Expense", "balance": 12000, "normalBalance": "debit"},
      {"name": "Utilities Expense", "balance": 6000, "normalBalance": "debit"}
    ]
  }',
  'trial-balance-builder',
  80,
  false,
  true
);

-- Link activities to skills
INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0004-000000000030', id, true, true
FROM skills WHERE slug = 'adj-prepaid-expenses'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0009-000000000035', id, true, true
FROM skills WHERE slug = 'cfs-indirect-method'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0003-000000000031', id, true, true
FROM skills WHERE slug = 'is-profitability-analysis'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0004-000000000031', id, true, true
FROM skills WHERE slug = 'adj-trial-balance'
ON CONFLICT DO NOTHING;
