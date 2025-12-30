-- ============================================
-- Module 4: Period-End Adjustments
-- GOLD STANDARD Content - Accruals, Deferrals, Depreciation
-- Inspired by Bushwood, Playa, Cunningham cases (anonymized)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 4.1: Introduction to Adjusting Entries
-- ============================================
(
  'fa400000-0000-0000-0004-000000000001',
  'fa000000-0000-0000-0000-000000000004',
  '4.1',
  1,
  'Introduction to Adjusting Entries',
  'introduction-adjusting-entries',
  'lesson',
  15,
  25,
  'basic',
  '{"markdown": "# Introduction to Adjusting Entries\n\n## Why This Matters\n\nImagine you pay CHF 12,000 for a year of insurance on January 1. If you don''t adjust, your January income statement shows a CHF 12,000 expense - but you''ve really only \"used\" one month worth (CHF 1,000).\n\n**Adjusting entries** ensure that revenues and expenses are recorded in the correct period, making financial statements accurate.\n\n---\n\n## What Are Adjusting Entries?\n\n> **Adjusting Entries** are journal entries made at the end of an accounting period to update account balances before preparing financial statements.\n\n### Why They''re Necessary\n\n1. Some transactions span multiple periods (rent, insurance)\n2. Some revenues/expenses occur without a triggering transaction (depreciation, interest accrual)\n3. Cash movements don''t always align with when revenues are earned or expenses incurred\n\n---\n\n## The Four Types of Adjustments\n\n```\n              ADJUSTING ENTRIES\n                    |\n        ------------------------\n        |                      |\n    DEFERRALS              ACCRUALS\n    (Cash first)           (Cash later)\n        |                      |\n    ---------              ---------\n    |       |              |       |\n  Prepaid  Unearned     Accrued  Accrued\n  Expenses Revenue      Expenses Revenue\n```\n\n---\n\n## Type 1: Prepaid Expenses (Deferred Expenses)\n\n### Definition\n\nExpenses paid in ADVANCE - cash goes out before the expense is incurred.\n\n### Examples\n\n- Prepaid rent (paid 3 months upfront)\n- Prepaid insurance (annual policy paid in advance)\n- Prepaid advertising (campaign paid before it runs)\n- Supplies (purchased but not yet used)\n\n### The Adjustment Pattern\n\n**Original Entry (when paid):**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Prepaid Expense (Asset) | X | |\n| Cash | | X |\n\n**Adjusting Entry (when used/consumed):**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Expense | X | |\n| Prepaid Expense (Asset) | | X |\n\n### Example: Coastal Resorts Prepaid Insurance\n\nOn January 1, Coastal Resorts pays CHF 24,000 for a 12-month insurance policy.\n\n**January 1 - Payment:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Prepaid Insurance | 24,000 | |\n| Cash | | 24,000 |\n\n**January 31 - Adjusting Entry:**\n\nOne month has passed: CHF 24,000 / 12 = CHF 2,000 expired\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Insurance Expense | 2,000 | |\n| Prepaid Insurance | | 2,000 |\n\n**After adjustment:**\n- Prepaid Insurance (Asset) = CHF 22,000 (11 months remaining)\n- Insurance Expense = CHF 2,000 (1 month used)\n\n---\n\n## Type 2: Unearned Revenue (Deferred Revenue)\n\n### Definition\n\nRevenue received in ADVANCE - cash comes in before the revenue is earned.\n\n### Examples\n\n- Rent received in advance from tenants\n- Magazine subscriptions paid upfront\n- Gift cards sold but not yet redeemed\n- Advance deposits for hotel bookings\n\n### The Adjustment Pattern\n\n**Original Entry (when received):**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | X | |\n| Unearned Revenue (Liability) | | X |\n\n**Adjusting Entry (when earned):**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Unearned Revenue (Liability) | X | |\n| Revenue | | X |\n\n### Example: Summit Consulting Retainer\n\nOn December 1, Summit Consulting receives CHF 9,000 for 3 months of consulting services.\n\n**December 1 - Receipt:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 9,000 | |\n| Unearned Consulting Revenue | | 9,000 |\n\n**December 31 - Adjusting Entry:**\n\nOne month of service provided: CHF 9,000 / 3 = CHF 3,000 earned\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Unearned Consulting Revenue | 3,000 | |\n| Consulting Revenue | | 3,000 |\n\n**After adjustment:**\n- Unearned Revenue (Liability) = CHF 6,000 (2 months still owed)\n- Consulting Revenue = CHF 3,000 (1 month earned)\n\n---\n\n## Type 3: Accrued Expenses\n\n### Definition\n\nExpenses INCURRED but not yet paid - the expense happens before cash goes out.\n\n### Examples\n\n- Wages earned by employees but not yet paid\n- Interest on loans that accumulates daily\n- Utilities used but not yet billed\n- Rent owed but not yet paid\n\n### The Adjustment Pattern\n\n**Adjusting Entry (expense incurred, not paid):**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Expense | X | |\n| Payable (Liability) | | X |\n\n**Later (when paid):**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Payable (Liability) | X | |\n| Cash | | X |\n\n### Example: Metro Properties Wages\n\nMetro Properties pays employees on the 5th of each month for work in the prior month. On December 31, employees have earned CHF 15,000 that won''t be paid until January 5.\n\n**December 31 - Adjusting Entry:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Wages Expense | 15,000 | |\n| Wages Payable | | 15,000 |\n\n**January 5 - Payment:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Wages Payable | 15,000 | |\n| Cash | | 15,000 |\n\n---\n\n## Type 4: Accrued Revenue\n\n### Definition\n\nRevenue EARNED but not yet received - the revenue is earned before cash comes in.\n\n### Examples\n\n- Services performed but not yet billed\n- Interest earned on investments\n- Rent due from tenants but not yet collected\n- Commissions earned but not yet paid\n\n### The Adjustment Pattern\n\n**Adjusting Entry (revenue earned, not received):**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Receivable (Asset) | X | |\n| Revenue | | X |\n\n**Later (when received):**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | X | |\n| Receivable (Asset) | | X |\n\n### Example: Nova Energy Interest\n\nNova Energy has a CHF 100,000 investment earning 6% annual interest. Interest is received semi-annually. By December 31, 3 months of interest has accrued.\n\n**December 31 - Adjusting Entry:**\n\nInterest = CHF 100,000 x 6% x 3/12 = CHF 1,500\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Interest Receivable | 1,500 | |\n| Interest Revenue | | 1,500 |\n\n---\n\n## Summary Table\n\n| Type | Cash Timing | Before Adjustment | Adjusting Entry |\n|------|-------------|-------------------|------------------|\n| **Prepaid Expense** | Cash first | Asset overstated | Dr Expense, Cr Asset |\n| **Unearned Revenue** | Cash first | Liability overstated | Dr Liability, Cr Revenue |\n| **Accrued Expense** | Cash later | Expense understated | Dr Expense, Cr Liability |\n| **Accrued Revenue** | Cash later | Revenue understated | Dr Asset, Cr Revenue |\n\n---\n\n## Common Mistakes\n\n### Mistake 1: Forgetting to adjust\nWithout adjustments, financial statements will be incorrect.\n\n### Mistake 2: Adjusting the wrong direction\nPrepaid expenses are reduced (credit), not increased when time passes.\n\n### Mistake 3: Wrong time calculation\nCarefully calculate the portion of time that applies to the current period.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Deferrals = Cash first (prepaids, unearned)\n> - Accruals = Cash later (accrued expenses, accrued revenues)\n> - Adjusting entries always involve one balance sheet and one income statement account\n> - Never involve Cash in an adjusting entry\n> - Calculate time proportions carefully"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.2: Depreciation Fundamentals
-- ============================================
(
  'fa400000-0000-0000-0004-000000000002',
  'fa000000-0000-0000-0000-000000000004',
  '4.2',
  2,
  'Depreciation Fundamentals',
  'depreciation-fundamentals',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Depreciation Fundamentals\n\n## Why This Matters\n\nWhen a company buys equipment for CHF 100,000 that will last 10 years, should the entire cost be an expense in year 1? No! **Depreciation** allocates the cost over the asset''s useful life, matching the expense to the periods that benefit.\n\n---\n\n## What is Depreciation?\n\n> **Depreciation** is the systematic allocation of a tangible long-lived asset''s cost over its useful life.\n\n### Key Terms\n\n| Term | Definition |\n|------|------------|\n| **Cost** | Original purchase price plus all costs to prepare for use |\n| **Useful Life** | Estimated period the asset will be used |\n| **Residual Value** | Estimated value at end of useful life (also called salvage value) |\n| **Depreciable Amount** | Cost minus Residual Value |\n\n---\n\n## The Depreciation Formula (Straight-Line)\n\n```\nAnnual Depreciation = (Cost - Residual Value) / Useful Life\n```\n\n### Example\n\nCost: CHF 100,000\nResidual Value: CHF 10,000\nUseful Life: 10 years\n\nAnnual Depreciation = (100,000 - 10,000) / 10 = CHF 9,000/year\n\n---\n\n## Recording Depreciation\n\n### The Adjusting Entry\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Depreciation Expense | X | |\n| Accumulated Depreciation | | X |\n\n### Understanding Accumulated Depreciation\n\n- **Contra-asset account** - reduces the asset''s book value\n- Increases over time as more depreciation is recorded\n- Shown on balance sheet as a deduction from the asset\n\n### Book Value (Carrying Amount)\n\n```\nBook Value = Cost - Accumulated Depreciation\n```\n\n### Example Timeline\n\nEquipment purchased January 1, Year 1 for CHF 50,000\n- Useful life: 5 years\n- Residual value: CHF 5,000\n- Annual depreciation: (50,000 - 5,000) / 5 = CHF 9,000\n\n| End of Year | Depreciation Expense | Accumulated Depreciation | Book Value |\n|-------------|---------------------|--------------------------|------------|\n| Year 1 | 9,000 | 9,000 | 41,000 |\n| Year 2 | 9,000 | 18,000 | 32,000 |\n| Year 3 | 9,000 | 27,000 | 23,000 |\n| Year 4 | 9,000 | 36,000 | 14,000 |\n| Year 5 | 9,000 | 45,000 | 5,000 |\n\nNote: Book value at end of useful life equals residual value.\n\n---\n\n## Partial-Year Depreciation\n\nIf an asset is purchased mid-year, depreciate only for the months owned.\n\n### Example: Mid-Year Purchase\n\nEquipment purchased April 1:\n- Cost: CHF 24,000\n- Residual: CHF 0\n- Life: 4 years\n- Annual depreciation: 24,000 / 4 = CHF 6,000\n\nYear 1 depreciation (April - December = 9 months):\n6,000 x 9/12 = CHF 4,500\n\n---\n\n## What CAN and CANNOT be Depreciated\n\n### Depreciated\n\n| Asset | Why |\n|-------|-----|\n| Buildings | Have finite useful life |\n| Equipment | Wears out over time |\n| Vehicles | Limited useful life |\n| Furniture | Deteriorates with use |\n| Leasehold improvements | Benefit limited by lease term |\n\n### NOT Depreciated\n\n| Asset | Why |\n|-------|-----|\n| Land | Does not wear out |\n| Intangible assets | Amortized instead |\n| Inventory | Expensed as COGS when sold |\n| Investments | Not used in operations |\n\n---\n\n## Balance Sheet Presentation\n\n```\nProperty, Plant & Equipment:\n  Equipment, at cost             CHF 100,000\n  Less: Accumulated Depreciation     (27,000)\n                                 -----------\n  Equipment, net                  CHF 73,000\n```\n\n---\n\n## Why Use a Contra Account?\n\n### Benefits of Accumulated Depreciation\n\n1. **Preserves original cost** - Users can see what was paid\n2. **Shows depreciation taken** - Indicates how much has been allocated\n3. **Reveals book value** - Current carrying amount is clear\n4. **Historical record** - Tracks the asset''s entire life\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Depreciation allocates cost over useful life (matching principle)\n> - Straight-Line: (Cost - Residual) / Useful Life\n> - Accumulated Depreciation is a contra-asset (credit balance)\n> - Book Value = Cost - Accumulated Depreciation\n> - Land is NEVER depreciated\n> - Partial-year: prorate for months owned"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.3: Adjusting Entries Quiz
-- ============================================
(
  'fa400000-0000-0000-0004-000000000003',
  'fa000000-0000-0000-0000-000000000004',
  '4.3',
  3,
  'Adjusting Entries Quiz',
  'adjusting-entries-quiz',
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
        "question": "Which type of adjustment is required when a company pays rent in advance?",
        "options": [
          "Accrued expense",
          "Accrued revenue",
          "Prepaid expense (deferred expense)",
          "Unearned revenue"
        ],
        "correct": 2,
        "explanation": "Rent paid in advance is a prepaid expense. The company has an asset (prepaid rent) that becomes an expense as time passes."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "When a company receives cash for services NOT YET performed, they should initially record:",
        "options": [
          "Service Revenue",
          "Unearned Revenue (a liability)",
          "Accounts Receivable",
          "Prepaid Services"
        ],
        "correct": 1,
        "explanation": "Cash received before earning it creates a liability (Unearned Revenue). The company owes the customer the service."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Depreciation expense is recorded by:",
        "options": [
          "Debiting Equipment and crediting Cash",
          "Debiting Depreciation Expense and crediting Equipment",
          "Debiting Depreciation Expense and crediting Accumulated Depreciation",
          "Debiting Accumulated Depreciation and crediting Cash"
        ],
        "correct": 2,
        "explanation": "The adjusting entry for depreciation debits Depreciation Expense (income statement) and credits Accumulated Depreciation (contra-asset on balance sheet). Cash is never involved."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "On November 1, Coastal Resorts pays CHF 18,000 for 6 months of insurance (Nov-Apr). What is the adjusting entry on December 31?",
        "options": [
          "Debit Insurance Expense CHF 6,000; Credit Prepaid Insurance CHF 6,000",
          "Debit Insurance Expense CHF 3,000; Credit Prepaid Insurance CHF 3,000",
          "Debit Insurance Expense CHF 18,000; Credit Cash CHF 18,000",
          "Debit Prepaid Insurance CHF 12,000; Credit Insurance Expense CHF 12,000"
        ],
        "correct": 0,
        "explanation": "2 months have passed (Nov, Dec) out of 6 months. Expense = 18,000 x 2/6 = CHF 6,000. Debit Insurance Expense, Credit Prepaid Insurance."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Equipment costing CHF 80,000 with a residual value of CHF 8,000 has a useful life of 6 years. What is the annual straight-line depreciation?",
        "options": [
          "CHF 13,333",
          "CHF 12,000",
          "CHF 8,000",
          "CHF 80,000"
        ],
        "correct": 1,
        "explanation": "Depreciation = (Cost - Residual) / Life = (80,000 - 8,000) / 6 = 72,000 / 6 = CHF 12,000 per year."
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Adjusting entries never involve the Cash account.",
        "correct": true,
        "explanation": "TRUE. Adjusting entries correct timing differences - they never involve Cash because the cash transaction either already happened (deferrals) or hasn''t happened yet (accruals)."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "On December 31, Metro Properties owes employees CHF 25,000 for work performed in December. Payday is January 5. What is the December 31 adjusting entry?",
        "options": [
          "Debit Cash CHF 25,000; Credit Wages Expense CHF 25,000",
          "Debit Wages Expense CHF 25,000; Credit Wages Payable CHF 25,000",
          "Debit Wages Payable CHF 25,000; Credit Cash CHF 25,000",
          "No entry needed until payment is made"
        ],
        "correct": 1,
        "explanation": "This is an accrued expense - expense incurred but not yet paid. Debit Wages Expense (to record the expense), Credit Wages Payable (to record the liability)."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Summit Consulting receives CHF 36,000 on October 1 for a 12-month service contract. How much Unearned Revenue remains on December 31?",
        "options": [
          "CHF 36,000",
          "CHF 27,000",
          "CHF 9,000",
          "CHF 0"
        ],
        "correct": 1,
        "explanation": "3 months earned (Oct, Nov, Dec) out of 12 = CHF 9,000 earned. Remaining Unearned Revenue = 36,000 - 9,000 = CHF 27,000."
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Nova Energy has CHF 200,000 in loans at 9% annual interest. Interest is paid quarterly. By December 31, 2 months of interest has accrued since the last payment. What is the adjusting entry amount?",
        "options": [
          "CHF 18,000",
          "CHF 3,000",
          "CHF 4,500",
          "CHF 1,500"
        ],
        "correct": 1,
        "explanation": "Interest accrued = Principal x Rate x Time = 200,000 x 9% x 2/12 = 200,000 x 0.09 x 0.167 = CHF 3,000."
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "An asset was purchased on April 1 for CHF 60,000 with no residual value and a 5-year life. What is the depreciation expense for the first calendar year (ending Dec 31)?",
        "options": [
          "CHF 12,000",
          "CHF 9,000",
          "CHF 3,000",
          "CHF 15,000"
        ],
        "correct": 1,
        "explanation": "Annual depreciation = 60,000 / 5 = CHF 12,000. First year: 9 months (Apr-Dec) = 12,000 x 9/12 = CHF 9,000."
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
-- Activity 4.4: Case Study - Coastal Resorts Adjustments
-- ============================================
(
  'fa400000-0000-0000-0004-000000000004',
  'fa000000-0000-0000-0000-000000000004',
  '4.4',
  4,
  'Case Study: Coastal Resorts Adjustments',
  'case-study-coastal-resorts',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Coastal Resorts Year-End Adjustments",
    "description": "Coastal Resorts is a beachfront hotel property. Prepare the adjusting entries for December 31, Year 1.",
    "company_background": "Coastal Resorts operates a 200-room luxury hotel on the Mediterranean coast. The fiscal year ends December 31. The bookkeeper has prepared the unadjusted trial balance, and you need to record the necessary adjusting entries.",
    "unadjusted_balances": {
      "Cash": 85000,
      "Accounts Receivable": 42000,
      "Prepaid Insurance": 36000,
      "Supplies": 8500,
      "Equipment": 450000,
      "Accumulated Depreciation": 90000,
      "Accounts Payable": 28000,
      "Unearned Room Revenue": 24000,
      "Notes Payable": 200000,
      "Share Capital": 150000,
      "Retained Earnings": 75000,
      "Room Revenue": 380000,
      "Wages Expense": 180000,
      "Utilities Expense": 45000,
      "Other Expenses": 101500
    },
    "adjustment_info": [
      {
        "id": "adj1",
        "description": "The prepaid insurance balance represents a 24-month policy purchased on January 1 of the current year. 12 months have now expired.",
        "type": "prepaid_expense",
        "solution": {
          "debit_account": "Insurance Expense",
          "debit_amount": 18000,
          "credit_account": "Prepaid Insurance",
          "credit_amount": 18000
        },
        "calculation": "36,000 / 24 months x 12 months = CHF 18,000 expired"
      },
      {
        "id": "adj2",
        "description": "A physical count shows CHF 2,500 of supplies remaining. The rest have been used.",
        "type": "prepaid_expense",
        "solution": {
          "debit_account": "Supplies Expense",
          "debit_amount": 6000,
          "credit_account": "Supplies",
          "credit_amount": 6000
        },
        "calculation": "8,500 beginning - 2,500 ending = CHF 6,000 used"
      },
      {
        "id": "adj3",
        "description": "Equipment is depreciated straight-line over 10 years with no residual value. (Cost = CHF 450,000)",
        "type": "depreciation",
        "solution": {
          "debit_account": "Depreciation Expense",
          "debit_amount": 45000,
          "credit_account": "Accumulated Depreciation",
          "credit_amount": 45000
        },
        "calculation": "450,000 / 10 years = CHF 45,000 annual depreciation"
      },
      {
        "id": "adj4",
        "description": "The unearned room revenue represents advance bookings. By December 31, CHF 16,000 of these stays have been completed.",
        "type": "unearned_revenue",
        "solution": {
          "debit_account": "Unearned Room Revenue",
          "debit_amount": 16000,
          "credit_account": "Room Revenue",
          "credit_amount": 16000
        },
        "calculation": "CHF 16,000 of advances have been earned (stays completed)"
      },
      {
        "id": "adj5",
        "description": "Employees have earned CHF 12,000 in wages for the last week of December that will be paid on January 5.",
        "type": "accrued_expense",
        "solution": {
          "debit_account": "Wages Expense",
          "debit_amount": 12000,
          "credit_account": "Wages Payable",
          "credit_amount": 12000
        },
        "calculation": "Work performed but not yet paid = CHF 12,000 accrued"
      },
      {
        "id": "adj6",
        "description": "The notes payable carries 6% annual interest. Interest is paid quarterly. Two months of interest has accrued since the last payment.",
        "type": "accrued_expense",
        "solution": {
          "debit_account": "Interest Expense",
          "debit_amount": 2000,
          "credit_account": "Interest Payable",
          "credit_amount": 2000
        },
        "calculation": "200,000 x 6% x 2/12 = CHF 2,000 interest accrued"
      }
    ],
    "adjusted_trial_balance_check": {
      "total_debits": 856000,
      "total_credits": 856000,
      "net_income_after_adjustments": 92000
    },
    "passing_score": 100
  }'::jsonb,
  'adjusting-entries-builder',
  false,
  true
),

-- ============================================
-- Activity 4.5: Case Study - Summit Consulting
-- ============================================
(
  'fa400000-0000-0000-0004-000000000005',
  'fa000000-0000-0000-0000-000000000004',
  '4.5',
  5,
  'Case Study: Summit Consulting',
  'case-study-summit-consulting',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Summit Consulting December Adjustments",
    "description": "Summit Consulting provides business advisory services. Complete the adjusting entries and calculate the adjusted net income.",
    "company_background": "Summit Consulting is a boutique consulting firm in Geneva specializing in strategy and operations. The company was founded 3 years ago and has grown steadily. They use the calendar year for financial reporting.",
    "unadjusted_trial_balance": {
      "Cash": 45000,
      "Accounts Receivable": 68000,
      "Prepaid Rent": 30000,
      "Office Equipment": 85000,
      "Accumulated Depreciation - Equipment": 17000,
      "Accounts Payable": 15000,
      "Unearned Consulting Revenue": 42000,
      "Share Capital": 50000,
      "Retained Earnings": 35000,
      "Consulting Revenue": 185000,
      "Salaries Expense": 95000,
      "Utilities Expense": 12000,
      "Office Expense": 9000
    },
    "additional_information": [
      {
        "id": "info1",
        "description": "Prepaid rent represents 6 months paid on October 1 (Oct-Mar). By December 31, 3 months have been used.",
        "adjustment": {
          "type": "prepaid_expense",
          "amount": 15000,
          "debit": "Rent Expense",
          "credit": "Prepaid Rent"
        }
      },
      {
        "id": "info2",
        "description": "Office equipment is depreciated over 5 years straight-line with no residual value.",
        "adjustment": {
          "type": "depreciation",
          "amount": 17000,
          "debit": "Depreciation Expense",
          "credit": "Accumulated Depreciation - Equipment"
        }
      },
      {
        "id": "info3",
        "description": "By December 31, CHF 28,000 of the unearned consulting revenue has been earned (projects completed).",
        "adjustment": {
          "type": "unearned_revenue",
          "amount": 28000,
          "debit": "Unearned Consulting Revenue",
          "credit": "Consulting Revenue"
        }
      },
      {
        "id": "info4",
        "description": "A consulting project was completed in late December worth CHF 15,000 but not yet billed to the client.",
        "adjustment": {
          "type": "accrued_revenue",
          "amount": 15000,
          "debit": "Accounts Receivable",
          "credit": "Consulting Revenue"
        }
      },
      {
        "id": "info5",
        "description": "Salaries of CHF 8,000 have been earned by employees but will not be paid until January 3.",
        "adjustment": {
          "type": "accrued_expense",
          "amount": 8000,
          "debit": "Salaries Expense",
          "credit": "Salaries Payable"
        }
      }
    ],
    "solution_summary": {
      "adjusted_revenue": 228000,
      "adjusted_expenses": 156000,
      "adjusted_net_income": 72000
    },
    "passing_score": 100
  }'::jsonb,
  'adjusting-entries-builder',
  false,
  true
),

-- ============================================
-- Activity 4.6: Adjusted Trial Balance
-- ============================================
(
  'fa400000-0000-0000-0004-000000000006',
  'fa000000-0000-0000-0000-000000000004',
  '4.6',
  6,
  'The Adjusted Trial Balance',
  'adjusted-trial-balance',
  'lesson',
  10,
  20,
  'basic',
  '{"markdown": "# The Adjusted Trial Balance\n\n## Why This Matters\n\nAfter recording all adjusting entries, we need to verify that debits still equal credits and prepare for financial statement creation. The adjusted trial balance is this verification step.\n\n---\n\n## What is an Adjusted Trial Balance?\n\n> The **Adjusted Trial Balance** is a list of all account balances AFTER adjusting entries have been posted.\n\n### Purpose\n\n1. Verify debits = credits after adjustments\n2. Provide the numbers for financial statements\n3. Serve as the final checkpoint before financial statements\n\n---\n\n## The Process\n\n```\n  UNADJUSTED TRIAL BALANCE\n            |\n            v\n    ADJUSTING ENTRIES\n            |\n            v\n  ADJUSTED TRIAL BALANCE\n            |\n            v\n   FINANCIAL STATEMENTS\n```\n\n---\n\n## Example: Coastal Resorts\n\nAfter the adjusting entries from our case study:\n\n```\n           COASTAL RESORTS\n         ADJUSTED TRIAL BALANCE\n           December 31, Year 1\n\n                                 Debit      Credit\n                               --------    --------\nCash                            85,000\nAccounts Receivable             42,000\nPrepaid Insurance               18,000\nSupplies                         2,500\nEquipment                      450,000\nAccumulated Depreciation                   135,000\nAccounts Payable                            28,000\nWages Payable                               12,000\nInterest Payable                             2,000\nUnearned Room Revenue                        8,000\nNotes Payable                              200,000\nShare Capital                              150,000\nRetained Earnings                           75,000\nRoom Revenue                               396,000\nWages Expense                  192,000\nUtilities Expense               45,000\nSupplies Expense                 6,000\nInsurance Expense               18,000\nDepreciation Expense            45,000\nInterest Expense                 2,000\nOther Expenses                 101,500\n                               --------    --------\n                             1,006,000   1,006,000\n```\n\n---\n\n## From Trial Balance to Financial Statements\n\n### Step 1: Income Statement\n\nUse Revenue and Expense accounts:\n\n```\n             COASTAL RESORTS\n             INCOME STATEMENT\n     For the Year Ended December 31\n\nRevenue:\n  Room Revenue                     CHF 396,000\n\nExpenses:\n  Wages Expense          192,000\n  Utilities Expense       45,000\n  Supplies Expense         6,000\n  Insurance Expense       18,000\n  Depreciation Expense    45,000\n  Interest Expense         2,000\n  Other Expenses         101,500\n  Total Expenses                      409,500\n                                   ----------\nNet Loss                          CHF (13,500)\n```\n\n### Step 2: Statement of Changes in Equity\n\n```\n        STATEMENT OF CHANGES IN EQUITY\n     For the Year Ended December 31\n\nBeginning Retained Earnings    CHF  75,000\nAdd: Net Income (Loss)             (13,500)\nLess: Dividends                          0\n                               ----------\nEnding Retained Earnings       CHF  61,500\n```\n\n### Step 3: Balance Sheet\n\nUse Asset, Liability, and Equity accounts with updated Retained Earnings.\n\n---\n\n## Common Errors\n\n### Error 1: Trial balance doesn''t balance\n\n**Causes:**\n- Adjusting entry had unequal debits and credits\n- Calculation error when posting\n- Missed an adjustment\n\n### Error 2: Forgetting to adjust accumulated depreciation\n\nRemember: Accumulated Depreciation is cumulative. Add this year''s depreciation to prior balance.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Adjusted Trial Balance = After all adjusting entries\n> - Must balance (Total Debits = Total Credits)\n> - Used to prepare financial statements\n> - Revenue and Expense accounts go to Income Statement\n> - Asset, Liability, and Equity accounts go to Balance Sheet\n> - Net Income updates Retained Earnings"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.7: Module 4 Checkpoint
-- ============================================
(
  'fa400000-0000-0000-0004-000000000007',
  'fa000000-0000-0000-0000-000000000004',
  '4.7',
  7,
  'Module 4 Checkpoint',
  'module-4-checkpoint',
  'checkpoint',
  18,
  60,
  'basic',
  '{
    "questions": [
      {
        "id": "c1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Coastal Resorts pays CHF 48,000 on March 1 for a 24-month insurance policy. What is the adjusting entry on December 31 of the same year?",
        "options": [
          "Debit Insurance Expense CHF 20,000; Credit Prepaid Insurance CHF 20,000",
          "Debit Insurance Expense CHF 28,000; Credit Prepaid Insurance CHF 28,000",
          "Debit Prepaid Insurance CHF 28,000; Credit Insurance Expense CHF 28,000",
          "Debit Insurance Expense CHF 48,000; Credit Cash CHF 48,000"
        ],
        "correct": 0,
        "explanation": "10 months have passed (March-December). Monthly expense = 48,000 / 24 = CHF 2,000. 10 months x 2,000 = CHF 20,000 expired."
      },
      {
        "id": "c2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Summit Consulting has office equipment costing CHF 120,000 with a CHF 12,000 residual value and an 8-year useful life. The equipment was purchased on July 1. What is the depreciation expense for the first calendar year?",
        "options": [
          "CHF 13,500",
          "CHF 6,750",
          "CHF 15,000",
          "CHF 7,500"
        ],
        "correct": 1,
        "explanation": "Annual depreciation = (120,000 - 12,000) / 8 = CHF 13,500. First year: 6 months (July-December) = 13,500 x 6/12 = CHF 6,750."
      },
      {
        "id": "c3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company has Unearned Revenue of CHF 30,000 at year start. During the year, they receive CHF 45,000 in advance and earn CHF 50,000 of previously unearned revenue. What is ending Unearned Revenue?",
        "options": [
          "CHF 25,000",
          "CHF 35,000",
          "CHF 45,000",
          "CHF 50,000"
        ],
        "correct": 0,
        "explanation": "Beginning 30,000 + Received 45,000 - Earned 50,000 = CHF 25,000 ending unearned revenue."
      },
      {
        "id": "c4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which of the following is an accrued expense?",
        "options": [
          "Rent paid in advance",
          "Supplies purchased for future use",
          "Wages earned by employees but not yet paid",
          "Magazine subscriptions received in advance"
        ],
        "correct": 2,
        "explanation": "Accrued expenses are incurred but not yet paid. Wages earned but unpaid is an accrued expense. The others are prepaid expenses or unearned revenue."
      },
      {
        "id": "c5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Metro Properties has a CHF 300,000 note payable at 8% interest. Interest is paid semi-annually on June 30 and December 31. On December 31, the adjusting entry for interest is:",
        "options": [
          "No entry needed - interest is paid on Dec 31",
          "Debit Interest Expense CHF 12,000; Credit Interest Payable CHF 12,000",
          "Debit Interest Expense CHF 24,000; Credit Interest Payable CHF 24,000",
          "Debit Interest Payable CHF 12,000; Credit Cash CHF 12,000"
        ],
        "correct": 0,
        "explanation": "If interest is paid on December 31, no accrual is needed - the payment entry records the expense. An adjusting entry would only be needed if interest had accrued since the last payment date."
      },
      {
        "id": "c6",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Accumulated Depreciation is a contra-asset account that normally has a credit balance.",
        "correct": true,
        "explanation": "TRUE. Accumulated Depreciation is a contra-asset account. It is credited when depreciation is recorded and accumulates over time. Its credit balance reduces the carrying amount of the related asset."
      },
      {
        "id": "c7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "At the end of the year, Nova Energy has performed CHF 18,000 of consulting work that has not yet been billed. The adjusting entry is:",
        "options": [
          "Debit Cash CHF 18,000; Credit Consulting Revenue CHF 18,000",
          "Debit Accounts Receivable CHF 18,000; Credit Consulting Revenue CHF 18,000",
          "Debit Consulting Revenue CHF 18,000; Credit Unearned Revenue CHF 18,000",
          "Debit Unearned Revenue CHF 18,000; Credit Consulting Revenue CHF 18,000"
        ],
        "correct": 1,
        "explanation": "This is accrued revenue - earned but not yet received/billed. Debit Accounts Receivable (asset), Credit Consulting Revenue."
      },
      {
        "id": "c8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "After recording adjusting entries, a company''s total debits in the adjusted trial balance are CHF 580,000 and total credits are CHF 575,000. This indicates:",
        "options": [
          "The company is profitable",
          "An error has occurred in the adjustments",
          "Net income is CHF 5,000",
          "Assets exceed liabilities by CHF 5,000"
        ],
        "correct": 1,
        "explanation": "The adjusted trial balance must balance (debits = credits). A difference of CHF 5,000 indicates an error in posting or calculating the adjustments."
      }
    ],
    "passing_score": 75,
    "show_explanations": true
  }'::jsonb,
  NULL,
  true,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;


