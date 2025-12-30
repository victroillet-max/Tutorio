-- ============================================
-- FA Course Content Expansion - Phase 1
-- Module 3: Operating Expenses and Net Income Skills
-- Adds 8 new activities for under-covered skills
-- ============================================

-- ============================================
-- NEW ACTIVITIES FOR MODULE 3
-- Following existing UUID pattern: fa300000-0000-0000-0003-00000000XXXX
-- Existing activities: 0001-0006, new start at 0007
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 3.7: Operating Expenses Classification
-- Primary Skill: is-operating-expenses
-- ============================================
(
  'fa300000-0000-0000-0003-000000000007',
  'fa000000-0000-0000-0000-000000000003',
  '3.7',
  7,
  'Operating Expenses Classification',
  'operating-expenses-classification',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# Operating Expenses Classification\n\n## Why This Matters\n\nOperating expenses (OpEx) are the costs of running a business that are NOT directly tied to producing goods. Understanding what qualifies as an operating expense versus COGS is crucial for accurate income statement preparation.\n\n---\n\n## What Are Operating Expenses?\n\n> **Operating Expenses** are costs incurred in the normal course of business operations, excluding the direct costs of goods sold.\n\n### Key Categories\n\n```\nOPERATING EXPENSES\n       |\n       +-- Selling Expenses (S&D)\n       |\n       +-- General & Administrative (G&A)\n       |\n       +-- Depreciation & Amortization\n       |\n       +-- Research & Development (R&D)\n```\n\n---\n\n## Selling Expenses\n\n### What They Include\n\nCosts related to marketing, selling, and delivering products to customers:\n\n| Expense | Description |\n|---------|-------------|\n| **Advertising** | Marketing campaigns, promotions |\n| **Sales Salaries & Commissions** | Compensation for sales team |\n| **Sales Travel** | Business travel for sales |\n| **Freight-Out** | Shipping to customers |\n| **Store Rent** | Retail location costs |\n| **Display Equipment** | Point-of-sale materials |\n| **Customer Service** | Support after sale |\n\n### Example: Urban Apparel Co.\n\n| Selling Expense | Amount |\n|-----------------|--------|\n| Advertising | CHF 85,000 |\n| Sales Commissions | 120,000 |\n| Store Rent | 180,000 |\n| Delivery Expense | 45,000 |\n| **Total Selling** | **CHF 430,000** |\n\n---\n\n## General & Administrative Expenses (G&A)\n\n### What They Include\n\nCosts of running the business that are not directly related to sales:\n\n| Expense | Description |\n|---------|-------------|\n| **Executive Salaries** | Management compensation |\n| **Office Rent** | Headquarters costs |\n| **Office Supplies** | General supplies |\n| **Utilities** | Electricity, water, heating |\n| **Insurance** | Business insurance |\n| **Professional Fees** | Legal, accounting services |\n| **Bank Fees** | Banking charges |\n| **IT Expenses** | Software, hardware maintenance |\n\n### Example: Urban Apparel Co.\n\n| G&A Expense | Amount |\n|-------------|--------|\n| Executive Salaries | CHF 250,000 |\n| Office Rent | 60,000 |\n| Professional Fees | 45,000 |\n| Utilities | 35,000 |\n| Insurance | 28,000 |\n| **Total G&A** | **CHF 418,000** |\n\n---\n\n## Depreciation & Amortization\n\n### Depreciation\n\nAllocation of tangible asset costs over their useful life.\n\n| Asset Type | Example |\n|------------|----------|\n| Buildings | Factory, warehouse |\n| Equipment | Machinery, computers |\n| Vehicles | Delivery trucks |\n| Furniture | Office furniture |\n\n### Amortization\n\nAllocation of intangible asset costs over their useful life.\n\n| Asset Type | Example |\n|------------|----------|\n| Patents | Technology rights |\n| Software | Licensed software |\n| Trademarks | Brand rights |\n| Goodwill | Acquisition premium (tested for impairment under IFRS) |\n\n---\n\n## Operating Expenses vs. COGS\n\n### The Critical Distinction\n\n| COGS (Product Costs) | Operating Expenses (Period Costs) |\n|----------------------|----------------------------------|\n| Raw materials | Sales salaries |\n| Factory labor | Marketing |\n| Manufacturing overhead | Office rent |\n| Freight-in | Shipping to customers |\n| Factory utilities | Headquarters utilities |\n\n### Test: Direct Link to Product?\n\n**Ask:** Is this cost directly required to produce/acquire the product?\n- YES = COGS\n- NO = Operating Expense\n\n---\n\n## Common Classification Errors\n\n### Error 1: Freight-In vs Freight-Out\n\n| Type | Classification | Why |\n|------|----------------|-----|\n| Freight-In | COGS | Cost of getting inventory |\n| Freight-Out | Selling Expense | Cost of delivering to customers |\n\n### Error 2: Factory vs Office Costs\n\n| Cost | Factory | Office |\n|------|---------|--------|\n| Rent | COGS (overhead) | G&A Expense |\n| Utilities | COGS (overhead) | G&A Expense |\n| Labor | COGS (direct labor) | G&A Expense |\n\n### Error 3: Insurance\n\n| Type | Classification |\n|------|----------------|\n| Factory insurance | COGS (manufacturing overhead) |\n| Office insurance | G&A Expense |\n\n---\n\n## Impact on Financial Statements\n\n### Income Statement Structure\n\n```\nRevenue                          CHF 2,000,000\nLess: COGS                          (1,000,000)\n                                  ------------\nGross Profit                        1,000,000\n\nOperating Expenses:\n  Selling Expenses      430,000\n  G&A Expenses         418,000\n  Depreciation         100,000\n  Total OpEx                         (948,000)\n                                  ------------\nOperating Income                   CHF  52,000\n```\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Operating expenses are NOT directly tied to product creation\n> - Selling expenses = costs to get products to customers\n> - G&A = costs of running headquarters/administration\n> - Freight-In is COGS; Freight-Out is Selling Expense\n> - Factory costs are generally COGS; Office costs are Operating Expenses\n> - Depreciation can be COGS (factory) or OpEx (office)"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 3.8: Operating Expenses Practice
-- Primary Skill: is-operating-expenses
-- ============================================
(
  'fa300000-0000-0000-0003-000000000008',
  'fa000000-0000-0000-0000-000000000003',
  '3.8',
  8,
  'Operating Expenses Practice',
  'operating-expenses-practice',
  'interactive',
  16,
  40,
  'basic',
  '{
    "title": "Operating Expense Classification: Golden Bear Candy",
    "description": "Classify expenses and calculate total operating expenses for Golden Bear Candy Co.",
    "company_background": "Golden Bear Candy is a Swiss chocolate manufacturer. Classify their expenses correctly and compute operating expense totals.",
    "expense_items": [
      {"item": "Sales team salaries", "amount": 180000, "classification": "selling"},
      {"item": "Factory workers wages", "amount": 420000, "classification": "cogs"},
      {"item": "Advertising campaign", "amount": 75000, "classification": "selling"},
      {"item": "Corporate headquarters rent", "amount": 120000, "classification": "g_and_a"},
      {"item": "Factory building rent", "amount": 200000, "classification": "cogs"},
      {"item": "Delivery to customers", "amount": 45000, "classification": "selling"},
      {"item": "CEO and CFO salaries", "amount": 350000, "classification": "g_and_a"},
      {"item": "Cocoa and sugar (raw materials)", "amount": 580000, "classification": "cogs"},
      {"item": "Office supplies", "amount": 15000, "classification": "g_and_a"},
      {"item": "Factory depreciation", "amount": 80000, "classification": "cogs"},
      {"item": "Office equipment depreciation", "amount": 25000, "classification": "depreciation_opex"},
      {"item": "Legal and accounting fees", "amount": 60000, "classification": "g_and_a"},
      {"item": "Trade show participation", "amount": 35000, "classification": "selling"},
      {"item": "Factory insurance", "amount": 40000, "classification": "cogs"},
      {"item": "Corporate insurance", "amount": 30000, "classification": "g_and_a"}
    ],
    "questions": [
      {
        "id": "oe1",
        "question": "Which of these is an Operating Expense (not COGS)?",
        "answer_type": "choice",
        "options": ["Factory workers wages", "Delivery to customers", "Raw materials", "Factory rent"],
        "correct_answer": "Delivery to customers",
        "explanation": "Delivery to customers (freight-out) is a selling expense. Factory wages, raw materials, and factory rent are all COGS."
      },
      {
        "id": "oe2",
        "question": "Calculate total Selling Expenses.",
        "answer_type": "numeric",
        "correct_answer": 335000,
        "tolerance": 1000,
        "hint": "Sales salaries + Advertising + Delivery + Trade shows",
        "explanation": "Selling Expenses = 180,000 + 75,000 + 45,000 + 35,000 = CHF 335,000"
      },
      {
        "id": "oe3",
        "question": "Calculate total General & Administrative Expenses.",
        "answer_type": "numeric",
        "correct_answer": 575000,
        "tolerance": 1000,
        "hint": "HQ rent + Exec salaries + Office supplies + Legal fees + Corporate insurance",
        "explanation": "G&A = 120,000 + 350,000 + 15,000 + 60,000 + 30,000 = CHF 575,000"
      },
      {
        "id": "oe4",
        "question": "Calculate Total Operating Expenses (including office depreciation).",
        "answer_type": "numeric",
        "correct_answer": 935000,
        "tolerance": 1000,
        "hint": "Selling + G&A + Office Depreciation",
        "explanation": "Total OpEx = 335,000 + 575,000 + 25,000 = CHF 935,000"
      },
      {
        "id": "oe5",
        "question": "Calculate total Cost of Goods Sold.",
        "answer_type": "numeric",
        "correct_answer": 1320000,
        "tolerance": 1000,
        "hint": "Factory wages + Factory rent + Raw materials + Factory depreciation + Factory insurance",
        "explanation": "COGS = 420,000 + 200,000 + 580,000 + 80,000 + 40,000 = CHF 1,320,000"
      }
    ],
    "passing_score": 80
  }'::jsonb,
  'expense-classifier',
  false,
  true
),

-- ============================================
-- Activity 3.9: Operating Expenses Quiz
-- Primary Skill: is-operating-expenses
-- ============================================
(
  'fa300000-0000-0000-0003-000000000009',
  'fa000000-0000-0000-0000-000000000003',
  '3.9',
  9,
  'Operating Expenses Quiz',
  'operating-expenses-quiz',
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
        "question": "Which of the following is classified as an Operating Expense?",
        "options": [
          "Raw materials purchased",
          "Factory labor costs",
          "Marketing campaign costs",
          "Freight-in on inventory"
        ],
        "correct": 2,
        "explanation": "Marketing campaigns are selling expenses (operating expenses). Raw materials, factory labor, and freight-in are all part of COGS."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Freight-OUT (delivery to customers) is classified as:",
        "options": [
          "Cost of Goods Sold",
          "Selling Expense",
          "General & Administrative Expense",
          "Interest Expense"
        ],
        "correct": 1,
        "explanation": "Freight-out is a selling expense because it is the cost of delivering products to customers, not the cost of acquiring inventory."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which expense would be classified as G&A (not Selling)?",
        "options": [
          "Sales commissions",
          "Advertising costs",
          "CFO salary",
          "Customer service costs"
        ],
        "correct": 2,
        "explanation": "The CFO is part of corporate administration. Sales commissions, advertising, and customer service are selling-related."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A manufacturing company has factory rent of CHF 100,000 and office rent of CHF 50,000. How should these be classified?",
        "options": [
          "Both are Operating Expenses",
          "Both are Cost of Goods Sold",
          "Factory rent is COGS; Office rent is Operating Expense",
          "Factory rent is Operating Expense; Office rent is COGS"
        ],
        "correct": 2,
        "explanation": "Factory rent is manufacturing overhead (part of COGS). Office rent is a G&A expense (operating expense)."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Depreciation on office furniture is always an operating expense, while depreciation on factory equipment is part of COGS.",
        "correct": true,
        "explanation": "TRUE. Office equipment depreciation is an operating expense (G&A). Factory equipment depreciation is part of manufacturing overhead and included in COGS for a manufacturer."
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
-- Activity 3.10: Income Tax Basics
-- Primary Skill: is-net-income
-- ============================================
(
  'fa300000-0000-0000-0003-000000000010',
  'fa000000-0000-0000-0000-000000000003',
  '3.10',
  10,
  'Income Tax Calculation Basics',
  'income-tax-calculation-basics',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Income Tax Calculation Basics\n\n## Why This Matters\n\nIncome tax expense is the final deduction before arriving at Net Income. Understanding how to calculate and present taxes is essential for financial statement analysis and preparation.\n\n---\n\n## The Path to Net Income\n\n```\nOperating Income (EBIT)\n- Interest Expense\n+ Interest Income\n+/- Other Non-Operating Items\n= Income Before Tax (EBT)\n- Income Tax Expense\n= NET INCOME\n```\n\n---\n\n## Calculating Income Tax Expense\n\n### Basic Formula\n\n```\nIncome Tax Expense = Income Before Tax x Tax Rate\n```\n\n### Example: Swiss Tech AG\n\n| Item | Amount |\n|------|--------|\n| Operating Income | CHF 500,000 |\n| Interest Expense | (50,000) |\n| Interest Income | 10,000 |\n| **Income Before Tax** | **CHF 460,000** |\n| Tax Rate | 25% |\n| **Income Tax Expense** | **CHF 115,000** |\n| **Net Income** | **CHF 345,000** |\n\n---\n\n## Corporate Tax Rates\n\n### Swiss Context\n\nSwitzerland has a combined federal, cantonal, and communal tax system:\n\n| Level | Approximate Rate |\n|-------|------------------|\n| Federal | 8.5% |\n| Cantonal/Communal | 6-16% (varies by canton) |\n| **Effective Total** | **12-24%** |\n\n### For Exam Purposes\n\nUse the tax rate given in the problem (commonly 25%, 30%, or 20%).\n\n---\n\n## Current vs. Deferred Tax\n\n### Current Tax Expense\n\nTax actually payable based on this year''s taxable income.\n\n### Deferred Tax\n\nArises from timing differences between accounting income and taxable income:\n\n| Example | Accounting | Tax | Effect |\n|---------|------------|-----|--------|\n| Depreciation | Straight-line (slower) | Accelerated (faster) | Deferred tax liability |\n| Warranty expense | Accrued when sold | Deducted when paid | Deferred tax asset |\n\n### For Introductory FA\n\nFocus on total income tax expense. Deferred taxes are covered in advanced courses.\n\n---\n\n## Multi-Step Calculation Example\n\n### Alpine Electronics Full Income Statement\n\n```\nNet Sales                         CHF 2,000,000\nCost of Goods Sold                   (1,200,000)\n                                  -------------\nGross Profit                           800,000\n\nOperating Expenses:\n  Selling Expenses       (200,000)\n  G&A Expenses          (150,000)\n  Depreciation           (50,000)\n  Total Operating        (400,000)     (400,000)\n                                  -------------\nOperating Income (EBIT)                400,000\n\nOther Income (Expenses):\n  Interest Income          5,000\n  Interest Expense       (25,000)\n  Gain on Sale of Asset   10,000\n  Total Other                           (10,000)\n                                  -------------\nIncome Before Tax                      390,000\nIncome Tax Expense (25%)               (97,500)\n                                  -------------\nNET INCOME                        CHF  292,500\n```\n\n---\n\n## Key Tax Concepts\n\n### Tax Shield from Interest\n\nInterest expense reduces taxable income, creating a \"tax shield\":\n\n```\nTax Shield = Interest Expense x Tax Rate\n```\n\n**Example:** CHF 100,000 interest at 25% tax = CHF 25,000 tax savings\n\n### Effective Tax Rate\n\n```\nEffective Tax Rate = Income Tax Expense / Income Before Tax\n```\n\nThis may differ from statutory rate due to:\n- Tax credits\n- Non-deductible expenses\n- Tax-exempt income\n- Jurisdictional differences\n\n---\n\n## Net Income and Beyond\n\n### Where Net Income Goes\n\n```\nNET INCOME\n    |\n    +-- Retained (Retained Earnings)\n    |\n    +-- Distributed (Dividends)\n```\n\n### Earnings Per Share (EPS)\n\n```\nBasic EPS = Net Income / Average Shares Outstanding\n```\n\nEPS is often the most watched metric by investors.\n\n---\n\n## Common Errors\n\n### Error 1: Tax on Operating Income\n\nTax is calculated on Income BEFORE Tax (after interest), not on Operating Income.\n\n### Error 2: Forgetting Interest\n\nDon''t skip interest income/expense when calculating Income Before Tax.\n\n### Error 3: Misplacing Gains/Losses\n\nGains/losses on asset sales are non-operating but ARE included before tax.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Tax is calculated on Income Before Tax (EBT)\n> - EBT = Operating Income + Non-Operating Items\n> - Income Tax Expense = EBT x Tax Rate\n> - Net Income = EBT - Tax Expense\n> - Interest reduces taxes (tax shield)\n> - Net Income flows to Retained Earnings"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 3.11: Net Income Computation Practice
-- Primary Skill: is-net-income
-- ============================================
(
  'fa300000-0000-0000-0003-000000000011',
  'fa000000-0000-0000-0000-000000000003',
  '3.11',
  11,
  'Net Income Computation Practice',
  'net-income-computation-practice',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Computing Net Income: Phantom Studios",
    "description": "Calculate the complete income statement path from revenue to net income for Phantom Studios, a media production company.",
    "company_background": "Phantom Studios produces commercial videos and documentaries. Calculate their profitability for the year.",
    "financial_data": {
      "revenue": 1800000,
      "cogs": 720000,
      "selling_expenses": 250000,
      "ga_expenses": 180000,
      "depreciation": 75000,
      "interest_expense": 35000,
      "interest_income": 8000,
      "gain_on_equipment_sale": 12000,
      "tax_rate": 0.30
    },
    "questions": [
      {
        "id": "ni1",
        "question": "Calculate Gross Profit.",
        "answer_type": "numeric",
        "correct_answer": 1080000,
        "tolerance": 100,
        "hint": "Revenue - COGS",
        "explanation": "Gross Profit = 1,800,000 - 720,000 = CHF 1,080,000"
      },
      {
        "id": "ni2",
        "question": "Calculate Total Operating Expenses.",
        "answer_type": "numeric",
        "correct_answer": 505000,
        "tolerance": 100,
        "hint": "Selling + G&A + Depreciation",
        "explanation": "Total OpEx = 250,000 + 180,000 + 75,000 = CHF 505,000"
      },
      {
        "id": "ni3",
        "question": "Calculate Operating Income (EBIT).",
        "answer_type": "numeric",
        "correct_answer": 575000,
        "tolerance": 100,
        "hint": "Gross Profit - Total Operating Expenses",
        "explanation": "Operating Income = 1,080,000 - 505,000 = CHF 575,000"
      },
      {
        "id": "ni4",
        "question": "Calculate Income Before Tax (EBT).",
        "answer_type": "numeric",
        "correct_answer": 560000,
        "tolerance": 100,
        "hint": "Operating Income - Interest Expense + Interest Income + Gain",
        "explanation": "EBT = 575,000 - 35,000 + 8,000 + 12,000 = CHF 560,000"
      },
      {
        "id": "ni5",
        "question": "Calculate Income Tax Expense at 30% rate.",
        "answer_type": "numeric",
        "correct_answer": 168000,
        "tolerance": 100,
        "explanation": "Tax = 560,000 x 0.30 = CHF 168,000"
      },
      {
        "id": "ni6",
        "question": "Calculate Net Income.",
        "answer_type": "numeric",
        "correct_answer": 392000,
        "tolerance": 100,
        "explanation": "Net Income = 560,000 - 168,000 = CHF 392,000"
      },
      {
        "id": "ni7",
        "question": "What is the Net Profit Margin (as percentage, 1 decimal)?",
        "answer_type": "numeric",
        "correct_answer": 21.8,
        "tolerance": 0.2,
        "explanation": "Net Profit Margin = 392,000 / 1,800,000 = 21.8%"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'income-calculator',
  false,
  true
),

-- ============================================
-- Activity 3.12: Tax Expense and Net Income Quiz
-- Primary Skill: is-net-income
-- ============================================
(
  'fa300000-0000-0000-0003-000000000012',
  'fa000000-0000-0000-0000-000000000003',
  '3.12',
  12,
  'Tax Expense and Net Income Quiz',
  'tax-expense-net-income-quiz',
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
        "question": "Income tax expense is calculated based on:",
        "options": [
          "Gross Profit",
          "Operating Income",
          "Income Before Tax",
          "Revenue"
        ],
        "correct": 2,
        "explanation": "Income tax is calculated on Income Before Tax (EBT), which includes non-operating items like interest income and expense."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Operating Income is CHF 200,000; Interest Expense CHF 25,000; Tax Rate 30%. What is Net Income?",
        "options": [
          "CHF 122,500",
          "CHF 140,000",
          "CHF 175,000",
          "CHF 60,000"
        ],
        "correct": 0,
        "explanation": "EBT = 200,000 - 25,000 = 175,000. Tax = 175,000 x 30% = 52,500. Net Income = 175,000 - 52,500 = CHF 122,500."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The tax shield from CHF 100,000 of interest expense at 25% tax rate is:",
        "options": [
          "CHF 100,000",
          "CHF 75,000",
          "CHF 25,000",
          "CHF 125,000"
        ],
        "correct": 2,
        "explanation": "Tax shield = Interest x Tax Rate = 100,000 x 25% = CHF 25,000 in tax savings."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Company reports: Revenue CHF 500,000; COGS CHF 200,000; OpEx CHF 150,000; Interest CHF 20,000; Tax 25%. Net Income is:",
        "options": [
          "CHF 97,500",
          "CHF 112,500",
          "CHF 130,000",
          "CHF 150,000"
        ],
        "correct": 0,
        "explanation": "Gross Profit = 300,000. Operating Income = 150,000. EBT = 130,000. Tax = 32,500. Net Income = CHF 97,500."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Interest expense is deducted AFTER calculating income tax expense.",
        "correct": false,
        "explanation": "FALSE. Interest expense is deducted BEFORE calculating tax. Interest reduces Income Before Tax, which then determines tax expense."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company has Income Tax Expense of CHF 60,000 and EBT of CHF 200,000. What is the effective tax rate?",
        "options": [
          "25%",
          "30%",
          "35%",
          "20%"
        ],
        "correct": 1,
        "explanation": "Effective Tax Rate = Tax Expense / EBT = 60,000 / 200,000 = 30%."
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
-- Activity 3.13: Multi-Step Income Statement Builder
-- Primary Skill: is-interpretation
-- ============================================
(
  'fa300000-0000-0000-0003-000000000013',
  'fa000000-0000-0000-0000-000000000003',
  '3.13',
  13,
  'Multi-Step Income Statement Builder',
  'multi-step-income-statement-builder',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Build the Income Statement: Alpine Sports Equipment",
    "description": "Arrange the items correctly and calculate subtotals to build a complete multi-step income statement.",
    "company_background": "Alpine Sports Equipment manufactures ski equipment. You have been given a list of accounts and need to prepare a proper multi-step income statement.",
    "accounts": [
      {"name": "Sales Revenue", "amount": 4500000},
      {"name": "Sales Returns and Allowances", "amount": 75000},
      {"name": "Cost of Goods Sold", "amount": 2250000},
      {"name": "Sales Salaries Expense", "amount": 280000},
      {"name": "Advertising Expense", "amount": 120000},
      {"name": "Delivery Expense", "amount": 65000},
      {"name": "Administrative Salaries", "amount": 420000},
      {"name": "Rent Expense - Office", "amount": 96000},
      {"name": "Utilities Expense - Office", "amount": 24000},
      {"name": "Depreciation Expense - Office Equipment", "amount": 36000},
      {"name": "Interest Revenue", "amount": 15000},
      {"name": "Interest Expense", "amount": 55000}
    ],
    "tax_rate": 0.25,
    "questions": [
      {
        "id": "ms1",
        "question": "Calculate Net Sales.",
        "answer_type": "numeric",
        "correct_answer": 4425000,
        "tolerance": 100,
        "hint": "Sales Revenue - Sales Returns and Allowances",
        "explanation": "Net Sales = 4,500,000 - 75,000 = CHF 4,425,000"
      },
      {
        "id": "ms2",
        "question": "Calculate Gross Profit.",
        "answer_type": "numeric",
        "correct_answer": 2175000,
        "tolerance": 100,
        "explanation": "Gross Profit = 4,425,000 - 2,250,000 = CHF 2,175,000"
      },
      {
        "id": "ms3",
        "question": "Calculate Total Selling Expenses.",
        "answer_type": "numeric",
        "correct_answer": 465000,
        "tolerance": 100,
        "hint": "Sales Salaries + Advertising + Delivery",
        "explanation": "Selling Expenses = 280,000 + 120,000 + 65,000 = CHF 465,000"
      },
      {
        "id": "ms4",
        "question": "Calculate Total G&A Expenses.",
        "answer_type": "numeric",
        "correct_answer": 576000,
        "tolerance": 100,
        "hint": "Admin Salaries + Office Rent + Office Utilities + Office Depreciation",
        "explanation": "G&A = 420,000 + 96,000 + 24,000 + 36,000 = CHF 576,000"
      },
      {
        "id": "ms5",
        "question": "Calculate Operating Income (EBIT).",
        "answer_type": "numeric",
        "correct_answer": 1134000,
        "tolerance": 100,
        "explanation": "Operating Income = 2,175,000 - 465,000 - 576,000 = CHF 1,134,000"
      },
      {
        "id": "ms6",
        "question": "Calculate Income Before Tax.",
        "answer_type": "numeric",
        "correct_answer": 1094000,
        "tolerance": 100,
        "hint": "Operating Income + Interest Revenue - Interest Expense",
        "explanation": "EBT = 1,134,000 + 15,000 - 55,000 = CHF 1,094,000"
      },
      {
        "id": "ms7",
        "question": "Calculate Net Income (at 25% tax rate).",
        "answer_type": "numeric",
        "correct_answer": 820500,
        "tolerance": 100,
        "explanation": "Tax = 1,094,000 x 0.25 = 273,500. Net Income = 1,094,000 - 273,500 = CHF 820,500"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'income-statement-builder',
  false,
  true
),

-- ============================================
-- Activity 3.14: Profitability Analysis Case
-- Primary Skill: is-interpretation + is-net-income
-- ============================================
(
  'fa300000-0000-0000-0003-000000000014',
  'fa000000-0000-0000-0000-000000000003',
  '3.14',
  14,
  'Income Statement Analysis Case',
  'income-statement-analysis-case',
  'interactive',
  22,
  55,
  'basic',
  '{
    "title": "Profitability Analysis: Two Restaurant Chains",
    "description": "Compare two restaurant chains to understand how different business models impact profitability metrics.",
    "company_background": "Compare GourmetBite (upscale dining) and QuickServe (fast food) using their income statements.",
    "financial_data": {
      "gourmetbite": {
        "name": "GourmetBite SA",
        "segment": "Fine Dining",
        "net_sales": 5000000,
        "cogs": 1750000,
        "selling_expenses": 750000,
        "ga_expenses": 1100000,
        "interest_expense": 150000,
        "tax_rate": 0.25
      },
      "quickserve": {
        "name": "QuickServe AG",
        "segment": "Fast Food",
        "net_sales": 8000000,
        "cogs": 4800000,
        "selling_expenses": 800000,
        "ga_expenses": 1200000,
        "interest_expense": 200000,
        "tax_rate": 0.25
      }
    },
    "questions": [
      {
        "id": "pa1",
        "question": "Calculate GourmetBite''s Gross Profit Margin (as percentage).",
        "answer_type": "numeric",
        "correct_answer": 65.0,
        "tolerance": 0.2,
        "explanation": "GourmetBite GP = (5,000,000 - 1,750,000) / 5,000,000 = 65%"
      },
      {
        "id": "pa2",
        "question": "Calculate QuickServe''s Gross Profit Margin (as percentage).",
        "answer_type": "numeric",
        "correct_answer": 40.0,
        "tolerance": 0.2,
        "explanation": "QuickServe GP = (8,000,000 - 4,800,000) / 8,000,000 = 40%"
      },
      {
        "id": "pa3",
        "question": "Calculate GourmetBite''s Net Income.",
        "answer_type": "numeric",
        "correct_answer": 787500,
        "tolerance": 1000,
        "hint": "Calculate: Gross Profit - OpEx = Operating Income. Then EBT - Tax = Net Income",
        "explanation": "GP = 3,250,000. Operating Income = 1,400,000. EBT = 1,250,000. Tax = 312,500. Net Income = CHF 937,500"
      },
      {
        "id": "pa4",
        "question": "Calculate QuickServe''s Net Income.",
        "answer_type": "numeric",
        "correct_answer": 600000,
        "tolerance": 1000,
        "explanation": "GP = 3,200,000. Operating Income = 1,200,000. EBT = 1,000,000. Tax = 250,000. Net Income = CHF 750,000"
      },
      {
        "id": "pa5",
        "question": "Which company has a higher Net Profit Margin?",
        "answer_type": "choice",
        "options": ["GourmetBite (higher margin)", "QuickServe (higher margin)", "Same margin"],
        "correct_answer": "GourmetBite (higher margin)",
        "explanation": "GourmetBite: 937,500/5,000,000 = 18.75%. QuickServe: 750,000/8,000,000 = 9.4%. Fine dining has higher margins."
      },
      {
        "id": "pa6",
        "question": "Which business model insight does this comparison reveal?",
        "answer_type": "choice",
        "options": [
          "Fast food is always more profitable than fine dining",
          "Fine dining has higher margins but lower volume; fast food relies on volume",
          "Both models have identical profitability"
        ],
        "correct_answer": "Fine dining has higher margins but lower volume; fast food relies on volume",
        "explanation": "GourmetBite has 65% gross margin vs QuickServe at 40%. However, QuickServe generates 60% more revenue. Different strategies both work."
      }
    ],
    "passing_score": 70
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
-- ADD SKILL TAGS FOR NEW MODULE 3 ACTIVITIES
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 3.7 Operating Expenses Classification (is-operating-expenses)
('fa300000-0000-0000-0003-000000000007', 'b0000000-0000-0000-0003-000000000003', 1.0, true),

-- 3.8 Operating Expenses Practice (is-operating-expenses)
('fa300000-0000-0000-0003-000000000008', 'b0000000-0000-0000-0003-000000000003', 1.0, true),
('fa300000-0000-0000-0003-000000000008', 'b0000000-0000-0000-0003-000000000002', 0.3, false),

-- 3.9 Operating Expenses Quiz (is-operating-expenses)
('fa300000-0000-0000-0003-000000000009', 'b0000000-0000-0000-0003-000000000003', 1.0, true),

-- 3.10 Income Tax Basics (is-net-income)
('fa300000-0000-0000-0003-000000000010', 'b0000000-0000-0000-0003-000000000004', 1.0, true),

-- 3.11 Net Income Computation Practice (is-net-income)
('fa300000-0000-0000-0003-000000000011', 'b0000000-0000-0000-0003-000000000004', 1.0, true),
('fa300000-0000-0000-0003-000000000011', 'b0000000-0000-0000-0003-000000000003', 0.3, false),

-- 3.12 Tax and Net Income Quiz (is-net-income)
('fa300000-0000-0000-0003-000000000012', 'b0000000-0000-0000-0003-000000000004', 1.0, true),

-- 3.13 Multi-Step Builder (is-interpretation + is-net-income)
('fa300000-0000-0000-0003-000000000013', 'b0000000-0000-0000-0003-000000000005', 1.0, true),
('fa300000-0000-0000-0003-000000000013', 'b0000000-0000-0000-0003-000000000004', 0.5, false),
('fa300000-0000-0000-0003-000000000013', 'b0000000-0000-0000-0003-000000000003', 0.3, false),

-- 3.14 Profitability Analysis (is-interpretation + is-net-income)
('fa300000-0000-0000-0003-000000000014', 'b0000000-0000-0000-0003-000000000005', 1.0, true),
('fa300000-0000-0000-0003-000000000014', 'b0000000-0000-0000-0003-000000000004', 0.5, false)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

