-- ============================================
-- FA Course Content Expansion - Phase 3
-- Module 6: Mock Midterm Additional Practice
-- Adds 4 activities to supplement exam preparation
-- ============================================

-- ============================================
-- NEW ACTIVITIES FOR MODULE 6 (Mock Midterm Support)
-- Following existing UUID pattern: fa600000-0000-0000-0006-00000000XXXX
-- Existing activities: 0001-0003, new start at 0004
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 6.4: Midterm Review: Foundations
-- Primary Skill: fa-accounting-equation, fa-journal-entries
-- ============================================
(
  'fa600000-0000-0000-0006-000000000004',
  'fa000000-0000-0000-0000-000000000006',
  '6.4',
  4,
  'Midterm Review: Foundations',
  'midterm-review-foundations',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Foundations Review: Comprehensive Practice",
    "description": "Review fundamental concepts before the midterm exam.",
    "topics_covered": ["Accounting Equation", "Journal Entries", "T-Accounts", "Normal Balances"],
    "questions": [
      {
        "id": "fr1",
        "question": "Beginning Assets CHF 150,000, Liabilities CHF 60,000. During the period: Revenue CHF 80,000, Expenses CHF 50,000, Dividends CHF 10,000. Calculate ending Equity.",
        "answer_type": "numeric",
        "correct_answer": 110000,
        "tolerance": 100,
        "hint": "Beginning Equity + Net Income - Dividends",
        "explanation": "Beginning Equity = 150,000 - 60,000 = 90,000. Net Income = 80,000 - 50,000 = 30,000. Ending Equity = 90,000 + 30,000 - 10,000 = CHF 110,000"
      },
      {
        "id": "fr2",
        "question": "Company purchases equipment CHF 40,000: CHF 15,000 cash, balance on note. Total assets change by:",
        "answer_type": "numeric",
        "correct_answer": 25000,
        "tolerance": 100,
        "explanation": "Equipment +40,000, Cash -15,000, Note Payable +25,000. Net asset change = CHF 25,000"
      },
      {
        "id": "fr3",
        "question": "Cash T-account: Debits 120,000; Credits 85,000. Balance is:",
        "answer_type": "numeric",
        "correct_answer": 35000,
        "tolerance": 100,
        "explanation": "Cash has normal debit balance = 120,000 - 85,000 = CHF 35,000 debit"
      },
      {
        "id": "fr4",
        "question": "Which journal entry records credit sale CHF 5,000?",
        "answer_type": "choice",
        "options": [
          "Dr Cash 5,000; Cr Revenue 5,000",
          "Dr A/R 5,000; Cr Revenue 5,000",
          "Dr Revenue 5,000; Cr A/R 5,000",
          "Dr A/P 5,000; Cr Revenue 5,000"
        ],
        "correct_answer": "Dr A/R 5,000; Cr Revenue 5,000",
        "explanation": "Credit sale: Debit Accounts Receivable (asset increase), Credit Revenue"
      },
      {
        "id": "fr5",
        "question": "Salaries earned but unpaid CHF 8,000 at month-end. Adjusting entry debits:",
        "answer_type": "choice",
        "options": ["Cash", "Salaries Payable", "Salaries Expense", "Prepaid Salaries"],
        "correct_answer": "Salaries Expense",
        "explanation": "Accrue expense: Dr Salaries Expense, Cr Salaries Payable"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'review-calculator',
  false,
  true
),

-- ============================================
-- Activity 6.5: Midterm Review: Balance Sheet
-- Primary Skill: bs-interpretation
-- ============================================
(
  'fa600000-0000-0000-0006-000000000005',
  'fa000000-0000-0000-0000-000000000006',
  '6.5',
  5,
  'Midterm Review: Balance Sheet',
  'midterm-review-balance-sheet',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Balance Sheet Review: Classification Practice",
    "description": "Practice classifying accounts and interpreting balance sheet relationships.",
    "questions": [
      {
        "id": "bs1",
        "question": "Classify: Unearned Revenue",
        "answer_type": "choice",
        "options": ["Current Asset", "Non-Current Asset", "Current Liability", "Equity"],
        "correct_answer": "Current Liability",
        "explanation": "Unearned Revenue is a liability - cash received for services not yet provided."
      },
      {
        "id": "bs2",
        "question": "Classify: Accumulated Depreciation",
        "answer_type": "choice",
        "options": ["Asset", "Contra-Asset", "Liability", "Expense"],
        "correct_answer": "Contra-Asset",
        "explanation": "Accumulated Depreciation offsets fixed assets as a contra-asset account."
      },
      {
        "id": "bs3",
        "question": "Equipment CHF 200,000, Accum. Depr. CHF 75,000. Book value is:",
        "answer_type": "numeric",
        "correct_answer": 125000,
        "tolerance": 100,
        "explanation": "Book Value = Cost - Accumulated Depreciation = 200,000 - 75,000 = CHF 125,000"
      },
      {
        "id": "bs4",
        "question": "Current Assets CHF 180,000, Current Liabilities CHF 120,000. Working Capital is:",
        "answer_type": "numeric",
        "correct_answer": 60000,
        "tolerance": 100,
        "explanation": "Working Capital = CA - CL = 180,000 - 120,000 = CHF 60,000"
      },
      {
        "id": "bs5",
        "question": "Total Assets CHF 500,000, Total Liabilities CHF 200,000. Equity is:",
        "answer_type": "numeric",
        "correct_answer": 300000,
        "tolerance": 100,
        "explanation": "Equity = Assets - Liabilities = 500,000 - 200,000 = CHF 300,000"
      },
      {
        "id": "bs6",
        "question": "Which increases when a bond is issued at premium?",
        "answer_type": "choice",
        "options": ["Discount on Bonds", "Interest Expense", "Premium on Bonds", "Bond Principal"],
        "correct_answer": "Premium on Bonds",
        "explanation": "Premium on Bonds is credited when bonds sell above face value."
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'classification-practice',
  false,
  true
),

-- ============================================
-- Activity 6.6: Midterm Review: Income Statement
-- Primary Skill: is-revenue, is-gross-profit, is-net-income
-- ============================================
(
  'fa600000-0000-0000-0006-000000000006',
  'fa000000-0000-0000-0000-000000000006',
  '6.6',
  6,
  'Midterm Review: Income Statement',
  'midterm-review-income-statement',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Income Statement Review: Profitability Analysis",
    "description": "Review income statement components and calculate key profitability measures.",
    "financial_data": {
      "sales_revenue": 850000,
      "sales_returns": 35000,
      "cost_of_goods_sold": 450000,
      "salaries_expense": 120000,
      "rent_expense": 48000,
      "depreciation_expense": 32000,
      "interest_expense": 15000,
      "tax_rate": 0.25
    },
    "questions": [
      {
        "id": "is1",
        "question": "Calculate Net Sales.",
        "answer_type": "numeric",
        "correct_answer": 815000,
        "tolerance": 100,
        "explanation": "Net Sales = 850,000 - 35,000 = CHF 815,000"
      },
      {
        "id": "is2",
        "question": "Calculate Gross Profit.",
        "answer_type": "numeric",
        "correct_answer": 365000,
        "tolerance": 100,
        "explanation": "Gross Profit = Net Sales - COGS = 815,000 - 450,000 = CHF 365,000"
      },
      {
        "id": "is3",
        "question": "Calculate Total Operating Expenses.",
        "answer_type": "numeric",
        "correct_answer": 200000,
        "tolerance": 100,
        "hint": "Salaries + Rent + Depreciation",
        "explanation": "Operating Expenses = 120,000 + 48,000 + 32,000 = CHF 200,000"
      },
      {
        "id": "is4",
        "question": "Calculate Operating Income.",
        "answer_type": "numeric",
        "correct_answer": 165000,
        "tolerance": 100,
        "explanation": "Operating Income = Gross Profit - Operating Expenses = 365,000 - 200,000 = CHF 165,000"
      },
      {
        "id": "is5",
        "question": "Calculate Income Before Taxes.",
        "answer_type": "numeric",
        "correct_answer": 150000,
        "tolerance": 100,
        "explanation": "Income Before Tax = Operating Income - Interest = 165,000 - 15,000 = CHF 150,000"
      },
      {
        "id": "is6",
        "question": "Calculate Net Income.",
        "answer_type": "numeric",
        "correct_answer": 112500,
        "tolerance": 200,
        "explanation": "Tax = 150,000 x 25% = 37,500. Net Income = 150,000 - 37,500 = CHF 112,500"
      },
      {
        "id": "is7",
        "question": "Calculate Gross Profit Margin (%).",
        "answer_type": "numeric",
        "correct_answer": 44.8,
        "tolerance": 0.5,
        "explanation": "Gross Margin = 365,000 / 815,000 x 100 = 44.8%"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'income-calculator',
  false,
  true
),

-- ============================================
-- Activity 6.7: Midterm Review: Adjustments
-- Primary Skill: adj-overview
-- ============================================
(
  'fa600000-0000-0000-0006-000000000007',
  'fa000000-0000-0000-0000-000000000006',
  '6.7',
  7,
  'Midterm Review: Adjustments',
  'midterm-review-adjustments',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Adjusting Entries Review: Year-End Practice",
    "description": "Practice all types of adjusting entries in exam-style format.",
    "year_end": "December 31",
    "scenarios": [
      {"type": "Prepaid", "description": "CHF 24,000 insurance paid March 1 for 24 months"},
      {"type": "Depreciation", "description": "Equipment CHF 80,000, 8-year life, no salvage, straight-line"},
      {"type": "Accrued Revenue", "description": "Consulting services CHF 6,000 performed in December, to be billed January"},
      {"type": "Unearned", "description": "CHF 36,000 received September 1 for 12-month service contract"},
      {"type": "Accrued Expense", "description": "Loan CHF 100,000 at 6%, taken August 1"}
    ],
    "questions": [
      {
        "id": "adj1",
        "question": "Insurance Expense for the year (10 months: Mar-Dec):",
        "answer_type": "numeric",
        "correct_answer": 10000,
        "tolerance": 100,
        "explanation": "Monthly = 24,000/24 = 1,000. Expense = 1,000 x 10 = CHF 10,000"
      },
      {
        "id": "adj2",
        "question": "Depreciation Expense for the year:",
        "answer_type": "numeric",
        "correct_answer": 10000,
        "tolerance": 100,
        "explanation": "Depreciation = 80,000 / 8 = CHF 10,000"
      },
      {
        "id": "adj3",
        "question": "Consulting Revenue to accrue:",
        "answer_type": "numeric",
        "correct_answer": 6000,
        "tolerance": 50,
        "explanation": "Accrue unbilled revenue: CHF 6,000"
      },
      {
        "id": "adj4",
        "question": "Service Revenue earned (Sep-Dec = 4 months):",
        "answer_type": "numeric",
        "correct_answer": 12000,
        "tolerance": 100,
        "explanation": "Monthly = 36,000/12 = 3,000. Revenue = 3,000 x 4 = CHF 12,000"
      },
      {
        "id": "adj5",
        "question": "Interest Expense to accrue (Aug 1 - Dec 31 = 5 months):",
        "answer_type": "numeric",
        "correct_answer": 2500,
        "tolerance": 50,
        "explanation": "Interest = 100,000 x 6% x 5/12 = CHF 2,500"
      },
      {
        "id": "adj6",
        "question": "Total adjusting entries that increase expenses:",
        "answer_type": "numeric",
        "correct_answer": 22500,
        "tolerance": 100,
        "explanation": "Expenses = Insurance 10,000 + Depreciation 10,000 + Interest 2,500 = CHF 22,500"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'adjustment-review',
  false,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;

-- ============================================
-- ADD SKILL TAGS FOR NEW MODULE 6 ACTIVITIES
-- Using correct skill IDs from 037_fa_skill_definitions.sql
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 6.4 Midterm Review: Foundations (fa-statements-overview, fa-accounting-equation, fa-transaction-analysis)
('fa600000-0000-0000-0006-000000000004', 'b0000000-0000-0000-0001-000000000001', 0.5, true),
('fa600000-0000-0000-0006-000000000004', 'b0000000-0000-0000-0001-000000000002', 0.5, false),
('fa600000-0000-0000-0006-000000000004', 'b0000000-0000-0000-0001-000000000003', 0.3, false),

-- 6.5 Midterm Review: Balance Sheet (bs-interpretation, bs-current-liabilities, bs-noncurrent-liabilities)
('fa600000-0000-0000-0006-000000000005', 'b0000000-0000-0000-0002-000000000006', 1.0, true),
('fa600000-0000-0000-0006-000000000005', 'b0000000-0000-0000-0002-000000000003', 0.3, false),
('fa600000-0000-0000-0006-000000000005', 'b0000000-0000-0000-0002-000000000004', 0.3, false),

-- 6.6 Midterm Review: Income Statement (is-revenue-recognition, is-cogs, is-net-income)
('fa600000-0000-0000-0006-000000000006', 'b0000000-0000-0000-0003-000000000001', 0.4, true),
('fa600000-0000-0000-0006-000000000006', 'b0000000-0000-0000-0003-000000000002', 0.4, false),
('fa600000-0000-0000-0006-000000000006', 'b0000000-0000-0000-0003-000000000004', 0.4, false),

-- 6.7 Midterm Review: Adjustments (adj-depreciation, adj-prepaid-expenses, adj-accrued-expenses, adj-accrued-revenue)
('fa600000-0000-0000-0006-000000000007', 'b0000000-0000-0000-0004-000000000005', 1.0, true),
('fa600000-0000-0000-0006-000000000007', 'b0000000-0000-0000-0004-000000000001', 0.3, false),
('fa600000-0000-0000-0006-000000000007', 'b0000000-0000-0000-0004-000000000002', 0.3, false),
('fa600000-0000-0000-0006-000000000007', 'b0000000-0000-0000-0004-000000000004', 0.3, false)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

