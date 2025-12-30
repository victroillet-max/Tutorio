-- ============================================
-- FA Course Content Expansion - Phase 2
-- Module 2: Balance Sheet Liabilities Content
-- Adds 8 new activities for current and non-current liabilities
-- ============================================

-- ============================================
-- NEW ACTIVITIES FOR MODULE 2
-- Following existing UUID pattern: fa200000-0000-0000-0002-00000000XXXX
-- Existing activities: 0001-0007, new start at 0008
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 2.8: Current Liabilities Deep Dive
-- Primary Skill: bs-current-liabilities
-- ============================================
(
  'fa200000-0000-0000-0002-000000000008',
  'fa000000-0000-0000-0000-000000000002',
  '2.8',
  8,
  'Current Liabilities Deep Dive',
  'current-liabilities-deep-dive',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Current Liabilities Deep Dive\n\n## Why This Matters\n\nCurrent liabilities represent what a company must pay within one year. Understanding these obligations is crucial for assessing liquidity and short-term financial health.\n\n---\n\n## Definition\n\n> **Current Liabilities** are obligations expected to be settled within one year or the operating cycle, whichever is longer.\n\n---\n\n## Types of Current Liabilities\n\n### 1. Accounts Payable\n\nAmounts owed to suppliers for goods or services purchased on credit.\n\n| Transaction | Entry |\n|------------|-------|\n| Purchase on credit | Dr Inventory; Cr Accounts Payable |\n| Payment to supplier | Dr Accounts Payable; Cr Cash |\n\n### 2. Accrued Liabilities\n\nExpenses incurred but not yet paid:\n\n| Type | Example |\n|------|----------|\n| **Wages Payable** | Salaries earned by employees but not yet paid |\n| **Interest Payable** | Interest accrued on loans |\n| **Utilities Payable** | Electricity, water bills not yet paid |\n| **Taxes Payable** | Income taxes owed |\n\n### 3. Unearned Revenue\n\nPayments received before goods/services are provided.\n\n| Example | Description |\n|---------|-------------|\n| Gift cards | Cash received, product not yet delivered |\n| Subscriptions | Annual fee paid upfront |\n| Deposits | Customer deposits on orders |\n\n### 4. Short-Term Notes Payable\n\nFormal written promises to pay within one year.\n\n| Feature | Description |\n|---------|-------------|\n| Principal | Amount borrowed |\n| Interest | Cost of borrowing |\n| Maturity | Due date |\n\n### 5. Current Portion of Long-Term Debt\n\nThe part of long-term debt due within the next 12 months.\n\n---\n\n## Recording Current Liabilities\n\n### Accounts Payable Example\n\n**Purchase inventory CHF 50,000 on account:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Inventory | 50,000 | |\n| Accounts Payable | | 50,000 |\n\n### Accrued Wages Example\n\n**Employees earned CHF 8,000 in wages not yet paid:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Wages Expense | 8,000 | |\n| Wages Payable | | 8,000 |\n\n### Unearned Revenue Example\n\n**Receive CHF 12,000 for 12-month service contract:**\n\n**At receipt:**\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 12,000 | |\n| Unearned Revenue | | 12,000 |\n\n**Each month (as service is provided):**\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Unearned Revenue | 1,000 | |\n| Service Revenue | | 1,000 |\n\n---\n\n## Balance Sheet Presentation\n\n```\nCURRENT LIABILITIES:\n  Accounts Payable               CHF 185,000\n  Accrued Wages                       28,000\n  Accrued Interest                     5,000\n  Unearned Revenue                    42,000\n  Income Taxes Payable                35,000\n  Current Portion of Long-Term Debt   50,000\n                                  ----------\n  Total Current Liabilities      CHF 345,000\n```\n\n---\n\n## Common Mistakes\n\n### Mistake 1: Confusing A/P and Notes Payable\n\n- **Accounts Payable:** Informal, typically no interest for short periods\n- **Notes Payable:** Formal document, usually bears interest\n\n### Mistake 2: Recording Unearned Revenue as Revenue\n\nCash received in advance is a LIABILITY until earned.\n\n### Mistake 3: Missing Accruals\n\nForgetting to record expenses incurred but not yet billed (utilities, wages).\n\n---\n\n## Impact on Ratios\n\n| Ratio | Formula | Impact of Higher CL |\n|-------|---------|---------------------|\n| Current Ratio | CA / CL | Lower ratio |\n| Quick Ratio | Quick Assets / CL | Lower ratio |\n| Working Capital | CA - CL | Lower WC |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Current liabilities due within 1 year\n> - A/P for purchases on credit\n> - Accrued liabilities for expenses incurred but unpaid\n> - Unearned revenue is a liability, not revenue\n> - Current portion of LT debt must be reclassified"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.9: Current Liabilities Practice
-- Primary Skill: bs-current-liabilities
-- ============================================
(
  'fa200000-0000-0000-0002-000000000009',
  'fa000000-0000-0000-0000-000000000002',
  '2.9',
  9,
  'Current Liabilities Practice',
  'current-liabilities-practice',
  'interactive',
  16,
  40,
  'basic',
  '{
    "title": "Current Liabilities: Alpine Resort",
    "description": "Calculate and classify current liabilities for Alpine Resort at year-end.",
    "company_background": "Alpine Resort operates a ski resort and hotel. They have various short-term obligations to manage.",
    "transactions": [
      {"description": "Accounts payable to suppliers", "amount": 125000},
      {"description": "Accrued wages (Dec 28-31)", "amount": 18000},
      {"description": "Guest deposits for next season", "amount": 85000},
      {"description": "Utility bills received but unpaid", "amount": 12000},
      {"description": "Gift card balances outstanding", "amount": 32000},
      {"description": "Short-term bank loan due March", "amount": 100000},
      {"description": "Interest accrued on bank loan", "amount": 2500},
      {"description": "Property taxes due in 60 days", "amount": 45000},
      {"description": "Current portion of mortgage", "amount": 60000}
    ],
    "questions": [
      {
        "id": "cl1",
        "question": "Guest deposits are classified as:",
        "answer_type": "choice",
        "options": ["Revenue", "Unearned Revenue (Liability)", "Accounts Receivable", "Prepaid Expense"],
        "correct_answer": "Unearned Revenue (Liability)",
        "explanation": "Guest deposits received for future stays are unearned revenue - a liability until the service is provided."
      },
      {
        "id": "cl2",
        "question": "Calculate total Accrued Liabilities.",
        "answer_type": "numeric",
        "correct_answer": 77500,
        "tolerance": 100,
        "hint": "Wages + Utilities + Interest + Property taxes",
        "explanation": "Accrued = 18,000 + 12,000 + 2,500 + 45,000 = CHF 77,500"
      },
      {
        "id": "cl3",
        "question": "Calculate total Unearned Revenue.",
        "answer_type": "numeric",
        "correct_answer": 117000,
        "tolerance": 100,
        "hint": "Guest deposits + Gift cards",
        "explanation": "Unearned Revenue = 85,000 + 32,000 = CHF 117,000"
      },
      {
        "id": "cl4",
        "question": "Calculate total Notes/Loans Payable (current).",
        "answer_type": "numeric",
        "correct_answer": 160000,
        "tolerance": 100,
        "hint": "Short-term loan + Current portion of mortgage",
        "explanation": "Notes Payable = 100,000 + 60,000 = CHF 160,000"
      },
      {
        "id": "cl5",
        "question": "Calculate Total Current Liabilities.",
        "answer_type": "numeric",
        "correct_answer": 479500,
        "tolerance": 500,
        "explanation": "Total CL = 125,000 + 77,500 + 117,000 + 160,000 = CHF 479,500"
      }
    ],
    "passing_score": 80
  }'::jsonb,
  'liability-calculator',
  false,
  true
),

-- ============================================
-- Activity 2.10: Current Liabilities Quiz
-- Primary Skill: bs-current-liabilities
-- ============================================
(
  'fa200000-0000-0000-0002-000000000010',
  'fa000000-0000-0000-0000-000000000002',
  '2.10',
  10,
  'Current Liabilities Quiz',
  'current-liabilities-quiz',
  'quiz',
  10,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which is NOT a current liability?",
        "options": [
          "Accounts Payable",
          "Wages Payable",
          "Bonds Payable due in 5 years",
          "Unearned Revenue"
        ],
        "correct": 2,
        "explanation": "Bonds due in 5 years are long-term (non-current) liabilities. A/P, wages payable, and unearned revenue are current."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A company receives CHF 24,000 for a 2-year subscription on July 1. At December 31, Unearned Revenue is:",
        "options": [
          "CHF 24,000",
          "CHF 18,000",
          "CHF 12,000",
          "CHF 6,000"
        ],
        "correct": 1,
        "explanation": "6 months of 24 months earned = CHF 6,000 revenue. Remaining unearned = 24,000 - 6,000 = CHF 18,000."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Wages earned by employees Dec 28-31 but paid Jan 5 require which year-end entry?",
        "options": [
          "No entry needed until payment",
          "Dr Wages Expense; Cr Wages Payable",
          "Dr Wages Payable; Cr Cash",
          "Dr Wages Expense; Cr Cash"
        ],
        "correct": 1,
        "explanation": "Accrue the expense when incurred: Dr Wages Expense, Cr Wages Payable. Payment in January is a separate entry."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A CHF 500,000 mortgage has CHF 40,000 principal due in the next 12 months. On the Balance Sheet:",
        "options": [
          "CHF 500,000 in long-term liabilities",
          "CHF 500,000 in current liabilities",
          "CHF 40,000 current; CHF 460,000 long-term",
          "CHF 460,000 current; CHF 40,000 long-term"
        ],
        "correct": 2,
        "explanation": "The current portion (CHF 40,000) must be classified as current liability; the remainder (CHF 460,000) stays long-term."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Gift cards sold but not yet redeemed are reported as revenue on the income statement.",
        "correct": false,
        "explanation": "FALSE. Gift cards not redeemed are Unearned Revenue (a liability). Revenue is recognized when the gift card is used."
      }
    ],
    "passing_score": 70,
    "show_explanations": true
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.11: Non-Current Liabilities Introduction
-- Primary Skill: bs-noncurrent-liabilities
-- ============================================
(
  'fa200000-0000-0000-0002-000000000011',
  'fa000000-0000-0000-0000-000000000002',
  '2.11',
  11,
  'Non-Current Liabilities Introduction',
  'noncurrent-liabilities-introduction',
  'lesson',
  16,
  32,
  'basic',
  '{"markdown": "# Non-Current Liabilities Introduction\n\n## Why This Matters\n\nNon-current liabilities represent long-term financing that shapes a company''s capital structure. Understanding these obligations is essential for analyzing solvency and leverage.\n\n---\n\n## Definition\n\n> **Non-Current Liabilities** are obligations not due within one year or the operating cycle.\n\n---\n\n## Types of Non-Current Liabilities\n\n### 1. Long-Term Notes Payable\n\nFormal borrowing agreements with maturities beyond one year.\n\n| Feature | Description |\n|---------|-------------|\n| Principal | Amount borrowed |\n| Interest Rate | Fixed or variable |\n| Maturity | When full repayment is due |\n| Collateral | May be secured by assets |\n\n### 2. Bonds Payable\n\nDebt securities sold to investors (covered in depth later).\n\n| Term | Meaning |\n|------|--------|\n| **Face Value** | Amount repaid at maturity |\n| **Coupon Rate** | Stated interest rate |\n| **Market Rate** | Current interest rate |\n| **Maturity Date** | When principal is due |\n\n### 3. Mortgage Payable\n\nLoans secured by real property (buildings, land).\n\n### 4. Lease Liabilities\n\nObligations under finance (capital) leases.\n\n### 5. Pension Liabilities\n\nObligations to pay retirement benefits to employees.\n\n### 6. Deferred Tax Liabilities\n\nTaxes that will be paid in future periods due to timing differences.\n\n---\n\n## Bonds Payable Basics\n\n### How Bonds Work\n\n```\n1. Company issues bonds to investors\n2. Investors pay cash (proceeds)\n3. Company makes periodic interest payments (coupon)\n4. At maturity, company repays face value\n```\n\n### Bond Pricing\n\n| Condition | Issue Price | Premium/Discount |\n|-----------|------------|------------------|\n| Coupon Rate > Market Rate | Above Face Value | Premium |\n| Coupon Rate = Market Rate | At Face Value | Par |\n| Coupon Rate < Market Rate | Below Face Value | Discount |\n\n### Example: Bond at Premium\n\n- Face Value: CHF 1,000,000\n- Coupon Rate: 6%\n- Market Rate: 5%\n- Issue Price: CHF 1,077,217 (premium of CHF 77,217)\n\n**Why Premium?** Investors pay more for higher-than-market interest payments.\n\n---\n\n## Recording Long-Term Debt\n\n### Initial Recording\n\n**Borrow CHF 500,000 on 5-year note:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 500,000 | |\n| Notes Payable | | 500,000 |\n\n### Interest Expense (Annual)\n\n**Interest at 6%:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Interest Expense | 30,000 | |\n| Cash (or Interest Payable) | | 30,000 |\n\n---\n\n## Balance Sheet Presentation\n\n```\nLIABILITIES\n\nCurrent Liabilities:\n  Accounts Payable              CHF 150,000\n  Current Portion of LT Debt         80,000\n  Other Current                      50,000\n                                ----------\n  Total Current                     280,000\n\nNon-Current Liabilities:\n  Notes Payable                     400,000\n  Bonds Payable                     500,000\n  Mortgage Payable                  800,000\n  Lease Liabilities                 150,000\n                                ----------\n  Total Non-Current               1,850,000\n                                ----------\nTOTAL LIABILITIES             CHF 2,130,000\n```\n\n---\n\n## Debt Covenants\n\n### What Are Covenants?\n\nRestrictions imposed by lenders to protect their investment:\n\n| Type | Example |\n|------|--------|\n| **Financial Ratios** | Maintain Current Ratio > 1.5 |\n| **Restrictions** | No additional borrowing |\n| **Requirements** | Provide audited financials |\n\n### Covenant Violations\n\n- May trigger immediate repayment\n- Often renegotiated (waiver)\n- Disclosed in financial statements\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Non-current = due beyond 1 year\n> - Include notes, bonds, mortgages, leases\n> - Current portion of LT debt is reclassified each year\n> - Bonds at premium: Coupon > Market rate\n> - Bonds at discount: Coupon < Market rate\n> - Covenants restrict company actions"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.12: Bonds Payable Basics
-- Primary Skill: bs-noncurrent-liabilities
-- ============================================
(
  'fa200000-0000-0000-0002-000000000012',
  'fa000000-0000-0000-0000-000000000002',
  '2.12',
  12,
  'Bonds Payable Basics',
  'bonds-payable-basics',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Bond Pricing and Recording: Metro Corp",
    "description": "Understand bond pricing and record bond transactions for Metro Corp.",
    "company_background": "Metro Corp issues bonds to finance a new factory. Analyze the bond terms and calculate key amounts.",
    "bond_data": {
      "face_value": 1000000,
      "coupon_rate": 0.05,
      "market_rate": 0.06,
      "term_years": 5,
      "issue_price": 957876,
      "annual_interest": 50000
    },
    "questions": [
      {
        "id": "bp1",
        "question": "Is this bond issued at a premium, par, or discount?",
        "answer_type": "choice",
        "options": ["Premium", "Par", "Discount"],
        "correct_answer": "Discount",
        "explanation": "Since coupon rate (5%) < market rate (6%), investors pay less than face value = Discount."
      },
      {
        "id": "bp2",
        "question": "What is the amount of the discount?",
        "answer_type": "numeric",
        "correct_answer": 42124,
        "tolerance": 100,
        "hint": "Face Value - Issue Price",
        "explanation": "Discount = 1,000,000 - 957,876 = CHF 42,124"
      },
      {
        "id": "bp3",
        "question": "What is the annual cash interest payment?",
        "answer_type": "numeric",
        "correct_answer": 50000,
        "tolerance": 100,
        "hint": "Face Value x Coupon Rate",
        "explanation": "Cash Interest = 1,000,000 x 5% = CHF 50,000 per year"
      },
      {
        "id": "bp4",
        "question": "At issuance, what is recorded as Cash received?",
        "answer_type": "numeric",
        "correct_answer": 957876,
        "tolerance": 100,
        "explanation": "Cash received = Issue price = CHF 957,876"
      },
      {
        "id": "bp5",
        "question": "If a bond is issued at a premium, interest expense over the life will be:",
        "answer_type": "choice",
        "options": ["Greater than cash interest paid", "Less than cash interest paid", "Equal to cash interest paid"],
        "correct_answer": "Less than cash interest paid",
        "explanation": "Premium is amortized, reducing interest expense below cash paid. For discount (like Metro), expense > cash paid."
      }
    ],
    "passing_score": 80
  }'::jsonb,
  'bond-calculator',
  false,
  true
),

-- ============================================
-- Activity 2.13: Non-Current Liabilities Quiz
-- Primary Skill: bs-noncurrent-liabilities
-- ============================================
(
  'fa200000-0000-0000-0002-000000000013',
  'fa000000-0000-0000-0000-000000000002',
  '2.13',
  13,
  'Non-Current Liabilities Quiz',
  'noncurrent-liabilities-quiz',
  'quiz',
  10,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A bond is issued at a premium when:",
        "options": [
          "Coupon rate is less than market rate",
          "Coupon rate equals market rate",
          "Coupon rate is greater than market rate",
          "The company has high credit risk"
        ],
        "correct": 2,
        "explanation": "When coupon rate > market rate, investors pay more than face value (premium) to receive higher interest payments."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A CHF 500,000 bond at 6% coupon has annual interest payments of:",
        "options": [
          "CHF 3,000",
          "CHF 30,000",
          "CHF 300,000",
          "CHF 500,000"
        ],
        "correct": 1,
        "explanation": "Annual Interest = Face Value x Coupon Rate = 500,000 x 6% = CHF 30,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A company has a CHF 2,000,000 mortgage with CHF 150,000 due next year. Balance sheet shows:",
        "options": [
          "CHF 2,000,000 in non-current liabilities",
          "CHF 150,000 current; CHF 1,850,000 non-current",
          "CHF 2,000,000 in current liabilities",
          "No liability until payment is made"
        ],
        "correct": 1,
        "explanation": "The current portion (CHF 150,000) is classified as current liability; the remainder is non-current."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A bond with face value CHF 100,000 is issued for CHF 103,000. The CHF 3,000 represents:",
        "options": [
          "Interest expense",
          "Premium on bonds payable",
          "Discount on bonds payable",
          "Gain on bond issuance"
        ],
        "correct": 1,
        "explanation": "When issue price > face value, the difference is a premium. Premium is amortized over the bond''s life."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "When a bond is issued at a discount, the company will pay less total interest over the life of the bond.",
        "correct": false,
        "explanation": "FALSE. Discount means coupon rate < market rate. Total interest expense is HIGHER because the discount is amortized, increasing expense above cash paid."
      }
    ],
    "passing_score": 70,
    "show_explanations": true
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.14: Balance Sheet Construction Exercise
-- Primary Skill: bs-interpretation
-- ============================================
(
  'fa200000-0000-0000-0002-000000000014',
  'fa000000-0000-0000-0000-000000000002',
  '2.14',
  14,
  'Balance Sheet Construction Exercise',
  'balance-sheet-construction',
  'interactive',
  22,
  55,
  'basic',
  '{
    "title": "Build the Balance Sheet: Horizon Industries",
    "description": "Classify accounts and prepare a classified balance sheet for Horizon Industries.",
    "company_background": "Horizon Industries manufactures precision instruments. Organize their accounts into a proper classified balance sheet.",
    "accounts": [
      {"name": "Cash", "amount": 145000, "type": "current_asset"},
      {"name": "Accounts Receivable", "amount": 280000, "type": "current_asset"},
      {"name": "Inventory", "amount": 320000, "type": "current_asset"},
      {"name": "Prepaid Insurance", "amount": 24000, "type": "current_asset"},
      {"name": "Land", "amount": 500000, "type": "noncurrent_asset"},
      {"name": "Buildings", "amount": 1200000, "type": "noncurrent_asset"},
      {"name": "Accumulated Depreciation - Buildings", "amount": 360000, "type": "contra_asset"},
      {"name": "Equipment", "amount": 450000, "type": "noncurrent_asset"},
      {"name": "Accumulated Depreciation - Equipment", "amount": 135000, "type": "contra_asset"},
      {"name": "Accounts Payable", "amount": 185000, "type": "current_liability"},
      {"name": "Wages Payable", "amount": 45000, "type": "current_liability"},
      {"name": "Unearned Revenue", "amount": 60000, "type": "current_liability"},
      {"name": "Current Portion of Notes", "amount": 100000, "type": "current_liability"},
      {"name": "Notes Payable (long-term)", "amount": 400000, "type": "noncurrent_liability"},
      {"name": "Bonds Payable", "amount": 500000, "type": "noncurrent_liability"},
      {"name": "Common Stock", "amount": 600000, "type": "equity"},
      {"name": "Retained Earnings", "amount": 534000, "type": "equity"}
    ],
    "questions": [
      {
        "id": "bs1",
        "question": "Calculate Total Current Assets.",
        "answer_type": "numeric",
        "correct_answer": 769000,
        "tolerance": 100,
        "explanation": "Current Assets = 145,000 + 280,000 + 320,000 + 24,000 = CHF 769,000"
      },
      {
        "id": "bs2",
        "question": "Calculate Net Property, Plant & Equipment.",
        "answer_type": "numeric",
        "correct_answer": 1655000,
        "tolerance": 100,
        "hint": "Land + Buildings + Equipment - All Accumulated Depreciation",
        "explanation": "Net PPE = 500,000 + 1,200,000 + 450,000 - 360,000 - 135,000 = CHF 1,655,000"
      },
      {
        "id": "bs3",
        "question": "Calculate Total Assets.",
        "answer_type": "numeric",
        "correct_answer": 2424000,
        "tolerance": 100,
        "explanation": "Total Assets = 769,000 + 1,655,000 = CHF 2,424,000"
      },
      {
        "id": "bs4",
        "question": "Calculate Total Current Liabilities.",
        "answer_type": "numeric",
        "correct_answer": 390000,
        "tolerance": 100,
        "explanation": "Current Liabilities = 185,000 + 45,000 + 60,000 + 100,000 = CHF 390,000"
      },
      {
        "id": "bs5",
        "question": "Calculate Total Liabilities.",
        "answer_type": "numeric",
        "correct_answer": 1290000,
        "tolerance": 100,
        "explanation": "Total Liabilities = 390,000 + 400,000 + 500,000 = CHF 1,290,000"
      },
      {
        "id": "bs6",
        "question": "Calculate Total Shareholders'' Equity.",
        "answer_type": "numeric",
        "correct_answer": 1134000,
        "tolerance": 100,
        "explanation": "Equity = 600,000 + 534,000 = CHF 1,134,000"
      },
      {
        "id": "bs7",
        "question": "Verify: Does the Balance Sheet balance? Assets = Liabilities + Equity?",
        "answer_type": "choice",
        "options": ["Yes, it balances", "No, it does not balance"],
        "correct_answer": "Yes, it balances",
        "explanation": "Assets (2,424,000) = Liabilities (1,290,000) + Equity (1,134,000). Yes, it balances!"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'balance-sheet-builder',
  false,
  true
),

-- ============================================
-- Activity 2.15: Comparative Balance Sheet Analysis
-- Primary Skill: bs-interpretation
-- ============================================
(
  'fa200000-0000-0000-0002-000000000015',
  'fa000000-0000-0000-0000-000000000002',
  '2.15',
  15,
  'Comparative Balance Sheet Analysis',
  'comparative-balance-sheet-analysis',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Balance Sheet Analysis: Nordic Electronics",
    "description": "Analyze changes in Nordic Electronics'' balance sheet over two years.",
    "company_background": "Nordic Electronics is a growing technology company. Compare their year-end balance sheets to understand financial position changes.",
    "financial_data": {
      "year_2023": {
        "cash": 150000,
        "accounts_receivable": 200000,
        "inventory": 180000,
        "total_current_assets": 530000,
        "ppe_net": 700000,
        "total_assets": 1230000,
        "accounts_payable": 120000,
        "current_portion_debt": 50000,
        "total_current_liabilities": 170000,
        "long_term_debt": 300000,
        "total_liabilities": 470000,
        "shareholders_equity": 760000
      },
      "year_2024": {
        "cash": 95000,
        "accounts_receivable": 280000,
        "inventory": 250000,
        "total_current_assets": 625000,
        "ppe_net": 950000,
        "total_assets": 1575000,
        "accounts_payable": 160000,
        "current_portion_debt": 60000,
        "total_current_liabilities": 220000,
        "long_term_debt": 450000,
        "total_liabilities": 670000,
        "shareholders_equity": 905000
      }
    },
    "questions": [
      {
        "id": "cba1",
        "question": "By how much did Total Assets grow (in CHF)?",
        "answer_type": "numeric",
        "correct_answer": 345000,
        "tolerance": 100,
        "explanation": "Asset Growth = 1,575,000 - 1,230,000 = CHF 345,000"
      },
      {
        "id": "cba2",
        "question": "Calculate the percentage growth in Total Assets.",
        "answer_type": "numeric",
        "correct_answer": 28.0,
        "tolerance": 0.5,
        "explanation": "Growth % = 345,000 / 1,230,000 x 100 = 28.0%"
      },
      {
        "id": "cba3",
        "question": "What happened to the Current Ratio from 2023 to 2024?",
        "answer_type": "choice",
        "options": ["Improved (increased)", "Declined (decreased)", "Stayed the same"],
        "correct_answer": "Declined (decreased)",
        "explanation": "2023: 530,000/170,000 = 3.12. 2024: 625,000/220,000 = 2.84. Current ratio declined."
      },
      {
        "id": "cba4",
        "question": "Calculate the Debt-to-Equity ratio for 2024 (rounded to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 0.74,
        "tolerance": 0.02,
        "explanation": "D/E 2024 = 670,000 / 905,000 = 0.74"
      },
      {
        "id": "cba5",
        "question": "Which best describes the financing of growth?",
        "answer_type": "choice",
        "options": [
          "Primarily through equity (retained earnings)",
          "Primarily through debt",
          "Balanced mix of debt and equity"
        ],
        "correct_answer": "Balanced mix of debt and equity",
        "explanation": "Liability increase: 200,000. Equity increase: 145,000. Growth funded by both, slightly more debt."
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'ratio-calculator',
  false,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;

-- ============================================
-- ADD SKILL TAGS FOR NEW MODULE 2 ACTIVITIES
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 2.8 Current Liabilities Deep Dive (bs-current-liabilities)
('fa200000-0000-0000-0002-000000000008', 'b0000000-0000-0000-0002-000000000003', 1.0, true),

-- 2.9 Current Liabilities Practice (bs-current-liabilities)
('fa200000-0000-0000-0002-000000000009', 'b0000000-0000-0000-0002-000000000003', 1.0, true),

-- 2.10 Current Liabilities Quiz (bs-current-liabilities)
('fa200000-0000-0000-0002-000000000010', 'b0000000-0000-0000-0002-000000000003', 1.0, true),

-- 2.11 Non-Current Liabilities Introduction (bs-noncurrent-liabilities)
('fa200000-0000-0000-0002-000000000011', 'b0000000-0000-0000-0002-000000000004', 1.0, true),

-- 2.12 Bonds Payable Basics (bs-noncurrent-liabilities)
('fa200000-0000-0000-0002-000000000012', 'b0000000-0000-0000-0002-000000000004', 1.0, true),

-- 2.13 Non-Current Liabilities Quiz (bs-noncurrent-liabilities)
('fa200000-0000-0000-0002-000000000013', 'b0000000-0000-0000-0002-000000000004', 1.0, true),

-- 2.14 Balance Sheet Construction (bs-interpretation)
('fa200000-0000-0000-0002-000000000014', 'b0000000-0000-0000-0002-000000000006', 1.0, true),
('fa200000-0000-0000-0002-000000000014', 'b0000000-0000-0000-0002-000000000003', 0.3, false),
('fa200000-0000-0000-0002-000000000014', 'b0000000-0000-0000-0002-000000000004', 0.3, false),

-- 2.15 Comparative Balance Sheet (bs-interpretation)
('fa200000-0000-0000-0002-000000000015', 'b0000000-0000-0000-0002-000000000006', 1.0, true)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

