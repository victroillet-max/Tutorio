-- ============================================
-- Modules 5-6: Equations and Functions Activities
-- Key Skills: Linear Equations, Systems, Functions, Graphs
-- ============================================

-- ============================================
-- SKILL: Linear Equations (EQ-01)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

(
  'b0500000-0000-0000-0001-000000000001',
  'b0000000-0000-0000-0000-000000000005',
  '5.1.1',
  1,
  'Solving Linear Equations',
  'solving-linear-equations',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Solving Linear Equations\n\n## What is a Linear Equation?\n\nA linear equation has variables raised only to the first power:\n$$ax + b = c$$\n\nExamples:\n- 2x + 5 = 11 (linear)\n- 3x - 7 = 2x + 4 (linear)\n- x² + 2 = 6 (NOT linear - has x²)\n\n---\n\n## The Balance Method\n\n:::concept{title=\"Golden Rule\"}\nWhatever you do to one side, you must do to the other side.\n:::\n\n---\n\n## Step-by-Step Process\n\n### Example: Solve 3x + 7 = 22\n\n| Step | Operation | Result |\n|------|-----------|--------|\n| 1 | Start | 3x + 7 = 22 |\n| 2 | Subtract 7 from both sides | 3x = 15 |\n| 3 | Divide both sides by 3 | x = 5 |\n| 4 | Check: 3(5) + 7 = 22 ✓ | Solution verified |\n\n---\n\n## Variables on Both Sides\n\n### Example: Solve 5x - 3 = 2x + 9\n\n| Step | Operation | Result |\n|------|-----------|--------|\n| 1 | Subtract 2x from both sides | 3x - 3 = 9 |\n| 2 | Add 3 to both sides | 3x = 12 |\n| 3 | Divide by 3 | x = 4 |\n\n---\n\n## Business Application: Break-Even Analysis\n\n### Example\nFixed costs: CHF 5,000\nVariable cost per unit: CHF 20\nSelling price per unit: CHF 35\n\n**Break-even equation:**\n$$35x = 20x + 5000$$\n$$15x = 5000$$\n$$x = 333.33 ≈ 334 \\text{ units}$$\n\n---\n\n:::takeaways\n- Linear equations have variables to the first power only\n- Use inverse operations to isolate the variable\n- Always check your solution in the original equation\n- Business applications include break-even analysis\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0500000-0000-0000-0001-000000000002',
  'b0000000-0000-0000-0000-000000000005',
  '5.1.2',
  2,
  'Linear Equations Quiz',
  'linear-equations-quiz',
  'quiz',
  10,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Solve: 2x + 8 = 20",
        "options": ["x = 6", "x = 14", "x = 4", "x = 10"],
        "correct": 0,
        "explanation": "2x = 20 - 8 = 12, so x = 6"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Solve: 4x - 5 = 2x + 7",
        "options": ["x = 6", "x = 1", "x = 3", "x = 12"],
        "correct": 0,
        "explanation": "4x - 2x = 7 + 5, so 2x = 12, x = 6"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Break-even: Revenue = 50x, Cost = 30x + 2000. Units needed?",
        "options": ["100 units", "50 units", "200 units", "67 units"],
        "correct": 0,
        "explanation": "50x = 30x + 2000, 20x = 2000, x = 100"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0500000-0000-0000-0001-000000000003',
  'b0000000-0000-0000-0000-000000000005',
  '5.1.3',
  3,
  'Linear Equations Checkpoint',
  'linear-equations-checkpoint',
  'checkpoint',
  8,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Solve: 7x - 3 = 25",
        "options": ["x = 4", "x = 3.14", "x = 22/7", "x = 28"],
        "correct": 0,
        "explanation": "7x = 28, x = 4"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Solve: 3(x + 2) = 21",
        "options": ["x = 5", "x = 7", "x = 6.33", "x = 3"],
        "correct": 0,
        "explanation": "3x + 6 = 21, 3x = 15, x = 5"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Which is NOT a linear equation?",
        "options": ["x² + 3 = 12", "2x + 5 = 11", "x/3 = 7", "5x = 20"],
        "correct": 0,
        "explanation": "x² makes it quadratic, not linear"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Systems of Two Equations (EQ-04)
-- ============================================

(
  'b0500000-0000-0000-0004-000000000001',
  'b0000000-0000-0000-0000-000000000005',
  '5.4.1',
  4,
  'Systems of Equations',
  'systems-of-equations',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Systems of Equations\n\n## What is a System?\n\nTwo or more equations with the same variables, solved simultaneously:\n\n$$\\begin{cases} 2x + y = 10 \\\\ x - y = 2 \\end{cases}$$\n\n---\n\n## Method 1: Substitution\n\n1. Solve one equation for one variable\n2. Substitute into the other equation\n3. Solve for the remaining variable\n4. Back-substitute to find the first variable\n\n### Example\n$$\\begin{cases} y = 2x + 1 \\\\ 3x + y = 11 \\end{cases}$$\n\nSubstitute y into second equation:\n$$3x + (2x + 1) = 11$$\n$$5x = 10$$\n$$x = 2$$\n\nThen: y = 2(2) + 1 = 5\n\n**Solution: (2, 5)**\n\n---\n\n## Method 2: Elimination\n\n1. Multiply equations to get equal coefficients\n2. Add or subtract to eliminate one variable\n3. Solve for the remaining variable\n\n### Example\n$$\\begin{cases} 2x + 3y = 12 \\\\ x + y = 5 \\end{cases}$$\n\nMultiply second by 2: 2x + 2y = 10\n\nSubtract: (2x + 3y) - (2x + 2y) = 12 - 10\n$$y = 2$$\n\nSubstitute: x + 2 = 5, so x = 3\n\n**Solution: (3, 2)**\n\n---\n\n## Business Application: Supply and Demand\n\nSupply: P = 2Q + 10\nDemand: P = -Q + 40\n\nAt equilibrium, Supply = Demand:\n$$2Q + 10 = -Q + 40$$\n$$3Q = 30$$\n$$Q = 10, P = 30$$\n\n---\n\n:::takeaways\n- Systems have multiple equations with shared variables\n- Substitution: Solve one equation, substitute into another\n- Elimination: Add/subtract to remove a variable\n- Used for equilibrium, optimization, and resource allocation\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0500000-0000-0000-0004-000000000002',
  'b0000000-0000-0000-0000-000000000005',
  '5.4.2',
  5,
  'Systems of Equations Checkpoint',
  'systems-equations-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Solve: x + y = 7, x - y = 3",
        "options": ["x = 5, y = 2", "x = 4, y = 3", "x = 2, y = 5", "x = 3, y = 4"],
        "correct": 0,
        "explanation": "Add equations: 2x = 10, x = 5. Then y = 7 - 5 = 2"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Which method isolates a variable first?",
        "options": ["Substitution", "Elimination", "Both", "Neither"],
        "correct": 0,
        "explanation": "Substitution requires solving for one variable and substituting."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Solve: 2x + y = 8, x + y = 5",
        "options": ["x = 3, y = 2", "x = 2, y = 3", "x = 4, y = 1", "x = 1, y = 4"],
        "correct": 0,
        "explanation": "Subtract: x = 3. Then y = 5 - 3 = 2"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Function Notation (FG-01)
-- ============================================

(
  'b0600000-0000-0000-0001-000000000001',
  'b0000000-0000-0000-0000-000000000006',
  '6.1.1',
  1,
  'Understanding Functions',
  'understanding-functions',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Understanding Functions\n\n## What is a Function?\n\nA function is a rule that assigns exactly ONE output to each input.\n\n$$f(x) = 2x + 3$$\n\n- **f** is the function name\n- **x** is the input (independent variable)\n- **f(x)** is the output (dependent variable)\n\n---\n\n## Function Notation\n\n:::concept{title=\"Reading f(x)\"}\n\"f of x\" means \"the value of function f when the input is x\"\n:::\n\n### Evaluating Functions\n\nIf f(x) = 3x - 5:\n\n| Input | Calculation | Output |\n|-------|-------------|--------|\n| f(2) | 3(2) - 5 | 1 |\n| f(0) | 3(0) - 5 | -5 |\n| f(-1) | 3(-1) - 5 | -8 |\n| f(a) | 3a - 5 | 3a - 5 |\n\n---\n\n## Domain and Range\n\n- **Domain**: All possible input values (x)\n- **Range**: All possible output values (f(x))\n\n### Example\nFor f(x) = 1/x:\n- Domain: All x except 0 (can''t divide by zero)\n- Range: All y except 0\n\n---\n\n## Business Functions\n\n| Function | Meaning |\n|----------|--------|\n| C(x) = 500 + 10x | Cost function: Fixed + Variable |\n| R(x) = 25x | Revenue function: Price × Quantity |\n| P(x) = R(x) - C(x) | Profit function |\n\n---\n\n:::takeaways\n- Functions map inputs to exactly one output\n- f(x) notation: function name, input variable, output value\n- Domain = valid inputs, Range = possible outputs\n- Business uses: cost, revenue, profit functions\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0001-000000000002',
  'b0000000-0000-0000-0000-000000000006',
  '6.1.2',
  2,
  'Function Notation Checkpoint',
  'function-notation-checkpoint',
  'checkpoint',
  8,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "If f(x) = 4x - 7, what is f(3)?",
        "options": ["5", "12", "19", "-19"],
        "correct": 0,
        "explanation": "f(3) = 4(3) - 7 = 12 - 7 = 5"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "What is the domain of f(x) = sqrt(x)?",
        "options": ["x >= 0", "All real numbers", "x > 0", "x != 0"],
        "correct": 0,
        "explanation": "Can''t take square root of negative numbers, so x >= 0"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "If C(x) = 1000 + 25x, what does C(50) represent?",
        "options": ["Cost of producing 50 units", "Revenue from 50 units", "Profit on 50 units", "Price per unit"],
        "correct": 0,
        "explanation": "C(50) = 1000 + 25(50) = CHF 2,250 total cost for 50 units"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Linear Functions (FG-02)
-- ============================================

(
  'b0600000-0000-0000-0002-000000000001',
  'b0000000-0000-0000-0000-000000000006',
  '6.2.1',
  3,
  'Linear Functions and Graphs',
  'linear-functions-graphs',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Linear Functions and Graphs\n\n## The Linear Function Form\n\n$$f(x) = mx + b$$\n\nOr equivalently: $$y = mx + b$$\n\n- **m** = slope (rate of change)\n- **b** = y-intercept (where line crosses y-axis)\n\n---\n\n## Understanding Slope\n\n$$m = \\frac{\\text{Rise}}{\\text{Run}} = \\frac{y_2 - y_1}{x_2 - x_1}$$\n\n| Slope | Direction |\n|-------|----------|\n| m > 0 | Line goes up (positive correlation) |\n| m < 0 | Line goes down (negative correlation) |\n| m = 0 | Horizontal line |\n| undefined | Vertical line |\n\n---\n\n## Graphing a Linear Function\n\n### Method 1: Slope-Intercept\n1. Plot the y-intercept (0, b)\n2. Use slope to find another point\n3. Connect with a straight line\n\n### Method 2: Two Points\n1. Find two points by substituting x values\n2. Connect with a straight line\n\n---\n\n## Business Interpretation\n\n### Cost Function: C(x) = 500 + 20x\n\n- **b = 500**: Fixed costs (even if x = 0)\n- **m = 20**: Variable cost per unit\n- Slope = marginal cost\n\n### Revenue Function: R(x) = 35x\n\n- **b = 0**: No revenue without sales\n- **m = 35**: Price per unit\n\n---\n\n:::takeaways\n- Linear functions have constant rate of change (slope)\n- y = mx + b: m is slope, b is y-intercept\n- Positive slope = increasing, negative = decreasing\n- In business: slope often represents marginal cost/revenue\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0002-000000000002',
  'b0000000-0000-0000-0000-000000000006',
  '6.2.2',
  4,
  'Linear Functions Checkpoint',
  'linear-functions-checkpoint',
  'checkpoint',
  8,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "What is the slope of y = 3x - 7?",
        "options": ["3", "-7", "3x", "-3"],
        "correct": 0,
        "explanation": "In y = mx + b form, m (slope) = 3"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Find the y-intercept of y = -2x + 5",
        "options": ["(0, 5)", "(5, 0)", "(0, -2)", "(2, 5)"],
        "correct": 0,
        "explanation": "Y-intercept is where x = 0, so y = 5. Point is (0, 5)"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "A line passes through (0, 4) and (2, 10). What is the slope?",
        "options": ["3", "2", "6", "5"],
        "correct": 0,
        "explanation": "m = (10 - 4)/(2 - 0) = 6/2 = 3"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "If C(x) = 800 + 15x, what is the marginal cost?",
        "options": ["CHF 15", "CHF 800", "CHF 815", "CHF 53.33"],
        "correct": 0,
        "explanation": "Marginal cost is the slope = 15 CHF per additional unit"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content;

-- ============================================
-- Activity Skill Tags for Module 5-6
-- ============================================

-- Skill: Linear Equations (EQ-01)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0500000-0000-0000-0001-000000000001', 'c0000000-0000-0000-0005-000000000001', true, 1, true, true, 1.0),
('b0500000-0000-0000-0001-000000000002', 'c0000000-0000-0000-0005-000000000001', true, 2, true, true, 1.0),
('b0500000-0000-0000-0001-000000000003', 'c0000000-0000-0000-0005-000000000001', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Systems of Two Equations (EQ-04)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0500000-0000-0000-0004-000000000001', 'c0000000-0000-0000-0005-000000000004', true, 1, true, true, 1.0),
('b0500000-0000-0000-0004-000000000002', 'c0000000-0000-0000-0005-000000000004', true, 2, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Function Notation (FG-01)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0600000-0000-0000-0001-000000000001', 'c0000000-0000-0000-0006-000000000001', true, 1, true, true, 1.0),
('b0600000-0000-0000-0001-000000000002', 'c0000000-0000-0000-0006-000000000001', true, 2, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Linear Functions (FG-02)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0600000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0006-000000000002', true, 1, true, true, 1.0),
('b0600000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0006-000000000002', true, 2, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

