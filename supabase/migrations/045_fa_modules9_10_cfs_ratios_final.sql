-- ============================================
-- Modules 9-10 and Mock Final
-- Cash Flow Statement, Financial Analysis & Ratios, Mock Final
-- Inspired by Wayne Enterprises, Spacely Sprockets CFS exercises
-- ============================================

-- ============================================
-- MODULE 9: Cash Flow Statement
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 9.1: Introduction to Cash Flow Statement
(
  'fa900000-0000-0000-0009-000000000001',
  'fa000000-0000-0000-0000-000000000009',
  '9.1',
  1,
  'Introduction to the Cash Flow Statement',
  'introduction-cash-flow-statement',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to the Cash Flow Statement\n\n## Why This Matters\n\nA profitable company can run out of cash. A loss-making company can have plenty of cash. The Cash Flow Statement (CFS) reveals what the Income Statement cannot: **where cash actually came from and where it went.**\n\n---\n\n## The Third Financial Statement\n\n| Statement | Shows | Time Frame |\n|-----------|-------|-----------|\n| Balance Sheet | Financial position | Point in time |\n| Income Statement | Profitability | Over a period |\n| **Cash Flow Statement** | **Cash movements** | **Over a period** |\n\n---\n\n## Three Categories of Cash Flows\n\n```\n              CASH FLOW STATEMENT\n                     |\n      ---------------------------------\n      |              |                |\n  OPERATING      INVESTING       FINANCING\n   (CFO)          (CFI)            (CFF)\n      |              |                |\n  Core           Assets &        Debt &\n  business       investments     equity\n  activities\n```\n\n---\n\n## Operating Activities (CFO)\n\n**Cash from the core business:**\n\n### Cash Inflows\n- Collections from customers\n- Interest received\n- Dividends received\n\n### Cash Outflows\n- Payments to suppliers\n- Payments to employees\n- Interest paid\n- Income taxes paid\n\n---\n\n## Investing Activities (CFI)\n\n**Cash used for/from long-term assets and investments:**\n\n### Cash Inflows\n- Sale of property, plant & equipment\n- Sale of investments\n- Collections on loans to others\n\n### Cash Outflows\n- Purchase of PP&E (capital expenditures)\n- Purchase of investments\n- Loans made to others\n\n---\n\n## Financing Activities (CFF)\n\n**Cash from/to owners and lenders:**\n\n### Cash Inflows\n- Issuing shares (equity)\n- Borrowing money (debt)\n\n### Cash Outflows\n- Repaying loans\n- Repurchasing shares (treasury stock)\n- Paying dividends\n\n---\n\n## The Big Picture\n\n```\n  Beginning Cash Balance\n+ Cash from Operating Activities\n+ Cash from Investing Activities\n+ Cash from Financing Activities\n= Ending Cash Balance\n```\n\nThis must tie to cash on the Balance Sheet!\n\n---\n\n## Direct vs Indirect Method\n\n### Direct Method\n\nShows actual cash inflows and outflows.\n\n```\nCash received from customers     XXX\nCash paid to suppliers          (XXX)\nCash paid to employees          (XXX)\nNet Cash from Operating         XXX\n```\n\n### Indirect Method (Most Common)\n\nStarts with Net Income and adjusts for non-cash items.\n\n```\nNet Income                      XXX\n+ Depreciation                  XXX\n+ Decrease in A/R               XXX\n- Increase in Inventory        (XXX)\n+ Increase in A/P               XXX\nNet Cash from Operating         XXX\n```\n\n---\n\n## Why the Indirect Method?\n\n| Net Income includes... | But cash wasn''t affected by... |\n|----------------------|-------------------------------|\n| Depreciation expense | No cash was paid |\n| Credit sales | Cash not yet received |\n| Purchases on account | Cash not yet paid |\n\nThe indirect method removes these non-cash items!\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - CFS shows cash movements (not accrual accounting)\n> - Three sections: Operating, Investing, Financing\n> - Operating = core business activities\n> - Investing = long-term assets\n> - Financing = debt and equity\n> - Indirect method: Start with Net Income, adjust for non-cash"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 9.2: The Indirect Method
(
  'fa900000-0000-0000-0009-000000000002',
  'fa000000-0000-0000-0000-000000000009',
  '9.2',
  2,
  'Building CFO: The Indirect Method',
  'building-cfo-indirect-method',
  'lesson',
  18,
  35,
  'basic',
  '{"markdown": "# Building CFO: The Indirect Method\n\n## Why This Matters\n\nThe indirect method is used by 95%+ of companies. Understanding how to reconcile Net Income to Cash from Operations is essential for both preparing and analyzing financial statements.\n\n---\n\n## The Indirect Method Formula\n\n```\n  Net Income\n+ Non-cash expenses (Depreciation, Amortization)\n- Gains on asset sales (+ Losses)\n+/- Changes in operating assets and liabilities\n= Net Cash from Operating Activities\n```\n\n---\n\n## Step 1: Start with Net Income\n\nNet Income from the Income Statement is the starting point.\n\n---\n\n## Step 2: Add Back Non-Cash Expenses\n\n### Depreciation and Amortization\n\nThese reduce Net Income but don''t use cash.\n\n```\nNet Income includes:    CHF -50,000 (Depreciation Expense)\nBut cash paid was:      CHF 0\nAdjustment:             ADD BACK CHF 50,000\n```\n\n---\n\n## Step 3: Remove Non-Operating Gains/Losses\n\n### Gain on Sale of Equipment\n\nThe gain is included in Net Income but belongs in Investing Activities.\n\n```\nNet Income includes:    CHF +10,000 (Gain on Sale)\nWhere it belongs:       Investing Activities\nAdjustment:             SUBTRACT CHF 10,000\n```\n\nThe full proceeds will be shown in Investing Activities.\n\n---\n\n## Step 4: Adjust for Working Capital Changes\n\n### The Rules\n\n| Change in... | Effect on CFO |\n|--------------|---------------|\n| Current Assets INCREASE | SUBTRACT |\n| Current Assets DECREASE | ADD |\n| Current Liabilities INCREASE | ADD |\n| Current Liabilities DECREASE | SUBTRACT |\n\n### Why?\n\n**Accounts Receivable increases:**\n- Sales recorded (Net Income up)\n- But cash NOT collected yet\n- Subtract the increase from CFO\n\n**Inventory increases:**\n- Cash paid for inventory\n- But not yet expensed as COGS\n- Subtract the increase from CFO\n\n**Accounts Payable increases:**\n- COGS recorded (Net Income down)\n- But cash NOT paid yet\n- Add the increase to CFO\n\n---\n\n## Comprehensive Example: Wayne Enterprises\n\n### Given Information:\n\n| Item | Amount |\n|------|--------|\n| Net Income | CHF 150,000 |\n| Depreciation Expense | 45,000 |\n| Gain on Sale of Equipment | 8,000 |\n| Accounts Receivable increase | 25,000 |\n| Inventory decrease | 12,000 |\n| Prepaid Expenses decrease | 3,000 |\n| Accounts Payable increase | 18,000 |\n| Wages Payable decrease | 5,000 |\n\n### Calculation:\n\n```\nNet Income                              CHF 150,000\nAdjustments:\n  Depreciation                              +45,000\n  Gain on sale of equipment                  -8,000\n  Increase in Accounts Receivable           -25,000\n  Decrease in Inventory                     +12,000\n  Decrease in Prepaid Expenses               +3,000\n  Increase in Accounts Payable              +18,000\n  Decrease in Wages Payable                  -5,000\n                                        -----------\nNet Cash from Operating Activities      CHF 190,000\n```\n\n---\n\n## Memory Tricks\n\n### For Current Assets (A/R, Inventory, Prepaids)\n\n**Think: \"Using cash to build up assets\"**\n- If asset increases: Cash was used - SUBTRACT\n- If asset decreases: Cash was freed up - ADD\n\n### For Current Liabilities (A/P, Wages Payable)\n\n**Think: \"Delaying cash payment\"**\n- If liability increases: Cash was saved - ADD\n- If liability decreases: Cash was paid - SUBTRACT\n\n---\n\n## Common Mistakes\n\n1. **Forgetting depreciation** - Always add it back!\n2. **Wrong sign on gains** - Subtract gains, add losses\n3. **Wrong sign on working capital** - Use the rules consistently\n4. **Including interest and dividends received** - These are operating, but often forgotten\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Start with Net Income\n> - Add back depreciation (non-cash expense)\n> - Subtract gains / Add losses on asset sales\n> - Current assets increase = SUBTRACT\n> - Current liabilities increase = ADD\n> - Result must reconcile with change in cash"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 9.3: Investing and Financing Activities
(
  'fa900000-0000-0000-0009-000000000003',
  'fa000000-0000-0000-0000-000000000009',
  '9.3',
  3,
  'Investing and Financing Activities',
  'investing-financing-activities',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Investing and Financing Activities\n\n## Investing Activities (CFI)\n\n### Key Question\n\n> What did the company do with long-term assets and investments?\n\n### Common Items\n\n| Inflows (Sources) | Outflows (Uses) |\n|-------------------|------------------|\n| Sale of equipment | Purchase of equipment |\n| Sale of investments | Purchase of investments |\n| Collection of loans made | Making loans to others |\n| Sale of building/land | Purchase of building/land |\n\n### Example: Spacely Sprockets\n\n- Sold old equipment for CHF 25,000\n- Purchased new machinery for CHF 180,000\n- Bought investment securities for CHF 50,000\n\n```\nCash from Investing Activities:\n  Sale of equipment                  CHF  25,000\n  Purchase of machinery                (180,000)\n  Purchase of investments               (50,000)\n                                     -----------\nNet Cash Used in Investing         CHF (205,000)\n```\n\n---\n\n## Financing Activities (CFF)\n\n### Key Question\n\n> How did the company finance itself with debt and equity?\n\n### Common Items\n\n| Inflows (Sources) | Outflows (Uses) |\n|-------------------|------------------|\n| Issuing shares | Repurchasing shares |\n| Borrowing (loans, bonds) | Repaying loans |\n| | Paying dividends |\n\n### Example: Spacely Sprockets\n\n- Issued new shares for CHF 100,000\n- Repaid long-term debt of CHF 60,000\n- Paid dividends of CHF 30,000\n\n```\nCash from Financing Activities:\n  Proceeds from issuing shares      CHF 100,000\n  Repayment of long-term debt          (60,000)\n  Dividends paid                       (30,000)\n                                     -----------\nNet Cash from Financing             CHF  10,000\n```\n\n---\n\n## Complete CFS Example\n\n```\n              SPACELY SPROCKETS INC.\n              CASH FLOW STATEMENT\n     For the Year Ended December 31, 2024\n\nOPERATING ACTIVITIES:\n  Net Income                           CHF 150,000\n  Depreciation                              45,000\n  Increase in Accounts Receivable          (20,000)\n  Decrease in Inventory                     15,000\n  Increase in Accounts Payable              10,000\n                                         ---------\n  Net Cash from Operating                  200,000\n\nINVESTING ACTIVITIES:\n  Sale of equipment                         25,000\n  Purchase of machinery                   (180,000)\n  Purchase of investments                  (50,000)\n                                         ---------\n  Net Cash Used in Investing              (205,000)\n\nFINANCING ACTIVITIES:\n  Proceeds from issuing shares             100,000\n  Repayment of long-term debt              (60,000)\n  Dividends paid                           (30,000)\n                                         ---------\n  Net Cash from Financing                   10,000\n                                         =========\nNet Change in Cash                          5,000\nBeginning Cash                             50,000\n                                         ---------\nEnding Cash                            CHF 55,000\n```\n\n---\n\n## Linking to Balance Sheet\n\n| CFS Section | Balance Sheet Accounts |\n|-------------|------------------------|\n| Operating | Current assets/liabilities (except cash) |\n| Investing | Long-term assets |\n| Financing | Long-term liabilities, Equity |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Investing: PP&E purchases, sales, investments\n> - Financing: Debt and equity transactions\n> - Net change in cash must equal: Ending cash - Beginning cash\n> - This ties to the Balance Sheet"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 9.4: CFS Case Study - Wayne Enterprises
(
  'fa900000-0000-0000-0009-000000000004',
  'fa000000-0000-0000-0000-000000000009',
  '9.4',
  4,
  'CFS Case Study: Wayne Enterprises',
  'cfs-case-study-wayne-enterprises',
  'interactive',
  25,
  60,
  'basic',
  '{
    "title": "Build the Cash Flow Statement: Wayne Enterprises",
    "description": "Using comparative balance sheets and the income statement, prepare a complete Cash Flow Statement for Wayne Enterprises Inc.",
    "company_background": "Wayne Enterprises Inc. is a diversified technology and manufacturing conglomerate. Using the provided financial data, prepare the Cash Flow Statement using the indirect method.",
    "comparative_balance_sheet": {
      "assets": {
        "Cash": {"current": 85000, "prior": 50000},
        "Accounts Receivable": {"current": 120000, "prior": 95000},
        "Inventory": {"current": 180000, "prior": 210000},
        "Prepaid Expenses": {"current": 15000, "prior": 18000},
        "Equipment": {"current": 450000, "prior": 380000},
        "Accumulated Depreciation": {"current": -135000, "prior": -90000}
      },
      "liabilities_equity": {
        "Accounts Payable": {"current": 75000, "prior": 60000},
        "Wages Payable": {"current": 12000, "prior": 15000},
        "Notes Payable (long-term)": {"current": 150000, "prior": 200000},
        "Share Capital": {"current": 300000, "prior": 250000},
        "Retained Earnings": {"current": 178000, "prior": 138000}
      }
    },
    "income_statement": {
      "Sales Revenue": 650000,
      "Cost of Goods Sold": -380000,
      "Depreciation Expense": -45000,
      "Other Operating Expenses": -145000,
      "Gain on Sale of Equipment": 5000,
      "Net Income": 85000
    },
    "additional_info": [
      "Equipment with original cost of CHF 30,000 and accumulated depreciation of CHF 20,000 was sold for CHF 15,000",
      "New equipment was purchased during the year",
      "Dividends of CHF 45,000 were paid"
    ],
    "solution": {
      "operating": {
        "net_income": 85000,
        "depreciation": 45000,
        "gain_on_sale": -5000,
        "change_ar": -25000,
        "change_inventory": 30000,
        "change_prepaid": 3000,
        "change_ap": 15000,
        "change_wages": -3000,
        "total": 145000
      },
      "investing": {
        "sale_equipment": 15000,
        "purchase_equipment": -100000,
        "total": -85000
      },
      "financing": {
        "issue_shares": 50000,
        "repay_notes": -50000,
        "dividends": -45000,
        "total": -45000
      },
      "net_change": 15000,
      "beginning_cash": 50000,
      "ending_cash": 65000
    },
    "questions": [
      {
        "id": "we1",
        "question": "What is the Net Cash from Operating Activities?",
        "answer_type": "numeric",
        "correct_answer": 145000,
        "tolerance": 1000
      },
      {
        "id": "we2",
        "question": "What was the cost of equipment purchased?",
        "answer_type": "numeric",
        "correct_answer": 100000,
        "tolerance": 100,
        "hint": "Equipment increased by 70,000, but also sold equipment costing 30,000. So purchases = 70,000 + 30,000 = 100,000"
      },
      {
        "id": "we3",
        "question": "What is the Net Cash Used in Investing Activities?",
        "answer_type": "numeric",
        "correct_answer": -85000,
        "tolerance": 1000
      },
      {
        "id": "we4",
        "question": "What is the Net Change in Cash for the year?",
        "answer_type": "numeric",
        "correct_answer": 35000,
        "tolerance": 100,
        "hint": "Ending cash (85,000) - Beginning cash (50,000)"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'cfs-builder',
  false,
  true
),

-- Activity 9.5: Module 9 Checkpoint
(
  'fa900000-0000-0000-0009-000000000005',
  'fa000000-0000-0000-0000-000000000009',
  '9.5',
  5,
  'Module 9 Checkpoint',
  'module-9-checkpoint',
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
        "question": "Under the indirect method, depreciation expense is:",
        "options": [
          "Subtracted from Net Income",
          "Added to Net Income",
          "Shown in Investing Activities",
          "Not included in the Cash Flow Statement"
        ],
        "correct": 1,
        "explanation": "Depreciation is a non-cash expense that reduces Net Income. To get to cash flow, we ADD it back since no cash was actually spent."
      },
      {
        "id": "c2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "An increase in Accounts Receivable is:",
        "options": [
          "Added in Operating Activities",
          "Subtracted in Operating Activities",
          "Shown in Investing Activities",
          "Shown in Financing Activities"
        ],
        "correct": 1,
        "explanation": "An increase in A/R means sales were recorded but cash wasn''t received. This represents cash not collected, so we SUBTRACT it from Net Income in operating activities."
      },
      {
        "id": "c3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which of the following is a Financing Activity?",
        "options": [
          "Purchase of equipment",
          "Collection from customers",
          "Payment of dividends",
          "Sale of investments"
        ],
        "correct": 2,
        "explanation": "Dividends paid to shareholders is a financing activity (transaction with owners). Equipment purchase is investing; customer collections is operating."
      },
      {
        "id": "c4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A gain on sale of equipment in the indirect method is:",
        "options": [
          "Added to Net Income in Operating",
          "Subtracted from Net Income in Operating",
          "Shown as an inflow in Investing",
          "Both B and C"
        ],
        "correct": 3,
        "explanation": "The gain is SUBTRACTED from Net Income (to remove it from operating) because the full cash proceeds are reported in Investing Activities. So both B and C are correct."
      },
      {
        "id": "c5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Net Income is CHF 100,000. Depreciation is CHF 30,000. A/R decreased CHF 15,000. Inventory increased CHF 20,000. A/P increased CHF 10,000. Cash from Operations is:",
        "options": [
          "CHF 135,000",
          "CHF 115,000",
          "CHF 125,000",
          "CHF 145,000"
        ],
        "correct": 0,
        "explanation": "100,000 + 30,000 (depreciation) + 15,000 (A/R decrease) - 20,000 (inventory increase) + 10,000 (A/P increase) = CHF 135,000."
      }
    ],
    "passing_score": 75,
    "show_explanations": true
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- MODULE 10: Financial Analysis & Ratios
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 10.1: Financial Ratio Analysis
(
  'faa00000-0000-0000-000a-000000000001',
  'fa000000-0000-0000-0000-000000000010',
  '10.1',
  1,
  'Financial Ratio Analysis',
  'financial-ratio-analysis',
  'lesson',
  18,
  35,
  'basic',
  '{"markdown": "# Financial Ratio Analysis\n\n## Why This Matters\n\nAbsolute numbers don''t tell the whole story. A company with CHF 10 million in profit sounds good - but what if they have CHF 500 million in assets? Ratios provide context and enable meaningful comparison.\n\n---\n\n## Four Categories of Ratios\n\n| Category | Question Answered |\n|----------|-------------------|\n| Profitability | How efficiently does the company generate profit? |\n| Liquidity | Can the company pay short-term obligations? |\n| Solvency | Can the company meet long-term debt obligations? |\n| Efficiency | How well does the company use its assets? |\n\n---\n\n## Profitability Ratios\n\n### Gross Profit Margin\n\n```\nGross Profit Margin = Gross Profit / Net Sales\n```\n\nMeasures profitability after direct costs.\n\n### Operating Margin\n\n```\nOperating Margin = Operating Income / Net Sales\n```\n\nMeasures profitability from core operations.\n\n### Net Profit Margin\n\n```\nNet Profit Margin = Net Income / Net Sales\n```\n\nThe \"bottom line\" - what percentage of sales becomes profit.\n\n### Return on Assets (ROA)\n\n```\nROA = Net Income / Average Total Assets\n```\n\nHow efficiently the company uses ALL its assets.\n\n### Return on Equity (ROE)\n\n```\nROE = Net Income / Average Shareholders'' Equity\n```\n\nReturn generated for shareholders.\n\n---\n\n## Liquidity Ratios\n\n### Current Ratio\n\n```\nCurrent Ratio = Current Assets / Current Liabilities\n```\n\n- Above 1.0 = Can cover short-term obligations\n- Industry-dependent (retailers often below 1.0)\n\n### Quick Ratio (Acid Test)\n\n```\nQuick Ratio = (Current Assets - Inventory) / Current Liabilities\n```\n\nMore conservative - excludes inventory which may not be easily liquidated.\n\n---\n\n## Solvency Ratios\n\n### Debt-to-Equity Ratio\n\n```\nD/E = Total Liabilities / Total Shareholders'' Equity\n```\n\n- Higher = more leveraged (risky)\n- Industry norms vary widely\n\n### Interest Coverage Ratio\n\n```\nInterest Coverage = Operating Income (EBIT) / Interest Expense\n```\n\n- Can the company pay its interest?\n- Below 1.0 = Cannot cover interest from operations\n\n---\n\n## Efficiency Ratios\n\n### Inventory Turnover\n\n```\nInventory Turnover = COGS / Average Inventory\n```\n\nHow many times inventory is sold per year.\n\n### Days Inventory Outstanding (DIO)\n\n```\nDIO = 365 / Inventory Turnover\n```\n\nAverage days to sell inventory.\n\n### Receivables Turnover\n\n```\nReceivables Turnover = Net Credit Sales / Average A/R\n```\n\nHow quickly customers pay.\n\n### Days Sales Outstanding (DSO)\n\n```\nDSO = 365 / Receivables Turnover\n```\n\nAverage days to collect payment.\n\n---\n\n## Alpine Foods Example\n\n| Item | Amount |\n|------|--------|\n| Net Sales | CHF 500,000 |\n| COGS | 200,000 |\n| Net Income | 50,000 |\n| Total Assets | 400,000 |\n| Shareholders'' Equity | 250,000 |\n| Current Assets | 150,000 |\n| Current Liabilities | 100,000 |\n\n**Calculations:**\n\n| Ratio | Calculation | Result |\n|-------|-------------|--------|\n| Gross Profit Margin | (500-200)/500 | 60.0% |\n| Net Profit Margin | 50/500 | 10.0% |\n| ROA | 50/400 | 12.5% |\n| ROE | 50/250 | 20.0% |\n| Current Ratio | 150/100 | 1.50 |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Profitability: Margin ratios and ROA/ROE\n> - Liquidity: Current ratio, Quick ratio\n> - Solvency: D/E ratio, Interest coverage\n> - Efficiency: Turnover ratios and days outstanding\n> - Always compare to industry benchmarks and prior years"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 10.2: Du Pont Analysis
(
  'faa00000-0000-0000-000a-000000000002',
  'fa000000-0000-0000-0000-000000000010',
  '10.2',
  2,
  'Du Pont Analysis',
  'dupont-analysis',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Du Pont Analysis\n\n## Why This Matters\n\nROE tells you the return to shareholders, but not HOW the company achieves it. Du Pont breaks ROE into three components, revealing whether the company succeeds through profitability, efficiency, or leverage.\n\n---\n\n## The Du Pont Formula\n\n```\nROE = Net Profit Margin x Asset Turnover x Equity Multiplier\n\nROE = (Net Income/Sales) x (Sales/Assets) x (Assets/Equity)\n```\n\n### The Three Components\n\n| Component | Measures | Formula |\n|-----------|----------|---------|\n| **Net Profit Margin** | Profitability | Net Income / Sales |\n| **Asset Turnover** | Efficiency | Sales / Average Assets |\n| **Equity Multiplier** | Leverage | Average Assets / Average Equity |\n\n---\n\n## Understanding Each Driver\n\n### Net Profit Margin (Profitability)\n\n> How much of each sales dollar becomes profit?\n\n- Luxury goods: High margins (15-20%)\n- Grocery retail: Low margins (1-3%)\n\n### Asset Turnover (Efficiency)\n\n> How many sales dollars generated per dollar of assets?\n\n- Retail: High turnover (2-3x)\n- Real estate: Low turnover (0.2-0.5x)\n\n### Equity Multiplier (Leverage)\n\n> How much of the assets are funded by debt vs equity?\n\n- Assets/Equity = 1 means no debt\n- Assets/Equity = 2 means 50% debt\n- Higher leverage increases ROE but also risk\n\n---\n\n## Comparing Two Companies\n\n### Luxe Maison Group (Luxury)\n\n| Metric | Value |\n|--------|-------|\n| Net Profit Margin | 15% |\n| Asset Turnover | 0.8 |\n| Equity Multiplier | 1.5 |\n| **ROE** | **18%** |\n\n### Urban Apparel (Fast Fashion)\n\n| Metric | Value |\n|--------|-------|\n| Net Profit Margin | 5% |\n| Asset Turnover | 2.5 |\n| Equity Multiplier | 1.8 |\n| **ROE** | **22.5%** |\n\n### Analysis\n\n- Luxe Maison: High margins but slower asset turnover\n- Urban Apparel: Low margins but high turnover and more leverage\n\nBoth achieve similar ROE through different strategies!\n\n---\n\n## Extended Du Pont (5-Factor)\n\n```\nROE = (EBIT/Sales) x (Sales/Assets) x (Assets/Equity)\n      x (EBT/EBIT) x (Net Income/EBT)\n```\n\nAdds interest burden and tax burden for deeper analysis.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - ROE = Margin x Turnover x Leverage\n> - High margins can offset low turnover\n> - High turnover can offset low margins\n> - Leverage boosts ROE but increases risk\n> - Du Pont reveals the drivers behind ROE"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 10.3: Ratio Analysis Case Study
(
  'faa00000-0000-0000-000a-000000000003',
  'fa000000-0000-0000-0000-000000000010',
  '10.3',
  3,
  'Ratio Analysis: Alpine Foods',
  'ratio-analysis-alpine-foods',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Financial Analysis: Alpine Foods International",
    "description": "Analyze Alpine Foods International financial statements and calculate key ratios.",
    "financial_data": {
      "income_statement": {
        "net_sales": 12500000,
        "cogs": 6250000,
        "gross_profit": 6250000,
        "operating_expenses": 4375000,
        "operating_income": 1875000,
        "interest_expense": 250000,
        "income_before_tax": 1625000,
        "income_tax": 406250,
        "net_income": 1218750
      },
      "balance_sheet": {
        "current_assets": 3500000,
        "inventory": 1200000,
        "total_assets": 7500000,
        "current_liabilities": 2000000,
        "total_liabilities": 3750000,
        "shareholders_equity": 3750000
      },
      "additional": {
        "average_ar": 800000,
        "average_inventory": 1100000,
        "average_total_assets": 7000000,
        "average_equity": 3500000
      }
    },
    "questions": [
      {
        "id": "af1",
        "question": "Calculate the Gross Profit Margin (as a percentage)",
        "answer_type": "numeric",
        "correct_answer": 50.0,
        "tolerance": 0.5
      },
      {
        "id": "af2",
        "question": "Calculate the Net Profit Margin (as a percentage)",
        "answer_type": "numeric",
        "correct_answer": 9.75,
        "tolerance": 0.2
      },
      {
        "id": "af3",
        "question": "Calculate the Current Ratio",
        "answer_type": "numeric",
        "correct_answer": 1.75,
        "tolerance": 0.05
      },
      {
        "id": "af4",
        "question": "Calculate the Debt-to-Equity Ratio",
        "answer_type": "numeric",
        "correct_answer": 1.0,
        "tolerance": 0.05
      },
      {
        "id": "af5",
        "question": "Calculate Return on Equity (ROE) as a percentage",
        "answer_type": "numeric",
        "correct_answer": 34.82,
        "tolerance": 0.5
      },
      {
        "id": "af6",
        "question": "Calculate the Interest Coverage Ratio",
        "answer_type": "numeric",
        "correct_answer": 7.5,
        "tolerance": 0.2
      }
    ],
    "passing_score": 70
  }'::jsonb,
  'ratio-calculator',
  false,
  true
),

-- Activity 10.4: Module 10 Checkpoint
(
  'faa00000-0000-0000-000a-000000000004',
  'fa000000-0000-0000-0000-000000000010',
  '10.4',
  4,
  'Module 10 Checkpoint',
  'module-10-checkpoint',
  'checkpoint',
  15,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "c1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company has Net Income of CHF 200,000, Sales of CHF 2,000,000, and Average Assets of CHF 1,600,000. What is the Return on Assets (ROA)?",
        "options": [
          "10%",
          "12.5%",
          "8%",
          "80%"
        ],
        "correct": 1,
        "explanation": "ROA = Net Income / Average Assets = 200,000 / 1,600,000 = 12.5%."
      },
      {
        "id": "c2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "The Quick Ratio excludes which current asset from the numerator?",
        "options": [
          "Cash",
          "Accounts Receivable",
          "Inventory",
          "Prepaid Expenses"
        ],
        "correct": 2,
        "explanation": "Quick Ratio = (Current Assets - Inventory) / Current Liabilities. Inventory is excluded because it may not be quickly convertible to cash."
      },
      {
        "id": "c3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "In Du Pont analysis, ROE is decomposed into:",
        "options": [
          "Gross Margin x Asset Turnover",
          "Net Profit Margin x Asset Turnover x Equity Multiplier",
          "Operating Margin x Current Ratio",
          "Net Income / Sales / Assets"
        ],
        "correct": 1,
        "explanation": "Du Pont: ROE = Net Profit Margin x Asset Turnover x Equity Multiplier, or (NI/Sales) x (Sales/Assets) x (Assets/Equity)."
      },
      {
        "id": "c4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company has COGS of CHF 900,000 and Average Inventory of CHF 150,000. What is the Days Inventory Outstanding?",
        "options": [
          "6 days",
          "61 days",
          "45 days",
          "365 days"
        ],
        "correct": 1,
        "explanation": "Inventory Turnover = 900,000 / 150,000 = 6. DIO = 365 / 6 = 60.8 days, approximately 61 days."
      },
      {
        "id": "c5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "A higher equity multiplier indicates the company uses less financial leverage.",
        "correct": false,
        "explanation": "FALSE. Equity Multiplier = Assets / Equity. A higher multiplier means more assets are financed by debt (more leverage), not less."
      }
    ],
    "passing_score": 75,
    "show_explanations": true
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- MOCK FINAL EXAM
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, time_limit, is_published) VALUES

(
  'faf00000-0000-0000-00ff-000000000001',
  'fa000000-0000-0000-0000-000000000100',
  'final.1',
  1,
  'Mock Final Exam',
  'mock-final-exam-fa',
  'mock_exam',
  120,
  300,
  'basic',
  '{
    "title": "Financial Accounting Mock Final Exam",
    "description": "Comprehensive practice exam covering all course material with emphasis on Cash Flow Statement and Financial Analysis.",
    "instructions": "You have 120 minutes to complete this exam. Answer all 25 questions. Each question is worth 4 points. A score of 75% or higher is considered passing.",
    "questions": [
      {
        "id": "f1",
        "type": "mcq",
        "topic": "Accounting Equation",
        "question": "Alpine Foods has Assets of CHF 500,000 and Liabilities of CHF 180,000. During the year, Net Income is CHF 75,000 and Dividends of CHF 25,000 are declared. What is ending equity?",
        "options": ["CHF 320,000", "CHF 370,000", "CHF 395,000", "CHF 345,000"],
        "correct": 1,
        "explanation": "Beginning Equity = 500,000 - 180,000 = 320,000. Ending Equity = 320,000 + 75,000 - 25,000 = CHF 370,000."
      },
      {
        "id": "f2",
        "type": "mcq",
        "topic": "Journal Entries",
        "question": "Phantom Studios receives CHF 45,000 cash for a project to be completed next quarter. The journal entry is:",
        "options": [
          "Dr Cash 45,000; Cr Service Revenue 45,000",
          "Dr Cash 45,000; Cr Unearned Revenue 45,000",
          "Dr Accounts Receivable 45,000; Cr Service Revenue 45,000",
          "Dr Unearned Revenue 45,000; Cr Cash 45,000"
        ],
        "correct": 1,
        "explanation": "Cash received before service is performed creates a liability (Unearned Revenue). Revenue is recognized when the project is completed."
      },
      {
        "id": "f3",
        "type": "mcq",
        "topic": "Adjustments",
        "question": "Equipment costing CHF 90,000 with CHF 10,000 residual value has a 4-year life. If purchased on October 1, what is Year 1 depreciation (Dec 31 year-end)?",
        "options": ["CHF 20,000", "CHF 22,500", "CHF 5,000", "CHF 6,250"],
        "correct": 2,
        "explanation": "Annual = (90,000 - 10,000) / 4 = 20,000. Year 1: 3 months = 20,000 x 3/12 = CHF 5,000."
      },
      {
        "id": "f4",
        "type": "mcq",
        "topic": "Bad Debts",
        "question": "Using aging analysis, required allowance is CHF 18,000. Current balance is CHF 5,000 DEBIT. What is the adjusting entry?",
        "options": [
          "Dr Bad Debt Expense 18,000",
          "Dr Bad Debt Expense 13,000",
          "Dr Bad Debt Expense 23,000",
          "Cr Bad Debt Expense 5,000"
        ],
        "correct": 2,
        "explanation": "A debit balance means over-written. To reach +18,000 from -5,000 requires adding 23,000."
      },
      {
        "id": "f5",
        "type": "mcq",
        "topic": "Inventory",
        "question": "Which inventory method is NOT permitted under IFRS?",
        "options": ["FIFO", "LIFO", "Weighted Average", "Specific Identification"],
        "correct": 1,
        "explanation": "LIFO (Last-In, First-Out) is NOT permitted under IFRS, though it is allowed under US GAAP."
      },
      {
        "id": "f6",
        "type": "mcq",
        "topic": "Depreciation",
        "question": "Using double-declining balance, an asset costing CHF 80,000 with 5-year life has Year 2 depreciation of:",
        "options": ["CHF 32,000", "CHF 19,200", "CHF 16,000", "CHF 12,800"],
        "correct": 1,
        "explanation": "Rate = 2 x 1/5 = 40%. Year 1: 80,000 x 40% = 32,000. Year 2: (80,000 - 32,000) x 40% = 19,200."
      },
      {
        "id": "f7",
        "type": "mcq",
        "topic": "Asset Disposal",
        "question": "Equipment with cost CHF 60,000 and accumulated depreciation CHF 48,000 is sold for CHF 15,000. The result is:",
        "options": ["Gain of CHF 3,000", "Loss of CHF 3,000", "Gain of CHF 15,000", "No gain or loss"],
        "correct": 0,
        "explanation": "Book Value = 60,000 - 48,000 = 12,000. Gain = 15,000 - 12,000 = CHF 3,000."
      },
      {
        "id": "f8",
        "type": "mcq",
        "topic": "Bonds",
        "question": "A bond is issued at a premium when:",
        "options": [
          "Coupon rate < Market rate",
          "Coupon rate = Market rate",
          "Coupon rate > Market rate",
          "Face value < Issue price times 2"
        ],
        "correct": 2,
        "explanation": "When coupon rate exceeds market rate, investors pay more than face value (premium) for the higher interest payments."
      },
      {
        "id": "f9",
        "type": "mcq",
        "topic": "Equity",
        "question": "A company issues 10,000 shares with CHF 5 par value for CHF 40 each. Share Premium is:",
        "options": ["CHF 50,000", "CHF 350,000", "CHF 400,000", "CHF 450,000"],
        "correct": 1,
        "explanation": "Share Premium = (Issue price - Par) x Shares = (40 - 5) x 10,000 = CHF 350,000."
      },
      {
        "id": "f10",
        "type": "mcq",
        "topic": "Cash Flow - Operating",
        "question": "Under the indirect method, an increase in Accounts Payable is:",
        "options": [
          "Subtracted from Net Income",
          "Added to Net Income",
          "Shown in Investing Activities",
          "Shown in Financing Activities"
        ],
        "correct": 1,
        "explanation": "Increase in A/P = expenses recorded but cash not yet paid = cash saved. ADD to Net Income."
      },
      {
        "id": "f11",
        "type": "mcq",
        "topic": "Cash Flow - Investing",
        "question": "Which is an Investing Activity?",
        "options": [
          "Paying dividends",
          "Issuing bonds",
          "Purchasing equipment",
          "Paying suppliers"
        ],
        "correct": 2,
        "explanation": "Purchasing equipment is an investing activity (long-term asset acquisition). Dividends = Financing; Bonds = Financing; Suppliers = Operating."
      },
      {
        "id": "f12",
        "type": "mcq",
        "topic": "Cash Flow - Indirect",
        "question": "Net Income CHF 80,000; Depreciation CHF 25,000; A/R decreased CHF 10,000; Inventory increased CHF 15,000. Cash from Operations is:",
        "options": ["CHF 100,000", "CHF 90,000", "CHF 110,000", "CHF 80,000"],
        "correct": 0,
        "explanation": "80,000 + 25,000 + 10,000 - 15,000 = CHF 100,000."
      },
      {
        "id": "f13",
        "type": "mcq",
        "topic": "Ratios - Profitability",
        "question": "Net Income CHF 150,000, Average Equity CHF 1,000,000. ROE is:",
        "options": ["15%", "6.7%", "150%", "66.7%"],
        "correct": 0,
        "explanation": "ROE = Net Income / Average Equity = 150,000 / 1,000,000 = 15%."
      },
      {
        "id": "f14",
        "type": "mcq",
        "topic": "Ratios - Liquidity",
        "question": "Current Assets CHF 300,000 including Inventory CHF 120,000. Current Liabilities CHF 200,000. Quick Ratio is:",
        "options": ["1.50", "0.90", "1.00", "0.60"],
        "correct": 1,
        "explanation": "Quick Ratio = (Current Assets - Inventory) / Current Liabilities = (300,000 - 120,000) / 200,000 = 0.90."
      },
      {
        "id": "f15",
        "type": "mcq",
        "topic": "Du Pont",
        "question": "In Du Pont analysis, a company can improve ROE by:",
        "options": [
          "Decreasing asset turnover",
          "Increasing the equity multiplier",
          "Lowering profit margin",
          "Reducing leverage"
        ],
        "correct": 1,
        "explanation": "ROE = Margin x Turnover x Equity Multiplier. Increasing any factor increases ROE. Higher equity multiplier (more leverage) increases ROE."
      },
      {
        "id": "f16",
        "type": "true_false",
        "topic": "GAAP/IFRS",
        "question": "Under accrual accounting, revenue is recognized when cash is received from customers.",
        "correct": false,
        "explanation": "FALSE. Under accrual accounting, revenue is recognized when EARNED (performance obligation satisfied), regardless of when cash is received."
      },
      {
        "id": "f17",
        "type": "true_false",
        "topic": "Depreciation",
        "question": "Land is depreciated using the straight-line method over its estimated useful life.",
        "correct": false,
        "explanation": "FALSE. Land is NEVER depreciated because it does not wear out or have a finite useful life."
      },
      {
        "id": "f18",
        "type": "mcq",
        "topic": "Revenue Recognition",
        "question": "A hotel receives CHF 6,000 on Dec 1 for a 3-night stay Dec 28-30. As of Dec 31, how much revenue is recognized?",
        "options": ["CHF 6,000", "CHF 4,000", "CHF 2,000", "CHF 0"],
        "correct": 0,
        "explanation": "All 3 nights are in December (28, 29, 30), so all CHF 6,000 is earned and recognized by Dec 31."
      },
      {
        "id": "f19",
        "type": "mcq",
        "topic": "COGS",
        "question": "Beginning Inventory CHF 40,000; Purchases CHF 200,000; Freight-in CHF 8,000; Ending Inventory CHF 52,000. COGS is:",
        "options": ["CHF 196,000", "CHF 188,000", "CHF 200,000", "CHF 208,000"],
        "correct": 0,
        "explanation": "COGS = Beginning + Purchases + Freight-in - Ending = 40,000 + 200,000 + 8,000 - 52,000 = CHF 196,000."
      },
      {
        "id": "f20",
        "type": "mcq",
        "topic": "Financial Statement Linkage",
        "question": "Net Income on the Income Statement flows to which Balance Sheet account?",
        "options": ["Cash", "Share Capital", "Retained Earnings", "Accounts Receivable"],
        "correct": 2,
        "explanation": "Net Income increases Retained Earnings on the Balance Sheet. This is the primary link between the two statements."
      },
      {
        "id": "f21",
        "type": "mcq",
        "topic": "Interest Coverage",
        "question": "Operating Income CHF 250,000; Interest Expense CHF 50,000. The Interest Coverage Ratio is:",
        "options": ["5.0x", "0.2x", "4.0x", "5.0%"],
        "correct": 0,
        "explanation": "Interest Coverage = EBIT / Interest = 250,000 / 50,000 = 5.0 times."
      },
      {
        "id": "f22",
        "type": "mcq",
        "topic": "CFS Reconciliation",
        "question": "Beginning Cash CHF 40,000. CFO +CHF 90,000. CFI -CHF 60,000. CFF -CHF 20,000. Ending Cash is:",
        "options": ["CHF 50,000", "CHF 40,000", "CHF 70,000", "CHF 10,000"],
        "correct": 0,
        "explanation": "Ending Cash = 40,000 + 90,000 - 60,000 - 20,000 = CHF 50,000."
      },
      {
        "id": "f23",
        "type": "mcq",
        "topic": "Inventory Valuation",
        "question": "Inventory has cost CHF 25,000 and NRV of CHF 22,000. Under IFRS, it should be reported at:",
        "options": ["CHF 25,000", "CHF 22,000", "CHF 23,500", "CHF 47,000"],
        "correct": 1,
        "explanation": "IFRS requires inventory at lower of cost or NRV. Since NRV (22,000) < Cost (25,000), report at CHF 22,000."
      },
      {
        "id": "f24",
        "type": "mcq",
        "topic": "Efficiency Ratios",
        "question": "Net Credit Sales CHF 600,000; Average A/R CHF 50,000. Days Sales Outstanding is approximately:",
        "options": ["12 days", "30 days", "45 days", "60 days"],
        "correct": 1,
        "explanation": "A/R Turnover = 600,000 / 50,000 = 12. DSO = 365 / 12 = 30.4 days, approximately 30 days."
      },
      {
        "id": "f25",
        "type": "mcq",
        "topic": "Three Statement Integration",
        "question": "Which statement correctly describes the relationship among the three financial statements?",
        "options": [
          "Net Income appears on both the Income Statement and Cash Flow Statement",
          "Ending Cash on the CFS must equal Cash on the Balance Sheet",
          "Operating Cash Flow equals Net Income",
          "The Balance Sheet shows the change in equity during a period"
        ],
        "correct": 1,
        "explanation": "The ending cash balance calculated on the CFS must equal the cash reported on the Balance Sheet. This is a key reconciliation check."
      }
    ],
    "passing_score": 75,
    "show_explanations": true
  }'::jsonb,
  NULL,
  true,
  120,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;


