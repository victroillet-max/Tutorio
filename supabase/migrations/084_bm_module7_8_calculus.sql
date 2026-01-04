-- ============================================
-- Modules 7-8: Differential and Integral Calculus
-- Core Skills: Derivatives, Optimization, Integration
-- ============================================

-- ============================================
-- SKILL: Derivative Concept (DC-02)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

(
  'b0700000-0000-0000-0002-000000000001',
  'b0000000-0000-0000-0000-000000000007',
  '7.2.1',
  1,
  'Understanding Derivatives',
  'understanding-derivatives',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Understanding Derivatives\n\n## What is a Derivative?\n\nThe derivative measures the **instantaneous rate of change** of a function.\n\n$$f''(x) = \\lim_{h \\to 0} \\frac{f(x+h) - f(x)}{h}$$\n\n---\n\n## Intuitive Understanding\n\n:::concept{title=\"The Derivative Is...\"}\n- The slope of the tangent line at a point\n- The instantaneous rate of change\n- How fast the function is changing\n:::\n\n### Example: Position and Velocity\n\nIf s(t) = position at time t, then:\n- s''(t) = velocity (rate of change of position)\n- s''''(t) = acceleration (rate of change of velocity)\n\n---\n\n## Notation\n\n| Notation | Read As | Meaning |\n|----------|---------|--------|\n| f''(x) | f prime of x | Derivative of f |\n| dy/dx | dee y dee x | Derivative of y with respect to x |\n| d/dx[f(x)] | derivative of f | Taking the derivative |\n\n---\n\n## Business Interpretation\n\n### Marginal Concepts\n\n| If | Then Derivative Is |\n|----|-----------------|\n| C(x) = Total Cost | C''(x) = Marginal Cost |\n| R(x) = Total Revenue | R''(x) = Marginal Revenue |\n| P(x) = Total Profit | P''(x) = Marginal Profit |\n\n**Marginal** = Cost/Revenue/Profit of ONE MORE unit\n\n---\n\n## Example: Marginal Cost\n\nIf C(x) = 1000 + 50x + 0.1x²\n\nThen C''(x) = 50 + 0.2x (we''ll learn how to get this)\n\nAt x = 100: C''(100) = 50 + 20 = CHF 70\n\n**The 101st unit costs approximately CHF 70 to produce.**\n\n---\n\n:::takeaways\n- Derivative = instantaneous rate of change = slope of tangent\n- Notation: f''(x), dy/dx, d/dx[f(x)]\n- In business: derivatives give marginal cost, revenue, profit\n- Marginal = additional cost/benefit of one more unit\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0700000-0000-0000-0002-000000000002',
  'b0000000-0000-0000-0000-000000000007',
  '7.2.2',
  2,
  'Derivative Concept Checkpoint',
  'derivative-concept-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The derivative of a function measures:",
        "options": ["The rate of change", "The area under the curve", "The maximum value", "The y-intercept"],
        "correct": 0,
        "explanation": "The derivative gives the instantaneous rate of change of a function."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "If C(x) is total cost, C''(x) represents:",
        "options": ["Marginal cost", "Average cost", "Fixed cost", "Total cost"],
        "correct": 0,
        "explanation": "The derivative of cost is marginal cost - the cost of one more unit."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "The derivative at a point equals:",
        "options": ["Slope of the tangent line", "y-coordinate", "x-coordinate", "Area"],
        "correct": 0,
        "explanation": "The derivative at a point is the slope of the tangent line at that point."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Basic Derivative Rules (DC-03)
-- ============================================

(
  'b0700000-0000-0000-0003-000000000001',
  'b0000000-0000-0000-0000-000000000007',
  '7.3.1',
  3,
  'Basic Derivative Rules',
  'basic-derivative-rules',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Basic Derivative Rules\n\n## The Power Rule\n\n$$\\frac{d}{dx}[x^n] = nx^{n-1}$$\n\n### Examples\n\n| Function | Derivative | Steps |\n|----------|------------|-------|\n| x³ | 3x² | Bring 3 down, reduce power by 1 |\n| x⁵ | 5x⁴ | Bring 5 down, reduce power by 1 |\n| x | 1 | x¹ becomes 1x⁰ = 1 |\n| x⁻² | -2x⁻³ | Works for negative exponents too |\n\n---\n\n## Constant Rule\n\n$$\\frac{d}{dx}[c] = 0$$\n\nThe derivative of a constant is zero.\n\n**Example:** d/dx[5] = 0\n\n---\n\n## Constant Multiple Rule\n\n$$\\frac{d}{dx}[cf(x)] = c \\cdot f''(x)$$\n\n**Example:** d/dx[3x²] = 3 · 2x = 6x\n\n---\n\n## Sum/Difference Rule\n\n$$\\frac{d}{dx}[f(x) ± g(x)] = f''(x) ± g''(x)$$\n\nTake derivatives term by term.\n\n---\n\n## Combined Example\n\n**Find the derivative of:** f(x) = 4x³ - 2x² + 5x - 7\n\n| Term | Derivative |\n|------|------------|\n| 4x³ | 12x² |\n| -2x² | -4x |\n| 5x | 5 |\n| -7 | 0 |\n\n**Answer:** f''(x) = 12x² - 4x + 5\n\n---\n\n## Business Application\n\n**Cost function:** C(x) = 1000 + 50x + 0.5x²\n\n**Marginal cost:** C''(x) = 50 + x\n\nAt x = 20 units: C''(20) = 50 + 20 = CHF 70/unit\n\n---\n\n:::takeaways\n- Power rule: d/dx[xⁿ] = nxⁿ⁻¹\n- Constants vanish, coefficients multiply through\n- Sum rule: differentiate term by term\n- These rules handle most polynomial functions\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0700000-0000-0000-0003-000000000002',
  'b0000000-0000-0000-0000-000000000007',
  '7.3.2',
  4,
  'Derivative Rules Quiz',
  'derivative-rules-quiz',
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
        "question": "Find f''(x) if f(x) = x⁴",
        "options": ["4x³", "x³", "4x⁴", "x⁵/5"],
        "correct": 0,
        "explanation": "Power rule: 4x^(4-1) = 4x³"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is d/dx[7]?",
        "options": ["0", "7", "1", "7x"],
        "correct": 0,
        "explanation": "The derivative of any constant is 0."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Find f''(x) if f(x) = 3x² + 2x - 5",
        "options": ["6x + 2", "6x² + 2", "3x + 2", "x² + 2x"],
        "correct": 0,
        "explanation": "d/dx[3x²] = 6x, d/dx[2x] = 2, d/dx[-5] = 0. Total: 6x + 2"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If C(x) = 500 + 30x + 2x², find C''(x) and evaluate at x = 10",
        "options": ["C''(10) = 70", "C''(10) = 30", "C''(10) = 250", "C''(10) = 50"],
        "correct": 0,
        "explanation": "C''(x) = 30 + 4x. At x = 10: C''(10) = 30 + 40 = 70"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0700000-0000-0000-0003-000000000003',
  'b0000000-0000-0000-0000-000000000007',
  '7.3.3',
  5,
  'Derivative Rules Checkpoint',
  'derivative-rules-checkpoint',
  'checkpoint',
  10,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Differentiate: f(x) = 5x³ - 2x + 1",
        "options": ["15x² - 2", "5x² - 2", "15x² - 2x", "5x³ - 2"],
        "correct": 0,
        "explanation": "d/dx[5x³] = 15x², d/dx[-2x] = -2, d/dx[1] = 0"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Find d/dx[x⁻¹]",
        "options": ["-x⁻²", "x⁻²", "-1", "1/x"],
        "correct": 0,
        "explanation": "Power rule: -1 · x^(-1-1) = -x⁻²"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "If R(x) = 100x - 2x², find marginal revenue R''(x)",
        "options": ["100 - 4x", "100 - 2x", "100x - 4", "100 - 2x²"],
        "correct": 0,
        "explanation": "R''(x) = 100 - 4x"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "At what value of x does marginal cost equal 60 if C''(x) = 20 + 4x?",
        "options": ["x = 10", "x = 15", "x = 20", "x = 5"],
        "correct": 0,
        "explanation": "20 + 4x = 60, 4x = 40, x = 10"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Optimization (DC-08)
-- ============================================

(
  'b0700000-0000-0000-0008-000000000001',
  'b0000000-0000-0000-0000-000000000007',
  '7.8.1',
  6,
  'Optimization with Derivatives',
  'optimization-derivatives',
  'lesson',
  18,
  40,
  'basic',
  '{"markdown": "# Optimization with Derivatives\n\n## Finding Maximum and Minimum Values\n\nOptimization is about finding the best (highest or lowest) values of a function.\n\n---\n\n## Critical Points\n\n:::concept{title=\"Critical Points\"}\nPoints where f''(x) = 0 or f''(x) is undefined.\nThese are candidates for maxima or minima.\n:::\n\n---\n\n## The First Derivative Test\n\n1. Find f''(x)\n2. Solve f''(x) = 0 for critical points\n3. Test sign of f''(x) on either side:\n\n| Sign Change | Type of Point |\n|-------------|---------------|\n| + to - | Local Maximum |\n| - to + | Local Minimum |\n| No change | Neither (inflection) |\n\n---\n\n## The Second Derivative Test\n\nAt a critical point x = c:\n\n| If f''''(c) | Then x = c is a |\n|------------|----------------|\n| < 0 | Local Maximum |\n| > 0 | Local Minimum |\n| = 0 | Test is inconclusive |\n\n---\n\n## Example: Profit Maximization\n\n**Profit function:** P(x) = -2x² + 120x - 1000\n\n**Step 1: Find critical points**\n$$P''(x) = -4x + 120 = 0$$\n$$x = 30$$\n\n**Step 2: Second derivative test**\n$$P''''(x) = -4 < 0$$\n\nSince P''''(x) < 0, x = 30 is a maximum.\n\n**Step 3: Find maximum profit**\n$$P(30) = -2(900) + 120(30) - 1000 = -1800 + 3600 - 1000 = CHF 800$$\n\n---\n\n## Business Applications\n\n### Profit Maximization\nMaximize P(x) = R(x) - C(x)\n\n### Cost Minimization\nFind x where average cost AC(x) = C(x)/x is minimized.\n\n### Revenue Maximization\nFind price/quantity where R(x) = p · x is maximum.\n\n---\n\n:::takeaways\n- Critical points: where f''(x) = 0\n- First derivative test: check sign changes\n- Second derivative test: f''''(c) < 0 = max, f''''(c) > 0 = min\n- Business: maximize profit, minimize cost, optimize pricing\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0700000-0000-0000-0008-000000000002',
  'b0000000-0000-0000-0000-000000000007',
  '7.8.2',
  7,
  'Optimization Checkpoint',
  'optimization-checkpoint',
  'checkpoint',
  12,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "To find critical points, we set ___ equal to zero.",
        "options": ["The first derivative", "The function", "The second derivative", "The x value"],
        "correct": 0,
        "explanation": "Critical points occur where f''(x) = 0 (or is undefined)."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "If f''''(c) < 0 at a critical point, then x = c is a:",
        "options": ["Local maximum", "Local minimum", "Inflection point", "Cannot determine"],
        "correct": 0,
        "explanation": "Negative second derivative at critical point = concave down = maximum."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "P(x) = -x² + 40x - 100. At what x is profit maximized?",
        "options": ["x = 20", "x = 40", "x = 10", "x = 100"],
        "correct": 0,
        "explanation": "P''(x) = -2x + 40 = 0, so x = 20"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Maximum profit for P(x) = -x² + 40x - 100 is:",
        "options": ["CHF 300", "CHF 400", "CHF 200", "CHF 500"],
        "correct": 0,
        "explanation": "P(20) = -(400) + 800 - 100 = 300"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Antiderivatives/Integration (IC-01)
-- ============================================

(
  'b0800000-0000-0000-0001-000000000001',
  'b0000000-0000-0000-0000-000000000008',
  '8.1.1',
  1,
  'Introduction to Integration',
  'introduction-integration',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Introduction to Integration\n\n## What is an Antiderivative?\n\nAn antiderivative (or indefinite integral) reverses differentiation.\n\nIf F''(x) = f(x), then F(x) is an antiderivative of f(x).\n\n---\n\n## Notation\n\n$$\\int f(x) \\, dx = F(x) + C$$\n\n- ∫ = integral sign\n- f(x) = integrand (function to integrate)\n- dx = variable of integration\n- C = constant of integration\n\n---\n\n## Basic Integration Rules\n\n### Power Rule for Integration\n\n$$\\int x^n \\, dx = \\frac{x^{n+1}}{n+1} + C \\quad (n \\neq -1)$$\n\n### Examples\n\n| Integral | Result |\n|----------|--------|\n| ∫ x² dx | x³/3 + C |\n| ∫ x⁴ dx | x⁵/5 + C |\n| ∫ 1 dx | x + C |\n| ∫ x dx | x²/2 + C |\n\n### Constant Rule\n$$\\int k \\, dx = kx + C$$\n\n### Constant Multiple\n$$\\int kf(x) \\, dx = k \\int f(x) \\, dx$$\n\n---\n\n## Sum/Difference Rule\n\n$$\\int [f(x) \\pm g(x)] \\, dx = \\int f(x) \\, dx \\pm \\int g(x) \\, dx$$\n\n---\n\n## Example: Integrating a Polynomial\n\n$$\\int (3x^2 + 4x - 5) \\, dx$$\n\n| Term | Integral |\n|------|----------|\n| 3x² | x³ |\n| 4x | 2x² |\n| -5 | -5x |\n\n**Answer:** x³ + 2x² - 5x + C\n\n---\n\n:::takeaways\n- Integration reverses differentiation\n- Power rule: Add 1 to exponent, divide by new exponent\n- Always add + C for indefinite integrals\n- Integrate term by term for sums\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0800000-0000-0000-0001-000000000002',
  'b0000000-0000-0000-0000-000000000008',
  '8.1.2',
  2,
  'Integration Checkpoint',
  'integration-checkpoint',
  'checkpoint',
  10,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "∫ x³ dx = ?",
        "options": ["x⁴/4 + C", "3x² + C", "x⁴ + C", "4x³ + C"],
        "correct": 0,
        "explanation": "Add 1 to power: 3+1=4. Divide by new power: x⁴/4 + C"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "∫ 5 dx = ?",
        "options": ["5x + C", "5 + C", "0", "x/5 + C"],
        "correct": 0,
        "explanation": "The integral of a constant k is kx + C"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "∫ (2x + 3) dx = ?",
        "options": ["x² + 3x + C", "2x² + 3x + C", "x² + 3 + C", "2 + C"],
        "correct": 0,
        "explanation": "∫2x dx = x², ∫3 dx = 3x. Total: x² + 3x + C"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Why do we add + C to indefinite integrals?",
        "options": ["Because many functions have the same derivative", "Convention only", "To make it positive", "For units"],
        "correct": 0,
        "explanation": "f(x) + C and f(x) + 5 both have the same derivative, so we need C to represent all possibilities."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Definite Integrals (IC-02)
-- ============================================

(
  'b0800000-0000-0000-0002-000000000001',
  'b0000000-0000-0000-0000-000000000008',
  '8.2.1',
  3,
  'Definite Integrals and Area',
  'definite-integrals-area',
  'lesson',
  15,
  40,
  'basic',
  '{"markdown": "# Definite Integrals and Area\n\n## What is a Definite Integral?\n\nA definite integral calculates the **signed area** between a function and the x-axis over an interval [a, b].\n\n$$\\int_a^b f(x) \\, dx = F(b) - F(a)$$\n\n- a = lower limit\n- b = upper limit\n- F(x) = antiderivative of f(x)\n\n---\n\n## The Fundamental Theorem of Calculus\n\n$$\\int_a^b f(x) \\, dx = F(b) - F(a)$$\n\nWhere F''(x) = f(x)\n\n---\n\n## Example: Calculate Area\n\n$$\\int_1^3 x^2 \\, dx$$\n\n**Step 1: Find antiderivative**\n$$F(x) = \\frac{x^3}{3}$$\n\n**Step 2: Evaluate at limits**\n$$F(3) - F(1) = \\frac{27}{3} - \\frac{1}{3} = 9 - \\frac{1}{3} = \\frac{26}{3}$$\n\n---\n\n## Business Application: Total Change\n\nIf R''(x) = marginal revenue, then:\n\n$$\\int_a^b R''(x) \\, dx = R(b) - R(a) = \\text{Change in Revenue}$$\n\n### Example\nMarginal revenue = 50 - 2x\n\nTotal revenue from selling units 10 to 20:\n$$\\int_{10}^{20} (50 - 2x) \\, dx = [50x - x^2]_{10}^{20}$$\n$$= (1000 - 400) - (500 - 100) = 600 - 400 = CHF 200$$\n\n---\n\n:::takeaways\n- Definite integral gives area under curve between limits\n- Fundamental Theorem: ∫ₐᵇ f(x)dx = F(b) - F(a)\n- No + C needed for definite integrals\n- Business: integrating marginal functions gives total change\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0800000-0000-0000-0002-000000000002',
  'b0000000-0000-0000-0000-000000000008',
  '8.2.2',
  4,
  'Definite Integrals Checkpoint',
  'definite-integrals-checkpoint',
  'checkpoint',
  12,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Evaluate: ∫₀² 3x² dx",
        "options": ["8", "6", "12", "4"],
        "correct": 0,
        "explanation": "F(x) = x³. F(2) - F(0) = 8 - 0 = 8"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "∫₁⁴ 2 dx = ?",
        "options": ["6", "8", "2", "4"],
        "correct": 0,
        "explanation": "∫2 dx = 2x. [2x]₁⁴ = 2(4) - 2(1) = 8 - 2 = 6"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "A definite integral gives:",
        "options": ["The signed area between the curve and x-axis", "The slope of the function", "The maximum value", "The antiderivative"],
        "correct": 0,
        "explanation": "The definite integral calculates the signed area under the curve."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Evaluate: ∫₀³ (4x) dx",
        "options": ["18", "12", "6", "36"],
        "correct": 0,
        "explanation": "F(x) = 2x². F(3) - F(0) = 2(9) - 0 = 18"
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
-- Activity Skill Tags for Modules 7-8
-- ============================================

-- Skill: Derivative Concept (DC-02)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0700000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0007-000000000002', true, 1, true, true, 1.0),
('b0700000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0007-000000000002', true, 2, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Basic Derivative Rules (DC-03)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0700000-0000-0000-0003-000000000001', 'c0000000-0000-0000-0007-000000000003', true, 1, true, true, 1.0),
('b0700000-0000-0000-0003-000000000002', 'c0000000-0000-0000-0007-000000000003', true, 2, true, true, 1.0),
('b0700000-0000-0000-0003-000000000003', 'c0000000-0000-0000-0007-000000000003', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Optimization (DC-08)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0700000-0000-0000-0008-000000000001', 'c0000000-0000-0000-0007-000000000008', true, 1, true, true, 1.0),
('b0700000-0000-0000-0008-000000000002', 'c0000000-0000-0000-0007-000000000008', true, 2, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Antiderivatives (IC-01)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0800000-0000-0000-0001-000000000001', 'c0000000-0000-0000-0008-000000000001', true, 1, true, true, 1.0),
('b0800000-0000-0000-0001-000000000002', 'c0000000-0000-0000-0008-000000000001', true, 2, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Definite Integrals (IC-02)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0800000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0008-000000000002', true, 1, true, true, 1.0),
('b0800000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0008-000000000002', true, 2, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

