-- ============================================
-- Module 2: Cost Classification Activities
-- 3 Skills: Direct vs Indirect, Product vs Period, Prime vs Conversion
-- ~16 Activities with comprehensive lesson content
-- ============================================

-- Clean up existing data to avoid conflicts
DELETE FROM activity_skills WHERE activity_id IN (
  SELECT id FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000002'
);
DELETE FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000002';

-- ============================================
-- SKILL: Direct vs Indirect Costs (MA-04)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 2.1.1: Direct and Indirect Costs Explained
(
  'd0200000-0000-0000-0001-000000000001',
  'd0000000-0000-0000-0000-000000000002',
  '2.1.1',
  1,
  'Direct and Indirect Costs Explained',
  'direct-indirect-costs-explained',
  'lesson',
  15,
  30,
  'free',
  '{"markdown": "# Direct and Indirect Costs Explained\n\n## The Key Question: Can We Trace It?\n\nThe difference between direct and indirect costs comes down to one question:\n\n> **Can we easily and economically trace this cost to a specific cost object?**\n\n- **YES** = Direct Cost\n- **NO** = Indirect Cost\n\n---\n\n## Direct Costs\n\nCosts that can be **physically and conveniently traced** to a specific cost object.\n\n### Characteristics:\n- Clearly identifiable with the cost object\n- Economically feasible to trace\n- Specific and exclusive to that cost object\n\n### Examples in a Hotel:\n\n| Cost | Cost Object | Why Direct? |\n|------|------------|-------------|\n| Guest room amenities | Room night | Used only in that room |\n| Banquet food | Catering event | Prepared specifically for that event |\n| Server wages | Shift | Worked only during that shift |\n| Minibar contents | Room | Stocked in specific room |\n\n---\n\n## Indirect Costs\n\nCosts that **cannot be conveniently traced** to a specific cost object. They benefit multiple cost objects and must be **allocated**.\n\n### Characteristics:\n- Shared by multiple cost objects\n- Not economically feasible to trace\n- Require an allocation method\n\n### Examples in a Hotel:\n\n| Cost | Cost Object | Why Indirect? |\n|------|------------|---------------|\n| Hotel property insurance | Room night | Covers entire property |\n| Front desk staff salary | Room night | Serves all guests |\n| Electricity bill | Meal served | Powers entire kitchen |\n| General manager salary | Department | Oversees all operations |\n\n---\n\n## The Traceability Concept\n\n```\n                    CAN THE COST BE TRACED?\n                            |\n            +---------------+---------------+\n            |                               |\n    YES - Physically &              NO - Shared or\n    economically feasible           impractical to trace\n            |                               |\n      DIRECT COST                   INDIRECT COST\n   (assign directly)              (must allocate)\n```\n\n---\n\n## Why Classification Matters\n\n### For Product Costing\nAccurate cost classification leads to accurate product costs, which affects:\n- Pricing decisions\n- Profitability analysis\n- Make-or-buy decisions\n\n### For Cost Control\n- Direct costs are easier to control and hold someone accountable\n- Indirect costs require allocation, making control more complex\n\n---\n\n## Context Matters!\n\nThe same cost can be direct or indirect depending on the cost object:\n\n| Cost | Cost Object: Department | Cost Object: Individual Room Night |\n|------|------------------------|------------------------------------|\n| Housekeeping supervisor salary | Direct | Indirect |\n| Room cleaning supplies | Direct | Could be either |\n| Hotel general manager | Indirect | Indirect |\n\n---\n\n:::concept{title=\"The 5% Rule (Practical Guideline)\"}\nSome companies treat small costs as indirect even if technically traceable:\n- If a cost is less than 5% of total cost\n- And tracking it is expensive\n- It may be treated as indirect for simplicity\n:::\n\n---\n\n:::takeaways\n- **Direct costs**: Traceable and exclusive to the cost object\n- **Indirect costs**: Shared and must be allocated\n- Classification depends on the cost object chosen\n- Accurate classification is essential for good decisions\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.1.2: Direct vs Indirect Costs Quiz
(
  'd0200000-0000-0000-0001-000000000002',
  'd0000000-0000-0000-0000-000000000002',
  '2.1.2',
  2,
  'Direct vs Indirect Costs Quiz',
  'direct-indirect-costs-quiz',
  'quiz',
  8,
  30,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A direct cost is one that:",
        "options": ["Always varies with production", "Can be traced to a cost object", "Is always a fixed cost", "Is controlled by top management"],
        "correct": 1,
        "explanation": "A direct cost can be physically and conveniently traced to a specific cost object."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If the cost object is a hotel guest room night, which cost is DIRECT?",
        "options": ["Hotel insurance", "Housekeeping supervisor salary", "Guest toiletries placed in the room", "Front desk clerk wages"],
        "correct": 2,
        "explanation": "Guest toiletries placed in a specific room are directly traceable to that room night."
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Indirect costs cannot be assigned to cost objects at all.",
        "correct": false,
        "explanation": "False. Indirect costs CAN be assigned to cost objects, but through allocation rather than direct tracing."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A restaurant manager''s salary when the cost object is a single meal is:",
        "options": ["A direct cost", "An indirect cost", "Not a cost", "A variable cost"],
        "correct": 1,
        "explanation": "The manager supervises all operations; their salary cannot be traced to one specific meal."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Why might a company treat a small but traceable cost as indirect?",
        "options": ["It''s required by GAAP", "The cost of tracking exceeds the benefit", "Direct costs must be large", "Indirect costs are more accurate"],
        "correct": 1,
        "explanation": "If tracking a small cost is more expensive than the information is worth, it may be treated as indirect."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "The housekeeping supervisor''s salary is DIRECT when the cost object is:",
        "options": ["A specific guest room", "The housekeeping department", "A single room night", "The entire hotel"],
        "correct": 1,
        "explanation": "The supervisor''s salary is directly traceable to the housekeeping department as a whole."
      },
      {
        "id": "q7",
        "type": "true_false",
        "difficulty": "applied",
        "question": "The classification of a cost as direct or indirect depends on the cost object.",
        "correct": true,
        "explanation": "True. The same cost may be direct for one cost object but indirect for another."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "basic",
        "question": "An indirect cost is also commonly called:",
        "options": ["A variable cost", "An overhead cost", "A prime cost", "A sunk cost"],
        "correct": 1,
        "explanation": "Indirect costs are commonly referred to as overhead costs because they cannot be directly traced."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.1.3: Cost Classification Sorter Interactive
(
  'd0200000-0000-0000-0001-000000000003',
  'd0000000-0000-0000-0000-000000000002',
  '2.1.3',
  3,
  'Cost Classification Sorter',
  'cost-classification-sorter',
  'interactive',
  6,
  25,
  'free',
  '{
    "instructions": "Sort each cost as Direct or Indirect when the cost object is a SINGLE HOTEL GUEST ROOM NIGHT.",
    "categories": ["Direct Costs", "Indirect Costs"],
    "items": [
      {"text": "Toiletries placed in the room", "category": "Direct Costs"},
      {"text": "Hotel property taxes", "category": "Indirect Costs"},
      {"text": "Cleaning the specific room", "category": "Direct Costs"},
      {"text": "Hotel general manager salary", "category": "Indirect Costs"},
      {"text": "Room linens used", "category": "Direct Costs"},
      {"text": "Lobby maintenance", "category": "Indirect Costs"},
      {"text": "In-room coffee supplies", "category": "Direct Costs"},
      {"text": "Hotel-wide WiFi service", "category": "Indirect Costs"},
      {"text": "Front desk night staff", "category": "Indirect Costs"},
      {"text": "Minibar restocking for this room", "category": "Direct Costs"}
    ]
  }'::jsonb,
  'category-sort',
  false,
  true
),

-- Activity 2.1.4: Hotel Room Service Costs Practice
(
  'd0200000-0000-0000-0001-000000000004',
  'd0000000-0000-0000-0000-000000000002',
  '2.1.4',
  4,
  'Hotel Room Service Cost Classification',
  'hotel-room-service-costs',
  'lesson',
  10,
  25,
  'free',
  '{"markdown": "# Hotel Room Service Cost Classification\n\n## Lakeside Hotel Room Service Department\n\nThe Lakeside Hotel wants to determine the cost of a room service order. Let''s classify each cost.\n\n**Cost Object: One Room Service Order**\n\n---\n\n## Cost Classification Exercise\n\n| Cost Item | Monthly Amount | Classification | Reason |\n|-----------|---------------|----------------|--------|\n| Food ingredients for order | Varies | Direct | Used specifically for this order |\n| Server wage (delivery time) | Varies | Direct | Time spent on this order |\n| Room service manager salary | CHF 6,000 | Indirect | Supervises all orders |\n| Trays and covers used | Varies | Direct | Used for this order |\n| Kitchen equipment depreciation | CHF 2,000 | Indirect | Used for all food prep |\n| Order ticket paper | CHF 50 | Indirect | Immaterial to trace |\n| Kitchen utilities | CHF 3,000 | Indirect | Shared by all cooking |\n| Delivery cart maintenance | CHF 200 | Indirect | Used for all deliveries |\n\n---\n\n## Calculating Order Cost\n\n### Direct Costs (Traced)\n\n| Item | Amount |\n|------|--------|\n| Steak and sides | CHF 22.00 |\n| Beverages | CHF 8.00 |\n| Server time (12 min @ CHF 24/hr) | CHF 4.80 |\n| Tray, covers, linens | CHF 1.50 |\n| **Total Direct Costs** | **CHF 36.30** |\n\n### Indirect Costs (Allocated)\n\nIf room service handles 500 orders/month and total indirect costs are CHF 11,250:\n\n```\nIndirect cost per order = CHF 11,250 / 500 = CHF 22.50\n```\n\n### Total Order Cost\n\n| Component | Amount |\n|-----------|--------|\n| Direct costs | CHF 36.30 |\n| Allocated indirect costs | CHF 22.50 |\n| **Total Cost** | **CHF 58.80** |\n\n---\n\n## Using This Information\n\n### Pricing Decision\nIf the order sells for CHF 85:\n- Cost: CHF 58.80\n- Profit: CHF 26.20 (30.8% margin)\n\n### Cost Control\n- Direct costs: Control at the order level\n- Indirect costs: Control at the department level\n\n---\n\n:::takeaways\n- Direct costs are traced to each order specifically\n- Indirect costs are allocated based on activity level\n- Total cost = Direct + Allocated Indirect\n- This analysis supports pricing and profitability decisions\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.1.5: Restaurant Meal Costing Practice
(
  'd0200000-0000-0000-0001-000000000005',
  'd0000000-0000-0000-0000-000000000002',
  '2.1.5',
  5,
  'Restaurant Meal Costing',
  'restaurant-meal-costing',
  'quiz',
  10,
  35,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The beef used to prepare a steak dinner is what type of cost?",
        "options": ["Indirect material", "Direct material", "Manufacturing overhead", "Period cost"],
        "correct": 1,
        "explanation": "The beef can be directly traced to the steak dinner being prepared."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The chef''s time spent preparing a specific dish is:",
        "options": ["Indirect labor", "Direct labor", "Fixed overhead", "Period cost"],
        "correct": 1,
        "explanation": "Time spent directly on a specific dish is direct labor - traceable to that cost object."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Kitchen rent when the cost object is one meal served is:",
        "options": ["Direct cost", "Indirect cost", "Prime cost", "Conversion cost"],
        "correct": 1,
        "explanation": "Rent benefits all meals and cannot be traced to one specific meal - it must be allocated."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A restaurant has CHF 15,000 monthly indirect costs and serves 3,000 meals. Direct costs for a salmon dish are CHF 12. Total cost per salmon dish is:",
        "options": ["CHF 12.00", "CHF 17.00", "CHF 27.00", "CHF 15.00"],
        "correct": 1,
        "explanation": "Indirect per meal = 15,000/3,000 = CHF 5. Total = CHF 12 + CHF 5 = CHF 17."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Cooking oil used in small amounts across many dishes would typically be treated as an indirect material.",
        "correct": true,
        "explanation": "True. While technically traceable, the cost of tracking small amounts of oil per dish exceeds the benefit."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.1.6: Direct vs Indirect Checkpoint
(
  'd0200000-0000-0000-0001-000000000006',
  'd0000000-0000-0000-0000-000000000002',
  '2.1.6',
  6,
  'Direct vs Indirect Checkpoint',
  'direct-indirect-checkpoint',
  'checkpoint',
  10,
  40,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The key characteristic that makes a cost DIRECT is:",
        "options": ["It varies with production", "It can be traced to a cost object", "It is controlled by management", "It occurs every month"],
        "correct": 1,
        "explanation": "Traceability to the cost object is the defining characteristic of direct costs."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "For a catering event (cost object), which is a DIRECT cost?",
        "options": ["Kitchen manager salary", "Event hall insurance", "Food prepared for the event", "General office supplies"],
        "correct": 2,
        "explanation": "Food prepared specifically for one event is directly traceable to that event."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Indirect costs are assigned to cost objects through:",
        "options": ["Direct tracing", "Cost allocation", "Physical counting", "Budget variance"],
        "correct": 1,
        "explanation": "Because indirect costs cannot be traced, they must be allocated using an allocation base."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "A cost classified as direct for one cost object may be indirect for another.",
        "correct": true,
        "explanation": "True. The classification depends entirely on what cost object you are measuring."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "A hotel has CHF 200,000 indirect costs. Rooms department earns 60% of revenue, F&B earns 40%. Indirect costs allocated to Rooms:",
        "options": ["CHF 80,000", "CHF 100,000", "CHF 120,000", "CHF 200,000"],
        "correct": 2,
        "explanation": "Rooms allocation = 60% x CHF 200,000 = CHF 120,000"
      },
      {
        "id": "cp6",
        "type": "mcq",
        "question": "The salary of a department supervisor is DIRECT when the cost object is:",
        "options": ["A single product", "A customer order", "The entire department", "One hour of production"],
        "correct": 2,
        "explanation": "The supervisor''s salary can be directly traced to their department as a whole."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- SKILL: Product vs Period Costs (MA-05)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 2.2.1: Product Costs vs Period Costs
(
  'd0200000-0000-0000-0002-000000000001',
  'd0000000-0000-0000-0000-000000000002',
  '2.2.1',
  7,
  'Product Costs vs Period Costs',
  'product-vs-period-costs',
  'lesson',
  12,
  30,
  'free',
  '{"markdown": "# Product Costs vs Period Costs\n\n## Two Categories of Costs\n\nAll costs in a business fall into one of two categories based on how they are treated on financial statements:\n\n| Product Costs | Period Costs |\n|--------------|---------------|\n| Attached to inventory | Expensed immediately |\n| Appear on Balance Sheet (until sold) | Appear on Income Statement |\n| Become COGS when sold | Become expense when incurred |\n| Also called \"inventoriable costs\" | Also called \"operating expenses\" |\n\n---\n\n## Product Costs\n\nCosts necessary to **make or acquire** products for sale.\n\n### For Manufacturers:\n- **Direct Materials**: Raw materials in the product\n- **Direct Labor**: Labor to produce the product\n- **Manufacturing Overhead**: Indirect factory costs\n\n### For Retailers/Hotels:\n- Cost of goods purchased for resale\n- Food ingredients for restaurant\n- Beverages for bar\n\n### Financial Statement Impact:\n\n```\nProduct Costs Incurred\n        |\n        v\nInventory (Balance Sheet)\n        |\n        v (when sold)\nCost of Goods Sold (Income Statement)\n```\n\n---\n\n## Period Costs\n\nCosts that are **not part of production** - they support operations but don''t create inventory.\n\n### Examples:\n- **Selling Costs**: Advertising, sales commissions, marketing\n- **Administrative Costs**: Office salaries, accounting, legal\n- **General Overhead**: Corporate headquarters, HR department\n\n### Financial Statement Impact:\n\n```\nPeriod Costs Incurred\n        |\n        v\nOperating Expenses (Income Statement immediately)\n```\n\n---\n\n## The Key Distinction\n\n:::concept{title=\"Inventoriable vs Non-Inventoriable\"}\n- **Product costs** stay in inventory until sold - they follow the product\n- **Period costs** expire with time - they are matched to the period, not the product\n:::\n\n---\n\n## Hotel Industry Examples\n\n| Cost | Product or Period? | Reason |\n|------|-------------------|--------|\n| Food ingredients | Product | Part of meal served |\n| Chef wages (cooking) | Product | Creates the product |\n| Kitchen utilities | Product | Factory overhead |\n| Restaurant advertising | Period | Selling expense |\n| Hotel GM salary | Period | Administrative expense |\n| Accounting department | Period | Administrative expense |\n| Housekeeping supplies | Product | Creates the room product |\n| Sales team commissions | Period | Selling expense |\n\n---\n\n## Impact on Timing of Expenses\n\n### Example: Hotel Kitchen\n\n**January**: Purchased CHF 10,000 of food ingredients\n- CHF 8,000 used to prepare meals (Product Cost)\n- CHF 2,000 still in inventory\n\n**January Income Statement shows**:\n- COGS: CHF 8,000 (for meals sold)\n- Inventory on Balance Sheet: CHF 2,000\n\n**If treated as Period Cost (incorrect)**:\n- Operating expense: CHF 10,000\n- No inventory on Balance Sheet\n\n---\n\n:::takeaways\n- **Product costs**: Inventoried, become COGS when sold\n- **Period costs**: Expensed immediately in the period incurred\n- Manufacturing costs (DM, DL, MOH) are product costs\n- Selling and administrative costs are period costs\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.2.2: Product vs Period Quiz
(
  'd0200000-0000-0000-0002-000000000002',
  'd0000000-0000-0000-0000-000000000002',
  '2.2.2',
  8,
  'Product vs Period Quiz',
  'product-vs-period-quiz',
  'quiz',
  8,
  30,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Product costs are also known as:",
        "options": ["Operating expenses", "Inventoriable costs", "Period expenses", "Sunk costs"],
        "correct": 1,
        "explanation": "Product costs are inventoriable - they become part of inventory until sold."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which appears on the Income Statement IMMEDIATELY when incurred?",
        "options": ["Direct materials", "Direct labor", "Manufacturing overhead", "Selling expenses"],
        "correct": 3,
        "explanation": "Selling expenses are period costs - they are expensed immediately, not inventoried."
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Manufacturing overhead is a period cost.",
        "correct": false,
        "explanation": "False. Manufacturing overhead is a product cost - it becomes part of inventory."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "In a hotel, the restaurant advertising expense is:",
        "options": ["A product cost", "A period cost", "Part of COGS", "Inventory"],
        "correct": 1,
        "explanation": "Advertising is a selling expense - a period cost that is expensed immediately."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Kitchen equipment depreciation in a hotel restaurant is:",
        "options": ["A period cost", "A product cost", "Not a cost", "A selling expense"],
        "correct": 1,
        "explanation": "Equipment depreciation in the production area (kitchen) is manufacturing overhead - a product cost."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If unsold inventory increases during a period, then product costs:",
        "options": ["All become expenses", "Partially remain on the Balance Sheet", "Are classified as period costs", "Decrease total assets"],
        "correct": 1,
        "explanation": "Product costs for unsold items remain in inventory on the Balance Sheet until sold."
      },
      {
        "id": "q7",
        "type": "true_false",
        "difficulty": "applied",
        "question": "The hotel general manager''s salary is a period cost.",
        "correct": true,
        "explanation": "True. The GM salary is an administrative cost - a period cost expensed immediately."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Food ingredients purchased but not yet used in cooking are:",
        "options": ["Cost of goods sold", "Operating expense", "Raw materials inventory", "Period costs"],
        "correct": 2,
        "explanation": "Unused food ingredients are product costs held in inventory until used."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.2.3: Income Statement Impact Interactive
(
  'd0200000-0000-0000-0002-000000000003',
  'd0000000-0000-0000-0000-000000000002',
  '2.2.3',
  9,
  'Income Statement Impact',
  'income-statement-impact',
  'interactive',
  6,
  25,
  'free',
  '{
    "instructions": "Place each cost in the correct location: Balance Sheet (Inventory) or Income Statement (Expense This Period)",
    "categories": ["Balance Sheet - Inventory", "Income Statement - Expense"],
    "items": [
      {"text": "Unused food ingredients", "category": "Balance Sheet - Inventory"},
      {"text": "Hotel advertising expense", "category": "Income Statement - Expense"},
      {"text": "Linens for rooms not yet rented", "category": "Balance Sheet - Inventory"},
      {"text": "Administrative staff salaries", "category": "Income Statement - Expense"},
      {"text": "Completed meals not yet sold", "category": "Balance Sheet - Inventory"},
      {"text": "Sales commission paid", "category": "Income Statement - Expense"},
      {"text": "Kitchen equipment depreciation (for unsold goods)", "category": "Balance Sheet - Inventory"},
      {"text": "Legal fees", "category": "Income Statement - Expense"}
    ]
  }'::jsonb,
  'category-sort',
  false,
  true
),

-- Activity 2.2.4: Hotel Operations Classification
(
  'd0200000-0000-0000-0002-000000000004',
  'd0000000-0000-0000-0000-000000000002',
  '2.2.4',
  10,
  'Hotel Operations Classification',
  'hotel-operations-classification',
  'quiz',
  10,
  35,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Guest room cleaning supplies are:",
        "options": ["Period costs - expensed immediately", "Product costs - part of room service", "Selling costs", "Administrative costs"],
        "correct": 1,
        "explanation": "Cleaning supplies are necessary to produce the room product and are inventoriable."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The reservation system license fee is:",
        "options": ["A product cost", "A period cost", "Inventory", "Cost of goods sold"],
        "correct": 1,
        "explanation": "Reservation system fees are administrative/selling costs - period costs."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel kitchen produced CHF 50,000 of meals. CHF 45,000 were sold. Product costs in Finished Goods at month end:",
        "options": ["CHF 0", "CHF 5,000", "CHF 45,000", "CHF 50,000"],
        "correct": 1,
        "explanation": "CHF 5,000 remains in inventory (CHF 50,000 produced - CHF 45,000 sold)."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Travel agent commissions for room bookings are:",
        "options": ["Product costs", "Period costs - selling", "Manufacturing overhead", "Direct labor"],
        "correct": 1,
        "explanation": "Sales commissions are selling expenses - period costs expensed when incurred."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "The cost of beverages in a hotel bar is a product cost.",
        "correct": true,
        "explanation": "True. Beverages purchased for resale are inventoriable product costs."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.2.5: Product vs Period Checkpoint
(
  'd0200000-0000-0000-0002-000000000005',
  'd0000000-0000-0000-0000-000000000002',
  '2.2.5',
  11,
  'Product vs Period Checkpoint',
  'product-vs-period-checkpoint',
  'checkpoint',
  10,
  40,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The three types of product costs for a manufacturer are:",
        "options": ["Selling, Admin, Finance", "Direct Materials, Direct Labor, MOH", "Fixed, Variable, Mixed", "Assets, Liabilities, Equity"],
        "correct": 1,
        "explanation": "Product costs = Direct Materials + Direct Labor + Manufacturing Overhead."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Which statement about period costs is TRUE?",
        "options": ["They become part of inventory", "They are expensed when incurred", "They include manufacturing overhead", "They appear on Balance Sheet"],
        "correct": 1,
        "explanation": "Period costs are expensed immediately in the period they are incurred."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "A restaurant had CHF 20,000 in food purchases. Ending food inventory is CHF 4,000. Cost of Goods Sold is:",
        "options": ["CHF 16,000", "CHF 20,000", "CHF 24,000", "CHF 4,000"],
        "correct": 0,
        "explanation": "COGS = Purchases - Ending Inventory = CHF 20,000 - CHF 4,000 = CHF 16,000."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Hotel front desk computers depreciation is a product cost.",
        "correct": false,
        "explanation": "False. Front desk is administrative, not production. The depreciation is a period cost."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "If production exceeds sales in a period, then compared to period costs, product costs will:",
        "options": ["Show higher expenses", "Show lower expenses", "Be the same", "Not affect expenses"],
        "correct": 1,
        "explanation": "Some product costs remain in inventory, reducing current period expenses compared to full production."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "question": "The accounting department salary is classified as:",
        "options": ["Manufacturing overhead", "Direct labor", "Period cost - administrative", "Product cost"],
        "correct": 2,
        "explanation": "Accounting is an administrative function - a period cost expensed immediately."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- SKILL: Prime Costs & Conversion Costs (MA-06)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 2.3.1: Prime Costs and Conversion Costs
(
  'd0200000-0000-0000-0003-000000000001',
  'd0000000-0000-0000-0000-000000000002',
  '2.3.1',
  12,
  'Prime Costs and Conversion Costs',
  'prime-conversion-costs',
  'lesson',
  12,
  30,
  'free',
  '{"markdown": "# Prime Costs and Conversion Costs\n\n## Two Useful Cost Groupings\n\nManufacturing costs can be grouped in different ways for analysis:\n\n---\n\n## Prime Costs\n\n**Prime Costs = Direct Materials + Direct Labor**\n\nThe PRIMARY or FIRST costs that go directly into the product.\n\n### Characteristics:\n- All direct costs\n- Can be traced to specific products\n- Vary with production volume\n- Easiest to control\n\n### Restaurant Example:\n| Prime Cost Component | Example |\n|---------------------|----------|\n| Direct Materials | Salmon, vegetables, sauce |\n| Direct Labor | Chef time preparing dish |\n| **Total Prime Cost** | CHF 15.00 per dish |\n\n---\n\n## Conversion Costs\n\n**Conversion Costs = Direct Labor + Manufacturing Overhead**\n\nCosts to CONVERT raw materials into finished products.\n\n### Characteristics:\n- Includes direct labor (overlap with prime)\n- Includes all indirect production costs\n- Represents the value added in manufacturing\n\n### Restaurant Example:\n| Conversion Cost Component | Amount |\n|--------------------------|--------|\n| Direct Labor (chef) | CHF 4.00 |\n| Manufacturing Overhead | CHF 3.00 |\n| **Total Conversion Cost** | CHF 7.00 per dish |\n\n---\n\n## The Overlap: Direct Labor\n\nNote that **Direct Labor is included in BOTH**:\n\n```\n                 PRIME COSTS\n            +----------------+\n            | Direct         |\n            | Materials      |\n            |                |\n            +-------+--------+\n                    |Direct  |\n                    |Labor   |  <-- Shared\n            +-------+--------+\n            | Manufacturing  |\n            | Overhead       |\n            +----------------+\n               CONVERSION COSTS\n```\n\n---\n\n## Formula Summary\n\n| Category | Formula |\n|----------|--------|\n| Prime Costs | DM + DL |\n| Conversion Costs | DL + MOH |\n| Total Manufacturing Costs | DM + DL + MOH |\n| Also: | Prime + MOH = Total |\n| Also: | DM + Conversion = Total |\n\n---\n\n## Why These Groupings Matter\n\n### Prime Costs\n- Focus on direct, traceable costs\n- Useful for product pricing\n- Easier to hold managers accountable\n\n### Conversion Costs\n- Measures value added in production\n- Useful in process costing\n- Important for automation decisions\n\n---\n\n## Calculation Example\n\n**Lakeside Kitchen - Monthly Costs:**\n\n| Cost | Amount |\n|------|--------|\n| Direct Materials | CHF 42,000 |\n| Direct Labor | CHF 28,000 |\n| Manufacturing Overhead | CHF 18,000 |\n\n### Calculations:\n\n```\nPrime Costs = DM + DL\n            = 42,000 + 28,000\n            = CHF 70,000\n\nConversion Costs = DL + MOH\n                 = 28,000 + 18,000\n                 = CHF 46,000\n\nTotal Manufacturing = DM + DL + MOH\n                    = 42,000 + 28,000 + 18,000\n                    = CHF 88,000\n```\n\nNote: CHF 70,000 + CHF 46,000 = CHF 116,000 (not CHF 88,000)\nBecause Direct Labor (CHF 28,000) is counted in both!\n\n---\n\n:::takeaways\n- **Prime Costs** = Direct Materials + Direct Labor\n- **Conversion Costs** = Direct Labor + Manufacturing Overhead\n- Direct Labor appears in BOTH categories\n- Prime + Conversion - DL = Total Manufacturing Costs\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.3.2: Cost Category Calculations Quiz
(
  'd0200000-0000-0000-0003-000000000002',
  'd0000000-0000-0000-0000-000000000002',
  '2.3.2',
  13,
  'Cost Category Calculations Quiz',
  'cost-category-calculations-quiz',
  'quiz',
  10,
  35,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Prime costs consist of:",
        "options": ["DM + MOH", "DL + MOH", "DM + DL", "DM + DL + MOH"],
        "correct": 2,
        "explanation": "Prime costs = Direct Materials + Direct Labor."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Conversion costs consist of:",
        "options": ["DM + DL", "DM + MOH", "DL + MOH", "DM + DL + MOH"],
        "correct": 2,
        "explanation": "Conversion costs = Direct Labor + Manufacturing Overhead."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If DM = CHF 50,000, DL = CHF 30,000, MOH = CHF 25,000, what are Prime Costs?",
        "options": ["CHF 80,000", "CHF 55,000", "CHF 75,000", "CHF 105,000"],
        "correct": 0,
        "explanation": "Prime Costs = DM + DL = CHF 50,000 + CHF 30,000 = CHF 80,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Using the same costs (DM = 50k, DL = 30k, MOH = 25k), what are Conversion Costs?",
        "options": ["CHF 80,000", "CHF 55,000", "CHF 75,000", "CHF 105,000"],
        "correct": 1,
        "explanation": "Conversion Costs = DL + MOH = CHF 30,000 + CHF 25,000 = CHF 55,000"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which cost is included in BOTH prime costs and conversion costs?",
        "options": ["Direct Materials", "Direct Labor", "Manufacturing Overhead", "Period Costs"],
        "correct": 1,
        "explanation": "Direct Labor is part of both Prime (DM+DL) and Conversion (DL+MOH) costs."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Prime costs are CHF 90,000 and Conversion costs are CHF 75,000. If DL is CHF 40,000, what is MOH?",
        "options": ["CHF 35,000", "CHF 50,000", "CHF 75,000", "CHF 115,000"],
        "correct": 0,
        "explanation": "Conversion = DL + MOH. So MOH = 75,000 - 40,000 = CHF 35,000"
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Using the same data (Prime 90k, Conversion 75k, DL 40k), what are Total Manufacturing Costs?",
        "options": ["CHF 125,000", "CHF 165,000", "CHF 85,000", "CHF 205,000"],
        "correct": 0,
        "explanation": "DM = Prime - DL = 90k - 40k = 50k. Total = 50k + 40k + 35k = CHF 125,000. Or: Prime + MOH = 90k + 35k = CHF 125,000"
      },
      {
        "id": "q8",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Prime costs plus Conversion costs equals Total Manufacturing Costs.",
        "correct": false,
        "explanation": "False. Prime + Conversion counts Direct Labor twice. Total = Prime + Conversion - DL"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.3.3: Venn Diagram Interactive
(
  'd0200000-0000-0000-0003-000000000003',
  'd0000000-0000-0000-0000-000000000002',
  '2.3.3',
  14,
  'Manufacturing Cost Venn Diagram',
  'manufacturing-cost-venn',
  'interactive',
  6,
  25,
  'free',
  '{
    "instructions": "Place each cost component in the correct section of the Venn diagram: Prime Only, Conversion Only, or Both (Overlap)",
    "categories": ["Prime Costs Only", "Both (Overlap)", "Conversion Costs Only"],
    "items": [
      {"text": "Direct Materials", "category": "Prime Costs Only"},
      {"text": "Direct Labor", "category": "Both (Overlap)"},
      {"text": "Manufacturing Overhead", "category": "Conversion Costs Only"},
      {"text": "Indirect Materials", "category": "Conversion Costs Only"},
      {"text": "Indirect Labor", "category": "Conversion Costs Only"},
      {"text": "Raw Materials (traceable)", "category": "Prime Costs Only"},
      {"text": "Production Worker Wages", "category": "Both (Overlap)"},
      {"text": "Factory Rent", "category": "Conversion Costs Only"}
    ]
  }'::jsonb,
  'category-sort',
  false,
  true
),

-- Activity 2.3.4: Restaurant Kitchen Analysis Practice
(
  'd0200000-0000-0000-0003-000000000004',
  'd0000000-0000-0000-0000-000000000002',
  '2.3.4',
  15,
  'Restaurant Kitchen Analysis',
  'restaurant-kitchen-analysis',
  'lesson',
  10,
  30,
  'free',
  '{"markdown": "# Restaurant Kitchen Analysis\n\n## Chez Marie Kitchen Cost Analysis\n\nChez Marie wants to analyze their kitchen costs for a single Beef Bourguignon dish.\n\n---\n\n## Cost Data\n\n| Cost Component | Amount per Dish |\n|----------------|----------------|\n| Beef | CHF 8.00 |\n| Vegetables and wine | CHF 4.00 |\n| Herbs and seasonings | CHF 1.50 |\n| Chef time (15 min @ CHF 40/hr) | CHF 10.00 |\n| Kitchen utilities allocation | CHF 1.50 |\n| Equipment depreciation allocation | CHF 0.75 |\n| Kitchen supervisor allocation | CHF 1.25 |\n\n---\n\n## Step 1: Classify Each Cost\n\n| Cost | DM | DL | MOH |\n|------|:--:|:--:|:---:|\n| Beef | X | | |\n| Vegetables and wine | X | | |\n| Herbs and seasonings | X | | |\n| Chef time | | X | |\n| Kitchen utilities | | | X |\n| Equipment depreciation | | | X |\n| Kitchen supervisor | | | X |\n\n---\n\n## Step 2: Calculate Totals\n\n| Category | Calculation | Total |\n|----------|-------------|-------|\n| Direct Materials | 8.00 + 4.00 + 1.50 | CHF 13.50 |\n| Direct Labor | 10.00 | CHF 10.00 |\n| Manufacturing OH | 1.50 + 0.75 + 1.25 | CHF 3.50 |\n\n---\n\n## Step 3: Prime and Conversion Costs\n\n### Prime Costs\n```\nPrime = DM + DL\n      = CHF 13.50 + CHF 10.00\n      = CHF 23.50\n```\n\n### Conversion Costs\n```\nConversion = DL + MOH\n           = CHF 10.00 + CHF 3.50\n           = CHF 13.50\n```\n\n### Total Manufacturing Cost\n```\nTotal = DM + DL + MOH\n      = CHF 13.50 + CHF 10.00 + CHF 3.50\n      = CHF 27.00\n```\n\n---\n\n## Verify: Two Ways to Calculate Total\n\n**Method 1**: DM + DL + MOH = CHF 27.00\n\n**Method 2**: Prime + MOH = CHF 23.50 + CHF 3.50 = CHF 27.00\n\n**Method 3**: DM + Conversion = CHF 13.50 + CHF 13.50 = CHF 27.00\n\n---\n\n## Pricing Implications\n\nIf Chez Marie wants a 30% food cost ratio:\n\n```\nMenu Price = Total Cost / Target Cost %\n           = CHF 27.00 / 0.30\n           = CHF 90.00\n```\n\n---\n\n:::takeaways\n- Prime costs focus on direct, traceable costs\n- Conversion costs show the value added in production\n- Total can be calculated multiple ways\n- Understanding cost composition helps with pricing\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.3.5: Prime and Conversion Checkpoint
(
  'd0200000-0000-0000-0003-000000000005',
  'd0000000-0000-0000-0000-000000000002',
  '2.3.5',
  16,
  'Prime and Conversion Checkpoint',
  'prime-conversion-checkpoint',
  'checkpoint',
  10,
  40,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "A bakery has DM CHF 15,000, DL CHF 12,000, MOH CHF 8,000. Prime costs are:",
        "options": ["CHF 20,000", "CHF 23,000", "CHF 27,000", "CHF 35,000"],
        "correct": 2,
        "explanation": "Prime = DM + DL = CHF 15,000 + CHF 12,000 = CHF 27,000"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Using the same bakery data, conversion costs are:",
        "options": ["CHF 20,000", "CHF 23,000", "CHF 27,000", "CHF 35,000"],
        "correct": 0,
        "explanation": "Conversion = DL + MOH = CHF 12,000 + CHF 8,000 = CHF 20,000"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Why is Direct Labor in both prime and conversion costs?",
        "options": ["It is the largest cost", "It directly works on materials to convert them", "It is always variable", "It is a period cost"],
        "correct": 1,
        "explanation": "DL is direct (making it prime) AND it converts materials (making it conversion)."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "If Prime is CHF 80,000 and Total Manufacturing is CHF 110,000, then MOH is:",
        "options": ["CHF 30,000", "CHF 80,000", "CHF 110,000", "CHF 190,000"],
        "correct": 0,
        "explanation": "Total = Prime + MOH. So MOH = 110,000 - 80,000 = CHF 30,000"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Conversion costs are useful for analyzing:",
        "options": ["Marketing effectiveness", "The value added in manufacturing", "Sales commissions", "Administrative efficiency"],
        "correct": 1,
        "explanation": "Conversion costs represent the cost of converting raw materials into finished products."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "question": "If DM is CHF 40,000 and Conversion is CHF 55,000, and DL is CHF 25,000, Total Manufacturing Cost is:",
        "options": ["CHF 70,000", "CHF 95,000", "CHF 120,000", "CHF 65,000"],
        "correct": 0,
        "explanation": "Total = DM + Conversion = CHF 40,000 + CHF 55,000 = CHF 95,000. Wait, let me recalculate. Conversion = DL + MOH, so MOH = 55k - 25k = 30k. Total = DM + DL + MOH = 40k + 25k + 30k = CHF 95,000. But also DM + Conversion would be 40k + 55k = 95k."
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
-- Skill MA-04: Direct vs Indirect Costs
('d0200000-0000-0000-0001-000000000001', 'd0000000-0000-0000-0002-000000000001', true, 1.0),
('d0200000-0000-0000-0001-000000000002', 'd0000000-0000-0000-0002-000000000001', true, 1.0),
('d0200000-0000-0000-0001-000000000003', 'd0000000-0000-0000-0002-000000000001', true, 1.0),
('d0200000-0000-0000-0001-000000000004', 'd0000000-0000-0000-0002-000000000001', true, 1.0),
('d0200000-0000-0000-0001-000000000005', 'd0000000-0000-0000-0002-000000000001', true, 1.0),
('d0200000-0000-0000-0001-000000000006', 'd0000000-0000-0000-0002-000000000001', true, 1.0),

-- Skill MA-05: Product vs Period Costs
('d0200000-0000-0000-0002-000000000001', 'd0000000-0000-0000-0002-000000000002', true, 1.0),
('d0200000-0000-0000-0002-000000000002', 'd0000000-0000-0000-0002-000000000002', true, 1.0),
('d0200000-0000-0000-0002-000000000003', 'd0000000-0000-0000-0002-000000000002', true, 1.0),
('d0200000-0000-0000-0002-000000000004', 'd0000000-0000-0000-0002-000000000002', true, 1.0),
('d0200000-0000-0000-0002-000000000005', 'd0000000-0000-0000-0002-000000000002', true, 1.0),

-- Skill MA-06: Prime Costs & Conversion Costs
('d0200000-0000-0000-0003-000000000001', 'd0000000-0000-0000-0002-000000000003', true, 1.0),
('d0200000-0000-0000-0003-000000000002', 'd0000000-0000-0000-0002-000000000003', true, 1.0),
('d0200000-0000-0000-0003-000000000003', 'd0000000-0000-0000-0002-000000000003', true, 1.0),
('d0200000-0000-0000-0003-000000000004', 'd0000000-0000-0000-0002-000000000003', true, 1.0),
('d0200000-0000-0000-0003-000000000005', 'd0000000-0000-0000-0002-000000000003', true, 1.0);

