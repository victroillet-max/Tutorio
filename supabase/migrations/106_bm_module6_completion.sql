-- ============================================
-- Phase 3: Module 6 Completion
-- Quadratic Functions, Polynomial Functions, Exponential Functions, Graph Interpretation
-- 20 Activities (5 per skill)
-- ============================================

-- ============================================
-- SKILL: Quadratic Functions (FG-03)
-- Skill ID: c0000000-0000-0000-0006-000000000003
-- Prerequisites: Linear Functions, Quadratic Equations
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 6.3.1: Understanding Quadratic Functions
(
  'b0600000-0000-0000-0003-000000000001',
  NULL,
  '6.3.1',
  5,
  'Understanding Quadratic Functions',
  'understanding-quadratic-functions',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Understanding Quadratic Functions\n\n## The Standard Form\n\n$$f(x) = ax^2 + bx + c$$\n\nWhere:\n- a determines opening direction and width\n- b affects horizontal position\n- c is the y-intercept\n\n---\n\n## The Parabola Shape\n\n| If a > 0 | If a < 0 |\n|----------|----------|\n| Opens upward (U shape) | Opens downward (∩ shape) |\n| Has minimum | Has maximum |\n\n---\n\n## Key Features\n\n### 1. Vertex (Turning Point)\nThe highest or lowest point:\n$$x_{vertex} = -\\frac{b}{2a}$$\n$$y_{vertex} = f(x_{vertex})$$\n\n### 2. Axis of Symmetry\nVertical line through vertex: $x = -\\frac{b}{2a}$\n\n### 3. Y-Intercept\nWhere graph crosses y-axis: $(0, c)$\n\n### 4. X-Intercepts (Roots)\nWhere graph crosses x-axis: Solve $ax^2 + bx + c = 0$\n\n---\n\n## Example: f(x) = x² - 4x + 3\n\nHere: a = 1, b = -4, c = 3\n\n| Feature | Calculation | Value |\n|---------|-------------|-------|\n| Opens | a = 1 > 0 | Upward |\n| x-vertex | $-(-4)/(2×1)$ | 2 |\n| y-vertex | $f(2) = 4 - 8 + 3$ | -1 |\n| y-intercept | c | (0, 3) |\n| x-intercepts | Factor: $(x-1)(x-3)=0$ | x = 1, 3 |\n\n---\n\n## Vertex Form\n\n$$f(x) = a(x - h)^2 + k$$\n\nWhere (h, k) is the vertex.\n\n### Converting to Vertex Form\n$f(x) = x^2 - 4x + 3$\n$= (x^2 - 4x + 4) - 4 + 3$\n$= (x - 2)^2 - 1$\n\nVertex: (2, -1) ✓\n\n---\n\n## Business Application: Profit Maximization\n\nProfit function: $P(x) = -2x^2 + 200x - 3000$\n\nMaximum profit at:\n$$x = -\\frac{200}{2(-2)} = 50 \\text{ units}$$\n$$P(50) = -2(2500) + 10000 - 3000 = 2000$$\n\nMaximum profit: CHF 2,000 at 50 units\n\n---\n\n:::takeaways\n- Quadratic functions graph as parabolas\n- Vertex x-coordinate: $x = -b/(2a)$\n- a > 0 opens up (minimum), a < 0 opens down (maximum)\n- Vertex form reveals the vertex directly\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.3.2: Graphing Quadratic Functions
(
  'b0600000-0000-0000-0003-000000000002',
  NULL,
  '6.3.2',
  6,
  'Graphing Quadratic Functions',
  'graphing-quadratic-functions',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Graphing Quadratic Functions\n\n## Step-by-Step Graphing\n\n### Step 1: Identify Direction\nCheck sign of a: positive (opens up) or negative (opens down)\n\n### Step 2: Find the Vertex\n$x_v = -b/(2a)$, then calculate $y_v = f(x_v)$\n\n### Step 3: Find Y-Intercept\nPlot point $(0, c)$\n\n### Step 4: Find X-Intercepts (if real)\nSolve $ax^2 + bx + c = 0$\n\n### Step 5: Plot Symmetric Points\nUse axis of symmetry to find matching points\n\n---\n\n## Example: Graph f(x) = -x² + 6x - 5\n\n**Step 1:** a = -1 < 0, opens downward\n\n**Step 2:** Vertex\n$x_v = -6/(2×-1) = 3$\n$y_v = -(9) + 18 - 5 = 4$\nVertex: (3, 4)\n\n**Step 3:** Y-intercept: (0, -5)\n\n**Step 4:** X-intercepts: $-x^2 + 6x - 5 = 0$\n$x^2 - 6x + 5 = 0$\n$(x-1)(x-5) = 0$\nx = 1, 5\n\n**Step 5:** Mirror point of (0, -5) across x = 3 is (6, -5)\n\n---\n\n## Effect of Parameters\n\n### Changing a\n| Value of a | Effect |\n|------------|--------|\n| |a| > 1 | Narrower parabola |\n| |a| < 1 | Wider parabola |\n| a > 0 | Opens up |\n| a < 0 | Opens down |\n\n### Changing c\nShifts parabola up (c > 0) or down (c < 0)\n\n---\n\n## Transformations from f(x) = x²\n\n| Function | Transformation |\n|----------|---------------|\n| $x^2 + 3$ | Shift up 3 |\n| $(x - 2)^2$ | Shift right 2 |\n| $-x^2$ | Reflect over x-axis |\n| $2x^2$ | Vertically stretch |\n\n---\n\n:::takeaways\n- Always find vertex first when graphing\n- Use symmetry to plot additional points\n- The vertex is a maximum (a < 0) or minimum (a > 0)\n- Y-intercept is always at (0, c)\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.3.3: Quadratic Functions Quiz
(
  'b0600000-0000-0000-0003-000000000003',
  NULL,
  '6.3.3',
  7,
  'Quadratic Functions Practice',
  'quadratic-functions-practice',
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
        "question": "For f(x) = 2x² - 8x + 6, find the x-coordinate of the vertex.",
        "options": ["2", "-2", "4", "8"],
        "correct": 0,
        "explanation": "x = -b/(2a) = -(-8)/(2×2) = 8/4 = 2"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A parabola with a = -3 opens:",
        "options": ["Downward and is narrow", "Upward and is narrow", "Downward and is wide", "Upward and is wide"],
        "correct": 0,
        "explanation": "Negative a means opens down, |a| > 1 means narrow."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Find the maximum value of f(x) = -x² + 4x + 5.",
        "options": ["9", "5", "4", "13"],
        "correct": 0,
        "explanation": "x_v = -4/(2×-1) = 2. f(2) = -4 + 8 + 5 = 9"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The vertex form of f(x) = x² - 6x + 11 is:",
        "options": ["(x - 3)² + 2", "(x + 3)² + 2", "(x - 3)² - 2", "(x - 6)² + 11"],
        "correct": 0,
        "explanation": "Complete the square: x² - 6x + 9 + 2 = (x - 3)² + 2"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The axis of symmetry always passes through the vertex.",
        "correct": true,
        "explanation": "True! The axis of symmetry is the vertical line x = -b/(2a), which goes through the vertex."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Profit P(x) = -5x² + 100x - 300. Maximum profit occurs at:",
        "options": ["x = 10 units", "x = 20 units", "x = 5 units", "x = 15 units"],
        "correct": 0,
        "explanation": "x = -100/(2×-5) = 100/10 = 10"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.3.4: Parabola Feature Matcher
(
  'b0600000-0000-0000-0003-000000000004',
  NULL,
  '6.3.4',
  8,
  'Parabola Features Matcher',
  'parabola-features-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each quadratic function feature with its formula or description.",
    "pairs": [
      {"left": "Vertex x-coordinate", "right": "-b/(2a)"},
      {"left": "Y-intercept", "right": "(0, c)"},
      {"left": "Axis of symmetry", "right": "x = -b/(2a)"},
      {"left": "a > 0", "right": "Parabola opens upward"},
      {"left": "Vertex form", "right": "a(x - h)² + k"},
      {"left": "|a| > 1", "right": "Narrower parabola"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 6.3.5: Quadratic Functions Checkpoint
(
  'b0600000-0000-0000-0003-000000000005',
  NULL,
  '6.3.5',
  9,
  'Quadratic Functions Checkpoint',
  'quadratic-functions-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "For f(x) = 3(x - 2)² + 5, what is the vertex?",
        "options": ["(2, 5)", "(-2, 5)", "(2, -5)", "(3, 5)"],
        "correct": 0,
        "explanation": "In vertex form a(x - h)² + k, vertex is (h, k) = (2, 5)"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "A ball is thrown with height h(t) = -5t² + 30t + 2. Maximum height is:",
        "options": ["47 meters", "45 meters", "30 meters", "2 meters"],
        "correct": 0,
        "explanation": "t = -30/(2×-5) = 3. h(3) = -45 + 90 + 2 = 47"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "How many x-intercepts does f(x) = x² + 2x + 5 have?",
        "options": ["None (discriminant < 0)", "One", "Two", "Infinitely many"],
        "correct": 0,
        "explanation": "D = 4 - 20 = -16 < 0, so no real x-intercepts."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Revenue R(p) = -50p² + 600p. Price for maximum revenue?",
        "options": ["p = 6", "p = 12", "p = 50", "p = 600"],
        "correct": 0,
        "explanation": "p = -600/(2×-50) = 600/100 = 6"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Which function has its vertex at the origin?",
        "options": ["f(x) = 3x²", "f(x) = x² + 1", "f(x) = (x - 1)²", "f(x) = x² - x"],
        "correct": 0,
        "explanation": "f(x) = 3x² = 3(x - 0)² + 0 has vertex at (0, 0)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Polynomial Functions (FG-04)
-- Skill ID: c0000000-0000-0000-0006-000000000004
-- ============================================

(
  'b0600000-0000-0000-0004-000000000001',
  NULL,
  '6.4.1',
  10,
  'Understanding Polynomial Functions',
  'understanding-polynomial-functions',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Understanding Polynomial Functions\n\n## What is a Polynomial?\n\n$$P(x) = a_nx^n + a_{n-1}x^{n-1} + ... + a_1x + a_0$$\n\nWhere:\n- n is a non-negative integer (the degree)\n- $a_n \\neq 0$ (leading coefficient)\n- All exponents are whole numbers\n\n---\n\n## Polynomial Classification\n\n| Degree | Name | Example |\n|--------|------|--------|\n| 0 | Constant | $f(x) = 5$ |\n| 1 | Linear | $f(x) = 3x + 2$ |\n| 2 | Quadratic | $f(x) = x^2 - 4$ |\n| 3 | Cubic | $f(x) = x^3 + 2x$ |\n| 4 | Quartic | $f(x) = x^4 - 1$ |\n| 5 | Quintic | $f(x) = x^5 + x$ |\n\n---\n\n## End Behavior\n\nWhat happens as x → ±∞?\n\n### Determined by Leading Term\n\n| Leading Coeff | Degree | Left End | Right End |\n|--------------|--------|----------|----------|\n| Positive | Even | Up | Up |\n| Positive | Odd | Down | Up |\n| Negative | Even | Down | Down |\n| Negative | Odd | Up | Down |\n\n---\n\n## Finding Zeros (Roots)\n\nZeros are x-values where $P(x) = 0$\n\n### Number of Zeros\nA polynomial of degree n has at most n real zeros.\n\n### Example\n$f(x) = x^3 - 4x = x(x^2 - 4) = x(x-2)(x+2)$\n\nZeros: x = 0, 2, -2 (three zeros for degree 3)\n\n---\n\n## Multiplicity of Zeros\n\n| Zero | Graph Behavior |\n|------|---------------|\n| Multiplicity 1 | Crosses x-axis |\n| Multiplicity 2 | Touches and bounces |\n| Multiplicity 3 | Crosses with inflection |\n\n### Example\n$f(x) = (x-1)^2(x+2)$\n- x = 1 has multiplicity 2 (bounces)\n- x = -2 has multiplicity 1 (crosses)\n\n---\n\n## Business Applications\n\n### Cost Functions\n$C(x) = 0.001x^3 - 0.5x^2 + 100x + 5000$\n\nCubic cost functions capture:\n- Initial fixed costs\n- Economies of scale (decreasing marginal cost)\n- Diseconomies at high volumes (increasing marginal cost)\n\n---\n\n:::takeaways\n- Degree determines maximum number of zeros and turns\n- End behavior depends on leading coefficient and degree\n- Multiplicity affects how graph behaves at zeros\n- Higher-degree polynomials model complex real-world phenomena\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0004-000000000002',
  NULL,
  '6.4.2',
  11,
  'Polynomial Functions Quiz',
  'polynomial-functions-quiz',
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
        "question": "What is the degree of f(x) = 5x³ - 2x² + 7x - 1?",
        "options": ["3", "5", "4", "7"],
        "correct": 0,
        "explanation": "The degree is the highest power of x, which is 3."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A polynomial of degree 4 has at most how many real zeros?",
        "options": ["4", "3", "5", "8"],
        "correct": 0,
        "explanation": "A polynomial of degree n has at most n real zeros."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "For f(x) = -2x³ + x, as x → +∞, f(x) →",
        "options": ["-∞", "+∞", "0", "2"],
        "correct": 0,
        "explanation": "Negative leading coefficient with odd degree: right end goes down to -∞"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The zeros of f(x) = x(x-3)(x+2) are:",
        "options": ["0, 3, -2", "0, -3, 2", "1, 3, -2", "None"],
        "correct": 0,
        "explanation": "Set each factor to zero: x = 0, x - 3 = 0 gives x = 3, x + 2 = 0 gives x = -2"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "A polynomial with an even degree must have at least one real zero.",
        "correct": false,
        "explanation": "False! For example, x² + 1 has no real zeros."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0004-000000000003',
  NULL,
  '6.4.3',
  12,
  'Polynomial Concepts Matcher',
  'polynomial-concepts-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each polynomial concept with its correct description.",
    "pairs": [
      {"left": "Cubic polynomial", "right": "Degree 3"},
      {"left": "Leading coefficient positive, even degree", "right": "Both ends up"},
      {"left": "Multiplicity 2", "right": "Graph touches and bounces"},
      {"left": "Maximum real zeros for degree 5", "right": "5"},
      {"left": "f(x) = x⁴ - 16", "right": "Quartic polynomial"},
      {"left": "Odd degree polynomial", "right": "At least one real zero"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

(
  'b0600000-0000-0000-0004-000000000004',
  NULL,
  '6.4.4',
  13,
  'Analyzing Polynomial Behavior',
  'analyzing-polynomial-behavior',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Analyzing Polynomial Behavior\n\n## Turning Points\n\nA polynomial of degree n has at most n - 1 turning points.\n\n| Degree | Max Turning Points |\n|--------|--------------------|\n| 2 | 1 |\n| 3 | 2 |\n| 4 | 3 |\n| 5 | 4 |\n\n---\n\n## Sketching Strategy\n\n1. **Find end behavior** from leading term\n2. **Find zeros** by factoring or solving\n3. **Determine multiplicity** of each zero\n4. **Find y-intercept** (plug in x = 0)\n5. **Connect** the pieces smoothly\n\n---\n\n## Example: Sketch f(x) = x³ - 4x\n\n**Step 1:** Leading term x³ (positive, odd)\n- Left: down, Right: up\n\n**Step 2:** Factor: x(x² - 4) = x(x-2)(x+2)\n- Zeros: -2, 0, 2\n\n**Step 3:** All multiplicity 1 (crosses at each)\n\n**Step 4:** y-intercept: f(0) = 0\n\n**Step 5:** Graph goes: up from bottom-left → crosses at -2 → down → crosses at 0 → up → crosses at 2 → continues up\n\n---\n\n## Intervals of Increase/Decrease\n\nThe graph:\n- **Increases** where f(x) goes up as x increases\n- **Decreases** where f(x) goes down as x increases\n- **Changes** at turning points\n\n---\n\n:::takeaways\n- Maximum turning points = degree - 1\n- Use zeros and end behavior to sketch\n- Multiplicity determines crossing vs. bouncing\n- Factor to find zeros when possible\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0004-000000000005',
  NULL,
  '6.4.5',
  14,
  'Polynomial Functions Checkpoint',
  'polynomial-functions-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "How many turning points can f(x) = x⁵ - 3x³ + 2x have at most?",
        "options": ["4", "5", "3", "2"],
        "correct": 0,
        "explanation": "Degree 5 means at most 5 - 1 = 4 turning points"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "For f(x) = (x + 1)²(x - 2), describe behavior at x = -1:",
        "options": ["Touches and bounces", "Crosses", "Vertical asymptote", "Hole"],
        "correct": 0,
        "explanation": "Multiplicity 2 at x = -1 means the graph touches and bounces."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "End behavior of f(x) = -x⁴ + 2x² - 1:",
        "options": ["Both ends down", "Both ends up", "Left down, right up", "Left up, right down"],
        "correct": 0,
        "explanation": "Negative leading coefficient with even degree: both ends go down."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "The y-intercept of f(x) = 2x³ - 5x² + 3x - 7 is:",
        "options": ["(0, -7)", "(0, 2)", "(0, 3)", "(0, 7)"],
        "correct": 0,
        "explanation": "Y-intercept is f(0) = -7, so point (0, -7)"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Which is NOT a polynomial?",
        "options": ["f(x) = x^(-2) + 1", "f(x) = x³ - 5", "f(x) = 7", "f(x) = x⁵ + x² + 1"],
        "correct": 0,
        "explanation": "x^(-2) = 1/x² is not a polynomial (exponents must be non-negative integers)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Exponential Functions (FG-05)
-- Skill ID: c0000000-0000-0000-0006-000000000005
-- ============================================

(
  'b0600000-0000-0000-0005-000000000001',
  NULL,
  '6.5.1',
  15,
  'Introduction to Exponential Functions',
  'introduction-exponential-functions',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to Exponential Functions\n\n## The Exponential Form\n\n$$f(x) = a \\cdot b^x$$\n\nWhere:\n- a = initial value (y-intercept when x = 0)\n- b = base (growth/decay factor)\n- x = exponent (often time)\n\n---\n\n## Growth vs. Decay\n\n| If b > 1 | If 0 < b < 1 |\n|----------|-------------|\n| Exponential growth | Exponential decay |\n| Increases rapidly | Decreases toward zero |\n| Example: $2^x$ | Example: $(0.5)^x$ |\n\n---\n\n## Key Properties\n\n1. **Domain:** All real numbers\n2. **Range:** $(0, ∞)$ for a > 0\n3. **Y-intercept:** (0, a)\n4. **Horizontal asymptote:** y = 0\n5. **Never equals zero** (approaches but never touches)\n\n---\n\n## Common Bases\n\n| Base | Use |\n|------|-----|\n| 2 | Doubling, binary |\n| e ≈ 2.718 | Natural growth |\n| 10 | Orders of magnitude |\n| 1/2 | Half-life |\n\n---\n\n## Growth Rate Form\n\n$$f(t) = a(1 + r)^t$$\n\nWhere r is the growth rate per period.\n\n### Example\nPopulation growing at 3% per year:\n$$P(t) = P_0(1.03)^t$$\n\n---\n\n## Decay Form\n\n$$f(t) = a(1 - r)^t$$\n\nWhere r is the decay rate.\n\n### Example\nValue depreciating at 15% per year:\n$$V(t) = V_0(0.85)^t$$\n\n---\n\n## Business Applications\n\n### Compound Interest\n$$A = P(1 + r/n)^{nt}$$\n\n### Viral Marketing\nEach person tells k people: Reach = $(k)^{generations}$\n\n### Depreciation\n$$Value = Cost \\times (1 - rate)^{years}$$\n\n---\n\n:::takeaways\n- Exponential: variable is in the exponent\n- b > 1 means growth, 0 < b < 1 means decay\n- Y-intercept is the initial value a\n- Graph approaches but never touches y = 0\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0005-000000000002',
  NULL,
  '6.5.2',
  16,
  'Exponential Growth and Decay Applications',
  'exponential-growth-decay-applications',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Exponential Growth and Decay Applications\n\n## Finding Growth/Decay Rate\n\n### From a Percentage\n- 5% growth: b = 1 + 0.05 = 1.05\n- 8% decay: b = 1 - 0.08 = 0.92\n\n### From Two Points\nGiven $(t_1, y_1)$ and $(t_2, y_2)$:\n$$b = \\left(\\frac{y_2}{y_1}\\right)^{1/(t_2 - t_1)}$$\n\n---\n\n## Doubling Time\n\nTime for quantity to double:\n$$t_{double} = \\frac{\\ln(2)}{\\ln(b)} = \\frac{0.693}{\\ln(b)}$$\n\n### Example\nGrowth factor b = 1.08 (8% growth):\n$$t_{double} = \\frac{0.693}{\\ln(1.08)} = \\frac{0.693}{0.077} = 9 \\text{ years}$$\n\n---\n\n## Half-Life\n\nTime for quantity to halve:\n$$t_{half} = \\frac{\\ln(0.5)}{\\ln(b)} = \\frac{-0.693}{\\ln(b)}$$\n\n### Example\nDecay factor b = 0.9 (10% decay):\n$$t_{half} = \\frac{-0.693}{\\ln(0.9)} = \\frac{-0.693}{-0.105} = 6.6 \\text{ periods}$$\n\n---\n\n## Solving Exponential Equations\n\n### Method: Use Logarithms\n\n**Find t when:** $1000(1.05)^t = 1500$\n\n| Step | Work |\n|------|------|\n| 1. Divide by 1000 | $(1.05)^t = 1.5$ |\n| 2. Take ln of both sides | $t \\cdot \\ln(1.05) = \\ln(1.5)$ |\n| 3. Solve for t | $t = \\frac{\\ln(1.5)}{\\ln(1.05)} = \\frac{0.405}{0.049} = 8.3$ |\n\n---\n\n## Comparing Linear vs. Exponential\n\n| Feature | Linear | Exponential |\n|---------|--------|-------------|\n| Change | Constant amount | Constant percentage |\n| Formula | $y = mx + b$ | $y = ab^x$ |\n| Long-term | Moderate | Explosive |\n\n---\n\n:::takeaways\n- Use ln to solve for time in exponential equations\n- Doubling time = ln(2)/ln(b)\n- Half-life = -ln(2)/ln(b)\n- Exponential always outpaces linear eventually\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0005-000000000003',
  NULL,
  '6.5.3',
  17,
  'Exponential Functions Quiz',
  'exponential-functions-quiz',
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
        "question": "For f(x) = 5(2)^x, what is f(0)?",
        "options": ["5", "10", "2", "1"],
        "correct": 0,
        "explanation": "f(0) = 5(2)^0 = 5(1) = 5"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which represents 12% annual decay?",
        "options": ["f(t) = a(0.88)^t", "f(t) = a(1.12)^t", "f(t) = a(0.12)^t", "f(t) = a(12)^t"],
        "correct": 0,
        "explanation": "12% decay means b = 1 - 0.12 = 0.88"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Population doubles every 10 years from 1000. Population after 30 years?",
        "options": ["8000", "3000", "4000", "6000"],
        "correct": 0,
        "explanation": "Doubles 3 times: 1000 → 2000 → 4000 → 8000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A CHF 20,000 car depreciates 20% per year. Value after 3 years?",
        "options": ["CHF 10,240", "CHF 14,000", "CHF 12,800", "CHF 8,000"],
        "correct": 0,
        "explanation": "V = 20000(0.8)^3 = 20000(0.512) = 10,240"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "An exponential function with base b = 1 results in a constant function.",
        "correct": true,
        "explanation": "True! 1^x = 1 for all x, so f(x) = a(1)^x = a (constant)"
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "How long for CHF 5000 to grow to CHF 7000 at 4% annual growth?",
        "options": ["8.6 years", "10 years", "7 years", "5 years"],
        "correct": 0,
        "explanation": "t = ln(7000/5000)/ln(1.04) = ln(1.4)/0.039 = 0.336/0.039 = 8.6 years"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0005-000000000004',
  NULL,
  '6.5.4',
  18,
  'Exponential Concepts Matcher',
  'exponential-concepts-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each exponential concept with its correct description or value.",
    "pairs": [
      {"left": "Base > 1", "right": "Exponential growth"},
      {"left": "0 < Base < 1", "right": "Exponential decay"},
      {"left": "f(x) = 100(1.05)^x", "right": "5% growth from 100"},
      {"left": "Horizontal asymptote", "right": "y = 0"},
      {"left": "Y-intercept of a×b^x", "right": "(0, a)"},
      {"left": "Doubling time formula", "right": "ln(2)/ln(b)"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

(
  'b0600000-0000-0000-0005-000000000005',
  NULL,
  '6.5.5',
  19,
  'Exponential Functions Checkpoint',
  'exponential-functions-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "A bacteria culture triples every 4 hours from 500. Population after 12 hours?",
        "options": ["13,500", "4,500", "6,000", "1,500"],
        "correct": 0,
        "explanation": "Triples 3 times (12/4): 500 × 3³ = 500 × 27 = 13,500"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Investment grows from CHF 10,000 to CHF 15,000 in 5 years. Annual growth rate?",
        "options": ["8.4%", "10%", "50%", "5%"],
        "correct": 0,
        "explanation": "b = (15000/10000)^(1/5) = 1.5^0.2 = 1.084, so 8.4% growth"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Half-life of a substance with decay factor 0.95 per day is approximately:",
        "options": ["14 days", "2 days", "10 days", "20 days"],
        "correct": 0,
        "explanation": "t = ln(0.5)/ln(0.95) = -0.693/-0.051 = 13.5 ≈ 14 days"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "The function f(x) = 3^x has which asymptote?",
        "options": ["y = 0", "x = 0", "y = 3", "No asymptote"],
        "correct": 0,
        "explanation": "All exponential functions a×b^x with a > 0 have y = 0 as horizontal asymptote."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Which grows faster for large x: f(x) = 1000x or g(x) = 2^x?",
        "options": ["g(x) = 2^x", "f(x) = 1000x", "They grow equally", "Cannot determine"],
        "correct": 0,
        "explanation": "Exponential always eventually outpaces linear, no matter the coefficients."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Graph Interpretation (FG-06)
-- Skill ID: c0000000-0000-0000-0006-000000000006
-- ============================================

(
  'b0600000-0000-0000-0006-000000000001',
  NULL,
  '6.6.1',
  20,
  'Reading and Interpreting Graphs',
  'reading-interpreting-graphs',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Reading and Interpreting Graphs\n\n## What Graphs Tell Us\n\nGraphs communicate:\n- Trends over time\n- Relationships between variables\n- Maximum and minimum values\n- Rates of change\n\n---\n\n## Key Graph Features\n\n### Intercepts\n- **X-intercept:** Where graph crosses x-axis (y = 0)\n- **Y-intercept:** Where graph crosses y-axis (x = 0)\n\n### Extrema\n- **Maximum:** Highest point (peak)\n- **Minimum:** Lowest point (valley)\n\n### Trends\n- **Increasing:** Graph rises left to right\n- **Decreasing:** Graph falls left to right\n\n---\n\n## Interpreting Slope\n\n### Positive Slope\n- Line goes up left to right\n- Variables increase together\n\n### Negative Slope\n- Line goes down left to right\n- As one increases, other decreases\n\n### Zero Slope\n- Horizontal line\n- Output doesn''t change with input\n\n---\n\n## Reading Values\n\n### From Graph to Number\n1. Find x-value on horizontal axis\n2. Go vertically to the curve\n3. Go horizontally to y-axis\n4. Read the y-value\n\n### From Number to Graph\n1. Find value on appropriate axis\n2. Draw line to curve\n3. Draw line to other axis\n4. Read corresponding value\n\n---\n\n## Business Graph Types\n\n| Graph Type | Shows |\n|------------|-------|\n| Revenue vs. Quantity | Sales relationship |\n| Cost curves | Fixed + variable costs |\n| Break-even chart | Profit/loss zones |\n| Supply-demand | Market equilibrium |\n| Time series | Trends over time |\n\n---\n\n## Rate of Change from Graphs\n\n$$\\text{Average Rate} = \\frac{\\Delta y}{\\Delta x} = \\frac{y_2 - y_1}{x_2 - x_1}$$\n\n### Visual Cues\n- Steeper curve = faster change\n- Flatter curve = slower change\n- Curved line = changing rate\n\n---\n\n:::takeaways\n- X-intercepts are solutions where output = 0\n- Slope indicates rate and direction of change\n- Steeper means faster change\n- Context determines meaning (revenue, cost, etc.)\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0006-000000000002',
  NULL,
  '6.6.2',
  21,
  'Supply, Demand, and Business Graphs',
  'supply-demand-business-graphs',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Supply, Demand, and Business Graphs\n\n## Supply and Demand Curves\n\n### Demand Curve\n- Usually slopes **downward**\n- Higher price → Lower quantity demanded\n- Shows buyer behavior\n\n### Supply Curve\n- Usually slopes **upward**\n- Higher price → Higher quantity supplied\n- Shows seller behavior\n\n---\n\n## Market Equilibrium\n\nWhere supply and demand curves intersect:\n- **Equilibrium price:** Neither shortage nor surplus\n- **Equilibrium quantity:** Amount actually traded\n\n---\n\n## Reading a Break-Even Chart\n\n### Components\n- **Total Cost line:** Starts at fixed costs, slopes up\n- **Total Revenue line:** Starts at origin, slopes up\n- **Break-even point:** Where lines cross\n\n### Zones\n- **Left of intersection:** Loss (Costs > Revenue)\n- **Right of intersection:** Profit (Revenue > Costs)\n\n---\n\n## Cost Curve Interpretation\n\n### Total Cost Curve\n- Starts above zero (fixed costs)\n- Curves upward (increasing marginal cost)\n\n### Average Cost Curve\n- Often U-shaped\n- Minimum point is optimal production level\n\n### Marginal Cost Curve\n- Shows cost of one more unit\n- Intersects average cost at minimum\n\n---\n\n## Time Series Analysis\n\n### Trend\n- Overall direction over time\n- Rising, falling, or stable\n\n### Seasonality\n- Regular patterns within periods\n- Hotel occupancy by month\n\n### Fluctuations\n- Short-term variations\n- Random or cyclical\n\n---\n\n:::takeaways\n- Demand slopes down, supply slopes up\n- Equilibrium is where curves cross\n- Break-even is where revenue = cost\n- Time series show trends and patterns\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0006-000000000003',
  NULL,
  '6.6.3',
  22,
  'Graph Interpretation Quiz',
  'graph-interpretation-quiz',
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
        "question": "A demand curve typically slopes:",
        "options": ["Downward from left to right", "Upward from left to right", "Horizontally", "Vertically"],
        "correct": 0,
        "explanation": "Higher prices lead to lower quantity demanded, creating a downward slope."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "The break-even point on a chart is where:",
        "options": ["Total Revenue = Total Cost", "Profit is maximum", "Cost is minimum", "Revenue is maximum"],
        "correct": 0,
        "explanation": "Break-even is where the company neither makes nor loses money: TR = TC"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If a cost curve becomes steeper, this indicates:",
        "options": ["Costs are increasing faster", "Costs are decreasing", "Costs are constant", "Production is stopping"],
        "correct": 0,
        "explanation": "A steeper slope means a faster rate of change - costs rising more quickly."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Market equilibrium price is found at the:",
        "options": ["Intersection of supply and demand", "Peak of the demand curve", "Bottom of the supply curve", "Y-intercept of demand"],
        "correct": 0,
        "explanation": "Equilibrium is where supply equals demand - the intersection point."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "On a profit graph, the region above the x-axis represents profit.",
        "correct": true,
        "explanation": "True! Positive y-values (above x-axis) represent positive profit."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A horizontal line on a time series graph indicates:",
        "options": ["No change over time", "Rapid growth", "Constant increase", "Seasonal variation"],
        "correct": 0,
        "explanation": "Horizontal means the value stays constant - no change over the time period."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0600000-0000-0000-0006-000000000004',
  NULL,
  '6.6.4',
  23,
  'Graph Features Matcher',
  'graph-features-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each graph feature with what it represents.",
    "pairs": [
      {"left": "Positive slope", "right": "Both variables increase together"},
      {"left": "X-intercept", "right": "Where output equals zero"},
      {"left": "Maximum point", "right": "Peak value of function"},
      {"left": "Steeper curve", "right": "Faster rate of change"},
      {"left": "Intersection of two curves", "right": "Where values are equal"},
      {"left": "Area under curve", "right": "Accumulated quantity"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

(
  'b0600000-0000-0000-0006-000000000005',
  NULL,
  '6.6.5',
  24,
  'Graph Interpretation Checkpoint',
  'graph-interpretation-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "At a price above equilibrium, a market has:",
        "options": ["Surplus (excess supply)", "Shortage (excess demand)", "Equilibrium", "No trade"],
        "correct": 0,
        "explanation": "Above equilibrium price, quantity supplied > quantity demanded = surplus"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "The y-intercept of a cost function typically represents:",
        "options": ["Fixed costs", "Variable costs", "Total revenue", "Profit"],
        "correct": 0,
        "explanation": "At Q = 0, total cost = fixed costs only (the y-intercept)"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Average rate of change between points (2, 10) and (6, 30) is:",
        "options": ["5", "20", "4", "10"],
        "correct": 0,
        "explanation": "Rate = (30 - 10)/(6 - 2) = 20/4 = 5"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "A revenue curve that levels off indicates:",
        "options": ["Market saturation", "Increasing sales", "Price increase", "Cost reduction"],
        "correct": 0,
        "explanation": "Leveling off means additional units add little revenue - market is saturating."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "On a break-even chart with units on x-axis, the slope of total revenue equals:",
        "options": ["Price per unit", "Total cost", "Fixed cost", "Variable cost"],
        "correct": 0,
        "explanation": "Revenue = Price × Quantity, so slope = Price per unit"
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

-- Quadratic Functions -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0600000-0000-0000-0003-000000000001', 'c0000000-0000-0000-0006-000000000003', true, 1, true, true, 1.0),
('b0600000-0000-0000-0003-000000000002', 'c0000000-0000-0000-0006-000000000003', true, 2, true, true, 1.0),
('b0600000-0000-0000-0003-000000000003', 'c0000000-0000-0000-0006-000000000003', true, 3, true, true, 1.0),
('b0600000-0000-0000-0003-000000000004', 'c0000000-0000-0000-0006-000000000003', true, 4, true, true, 1.0),
('b0600000-0000-0000-0003-000000000005', 'c0000000-0000-0000-0006-000000000003', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Polynomial Functions -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0600000-0000-0000-0004-000000000001', 'c0000000-0000-0000-0006-000000000004', true, 1, true, true, 1.0),
('b0600000-0000-0000-0004-000000000002', 'c0000000-0000-0000-0006-000000000004', true, 2, true, true, 1.0),
('b0600000-0000-0000-0004-000000000003', 'c0000000-0000-0000-0006-000000000004', true, 3, true, true, 1.0),
('b0600000-0000-0000-0004-000000000004', 'c0000000-0000-0000-0006-000000000004', true, 4, true, true, 1.0),
('b0600000-0000-0000-0004-000000000005', 'c0000000-0000-0000-0006-000000000004', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Exponential Functions -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0600000-0000-0000-0005-000000000001', 'c0000000-0000-0000-0006-000000000005', true, 1, true, true, 1.0),
('b0600000-0000-0000-0005-000000000002', 'c0000000-0000-0000-0006-000000000005', true, 2, true, true, 1.0),
('b0600000-0000-0000-0005-000000000003', 'c0000000-0000-0000-0006-000000000005', true, 3, true, true, 1.0),
('b0600000-0000-0000-0005-000000000004', 'c0000000-0000-0000-0006-000000000005', true, 4, true, true, 1.0),
('b0600000-0000-0000-0005-000000000005', 'c0000000-0000-0000-0006-000000000005', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Graph Interpretation -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0600000-0000-0000-0006-000000000001', 'c0000000-0000-0000-0006-000000000006', true, 1, true, true, 1.0),
('b0600000-0000-0000-0006-000000000002', 'c0000000-0000-0000-0006-000000000006', true, 2, true, true, 1.0),
('b0600000-0000-0000-0006-000000000003', 'c0000000-0000-0000-0006-000000000006', true, 3, true, true, 1.0),
('b0600000-0000-0000-0006-000000000004', 'c0000000-0000-0000-0006-000000000006', true, 4, true, true, 1.0),
('b0600000-0000-0000-0006-000000000005', 'c0000000-0000-0000-0006-000000000006', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

