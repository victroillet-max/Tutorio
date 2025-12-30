-- ============================================
-- FA Course Content Expansion - Phase 2
-- Module 8: Liabilities and Equity Expansion
-- Adds 8 new activities for liabilities and equity
-- ============================================

-- ============================================
-- NEW ACTIVITIES FOR MODULE 8
-- Following existing UUID pattern: fa800000-0000-0000-0008-00000000XXXX
-- Existing activities: 0001-0005, new start at 0006
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 8.6: Advanced Bond Accounting
-- Primary Skill: liab-bonds
-- ============================================
(
  'fa800000-0000-0000-0008-000000000006',
  'fa000000-0000-0000-0000-000000000008',
  '8.6',
  6,
  'Advanced Bond Accounting',
  'advanced-bond-accounting',
  'lesson',
  18,
  36,
  'basic',
  '{"markdown": "# Advanced Bond Accounting\n\n## Why This Matters\n\nBonds are a major financing tool. Understanding premium and discount amortization is essential for accurate financial reporting.\n\n---\n\n## Bond Terminology Review\n\n| Term | Definition |\n|------|------------|\n| **Face Value** | Amount repaid at maturity (par value) |\n| **Coupon Rate** | Stated annual interest rate |\n| **Market Rate** | Current interest rate for similar bonds |\n| **Issue Price** | Amount investors pay |\n| **Premium** | Issue Price > Face Value |\n| **Discount** | Issue Price < Face Value |\n\n---\n\n## Why Bonds Sell at Premium or Discount\n\n### Premium Bond\n\n```\nCoupon Rate > Market Rate\n= Investors willing to pay MORE for higher interest\n= Issue Price > Face Value\n```\n\n### Discount Bond\n\n```\nCoupon Rate < Market Rate\n= Investors demand LESS to accept lower interest\n= Issue Price < Face Value\n```\n\n---\n\n## Amortization: The Big Picture\n\n### What Is Amortization?\n\nThe process of gradually adjusting the bond carrying value toward face value over the bond''s life.\n\n| Bond Type | Premium/Discount | Effect on Carrying Value |\n|-----------|-----------------|------------------------|\n| Premium | Decreases | Carrying value decreases |\n| Discount | Increases | Carrying value increases |\n\n---\n\n## Straight-Line Amortization\n\n### Formula\n\n```\nPeriodic Amortization = Total Premium or Discount / Number of Periods\n```\n\n### Example: Bond Issued at Discount\n\n| Detail | Amount |\n|--------|--------|\n| Face Value | CHF 500,000 |\n| Issue Price | CHF 475,000 |\n| Discount | CHF 25,000 |\n| Term | 5 years |\n| Annual Amortization | CHF 5,000 |\n\n### Journal Entry: Annual Interest + Amortization\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Interest Expense | 35,000 | |\n| Discount on Bonds Payable | | 5,000 |\n| Cash | | 30,000 |\n\n*Cash = Face Value x Coupon Rate = 500,000 x 6% = 30,000*\n*Interest Expense = Cash + Discount Amortization = 30,000 + 5,000 = 35,000*\n\n---\n\n## Premium Amortization Example\n\n| Detail | Amount |\n|--------|--------|\n| Face Value | CHF 500,000 |\n| Issue Price | CHF 535,000 |\n| Premium | CHF 35,000 |\n| Term | 7 years |\n| Annual Amortization | CHF 5,000 |\n\n### Journal Entry: Annual Interest + Amortization\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Interest Expense | 35,000 | |\n| Premium on Bonds Payable | 5,000 | |\n| Cash | | 40,000 |\n\n*Cash = 500,000 x 8% = 40,000*\n*Interest Expense = Cash - Premium Amortization = 40,000 - 5,000 = 35,000*\n\n---\n\n## Carrying Value Over Time\n\n### Discount Bond Schedule (Simplified)\n\n| Year | Carrying Value Start | + Amortization | Carrying Value End |\n|------|---------------------|----------------|-------------------|\n| 1 | 475,000 | 5,000 | 480,000 |\n| 2 | 480,000 | 5,000 | 485,000 |\n| 3 | 485,000 | 5,000 | 490,000 |\n| 4 | 490,000 | 5,000 | 495,000 |\n| 5 | 495,000 | 5,000 | 500,000 |\n\n**At maturity, Carrying Value = Face Value**\n\n---\n\n## Balance Sheet Presentation\n\n### Discount\n\n```\nLong-Term Liabilities:\n  Bonds Payable               CHF 500,000\n  Less: Discount on Bonds        (20,000)\n                              -----------\n  Net Carrying Value          CHF 480,000\n```\n\n### Premium\n\n```\nLong-Term Liabilities:\n  Bonds Payable               CHF 500,000\n  Add: Premium on Bonds           28,000\n                              -----------\n  Net Carrying Value          CHF 528,000\n```\n\n---\n\n## Interest Expense Patterns\n\n| Bond Type | Interest Expense vs Cash Paid |\n|-----------|------------------------------|\n| Discount | Expense > Cash (higher cost) |\n| Premium | Expense < Cash (lower cost) |\n| Par | Expense = Cash |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Premium: Coupon > Market, pay more than face\n> - Discount: Coupon < Market, pay less than face\n> - Amortization adjusts carrying value toward face\n> - Discount increases interest expense\n> - Premium decreases interest expense\n> - At maturity, carrying value = face value"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 8.7: Bond Amortization Practice
-- Primary Skill: liab-bonds
-- ============================================
(
  'fa800000-0000-0000-0008-000000000007',
  'fa000000-0000-0000-0000-000000000008',
  '8.7',
  7,
  'Bond Amortization Practice',
  'bond-amortization-practice',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Bond Amortization: Glacier Corp",
    "description": "Calculate bond values and amortization for Glacier Corp bonds issued at a discount.",
    "company_background": "Glacier Corp issued bonds to finance expansion. Work through the amortization schedule.",
    "bond_data": {
      "face_value": 800000,
      "coupon_rate": 0.05,
      "market_rate": 0.06,
      "issue_price": 766000,
      "term_years": 10,
      "payment": "annual"
    },
    "questions": [
      {
        "id": "ba1",
        "question": "Calculate the total discount on the bonds.",
        "answer_type": "numeric",
        "correct_answer": 34000,
        "tolerance": 100,
        "hint": "Face Value - Issue Price",
        "explanation": "Discount = 800,000 - 766,000 = CHF 34,000"
      },
      {
        "id": "ba2",
        "question": "Calculate annual discount amortization (straight-line).",
        "answer_type": "numeric",
        "correct_answer": 3400,
        "tolerance": 50,
        "explanation": "Annual Amortization = 34,000 / 10 years = CHF 3,400"
      },
      {
        "id": "ba3",
        "question": "Calculate annual cash interest payment.",
        "answer_type": "numeric",
        "correct_answer": 40000,
        "tolerance": 100,
        "hint": "Face Value x Coupon Rate",
        "explanation": "Cash Interest = 800,000 x 5% = CHF 40,000"
      },
      {
        "id": "ba4",
        "question": "Calculate annual interest expense.",
        "answer_type": "numeric",
        "correct_answer": 43400,
        "tolerance": 100,
        "hint": "Cash Interest + Discount Amortization",
        "explanation": "Interest Expense = 40,000 + 3,400 = CHF 43,400"
      },
      {
        "id": "ba5",
        "question": "What is the carrying value at end of Year 1?",
        "answer_type": "numeric",
        "correct_answer": 769400,
        "tolerance": 100,
        "explanation": "Year 1 CV = 766,000 + 3,400 = CHF 769,400"
      },
      {
        "id": "ba6",
        "question": "What is the carrying value at end of Year 5?",
        "answer_type": "numeric",
        "correct_answer": 783000,
        "tolerance": 100,
        "hint": "Issue Price + (Amortization x 5)",
        "explanation": "Year 5 CV = 766,000 + (3,400 x 5) = CHF 783,000"
      },
      {
        "id": "ba7",
        "question": "Total interest expense over the bond''s life:",
        "answer_type": "numeric",
        "correct_answer": 434000,
        "tolerance": 500,
        "explanation": "Total = 43,400 x 10 = CHF 434,000 (or 400,000 cash + 34,000 discount)"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'bond-calculator',
  false,
  true
),

-- ============================================
-- Activity 8.8: Contingent Liabilities
-- Primary Skill: liab-contingent
-- ============================================
(
  'fa800000-0000-0000-0008-000000000008',
  'fa000000-0000-0000-0000-000000000008',
  '8.8',
  8,
  'Contingent Liabilities',
  'contingent-liabilities',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# Contingent Liabilities\n\n## Why This Matters\n\nContingent liabilities are potential obligations depending on uncertain future events. Proper treatment is crucial for fair financial reporting.\n\n---\n\n## What Is a Contingent Liability?\n\n> A **Contingent Liability** is a potential obligation that may or may not become an actual liability, depending on the outcome of an uncertain future event.\n\n---\n\n## Common Examples\n\n| Type | Example |\n|------|--------|\n| **Lawsuits** | Pending litigation against the company |\n| **Product Warranties** | Potential claims from customers |\n| **Environmental** | Cleanup costs for contamination |\n| **Guarantees** | Guaranteeing another party''s debt |\n| **Tax Disputes** | Pending audits/challenges |\n\n---\n\n## Three Levels of Likelihood\n\n| Level | Meaning | Probability |\n|-------|---------|-------------|\n| **Probable** | Likely to occur | > 50% |\n| **Possible** | Could occur | 10-50% |\n| **Remote** | Unlikely to occur | < 10% |\n\n---\n\n## Accounting Treatment\n\n### Decision Tree\n\n```\nIs the loss PROBABLE and ESTIMABLE?\n├── YES → Record liability and expense\n└── NO ─→ Is it POSSIBLE?\n          ├── YES → Disclose in notes only\n          └── NO → No action needed (remote)\n```\n\n---\n\n## Recording a Contingent Liability\n\n### When to Record\n\n1. Loss is **PROBABLE** (>50%), AND\n2. Amount is **REASONABLY ESTIMABLE**\n\n### Journal Entry\n\n**Company estimates CHF 500,000 loss from lawsuit (probable):**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Lawsuit Expense | 500,000 | |\n| Lawsuit Liability | | 500,000 |\n\n---\n\n## Disclosure Only\n\n### When to Disclose\n\n- Loss is **possible** (not probable), OR\n- Loss is probable but **not estimable**\n\n### Disclosure Requirements\n\n- Nature of the contingency\n- Estimated range of loss (if available)\n- Statement that amount cannot be estimated\n\n---\n\n## Product Warranty Example\n\n### Situation\n\n- Company sells CHF 2,000,000 of products\n- Historical warranty claims: 3% of sales\n- Expected warranty liability: CHF 60,000\n\n### Journal Entry\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Warranty Expense | 60,000 | |\n| Warranty Liability | | 60,000 |\n\n### When Claims Are Paid\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Warranty Liability | 15,000 | |\n| Cash/Parts | | 15,000 |\n\n---\n\n## Gain Contingencies\n\n### Treatment\n\n> Gain contingencies are generally **NOT RECORDED** until realized, but may be disclosed.\n\n### Why?\n\nConservatism principle: don''t recognize gains until certain, but recognize losses when probable.\n\n---\n\n## Balance Sheet Presentation\n\n```\nLIABILITIES\n\nCurrent Liabilities:\n  Warranty Liability              CHF 45,000\n  Litigation Reserve                 200,000\n\nNon-Current Liabilities:\n  Environmental Liability           850,000\n```\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Probable + Estimable = Record as liability\n> - Possible = Disclose only (footnotes)\n> - Remote = No action required\n> - Warranties are contingent liabilities\n> - Gain contingencies: disclose only, don''t record"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 8.9: Contingent Liabilities Practice
-- Primary Skill: liab-contingent
-- ============================================
(
  'fa800000-0000-0000-0008-000000000009',
  'fa000000-0000-0000-0000-000000000008',
  '8.9',
  9,
  'Contingent Liabilities Practice',
  'contingent-liabilities-practice',
  'interactive',
  16,
  40,
  'basic',
  '{
    "title": "Contingent Liabilities: Atlas Industries",
    "description": "Determine the proper accounting treatment for various contingent situations at Atlas Industries.",
    "company_background": "Atlas Industries faces several contingent situations at year-end. Determine proper treatment for each.",
    "scenarios": [
      {
        "id": "A",
        "description": "Lawsuit: Former employee suing for CHF 300,000. Legal counsel says loss is probable. Company estimates potential loss at CHF 250,000."
      },
      {
        "id": "B",
        "description": "Product warranty: Sold CHF 5,000,000 in appliances. Historical warranty rate is 2.5% of sales."
      },
      {
        "id": "C",
        "description": "Environmental: Possible cleanup needed at old factory site. If required, cost estimated at CHF 800,000-1,200,000. Currently considered possible, not probable."
      },
      {
        "id": "D",
        "description": "Pending patent case: Company might receive CHF 2,000,000 if it wins the lawsuit against a competitor."
      },
      {
        "id": "E",
        "description": "Guarantee: Atlas guaranteed a CHF 500,000 loan for subsidiary. Subsidiary is financially healthy; default is remote."
      }
    ],
    "questions": [
      {
        "id": "cl1",
        "question": "Scenario A (Lawsuit): What is the proper treatment?",
        "answer_type": "choice",
        "options": [
          "Record CHF 250,000 liability",
          "Record CHF 300,000 liability",
          "Disclose only, do not record",
          "No action required"
        ],
        "correct_answer": "Record CHF 250,000 liability",
        "explanation": "Probable and estimable at CHF 250,000. Record liability at estimated amount."
      },
      {
        "id": "cl2",
        "question": "Scenario B (Warranty): Calculate the warranty liability to record.",
        "answer_type": "numeric",
        "correct_answer": 125000,
        "tolerance": 100,
        "explanation": "Warranty = 5,000,000 x 2.5% = CHF 125,000"
      },
      {
        "id": "cl3",
        "question": "Scenario C (Environmental): What is the proper treatment?",
        "answer_type": "choice",
        "options": [
          "Record CHF 1,000,000 liability (midpoint)",
          "Record CHF 800,000 liability (minimum)",
          "Disclose in footnotes only",
          "No action required"
        ],
        "correct_answer": "Disclose in footnotes only",
        "explanation": "Possible, not probable. Disclosure is required but no liability is recorded."
      },
      {
        "id": "cl4",
        "question": "Scenario D (Patent gain): What is the proper treatment?",
        "answer_type": "choice",
        "options": [
          "Record CHF 2,000,000 receivable",
          "Record CHF 1,000,000 receivable (50%)",
          "Disclose in footnotes only",
          "Record as revenue immediately"
        ],
        "correct_answer": "Disclose in footnotes only",
        "explanation": "Gain contingencies are not recorded until realized. May disclose if probable."
      },
      {
        "id": "cl5",
        "question": "Scenario E (Guarantee): What is the proper treatment?",
        "answer_type": "choice",
        "options": [
          "Record CHF 500,000 liability",
          "Record CHF 250,000 liability",
          "Disclose in footnotes only",
          "No action required"
        ],
        "correct_answer": "No action required",
        "explanation": "Remote likelihood of loss. No recording or disclosure required."
      },
      {
        "id": "cl6",
        "question": "Total contingent liabilities to RECORD (not just disclose):",
        "answer_type": "numeric",
        "correct_answer": 375000,
        "tolerance": 500,
        "explanation": "Record: Lawsuit 250,000 + Warranty 125,000 = CHF 375,000"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'contingency-analyzer',
  false,
  true
),

-- ============================================
-- Activity 8.10: Stockholders' Equity Components
-- Primary Skill: eq-components
-- ============================================
(
  'fa800000-0000-0000-0008-000000000010',
  'fa000000-0000-0000-0000-000000000008',
  '8.10',
  10,
  'Stockholders'' Equity Components',
  'stockholders-equity-components',
  'lesson',
  16,
  32,
  'basic',
  '{"markdown": "# Stockholders'' Equity Components\n\n## Why This Matters\n\nEquity represents owners'' claims on assets. Understanding its components is essential for analyzing corporate financing and ownership structure.\n\n---\n\n## Definition\n\n> **Stockholders'' Equity** = Assets - Liabilities = Owners'' residual interest in the company\n\n---\n\n## Main Components\n\n| Component | Description |\n|-----------|-------------|\n| **Common Stock** | Par value of shares issued |\n| **Additional Paid-In Capital** | Amount above par |\n| **Retained Earnings** | Accumulated profits not distributed |\n| **Treasury Stock** | Company''s own shares repurchased |\n| **Accumulated OCI** | Unrealized gains/losses |\n\n---\n\n## Common Stock\n\n### Par Value vs. Issue Price\n\n| Term | Meaning |\n|------|--------|\n| **Par Value** | Nominal legal value (e.g., CHF 1/share) |\n| **Issue Price** | Actual price paid by investors |\n| **APIC** | Issue Price - Par Value |\n\n### Example: Issue 10,000 shares\n\n- Par Value: CHF 1/share\n- Issue Price: CHF 25/share\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 250,000 | |\n| Common Stock (par) | | 10,000 |\n| Additional Paid-In Capital | | 240,000 |\n\n---\n\n## Retained Earnings\n\n### What Affects Retained Earnings\n\n| Increase | Decrease |\n|----------|----------|\n| Net Income | Net Loss |\n| | Dividends declared |\n\n### Formula\n\n```\nEnding RE = Beginning RE + Net Income - Dividends\n```\n\n### Example\n\n- Beginning RE: CHF 500,000\n- Net Income: CHF 180,000\n- Dividends: CHF 40,000\n- Ending RE: CHF 640,000\n\n---\n\n## Treasury Stock\n\n### What Is It?\n\nShares the company previously issued but has repurchased.\n\n### Treatment\n\n- Recorded at COST\n- Contra-equity account (reduces equity)\n- No voting rights or dividends\n\n### Example: Repurchase 1,000 shares at CHF 30\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Treasury Stock | 30,000 | |\n| Cash | | 30,000 |\n\n---\n\n## Balance Sheet Presentation\n\n```\nSTOCKHOLDERS'' EQUITY\n\nCommon Stock, CHF 1 par,\n  100,000 shares authorized,\n  80,000 shares issued             CHF    80,000\n\nAdditional Paid-In Capital            1,920,000\n\nRetained Earnings                       640,000\n\nTreasury Stock (5,000 shares at cost)  (150,000)\n                                     ----------\nTotal Stockholders'' Equity         CHF 2,490,000\n```\n\n---\n\n## Key Calculations\n\n### Shares Outstanding\n\n```\nShares Outstanding = Shares Issued - Treasury Shares\nExample: 80,000 - 5,000 = 75,000 shares\n```\n\n### Book Value per Share\n\n```\nBook Value = Total Equity / Shares Outstanding\nExample: 2,490,000 / 75,000 = CHF 33.20\n```\n\n---\n\n## Common vs. Preferred Stock\n\n| Feature | Common | Preferred |\n|---------|--------|--------|\n| Voting Rights | Yes | Usually No |\n| Dividends | Variable | Fixed |\n| Dividend Priority | Last | First |\n| Liquidation | Residual | After debt, before common |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Common Stock = Par x Shares Issued\n> - APIC = (Issue Price - Par) x Shares\n> - Retained Earnings = Cumulative profits - dividends\n> - Treasury Stock is CONTRA-equity\n> - Outstanding = Issued - Treasury"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 8.11: Equity Transactions Practice
-- Primary Skill: eq-components
-- ============================================
(
  'fa800000-0000-0000-0008-000000000011',
  'fa000000-0000-0000-0000-000000000008',
  '8.11',
  11,
  'Equity Transactions Practice',
  'equity-transactions-practice',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Equity Transactions: Pinnacle Corp",
    "description": "Record and analyze equity transactions for Pinnacle Corp.",
    "company_background": "Pinnacle Corp has various equity transactions during the year. Analyze the effects on stockholders'' equity.",
    "beginning_equity": {
      "common_stock_par": 100000,
      "apic": 900000,
      "retained_earnings": 450000,
      "treasury_stock": 0,
      "shares_issued": 100000,
      "par_per_share": 1
    },
    "transactions": [
      {"date": "Feb 15", "description": "Issued 20,000 shares at CHF 15 per share"},
      {"date": "Jun 1", "description": "Repurchased 5,000 shares at CHF 18 per share"},
      {"date": "Sep 30", "description": "Declared cash dividends of CHF 0.50 per share on outstanding shares"},
      {"date": "Dec 31", "description": "Net income for the year: CHF 285,000"}
    ],
    "questions": [
      {
        "id": "eq1",
        "question": "Feb 15: Cash received from stock issuance:",
        "answer_type": "numeric",
        "correct_answer": 300000,
        "tolerance": 100,
        "explanation": "Cash = 20,000 shares x CHF 15 = CHF 300,000"
      },
      {
        "id": "eq2",
        "question": "Feb 15: Amount credited to Common Stock:",
        "answer_type": "numeric",
        "correct_answer": 20000,
        "tolerance": 100,
        "hint": "Shares x Par Value",
        "explanation": "Common Stock = 20,000 x CHF 1 par = CHF 20,000"
      },
      {
        "id": "eq3",
        "question": "Feb 15: Amount credited to APIC:",
        "answer_type": "numeric",
        "correct_answer": 280000,
        "tolerance": 100,
        "hint": "Cash - Common Stock",
        "explanation": "APIC = 300,000 - 20,000 = CHF 280,000"
      },
      {
        "id": "eq4",
        "question": "Jun 1: Amount debited to Treasury Stock:",
        "answer_type": "numeric",
        "correct_answer": 90000,
        "tolerance": 100,
        "explanation": "Treasury Stock = 5,000 x CHF 18 = CHF 90,000"
      },
      {
        "id": "eq5",
        "question": "Sep 30: Calculate shares outstanding for dividend:",
        "answer_type": "numeric",
        "correct_answer": 115000,
        "tolerance": 100,
        "hint": "Beginning + Issued - Treasury",
        "explanation": "Outstanding = 100,000 + 20,000 - 5,000 = 115,000 shares"
      },
      {
        "id": "eq6",
        "question": "Sep 30: Total dividends declared:",
        "answer_type": "numeric",
        "correct_answer": 57500,
        "tolerance": 100,
        "explanation": "Dividends = 115,000 x CHF 0.50 = CHF 57,500"
      },
      {
        "id": "eq7",
        "question": "Calculate ending Retained Earnings:",
        "answer_type": "numeric",
        "correct_answer": 677500,
        "tolerance": 200,
        "hint": "Beginning RE + Net Income - Dividends",
        "explanation": "RE = 450,000 + 285,000 - 57,500 = CHF 677,500"
      },
      {
        "id": "eq8",
        "question": "Calculate total ending Stockholders'' Equity:",
        "answer_type": "numeric",
        "correct_answer": 1887500,
        "tolerance": 500,
        "explanation": "Total Equity = 120,000 + 1,180,000 + 677,500 - 90,000 = CHF 1,887,500"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'equity-calculator',
  false,
  true
),

-- ============================================
-- Activity 8.12: Liabilities and Equity Quiz
-- Primary Skill: liab-bonds, eq-components
-- ============================================
(
  'fa800000-0000-0000-0008-000000000012',
  'fa000000-0000-0000-0000-000000000008',
  '8.12',
  12,
  'Liabilities and Equity Quiz',
  'liabilities-equity-quiz',
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
        "question": "A bond issued at a discount will have:",
        "options": [
          "Coupon rate higher than market rate",
          "Coupon rate equal to market rate",
          "Coupon rate lower than market rate",
          "No coupon payments"
        ],
        "correct": 2,
        "explanation": "Discount = Coupon < Market. Investors pay less because they receive below-market interest."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "CHF 600,000 bonds with CHF 24,000 discount, 8-year term. Annual discount amortization (straight-line) is:",
        "options": [
          "CHF 2,000",
          "CHF 3,000",
          "CHF 6,000",
          "CHF 24,000"
        ],
        "correct": 1,
        "explanation": "Annual Amortization = 24,000 / 8 = CHF 3,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A company has a probable lawsuit loss estimated at CHF 150,000-200,000. The company should:",
        "options": [
          "Record CHF 150,000 liability",
          "Record CHF 175,000 liability (midpoint)",
          "Disclose only, do not record",
          "Record CHF 200,000 liability"
        ],
        "correct": 0,
        "explanation": "When a range exists and no amount is more likely, record the minimum. CHF 150,000."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Issue 15,000 shares, CHF 2 par, at CHF 28. APIC credited is:",
        "options": [
          "CHF 30,000",
          "CHF 390,000",
          "CHF 420,000",
          "CHF 450,000"
        ],
        "correct": 1,
        "explanation": "APIC = 15,000 x (28 - 2) = 15,000 x 26 = CHF 390,000"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Treasury stock is:",
        "options": [
          "An asset on the balance sheet",
          "A contra-equity account",
          "A liability to repurchase shares",
          "Recorded at par value"
        ],
        "correct": 1,
        "explanation": "Treasury stock is a contra-equity account, reducing total stockholders'' equity. Recorded at cost."
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "applied",
        "question": "When a bond premium is amortized, interest expense is greater than the cash interest paid.",
        "correct": false,
        "explanation": "FALSE. Premium amortization REDUCES interest expense below cash paid. Discount amortization increases expense above cash."
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
-- Activity 8.13: Comprehensive Liabilities & Equity Case
-- Primary Skill: liab-bonds, eq-components
-- ============================================
(
  'fa800000-0000-0000-0008-000000000013',
  'fa000000-0000-0000-0000-000000000008',
  '8.13',
  13,
  'Comprehensive Liabilities & Equity Case',
  'comprehensive-liabilities-equity-case',
  'interactive',
  22,
  55,
  'basic',
  '{
    "title": "Financing Structure: Cascade Holdings",
    "description": "Analyze the complete financing structure of Cascade Holdings, including bonds and equity.",
    "company_background": "Cascade Holdings is evaluating its capital structure. Review bonds and equity to understand the financing mix.",
    "financial_data": {
      "bonds_payable_face": 2000000,
      "bond_discount": 80000,
      "coupon_rate": 0.045,
      "years_remaining": 8,
      "common_stock_par": 500000,
      "shares_issued": 500000,
      "par_per_share": 1,
      "apic": 2500000,
      "retained_earnings": 1800000,
      "treasury_stock": 150000,
      "treasury_shares": 10000
    },
    "questions": [
      {
        "id": "cc1",
        "question": "Calculate the carrying value of bonds payable.",
        "answer_type": "numeric",
        "correct_answer": 1920000,
        "tolerance": 100,
        "explanation": "Carrying Value = 2,000,000 - 80,000 = CHF 1,920,000"
      },
      {
        "id": "cc2",
        "question": "Calculate annual cash interest on bonds.",
        "answer_type": "numeric",
        "correct_answer": 90000,
        "tolerance": 100,
        "explanation": "Cash Interest = 2,000,000 x 4.5% = CHF 90,000"
      },
      {
        "id": "cc3",
        "question": "Calculate annual discount amortization.",
        "answer_type": "numeric",
        "correct_answer": 10000,
        "tolerance": 100,
        "explanation": "Amortization = 80,000 / 8 years = CHF 10,000"
      },
      {
        "id": "cc4",
        "question": "Calculate annual interest expense.",
        "answer_type": "numeric",
        "correct_answer": 100000,
        "tolerance": 100,
        "hint": "Cash Interest + Discount Amortization",
        "explanation": "Interest Expense = 90,000 + 10,000 = CHF 100,000"
      },
      {
        "id": "cc5",
        "question": "Calculate shares outstanding.",
        "answer_type": "numeric",
        "correct_answer": 490000,
        "tolerance": 100,
        "explanation": "Outstanding = 500,000 issued - 10,000 treasury = 490,000"
      },
      {
        "id": "cc6",
        "question": "Calculate total stockholders'' equity.",
        "answer_type": "numeric",
        "correct_answer": 4650000,
        "tolerance": 500,
        "explanation": "Equity = 500,000 + 2,500,000 + 1,800,000 - 150,000 = CHF 4,650,000"
      },
      {
        "id": "cc7",
        "question": "Calculate book value per share (outstanding).",
        "answer_type": "numeric",
        "correct_answer": 9.49,
        "tolerance": 0.1,
        "explanation": "Book Value = 4,650,000 / 490,000 = CHF 9.49"
      },
      {
        "id": "cc8",
        "question": "Calculate debt-to-equity ratio using bond carrying value.",
        "answer_type": "numeric",
        "correct_answer": 0.41,
        "tolerance": 0.02,
        "explanation": "D/E = 1,920,000 / 4,650,000 = 0.41"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'capital-structure-analyzer',
  false,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;

-- ============================================
-- ADD SKILL TAGS FOR NEW MODULE 8 ACTIVITIES
-- Using correct skill IDs:
-- bs-noncurrent-liabilities = b0000000-0000-0000-0002-000000000004
-- bs-owners-equity = b0000000-0000-0000-0002-000000000005
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 8.6 Advanced Bond Accounting (bs-noncurrent-liabilities)
('fa800000-0000-0000-0008-000000000006', 'b0000000-0000-0000-0002-000000000004', 1.0, true),

-- 8.7 Bond Amortization Practice (bs-noncurrent-liabilities)
('fa800000-0000-0000-0008-000000000007', 'b0000000-0000-0000-0002-000000000004', 1.0, true),

-- 8.8 Contingent Liabilities (bs-noncurrent-liabilities)
('fa800000-0000-0000-0008-000000000008', 'b0000000-0000-0000-0002-000000000004', 1.0, true),

-- 8.9 Contingent Liabilities Practice (bs-noncurrent-liabilities)
('fa800000-0000-0000-0008-000000000009', 'b0000000-0000-0000-0002-000000000004', 1.0, true),

-- 8.10 Stockholders Equity Components (bs-owners-equity)
('fa800000-0000-0000-0008-000000000010', 'b0000000-0000-0000-0002-000000000005', 1.0, true),

-- 8.11 Equity Transactions Practice (bs-owners-equity)
('fa800000-0000-0000-0008-000000000011', 'b0000000-0000-0000-0002-000000000005', 1.0, true),

-- 8.12 Liabilities and Equity Quiz (multiple skills)
('fa800000-0000-0000-0008-000000000012', 'b0000000-0000-0000-0002-000000000004', 0.5, true),
('fa800000-0000-0000-0008-000000000012', 'b0000000-0000-0000-0002-000000000005', 0.5, false),

-- 8.13 Comprehensive Case (multiple skills)
('fa800000-0000-0000-0008-000000000013', 'b0000000-0000-0000-0002-000000000004', 0.6, true),
('fa800000-0000-0000-0008-000000000013', 'b0000000-0000-0000-0002-000000000005', 0.6, false)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

