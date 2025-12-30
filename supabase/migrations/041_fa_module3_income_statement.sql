-- ============================================
-- Module 3: Understanding Profitability
-- GOLD STANDARD Content - Income Statement Mastery
-- Inspired by LVMH homework structure (anonymized)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 3.1: Introduction to the Income Statement
-- ============================================
(
  'fa300000-0000-0000-0003-000000000001',
  'fa000000-0000-0000-0000-000000000003',
  '3.1',
  1,
  'Introduction to the Income Statement',
  'introduction-income-statement',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Introduction to the Income Statement\n\n## Why This Matters\n\nWhile the balance sheet shows what a company owns and owes at a moment in time, the income statement tells the story of what happened over a period. Did the company make money? Where did revenue come from? What did it cost to operate?\n\n> The Income Statement answers: **How profitable was the company during this period?**\n\n---\n\n## What is the Income Statement?\n\n**Also called:** Profit & Loss Statement (P&L), Statement of Earnings, Statement of Operations\n\n**Purpose:** Reports revenues earned and expenses incurred over a specific period (month, quarter, year)\n\n**The Basic Formula:**\n\n```\n  REVENUES\n- EXPENSES\n= NET INCOME (or Net Loss)\n```\n\n---\n\n## Structure of the Multi-Step Income Statement\n\n```\n                    LUXE MAISON GROUP\n                    INCOME STATEMENT\n           For the Year Ended December 31, 2024\n\nSales Revenue                              CHF 2,500,000\nLess: Cost of Goods Sold                     (1,500,000)\n                                           -------------\nGROSS PROFIT                                  1,000,000\n\nOperating Expenses:\n  Selling Expenses                  250,000\n  Administrative Expenses           300,000\n  Depreciation Expense               80,000\n  Total Operating Expenses                     (630,000)\n                                           -------------\nOPERATING INCOME                                370,000\n\nOther Income (Expenses):\n  Interest Revenue                   10,000\n  Interest Expense                  (40,000)\n  Total Other                                   (30,000)\n                                           -------------\nINCOME BEFORE TAX                               340,000\nIncome Tax Expense                             (102,000)\n                                           -------------\nNET INCOME                                 CHF  238,000\n```\n\n---\n\n## Key Components Explained\n\n### 1. Revenue (Sales)\n\nThe money earned from selling goods or providing services.\n\n| Type | Description | Example |\n|------|-------------|---------|\n| **Sales Revenue** | From selling products | Selling luxury handbags |\n| **Service Revenue** | From providing services | Consulting fees |\n| **Other Revenue** | Incidental income | Rent from subletting space |\n\n### 2. Cost of Goods Sold (COGS)\n\nThe direct costs of producing goods sold.\n\n**For a manufacturer:** Raw materials + Labor + Manufacturing overhead\n**For a retailer:** Purchase cost of inventory sold\n\n### 3. Gross Profit\n\n```\nGross Profit = Revenue - Cost of Goods Sold\n\nGross Profit Margin = (Gross Profit / Revenue) x 100%\n```\n\nThis shows how much is left to cover other expenses after paying for the products.\n\n### 4. Operating Expenses\n\nCosts of running the business that aren''t directly tied to production:\n\n| Category | Examples |\n|----------|----------|\n| **Selling Expenses** | Advertising, sales commissions, delivery costs |\n| **General & Administrative** | Office rent, utilities, management salaries |\n| **Depreciation** | Allocation of asset cost over time |\n\n### 5. Operating Income\n\n```\nOperating Income = Gross Profit - Operating Expenses\n```\n\nAlso called **EBIT** (Earnings Before Interest and Taxes)\n\n### 6. Other Income/Expenses\n\nItems not from core operations:\n- Interest earned on investments\n- Interest paid on loans\n- Gains/losses on asset sales\n\n### 7. Income Tax Expense\n\nThe tax owed on the company''s profits.\n\n### 8. Net Income\n\nThe \"bottom line\" - what''s left for shareholders after all expenses.\n\n---\n\n## Revenue Recognition Under IFRS 15\n\n> Revenue is recognized when a company satisfies a performance obligation by transferring a promised good or service to a customer.\n\n### Five-Step Model\n\n1. **Identify the contract** with the customer\n2. **Identify performance obligations** in the contract\n3. **Determine transaction price**\n4. **Allocate price** to each performance obligation\n5. **Recognize revenue** when obligations are satisfied\n\n### Example: Software Company\n\nSells software (CHF 10,000) with 1-year support (CHF 2,000):\n- Software delivered: Recognize CHF 10,000 immediately\n- Support: Recognize CHF 2,000 over 12 months (CHF 167/month)\n\n---\n\n## Gross Profit Margin Analysis\n\nComparing gross profit margins reveals competitive advantages:\n\n| Company Type | Typical Gross Margin | Why |\n|--------------|---------------------|-----|\n| **Luxury goods** | 60-70% | Premium pricing power |\n| **Software** | 70-90% | Low marginal cost |\n| **Grocery retail** | 25-35% | High competition, commodity products |\n| **Airlines** | 40-50% | Fuel and labor costs |\n\n---\n\n## Common Mistakes\n\n### Mistake 1: Revenue Recognition Timing\nRecording revenue when cash is received instead of when earned.\n\n### Mistake 2: Mixing Up COGS and Operating Expenses\nCOGS = Direct product costs only. Rent for headquarters is an operating expense, not COGS.\n\n### Mistake 3: Confusing Gross Profit and Net Income\nGross profit doesn''t account for operating expenses, interest, or taxes.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Income Statement covers a PERIOD (not a point in time)\n> - Gross Profit = Revenue - COGS\n> - Operating Income = Gross Profit - Operating Expenses\n> - Net Income = Bottom line after all expenses and taxes\n> - Revenue is recognized when performance obligations are satisfied\n> - Gross margin varies significantly by industry"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 3.2: Revenue Recognition Deep Dive
-- ============================================
(
  'fa300000-0000-0000-0003-000000000002',
  'fa000000-0000-0000-0000-000000000003',
  '3.2',
  2,
  'Revenue Recognition Deep Dive',
  'revenue-recognition-deep-dive',
  'lesson',
  10,
  20,
  'basic',
  '{"markdown": "# Revenue Recognition Deep Dive\n\n## Why This Matters\n\nRevenue recognition is one of the most important - and most manipulated - areas of accounting. Getting it right is crucial for accurate financial statements and for passing your exam.\n\n---\n\n## The Core Principle\n\n> Revenue is recognized when a company satisfies a performance obligation by transferring control of a good or service to the customer.\n\n### What is \"Control\"?\n\nThe customer has control when they:\n- Can direct the use of the asset\n- Obtain substantially all remaining benefits\n- Bear the risks and rewards of ownership\n\n---\n\n## Point in Time vs. Over Time\n\n### Point in Time Recognition\n\n**When:** Control transfers at a specific moment\n\n**Examples:**\n- Selling a product in a retail store\n- Delivering goods to a customer\n- Completing a one-time service\n\n### Over Time Recognition\n\n**When:** The customer receives and consumes benefits as the company performs\n\n**Examples:**\n- Long-term construction contracts\n- Monthly subscription services\n- Annual maintenance agreements\n\n---\n\n## Worked Example: Alpine Foods Multi-Element Sale\n\n**Scenario:** Alpine Foods sells:\n- Food products worth CHF 100,000 (delivered now)\n- 2-year warranty service worth CHF 20,000\n\n**Analysis:**\n\n| Performance Obligation | Timing | Revenue |\n|------------------------|--------|--------|\n| Food products | At delivery | CHF 100,000 |\n| Warranty Year 1 | Over 12 months | CHF 10,000 |\n| Warranty Year 2 | Over next 12 months | CHF 10,000 |\n\n**Journal Entry at Delivery:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash/A/R | 120,000 | |\n| Sales Revenue | | 100,000 |\n| Unearned Revenue | | 20,000 |\n\n**Each month for 2 years:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Unearned Revenue | 833 | |\n| Service Revenue | | 833 |\n\n---\n\n## Special Scenarios\n\n### 1. Consignment Sales\n\n**Situation:** Goods are with a retailer but title hasn''t transferred\n\n**Recognition:** NO revenue until the consignee sells to the final customer\n\n### 2. Bill-and-Hold Arrangements\n\n**Situation:** Customer is billed but goods remain with seller\n\n**Recognition:** Revenue only if specific conditions are met (customer requests delay, goods are segregated, etc.)\n\n### 3. Right of Return\n\n**Situation:** Customer can return goods for refund\n\n**Recognition:** Estimate returns and recognize only expected net revenue\n\n---\n\n## Common Exam Scenarios\n\n| Scenario | When to Recognize Revenue |\n|----------|---------------------------|\n| Cash sale | At point of sale |\n| Sale on credit | When goods delivered (not when paid) |\n| Advance payment | When service/goods provided (not when cash received) |\n| Subscription | Ratably over subscription period |\n| Construction contract | Over time based on progress |\n| Layaway sale | When all payments made and goods delivered |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Revenue = when performance obligation is satisfied\n> - Point in time: Control transfers at a moment\n> - Over time: Benefits received as company performs\n> - Advance payments = Unearned Revenue (liability) until earned\n> - Multiple elements: Allocate and recognize separately"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 3.3: Cost of Goods Sold
-- ============================================
(
  'fa300000-0000-0000-0003-000000000003',
  'fa000000-0000-0000-0000-000000000003',
  '3.3',
  3,
  'Cost of Goods Sold',
  'cost-of-goods-sold',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Cost of Goods Sold (COGS)\n\n## Why This Matters\n\nCOGS is often the largest expense on the income statement. Understanding how to calculate and interpret it is essential for analyzing profitability.\n\n---\n\n## What is COGS?\n\n> **Cost of Goods Sold (COGS)** represents the direct costs of producing or purchasing the goods that were actually sold during the period.\n\n**Alternative names:** Cost of Sales, Cost of Revenue\n\n---\n\n## The COGS Formula\n\n```\n   Beginning Inventory\n + Purchases (or Cost of Goods Manufactured)\n = Cost of Goods Available for Sale\n - Ending Inventory\n = Cost of Goods Sold\n```\n\n### Visual Representation\n\n```\n        What we started with\n                +\n        What we bought/made\n                =\n        What was available\n                -\n        What''s still on shelves\n                =\n        What we sold (COGS)\n```\n\n---\n\n## Worked Example: Swiss Confections Co.\n\n**Given information for January:**\n- Beginning Inventory: CHF 50,000\n- Purchases during January: CHF 120,000\n- Ending Inventory: CHF 45,000\n\n**COGS Calculation:**\n\n```\n  Beginning Inventory      CHF  50,000\n+ Purchases                    120,000\n= Goods Available              170,000\n- Ending Inventory              45,000\n= Cost of Goods Sold       CHF 125,000\n```\n\n**If January Sales were CHF 200,000:**\n\n```\nGross Profit = 200,000 - 125,000 = CHF 75,000\nGross Margin = 75,000 / 200,000 = 37.5%\n```\n\n---\n\n## What''s Included in COGS?\n\n### For a Retailer (Merchandising Company)\n\n| Included in COGS | NOT in COGS |\n|------------------|-------------|\n| Purchase price of goods | Store rent |\n| Freight-in (shipping to you) | Sales salaries |\n| Import duties | Advertising |\n| Handling costs | Office expenses |\n\n### For a Manufacturer\n\n| Included in COGS | NOT in COGS |\n|------------------|-------------|\n| Raw materials | Administrative salaries |\n| Direct labor (factory workers) | Office rent |\n| Manufacturing overhead | Marketing |\n| Factory utilities | Distribution costs |\n\n---\n\n## Freight-In vs. Freight-Out\n\n### Freight-In (Shipping IN to the company)\n\n**Included in:** Cost of inventory / COGS\n\n**Why:** It''s a cost necessary to get inventory ready for sale\n\n### Freight-Out (Shipping OUT to customers)\n\n**Included in:** Operating Expenses (Selling Expenses)\n\n**Why:** It''s a cost of selling, not acquiring, inventory\n\n---\n\n## Inventory Systems\n\n### Perpetual System\n\n- Updates inventory continuously with each transaction\n- COGS recorded at time of each sale\n- Common with computerized systems\n\n### Periodic System\n\n- Updates inventory only at period end\n- COGS calculated using the formula above\n- Simpler but less timely information\n\n---\n\n## Impact on Gross Profit\n\n### Scenario Analysis: Urban Apparel Co.\n\n**Given:** Sales = CHF 500,000, Beginning Inventory = CHF 80,000, Purchases = CHF 300,000\n\n| Ending Inventory | COGS | Gross Profit | Gross Margin |\n|------------------|------|--------------|---------------|\n| CHF 60,000 | 320,000 | 180,000 | 36.0% |\n| CHF 80,000 | 300,000 | 200,000 | 40.0% |\n| CHF 100,000 | 280,000 | 220,000 | 44.0% |\n\n**Key Insight:** Higher ending inventory = Lower COGS = Higher gross profit\n\nThis is why inventory valuation methods (FIFO, LIFO, etc.) are so important!\n\n---\n\n## Common Mistakes\n\n### Mistake 1: Including operating expenses in COGS\nStore rent is NOT part of COGS even though it''s needed to sell goods.\n\n### Mistake 2: Confusing freight-in and freight-out\nFreight-in is part of inventory cost; freight-out is a selling expense.\n\n### Mistake 3: Forgetting to adjust for inventory changes\nCOGS is NOT just what you purchased - you must account for beginning and ending inventory.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - COGS = Beginning Inventory + Purchases - Ending Inventory\n> - Only DIRECT costs of goods sold are included\n> - Freight-in is part of COGS; Freight-out is an operating expense\n> - Higher ending inventory = Lower COGS = Higher profit\n> - Gross Profit = Sales - COGS"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 3.4: Income Statement Quiz
-- ============================================
(
  'fa300000-0000-0000-0003-000000000004',
  'fa000000-0000-0000-0000-000000000003',
  '3.4',
  4,
  'Income Statement Quiz',
  'income-statement-quiz',
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
        "question": "What does the Income Statement show?",
        "options": [
          "Assets, liabilities, and equity at a point in time",
          "Cash inflows and outflows during a period",
          "Revenues earned and expenses incurred during a period",
          "Changes in shareholders'' equity during a period"
        ],
        "correct": 2,
        "explanation": "The Income Statement (also called P&L) shows revenues earned and expenses incurred during a specific period, resulting in net income or net loss."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "How is Gross Profit calculated?",
        "options": [
          "Revenue minus Operating Expenses",
          "Revenue minus Cost of Goods Sold",
          "Revenue minus All Expenses",
          "Revenue minus Interest Expense"
        ],
        "correct": 1,
        "explanation": "Gross Profit = Revenue - Cost of Goods Sold. It represents the profit before operating expenses are deducted."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which of the following is typically included in Cost of Goods Sold for a retailer?",
        "options": [
          "Store rent",
          "Sales commissions",
          "Purchase cost of inventory",
          "Advertising"
        ],
        "correct": 2,
        "explanation": "COGS for a retailer includes the purchase cost of inventory sold. Rent, commissions, and advertising are operating expenses, not COGS."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Golden Bear Candy has Beginning Inventory CHF 40,000, Purchases CHF 180,000, and Ending Inventory CHF 55,000. What is COGS?",
        "options": [
          "CHF 165,000",
          "CHF 175,000",
          "CHF 195,000",
          "CHF 220,000"
        ],
        "correct": 0,
        "explanation": "COGS = Beginning (40,000) + Purchases (180,000) - Ending (55,000) = CHF 165,000."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A company receives CHF 24,000 in January for a 12-month service contract starting in January. How much revenue should be recognized in January?",
        "options": [
          "CHF 24,000",
          "CHF 12,000",
          "CHF 2,000",
          "CHF 0"
        ],
        "correct": 2,
        "explanation": "Revenue is recognized as the service is performed. For a 12-month contract, January revenue = 24,000 / 12 = CHF 2,000. The remaining 22,000 is Unearned Revenue."
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Freight costs to ship goods TO the company (freight-in) should be included in Cost of Goods Sold.",
        "correct": true,
        "explanation": "TRUE. Freight-in is part of the cost of acquiring inventory and is included in COGS. Freight-out (shipping to customers) is an operating expense."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Luxe Maison Group has: Sales CHF 500,000; COGS CHF 200,000; Operating Expenses CHF 180,000; Interest Expense CHF 20,000; Tax Rate 30%. What is Net Income?",
        "options": [
          "CHF 70,000",
          "CHF 100,000",
          "CHF 120,000",
          "CHF 300,000"
        ],
        "correct": 0,
        "explanation": "Gross Profit = 500,000 - 200,000 = 300,000. Operating Income = 300,000 - 180,000 = 120,000. Income Before Tax = 120,000 - 20,000 = 100,000. Tax = 100,000 x 30% = 30,000. Net Income = 100,000 - 30,000 = CHF 70,000."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which statement about Operating Income is CORRECT?",
        "options": [
          "It includes interest income and expense",
          "It is also known as EBIT (Earnings Before Interest and Taxes)",
          "It equals Net Income minus dividends",
          "It is always higher than Net Income"
        ],
        "correct": 1,
        "explanation": "Operating Income is also called EBIT (Earnings Before Interest and Taxes). It excludes interest and taxes. It is typically higher than net income (unless there is significant other income)."
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Alpine Foods has a Gross Profit Margin of 40% and Net Sales of CHF 750,000. What is the Cost of Goods Sold?",
        "options": [
          "CHF 300,000",
          "CHF 450,000",
          "CHF 500,000",
          "CHF 750,000"
        ],
        "correct": 1,
        "explanation": "If Gross Profit Margin is 40%, then COGS is 60% of sales. COGS = 750,000 x 60% = CHF 450,000. (Check: Gross Profit = 750,000 - 450,000 = 300,000 = 40% of 750,000)."
      },
      {
        "id": "q10",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Under IFRS 15, revenue from a magazine subscription should be recognized entirely when cash is received.",
        "correct": false,
        "explanation": "FALSE. Magazine subscriptions involve performance obligations over time. Revenue should be recognized as each magazine is delivered (e.g., monthly), not when cash is received upfront."
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
-- Activity 3.5: Case Study - Luxe Maison Group Analysis
-- ============================================
(
  'fa300000-0000-0000-0003-000000000005',
  'fa000000-0000-0000-0000-000000000003',
  '3.5',
  5,
  'Case Study: Luxe Maison Group',
  'case-study-luxe-maison',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Analyzing Luxe Maison Group",
    "description": "Luxe Maison Group is a global luxury goods conglomerate with fashion, jewelry, and spirits divisions. Analyze their income statement and answer questions about profitability.",
    "company_background": "Luxe Maison Group (LMG) is a fictional luxury conglomerate inspired by European luxury brands. Headquartered in Geneva, they operate in 60 countries with over 4,000 boutiques. Their brands include high-end fashion, jewelry, watches, and premium spirits.",
    "financial_data": {
      "year": 2024,
      "income_statement": {
        "revenue": 86500000000,
        "cogs": 29410000000,
        "gross_profit": 57090000000,
        "selling_expenses": 28150000000,
        "admin_expenses": 8650000000,
        "other_operating": 1730000000,
        "operating_income": 18560000000,
        "interest_income": 520000000,
        "interest_expense": 780000000,
        "other_income": 350000000,
        "income_before_tax": 18650000000,
        "tax_expense": 4662500000,
        "net_income": 13987500000
      },
      "prior_year": {
        "revenue": 79200000000,
        "cogs": 26532000000,
        "gross_profit": 52668000000,
        "operating_income": 15840000000,
        "net_income": 11880000000
      }
    },
    "questions": [
      {
        "id": "lm1",
        "question": "Calculate the Gross Profit Margin for 2024 (as a percentage, rounded to 1 decimal place)",
        "answer_type": "numeric",
        "correct_answer": 66.0,
        "tolerance": 0.2,
        "hint": "Gross Profit Margin = (Gross Profit / Revenue) x 100",
        "explanation": "Gross Profit Margin = 57,090 / 86,500 x 100 = 66.0%. This is typical for luxury goods companies with strong pricing power."
      },
      {
        "id": "lm2",
        "question": "Calculate the Operating Margin for 2024 (as a percentage, rounded to 1 decimal place)",
        "answer_type": "numeric",
        "correct_answer": 21.5,
        "tolerance": 0.2,
        "hint": "Operating Margin = (Operating Income / Revenue) x 100",
        "explanation": "Operating Margin = 18,560 / 86,500 x 100 = 21.5%. This indicates efficient cost control while maintaining luxury positioning."
      },
      {
        "id": "lm3",
        "question": "What is the year-over-year revenue growth percentage?",
        "answer_type": "numeric",
        "correct_answer": 9.2,
        "tolerance": 0.2,
        "hint": "(Current Revenue - Prior Revenue) / Prior Revenue x 100",
        "explanation": "Growth = (86,500 - 79,200) / 79,200 x 100 = 9.2%. Strong organic growth for a mature luxury company."
      },
      {
        "id": "lm4",
        "question": "What is the Net Profit Margin for 2024 (as a percentage)?",
        "answer_type": "numeric",
        "correct_answer": 16.2,
        "tolerance": 0.2,
        "hint": "Net Profit Margin = (Net Income / Revenue) x 100",
        "explanation": "Net Profit Margin = 13,987.5 / 86,500 x 100 = 16.2%. Luxury companies typically achieve higher net margins."
      },
      {
        "id": "lm5",
        "question": "By how much did Net Income grow year-over-year (in billions CHF)?",
        "answer_type": "numeric",
        "correct_answer": 2.1,
        "tolerance": 0.1,
        "hint": "Current Net Income - Prior Net Income",
        "explanation": "Net Income Growth = 13,987.5 - 11,880 = CHF 2,107.5 million = ~CHF 2.1 billion."
      }
    ],
    "analysis_summary": "Luxe Maison Group demonstrates the hallmarks of a successful luxury goods company: high gross margins (66%) from premium pricing, strong operating margins (21.5%) from brand power, and healthy net margins (16.2%). The 9.2% revenue growth suggests continued demand for luxury products despite economic uncertainties.",
    "passing_score": 80
  }'::jsonb,
  'ratio-calculator',
  false,
  true
),

-- ============================================
-- Activity 3.6: Module 3 Checkpoint
-- ============================================
(
  'fa300000-0000-0000-0003-000000000006',
  'fa000000-0000-0000-0000-000000000003',
  '3.6',
  6,
  'Module 3 Checkpoint',
  'module-3-checkpoint',
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
        "question": "Swiss Confections Co. has Sales of CHF 800,000, Beginning Inventory CHF 100,000, Purchases CHF 450,000, Ending Inventory CHF 150,000, and Operating Expenses CHF 180,000. What is Operating Income?",
        "options": [
          "CHF 220,000",
          "CHF 400,000",
          "CHF 300,000",
          "CHF 120,000"
        ],
        "correct": 0,
        "explanation": "COGS = 100,000 + 450,000 - 150,000 = 400,000. Gross Profit = 800,000 - 400,000 = 400,000. Operating Income = 400,000 - 180,000 = CHF 220,000."
      },
      {
        "id": "c2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Under IFRS 15, when should a hotel recognize revenue for a room booking paid 3 months in advance?",
        "options": [
          "When the deposit is received",
          "When the reservation is confirmed",
          "When the guest stays at the hotel",
          "At the end of the fiscal year"
        ],
        "correct": 2,
        "explanation": "Under IFRS 15, revenue is recognized when the performance obligation is satisfied - when the hotel provides the room (i.e., when the guest stays). The advance payment is recorded as Unearned Revenue until then."
      },
      {
        "id": "c3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Alpine Foods has a Gross Profit of CHF 2,400,000 and a Gross Profit Margin of 60%. What is their Cost of Goods Sold?",
        "options": [
          "CHF 1,440,000",
          "CHF 1,600,000",
          "CHF 2,400,000",
          "CHF 4,000,000"
        ],
        "correct": 1,
        "explanation": "If Gross Profit Margin = 60%, then Gross Profit = 60% of Revenue. So Revenue = 2,400,000 / 0.60 = 4,000,000. COGS = Revenue - Gross Profit = 4,000,000 - 2,400,000 = CHF 1,600,000."
      },
      {
        "id": "c4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which of the following would be classified as an Operating Expense (not COGS)?",
        "options": [
          "Factory workers'' wages in a manufacturing company",
          "Raw materials used in production",
          "Advertising and marketing costs",
          "Freight-in on purchased inventory"
        ],
        "correct": 2,
        "explanation": "Advertising and marketing are selling expenses (operating expenses). Factory wages and raw materials are part of manufacturing cost (COGS). Freight-in is part of inventory cost (COGS)."
      },
      {
        "id": "c5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company has: Revenue CHF 1,000,000; COGS CHF 400,000; Operating Expenses CHF 300,000; Interest Expense CHF 50,000; Tax Rate 25%. Net Income is:",
        "options": [
          "CHF 187,500",
          "CHF 200,000",
          "CHF 225,000",
          "CHF 300,000"
        ],
        "correct": 0,
        "explanation": "Gross Profit = 1,000,000 - 400,000 = 600,000. Operating Income = 600,000 - 300,000 = 300,000. Income Before Tax = 300,000 - 50,000 = 250,000. Tax = 250,000 x 25% = 62,500. Net Income = 250,000 - 62,500 = CHF 187,500."
      },
      {
        "id": "c6",
        "type": "true_false",
        "difficulty": "exam",
        "question": "A company that increases its ending inventory while purchases remain constant will report lower Cost of Goods Sold and higher Gross Profit.",
        "correct": true,
        "explanation": "TRUE. COGS = Beginning Inventory + Purchases - Ending Inventory. If ending inventory increases (with purchases constant), COGS decreases, which increases Gross Profit."
      },
      {
        "id": "c7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Phantom Studios receives CHF 60,000 for a video production contract. They complete 40% of the work by year-end. Under percentage-of-completion (over time recognition), how much revenue should be recognized?",
        "options": [
          "CHF 0",
          "CHF 24,000",
          "CHF 36,000",
          "CHF 60,000"
        ],
        "correct": 1,
        "explanation": "If the customer receives benefits as work is performed (over time recognition), revenue is recognized based on progress. 40% complete x CHF 60,000 = CHF 24,000 revenue recognized."
      },
      {
        "id": "c8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which ratio best indicates a company''s ability to convert sales into profit after covering direct product costs?",
        "options": [
          "Net Profit Margin",
          "Return on Equity",
          "Gross Profit Margin",
          "Operating Margin"
        ],
        "correct": 2,
        "explanation": "Gross Profit Margin (Gross Profit / Revenue) measures profitability after deducting only direct product costs (COGS). Operating Margin includes operating expenses; Net Profit Margin includes all expenses."
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


