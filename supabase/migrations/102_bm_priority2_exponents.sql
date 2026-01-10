-- ============================================
-- Phase 2: Exponents Completion
-- Negative/Fractional Exponents, Scientific Notation
-- 10 Activities (5 per skill)
-- ============================================

-- ============================================
-- SKILL: Negative and Fractional Exponents (EL-02)
-- Skill ID: c0000000-0000-0000-0004-000000000002
-- Prerequisites: Exponent Rules
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 4.2.1: Understanding Negative Exponents
(
  'b0400000-0000-0000-0002-000000000001',
  NULL,
  '4.2.1',
  20,
  'Understanding Negative Exponents',
  'understanding-negative-exponents',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Understanding Negative Exponents\n\n## The Pattern That Reveals the Rule\n\nLook at the pattern when we divide powers of 2:\n\n| Expression | Value |\n|------------|-------|\n| $2^3$ | 8 |\n| $2^2$ | 4 |\n| $2^1$ | 2 |\n| $2^0$ | 1 |\n| $2^{-1}$ | ? |\n| $2^{-2}$ | ? |\n\nEach step down divides by 2:\n$$2^{-1} = \\frac{1}{2}, \\quad 2^{-2} = \\frac{1}{4}$$\n\n---\n\n## The Negative Exponent Rule\n\n$$a^{-n} = \\frac{1}{a^n}$$\n\nA negative exponent means \"take the reciprocal.\"\n\n### Examples\n\n| Expression | Calculation | Result |\n|------------|-------------|--------|\n| $5^{-1}$ | $\\frac{1}{5^1}$ | $\\frac{1}{5}$ |\n| $3^{-2}$ | $\\frac{1}{3^2}$ | $\\frac{1}{9}$ |\n| $10^{-3}$ | $\\frac{1}{10^3}$ | $\\frac{1}{1000} = 0.001$ |\n| $4^{-2}$ | $\\frac{1}{4^2}$ | $\\frac{1}{16}$ |\n\n---\n\n## Negative Exponents in Fractions\n\nWhen a negative exponent is in the denominator, it moves to the numerator:\n\n$$\\frac{1}{a^{-n}} = a^n$$\n\n### Example\n$$\\frac{1}{x^{-3}} = x^3$$\n\n---\n\n## General Pattern\n\n$$\\frac{a^m}{b^n} = a^m \\cdot b^{-n}$$\n\n$$\\left(\\frac{a}{b}\\right)^{-n} = \\left(\\frac{b}{a}\\right)^n$$\n\n### Example\n$$\\left(\\frac{2}{5}\\right)^{-2} = \\left(\\frac{5}{2}\\right)^2 = \\frac{25}{4}$$\n\n---\n\n## Simplifying Expressions\n\n### Example 1\nSimplify: $\\frac{x^5}{x^8}$\n\nUsing quotient rule: $x^{5-8} = x^{-3} = \\frac{1}{x^3}$\n\n### Example 2\nSimplify: $2^{-3} \\cdot 2^5$\n\nUsing product rule: $2^{-3+5} = 2^2 = 4$\n\n---\n\n## Business Application: Decay Models\n\nDepreciation factor after n years at 10% annual decline:\n$$\\text{Value} = P \\cdot (0.9)^n = P \\cdot \\left(\\frac{9}{10}\\right)^n$$\n\nFor years in the past (n negative):\n$$P \\cdot (0.9)^{-2} = P \\cdot \\left(\\frac{10}{9}\\right)^2 \\approx 1.23P$$\n\n---\n\n:::takeaways\n- $a^{-n} = \\frac{1}{a^n}$: Negative exponent = reciprocal\n- Negative exponents in denominators move to numerators\n- $(a/b)^{-n} = (b/a)^n$: Flip the fraction\n- All exponent rules still apply with negative exponents\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.2.2: Fractional Exponents
(
  'b0400000-0000-0000-0002-000000000002',
  NULL,
  '4.2.2',
  21,
  'Fractional Exponents and Roots',
  'fractional-exponents-roots',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Fractional Exponents and Roots\n\n## The Connection Between Roots and Exponents\n\n:::concept{title=\"Fractional Exponents\"}\n$$a^{1/n} = \\sqrt[n]{a}$$\n\nA fractional exponent of 1/n means the nth root.\n:::\n\n---\n\n## Common Fractional Exponents\n\n| Exponent | Meaning | Example |\n|----------|---------|--------|\n| $a^{1/2}$ | Square root | $9^{1/2} = 3$ |\n| $a^{1/3}$ | Cube root | $8^{1/3} = 2$ |\n| $a^{1/4}$ | Fourth root | $16^{1/4} = 2$ |\n| $a^{1/5}$ | Fifth root | $32^{1/5} = 2$ |\n\n---\n\n## General Fractional Exponents\n\n$$a^{m/n} = \\sqrt[n]{a^m} = \\left(\\sqrt[n]{a}\\right)^m$$\n\nThe numerator is the power, the denominator is the root.\n\n### Examples\n\n| Expression | Two Equivalent Forms | Result |\n|------------|---------------------|--------|\n| $8^{2/3}$ | $\\sqrt[3]{8^2} = \\sqrt[3]{64}$ or $(\\sqrt[3]{8})^2 = 2^2$ | 4 |\n| $27^{2/3}$ | $(\\sqrt[3]{27})^2 = 3^2$ | 9 |\n| $16^{3/4}$ | $(\\sqrt[4]{16})^3 = 2^3$ | 8 |\n| $25^{3/2}$ | $(\\sqrt{25})^3 = 5^3$ | 125 |\n\n---\n\n## Strategy: Root First, Then Power\n\n:::tip{title=\"Easier Calculation\"}\nWhen possible, take the root first, then raise to the power.\n\n$8^{2/3}$: Calculate $\\sqrt[3]{8} = 2$ first, then $2^2 = 4$\n\nThis avoids large numbers.\n:::\n\n---\n\n## Combining Negative and Fractional Exponents\n\n$$a^{-m/n} = \\frac{1}{a^{m/n}} = \\frac{1}{\\sqrt[n]{a^m}}$$\n\n### Example\n$$8^{-2/3} = \\frac{1}{8^{2/3}} = \\frac{1}{4}$$\n\n### Example\n$$25^{-1/2} = \\frac{1}{25^{1/2}} = \\frac{1}{5}$$\n\n---\n\n## Converting Between Forms\n\n| Radical Form | Exponential Form |\n|--------------|------------------|\n| $\\sqrt{x}$ | $x^{1/2}$ |\n| $\\sqrt[3]{x^2}$ | $x^{2/3}$ |\n| $\\frac{1}{\\sqrt{x}}$ | $x^{-1/2}$ |\n| $\\sqrt[4]{x^3}$ | $x^{3/4}$ |\n\n---\n\n## Business Application: Growth Rates\n\nIf an investment triples in 10 years, the annual growth factor is:\n$$3^{1/10} \\approx 1.116$$\n\nThis means about 11.6% annual growth.\n\n---\n\n:::takeaways\n- $a^{1/n} = \\sqrt[n]{a}$: Fractional exponent = root\n- $a^{m/n}$: Numerator = power, Denominator = root\n- Take the root first for easier calculations\n- Negative fractional exponents combine both rules\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.2.3: Negative and Fractional Exponents Quiz
(
  'b0400000-0000-0000-0002-000000000003',
  NULL,
  '4.2.3',
  22,
  'Negative and Fractional Exponents Practice',
  'neg-frac-exponents-practice',
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
        "question": "What is 2^(-3)?",
        "options": ["1/8", "-8", "-6", "8"],
        "correct": 0,
        "explanation": "2^(-3) = 1/2^3 = 1/8"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is 16^(1/2)?",
        "options": ["4", "8", "32", "1/16"],
        "correct": 0,
        "explanation": "16^(1/2) = sqrt(16) = 4"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is 27^(2/3)?",
        "options": ["9", "3", "18", "81"],
        "correct": 0,
        "explanation": "27^(2/3) = (cube root of 27)^2 = 3^2 = 9"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Simplify: (1/4)^(-2)",
        "options": ["16", "1/16", "-8", "4"],
        "correct": 0,
        "explanation": "(1/4)^(-2) = (4/1)^2 = 4^2 = 16"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is 32^(-2/5)?",
        "options": ["1/4", "4", "1/2", "2"],
        "correct": 0,
        "explanation": "32^(2/5) = (5th root of 32)^2 = 2^2 = 4. So 32^(-2/5) = 1/4"
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "basic",
        "question": "x^(-1) is always equal to 1/x (for x not equal to 0).",
        "correct": true,
        "explanation": "True! x^(-1) = 1/x^1 = 1/x by the negative exponent rule."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Simplify: x^(3/4) / x^(1/4)",
        "options": ["x^(1/2)", "x^(3/16)", "x", "x^(2/4)"],
        "correct": 0,
        "explanation": "Using quotient rule: x^(3/4 - 1/4) = x^(2/4) = x^(1/2)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.2.4: Exponent Form Converter Interactive
(
  'b0400000-0000-0000-0002-000000000004',
  NULL,
  '4.2.4',
  23,
  'Exponent Form Converter',
  'exponent-form-converter',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each radical expression with its equivalent exponential form.",
    "pairs": [
      {"left": "sqrt(x)", "right": "x^(1/2)"},
      {"left": "cube root of 8", "right": "8^(1/3) = 2"},
      {"left": "1/x^3", "right": "x^(-3)"},
      {"left": "fourth root of 81", "right": "81^(1/4) = 3"},
      {"left": "1/sqrt(x)", "right": "x^(-1/2)"},
      {"left": "(cube root of 27)^2", "right": "27^(2/3) = 9"},
      {"left": "5^(-2)", "right": "1/25"},
      {"left": "64^(1/6)", "right": "2"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 4.2.5: Negative and Fractional Exponents Checkpoint
(
  'b0400000-0000-0000-0002-000000000005',
  NULL,
  '4.2.5',
  24,
  'Negative and Fractional Exponents Checkpoint',
  'neg-frac-exponents-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Evaluate: 64^(2/3)",
        "options": ["16", "8", "32", "4"],
        "correct": 0,
        "explanation": "64^(2/3) = (cube root of 64)^2 = 4^2 = 16"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Express sqrt(x^3) in exponential form:",
        "options": ["x^(3/2)", "x^(2/3)", "x^3/2", "3x^(1/2)"],
        "correct": 0,
        "explanation": "sqrt(x^3) = (x^3)^(1/2) = x^(3/2)"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "What is (8/27)^(-1/3)?",
        "options": ["3/2", "2/3", "27/8", "-2/3"],
        "correct": 0,
        "explanation": "(8/27)^(-1/3) = (27/8)^(1/3) = cube root of 27 / cube root of 8 = 3/2"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Simplify: 9^(1/2) x 9^(-1)",
        "options": ["1/3", "3", "1/9", "9"],
        "correct": 0,
        "explanation": "9^(1/2 - 1) = 9^(-1/2) = 1/sqrt(9) = 1/3"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "An investment doubles in 6 years. The annual growth factor is:",
        "options": ["2^(1/6) ≈ 1.12", "2/6 ≈ 0.33", "6^(1/2) ≈ 2.45", "2^6 = 64"],
        "correct": 0,
        "explanation": "If it doubles in 6 years, annual factor = 2^(1/6) ≈ 1.12 (about 12% growth per year)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Scientific Notation (EL-03)
-- Skill ID: c0000000-0000-0000-0004-000000000003
-- Prerequisites: Exponent Rules
-- ============================================

-- Activity 4.3.1: Introduction to Scientific Notation
(
  'b0400000-0000-0000-0003-000000000001',
  NULL,
  '4.3.1',
  25,
  'Introduction to Scientific Notation',
  'introduction-scientific-notation',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Introduction to Scientific Notation\n\n## Why Scientific Notation?\n\nIn business and science, we often deal with very large or very small numbers:\n\n| Context | Number | Difficult to Work With |\n|---------|--------|----------------------|\n| Company valuation | CHF 4,500,000,000 | 10 digits |\n| Bacteria size | 0.000001 meters | Many zeros |\n| National debt | CHF 850,000,000,000 | 12 digits |\n| Precision part | 0.0000025 meters | Hard to read |\n\n---\n\n## What is Scientific Notation?\n\n:::concept{title=\"Scientific Notation\"}\n$$a \\times 10^n$$\n\nWhere:\n- $1 \\leq a < 10$ (a number between 1 and 10)\n- n is an integer (power of 10)\n:::\n\n---\n\n## Converting Large Numbers\n\n**Process:** Move the decimal point until you have a number between 1 and 10. Count the moves.\n\n### Example: 4,500,000,000\n\n$$4,500,000,000 = 4.5 \\times 10^9$$\n\nDecimal moved 9 places left → positive exponent 9\n\n### Example: 127,000\n\n$$127,000 = 1.27 \\times 10^5$$\n\n---\n\n## Converting Small Numbers\n\n**Process:** Move decimal right until you have a number between 1 and 10.\n\n### Example: 0.000045\n\n$$0.000045 = 4.5 \\times 10^{-5}$$\n\nDecimal moved 5 places right → negative exponent -5\n\n### Example: 0.0082\n\n$$0.0082 = 8.2 \\times 10^{-3}$$\n\n---\n\n## Converting Back to Standard Form\n\n| Scientific Notation | Direction | Standard Form |\n|--------------------|-----------|---------------|\n| $3.2 \\times 10^4$ | Move right 4 | 32,000 |\n| $7.5 \\times 10^{-3}$ | Move left 3 | 0.0075 |\n| $1.08 \\times 10^6$ | Move right 6 | 1,080,000 |\n| $9.1 \\times 10^{-5}$ | Move left 5 | 0.000091 |\n\n---\n\n## Common Powers of 10\n\n| Power | Value | Name |\n|-------|-------|------|\n| $10^{12}$ | 1,000,000,000,000 | Trillion |\n| $10^9$ | 1,000,000,000 | Billion |\n| $10^6$ | 1,000,000 | Million |\n| $10^3$ | 1,000 | Thousand |\n| $10^0$ | 1 | One |\n| $10^{-3}$ | 0.001 | Thousandth |\n| $10^{-6}$ | 0.000001 | Millionth |\n\n---\n\n## Business Applications\n\n### Revenue Report\n\"Quarterly revenue of CHF 2.35 billion\" = CHF $2.35 \\times 10^9$\n\n### Market Share\n\"A 0.0012% market share\" = $1.2 \\times 10^{-5}$\n\n---\n\n:::takeaways\n- Scientific notation: $a \\times 10^n$ where $1 \\leq a < 10$\n- Large numbers: positive exponent\n- Small numbers: negative exponent\n- Count decimal place moves to find exponent\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.3.2: Operations with Scientific Notation
(
  'b0400000-0000-0000-0003-000000000002',
  NULL,
  '4.3.2',
  26,
  'Operations with Scientific Notation',
  'operations-scientific-notation',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Operations with Scientific Notation\n\n## Multiplication\n\nTo multiply numbers in scientific notation:\n1. Multiply the coefficients\n2. Add the exponents\n\n$$(a \\times 10^m) \\times (b \\times 10^n) = (a \\times b) \\times 10^{m+n}$$\n\n### Example\n$$(3 \\times 10^4) \\times (2 \\times 10^5)$$\n$$= (3 \\times 2) \\times 10^{4+5}$$\n$$= 6 \\times 10^9$$\n\n### Example with Adjustment\n$$(4 \\times 10^3) \\times (5 \\times 10^2)$$\n$$= 20 \\times 10^5$$\n$$= 2 \\times 10^6$$ (adjusted so coefficient is between 1 and 10)\n\n---\n\n## Division\n\nTo divide numbers in scientific notation:\n1. Divide the coefficients\n2. Subtract the exponents\n\n$$\\frac{a \\times 10^m}{b \\times 10^n} = \\frac{a}{b} \\times 10^{m-n}$$\n\n### Example\n$$\\frac{8 \\times 10^7}{4 \\times 10^3}$$\n$$= \\frac{8}{4} \\times 10^{7-3}$$\n$$= 2 \\times 10^4$$\n\n### Example with Negative Result\n$$\\frac{6 \\times 10^2}{3 \\times 10^5}$$\n$$= 2 \\times 10^{-3}$$\n\n---\n\n## Addition and Subtraction\n\nNumbers must have the **same exponent** first!\n\n### Example\n$$3.2 \\times 10^5 + 4.8 \\times 10^4$$\n\nConvert to same exponent:\n$$3.2 \\times 10^5 + 0.48 \\times 10^5$$\n$$= 3.68 \\times 10^5$$\n\n---\n\n## Calculator Notation\n\nCalculators display scientific notation as:\n\n| Calculator Shows | Means |\n|-----------------|-------|\n| 3.5E6 | $3.5 \\times 10^6$ |\n| 2.1E-4 | $2.1 \\times 10^{-4}$ |\n| 8.9E9 | $8.9 \\times 10^9$ |\n\n---\n\n## Business Application Examples\n\n### Total Market Value\nCompany A: CHF $2.4 \\times 10^{10}$\nCompany B: CHF $3.6 \\times 10^9$\n\nTotal: $2.4 \\times 10^{10} + 0.36 \\times 10^{10} = 2.76 \\times 10^{10}$ = CHF 27.6 billion\n\n### Per-Unit Cost\nTotal cost: CHF $4.8 \\times 10^6$\nUnits produced: $2 \\times 10^4$\n\nCost per unit: $\\frac{4.8 \\times 10^6}{2 \\times 10^4} = 2.4 \\times 10^2$ = CHF 240\n\n---\n\n:::takeaways\n- Multiplication: Multiply coefficients, add exponents\n- Division: Divide coefficients, subtract exponents\n- Addition/Subtraction: Make exponents equal first\n- Adjust final answer so coefficient is between 1 and 10\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.3.3: Scientific Notation Quiz
(
  'b0400000-0000-0000-0003-000000000003',
  NULL,
  '4.3.3',
  27,
  'Scientific Notation Practice',
  'scientific-notation-practice',
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
        "question": "Write 45,000,000 in scientific notation:",
        "options": ["4.5 x 10^7", "45 x 10^6", "4.5 x 10^6", "0.45 x 10^8"],
        "correct": 0,
        "explanation": "45,000,000 = 4.5 x 10^7 (decimal moves 7 places left)"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Write 0.00032 in scientific notation:",
        "options": ["3.2 x 10^(-4)", "32 x 10^(-5)", "3.2 x 10^4", "0.32 x 10^(-3)"],
        "correct": 0,
        "explanation": "0.00032 = 3.2 x 10^(-4) (decimal moves 4 places right)"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Calculate: (3 x 10^5) x (4 x 10^3)",
        "options": ["1.2 x 10^9", "12 x 10^8", "1.2 x 10^8", "12 x 10^15"],
        "correct": 0,
        "explanation": "3 x 4 = 12, exponents: 5 + 3 = 8. So 12 x 10^8 = 1.2 x 10^9"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Calculate: (9 x 10^8) / (3 x 10^5)",
        "options": ["3 x 10^3", "3 x 10^13", "27 x 10^3", "3 x 10^(-3)"],
        "correct": 0,
        "explanation": "9 / 3 = 3, exponents: 8 - 5 = 3. Answer: 3 x 10^3"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "In proper scientific notation, the coefficient must be between 1 and 10.",
        "correct": true,
        "explanation": "True! The coefficient a must satisfy 1 <= a < 10."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Add: (2.5 x 10^6) + (3.0 x 10^5)",
        "options": ["2.8 x 10^6", "5.5 x 10^6", "5.5 x 10^11", "2.5 x 10^11"],
        "correct": 0,
        "explanation": "Convert: 2.5 x 10^6 + 0.30 x 10^6 = 2.8 x 10^6"
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company worth CHF 8 x 10^9 acquires another worth CHF 2.5 x 10^8. Combined value?",
        "options": ["8.25 x 10^9", "10.5 x 10^9", "8.25 x 10^17", "1.05 x 10^10"],
        "correct": 0,
        "explanation": "8 x 10^9 + 0.25 x 10^9 = 8.25 x 10^9"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.3.4: Scientific Notation Converter Interactive
(
  'b0400000-0000-0000-0003-000000000004',
  NULL,
  '4.3.4',
  28,
  'Scientific Notation Converter',
  'scientific-notation-converter',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each standard number with its scientific notation equivalent.",
    "pairs": [
      {"left": "5,600,000", "right": "5.6 x 10^6"},
      {"left": "0.00078", "right": "7.8 x 10^(-4)"},
      {"left": "123,000,000,000", "right": "1.23 x 10^11"},
      {"left": "0.0000091", "right": "9.1 x 10^(-6)"},
      {"left": "8,200", "right": "8.2 x 10^3"},
      {"left": "0.052", "right": "5.2 x 10^(-2)"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 4.3.5: Scientific Notation Checkpoint
(
  'b0400000-0000-0000-0003-000000000005',
  NULL,
  '4.3.5',
  29,
  'Scientific Notation Checkpoint',
  'scientific-notation-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Convert 7.2 x 10^5 to standard form:",
        "options": ["720,000", "72,000", "7,200,000", "7,200"],
        "correct": 0,
        "explanation": "7.2 x 10^5 = 7.2 x 100,000 = 720,000"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "What does your calculator display 4.5E-3 mean?",
        "options": ["4.5 x 10^(-3) = 0.0045", "4.5 x 10^3 = 4,500", "4.5 - 3 = 1.5", "45 x 10^(-2)"],
        "correct": 0,
        "explanation": "E-3 means x 10^(-3), so 4.5E-3 = 4.5 x 10^(-3) = 0.0045"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Calculate: (6 x 10^4)^2",
        "options": ["3.6 x 10^9", "36 x 10^8", "6 x 10^8", "12 x 10^8"],
        "correct": 0,
        "explanation": "6^2 = 36, (10^4)^2 = 10^8. So 36 x 10^8 = 3.6 x 10^9"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "World population is about 8 billion. In scientific notation:",
        "options": ["8 x 10^9", "8 x 10^6", "80 x 10^8", "8 x 10^12"],
        "correct": 0,
        "explanation": "8 billion = 8,000,000,000 = 8 x 10^9"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "If revenue is CHF 2.4 x 10^8 and costs are CHF 1.8 x 10^8, what is profit?",
        "options": ["6 x 10^7", "6 x 10^8", "4.2 x 10^8", "0.6 x 10^8"],
        "correct": 0,
        "explanation": "2.4 x 10^8 - 1.8 x 10^8 = 0.6 x 10^8 = 6 x 10^7"
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

-- Negative/Fractional Exponents Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0400000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0004-000000000002', true, 1, true, true, 1.0),
('b0400000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0004-000000000002', true, 2, true, true, 1.0),
('b0400000-0000-0000-0002-000000000003', 'c0000000-0000-0000-0004-000000000002', true, 3, true, true, 1.0),
('b0400000-0000-0000-0002-000000000004', 'c0000000-0000-0000-0004-000000000002', true, 4, true, true, 1.0),
('b0400000-0000-0000-0002-000000000005', 'c0000000-0000-0000-0004-000000000002', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Scientific Notation Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0400000-0000-0000-0003-000000000001', 'c0000000-0000-0000-0004-000000000003', true, 1, true, true, 1.0),
('b0400000-0000-0000-0003-000000000002', 'c0000000-0000-0000-0004-000000000003', true, 2, true, true, 1.0),
('b0400000-0000-0000-0003-000000000003', 'c0000000-0000-0000-0004-000000000003', true, 3, true, true, 1.0),
('b0400000-0000-0000-0003-000000000004', 'c0000000-0000-0000-0004-000000000003', true, 4, true, true, 1.0),
('b0400000-0000-0000-0003-000000000005', 'c0000000-0000-0000-0004-000000000003', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

