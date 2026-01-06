-- ============================================
-- Module 4: CVP Analysis Activities
-- 5 Skills: Break-Even, Target Profit, Margin of Safety, Operating Leverage, Sales Mix
-- ~28 Activities with comprehensive content
-- ============================================

-- Clean up existing data to avoid conflicts
DELETE FROM activity_skills WHERE activity_id IN (
  SELECT id FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000004'
);
DELETE FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000004';

-- ============================================
-- SKILL: Break-Even Analysis (MA-11)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 4.1.1: Finding the Break-Even Point
(
  'd0400000-0000-0000-0001-000000000001',
  'd0000000-0000-0000-0000-000000000004',
  '4.1.1',
  1,
  'Finding the Break-Even Point',
  'finding-break-even-point',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Finding the Break-Even Point\n\n## What is Break-Even?\n\nThe break-even point is where **total revenue equals total costs** - no profit, no loss.\n\n$$\\text{Break-Even: Revenue} = \\text{Variable Costs} + \\text{Fixed Costs}$$\n\n---\n\n## Two Ways to Express Break-Even\n\n### 1. Break-Even in Units\nHow many units must be sold to break even?\n\n$$\\text{BEP (units)} = \\frac{\\text{Fixed Costs}}{\\text{Contribution Margin per Unit}}$$\n\n### 2. Break-Even in Sales Dollars\nHow much revenue is needed to break even?\n\n$$\\text{BEP (sales)} = \\frac{\\text{Fixed Costs}}{\\text{CM Ratio}}$$\n\n---\n\n## The Logic Behind the Formulas\n\n:::concept{title=\"Why These Formulas Work\"}\n- Each unit sold contributes its CM toward covering fixed costs\n- Once fixed costs are covered, additional CM becomes profit\n- At break-even: Total CM = Fixed Costs\n:::\n\n### Visual Understanding\n\n```\nUnits Sold:  100   200   300   400   500\nCM Earned:  $500  $1000 $1500 $2000 $2500\nFixed Costs: ----$2000 to cover---------\nProfit:     -1500 -1000  -500    0   +500\n                                 ^\n                           Break-Even\n```\n\n---\n\n## Step-by-Step Example\n\n**Hotel Room Data:**\n- Selling price per room: CHF 200\n- Variable cost per room: CHF 50\n- Fixed costs per month: CHF 90,000\n\n### Step 1: Calculate CM per Unit\n$$\\text{CM per room} = 200 - 50 = \\text{CHF 150}$$\n\n### Step 2: Calculate CM Ratio\n$$\\text{CM Ratio} = 150 / 200 = 75\\%$$\n\n### Step 3: Break-Even in Units\n$$\\text{BEP (rooms)} = \\frac{90,000}{150} = 600 \\text{ rooms}$$\n\n### Step 4: Break-Even in Sales Dollars\n$$\\text{BEP (sales)} = \\frac{90,000}{0.75} = \\text{CHF 120,000}$$\n\n**Verification:** 600 rooms x CHF 200 = CHF 120,000\n\n---\n\n## The CVP Graph\n\n```\n        $\n        |\n Revenue |      /\n        |    /\n        |  /----Fixed Costs\n        |/\n        +----------------> Units\n           BEP\n```\n\n**Key Points:**\n- Total revenue line starts at origin\n- Total cost line starts at fixed costs\n- Lines intersect at break-even\n- Below intersection = Loss\n- Above intersection = Profit\n\n---\n\n## Hotel Application\n\n**200-room hotel, 30 days per month = 6,000 room nights available**\n\nBreak-even of 600 rooms = 600/6,000 = **10% occupancy**\n\nThis means:\n- Below 10%: Losing money\n- At 10%: Breaking even\n- Above 10%: Making profit\n\n---\n\n:::takeaways\n- Break-even is where Revenue = Total Costs (zero profit)\n- BEP (units) = Fixed Costs / CM per unit\n- BEP (sales $) = Fixed Costs / CM Ratio\n- Understanding break-even helps set targets and assess risk\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.1.2: Break-Even Calculator Interactive
(
  'd0400000-0000-0000-0001-000000000002',
  'd0000000-0000-0000-0000-000000000004',
  '4.1.2',
  2,
  'Break-Even Calculator',
  'break-even-calculator',
  'interactive',
  8,
  30,
  'basic',
  '{
    "instructions": "Put the break-even calculation steps in the correct order.",
    "sequence": [
      "Identify the selling price per unit",
      "Calculate variable cost per unit",
      "Compute Contribution Margin per unit (Price - Variable Cost)",
      "Determine the CM Ratio (CM / Price)",
      "Identify total fixed costs",
      "Calculate BEP in units: Fixed Costs / CM per unit",
      "Calculate BEP in sales: Fixed Costs / CM Ratio",
      "Verify: BEP units x Price = BEP sales dollars"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

-- Activity 4.1.3: Break-Even Concepts Quiz
(
  'd0400000-0000-0000-0001-000000000003',
  'd0000000-0000-0000-0000-000000000004',
  '4.1.3',
  3,
  'Break-Even Concepts Quiz',
  'break-even-concepts-quiz',
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
        "question": "At the break-even point, total revenue equals:",
        "options": ["Total variable costs", "Total fixed costs", "Total variable costs plus fixed costs", "Zero"],
        "correct": 2,
        "explanation": "At break-even, Revenue = Variable Costs + Fixed Costs (all costs are covered, profit = 0)."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Fixed costs CHF 40,000, CM per unit CHF 20. Break-even in units is:",
        "options": ["2,000 units", "800 units", "20,000 units", "40,000 units"],
        "correct": 0,
        "explanation": "BEP = Fixed Costs / CM per unit = 40,000 / 20 = 2,000 units"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Fixed costs CHF 60,000, CM ratio 40%. Break-even in sales is:",
        "options": ["CHF 24,000", "CHF 100,000", "CHF 150,000", "CHF 60,000"],
        "correct": 2,
        "explanation": "BEP = Fixed Costs / CM Ratio = 60,000 / 0.40 = CHF 150,000"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "If fixed costs increase, the break-even point will increase.",
        "correct": true,
        "explanation": "True. Higher fixed costs require more units/sales to cover them."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If CM per unit increases while fixed costs stay the same, break-even will:",
        "options": ["Increase", "Decrease", "Stay the same", "Double"],
        "correct": 1,
        "explanation": "Higher CM per unit means each unit contributes more, so fewer units needed to break even."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Price CHF 100, VC CHF 60, Fixed CHF 80,000. How many units to break even?",
        "options": ["800", "1,333", "2,000", "8,000"],
        "correct": 2,
        "explanation": "CM = 100 - 60 = 40. BEP = 80,000 / 40 = 2,000 units"
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "At break-even, net operating income is:",
        "options": ["Equal to fixed costs", "Equal to CM", "Zero", "Equal to sales"],
        "correct": 2,
        "explanation": "By definition, break-even is where profit (net operating income) equals zero."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "applied",
        "question": "On the CVP graph, the break-even point is where:",
        "options": ["Revenue line crosses the x-axis", "Cost line crosses the y-axis", "Revenue and total cost lines intersect", "Variable cost equals fixed cost"],
        "correct": 2,
        "explanation": "Break-even occurs at the intersection of the revenue and total cost lines."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.1.4: Hotel Room Break-Even Practice
(
  'd0400000-0000-0000-0001-000000000004',
  'd0000000-0000-0000-0000-000000000004',
  '4.1.4',
  4,
  'Hotel Room Break-Even',
  'hotel-room-break-even',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Hotel Room Break-Even Analysis\n\n## Grandview Hotel Case\n\n**Data:**\n- 150 rooms available\n- Average room rate: CHF 180\n- Variable cost per room: CHF 45 (cleaning, amenities, laundry)\n- Monthly fixed costs: CHF 162,000 (rent, salaries, insurance)\n- 30 days per month\n\n---\n\n## Step-by-Step Analysis\n\n### Step 1: Calculate Contribution Margin\n$$\\text{CM per room} = 180 - 45 = \\text{CHF 135}$$\n\n$$\\text{CM Ratio} = 135 / 180 = 75\\%$$\n\n### Step 2: Break-Even in Room Nights\n$$\\text{BEP} = \\frac{162,000}{135} = 1,200 \\text{ room nights}$$\n\n### Step 3: Break-Even Occupancy\n$$\\text{Available rooms} = 150 \\times 30 = 4,500 \\text{ room nights}$$\n\n$$\\text{BEP occupancy} = \\frac{1,200}{4,500} = 26.7\\%$$\n\n---\n\n## Profitability Analysis\n\n| Occupancy | Rooms Sold | Revenue | VC | CM | FC | Profit |\n|-----------|------------|---------|-----|-----|-------|--------|\n| 20% | 900 | 162,000 | 40,500 | 121,500 | 162,000 | (40,500) |\n| 26.7% | 1,200 | 216,000 | 54,000 | 162,000 | 162,000 | 0 |\n| 40% | 1,800 | 324,000 | 81,000 | 243,000 | 162,000 | 81,000 |\n| 60% | 2,700 | 486,000 | 121,500 | 364,500 | 162,000 | 202,500 |\n\n---\n\n## What-If Scenarios\n\n### Scenario A: Increase Room Rate to CHF 200\n$$\\text{New CM} = 200 - 45 = \\text{CHF 155}$$\n$$\\text{New BEP} = 162,000 / 155 = 1,045 \\text{ rooms (23.2\\% occupancy)}$$\n\n### Scenario B: Reduce Fixed Costs to CHF 135,000\n$$\\text{New BEP} = 135,000 / 135 = 1,000 \\text{ rooms (22.2\\% occupancy)}$$\n\n### Scenario C: Add CHF 10 in Variable Costs for Breakfast\n$$\\text{New CM} = 180 - 55 = \\text{CHF 125}$$\n$$\\text{New BEP} = 162,000 / 125 = 1,296 \\text{ rooms (28.8\\% occupancy)}$$\n\n---\n\n## Management Insights\n\n1. **Current risk level**: 26.7% occupancy is relatively low break-even - good cushion\n2. **Pricing power**: Raising rates improves break-even significantly\n3. **Cost control**: Reducing fixed costs has substantial impact\n4. **Added services**: Including breakfast raises break-even unless price also increases\n\n---\n\n:::takeaways\n- Convert break-even units to occupancy percentage for hotels\n- Compare break-even to expected/historical occupancy\n- Use what-if analysis to test pricing and cost decisions\n- Lower break-even = less risk, more profit potential\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.1.5: Restaurant Multi-Product Break-Even
(
  'd0400000-0000-0000-0001-000000000005',
  'd0000000-0000-0000-0000-000000000004',
  '4.1.5',
  5,
  'Restaurant Break-Even Analysis',
  'restaurant-break-even',
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
        "question": "Average check CHF 55, variable cost CHF 22, fixed costs CHF 49,500. Break-even covers are:",
        "options": ["900", "1,500", "2,250", "3,000"],
        "correct": 1,
        "explanation": "CM = 55 - 22 = 33. BEP = 49,500 / 33 = 1,500 covers"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If the restaurant serves 80 covers per day and operates 25 days/month, monthly covers are:",
        "options": ["1,500", "2,000", "2,500", "3,000"],
        "correct": 1,
        "explanation": "Monthly covers = 80 x 25 = 2,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "With BEP of 1,500 and capacity of 2,000 covers, how much profit at full capacity?",
        "options": ["CHF 16,500", "CHF 49,500", "CHF 66,000", "CHF 33,000"],
        "correct": 0,
        "explanation": "Covers above BEP: 2,000 - 1,500 = 500. Profit = 500 x CHF 33 = CHF 16,500"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "To achieve CHF 33,000 profit, how many covers are needed?",
        "options": ["1,500", "2,000", "2,500", "3,000"],
        "correct": 2,
        "explanation": "Covers for profit = 33,000/33 = 1,000. Total = 1,500 BEP + 1,000 = 2,500"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "If the restaurant is already at break-even, each additional cover adds CHF 33 to profit.",
        "correct": true,
        "explanation": "True. Once fixed costs are covered, each unit''s CM goes directly to profit."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.1.6: CVP Graph Builder
(
  'd0400000-0000-0000-0001-000000000006',
  'd0000000-0000-0000-0000-000000000004',
  '4.1.6',
  6,
  'CVP Graph Builder',
  'cvp-graph-builder',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Match each element of the CVP graph to its description.",
    "pairs": [
      {"left": "Upward sloping line from origin", "right": "Total Revenue line"},
      {"left": "Upward sloping line starting above zero", "right": "Total Cost line"},
      {"left": "Where revenue and cost lines cross", "right": "Break-Even Point"},
      {"left": "Area above break-even between lines", "right": "Profit Zone"},
      {"left": "Area below break-even between lines", "right": "Loss Zone"},
      {"left": "Y-intercept of total cost line", "right": "Fixed Costs"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 4.1.7: Break-Even Checkpoint
(
  'd0400000-0000-0000-0001-000000000007',
  'd0000000-0000-0000-0000-000000000004',
  '4.1.7',
  7,
  'Break-Even Analysis Checkpoint',
  'break-even-checkpoint',
  'checkpoint',
  12,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The formula for break-even in units is:",
        "options": ["Fixed Costs / Selling Price", "Fixed Costs / CM per Unit", "Variable Costs / CM Ratio", "Sales / Fixed Costs"],
        "correct": 1,
        "explanation": "BEP (units) = Fixed Costs / Contribution Margin per Unit"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Price CHF 80, VC CHF 48, FC CHF 64,000. Break-even units:",
        "options": ["800", "1,333", "2,000", "4,000"],
        "correct": 2,
        "explanation": "CM = 80 - 48 = 32. BEP = 64,000 / 32 = 2,000 units"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Using the same data, CM ratio is:",
        "options": ["32%", "40%", "60%", "80%"],
        "correct": 1,
        "explanation": "CM Ratio = 32 / 80 = 40%"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Break-even in sales dollars is:",
        "options": ["CHF 64,000", "CHF 128,000", "CHF 160,000", "CHF 200,000"],
        "correct": 2,
        "explanation": "BEP sales = FC / CM ratio = 64,000 / 0.40 = CHF 160,000"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "If 2,500 units are sold, profit is:",
        "options": ["CHF 16,000", "CHF 64,000", "CHF 80,000", "CHF 0"],
        "correct": 0,
        "explanation": "Units above BEP = 500. Profit = 500 x 32 = CHF 16,000"
      },
      {
        "id": "cp6",
        "type": "true_false",
        "question": "Reducing variable cost per unit will lower the break-even point.",
        "correct": true,
        "explanation": "True. Lower VC increases CM per unit, reducing units needed to break even."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- SKILL: Target Profit Analysis (MA-12)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 4.2.1: Calculating Target Profit
(
  'd0400000-0000-0000-0002-000000000001',
  'd0000000-0000-0000-0000-000000000004',
  '4.2.1',
  8,
  'Calculating Target Profit',
  'calculating-target-profit',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Calculating Target Profit\n\n## Beyond Break-Even\n\nBreak-even tells us how to achieve zero profit. But businesses need profit! Target profit analysis answers:\n\n> **How many units must we sell to achieve a desired profit?**\n\n---\n\n## Target Profit Formulas\n\n### Units Required for Target Profit\n$$\\text{Units} = \\frac{\\text{Fixed Costs} + \\text{Target Profit}}{\\text{CM per Unit}}$$\n\n### Sales Dollars Required for Target Profit\n$$\\text{Sales} = \\frac{\\text{Fixed Costs} + \\text{Target Profit}}{\\text{CM Ratio}}$$\n\n---\n\n## The Logic\n\n:::concept{title=\"Modified Break-Even\"}\nTarget profit analysis is just break-even with the profit added:\n- First, CM covers fixed costs (break-even)\n- Then, additional CM covers desired profit\n:::\n\n---\n\n## Example: Hotel Target Profit\n\n**Alpine Lodge:**\n- Room rate: CHF 150\n- Variable cost: CHF 40\n- Fixed costs: CHF 77,000/month\n- Target profit: CHF 33,000/month\n\n### Step 1: Calculate CM\n$$\\text{CM per room} = 150 - 40 = \\text{CHF 110}$$\n\n### Step 2: Calculate Required Units\n$$\\text{Rooms} = \\frac{77,000 + 33,000}{110} = \\frac{110,000}{110} = 1,000 \\text{ rooms}$$\n\n### Step 3: Verify\n```\nRevenue (1,000 x 150)     CHF 150,000\nVariable costs (1,000 x 40) (40,000)\nContribution margin         110,000\nFixed costs                 (77,000)\nNet profit                 CHF 33,000  (target achieved)\n```\n\n---\n\n## Comparing Break-Even vs Target Profit\n\n| | Break-Even | Target Profit |\n|-|-----------|---------------|\n| Formula numerator | Fixed Costs | Fixed Costs + Target Profit |\n| Rooms needed | 700 | 1,000 |\n| Revenue needed | CHF 105,000 | CHF 150,000 |\n| Profit | CHF 0 | CHF 33,000 |\n\n---\n\n## Working with CM Ratio\n\n$$\\text{CM Ratio} = 110/150 = 73.33\\%$$\n\n$$\\text{Sales needed} = \\frac{110,000}{0.7333} = \\text{CHF 150,000}$$\n\n---\n\n## After-Tax Target Profit\n\nIf the target is specified after taxes:\n\n$$\\text{Before-tax profit needed} = \\frac{\\text{After-tax target}}{1 - \\text{Tax rate}}$$\n\n**Example**: Target CHF 25,000 after-tax, 20% tax rate\n$$\\text{Before-tax} = \\frac{25,000}{1 - 0.20} = \\frac{25,000}{0.80} = \\text{CHF 31,250}$$\n\n---\n\n:::takeaways\n- Target profit adds desired profit to fixed costs in the numerator\n- Units for target = (FC + Target) / CM per unit\n- Sales for target = (FC + Target) / CM Ratio\n- For after-tax targets, convert to before-tax first\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.2.2: Target Profit Quiz
(
  'd0400000-0000-0000-0002-000000000002',
  'd0000000-0000-0000-0000-000000000004',
  '4.2.2',
  9,
  'Target Profit Quiz',
  'target-profit-quiz',
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
        "question": "The target profit formula differs from break-even by adding _____ to the numerator.",
        "options": ["Variable costs", "Fixed costs", "Target profit", "CM ratio"],
        "correct": 2,
        "explanation": "Target profit is added to fixed costs in the numerator: (FC + Target) / CM"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "FC CHF 50,000, CM CHF 25/unit, Target profit CHF 30,000. Units needed:",
        "options": ["2,000", "2,800", "3,200", "3,400"],
        "correct": 2,
        "explanation": "Units = (50,000 + 30,000) / 25 = 80,000 / 25 = 3,200"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "FC CHF 60,000, CM Ratio 40%, Target profit CHF 20,000. Sales needed:",
        "options": ["CHF 150,000", "CHF 175,000", "CHF 200,000", "CHF 225,000"],
        "correct": 2,
        "explanation": "Sales = (60,000 + 20,000) / 0.40 = 80,000 / 0.40 = CHF 200,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Target after-tax profit CHF 40,000, tax rate 20%. Before-tax profit needed is:",
        "options": ["CHF 32,000", "CHF 40,000", "CHF 48,000", "CHF 50,000"],
        "correct": 3,
        "explanation": "Before-tax = 40,000 / (1 - 0.20) = 40,000 / 0.80 = CHF 50,000"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "If target profit equals fixed costs, units needed are exactly twice the break-even point.",
        "correct": true,
        "explanation": "True. (FC + FC) / CM = 2 x (FC / CM) = 2 x break-even"
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Break-even is 1,000 units. To earn CHF 15,000 profit with CM of CHF 30, total units needed:",
        "options": ["1,000", "1,250", "1,500", "2,000"],
        "correct": 2,
        "explanation": "Additional units for profit = 15,000 / 30 = 500. Total = 1,000 + 500 = 1,500"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.2.3: Target Profit Calculator Interactive
(
  'd0400000-0000-0000-0002-000000000003',
  'd0000000-0000-0000-0000-000000000004',
  '4.2.3',
  10,
  'Target Profit Calculator',
  'target-profit-calculator',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Arrange the steps to calculate units needed for target profit.",
    "sequence": [
      "Identify fixed costs",
      "Determine the target profit amount",
      "Calculate contribution margin per unit (Price - VC)",
      "Add fixed costs plus target profit",
      "Divide sum by contribution margin per unit",
      "Result = number of units needed",
      "Verify by preparing a CM income statement"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

-- Activity 4.2.4: Hotel Revenue Goals Practice
(
  'd0400000-0000-0000-0002-000000000004',
  'd0000000-0000-0000-0000-000000000004',
  '4.2.4',
  11,
  'Hotel Revenue Goals',
  'hotel-revenue-goals',
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
        "question": "Room rate CHF 200, VC CHF 50, FC CHF 120,000, Target profit CHF 45,000. Required room nights:",
        "options": ["800", "1,000", "1,100", "1,300"],
        "correct": 2,
        "explanation": "CM = 150. Units = (120,000 + 45,000) / 150 = 165,000 / 150 = 1,100"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "With 100 rooms and 30 days, 1,100 room nights equals what occupancy?",
        "options": ["33%", "37%", "42%", "55%"],
        "correct": 1,
        "explanation": "Occupancy = 1,100 / 3,000 = 36.67%, approximately 37%"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If the hotel only achieves 1,000 room nights, what is the actual profit?",
        "options": ["CHF 30,000", "CHF 45,000", "CHF 120,000", "CHF 150,000"],
        "correct": 0,
        "explanation": "CM = 1,000 x 150 = 150,000. Profit = 150,000 - 120,000 = CHF 30,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "To increase target profit to CHF 60,000, how many additional rooms beyond 1,100?",
        "options": ["50", "100", "150", "200"],
        "correct": 1,
        "explanation": "Additional profit needed = 60,000 - 45,000 = 15,000. Additional rooms = 15,000 / 150 = 100"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Higher fixed costs require more units to achieve the same target profit.",
        "correct": true,
        "explanation": "True. Higher FC increases the numerator, requiring more units."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.2.5: Target Profit Checkpoint
(
  'd0400000-0000-0000-0002-000000000005',
  'd0000000-0000-0000-0000-000000000004',
  '4.2.5',
  12,
  'Target Profit Checkpoint',
  'target-profit-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Units for target profit = (FC + Target) / ____",
        "options": ["Sales price", "Variable cost", "CM per unit", "Total costs"],
        "correct": 2,
        "explanation": "Units = (Fixed Costs + Target Profit) / Contribution Margin per Unit"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "FC CHF 80,000, CM CHF 40/unit. Break-even is 2,000 units. For CHF 20,000 profit, units needed:",
        "options": ["2,000", "2,500", "3,000", "3,500"],
        "correct": 1,
        "explanation": "Units = (80,000 + 20,000) / 40 = 100,000 / 40 = 2,500"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Same data: for CHF 40,000 profit, units needed:",
        "options": ["2,500", "3,000", "3,500", "4,000"],
        "correct": 1,
        "explanation": "Units = (80,000 + 40,000) / 40 = 120,000 / 40 = 3,000"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Target after-tax profit CHF 36,000 with 25% tax rate. Before-tax profit needed:",
        "options": ["CHF 27,000", "CHF 36,000", "CHF 45,000", "CHF 48,000"],
        "correct": 3,
        "explanation": "Before-tax = 36,000 / (1 - 0.25) = 36,000 / 0.75 = CHF 48,000"
      },
      {
        "id": "cp5",
        "type": "true_false",
        "question": "Target profit analysis is simply break-even analysis with profit added to fixed costs.",
        "correct": true,
        "explanation": "True. The formulas are identical except target profit is added to the numerator."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- SKILL: Margin of Safety (MA-13)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 4.3.1: Understanding Margin of Safety
(
  'd0400000-0000-0000-0003-000000000001',
  'd0000000-0000-0000-0000-000000000004',
  '4.3.1',
  13,
  'Understanding Margin of Safety',
  'understanding-margin-of-safety',
  'lesson',
  10,
  30,
  'basic',
  '{"markdown": "# Understanding Margin of Safety\n\n## What is Margin of Safety?\n\nThe **margin of safety** measures how far current or expected sales exceed the break-even point. It represents the **cushion** before losses occur.\n\n---\n\n## Margin of Safety Formulas\n\n### In Units\n$$\\text{MOS (units)} = \\text{Current Sales} - \\text{Break-Even Sales}$$\n\n### In Dollars\n$$\\text{MOS (\\$)} = \\text{Current Sales (\\$)} - \\text{Break-Even Sales (\\$)}$$\n\n### As Percentage\n$$\\text{MOS \\%} = \\frac{\\text{MOS (\\$)}}{\\text{Current Sales (\\$)}} \\times 100\\%$$\n\n---\n\n## Example\n\n**Resort Hotel:**\n- Current sales: 1,500 room nights\n- Break-even: 1,000 room nights\n- Room rate: CHF 180\n\n### Margin of Safety Calculations\n\n$$\\text{MOS (units)} = 1,500 - 1,000 = 500 \\text{ room nights}$$\n\n$$\\text{MOS (\\$)} = (1,500 - 1,000) \\times 180 = \\text{CHF 90,000}$$\n\n$$\\text{MOS \\%} = \\frac{500}{1,500} = 33.3\\%$$\n\n---\n\n## Interpretation\n\n:::concept{title=\"What MOS % Tells You\"}\n- **33.3% MOS** means sales can drop 33.3% before losses occur\n- Higher MOS % = lower risk\n- Lower MOS % = higher risk, less cushion\n:::\n\n### Risk Levels\n\n| MOS % | Risk Level | Interpretation |\n|-------|-----------|----------------|\n| > 40% | Low | Substantial cushion |\n| 20-40% | Moderate | Reasonable buffer |\n| < 20% | High | Vulnerable to downturns |\n\n---\n\n## MOS and Profit Relationship\n\n$$\\text{Profit} = \\text{MOS (units)} \\times \\text{CM per unit}$$\n\nOR\n\n$$\\text{Profit} = \\text{MOS (\\$)} \\times \\text{CM Ratio}$$\n\n**Example:** MOS 500 rooms x CHF 130 CM = CHF 65,000 profit\n\n---\n\n## Using MOS for Decision Making\n\n1. **Compare alternatives** - Choose options with higher MOS\n2. **Assess risk** - Low MOS indicates vulnerability\n3. **Set sales targets** - Aim for acceptable MOS %\n4. **Evaluate seasonality** - Monitor MOS during low seasons\n\n---\n\n:::takeaways\n- MOS = Current Sales - Break-Even Sales\n- Expresses the buffer before reaching break-even\n- MOS % shows what percentage of sales can drop\n- Higher MOS = lower risk, better cushion\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.3.2: Margin of Safety Quiz
(
  'd0400000-0000-0000-0003-000000000002',
  'd0000000-0000-0000-0000-000000000004',
  '4.3.2',
  14,
  'Margin of Safety Quiz',
  'margin-of-safety-quiz',
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
        "question": "Margin of safety represents:",
        "options": ["Total profit earned", "Buffer above break-even", "Total fixed costs", "Variable cost ratio"],
        "correct": 1,
        "explanation": "MOS is the cushion or buffer between current sales and break-even."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Current sales 2,000 units, break-even 1,500 units. MOS in units is:",
        "options": ["500", "1,500", "2,000", "3,500"],
        "correct": 0,
        "explanation": "MOS = Current - BEP = 2,000 - 1,500 = 500 units"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Using the same data, MOS % is:",
        "options": ["25%", "33%", "50%", "75%"],
        "correct": 0,
        "explanation": "MOS % = 500 / 2,000 = 25%"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A company with 15% margin of safety has lower risk than one with 35%.",
        "correct": false,
        "explanation": "False. Higher MOS % means lower risk. 35% has more cushion than 15%."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "MOS is 600 units, CM CHF 25/unit. Current profit is:",
        "options": ["CHF 600", "CHF 15,000", "CHF 25,000", "CHF 24"],
        "correct": 1,
        "explanation": "Profit = MOS units x CM = 600 x 25 = CHF 15,000"
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If MOS % is 30%, a 30% drop in sales would result in:",
        "options": ["Large profit", "Moderate profit", "Break-even", "Loss"],
        "correct": 2,
        "explanation": "A 30% drop uses the entire margin of safety, reaching break-even exactly."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.3.3: Safety Margin Calculator Interactive
(
  'd0400000-0000-0000-0003-000000000003',
  'd0000000-0000-0000-0000-000000000004',
  '4.3.3',
  15,
  'Safety Margin Calculator',
  'safety-margin-calculator',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Match each margin of safety formula component.",
    "pairs": [
      {"left": "MOS in units", "right": "Actual units - Break-even units"},
      {"left": "MOS in dollars", "right": "Actual sales - Break-even sales"},
      {"left": "MOS percentage", "right": "MOS / Current Sales x 100"},
      {"left": "Profit using MOS", "right": "MOS units x CM per unit"},
      {"left": "High MOS %", "right": "Low business risk"},
      {"left": "Low MOS %", "right": "High business risk"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 4.3.4: Seasonal Hotel Analysis Practice
(
  'd0400000-0000-0000-0003-000000000004',
  'd0000000-0000-0000-0000-000000000004',
  '4.3.4',
  16,
  'Seasonal Hotel Analysis',
  'seasonal-hotel-analysis',
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
        "question": "High season: 2,400 rooms sold, BEP 1,800. MOS %:",
        "options": ["25%", "33%", "50%", "75%"],
        "correct": 0,
        "explanation": "MOS % = (2,400 - 1,800) / 2,400 = 600 / 2,400 = 25%"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Low season: 2,000 rooms sold, same BEP 1,800. MOS %:",
        "options": ["10%", "15%", "20%", "25%"],
        "correct": 0,
        "explanation": "MOS % = (2,000 - 1,800) / 2,000 = 200 / 2,000 = 10%"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which season has higher risk?",
        "options": ["High season (25% MOS)", "Low season (10% MOS)", "Equal risk", "Cannot determine"],
        "correct": 1,
        "explanation": "Lower MOS % means higher risk. Low season at 10% has less cushion."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "In low season, how much can sales drop before loss occurs?",
        "options": ["10%", "25%", "90%", "200 rooms"],
        "correct": 0,
        "explanation": "MOS % of 10% means sales can drop 10% before reaching break-even."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A hotel should consider reducing fixed costs during low season to improve margin of safety.",
        "correct": true,
        "explanation": "True. Lower fixed costs reduces break-even, improving MOS."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.3.5: Margin of Safety Checkpoint
(
  'd0400000-0000-0000-0003-000000000005',
  'd0000000-0000-0000-0000-000000000004',
  '4.3.5',
  17,
  'Margin of Safety Checkpoint',
  'margin-of-safety-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "MOS measures the distance between current sales and:",
        "options": ["Target profit", "Break-even point", "Fixed costs", "Maximum capacity"],
        "correct": 1,
        "explanation": "MOS is the buffer between current sales and break-even."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Current sales CHF 500,000, BEP sales CHF 350,000. MOS % is:",
        "options": ["30%", "70%", "43%", "150%"],
        "correct": 0,
        "explanation": "MOS % = (500,000 - 350,000) / 500,000 = 150,000 / 500,000 = 30%"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Same data with CM ratio 40%. Current profit is:",
        "options": ["CHF 60,000", "CHF 140,000", "CHF 150,000", "CHF 200,000"],
        "correct": 0,
        "explanation": "Profit = MOS x CM ratio = 150,000 x 40% = CHF 60,000"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "If MOS % equals 0%, the company is exactly at break-even.",
        "correct": true,
        "explanation": "True. Zero margin of safety means current sales equal break-even sales."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Which action would INCREASE margin of safety?",
        "options": ["Increase fixed costs", "Decrease selling price", "Increase sales volume", "Decrease CM per unit"],
        "correct": 2,
        "explanation": "Higher sales volume increases the gap above break-even."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- SKILL: Operating Leverage (MA-14)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 4.4.1: Operating Leverage Explained
(
  'd0400000-0000-0000-0004-000000000001',
  'd0000000-0000-0000-0000-000000000004',
  '4.4.1',
  18,
  'Operating Leverage Explained',
  'operating-leverage-explained',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Operating Leverage Explained\n\n## What is Operating Leverage?\n\nOperating leverage measures how sensitive net income is to changes in sales. It shows the **multiplier effect** of changes in revenue on profit.\n\n---\n\n## Degree of Operating Leverage (DOL)\n\n$$\\text{DOL} = \\frac{\\text{Contribution Margin}}{\\text{Net Operating Income}}$$\n\nThe DOL indicates by what percentage profit will change for each 1% change in sales.\n\n---\n\n## Example\n\n**Mountain Resort Restaurant:**\n\n| Item | Amount |\n|------|--------|\n| Sales | CHF 200,000 |\n| Variable Costs | (80,000) |\n| Contribution Margin | 120,000 |\n| Fixed Costs | (100,000) |\n| Net Operating Income | CHF 20,000 |\n\n$$\\text{DOL} = \\frac{120,000}{20,000} = 6$$\n\n### Interpretation\n- A 10% increase in sales will increase profit by 60% (10% x 6)\n- A 5% decrease in sales will decrease profit by 30% (5% x 6)\n\n---\n\n## The Leverage Effect\n\n:::concept{title=\"High vs Low Operating Leverage\"}\n**High DOL (high fixed costs)**:\n- Profit changes dramatically with sales\n- Great when sales increase\n- Dangerous when sales decrease\n\n**Low DOL (low fixed costs)**:\n- Profit is more stable\n- Less upside potential\n- Less downside risk\n:::\n\n---\n\n## Comparing Cost Structures\n\n| | High Fixed / Low Variable | Low Fixed / High Variable |\n|--|---------------------------|---------------------------|\n| CM per unit | Higher | Lower |\n| Break-even | Higher | Lower |\n| DOL | Higher | Lower |\n| Risk | Higher | Lower |\n| Profit potential | Higher | Lower |\n\n---\n\n## DOL Changes with Volume\n\nDOL is highest near break-even and decreases as you move away from it:\n\n| Sales Level | CM | Profit | DOL |\n|-------------|-----|--------|-----|\n| At BEP | 100,000 | 0 | Undefined |\n| 10% above BEP | 110,000 | 10,000 | 11.0 |\n| 20% above BEP | 120,000 | 20,000 | 6.0 |\n| 50% above BEP | 150,000 | 50,000 | 3.0 |\n\n---\n\n## Hotel Industry Example\n\n**Luxury Hotel (High Leverage)**:\n- High fixed costs (staffing, facilities)\n- Low variable costs per room\n- Profit swings dramatically with occupancy\n\n**Budget Motel (Lower Leverage)**:\n- Lower fixed costs\n- Higher variable costs per room\n- More stable but lower profit margins\n\n---\n\n:::takeaways\n- DOL = CM / Net Operating Income\n- DOL shows profit sensitivity to sales changes\n- % change in profit = DOL x % change in sales\n- Higher leverage = higher risk and reward\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.4.2: Operating Leverage Quiz
(
  'd0400000-0000-0000-0004-000000000002',
  'd0000000-0000-0000-0000-000000000004',
  '4.4.2',
  19,
  'Operating Leverage Quiz',
  'operating-leverage-quiz',
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
        "question": "The degree of operating leverage equals:",
        "options": ["Fixed costs / Variable costs", "CM / Net operating income", "Sales / Break-even", "Profit / Sales"],
        "correct": 1,
        "explanation": "DOL = Contribution Margin / Net Operating Income"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "CM is CHF 80,000 and profit is CHF 16,000. DOL is:",
        "options": ["3", "4", "5", "6"],
        "correct": 2,
        "explanation": "DOL = 80,000 / 16,000 = 5"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "With DOL of 5, a 12% increase in sales causes profit to increase by:",
        "options": ["12%", "24%", "60%", "500%"],
        "correct": 2,
        "explanation": "% profit change = DOL x % sales change = 5 x 12% = 60%"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "With DOL of 5, a 10% DECREASE in sales causes profit to:",
        "options": ["Increase 50%", "Decrease 10%", "Decrease 50%", "Decrease 500%"],
        "correct": 2,
        "explanation": "% profit change = 5 x (-10%) = -50% (decrease)"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A company with high fixed costs will have higher operating leverage than one with high variable costs.",
        "correct": true,
        "explanation": "True. High fixed costs mean higher CM relative to profit, resulting in higher DOL."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Near break-even, DOL is:",
        "options": ["Very low", "Around 1", "Very high", "Negative"],
        "correct": 2,
        "explanation": "At break-even, profit approaches zero, making DOL (CM/Profit) extremely high."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.4.3: Leverage Calculator Interactive
(
  'd0400000-0000-0000-0004-000000000003',
  'd0000000-0000-0000-0000-000000000004',
  '4.4.3',
  20,
  'Leverage Calculator',
  'leverage-calculator',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Sort these characteristics into High Operating Leverage or Low Operating Leverage.",
    "categories": ["High Operating Leverage", "Low Operating Leverage"],
    "items": [
      {"text": "High fixed costs", "category": "High Operating Leverage"},
      {"text": "Low fixed costs", "category": "Low Operating Leverage"},
      {"text": "Higher profit volatility", "category": "High Operating Leverage"},
      {"text": "More stable profits", "category": "Low Operating Leverage"},
      {"text": "Higher break-even point", "category": "High Operating Leverage"},
      {"text": "Lower break-even point", "category": "Low Operating Leverage"},
      {"text": "Greater upside potential", "category": "High Operating Leverage"},
      {"text": "Lower downside risk", "category": "Low Operating Leverage"}
    ]
  }'::jsonb,
  'category-sort',
  false,
  true
),

-- Activity 4.4.4: Hotel Cost Structure Comparison
(
  'd0400000-0000-0000-0004-000000000004',
  'd0000000-0000-0000-0000-000000000004',
  '4.4.4',
  21,
  'Hotel Cost Structure Comparison',
  'hotel-cost-structure-comparison',
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
        "question": "Hotel A: CM CHF 150,000, Profit CHF 30,000. Hotel B: CM CHF 100,000, Profit CHF 40,000. Which has higher DOL?",
        "options": ["Hotel A (DOL 5)", "Hotel B (DOL 2.5)", "Same DOL", "Cannot determine"],
        "correct": 0,
        "explanation": "Hotel A DOL = 150,000/30,000 = 5. Hotel B DOL = 100,000/40,000 = 2.5"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If sales increase 20% at both hotels, which sees larger profit increase?",
        "options": ["Hotel A", "Hotel B", "Same increase", "Hotel B by 40%"],
        "correct": 0,
        "explanation": "Hotel A: 20% x 5 = 100% profit increase. Hotel B: 20% x 2.5 = 50% increase"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If sales DECREASE 20%, which hotel is hurt more?",
        "options": ["Hotel A", "Hotel B", "Same impact", "Neither is affected"],
        "correct": 0,
        "explanation": "Hotel A: -20% x 5 = -100% (profit to zero). Hotel B: -20% x 2.5 = -50%"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A budget hotel with mostly variable costs should have lower operating leverage than a luxury resort.",
        "correct": true,
        "explanation": "True. The budget hotel has lower fixed costs, resulting in lower DOL."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which hotel would you prefer in an uncertain economy?",
        "options": ["Hotel A (high leverage)", "Hotel B (low leverage)", "Either one", "Depends on risk tolerance"],
        "correct": 3,
        "explanation": "It depends on risk tolerance - high leverage has more reward but more risk."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.4.5: Operating Leverage Checkpoint
(
  'd0400000-0000-0000-0004-000000000005',
  'd0000000-0000-0000-0000-000000000004',
  '4.4.5',
  22,
  'Operating Leverage Checkpoint',
  'operating-leverage-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "DOL measures the sensitivity of _____ to changes in _____.",
        "options": ["Sales / Costs", "Profit / Sales", "Fixed costs / Variable costs", "Revenue / Expenses"],
        "correct": 1,
        "explanation": "DOL measures how sensitive profit is to changes in sales."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "CM CHF 90,000, Fixed costs CHF 60,000. DOL equals:",
        "options": ["1.5", "3.0", "6.0", "0.67"],
        "correct": 1,
        "explanation": "Profit = CM - FC = 90,000 - 60,000 = 30,000. DOL = 90,000/30,000 = 3"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "With DOL of 3, an 8% sales increase results in profit increase of:",
        "options": ["8%", "11%", "24%", "3%"],
        "correct": 2,
        "explanation": "% profit change = DOL x % sales change = 3 x 8% = 24%"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "As a company moves further above break-even, its DOL decreases.",
        "correct": true,
        "explanation": "True. As profit grows, DOL (CM/Profit) gets smaller."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "A company wants to reduce risk. It should shift toward:",
        "options": ["Higher fixed costs", "Higher variable costs", "Higher sales", "Lower break-even"],
        "correct": 1,
        "explanation": "Shifting from fixed to variable costs reduces leverage and risk."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- SKILL: Sales Mix Analysis (MA-15)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 4.5.1: Multi-Product CVP Analysis
(
  'd0400000-0000-0000-0005-000000000001',
  'd0000000-0000-0000-0000-000000000004',
  '4.5.1',
  23,
  'Multi-Product CVP Analysis',
  'multi-product-cvp-analysis',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Multi-Product CVP Analysis\n\n## The Challenge with Multiple Products\n\nWhen a company sells multiple products with different contribution margins, we need a method to calculate break-even and target profit.\n\n---\n\n## The Solution: Weighted Average CM\n\nCalculate a single **weighted average contribution margin** based on the sales mix.\n\n$$\\text{Weighted Avg CM} = \\sum (\\text{CM}_i \\times \\text{Sales Mix}_i)$$\n\n---\n\n## Example: Resort with Two Room Types\n\n**Mountain View Resort:**\n\n| Room Type | Price | VC | CM | Sales Mix |\n|-----------|-------|-----|-----|----------|\n| Standard | CHF 150 | CHF 40 | CHF 110 | 60% |\n| Deluxe | CHF 250 | CHF 70 | CHF 180 | 40% |\n\n**Fixed Costs**: CHF 99,000/month\n\n---\n\n## Step 1: Calculate Weighted Average CM\n\n$$\\text{Weighted Avg CM} = (110 \\times 0.60) + (180 \\times 0.40)$$\n$$= 66 + 72 = \\text{CHF 138}$$\n\n---\n\n## Step 2: Calculate Break-Even in Total Units\n\n$$\\text{BEP (total rooms)} = \\frac{99,000}{138} = 717.4 \\approx 718 \\text{ rooms}$$\n\n---\n\n## Step 3: Split by Product\n\n| Room Type | Mix | Rooms (718 total) |\n|-----------|-----|-------------------|\n| Standard | 60% | 431 rooms |\n| Deluxe | 40% | 287 rooms |\n| **Total** | 100% | **718 rooms** |\n\n---\n\n## Verification\n\n```\nStandard: 431 rooms x CHF 110 CM =  CHF 47,410\nDeluxe:   287 rooms x CHF 180 CM =  CHF 51,660\n                                    ----------\nTotal Contribution Margin           CHF 99,070\nFixed Costs                        (CHF 99,000)\nNet Income                          CHF     70 (rounding)\n```\n\n---\n\n## Impact of Sales Mix Changes\n\n:::concept{title=\"Mix Matters!\"}\nIf the mix shifts toward higher-CM products, break-even decreases.\nIf it shifts toward lower-CM products, break-even increases.\n:::\n\n### What if mix changes to 50/50?\n\n$$\\text{New Weighted CM} = (110 \\times 0.50) + (180 \\times 0.50) = 55 + 90 = \\text{CHF 145}$$\n\n$$\\text{New BEP} = 99,000 / 145 = 683 \\text{ rooms}$$\n\nThe shift to more high-margin Deluxe rooms **reduced** break-even.\n\n---\n\n## Using CM Ratio for Sales Dollars\n\n### Weighted Average CM Ratio\n\n| Room | CM | Price | CM Ratio | Mix | Weighted |\n|------|-----|-------|---------|-----|----------|\n| Standard | 110 | 150 | 73.3% | 60% | 44.0% |\n| Deluxe | 180 | 250 | 72.0% | 40% | 28.8% |\n| **Weighted Avg** | | | | | **72.8%** |\n\n$$\\text{BEP (sales)} = \\frac{99,000}{0.728} = \\text{CHF 136,000}$$\n\n---\n\n:::takeaways\n- Use weighted average CM for multi-product CVP\n- Weight = product''s percentage of total sales mix\n- Sales mix changes affect break-even\n- Shifting toward high-CM products lowers break-even\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.5.2: Sales Mix Calculator Interactive
(
  'd0400000-0000-0000-0005-000000000002',
  'd0000000-0000-0000-0000-000000000004',
  '4.5.2',
  24,
  'Sales Mix Calculator',
  'sales-mix-calculator',
  'interactive',
  8,
  30,
  'basic',
  '{
    "instructions": "Arrange the steps for multi-product break-even analysis in order.",
    "sequence": [
      "Identify all products and their selling prices",
      "Calculate variable cost per unit for each product",
      "Compute CM per unit for each product (Price - VC)",
      "Determine the sales mix (% of total for each product)",
      "Calculate weighted average CM (sum of CM x Mix %)",
      "Divide fixed costs by weighted average CM for break-even",
      "Allocate total break-even units to each product using mix %"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

-- Activity 4.5.3: Sales Mix Concepts Quiz
(
  'd0400000-0000-0000-0005-000000000003',
  'd0000000-0000-0000-0000-000000000004',
  '4.5.3',
  25,
  'Sales Mix Concepts Quiz',
  'sales-mix-concepts-quiz',
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
        "question": "When a company sells multiple products, break-even is calculated using:",
        "options": ["Highest CM", "Lowest CM", "Weighted average CM", "Total CM"],
        "correct": 2,
        "explanation": "Weighted average CM accounts for the mix of products sold."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Product A: CM CHF 20, 60% of sales. Product B: CM CHF 35, 40% of sales. Weighted avg CM is:",
        "options": ["CHF 20", "CHF 26", "CHF 27.50", "CHF 35"],
        "correct": 1,
        "explanation": "Weighted CM = (20 x 0.60) + (35 x 0.40) = 12 + 14 = CHF 26"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "With weighted CM of CHF 26 and fixed costs CHF 52,000, break-even units:",
        "options": ["1,000", "2,000", "2,600", "5,200"],
        "correct": 1,
        "explanation": "BEP = 52,000 / 26 = 2,000 units total"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Of the 2,000 break-even units (60%/40% mix), how many are Product A?",
        "options": ["800", "1,000", "1,200", "2,000"],
        "correct": 2,
        "explanation": "Product A = 60% x 2,000 = 1,200 units"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "If the mix shifts to more of the high-CM product, break-even increases.",
        "correct": false,
        "explanation": "False. More high-CM products increases weighted CM, LOWERING break-even."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If the sales mix changes from 60/40 to 40/60 (A/B), the new weighted CM is:",
        "options": ["CHF 26", "CHF 29", "CHF 32", "CHF 35"],
        "correct": 1,
        "explanation": "New weighted CM = (20 x 0.40) + (35 x 0.60) = 8 + 21 = CHF 29"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.5.4: Restaurant Menu Mix Practice
(
  'd0400000-0000-0000-0005-000000000004',
  'd0000000-0000-0000-0000-000000000004',
  '4.5.4',
  26,
  'Restaurant Menu Mix',
  'restaurant-menu-mix',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Restaurant Menu Mix Analysis\n\n## Chez Alpes Restaurant\n\n**Menu Categories:**\n\n| Category | Avg Price | Avg VC | CM | Mix |\n|----------|-----------|--------|-----|-----|\n| Appetizers | CHF 18 | CHF 5 | CHF 13 | 20% |\n| Entrees | CHF 45 | CHF 15 | CHF 30 | 50% |\n| Desserts | CHF 14 | CHF 4 | CHF 10 | 20% |\n| Beverages | CHF 12 | CHF 3 | CHF 9 | 10% |\n\n**Fixed Costs**: CHF 36,000/month\n\n---\n\n## Step 1: Weighted Average CM\n\n$$\\text{Weighted CM} = (13 \\times 0.20) + (30 \\times 0.50) + (10 \\times 0.20) + (9 \\times 0.10)$$\n$$= 2.60 + 15.00 + 2.00 + 0.90 = \\text{CHF 20.50}$$\n\n---\n\n## Step 2: Break-Even in Items\n\n$$\\text{BEP} = \\frac{36,000}{20.50} = 1,756 \\text{ items}$$\n\n---\n\n## Step 3: Break-Even by Category\n\n| Category | Mix | Items |\n|----------|-----|-------|\n| Appetizers | 20% | 351 |\n| Entrees | 50% | 878 |\n| Desserts | 20% | 351 |\n| Beverages | 10% | 176 |\n| **Total** | 100% | **1,756** |\n\n---\n\n## What If: Promoting Appetizers?\n\n**Scenario**: Marketing pushes appetizers to 30%, reducing entrees to 40%\n\n$$\\text{New Weighted CM} = (13 \\times 0.30) + (30 \\times 0.40) + (10 \\times 0.20) + (9 \\times 0.10)$$\n$$= 3.90 + 12.00 + 2.00 + 0.90 = \\text{CHF 18.80}$$\n\n$$\\text{New BEP} = 36,000 / 18.80 = 1,915 \\text{ items}$$\n\n**Impact**: Break-even increased by 159 items because the mix shifted away from high-CM entrees.\n\n---\n\n## Key Insight\n\n:::concept{title=\"Mix Optimization\"}\nTo maximize profit, encourage sales of high-CM items:\n- Train servers to upsell entrees\n- Feature high-margin specials\n- Consider pricing strategy for low-CM items\n:::\n\n---\n\n:::takeaways\n- Restaurant CVP requires weighted average CM\n- Entrees drive profitability in this mix\n- Shifting mix to lower-CM items hurts break-even\n- Menu engineering should focus on high-CM items\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.5.5: Hotel Revenue Mix Practice
(
  'd0400000-0000-0000-0005-000000000005',
  'd0000000-0000-0000-0000-000000000004',
  '4.5.5',
  27,
  'Hotel Revenue Mix',
  'hotel-revenue-mix',
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
        "question": "Standard rooms: CM CHF 100, 70% mix. Suite rooms: CM CHF 200, 30% mix. Weighted CM:",
        "options": ["CHF 100", "CHF 130", "CHF 150", "CHF 200"],
        "correct": 1,
        "explanation": "Weighted CM = (100 x 0.70) + (200 x 0.30) = 70 + 60 = CHF 130"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "FC CHF 117,000. Break-even total rooms:",
        "options": ["700", "900", "1,170", "585"],
        "correct": 1,
        "explanation": "BEP = 117,000 / 130 = 900 rooms"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Of 900 break-even rooms, how many are suites?",
        "options": ["270", "300", "630", "180"],
        "correct": 0,
        "explanation": "Suites = 30% x 900 = 270 rooms"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If mix shifts to 60% standard / 40% suites, new weighted CM is:",
        "options": ["CHF 120", "CHF 130", "CHF 140", "CHF 160"],
        "correct": 2,
        "explanation": "New weighted CM = (100 x 0.60) + (200 x 0.40) = 60 + 80 = CHF 140"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "With the new mix (weighted CM CHF 140), new break-even is:",
        "options": ["750 rooms", "836 rooms", "900 rooms", "1,170 rooms"],
        "correct": 1,
        "explanation": "New BEP = 117,000 / 140 = 835.7, rounded to 836 rooms"
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Shifting the mix toward suites DECREASED break-even because suites have higher CM.",
        "correct": true,
        "explanation": "True. Higher CM products in the mix increase weighted CM, lowering break-even."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.5.6: Sales Mix Checkpoint
(
  'd0400000-0000-0000-0005-000000000006',
  'd0000000-0000-0000-0000-000000000004',
  '4.5.6',
  28,
  'Sales Mix Analysis Checkpoint',
  'sales-mix-checkpoint',
  'checkpoint',
  12,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Weighted average CM is calculated by multiplying each product''s CM by its:",
        "options": ["Price", "Variable cost", "Sales mix percentage", "Fixed cost allocation"],
        "correct": 2,
        "explanation": "Each product''s CM is weighted by its percentage of total sales."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Product X: CM CHF 40, 25% mix. Product Y: CM CHF 60, 75% mix. Weighted CM:",
        "options": ["CHF 50", "CHF 55", "CHF 60", "CHF 100"],
        "correct": 1,
        "explanation": "Weighted CM = (40 x 0.25) + (60 x 0.75) = 10 + 45 = CHF 55"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "With weighted CM CHF 55 and FC CHF 82,500, break-even is:",
        "options": ["1,000 units", "1,375 units", "1,500 units", "2,062 units"],
        "correct": 2,
        "explanation": "BEP = 82,500 / 55 = 1,500 units"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "If the mix changes to 50/50, new weighted CM is:",
        "options": ["CHF 50", "CHF 55", "CHF 100", "CHF 40"],
        "correct": 0,
        "explanation": "Weighted CM = (40 x 0.50) + (60 x 0.50) = 20 + 30 = CHF 50"
      },
      {
        "id": "cp5",
        "type": "true_false",
        "question": "A constant sales mix is assumed throughout CVP analysis with multiple products.",
        "correct": true,
        "explanation": "True. CVP assumes the mix stays constant at all activity levels."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "question": "Which strategy would LOWER break-even?",
        "options": ["Sell more low-CM products", "Sell more high-CM products", "Reduce all prices", "Increase fixed costs"],
        "correct": 1,
        "explanation": "Shifting to more high-CM products increases weighted CM, lowering break-even."
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
-- Skill MA-11: Break-Even Analysis
('d0400000-0000-0000-0001-000000000001', 'd0000000-0000-0000-0004-000000000001', true, 1.0),
('d0400000-0000-0000-0001-000000000002', 'd0000000-0000-0000-0004-000000000001', true, 1.0),
('d0400000-0000-0000-0001-000000000003', 'd0000000-0000-0000-0004-000000000001', true, 1.0),
('d0400000-0000-0000-0001-000000000004', 'd0000000-0000-0000-0004-000000000001', true, 1.0),
('d0400000-0000-0000-0001-000000000005', 'd0000000-0000-0000-0004-000000000001', true, 1.0),
('d0400000-0000-0000-0001-000000000006', 'd0000000-0000-0000-0004-000000000001', true, 1.0),
('d0400000-0000-0000-0001-000000000007', 'd0000000-0000-0000-0004-000000000001', true, 1.0),

-- Skill MA-12: Target Profit Analysis
('d0400000-0000-0000-0002-000000000001', 'd0000000-0000-0000-0004-000000000002', true, 1.0),
('d0400000-0000-0000-0002-000000000002', 'd0000000-0000-0000-0004-000000000002', true, 1.0),
('d0400000-0000-0000-0002-000000000003', 'd0000000-0000-0000-0004-000000000002', true, 1.0),
('d0400000-0000-0000-0002-000000000004', 'd0000000-0000-0000-0004-000000000002', true, 1.0),
('d0400000-0000-0000-0002-000000000005', 'd0000000-0000-0000-0004-000000000002', true, 1.0),

-- Skill MA-13: Margin of Safety
('d0400000-0000-0000-0003-000000000001', 'd0000000-0000-0000-0004-000000000003', true, 1.0),
('d0400000-0000-0000-0003-000000000002', 'd0000000-0000-0000-0004-000000000003', true, 1.0),
('d0400000-0000-0000-0003-000000000003', 'd0000000-0000-0000-0004-000000000003', true, 1.0),
('d0400000-0000-0000-0003-000000000004', 'd0000000-0000-0000-0004-000000000003', true, 1.0),
('d0400000-0000-0000-0003-000000000005', 'd0000000-0000-0000-0004-000000000003', true, 1.0),

-- Skill MA-14: Operating Leverage
('d0400000-0000-0000-0004-000000000001', 'd0000000-0000-0000-0004-000000000004', true, 1.0),
('d0400000-0000-0000-0004-000000000002', 'd0000000-0000-0000-0004-000000000004', true, 1.0),
('d0400000-0000-0000-0004-000000000003', 'd0000000-0000-0000-0004-000000000004', true, 1.0),
('d0400000-0000-0000-0004-000000000004', 'd0000000-0000-0000-0004-000000000004', true, 1.0),
('d0400000-0000-0000-0004-000000000005', 'd0000000-0000-0000-0004-000000000004', true, 1.0),

-- Skill MA-15: Sales Mix Analysis
('d0400000-0000-0000-0005-000000000001', 'd0000000-0000-0000-0004-000000000005', true, 1.0),
('d0400000-0000-0000-0005-000000000002', 'd0000000-0000-0000-0004-000000000005', true, 1.0),
('d0400000-0000-0000-0005-000000000003', 'd0000000-0000-0000-0004-000000000005', true, 1.0),
('d0400000-0000-0000-0005-000000000004', 'd0000000-0000-0000-0004-000000000005', true, 1.0),
('d0400000-0000-0000-0005-000000000005', 'd0000000-0000-0000-0004-000000000005', true, 1.0),
('d0400000-0000-0000-0005-000000000006', 'd0000000-0000-0000-0004-000000000005', true, 1.0);

