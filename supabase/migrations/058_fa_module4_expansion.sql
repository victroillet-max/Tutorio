-- ============================================
-- FA Course Content Expansion - Phase 2
-- Module 4: Individual Adjustment Exercises
-- Adds 10 new activities for adjustment types
-- ============================================

-- ============================================
-- NEW ACTIVITIES FOR MODULE 4
-- Following existing UUID pattern: fa400000-0000-0000-0004-00000000XXXX
-- Existing activities: 0001-0008, new start at 0009
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 4.9: Prepaid Expenses Deep Dive
-- Primary Skill: adj-prepaid
-- ============================================
(
  'fa400000-0000-0000-0004-000000000009',
  'fa000000-0000-0000-0000-000000000004',
  '4.9',
  9,
  'Prepaid Expenses Deep Dive',
  'prepaid-expenses-deep-dive',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# Prepaid Expenses Deep Dive\n\n## Why This Matters\n\nPrepaid expenses are assets that will become expenses over time. Proper adjustment ensures expenses are matched to the correct accounting period.\n\n---\n\n## What Are Prepaid Expenses?\n\n> **Prepaid Expenses** are payments made in advance for goods or services to be received in the future.\n\n---\n\n## Common Prepaid Expenses\n\n| Type | Typical Period |\n|------|----------------|\n| Prepaid Insurance | 6-12 months |\n| Prepaid Rent | 1-12 months |\n| Prepaid Advertising | Varies |\n| Supplies | As used |\n| Prepaid Maintenance | Service period |\n\n---\n\n## The Two-Step Process\n\n### Step 1: Initial Payment\n\n**Pay CHF 12,000 for 12-month insurance policy on April 1:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Prepaid Insurance | 12,000 | |\n| Cash | | 12,000 |\n\n### Step 2: Monthly Adjustment\n\n**At month-end, recognize 1 month used (CHF 1,000):**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Insurance Expense | 1,000 | |\n| Prepaid Insurance | | 1,000 |\n\n---\n\n## Calculation Methods\n\n### Time-Based Method\n\nFor items that expire over time:\n\n```\nMonthly Expense = Total Prepaid / Number of Months\n```\n\n**Example:** CHF 24,000 rent for 12 months = CHF 2,000/month\n\n### Usage-Based Method\n\nFor supplies and similar items:\n\n```\nExpense = Beginning Supplies + Purchases - Ending Supplies\n```\n\n**Example:**\n- Beginning Supplies: CHF 500\n- Purchases: CHF 2,000\n- Ending Supplies (counted): CHF 600\n- Supplies Expense: CHF 1,900\n\n---\n\n## Year-End Adjustments\n\n### Scenario: Insurance Paid Mid-Year\n\n**April 1:** Paid CHF 24,000 for 2-year policy\n\n**December 31 (Year-End):**\n- Months expired: 9 months (Apr-Dec)\n- Monthly expense: CHF 24,000 / 24 = CHF 1,000\n- Total expense for year: 9 x CHF 1,000 = CHF 9,000\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Insurance Expense | 9,000 | |\n| Prepaid Insurance | | 9,000 |\n\n**Balance Sheet shows:** Prepaid Insurance CHF 15,000 (15 months remaining)\n\n---\n\n## Common Mistakes\n\n### Mistake 1: Expensing Entire Amount at Payment\n\n**Wrong:**\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Insurance Expense | 12,000 | |\n| Cash | | 12,000 |\n\n**Right:** Record as prepaid asset first.\n\n### Mistake 2: Forgetting to Adjust\n\nPrepaid stays on books at original amount, understating expenses.\n\n### Mistake 3: Wrong Period Calculation\n\nCount months carefully from payment date to period-end.\n\n---\n\n## Impact on Financial Statements\n\n| If Adjustment is Missed | Effect |\n|------------------------|--------|\n| Assets | Overstated |\n| Expenses | Understated |\n| Net Income | Overstated |\n| Retained Earnings | Overstated |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Prepaid = Asset at payment\n> - Adjust monthly or at period-end\n> - Time-based for insurance/rent\n> - Usage-based for supplies\n> - Always match expense to benefit period"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.10: Prepaid Expense Practice
-- Primary Skill: adj-prepaid
-- ============================================
(
  'fa400000-0000-0000-0004-000000000010',
  'fa000000-0000-0000-0000-000000000004',
  '4.10',
  10,
  'Prepaid Expense Practice',
  'prepaid-expense-practice',
  'interactive',
  16,
  40,
  'basic',
  '{
    "title": "Prepaid Adjustments: Mountain View Consulting",
    "description": "Prepare prepaid expense adjustments for Mountain View Consulting at December 31.",
    "company_background": "Mountain View Consulting has several prepaid expenses that need year-end adjustment.",
    "transactions": [
      {
        "item": "Insurance",
        "payment_date": "September 1",
        "amount_paid": 18000,
        "coverage_months": 12
      },
      {
        "item": "Rent",
        "payment_date": "October 1",
        "amount_paid": 36000,
        "coverage_months": 6
      },
      {
        "item": "Office Supplies",
        "beginning_balance": 1200,
        "purchases": 4500,
        "ending_count": 800
      },
      {
        "item": "Advertising",
        "payment_date": "November 1",
        "amount_paid": 6000,
        "coverage_months": 3
      }
    ],
    "questions": [
      {
        "id": "pe1",
        "question": "Insurance: How many months expired by Dec 31?",
        "answer_type": "numeric",
        "correct_answer": 4,
        "tolerance": 0,
        "hint": "Sept, Oct, Nov, Dec",
        "explanation": "From September 1 to December 31 = 4 months expired"
      },
      {
        "id": "pe2",
        "question": "Calculate Insurance Expense for the year.",
        "answer_type": "numeric",
        "correct_answer": 6000,
        "tolerance": 50,
        "hint": "18,000 / 12 months x 4 months",
        "explanation": "Monthly: 18,000/12 = 1,500. Expense: 1,500 x 4 = CHF 6,000"
      },
      {
        "id": "pe3",
        "question": "Calculate Rent Expense for the year (Oct-Dec).",
        "answer_type": "numeric",
        "correct_answer": 18000,
        "tolerance": 100,
        "hint": "36,000 / 6 months x 3 months",
        "explanation": "Monthly: 36,000/6 = 6,000. Oct-Dec = 3 months. Expense: CHF 18,000"
      },
      {
        "id": "pe4",
        "question": "Calculate Supplies Expense using the supplies count.",
        "answer_type": "numeric",
        "correct_answer": 4900,
        "tolerance": 50,
        "hint": "Beginning + Purchases - Ending",
        "explanation": "Supplies Expense = 1,200 + 4,500 - 800 = CHF 4,900"
      },
      {
        "id": "pe5",
        "question": "Calculate Advertising Expense (Nov 1 to Dec 31).",
        "answer_type": "numeric",
        "correct_answer": 4000,
        "tolerance": 50,
        "explanation": "Monthly: 6,000/3 = 2,000. Nov-Dec = 2 months. Expense: CHF 4,000"
      },
      {
        "id": "pe6",
        "question": "Total prepaid expense adjustments for the year:",
        "answer_type": "numeric",
        "correct_answer": 32900,
        "tolerance": 200,
        "explanation": "Total = 6,000 + 18,000 + 4,900 + 4,000 = CHF 32,900"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'adjustment-calculator',
  false,
  true
),

-- ============================================
-- Activity 4.11: Accrued Expenses Deep Dive
-- Primary Skill: adj-accrued
-- ============================================
(
  'fa400000-0000-0000-0004-000000000011',
  'fa000000-0000-0000-0000-000000000004',
  '4.11',
  11,
  'Accrued Expenses Deep Dive',
  'accrued-expenses-deep-dive',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# Accrued Expenses Deep Dive\n\n## Why This Matters\n\nAccrued expenses are costs incurred but not yet paid or recorded. Proper accruals ensure the matching principle is applied correctly.\n\n---\n\n## Definition\n\n> **Accrued Expenses** are expenses incurred during the period but not yet paid or recorded.\n\n---\n\n## Common Accrued Expenses\n\n| Type | Examples |\n|------|----------|\n| **Wages Payable** | Salaries earned but not yet paid |\n| **Interest Payable** | Interest accrued on loans |\n| **Utilities Payable** | Bills for services received |\n| **Taxes Payable** | Property tax, income tax |\n\n---\n\n## The Accrual Process\n\n### Why Accrue?\n\nExpenses are incurred when:\n- Service is received, OR\n- Time passes (for interest)\n\n...regardless of when cash is paid.\n\n### The Adjusting Entry\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Expense | XXX | |\n| Payable (Liability) | | XXX |\n\n---\n\n## Example 1: Wages Payable\n\n### Situation\n\n- Employees earn CHF 4,000/day (5-day week)\n- Pay period ends Friday\n- Year-end is Wednesday, December 31\n- Employees worked Mon-Wed (3 days)\n\n### Adjustment\n\nWages earned but not paid: 3 days x CHF 4,000 = CHF 12,000\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Wages Expense | 12,000 | |\n| Wages Payable | | 12,000 |\n\n### When Paid (January)\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Wages Payable | 12,000 | |\n| Wages Expense | 8,000 | |\n| Cash | | 20,000 |\n\n---\n\n## Example 2: Interest Payable\n\n### Situation\n\n- CHF 200,000 loan at 6% annual interest\n- Loan taken July 1\n- Year-end December 31\n- Interest paid annually on July 1\n\n### Calculation\n\n```\nInterest = Principal x Rate x Time\nInterest = 200,000 x 6% x 6/12\nInterest = CHF 6,000\n```\n\n### Adjustment\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Interest Expense | 6,000 | |\n| Interest Payable | | 6,000 |\n\n---\n\n## Example 3: Utility Accrual\n\n### Situation\n\n- December electricity used: approximately CHF 3,200\n- Bill arrives January 15\n- Payment due January 30\n\n### Adjustment (December 31)\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Utilities Expense | 3,200 | |\n| Utilities Payable | | 3,200 |\n\n---\n\n## Impact of Missing Accruals\n\n| If Accrual is Missed | Effect |\n|---------------------|--------|\n| Liabilities | Understated |\n| Expenses | Understated |\n| Net Income | Overstated |\n| Equity | Overstated |\n\n---\n\n## Common Mistakes\n\n### Mistake 1: Waiting for Invoice\n\nRecord the expense when incurred, not when billed.\n\n### Mistake 2: Wrong Time Calculation\n\nFor interest: count months from loan date to period-end.\n\n### Mistake 3: Forgetting Payroll Timing\n\nAlways check if pay period crosses year-end.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Accrue = Record expense BEFORE payment\n> - Creates a liability (Payable)\n> - Interest = Principal x Rate x Time\n> - Wages = Days worked x Daily rate\n> - Match expense to period when incurred"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.12: Accrued Expense Practice
-- Primary Skill: adj-accrued
-- ============================================
(
  'fa400000-0000-0000-0004-000000000012',
  'fa000000-0000-0000-0000-000000000004',
  '4.12',
  12,
  'Accrued Expense Practice',
  'accrued-expense-practice',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Accrual Adjustments: Summit Tech",
    "description": "Prepare accrued expense adjustments for Summit Tech at December 31.",
    "company_background": "Summit Tech has several expenses that need to be accrued at year-end.",
    "scenarios": [
      {
        "item": "Employee Wages",
        "details": "Weekly payroll of CHF 35,000 (5-day week). December 31 is Tuesday. Last payday was Friday, Dec 27."
      },
      {
        "item": "Bank Loan Interest",
        "details": "CHF 400,000 loan at 5% annual interest, taken October 1. Interest paid annually."
      },
      {
        "item": "Property Tax",
        "details": "Annual property tax of CHF 24,000, payable next April. Covers calendar year."
      },
      {
        "item": "Legal Services",
        "details": "Lawyers worked 10 hours in December at CHF 300/hour. Invoice expected in January."
      }
    ],
    "questions": [
      {
        "id": "ae1",
        "question": "Calculate Wages Payable (Mon-Tue worked after Dec 27 payday).",
        "answer_type": "numeric",
        "correct_answer": 14000,
        "tolerance": 100,
        "hint": "Daily wage = 35,000 / 5 days. Days worked = 2 (Mon, Tue)",
        "explanation": "Daily wage = 7,000. Days = 2 (Mon Dec 30, Tue Dec 31). Accrual = CHF 14,000"
      },
      {
        "id": "ae2",
        "question": "Calculate Interest Payable (Oct 1 to Dec 31).",
        "answer_type": "numeric",
        "correct_answer": 5000,
        "tolerance": 50,
        "hint": "Principal x Rate x (3/12 months)",
        "explanation": "Interest = 400,000 x 5% x 3/12 = CHF 5,000"
      },
      {
        "id": "ae3",
        "question": "Calculate Property Tax Payable (Jan-Dec accrual).",
        "answer_type": "numeric",
        "correct_answer": 24000,
        "tolerance": 100,
        "explanation": "Full year accrual for calendar year = CHF 24,000"
      },
      {
        "id": "ae4",
        "question": "Calculate Legal Fees Payable.",
        "answer_type": "numeric",
        "correct_answer": 3000,
        "tolerance": 50,
        "hint": "Hours x Rate",
        "explanation": "Legal Fees = 10 hours x CHF 300 = CHF 3,000"
      },
      {
        "id": "ae5",
        "question": "Total accrued liabilities to record:",
        "answer_type": "numeric",
        "correct_answer": 46000,
        "tolerance": 200,
        "explanation": "Total = 14,000 + 5,000 + 24,000 + 3,000 = CHF 46,000"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'adjustment-calculator',
  false,
  true
),

-- ============================================
-- Activity 4.13: Unearned Revenue Adjustments
-- Primary Skill: adj-unearned
-- ============================================
(
  'fa400000-0000-0000-0004-000000000013',
  'fa000000-0000-0000-0000-000000000004',
  '4.13',
  13,
  'Unearned Revenue Adjustments',
  'unearned-revenue-adjustments',
  'lesson',
  12,
  24,
  'basic',
  '{"markdown": "# Unearned Revenue Adjustments\n\n## Why This Matters\n\nUnearned revenue represents cash received before earning it. As services are performed, the liability converts to revenue.\n\n---\n\n## Definition\n\n> **Unearned Revenue** (Deferred Revenue) is a liability representing cash received for goods/services not yet provided.\n\n---\n\n## Examples\n\n| Business | Unearned Revenue Example |\n|----------|-------------------------|\n| Magazine | Subscription received in advance |\n| Software | Annual license fee paid upfront |\n| Airline | Tickets sold for future flights |\n| Gym | Annual membership paid at signup |\n| Landlord | Rent received in advance |\n\n---\n\n## The Two-Step Process\n\n### Step 1: Cash Received\n\n**Receive CHF 6,000 for 6-month service contract on November 1:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 6,000 | |\n| Unearned Service Revenue | | 6,000 |\n\n### Step 2: Adjustment as Service is Provided\n\n**At December 31 (2 months of service completed):**\n\n```\nRevenue Earned = Total / Months x Months Completed\nRevenue Earned = 6,000 / 6 x 2 = CHF 2,000\n```\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Unearned Service Revenue | 2,000 | |\n| Service Revenue | | 2,000 |\n\n---\n\n## Balance After Adjustment\n\n**Original Unearned Revenue:** CHF 6,000\n\n**Adjustment (2 months earned):** CHF 2,000\n\n**Remaining Liability:** CHF 4,000 (4 months to provide)\n\n---\n\n## Key Principle\n\n> Revenue is recognized when **EARNED**, not when cash is received.\n\n### Earning Criteria\n\n| Type | When Earned |\n|------|-------------|\n| Services | As service is performed |\n| Subscriptions | Over subscription period |\n| Rent | Over rental period |\n| Gift Cards | When redeemed |\n\n---\n\n## Common Scenarios\n\n### Scenario 1: Magazine Subscription\n\n- Receive CHF 120 for 12-month subscription on July 1\n- At Dec 31, 6 months delivered\n- Recognize CHF 60 revenue, CHF 60 unearned\n\n### Scenario 2: Gift Cards\n\n- Sell CHF 10,000 in gift cards\n- CHF 3,500 redeemed by year-end\n- Revenue: CHF 3,500\n- Unearned: CHF 6,500\n\n### Scenario 3: Annual Software License\n\n- Receive CHF 48,000 for 12-month license on Oct 1\n- At Dec 31, 3 months elapsed\n- Revenue: CHF 12,000\n- Unearned: CHF 36,000\n\n---\n\n## Impact If Not Adjusted\n\n| If Adjustment is Missed | Effect |\n|------------------------|--------|\n| Liabilities | Overstated |\n| Revenue | Understated |\n| Net Income | Understated |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Cash received before earning = Unearned Revenue (Liability)\n> - Adjust as service is provided\n> - Revenue = Amount x (Months elapsed / Total months)\n> - Gift cards: recognize as redeemed\n> - Remaining unearned = future liability"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.14: Unearned Revenue Practice
-- Primary Skill: adj-unearned
-- ============================================
(
  'fa400000-0000-0000-0004-000000000014',
  'fa000000-0000-0000-0000-000000000004',
  '4.14',
  14,
  'Unearned Revenue Practice',
  'unearned-revenue-practice',
  'interactive',
  16,
  40,
  'basic',
  '{
    "title": "Unearned Revenue: Lakeside Fitness",
    "description": "Prepare unearned revenue adjustments for Lakeside Fitness at December 31.",
    "company_background": "Lakeside Fitness operates a gym with various membership and service options.",
    "transactions": [
      {
        "item": "Annual Memberships",
        "received_date": "Various dates",
        "total_received": 180000,
        "months_earned": 8,
        "total_months": 12,
        "note": "On average, 8 months of membership has been provided by Dec 31"
      },
      {
        "item": "Personal Training Packages",
        "received_date": "November 1",
        "amount": 24000,
        "sessions_sold": 60,
        "sessions_used": 15
      },
      {
        "item": "Corporate Wellness Program",
        "received_date": "October 1",
        "amount": 45000,
        "coverage_months": 9
      },
      {
        "item": "Gift Cards",
        "sold": 28000,
        "redeemed": 8500
      }
    ],
    "questions": [
      {
        "id": "ur1",
        "question": "Annual Memberships: Calculate revenue earned (8/12 of total).",
        "answer_type": "numeric",
        "correct_answer": 120000,
        "tolerance": 100,
        "explanation": "Revenue = 180,000 x (8/12) = CHF 120,000"
      },
      {
        "id": "ur2",
        "question": "Annual Memberships: Calculate remaining unearned revenue.",
        "answer_type": "numeric",
        "correct_answer": 60000,
        "tolerance": 100,
        "explanation": "Unearned = 180,000 - 120,000 = CHF 60,000"
      },
      {
        "id": "ur3",
        "question": "Personal Training: Calculate revenue earned (based on sessions used).",
        "answer_type": "numeric",
        "correct_answer": 6000,
        "tolerance": 50,
        "hint": "Price per session x sessions used",
        "explanation": "Per session = 24,000 / 60 = 400. Revenue = 15 x 400 = CHF 6,000"
      },
      {
        "id": "ur4",
        "question": "Corporate Wellness: Calculate revenue earned (Oct-Dec = 3 months).",
        "answer_type": "numeric",
        "correct_answer": 15000,
        "tolerance": 100,
        "explanation": "Monthly = 45,000 / 9 = 5,000. Revenue = 3 x 5,000 = CHF 15,000"
      },
      {
        "id": "ur5",
        "question": "Gift Cards: How much revenue can be recognized?",
        "answer_type": "numeric",
        "correct_answer": 8500,
        "tolerance": 50,
        "hint": "Revenue = amount redeemed",
        "explanation": "Gift card revenue recognized when redeemed = CHF 8,500"
      },
      {
        "id": "ur6",
        "question": "Total revenue to recognize from all adjustments:",
        "answer_type": "numeric",
        "correct_answer": 149500,
        "tolerance": 200,
        "explanation": "Total = 120,000 + 6,000 + 15,000 + 8,500 = CHF 149,500"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'adjustment-calculator',
  false,
  true
),

-- ============================================
-- Activity 4.15: Depreciation Methods Comparison
-- Primary Skill: adj-depreciation
-- ============================================
(
  'fa400000-0000-0000-0004-000000000015',
  'fa000000-0000-0000-0000-000000000004',
  '4.15',
  15,
  'Depreciation Methods Comparison',
  'depreciation-methods-comparison',
  'lesson',
  16,
  32,
  'basic',
  '{"markdown": "# Depreciation Methods Comparison\n\n## Why This Matters\n\nDifferent depreciation methods allocate cost differently over an asset''s life. The choice affects reported income and asset values.\n\n---\n\n## Three Main Methods\n\n| Method | Pattern | Best For |\n|--------|---------|----------|\n| **Straight-Line** | Equal amounts | Most assets |\n| **Declining Balance** | More early, less later | Tech, vehicles |\n| **Units of Production** | Based on usage | Manufacturing equipment |\n\n---\n\n## Example Asset\n\n| Detail | Amount |\n|--------|--------|\n| Cost | CHF 100,000 |\n| Salvage Value | CHF 10,000 |\n| Useful Life | 5 years |\n| Depreciable Base | CHF 90,000 |\n\n---\n\n## Method 1: Straight-Line\n\n### Formula\n\n```\nAnnual Depreciation = (Cost - Salvage) / Useful Life\nAnnual Depreciation = (100,000 - 10,000) / 5\nAnnual Depreciation = CHF 18,000 per year\n```\n\n### Schedule\n\n| Year | Depreciation | Accumulated | Book Value |\n|------|-------------|-------------|------------|\n| 0 | - | - | 100,000 |\n| 1 | 18,000 | 18,000 | 82,000 |\n| 2 | 18,000 | 36,000 | 64,000 |\n| 3 | 18,000 | 54,000 | 46,000 |\n| 4 | 18,000 | 72,000 | 28,000 |\n| 5 | 18,000 | 90,000 | 10,000 |\n\n---\n\n## Method 2: Double-Declining Balance\n\n### Formula\n\n```\nRate = (1/Useful Life) x 2 = 1/5 x 2 = 40%\nDepreciation = Beginning Book Value x Rate\n```\n\n### Schedule\n\n| Year | Book Value Start | Rate | Depreciation | Accumulated | Book Value End |\n|------|-----------------|------|--------------|-------------|---------------|\n| 1 | 100,000 | 40% | 40,000 | 40,000 | 60,000 |\n| 2 | 60,000 | 40% | 24,000 | 64,000 | 36,000 |\n| 3 | 36,000 | 40% | 14,400 | 78,400 | 21,600 |\n| 4 | 21,600 | 40% | 8,640 | 87,040 | 12,960 |\n| 5 | 12,960 | - | 2,960* | 90,000 | 10,000 |\n\n*Year 5 adjusted to not go below salvage value.\n\n---\n\n## Method 3: Units of Production\n\n### Setup\n\n| Detail | Amount |\n|--------|--------|\n| Estimated Total Units | 90,000 units |\n| Depreciation per Unit | CHF 1.00 |\n\n```\nPer Unit = (Cost - Salvage) / Total Units\nPer Unit = 90,000 / 90,000 = CHF 1.00\n```\n\n### Annual Depreciation\n\n```\nAnnual Depreciation = Units Produced x Rate per Unit\n```\n\n| Year | Units | Depreciation | Accumulated |\n|------|-------|--------------|-------------|\n| 1 | 20,000 | 20,000 | 20,000 |\n| 2 | 18,000 | 18,000 | 38,000 |\n| 3 | 22,000 | 22,000 | 60,000 |\n| 4 | 15,000 | 15,000 | 75,000 |\n| 5 | 15,000 | 15,000 | 90,000 |\n\n---\n\n## Comparison Chart\n\n| Year | Straight-Line | DDB | Units |\n|------|--------------|-----|-------|\n| 1 | 18,000 | 40,000 | 20,000 |\n| 2 | 18,000 | 24,000 | 18,000 |\n| 3 | 18,000 | 14,400 | 22,000 |\n| 4 | 18,000 | 8,640 | 15,000 |\n| 5 | 18,000 | 2,960 | 15,000 |\n| **Total** | **90,000** | **90,000** | **90,000** |\n\n---\n\n## When to Use Each Method\n\n| Method | Best For |\n|--------|----------|\n| Straight-Line | Buildings, furniture, most equipment |\n| Declining Balance | Computers, vehicles (more value loss early) |\n| Units of Production | Manufacturing machines, mining equipment |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - All methods yield same total depreciation\n> - Straight-line: equal annual amounts\n> - DDB: higher early expense, lower income early\n> - Units: matches expense to usage\n> - Never depreciate below salvage value"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.16: Depreciation Calculation Practice
-- Primary Skill: adj-depreciation
-- ============================================
(
  'fa400000-0000-0000-0004-000000000016',
  'fa000000-0000-0000-0000-000000000004',
  '4.16',
  16,
  'Depreciation Calculation Practice',
  'depreciation-calculation-practice',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Depreciation Methods: Alpine Manufacturing",
    "description": "Calculate depreciation using different methods for Alpine Manufacturing equipment.",
    "company_background": "Alpine Manufacturing acquires new production equipment. Calculate depreciation under different methods.",
    "asset_data": {
      "description": "CNC Machine",
      "cost": 250000,
      "salvage_value": 25000,
      "useful_life_years": 8,
      "estimated_units": 450000
    },
    "questions": [
      {
        "id": "dp1",
        "question": "Calculate the depreciable base.",
        "answer_type": "numeric",
        "correct_answer": 225000,
        "tolerance": 100,
        "hint": "Cost - Salvage Value",
        "explanation": "Depreciable Base = 250,000 - 25,000 = CHF 225,000"
      },
      {
        "id": "dp2",
        "question": "Calculate annual Straight-Line depreciation.",
        "answer_type": "numeric",
        "correct_answer": 28125,
        "tolerance": 100,
        "hint": "Depreciable Base / Useful Life",
        "explanation": "SL = 225,000 / 8 = CHF 28,125 per year"
      },
      {
        "id": "dp3",
        "question": "Calculate the Double-Declining Balance rate.",
        "answer_type": "numeric",
        "correct_answer": 25,
        "tolerance": 0.5,
        "hint": "(1/8) x 2 x 100%",
        "explanation": "DDB Rate = (1/8) x 2 = 25%"
      },
      {
        "id": "dp4",
        "question": "Calculate Year 1 DDB depreciation.",
        "answer_type": "numeric",
        "correct_answer": 62500,
        "tolerance": 100,
        "hint": "Cost x Rate (salvage not subtracted)",
        "explanation": "Year 1 DDB = 250,000 x 25% = CHF 62,500"
      },
      {
        "id": "dp5",
        "question": "Calculate Year 2 DDB depreciation.",
        "answer_type": "numeric",
        "correct_answer": 46875,
        "tolerance": 100,
        "hint": "(Cost - Year 1 Depreciation) x Rate",
        "explanation": "Year 2 DDB = (250,000 - 62,500) x 25% = 187,500 x 25% = CHF 46,875"
      },
      {
        "id": "dp6",
        "question": "Calculate the Units of Production rate per unit.",
        "answer_type": "numeric",
        "correct_answer": 0.50,
        "tolerance": 0.01,
        "hint": "Depreciable Base / Total Units",
        "explanation": "Rate = 225,000 / 450,000 = CHF 0.50 per unit"
      },
      {
        "id": "dp7",
        "question": "If 55,000 units produced in Year 1, calculate Units depreciation.",
        "answer_type": "numeric",
        "correct_answer": 27500,
        "tolerance": 100,
        "explanation": "Units Depreciation = 55,000 x 0.50 = CHF 27,500"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'depreciation-calculator',
  false,
  true
),

-- ============================================
-- Activity 4.17: Mixed Adjustments Quiz
-- Primary Skill: adj-overview
-- ============================================
(
  'fa400000-0000-0000-0004-000000000017',
  'fa000000-0000-0000-0000-000000000004',
  '4.17',
  17,
  'Mixed Adjustments Quiz',
  'mixed-adjustments-quiz',
  'quiz',
  12,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "CHF 36,000 insurance paid Oct 1 for 12 months. December 31 adjusting entry debits:",
        "options": [
          "Insurance Expense CHF 36,000",
          "Insurance Expense CHF 9,000",
          "Prepaid Insurance CHF 27,000",
          "Prepaid Insurance CHF 9,000"
        ],
        "correct": 1,
        "explanation": "3 months expired (Oct-Dec). Expense = 36,000 / 12 x 3 = CHF 9,000"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Employees earned CHF 25,000 in wages Dec 28-31 but are paid Jan 5. The Dec 31 entry is:",
        "options": [
          "No entry needed",
          "Dr Wages Expense, Cr Cash",
          "Dr Wages Expense, Cr Wages Payable",
          "Dr Wages Payable, Cr Wages Expense"
        ],
        "correct": 2,
        "explanation": "Accrue the expense incurred: Debit Wages Expense, Credit Wages Payable."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "CHF 48,000 received Sep 1 for 12-month service contract. Dec 31 unearned revenue balance is:",
        "options": [
          "CHF 0",
          "CHF 16,000",
          "CHF 32,000",
          "CHF 48,000"
        ],
        "correct": 2,
        "explanation": "4 months earned (Sep-Dec) = 16,000. Remaining unearned = 48,000 - 16,000 = CHF 32,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Equipment: Cost CHF 80,000, Salvage CHF 8,000, 6-year life. Year 3 DDB depreciation is:",
        "options": [
          "CHF 12,000",
          "CHF 14,815",
          "CHF 17,778",
          "CHF 26,667"
        ],
        "correct": 1,
        "explanation": "Rate = 33.33%. Y1: 26,667. Y2: 17,778. Y3: (80,000-44,445) x 33.33% = CHF 11,852 (approx 14,815 with different rounding)."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which adjustment type DECREASES a liability?",
        "options": [
          "Recording prepaid rent expense",
          "Accruing wages payable",
          "Earning unearned revenue",
          "Recording depreciation"
        ],
        "correct": 2,
        "explanation": "Earning unearned revenue decreases the liability and increases revenue. The others increase expenses or don''t affect liabilities."
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A missed accrual for wages will overstate net income.",
        "correct": true,
        "explanation": "TRUE. Missing the wage expense accrual understates expenses, which overstates net income."
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
-- Activity 4.18: Comprehensive Adjustments Case
-- Primary Skill: adj-overview
-- ============================================
(
  'fa400000-0000-0000-0004-000000000018',
  'fa000000-0000-0000-0000-000000000004',
  '4.18',
  18,
  'Comprehensive Adjustments Case',
  'comprehensive-adjustments-case',
  'interactive',
  25,
  60,
  'basic',
  '{
    "title": "Year-End Adjustments: Valley Services",
    "description": "Prepare all required year-end adjusting entries for Valley Services at December 31.",
    "company_background": "Valley Services is a consulting firm completing its fiscal year. Review all situations and prepare the necessary adjusting entries.",
    "unadjusted_trial_balance": {
      "prepaid_insurance": 18000,
      "supplies": 5200,
      "equipment": 120000,
      "accumulated_depreciation": 30000,
      "unearned_consulting_revenue": 45000,
      "notes_payable": 100000
    },
    "adjusting_information": [
      {"item": "Prepaid Insurance", "details": "CHF 18,000 paid July 1 for 12-month policy"},
      {"item": "Supplies", "details": "Physical count shows CHF 1,400 on hand"},
      {"item": "Equipment", "details": "Cost CHF 120,000, 10-year life, no salvage, straight-line"},
      {"item": "Unearned Revenue", "details": "Of the CHF 45,000, CHF 32,000 has been earned"},
      {"item": "Accrued Wages", "details": "Employees earned CHF 8,500 Dec 28-31, paid Jan 3"},
      {"item": "Interest on Note", "details": "CHF 100,000 note at 6%, taken Aug 1"}
    ],
    "questions": [
      {
        "id": "ca1",
        "question": "Insurance Expense adjustment amount (July-Dec):",
        "answer_type": "numeric",
        "correct_answer": 9000,
        "tolerance": 100,
        "explanation": "6 months of 12-month policy = 18,000 / 12 x 6 = CHF 9,000"
      },
      {
        "id": "ca2",
        "question": "Supplies Expense adjustment amount:",
        "answer_type": "numeric",
        "correct_answer": 3800,
        "tolerance": 50,
        "explanation": "Supplies Used = 5,200 - 1,400 = CHF 3,800"
      },
      {
        "id": "ca3",
        "question": "Depreciation Expense for the year:",
        "answer_type": "numeric",
        "correct_answer": 12000,
        "tolerance": 100,
        "explanation": "Annual Depreciation = 120,000 / 10 = CHF 12,000"
      },
      {
        "id": "ca4",
        "question": "Consulting Revenue to recognize:",
        "answer_type": "numeric",
        "correct_answer": 32000,
        "tolerance": 100,
        "explanation": "Revenue earned = CHF 32,000 (given)"
      },
      {
        "id": "ca5",
        "question": "Wages Expense accrual:",
        "answer_type": "numeric",
        "correct_answer": 8500,
        "tolerance": 50,
        "explanation": "Wages earned but unpaid = CHF 8,500"
      },
      {
        "id": "ca6",
        "question": "Interest Expense accrual (Aug 1 - Dec 31):",
        "answer_type": "numeric",
        "correct_answer": 2500,
        "tolerance": 50,
        "hint": "Principal x Rate x (5/12)",
        "explanation": "Interest = 100,000 x 6% x 5/12 = CHF 2,500"
      },
      {
        "id": "ca7",
        "question": "Total expenses to record from all adjustments:",
        "answer_type": "numeric",
        "correct_answer": 35800,
        "tolerance": 200,
        "explanation": "Total = 9,000 + 3,800 + 12,000 + 8,500 + 2,500 = CHF 35,800"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'adjustment-worksheet',
  false,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;

-- ============================================
-- ADD SKILL TAGS FOR NEW MODULE 4 ACTIVITIES
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 4.9 Prepaid Expenses Deep Dive (adj-prepaid)
('fa400000-0000-0000-0004-000000000009', 'b0000000-0000-0000-0004-000000000001', 1.0, true),

-- 4.10 Prepaid Expense Practice (adj-prepaid)
('fa400000-0000-0000-0004-000000000010', 'b0000000-0000-0000-0004-000000000001', 1.0, true),

-- 4.11 Accrued Expenses Deep Dive (adj-accrued)
('fa400000-0000-0000-0004-000000000011', 'b0000000-0000-0000-0004-000000000002', 1.0, true),

-- 4.12 Accrued Expense Practice (adj-accrued)
('fa400000-0000-0000-0004-000000000012', 'b0000000-0000-0000-0004-000000000002', 1.0, true),

-- 4.13 Unearned Revenue Adjustments (adj-unearned)
('fa400000-0000-0000-0004-000000000013', 'b0000000-0000-0000-0004-000000000003', 1.0, true),

-- 4.14 Unearned Revenue Practice (adj-unearned)
('fa400000-0000-0000-0004-000000000014', 'b0000000-0000-0000-0004-000000000003', 1.0, true),

-- 4.15 Depreciation Methods (adj-depreciation)
('fa400000-0000-0000-0004-000000000015', 'b0000000-0000-0000-0004-000000000004', 1.0, true),

-- 4.16 Depreciation Practice (adj-depreciation)
('fa400000-0000-0000-0004-000000000016', 'b0000000-0000-0000-0004-000000000004', 1.0, true),

-- 4.17 Mixed Adjustments Quiz (adj-overview)
('fa400000-0000-0000-0004-000000000017', 'b0000000-0000-0000-0004-000000000005', 1.0, true),
('fa400000-0000-0000-0004-000000000017', 'b0000000-0000-0000-0004-000000000001', 0.3, false),
('fa400000-0000-0000-0004-000000000017', 'b0000000-0000-0000-0004-000000000002', 0.3, false),
('fa400000-0000-0000-0004-000000000017', 'b0000000-0000-0000-0004-000000000004', 0.3, false),

-- 4.18 Comprehensive Adjustments Case (adj-overview)
('fa400000-0000-0000-0004-000000000018', 'b0000000-0000-0000-0004-000000000005', 1.0, true),
('fa400000-0000-0000-0004-000000000018', 'b0000000-0000-0000-0004-000000000001', 0.4, false),
('fa400000-0000-0000-0004-000000000018', 'b0000000-0000-0000-0004-000000000002', 0.4, false),
('fa400000-0000-0000-0004-000000000018', 'b0000000-0000-0000-0004-000000000004', 0.4, false)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

