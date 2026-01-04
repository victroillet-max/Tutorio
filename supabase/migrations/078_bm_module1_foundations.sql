-- ============================================
-- Module 1: Math Foundations Activities
-- 4 Skills: Arithmetic, Order of Operations, Number Types, Calculator
-- ~20 Activities with comprehensive lesson content
-- ============================================

-- ============================================
-- SKILL: Arithmetic Fundamentals (MF-01)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 1.1.1: Introduction to Arithmetic
(
  'b0100000-0000-0000-0001-000000000001',
  'b0000000-0000-0000-0000-000000000001',
  '1.1.1',
  1,
  'Introduction to Arithmetic',
  'introduction-to-arithmetic',
  'lesson',
  10,
  20,
  'free',
  '{"markdown": "# Introduction to Arithmetic\n\n## Why This Matters\n\nArithmetic is the foundation of all mathematics. Whether you are calculating room rates, managing inventory, analyzing financial statements, or computing tips, you need solid arithmetic skills.\n\n> **Every business calculation starts with basic arithmetic.**\n\n---\n\n## The Four Basic Operations\n\n| Operation | Symbol | Example | Result |\n|-----------|--------|---------|--------|\n| Addition | + | 15 + 8 | 23 |\n| Subtraction | - | 42 - 17 | 25 |\n| Multiplication | x or * | 6 x 9 | 54 |\n| Division | / or ÷ | 72 / 8 | 9 |\n\n---\n\n## Working with Positive and Negative Numbers\n\n### The Number Line\n\n```\n    -5   -4   -3   -2   -1    0    1    2    3    4    5\n    |----|----|----|----|----|----|----|----|----|----|---->\n  negative numbers     zero     positive numbers\n```\n\n### Rules for Addition and Subtraction\n\n| Operation | Rule | Example |\n|-----------|------|--------|\n| (+) + (+) | Add, result positive | 5 + 3 = 8 |\n| (-) + (-) | Add, result negative | (-5) + (-3) = -8 |\n| (+) + (-) | Subtract, sign of larger | 5 + (-3) = 2 |\n| (-) + (+) | Subtract, sign of larger | (-5) + 3 = -2 |\n\n:::concept{title=\"Subtracting = Adding the Opposite\"}\nTo subtract a number, add its opposite:\n- 7 - 3 = 7 + (-3) = 4\n- 7 - (-3) = 7 + 3 = 10\n:::\n\n---\n\n## Multiplication and Division Signs\n\n| Rule | Example |\n|------|--------|\n| (+) x (+) = (+) | 4 x 5 = 20 |\n| (-) x (-) = (+) | (-4) x (-5) = 20 |\n| (+) x (-) = (-) | 4 x (-5) = -20 |\n| (-) x (+) = (-) | (-4) x 5 = -20 |\n\n:::tip{title=\"Memory Trick\"}\n- Same signs = Positive result\n- Different signs = Negative result\n:::\n\nThe same rules apply to division.\n\n---\n\n## Working with Decimals\n\n### Place Values\n\n```\n   Hundreds  Tens  Ones  .  Tenths  Hundredths  Thousandths\n      1       2     3    .    4         5           6\n                         ↑\n                   decimal point\n\n   123.456 = 100 + 20 + 3 + 0.4 + 0.05 + 0.006\n```\n\n### Decimal Operations\n\n**Addition/Subtraction:** Line up the decimal points\n```\n    23.45\n  +  7.80\n  ------\n    31.25\n```\n\n**Multiplication:** Multiply as whole numbers, then count decimal places\n```\n    2.5 x 1.2 = 3.0 (1 + 1 = 2 decimal places)\n```\n\n**Division:** Move decimal in divisor to make it whole, move same in dividend\n\n---\n\n## Business Examples\n\n### Example 1: Hotel Room Calculation\nA hotel has 150 rooms. If 87 are occupied, how many are available?\n\n**Solution:** 150 - 87 = 63 rooms available\n\n### Example 2: Restaurant Bill\nA party of 8 has a bill of CHF 392. What is the cost per person?\n\n**Solution:** 392 ÷ 8 = CHF 49 per person\n\n### Example 3: Profit/Loss\nA business had revenue of CHF 45,000 and expenses of CHF 52,000. What is the profit/loss?\n\n**Solution:** 45,000 - 52,000 = -CHF 7,000 (a loss of CHF 7,000)\n\n---\n\n:::takeaways\n- Master the four basic operations: +, -, x, ÷\n- Same signs multiply/divide to positive; different signs to negative\n- Line up decimals for addition and subtraction\n- Count total decimal places for multiplication results\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.1.2: Arithmetic Practice Quiz
(
  'b0100000-0000-0000-0001-000000000002',
  'b0000000-0000-0000-0000-000000000001',
  '1.1.2',
  2,
  'Arithmetic Practice Quiz',
  'arithmetic-practice-quiz',
  'quiz',
  8,
  25,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is (-8) + (-5)?",
        "options": ["-13", "13", "-3", "3"],
        "correct": 0,
        "explanation": "When adding two negative numbers, add the absolute values and keep the negative sign: |-8| + |-5| = 8 + 5 = 13, so the answer is -13."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is (-6) x (-4)?",
        "options": ["-24", "24", "-10", "10"],
        "correct": 1,
        "explanation": "When multiplying two numbers with the same sign, the result is positive: (-6) x (-4) = 24."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Calculate: 15.7 + 8.35",
        "options": ["24.05", "23.05", "24.50", "23.50"],
        "correct": 0,
        "explanation": "Line up the decimals: 15.70 + 8.35 = 24.05"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel received 245 guests on Monday and 178 guests on Tuesday. What is the total number of guests?",
        "options": ["423", "67", "413", "433"],
        "correct": 0,
        "explanation": "245 + 178 = 423 guests"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Calculate: 7.2 x 0.5",
        "options": ["3.6", "36", "0.36", "7.7"],
        "correct": 0,
        "explanation": "7.2 x 0.5 = 3.6 (one decimal place + one decimal place = two decimal places in answer, but trailing zero is dropped)"
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "basic",
        "question": "When you subtract a negative number, the result is the same as adding a positive number.",
        "correct": true,
        "explanation": "True! Subtracting a negative is the same as adding: 5 - (-3) = 5 + 3 = 8"
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A restaurant had revenue of CHF 12,500 and expenses of CHF 15,200. What is the profit or loss?",
        "options": ["Loss of CHF 2,700", "Profit of CHF 2,700", "Loss of CHF 27,700", "Profit of CHF 27,700"],
        "correct": 0,
        "explanation": "12,500 - 15,200 = -2,700, which is a loss of CHF 2,700"
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Calculate: (-12) ÷ 4 + (-3) x (-2)",
        "options": ["3", "-9", "9", "-3"],
        "correct": 0,
        "explanation": "First: (-12) ÷ 4 = -3. Then: (-3) x (-2) = 6. Finally: -3 + 6 = 3"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.1.3: Integer Operations Interactive
(
  'b0100000-0000-0000-0001-000000000003',
  'b0000000-0000-0000-0000-000000000001',
  '1.1.3',
  3,
  'Integer Operations Game',
  'integer-operations-game',
  'interactive',
  8,
  30,
  'free',
  '{
    "instructions": "Match each arithmetic expression with its correct answer.",
    "pairs": [
      {"left": "(-7) + 12", "right": "5"},
      {"left": "(-4) x (-6)", "right": "24"},
      {"left": "15 - (-8)", "right": "23"},
      {"left": "(-36) ÷ 9", "right": "-4"},
      {"left": "(-5) + (-9)", "right": "-14"},
      {"left": "8 x (-3)", "right": "-24"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 1.1.4: Decimal Calculations
(
  'b0100000-0000-0000-0001-000000000004',
  'b0000000-0000-0000-0000-000000000001',
  '1.1.4',
  4,
  'Decimal Calculations in Business',
  'decimal-calculations-business',
  'lesson',
  8,
  20,
  'free',
  '{"markdown": "# Decimal Calculations in Business\n\n## Why Decimals Matter\n\nIn business, you work with decimals constantly:\n- **Prices:** CHF 29.95\n- **Percentages:** 0.15 (15%)\n- **Exchange rates:** 1.0847\n- **Interest rates:** 0.045 (4.5%)\n\n---\n\n## Rounding Rules\n\n### Standard Rounding\nLook at the digit to the right of where you want to round:\n- If 5 or more, round UP\n- If less than 5, round DOWN\n\n| Original | Round to tenths | Round to whole |\n|----------|-----------------|----------------|\n| 3.847 | 3.8 | 4 |\n| 12.349 | 12.3 | 12 |\n| 7.95 | 8.0 | 8 |\n\n:::warning{title=\"Rounding Errors\"}\nNever round intermediate calculations! Only round the final answer to avoid accumulating errors.\n:::\n\n---\n\n## Common Business Calculations\n\n### Example 1: Currency Conversion\nYou need to convert EUR 500 to CHF. The exchange rate is 0.9654.\n\n**Solution:** 500 ÷ 0.9654 = CHF 518.00 (rounded to centimes)\n\n### Example 2: Unit Price\nA case of 24 bottles costs CHF 42.00. What is the price per bottle?\n\n**Solution:** 42.00 ÷ 24 = CHF 1.75 per bottle\n\n### Example 3: Total with Tax\nA meal costs CHF 45.50. Add 7.7% VAT.\n\n**Solution:** \n- VAT = 45.50 x 0.077 = CHF 3.50 (rounded)\n- Total = 45.50 + 3.50 = CHF 49.00\n\n---\n\n:::takeaways\n- Align decimal points for addition/subtraction\n- Count decimal places for multiplication results\n- Round only the final answer, not intermediate steps\n- Practice with real prices and business scenarios\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.1.5: Arithmetic Checkpoint
(
  'b0100000-0000-0000-0001-000000000005',
  'b0000000-0000-0000-0000-000000000001',
  '1.1.5',
  5,
  'Arithmetic Fundamentals Checkpoint',
  'arithmetic-fundamentals-checkpoint',
  'checkpoint',
  10,
  35,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Calculate: (-15) + 8 - (-3)",
        "options": ["-4", "-10", "4", "10"],
        "correct": 0,
        "explanation": "(-15) + 8 = -7, then -7 - (-3) = -7 + 3 = -4"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "What is 4.25 x 1.6?",
        "options": ["6.8", "6.80", "68", "0.68"],
        "correct": 0,
        "explanation": "4.25 x 1.6 = 6.80 (or 6.8)"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "A hotel has 320 rooms. 276 are occupied. How many are vacant?",
        "options": ["44", "54", "46", "596"],
        "correct": 0,
        "explanation": "320 - 276 = 44 vacant rooms"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "What is (-8) x 7 ÷ (-4)?",
        "options": ["14", "-14", "28", "-28"],
        "correct": 0,
        "explanation": "(-8) x 7 = -56, then -56 ÷ (-4) = 14"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Round 127.8549 to two decimal places.",
        "options": ["127.85", "127.86", "127.90", "128.00"],
        "correct": 1,
        "explanation": "The third decimal is 4, but we round the second decimal 5 up because the full sequence 549 > 500."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Order of Operations (MF-02)
-- ============================================

-- Activity 1.2.1: Order of Operations Explained
(
  'b0100000-0000-0000-0002-000000000001',
  'b0000000-0000-0000-0000-000000000001',
  '1.2.1',
  6,
  'Understanding Order of Operations',
  'understanding-order-of-operations',
  'lesson',
  12,
  25,
  'free',
  '{"markdown": "# Understanding Order of Operations\n\n## Why Order Matters\n\nWithout a standard order, the same expression could give different answers:\n\n```\n3 + 4 x 5 = ?\n\nWrong: (3 + 4) x 5 = 7 x 5 = 35\nCorrect: 3 + (4 x 5) = 3 + 20 = 23\n```\n\n:::concept{title=\"The Universal Rule\"}\nMathematicians worldwide follow the same order of operations to ensure consistent results.\n:::\n\n---\n\n## PEMDAS / BODMAS\n\nTwo common mnemonics for the same rules:\n\n| PEMDAS | BODMAS | Operation | Priority |\n|--------|--------|-----------|----------|\n| **P**arentheses | **B**rackets | ( ) | 1st |\n| **E**xponents | **O**rders | Powers, roots | 2nd |\n| **M**ultiplication | **D**ivision | x, ÷ | 3rd |\n| **D**ivision | **M**ultiplication | (left to right) | 3rd |\n| **A**ddition | **A**ddition | +, - | 4th |\n| **S**ubtraction | **S**ubtraction | (left to right) | 4th |\n\n:::warning{title=\"Important\"}\nMultiplication and Division have the SAME priority - evaluate left to right.\nAddition and Subtraction have the SAME priority - evaluate left to right.\n:::\n\n---\n\n## Step-by-Step Examples\n\n### Example 1: Basic PEMDAS\n\n**Calculate:** 2 + 3 x 4 - 1\n\n| Step | Operation | Result |\n|------|-----------|--------|\n| 1 | Multiply first: 3 x 4 = 12 | 2 + 12 - 1 |\n| 2 | Add left to right: 2 + 12 = 14 | 14 - 1 |\n| 3 | Subtract: 14 - 1 | **13** |\n\n### Example 2: With Parentheses\n\n**Calculate:** (2 + 3) x 4 - 1\n\n| Step | Operation | Result |\n|------|-----------|--------|\n| 1 | Parentheses first: 2 + 3 = 5 | 5 x 4 - 1 |\n| 2 | Multiply: 5 x 4 = 20 | 20 - 1 |\n| 3 | Subtract: 20 - 1 | **19** |\n\n### Example 3: With Exponents\n\n**Calculate:** 2 + 3² x 4\n\n| Step | Operation | Result |\n|------|-----------|--------|\n| 1 | Exponent first: 3² = 9 | 2 + 9 x 4 |\n| 2 | Multiply: 9 x 4 = 36 | 2 + 36 |\n| 3 | Add: 2 + 36 | **38** |\n\n### Example 4: Division and Multiplication (left to right)\n\n**Calculate:** 24 ÷ 4 x 3\n\n| Step | Operation | Result |\n|------|-----------|--------|\n| 1 | Divide first (left to right): 24 ÷ 4 = 6 | 6 x 3 |\n| 2 | Multiply: 6 x 3 | **18** |\n\n---\n\n## Business Applications\n\n### Example: Total Revenue Calculation\n\nA hotel has 100 standard rooms at CHF 150/night and 25 suites at CHF 350/night.\n\n**Formula:** Total = 100 x 150 + 25 x 350\n\n| Step | Calculation |\n|------|-------------|\n| 1 | 100 x 150 = 15,000 |\n| 2 | 25 x 350 = 8,750 |\n| 3 | 15,000 + 8,750 = **CHF 23,750** |\n\n---\n\n:::takeaways\n- PEMDAS/BODMAS gives a consistent order for all calculations\n- Parentheses have the highest priority - always calculate them first\n- Multiplication and Division have equal priority (left to right)\n- Addition and Subtraction have equal priority (left to right)\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.2.2: Order of Operations Quiz
(
  'b0100000-0000-0000-0002-000000000002',
  'b0000000-0000-0000-0000-000000000001',
  '1.2.2',
  7,
  'Order of Operations Quiz',
  'order-of-operations-quiz',
  'quiz',
  10,
  30,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Calculate: 8 + 4 x 2",
        "options": ["16", "24", "14", "20"],
        "correct": 0,
        "explanation": "Multiply first: 4 x 2 = 8. Then add: 8 + 8 = 16"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Calculate: (8 + 4) x 2",
        "options": ["24", "16", "14", "20"],
        "correct": 0,
        "explanation": "Parentheses first: 8 + 4 = 12. Then multiply: 12 x 2 = 24"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Calculate: 20 - 4² + 6",
        "options": ["10", "6", "-6", "22"],
        "correct": 0,
        "explanation": "Exponent first: 4² = 16. Then: 20 - 16 + 6 = 4 + 6 = 10"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Calculate: 36 ÷ 6 ÷ 2",
        "options": ["3", "12", "6", "1"],
        "correct": 0,
        "explanation": "Left to right: 36 ÷ 6 = 6, then 6 ÷ 2 = 3"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Calculate: 5 + 3 x (2 + 4)²",
        "options": ["113", "53", "108", "293"],
        "correct": 0,
        "explanation": "Parentheses: 2 + 4 = 6. Exponent: 6² = 36. Multiply: 3 x 36 = 108. Add: 5 + 108 = 113"
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "basic",
        "question": "In the expression 12 ÷ 4 x 3, you must do the division before the multiplication.",
        "correct": true,
        "explanation": "True. When operations have equal priority, work left to right. 12 ÷ 4 = 3, then 3 x 3 = 9."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the value of: 100 - 3 x (4 + 2)² ÷ 4?",
        "options": ["73", "27", "91", "100"],
        "correct": 0,
        "explanation": "Parentheses: 4 + 2 = 6. Exponent: 6² = 36. Multiply: 3 x 36 = 108. Divide: 108 ÷ 4 = 27. Subtract: 100 - 27 = 73"
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A formula uses: Revenue = 50 x Quantity + 25 x (Quantity - 10). If Quantity = 30, what is Revenue?",
        "options": ["2000", "1500", "2500", "1750"],
        "correct": 0,
        "explanation": "First parentheses: 30 - 10 = 20. Then: 50 x 30 = 1500 and 25 x 20 = 500. Finally: 1500 + 500 = 2000"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.2.3: Order Matching
(
  'b0100000-0000-0000-0002-000000000003',
  'b0000000-0000-0000-0000-000000000001',
  '1.2.3',
  8,
  'Match Expressions to Results',
  'match-expressions-results',
  'interactive',
  6,
  25,
  'free',
  '{
    "instructions": "Match each expression with its correct result using PEMDAS order of operations.",
    "pairs": [
      {"left": "2 + 3 x 4", "right": "14"},
      {"left": "(2 + 3) x 4", "right": "20"},
      {"left": "12 ÷ 4 + 2", "right": "5"},
      {"left": "12 ÷ (4 + 2)", "right": "2"},
      {"left": "3 + 2²", "right": "7"},
      {"left": "(3 + 2)²", "right": "25"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 1.2.4: Complex Expression Practice
(
  'b0100000-0000-0000-0002-000000000004',
  'b0000000-0000-0000-0000-000000000001',
  '1.2.4',
  9,
  'Complex Expression Practice',
  'complex-expression-practice',
  'lesson',
  8,
  20,
  'free',
  '{"markdown": "# Complex Expression Practice\n\n## Nested Parentheses\n\nWhen you have parentheses inside parentheses, start with the innermost:\n\n### Example\n**Calculate:** 2 x [(3 + 4) x 2 - 5]\n\n| Step | Work |\n|------|------|\n| 1 | Inner parentheses: 3 + 4 = 7 | 2 x [7 x 2 - 5] |\n| 2 | Inside brackets - multiply: 7 x 2 = 14 | 2 x [14 - 5] |\n| 3 | Inside brackets - subtract: 14 - 5 = 9 | 2 x 9 |\n| 4 | Final multiply | **18** |\n\n---\n\n## Fractions as Division\n\nA fraction bar acts like parentheses around the numerator and denominator:\n\n$$\\frac{6 + 8}{2 + 5} = \\frac{14}{7} = 2$$\n\n### Example\n**Calculate:** $$\\frac{12 + 4 \\times 3}{2^2 + 2}$$\n\n| Step | Work |\n|------|------|\n| 1 | Numerator: 12 + 4 x 3 = 12 + 12 = 24 |\n| 2 | Denominator: 2² + 2 = 4 + 2 = 6 |\n| 3 | Divide: 24 ÷ 6 = **4** |\n\n---\n\n## Business Formula Application\n\n### Profit Margin Formula\n\n$$\\text{Profit Margin} = \\frac{\\text{Revenue} - \\text{Cost}}{\\text{Revenue}} \\times 100$$\n\n**Example:** Revenue = CHF 1,200, Cost = CHF 800\n\n| Step | Calculation |\n|------|-------------|\n| 1 | Numerator: 1200 - 800 = 400 |\n| 2 | Divide: 400 ÷ 1200 = 0.333... |\n| 3 | Multiply: 0.333 x 100 = **33.3%** |\n\n---\n\n:::takeaways\n- Work from innermost parentheses outward\n- Treat the fraction bar as grouping symbols\n- Calculate numerator and denominator separately before dividing\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.2.5: Order of Operations Checkpoint
(
  'b0100000-0000-0000-0002-000000000005',
  'b0000000-0000-0000-0000-000000000001',
  '1.2.5',
  10,
  'Order of Operations Checkpoint',
  'order-of-operations-checkpoint',
  'checkpoint',
  10,
  35,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Calculate: 15 - 3 x 2 + 4",
        "options": ["13", "28", "15", "1"],
        "correct": 0,
        "explanation": "3 x 2 = 6. Then 15 - 6 + 4 = 9 + 4 = 13"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "What is 2³ + 4 x 3?",
        "options": ["20", "18", "24", "36"],
        "correct": 0,
        "explanation": "2³ = 8. Then 4 x 3 = 12. Finally 8 + 12 = 20"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Calculate: 48 ÷ (4 + 4) x 2",
        "options": ["12", "6", "3", "24"],
        "correct": 0,
        "explanation": "Parentheses: 4 + 4 = 8. Then 48 ÷ 8 = 6. Finally 6 x 2 = 12"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Which expression equals 36?",
        "options": ["(4 + 2)²", "4 + 2²", "4² + 2", "4 x 2²"],
        "correct": 0,
        "explanation": "(4 + 2)² = 6² = 36"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "Evaluate: (100 - 20) / (4 x 2) + 5",
        "options": ["15", "10", "20", "25"],
        "correct": 0,
        "explanation": "Numerator: 100 - 20 = 80. Denominator: 4 x 2 = 8. Division: 80 / 8 = 10. Final: 10 + 5 = 15"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Number Types (MF-03)
-- ============================================

-- Activity 1.3.1: Understanding Number Types
(
  'b0100000-0000-0000-0003-000000000001',
  'b0000000-0000-0000-0000-000000000001',
  '1.3.1',
  11,
  'Understanding Number Types',
  'understanding-number-types',
  'lesson',
  10,
  20,
  'free',
  '{"markdown": "# Understanding Number Types\n\n## Why Number Types Matter\n\nDifferent types of numbers have different properties and uses:\n- Some can be written as fractions, others cannot\n- Some are whole, others have infinite decimals\n- Understanding types helps predict calculation outcomes\n\n---\n\n## The Number Type Hierarchy\n\n```\n                    REAL NUMBERS\n                    /         \\\n            RATIONAL         IRRATIONAL\n            /       \\              |\n      INTEGERS    FRACTIONS    pi, sqrt(2)\n       /    \\\n  WHOLE   NEGATIVE\n   /  \\\nNATURAL ZERO\n```\n\n---\n\n## Number Types Explained\n\n### Natural Numbers (N)\nPositive counting numbers: 1, 2, 3, 4, 5, ...\n\n**Business example:** Number of guests, rooms, items\n\n### Whole Numbers (W)\nNatural numbers plus zero: 0, 1, 2, 3, 4, ...\n\n**Business example:** Quantity in stock (can be zero)\n\n### Integers (Z)\nWhole numbers and their negatives: ..., -3, -2, -1, 0, 1, 2, 3, ...\n\n**Business example:** Temperature changes, profit/loss, floor levels\n\n### Rational Numbers (Q)\nNumbers that can be written as a fraction a/b where b is not zero.\n\n| Example | Fraction Form |\n|---------|---------------|\n| 0.5 | 1/2 |\n| 0.333... | 1/3 |\n| -2.75 | -11/4 |\n| 4 | 4/1 |\n\n**Business example:** Prices (CHF 29.95), percentages (0.15 = 15/100)\n\n### Irrational Numbers\nNumbers that CANNOT be written as a fraction. They have infinite, non-repeating decimals.\n\n| Number | Approximate Value | Use |\n|--------|-------------------|-----|\n| pi | 3.14159... | Circles, cylinders |\n| sqrt(2) | 1.41421... | Diagonals, geometry |\n| e | 2.71828... | Continuous growth |\n\n**Business example:** Calculating circular room areas, continuous compounding\n\n### Real Numbers (R)\nAll rational and irrational numbers together. Any number that can be placed on a number line.\n\n---\n\n## Identifying Number Types\n\n| Number | Types It Belongs To |\n|--------|---------------------|\n| 7 | Natural, Whole, Integer, Rational, Real |\n| 0 | Whole, Integer, Rational, Real |\n| -5 | Integer, Rational, Real |\n| 3/4 | Rational, Real |\n| sqrt(9) = 3 | Natural, Whole, Integer, Rational, Real |\n| sqrt(7) | Irrational, Real |\n| pi | Irrational, Real |\n\n---\n\n:::takeaways\n- Natural numbers are for counting (1, 2, 3...)\n- Integers include negatives and zero\n- Rational numbers can be written as fractions\n- Irrational numbers have infinite non-repeating decimals\n- All these together form Real numbers\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.3.2: Number Types Quiz
(
  'b0100000-0000-0000-0003-000000000002',
  'b0000000-0000-0000-0000-000000000001',
  '1.3.2',
  12,
  'Number Types Quiz',
  'number-types-quiz',
  'quiz',
  8,
  25,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which of these is NOT a rational number?",
        "options": ["pi", "0.75", "1/3", "-5"],
        "correct": 0,
        "explanation": "pi is irrational because it cannot be expressed as a fraction and has infinite non-repeating decimals."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "The number -12 belongs to which number sets?",
        "options": ["Integer, Rational, Real", "Natural, Integer, Real", "Whole, Integer, Rational", "Natural, Whole, Integer"],
        "correct": 0,
        "explanation": "-12 is an integer (negative whole number), it can be written as -12/1 (rational), and it is real. It is NOT natural or whole (those are non-negative)."
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Every integer is also a rational number.",
        "correct": true,
        "explanation": "True! Any integer n can be written as n/1, which is a fraction. Therefore, all integers are rational."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "0.333... (repeating) is a:",
        "options": ["Rational number", "Irrational number", "Natural number", "Whole number"],
        "correct": 0,
        "explanation": "0.333... = 1/3, which is a fraction. Repeating decimals are always rational."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is sqrt(25)?",
        "options": ["5 (a natural number)", "An irrational number", "A negative integer", "Not a real number"],
        "correct": 0,
        "explanation": "sqrt(25) = 5, which is a natural number. Perfect square roots are rational."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which statement is FALSE?",
        "options": ["All whole numbers are integers", "All natural numbers are whole numbers", "All real numbers are rational", "All integers are real numbers"],
        "correct": 2,
        "explanation": "Not all real numbers are rational. Irrational numbers like pi and sqrt(2) are real but NOT rational."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.3.3: Number Classification Game
(
  'b0100000-0000-0000-0003-000000000003',
  'b0000000-0000-0000-0000-000000000001',
  '1.3.3',
  13,
  'Number Classification Challenge',
  'number-classification-challenge',
  'interactive',
  8,
  30,
  'free',
  '{
    "instructions": "Classify each number into its most specific category.",
    "timeLimit": 120,
    "items": [
      {"item": "7", "correctCategory": "Natural Number", "categories": ["Natural Number", "Integer (not natural)", "Rational (not integer)", "Irrational"]},
      {"item": "-3", "correctCategory": "Integer (not natural)", "categories": ["Natural Number", "Integer (not natural)", "Rational (not integer)", "Irrational"]},
      {"item": "0.5", "correctCategory": "Rational (not integer)", "categories": ["Natural Number", "Integer (not natural)", "Rational (not integer)", "Irrational"]},
      {"item": "pi", "correctCategory": "Irrational", "categories": ["Natural Number", "Integer (not natural)", "Rational (not integer)", "Irrational"]},
      {"item": "0", "correctCategory": "Integer (not natural)", "categories": ["Natural Number", "Integer (not natural)", "Rational (not integer)", "Irrational"]},
      {"item": "sqrt(2)", "correctCategory": "Irrational", "categories": ["Natural Number", "Integer (not natural)", "Rational (not integer)", "Irrational"]},
      {"item": "-2.5", "correctCategory": "Rational (not integer)", "categories": ["Natural Number", "Integer (not natural)", "Rational (not integer)", "Irrational"]},
      {"item": "100", "correctCategory": "Natural Number", "categories": ["Natural Number", "Integer (not natural)", "Rational (not integer)", "Irrational"]}
    ]
  }'::jsonb,
  'timed-classification',
  false,
  true
),

-- Activity 1.3.4: Number Types Checkpoint
(
  'b0100000-0000-0000-0003-000000000004',
  'b0000000-0000-0000-0000-000000000001',
  '1.3.4',
  14,
  'Number Types Checkpoint',
  'number-types-checkpoint',
  'checkpoint',
  8,
  30,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Which number type includes ALL other number types?",
        "options": ["Real numbers", "Rational numbers", "Integers", "Natural numbers"],
        "correct": 0,
        "explanation": "Real numbers include both rational and irrational numbers, making them the broadest category."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Which of these is irrational?",
        "options": ["sqrt(3)", "sqrt(4)", "0.25", "1/7"],
        "correct": 0,
        "explanation": "sqrt(3) is approximately 1.732... with non-repeating decimals. sqrt(4) = 2 is rational."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "The number 0 is classified as:",
        "options": ["Whole, Integer, Rational, Real", "Natural, Whole, Integer, Rational", "Only an integer", "Only a whole number"],
        "correct": 0,
        "explanation": "0 is whole, integer, rational (0/1), and real. It is NOT natural (natural numbers start at 1)."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "0.142857142857... (repeating) is a rational number.",
        "correct": true,
        "explanation": "True! Repeating decimals can always be expressed as fractions. This equals 1/7."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "If a hotel has -5 available rooms, what does this represent?",
        "options": ["5 overbooked rooms", "An impossible situation", "5 vacant rooms", "5 occupied rooms"],
        "correct": 0,
        "explanation": "A negative availability means the hotel is overbooked. Integers can represent deficits."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Calculator Proficiency (MF-04)
-- ============================================

-- Activity 1.4.1: Mastering Your Calculator
(
  'b0100000-0000-0000-0004-000000000001',
  'b0000000-0000-0000-0000-000000000001',
  '1.4.1',
  15,
  'Mastering Your Calculator',
  'mastering-your-calculator',
  'lesson',
  10,
  20,
  'free',
  '{"markdown": "# Mastering Your Calculator\n\n## Why Calculator Skills Matter\n\nIn exams and real business situations, you need to:\n- Enter complex expressions correctly\n- Use memory functions efficiently\n- Avoid common input errors\n- Verify results make sense\n\n---\n\n## Essential Calculator Keys\n\n| Key | Function | Example |\n|-----|----------|--------|\n| +/- or (-) | Change sign (negative) | Enter -5 |\n| x² | Square a number | 5² = 25 |\n| sqrt or √ | Square root | sqrt(16) = 4 |\n| ^ or y^x | Exponent/power | 2^3 = 8 |\n| 1/x | Reciprocal | 1/4 = 0.25 |\n| % | Percentage | 50 x 15% = 7.5 |\n| ( ) | Parentheses | (3+4) x 2 = 14 |\n\n---\n\n## Memory Functions\n\n| Key | Action |\n|-----|--------|\n| MC | Memory Clear - erases memory |\n| MR | Memory Recall - displays stored value |\n| M+ | Memory Add - adds display to memory |\n| M- | Memory Subtract - subtracts display from memory |\n| MS | Memory Store - stores display value |\n\n### Example: Calculate 25 x 3 + 18 x 4\n\n**Using Memory:**\n1. Enter 25 x 3 = 75, press M+ (stores 75)\n2. Enter 18 x 4 = 72, press M+ (adds 72 to memory)\n3. Press MR to get 147\n\n---\n\n## Entering Negative Numbers\n\n:::warning{title=\"Common Mistake\"}\nDo NOT use the minus key for negative numbers!\n- Wrong: - 5 x 3 (calculates 0 - 5 x 3)\n- Correct: (-) 5 x 3 or 5 +/- x 3\n:::\n\n---\n\n## Percentage Calculations\n\n### Finding a percentage OF something\n**What is 15% of 200?**\n- Option 1: 200 x 15 % = 30\n- Option 2: 200 x 0.15 = 30\n\n### Adding a percentage TO something\n**Add 7.7% VAT to CHF 100:**\n- Option 1: 100 + 100 x 7.7 % = 107.70\n- Option 2: 100 x 1.077 = 107.70\n\n### Finding percentage change\n**Old: 80, New: 100. What is the % increase?**\n- (100 - 80) ÷ 80 x 100 = 25%\n\n---\n\n## Order of Operations on Calculators\n\n### Scientific Calculators\nMost scientific calculators follow PEMDAS automatically:\n- 2 + 3 x 4 = gives 14 (correct)\n\n### Basic Calculators\nSome basic calculators evaluate left-to-right:\n- 2 + 3 x 4 = might give 20 (wrong for math)\n\n:::tip{title=\"Always Test Your Calculator\"}\nEnter 2 + 3 x 4 =\n- If you get 14, it follows PEMDAS\n- If you get 20, you need to use parentheses\n:::\n\n---\n\n## Exam Tips\n\n1. **Bring fresh batteries** or a backup calculator\n2. **Practice with YOUR calculator** before the exam\n3. **Use parentheses liberally** to avoid order errors\n4. **Check reasonableness** - does the answer make sense?\n5. **Write down intermediate results** for partial credit\n\n---\n\n:::takeaways\n- Use the (+/-) key for negative numbers, not the minus key\n- Memory functions save time on multi-part calculations\n- Know if your calculator follows PEMDAS or not\n- Practice percentage calculations both ways\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.4.2: Calculator Quiz
(
  'b0100000-0000-0000-0004-000000000002',
  'b0000000-0000-0000-0000-000000000001',
  '1.4.2',
  16,
  'Calculator Skills Quiz',
  'calculator-skills-quiz',
  'quiz',
  8,
  25,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "To enter -8 on a scientific calculator, you should:",
        "options": ["Press 8 then the +/- or (-) key", "Press - then 8", "Press 8 - 0", "Press 0 - 8"],
        "correct": 0,
        "explanation": "The +/- or (-) key changes the sign of the displayed number. Enter the number first, then make it negative."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is the purpose of the MR (Memory Recall) key?",
        "options": ["Display the value stored in memory", "Reset all memory", "Add to memory", "Subtract from memory"],
        "correct": 0,
        "explanation": "MR (Memory Recall) displays whatever value is currently stored in the calculator''s memory."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "To calculate 18% of CHF 450, you would enter:",
        "options": ["450 x 18 % or 450 x 0.18", "18 ÷ 450 x 100", "450 + 18 %", "450 ÷ 18"],
        "correct": 0,
        "explanation": "18% of 450 = 450 x 0.18 = 81. Most calculators also accept 450 x 18 %."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "All calculators follow PEMDAS order of operations automatically.",
        "correct": false,
        "explanation": "False! Basic calculators often evaluate left-to-right. Only scientific calculators consistently follow PEMDAS."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "To add 7.7% VAT to CHF 85, the most efficient calculator entry is:",
        "options": ["85 x 1.077", "85 + 85 x 7.7 ÷ 100", "85 x 7.7%", "All of these work"],
        "correct": 3,
        "explanation": "All methods give CHF 91.55. Multiplying by 1.077 is most efficient for mental math too."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "You need to calculate (15 x 24) + (18 x 32). Using memory, the correct sequence is:",
        "options": ["15 x 24 = M+, 18 x 32 = M+, MR", "15 x 24 = MS, 18 x 32 +", "M+ 15 x 24, M+ 18 x 32", "15 x 24 MR, 18 x 32 MC"],
        "correct": 0,
        "explanation": "Calculate 15 x 24 = 360, press M+ to add to memory. Calculate 18 x 32 = 576, press M+ to add. Press MR to get 936."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 1.4.3: Calculator Matching
(
  'b0100000-0000-0000-0004-000000000003',
  'b0000000-0000-0000-0000-000000000001',
  '1.4.3',
  17,
  'Match Calculator Functions',
  'match-calculator-functions',
  'interactive',
  5,
  20,
  'free',
  '{
    "instructions": "Match each calculator key with its function.",
    "pairs": [
      {"left": "M+", "right": "Add display value to memory"},
      {"left": "MR", "right": "Display stored memory value"},
      {"left": "MC", "right": "Clear the memory"},
      {"left": "+/-", "right": "Change sign (positive/negative)"},
      {"left": "y^x", "right": "Raise to a power"},
      {"left": "1/x", "right": "Calculate reciprocal"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 1.4.4: Calculator Checkpoint
(
  'b0100000-0000-0000-0004-000000000004',
  'b0000000-0000-0000-0000-000000000001',
  '1.4.4',
  18,
  'Calculator Proficiency Checkpoint',
  'calculator-proficiency-checkpoint',
  'checkpoint',
  8,
  30,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Calculate 5.6² using your calculator. The answer is:",
        "options": ["31.36", "11.2", "25.36", "31.36"],
        "correct": 0,
        "explanation": "5.6² = 5.6 x 5.6 = 31.36. Use the x² key or enter 5.6 x 5.6."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "What is 12% of CHF 875?",
        "options": ["CHF 105", "CHF 10.50", "CHF 1,050", "CHF 72.92"],
        "correct": 0,
        "explanation": "875 x 0.12 = 105"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Calculate the total: CHF 45 + 7.7% VAT",
        "options": ["CHF 48.47", "CHF 52.70", "CHF 48.00", "CHF 45.77"],
        "correct": 0,
        "explanation": "45 x 1.077 = 48.465, rounded to CHF 48.47"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Enter (-5)² on your calculator. The result is:",
        "options": ["25", "-25", "10", "-10"],
        "correct": 0,
        "explanation": "(-5)² = (-5) x (-5) = 25. The square of any number is positive."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "To test if your calculator follows PEMDAS, enter 3 + 4 x 2 =. The correct answer is:",
        "options": ["11", "14", "10", "24"],
        "correct": 0,
        "explanation": "Following PEMDAS: 4 x 2 = 8, then 3 + 8 = 11"
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

