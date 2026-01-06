-- ============================================
-- Module 1: MA Foundations Activities
-- 3 Skills: MA vs FA, Cost Terminology, Manufacturing Cost Flows
-- ~16 Activities with comprehensive lesson content
-- ============================================

-- Clean up existing data to avoid conflicts
DELETE FROM activity_skills WHERE activity_id IN (
  SELECT id FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000001'
);
DELETE FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000001';

-- ============================================
-- SKILL: Managerial vs Financial Accounting (MA-01)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 1.1.1: Introduction to Managerial Accounting
(
  'd0100000-0000-0000-0001-000000000001',
  'd0000000-0000-0000-0000-000000000001',
  '1.1.1',
  1,
  'Introduction to Managerial Accounting',
  'introduction-to-managerial-accounting',
  'lesson',
  12,
  25,
  'free',
  '{"markdown": "# Introduction to Managerial Accounting\n\n## What is Managerial Accounting?\n\nManagerial accounting provides information to **internal users** (managers) to help them make better business decisions. Unlike financial accounting, which reports to outsiders, managerial accounting is all about helping managers plan, control, and make decisions.\n\n> **Managerial accounting looks forward to help managers make decisions; financial accounting looks backward to report what happened.**\n\n---\n\n## Two Types of Accounting\n\n| Feature | Financial Accounting | Managerial Accounting |\n|---------|---------------------|----------------------|\n| **Users** | External (investors, banks, regulators) | Internal (managers, executives) |\n| **Purpose** | Report financial position | Support decision-making |\n| **Rules** | GAAP/IFRS required | No required format |\n| **Time Focus** | Historical (past) | Future-oriented |\n| **Reports** | Annual/Quarterly statements | As needed (daily, weekly) |\n| **Scope** | Whole company | Segments, products, departments |\n| **Verification** | Audited | Not audited |\n\n---\n\n## Key Functions of Managerial Accounting\n\n### 1. Planning\nSetting goals and determining how to achieve them.\n- **Example**: A hotel creates a budget for next year''s occupancy and revenue targets.\n\n### 2. Controlling\nMonitoring performance and taking corrective action.\n- **Example**: Comparing actual food costs to budgeted costs in a restaurant.\n\n### 3. Decision Making\nChoosing among alternatives based on relevant information.\n- **Example**: Should we outsource laundry services or keep them in-house?\n\n---\n\n## Hospitality Industry Examples\n\n### Hotel Management Decisions\n- What room rate maximizes profit?\n- Should we renovate the restaurant or close it?\n- How many staff members do we need per shift?\n\n### Restaurant Management Decisions\n- Which menu items are most profitable?\n- Should we accept a group booking at a discounted rate?\n- What is the cost per meal served?\n\n---\n\n## The Role of the Management Accountant\n\nManagement accountants:\n- Prepare internal reports and budgets\n- Analyze costs and profitability\n- Support strategic planning\n- Help evaluate capital investments\n\n:::concept{title=\"Ethical Standards\"}\nManagerial accountants follow ethical standards including:\n- **Competence**: Maintain professional expertise\n- **Confidentiality**: Keep information private\n- **Integrity**: Avoid conflicts of interest\n- **Credibility**: Report information fairly\n:::\n\n---\n\n:::takeaways\n- Managerial accounting serves internal users for decision-making\n- It is future-oriented and not bound by GAAP/IFRS\n- Three key functions: Planning, Controlling, Decision Making\n- Reports can be customized to manager needs\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.1.2: Financial vs Managerial Accounting Quiz
(
  'd0100000-0000-0000-0001-000000000002',
  'd0000000-0000-0000-0000-000000000001',
  '1.1.2',
  2,
  'Financial vs Managerial Accounting Quiz',
  'financial-vs-managerial-quiz',
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
        "question": "Who are the primary users of managerial accounting information?",
        "options": ["Investors and creditors", "Managers and executives", "Government regulators", "External auditors"],
        "correct": 1,
        "explanation": "Managerial accounting provides information primarily for internal users such as managers and executives to support decision-making."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which type of accounting must follow GAAP or IFRS?",
        "options": ["Managerial accounting", "Financial accounting", "Both types", "Neither type"],
        "correct": 1,
        "explanation": "Financial accounting must follow standardized rules (GAAP/IFRS) because external users need comparable information. Managerial accounting has no required format."
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Managerial accounting reports are typically audited by external auditors.",
        "correct": false,
        "explanation": "False. Only financial statements are audited. Managerial reports are internal and not subject to external audit."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel manager needs a report showing costs by department. This is an example of:",
        "options": ["Financial accounting", "Managerial accounting", "Tax accounting", "Audit accounting"],
        "correct": 1,
        "explanation": "Segment or departmental reporting is a managerial accounting function, helping internal managers understand performance by area."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which function involves comparing actual results to budgeted amounts?",
        "options": ["Planning", "Controlling", "Decision making", "Reporting"],
        "correct": 1,
        "explanation": "Controlling involves monitoring actual performance against plans and taking corrective action when needed."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Managerial accounting is primarily focused on:",
        "options": ["The past", "The future", "Only current period", "Only annual data"],
        "correct": 1,
        "explanation": "Managerial accounting is future-oriented, helping managers plan and make decisions about what will happen."
      },
      {
        "id": "q7",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A decision about whether to close an underperforming restaurant is a managerial accounting concern.",
        "correct": true,
        "explanation": "True. Decision-making about keeping or dropping segments is a key function of managerial accounting."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which characteristic applies to BOTH financial and managerial accounting?",
        "options": ["Must follow GAAP", "Reports must be audited", "Uses monetary units", "Only reports historical data"],
        "correct": 2,
        "explanation": "Both types of accounting use monetary units (CHF, USD, EUR, etc.) to measure and communicate information."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.1.3: Classification Game Interactive
(
  'd0100000-0000-0000-0001-000000000003',
  'd0000000-0000-0000-0000-000000000001',
  '1.1.3',
  3,
  'Accounting Classification Game',
  'accounting-classification-game',
  'interactive',
  6,
  25,
  'free',
  '{
    "instructions": "Drag each item to the correct accounting type: Financial Accounting or Managerial Accounting.",
    "categories": ["Financial Accounting", "Managerial Accounting"],
    "items": [
      {"text": "Balance sheet for shareholders", "category": "Financial Accounting"},
      {"text": "Departmental cost report", "category": "Managerial Accounting"},
      {"text": "Annual report for investors", "category": "Financial Accounting"},
      {"text": "Budget for next quarter", "category": "Managerial Accounting"},
      {"text": "Audited income statement", "category": "Financial Accounting"},
      {"text": "Product profitability analysis", "category": "Managerial Accounting"},
      {"text": "Cash flow statement for bank", "category": "Financial Accounting"},
      {"text": "Make or buy decision analysis", "category": "Managerial Accounting"}
    ]
  }'::jsonb,
  'category-sort',
  false,
  true
),

-- Activity 1.1.4: Hotel Scenario Practice
(
  'd0100000-0000-0000-0001-000000000004',
  'd0000000-0000-0000-0000-000000000001',
  '1.1.4',
  4,
  'Hotel Reporting Scenario',
  'hotel-reporting-scenario',
  'lesson',
  8,
  20,
  'free',
  '{"markdown": "# Hotel Reporting Scenario\n\n## Grand Palace Hotel Case\n\nThe Grand Palace Hotel has 200 rooms and includes a restaurant, spa, and conference facilities. Various stakeholders need different types of information.\n\n---\n\n## Scenario Analysis\n\n### Who Needs What?\n\nMatch each report to its primary user:\n\n| Report | User | Type |\n|--------|------|------|\n| Quarterly earnings report | Investors | Financial |\n| Daily occupancy by room type | Front Desk Manager | Managerial |\n| Annual audited statements | Bank (loan review) | Financial |\n| Food cost percentage by menu item | Restaurant Manager | Managerial |\n| Tax return | Government | Financial |\n| Spa profitability analysis | Spa Director | Managerial |\n| SEC/regulatory filings | Regulators | Financial |\n| Variance report: budget vs actual | General Manager | Managerial |\n\n---\n\n## Key Insight\n\n:::concept{title=\"Different Information for Different Purposes\"}\n- **External reports** must be standardized for comparability\n- **Internal reports** should be customized for relevance\n- The same underlying data can generate both types of reports\n:::\n\n---\n\n## Your Turn\n\nConsider these questions:\n1. Why might the spa manager need different information than shareholders?\n2. How often should the restaurant manager receive cost reports?\n3. What information would help the GM control labor costs?\n\n---\n\n:::takeaways\n- External users need standardized, verified information\n- Internal users need timely, relevant, customized reports\n- Managerial reports can be produced at any frequency\n- The same transaction affects both types of accounting\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.1.5: MA vs FA Checkpoint
(
  'd0100000-0000-0000-0001-000000000005',
  'd0000000-0000-0000-0000-000000000001',
  '1.1.5',
  5,
  'Managerial vs Financial Checkpoint',
  'ma-vs-fa-checkpoint',
  'checkpoint',
  10,
  40,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The preparation of budgets for planning purposes is primarily a function of:",
        "options": ["Financial accounting", "Managerial accounting", "Tax accounting", "Governmental accounting"],
        "correct": 1,
        "explanation": "Budgeting is a planning function and falls under managerial accounting."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Which statement is TRUE about managerial accounting reports?",
        "options": ["Must be prepared annually", "Must follow GAAP", "Can focus on segments of the organization", "Are distributed to stockholders"],
        "correct": 2,
        "explanation": "Managerial reports can focus on specific segments, departments, or products - not just the whole company."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "A hotel is deciding whether to renovate its lobby. This decision requires:",
        "options": ["Audited financial statements", "Managerial accounting analysis", "Tax return preparation", "SEC filing"],
        "correct": 1,
        "explanation": "Capital investment decisions like renovations require managerial accounting analysis to evaluate costs and benefits."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Managerial accounting information must be verified by an independent auditor before being used by managers.",
        "correct": false,
        "explanation": "False. Managerial accounting information is for internal use and does not require external audit verification."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Comparing actual labor costs to budgeted labor costs is an example of the _____ function.",
        "options": ["Planning", "Controlling", "Decision making", "Financing"],
        "correct": 1,
        "explanation": "Comparing actual to budget and identifying variances is the controlling function."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "question": "Which ethical standard requires management accountants to avoid conflicts of interest?",
        "options": ["Competence", "Confidentiality", "Integrity", "Objectivity"],
        "correct": 2,
        "explanation": "Integrity requires accountants to avoid actual or apparent conflicts of interest and to refuse gifts that might influence behavior."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- SKILL: Cost Terminology Basics (MA-02)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 1.2.1: The Language of Costs
(
  'd0100000-0000-0000-0002-000000000001',
  'd0000000-0000-0000-0000-000000000001',
  '1.2.1',
  6,
  'The Language of Costs',
  'the-language-of-costs',
  'lesson',
  15,
  30,
  'free',
  '{"markdown": "# The Language of Costs\n\n## Why Cost Terminology Matters\n\nBefore analyzing costs, you must understand the vocabulary. Using consistent terminology helps managers communicate clearly and make better decisions.\n\n---\n\n## Essential Cost Terms\n\n### Cost Object\n\nAnything for which you want to measure costs.\n\n**Examples:**\n- A hotel room (cost per room night)\n- A meal served (cost per cover)\n- A department (housekeeping costs)\n- A customer (cost to acquire and serve)\n- A catering event (total event cost)\n\n:::concept{title=\"Cost Object Flexibility\"}\nThe same expense can be traced to different cost objects depending on your question. Linens might be:\n- A room cost (per room night)\n- A department cost (housekeeping)\n- A hotel cost (total operations)\n:::\n\n---\n\n### Cost Driver\n\nAn activity or factor that causes costs to change.\n\n| Cost | Cost Driver |\n|------|------------|\n| Food cost | Number of meals served |\n| Laundry cost | Rooms occupied |\n| Electricity | Square footage + occupancy |\n| Server wages | Tables served |\n| Commission | Room nights booked |\n\n**Why it matters**: Understanding cost drivers helps predict and control costs.\n\n---\n\n### Cost Pool\n\nA grouping of individual costs that share a common cost driver.\n\n**Example**: Manufacturing Overhead Pool\n- Depreciation\n- Utilities\n- Indirect labor\n- Maintenance\n\nThese are grouped because they all relate to factory operations and are allocated based on similar drivers.\n\n---\n\n### Direct vs Indirect Costs\n\n| Direct Costs | Indirect Costs |\n|--------------|----------------|\n| Traceable to cost object | Shared by multiple cost objects |\n| Easy to identify | Must be allocated |\n| Food ingredients for a meal | Kitchen utilities |\n| Server wages for a shift | Manager salary |\n\n---\n\n## Cost Classification Framework\n\n```\n                    COSTS\n                      |\n        +-------------+-------------+\n        |                           |\n     DIRECT                     INDIRECT\n  (Traceable)                   (Allocated)\n        |                           |\n   +----+----+              +-------+-------+\n   |         |              |               |\n Materials  Labor       Overhead         Admin\n```\n\n---\n\n## Hospitality Examples\n\n### Restaurant Cost Analysis\n\n**Cost Object**: A pasta dish\n\n| Cost | Classification | Traceability |\n|------|---------------|---------------|\n| Pasta, sauce, cheese | Direct Material | Traceable |\n| Chef time preparing | Direct Labor | Traceable |\n| Kitchen rent | Indirect | Allocated |\n| Restaurant manager | Indirect | Allocated |\n\n---\n\n:::takeaways\n- **Cost object**: What you are measuring costs for\n- **Cost driver**: What causes costs to change\n- **Cost pool**: Grouping of costs for allocation\n- **Direct costs**: Traceable to the cost object\n- **Indirect costs**: Must be allocated\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.2.2: Cost Terminology Quiz
(
  'd0100000-0000-0000-0002-000000000002',
  'd0000000-0000-0000-0000-000000000001',
  '1.2.2',
  7,
  'Cost Terminology Quiz',
  'cost-terminology-quiz',
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
        "question": "A cost object is best defined as:",
        "options": ["A type of inventory", "Anything for which costs are measured", "The total cost of a department", "A variable expense"],
        "correct": 1,
        "explanation": "A cost object is anything for which you want to measure costs - it could be a product, service, customer, department, or project."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "The number of guests served is most likely a cost driver for:",
        "options": ["Building depreciation", "Property taxes", "Food costs", "Insurance premium"],
        "correct": 2,
        "explanation": "Food costs increase with the number of guests served, making guest count a cost driver for food."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "In a hotel, which cost is DIRECTLY traceable to a specific guest room night?",
        "options": ["Front desk clerk salary", "Guest room cleaning supplies", "Hotel property taxes", "Reservation system license"],
        "correct": 1,
        "explanation": "Cleaning supplies used in a specific room can be traced directly to that room night. The other costs are indirect."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "A cost pool is a grouping of individual costs that share a common cost driver.",
        "correct": true,
        "explanation": "True. Cost pools group similar costs together so they can be allocated using the same driver or rate."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If the cost object is ''Housekeeping Department,'' which cost is indirect?",
        "options": ["Housekeeping supervisor salary", "Cleaning supplies", "Housekeeping staff wages", "Hotel general manager salary"],
        "correct": 3,
        "explanation": "The GM salary cannot be directly traced to housekeeping; it benefits all departments and must be allocated."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which factor is most likely the cost driver for room cleaning labor?",
        "options": ["Number of employees", "Number of rooms cleaned", "Hotel star rating", "Room price"],
        "correct": 1,
        "explanation": "The number of rooms cleaned directly drives how much cleaning labor is needed."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A cost that is direct for one cost object might be indirect for another. This is because:",
        "options": ["Costs are always either direct or indirect", "The classification depends on what you are costing", "Direct costs are always variable", "Indirect costs cannot be traced"],
        "correct": 1,
        "explanation": "Whether a cost is direct or indirect depends on the cost object. A supervisor salary is direct to their department but indirect to individual products."
      },
      {
        "id": "q8",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Indirect costs cannot be identified with any cost object.",
        "correct": false,
        "explanation": "False. Indirect costs CAN be identified with a cost object, but only through allocation - they cannot be directly traced."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.2.3: Cost Term Matching Interactive
(
  'd0100000-0000-0000-0002-000000000003',
  'd0000000-0000-0000-0000-000000000001',
  '1.2.3',
  8,
  'Cost Term Matching',
  'cost-term-matching',
  'interactive',
  6,
  25,
  'free',
  '{
    "instructions": "Match each term with its correct definition.",
    "pairs": [
      {"left": "Cost Object", "right": "What you are measuring costs for"},
      {"left": "Cost Driver", "right": "Factor that causes costs to change"},
      {"left": "Cost Pool", "right": "Grouping of costs with similar drivers"},
      {"left": "Direct Cost", "right": "Traceable to the cost object"},
      {"left": "Indirect Cost", "right": "Must be allocated to cost objects"},
      {"left": "Allocation Base", "right": "Measure used to assign indirect costs"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 1.2.4: Restaurant Cost Analysis Practice
(
  'd0100000-0000-0000-0002-000000000004',
  'd0000000-0000-0000-0000-000000000001',
  '1.2.4',
  9,
  'Restaurant Cost Analysis',
  'restaurant-cost-analysis',
  'lesson',
  10,
  25,
  'free',
  '{"markdown": "# Restaurant Cost Analysis\n\n## Bella Vista Restaurant Case\n\nBella Vista is analyzing costs to understand the profitability of different menu items. The cost object is a single ''Grilled Salmon'' dish.\n\n---\n\n## Identifying Cost Types\n\n### Direct Costs (Traceable to the Dish)\n\n| Cost Item | Amount | Type |\n|-----------|--------|------|\n| Salmon fillet | CHF 8.50 | Direct Material |\n| Vegetables | CHF 2.00 | Direct Material |\n| Sauce ingredients | CHF 1.50 | Direct Material |\n| Chef labor (5 min @ CHF 36/hr) | CHF 3.00 | Direct Labor |\n| **Total Direct Cost** | **CHF 15.00** | |\n\n### Indirect Costs (Must Be Allocated)\n\n| Cost Item | Monthly Total | Cannot trace directly to one dish |\n|-----------|---------------|-----------------------------------|\n| Kitchen utilities | CHF 3,000 | Shared by all dishes |\n| Kitchen equipment depreciation | CHF 2,000 | Used for all cooking |\n| Head chef salary | CHF 8,000 | Supervises all production |\n| Restaurant rent | CHF 12,000 | Benefits all operations |\n\n---\n\n## Cost Drivers for Allocation\n\n| Indirect Cost | Possible Cost Driver |\n|--------------|---------------------|\n| Kitchen utilities | Number of dishes cooked |\n| Equipment depreciation | Machine hours used |\n| Head chef salary | Direct labor hours |\n| Restaurant rent | Revenue or square footage |\n\n---\n\n## Calculate Allocated Cost Per Dish\n\nIf the restaurant serves 3,000 dishes per month:\n\n```\nTotal indirect costs: CHF 25,000/month\nDishes served: 3,000\n\nAllocated cost per dish = CHF 25,000 / 3,000 = CHF 8.33\n```\n\n### Total Cost per Grilled Salmon\n\n| Component | Amount |\n|-----------|--------|\n| Direct costs | CHF 15.00 |\n| Allocated indirect costs | CHF 8.33 |\n| **Total Cost** | **CHF 23.33** |\n\n---\n\n:::takeaways\n- Direct costs can be traced to specific dishes\n- Indirect costs require allocation using cost drivers\n- Total product cost = Direct + Allocated Indirect\n- Understanding costs helps set profitable menu prices\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.2.5: Hotel Department Costs
(
  'd0100000-0000-0000-0002-000000000005',
  'd0000000-0000-0000-0000-000000000001',
  '1.2.5',
  10,
  'Hotel Department Costs',
  'hotel-department-costs',
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
        "question": "If the cost object is the Spa Department, which cost is DIRECT?",
        "options": ["Hotel property insurance", "Spa therapist wages", "Hotel marketing costs", "General Manager salary"],
        "correct": 1,
        "explanation": "Spa therapist wages can be directly traced to the Spa Department. The other costs benefit multiple departments."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the best cost driver for allocating laundry costs to hotel departments?",
        "options": ["Number of employees", "Square footage", "Pounds of laundry processed", "Department revenue"],
        "correct": 2,
        "explanation": "Pounds of laundry directly measures each department''s use of laundry services."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel has CHF 60,000 in utility costs. Rooms department has 10,000 sq ft, F&B has 5,000 sq ft. How much is allocated to Rooms?",
        "options": ["CHF 40,000", "CHF 30,000", "CHF 20,000", "CHF 60,000"],
        "correct": 0,
        "explanation": "Rooms = 10,000 / 15,000 total = 2/3 of utilities. 2/3 x CHF 60,000 = CHF 40,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which would be the most appropriate cost driver for allocating reservation system costs?",
        "options": ["Number of rooms", "Number of reservations processed", "Total revenue", "Number of employees"],
        "correct": 1,
        "explanation": "Number of reservations directly reflects each department''s use of the reservation system."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "The same cost can be classified as direct for one cost object and indirect for another.",
        "correct": true,
        "explanation": "True. Classification depends on the cost object. A department manager''s salary is direct to that department but indirect to individual products within the department."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.2.6: Cost Terminology Checkpoint
(
  'd0100000-0000-0000-0002-000000000006',
  'd0000000-0000-0000-0000-000000000001',
  '1.2.6',
  11,
  'Cost Terminology Checkpoint',
  'cost-terminology-checkpoint',
  'checkpoint',
  10,
  40,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "A restaurant wants to know the cost of serving one customer. The ''customer'' is the:",
        "options": ["Cost driver", "Cost pool", "Cost object", "Allocation base"],
        "correct": 2,
        "explanation": "The customer is the cost object - what we want to measure costs for."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Room nights occupied is most likely the cost driver for:",
        "options": ["Property taxes", "Guest amenity costs", "Fire insurance", "Franchise fees"],
        "correct": 1,
        "explanation": "Guest amenities (toiletries, etc.) increase directly with room nights occupied."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Which cost is INDIRECT when the cost object is a specific banquet event?",
        "options": ["Food served at the event", "Server wages for the event", "Banquet hall utilities", "Table linens used"],
        "correct": 2,
        "explanation": "Banquet hall utilities are shared by all events and cannot be directly traced to one event."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "A cost pool combines costs that:",
        "options": ["Are always direct", "Share a common cost driver", "Never change", "Relate to products only"],
        "correct": 1,
        "explanation": "A cost pool groups costs that share a common cost driver for allocation purposes."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "A hotel allocates CHF 90,000 admin costs based on revenue. Restaurant has CHF 300,000 revenue, Rooms has CHF 600,000. Admin allocated to Restaurant is:",
        "options": ["CHF 30,000", "CHF 45,000", "CHF 60,000", "CHF 90,000"],
        "correct": 0,
        "explanation": "Restaurant = 300,000 / 900,000 = 1/3 of total. 1/3 x CHF 90,000 = CHF 30,000"
      },
      {
        "id": "cp6",
        "type": "true_false",
        "question": "Direct costs always cost more than indirect costs.",
        "correct": false,
        "explanation": "False. The classification as direct or indirect has nothing to do with the amount - it relates to traceability."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- SKILL: Manufacturing Cost Flows (MA-03)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 1.3.1: From Raw Materials to Finished Goods
(
  'd0100000-0000-0000-0003-000000000001',
  'd0000000-0000-0000-0000-000000000001',
  '1.3.1',
  12,
  'From Raw Materials to Finished Goods',
  'raw-materials-to-finished-goods',
  'lesson',
  15,
  35,
  'free',
  '{"markdown": "# From Raw Materials to Finished Goods\n\n## The Manufacturing Cost Flow\n\nIn manufacturing (or food production), costs flow through three inventory accounts before becoming Cost of Goods Sold.\n\n---\n\n## The Three Inventory Accounts\n\n### 1. Raw Materials Inventory\nMaterials purchased but not yet used in production.\n\n**Hotel Kitchen Example**: Ingredients in storage (flour, vegetables, proteins)\n\n### 2. Work-in-Process (WIP) Inventory\nPartially completed products still in production.\n\n**Hotel Kitchen Example**: Meals being prepared, sauces in progress\n\n### 3. Finished Goods Inventory\nCompleted products ready for sale.\n\n**Hotel Kitchen Example**: Prepared items ready to serve (pre-made desserts, stocks)\n\n---\n\n## Cost Flow Diagram\n\n```\n+------------------+     +-----------------+     +------------------+\n| RAW MATERIALS    | --> | WORK-IN-PROCESS | --> | FINISHED GOODS   |\n| Inventory        |     | Inventory       |     | Inventory        |\n+------------------+     +-----------------+     +------------------+\n                                                          |\n                                                          v\n                                                 +------------------+\n                                                 | COST OF GOODS    |\n                                                 | SOLD (Expense)   |\n                                                 +------------------+\n```\n\n---\n\n## Three Types of Manufacturing Costs\n\n### 1. Direct Materials (DM)\nRaw materials that become part of the finished product and can be traced directly.\n\n**Examples**: Salmon for a fish dish, flour for bread, fabric for uniforms\n\n### 2. Direct Labor (DL)\nWages of workers who physically work on the product.\n\n**Examples**: Chef preparing meals, baker making pastries, seamstress sewing\n\n### 3. Manufacturing Overhead (MOH)\nAll other manufacturing costs that cannot be directly traced.\n\n**Examples**: Kitchen utilities, equipment depreciation, supervisor salary, cleaning supplies\n\n---\n\n## Cost Flow with Dollar Amounts\n\n### Example: Hotel Bakery\n\n| Transaction | Effect |\n|------------|--------|\n| Purchase flour and sugar (CHF 5,000) | + Raw Materials |\n| Transfer ingredients to kitchen (CHF 4,000) | - Raw Materials, + WIP |\n| Pay baker wages (CHF 3,000) | + WIP (Direct Labor) |\n| Apply overhead (CHF 2,000) | + WIP (MOH Applied) |\n| Complete pastries (CHF 8,500) | - WIP, + Finished Goods |\n| Sell pastries (CHF 6,000 cost) | - Finished Goods, + COGS |\n\n---\n\n## Journal Entries (Simplified)\n\n**Purchase Raw Materials:**\n```\nRaw Materials Inventory    5,000\n    Accounts Payable              5,000\n```\n\n**Transfer to Production:**\n```\nWork-in-Process           4,000\n    Raw Materials Inventory       4,000\n```\n\n**Record Direct Labor:**\n```\nWork-in-Process           3,000\n    Wages Payable                 3,000\n```\n\n**Apply Overhead:**\n```\nWork-in-Process           2,000\n    Manufacturing Overhead        2,000\n```\n\n**Complete Production:**\n```\nFinished Goods            8,500\n    Work-in-Process               8,500\n```\n\n**Sell Products:**\n```\nCost of Goods Sold        6,000\n    Finished Goods                6,000\n```\n\n---\n\n:::takeaways\n- Costs flow: Raw Materials --> WIP --> Finished Goods --> COGS\n- Three manufacturing costs: Direct Materials, Direct Labor, Manufacturing Overhead\n- WIP contains all three cost components\n- Costs stay in inventory until products are sold\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.3.2: Cost Flow Diagram Interactive
(
  'd0100000-0000-0000-0003-000000000002',
  'd0000000-0000-0000-0000-000000000001',
  '1.3.2',
  13,
  'Cost Flow Diagram Builder',
  'cost-flow-diagram',
  'interactive',
  8,
  30,
  'free',
  '{
    "instructions": "Arrange these items in the correct order to show how costs flow through a manufacturing business.",
    "sequence": [
      "Purchase raw materials",
      "Store in Raw Materials Inventory",
      "Transfer materials to production",
      "Add direct labor to Work-in-Process",
      "Apply manufacturing overhead",
      "Complete production to Finished Goods",
      "Sell products - record Cost of Goods Sold"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

-- Activity 1.3.3: Manufacturing Cost Flows Quiz
(
  'd0100000-0000-0000-0003-000000000003',
  'd0000000-0000-0000-0000-000000000001',
  '1.3.3',
  14,
  'Manufacturing Cost Flows Quiz',
  'manufacturing-cost-flows-quiz',
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
        "question": "Raw materials that have been placed into production are recorded in:",
        "options": ["Raw Materials Inventory", "Work-in-Process Inventory", "Finished Goods Inventory", "Cost of Goods Sold"],
        "correct": 1,
        "explanation": "When materials enter production, they are transferred from Raw Materials to Work-in-Process."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which account contains Direct Materials, Direct Labor, AND Manufacturing Overhead?",
        "options": ["Raw Materials", "Work-in-Process", "Finished Goods", "All of the above"],
        "correct": 1,
        "explanation": "Work-in-Process accumulates all three manufacturing cost components as products are being made."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "In a hotel kitchen, flour sitting in the storeroom is part of:",
        "options": ["Work-in-Process", "Finished Goods", "Raw Materials", "Cost of Goods Sold"],
        "correct": 2,
        "explanation": "Unused ingredients in storage are Raw Materials - they haven''t entered production yet."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Manufacturing overhead includes only indirect materials, not indirect labor.",
        "correct": false,
        "explanation": "False. Manufacturing overhead includes both indirect materials AND indirect labor, plus other factory costs."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A completed pastry waiting to be served is classified as:",
        "options": ["Raw Materials", "Work-in-Process", "Finished Goods", "Cost of Goods Sold"],
        "correct": 2,
        "explanation": "Completed products waiting for sale are Finished Goods Inventory."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "When is a manufacturing cost recognized as an expense?",
        "options": ["When materials are purchased", "When labor is paid", "When production is complete", "When the product is sold"],
        "correct": 3,
        "explanation": "Manufacturing costs remain in inventory until the product is sold, when they become Cost of Goods Sold (an expense)."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Beginning WIP was CHF 10,000. Manufacturing costs added were CHF 45,000. Ending WIP is CHF 8,000. Cost of goods manufactured is:",
        "options": ["CHF 43,000", "CHF 47,000", "CHF 55,000", "CHF 63,000"],
        "correct": 1,
        "explanation": "COGM = Beginning WIP + Costs Added - Ending WIP = 10,000 + 45,000 - 8,000 = CHF 47,000"
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Kitchen equipment depreciation is classified as:",
        "options": ["Direct Materials", "Direct Labor", "Manufacturing Overhead", "Period Cost"],
        "correct": 2,
        "explanation": "Equipment depreciation in a production area is Manufacturing Overhead - an indirect production cost."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.3.4: Hotel Kitchen Cost Flows Practice
(
  'd0100000-0000-0000-0003-000000000004',
  'd0000000-0000-0000-0000-000000000001',
  '1.3.4',
  15,
  'Hotel Kitchen Cost Flows',
  'hotel-kitchen-cost-flows',
  'lesson',
  12,
  30,
  'free',
  '{"markdown": "# Hotel Kitchen Cost Flows\n\n## Alpine Resort Kitchen Case\n\nThe Alpine Resort kitchen prepares breakfast, lunch, and dinner. Let''s trace costs through the system for one month.\n\n---\n\n## Beginning Balances\n\n| Account | Balance |\n|---------|--------|\n| Raw Materials Inventory | CHF 8,000 |\n| Work-in-Process | CHF 2,000 |\n| Finished Goods | CHF 3,000 |\n\n---\n\n## Monthly Transactions\n\n### 1. Purchases\n- Purchased food ingredients: CHF 45,000\n- Purchased kitchen supplies: CHF 5,000\n\n### 2. Materials Used in Production\n- Direct materials (ingredients): CHF 42,000\n- Indirect materials (supplies): CHF 4,500\n\n### 3. Labor Costs\n- Chef and cook wages (direct): CHF 28,000\n- Kitchen manager salary (indirect): CHF 6,000\n\n### 4. Other Manufacturing Overhead\n- Kitchen utilities: CHF 3,500\n- Equipment depreciation: CHF 2,000\n- Kitchen maintenance: CHF 1,500\n\n---\n\n## Calculating Total Manufacturing Costs\n\n| Cost Component | Amount |\n|---------------|--------|\n| Direct Materials | CHF 42,000 |\n| Direct Labor | CHF 28,000 |\n| Manufacturing Overhead: | |\n| - Indirect materials | CHF 4,500 |\n| - Indirect labor | CHF 6,000 |\n| - Utilities | CHF 3,500 |\n| - Depreciation | CHF 2,000 |\n| - Maintenance | CHF 1,500 |\n| **Total MOH** | **CHF 17,500** |\n| **Total Manufacturing Costs** | **CHF 87,500** |\n\n---\n\n## Cost of Goods Manufactured\n\n```\nBeginning WIP                     CHF  2,000\n+ Direct Materials Used            42,000\n+ Direct Labor                     28,000\n+ Manufacturing Overhead           17,500\n= Total Manufacturing Costs        89,500\n- Ending WIP                       (1,500)\n= Cost of Goods Manufactured   CHF 88,000\n```\n\n---\n\n## Cost of Goods Sold\n\n```\nBeginning Finished Goods      CHF  3,000\n+ Cost of Goods Manufactured      88,000\n= Goods Available for Sale        91,000\n- Ending Finished Goods           (4,000)\n= Cost of Goods Sold          CHF 87,000\n```\n\n---\n\n:::takeaways\n- Track costs through Raw Materials, WIP, Finished Goods, to COGS\n- Manufacturing overhead combines all indirect production costs\n- COGM formula: Begin WIP + Manufacturing Costs - End WIP\n- COGS formula: Begin FG + COGM - End FG\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.3.5: Manufacturing Cost Flows Checkpoint
(
  'd0100000-0000-0000-0003-000000000005',
  'd0000000-0000-0000-0000-000000000001',
  '1.3.5',
  16,
  'Manufacturing Cost Flows Checkpoint',
  'manufacturing-cost-flows-checkpoint',
  'checkpoint',
  12,
  45,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The three inventory accounts in a manufacturing business are:",
        "options": ["Materials, Labor, Overhead", "Assets, Liabilities, Equity", "Raw Materials, WIP, Finished Goods", "Direct, Indirect, Period"],
        "correct": 2,
        "explanation": "Manufacturing businesses have Raw Materials, Work-in-Process, and Finished Goods inventory accounts."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Direct Labor is added to which account?",
        "options": ["Raw Materials", "Work-in-Process", "Finished Goods", "Cost of Goods Sold"],
        "correct": 1,
        "explanation": "Direct Labor, along with Direct Materials and MOH, is added to Work-in-Process during production."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Kitchen supervisor salary in a hotel production kitchen is:",
        "options": ["Direct Labor", "Direct Materials", "Manufacturing Overhead", "Period Cost"],
        "correct": 2,
        "explanation": "Supervisor salary is indirect labor - part of Manufacturing Overhead."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Beginning WIP CHF 5,000 + Manufacturing costs CHF 80,000 - Ending WIP CHF 7,000 = COGM of:",
        "options": ["CHF 72,000", "CHF 78,000", "CHF 82,000", "CHF 92,000"],
        "correct": 1,
        "explanation": "COGM = 5,000 + 80,000 - 7,000 = CHF 78,000"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "COGM CHF 100,000 + Beginning FG CHF 12,000 - Ending FG CHF 15,000 = COGS of:",
        "options": ["CHF 97,000", "CHF 103,000", "CHF 112,000", "CHF 127,000"],
        "correct": 0,
        "explanation": "COGS = Beginning FG + COGM - Ending FG = 12,000 + 100,000 - 15,000 = CHF 97,000"
      },
      {
        "id": "cp6",
        "type": "true_false",
        "question": "Manufacturing costs become expenses immediately when incurred.",
        "correct": false,
        "explanation": "False. Manufacturing costs stay in inventory until products are sold, then become COGS (expense)."
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
-- Skill MA-01: Managerial vs Financial Accounting
('d0100000-0000-0000-0001-000000000001', 'd0000000-0000-0000-0001-000000000001', true, 1.0),
('d0100000-0000-0000-0001-000000000002', 'd0000000-0000-0000-0001-000000000001', true, 1.0),
('d0100000-0000-0000-0001-000000000003', 'd0000000-0000-0000-0001-000000000001', true, 1.0),
('d0100000-0000-0000-0001-000000000004', 'd0000000-0000-0000-0001-000000000001', true, 1.0),
('d0100000-0000-0000-0001-000000000005', 'd0000000-0000-0000-0001-000000000001', true, 1.0),

-- Skill MA-02: Cost Terminology Basics
('d0100000-0000-0000-0002-000000000001', 'd0000000-0000-0000-0001-000000000002', true, 1.0),
('d0100000-0000-0000-0002-000000000002', 'd0000000-0000-0000-0001-000000000002', true, 1.0),
('d0100000-0000-0000-0002-000000000003', 'd0000000-0000-0000-0001-000000000002', true, 1.0),
('d0100000-0000-0000-0002-000000000004', 'd0000000-0000-0000-0001-000000000002', true, 1.0),
('d0100000-0000-0000-0002-000000000005', 'd0000000-0000-0000-0001-000000000002', true, 1.0),
('d0100000-0000-0000-0002-000000000006', 'd0000000-0000-0000-0001-000000000002', true, 1.0),

-- Skill MA-03: Manufacturing Cost Flows
('d0100000-0000-0000-0003-000000000001', 'd0000000-0000-0000-0001-000000000003', true, 1.0),
('d0100000-0000-0000-0003-000000000002', 'd0000000-0000-0000-0001-000000000003', true, 1.0),
('d0100000-0000-0000-0003-000000000003', 'd0000000-0000-0000-0001-000000000003', true, 1.0),
('d0100000-0000-0000-0003-000000000004', 'd0000000-0000-0000-0001-000000000003', true, 1.0),
('d0100000-0000-0000-0003-000000000005', 'd0000000-0000-0000-0001-000000000003', true, 1.0);

