-- ============================================
-- Modules 5-6 and Mock Midterm
-- Revenue & Receivables, Inventory, Mock Midterm
-- ============================================

-- ============================================
-- MODULE 5: Revenue & Receivables
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 5.1: Accounts Receivable Management
(
  'fa500000-0000-0000-0005-000000000001',
  'fa000000-0000-0000-0000-000000000005',
  '5.1',
  1,
  'Accounts Receivable Management',
  'accounts-receivable-management',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Accounts Receivable Management\n\n## Why This Matters\n\nWhen a business sells on credit, it creates an account receivable - a promise from the customer to pay later. Managing these receivables effectively is crucial for cash flow and profitability.\n\n---\n\n## What is Accounts Receivable?\n\n> **Accounts Receivable (A/R)** represents amounts owed to a company by customers for goods or services sold on credit.\n\n### The Credit Sale Cycle\n\n```\n1. Sell goods/services on credit\n           |\n           v\n2. Record A/R and Revenue\n           |\n           v\n3. Customer pays within terms\n           |\n           v\n4. Convert A/R to Cash\n```\n\n---\n\n## Recording Credit Sales\n\n### Initial Sale\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Accounts Receivable | X | |\n| Sales Revenue | | X |\n\n### Customer Payment\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | X | |\n| Accounts Receivable | | X |\n\n---\n\n## Credit Terms\n\n### Common Terms Explained\n\n| Term | Meaning |\n|------|--------|\n| **Net 30** | Full amount due in 30 days |\n| **2/10, Net 30** | 2% discount if paid in 10 days, otherwise full amount in 30 days |\n| **1/15, Net 45** | 1% discount if paid in 15 days, otherwise full in 45 days |\n\n### Example: Sales Discount\n\nSale of CHF 10,000 with terms 2/10, Net 30\n\n**If customer pays within 10 days:**\n- Discount = 10,000 x 2% = CHF 200\n- Customer pays: CHF 9,800\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 9,800 | |\n| Sales Discounts | 200 | |\n| Accounts Receivable | | 10,000 |\n\n---\n\n## The Problem: Uncollectible Accounts\n\nNot every customer pays. Some accounts become **bad debts** (uncollectible).\n\n### Two Methods of Accounting\n\n1. **Direct Write-Off Method** - Record bad debt when specific account identified as uncollectible (NOT GAAP compliant for significant receivables)\n\n2. **Allowance Method** - Estimate uncollectible amounts in advance (GAAP/IFRS required)\n\n---\n\n## The Allowance Method\n\n### Key Accounts\n\n- **Allowance for Doubtful Accounts** - Contra-asset (credit balance)\n- **Bad Debt Expense** - Operating expense\n\n### Net Realizable Value\n\n```\nNet Realizable Value = Gross A/R - Allowance for Doubtful Accounts\n```\n\nThis represents what the company actually expects to collect.\n\n---\n\n## Estimating Bad Debts\n\n### Method 1: Percentage of Sales\n\nBased on historical experience with credit sales.\n\n**Example:** Credit sales of CHF 500,000, historical bad debt rate of 2%\n\nBad Debt Expense = 500,000 x 2% = CHF 10,000\n\n### Method 2: Aging of Receivables\n\nGroups receivables by how long they''ve been outstanding.\n\n| Age | Amount | Est. % Uncollectible | Estimated Bad Debt |\n|-----|--------|---------------------|--------------------|\n| 0-30 days | 100,000 | 1% | 1,000 |\n| 31-60 days | 50,000 | 5% | 2,500 |\n| 61-90 days | 30,000 | 15% | 4,500 |\n| Over 90 days | 20,000 | 40% | 8,000 |\n| **Total** | **200,000** | | **16,000** |\n\nThe aging method calculates the required ending balance for the Allowance account.\n\n---\n\n## Recording Bad Debts\n\n### Adjusting Entry (at period end)\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Bad Debt Expense | X | |\n| Allowance for Doubtful Accounts | | X |\n\n### Writing Off a Specific Account\n\nWhen a customer definitely won''t pay:\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Allowance for Doubtful Accounts | X | |\n| Accounts Receivable | | X |\n\n**Note:** Write-offs don''t affect the income statement or net A/R!\n\n---\n\n## Balance Sheet Presentation\n\n```\nCurrent Assets:\n  Accounts Receivable              CHF 200,000\n  Less: Allowance for Doubtful         (16,000)\n  Accounts Receivable, net         CHF 184,000\n```\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - A/R recorded at time of credit sale, not when cash received\n> - Allowance Method required by GAAP/IFRS\n> - Net Realizable Value = Gross A/R - Allowance\n> - Bad Debt Expense is an estimate, recorded with adjusting entry\n> - Write-offs reduce both A/R and Allowance (no income statement impact)"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.2: Bad Debt Estimation Case
(
  'fa500000-0000-0000-0005-000000000002',
  'fa000000-0000-0000-0000-000000000005',
  '5.2',
  2,
  'Bad Debt Estimation: Riverside Electronics',
  'bad-debt-estimation-riverside',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Bad Debt Estimation: Riverside Electronics",
    "description": "Riverside Electronics sells consumer electronics on credit. Prepare the bad debt adjusting entry using the aging of receivables method.",
    "company_background": "Riverside Electronics is a regional electronics retailer with CHF 2.5 million in annual credit sales. They use the aging method to estimate uncollectible accounts.",
    "aging_schedule": {
      "current_30": {"amount": 180000, "percent": 1},
      "31_60": {"amount": 85000, "percent": 4},
      "61_90": {"amount": 42000, "percent": 12},
      "91_120": {"amount": 28000, "percent": 25},
      "over_120": {"amount": 15000, "percent": 50}
    },
    "allowance_before": 8500,
    "questions": [
      {
        "id": "rd1",
        "question": "Calculate the total estimated uncollectible amount from the aging schedule.",
        "answer_type": "numeric",
        "correct_answer": 18690,
        "tolerance": 10,
        "calculation": "1,800 + 3,400 + 5,040 + 7,000 + 7,500 = 18,690 (Note: calculation is 180,000*1% + 85,000*4% + 42,000*12% + 28,000*25% + 15,000*50%)"
      },
      {
        "id": "rd2",
        "question": "The existing Allowance balance is CHF 8,500. What amount should be debited to Bad Debt Expense?",
        "answer_type": "numeric",
        "correct_answer": 10190,
        "tolerance": 10,
        "explanation": "Required balance (18,690) - Existing balance (8,500) = CHF 10,190 adjustment needed"
      },
      {
        "id": "rd3",
        "question": "What is the Net Realizable Value of Accounts Receivable after the adjustment?",
        "answer_type": "numeric",
        "correct_answer": 331310,
        "tolerance": 10,
        "calculation": "Total A/R (350,000) - Allowance (18,690) = CHF 331,310"
      }
    ],
    "journal_entry_solution": {
      "debit_account": "Bad Debt Expense",
      "debit_amount": 10190,
      "credit_account": "Allowance for Doubtful Accounts",
      "credit_amount": 10190
    },
    "passing_score": 80
  }'::jsonb,
  'bad-debt-calculator',
  false,
  true
),

-- Activity 5.3: Module 5 Quiz
(
  'fa500000-0000-0000-0005-000000000003',
  'fa000000-0000-0000-0000-000000000005',
  '5.3',
  3,
  'Revenue & Receivables Quiz',
  'revenue-receivables-quiz',
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
        "question": "Under the allowance method, when a specific customer account is written off as uncollectible:",
        "options": [
          "Bad Debt Expense increases",
          "Net Accounts Receivable decreases",
          "Net Accounts Receivable stays the same",
          "Total Assets increase"
        ],
        "correct": 2,
        "explanation": "A write-off decreases both Accounts Receivable and Allowance for Doubtful Accounts by the same amount. Net A/R (Gross A/R minus Allowance) stays the same. No expense is recorded at write-off time."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Alpine Foods has Gross A/R of CHF 250,000 and an Allowance for Doubtful Accounts of CHF 12,000. What is the Net Realizable Value?",
        "options": [
          "CHF 262,000",
          "CHF 250,000",
          "CHF 238,000",
          "CHF 12,000"
        ],
        "correct": 2,
        "explanation": "Net Realizable Value = Gross A/R - Allowance = 250,000 - 12,000 = CHF 238,000."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A CHF 50,000 sale with terms 2/10, Net 30 is paid within 10 days. How much cash is received?",
        "options": [
          "CHF 50,000",
          "CHF 49,000",
          "CHF 48,000",
          "CHF 51,000"
        ],
        "correct": 1,
        "explanation": "2% discount on CHF 50,000 = CHF 1,000. Customer pays 50,000 - 1,000 = CHF 49,000."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Using the aging method, a company determines that CHF 25,000 is the required balance for Allowance for Doubtful Accounts. The current balance is CHF 7,000 (credit). The adjusting entry should:",
        "options": [
          "Debit Bad Debt Expense CHF 25,000",
          "Debit Bad Debt Expense CHF 18,000",
          "Debit Bad Debt Expense CHF 7,000",
          "Credit Bad Debt Expense CHF 18,000"
        ],
        "correct": 1,
        "explanation": "The aging method determines the required ENDING balance. Adjustment = Required (25,000) - Current (7,000) = CHF 18,000 additional expense needed."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "When using the percentage of sales method, the existing balance in the Allowance account is ignored when calculating Bad Debt Expense.",
        "correct": true,
        "explanation": "TRUE. The percentage of sales method calculates the expense directly from sales, without adjusting for the existing allowance balance. This is different from the aging method, which calculates the required ending balance."
      }
    ],
    "passing_score": 70,
    "show_explanations": true
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.4: Module 5 Checkpoint
(
  'fa500000-0000-0000-0005-000000000004',
  'fa000000-0000-0000-0000-000000000005',
  '5.4',
  4,
  'Module 5 Checkpoint',
  'module-5-checkpoint',
  'checkpoint',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "c1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Swiss Confections has credit sales of CHF 800,000 and estimates 1.5% will be uncollectible. The Allowance account has a CHF 3,000 credit balance before adjustment. Using the percentage of sales method, what is Bad Debt Expense?",
        "options": [
          "CHF 12,000",
          "CHF 9,000",
          "CHF 15,000",
          "CHF 3,000"
        ],
        "correct": 0,
        "explanation": "Percentage of sales method: 800,000 x 1.5% = CHF 12,000. The existing balance is NOT considered with this method."
      },
      {
        "id": "c2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "The aging schedule shows required allowance of CHF 20,000. The current Allowance balance is CHF 4,000 DEBIT (due to write-offs exceeding estimates). What is the adjusting entry?",
        "options": [
          "Debit Bad Debt Expense CHF 20,000",
          "Debit Bad Debt Expense CHF 16,000",
          "Debit Bad Debt Expense CHF 24,000",
          "Credit Bad Debt Expense CHF 4,000"
        ],
        "correct": 2,
        "explanation": "A debit balance means the allowance is \"overdrawn.\" To get from -4,000 to +20,000 requires adding 24,000: (-4,000) + 24,000 = 20,000."
      },
      {
        "id": "c3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Riverside Electronics writes off a CHF 5,000 receivable. Before the write-off, Gross A/R was CHF 150,000 and Allowance was CHF 12,000. After the write-off, Net A/R is:",
        "options": [
          "CHF 133,000",
          "CHF 138,000",
          "CHF 145,000",
          "CHF 140,000"
        ],
        "correct": 1,
        "explanation": "After write-off: Gross A/R = 150,000 - 5,000 = 145,000. Allowance = 12,000 - 5,000 = 7,000. Net A/R = 145,000 - 7,000 = CHF 138,000. (Same as before write-off: 150,000 - 12,000 = 138,000)"
      },
      {
        "id": "c4",
        "type": "true_false",
        "difficulty": "exam",
        "question": "A sale with terms 3/15, Net 45 means the customer can take a 3% discount if they pay within 15 days; otherwise, the full amount is due in 45 days.",
        "correct": true,
        "explanation": "TRUE. Credit terms format: [discount%]/[discount days], Net [total days]. 3/15, Net 45 = 3% discount if paid in 15 days, otherwise full payment due in 45 days."
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
-- MODULE 6: Inventory Deep Dive
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 6.1: Inventory Cost Flow Assumptions
(
  'fa600000-0000-0000-0006-000000000001',
  'fa000000-0000-0000-0000-000000000006',
  '6.1',
  1,
  'Inventory Cost Flow Assumptions',
  'inventory-cost-flow-assumptions',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Inventory Cost Flow Assumptions\n\n## Why This Matters\n\nWhen a company buys the same product multiple times at different prices, which cost goes to COGS when they sell one? The answer significantly impacts reported profit and taxes.\n\n---\n\n## The Problem\n\nUrban Apparel Co. buys jeans at different prices throughout the year:\n\n| Purchase | Units | Cost/Unit | Total |\n|----------|-------|-----------|-------|\n| January | 100 | CHF 40 | 4,000 |\n| April | 100 | CHF 45 | 4,500 |\n| August | 100 | CHF 50 | 5,000 |\n| **Total** | **300** | | **13,500** |\n\nThey sell 200 units. What is COGS?\n\n**Answer:** It depends on the inventory cost flow assumption!\n\n---\n\n## Three Methods Under IFRS\n\n### 1. FIFO (First-In, First-Out)\n\nAssumes oldest costs are sold first.\n\n### 2. Weighted Average Cost\n\nUses average cost for all units.\n\n### 3. Specific Identification\n\nTracks actual cost of each specific item.\n\n**Note:** LIFO (Last-In, First-Out) is NOT permitted under IFRS but is allowed under US GAAP.\n\n---\n\n## FIFO Calculation\n\n**Assumption:** Sell the oldest inventory first.\n\n**Urban Apparel sells 200 units:**\n\n| From | Units | Cost | COGS |\n|------|-------|------|------|\n| January | 100 | 40 | 4,000 |\n| April | 100 | 45 | 4,500 |\n| **COGS** | **200** | | **8,500** |\n\n**Ending Inventory:** 100 units from August @ CHF 50 = **CHF 5,000**\n\n**Check:** COGS + Ending = 8,500 + 5,000 = 13,500 (Total available)\n\n---\n\n## Weighted Average Calculation\n\n**Step 1:** Calculate weighted average cost\n\n```\nWeighted Average = Total Cost / Total Units\n                 = 13,500 / 300\n                 = CHF 45 per unit\n```\n\n**Step 2:** Apply to units sold and on hand\n\n| | Units | Cost | Total |\n|--|-------|------|-------|\n| COGS | 200 | 45 | 9,000 |\n| Ending Inventory | 100 | 45 | 4,500 |\n| **Total** | **300** | | **13,500** |\n\n---\n\n## Comparison of Methods\n\nUsing Urban Apparel example (assume sales revenue = CHF 15,000):\n\n| Method | COGS | Gross Profit | Ending Inventory |\n|--------|------|--------------|------------------|\n| **FIFO** | 8,500 | 6,500 | 5,000 |\n| **Weighted Avg** | 9,000 | 6,000 | 4,500 |\n\n### Key Insight: Rising Prices\n\n- **FIFO:** Higher profit, higher ending inventory, higher taxes\n- **Weighted Average:** Moderate profit, moderate inventory\n\n---\n\n## Which Method to Use?\n\n### FIFO is best when:\n- Prices are rising and you want higher reported profit\n- Physical flow actually is first-in, first-out (perishables)\n- Industry norm uses FIFO\n\n### Weighted Average is best when:\n- Items are interchangeable\n- Want to smooth out price fluctuations\n- Simpler calculation\n\n### Specific Identification is required when:\n- Each item is unique (cars, jewelry, real estate)\n- High-value items where identity matters\n\n---\n\n## Lower of Cost or Net Realizable Value\n\nUnder IFRS, inventory must be reported at the **lower of cost or NRV**.\n\n> **Net Realizable Value (NRV)** = Expected selling price - Costs to sell\n\n### Example\n\nInventory cost: CHF 10,000\nExpected selling price: CHF 8,500\nCosts to complete/sell: CHF 500\n\nNRV = 8,500 - 500 = **CHF 8,000**\n\nSince NRV (8,000) < Cost (10,000), write down to CHF 8,000.\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Inventory Write-Down (or COGS) | 2,000 | |\n| Inventory | | 2,000 |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - FIFO: First costs out = oldest costs to COGS\n> - Weighted Average: Average cost for all units\n> - LIFO NOT allowed under IFRS\n> - Rising prices: FIFO = higher profit, higher taxes\n> - Report at lower of Cost or NRV\n> - Inventory method must be consistent year to year"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.2: FIFO vs Weighted Average Calculator
(
  'fa600000-0000-0000-0006-000000000002',
  'fa000000-0000-0000-0000-000000000006',
  '6.2',
  2,
  'Inventory Method Comparison',
  'inventory-method-comparison',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Urban Apparel Inventory Analysis",
    "description": "Urban Apparel Co. needs to calculate COGS and ending inventory using both FIFO and Weighted Average methods.",
    "company_background": "Urban Apparel is a fashion retailer that purchases clothing from wholesalers. They need to determine the impact of different inventory methods on their financial statements.",
    "inventory_data": {
      "beginning_inventory": {"units": 200, "cost_per_unit": 25, "total": 5000},
      "purchases": [
        {"date": "Feb 15", "units": 300, "cost_per_unit": 28, "total": 8400},
        {"date": "May 1", "units": 400, "cost_per_unit": 30, "total": 12000},
        {"date": "Sep 20", "units": 250, "cost_per_unit": 32, "total": 8000}
      ],
      "units_sold": 800,
      "units_available": 1150,
      "cost_available": 33400
    },
    "questions": [
      {
        "id": "ua1",
        "question": "Using FIFO, what is the Cost of Goods Sold?",
        "answer_type": "numeric",
        "correct_answer": 23000,
        "tolerance": 50,
        "hint": "Under FIFO, sell oldest inventory first: 200 @ 25, then 300 @ 28, then 300 @ 30",
        "calculation": "(200 x 25) + (300 x 28) + (300 x 30) = 5,000 + 8,400 + 9,000 = 22,400"
      },
      {
        "id": "ua2",
        "question": "Using FIFO, what is the Ending Inventory?",
        "answer_type": "numeric",
        "correct_answer": 11000,
        "tolerance": 50,
        "hint": "Remaining units: (100 x 30) + (250 x 32) = 3,000 + 8,000",
        "calculation": "33,400 - 22,400 = 11,000"
      },
      {
        "id": "ua3",
        "question": "Calculate the Weighted Average cost per unit (round to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 29.04,
        "tolerance": 0.05,
        "hint": "Total cost / Total units = 33,400 / 1,150",
        "calculation": "33,400 / 1,150 = 29.04"
      },
      {
        "id": "ua4",
        "question": "Using Weighted Average, what is COGS?",
        "answer_type": "numeric",
        "correct_answer": 23232,
        "tolerance": 50,
        "hint": "Units sold x Weighted Average cost = 800 x 29.04",
        "calculation": "800 x 29.04 = 23,232"
      },
      {
        "id": "ua5",
        "question": "If Urban Apparel sells goods for CHF 48,000, which method results in higher Gross Profit?",
        "answer_type": "choice",
        "options": ["FIFO", "Weighted Average", "Same under both"],
        "correct_answer": "FIFO",
        "explanation": "FIFO has lower COGS (22,400 vs 23,232), so Gross Profit is higher (25,600 vs 24,768)"
      }
    ],
    "passing_score": 80
  }'::jsonb,
  'inventory-calculator',
  false,
  true
),

-- Activity 6.3: Module 6 Checkpoint
(
  'fa600000-0000-0000-0006-000000000003',
  'fa000000-0000-0000-0000-000000000006',
  '6.3',
  3,
  'Module 6 Checkpoint',
  'module-6-checkpoint',
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
        "question": "When prices are rising, which inventory method results in the LOWEST Cost of Goods Sold?",
        "options": [
          "FIFO",
          "LIFO",
          "Weighted Average",
          "Specific Identification"
        ],
        "correct": 0,
        "explanation": "Under rising prices, FIFO uses oldest (lowest) costs for COGS, resulting in lowest COGS and highest gross profit."
      },
      {
        "id": "c2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which inventory method is NOT permitted under IFRS?",
        "options": [
          "FIFO",
          "LIFO",
          "Weighted Average",
          "Specific Identification"
        ],
        "correct": 1,
        "explanation": "LIFO (Last-In, First-Out) is NOT allowed under IFRS. It is permitted under US GAAP."
      },
      {
        "id": "c3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Golden Bear Candy has inventory with a cost of CHF 45,000. Due to market changes, the expected selling price is CHF 42,000 with CHF 2,000 in selling costs. At what amount should inventory be reported?",
        "options": [
          "CHF 45,000",
          "CHF 42,000",
          "CHF 40,000",
          "CHF 47,000"
        ],
        "correct": 2,
        "explanation": "NRV = Selling price (42,000) - Selling costs (2,000) = 40,000. Since NRV < Cost, report at lower amount: CHF 40,000."
      },
      {
        "id": "c4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Beginning Inventory: 50 units @ CHF 10 = CHF 500. Purchases: 100 units @ CHF 12 = CHF 1,200. Sales: 80 units. Using weighted average, what is COGS?",
        "options": [
          "CHF 880",
          "CHF 906",
          "CHF 960",
          "CHF 800"
        ],
        "correct": 1,
        "explanation": "Total cost = 500 + 1,200 = 1,700. Total units = 150. Avg cost = 1,700 / 150 = 11.33. COGS = 80 x 11.33 = CHF 906.67 (rounded to 906)."
      },
      {
        "id": "c5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Under FIFO, ending inventory is valued at the most recent (newest) purchase costs.",
        "correct": true,
        "explanation": "TRUE. FIFO assumes oldest costs are sold first, so the remaining (ending) inventory consists of the most recent purchases."
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
-- MOCK MIDTERM EXAM
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, time_limit, is_published) VALUES

(
  'fa990000-0000-0000-0099-000000000001',
  'fa000000-0000-0000-0000-000000000099',
  'midterm.1',
  1,
  'Mock Midterm Exam',
  'mock-midterm-exam-fa',
  'mock_exam',
  60,
  200,
  'basic',
  '{
    "title": "Financial Accounting Mock Midterm",
    "description": "This practice exam covers Modules 1-6: Foundations, Balance Sheet, Income Statement, Adjustments, Receivables, and Inventory.",
    "instructions": "You have 60 minutes to complete this exam. Answer all questions. Each question is worth 5 points. A score of 75% or higher is considered passing.",
    "questions": [
      {
        "id": "m1",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Accounting Equation",
        "question": "Nova Energy Corp. has total assets of CHF 850,000 and total equity of CHF 320,000. What are total liabilities?",
        "options": [
          "CHF 1,170,000",
          "CHF 530,000",
          "CHF 850,000",
          "CHF 320,000"
        ],
        "correct": 1,
        "explanation": "A = L + E. Therefore L = A - E = 850,000 - 320,000 = CHF 530,000."
      },
      {
        "id": "m2",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Journal Entries",
        "question": "Metro Properties purchases equipment for CHF 75,000 by paying CHF 25,000 cash and signing a note for the balance. Which entry is correct?",
        "options": [
          "Dr Equipment 75,000; Cr Cash 75,000",
          "Dr Equipment 75,000; Cr Cash 25,000; Cr Notes Payable 50,000",
          "Dr Equipment 50,000; Dr Cash 25,000; Cr Notes Payable 75,000",
          "Dr Cash 25,000; Dr Notes Payable 50,000; Cr Equipment 75,000"
        ],
        "correct": 1,
        "explanation": "Equipment increases (debit) by full cost. Cash decreases (credit) by amount paid. Notes Payable increases (credit) for borrowed amount."
      },
      {
        "id": "m3",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Revenue Recognition",
        "question": "Phantom Studios receives CHF 30,000 on November 1 for a 6-month project (Nov-Apr). Under IFRS, how much revenue is recognized by December 31?",
        "options": [
          "CHF 30,000",
          "CHF 20,000",
          "CHF 10,000",
          "CHF 0"
        ],
        "correct": 2,
        "explanation": "2 months of 6 months have passed (Nov, Dec). Revenue = 30,000 x 2/6 = CHF 10,000."
      },
      {
        "id": "m4",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "COGS",
        "question": "Alpine Foods has: Beginning Inventory CHF 80,000; Purchases CHF 320,000; Ending Inventory CHF 95,000. What is Cost of Goods Sold?",
        "options": [
          "CHF 305,000",
          "CHF 320,000",
          "CHF 335,000",
          "CHF 400,000"
        ],
        "correct": 0,
        "explanation": "COGS = Beginning + Purchases - Ending = 80,000 + 320,000 - 95,000 = CHF 305,000."
      },
      {
        "id": "m5",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Adjusting Entries",
        "question": "Coastal Resorts pays CHF 18,000 for 12 months of insurance on April 1. What is the adjusting entry on December 31?",
        "options": [
          "Dr Insurance Expense 18,000; Cr Prepaid Insurance 18,000",
          "Dr Insurance Expense 13,500; Cr Prepaid Insurance 13,500",
          "Dr Prepaid Insurance 4,500; Cr Insurance Expense 4,500",
          "Dr Insurance Expense 4,500; Cr Prepaid Insurance 4,500"
        ],
        "correct": 1,
        "explanation": "9 months have passed (Apr-Dec). Expense = 18,000 x 9/12 = CHF 13,500."
      },
      {
        "id": "m6",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Depreciation",
        "question": "Equipment costing CHF 120,000 with residual value of CHF 20,000 has a 10-year life. If purchased July 1, what is Year 1 depreciation?",
        "options": [
          "CHF 12,000",
          "CHF 10,000",
          "CHF 6,000",
          "CHF 5,000"
        ],
        "correct": 3,
        "explanation": "Annual = (120,000 - 20,000) / 10 = 10,000. Year 1 = 10,000 x 6/12 = CHF 5,000."
      },
      {
        "id": "m7",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Bad Debts",
        "question": "Using the aging method, required allowance is CHF 15,000. Current allowance balance is CHF 4,000 credit. Bad debt expense is:",
        "options": [
          "CHF 15,000",
          "CHF 11,000",
          "CHF 19,000",
          "CHF 4,000"
        ],
        "correct": 1,
        "explanation": "Aging method targets ending balance. Expense = Required - Current = 15,000 - 4,000 = CHF 11,000."
      },
      {
        "id": "m8",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Inventory",
        "question": "Under FIFO with rising prices, compared to Weighted Average, ending inventory will be:",
        "options": [
          "Higher",
          "Lower",
          "The same",
          "Cannot be determined"
        ],
        "correct": 0,
        "explanation": "FIFO leaves newest (highest) costs in ending inventory when prices rise, resulting in higher ending inventory than Weighted Average."
      },
      {
        "id": "m9",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Accrued Expenses",
        "question": "Summit Consulting owes employees CHF 8,500 for work performed but not yet paid. The adjusting entry is:",
        "options": [
          "Dr Cash 8,500; Cr Wages Expense 8,500",
          "Dr Wages Expense 8,500; Cr Cash 8,500",
          "Dr Wages Expense 8,500; Cr Wages Payable 8,500",
          "Dr Wages Payable 8,500; Cr Wages Expense 8,500"
        ],
        "correct": 2,
        "explanation": "Accrued expense: Dr Expense (increase expense), Cr Payable (increase liability). Cash is not involved in adjusting entries."
      },
      {
        "id": "m10",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Income Statement",
        "question": "Luxe Maison Group has: Revenue CHF 500,000; COGS CHF 200,000; Operating Expenses CHF 150,000; Interest CHF 25,000; Tax Rate 30%. Net Income is:",
        "options": [
          "CHF 87,500",
          "CHF 105,000",
          "CHF 125,000",
          "CHF 150,000"
        ],
        "correct": 0,
        "explanation": "Gross Profit = 300,000. Operating Income = 150,000. Income Before Tax = 125,000. Tax = 37,500. Net Income = CHF 87,500."
      },
      {
        "id": "m11",
        "type": "true_false",
        "difficulty": "exam",
        "topic": "Balance Sheet",
        "question": "Accumulated Depreciation is a contra-asset account that reduces the carrying value of the related asset on the balance sheet.",
        "correct": true,
        "explanation": "TRUE. Accumulated Depreciation has a credit balance and is subtracted from the asset cost to show net book value."
      },
      {
        "id": "m12",
        "type": "true_false",
        "difficulty": "exam",
        "topic": "Accounting Principles",
        "question": "Under the matching principle, expenses should be recorded in the same period as the revenues they help generate.",
        "correct": true,
        "explanation": "TRUE. The matching principle ensures that expenses are recognized in the period they contribute to revenue, providing accurate period profitability."
      },
      {
        "id": "m13",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Unearned Revenue",
        "question": "Golden Bear Candy receives CHF 45,000 for gift cards sold. By year end, CHF 32,000 has been redeemed. The balance sheet shows Unearned Revenue of:",
        "options": [
          "CHF 45,000",
          "CHF 32,000",
          "CHF 13,000",
          "CHF 0"
        ],
        "correct": 2,
        "explanation": "Unearned Revenue = Amount received - Amount earned = 45,000 - 32,000 = CHF 13,000 still owed as liability."
      },
      {
        "id": "m14",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Gross Profit",
        "question": "Swiss Confections has Net Sales of CHF 400,000 and Gross Profit of CHF 160,000. What is the Gross Profit Margin?",
        "options": [
          "40%",
          "60%",
          "25%",
          "160%"
        ],
        "correct": 0,
        "explanation": "Gross Profit Margin = Gross Profit / Net Sales = 160,000 / 400,000 = 40%."
      },
      {
        "id": "m15",
        "type": "mcq",
        "difficulty": "exam",
        "topic": "Trial Balance",
        "question": "If total debits in a trial balance exceed total credits, which error could cause this?",
        "options": [
          "Recording a credit transaction twice",
          "Posting a debit entry to the wrong account",
          "Omitting a credit from a journal entry",
          "Recording revenue as a debit"
        ],
        "correct": 2,
        "explanation": "Omitting a credit while recording the debit would leave debits > credits. Posting to wrong account doesn''t affect balance. Recording revenue as debit would make debits higher than credits too, but that''s more of a classification error."
      }
    ],
    "passing_score": 75,
    "show_explanations": true
  }'::jsonb,
  NULL,
  true,
  60,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;


