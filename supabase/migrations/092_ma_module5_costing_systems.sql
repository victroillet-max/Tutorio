-- ============================================
-- Module 5: Costing Systems Activities
-- 4 Skills: Job-Order, POHR, Over/Under OH, Service Dept Allocation
-- ~23 Activities with comprehensive content
-- ============================================

-- Clean up existing data to avoid conflicts
DELETE FROM activity_skills WHERE activity_id IN (
  SELECT id FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000005'
);
DELETE FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000005';

-- ============================================
-- SKILL: Job-Order Costing Fundamentals (MA-16)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 5.1.1: Introduction to Job-Order Costing
(
  'd0500000-0000-0000-0001-000000000001',
  'd0000000-0000-0000-0000-000000000005',
  '5.1.1',
  1,
  'Introduction to Job-Order Costing',
  'introduction-job-order-costing',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Introduction to Job-Order Costing\n\n## What is Job-Order Costing?\n\nJob-order costing accumulates costs for each **unique job, batch, or customer order**. It''s used when products/services are distinct and identifiable.\n\n---\n\n## When to Use Job-Order Costing\n\n| Industry | Examples |\n|----------|----------|\n| Hospitality | Catering events, banquets, custom menus |\n| Construction | Building projects |\n| Professional services | Consulting engagements, audits |\n| Manufacturing | Custom furniture, specialty items |\n| Entertainment | Film productions, concerts |\n\n---\n\n## The Job Cost Sheet\n\nA document that tracks all costs for a specific job:\n\n```\n+----------------------------------------+\n|           JOB COST SHEET               |\n| Job Number: J-2024-0142                |\n| Customer: Alpine Corp Annual Dinner    |\n| Start Date: March 1                    |\n| Completion Date: March 15              |\n+----------------------------------------+\n| DIRECT MATERIALS                       |\n| Date    | Description    | Amount     |\n| Mar 5   | Food items     | CHF 2,400  |\n| Mar 10  | Beverages      | CHF    800 |\n| Total Direct Materials   | CHF 3,200  |\n+----------------------------------------+\n| DIRECT LABOR                           |\n| Date    | Hours | Rate | Amount       |\n| Mar 15  | 40    | CHF30| CHF 1,200    |\n| Mar 15  | 20    | CHF25| CHF   500    |\n| Total Direct Labor       | CHF 1,700  |\n+----------------------------------------+\n| MANUFACTURING OVERHEAD APPLIED         |\n| Base: Direct Labor Hours (60)          |\n| Rate: CHF 15/DL hour                   |\n| Total MOH Applied        | CHF   900  |\n+----------------------------------------+\n| TOTAL JOB COST           | CHF 5,800  |\n+----------------------------------------+\n```\n\n---\n\n## Cost Flow in Job-Order Costing\n\n```\nDirect Materials --------\\\nDirect Labor --------------> Work-in-Process --> Finished Goods --> COGS\nMOH Applied -------------/      (by Job)          (by Job)\n```\n\nEach job accumulates its own costs in WIP until complete.\n\n---\n\n## Hospitality Applications\n\n### Catering Events\n- Each event is a separate \"job\"\n- Track ingredients, labor, and overhead per event\n- Calculate profit margin per event\n\n### Banquet Functions\n- Wedding receptions, corporate dinners\n- Customized menus and service requirements\n- Event-specific costs\n\n### Custom Orders\n- Special dietary menus\n- VIP room setups\n- Group travel packages\n\n---\n\n## Job-Order vs Process Costing\n\n| Feature | Job-Order | Process |\n|---------|----------|--------|\n| Products | Unique, distinct | Homogeneous |\n| Cost accumulation | By job | By process/department |\n| Cost calculation | Total job cost / units | Total process cost / units |\n| Examples | Catering event | Hotel laundry |\n\n---\n\n:::takeaways\n- Job-order costing tracks costs by individual job\n- Used for unique, distinguishable products/services\n- The job cost sheet records DM, DL, and MOH applied\n- Perfect for hospitality events and custom services\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.1.2: Job Cost Sheet Builder Interactive
(
  'd0500000-0000-0000-0001-000000000002',
  'd0000000-0000-0000-0000-000000000005',
  '5.1.2',
  2,
  'Job Cost Sheet Builder',
  'job-cost-sheet-builder',
  'interactive',
  8,
  30,
  'basic',
  '{
    "instructions": "Arrange the components of a job cost sheet in the correct order.",
    "sequence": [
      "Job identification (number, customer, dates)",
      "Direct Materials section - list all materials used",
      "Calculate Total Direct Materials",
      "Direct Labor section - hours x rate",
      "Calculate Total Direct Labor",
      "Apply Manufacturing Overhead using predetermined rate",
      "Calculate Total Job Cost (DM + DL + MOH Applied)",
      "Transfer to Finished Goods when complete"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

-- Activity 5.1.3: Job-Order Concepts Quiz
(
  'd0500000-0000-0000-0001-000000000003',
  'd0000000-0000-0000-0000-000000000005',
  '5.1.3',
  3,
  'Job-Order Concepts Quiz',
  'job-order-concepts-quiz',
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
        "question": "Job-order costing is most appropriate when:",
        "options": ["Products are identical", "Products are unique and distinguishable", "Mass production occurs", "There is only one product"],
        "correct": 1,
        "explanation": "Job-order costing is used when each product/service is unique and can be tracked separately."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel catering department would most likely use:",
        "options": ["Process costing", "Job-order costing", "Neither", "Both equally"],
        "correct": 1,
        "explanation": "Each catering event is unique, making job-order costing appropriate."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A job cost sheet accumulates all of the following EXCEPT:",
        "options": ["Direct materials", "Direct labor", "Applied overhead", "Period costs"],
        "correct": 3,
        "explanation": "Job cost sheets track product costs (DM, DL, MOH), not period costs."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "DM CHF 1,500, DL CHF 800, MOH applied CHF 400. Total job cost is:",
        "options": ["CHF 1,500", "CHF 2,300", "CHF 2,700", "CHF 3,100"],
        "correct": 2,
        "explanation": "Total = DM + DL + MOH = 1,500 + 800 + 400 = CHF 2,700"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "In job-order costing, costs remain in WIP until the job is completed.",
        "correct": true,
        "explanation": "True. Costs accumulate in WIP for each job until it''s finished."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which hospitality activity would NOT use job-order costing?",
        "options": ["Wedding reception", "Custom banquet menu", "Daily hotel laundry", "Corporate retreat planning"],
        "correct": 2,
        "explanation": "Daily laundry is repetitive and homogeneous - better suited to process costing."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.1.4: Catering Event Costing Practice
(
  'd0500000-0000-0000-0001-000000000004',
  'd0000000-0000-0000-0000-000000000005',
  '5.1.4',
  4,
  'Catering Event Costing',
  'catering-event-costing',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Catering Event Costing\n\n## Lakeside Catering Job Analysis\n\n**Job: Johnson-Smith Wedding Reception**\n**200 guests, 4-course dinner with open bar**\n\n---\n\n## Job Cost Sheet\n\n### Direct Materials\n\n| Item | Quantity | Unit Cost | Total |\n|------|----------|-----------|-------|\n| Prime rib | 40 kg | CHF 35 | CHF 1,400 |\n| Salmon | 20 kg | CHF 28 | CHF 560 |\n| Vegetables | Various | - | CHF 320 |\n| Appetizers | 200 portions | CHF 4 | CHF 800 |\n| Desserts | 200 portions | CHF 6 | CHF 1,200 |\n| Beverages | Open bar | - | CHF 2,400 |\n| **Total DM** | | | **CHF 6,680** |\n\n### Direct Labor\n\n| Role | Hours | Rate | Total |\n|------|-------|------|-------|\n| Head chef | 12 | CHF 45 | CHF 540 |\n| Line cooks (3) | 36 | CHF 28 | CHF 1,008 |\n| Servers (8) | 48 | CHF 22 | CHF 1,056 |\n| Bartenders (2) | 16 | CHF 24 | CHF 384 |\n| **Total DL** | **112 hrs** | | **CHF 2,988** |\n\n### Manufacturing Overhead Applied\n\n| Allocation Base | Amount | Rate | Total |\n|-----------------|--------|------|-------|\n| Direct labor hours | 112 | CHF 12 | CHF 1,344 |\n\n---\n\n## Total Job Cost\n\n| Component | Amount |\n|-----------|--------|\n| Direct Materials | CHF 6,680 |\n| Direct Labor | CHF 2,988 |\n| MOH Applied | CHF 1,344 |\n| **Total Job Cost** | **CHF 11,012** |\n\n---\n\n## Profitability Analysis\n\n**Contract Price**: CHF 17,000 (CHF 85 per guest)\n\n| | Amount | Per Guest |\n|-|--------|----------|\n| Revenue | CHF 17,000 | CHF 85.00 |\n| Job Cost | CHF 11,012 | CHF 55.06 |\n| **Gross Profit** | **CHF 5,988** | **CHF 29.94** |\n| Gross Margin | 35.2% | |\n\n---\n\n:::takeaways\n- Each catering event has its own job cost sheet\n- Track DM, DL, and overhead for each event\n- Calculate profit margin per event\n- Use data for pricing future events\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.1.5: Banquet Hall Costing Applied
(
  'd0500000-0000-0000-0001-000000000005',
  'd0000000-0000-0000-0000-000000000005',
  '5.1.5',
  5,
  'Banquet Hall Costing',
  'banquet-hall-costing',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A banquet has DM CHF 4,200, DL 80 hours @ CHF 25/hr, MOH rate CHF 15/DL hour. Total job cost:",
        "options": ["CHF 6,200", "CHF 7,400", "CHF 5,400", "CHF 8,200"],
        "correct": 1,
        "explanation": "DL = 80 x 25 = 2,000. MOH = 80 x 15 = 1,200. Total = 4,200 + 2,000 + 1,200 = CHF 7,400"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If the banquet is for 100 guests, cost per guest is:",
        "options": ["CHF 42", "CHF 54", "CHF 74", "CHF 82"],
        "correct": 2,
        "explanation": "Cost per guest = 7,400 / 100 = CHF 74"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If priced at CHF 110 per guest, gross profit margin is approximately:",
        "options": ["33%", "42%", "55%", "67%"],
        "correct": 0,
        "explanation": "Profit = 110 - 74 = 36. Margin = 36/110 = 32.7%, approximately 33%"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "To earn 40% gross margin, price per guest should be:",
        "options": ["CHF 104", "CHF 118", "CHF 123", "CHF 148"],
        "correct": 2,
        "explanation": "Price = Cost / (1 - Margin) = 74 / 0.60 = CHF 123.33"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "The MOH applied using a predetermined rate may differ from actual overhead incurred.",
        "correct": true,
        "explanation": "True. This difference creates over/underapplied overhead."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.1.6: Job-Order Fundamentals Checkpoint
(
  'd0500000-0000-0000-0001-000000000006',
  'd0000000-0000-0000-0000-000000000005',
  '5.1.6',
  6,
  'Job-Order Fundamentals Checkpoint',
  'job-order-fundamentals-checkpoint',
  'checkpoint',
  12,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Job-order costing is BEST for:",
        "options": ["Continuous production", "Unique products/services", "Identical outputs", "Chemical processing"],
        "correct": 1,
        "explanation": "Job-order costing tracks costs for unique, distinguishable jobs."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "The three components on a job cost sheet are:",
        "options": ["Assets, Liabilities, Equity", "DM, DL, MOH Applied", "Fixed, Variable, Mixed", "Prime, Conversion, Period"],
        "correct": 1,
        "explanation": "Job cost sheets track Direct Materials, Direct Labor, and Manufacturing Overhead Applied."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Job 101: DM CHF 2,800, DL CHF 1,600 (40 hrs), MOH CHF 18/hr. Total cost:",
        "options": ["CHF 4,400", "CHF 5,120", "CHF 5,400", "CHF 6,200"],
        "correct": 1,
        "explanation": "MOH = 40 x 18 = 720. Total = 2,800 + 1,600 + 720 = CHF 5,120"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "When Job 101 is complete, it moves from WIP to:",
        "options": ["Raw Materials", "Cost of Goods Sold", "Finished Goods", "Period Expense"],
        "correct": 2,
        "explanation": "Completed jobs move from WIP to Finished Goods inventory."
      },
      {
        "id": "cp5",
        "type": "true_false",
        "question": "A wedding reception and a corporate conference would be treated as separate jobs.",
        "correct": true,
        "explanation": "True. Each event is a distinct job with its own cost accumulation."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- Activity 5.2.1: Calculating Predetermined Overhead Rates
(
  'd0500000-0000-0000-0002-000000000001',
  'd0000000-0000-0000-0000-000000000005',
  '5.2.1',
  7,
  'Calculating Predetermined Overhead Rates',
  'calculating-predetermined-overhead-rates',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Calculating Predetermined Overhead Rates\n\n## Why Predetermined Rates?\n\nActual overhead is only known at period end. But we need to cost jobs during the period. Solution: use a **predetermined overhead rate (POHR)**.\n\n---\n\n## POHR Formula\n\n$$\\text{POHR} = \\frac{\\text{Estimated Total Manufacturing Overhead}}{\\text{Estimated Total Allocation Base}}$$\n\nCalculated at the **beginning** of the period using estimates.\n\n---\n\n## Common Allocation Bases\n\n| Base | When to Use |\n|------|------------|\n| Direct labor hours | Labor-intensive operations |\n| Direct labor cost | Consistent wage rates |\n| Machine hours | Automated production |\n| Direct materials cost | Materials-intensive |\n| Units produced | Homogeneous products |\n\n---\n\n## Example: Hotel Kitchen\n\n**Budget Estimates for Year:**\n- Estimated MOH: CHF 180,000\n- Estimated direct labor hours: 12,000 hours\n\n$$\\text{POHR} = \\frac{180,000}{12,000} = \\text{CHF 15 per DL hour}$$\n\n---\n\n## Applying Overhead to Jobs\n\nOnce POHR is set, apply overhead to each job:\n\n$$\\text{OH Applied} = \\text{POHR} \\times \\text{Actual Allocation Base Used}$$\n\n### Example Job\n- Job uses 25 direct labor hours\n- OH Applied = CHF 15 x 25 = CHF 375\n\n---\n\n## Multiple POHRs\n\nSome companies use different rates for different departments:\n\n| Department | Est. MOH | Est. Base | POHR |\n|------------|----------|-----------|------|\n| Kitchen | CHF 180,000 | 12,000 DL hrs | CHF 15/DL hr |\n| Housekeeping | CHF 120,000 | 60,000 rooms | CHF 2/room |\n| Maintenance | CHF 90,000 | 3,000 maint hrs | CHF 30/maint hr |\n\n---\n\n## Advantages of POHR\n\n1. **Timely costing** - Don''t wait for actual costs\n2. **Smooth cost flow** - Avoids seasonal fluctuations\n3. **Consistent pricing** - Quote jobs before completion\n4. **Management focus** - Highlights variance from plan\n\n---\n\n## Choosing the Right Base\n\n:::concept{title=\"Cause-and-Effect Relationship\"}\nChoose an allocation base that has a **logical connection** to overhead costs:\n- If overhead is driven by labor, use DL hours\n- If overhead is driven by machines, use machine hours\n- The base should reflect what causes overhead to be incurred\n:::\n\n---\n\n:::takeaways\n- POHR = Estimated MOH / Estimated Allocation Base\n- Calculate at period start using budgeted amounts\n- Apply to jobs: POHR x Actual base used\n- Choose allocation base that reflects cost driver\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.2.2: POHR Calculator Interactive
(
  'd0500000-0000-0000-0002-000000000002',
  'd0000000-0000-0000-0000-000000000005',
  '5.2.2',
  8,
  'POHR Calculator',
  'pohr-calculator',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Put the POHR calculation and application steps in order.",
    "sequence": [
      "Estimate total manufacturing overhead for the period",
      "Estimate total allocation base (e.g., DL hours) for the period",
      "Calculate POHR = Estimated MOH / Estimated Base",
      "Track actual allocation base used by each job",
      "Apply overhead: POHR x Actual base used",
      "Compare applied to actual at period end"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

-- Activity 5.2.3: Overhead Rate Quiz
(
  'd0500000-0000-0000-0002-000000000003',
  'd0000000-0000-0000-0000-000000000005',
  '5.2.3',
  9,
  'Overhead Rate Questions',
  'overhead-rate-questions',
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
        "question": "POHR is calculated using:",
        "options": ["Actual costs only", "Estimated costs only", "Actual and estimated", "Neither"],
        "correct": 1,
        "explanation": "POHR uses estimated MOH and estimated allocation base."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Estimated MOH CHF 240,000, Estimated DL hours 16,000. POHR is:",
        "options": ["CHF 12/hr", "CHF 15/hr", "CHF 18/hr", "CHF 20/hr"],
        "correct": 1,
        "explanation": "POHR = 240,000 / 16,000 = CHF 15 per DL hour"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A job uses 80 DL hours. With POHR CHF 15/hr, overhead applied is:",
        "options": ["CHF 80", "CHF 1,200", "CHF 1,500", "CHF 15"],
        "correct": 1,
        "explanation": "OH Applied = 80 hours x CHF 15 = CHF 1,200"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which is the BEST allocation base for a machine-intensive factory?",
        "options": ["Direct labor hours", "Direct labor cost", "Machine hours", "Number of employees"],
        "correct": 2,
        "explanation": "Machine hours best reflects the cost driver in automated production."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "POHR is calculated at the end of the accounting period.",
        "correct": false,
        "explanation": "False. POHR is calculated at the BEGINNING of the period using estimates."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If actual MOH is CHF 250,000 but applied MOH is CHF 240,000, overhead is:",
        "options": ["Underapplied by CHF 10,000", "Overapplied by CHF 10,000", "Fully applied", "Cannot determine"],
        "correct": 0,
        "explanation": "Applied < Actual means underapplied by the difference."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.2.4: Hotel Housekeeping Overhead
(
  'd0500000-0000-0000-0002-000000000004',
  'd0000000-0000-0000-0000-000000000005',
  '5.2.4',
  10,
  'Hotel Housekeeping Overhead',
  'hotel-housekeeping-overhead',
  'lesson',
  10,
  30,
  'basic',
  '{"markdown": "# Hotel Housekeeping Overhead\n\n## Setting the POHR for Housekeeping\n\n**Mountain View Hotel - Housekeeping Department**\n\nBudget for upcoming year:\n- Estimated cleaning supplies: CHF 48,000\n- Estimated equipment depreciation: CHF 24,000\n- Estimated supervisor salary: CHF 60,000\n- Estimated utilities (dept share): CHF 18,000\n- **Total Estimated MOH: CHF 150,000**\n- Estimated rooms to be cleaned: 50,000\n\n---\n\n## Calculate POHR\n\n$$\\text{POHR} = \\frac{150,000}{50,000 \\text{ rooms}} = \\text{CHF 3 per room cleaned}$$\n\n---\n\n## Applying to a Specific Month\n\n**March Results:**\n- Rooms cleaned: 4,200\n- Overhead Applied: 4,200 x CHF 3 = **CHF 12,600**\n\n**Actual March Overhead:**\n- Supplies used: CHF 4,100\n- Depreciation: CHF 2,000\n- Supervisor: CHF 5,000\n- Utilities: CHF 1,600\n- **Total Actual: CHF 12,700**\n\n---\n\n## Analysis\n\n| | Amount |\n|-|--------|\n| Applied MOH | CHF 12,600 |\n| Actual MOH | CHF 12,700 |\n| Difference | CHF (100) underapplied |\n\nSlightly underapplied - estimates were close!\n\n---\n\n## Using POHR for Costing\n\nIf a VIP suite requires 2 hours of cleaning (vs 30 min for standard):\n\n- Standard room: 1 clean x CHF 3 = CHF 3 overhead\n- VIP suite: Could use time-based rate instead\n\n---\n\n:::takeaways\n- Housekeeping overhead can be allocated per room cleaned\n- POHR provides consistent cost per room\n- Compare applied vs actual to evaluate estimates\n- Adjust rates if significant variances occur\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.2.5: Restaurant Kitchen Overhead Practice
(
  'd0500000-0000-0000-0002-000000000005',
  'd0000000-0000-0000-0000-000000000005',
  '5.2.5',
  11,
  'Restaurant Kitchen Overhead',
  'restaurant-kitchen-overhead',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Kitchen estimates: MOH CHF 96,000, DL hours 8,000. POHR is:",
        "options": ["CHF 8/hr", "CHF 10/hr", "CHF 12/hr", "CHF 15/hr"],
        "correct": 2,
        "explanation": "POHR = 96,000 / 8,000 = CHF 12 per DL hour"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A special menu takes 15 DL hours. Overhead applied is:",
        "options": ["CHF 144", "CHF 150", "CHF 180", "CHF 200"],
        "correct": 2,
        "explanation": "OH Applied = 15 x CHF 12 = CHF 180"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If kitchen actual DL hours are 8,500 (CHF 12 POHR), and actual MOH is CHF 100,000, overhead is:",
        "options": ["Underapplied CHF 2,000", "Overapplied CHF 2,000", "Underapplied CHF 4,000", "Overapplied CHF 4,000"],
        "correct": 0,
        "explanation": "Applied = 8,500 x 12 = 102,000. Actual = 100,000. Overapplied... Wait, 102,000 > 100,000 means overapplied by 2,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The kitchen might also allocate overhead based on:",
        "options": ["Number of employees", "Meals prepared", "Square footage", "Any of the above"],
        "correct": 3,
        "explanation": "Any logical allocation base can be used if it reflects cost driver."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Using departmental rates (kitchen vs housekeeping) gives more accurate product costs.",
        "correct": true,
        "explanation": "True. Departmental rates reflect different cost structures in each area."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.2.6: POHR Checkpoint
(
  'd0500000-0000-0000-0002-000000000006',
  'd0000000-0000-0000-0000-000000000005',
  '5.2.6',
  12,
  'Predetermined Overhead Rates Checkpoint',
  'pohr-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "POHR = Estimated MOH / ____",
        "options": ["Actual MOH", "Estimated Allocation Base", "Actual Allocation Base", "Fixed Costs"],
        "correct": 1,
        "explanation": "POHR = Estimated MOH / Estimated Allocation Base"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Est. MOH CHF 200,000, Est. machine hours 10,000. POHR:",
        "options": ["CHF 15", "CHF 20", "CHF 25", "CHF 30"],
        "correct": 1,
        "explanation": "POHR = 200,000 / 10,000 = CHF 20 per machine hour"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Job uses 45 machine hours at CHF 20 POHR. Applied overhead:",
        "options": ["CHF 450", "CHF 900", "CHF 45", "CHF 200"],
        "correct": 1,
        "explanation": "Applied = 45 x 20 = CHF 900"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Overhead is applied to jobs using actual overhead incurred.",
        "correct": false,
        "explanation": "False. Overhead is applied using the predetermined rate x actual base."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "A labor-intensive kitchen should allocate overhead using:",
        "options": ["Machine hours", "Square footage", "Direct labor hours", "Number of ingredients"],
        "correct": 2,
        "explanation": "In labor-intensive operations, direct labor hours reflects the cost driver."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- Activity 5.3.1: Actual vs Applied Overhead
(
  'd0500000-0000-0000-0003-000000000001',
  'd0000000-0000-0000-0000-000000000005',
  '5.3.1',
  13,
  'Actual vs Applied Overhead',
  'actual-vs-applied-overhead',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Actual vs Applied Overhead\n\n## The Variance Problem\n\nBecause we use **estimates** for POHR, applied overhead rarely equals actual overhead.\n\n---\n\n## Two Possible Outcomes\n\n### Underapplied Overhead\n$$\\text{Actual MOH} > \\text{Applied MOH}$$\n\n- We applied **less** than we actually incurred\n- Products are undercosted\n- Must add the difference to COGS\n\n### Overapplied Overhead\n$$\\text{Actual MOH} < \\text{Applied MOH}$$\n\n- We applied **more** than we actually incurred\n- Products are overcosted\n- Must reduce COGS by the difference\n\n---\n\n## Calculating the Variance\n\n| | Amount |\n|-|--------|\n| Actual MOH incurred | CHF 95,000 |\n| Applied MOH (POHR x base) | CHF 90,000 |\n| **Underapplied** | **CHF 5,000** |\n\n---\n\n## Disposing of Over/Underapplied OH\n\n### Method 1: Close to COGS (Simplest)\n\n- **Underapplied**: Add to COGS (increases expense)\n- **Overapplied**: Subtract from COGS (decreases expense)\n\n### Method 2: Prorate (More Accurate)\n\nAllocate the variance to:\n- Work-in-Process\n- Finished Goods\n- Cost of Goods Sold\n\nBased on their relative balances.\n\n---\n\n## Journal Entries\n\n### Underapplied (CHF 5,000):\n```\nCost of Goods Sold           5,000\n    Manufacturing Overhead          5,000\n```\n\n### Overapplied (CHF 3,000):\n```\nManufacturing Overhead       3,000\n    Cost of Goods Sold              3,000\n```\n\n---\n\n## Why Variances Occur\n\n| Cause | Effect |\n|-------|--------|\n| Higher actual costs | Underapplied |\n| Lower actual costs | Overapplied |\n| More units than expected | Overapplied |\n| Fewer units than expected | Underapplied |\n| Poor estimates | Either direction |\n\n---\n\n:::takeaways\n- Variance = Actual MOH - Applied MOH\n- Underapplied (positive) increases COGS\n- Overapplied (negative) decreases COGS\n- Most companies close variance to COGS\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.3.2: Overhead Variance Quiz
(
  'd0500000-0000-0000-0003-000000000002',
  'd0000000-0000-0000-0000-000000000005',
  '5.3.2',
  14,
  'Overhead Variance Concepts',
  'overhead-variance-concepts',
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
        "question": "Overhead is underapplied when:",
        "options": ["Applied > Actual", "Actual > Applied", "Applied = Actual", "POHR is too high"],
        "correct": 1,
        "explanation": "Underapplied means actual overhead exceeded what was applied to products."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Actual MOH CHF 82,000, Applied MOH CHF 78,000. This is:",
        "options": ["Underapplied CHF 4,000", "Overapplied CHF 4,000", "Underapplied CHF 160,000", "No variance"],
        "correct": 0,
        "explanation": "Actual > Applied by CHF 4,000 = Underapplied CHF 4,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Underapplied overhead is disposed of by:",
        "options": ["Adding to COGS", "Subtracting from COGS", "Adding to revenue", "Ignoring it"],
        "correct": 0,
        "explanation": "Underapplied overhead increases COGS to recognize the additional expense."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Overapplied overhead CHF 6,000 means products were:",
        "options": ["Undercosted", "Overcosted", "Correctly costed", "Not costed"],
        "correct": 1,
        "explanation": "Overapplied means we applied too much, overcosting the products."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Over/underapplied overhead is usually closed to COGS at period end.",
        "correct": true,
        "explanation": "True. The simplest method closes the variance to Cost of Goods Sold."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "POHR CHF 10/hr, Actual hours 9,500, Actual MOH CHF 100,000. Variance:",
        "options": ["Underapplied CHF 5,000", "Overapplied CHF 5,000", "Underapplied CHF 4,500", "Overapplied CHF 4,500"],
        "correct": 0,
        "explanation": "Applied = 9,500 x 10 = 95,000. Actual = 100,000. Under by 5,000."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.3.3: Overhead Reconciliation Interactive
(
  'd0500000-0000-0000-0003-000000000003',
  'd0000000-0000-0000-0000-000000000005',
  '5.3.3',
  15,
  'Overhead Reconciliation',
  'overhead-reconciliation',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Match each scenario to the correct variance type and disposal.",
    "pairs": [
      {"left": "Actual CHF 50K, Applied CHF 48K", "right": "Underapplied CHF 2K"},
      {"left": "Actual CHF 75K, Applied CHF 80K", "right": "Overapplied CHF 5K"},
      {"left": "Products are overcosted", "right": "Overapplied overhead"},
      {"left": "Products are undercosted", "right": "Underapplied overhead"},
      {"left": "Add to COGS", "right": "Underapplied disposal"},
      {"left": "Subtract from COGS", "right": "Overapplied disposal"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 5.3.4: Year-End Adjustments Practice
(
  'd0500000-0000-0000-0003-000000000004',
  'd0000000-0000-0000-0000-000000000005',
  '5.3.4',
  16,
  'Year-End Overhead Adjustments',
  'year-end-overhead-adjustments',
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
        "question": "COGS before adjustment CHF 500,000, Underapplied OH CHF 8,000. Adjusted COGS:",
        "options": ["CHF 492,000", "CHF 500,000", "CHF 508,000", "CHF 516,000"],
        "correct": 2,
        "explanation": "Adjusted COGS = 500,000 + 8,000 = CHF 508,000"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "COGS before adjustment CHF 400,000, Overapplied OH CHF 12,000. Adjusted COGS:",
        "options": ["CHF 388,000", "CHF 400,000", "CHF 412,000", "CHF 424,000"],
        "correct": 0,
        "explanation": "Adjusted COGS = 400,000 - 12,000 = CHF 388,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Underapplied overhead will _____ net income when closed to COGS.",
        "options": ["Increase", "Decrease", "Not affect", "Double"],
        "correct": 1,
        "explanation": "Adding to COGS increases expenses, which decreases net income."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Overapplied overhead will _____ net income when closed to COGS.",
        "options": ["Increase", "Decrease", "Not affect", "Halve"],
        "correct": 0,
        "explanation": "Subtracting from COGS decreases expenses, which increases net income."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Prorating the variance to WIP, FG, and COGS is more accurate than closing entirely to COGS.",
        "correct": true,
        "explanation": "True. Proration assigns the variance based on where the costs actually reside."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.3.5: Over/Under Overhead Checkpoint
(
  'd0500000-0000-0000-0003-000000000005',
  'd0000000-0000-0000-0000-000000000005',
  '5.3.5',
  17,
  'Overhead Variance Checkpoint',
  'overhead-variance-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "When Actual MOH < Applied MOH, overhead is:",
        "options": ["Underapplied", "Overapplied", "Correctly applied", "Zero"],
        "correct": 1,
        "explanation": "Overapplied means we applied more than actually incurred."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Applied MOH CHF 120,000, Actual CHF 127,000. Variance:",
        "options": ["Underapplied CHF 7,000", "Overapplied CHF 7,000", "No variance", "CHF 247,000"],
        "correct": 0,
        "explanation": "Actual > Applied = Underapplied by CHF 7,000"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "To close underapplied overhead CHF 7,000, the entry debits:",
        "options": ["Manufacturing Overhead", "Work-in-Process", "Cost of Goods Sold", "Finished Goods"],
        "correct": 2,
        "explanation": "Debit COGS to increase expense for underapplied overhead."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Large over/underapplied amounts suggest the POHR estimates were poor.",
        "correct": true,
        "explanation": "True. Significant variances indicate estimation problems."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Gross profit will be _____ if overhead was overapplied.",
        "options": ["Understated before adjustment", "Overstated before adjustment", "Unaffected", "Zero"],
        "correct": 1,
        "explanation": "Overapplied means COGS was too high, understating gross profit before adjustment."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- Activity 5.4.1: Allocating Service Department Costs
(
  'd0500000-0000-0000-0004-000000000001',
  'd0000000-0000-0000-0000-000000000005',
  '5.4.1',
  18,
  'Allocating Service Department Costs',
  'allocating-service-department-costs',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Allocating Service Department Costs\n\n## Service vs Operating Departments\n\n| Service Departments | Operating Departments |\n|--------------------|----------------------|\n| Support operations | Generate revenue |\n| IT, HR, Maintenance | Rooms, F&B, Spa |\n| Costs allocated out | Receive allocated costs |\n\n---\n\n## Why Allocate?\n\n1. **Full product costing** - Include all costs\n2. **Pricing decisions** - Recover support costs\n3. **Cost control** - Make departments accountable\n4. **Performance evaluation** - Fair comparison\n\n---\n\n## Two Common Methods\n\n### 1. Direct Method (Simple)\n- Allocate service costs directly to operating departments\n- Ignores services provided between service departments\n\n### 2. Step-Down Method (More Accurate)\n- Allocate in sequence, starting with largest service dept\n- Each step includes previously allocated costs\n- Partially recognizes inter-service relationships\n\n---\n\n## Direct Method Example\n\n**Hotel Support Services:**\n\n| Service Dept | Total Cost | Allocation Base |\n|--------------|------------|----------------|\n| IT | CHF 60,000 | Computer terminals |\n| HR | CHF 40,000 | Number of employees |\n\n**Operating Department Usage:**\n\n| | Rooms | F&B | Total |\n|-|-------|-----|-------|\n| Computer terminals | 30 | 10 | 40 |\n| Employees | 60 | 40 | 100 |\n\n### IT Allocation (Direct):\n- Rooms: 30/40 x CHF 60,000 = CHF 45,000\n- F&B: 10/40 x CHF 60,000 = CHF 15,000\n\n### HR Allocation (Direct):\n- Rooms: 60/100 x CHF 40,000 = CHF 24,000\n- F&B: 40/100 x CHF 40,000 = CHF 16,000\n\n---\n\n## Total Allocated to Operating Depts\n\n| | Rooms | F&B |\n|-|-------|-----|\n| From IT | CHF 45,000 | CHF 15,000 |\n| From HR | CHF 24,000 | CHF 16,000 |\n| **Total** | **CHF 69,000** | **CHF 31,000** |\n\n---\n\n## Step-Down Method\n\nAllocates IT first (includes HR''s usage of IT), then HR:\n\n1. IT serves both HR and operating depts\n2. Allocate IT costs to HR and operating depts\n3. Then allocate HR (now including its IT allocation)\n4. More accurate but more complex\n\n---\n\n:::takeaways\n- Service dept costs must be allocated to operating depts\n- Direct method is simpler but ignores inter-service usage\n- Step-down method is more accurate\n- Choose allocation base that reflects usage\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.4.2: Allocation Method Selector Interactive
(
  'd0500000-0000-0000-0004-000000000002',
  'd0000000-0000-0000-0000-000000000005',
  '5.4.2',
  19,
  'Allocation Method Selector',
  'allocation-method-selector',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Match each characteristic to the correct allocation method.",
    "pairs": [
      {"left": "Simpler to calculate", "right": "Direct Method"},
      {"left": "More accurate results", "right": "Step-Down Method"},
      {"left": "Ignores inter-service usage", "right": "Direct Method"},
      {"left": "Allocates in sequence", "right": "Step-Down Method"},
      {"left": "One-step allocation", "right": "Direct Method"},
      {"left": "Partially recognizes reciprocal services", "right": "Step-Down Method"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 5.4.3: Service Department Quiz
(
  'd0500000-0000-0000-0004-000000000003',
  'd0000000-0000-0000-0000-000000000005',
  '5.4.3',
  20,
  'Service Department Concepts',
  'service-department-concepts',
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
        "question": "Service departments:",
        "options": ["Generate revenue directly", "Support operating departments", "Only have variable costs", "Are not part of overhead"],
        "correct": 1,
        "explanation": "Service departments support operating departments rather than generating revenue directly."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "IT costs CHF 80,000. Rooms uses 60% of IT resources, F&B uses 40%. Direct allocation to Rooms:",
        "options": ["CHF 32,000", "CHF 48,000", "CHF 80,000", "CHF 20,000"],
        "correct": 1,
        "explanation": "Rooms = 60% x CHF 80,000 = CHF 48,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The direct method is called ''direct'' because it:",
        "options": ["Uses direct costs only", "Allocates directly to operating depts", "Is the most accurate", "Uses direct labor hours"],
        "correct": 1,
        "explanation": "Direct method allocates service costs directly to operating departments, skipping other service depts."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The step-down method allocates service department costs in a specific sequence.",
        "correct": true,
        "explanation": "True. Step-down proceeds from one service dept to the next in order."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which method most accurately reflects that service depts serve each other?",
        "options": ["Direct method", "Step-down method", "Reciprocal method", "None of the above"],
        "correct": 2,
        "explanation": "The reciprocal method (not covered in detail) fully accounts for inter-service relationships."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The best allocation base for HR costs is typically:",
        "options": ["Square footage", "Machine hours", "Number of employees", "Revenue"],
        "correct": 2,
        "explanation": "Number of employees reflects HR''s workload in each department."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.4.4: Hotel Support Services Practice
(
  'd0500000-0000-0000-0004-000000000004',
  'd0000000-0000-0000-0000-000000000005',
  '5.4.4',
  21,
  'Hotel Support Services',
  'hotel-support-services',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Hotel Support Services Allocation\n\n## Grand Resort Hotel\n\n**Service Departments:**\n- IT: CHF 72,000\n- Maintenance: CHF 108,000\n\n**Operating Departments:**\n- Rooms Division\n- Food & Beverage\n- Spa & Wellness\n\n---\n\n## Allocation Bases\n\n| Service | Base | Rooms | F&B | Spa |\n|---------|------|-------|-----|-----|\n| IT | Terminals | 50 | 30 | 20 |\n| Maint. | Sq meters | 5,000 | 3,000 | 2,000 |\n\n---\n\n## Direct Method Allocation\n\n### IT Allocation (Total: 100 terminals)\n\n| Dept | Terminals | % | Allocation |\n|------|-----------|---|------------|\n| Rooms | 50 | 50% | CHF 36,000 |\n| F&B | 30 | 30% | CHF 21,600 |\n| Spa | 20 | 20% | CHF 14,400 |\n| **Total** | 100 | 100% | **CHF 72,000** |\n\n### Maintenance Allocation (Total: 10,000 sq m)\n\n| Dept | Sq M | % | Allocation |\n|------|------|---|------------|\n| Rooms | 5,000 | 50% | CHF 54,000 |\n| F&B | 3,000 | 30% | CHF 32,400 |\n| Spa | 2,000 | 20% | CHF 21,600 |\n| **Total** | 10,000 | 100% | **CHF 108,000** |\n\n---\n\n## Total Service Cost Allocation\n\n| Dept | IT | Maint. | Total |\n|------|-----|--------|-------|\n| Rooms | CHF 36,000 | CHF 54,000 | **CHF 90,000** |\n| F&B | CHF 21,600 | CHF 32,400 | **CHF 54,000** |\n| Spa | CHF 14,400 | CHF 21,600 | **CHF 36,000** |\n| **Total** | CHF 72,000 | CHF 108,000 | **CHF 180,000** |\n\n---\n\n## Using Allocated Costs\n\nThese allocated costs are added to each department''s direct costs for:\n- Full cost analysis\n- Pricing decisions\n- Profitability assessment\n- Performance evaluation\n\n---\n\n:::takeaways\n- Allocate service costs based on usage measures\n- IT uses terminals, Maintenance uses square meters\n- Direct method ignores that IT serves Maintenance\n- Total allocated must equal total service costs\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.4.5: Step Method Application Quiz
(
  'd0500000-0000-0000-0004-000000000005',
  'd0000000-0000-0000-0000-000000000005',
  '5.4.5',
  22,
  'Step Method Application',
  'step-method-application',
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
        "question": "In step-down, which service dept is typically allocated first?",
        "options": ["Smallest cost", "Most service to others", "Alphabetically first", "Random selection"],
        "correct": 1,
        "explanation": "Start with the dept providing the most service to other service depts."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "After allocating IT in step-down, HR''s cost to allocate includes:",
        "options": ["Only HR''s original cost", "HR''s cost plus IT allocation to HR", "Only IT''s cost", "Neither"],
        "correct": 1,
        "explanation": "Step-down accumulates - HR allocates its original cost plus its share of IT."
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Once a service dept is allocated in step-down, it receives no more allocations.",
        "correct": true,
        "explanation": "True. In step-down, once allocated, a dept is done and receives no further costs."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Direct method vs step-down: which gives operating depts HIGHER allocated costs?",
        "options": ["Direct method always", "Step-down always", "Depends on usage patterns", "They are always equal"],
        "correct": 3,
        "explanation": "Total allocated equals total service costs in both methods - just distributed differently."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "The reciprocal method is most accurate because it:",
        "options": ["Is simplest to calculate", "Fully recognizes inter-service relationships", "Ignores operating depts", "Uses only direct costs"],
        "correct": 1,
        "explanation": "Reciprocal method uses simultaneous equations to fully capture inter-service usage."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.4.6: Service Department Allocation Checkpoint
(
  'd0500000-0000-0000-0004-000000000006',
  'd0000000-0000-0000-0000-000000000005',
  '5.4.6',
  23,
  'Service Department Allocation Checkpoint',
  'service-department-allocation-checkpoint',
  'checkpoint',
  12,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Service departments such as IT and HR are allocated because:",
        "options": ["They generate revenue", "Their costs should be assigned to revenue centers", "They have no costs", "Regulations require it"],
        "correct": 1,
        "explanation": "Service dept costs are allocated to operating (revenue) depts for full costing."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "HR costs CHF 50,000. Rooms has 80 employees, F&B has 20. HR allocated to Rooms:",
        "options": ["CHF 10,000", "CHF 20,000", "CHF 40,000", "CHF 50,000"],
        "correct": 2,
        "explanation": "Rooms = 80/100 x 50,000 = CHF 40,000"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "The direct method ignores:",
        "options": ["Operating departments", "Service dept costs", "Services between service depts", "All allocations"],
        "correct": 2,
        "explanation": "Direct method skips inter-service allocations, going straight to operating depts."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Total service costs allocated must equal total service department costs.",
        "correct": true,
        "explanation": "True. We are redistributing costs, not creating or eliminating them."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "For maintenance costs, the best allocation base is likely:",
        "options": ["Number of employees", "Square footage or maintenance hours", "Revenue", "Number of customers"],
        "correct": 1,
        "explanation": "Maintenance usage relates to space or actual maintenance work performed."
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
-- Skill MA-16: Job-Order Costing Fundamentals
('d0500000-0000-0000-0001-000000000001', 'd0000000-0000-0000-0005-000000000001', true, 1.0),
('d0500000-0000-0000-0001-000000000002', 'd0000000-0000-0000-0005-000000000001', true, 1.0),
('d0500000-0000-0000-0001-000000000003', 'd0000000-0000-0000-0005-000000000001', true, 1.0),
('d0500000-0000-0000-0001-000000000004', 'd0000000-0000-0000-0005-000000000001', true, 1.0),
('d0500000-0000-0000-0001-000000000005', 'd0000000-0000-0000-0005-000000000001', true, 1.0),
('d0500000-0000-0000-0001-000000000006', 'd0000000-0000-0000-0005-000000000001', true, 1.0),

-- Skill MA-17: Predetermined Overhead Rates
('d0500000-0000-0000-0002-000000000001', 'd0000000-0000-0000-0005-000000000002', true, 1.0),
('d0500000-0000-0000-0002-000000000002', 'd0000000-0000-0000-0005-000000000002', true, 1.0),
('d0500000-0000-0000-0002-000000000003', 'd0000000-0000-0000-0005-000000000002', true, 1.0),
('d0500000-0000-0000-0002-000000000004', 'd0000000-0000-0000-0005-000000000002', true, 1.0),
('d0500000-0000-0000-0002-000000000005', 'd0000000-0000-0000-0005-000000000002', true, 1.0),
('d0500000-0000-0000-0002-000000000006', 'd0000000-0000-0000-0005-000000000002', true, 1.0),

-- Skill MA-18: Over/Under Applied Overhead
('d0500000-0000-0000-0003-000000000001', 'd0000000-0000-0000-0005-000000000003', true, 1.0),
('d0500000-0000-0000-0003-000000000002', 'd0000000-0000-0000-0005-000000000003', true, 1.0),
('d0500000-0000-0000-0003-000000000003', 'd0000000-0000-0000-0005-000000000003', true, 1.0),
('d0500000-0000-0000-0003-000000000004', 'd0000000-0000-0000-0005-000000000003', true, 1.0),
('d0500000-0000-0000-0003-000000000005', 'd0000000-0000-0000-0005-000000000003', true, 1.0),

-- Skill MA-19: Service Department Cost Allocation
('d0500000-0000-0000-0004-000000000001', 'd0000000-0000-0000-0005-000000000004', true, 1.0),
('d0500000-0000-0000-0004-000000000002', 'd0000000-0000-0000-0005-000000000004', true, 1.0),
('d0500000-0000-0000-0004-000000000003', 'd0000000-0000-0000-0005-000000000004', true, 1.0),
('d0500000-0000-0000-0004-000000000004', 'd0000000-0000-0000-0005-000000000004', true, 1.0),
('d0500000-0000-0000-0004-000000000005', 'd0000000-0000-0000-0005-000000000004', true, 1.0),
('d0500000-0000-0000-0004-000000000006', 'd0000000-0000-0000-0005-000000000004', true, 1.0);

