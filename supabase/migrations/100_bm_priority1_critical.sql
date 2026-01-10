-- ============================================
-- Phase 1: Critical Missing Skills
-- Logarithm Basics, Logarithm Rules, Quadratic Equations
-- 15 Activities (5 per skill)
-- ============================================

-- ============================================
-- SKILL: Logarithm Basics (EL-04)
-- Skill ID: c0000000-0000-0000-0004-000000000004
-- Prerequisites: Negative/Fractional Exponents
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 4.4.1: Introduction to Logarithms
(
  'b0400000-0000-0000-0004-000000000001',
  NULL,
  '4.4.1',
  101,
  'Introduction to Logarithms',
  'introduction-to-logarithms',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to Logarithms\n\n## What is a Logarithm?\n\nA logarithm answers the question: **What exponent do I need?**\n\n$$\\log_b(x) = y \\text{ means } b^y = x$$\n\n- **b** = base (must be positive, not 1)\n- **x** = argument (must be positive)\n- **y** = the exponent we are finding\n\n---\n\n## Logarithms as Inverse of Exponents\n\n| Exponential Form | Logarithmic Form | Question Answered |\n|------------------|------------------|------------------|\n| $2^3 = 8$ | $\\log_2(8) = 3$ | 2 to what power gives 8? |\n| $10^2 = 100$ | $\\log_{10}(100) = 2$ | 10 to what power gives 100? |\n| $5^4 = 625$ | $\\log_5(625) = 4$ | 5 to what power gives 625? |\n\n:::concept{title=\"The Relationship\"}\nExponents and logarithms are inverse operations, just like:\n- Addition and Subtraction\n- Multiplication and Division\n:::\n\n---\n\n## Converting Between Forms\n\n### Exponential to Logarithmic\n$$3^4 = 81 \\rightarrow \\log_3(81) = 4$$\n\n### Logarithmic to Exponential\n$$\\log_7(49) = 2 \\rightarrow 7^2 = 49$$\n\n---\n\n## Special Values to Memorize\n\n| Expression | Value | Why |\n|------------|-------|-----|\n| $\\log_b(1)$ | 0 | Because $b^0 = 1$ |\n| $\\log_b(b)$ | 1 | Because $b^1 = b$ |\n| $\\log_b(b^n)$ | n | Because $b^n = b^n$ |\n\n---\n\n## Practice Examples\n\n### Example 1\nFind $\\log_4(64)$\n\n**Think:** 4 to what power gives 64?\n- $4^1 = 4$\n- $4^2 = 16$\n- $4^3 = 64$ ✓\n\n**Answer:** $\\log_4(64) = 3$\n\n### Example 2\nFind $\\log_9(3)$\n\n**Think:** 9 to what power gives 3?\n- $9^{1/2} = \\sqrt{9} = 3$ ✓\n\n**Answer:** $\\log_9(3) = 0.5$\n\n---\n\n## Business Context\n\nLogarithms are used in:\n- Measuring earthquake intensity (Richter scale)\n- Sound levels (decibels)\n- pH acidity scale\n- Analyzing growth rates\n- Solving compound interest problems for time\n\n---\n\n:::takeaways\n- $\\log_b(x) = y$ means $b^y = x$\n- Logarithms answer: \"What exponent do I need?\"\n- $\\log_b(1) = 0$ and $\\log_b(b) = 1$ always\n- Logarithms and exponents are inverses\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.4.2: Common and Natural Logarithms
(
  'b0400000-0000-0000-0004-000000000002',
  NULL,
  '4.4.2',
  102,
  'Common and Natural Logarithms',
  'common-natural-logarithms',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Common and Natural Logarithms\n\n## Two Special Bases\n\nWhile logarithms can have any positive base (except 1), two bases are used so frequently they get special names:\n\n| Name | Base | Notation | Calculator Key |\n|------|------|----------|---------------|\n| Common Logarithm | 10 | $\\log(x)$ or $\\log_{10}(x)$ | LOG |\n| Natural Logarithm | e ≈ 2.718 | $\\ln(x)$ or $\\log_e(x)$ | LN |\n\n---\n\n## Common Logarithm (Base 10)\n\nWhen you see $\\log(x)$ without a base written, it means base 10.\n\n| Expression | Value | Reasoning |\n|------------|-------|----------|\n| $\\log(10)$ | 1 | $10^1 = 10$ |\n| $\\log(100)$ | 2 | $10^2 = 100$ |\n| $\\log(1000)$ | 3 | $10^3 = 1000$ |\n| $\\log(1)$ | 0 | $10^0 = 1$ |\n| $\\log(0.01)$ | -2 | $10^{-2} = 0.01$ |\n\n:::tip{title=\"Pattern\"}\n$\\log(10^n) = n$ always\n\nCounting zeros: $\\log(1,000,000) = 6$ (six zeros)\n:::\n\n---\n\n## Natural Logarithm (Base e)\n\nThe number **e** (approximately 2.71828) is called Euler''s number.\n\n| Expression | Approximate Value |\n|------------|------------------|\n| $\\ln(1)$ | 0 |\n| $\\ln(e)$ | 1 |\n| $\\ln(e^2)$ | 2 |\n| $\\ln(2)$ | 0.693 |\n| $\\ln(10)$ | 2.303 |\n\n---\n\n## Why e Matters in Business\n\n:::concept{title=\"Continuous Growth\"}\nThe number e appears naturally when growth happens continuously:\n- Continuous compounding of interest\n- Population growth models\n- Radioactive decay\n- Market growth analysis\n:::\n\n---\n\n## Using Your Calculator\n\n### To find $\\log(50)$:\n1. Press 5, 0\n2. Press LOG\n3. Result: 1.699\n\n### To find $\\ln(50)$:\n1. Press 5, 0\n2. Press LN\n3. Result: 3.912\n\n---\n\n## Converting Between Bases\n\n$$\\log_b(x) = \\frac{\\ln(x)}{\\ln(b)} = \\frac{\\log(x)}{\\log(b)}$$\n\n### Example\nFind $\\log_3(20)$:\n$$\\log_3(20) = \\frac{\\ln(20)}{\\ln(3)} = \\frac{2.996}{1.099} = 2.727$$\n\n---\n\n:::takeaways\n- Common log ($\\log$) uses base 10\n- Natural log ($\\ln$) uses base e ≈ 2.718\n- Use calculator''s LOG and LN buttons\n- Change of base: $\\log_b(x) = \\ln(x)/\\ln(b)$\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.4.3: Logarithm Basics Practice Quiz
(
  'b0400000-0000-0000-0004-000000000003',
  NULL,
  '4.4.3',
  103,
  'Logarithm Basics Practice',
  'logarithm-basics-practice',
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
        "question": "What is log base 2 of 32?",
        "options": ["5", "4", "6", "16"],
        "correct": 0,
        "explanation": "2^5 = 32, so log_2(32) = 5"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Convert to logarithmic form: 5^3 = 125",
        "options": ["log_5(125) = 3", "log_3(125) = 5", "log_125(5) = 3", "log_5(3) = 125"],
        "correct": 0,
        "explanation": "b^y = x becomes log_b(x) = y, so 5^3 = 125 becomes log_5(125) = 3"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is log_10(1000)?",
        "options": ["3", "100", "10", "1000"],
        "correct": 0,
        "explanation": "10^3 = 1000, so log_10(1000) = 3"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is log_8(2)?",
        "options": ["1/3", "4", "1/2", "2"],
        "correct": 0,
        "explanation": "8^(1/3) = cube root of 8 = 2, so log_8(2) = 1/3"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "log_b(1) = 0 for any valid base b.",
        "correct": true,
        "explanation": "True! b^0 = 1 for any b, so log_b(1) = 0"
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If log_3(x) = 4, what is x?",
        "options": ["81", "12", "64", "27"],
        "correct": 0,
        "explanation": "log_3(x) = 4 means 3^4 = x, so x = 81"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.4.4: Log-Exponent Converter Interactive
(
  'b0400000-0000-0000-0004-000000000004',
  NULL,
  '4.4.4',
  104,
  'Log-Exponent Converter',
  'log-exponent-converter',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each exponential form with its equivalent logarithmic form.",
    "pairs": [
      {"left": "2^4 = 16", "right": "log_2(16) = 4"},
      {"left": "10^3 = 1000", "right": "log_10(1000) = 3"},
      {"left": "5^2 = 25", "right": "log_5(25) = 2"},
      {"left": "3^4 = 81", "right": "log_3(81) = 4"},
      {"left": "e^1 = e", "right": "ln(e) = 1"},
      {"left": "7^0 = 1", "right": "log_7(1) = 0"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 4.4.5: Logarithm Basics Checkpoint
(
  'b0400000-0000-0000-0004-000000000005',
  NULL,
  '4.4.5',
  105,
  'Logarithm Basics Checkpoint',
  'logarithm-basics-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Evaluate: log_4(256)",
        "options": ["4", "64", "8", "2"],
        "correct": 0,
        "explanation": "4^4 = 256, so log_4(256) = 4"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Convert 2^6 = 64 to logarithmic form:",
        "options": ["log_2(64) = 6", "log_6(64) = 2", "log_64(2) = 6", "log_2(6) = 64"],
        "correct": 0,
        "explanation": "b^y = x becomes log_b(x) = y"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "What is ln(1)?",
        "options": ["0", "1", "e", "undefined"],
        "correct": 0,
        "explanation": "e^0 = 1, so ln(1) = 0"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Evaluate: log_25(5)",
        "options": ["0.5", "5", "2", "25"],
        "correct": 0,
        "explanation": "25^(1/2) = sqrt(25) = 5, so log_25(5) = 0.5"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "If log(x) = 2, what is x?",
        "options": ["100", "20", "2", "10"],
        "correct": 0,
        "explanation": "log means base 10: 10^2 = 100"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Logarithm Rules (EL-05)
-- Skill ID: c0000000-0000-0000-0004-000000000005
-- Prerequisites: Logarithm Basics
-- ============================================

-- Activity 4.5.1: Logarithm Rules Introduction
(
  'b0400000-0000-0000-0005-000000000001',
  NULL,
  '4.5.1',
  106,
  'Logarithm Rules',
  'logarithm-rules',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Logarithm Rules\n\n## The Three Main Rules\n\n### 1. Product Rule\n$$\\log_b(MN) = \\log_b(M) + \\log_b(N)$$\n\nThe log of a product equals the sum of the logs.\n\n**Example:** $\\log_2(8 \\times 4) = \\log_2(8) + \\log_2(4) = 3 + 2 = 5$\n\n---\n\n### 2. Quotient Rule\n$$\\log_b\\left(\\frac{M}{N}\\right) = \\log_b(M) - \\log_b(N)$$\n\nThe log of a quotient equals the difference of the logs.\n\n**Example:** $\\log_3(81/9) = \\log_3(81) - \\log_3(9) = 4 - 2 = 2$\n\n---\n\n### 3. Power Rule\n$$\\log_b(M^n) = n \\cdot \\log_b(M)$$\n\nThe log of a power equals the exponent times the log.\n\n**Example:** $\\log_2(8^2) = 2 \\cdot \\log_2(8) = 2 \\times 3 = 6$\n\n---\n\n## Summary Table\n\n| Rule | Formula | Example |\n|------|---------|--------|\n| Product | $\\log(MN) = \\log(M) + \\log(N)$ | $\\log(20) = \\log(4) + \\log(5)$ |\n| Quotient | $\\log(M/N) = \\log(M) - \\log(N)$ | $\\log(5) = \\log(10) - \\log(2)$ |\n| Power | $\\log(M^n) = n\\log(M)$ | $\\log(100) = 2\\log(10)$ |\n\n---\n\n## Expanding Logarithms\n\nUse rules to write as sum/difference:\n\n$$\\log\\left(\\frac{x^3y}{z^2}\\right) = 3\\log(x) + \\log(y) - 2\\log(z)$$\n\n---\n\n## Condensing Logarithms\n\nCombine into single log:\n\n$$2\\log(x) + \\log(y) - 3\\log(z) = \\log\\left(\\frac{x^2y}{z^3}\\right)$$\n\n---\n\n## Business Application\n\nThe decibel scale for sound:\n$$dB = 10\\log\\left(\\frac{I}{I_0}\\right)$$\n\nDoubling intensity adds about 3 dB because $\\log(2) \\approx 0.3$.\n\n---\n\n:::takeaways\n- Product: log(MN) = log(M) + log(N)\n- Quotient: log(M/N) = log(M) - log(N)\n- Power: log(M^n) = n·log(M)\n- Use to expand or condense logarithmic expressions\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.5.2: Applying Logarithm Rules
(
  'b0400000-0000-0000-0005-000000000002',
  NULL,
  '4.5.2',
  107,
  'Applying Logarithm Rules',
  'applying-logarithm-rules',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Applying Logarithm Rules\n\n## Expanding Logarithms\n\n### Example 1\nExpand: $\\log_2(8x)$\n\n$$= \\log_2(8) + \\log_2(x) = 3 + \\log_2(x)$$\n\n### Example 2\nExpand: $\\ln\\left(\\frac{e^3}{x^2}\\right)$\n\n$$= \\ln(e^3) - \\ln(x^2) = 3 - 2\\ln(x)$$\n\n### Example 3\nExpand: $\\log\\left(\\frac{100x^3}{y}\\right)$\n\n$$= \\log(100) + \\log(x^3) - \\log(y)$$\n$$= 2 + 3\\log(x) - \\log(y)$$\n\n---\n\n## Condensing Logarithms\n\n### Example 1\nCondense: $\\log(x) + \\log(y)$\n\n$$= \\log(xy)$$\n\n### Example 2\nCondense: $3\\ln(x) - 2\\ln(y)$\n\n$$= \\ln(x^3) - \\ln(y^2) = \\ln\\left(\\frac{x^3}{y^2}\\right)$$\n\n### Example 3\nCondense: $\\frac{1}{2}\\log(x) + 2\\log(y) - \\log(z)$\n\n$$= \\log(x^{1/2}) + \\log(y^2) - \\log(z)$$\n$$= \\log\\left(\\frac{\\sqrt{x} \\cdot y^2}{z}\\right)$$\n\n---\n\n## Common Mistakes to Avoid\n\n:::warning{title=\"These are WRONG!\"}\n| Wrong | Correct |\n|-------|--------|\n| $\\log(M + N) = \\log(M) + \\log(N)$ | No simplification for log of a sum |\n| $\\log(M) \\cdot \\log(N) = \\log(MN)$ | Only addition gives product |\n| $\\frac{\\log(M)}{\\log(N)} = \\log(M/N)$ | Only subtraction gives quotient |\n:::\n\n---\n\n## Solving Equations Using Rules\n\n### Example: Solve $\\log(x) + \\log(x-3) = 1$\n\n**Step 1:** Condense: $\\log(x(x-3)) = 1$\n\n**Step 2:** Convert: $x(x-3) = 10^1 = 10$\n\n**Step 3:** Solve: $x^2 - 3x - 10 = 0$\n$(x-5)(x+2) = 0$\n$x = 5$ or $x = -2$\n\n**Step 4:** Check domain: x must be positive, so $x = 5$\n\n---\n\n:::takeaways\n- Expand: Break apart products, quotients, powers\n- Condense: Combine into single logarithm\n- Watch for domain restrictions (argument must be positive)\n- Common errors: Log rules don''t work for sums!\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.5.3: Logarithm Rules Quiz
(
  'b0400000-0000-0000-0005-000000000003',
  NULL,
  '4.5.3',
  108,
  'Logarithm Rules Practice',
  'logarithm-rules-practice',
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
        "question": "Expand: log_2(8x)",
        "options": ["3 + log_2(x)", "3 * log_2(x)", "log_2(8) * log_2(x)", "8 + log_2(x)"],
        "correct": 0,
        "explanation": "log_2(8x) = log_2(8) + log_2(x) = 3 + log_2(x)"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Condense: log(x) + log(y)",
        "options": ["log(xy)", "log(x+y)", "log(x) * log(y)", "log(x/y)"],
        "correct": 0,
        "explanation": "Product rule: log(x) + log(y) = log(xy)"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Expand: ln(x^4/y)",
        "options": ["4ln(x) - ln(y)", "4ln(x) + ln(y)", "ln(4x) - ln(y)", "4(ln(x) - ln(y))"],
        "correct": 0,
        "explanation": "ln(x^4/y) = ln(x^4) - ln(y) = 4ln(x) - ln(y)"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If log(2) ≈ 0.301, what is log(8)?",
        "options": ["0.903", "0.602", "2.408", "0.301"],
        "correct": 0,
        "explanation": "log(8) = log(2^3) = 3*log(2) = 3*0.301 = 0.903"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "log(M + N) = log(M) + log(N)",
        "correct": false,
        "explanation": "False! This is a common mistake. The product rule says log(MN) = log(M) + log(N), not log(M+N)."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Condense: 2log(x) - 3log(y) + log(z)",
        "options": ["log(x²z/y³)", "log(2x - 3y + z)", "log((x-y)²z³)", "log(x²/y³z)"],
        "correct": 0,
        "explanation": "2log(x) - 3log(y) + log(z) = log(x²) - log(y³) + log(z) = log(x²z/y³)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.5.4: Logarithm Rules Matcher
(
  'b0400000-0000-0000-0005-000000000004',
  NULL,
  '4.5.4',
  109,
  'Logarithm Rules Matcher',
  'logarithm-rules-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each logarithm expression with its equivalent form.",
    "pairs": [
      {"left": "log(xy)", "right": "log(x) + log(y)"},
      {"left": "log(x/y)", "right": "log(x) - log(y)"},
      {"left": "log(x³)", "right": "3log(x)"},
      {"left": "log(√x)", "right": "(1/2)log(x)"},
      {"left": "2log(5) + log(4)", "right": "log(100)"},
      {"left": "log(1000) - log(10)", "right": "log(100)"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 4.5.5: Logarithm Rules Checkpoint
(
  'b0400000-0000-0000-0005-000000000005',
  NULL,
  '4.5.5',
  110,
  'Logarithm Rules Checkpoint',
  'logarithm-rules-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Simplify: log_5(125) + log_5(25)",
        "options": ["5", "8", "150", "3"],
        "correct": 0,
        "explanation": "log_5(125) = 3, log_5(25) = 2, so 3 + 2 = 5. Or: log_5(125*25) = log_5(3125) = log_5(5^5) = 5"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Expand: ln(e²x³/y)",
        "options": ["2 + 3ln(x) - ln(y)", "2 + 3ln(x) + ln(y)", "6ln(x) - ln(y)", "2ln(x³/y)"],
        "correct": 0,
        "explanation": "ln(e²x³/y) = ln(e²) + ln(x³) - ln(y) = 2 + 3ln(x) - ln(y)"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "If log(x) = 2 and log(y) = 3, find log(x²y):",
        "options": ["7", "6", "8", "5"],
        "correct": 0,
        "explanation": "log(x²y) = 2log(x) + log(y) = 2(2) + 3 = 7"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Condense: (1/2)ln(x) - 2ln(y)",
        "options": ["ln(√x/y²)", "ln(x/2y²)", "ln(x²/√y)", "(1/2)ln(x/y²)"],
        "correct": 0,
        "explanation": "(1/2)ln(x) - 2ln(y) = ln(x^(1/2)) - ln(y²) = ln(√x/y²)"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Solve: log(x) + log(x + 21) = 2",
        "options": ["x = 4", "x = 25", "x = -25", "x = 21"],
        "correct": 0,
        "explanation": "log(x(x+21)) = 2, so x² + 21x = 100, x² + 21x - 100 = 0, (x+25)(x-4) = 0, x = 4 (positive)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Quadratic Equations (EQ-03)
-- Skill ID: c0000000-0000-0000-0005-000000000003
-- Prerequisites: Linear Equations
-- ============================================

-- Activity 5.3.1: Introduction to Quadratic Equations
(
  'b0500000-0000-0000-0003-000000000001',
  NULL,
  '5.3.1',
  111,
  'Introduction to Quadratic Equations',
  'introduction-quadratic-equations',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to Quadratic Equations\n\n## What is a Quadratic Equation?\n\n:::concept{title=\"Standard Form\"}\nA quadratic equation has the form:\n$$ax^2 + bx + c = 0$$\nwhere a ≠ 0\n:::\n\n---\n\n## Why \"Quadratic\"?\n\nFrom Latin \"quadratus\" meaning square. The highest power of x is 2 (squared).\n\n---\n\n## Examples of Quadratic Equations\n\n| Equation | a | b | c |\n|----------|---|---|---|\n| $x^2 - 5x + 6 = 0$ | 1 | -5 | 6 |\n| $2x^2 + 3x - 7 = 0$ | 2 | 3 | -7 |\n| $x^2 - 9 = 0$ | 1 | 0 | -9 |\n| $3x^2 + 12x = 0$ | 3 | 12 | 0 |\n\n---\n\n## Three Methods to Solve\n\n### Method 1: Factoring\nBest when equation factors nicely.\n\n$x^2 - 5x + 6 = 0$\n$(x - 2)(x - 3) = 0$\n$x = 2$ or $x = 3$\n\n---\n\n### Method 2: Quadratic Formula\nWorks for any quadratic equation.\n\n$$x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}$$\n\n---\n\n### Method 3: Completing the Square\nUseful for deriving the formula and vertex form.\n\n---\n\n## The Discriminant\n\n$$D = b^2 - 4ac$$\n\n| Discriminant | Solutions |\n|--------------|----------|\n| D > 0 | Two distinct real solutions |\n| D = 0 | One repeated real solution |\n| D < 0 | No real solutions (complex) |\n\n---\n\n## Business Applications\n\nQuadratics appear in:\n- Profit functions (parabolas)\n- Revenue optimization\n- Break-even analysis\n- Projectile motion\n- Area problems\n\n---\n\n:::takeaways\n- Standard form: $ax^2 + bx + c = 0$\n- The discriminant tells you how many solutions\n- Factoring is fastest when it works\n- Quadratic formula always works\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.3.2: Solving by Factoring and Formula
(
  'b0500000-0000-0000-0003-000000000002',
  NULL,
  '5.3.2',
  112,
  'Solving Quadratic Equations',
  'solving-quadratic-equations',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Solving Quadratic Equations\n\n## Method 1: Factoring\n\n### Step-by-Step\n1. Write in standard form\n2. Factor the quadratic\n3. Set each factor equal to zero\n4. Solve each equation\n\n### Example: $x^2 - 7x + 12 = 0$\n\nFind two numbers that multiply to 12 and add to -7:\n-3 × -4 = 12 and -3 + (-4) = -7\n\n$(x - 3)(x - 4) = 0$\n$x = 3$ or $x = 4$\n\n---\n\n## Method 2: Quadratic Formula\n\n$$x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}$$\n\n### Example: $2x^2 + 5x - 3 = 0$\n\na = 2, b = 5, c = -3\n\n$$x = \\frac{-5 \\pm \\sqrt{25 - 4(2)(-3)}}{2(2)}$$\n$$x = \\frac{-5 \\pm \\sqrt{25 + 24}}{4}$$\n$$x = \\frac{-5 \\pm \\sqrt{49}}{4}$$\n$$x = \\frac{-5 \\pm 7}{4}$$\n\n$x = \\frac{2}{4} = \\frac{1}{2}$ or $x = \\frac{-12}{4} = -3$\n\n---\n\n## When to Use Which Method\n\n| Situation | Best Method |\n|-----------|------------|\n| Looks factorable | Try factoring first |\n| a ≠ 1 or complex coefficients | Quadratic formula |\n| Need exact answer | Quadratic formula |\n| Need decimal approximation | Calculator with formula |\n\n---\n\n## Special Cases\n\n### No b term: $x^2 - 16 = 0$\n$x^2 = 16$\n$x = \\pm 4$\n\n### No c term: $x^2 - 5x = 0$\n$x(x - 5) = 0$\n$x = 0$ or $x = 5$\n\n---\n\n## Checking Solutions\n\nAlways substitute back to verify:\n\nFor $x^2 - 7x + 12 = 0$, check x = 3:\n$9 - 21 + 12 = 0$ ✓\n\n---\n\n:::takeaways\n- Factoring: find numbers that multiply to c and add to b\n- Quadratic formula: always works, just plug in a, b, c\n- Special cases: missing terms make it easier\n- Always check your solutions\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.3.3: Quadratic Equations Quiz
(
  'b0500000-0000-0000-0003-000000000003',
  NULL,
  '5.3.3',
  113,
  'Quadratic Equations Practice',
  'quadratic-equations-practice',
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
        "question": "Solve: x² - 9 = 0",
        "options": ["x = 3 or x = -3", "x = 9", "x = 3", "x = -9"],
        "correct": 0,
        "explanation": "x² = 9, so x = ±3"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Solve: x² - 5x + 6 = 0",
        "options": ["x = 2 or x = 3", "x = -2 or x = -3", "x = 6 or x = 1", "x = 5 or x = 1"],
        "correct": 0,
        "explanation": "(x - 2)(x - 3) = 0 gives x = 2 or x = 3"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the discriminant of x² + 4x + 4 = 0?",
        "options": ["0", "32", "16", "-16"],
        "correct": 0,
        "explanation": "D = b² - 4ac = 16 - 16 = 0"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "How many real solutions does x² + x + 1 = 0 have?",
        "options": ["None", "One", "Two", "Infinitely many"],
        "correct": 0,
        "explanation": "D = 1 - 4 = -3 < 0, so no real solutions"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Every quadratic equation has exactly two solutions.",
        "correct": false,
        "explanation": "False! A quadratic can have 0, 1, or 2 real solutions depending on the discriminant."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Use the quadratic formula to solve 2x² - 7x + 3 = 0:",
        "options": ["x = 3 or x = 0.5", "x = 3 or x = -0.5", "x = 7 or x = 3", "x = 1 or x = 1.5"],
        "correct": 0,
        "explanation": "x = (7 ± √(49-24))/4 = (7 ± 5)/4, so x = 3 or x = 0.5"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 5.3.4: Quadratic Solution Matcher
(
  'b0500000-0000-0000-0003-000000000004',
  NULL,
  '5.3.4',
  114,
  'Quadratic Solutions Matcher',
  'quadratic-solutions-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each quadratic equation with its solutions.",
    "pairs": [
      {"left": "x² - 4 = 0", "right": "x = 2 or x = -2"},
      {"left": "x² - 5x = 0", "right": "x = 0 or x = 5"},
      {"left": "(x - 3)(x + 2) = 0", "right": "x = 3 or x = -2"},
      {"left": "x² + 6x + 9 = 0", "right": "x = -3 (repeated)"},
      {"left": "x² - x - 6 = 0", "right": "x = 3 or x = -2"},
      {"left": "x² + 1 = 0", "right": "No real solutions"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 5.3.5: Quadratic Equations Checkpoint
(
  'b0500000-0000-0000-0003-000000000005',
  NULL,
  '5.3.5',
  115,
  'Quadratic Equations Checkpoint',
  'quadratic-equations-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Solve: x² - 8x + 15 = 0",
        "options": ["x = 3 or x = 5", "x = -3 or x = -5", "x = 8 or x = 15", "x = 1 or x = 15"],
        "correct": 0,
        "explanation": "(x - 3)(x - 5) = 0 gives x = 3 or x = 5"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "What is the quadratic formula?",
        "options": ["x = (-b ± √(b²-4ac)) / 2a", "x = (-b ± √(b²+4ac)) / 2a", "x = (b ± √(b²-4ac)) / 2a", "x = (-b ± √(b-4ac)) / 2a"],
        "correct": 0,
        "explanation": "The quadratic formula is x = (-b ± √(b²-4ac)) / 2a"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "How many real solutions does x² + 2x + 5 = 0 have?",
        "options": ["None", "One", "Two", "Cannot determine"],
        "correct": 0,
        "explanation": "D = 4 - 20 = -16 < 0, so no real solutions."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Solve: 3x² + 6x = 0",
        "options": ["x = 0 or x = -2", "x = 3 or x = 6", "x = 0 or x = 2", "x = -3 or x = -2"],
        "correct": 0,
        "explanation": "Factor: 3x(x + 2) = 0, so x = 0 or x = -2"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "A profit function P(x) = -2x² + 120x - 1600 has break-even at:",
        "options": ["x = 20 and x = 40", "x = 30 (only)", "x = 60 and x = 80", "No break-even point"],
        "correct": 0,
        "explanation": "-2x² + 120x - 1600 = 0, divide by -2: x² - 60x + 800 = 0, (x-20)(x-40) = 0"
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

-- Logarithm Basics Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0400000-0000-0000-0004-000000000001', 'c0000000-0000-0000-0004-000000000004', true, 1, true, true, 1.0),
('b0400000-0000-0000-0004-000000000002', 'c0000000-0000-0000-0004-000000000004', true, 2, true, true, 1.0),
('b0400000-0000-0000-0004-000000000003', 'c0000000-0000-0000-0004-000000000004', true, 3, true, true, 1.0),
('b0400000-0000-0000-0004-000000000004', 'c0000000-0000-0000-0004-000000000004', true, 4, true, true, 1.0),
('b0400000-0000-0000-0004-000000000005', 'c0000000-0000-0000-0004-000000000004', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Logarithm Rules Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0400000-0000-0000-0005-000000000001', 'c0000000-0000-0000-0004-000000000005', true, 1, true, true, 1.0),
('b0400000-0000-0000-0005-000000000002', 'c0000000-0000-0000-0004-000000000005', true, 2, true, true, 1.0),
('b0400000-0000-0000-0005-000000000003', 'c0000000-0000-0000-0004-000000000005', true, 3, true, true, 1.0),
('b0400000-0000-0000-0005-000000000004', 'c0000000-0000-0000-0004-000000000005', true, 4, true, true, 1.0),
('b0400000-0000-0000-0005-000000000005', 'c0000000-0000-0000-0004-000000000005', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Quadratic Equations Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0500000-0000-0000-0003-000000000001', 'c0000000-0000-0000-0005-000000000003', true, 1, true, true, 1.0),
('b0500000-0000-0000-0003-000000000002', 'c0000000-0000-0000-0005-000000000003', true, 2, true, true, 1.0),
('b0500000-0000-0000-0003-000000000003', 'c0000000-0000-0000-0005-000000000003', true, 3, true, true, 1.0),
('b0500000-0000-0000-0003-000000000004', 'c0000000-0000-0000-0005-000000000003', true, 4, true, true, 1.0),
('b0500000-0000-0000-0003-000000000005', 'c0000000-0000-0000-0005-000000000003', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;
