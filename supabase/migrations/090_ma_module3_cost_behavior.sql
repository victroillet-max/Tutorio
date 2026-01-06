-- ============================================
-- Module 3: Cost Behavior Activities
-- 4 Skills: Variable, Fixed, Mixed/High-Low, Contribution Margin
-- ~21 Activities with comprehensive content
-- ============================================

-- Clean up existing data to avoid conflicts
DELETE FROM activity_skills WHERE activity_id IN (
  SELECT id FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000003'
);
DELETE FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000003';

-- ============================================
-- SKILL: Variable Costs (MA-07)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 3.1.1: Understanding Variable Costs
(
  'd0300000-0000-0000-0001-000000000001',
  'd0000000-0000-0000-0000-000000000003',
  '3.1.1',
  1,
  'Understanding Variable Costs',
  'understanding-variable-costs',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Understanding Variable Costs\n\n## What Are Variable Costs?\n\nVariable costs **change in total** proportionally with the activity level, but **remain constant per unit**.\n\n---\n\n## The Two Key Behaviors\n\n### In Total\n- Increases as activity increases\n- Decreases as activity decreases\n- Changes proportionally with volume\n\n### Per Unit\n- Stays the same regardless of volume\n- Example: CHF 5 per room night = CHF 5 whether you sell 1 room or 100 rooms\n\n---\n\n## Visual Representation\n\n```\nTotal Variable Cost          Variable Cost Per Unit\n        |\n     $  |      /              $  |------------\n        |    /                    |\n        |  /                      |\n        |/______ Units            |_________ Units\n```\n\n**Total**: Diagonal line from origin\n**Per Unit**: Horizontal line\n\n---\n\n## Common Variable Costs in Hospitality\n\n| Cost | Varies With | Example Rate |\n|------|-------------|-------------|\n| Guest amenities | Room nights | CHF 8/room |\n| Food ingredients | Meals served | CHF 12/meal |\n| Laundry costs | Rooms occupied | CHF 6/room |\n| Credit card fees | Revenue | 2.5% of sales |\n| Server wages | Hours worked | CHF 25/hour |\n| Beverages | Drinks sold | CHF 3/drink |\n\n---\n\n## Variable Cost Formula\n\n$$\\text{Total Variable Cost} = \\text{Variable Cost per Unit} \\times \\text{Number of Units}$$\n\n### Example:\n- Variable cost per room: CHF 15\n- Rooms sold: 200\n- Total variable cost: CHF 15 x 200 = CHF 3,000\n\n---\n\n## The Relevant Range\n\n:::concept{title=\"Relevant Range\"}\nThe range of activity within which cost behavior assumptions are valid.\n\nOutside this range:\n- You might need to hire more staff (step increase)\n- You might get volume discounts (decreasing per unit cost)\n:::\n\n---\n\n## Hotel Occupancy Example\n\n**Mountain View Hotel**\n- Variable cost per occupied room: CHF 22\n- (Amenities CHF 8 + Laundry CHF 6 + Cleaning supplies CHF 4 + Utilities CHF 4)\n\n| Occupancy | Rooms Occupied | Total Variable Cost | Per Room |\n|-----------|----------------|--------------------|---------|\n| 20% | 40 | CHF 880 | CHF 22 |\n| 50% | 100 | CHF 2,200 | CHF 22 |\n| 80% | 160 | CHF 3,520 | CHF 22 |\n| 100% | 200 | CHF 4,400 | CHF 22 |\n\n**Notice**: Total changes, per unit stays constant.\n\n---\n\n:::takeaways\n- Variable costs change in TOTAL with activity\n- Variable costs stay CONSTANT per unit\n- Examples: materials, supplies, commissions\n- Total VC = Rate per unit x Units\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.1.2: Variable Cost Identification Quiz
(
  'd0300000-0000-0000-0001-000000000002',
  'd0000000-0000-0000-0000-000000000003',
  '3.1.2',
  2,
  'Variable Cost Identification Quiz',
  'variable-cost-identification-quiz',
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
        "question": "A variable cost is one that:",
        "options": ["Stays constant in total", "Changes per unit with volume", "Changes in total with volume", "Is always direct"],
        "correct": 2,
        "explanation": "Variable costs change in total as activity level changes, but remain constant per unit."
      },
      {
        "id": "q2",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Variable cost per unit increases as production volume increases.",
        "correct": false,
        "explanation": "False. Variable cost per unit remains CONSTANT regardless of volume."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If variable cost is CHF 8 per unit and 500 units are produced, total variable cost is:",
        "options": ["CHF 8", "CHF 500", "CHF 4,000", "CHF 62.50"],
        "correct": 2,
        "explanation": "Total VC = CHF 8 x 500 = CHF 4,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which is most likely a VARIABLE cost for a hotel?",
        "options": ["Property insurance", "Manager salary", "Guest toiletries", "Annual software license"],
        "correct": 2,
        "explanation": "Guest toiletries vary directly with the number of guests/rooms occupied."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A restaurant''s food cost is typically:",
        "options": ["A fixed cost", "A variable cost", "A period cost only", "An indirect cost only"],
        "correct": 1,
        "explanation": "Food cost varies directly with the number of meals served - a classic variable cost."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Total variable costs are CHF 15,000 for 3,000 units. For 5,000 units, total variable costs would be:",
        "options": ["CHF 15,000", "CHF 25,000", "CHF 9,000", "CHF 3.00"],
        "correct": 1,
        "explanation": "VC per unit = 15,000/3,000 = CHF 5. At 5,000 units: CHF 5 x 5,000 = CHF 25,000"
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The graph of total variable costs shows a:",
        "options": ["Horizontal line", "Downward sloping line", "Straight line from origin", "Curved line"],
        "correct": 2,
        "explanation": "Total variable costs graph shows a straight line starting from the origin."
      },
      {
        "id": "q8",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Sales commissions paid as a percentage of revenue are variable costs.",
        "correct": true,
        "explanation": "True. Commissions increase proportionally with sales - a classic variable cost."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.1.3: Graph Interpretation Interactive
(
  'd0300000-0000-0000-0001-000000000003',
  'd0000000-0000-0000-0000-000000000003',
  '3.1.3',
  3,
  'Cost Behavior Graphs',
  'cost-behavior-graphs',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Match each graph description to the correct cost type.",
    "pairs": [
      {"left": "Horizontal line (Total Cost)", "right": "Fixed Cost"},
      {"left": "Line from origin - upward slope (Total Cost)", "right": "Variable Cost"},
      {"left": "Horizontal line (Cost Per Unit)", "right": "Variable Cost Per Unit"},
      {"left": "Downward curving line (Cost Per Unit)", "right": "Fixed Cost Per Unit"},
      {"left": "Starts above zero with upward slope (Total Cost)", "right": "Mixed Cost"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 3.1.4: Hotel Occupancy Costs Practice
(
  'd0300000-0000-0000-0001-000000000004',
  'd0000000-0000-0000-0000-000000000003',
  '3.1.4',
  4,
  'Hotel Occupancy Variable Costs',
  'hotel-occupancy-variable-costs',
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
        "question": "A hotel has variable costs of CHF 18 per occupied room. At 75% occupancy (150 rooms), total variable costs are:",
        "options": ["CHF 1,350", "CHF 2,700", "CHF 3,600", "CHF 18"],
        "correct": 1,
        "explanation": "Total VC = CHF 18 x 150 rooms = CHF 2,700"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If occupancy increases from 150 to 180 rooms, variable costs will:",
        "options": ["Stay the same", "Increase by CHF 540", "Decrease", "Double"],
        "correct": 1,
        "explanation": "Increase = 30 more rooms x CHF 18 = CHF 540"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Total variable costs are CHF 4,500 at 250 rooms. What is the variable cost per room?",
        "options": ["CHF 4,500", "CHF 250", "CHF 18", "CHF 1,125"],
        "correct": 2,
        "explanation": "VC per room = CHF 4,500 / 250 = CHF 18"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel has 200 rooms. Variable cost is CHF 20/room. At 80% occupancy, what''s the variable cost per available room?",
        "options": ["CHF 20", "CHF 16", "CHF 25", "CHF 12.50"],
        "correct": 1,
        "explanation": "160 rooms occupied x CHF 20 = CHF 3,200 total. Per available room: CHF 3,200/200 = CHF 16"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "If a hotel has zero occupancy, total variable costs will be zero.",
        "correct": true,
        "explanation": "True. Variable costs only occur when there is activity (rooms sold)."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.1.5: Variable Costs Checkpoint
(
  'd0300000-0000-0000-0001-000000000005',
  'd0000000-0000-0000-0000-000000000003',
  '3.1.5',
  5,
  'Variable Costs Checkpoint',
  'variable-costs-checkpoint',
  'checkpoint',
  8,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Variable costs per unit _____ as activity increases.",
        "options": ["Increase", "Decrease", "Stay constant", "Vary randomly"],
        "correct": 2,
        "explanation": "Variable cost per unit remains constant regardless of activity level."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Which formula correctly calculates total variable cost?",
        "options": ["Fixed costs / units", "Variable rate + units", "Variable rate x units", "Total costs - fixed costs x 2"],
        "correct": 2,
        "explanation": "Total Variable Cost = Variable Cost per Unit x Number of Units"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "A restaurant serves 400 meals. Variable cost is CHF 9/meal. Total variable cost is:",
        "options": ["CHF 400", "CHF 3,600", "CHF 44.44", "CHF 9"],
        "correct": 1,
        "explanation": "Total VC = 400 meals x CHF 9 = CHF 3,600"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Credit card processing fees (percentage of sales) are typically variable costs.",
        "correct": true,
        "explanation": "True. These fees vary proportionally with sales volume."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Within the relevant range, total variable costs form what shape on a graph?",
        "options": ["A curve", "A horizontal line", "A straight line through the origin", "A step pattern"],
        "correct": 2,
        "explanation": "Total variable costs graph as a straight line starting from zero."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- Activity 3.2.1: Understanding Fixed Costs
(
  'd0300000-0000-0000-0002-000000000001',
  'd0000000-0000-0000-0000-000000000003',
  '3.2.1',
  6,
  'Understanding Fixed Costs',
  'understanding-fixed-costs',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Understanding Fixed Costs\n\n## What Are Fixed Costs?\n\nFixed costs **remain constant in total** regardless of activity level, but **change per unit** as volume changes.\n\n---\n\n## The Two Key Behaviors\n\n### In Total\n- Stays the same whether activity is high or low\n- Does not change with volume (within relevant range)\n- Example: Rent is CHF 10,000/month regardless of occupancy\n\n### Per Unit\n- Decreases as volume increases (spreading)\n- Increases as volume decreases\n- Example: CHF 10,000 rent / 100 rooms = CHF 100 per room\n\n---\n\n## Visual Representation\n\n```\nTotal Fixed Cost              Fixed Cost Per Unit\n        |\n     $  |--------              $  |\\\n        |                         | \\\n        |                         |  \\\n        |_________ Units          |___\\____ Units\n```\n\n**Total**: Horizontal line\n**Per Unit**: Downward curving line\n\n---\n\n## Types of Fixed Costs\n\n### Committed Fixed Costs\nLong-term, structural costs that are difficult to change in the short term.\n\n| Cost | Example |\n|------|---------|\n| Property rent/mortgage | CHF 50,000/month |\n| Equipment depreciation | CHF 8,000/month |\n| Insurance premiums | CHF 2,000/month |\n| Property taxes | CHF 3,000/month |\n\n### Discretionary Fixed Costs\nManagement decisions that could be changed in the short term.\n\n| Cost | Example |\n|------|---------|\n| Advertising budget | CHF 5,000/month |\n| Training programs | CHF 2,000/month |\n| Research & development | CHF 3,000/month |\n| Consulting fees | CHF 4,000/month |\n\n---\n\n## The Spreading Effect\n\n:::concept{title=\"Fixed Cost Spreading\"}\nAs volume increases, fixed costs are spread over more units, reducing the per-unit fixed cost. This is why high occupancy/volume improves profitability!\n:::\n\n### Example: Hotel Rent of CHF 30,000/month (100 rooms)\n\n| Occupancy | Rooms Sold | Total FC | FC Per Room |\n|-----------|------------|----------|-------------|\n| 20% | 20 | CHF 30,000 | CHF 1,500 |\n| 50% | 50 | CHF 30,000 | CHF 600 |\n| 80% | 80 | CHF 30,000 | CHF 375 |\n| 100% | 100 | CHF 30,000 | CHF 300 |\n\n**Notice**: Total stays constant, per unit decreases.\n\n---\n\n## Common Fixed Costs in Hospitality\n\n| Cost | Type | Amount |\n|------|------|--------|\n| Building rent | Committed | Monthly fixed |\n| Manager salaries | Committed | Monthly fixed |\n| Property insurance | Committed | Annual/monthly |\n| Software licenses | Committed | Annual/monthly |\n| Marketing budget | Discretionary | Set by management |\n| Maintenance contracts | Discretionary | Negotiable |\n\n---\n\n:::takeaways\n- Fixed costs stay CONSTANT in total\n- Fixed costs DECREASE per unit as volume increases\n- Two types: Committed (hard to change) and Discretionary (can adjust)\n- High volume spreads fixed costs over more units\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.2.2: Fixed Cost Characteristics Quiz
(
  'd0300000-0000-0000-0002-000000000002',
  'd0000000-0000-0000-0000-000000000003',
  '3.2.2',
  7,
  'Fixed Cost Characteristics Quiz',
  'fixed-cost-characteristics-quiz',
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
        "question": "A fixed cost is one that:",
        "options": ["Changes in total with volume", "Stays constant per unit", "Stays constant in total", "Varies with production"],
        "correct": 2,
        "explanation": "Fixed costs remain constant in total regardless of activity level."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "As production volume increases, fixed cost per unit:",
        "options": ["Increases", "Decreases", "Stays the same", "Doubles"],
        "correct": 1,
        "explanation": "Fixed cost per unit decreases as volume increases (spreading effect)."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which is most likely a FIXED cost for a hotel?",
        "options": ["Food ingredients", "Guest toiletries", "Property insurance", "Laundry per room"],
        "correct": 2,
        "explanation": "Property insurance is a set annual/monthly amount regardless of occupancy."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Fixed costs are CHF 50,000/month. At 1,000 units, fixed cost per unit is:",
        "options": ["CHF 50,000", "CHF 1,000", "CHF 50", "CHF 0"],
        "correct": 2,
        "explanation": "Fixed cost per unit = CHF 50,000 / 1,000 = CHF 50"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If volume doubles from 1,000 to 2,000 units, fixed cost per unit becomes:",
        "options": ["CHF 100", "CHF 50", "CHF 25", "CHF 12.50"],
        "correct": 2,
        "explanation": "CHF 50,000 / 2,000 = CHF 25 per unit"
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Committed fixed costs can easily be changed in the short term.",
        "correct": false,
        "explanation": "False. Committed fixed costs (like leases, mortgages) are long-term and difficult to change quickly."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "An advertising budget is typically what type of fixed cost?",
        "options": ["Committed", "Discretionary", "Variable", "Mixed"],
        "correct": 1,
        "explanation": "Advertising budgets are discretionary - they can be adjusted by management decision."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "The graph of total fixed costs shows a:",
        "options": ["Line from origin", "Downward sloping line", "Horizontal line", "Curved line"],
        "correct": 2,
        "explanation": "Total fixed costs graph as a horizontal line - the same at all activity levels."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.2.3: Fixed Cost Graphing Interactive
(
  'd0300000-0000-0000-0002-000000000003',
  'd0000000-0000-0000-0000-000000000003',
  '3.2.3',
  8,
  'Fixed Cost Graphing',
  'fixed-cost-graphing',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Place each statement in the correct category for Fixed Costs.",
    "categories": ["True for Fixed Costs", "False for Fixed Costs"],
    "items": [
      {"text": "Total cost stays the same as volume changes", "category": "True for Fixed Costs"},
      {"text": "Cost per unit stays the same as volume changes", "category": "False for Fixed Costs"},
      {"text": "Property rent is an example", "category": "True for Fixed Costs"},
      {"text": "Food ingredients is an example", "category": "False for Fixed Costs"},
      {"text": "Higher volume means lower cost per unit", "category": "True for Fixed Costs"},
      {"text": "Total cost is zero when volume is zero", "category": "False for Fixed Costs"},
      {"text": "Manager salary is typically this type", "category": "True for Fixed Costs"},
      {"text": "Commission payments are this type", "category": "False for Fixed Costs"}
    ]
  }'::jsonb,
  'category-sort',
  false,
  true
),

-- Activity 3.2.4: Hotel Lease Analysis Practice
(
  'd0300000-0000-0000-0002-000000000004',
  'd0000000-0000-0000-0000-000000000003',
  '3.2.4',
  9,
  'Hotel Lease Analysis',
  'hotel-lease-analysis',
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
        "question": "Hotel rent is CHF 60,000/month. At 60% occupancy (180 rooms), rent per occupied room is:",
        "options": ["CHF 60,000", "CHF 333.33", "CHF 200", "CHF 100"],
        "correct": 1,
        "explanation": "CHF 60,000 / 180 rooms = CHF 333.33 per occupied room"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If occupancy increases to 90% (270 rooms), rent per occupied room becomes:",
        "options": ["CHF 333.33", "CHF 222.22", "CHF 200", "CHF 66.67"],
        "correct": 1,
        "explanation": "CHF 60,000 / 270 rooms = CHF 222.22 per occupied room"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel has CHF 100,000 monthly fixed costs. To achieve CHF 200 fixed cost per room, how many rooms must be sold?",
        "options": ["200 rooms", "500 rooms", "1,000 rooms", "50 rooms"],
        "correct": 1,
        "explanation": "Rooms needed = CHF 100,000 / CHF 200 = 500 rooms"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "applied",
        "question": "If occupancy is zero, the hotel still pays its fixed costs.",
        "correct": true,
        "explanation": "True. Fixed costs must be paid regardless of business activity."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Fixed costs CHF 80,000, rooms sold 400, selling price CHF 300. If rooms increase to 500, profit will increase because:",
        "options": ["Fixed costs decrease", "Fixed cost per room decreases", "Variable costs increase", "Selling price increases"],
        "correct": 1,
        "explanation": "The same fixed costs spread over more rooms reduces fixed cost per room."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.2.5: Fixed Costs Checkpoint
(
  'd0300000-0000-0000-0002-000000000005',
  'd0000000-0000-0000-0000-000000000003',
  '3.2.5',
  10,
  'Fixed Costs Checkpoint',
  'fixed-costs-checkpoint',
  'checkpoint',
  8,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Total fixed costs of CHF 45,000 at 900 units means fixed cost per unit is:",
        "options": ["CHF 45,000", "CHF 900", "CHF 50", "CHF 20"],
        "correct": 2,
        "explanation": "FC per unit = CHF 45,000 / 900 = CHF 50"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "If production increases from 900 to 1,500 units with the same fixed costs, per-unit fixed cost is:",
        "options": ["CHF 50", "CHF 30", "CHF 75", "CHF 45,000"],
        "correct": 1,
        "explanation": "FC per unit = CHF 45,000 / 1,500 = CHF 30"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Equipment depreciation is typically a:",
        "options": ["Variable cost", "Committed fixed cost", "Discretionary fixed cost", "Mixed cost"],
        "correct": 1,
        "explanation": "Depreciation on major equipment is committed - cannot easily change it."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "The relevant range is the span of activity where cost behavior assumptions hold true.",
        "correct": true,
        "explanation": "True. Outside the relevant range, fixed costs might change (e.g., need new equipment)."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "A hotel wants to reduce fixed costs. Which would be easiest to cut in the short term?",
        "options": ["Building mortgage", "Property taxes", "Marketing budget", "Equipment depreciation"],
        "correct": 2,
        "explanation": "Marketing budget is discretionary and can be adjusted more easily than committed costs."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- Activity 3.3.1: Mixed Costs and High-Low Method
(
  'd0300000-0000-0000-0003-000000000001',
  'd0000000-0000-0000-0000-000000000003',
  '3.3.1',
  11,
  'Mixed Costs and High-Low Method',
  'mixed-costs-high-low-method',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Mixed Costs and High-Low Method\n\n## What Are Mixed Costs?\n\nMixed costs (also called semi-variable costs) contain **both fixed and variable components**.\n\n---\n\n## Mixed Cost Formula\n\n$$\\text{Total Mixed Cost} = \\text{Fixed Component} + (\\text{Variable Rate} \\times \\text{Activity})$$\n\nOr in equation form:\n\n$$Y = a + bX$$\n\nWhere:\n- Y = Total cost\n- a = Fixed component (intercept)\n- b = Variable rate per unit (slope)\n- X = Activity level\n\n---\n\n## Common Mixed Costs in Hospitality\n\n| Cost | Fixed Component | Variable Component |\n|------|----------------|-------------------|\n| Utilities | Base charge | Usage-based rate |\n| Phone/Internet | Monthly fee | Per-call/usage |\n| Maintenance | Contract fee | Parts and labor |\n| Car rental | Base fee | Per-km charge |\n| Staffing agency | Retainer | Per-hour rate |\n\n---\n\n## The High-Low Method\n\nA technique to separate mixed costs into fixed and variable components using just **two data points**: the highest and lowest activity levels.\n\n### Step-by-Step Process\n\n**Step 1**: Identify the HIGH and LOW activity points (not costs!)\n\n**Step 2**: Calculate the variable rate\n$$\\text{Variable Rate} = \\frac{\\text{Cost at High} - \\text{Cost at Low}}{\\text{High Activity} - \\text{Low Activity}}$$\n\n**Step 3**: Calculate the fixed component\n$$\\text{Fixed} = \\text{Total Cost} - (\\text{Variable Rate} \\times \\text{Activity})$$\n\n---\n\n## High-Low Method Example\n\n**Hotel Utility Data (6 months)**\n\n| Month | Rooms Occupied | Utility Cost |\n|-------|---------------|-------------|\n| Jan | 1,200 | CHF 8,400 |\n| Feb | 1,500 | CHF 9,900 |\n| Mar | 1,800 | CHF 11,400 |\n| Apr | 2,100 | CHF 12,900 |\n| May | 2,400 | CHF 14,400 |\n| Jun | 2,000 | CHF 12,400 |\n\n### Step 1: Find High and Low ACTIVITY Points\n- **High**: May - 2,400 rooms, CHF 14,400\n- **Low**: Jan - 1,200 rooms, CHF 8,400\n\n### Step 2: Calculate Variable Rate\n$$b = \\frac{14,400 - 8,400}{2,400 - 1,200} = \\frac{6,000}{1,200} = \\text{CHF 5 per room}$$\n\n### Step 3: Calculate Fixed Component\nUsing the high point:\n$$a = 14,400 - (5 \\times 2,400) = 14,400 - 12,000 = \\text{CHF 2,400}$$\n\n### The Cost Formula\n$$\\text{Total Utility Cost} = \\text{CHF 2,400} + (\\text{CHF 5} \\times \\text{Rooms})$$\n\n---\n\n## Verify the Formula\n\nCheck with February data:\n- Expected: CHF 2,400 + (CHF 5 x 1,500) = CHF 2,400 + CHF 7,500 = CHF 9,900\n- Actual: CHF 9,900\n\n---\n\n## Limitations of High-Low Method\n\n:::concept{title=\"High-Low Limitations\"}\n- Only uses two data points (ignores others)\n- Assumes perfectly linear relationship\n- Outliers can distort results\n- Better methods: Regression analysis, scatter plots\n:::\n\n---\n\n:::takeaways\n- Mixed costs have both fixed and variable components\n- Formula: Y = a + bX (or Total = Fixed + Variable x Activity)\n- High-Low method uses extreme activity points to separate costs\n- Calculate variable rate first, then fixed component\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.3.2: High-Low Calculator Interactive
(
  'd0300000-0000-0000-0003-000000000002',
  'd0000000-0000-0000-0000-000000000003',
  '3.3.2',
  12,
  'High-Low Calculator',
  'high-low-calculator',
  'interactive',
  8,
  30,
  'basic',
  '{
    "instructions": "Put the High-Low Method steps in the correct order.",
    "sequence": [
      "Identify the highest and lowest ACTIVITY levels",
      "Note the costs at those two activity levels",
      "Calculate: Variable Rate = (High Cost - Low Cost) / (High Activity - Low Activity)",
      "Use either point to calculate: Fixed = Total Cost - (Variable Rate x Activity)",
      "Write the cost equation: Y = Fixed + (Variable Rate x X)",
      "Verify by testing with another data point"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

-- Activity 3.3.3: Mixed Cost Analysis Quiz
(
  'd0300000-0000-0000-0003-000000000003',
  'd0000000-0000-0000-0000-000000000003',
  '3.3.3',
  13,
  'Mixed Cost Analysis Quiz',
  'mixed-cost-analysis-quiz',
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
        "question": "A mixed cost contains:",
        "options": ["Only fixed components", "Only variable components", "Both fixed and variable components", "Neither fixed nor variable"],
        "correct": 2,
        "explanation": "Mixed costs contain both a fixed component and a variable component."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "High activity: 1,000 units, CHF 8,000. Low activity: 400 units, CHF 5,000. Variable rate is:",
        "options": ["CHF 5.00", "CHF 8.00", "CHF 3.00", "CHF 12.50"],
        "correct": 0,
        "explanation": "Variable rate = (8,000 - 5,000) / (1,000 - 400) = 3,000 / 600 = CHF 5.00"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Using the same data (variable rate CHF 5), the fixed cost is:",
        "options": ["CHF 3,000", "CHF 5,000", "CHF 8,000", "CHF 2,000"],
        "correct": 0,
        "explanation": "Using low point: Fixed = 5,000 - (5 x 400) = 5,000 - 2,000 = CHF 3,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "With Fixed CHF 3,000 and Variable CHF 5/unit, cost at 700 units is:",
        "options": ["CHF 3,500", "CHF 6,500", "CHF 7,000", "CHF 3,700"],
        "correct": 1,
        "explanation": "Total = 3,000 + (5 x 700) = 3,000 + 3,500 = CHF 6,500"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "In the high-low method, you use the highest and lowest COST points.",
        "correct": false,
        "explanation": "False. You use the highest and lowest ACTIVITY points, then look at costs at those levels."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which is a limitation of the high-low method?",
        "options": ["It''s too complex", "It uses only two data points", "It cannot find fixed costs", "It only works for variable costs"],
        "correct": 1,
        "explanation": "The high-low method only uses two points, ignoring all other data which may be relevant."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.3.4: Utility Cost Analysis Practice
(
  'd0300000-0000-0000-0003-000000000004',
  'd0000000-0000-0000-0000-000000000003',
  '3.3.4',
  14,
  'Utility Cost Analysis',
  'utility-cost-analysis',
  'lesson',
  10,
  30,
  'basic',
  '{"markdown": "# Utility Cost Analysis\n\n## Mountain Lodge Utility Study\n\nMountain Lodge wants to understand their electricity costs, which appear to be mixed.\n\n---\n\n## Data Collection (Past 8 Months)\n\n| Month | Guest Nights | Electricity |\n|-------|-------------|-------------|\n| Jan | 800 | CHF 5,600 |\n| Feb | 1,000 | CHF 6,400 |\n| Mar | 1,200 | CHF 7,200 |\n| Apr | 1,400 | CHF 8,000 |\n| May | 1,600 | CHF 8,800 |\n| Jun | 1,800 | CHF 9,600 |\n| Jul | 2,000 | CHF 10,400 |\n| Aug | 1,500 | CHF 8,400 |\n\n---\n\n## High-Low Analysis\n\n### Step 1: Identify Extremes\n- **High Activity**: July - 2,000 guest nights, CHF 10,400\n- **Low Activity**: January - 800 guest nights, CHF 5,600\n\n### Step 2: Calculate Variable Rate\n$$b = \\frac{10,400 - 5,600}{2,000 - 800} = \\frac{4,800}{1,200} = \\text{CHF 4 per guest night}$$\n\n### Step 3: Calculate Fixed Cost\nUsing January:\n$$a = 5,600 - (4 \\times 800) = 5,600 - 3,200 = \\text{CHF 2,400}$$\n\n---\n\n## The Cost Equation\n\n$$\\text{Electricity Cost} = \\text{CHF 2,400} + (\\text{CHF 4} \\times \\text{Guest Nights})$$\n\n---\n\n## Interpretation\n\n- **Fixed Component (CHF 2,400)**: Base charges, standby equipment, minimum usage\n- **Variable Component (CHF 4/guest)**: HVAC, lighting, guest amenity usage\n\n---\n\n## Verification\n\n| Month | Guest Nights | Predicted Cost | Actual | Difference |\n|-------|-------------|---------------|--------|------------|\n| Feb | 1,000 | 2,400 + 4,000 = 6,400 | 6,400 | 0 |\n| Apr | 1,400 | 2,400 + 5,600 = 8,000 | 8,000 | 0 |\n| Aug | 1,500 | 2,400 + 6,000 = 8,400 | 8,400 | 0 |\n\n---\n\n## Forecasting Future Costs\n\nExpected September: 1,700 guest nights\n\n$$\\text{Predicted Cost} = 2,400 + (4 \\times 1,700) = 2,400 + 6,800 = \\text{CHF 9,200}$$\n\n---\n\n:::takeaways\n- Real utility costs often have both fixed and variable components\n- High-low method provides a quick estimate of cost behavior\n- The cost equation can forecast future costs\n- Verify predictions against actual data when available\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.3.5: Hotel Maintenance Costs Applied
(
  'd0300000-0000-0000-0003-000000000005',
  'd0000000-0000-0000-0000-000000000003',
  '3.3.5',
  15,
  'Hotel Maintenance Costs',
  'hotel-maintenance-costs',
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
        "question": "High: 3,000 rooms, CHF 21,000 maintenance. Low: 1,000 rooms, CHF 11,000. Variable rate per room is:",
        "options": ["CHF 5", "CHF 7", "CHF 10", "CHF 11"],
        "correct": 0,
        "explanation": "Variable = (21,000 - 11,000) / (3,000 - 1,000) = 10,000 / 2,000 = CHF 5"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Using the same data, the fixed maintenance cost is:",
        "options": ["CHF 5,000", "CHF 6,000", "CHF 11,000", "CHF 21,000"],
        "correct": 1,
        "explanation": "Using low: Fixed = 11,000 - (5 x 1,000) = 11,000 - 5,000 = CHF 6,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "With the cost equation Y = 6,000 + 5X, predict maintenance at 2,500 rooms:",
        "options": ["CHF 12,500", "CHF 18,500", "CHF 6,000", "CHF 11,000"],
        "correct": 1,
        "explanation": "Y = 6,000 + (5 x 2,500) = 6,000 + 12,500 = CHF 18,500"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "applied",
        "question": "The fixed component of maintenance could represent a maintenance contract base fee.",
        "correct": true,
        "explanation": "True. Fixed portions often represent base fees, salaries, or minimum contract amounts."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If actual maintenance at 2,200 rooms is CHF 17,200 but predicted is CHF 17,000, this suggests:",
        "options": ["The model is perfect", "Actual was slightly higher than expected", "Variable rate is wrong", "Fixed costs decreased"],
        "correct": 1,
        "explanation": "CHF 200 variance (17,200 - 17,000) shows actual slightly exceeded the prediction."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.3.6: Mixed Costs Checkpoint
(
  'd0300000-0000-0000-0003-000000000006',
  'd0000000-0000-0000-0000-000000000003',
  '3.3.6',
  16,
  'Mixed Costs and High-Low Checkpoint',
  'mixed-costs-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The cost equation Y = a + bX represents:",
        "options": ["Variable costs only", "Fixed costs only", "Mixed costs", "Period costs"],
        "correct": 2,
        "explanation": "Y = a + bX shows fixed (a) plus variable (b times X) components."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "In the high-low method, the variable rate is calculated as:",
        "options": ["High cost / Low cost", "Change in cost / Change in activity", "Fixed + Variable", "Total cost / Units"],
        "correct": 1,
        "explanation": "Variable rate = (Cost at High - Cost at Low) / (High Activity - Low Activity)"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "High: 500 units, CHF 7,500. Low: 200 units, CHF 4,500. Variable rate is:",
        "options": ["CHF 10", "CHF 15", "CHF 22.50", "CHF 7.50"],
        "correct": 0,
        "explanation": "Variable = (7,500 - 4,500) / (500 - 200) = 3,000 / 300 = CHF 10"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "With variable rate CHF 10 and low point (200, 4,500), fixed cost is:",
        "options": ["CHF 2,000", "CHF 2,500", "CHF 4,500", "CHF 5,500"],
        "correct": 1,
        "explanation": "Fixed = 4,500 - (10 x 200) = 4,500 - 2,000 = CHF 2,500"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Using Y = 2,500 + 10X, what is total cost at 350 units?",
        "options": ["CHF 3,500", "CHF 6,000", "CHF 5,000", "CHF 6,500"],
        "correct": 1,
        "explanation": "Y = 2,500 + (10 x 350) = 2,500 + 3,500 = CHF 6,000"
      },
      {
        "id": "cp6",
        "type": "true_false",
        "question": "The high-low method is highly accurate because it uses all available data.",
        "correct": false,
        "explanation": "False. The high-low method uses only two points, which is a limitation."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- Activity 3.4.1: Contribution Margin Income Statement
(
  'd0300000-0000-0000-0004-000000000001',
  'd0000000-0000-0000-0000-000000000003',
  '3.4.1',
  17,
  'Contribution Margin Income Statement',
  'contribution-margin-income-statement',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Contribution Margin Income Statement\n\n## What is Contribution Margin?\n\nThe amount remaining after variable costs are deducted from sales, available to **contribute** toward covering fixed costs and generating profit.\n\n---\n\n## Contribution Margin Formula\n\n$$\\text{Contribution Margin} = \\text{Sales} - \\text{Variable Costs}$$\n\n### Per Unit:\n$$\\text{CM per Unit} = \\text{Selling Price} - \\text{Variable Cost per Unit}$$\n\n### As a Ratio:\n$$\\text{CM Ratio} = \\frac{\\text{Contribution Margin}}{\\text{Sales}} = \\frac{\\text{CM per Unit}}{\\text{Selling Price}}$$\n\n---\n\n## The CM Income Statement Format\n\n```\n                        Total       Per Unit     %\nSales (1,000 units)     CHF 50,000  CHF 50      100%\nLess: Variable Costs    (30,000)    (30)        (60%)\n                        ----------  -------     -----\nContribution Margin      20,000     CHF 20       40%\nLess: Fixed Costs       (15,000)\n                        ----------\nNet Operating Income    CHF 5,000\n```\n\n---\n\n## Key Relationships\n\n### Contribution Margin Per Unit\n- Each unit sold contributes CHF 20 toward fixed costs and profit\n- After selling 750 units (CHF 15,000 CM), fixed costs are covered\n- Each additional unit adds CHF 20 directly to profit\n\n### Contribution Margin Ratio\n- 40% of each sales dollar contributes to covering fixed costs\n- Useful for analyzing changes in sales dollars\n\n---\n\n## CM vs Traditional Income Statement\n\n| Traditional Format | CM Format |\n|-------------------|----------|\n| Sales | Sales |\n| - Cost of Goods Sold | - Variable Costs |\n| = Gross Profit | = Contribution Margin |\n| - Operating Expenses | - Fixed Costs |\n| = Net Income | = Net Operating Income |\n\nThe CM format **separates by behavior** (variable vs fixed) rather than by function.\n\n---\n\n## Hotel Restaurant Example\n\n**Edelweiss Restaurant (200 covers)**\n\n| Item | Total | Per Cover | % |\n|------|-------|-----------|---|\n| Revenue | CHF 18,000 | CHF 90 | 100% |\n| Variable Costs: | | | |\n| - Food costs | (5,400) | (27) | 30% |\n| - Variable labor | (2,700) | (13.50) | 15% |\n| - Supplies | (900) | (4.50) | 5% |\n| = Contribution Margin | CHF 9,000 | CHF 45 | 50% |\n| Fixed Costs | (7,000) | | |\n| = Net Operating Income | CHF 2,000 | | |\n\n---\n\n## Using CM for Decisions\n\n### Question: What if we serve 50 more covers?\n\n- Each cover contributes CHF 45\n- Additional 50 covers = 50 x CHF 45 = CHF 2,250 more contribution margin\n- Fixed costs don''t change\n- Profit increases by CHF 2,250\n\n---\n\n:::takeaways\n- CM = Sales - Variable Costs\n- CM Format separates costs by behavior\n- CM per unit shows contribution of each sale\n- CM ratio shows percentage of sales contributing to coverage\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.4.2: Contribution Margin Concepts Quiz
(
  'd0300000-0000-0000-0004-000000000002',
  'd0000000-0000-0000-0000-000000000003',
  '3.4.2',
  18,
  'Contribution Margin Concepts Quiz',
  'contribution-margin-concepts-quiz',
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
        "question": "Contribution margin is calculated as:",
        "options": ["Sales - Fixed costs", "Sales - Variable costs", "Sales - All costs", "Fixed costs - Variable costs"],
        "correct": 1,
        "explanation": "Contribution Margin = Sales - Variable Costs"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Selling price CHF 80, variable cost CHF 50. Contribution margin per unit is:",
        "options": ["CHF 80", "CHF 50", "CHF 30", "CHF 130"],
        "correct": 2,
        "explanation": "CM per unit = CHF 80 - CHF 50 = CHF 30"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "With CM of CHF 30 and selling price CHF 80, the CM ratio is:",
        "options": ["30%", "37.5%", "62.5%", "80%"],
        "correct": 1,
        "explanation": "CM ratio = 30/80 = 0.375 = 37.5%"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Sales CHF 100,000, variable costs CHF 60,000, fixed costs CHF 25,000. Net income is:",
        "options": ["CHF 40,000", "CHF 15,000", "CHF 75,000", "CHF 35,000"],
        "correct": 1,
        "explanation": "CM = 100,000 - 60,000 = 40,000. Net income = 40,000 - 25,000 = CHF 15,000"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The CM format income statement organizes costs by function (production vs selling).",
        "correct": false,
        "explanation": "False. The CM format organizes costs by BEHAVIOR (variable vs fixed)."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If a hotel sells one more room with CM of CHF 120, and fixed costs don''t change, profit increases by:",
        "options": ["CHF 0", "CHF 120", "More than CHF 120", "Less than CHF 120"],
        "correct": 1,
        "explanation": "Each additional unit above break-even adds its full CM to profit."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "CM ratio is 45%. If sales increase by CHF 10,000, contribution margin increases by:",
        "options": ["CHF 4,500", "CHF 5,500", "CHF 10,000", "CHF 45,000"],
        "correct": 0,
        "explanation": "CM increase = Sales increase x CM ratio = CHF 10,000 x 45% = CHF 4,500"
      },
      {
        "id": "q8",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A high contribution margin ratio means a company can cover fixed costs faster.",
        "correct": true,
        "explanation": "True. Higher CM ratio means more of each sales dollar goes toward covering fixed costs and profit."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.4.3: CM Statement Builder Interactive
(
  'd0300000-0000-0000-0004-000000000003',
  'd0000000-0000-0000-0000-000000000003',
  '3.4.3',
  19,
  'CM Statement Builder',
  'cm-statement-builder',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Arrange these items in the correct order for a Contribution Margin Income Statement.",
    "sequence": [
      "Sales Revenue",
      "Less: Variable Costs",
      "Equals: Contribution Margin",
      "Less: Fixed Costs",
      "Equals: Net Operating Income"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

-- Activity 3.4.4: Restaurant CM Analysis Practice
(
  'd0300000-0000-0000-0004-000000000004',
  'd0000000-0000-0000-0000-000000000003',
  '3.4.4',
  20,
  'Restaurant CM Analysis',
  'restaurant-cm-analysis',
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
        "question": "A dish sells for CHF 35. Food cost is CHF 10, variable labor CHF 5. CM per dish is:",
        "options": ["CHF 10", "CHF 15", "CHF 20", "CHF 25"],
        "correct": 2,
        "explanation": "CM = 35 - 10 - 5 = CHF 20"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "With CM of CHF 20 and price of CHF 35, the CM ratio is approximately:",
        "options": ["35%", "43%", "57%", "67%"],
        "correct": 2,
        "explanation": "CM ratio = 20/35 = 0.571 = approximately 57%"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Restaurant serves 300 covers. CM per cover CHF 22. Fixed costs CHF 5,000. Net income is:",
        "options": ["CHF 1,600", "CHF 6,600", "CHF 5,000", "CHF 11,600"],
        "correct": 0,
        "explanation": "Total CM = 300 x 22 = 6,600. Net income = 6,600 - 5,000 = CHF 1,600"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If the restaurant adds 100 covers, profit will increase by:",
        "options": ["CHF 1,600", "CHF 2,200", "CHF 3,500", "CHF 100"],
        "correct": 1,
        "explanation": "100 additional covers x CHF 22 CM = CHF 2,200 additional profit"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A menu item with a 60% CM ratio is more profitable per dollar than one with 40% CM ratio.",
        "correct": true,
        "explanation": "True. Higher CM ratio means more contribution per sales dollar."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.4.5: Contribution Margin Checkpoint
(
  'd0300000-0000-0000-0004-000000000005',
  'd0000000-0000-0000-0000-000000000003',
  '3.4.5',
  21,
  'Contribution Margin Format Checkpoint',
  'contribution-margin-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The contribution margin income statement classifies costs by:",
        "options": ["Function", "Behavior", "Department", "Time period"],
        "correct": 1,
        "explanation": "CM format classifies costs as variable or fixed (behavior-based)."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Sales CHF 200,000, Variable costs CHF 120,000. Contribution margin is:",
        "options": ["CHF 320,000", "CHF 200,000", "CHF 120,000", "CHF 80,000"],
        "correct": 3,
        "explanation": "CM = Sales - Variable Costs = 200,000 - 120,000 = CHF 80,000"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "With the same data (CM CHF 80,000, Sales CHF 200,000), the CM ratio is:",
        "options": ["60%", "40%", "80%", "20%"],
        "correct": 1,
        "explanation": "CM ratio = 80,000 / 200,000 = 40%"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "CM CHF 80,000, Fixed costs CHF 55,000. Net Operating Income is:",
        "options": ["CHF 80,000", "CHF 55,000", "CHF 25,000", "CHF 135,000"],
        "correct": 2,
        "explanation": "NOI = CM - Fixed Costs = 80,000 - 55,000 = CHF 25,000"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "If CM ratio is 40% and sales increase by CHF 50,000, what happens to profit (assuming fixed costs unchanged)?",
        "options": ["Increases by CHF 50,000", "Increases by CHF 20,000", "Stays the same", "Decreases by CHF 30,000"],
        "correct": 1,
        "explanation": "Additional CM = 50,000 x 40% = CHF 20,000, all going to profit."
      },
      {
        "id": "cp6",
        "type": "true_false",
        "question": "The contribution margin represents the amount available to cover fixed costs and provide profit.",
        "correct": true,
        "explanation": "True. This is the fundamental definition of contribution margin."
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
-- Skill MA-07: Variable Costs
('d0300000-0000-0000-0001-000000000001', 'd0000000-0000-0000-0003-000000000001', true, 1.0),
('d0300000-0000-0000-0001-000000000002', 'd0000000-0000-0000-0003-000000000001', true, 1.0),
('d0300000-0000-0000-0001-000000000003', 'd0000000-0000-0000-0003-000000000001', true, 1.0),
('d0300000-0000-0000-0001-000000000004', 'd0000000-0000-0000-0003-000000000001', true, 1.0),
('d0300000-0000-0000-0001-000000000005', 'd0000000-0000-0000-0003-000000000001', true, 1.0),

-- Skill MA-08: Fixed Costs
('d0300000-0000-0000-0002-000000000001', 'd0000000-0000-0000-0003-000000000002', true, 1.0),
('d0300000-0000-0000-0002-000000000002', 'd0000000-0000-0000-0003-000000000002', true, 1.0),
('d0300000-0000-0000-0002-000000000003', 'd0000000-0000-0000-0003-000000000002', true, 1.0),
('d0300000-0000-0000-0002-000000000004', 'd0000000-0000-0000-0003-000000000002', true, 1.0),
('d0300000-0000-0000-0002-000000000005', 'd0000000-0000-0000-0003-000000000002', true, 1.0),

-- Skill MA-09: Mixed Costs & High-Low Method
('d0300000-0000-0000-0003-000000000001', 'd0000000-0000-0000-0003-000000000003', true, 1.0),
('d0300000-0000-0000-0003-000000000002', 'd0000000-0000-0000-0003-000000000003', true, 1.0),
('d0300000-0000-0000-0003-000000000003', 'd0000000-0000-0000-0003-000000000003', true, 1.0),
('d0300000-0000-0000-0003-000000000004', 'd0000000-0000-0000-0003-000000000003', true, 1.0),
('d0300000-0000-0000-0003-000000000005', 'd0000000-0000-0000-0003-000000000003', true, 1.0),
('d0300000-0000-0000-0003-000000000006', 'd0000000-0000-0000-0003-000000000003', true, 1.0),

-- Skill MA-10: Contribution Margin Format
('d0300000-0000-0000-0004-000000000001', 'd0000000-0000-0000-0003-000000000004', true, 1.0),
('d0300000-0000-0000-0004-000000000002', 'd0000000-0000-0000-0003-000000000004', true, 1.0),
('d0300000-0000-0000-0004-000000000003', 'd0000000-0000-0000-0003-000000000004', true, 1.0),
('d0300000-0000-0000-0004-000000000004', 'd0000000-0000-0000-0003-000000000004', true, 1.0),
('d0300000-0000-0000-0004-000000000005', 'd0000000-0000-0000-0003-000000000004', true, 1.0);

