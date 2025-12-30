-- ============================================
-- FA Course Content Expansion - Phase 3
-- Module 5: Receivables & Bad Debts Expansion
-- Adds 6 new activities for receivables skills
-- ============================================

-- ============================================
-- NEW ACTIVITIES FOR MODULE 5
-- Following existing UUID pattern: fa500000-0000-0000-0005-00000000XXXX
-- Existing activities: 0001-0006, new start at 0007
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 5.7: Accounts Receivable Management
-- Primary Skill: ar-recognition
-- ============================================
(
  'fa500000-0000-0000-0005-000000000007',
  'fa000000-0000-0000-0000-000000000005',
  '5.7',
  7,
  'Accounts Receivable Management',
  'ar-management-deep-dive',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# Accounts Receivable Management\n\n## Why This Matters\n\nAccounts receivable represent money owed by customers. Effective management impacts cash flow and profitability.\n\n---\n\n## What Are Accounts Receivable?\n\n> **Accounts Receivable (A/R)** are amounts due from customers for goods or services sold on credit.\n\n---\n\n## Recording Credit Sales\n\n### At Point of Sale\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Accounts Receivable | 5,000 | |\n| Sales Revenue | | 5,000 |\n\n### When Cash Collected\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 5,000 | |\n| Accounts Receivable | | 5,000 |\n\n---\n\n## The A/R Lifecycle\n\n```\n1. Credit Sale → A/R Created\n2. Invoice Sent → Customer Notified\n3. Payment Received → A/R Reduced\n4. Aging Tracked → Monitor Collections\n5. Write-off → If Uncollectible\n```\n\n---\n\n## A/R Aging Schedule\n\n### Purpose\n\nTracks how long receivables have been outstanding.\n\n### Example\n\n| Age Category | Amount | % Estimated Uncollectible |\n|--------------|--------|---------------------------|\n| Current (0-30 days) | CHF 200,000 | 1% |\n| 31-60 days | CHF 80,000 | 3% |\n| 61-90 days | CHF 40,000 | 10% |\n| Over 90 days | CHF 30,000 | 25% |\n| **Total A/R** | **CHF 350,000** | |\n\n---\n\n## Key Metrics\n\n### A/R Turnover\n\n```\nA/R Turnover = Net Credit Sales / Average A/R\n```\n\nHigher = Collecting faster\n\n### Days Sales Outstanding (DSO)\n\n```\nDSO = 365 / A/R Turnover\n```\n\nLower = Faster collection\n\n### Example\n\n- Credit Sales: CHF 2,400,000\n- Average A/R: CHF 200,000\n- Turnover: 12 times\n- DSO: 30.4 days\n\n---\n\n## Credit Terms\n\n| Term | Meaning |\n|------|--------|\n| n/30 | Net due in 30 days |\n| 2/10, n/30 | 2% discount if paid in 10 days, otherwise due in 30 |\n| n/EOM | Due end of month |\n\n### Early Payment Discount\n\n**2/10, n/30 example:**\n\n- Invoice: CHF 10,000\n- If paid in 10 days: 10,000 x 98% = CHF 9,800\n- Discount: CHF 200\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - A/R created at credit sale\n> - Aging schedule estimates uncollectibles\n> - Higher turnover = faster collection\n> - DSO measures average collection period\n> - Discount terms incentivize early payment"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 5.8: Aging Method Practice
-- Primary Skill: ar-estimation
-- ============================================
(
  'fa500000-0000-0000-0005-000000000008',
  'fa000000-0000-0000-0000-000000000005',
  '5.8',
  8,
  'Aging Method Practice',
  'ar-aging-method-practice',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Aging Analysis: Horizon Distributors",
    "description": "Prepare bad debt estimates using the aging of receivables method for Horizon Distributors.",
    "company_background": "Horizon Distributors uses the aging method to estimate uncollectible accounts. Analyze their A/R aging schedule.",
    "aging_schedule": [
      {"category": "0-30 days", "amount": 180000, "uncollectible_rate": 0.01},
      {"category": "31-60 days", "amount": 65000, "uncollectible_rate": 0.03},
      {"category": "61-90 days", "amount": 35000, "uncollectible_rate": 0.08},
      {"category": "91-120 days", "amount": 15000, "uncollectible_rate": 0.20},
      {"category": "Over 120 days", "amount": 10000, "uncollectible_rate": 0.40}
    ],
    "allowance_before_adjustment": 4200,
    "questions": [
      {
        "id": "am1",
        "question": "Calculate estimated uncollectible for 0-30 days.",
        "answer_type": "numeric",
        "correct_answer": 1800,
        "tolerance": 50,
        "explanation": "180,000 x 1% = CHF 1,800"
      },
      {
        "id": "am2",
        "question": "Calculate estimated uncollectible for 31-60 days.",
        "answer_type": "numeric",
        "correct_answer": 1950,
        "tolerance": 50,
        "explanation": "65,000 x 3% = CHF 1,950"
      },
      {
        "id": "am3",
        "question": "Calculate estimated uncollectible for 61-90 days.",
        "answer_type": "numeric",
        "correct_answer": 2800,
        "tolerance": 50,
        "explanation": "35,000 x 8% = CHF 2,800"
      },
      {
        "id": "am4",
        "question": "Calculate estimated uncollectible for 91-120 days.",
        "answer_type": "numeric",
        "correct_answer": 3000,
        "tolerance": 50,
        "explanation": "15,000 x 20% = CHF 3,000"
      },
      {
        "id": "am5",
        "question": "Calculate estimated uncollectible for Over 120 days.",
        "answer_type": "numeric",
        "correct_answer": 4000,
        "tolerance": 50,
        "explanation": "10,000 x 40% = CHF 4,000"
      },
      {
        "id": "am6",
        "question": "Calculate total required Allowance for Doubtful Accounts.",
        "answer_type": "numeric",
        "correct_answer": 13550,
        "tolerance": 100,
        "explanation": "Total = 1,800 + 1,950 + 2,800 + 3,000 + 4,000 = CHF 13,550"
      },
      {
        "id": "am7",
        "question": "Calculate Bad Debt Expense for the adjusting entry.",
        "answer_type": "numeric",
        "correct_answer": 9350,
        "tolerance": 100,
        "hint": "Required Allowance - Current Allowance Balance",
        "explanation": "Bad Debt Expense = 13,550 - 4,200 = CHF 9,350"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'aging-calculator',
  false,
  true
),

-- ============================================
-- Activity 5.9: Write-offs and Recoveries
-- Primary Skill: ar-write-off
-- ============================================
(
  'fa500000-0000-0000-0005-000000000009',
  'fa000000-0000-0000-0000-000000000005',
  '5.9',
  9,
  'Write-offs and Recoveries',
  'ar-write-offs-recoveries-lesson',
  'lesson',
  12,
  24,
  'basic',
  '{"markdown": "# Write-offs and Recoveries\n\n## Why This Matters\n\nNot all customers pay. Understanding write-offs and unexpected recoveries is essential for accurate A/R reporting.\n\n---\n\n## Writing Off Accounts\n\n### When to Write Off\n\nWrite off when collection is deemed impossible:\n- Customer bankruptcy\n- No response after multiple attempts\n- Account deemed uncollectible\n\n### The Entry\n\n**Write off CHF 3,000 uncollectible account:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Allowance for Doubtful Accounts | 3,000 | |\n| Accounts Receivable | | 3,000 |\n\n### Impact on Financial Statements\n\n| Element | Before | After | Change |\n|---------|--------|-------|--------|\n| A/R (gross) | 100,000 | 97,000 | -3,000 |\n| Allowance | (5,000) | (2,000) | +3,000 |\n| A/R (net) | 95,000 | 95,000 | 0 |\n\n**Net A/R unchanged!** Already estimated as uncollectible.\n\n---\n\n## Recovery of Written-Off Accounts\n\n### What If Customer Pays Later?\n\nTwo-step process:\n1. **Reverse** the original write-off\n2. **Record** the cash collection\n\n### Example: Recover CHF 1,500\n\n**Step 1: Reverse Write-off**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Accounts Receivable | 1,500 | |\n| Allowance for Doubtful Accounts | | 1,500 |\n\n**Step 2: Record Collection**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 1,500 | |\n| Accounts Receivable | | 1,500 |\n\n---\n\n## Allowance vs. Direct Write-off\n\n### Allowance Method (GAAP)\n\n- Estimates bad debts in advance\n- Matches expense to revenue period\n- Reports A/R at net realizable value\n\n### Direct Write-off Method\n\n- Records bad debt only when account is written off\n- Not GAAP compliant (no matching)\n- May be used for tax purposes\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Write-off: Dr Allowance, Cr A/R\n> - Net A/R is unchanged by write-off\n> - Recovery: Reverse write-off, then record collection\n> - Allowance method matches expenses to revenue period\n> - Direct write-off violates matching principle"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 5.10: Write-off Practice
-- Primary Skill: ar-write-off
-- ============================================
(
  'fa500000-0000-0000-0005-000000000010',
  'fa000000-0000-0000-0000-000000000005',
  '5.10',
  10,
  'Write-off Practice',
  'ar-write-off-exercise',
  'interactive',
  16,
  40,
  'basic',
  '{
    "title": "Write-offs and Recoveries: Pacific Supply",
    "description": "Record write-offs and recoveries for Pacific Supply Co.",
    "company_background": "Pacific Supply Co. needs to process several write-offs and an unexpected recovery.",
    "beginning_balances": {
      "accounts_receivable": 450000,
      "allowance": 18000
    },
    "transactions": [
      {"date": "Apr 10", "description": "Write off Acme Co. account: CHF 5,200 deemed uncollectible"},
      {"date": "May 5", "description": "Write off Beta Inc. account: CHF 2,800 (bankruptcy)"},
      {"date": "Jun 20", "description": "Recover CHF 1,500 from previously written-off Gamma Corp account"},
      {"date": "Jul 15", "description": "Write off Delta Ltd. account: CHF 3,500"}
    ],
    "questions": [
      {
        "id": "wo1",
        "question": "After Apr 10 write-off, what is the Allowance balance?",
        "answer_type": "numeric",
        "correct_answer": 12800,
        "tolerance": 50,
        "explanation": "Allowance = 18,000 - 5,200 = CHF 12,800"
      },
      {
        "id": "wo2",
        "question": "After May 5 write-off, what is A/R gross balance?",
        "answer_type": "numeric",
        "correct_answer": 442000,
        "tolerance": 100,
        "hint": "Beginning A/R - All write-offs",
        "explanation": "A/R = 450,000 - 5,200 - 2,800 = CHF 442,000"
      },
      {
        "id": "wo3",
        "question": "After Jun 20 recovery (step 1), what is the Allowance balance?",
        "answer_type": "numeric",
        "correct_answer": 11500,
        "tolerance": 50,
        "hint": "Allowance after May + Recovery",
        "explanation": "Allowance = (18,000 - 5,200 - 2,800) + 1,500 = CHF 11,500"
      },
      {
        "id": "wo4",
        "question": "Total write-offs for the period:",
        "answer_type": "numeric",
        "correct_answer": 11500,
        "tolerance": 50,
        "explanation": "Write-offs = 5,200 + 2,800 + 3,500 = CHF 11,500"
      },
      {
        "id": "wo5",
        "question": "What is the ending Allowance balance (after all transactions)?",
        "answer_type": "numeric",
        "correct_answer": 8000,
        "tolerance": 100,
        "explanation": "Allowance = 18,000 - 5,200 - 2,800 + 1,500 - 3,500 = CHF 8,000"
      },
      {
        "id": "wo6",
        "question": "What is the ending Net A/R?",
        "answer_type": "numeric",
        "correct_answer": 430500,
        "tolerance": 100,
        "explanation": "Net A/R = 438,500 - 8,000 = CHF 430,500"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'receivables-calculator',
  false,
  true
),

-- ============================================
-- Activity 5.11: Percentage of Sales Method
-- Primary Skill: ar-estimation
-- ============================================
(
  'fa500000-0000-0000-0005-000000000011',
  'fa000000-0000-0000-0000-000000000005',
  '5.11',
  11,
  'Percentage of Sales Method',
  'ar-percentage-sales-method',
  'interactive',
  14,
  35,
  'basic',
  '{
    "title": "Percentage of Sales: Summit Wholesale",
    "description": "Apply the percentage of sales method to estimate bad debt expense.",
    "company_background": "Summit Wholesale uses the percentage of sales method. Historical data shows 1.5% of credit sales become uncollectible.",
    "financial_data": {
      "credit_sales": 3200000,
      "cash_sales": 800000,
      "total_sales": 4000000,
      "historical_rate": 0.015,
      "current_allowance_balance": 12500
    },
    "questions": [
      {
        "id": "ps1",
        "question": "Calculate Bad Debt Expense using percentage of sales method.",
        "answer_type": "numeric",
        "correct_answer": 48000,
        "tolerance": 100,
        "hint": "Credit Sales x Historical Rate",
        "explanation": "Bad Debt Expense = 3,200,000 x 1.5% = CHF 48,000"
      },
      {
        "id": "ps2",
        "question": "What is the ending Allowance balance after recording expense?",
        "answer_type": "numeric",
        "correct_answer": 60500,
        "tolerance": 100,
        "explanation": "Ending Allowance = 12,500 + 48,000 = CHF 60,500"
      },
      {
        "id": "ps3",
        "question": "The percentage of sales method focuses on which financial statement?",
        "answer_type": "choice",
        "options": ["Balance Sheet", "Income Statement", "Cash Flow Statement", "Statement of Equity"],
        "correct_answer": "Income Statement",
        "explanation": "Percentage of sales matches expense to revenue (income statement focus)."
      },
      {
        "id": "ps4",
        "question": "If historical rate increased to 2%, new Bad Debt Expense would be:",
        "answer_type": "numeric",
        "correct_answer": 64000,
        "tolerance": 100,
        "explanation": "New Expense = 3,200,000 x 2% = CHF 64,000"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'bad-debt-calculator',
  false,
  true
),

-- ============================================
-- Activity 5.12: Receivables Quiz
-- Primary Skill: ar-recognition, ar-estimation, ar-write-off
-- ============================================
(
  'fa500000-0000-0000-0005-000000000012',
  'fa000000-0000-0000-0000-000000000005',
  '5.12',
  12,
  'Receivables Comprehensive Quiz',
  'ar-comprehensive-quiz',
  'quiz',
  12,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "The aging method estimates bad debts based on:",
        "options": [
          "Total credit sales",
          "Age of accounts receivable",
          "Cash collections",
          "Number of customers"
        ],
        "correct": 1,
        "explanation": "Aging method analyzes A/R by age categories, applying different uncollectible rates."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Writing off a specific uncollectible account under the allowance method:",
        "options": [
          "Increases bad debt expense",
          "Decreases net A/R",
          "Has no effect on net A/R",
          "Increases total assets"
        ],
        "correct": 2,
        "explanation": "Write-off reduces both A/R and Allowance by same amount. Net A/R unchanged."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A/R is CHF 200,000 with Allowance of CHF 8,000. Net realizable value is:",
        "options": [
          "CHF 208,000",
          "CHF 200,000",
          "CHF 192,000",
          "CHF 8,000"
        ],
        "correct": 2,
        "explanation": "Net Realizable Value = A/R - Allowance = 200,000 - 8,000 = CHF 192,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Credit sales CHF 500,000, 2% uncollectible rate. Allowance has CHF 3,000 debit balance. Bad Debt Expense is:",
        "options": [
          "CHF 7,000",
          "CHF 10,000",
          "CHF 13,000",
          "CHF 3,000"
        ],
        "correct": 2,
        "explanation": "Using % of sales: Expense = 500,000 x 2% = 10,000. But with debit balance, might need adjustment. If aging method: would need to cover debit + estimated bad debts."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A previously written-off account is recovered. The correct treatment is:",
        "options": [
          "Credit Bad Debt Expense",
          "Reverse write-off, then record collection",
          "Debit Cash, Credit Bad Debt Expense",
          "No entry needed, just record cash"
        ],
        "correct": 1,
        "explanation": "Recovery: 1) Reverse write-off (Dr A/R, Cr Allowance), 2) Record collection (Dr Cash, Cr A/R)."
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "applied",
        "question": "The percentage of sales method focuses on the balance sheet.",
        "correct": false,
        "explanation": "FALSE. Percentage of sales focuses on matching expense to revenue (income statement). Aging method focuses on balance sheet (A/R valuation)."
      }
    ],
    "passing_score": 70,
    "show_explanations": true
  }'::jsonb,
  NULL,
  false,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;

-- ============================================
-- ADD SKILL TAGS FOR NEW MODULE 5 ACTIVITIES
-- Using correct skill IDs:
-- spec-accounts-receivable = b0000000-0000-0000-0005-000000000001
-- spec-bad-debt = b0000000-0000-0000-0005-000000000002
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 5.7 Accounts Receivable Management (spec-accounts-receivable)
('fa500000-0000-0000-0005-000000000007', 'b0000000-0000-0000-0005-000000000001', 1.0, true),

-- 5.8 Aging Method Practice (spec-bad-debt)
('fa500000-0000-0000-0005-000000000008', 'b0000000-0000-0000-0005-000000000002', 1.0, true),

-- 5.9 Write-offs and Recoveries (spec-bad-debt)
('fa500000-0000-0000-0005-000000000009', 'b0000000-0000-0000-0005-000000000002', 1.0, true),

-- 5.10 Write-off Practice (spec-bad-debt)
('fa500000-0000-0000-0005-000000000010', 'b0000000-0000-0000-0005-000000000002', 1.0, true),

-- 5.11 Percentage of Sales Method (spec-bad-debt)
('fa500000-0000-0000-0005-000000000011', 'b0000000-0000-0000-0005-000000000002', 1.0, true),

-- 5.12 Receivables Quiz (multiple skills)
('fa500000-0000-0000-0005-000000000012', 'b0000000-0000-0000-0005-000000000001', 0.5, true),
('fa500000-0000-0000-0005-000000000012', 'b0000000-0000-0000-0005-000000000002', 0.5, false)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

