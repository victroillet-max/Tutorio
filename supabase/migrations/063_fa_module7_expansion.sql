-- ============================================
-- FA Course Content Expansion - Phase 3
-- Module 7: Inventory & Fixed Assets Expansion
-- Adds 6 new activities for inventory and asset skills
-- ============================================

-- ============================================
-- NEW ACTIVITIES FOR MODULE 7
-- Following existing UUID pattern: fa700000-0000-0000-0007-00000000XXXX
-- Existing activities: 0001-0006, new start at 0007
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 7.7: FIFO vs LIFO Comparison
-- Primary Skill: inv-costing
-- ============================================
(
  'fa700000-0000-0000-0007-000000000007',
  'fa000000-0000-0000-0000-000000000007',
  '7.7',
  7,
  'FIFO vs LIFO Comparison',
  'fifo-vs-lifo-comparison',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# FIFO vs LIFO Comparison\n\n## Why This Matters\n\nInventory costing methods significantly impact Cost of Goods Sold, Net Income, and Balance Sheet values. Understanding the differences is crucial for financial analysis.\n\n---\n\n## The Three Methods\n\n| Method | Assumes | Impact |\n|--------|---------|--------|\n| **FIFO** | First In, First Out | Oldest costs go to COGS |\n| **LIFO** | Last In, First Out | Newest costs go to COGS |\n| **Weighted Average** | Blended cost | Average cost per unit |\n\n---\n\n## FIFO: First In, First Out\n\n### How It Works\n\nOldest inventory costs are assigned to COGS first.\n\n### Balance Sheet Effect\n\nEnding inventory reflects **recent (current) costs**.\n\n### When Prices Are Rising\n\n- COGS: Lower (older, cheaper costs)\n- Gross Profit: Higher\n- Net Income: Higher\n- Ending Inventory: Higher\n\n---\n\n## LIFO: Last In, First Out\n\n### How It Works\n\nNewest inventory costs are assigned to COGS first.\n\n### Balance Sheet Effect\n\nEnding inventory reflects **older costs**.\n\n### When Prices Are Rising\n\n- COGS: Higher (newer, more expensive costs)\n- Gross Profit: Lower\n- Net Income: Lower\n- Ending Inventory: Lower\n- Taxes: Lower (tax advantage)\n\n---\n\n## Example Comparison\n\n### Inventory Data\n\n| Purchase | Units | Cost/Unit | Total |\n|----------|-------|-----------|-------|\n| Jan 1 (Beginning) | 100 | CHF 10 | CHF 1,000 |\n| Feb 15 | 200 | CHF 12 | CHF 2,400 |\n| Mar 20 | 150 | CHF 14 | CHF 2,100 |\n| **Available** | **450** | | **CHF 5,500** |\n\n**Units Sold: 300**\n\n### FIFO Calculation\n\nCOGS uses oldest costs first:\n- 100 units @ CHF 10 = CHF 1,000\n- 200 units @ CHF 12 = CHF 2,400\n- **COGS: CHF 3,400**\n\nEnding Inventory (150 units @ CHF 14): CHF 2,100\n\n### LIFO Calculation\n\nCOGS uses newest costs first:\n- 150 units @ CHF 14 = CHF 2,100\n- 150 units @ CHF 12 = CHF 1,800\n- **COGS: CHF 3,900**\n\nEnding Inventory: CHF 1,600\n\n---\n\n## Side-by-Side Comparison\n\n| Metric | FIFO | LIFO | Difference |\n|--------|------|------|------------|\n| COGS | 3,400 | 3,900 | +500 |\n| Gross Profit | Higher | Lower | -500 |\n| Net Income | Higher | Lower | -500 |\n| Ending Inv | 2,100 | 1,600 | -500 |\n| Tax Expense | Higher | Lower | |\n\n---\n\n## Key Decision Factors\n\n| Consider FIFO When | Consider LIFO When |\n|-------------------|-------------------|\n| Want higher profits | Want tax savings |\n| Rising prices, show strength | Minimize taxable income |\n| Better B/S representation | Match costs to revenues |\n| IFRS compliance required | US GAAP only |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - FIFO: newer costs on B/S, older in COGS\n> - LIFO: older costs on B/S, newer in COGS\n> - Rising prices: FIFO = higher income, LIFO = lower taxes\n> - LIFO is not allowed under IFRS\n> - Method choice affects analysis comparability"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 7.8: Inventory Costing Practice
-- Primary Skill: inv-costing
-- ============================================
(
  'fa700000-0000-0000-0007-000000000008',
  'fa000000-0000-0000-0000-000000000007',
  '7.8',
  8,
  'Inventory Costing Practice',
  'inventory-costing-practice',
  'interactive',
  22,
  55,
  'basic',
  '{
    "title": "Inventory Methods: Metro Electronics",
    "description": "Calculate COGS and ending inventory using FIFO, LIFO, and Weighted Average.",
    "company_background": "Metro Electronics tracks inventory using periodic method. Calculate values under each costing method.",
    "inventory_data": [
      {"transaction": "Beginning Inventory", "date": "Jan 1", "units": 80, "unit_cost": 50},
      {"transaction": "Purchase", "date": "Feb 10", "units": 120, "unit_cost": 55},
      {"transaction": "Purchase", "date": "Apr 5", "units": 100, "unit_cost": 60},
      {"transaction": "Purchase", "date": "Jul 20", "units": 140, "unit_cost": 65},
      {"transaction": "Purchase", "date": "Oct 15", "units": 60, "unit_cost": 70}
    ],
    "units_sold": 350,
    "questions": [
      {
        "id": "ic1",
        "question": "Calculate total units available for sale.",
        "answer_type": "numeric",
        "correct_answer": 500,
        "tolerance": 0,
        "explanation": "Total = 80 + 120 + 100 + 140 + 60 = 500 units"
      },
      {
        "id": "ic2",
        "question": "Calculate total cost of goods available.",
        "answer_type": "numeric",
        "correct_answer": 30200,
        "tolerance": 100,
        "explanation": "COGA = 4,000 + 6,600 + 6,000 + 9,100 + 4,200 = CHF 30,200"
      },
      {
        "id": "ic3",
        "question": "FIFO: Calculate Cost of Goods Sold.",
        "answer_type": "numeric",
        "correct_answer": 19550,
        "tolerance": 100,
        "hint": "Use oldest costs first: 80@50 + 120@55 + 100@60 + 50@65",
        "explanation": "FIFO COGS = 4,000 + 6,600 + 6,000 + 2,950 = CHF 19,550"
      },
      {
        "id": "ic4",
        "question": "FIFO: Calculate Ending Inventory.",
        "answer_type": "numeric",
        "correct_answer": 10650,
        "tolerance": 100,
        "explanation": "FIFO Ending = 30,200 - 19,550 = CHF 10,650"
      },
      {
        "id": "ic5",
        "question": "LIFO: Calculate Cost of Goods Sold.",
        "answer_type": "numeric",
        "correct_answer": 21850,
        "tolerance": 100,
        "hint": "Use newest costs first: 60@70 + 140@65 + 100@60 + 50@55",
        "explanation": "LIFO COGS = 4,200 + 9,100 + 6,000 + 2,550 = CHF 21,850"
      },
      {
        "id": "ic6",
        "question": "LIFO: Calculate Ending Inventory.",
        "answer_type": "numeric",
        "correct_answer": 8350,
        "tolerance": 100,
        "explanation": "LIFO Ending = 30,200 - 21,850 = CHF 8,350"
      },
      {
        "id": "ic7",
        "question": "Weighted Average: Calculate cost per unit (rounded to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 60.40,
        "tolerance": 0.1,
        "explanation": "Weighted Average = 30,200 / 500 = CHF 60.40"
      },
      {
        "id": "ic8",
        "question": "Weighted Average: Calculate COGS.",
        "answer_type": "numeric",
        "correct_answer": 21140,
        "tolerance": 100,
        "explanation": "WA COGS = 350 x 60.40 = CHF 21,140"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'inventory-calculator',
  false,
  true
),

-- ============================================
-- Activity 7.9: Fixed Asset Lifecycle
-- Primary Skill: fa-depreciation
-- ============================================
(
  'fa700000-0000-0000-0007-000000000009',
  'fa000000-0000-0000-0000-000000000007',
  '7.9',
  9,
  'Fixed Asset Lifecycle',
  'fixed-asset-lifecycle',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# Fixed Asset Lifecycle\n\n## Why This Matters\n\nUnderstanding the complete lifecycle of fixed assets - from acquisition to disposal - is essential for accurate financial reporting.\n\n---\n\n## The Four Stages\n\n```\n1. ACQUISITION → Record at cost\n2. USE → Depreciate over useful life\n3. IMPAIRMENT → Test and write down if needed\n4. DISPOSAL → Remove from books\n```\n\n---\n\n## Stage 1: Acquisition\n\n### What Is Included in Cost?\n\nAll costs to get the asset ready for use:\n\n| Include | Exclude |\n|---------|--------|\n| Purchase price | Repairs from accidents |\n| Sales tax | Insurance after placed in service |\n| Freight/shipping | Training costs |\n| Installation | Maintenance |\n| Testing | |\n\n### Example\n\n| Cost Component | Amount |\n|----------------|--------|\n| Equipment price | CHF 50,000 |\n| Sales tax | 3,500 |\n| Freight | 1,200 |\n| Installation | 800 |\n| **Total Cost** | **CHF 55,500** |\n\n---\n\n## Stage 2: Depreciation\n\n### Straight-Line (Most Common)\n\n```\nAnnual Depreciation = (Cost - Salvage) / Useful Life\n```\n\n### Example\n\n- Cost: CHF 55,500\n- Salvage: CHF 5,500\n- Life: 10 years\n- Annual Depreciation: CHF 5,000\n\n---\n\n## Stage 3: Capital vs. Revenue Expenditures\n\n### Capitalize (Add to Asset)\n\n- Extends useful life\n- Increases productivity\n- Adds new capability\n\n### Expense Immediately\n\n- Maintains current condition\n- Routine repairs\n- Normal maintenance\n\n---\n\n## Stage 4: Disposal\n\n### Steps\n\n1. Record depreciation to disposal date\n2. Remove asset cost from books\n3. Remove accumulated depreciation\n4. Record gain or loss\n\n### Gain or Loss Calculation\n\n```\nBook Value = Cost - Accumulated Depreciation\nGain/(Loss) = Proceeds - Book Value\n```\n\n### Example: Sell Asset\n\n| Detail | Amount |\n|--------|--------|\n| Original Cost | CHF 55,500 |\n| Accumulated Depreciation | CHF 35,500 |\n| Book Value | CHF 20,000 |\n| Sale Price | CHF 18,000 |\n| **Loss on Sale** | **CHF 2,000** |\n\n### Journal Entry\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 18,000 | |\n| Accumulated Depreciation | 35,500 | |\n| Loss on Disposal | 2,000 | |\n| Equipment | | 55,500 |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Cost includes all acquisition costs\n> - Depreciate over useful life\n> - Capitalize improvements, expense repairs\n> - Book value = Cost - Accum. Depr.\n> - Gain if proceeds > book value\n> - Loss if proceeds < book value"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 7.10: Asset Disposal Practice
-- Primary Skill: fa-disposal
-- ============================================
(
  'fa700000-0000-0000-0007-000000000010',
  'fa000000-0000-0000-0000-000000000007',
  '7.10',
  10,
  'Asset Disposal Practice',
  'asset-disposal-practice',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Asset Disposals: Mountain Transport",
    "description": "Record asset disposal transactions for Mountain Transport fleet.",
    "company_background": "Mountain Transport is updating its vehicle fleet. Record the disposal of old vehicles.",
    "disposals": [
      {
        "asset": "Delivery Truck #101",
        "original_cost": 85000,
        "accumulated_depreciation": 68000,
        "sale_price": 15000
      },
      {
        "asset": "Van #205",
        "original_cost": 45000,
        "accumulated_depreciation": 42000,
        "sale_price": 0,
        "note": "Junked, no proceeds"
      },
      {
        "asset": "Truck #108",
        "original_cost": 95000,
        "accumulated_depreciation": 57000,
        "sale_price": 42000
      }
    ],
    "questions": [
      {
        "id": "ad1",
        "question": "Truck #101: Calculate book value at disposal.",
        "answer_type": "numeric",
        "correct_answer": 17000,
        "tolerance": 50,
        "explanation": "Book Value = 85,000 - 68,000 = CHF 17,000"
      },
      {
        "id": "ad2",
        "question": "Truck #101: Calculate gain or loss (+ for gain, - for loss).",
        "answer_type": "numeric",
        "correct_answer": -2000,
        "tolerance": 50,
        "explanation": "Gain/(Loss) = 15,000 - 17,000 = CHF -2,000 (Loss)"
      },
      {
        "id": "ad3",
        "question": "Van #205: Calculate book value at disposal.",
        "answer_type": "numeric",
        "correct_answer": 3000,
        "tolerance": 50,
        "explanation": "Book Value = 45,000 - 42,000 = CHF 3,000"
      },
      {
        "id": "ad4",
        "question": "Van #205: Calculate gain or loss (junked).",
        "answer_type": "numeric",
        "correct_answer": -3000,
        "tolerance": 50,
        "explanation": "Gain/(Loss) = 0 - 3,000 = CHF -3,000 (Loss)"
      },
      {
        "id": "ad5",
        "question": "Truck #108: Calculate book value at disposal.",
        "answer_type": "numeric",
        "correct_answer": 38000,
        "tolerance": 50,
        "explanation": "Book Value = 95,000 - 57,000 = CHF 38,000"
      },
      {
        "id": "ad6",
        "question": "Truck #108: Calculate gain or loss.",
        "answer_type": "numeric",
        "correct_answer": 4000,
        "tolerance": 50,
        "explanation": "Gain/(Loss) = 42,000 - 38,000 = CHF 4,000 (Gain)"
      },
      {
        "id": "ad7",
        "question": "Total net gain or loss from all disposals:",
        "answer_type": "numeric",
        "correct_answer": -1000,
        "tolerance": 50,
        "explanation": "Net = -2,000 + (-3,000) + 4,000 = CHF -1,000 (Net Loss)"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'disposal-calculator',
  false,
  true
),

-- ============================================
-- Activity 7.11: Inventory Valuation Quiz
-- Primary Skill: inv-costing, inv-lcm
-- ============================================
(
  'fa700000-0000-0000-0007-000000000011',
  'fa000000-0000-0000-0000-000000000007',
  '7.11',
  11,
  'Inventory Valuation Quiz',
  'inventory-valuation-quiz',
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
        "question": "When prices are rising, which method gives the lowest COGS?",
        "options": [
          "FIFO",
          "LIFO",
          "Weighted Average",
          "Specific Identification"
        ],
        "correct": 0,
        "explanation": "FIFO uses oldest (lowest) costs for COGS when prices rise, resulting in lowest COGS."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Under Lower of Cost or Market, inventory cost CHF 50,000, market CHF 45,000. Inventory is reported at:",
        "options": [
          "CHF 50,000",
          "CHF 45,000",
          "CHF 47,500",
          "CHF 95,000"
        ],
        "correct": 1,
        "explanation": "LCM requires reporting at the lower amount: CHF 45,000 (market)."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "COGA CHF 80,000, Ending Inventory CHF 22,000. COGS is:",
        "options": [
          "CHF 102,000",
          "CHF 80,000",
          "CHF 58,000",
          "CHF 22,000"
        ],
        "correct": 2,
        "explanation": "COGS = Cost of Goods Available - Ending Inventory = 80,000 - 22,000 = CHF 58,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which inventory method is NOT allowed under IFRS?",
        "options": [
          "FIFO",
          "LIFO",
          "Weighted Average",
          "Specific Identification"
        ],
        "correct": 1,
        "explanation": "LIFO is not allowed under IFRS. It is only permitted under US GAAP."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company uses FIFO with rising prices. Compared to LIFO, working capital will be:",
        "options": [
          "Lower",
          "Higher",
          "The same",
          "Cannot be determined"
        ],
        "correct": 1,
        "explanation": "FIFO = higher ending inventory = higher current assets = higher working capital."
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Under periodic inventory, COGS is calculated after the physical count at period-end.",
        "correct": true,
        "explanation": "TRUE. Periodic system calculates COGS at period-end: COGS = Beginning + Purchases - Ending."
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
-- Activity 7.12: Fixed Assets Quiz
-- Primary Skill: fa-depreciation, fa-disposal
-- ============================================
(
  'fa700000-0000-0000-0007-000000000012',
  'fa000000-0000-0000-0000-000000000007',
  '7.12',
  12,
  'Fixed Assets Quiz',
  'fixed-assets-quiz',
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
        "question": "Which is included in the cost of a fixed asset?",
        "options": [
          "Maintenance after placed in service",
          "Installation costs",
          "Employee training",
          "Insurance premiums"
        ],
        "correct": 1,
        "explanation": "Installation costs are part of getting the asset ready for use and are capitalized."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Equipment cost CHF 60,000, salvage CHF 6,000, 6-year life. Annual straight-line depreciation is:",
        "options": [
          "CHF 9,000",
          "CHF 10,000",
          "CHF 11,000",
          "CHF 6,000"
        ],
        "correct": 0,
        "explanation": "SL Depreciation = (60,000 - 6,000) / 6 = CHF 9,000 per year"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Asset cost CHF 40,000, Accum. Depr. CHF 32,000, sold for CHF 10,000. Result is:",
        "options": [
          "Gain CHF 2,000",
          "Loss CHF 2,000",
          "Gain CHF 8,000",
          "Loss CHF 8,000"
        ],
        "correct": 0,
        "explanation": "Book value = 40,000 - 32,000 = 8,000. Gain = 10,000 - 8,000 = CHF 2,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Replacing a major component that extends useful life is:",
        "options": [
          "Expensed as repairs",
          "Capitalized as improvement",
          "Recorded as depreciation",
          "Ignored"
        ],
        "correct": 1,
        "explanation": "Expenditures that extend useful life or improve productivity are capitalized."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Under Double-Declining Balance, salvage value is:",
        "options": [
          "Subtracted before calculating depreciation",
          "Not considered in annual calculation, but limits total depreciation",
          "Added to cost before calculating depreciation",
          "Ignored completely"
        ],
        "correct": 1,
        "explanation": "DDB does not subtract salvage initially but cannot depreciate below salvage value."
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A loss on disposal of equipment is reported on the income statement.",
        "correct": true,
        "explanation": "TRUE. Gains and losses on asset disposal are reported on the income statement."
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
-- ADD SKILL TAGS FOR NEW MODULE 7 ACTIVITIES
-- Using correct skill IDs:
-- spec-inventory-methods = b0000000-0000-0000-0005-000000000003
-- spec-depreciation-methods = b0000000-0000-0000-0005-000000000004
-- spec-asset-disposal = b0000000-0000-0000-0005-000000000005
-- adj-depreciation = b0000000-0000-0000-0004-000000000005
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 7.7 FIFO vs LIFO Comparison (spec-inventory-methods)
('fa700000-0000-0000-0007-000000000007', 'b0000000-0000-0000-0005-000000000003', 1.0, true),

-- 7.8 Inventory Costing Practice (spec-inventory-methods)
('fa700000-0000-0000-0007-000000000008', 'b0000000-0000-0000-0005-000000000003', 1.0, true),

-- 7.9 Fixed Asset Lifecycle (spec-depreciation-methods, spec-asset-disposal)
('fa700000-0000-0000-0007-000000000009', 'b0000000-0000-0000-0005-000000000004', 0.6, true),
('fa700000-0000-0000-0007-000000000009', 'b0000000-0000-0000-0005-000000000005', 0.4, false),

-- 7.10 Asset Disposal Practice (spec-asset-disposal)
('fa700000-0000-0000-0007-000000000010', 'b0000000-0000-0000-0005-000000000005', 1.0, true),

-- 7.11 Inventory Valuation Quiz (spec-inventory-methods)
('fa700000-0000-0000-0007-000000000011', 'b0000000-0000-0000-0005-000000000003', 1.0, true),

-- 7.12 Fixed Assets Quiz (spec-depreciation-methods, spec-asset-disposal)
('fa700000-0000-0000-0007-000000000012', 'b0000000-0000-0000-0005-000000000004', 0.5, true),
('fa700000-0000-0000-0007-000000000012', 'b0000000-0000-0000-0005-000000000005', 0.5, false)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

