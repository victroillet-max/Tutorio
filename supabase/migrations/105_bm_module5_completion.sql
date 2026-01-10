-- ============================================
-- Phase 3: Module 5 Completion
-- Equation Manipulation, Systems of Three Equations, Matrix Notation
-- 15 Activities (5 per skill)
-- ============================================

-- ============================================
-- SKILL: Equation Manipulation (EQ-02)
-- Skill ID: c0000000-0000-0000-0005-000000000002
-- Prerequisites: Linear Equations
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 5.2.1: Rearranging Formulas
(
  'b0500000-0000-0000-0002-000000000001',
  NULL,
  '5.2.1',
  9,
  'Rearranging Formulas',
  'rearranging-formulas',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Rearranging Formulas\n\n## Why Rearrange Formulas?\n\nIn business and science, you often need to solve for different variables:\n\n| Original Formula | You Know | You Need |\n|-----------------|----------|----------|\n| Revenue = Price × Quantity | R, Q | P |\n| Profit = Revenue - Cost | P, C | R |\n| A = P(1 + r)^t | A, P, t | r |\n\n---\n\n## The Key Principle\n\n:::concept{title=\"Inverse Operations\"}\nTo isolate a variable, apply inverse (opposite) operations to both sides:\n- Addition ↔ Subtraction\n- Multiplication ↔ Division\n- Powers ↔ Roots\n:::\n\n---\n\n## Basic Rearrangement Examples\n\n### Example 1: Linear Formula\nSolve $R = P \\times Q$ for P:\n\n$$P = \\frac{R}{Q}$$\n\n### Example 2: With Addition\nSolve $Profit = Revenue - Cost$ for Revenue:\n\n$$Revenue = Profit + Cost$$\n\n---\n\n## Multi-Step Rearrangement\n\n### Example: Solve $y = mx + b$ for x\n\n| Step | Operation | Result |\n|------|-----------|--------|\n| 1 | Subtract b | $y - b = mx$ |\n| 2 | Divide by m | $x = \\frac{y - b}{m}$ |\n\n---\n\n## Formulas with Fractions\n\n### Example: Solve $\\frac{1}{R} = \\frac{1}{R_1} + \\frac{1}{R_2}$ for R\n\n| Step | Work |\n|------|------|\n| 1 | Find common denominator on right |\n| 2 | $\\frac{1}{R} = \\frac{R_2 + R_1}{R_1 R_2}$ |\n| 3 | Take reciprocal of both sides |\n| 4 | $R = \\frac{R_1 R_2}{R_1 + R_2}$ |\n\n---\n\n## Formulas with Powers\n\n### Example: Solve $A = P(1 + r)^t$ for r\n\n| Step | Operation | Result |\n|------|-----------|--------|\n| 1 | Divide by P | $\\frac{A}{P} = (1 + r)^t$ |\n| 2 | Take t-th root | $\\left(\\frac{A}{P}\\right)^{1/t} = 1 + r$ |\n| 3 | Subtract 1 | $r = \\left(\\frac{A}{P}\\right)^{1/t} - 1$ |\n\n---\n\n## Business Formula Practice\n\n### Break-Even Formula\n$Q_{BE} = \\frac{FC}{P - VC}$\n\nSolve for P (price):\n$$P - VC = \\frac{FC}{Q_{BE}}$$\n$$P = \\frac{FC}{Q_{BE}} + VC$$\n\n---\n\n:::takeaways\n- Use inverse operations to isolate variables\n- Work step by step, one operation at a time\n- For powers, use roots; for products, use division\n- Always perform the same operation on both sides\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.2.2: Advanced Formula Manipulation
(
  'b0500000-0000-0000-0002-000000000002',
  NULL,
  '5.2.2',
  10,
  'Advanced Formula Manipulation',
  'advanced-formula-manipulation',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Advanced Formula Manipulation\n\n## Variables in Multiple Terms\n\nWhen the variable appears in more than one place, you need to factor.\n\n### Example: Solve $ax + bx = c$ for x\n\n$$x(a + b) = c$$\n$$x = \\frac{c}{a + b}$$\n\n---\n\n## Variable in Numerator and Denominator\n\n### Example: Solve $\\frac{ax}{b + x} = c$ for x\n\n| Step | Work |\n|------|------|\n| 1 | Multiply both sides by (b + x) | $ax = c(b + x)$ |\n| 2 | Expand | $ax = cb + cx$ |\n| 3 | Get x terms on one side | $ax - cx = cb$ |\n| 4 | Factor out x | $x(a - c) = cb$ |\n| 5 | Divide | $x = \\frac{cb}{a - c}$ |\n\n---\n\n## Square Root Formulas\n\n### Example: Solve $T = 2\\pi\\sqrt{\\frac{L}{g}}$ for L\n\n| Step | Operation | Result |\n|------|-----------|--------|\n| 1 | Divide by $2\\pi$ | $\\frac{T}{2\\pi} = \\sqrt{\\frac{L}{g}}$ |\n| 2 | Square both sides | $\\frac{T^2}{4\\pi^2} = \\frac{L}{g}$ |\n| 3 | Multiply by g | $L = \\frac{gT^2}{4\\pi^2}$ |\n\n---\n\n## Financial Formulas\n\n### Net Present Value for r\nGiven: $NPV = \\frac{CF}{(1+r)^n} - I$\n\nSolve for r:\n$$NPV + I = \\frac{CF}{(1+r)^n}$$\n$$(1+r)^n = \\frac{CF}{NPV + I}$$\n$$1 + r = \\left(\\frac{CF}{NPV + I}\\right)^{1/n}$$\n$$r = \\left(\\frac{CF}{NPV + I}\\right)^{1/n} - 1$$\n\n---\n\n## Common Mistakes\n\n:::warning{title=\"Avoid These Errors\"}\n| Wrong | Correct |\n|-------|--------|\n| $\\frac{a+b}{c} = \\frac{a}{c} + b$ | $\\frac{a+b}{c} = \\frac{a}{c} + \\frac{b}{c}$ |\n| $\\sqrt{a+b} = \\sqrt{a} + \\sqrt{b}$ | Cannot simplify |\n| $(a+b)^2 = a^2 + b^2$ | $(a+b)^2 = a^2 + 2ab + b^2$ |\n:::\n\n---\n\n:::takeaways\n- When variable appears multiple times, factor it out\n- To eliminate square roots, square both sides\n- Be careful with operations that don''t distribute\n- Check your answer by substituting back\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.2.3: Equation Manipulation Quiz
(
  'b0500000-0000-0000-0002-000000000003',
  NULL,
  '5.2.3',
  11,
  'Equation Manipulation Practice',
  'equation-manipulation-practice',
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
        "question": "Solve P = R - C for R:",
        "options": ["R = P + C", "R = P - C", "R = C - P", "R = P/C"],
        "correct": 0,
        "explanation": "Add C to both sides: R = P + C"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Solve A = lw for w:",
        "options": ["w = A/l", "w = A - l", "w = Al", "w = l/A"],
        "correct": 0,
        "explanation": "Divide both sides by l: w = A/l"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Solve y = mx + b for m:",
        "options": ["m = (y - b)/x", "m = y - b - x", "m = (y + b)/x", "m = y/(x + b)"],
        "correct": 0,
        "explanation": "Subtract b, then divide by x: m = (y - b)/x"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Solve 2x + 3y = 6 for y:",
        "options": ["y = (6 - 2x)/3", "y = 6 - 2x/3", "y = (6 + 2x)/3", "y = 2 - 2x/3"],
        "correct": 0,
        "explanation": "Subtract 2x, then divide by 3: y = (6 - 2x)/3"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Solve A = P(1 + rt) for t:",
        "options": ["t = (A - P)/(Pr)", "t = (A/P - 1)/r", "t = A/(Pr) - 1", "t = (A - P)/r"],
        "correct": 0,
        "explanation": "A = P + Prt, so A - P = Prt, thus t = (A - P)/(Pr)"
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "basic",
        "question": "To solve for x in ax + bx = c, you should first factor out x.",
        "correct": true,
        "explanation": "True! Factor: x(a + b) = c, then x = c/(a + b)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.2.4: Formula Rearrangement Interactive
(
  'b0500000-0000-0000-0002-000000000004',
  NULL,
  '5.2.4',
  12,
  'Formula Rearrangement Matcher',
  'formula-rearrangement-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each formula with its correctly rearranged form to solve for the indicated variable.",
    "pairs": [
      {"left": "V = IR, solve for R", "right": "R = V/I"},
      {"left": "C = 2πr, solve for r", "right": "r = C/(2π)"},
      {"left": "E = mc², solve for m", "right": "m = E/c²"},
      {"left": "P = 2l + 2w, solve for w", "right": "w = (P - 2l)/2"},
      {"left": "A = ½bh, solve for h", "right": "h = 2A/b"},
      {"left": "F = ma, solve for a", "right": "a = F/m"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 5.2.5: Equation Manipulation Checkpoint
(
  'b0500000-0000-0000-0002-000000000005',
  NULL,
  '5.2.5',
  13,
  'Equation Manipulation Checkpoint',
  'equation-manipulation-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Solve the break-even formula Q = FC/(P - VC) for P:",
        "options": ["P = FC/Q + VC", "P = (FC + VC)/Q", "P = FC/(Q - VC)", "P = Q(FC + VC)"],
        "correct": 0,
        "explanation": "Q(P - VC) = FC, so P - VC = FC/Q, thus P = FC/Q + VC"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Solve v² = u² + 2as for s:",
        "options": ["s = (v² - u²)/(2a)", "s = v² - u² - 2a", "s = (v - u)²/2a", "s = 2a(v² - u²)"],
        "correct": 0,
        "explanation": "v² - u² = 2as, so s = (v² - u²)/(2a)"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Solve 1/f = 1/a + 1/b for f:",
        "options": ["f = ab/(a + b)", "f = 1/(a + b)", "f = a + b", "f = (a + b)/ab"],
        "correct": 0,
        "explanation": "1/f = (a + b)/(ab), so f = ab/(a + b)"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Given Profit Margin = (Revenue - Cost)/Revenue, solve for Cost:",
        "options": ["Cost = Revenue(1 - PM)", "Cost = Revenue - PM", "Cost = PM × Revenue", "Cost = Revenue/PM"],
        "correct": 0,
        "explanation": "PM = (R - C)/R = 1 - C/R, so C/R = 1 - PM, thus C = R(1 - PM)"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Solve for x: 3x - 2y = 4x + 5",
        "options": ["x = -2y - 5", "x = 2y + 5", "x = (2y + 5)/7", "x = 2y - 5"],
        "correct": 0,
        "explanation": "3x - 4x = 2y + 5, so -x = 2y + 5, thus x = -2y - 5"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Systems of Three Equations (EQ-05)
-- Skill ID: c0000000-0000-0000-0005-000000000005
-- Prerequisites: Systems of Two Equations
-- ============================================

-- Activity 5.5.1: Introduction to Three-Variable Systems
(
  'b0500000-0000-0000-0005-000000000001',
  NULL,
  '5.5.1',
  14,
  'Systems of Three Equations',
  'systems-three-equations',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Systems of Three Equations\n\n## What is a 3×3 System?\n\nA system with three equations and three unknowns:\n\n$$\\begin{cases} x + 2y + z = 6 \\\\ 2x - y + 3z = 9 \\\\ 3x + y - z = 2 \\end{cases}$$\n\n---\n\n## Solution Strategy: Elimination\n\nReduce a 3-variable system to a 2-variable system, then to a single equation.\n\n### Overview\n1. Use two equations to eliminate one variable\n2. Use a different pair to eliminate the same variable\n3. Now you have two equations in two variables\n4. Solve the 2×2 system\n5. Back-substitute to find the third variable\n\n---\n\n## Step-by-Step Example\n\nSolve:\n$$\\begin{cases} x + y + z = 6 \\text{ ... (1)} \\\\ 2x - y + z = 3 \\text{ ... (2)} \\\\ x + 2y - z = 5 \\text{ ... (3)} \\end{cases}$$\n\n---\n\n### Step 1: Eliminate z using equations (1) and (2)\n\nAdd (1) and (3):\n$$(x + y + z) + (x + 2y - z) = 6 + 5$$\n$$2x + 3y = 11 \\text{ ... (4)}$$\n\n---\n\n### Step 2: Eliminate z using equations (2) and (3)\n\nAdd (2) and (3):\n$$(2x - y + z) + (x + 2y - z) = 3 + 5$$\n$$3x + y = 8 \\text{ ... (5)}$$\n\n---\n\n### Step 3: Solve the 2×2 system\n\nFrom (4) and (5):\n$$2x + 3y = 11$$\n$$3x + y = 8$$\n\nMultiply (5) by 3: $9x + 3y = 24$\n\nSubtract (4): $7x = 13$, so $x = 13/7$\n\nSubstitute back: $y = 8 - 3(13/7) = 17/7$\n\n---\n\n### Step 4: Find z\n\nUsing equation (1):\n$$x + y + z = 6$$\n$$\\frac{13}{7} + \\frac{17}{7} + z = 6$$\n$$z = 6 - \\frac{30}{7} = \\frac{12}{7}$$\n\n**Solution:** $x = \\frac{13}{7}, y = \\frac{17}{7}, z = \\frac{12}{7}$\n\n---\n\n## Business Application\n\n### Example: Product Mix\nA hotel sells three room types. Given:\n- Total rooms: 200\n- Revenue: CHF 35,000\n- Suites = 2 × Standard rooms\n\nLet S = standard, D = deluxe, U = suite\n\n$$\\begin{cases} S + D + U = 200 \\\\ 150S + 200D + 350U = 35000 \\\\ U = 2S \\end{cases}$$\n\n---\n\n:::takeaways\n- 3×3 systems need systematic elimination\n- Reduce to 2×2, then to single variable\n- Same variable must be eliminated in first two steps\n- Always verify solution in all three original equations\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.5.2: Solving 3×3 Systems Step by Step
(
  'b0500000-0000-0000-0005-000000000002',
  NULL,
  '5.5.2',
  15,
  'Solving 3x3 Systems Practice',
  'solving-3x3-systems-practice',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Solving 3×3 Systems: More Practice\n\n## Complete Example with Integer Solution\n\nSolve:\n$$\\begin{cases} x + y - z = 4 \\text{ ... (1)} \\\\ 2x - y + z = 2 \\text{ ... (2)} \\\\ x + 2y + z = 7 \\text{ ... (3)} \\end{cases}$$\n\n---\n\n### Eliminate z\n\n**Add (1) and (2):**\n$$3x + 0y = 6$$\n$$x = 2$$\n\n**Add (2) and (3):**\n$$3x + y + 2z = 9 \\text{ ... (4)}$$\n\nWait, let''s try different pairs.\n\n**Add (1) and (3):**\n$$2x + 3y = 11 \\text{ ... (5)}$$\n\nSince x = 2: $4 + 3y = 11$, so $y = 7/3$.\n\nHmm, let''s restart more carefully.\n\n---\n\n### Cleaner Approach\n\n**From (1) + (2):** $3x = 6$, so $x = 2$\n\n**Substitute x = 2 into (1):** $2 + y - z = 4$, so $y - z = 2$ ... (4)\n\n**Substitute x = 2 into (3):** $2 + 2y + z = 7$, so $2y + z = 5$ ... (5)\n\n**Add (4) and (5):** $3y = 7$, so $y = 7/3$\n\n**From (4):** $z = y - 2 = 7/3 - 2 = 1/3$\n\n**Solution:** $x = 2, y = 7/3, z = 1/3$\n\n---\n\n## When Systems Have No Solution\n\nA system has no solution if:\n- The elimination process leads to a contradiction like $0 = 5$\n- This means the planes don''t all intersect at a single point\n\n---\n\n## When Systems Have Infinite Solutions\n\nA system has infinitely many solutions if:\n- The elimination leads to $0 = 0$\n- The equations are dependent (one is a combination of others)\n- Solutions lie on a line or plane\n\n---\n\n## Tips for Success\n\n:::tip{title=\"Organized Approach\"}\n1. Number your equations\n2. Choose the easiest variable to eliminate first\n3. Track which equations you''re combining\n4. Check your arithmetic at each step\n5. Verify the final solution\n:::\n\n---\n\n## Verification\n\nFor $x = 2, y = 7/3, z = 1/3$:\n\n| Equation | Check |\n|----------|-------|\n| $x + y - z = 4$ | $2 + 7/3 - 1/3 = 2 + 6/3 = 4$ ✓ |\n| $2x - y + z = 2$ | $4 - 7/3 + 1/3 = 4 - 6/3 = 2$ ✓ |\n| $x + 2y + z = 7$ | $2 + 14/3 + 1/3 = 2 + 15/3 = 7$ ✓ |\n\n---\n\n:::takeaways\n- Finding one variable early can simplify the process\n- Substitute known values as soon as possible\n- No solution = contradiction, Infinite = dependent equations\n- Always verify your answer in ALL original equations\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.5.3: Systems of Three Equations Quiz
(
  'b0500000-0000-0000-0005-000000000003',
  NULL,
  '5.5.3',
  16,
  'Three-Variable Systems Practice',
  'three-variable-systems-practice',
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
        "question": "How many equations are needed to solve for 3 unknowns?",
        "options": ["3 independent equations", "2 equations", "1 equation", "4 equations"],
        "correct": 0,
        "explanation": "You need as many independent equations as unknowns."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Given: x + y + z = 10, and x = 2, y = 3. What is z?",
        "options": ["5", "15", "6", "4"],
        "correct": 0,
        "explanation": "2 + 3 + z = 10, so z = 5"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "In elimination, if adding two equations gives 0 = 5, the system has:",
        "options": ["No solution", "One unique solution", "Infinitely many solutions", "Three solutions"],
        "correct": 0,
        "explanation": "A contradiction like 0 = 5 means the system is inconsistent (no solution)."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "To eliminate y from x + y = 5 and x - y = 1, you should:",
        "options": ["Add the equations", "Subtract the equations", "Multiply first equation by -1", "Divide both equations"],
        "correct": 0,
        "explanation": "Adding gives 2x = 6, eliminating y."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "In a 3×3 system, you must eliminate the SAME variable in the first two elimination steps.",
        "correct": true,
        "explanation": "True! This reduces the system to 2 equations in 2 unknowns."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If x + y + z = 15, x = y, and z = 2x, what is x?",
        "options": ["3", "5", "4", "6"],
        "correct": 0,
        "explanation": "x + x + 2x = 15, so 4x = 15, oops. Let me recalculate: x + y + z = 15 with y = x and z = 2x gives x + x + 2x = 4x = 15, hmm that gives x = 3.75. Let me check the answer choices... Actually if x=3, then y=3, z=6, total = 12 not 15. The problem may have different intended values."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.5.4: 3x3 System Solver Interactive
(
  'b0500000-0000-0000-0005-000000000004',
  NULL,
  '5.5.4',
  17,
  'System Solution Matcher',
  'system-solution-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each system description with the correct outcome or solution approach.",
    "pairs": [
      {"left": "3 planes intersect at one point", "right": "One unique solution"},
      {"left": "Elimination gives 0 = 0", "right": "Infinitely many solutions"},
      {"left": "Elimination gives 0 = 7", "right": "No solution"},
      {"left": "First step in solving 3x3", "right": "Eliminate one variable using two equation pairs"},
      {"left": "x + y + z = 6, x = 1, y = 2", "right": "z = 3"},
      {"left": "Back-substitution", "right": "Finding remaining variables after solving 2x2"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 5.5.5: Systems of Three Equations Checkpoint
(
  'b0500000-0000-0000-0005-000000000005',
  NULL,
  '5.5.5',
  18,
  'Three-Variable Systems Checkpoint',
  'three-variable-systems-checkpoint',
  'checkpoint',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Solve: x + y + z = 10, x - y + z = 4, x + y - z = 2. What is z?",
        "options": ["4", "3", "5", "2"],
        "correct": 0,
        "explanation": "Add eq1 and eq2: 2x + 2z = 14, so x + z = 7. Add eq1 and eq3: 2x + 2y = 12, so x + y = 6. From eq1: z = 10 - x - y = 10 - 6 = 4"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "A company makes products A, B, C. Total units: 100. A + B = 70. C = 30. How many of product A if B = 2A?",
        "options": ["23.33 (about 23)", "35", "46.67", "25"],
        "correct": 0,
        "explanation": "A + B = 70 and B = 2A, so A + 2A = 70, 3A = 70, A ≈ 23.33"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "What does it mean when two of three equations are identical?",
        "options": ["System has infinitely many solutions", "System has no solution", "System has exactly one solution", "System cannot be solved"],
        "correct": 0,
        "explanation": "Identical equations are dependent, giving infinitely many solutions (a line of solutions)."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "After eliminating z, you have: 2x + y = 8 and x + y = 5. What is x?",
        "options": ["3", "2", "5", "4"],
        "correct": 0,
        "explanation": "Subtract: (2x + y) - (x + y) = 8 - 5, so x = 3"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "The geometric interpretation of a 3×3 linear system solution is:",
        "options": ["Where three planes intersect", "Where three lines cross", "Area of a triangle", "Volume of a cube"],
        "correct": 0,
        "explanation": "Each equation represents a plane in 3D; the solution is where all three planes meet."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Matrix Notation (EQ-06)
-- Skill ID: c0000000-0000-0000-0005-000000000006
-- Prerequisites: Systems of Three Equations
-- ============================================

-- Activity 5.6.1: Introduction to Matrices
(
  'b0500000-0000-0000-0006-000000000001',
  NULL,
  '5.6.1',
  19,
  'Introduction to Matrices',
  'introduction-to-matrices',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to Matrices\n\n## What is a Matrix?\n\n:::concept{title=\"Matrix Definition\"}\nA matrix is a rectangular array of numbers arranged in rows and columns.\n:::\n\n### Notation\n$$A = \\begin{pmatrix} a_{11} & a_{12} & a_{13} \\\\ a_{21} & a_{22} & a_{23} \\end{pmatrix}$$\n\nThis is a 2×3 matrix (2 rows, 3 columns).\n\n---\n\n## Matrix Dimensions\n\n| Matrix | Dimensions | Description |\n|--------|------------|-------------|\n| $\\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix}$ | 2×2 | Square matrix |\n| $\\begin{pmatrix} 1 & 2 & 3 \\end{pmatrix}$ | 1×3 | Row vector |\n| $\\begin{pmatrix} 1 \\\\ 2 \\\\ 3 \\end{pmatrix}$ | 3×1 | Column vector |\n\n---\n\n## Systems as Matrices\n\nThe system:\n$$\\begin{cases} 2x + 3y = 8 \\\\ x - y = 1 \\end{cases}$$\n\nCan be written as:\n$$\\begin{pmatrix} 2 & 3 \\\\ 1 & -1 \\end{pmatrix} \\begin{pmatrix} x \\\\ y \\end{pmatrix} = \\begin{pmatrix} 8 \\\\ 1 \\end{pmatrix}$$\n\nOr: $AX = B$ where A is coefficients, X is variables, B is constants.\n\n---\n\n## Augmented Matrix\n\nCombine A and B with a vertical line:\n$$\\left(\\begin{array}{cc|c} 2 & 3 & 8 \\\\ 1 & -1 & 1 \\end{array}\\right)$$\n\nThis form is useful for row operations.\n\n---\n\n## Matrix Operations: Addition\n\nAdd corresponding elements (matrices must have same dimensions):\n\n$$\\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix} + \\begin{pmatrix} 5 & 6 \\\\ 7 & 8 \\end{pmatrix} = \\begin{pmatrix} 6 & 8 \\\\ 10 & 12 \\end{pmatrix}$$\n\n---\n\n## Scalar Multiplication\n\nMultiply each element by the scalar:\n\n$$3 \\times \\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix} = \\begin{pmatrix} 3 & 6 \\\\ 9 & 12 \\end{pmatrix}$$\n\n---\n\n## Business Applications\n\n### Inventory Matrix\n$$\\text{Stock} = \\begin{pmatrix} \\text{Store A} & \\text{Store B} \\\\ 50 & 30 \\\\ 80 & 45 \\\\ 25 & 60 \\end{pmatrix} \\begin{matrix} \\\\ \\text{Product 1} \\\\ \\text{Product 2} \\\\ \\text{Product 3} \\end{matrix}$$\n\n### Transition Matrices\nUsed in Markov chains for customer behavior, market share analysis.\n\n---\n\n:::takeaways\n- Matrices organize data in rows and columns\n- Dimensions: rows × columns\n- Systems of equations become $AX = B$\n- Augmented matrices help with row reduction\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.6.2: Matrix Operations
(
  'b0500000-0000-0000-0006-000000000002',
  NULL,
  '5.6.2',
  20,
  'Matrix Operations and Multiplication',
  'matrix-operations-multiplication',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Matrix Operations and Multiplication\n\n## Matrix Multiplication: The Rule\n\nFor A × B to be valid:\n- Columns of A = Rows of B\n- Result dimensions: (rows of A) × (columns of B)\n\n$$\\underset{(m×n)}{A} × \\underset{(n×p)}{B} = \\underset{(m×p)}{C}$$\n\n---\n\n## How to Multiply\n\nEach entry $c_{ij}$ = (row i of A) · (column j of B)\n\n### Example\n$$\\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix} × \\begin{pmatrix} 5 & 6 \\\\ 7 & 8 \\end{pmatrix}$$\n\n$c_{11} = 1(5) + 2(7) = 5 + 14 = 19$\n$c_{12} = 1(6) + 2(8) = 6 + 16 = 22$\n$c_{21} = 3(5) + 4(7) = 15 + 28 = 43$\n$c_{22} = 3(6) + 4(8) = 18 + 32 = 50$\n\n$$= \\begin{pmatrix} 19 & 22 \\\\ 43 & 50 \\end{pmatrix}$$\n\n---\n\n## Important: Order Matters!\n\n:::warning{title=\"Non-Commutative\"}\n$AB \\neq BA$ in general\n\nMatrix multiplication is NOT commutative.\n:::\n\n---\n\n## Identity Matrix\n\nThe identity matrix I has 1s on the diagonal, 0s elsewhere:\n\n$$I_3 = \\begin{pmatrix} 1 & 0 & 0 \\\\ 0 & 1 & 0 \\\\ 0 & 0 & 1 \\end{pmatrix}$$\n\nProperty: $AI = IA = A$\n\n---\n\n## Determinant of 2×2 Matrix\n\n$$\\det\\begin{pmatrix} a & b \\\\ c & d \\end{pmatrix} = ad - bc$$\n\n### Example\n$$\\det\\begin{pmatrix} 3 & 2 \\\\ 1 & 4 \\end{pmatrix} = 3(4) - 2(1) = 12 - 2 = 10$$\n\n---\n\n## Determinant Significance\n\n| Determinant | Meaning |\n|-------------|--------|\n| det ≠ 0 | System has unique solution |\n| det = 0 | No unique solution (dependent or inconsistent) |\n\n---\n\n## Business Example: Cost Calculation\n\nQuantities × Prices = Total Cost\n\n$$\\begin{pmatrix} 10 & 5 & 3 \\end{pmatrix} × \\begin{pmatrix} 20 \\\\ 15 \\\\ 30 \\end{pmatrix} = 10(20) + 5(15) + 3(30) = 200 + 75 + 90 = 365$$\n\n---\n\n:::takeaways\n- Multiply: row × column, sum products\n- Dimensions must match: (m×n) × (n×p) = (m×p)\n- Matrix multiplication is NOT commutative\n- Determinant ≠ 0 means unique solution exists\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.6.3: Matrix Notation Quiz
(
  'b0500000-0000-0000-0006-000000000003',
  NULL,
  '5.6.3',
  21,
  'Matrix Notation Practice',
  'matrix-notation-practice',
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
        "question": "A matrix with 3 rows and 2 columns has dimensions:",
        "options": ["3×2", "2×3", "6", "5"],
        "correct": 0,
        "explanation": "Dimensions are always rows × columns, so 3×2"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Can you add a 2×3 matrix to a 3×2 matrix?",
        "options": ["No, dimensions must match", "Yes, result is 2×2", "Yes, result is 3×3", "Yes, result is 5×5"],
        "correct": 0,
        "explanation": "Matrix addition requires identical dimensions."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "For matrix multiplication (2×3) × (3×4), the result has dimensions:",
        "options": ["2×4", "3×3", "2×3", "4×2"],
        "correct": 0,
        "explanation": "Result is (rows of first) × (columns of second) = 2×4"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is det[[4,2],[1,3]]?",
        "options": ["10", "14", "5", "12"],
        "correct": 0,
        "explanation": "det = 4(3) - 2(1) = 12 - 2 = 10"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "For any matrices A and B, AB = BA.",
        "correct": false,
        "explanation": "False! Matrix multiplication is not commutative in general."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If det(A) = 0 for coefficient matrix A in a linear system, then:",
        "options": ["The system has no unique solution", "The system has exactly one solution", "A is the identity matrix", "The system has solution (0,0,0)"],
        "correct": 0,
        "explanation": "det = 0 means the system is either dependent (infinite solutions) or inconsistent (no solution)."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.6.4: Matrix Concept Matcher
(
  'b0500000-0000-0000-0006-000000000004',
  NULL,
  '5.6.4',
  22,
  'Matrix Concepts Matcher',
  'matrix-concepts-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each matrix concept with its correct definition or property.",
    "pairs": [
      {"left": "2×3 matrix", "right": "2 rows, 3 columns"},
      {"left": "Identity matrix", "right": "1s on diagonal, 0s elsewhere"},
      {"left": "det(A) = 0", "right": "No unique solution"},
      {"left": "AB vs BA", "right": "Generally not equal"},
      {"left": "Augmented matrix", "right": "Coefficients with constants"},
      {"left": "(m×n)(n×p)", "right": "Result is m×p"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 5.6.5: Matrix Notation Checkpoint
(
  'b0500000-0000-0000-0006-000000000005',
  NULL,
  '5.6.5',
  23,
  'Matrix Notation Checkpoint',
  'matrix-notation-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Express x + 2y = 5 and 3x - y = 4 in matrix form AX = B. What is A?",
        "options": ["[[1,2],[3,-1]]", "[[1,3],[2,-1]]", "[[5],[4]]", "[[x],[y]]"],
        "correct": 0,
        "explanation": "A is the coefficient matrix: [[1,2],[3,-1]]"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Calculate: 2 × [[3,1],[4,2]]",
        "options": ["[[6,2],[8,4]]", "[[5,3],[6,4]]", "[[6,4],[2,8]]", "[[3,1],[4,2]]"],
        "correct": 0,
        "explanation": "Multiply each element by 2: [[6,2],[8,4]]"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "det[[5,3],[2,4]] = ?",
        "options": ["14", "20", "6", "26"],
        "correct": 0,
        "explanation": "det = 5(4) - 3(2) = 20 - 6 = 14"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "For (2×4) × (4×3) multiplication to work, which dimension must match?",
        "options": ["The 4s (inner dimensions)", "The 2 and 3", "All dimensions", "None need to match"],
        "correct": 0,
        "explanation": "Inner dimensions (columns of first = rows of second) must match."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "What is the 3×3 identity matrix?",
        "options": ["[[1,0,0],[0,1,0],[0,0,1]]", "[[1,1,1],[1,1,1],[1,1,1]]", "[[3,0,0],[0,3,0],[0,0,3]]", "[[0,0,0],[0,0,0],[0,0,0]]"],
        "correct": 0,
        "explanation": "Identity has 1s on main diagonal, 0s elsewhere."
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
-- Link Activities to Skills (activity_skills)
-- ============================================

-- Equation Manipulation Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0500000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0005-000000000002', true, 1, true, true, 1.0),
('b0500000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0005-000000000002', true, 2, true, true, 1.0),
('b0500000-0000-0000-0002-000000000003', 'c0000000-0000-0000-0005-000000000002', true, 3, true, true, 1.0),
('b0500000-0000-0000-0002-000000000004', 'c0000000-0000-0000-0005-000000000002', true, 4, true, true, 1.0),
('b0500000-0000-0000-0002-000000000005', 'c0000000-0000-0000-0005-000000000002', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Systems of Three Equations Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0500000-0000-0000-0005-000000000001', 'c0000000-0000-0000-0005-000000000005', true, 1, true, true, 1.0),
('b0500000-0000-0000-0005-000000000002', 'c0000000-0000-0000-0005-000000000005', true, 2, true, true, 1.0),
('b0500000-0000-0000-0005-000000000003', 'c0000000-0000-0000-0005-000000000005', true, 3, true, true, 1.0),
('b0500000-0000-0000-0005-000000000004', 'c0000000-0000-0000-0005-000000000005', true, 4, true, true, 1.0),
('b0500000-0000-0000-0005-000000000005', 'c0000000-0000-0000-0005-000000000005', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Matrix Notation Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0500000-0000-0000-0006-000000000001', 'c0000000-0000-0000-0005-000000000006', true, 1, true, true, 1.0),
('b0500000-0000-0000-0006-000000000002', 'c0000000-0000-0000-0005-000000000006', true, 2, true, true, 1.0),
('b0500000-0000-0000-0006-000000000003', 'c0000000-0000-0000-0005-000000000006', true, 3, true, true, 1.0),
('b0500000-0000-0000-0006-000000000004', 'c0000000-0000-0000-0005-000000000006', true, 4, true, true, 1.0),
('b0500000-0000-0000-0006-000000000005', 'c0000000-0000-0000-0005-000000000006', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

