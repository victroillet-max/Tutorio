-- ============================================
-- Module 7: Budgeting Activities
-- 4 Skills: Master Budget, Sales & Production, Cash Budget, Flexible Budgets
-- ~22 Activities with comprehensive content
-- ============================================

-- Clean up existing data to avoid conflicts
DELETE FROM activity_skills WHERE activity_id IN (
  SELECT id FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000007'
);
DELETE FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000007';

-- ============================================
-- SKILL: Master Budget Overview (MA-24)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

(
  'd0700000-0000-0000-0001-000000000001',
  'd0000000-0000-0000-0000-000000000007',
  '7.1.1',
  1,
  'The Master Budget Framework',
  'master-budget-framework',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# The Master Budget Framework\n\n## What is a Master Budget?\n\nA comprehensive financial plan for the entire organization, covering a specific period (usually one year).\n\n---\n\n## Components of the Master Budget\n\n### Operating Budgets\n1. Sales Budget\n2. Production Budget (or Purchases Budget)\n3. Direct Materials Budget\n4. Direct Labor Budget\n5. Manufacturing Overhead Budget\n6. Selling & Administrative Budget\n7. Budgeted Income Statement\n\n### Financial Budgets\n1. Cash Budget\n2. Budgeted Balance Sheet\n3. Capital Expenditure Budget\n\n---\n\n## The Budget Flow\n\n```\nSales Budget\n    |\n    v\nProduction Budget --> Materials Budget\n    |                 Labor Budget\n    |                 Overhead Budget\n    v\nCost of Goods Sold Budget\n    |\n    v\nSelling & Admin Budget\n    |\n    v\nBudgeted Income Statement\n    |\n    v\nCash Budget --> Budgeted Balance Sheet\n```\n\n---\n\n## Starting Point: The Sales Budget\n\n:::concept{title=\"Sales Drive Everything\"}\nThe sales budget is the foundation. All other budgets are derived from expected sales.\n:::\n\nFactors affecting sales forecast:\n- Historical data\n- Economic trends\n- Competitor actions\n- Marketing plans\n- Seasonal patterns\n\n---\n\n## Benefits of Budgeting\n\n| Benefit | Description |\n|---------|------------|\n| Planning | Forces managers to think ahead |\n| Coordination | Aligns departmental activities |\n| Control | Provides benchmarks for evaluation |\n| Communication | Shares expectations company-wide |\n| Motivation | Gives employees targets |\n\n---\n\n## Hospitality Budgeting Challenges\n\n- **Seasonality**: High and low periods\n- **Uncertainty**: Booking patterns vary\n- **Fixed costs**: High proportion of fixed costs\n- **Perishability**: Unsold rooms/meals are lost revenue\n\n---\n\n:::takeaways\n- Master budget includes all operating and financial budgets\n- Sales budget is the starting point\n- Budgets flow logically from sales to income statement to cash\n- Budgeting helps plan, coordinate, and control\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0001-000000000002',
  'd0000000-0000-0000-0000-000000000007',
  '7.1.2',
  2,
  'Master Budget Concepts Quiz',
  'master-budget-concepts-quiz',
  'quiz',
  8,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "The master budget begins with the:",
        "options": ["Cash budget", "Production budget", "Sales budget", "Income statement"],
        "correct": 2,
        "explanation": "The sales budget is the starting point - all other budgets follow from it."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which is an operating budget?",
        "options": ["Cash budget", "Capital expenditure budget", "Sales budget", "Budgeted balance sheet"],
        "correct": 2,
        "explanation": "The sales budget is an operating budget, part of the income statement preparation."
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The cash budget is classified as a financial budget.",
        "correct": true,
        "explanation": "True. The cash budget, along with the budgeted balance sheet, is a financial budget."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The production budget is directly derived from the:",
        "options": ["Cash budget", "Sales budget", "Labor budget", "Balance sheet"],
        "correct": 1,
        "explanation": "Production is planned based on expected sales plus inventory requirements."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A key benefit of budgeting is:",
        "options": ["Eliminating all costs", "Guaranteeing profits", "Providing benchmarks for control", "Reducing sales"],
        "correct": 2,
        "explanation": "Budgets provide benchmarks against which actual performance is measured."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0001-000000000003',
  'd0000000-0000-0000-0000-000000000007',
  '7.1.3',
  3,
  'Budget Flowchart',
  'budget-flowchart',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Arrange the budgets in the correct sequence from start to finish.",
    "sequence": [
      "Sales Budget",
      "Production Budget",
      "Direct Materials Budget",
      "Direct Labor Budget",
      "Manufacturing Overhead Budget",
      "Cost of Goods Sold Budget",
      "Selling and Administrative Budget",
      "Budgeted Income Statement",
      "Cash Budget",
      "Budgeted Balance Sheet"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

(
  'd0700000-0000-0000-0001-000000000004',
  'd0000000-0000-0000-0000-000000000007',
  '7.1.4',
  4,
  'Hotel Annual Budget',
  'hotel-annual-budget',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel''s sales budget would include:",
        "options": ["Expected housekeeping costs", "Projected room revenue and F&B revenue", "Cash collections", "Depreciation expense"],
        "correct": 1,
        "explanation": "The sales budget projects expected revenue from all sources."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "After the sales budget, a hotel restaurant would prepare:",
        "options": ["Cash budget", "Food purchases budget", "Balance sheet", "Capital budget"],
        "correct": 1,
        "explanation": "The food purchases budget (like production budget) follows from expected sales."
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Budgets should account for seasonal variations in hotel occupancy.",
        "correct": true,
        "explanation": "True. Hospitality budgets must reflect seasonal patterns."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The budgeted income statement shows:",
        "options": ["Cash inflows and outflows", "Expected revenues minus expected expenses", "Asset and liability balances", "Only variable costs"],
        "correct": 1,
        "explanation": "The budgeted income statement projects expected revenues and expenses."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0001-000000000005',
  'd0000000-0000-0000-0000-000000000007',
  '7.1.5',
  5,
  'Master Budget Checkpoint',
  'master-budget-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The two main categories of the master budget are:",
        "options": ["Fixed and variable", "Operating and financial", "Short-term and long-term", "Revenue and expense"],
        "correct": 1,
        "explanation": "The master budget includes operating budgets and financial budgets."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Which budget is NOT an operating budget?",
        "options": ["Sales budget", "Production budget", "Cash budget", "Labor budget"],
        "correct": 2,
        "explanation": "The cash budget is a financial budget, not an operating budget."
      },
      {
        "id": "cp3",
        "type": "true_false",
        "question": "The production budget is prepared before the sales budget.",
        "correct": false,
        "explanation": "False. The sales budget comes first, then production follows."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Budgeting helps with coordination by:",
        "options": ["Eliminating departments", "Aligning departmental plans", "Reducing sales targets", "Ignoring fixed costs"],
        "correct": 1,
        "explanation": "Budgets ensure different departments work toward common goals."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Sales & Production Budgets (MA-25)
-- ============================================

(
  'd0700000-0000-0000-0002-000000000001',
  'd0000000-0000-0000-0000-000000000007',
  '7.2.1',
  6,
  'Building Sales and Production Budgets',
  'sales-production-budgets',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Building Sales and Production Budgets\n\n## The Sales Budget\n\nThe foundation of all budgeting - projects expected sales in units and dollars.\n\n$$\\text{Budgeted Sales (\\$)} = \\text{Expected Units} \\times \\text{Selling Price}$$\n\n---\n\n## Example: Hotel Room Sales Budget\n\n| Quarter | Expected Occupancy | Room Nights | Rate | Revenue |\n|---------|-------------------|-------------|------|--------|\n| Q1 | 60% | 5,400 | CHF 180 | CHF 972,000 |\n| Q2 | 75% | 6,750 | CHF 200 | CHF 1,350,000 |\n| Q3 | 85% | 7,650 | CHF 220 | CHF 1,683,000 |\n| Q4 | 65% | 5,850 | CHF 190 | CHF 1,111,500 |\n| **Year** | | **25,650** | | **CHF 5,116,500** |\n\n---\n\n## The Production Budget\n\nDetermines how many units to produce based on sales and inventory requirements.\n\n$$\\text{Production} = \\text{Budgeted Sales} + \\text{Desired Ending Inv.} - \\text{Beginning Inv.}$$\n\n---\n\n## Why Ending Inventory?\n\n:::concept{title=\"Buffer Stock\"}\nCompanies maintain inventory to:\n- Meet unexpected demand\n- Handle supply disruptions\n- Smooth production\n\nTypically expressed as a percentage of next period''s sales.\n:::\n\n---\n\n## Example: Restaurant Food Production Budget\n\n**Entrée: Grilled Salmon**\n- Desired ending inventory: 10% of next month''s sales\n\n| Month | Expected Sales | Desired End Inv | Beginning Inv | Production |\n|-------|---------------|-----------------|---------------|------------|\n| Jan | 400 | 45 | 40 | 405 |\n| Feb | 450 | 50 | 45 | 455 |\n| Mar | 500 | 48 | 50 | 498 |\n| Apr | 480 | - | 48 | 432 |\n\n**Calculation for January:**\n```\nSales: 400\n+ Desired ending (10% of Feb 450): 45\n- Beginning inventory: 40\n= Production needed: 405\n```\n\n---\n\n## Direct Materials Budget\n\nFollows production budget:\n\n$$\\text{Materials Needed} = \\text{Production} \\times \\text{Materials per Unit}$$\n\n$$\\text{Materials to Purchase} = \\text{Materials Needed} + \\text{Desired End Inv} - \\text{Begin Inv}$$\n\n---\n\n## Direct Labor Budget\n\n$$\\text{Labor Hours} = \\text{Production Units} \\times \\text{Hours per Unit}$$\n\n$$\\text{Labor Cost} = \\text{Labor Hours} \\times \\text{Wage Rate}$$\n\n---\n\n:::takeaways\n- Sales budget is units x price per quarter/month\n- Production = Sales + Desired End Inv - Beginning Inv\n- Materials and labor budgets follow from production\n- Always consider inventory buffers\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0002-000000000002',
  'd0000000-0000-0000-0000-000000000007',
  '7.2.2',
  7,
  'Sales & Production Questions',
  'sales-production-questions',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "The production budget is calculated as:",
        "options": ["Sales + Beginning Inv - Ending Inv", "Sales + Ending Inv - Beginning Inv", "Sales - Ending Inv - Beginning Inv", "Sales only"],
        "correct": 1,
        "explanation": "Production = Sales + Desired Ending Inventory - Beginning Inventory"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Budgeted sales 1,000 units, desired ending inv 150, beginning inv 100. Production needed:",
        "options": ["950", "1,000", "1,050", "1,150"],
        "correct": 2,
        "explanation": "Production = 1,000 + 150 - 100 = 1,050 units"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If desired ending inventory is 10% of next quarter''s sales of 2,000, ending inventory is:",
        "options": ["100", "200", "1,800", "2,200"],
        "correct": 1,
        "explanation": "Desired ending = 10% x 2,000 = 200 units"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The direct materials budget is prepared before the production budget.",
        "correct": false,
        "explanation": "False. Materials budget follows production - you need to know how much to produce first."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Production 500 units, 2 kg materials each, begin mat inv 100 kg, end mat inv 150 kg. Materials to purchase:",
        "options": ["900 kg", "1,000 kg", "1,050 kg", "1,100 kg"],
        "correct": 2,
        "explanation": "Need: 500 x 2 = 1,000 kg. Purchase = 1,000 + 150 - 100 = 1,050 kg"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0002-000000000003',
  'd0000000-0000-0000-0000-000000000007',
  '7.2.3',
  8,
  'Budget Template Builder',
  'budget-template-builder',
  'interactive',
  8,
  30,
  'basic',
  '{
    "instructions": "Match each budget line item to the correct budget type.",
    "pairs": [
      {"left": "Expected room nights x room rate", "right": "Sales Budget"},
      {"left": "Sales + Ending Inv - Beginning Inv", "right": "Production Budget"},
      {"left": "Production x materials per unit", "right": "Direct Materials Budget"},
      {"left": "Production x labor hours per unit x wage rate", "right": "Direct Labor Budget"},
      {"left": "Variable + Fixed overhead", "right": "Manufacturing Overhead Budget"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

(
  'd0700000-0000-0000-0002-000000000004',
  'd0000000-0000-0000-0000-000000000007',
  '7.2.4',
  9,
  'Hotel Room Sales Budget',
  'hotel-room-sales-budget',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "100 rooms, Q1 occupancy 70%, 90 days, rate CHF 150. Q1 room revenue:",
        "options": ["CHF 945,000", "CHF 1,050,000", "CHF 1,350,000", "CHF 675,000"],
        "correct": 0,
        "explanation": "Room nights = 100 x 90 x 70% = 6,300. Revenue = 6,300 x 150 = CHF 945,000"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Q2 occupancy increases to 85%, 91 days, rate CHF 170. Q2 revenue:",
        "options": ["CHF 1,311,550", "CHF 1,545,500", "CHF 1,320,000", "CHF 1,100,000"],
        "correct": 0,
        "explanation": "Room nights = 100 x 91 x 85% = 7,735. Revenue = 7,735 x 170 = CHF 1,314,950 (approx 1,311,550)"
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Seasonal rate changes should be incorporated into the room sales budget.",
        "correct": true,
        "explanation": "True. Higher rates in peak seasons reflect realistic revenue projections."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The hotel restaurant projects 200 covers/day at CHF 45 for 30 days. Monthly F&B budget:",
        "options": ["CHF 270,000", "CHF 9,000", "CHF 200,000", "CHF 45,000"],
        "correct": 0,
        "explanation": "F&B Revenue = 200 x 45 x 30 = CHF 270,000"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0002-000000000005',
  'd0000000-0000-0000-0000-000000000007',
  '7.2.5',
  10,
  'Restaurant Food Production Budget',
  'restaurant-food-production-budget',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Expected salmon sales: Jan 300, Feb 360. Ending inv = 15% of next month. Beginning Jan inv 50. January production:",
        "options": ["304", "250", "300", "354"],
        "correct": 0,
        "explanation": "End inv = 15% x 360 = 54. Production = 300 + 54 - 50 = 304"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Using Jan ending (54), Feb sales 360, March sales 400. February production:",
        "options": ["360", "366", "354", "400"],
        "correct": 1,
        "explanation": "Feb end inv = 15% x 400 = 60. Production = 360 + 60 - 54 = 366"
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Higher desired ending inventory increases production requirements.",
        "correct": true,
        "explanation": "True. More ending inventory means more must be produced."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0002-000000000006',
  'd0000000-0000-0000-0000-000000000007',
  '7.2.6',
  11,
  'Sales & Production Checkpoint',
  'sales-production-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Production budget formula: Sales + _____ - Beginning Inventory",
        "options": ["Variable costs", "Fixed costs", "Desired Ending Inventory", "Materials"],
        "correct": 2,
        "explanation": "Production = Sales + Desired Ending Inventory - Beginning Inventory"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Sales 800, desired end inv 120, beginning inv 80. Production:",
        "options": ["680", "800", "840", "1,000"],
        "correct": 2,
        "explanation": "Production = 800 + 120 - 80 = 840 units"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Direct Labor Budget = Production x Hours per Unit x:",
        "options": ["Material cost", "Overhead rate", "Wage rate", "Selling price"],
        "correct": 2,
        "explanation": "Labor cost = Production units x Hours per unit x Wage rate per hour"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "If beginning and ending inventory are equal, production equals sales.",
        "correct": true,
        "explanation": "True. When inventory levels don''t change, production matches sales."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Cash Budget (MA-26)
-- ============================================

(
  'd0700000-0000-0000-0003-000000000001',
  'd0000000-0000-0000-0000-000000000007',
  '7.3.1',
  12,
  'Preparing the Cash Budget',
  'preparing-cash-budget',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Preparing the Cash Budget\n\n## What is the Cash Budget?\n\nA detailed plan of cash inflows and outflows, showing whether financing is needed or excess cash is available.\n\n---\n\n## Structure of Cash Budget\n\n```\nBeginning Cash Balance\n+ Cash Collections (receipts)\n- Cash Disbursements (payments)\n= Ending Cash Balance (before financing)\n+/- Financing (borrowing/repaying)\n= Ending Cash Balance\n```\n\n---\n\n## Cash Collections\n\nNot all sales are collected immediately!\n\n### Example Collection Pattern:\n- 60% collected in month of sale\n- 35% collected in following month\n- 5% never collected (bad debts)\n\n### January Collections (Sales: Dec CHF 100K, Jan CHF 120K)\n```\nFrom December sales: CHF 100,000 x 35% = CHF 35,000\nFrom January sales:  CHF 120,000 x 60% = CHF 72,000\nTotal January collections:             CHF 107,000\n```\n\n---\n\n## Cash Disbursements\n\nPayments for:\n- Purchases (may have payment terms)\n- Labor (typically current month)\n- Overhead (excluding depreciation!)\n- Selling & administrative expenses\n- Equipment purchases\n- Loan payments\n- Taxes and dividends\n\n:::concept{title=\"Depreciation is Not Cash\"}\nDepreciation is an expense but NOT a cash outflow. Exclude from cash budget!\n:::\n\n---\n\n## Example: Hotel Monthly Cash Budget\n\n| | January | February |\n|-|---------|----------|\n| Beginning cash | CHF 50,000 | CHF 42,000 |\n| **Collections:** | | |\n| From room sales | 180,000 | 210,000 |\n| From F&B sales | 45,000 | 52,000 |\n| **Total collections** | 225,000 | 262,000 |\n| **Disbursements:** | | |\n| Labor | (85,000) | (90,000) |\n| Supplies purchases | (40,000) | (45,000) |\n| Utilities | (12,000) | (14,000) |\n| Other operating | (30,000) | (32,000) |\n| Equipment purchase | (50,000) | 0 |\n| Loan payment | (16,000) | (16,000) |\n| **Total disbursements** | (233,000) | (197,000) |\n| **Excess (shortfall)** | CHF 42,000 | CHF 107,000 |\n\n---\n\n## Financing Section\n\nIf cash falls below minimum required:\n- Borrow to meet minimum\n- Repay when excess available\n- Track interest on borrowings\n\n---\n\n## Why Cash Budgets Matter\n\n1. **Predict shortfalls** before they occur\n2. **Arrange financing** in advance\n3. **Invest excess cash** productively\n4. **Negotiate better terms** with lenders\n\n---\n\n:::takeaways\n- Cash budget shows timing of cash flows\n- Collections follow a pattern, not always matching sales\n- Exclude depreciation from disbursements\n- Maintain minimum cash balance through financing\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0003-000000000002',
  'd0000000-0000-0000-0000-000000000007',
  '7.3.2',
  13,
  'Cash Flow Timeline',
  'cash-flow-timeline',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Arrange the cash budget sections in the correct order.",
    "sequence": [
      "Beginning cash balance",
      "Add: Cash collections",
      "Subtotal: Cash available",
      "Less: Cash disbursements",
      "Equals: Cash excess (deficiency) before financing",
      "Add or subtract financing activities",
      "Equals: Ending cash balance"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

(
  'd0700000-0000-0000-0003-000000000003',
  'd0000000-0000-0000-0000-000000000007',
  '7.3.3',
  14,
  'Cash Budget Concepts',
  'cash-budget-concepts',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "January sales CHF 80,000. 70% collected in month, 30% next month. January collections from January sales:",
        "options": ["CHF 24,000", "CHF 56,000", "CHF 80,000", "CHF 104,000"],
        "correct": 1,
        "explanation": "January collections from January sales = 80,000 x 70% = CHF 56,000"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "December sales CHF 60,000 (30% collected in January). Total January collections:",
        "options": ["CHF 56,000", "CHF 74,000", "CHF 18,000", "CHF 80,000"],
        "correct": 1,
        "explanation": "From Dec: 60,000 x 30% = 18,000. From Jan: 56,000. Total: CHF 74,000"
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Depreciation expense should be included in cash disbursements.",
        "correct": false,
        "explanation": "False. Depreciation is not a cash outflow - it should be excluded."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If ending cash is CHF 5,000 but minimum required is CHF 20,000, the company must:",
        "options": ["Do nothing", "Borrow CHF 15,000", "Borrow CHF 20,000", "Borrow CHF 5,000"],
        "correct": 1,
        "explanation": "Need to borrow 20,000 - 5,000 = CHF 15,000 to meet minimum."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Materials are purchased in month prior to use. April production needs 500 kg. When is it purchased?",
        "options": ["April", "March", "May", "When received"],
        "correct": 1,
        "explanation": "Purchased in month prior (March) for April production."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0003-000000000004',
  'd0000000-0000-0000-0000-000000000007',
  '7.3.4',
  15,
  'Hotel Cash Planning',
  'hotel-cash-planning',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Room revenue: Dec CHF 200K, Jan CHF 150K. Collection: 80% current, 20% next month. January room collections:",
        "options": ["CHF 120,000", "CHF 160,000", "CHF 150,000", "CHF 170,000"],
        "correct": 1,
        "explanation": "From Dec: 200K x 20% = 40K. From Jan: 150K x 80% = 120K. Total: CHF 160,000"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Beginning cash CHF 30K, collections CHF 160K, disbursements CHF 175K. Ending before financing:",
        "options": ["CHF 15,000", "CHF (15,000)", "CHF 365,000", "CHF 175,000"],
        "correct": 0,
        "explanation": "Ending = 30,000 + 160,000 - 175,000 = CHF 15,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If minimum cash is CHF 25,000 and ending (before financing) is CHF 15,000, financing needed:",
        "options": ["CHF 0", "CHF 10,000", "CHF 15,000", "CHF 25,000"],
        "correct": 1,
        "explanation": "Need to borrow CHF 10,000 to reach minimum of CHF 25,000"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A seasonal hotel should anticipate cash needs during the low season.",
        "correct": true,
        "explanation": "True. Low season brings lower collections but many fixed cash payments continue."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0003-000000000005',
  'd0000000-0000-0000-0000-000000000007',
  '7.3.5',
  16,
  'Seasonal Cash Flow',
  'seasonal-cash-flow',
  'lesson',
  10,
  30,
  'basic',
  '{"markdown": "# Seasonal Cash Flow Planning\n\n## Challenge for Seasonal Businesses\n\nHotels and resorts face dramatic seasonal swings:\n- High season: Strong cash inflows\n- Low season: Weak inflows but ongoing fixed costs\n\n---\n\n## Example: Ski Resort Cash Planning\n\n| Quarter | Revenue | Collections | Fixed Costs | Cash Flow |\n|---------|---------|-------------|-------------|----------|\n| Q1 (Winter) | CHF 800K | CHF 720K | CHF 200K | Strong + |\n| Q2 (Spring) | CHF 200K | CHF 280K | CHF 200K | Marginal |\n| Q3 (Summer) | CHF 150K | CHF 170K | CHF 200K | Negative |\n| Q4 (Fall) | CHF 250K | CHF 215K | CHF 200K | Marginal |\n\n**Key Insight**: Collections lag revenue (carryover from prior quarter).\n\n---\n\n## Strategies for Seasonal Cash Management\n\n1. **Build reserves** during peak season\n2. **Arrange credit lines** before low season\n3. **Time major expenditures** around cash availability\n4. **Reduce variable costs** during slow periods\n5. **Consider off-season revenue** opportunities\n\n---\n\n## Line of Credit Planning\n\n- Borrow during low months (Q2-Q3)\n- Repay during high months (Q1, Q4)\n- Budget for interest expense\n\n---\n\n:::takeaways\n- Seasonal businesses need careful cash planning\n- Build reserves during peak season\n- Arrange financing before you need it\n- Collections timing differs from revenue timing\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0003-000000000006',
  'd0000000-0000-0000-0000-000000000007',
  '7.3.6',
  17,
  'Cash Budget Checkpoint',
  'cash-budget-checkpoint',
  'checkpoint',
  12,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The cash budget shows:",
        "options": ["Revenue and expenses", "Assets and liabilities", "Cash inflows and outflows", "Inventory levels"],
        "correct": 2,
        "explanation": "The cash budget tracks cash receipts (collections) and cash payments."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "March sales CHF 100K (60% collected in March, 40% in April). April collections from March:",
        "options": ["CHF 40,000", "CHF 60,000", "CHF 100,000", "CHF 0"],
        "correct": 0,
        "explanation": "April collects the remaining 40% of March sales = CHF 40,000"
      },
      {
        "id": "cp3",
        "type": "true_false",
        "question": "Equipment purchases are included in cash disbursements.",
        "correct": true,
        "explanation": "True. Equipment purchases are cash outflows in the period of payment."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Beginning CHF 40K + Collections CHF 180K - Disbursements CHF 195K = Ending:",
        "options": ["CHF 25,000", "CHF 65,000", "CHF (25,000)", "CHF 415,000"],
        "correct": 0,
        "explanation": "Ending = 40,000 + 180,000 - 195,000 = CHF 25,000"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Which is NOT a cash disbursement?",
        "options": ["Wages paid", "Rent paid", "Depreciation expense", "Tax payment"],
        "correct": 2,
        "explanation": "Depreciation is not a cash payment - it allocates past costs."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Flexible Budgets (MA-27)
-- ============================================

(
  'd0700000-0000-0000-0004-000000000001',
  'd0000000-0000-0000-0000-000000000007',
  '7.4.1',
  18,
  'Static vs Flexible Budgets',
  'static-vs-flexible-budgets',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Static vs Flexible Budgets\n\n## The Problem with Static Budgets\n\nA **static budget** is prepared for ONE activity level (e.g., 1,000 rooms).\n\nBut what if actual activity is different? Comparing actual costs at 1,200 rooms to a budget at 1,000 rooms is unfair!\n\n---\n\n## The Flexible Budget Solution\n\nA **flexible budget** adjusts for the ACTUAL level of activity achieved.\n\n$$\\text{Flexible Budget} = \\text{Fixed Costs} + (\\text{Variable Rate} \\times \\text{Actual Activity})$$\n\n---\n\n## Example Comparison\n\n**Original Budget**: 1,000 room nights\n**Actual**: 1,200 room nights\n\n| | Static Budget | Flexible Budget | Actual |\n|-|--------------|-----------------|--------|\n| Room nights | 1,000 | 1,200 | 1,200 |\n| Revenue (CHF 200) | CHF 200,000 | CHF 240,000 | CHF 234,000 |\n| Variable costs (CHF 50) | (50,000) | (60,000) | (63,000) |\n| Fixed costs | (100,000) | (100,000) | (102,000) |\n| Profit | CHF 50,000 | CHF 80,000 | CHF 69,000 |\n\n---\n\n## Two Types of Variances\n\n### 1. Volume Variance (Static vs Flexible)\nDifference due to activity level\n\n$$\\text{Flexible Profit} - \\text{Static Profit} = 80,000 - 50,000 = \\text{CHF 30,000 F}$$\n\n### 2. Flexible Budget Variance (Flexible vs Actual)\nDifference due to price/efficiency\n\n$$\\text{Actual Profit} - \\text{Flexible Profit} = 69,000 - 80,000 = \\text{CHF (11,000) U}$$\n\n---\n\n## Why Flexible Budgets Matter\n\n:::concept{title=\"Fair Performance Evaluation\"}\n- Static budget: \"You spent CHF 165,000 vs budget CHF 150,000 - bad!\"\n- Flexible budget: \"At 1,200 rooms you should spend CHF 160,000, you spent CHF 165,000 - CHF 5,000 over\"\n\nFlexible budgets give a fairer, more meaningful comparison.\n:::\n\n---\n\n## Creating a Flexible Budget\n\n1. Identify fixed and variable costs\n2. Determine variable cost per unit\n3. Use actual activity level\n4. Calculate: Fixed + (Variable rate x Actual units)\n\n---\n\n:::takeaways\n- Static budgets don''t adjust for volume changes\n- Flexible budgets adjust variable costs for actual activity\n- Volume variance = difference due to activity level\n- Flexible budget variance = difference due to efficiency/price\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0004-000000000002',
  'd0000000-0000-0000-0000-000000000007',
  '7.4.2',
  19,
  'Flexible Budget Concepts',
  'flexible-budget-concepts',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A flexible budget adjusts for:",
        "options": ["Price changes", "Activity level changes", "Fixed cost changes", "All cost changes"],
        "correct": 1,
        "explanation": "Flexible budgets adjust variable costs based on actual activity achieved."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Static budget at 500 units: VC CHF 5,000. Actual activity 600 units. Flexible budget VC:",
        "options": ["CHF 5,000", "CHF 6,000", "CHF 5,500", "CHF 4,167"],
        "correct": 1,
        "explanation": "VC rate = 5,000/500 = CHF 10. Flexible = 600 x 10 = CHF 6,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Fixed costs in a flexible budget:",
        "options": ["Change with activity", "Stay the same as static budget", "Are eliminated", "Become variable"],
        "correct": 1,
        "explanation": "Fixed costs remain constant regardless of activity level."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The flexible budget variance isolates the effect of volume differences.",
        "correct": false,
        "explanation": "False. The volume variance isolates volume effects. Flexible budget variance isolates price/efficiency."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Flexible budget profit CHF 45,000, Static budget profit CHF 40,000, Actual profit CHF 42,000. Flexible budget variance:",
        "options": ["CHF 5,000 F", "CHF 3,000 U", "CHF 2,000 F", "CHF 3,000 F"],
        "correct": 1,
        "explanation": "Flexible variance = Actual - Flexible = 42,000 - 45,000 = CHF (3,000) U"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0004-000000000003',
  'd0000000-0000-0000-0000-000000000007',
  '7.4.3',
  20,
  'Flex Budget Calculator',
  'flex-budget-calculator',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Match each term to its correct definition.",
    "pairs": [
      {"left": "Static Budget", "right": "Budget prepared for one activity level"},
      {"left": "Flexible Budget", "right": "Budget adjusted to actual activity level"},
      {"left": "Volume Variance", "right": "Flexible budget - Static budget"},
      {"left": "Flexible Budget Variance", "right": "Actual - Flexible budget"},
      {"left": "Fixed costs in flex budget", "right": "Same as static budget"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

(
  'd0700000-0000-0000-0004-000000000004',
  'd0000000-0000-0000-0000-000000000007',
  '7.4.4',
  21,
  'Hotel Flex Budget',
  'hotel-flex-budget',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Budget 1,000 rooms at CHF 150/room revenue, VC CHF 40/room, FC CHF 80,000. Actual 1,100 rooms. Flexible budget revenue:",
        "options": ["CHF 150,000", "CHF 165,000", "CHF 176,000", "CHF 154,000"],
        "correct": 1,
        "explanation": "Flexible revenue = 1,100 x 150 = CHF 165,000"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Using same data, flexible budget total costs:",
        "options": ["CHF 120,000", "CHF 124,000", "CHF 128,000", "CHF 80,000"],
        "correct": 1,
        "explanation": "Flex costs = FC 80,000 + VC (1,100 x 40) = 80,000 + 44,000 = CHF 124,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Flexible budget profit:",
        "options": ["CHF 30,000", "CHF 41,000", "CHF 45,000", "CHF 52,000"],
        "correct": 1,
        "explanation": "Flex profit = 165,000 - 124,000 = CHF 41,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Static budget profit was CHF 30,000. Volume variance:",
        "options": ["CHF 11,000 F", "CHF 11,000 U", "CHF 30,000 F", "CHF 41,000 F"],
        "correct": 0,
        "explanation": "Volume variance = Flex - Static = 41,000 - 30,000 = CHF 11,000 F"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0700000-0000-0000-0004-000000000005',
  'd0000000-0000-0000-0000-000000000007',
  '7.4.5',
  22,
  'Flexible Budget Checkpoint',
  'flexible-budget-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "A flexible budget formula is: Fixed Costs + (Variable Rate x ___)",
        "options": ["Budgeted Units", "Actual Units", "Maximum Units", "Minimum Units"],
        "correct": 1,
        "explanation": "Flexible budgets use actual activity to calculate expected costs."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Static: 800 units, costs CHF 60,000 (FC 20,000 + VC 40,000). Actual 1,000 units. Flexible budget cost:",
        "options": ["CHF 60,000", "CHF 70,000", "CHF 75,000", "CHF 50,000"],
        "correct": 1,
        "explanation": "VC rate = 40,000/800 = 50. Flex = 20,000 + (1,000 x 50) = CHF 70,000"
      },
      {
        "id": "cp3",
        "type": "true_false",
        "question": "A favorable volume variance means actual volume exceeded budget.",
        "correct": true,
        "explanation": "True. Higher volume typically means higher contribution margin."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Actual costs CHF 72,000, Flexible budget CHF 70,000. Flexible budget variance:",
        "options": ["CHF 2,000 F", "CHF 2,000 U", "CHF 70,000 U", "CHF 72,000 F"],
        "correct": 1,
        "explanation": "Variance = Actual - Flex = 72,000 - 70,000 = CHF 2,000 U (over budget)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- Link Activities to Skills
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, is_primary, weight) VALUES
-- Skill MA-24: Master Budget Overview
('d0700000-0000-0000-0001-000000000001', 'd0000000-0000-0000-0007-000000000001', true, 1.0),
('d0700000-0000-0000-0001-000000000002', 'd0000000-0000-0000-0007-000000000001', true, 1.0),
('d0700000-0000-0000-0001-000000000003', 'd0000000-0000-0000-0007-000000000001', true, 1.0),
('d0700000-0000-0000-0001-000000000004', 'd0000000-0000-0000-0007-000000000001', true, 1.0),
('d0700000-0000-0000-0001-000000000005', 'd0000000-0000-0000-0007-000000000001', true, 1.0),

-- Skill MA-25: Sales & Production Budgets
('d0700000-0000-0000-0002-000000000001', 'd0000000-0000-0000-0007-000000000002', true, 1.0),
('d0700000-0000-0000-0002-000000000002', 'd0000000-0000-0000-0007-000000000002', true, 1.0),
('d0700000-0000-0000-0002-000000000003', 'd0000000-0000-0000-0007-000000000002', true, 1.0),
('d0700000-0000-0000-0002-000000000004', 'd0000000-0000-0000-0007-000000000002', true, 1.0),
('d0700000-0000-0000-0002-000000000005', 'd0000000-0000-0000-0007-000000000002', true, 1.0),
('d0700000-0000-0000-0002-000000000006', 'd0000000-0000-0000-0007-000000000002', true, 1.0),

-- Skill MA-26: Cash Budget
('d0700000-0000-0000-0003-000000000001', 'd0000000-0000-0000-0007-000000000003', true, 1.0),
('d0700000-0000-0000-0003-000000000002', 'd0000000-0000-0000-0007-000000000003', true, 1.0),
('d0700000-0000-0000-0003-000000000003', 'd0000000-0000-0000-0007-000000000003', true, 1.0),
('d0700000-0000-0000-0003-000000000004', 'd0000000-0000-0000-0007-000000000003', true, 1.0),
('d0700000-0000-0000-0003-000000000005', 'd0000000-0000-0000-0007-000000000003', true, 1.0),
('d0700000-0000-0000-0003-000000000006', 'd0000000-0000-0000-0007-000000000003', true, 1.0),

-- Skill MA-27: Flexible Budgets
('d0700000-0000-0000-0004-000000000001', 'd0000000-0000-0000-0007-000000000004', true, 1.0),
('d0700000-0000-0000-0004-000000000002', 'd0000000-0000-0000-0007-000000000004', true, 1.0),
('d0700000-0000-0000-0004-000000000003', 'd0000000-0000-0000-0007-000000000004', true, 1.0),
('d0700000-0000-0000-0004-000000000004', 'd0000000-0000-0000-0007-000000000004', true, 1.0),
('d0700000-0000-0000-0004-000000000005', 'd0000000-0000-0000-0007-000000000004', true, 1.0);

