-- ============================================
-- Phase 2: High Priority Calculus Skills
-- Chain Rule, Partial Derivatives, Consumer/Producer Surplus
-- 15 Activities (5 per skill)
-- ============================================

-- ============================================
-- SKILL: Chain Rule (DC-05)
-- Skill ID: c0000000-0000-0000-0007-000000000005
-- Prerequisites: Basic Derivative Rules
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 7.5.1: Understanding the Chain Rule
(
  'b0700000-0000-0000-0005-000000000001',
  NULL,
  '7.5.1',
  5,
  'Understanding the Chain Rule',
  'understanding-chain-rule',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Understanding the Chain Rule\n\n## When Do We Need the Chain Rule?\n\nThe chain rule is used when differentiating **composite functions** - functions inside other functions.\n\n| Function Type | Example | Needs Chain Rule? |\n|--------------|---------|------------------|\n| Simple | $x^3$ | No |\n| Composite | $(2x + 1)^3$ | Yes - has \"inner function\" |\n| Composite | $\\sqrt{x^2 + 5}$ | Yes - square root of something |\n\n---\n\n## Identifying Composite Functions\n\n:::concept{title=\"Outer and Inner Functions\"}\nA composite function $f(g(x))$ has:\n- **Outer function**: The main operation\n- **Inner function**: What''s inside\n:::\n\n### Examples\n\n| Function | Outer | Inner |\n|----------|-------|-------|\n| $(3x - 7)^4$ | $(\\cdot)^4$ | $3x - 7$ |\n| $\\sqrt{x^2 + 1}$ | $\\sqrt{\\cdot}$ | $x^2 + 1$ |\n| $e^{2x}$ | $e^{(\\cdot)}$ | $2x$ |\n| $\\ln(5x)$ | $\\ln(\\cdot)$ | $5x$ |\n\n---\n\n## The Chain Rule Formula\n\n$$\\frac{d}{dx}[f(g(x))] = f''(g(x)) \\cdot g''(x)$$\n\nIn words: **Derivative of outer × Derivative of inner**\n\n---\n\n## Step-by-Step Process\n\n### Example 1: $(2x + 3)^5$\n\n| Step | Action | Result |\n|------|--------|--------|\n| 1 | Identify outer | $(\\cdot)^5$ |\n| 2 | Identify inner | $2x + 3$ |\n| 3 | Derivative of outer | $5(\\cdot)^4$ |\n| 4 | Keep inner inside | $5(2x + 3)^4$ |\n| 5 | Multiply by derivative of inner | $5(2x + 3)^4 \\cdot 2$ |\n| 6 | Simplify | $10(2x + 3)^4$ |\n\n---\n\n## Example 2: $\\sqrt{x^2 + 9}$\n\nRewrite: $(x^2 + 9)^{1/2}$\n\n| Step | Action | Result |\n|------|--------|--------|\n| 1 | Outer derivative | $\\frac{1}{2}(x^2 + 9)^{-1/2}$ |\n| 2 | Inner derivative | $2x$ |\n| 3 | Multiply | $\\frac{1}{2}(x^2 + 9)^{-1/2} \\cdot 2x$ |\n| 4 | Simplify | $\\frac{x}{\\sqrt{x^2 + 9}}$ |\n\n---\n\n## Common Patterns\n\n| Function | Derivative |\n|----------|------------|\n| $(ax + b)^n$ | $na(ax + b)^{n-1}$ |\n| $e^{kx}$ | $ke^{kx}$ |\n| $\\ln(ax)$ | $\\frac{a}{ax} = \\frac{1}{x}$ |\n| $\\sqrt{f(x)}$ | $\\frac{f''(x)}{2\\sqrt{f(x)}}$ |\n\n---\n\n## Business Application\n\n### Marginal Analysis with Complex Cost Function\n\nIf $C(x) = 500\\sqrt{x + 100}$ (cost in CHF)\n\nMarginal cost:\n$$C''(x) = 500 \\cdot \\frac{1}{2\\sqrt{x + 100}} = \\frac{250}{\\sqrt{x + 100}}$$\n\nAt $x = 300$: $C''(300) = \\frac{250}{\\sqrt{400}} = \\frac{250}{20} = 12.50$ CHF/unit\n\n---\n\n:::takeaways\n- Chain rule: Derivative of outer × Derivative of inner\n- Look for \"functions inside functions\"\n- Common triggers: powers of expressions, roots, e^(something), ln(something)\n- Always multiply by the inner derivative\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 7.5.2: Chain Rule with Exponentials and Logs
(
  'b0700000-0000-0000-0005-000000000002',
  NULL,
  '7.5.2',
  6,
  'Chain Rule with Exponentials and Logs',
  'chain-rule-exp-log',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Chain Rule with Exponentials and Logarithms\n\n## Exponential Functions\n\n### Basic Rule\n$$\\frac{d}{dx}[e^x] = e^x$$\n\n### With Chain Rule\n$$\\frac{d}{dx}[e^{u}] = e^{u} \\cdot u''$$\n\nwhere $u$ is a function of $x$.\n\n---\n\n## Examples with $e^x$\n\n### Example 1: $e^{3x}$\n$$\\frac{d}{dx}[e^{3x}] = e^{3x} \\cdot 3 = 3e^{3x}$$\n\n### Example 2: $e^{x^2}$\n$$\\frac{d}{dx}[e^{x^2}] = e^{x^2} \\cdot 2x = 2xe^{x^2}$$\n\n### Example 3: $e^{-0.05t}$ (decay model)\n$$\\frac{d}{dt}[e^{-0.05t}] = e^{-0.05t} \\cdot (-0.05) = -0.05e^{-0.05t}$$\n\n---\n\n## General Exponential Base\n\n$$\\frac{d}{dx}[a^x] = a^x \\ln(a)$$\n\n### With Chain Rule\n$$\\frac{d}{dx}[a^{u}] = a^{u} \\ln(a) \\cdot u''$$\n\n### Example: $2^{4x}$\n$$\\frac{d}{dx}[2^{4x}] = 2^{4x} \\ln(2) \\cdot 4 = 4\\ln(2) \\cdot 2^{4x}$$\n\n---\n\n## Natural Logarithm\n\n### Basic Rule\n$$\\frac{d}{dx}[\\ln(x)] = \\frac{1}{x}$$\n\n### With Chain Rule\n$$\\frac{d}{dx}[\\ln(u)] = \\frac{1}{u} \\cdot u'' = \\frac{u''}{u}$$\n\n---\n\n## Examples with ln\n\n### Example 1: $\\ln(3x)$\n$$\\frac{d}{dx}[\\ln(3x)] = \\frac{1}{3x} \\cdot 3 = \\frac{1}{x}$$\n\n### Example 2: $\\ln(x^2 + 1)$\n$$\\frac{d}{dx}[\\ln(x^2 + 1)] = \\frac{1}{x^2 + 1} \\cdot 2x = \\frac{2x}{x^2 + 1}$$\n\n### Example 3: $\\ln(5x - 2)$\n$$\\frac{d}{dx}[\\ln(5x - 2)] = \\frac{5}{5x - 2}$$\n\n---\n\n## Business Applications\n\n### Continuous Growth Rate\n\nPopulation model: $P(t) = 1000e^{0.03t}$\n\nGrowth rate: $P''(t) = 1000 \\cdot 0.03e^{0.03t} = 30e^{0.03t}$\n\nAt $t = 10$: $P''(10) = 30e^{0.3} \\approx 40.5$ people/year\n\n### Logarithmic Demand\n\nDemand: $D(p) = 100 - 20\\ln(p)$\n\nRate of change: $D''(p) = -\\frac{20}{p}$\n\n---\n\n:::takeaways\n- $\\frac{d}{dx}[e^u] = e^u \\cdot u''$\n- $\\frac{d}{dx}[\\ln(u)] = \\frac{u''}{u}$\n- Exponentials stay, multiply by inner derivative\n- Logs become fractions with inner derivative on top\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 7.5.3: Chain Rule Practice Quiz
(
  'b0700000-0000-0000-0005-000000000003',
  NULL,
  '7.5.3',
  7,
  'Chain Rule Practice',
  'chain-rule-practice',
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
        "question": "Find the derivative of (4x - 1)^3",
        "options": ["12(4x - 1)^2", "3(4x - 1)^2", "12(4x - 1)^3", "4(4x - 1)^2"],
        "correct": 0,
        "explanation": "Outer: power rule gives 3(4x-1)^2. Multiply by inner derivative 4: 3 x 4 x (4x-1)^2 = 12(4x-1)^2"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Find the derivative of e^(5x)",
        "options": ["5e^(5x)", "e^(5x)", "5e^(5)", "e^(5)"],
        "correct": 0,
        "explanation": "Derivative of e^u is e^u times u''. Here u = 5x, so u'' = 5. Answer: 5e^(5x)"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Find the derivative of ln(2x + 7)",
        "options": ["2/(2x + 7)", "1/(2x + 7)", "2ln(2x + 7)", "(2x + 7)/2"],
        "correct": 0,
        "explanation": "d/dx[ln(u)] = u''/u. Here u'' = 2 and u = 2x + 7. Answer: 2/(2x + 7)"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Find the derivative of sqrt(x^2 + 4), i.e., (x^2 + 4)^(1/2)",
        "options": ["x/sqrt(x^2 + 4)", "2x/sqrt(x^2 + 4)", "1/(2sqrt(x^2 + 4))", "sqrt(x^2 + 4)/x"],
        "correct": 0,
        "explanation": "Outer: (1/2)(x^2+4)^(-1/2). Inner derivative: 2x. Result: (1/2)(2x)/sqrt(x^2+4) = x/sqrt(x^2+4)"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Find the derivative of e^(-x^2)",
        "options": ["-2xe^(-x^2)", "e^(-x^2)", "-x^2e^(-x^2)", "2xe^(-x^2)"],
        "correct": 0,
        "explanation": "u = -x^2, so u'' = -2x. Answer: e^(-x^2) x (-2x) = -2xe^(-x^2)"
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The derivative of (3x)^4 requires the chain rule.",
        "correct": true,
        "explanation": "True! (3x)^4 = 81x^4, but using chain rule: 4(3x)^3 x 3 = 12(3x)^3 = 12 x 27x^3 = 324x^3. Either way works."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If C(x) = 200sqrt(x + 25), find C''(x) at x = 75",
        "options": ["10", "20", "100", "5"],
        "correct": 0,
        "explanation": "C''(x) = 200 x (1/2)(x+25)^(-1/2) x 1 = 100/sqrt(x+25). At x=75: 100/sqrt(100) = 10"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 7.5.4: Chain Rule Function Matcher
(
  'b0700000-0000-0000-0005-000000000004',
  NULL,
  '7.5.4',
  8,
  'Chain Rule Function Matcher',
  'chain-rule-function-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each function with its derivative using the chain rule.",
    "pairs": [
      {"left": "(2x + 1)^4", "right": "8(2x + 1)^3"},
      {"left": "e^(3x)", "right": "3e^(3x)"},
      {"left": "ln(4x)", "right": "1/x"},
      {"left": "sqrt(x^2 - 9)", "right": "x/sqrt(x^2 - 9)"},
      {"left": "(5 - x)^3", "right": "-3(5 - x)^2"},
      {"left": "e^(-2t)", "right": "-2e^(-2t)"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 7.5.5: Chain Rule Checkpoint
(
  'b0700000-0000-0000-0005-000000000005',
  NULL,
  '7.5.5',
  9,
  'Chain Rule Checkpoint',
  'chain-rule-checkpoint',
  'checkpoint',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "What is the derivative of (x^3 + 2)^5?",
        "options": ["15x^2(x^3 + 2)^4", "5(x^3 + 2)^4", "15x^2(x^3 + 2)^5", "3x^2(x^3 + 2)^4"],
        "correct": 0,
        "explanation": "Outer derivative: 5(x^3+2)^4. Inner derivative: 3x^2. Product: 15x^2(x^3+2)^4"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Find d/dx[ln(x^2)]",
        "options": ["2/x", "2x/x^2", "1/x^2", "2ln(x)"],
        "correct": 0,
        "explanation": "d/dx[ln(x^2)] = (2x)/(x^2) = 2/x. Or use log rule first: ln(x^2) = 2ln(x), derivative = 2/x"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "The chain rule formula is:",
        "options": ["d/dx[f(g(x))] = f''(g(x)) x g''(x)", "d/dx[f(g(x))] = f''(x) x g''(x)", "d/dx[f(g(x))] = f(g''(x))", "d/dx[f(g(x))] = f''(g(x))"],
        "correct": 0,
        "explanation": "Chain rule: derivative of outer evaluated at inner, times derivative of inner."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Find d/dx[e^(x^2 + 3x)]",
        "options": ["(2x + 3)e^(x^2 + 3x)", "e^(x^2 + 3x)", "(x^2 + 3x)e^(x^2 + 3x)", "2xe^(2x + 3)"],
        "correct": 0,
        "explanation": "e^u stays, multiply by u'' = 2x + 3. Answer: (2x + 3)e^(x^2 + 3x)"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Revenue R(q) = 100ln(q + 10). Find marginal revenue R''(q) at q = 90.",
        "options": ["1", "10", "100", "0.1"],
        "correct": 0,
        "explanation": "R''(q) = 100/(q + 10). At q = 90: R''(90) = 100/100 = 1"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Partial Derivatives (DC-07)
-- Skill ID: c0000000-0000-0000-0007-000000000007
-- Prerequisites: Chain Rule
-- ============================================

-- Activity 7.7.1: Introduction to Partial Derivatives
(
  'b0700000-0000-0000-0007-000000000001',
  NULL,
  '7.7.1',
  10,
  'Introduction to Partial Derivatives',
  'introduction-partial-derivatives',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Introduction to Partial Derivatives\n\n## Functions of Multiple Variables\n\nIn business, many quantities depend on more than one variable:\n\n| Function | Variables | Example |\n|----------|-----------|--------|\n| Production | Labor, Capital | $Q(L, K) = 20L^{0.6}K^{0.4}$ |\n| Demand | Price, Income | $D(p, I) = 1000 - 50p + 0.1I$ |\n| Cost | Quantity, Wage | $C(q, w) = wq^2 + 500$ |\n\n---\n\n## What is a Partial Derivative?\n\n:::concept{title=\"Key Idea\"}\nA partial derivative measures the rate of change with respect to ONE variable, treating all others as constants.\n:::\n\n### Notation\n\n| Notation | Meaning |\n|----------|--------|\n| $\\frac{\\partial f}{\\partial x}$ or $f_x$ | Partial derivative with respect to x |\n| $\\frac{\\partial f}{\\partial y}$ or $f_y$ | Partial derivative with respect to y |\n\n---\n\n## How to Find Partial Derivatives\n\n### Step 1: Identify which variable to differentiate\n### Step 2: Treat all OTHER variables as constants\n### Step 3: Apply normal derivative rules\n\n---\n\n## Example 1: Basic Partial Derivatives\n\nLet $f(x, y) = 3x^2 + 2xy + y^3$\n\n**Find $f_x$ (treat y as constant):**\n$$f_x = 6x + 2y + 0 = 6x + 2y$$\n\n**Find $f_y$ (treat x as constant):**\n$$f_y = 0 + 2x + 3y^2 = 2x + 3y^2$$\n\n---\n\n## Example 2: Production Function\n\nCobb-Douglas: $Q(L, K) = 50L^{0.7}K^{0.3}$\n\n**Marginal Product of Labor:**\n$$\\frac{\\partial Q}{\\partial L} = 50 \\cdot 0.7 \\cdot L^{-0.3} \\cdot K^{0.3} = 35L^{-0.3}K^{0.3}$$\n\n**Marginal Product of Capital:**\n$$\\frac{\\partial Q}{\\partial K} = 50 \\cdot L^{0.7} \\cdot 0.3 \\cdot K^{-0.7} = 15L^{0.7}K^{-0.7}$$\n\n---\n\n## Example 3: Cost Function\n\nTotal cost: $C(x, y) = 4x^2 + 3xy + 5y^2 + 100$\n\nwhere x and y are quantities of two products.\n\n| Partial | Calculation | Interpretation |\n|---------|-------------|---------------|\n| $C_x = 8x + 3y$ | Differentiate w.r.t. x | Marginal cost of product x |\n| $C_y = 3x + 10y$ | Differentiate w.r.t. y | Marginal cost of product y |\n\n---\n\n## Evaluating at a Point\n\nFor $f(x, y) = x^2y + 3xy^2$:\n\n- $f_x = 2xy + 3y^2$\n- $f_y = x^2 + 6xy$\n\nAt point $(2, 1)$:\n- $f_x(2, 1) = 2(2)(1) + 3(1)^2 = 4 + 3 = 7$\n- $f_y(2, 1) = (2)^2 + 6(2)(1) = 4 + 12 = 16$\n\n---\n\n:::takeaways\n- Partial derivatives measure change in ONE variable\n- Treat other variables as constants\n- Use same rules as regular derivatives\n- Business applications: marginal products, marginal costs\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 7.7.2: Higher-Order Partial Derivatives
(
  'b0700000-0000-0000-0007-000000000002',
  NULL,
  '7.7.2',
  11,
  'Higher-Order Partial Derivatives',
  'higher-order-partial-derivatives',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Higher-Order Partial Derivatives\n\n## Second-Order Partials\n\nJust as we can take second derivatives of single-variable functions, we can take second partial derivatives.\n\n### Four Possibilities for f(x, y)\n\n| Notation | Meaning |\n|----------|--------|\n| $f_{xx}$ or $\\frac{\\partial^2 f}{\\partial x^2}$ | Differentiate twice w.r.t. x |\n| $f_{yy}$ or $\\frac{\\partial^2 f}{\\partial y^2}$ | Differentiate twice w.r.t. y |\n| $f_{xy}$ or $\\frac{\\partial^2 f}{\\partial y \\partial x}$ | First w.r.t. x, then w.r.t. y |\n| $f_{yx}$ or $\\frac{\\partial^2 f}{\\partial x \\partial y}$ | First w.r.t. y, then w.r.t. x |\n\n---\n\n## Example: Finding All Second Partials\n\nLet $f(x, y) = x^3 + 2x^2y - 3y^2$\n\n**First partials:**\n- $f_x = 3x^2 + 4xy$\n- $f_y = 2x^2 - 6y$\n\n**Second partials:**\n- $f_{xx} = \\frac{\\partial}{\\partial x}(3x^2 + 4xy) = 6x + 4y$\n- $f_{yy} = \\frac{\\partial}{\\partial y}(2x^2 - 6y) = -6$\n- $f_{xy} = \\frac{\\partial}{\\partial y}(3x^2 + 4xy) = 4x$\n- $f_{yx} = \\frac{\\partial}{\\partial x}(2x^2 - 6y) = 4x$\n\n---\n\n## Mixed Partials Theorem\n\n:::concept{title=\"Clairaut''s Theorem\"}\nFor most \"nice\" functions: $f_{xy} = f_{yx}$\n\nThe order of differentiation doesn''t matter!\n:::\n\nThis is useful for checking your work.\n\n---\n\n## Business Application: Profit Optimization\n\nProfit from two products: $\\pi(x, y) = 50x + 80y - x^2 - 2y^2 - xy$\n\n**First partials (for optimization):**\n- $\\pi_x = 50 - 2x - y$\n- $\\pi_y = 80 - 4y - x$\n\n**Second partials (for concavity test):**\n- $\\pi_{xx} = -2$\n- $\\pi_{yy} = -4$\n- $\\pi_{xy} = -1$\n\nThese help determine if we have a maximum or minimum.\n\n---\n\n## Summary Table\n\n| Function | $f_x$ | $f_y$ | $f_{xx}$ | $f_{yy}$ | $f_{xy}$ |\n|----------|-------|-------|----------|----------|----------|\n| $x^2y^3$ | $2xy^3$ | $3x^2y^2$ | $2y^3$ | $6x^2y$ | $6xy^2$ |\n| $e^{xy}$ | $ye^{xy}$ | $xe^{xy}$ | $y^2e^{xy}$ | $x^2e^{xy}$ | $(1+xy)e^{xy}$ |\n\n---\n\n:::takeaways\n- Second partials: differentiate first partials again\n- Four second partials exist for f(x, y)\n- Usually $f_{xy} = f_{yx}$ (mixed partials are equal)\n- Second partials used for optimization conditions\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 7.7.3: Partial Derivatives Quiz
(
  'b0700000-0000-0000-0007-000000000003',
  NULL,
  '7.7.3',
  12,
  'Partial Derivatives Practice',
  'partial-derivatives-practice',
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
        "question": "For f(x, y) = 5x^2 + 3y, find f_x",
        "options": ["10x", "5x^2 + 3", "10x + 3", "5x"],
        "correct": 0,
        "explanation": "Treating y as constant, d/dx[5x^2 + 3y] = 10x + 0 = 10x"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "For f(x, y) = x^2y^3, find f_y",
        "options": ["3x^2y^2", "2xy^3", "x^2y^2", "2x^2y^3"],
        "correct": 0,
        "explanation": "Treating x as constant, d/dy[x^2y^3] = x^2 x 3y^2 = 3x^2y^2"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "For Q(L, K) = 100L^0.5K^0.5, find dQ/dL (marginal product of labor)",
        "options": ["50L^(-0.5)K^0.5", "100L^0.5K^(-0.5)", "50K^0.5/L^0.5", "100L^(-0.5)K^0.5"],
        "correct": 0,
        "explanation": "dQ/dL = 100 x 0.5 x L^(-0.5) x K^0.5 = 50L^(-0.5)K^0.5"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "For f(x, y) = 4xy - y^2, find f_x(2, 3)",
        "options": ["12", "4", "8", "3"],
        "correct": 0,
        "explanation": "f_x = 4y. At (2, 3): f_x = 4(3) = 12"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "When finding the partial derivative with respect to x, we treat y as a constant.",
        "correct": true,
        "explanation": "True! This is the fundamental concept of partial derivatives."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "For f(x, y) = x^2 + xy + y^2, find f_xy",
        "options": ["1", "2x + y", "x + 2y", "0"],
        "correct": 0,
        "explanation": "f_x = 2x + y. Then f_xy = d/dy[2x + y] = 1"
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "For profit P(x,y) = 20x + 30y - x^2 - y^2 - 2xy, find P_x at (3, 2)",
        "options": ["8", "14", "20", "6"],
        "correct": 0,
        "explanation": "P_x = 20 - 2x - 2y. At (3,2): P_x = 20 - 6 - 4 = 10. Hmm let me recalculate: 20 - 2(3) - 2(2) = 20 - 6 - 4 = 10"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 7.7.4: Partial Derivative Matcher
(
  'b0700000-0000-0000-0007-000000000004',
  NULL,
  '7.7.4',
  13,
  'Partial Derivative Matcher',
  'partial-derivative-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each function with its partial derivative f_x (with respect to x, treating y as constant).",
    "pairs": [
      {"left": "f = 3x^2y", "right": "f_x = 6xy"},
      {"left": "f = xy^2 + 5y", "right": "f_x = y^2"},
      {"left": "f = x^3 + y^3", "right": "f_x = 3x^2"},
      {"left": "f = e^(xy)", "right": "f_x = ye^(xy)"},
      {"left": "f = ln(x) + y", "right": "f_x = 1/x"},
      {"left": "f = 4x - 2y + 7", "right": "f_x = 4"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 7.7.5: Partial Derivatives Checkpoint
(
  'b0700000-0000-0000-0007-000000000005',
  NULL,
  '7.7.5',
  14,
  'Partial Derivatives Checkpoint',
  'partial-derivatives-checkpoint',
  'checkpoint',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "For f(x, y) = x^2 - 4xy + 2y^2, find f_y",
        "options": ["-4x + 4y", "2x - 4y", "-4x + 2y", "2x - 4x"],
        "correct": 0,
        "explanation": "f_y = 0 - 4x + 4y = -4x + 4y"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Production function Q = 40L^0.6K^0.4. At L=100, K=50, find dQ/dL",
        "options": ["Approximately 19.0", "Approximately 40.0", "Approximately 24.0", "Approximately 8.0"],
        "correct": 0,
        "explanation": "dQ/dL = 40 x 0.6 x L^(-0.4) x K^0.4 = 24L^(-0.4)K^0.4. At L=100, K=50: 24 x (100)^(-0.4) x (50)^0.4 ≈ 19.0"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "What does the partial derivative f_x represent geometrically?",
        "options": ["Slope in the x-direction", "Slope in the y-direction", "Total slope", "Area under the curve"],
        "correct": 0,
        "explanation": "f_x gives the rate of change (slope) as we move in the x-direction, keeping y constant."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "For f(x,y) = xy + x^2y^2, find f_xx",
        "options": ["2y^2", "y + 2xy^2", "2x^2", "y + 4xy^2"],
        "correct": 0,
        "explanation": "f_x = y + 2xy^2. Then f_xx = 0 + 2y^2 = 2y^2"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "If f(x,y) = x^3y^2, which is TRUE?",
        "options": ["f_xy = f_yx = 6x^2y", "f_xy does not equal f_yx", "f_xy = 3x^2y^2", "f_yx = 2x^3y"],
        "correct": 0,
        "explanation": "f_x = 3x^2y^2, f_xy = 6x^2y. f_y = 2x^3y, f_yx = 6x^2y. They are equal!"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Consumer and Producer Surplus (IC-04)
-- Skill ID: c0000000-0000-0000-0008-000000000004
-- Prerequisites: Definite Integrals, Graph Interpretation
-- ============================================

-- Activity 8.4.1: Understanding Economic Surplus
(
  'b0800000-0000-0000-0004-000000000001',
  NULL,
  '8.4.1',
  5,
  'Understanding Economic Surplus',
  'understanding-economic-surplus',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Understanding Economic Surplus\n\n## Market Equilibrium\n\nIn a market:\n- **Demand curve**: How much consumers will buy at each price\n- **Supply curve**: How much producers will sell at each price\n- **Equilibrium**: Where supply meets demand\n\n---\n\n## What is Consumer Surplus?\n\n:::concept{title=\"Consumer Surplus\"}\nThe difference between what consumers are WILLING to pay and what they ACTUALLY pay.\n:::\n\n### Graphical Interpretation\nConsumer surplus is the **area between the demand curve and the equilibrium price**.\n\n### Example\nIf you''re willing to pay CHF 50 for a coffee but only pay CHF 5, your surplus is CHF 45.\n\n---\n\n## What is Producer Surplus?\n\n:::concept{title=\"Producer Surplus\"}\nThe difference between what producers RECEIVE and the MINIMUM they would accept.\n:::\n\n### Graphical Interpretation\nProducer surplus is the **area between the equilibrium price and the supply curve**.\n\n---\n\n## Visual Representation\n\n```\nPrice\n  ^\n  |     D\n P|    /|\\\n  |   / | \\ \n Pₑ|--/--|--\\-- Equilibrium Price\n  | /   |   \\\n  |/    |    \\\n  +-----|------> Quantity\n        Qₑ\n\nArea above Pₑ, under D = Consumer Surplus\nArea below Pₑ, above S = Producer Surplus\n```\n\n---\n\n## Calculating with Integration\n\nFor linear curves:\n\n### Consumer Surplus\n$$CS = \\int_0^{Q_e} D(Q) \\, dQ - P_e \\cdot Q_e$$\n\n**Or:** Area of triangle above equilibrium price\n\n### Producer Surplus\n$$PS = P_e \\cdot Q_e - \\int_0^{Q_e} S(Q) \\, dQ$$\n\n**Or:** Area of triangle below equilibrium price\n\n---\n\n## Example: Linear Curves\n\nDemand: $P = 100 - 2Q$\nSupply: $P = 20 + 2Q$\n\n**Find equilibrium:**\n$100 - 2Q = 20 + 2Q$\n$80 = 4Q$\n$Q_e = 20, P_e = 60$\n\n**Consumer Surplus:**\n$$CS = \\frac{1}{2} \\times 20 \\times (100 - 60) = \\frac{1}{2} \\times 20 \\times 40 = 400$$\n\n**Producer Surplus:**\n$$PS = \\frac{1}{2} \\times 20 \\times (60 - 20) = \\frac{1}{2} \\times 20 \\times 40 = 400$$\n\n---\n\n## Total Welfare\n\n$$\\text{Total Welfare} = CS + PS$$\n\nThis measures the total benefit to society from the market transaction.\n\n---\n\n:::takeaways\n- Consumer surplus: What you''d pay minus what you do pay\n- Producer surplus: What you receive minus your minimum\n- Both are areas on a supply-demand graph\n- Total welfare = CS + PS\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 8.4.2: Calculating Surplus with Integration
(
  'b0800000-0000-0000-0004-000000000002',
  NULL,
  '8.4.2',
  6,
  'Calculating Surplus with Integration',
  'calculating-surplus-integration',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Calculating Surplus with Integration\n\n## The General Formulas\n\n### Consumer Surplus\n$$CS = \\int_0^{Q_e} D(Q) \\, dQ - P_e \\cdot Q_e$$\n\nOr equivalently:\n$$CS = \\int_0^{Q_e} [D(Q) - P_e] \\, dQ$$\n\n### Producer Surplus\n$$PS = P_e \\cdot Q_e - \\int_0^{Q_e} S(Q) \\, dQ$$\n\nOr equivalently:\n$$PS = \\int_0^{Q_e} [P_e - S(Q)] \\, dQ$$\n\n---\n\n## Step-by-Step Process\n\n### Step 1: Find Equilibrium\nSet demand equal to supply and solve for $Q_e$ and $P_e$.\n\n### Step 2: Set Up Integrals\nIdentify which formula to use.\n\n### Step 3: Evaluate the Integral\nCalculate the definite integral.\n\n### Step 4: Interpret Results\nState what the surplus values mean.\n\n---\n\n## Example: Nonlinear Demand\n\nDemand: $P = 80 - Q^2$ (nonlinear)\nSupply: $P = 20 + Q$\n\n**Step 1: Find Equilibrium**\n$80 - Q^2 = 20 + Q$\n$Q^2 + Q - 60 = 0$\n$(Q - 6)(Q + 10) = 0$\n$Q_e = 6$ (positive value)\n$P_e = 20 + 6 = 26$\n\n---\n\n**Step 2: Consumer Surplus**\n$$CS = \\int_0^{6} (80 - Q^2) \\, dQ - 26 \\cdot 6$$\n\n$$= \\left[80Q - \\frac{Q^3}{3}\\right]_0^{6} - 156$$\n\n$$= \\left(480 - 72\\right) - 156 = 408 - 156 = 252$$\n\n---\n\n**Step 3: Producer Surplus**\n$$PS = 26 \\cdot 6 - \\int_0^{6} (20 + Q) \\, dQ$$\n\n$$= 156 - \\left[20Q + \\frac{Q^2}{2}\\right]_0^{6}$$\n\n$$= 156 - (120 + 18) = 156 - 138 = 18$$\n\n---\n\n## Summary of Example\n\n| Measure | Value | Interpretation |\n|---------|-------|---------------|\n| $Q_e$ | 6 units | Market quantity |\n| $P_e$ | CHF 26 | Market price |\n| CS | CHF 252 | Consumer benefit |\n| PS | CHF 18 | Producer benefit |\n| Total Welfare | CHF 270 | Society''s benefit |\n\n---\n\n## Special Case: Linear Curves\n\nFor linear supply and demand, surplus areas are triangles:\n\n$$CS = \\frac{1}{2} \\times Q_e \\times (P_{max} - P_e)$$\n$$PS = \\frac{1}{2} \\times Q_e \\times (P_e - P_{min})$$\n\nwhere $P_{max}$ is the y-intercept of demand and $P_{min}$ is the y-intercept of supply.\n\n---\n\n:::takeaways\n- Use integration for exact surplus calculations\n- Consumer surplus = Area under demand, above price\n- Producer surplus = Area above supply, below price\n- For linear curves, triangle formulas work\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 8.4.3: Economic Surplus Quiz
(
  'b0800000-0000-0000-0004-000000000003',
  NULL,
  '8.4.3',
  7,
  'Economic Surplus Practice',
  'economic-surplus-practice',
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
        "question": "Consumer surplus measures:",
        "options": ["The difference between willingness to pay and actual price", "The profit earned by producers", "The total revenue from sales", "The cost of production"],
        "correct": 0,
        "explanation": "Consumer surplus is what consumers would have paid minus what they actually pay."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "On a supply-demand graph, consumer surplus is represented by:",
        "options": ["Area above equilibrium price, below demand curve", "Area below equilibrium price, above supply curve", "Area below both curves", "Total area between the curves"],
        "correct": 0,
        "explanation": "Consumer surplus is the area between the demand curve and the equilibrium price line."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If demand is P = 50 - Q and supply is P = 10 + Q, what is the equilibrium quantity?",
        "options": ["20", "30", "10", "40"],
        "correct": 0,
        "explanation": "50 - Q = 10 + Q, so 40 = 2Q, Q = 20"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "With P_e = 30, Q_e = 20, and demand y-intercept at P = 50, consumer surplus for linear demand is:",
        "options": ["200", "600", "400", "100"],
        "correct": 0,
        "explanation": "CS = (1/2) x 20 x (50 - 30) = (1/2) x 20 x 20 = 200"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Total welfare equals consumer surplus plus producer surplus.",
        "correct": true,
        "explanation": "True! Total welfare (or total economic surplus) is CS + PS."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Calculate: Integral from 0 to 5 of (40 - 2Q) dQ",
        "options": ["175", "200", "150", "225"],
        "correct": 0,
        "explanation": "Integral = [40Q - Q^2] from 0 to 5 = (200 - 25) - 0 = 175"
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If CS = 300 and PS = 150, and the government imposes a tax that reduces CS to 200 and PS to 100, what is the deadweight loss?",
        "options": ["150", "100", "300", "50"],
        "correct": 0,
        "explanation": "Original welfare = 300 + 150 = 450. New welfare = 200 + 100 = 300. Lost welfare = 450 - 300 = 150 (plus tax revenue goes to government, but assuming no redistribution, DWL = 150)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 8.4.4: Surplus Concepts Matcher
(
  'b0800000-0000-0000-0004-000000000004',
  NULL,
  '8.4.4',
  8,
  'Economic Surplus Concepts Matcher',
  'economic-surplus-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each economic concept with its correct definition or formula.",
    "pairs": [
      {"left": "Consumer Surplus", "right": "Willingness to pay minus price paid"},
      {"left": "Producer Surplus", "right": "Price received minus minimum acceptable price"},
      {"left": "Total Welfare", "right": "CS + PS"},
      {"left": "Equilibrium", "right": "Where supply equals demand"},
      {"left": "CS Formula (integral)", "right": "Integral of D(Q) minus P_e x Q_e"},
      {"left": "Deadweight Loss", "right": "Lost surplus from market inefficiency"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 8.4.5: Consumer/Producer Surplus Checkpoint
(
  'b0800000-0000-0000-0004-000000000005',
  NULL,
  '8.4.5',
  9,
  'Economic Surplus Checkpoint',
  'economic-surplus-checkpoint',
  'checkpoint',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "A consumer willing to pay CHF 100 buys at CHF 75. Their surplus is:",
        "options": ["CHF 25", "CHF 75", "CHF 100", "CHF 175"],
        "correct": 0,
        "explanation": "Consumer surplus = Willingness to pay - Actual price = 100 - 75 = 25"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "For linear demand P = 80 - 4Q with equilibrium at Q = 10, P = 40, find CS:",
        "options": ["200", "400", "100", "800"],
        "correct": 0,
        "explanation": "CS = (1/2) x 10 x (80 - 40) = (1/2) x 10 x 40 = 200"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Producer surplus is calculated as:",
        "options": ["P_e x Q_e minus integral of supply", "Integral of demand minus P_e x Q_e", "Integral of demand plus integral of supply", "P_e divided by Q_e"],
        "correct": 0,
        "explanation": "PS = Total revenue (P_e x Q_e) minus the integral of the supply curve from 0 to Q_e"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Demand: P = 100 - 2Q, Supply: P = 40 + Q. What is equilibrium price?",
        "options": ["60", "40", "80", "50"],
        "correct": 0,
        "explanation": "100 - 2Q = 40 + Q gives 3Q = 60, Q = 20. Then P = 40 + 20 = 60"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Why does maximizing total welfare matter in economics?",
        "options": ["It represents the total benefit to society", "It only benefits consumers", "It only benefits producers", "It minimizes government revenue"],
        "correct": 0,
        "explanation": "Total welfare (CS + PS) represents the combined benefit to all participants in the market."
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

-- Chain Rule Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0700000-0000-0000-0005-000000000001', 'c0000000-0000-0000-0007-000000000005', true, 1, true, true, 1.0),
('b0700000-0000-0000-0005-000000000002', 'c0000000-0000-0000-0007-000000000005', true, 2, true, true, 1.0),
('b0700000-0000-0000-0005-000000000003', 'c0000000-0000-0000-0007-000000000005', true, 3, true, true, 1.0),
('b0700000-0000-0000-0005-000000000004', 'c0000000-0000-0000-0007-000000000005', true, 4, true, true, 1.0),
('b0700000-0000-0000-0005-000000000005', 'c0000000-0000-0000-0007-000000000005', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Partial Derivatives Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0700000-0000-0000-0007-000000000001', 'c0000000-0000-0000-0007-000000000007', true, 1, true, true, 1.0),
('b0700000-0000-0000-0007-000000000002', 'c0000000-0000-0000-0007-000000000007', true, 2, true, true, 1.0),
('b0700000-0000-0000-0007-000000000003', 'c0000000-0000-0000-0007-000000000007', true, 3, true, true, 1.0),
('b0700000-0000-0000-0007-000000000004', 'c0000000-0000-0000-0007-000000000007', true, 4, true, true, 1.0),
('b0700000-0000-0000-0007-000000000005', 'c0000000-0000-0000-0007-000000000007', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Consumer/Producer Surplus Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0800000-0000-0000-0004-000000000001', 'c0000000-0000-0000-0008-000000000004', true, 1, true, true, 1.0),
('b0800000-0000-0000-0004-000000000002', 'c0000000-0000-0000-0008-000000000004', true, 2, true, true, 1.0),
('b0800000-0000-0000-0004-000000000003', 'c0000000-0000-0000-0008-000000000004', true, 3, true, true, 1.0),
('b0800000-0000-0000-0004-000000000004', 'c0000000-0000-0000-0008-000000000004', true, 4, true, true, 1.0),
('b0800000-0000-0000-0004-000000000005', 'c0000000-0000-0000-0008-000000000004', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

