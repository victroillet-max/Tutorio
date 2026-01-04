-- ============================================
-- Module 2: Basic Statistics Activities
-- 4 Skills: Arithmetic Mean, Weighted Averages, Summation Notation, Central Tendency
-- ============================================

-- ============================================
-- SKILL: Arithmetic Mean (ST-01)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 2.1.1: Understanding the Mean
(
  'b0200000-0000-0000-0001-000000000001',
  'b0000000-0000-0000-0000-000000000002',
  '2.1.1',
  1,
  'Understanding the Arithmetic Mean',
  'understanding-arithmetic-mean',
  'lesson',
  10,
  20,
  'free',
  '{"markdown": "# Understanding the Arithmetic Mean\n\n## What is the Mean?\n\nThe **arithmetic mean** (commonly called the \"average\") is the sum of all values divided by the number of values.\n\n$$\\bar{x} = \\frac{\\text{Sum of all values}}{\\text{Number of values}} = \\frac{x_1 + x_2 + ... + x_n}{n}$$\n\n---\n\n## Why the Mean Matters in Business\n\nThe mean helps answer questions like:\n- What is the **average room rate**?\n- What is the **average customer spending**?\n- What is the **average occupancy rate**?\n- What is the **average employee performance score**?\n\n---\n\n## Step-by-Step Calculation\n\n### Example 1: Average Room Rate\n\nA hotel sold 5 rooms at these rates: CHF 150, 180, 165, 200, 175\n\n| Step | Calculation |\n|------|-------------|\n| 1. Sum all values | 150 + 180 + 165 + 200 + 175 = 870 |\n| 2. Count values | n = 5 |\n| 3. Divide | 870 ÷ 5 = **CHF 174** |\n\n### Example 2: Average Daily Occupancy\n\nWeekly occupancy rates: 78%, 82%, 95%, 88%, 72%, 91%, 85%\n\n$$\\bar{x} = \\frac{78 + 82 + 95 + 88 + 72 + 91 + 85}{7} = \\frac{591}{7} = 84.4\\%$$\n\n---\n\n## Properties of the Mean\n\n:::concept{title=\"Key Properties\"}\n1. The mean uses every data point\n2. The mean is sensitive to extreme values (outliers)\n3. The sum of deviations from the mean is always zero\n:::\n\n### The Outlier Problem\n\nSalaries at a small company: CHF 50,000, 55,000, 52,000, 48,000, **250,000** (CEO)\n\n$$\\bar{x} = \\frac{50000 + 55000 + 52000 + 48000 + 250000}{5} = \\frac{455000}{5} = CHF 91,000$$\n\nThe mean (CHF 91,000) does not represent a typical employee''s salary!\n\n---\n\n## Business Applications\n\n| Metric | Formula | Use |\n|--------|---------|-----|\n| Average Revenue per User (ARPU) | Total Revenue / Users | Tech, telecom |\n| Average Daily Rate (ADR) | Room Revenue / Rooms Sold | Hotels |\n| Average Check | Total Sales / Transactions | Restaurants |\n| Average Length of Stay | Total Nights / Guests | Hotels |\n\n---\n\n:::takeaways\n- Mean = Sum of values / Count of values\n- The mean is affected by extreme values (outliers)\n- Always consider if the mean represents typical values\n- In business, the mean is used for ADR, ARPU, average check, etc.\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.1.2: Mean Calculations Quiz
(
  'b0200000-0000-0000-0001-000000000002',
  'b0000000-0000-0000-0000-000000000002',
  '2.1.2',
  2,
  'Mean Calculations Quiz',
  'mean-calculations-quiz',
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
        "question": "Find the mean of: 10, 15, 20, 25, 30",
        "options": ["20", "25", "15", "100"],
        "correct": 0,
        "explanation": "Sum = 10+15+20+25+30 = 100. Mean = 100/5 = 20"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A restaurant had these daily revenues: CHF 2,400, 3,100, 2,800, 3,500, 2,700. What is the average daily revenue?",
        "options": ["CHF 2,900", "CHF 2,800", "CHF 3,000", "CHF 14,500"],
        "correct": 0,
        "explanation": "Sum = 14,500. Mean = 14,500/5 = CHF 2,900"
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The mean is always one of the values in the data set.",
        "correct": false,
        "explanation": "False! The mean of 2 and 4 is 3, which is not in the original set."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Five employees have salaries of CHF 45,000, 48,000, 52,000, 49,000, and X. If the mean salary is CHF 50,000, what is X?",
        "options": ["CHF 56,000", "CHF 50,000", "CHF 54,000", "CHF 52,000"],
        "correct": 0,
        "explanation": "Total must be 50,000 x 5 = 250,000. Current sum = 194,000. X = 250,000 - 194,000 = CHF 56,000"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Hotel occupancy for 4 weeks was 75%, 82%, 88%, and 79%. What is the average occupancy?",
        "options": ["81%", "80%", "82%", "324%"],
        "correct": 0,
        "explanation": "Mean = (75+82+88+79)/4 = 324/4 = 81%"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.1.3: Mean Practice Interactive
(
  'b0200000-0000-0000-0001-000000000003',
  'b0000000-0000-0000-0000-000000000002',
  '2.1.3',
  3,
  'Calculate the Mean Challenge',
  'calculate-mean-challenge',
  'interactive',
  6,
  25,
  'free',
  '{
    "instructions": "Match each data set with its correct mean.",
    "pairs": [
      {"left": "5, 10, 15, 20, 25", "right": "15"},
      {"left": "100, 200, 300", "right": "200"},
      {"left": "8, 12, 16, 4", "right": "10"},
      {"left": "50, 60, 70, 80, 90, 100", "right": "75"},
      {"left": "3.5, 4.5, 5.0, 7.0", "right": "5.0"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 2.1.4: Mean Checkpoint
(
  'b0200000-0000-0000-0001-000000000004',
  'b0000000-0000-0000-0000-000000000002',
  '2.1.4',
  4,
  'Arithmetic Mean Checkpoint',
  'arithmetic-mean-checkpoint',
  'checkpoint',
  8,
  30,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The mean of 12, 18, and 24 is:",
        "options": ["18", "12", "24", "54"],
        "correct": 0,
        "explanation": "(12+18+24)/3 = 54/3 = 18"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "If you add an outlier of 1000 to the set {10, 20, 30, 40}, the mean will:",
        "options": ["Increase significantly", "Decrease", "Stay the same", "Become negative"],
        "correct": 0,
        "explanation": "Original mean = 25. New mean = (10+20+30+40+1000)/5 = 220. The outlier pulls the mean up."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "ADR (Average Daily Rate) is calculated as:",
        "options": ["Room Revenue / Rooms Sold", "Total Revenue / Days", "Rooms Sold / Days", "Room Revenue x Rooms Sold"],
        "correct": 0,
        "explanation": "ADR = Total Room Revenue / Number of Rooms Sold"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "A hotel had 4 nights with occupancy of 80%, 85%, 90%, 85%. The average occupancy is:",
        "options": ["85%", "340%", "80%", "90%"],
        "correct": 0,
        "explanation": "(80+85+90+85)/4 = 340/4 = 85%"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Weighted Averages (ST-02)
-- ============================================

-- Activity 2.2.1: Introduction to Weighted Averages
(
  'b0200000-0000-0000-0002-000000000001',
  'b0000000-0000-0000-0000-000000000002',
  '2.2.1',
  5,
  'Introduction to Weighted Averages',
  'introduction-weighted-averages',
  'lesson',
  12,
  25,
  'free',
  '{"markdown": "# Introduction to Weighted Averages\n\n## Why Weighted Averages?\n\nNot all values should count equally. Consider:\n- A final exam (50%) vs. homework (10%)\n- Buying 100 units at CHF 5 vs. 10 units at CHF 8\n- High-traffic hours vs. low-traffic hours\n\n:::concept{title=\"Weighted vs. Simple Average\"}\nA weighted average assigns different importance (weights) to different values.\n:::\n\n---\n\n## The Formula\n\n$$\\bar{x}_w = \\frac{\\sum (w_i \\times x_i)}{\\sum w_i} = \\frac{w_1 x_1 + w_2 x_2 + ... + w_n x_n}{w_1 + w_2 + ... + w_n}$$\n\nWhere:\n- $x_i$ = each value\n- $w_i$ = weight (importance) of each value\n\n---\n\n## Example 1: Course Grade\n\n| Component | Score | Weight |\n|-----------|-------|--------|\n| Midterm | 75% | 30% |\n| Final Exam | 85% | 50% |\n| Homework | 90% | 20% |\n\n**Calculation:**\n$$\\bar{x}_w = \\frac{(75 \\times 0.30) + (85 \\times 0.50) + (90 \\times 0.20)}{0.30 + 0.50 + 0.20}$$\n$$= \\frac{22.5 + 42.5 + 18}{1.0} = \\textbf{83%}$$\n\n:::warning{title=\"Common Mistake\"}\nIf you used a simple average: (75 + 85 + 90)/3 = 83.3%\nThe difference is small here but can be significant with different weights!\n:::\n\n---\n\n## Example 2: Average Purchase Price\n\nA company bought inventory at different prices:\n\n| Purchase | Quantity | Price/Unit |\n|----------|----------|------------|\n| January | 100 units | CHF 5.00 |\n| March | 50 units | CHF 6.50 |\n| June | 150 units | CHF 4.50 |\n\n**Weighted Average Cost:**\n$$\\bar{x}_w = \\frac{(100 \\times 5) + (50 \\times 6.50) + (150 \\times 4.50)}{100 + 50 + 150}$$\n$$= \\frac{500 + 325 + 675}{300} = \\frac{1500}{300} = \\textbf{CHF 5.00}$$\n\n**Simple average would be:** (5 + 6.50 + 4.50)/3 = CHF 5.33\n\nThe weighted average is lower because more units were bought at lower prices!\n\n---\n\n## Business Applications\n\n| Application | Values | Weights |\n|-------------|--------|--------|\n| Portfolio Return | Stock returns | Investment amounts |\n| Course Grade | Assignment scores | Credit weights |\n| Price Index | Item prices | Consumption quantities |\n| Customer Satisfaction | Segment scores | Segment sizes |\n\n---\n\n:::takeaways\n- Weighted averages give more importance to some values than others\n- Multiply each value by its weight, sum, then divide by total weights\n- Use when quantities or importance differ\n- Common in grading, inventory costing, and financial analysis\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.2.2: Weighted Averages Quiz
(
  'b0200000-0000-0000-0002-000000000002',
  'b0000000-0000-0000-0000-000000000002',
  '2.2.2',
  6,
  'Weighted Averages Quiz',
  'weighted-averages-quiz',
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
        "question": "A student scores 80% on a test worth 40% and 90% on a test worth 60%. What is their weighted average?",
        "options": ["86%", "85%", "87%", "84%"],
        "correct": 0,
        "explanation": "(80 x 0.40) + (90 x 0.60) = 32 + 54 = 86%"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A store sells 200 items at CHF 10 and 100 items at CHF 15. What is the weighted average price?",
        "options": ["CHF 11.67", "CHF 12.50", "CHF 12.00", "CHF 11.00"],
        "correct": 0,
        "explanation": "(200 x 10 + 100 x 15)/(200 + 100) = (2000 + 1500)/300 = 3500/300 = CHF 11.67"
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "In a weighted average, items with higher weights have more influence on the result.",
        "correct": true,
        "explanation": "True! That is the purpose of weighted averages - to give more importance to certain values."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Three branches have customer satisfaction scores: Branch A: 85% (500 customers), Branch B: 78% (300 customers), Branch C: 92% (200 customers). What is the overall weighted satisfaction?",
        "options": ["84.1%", "85.0%", "83.7%", "86.2%"],
        "correct": 0,
        "explanation": "(85 x 500 + 78 x 300 + 92 x 200)/(500+300+200) = (42500 + 23400 + 18400)/1000 = 84100/1000 = 84.1%"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.2.3: Weighted Average Checkpoint
(
  'b0200000-0000-0000-0002-000000000003',
  'b0000000-0000-0000-0000-000000000002',
  '2.2.3',
  7,
  'Weighted Averages Checkpoint',
  'weighted-averages-checkpoint',
  'checkpoint',
  10,
  35,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Quiz 1 (20%): 70, Quiz 2 (30%): 80, Final (50%): 90. Weighted average?",
        "options": ["83%", "80%", "85%", "82%"],
        "correct": 0,
        "explanation": "0.20(70) + 0.30(80) + 0.50(90) = 14 + 24 + 45 = 83%"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "When would you use a weighted average instead of a simple average?",
        "options": ["When values have different importance or quantities", "When all values are equal", "When you have only two values", "Never in business"],
        "correct": 0,
        "explanation": "Weighted averages are used when values should count differently based on importance, quantity, or another factor."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Investment A: CHF 10,000 at 5% return. Investment B: CHF 20,000 at 8% return. Weighted average return?",
        "options": ["7%", "6.5%", "7.5%", "6%"],
        "correct": 0,
        "explanation": "(10000 x 5 + 20000 x 8)/(10000 + 20000) = (50000 + 160000)/30000 = 210000/30000 = 7%"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "If all weights are equal, the weighted average equals the simple average.",
        "correct": true,
        "explanation": "True! Equal weights means each value contributes equally, just like a simple average."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Summation Notation (ST-03)
-- ============================================

-- Activity 2.3.1: Understanding Sigma Notation
(
  'b0200000-0000-0000-0003-000000000001',
  'b0000000-0000-0000-0000-000000000002',
  '2.3.1',
  8,
  'Understanding Sigma Notation',
  'understanding-sigma-notation',
  'lesson',
  12,
  25,
  'free',
  '{"markdown": "# Understanding Sigma Notation\n\n## What is Sigma Notation?\n\nThe Greek letter sigma (Σ) is a shorthand way to write \"add up all of these values.\"\n\n$$\\sum_{i=1}^{n} x_i = x_1 + x_2 + x_3 + ... + x_n$$\n\n---\n\n## Anatomy of Sigma Notation\n\n```\n        n       ← upper limit (where to stop)\n        Σ x_i   ← expression to sum\n       i=1      ← index variable and lower limit (where to start)\n```\n\n| Component | Meaning |\n|-----------|--------|\n| Σ | Sum (add up) |\n| i | Index variable (counter) |\n| i = 1 | Start at 1 |\n| n | End at n |\n| x_i | The i-th value |\n\n---\n\n## Simple Examples\n\n### Example 1: Sum of First 5 Integers\n\n$$\\sum_{i=1}^{5} i = 1 + 2 + 3 + 4 + 5 = 15$$\n\n### Example 2: Sum of Squares\n\n$$\\sum_{i=1}^{4} i^2 = 1^2 + 2^2 + 3^2 + 4^2 = 1 + 4 + 9 + 16 = 30$$\n\n### Example 3: Sum of Data Values\n\nFor data set: x₁ = 5, x₂ = 8, x₃ = 12, x₄ = 7\n\n$$\\sum_{i=1}^{4} x_i = 5 + 8 + 12 + 7 = 32$$\n\n---\n\n## The Mean Formula in Sigma Notation\n\n$$\\bar{x} = \\frac{\\sum_{i=1}^{n} x_i}{n}$$\n\nThis reads: \"The mean equals the sum of all x values divided by n.\"\n\n---\n\n## Common Sigma Formulas\n\n| Formula | Expansion | Use |\n|---------|-----------|-----|\n| $\\sum_{i=1}^{n} x_i$ | x₁ + x₂ + ... + xₙ | Total of all values |\n| $\\sum_{i=1}^{n} w_i x_i$ | w₁x₁ + w₂x₂ + ... | Weighted sum |\n| $\\sum_{i=1}^{n} (x_i - \\bar{x})$ | Always equals 0 | Deviations from mean |\n| $\\sum_{i=1}^{n} (x_i - \\bar{x})^2$ | Sum of squared deviations | Variance calculation |\n\n---\n\n## Properties of Summation\n\n### 1. Constant Factor\n$$\\sum_{i=1}^{n} c \\cdot x_i = c \\cdot \\sum_{i=1}^{n} x_i$$\n\n### 2. Sum of Sums\n$$\\sum_{i=1}^{n} (x_i + y_i) = \\sum_{i=1}^{n} x_i + \\sum_{i=1}^{n} y_i$$\n\n### 3. Constant Sum\n$$\\sum_{i=1}^{n} c = n \\cdot c$$\n\n---\n\n:::takeaways\n- Σ means \"sum of\"\n- The index tells you where to start and stop\n- Sigma notation is used in formulas for mean, variance, and more\n- You can factor out constants and split sums\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.3.2: Sigma Notation Quiz
(
  'b0200000-0000-0000-0003-000000000002',
  'b0000000-0000-0000-0000-000000000002',
  '2.3.2',
  9,
  'Sigma Notation Quiz',
  'sigma-notation-quiz',
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
        "question": "Evaluate: Σ from i=1 to 4 of i",
        "options": ["10", "4", "16", "24"],
        "correct": 0,
        "explanation": "1 + 2 + 3 + 4 = 10"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does Σ from i=1 to 3 of 5 equal?",
        "options": ["15", "5", "8", "125"],
        "correct": 0,
        "explanation": "5 + 5 + 5 = 15 (we add the constant 5 three times)"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If x₁=2, x₂=4, x₃=6, x₄=8, what is Σxᵢ from i=1 to 4?",
        "options": ["20", "40", "10", "14"],
        "correct": 0,
        "explanation": "2 + 4 + 6 + 8 = 20"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Evaluate: Σ from i=1 to 3 of i²",
        "options": ["14", "9", "6", "36"],
        "correct": 0,
        "explanation": "1² + 2² + 3² = 1 + 4 + 9 = 14"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Σ from i=1 to n of (xᵢ - x̄) always equals zero.",
        "correct": true,
        "explanation": "True! The sum of deviations from the mean is always zero."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.3.3: Sigma Notation Checkpoint
(
  'b0200000-0000-0000-0003-000000000003',
  'b0000000-0000-0000-0000-000000000002',
  '2.3.3',
  10,
  'Summation Notation Checkpoint',
  'summation-notation-checkpoint',
  'checkpoint',
  10,
  35,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "What is Σ from i=1 to 5 of 2i?",
        "options": ["30", "15", "10", "20"],
        "correct": 0,
        "explanation": "2(1) + 2(2) + 2(3) + 2(4) + 2(5) = 2 + 4 + 6 + 8 + 10 = 30"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "The formula x̄ = Σxᵢ/n represents:",
        "options": ["The arithmetic mean", "The weighted average", "The sum total", "The variance"],
        "correct": 0,
        "explanation": "This is the formula for the arithmetic mean (average)."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "What is Σ from i=2 to 4 of i?",
        "options": ["9", "10", "6", "12"],
        "correct": 0,
        "explanation": "Starting from 2: 2 + 3 + 4 = 9"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "If Σxᵢ = 100 for 5 values, what is the mean?",
        "options": ["20", "100", "500", "25"],
        "correct": 0,
        "explanation": "Mean = Σxᵢ/n = 100/5 = 20"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Central Tendency Measures (ST-04)
-- ============================================

-- Activity 2.4.1: Mean, Median, and Mode
(
  'b0200000-0000-0000-0004-000000000001',
  'b0000000-0000-0000-0000-000000000002',
  '2.4.1',
  11,
  'Mean, Median, and Mode',
  'mean-median-mode',
  'lesson',
  12,
  25,
  'free',
  '{"markdown": "# Mean, Median, and Mode\n\n## Three Ways to Measure \"Average\"\n\nAll three are measures of central tendency, but they answer different questions:\n\n| Measure | Question Answered | Calculation |\n|---------|-------------------|-------------|\n| Mean | What is the arithmetic average? | Sum ÷ Count |\n| Median | What is the middle value? | Middle position |\n| Mode | What is the most common value? | Most frequent |\n\n---\n\n## The Median\n\nThe **median** is the middle value when data is arranged in order.\n\n### Steps to Find the Median:\n1. Arrange values in order (ascending or descending)\n2. Find the middle position:\n   - Odd n: Position = (n+1)/2\n   - Even n: Average of positions n/2 and n/2 + 1\n\n### Example: Odd Number of Values\nData: 15, 23, 8, 42, 11\n\n1. Order: 8, 11, **15**, 23, 42\n2. Position: (5+1)/2 = 3rd position\n3. Median = **15**\n\n### Example: Even Number of Values\nData: 15, 23, 8, 42, 11, 19\n\n1. Order: 8, 11, **15, 19**, 23, 42\n2. Position: Average of 3rd and 4th\n3. Median = (15 + 19)/2 = **17**\n\n---\n\n## The Mode\n\nThe **mode** is the value that appears most frequently.\n\n### Examples:\n- Data: 5, 7, 7, 8, 9 → Mode = **7**\n- Data: 1, 2, 2, 3, 3 → Bimodal: **2 and 3**\n- Data: 1, 2, 3, 4, 5 → **No mode** (all appear once)\n\n:::concept{title=\"Mode Use Cases\"}\nThe mode is most useful for:\n- Categorical data (most popular menu item)\n- Finding the most common shoe size to stock\n- Identifying the busiest hour\n:::\n\n---\n\n## Comparing the Three Measures\n\n### When They Are Equal\nIn a perfectly symmetric distribution, Mean = Median = Mode\n\n### When They Differ\nSalaries: CHF 40,000, 42,000, 45,000, 48,000, 200,000\n\n| Measure | Value | Representative? |\n|---------|-------|----------------|\n| Mean | CHF 75,000 | No (pulled by outlier) |\n| Median | CHF 45,000 | Yes (middle value) |\n| Mode | None | N/A |\n\n---\n\n## Which Measure to Use?\n\n| Situation | Best Measure | Why |\n|-----------|--------------|-----|\n| Symmetric data | Mean | Uses all data |\n| Skewed data/outliers | Median | Not affected by extremes |\n| Categorical data | Mode | Only option |\n| Income/prices | Median | Often skewed |\n| Test scores | Mean | Symmetric, all grades count |\n\n---\n\n:::takeaways\n- Mean: Sum of values divided by count\n- Median: Middle value when ordered\n- Mode: Most frequent value\n- Use median when outliers exist\n- Use mode for categorical data\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.4.2: Central Tendency Quiz
(
  'b0200000-0000-0000-0004-000000000002',
  'b0000000-0000-0000-0000-000000000002',
  '2.4.2',
  12,
  'Central Tendency Quiz',
  'central-tendency-quiz',
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
        "question": "Find the median of: 3, 7, 9, 12, 15",
        "options": ["9", "7", "12", "9.2"],
        "correct": 0,
        "explanation": "Already ordered, 5 values, middle position = 3rd. Median = 9"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Find the mode of: 4, 6, 6, 7, 8, 8, 8, 9",
        "options": ["8", "6", "7", "7.5"],
        "correct": 0,
        "explanation": "8 appears 3 times, more than any other value. Mode = 8"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Data: 10, 20, 30, 40, 500. Which measure is most representative?",
        "options": ["Median (30)", "Mean (120)", "Mode (none)", "All are equal"],
        "correct": 0,
        "explanation": "The value 500 is an outlier. Median (30) better represents typical values than mean (120)."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Find the median of: 15, 22, 31, 40, 55, 68",
        "options": ["35.5", "31", "40", "36"],
        "correct": 0,
        "explanation": "Even count (6). Average of 3rd and 4th: (31+40)/2 = 35.5"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which measure is best for finding the most popular room type?",
        "options": ["Mode", "Mean", "Median", "Range"],
        "correct": 0,
        "explanation": "Room type is categorical. Mode identifies the most frequent category."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 2.4.3: Central Tendency Checkpoint
(
  'b0200000-0000-0000-0004-000000000003',
  'b0000000-0000-0000-0000-000000000002',
  '2.4.3',
  13,
  'Central Tendency Checkpoint',
  'central-tendency-checkpoint',
  'checkpoint',
  10,
  35,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Data: 5, 8, 8, 10, 12, 15, 15, 15, 20. What is the mode?",
        "options": ["15", "8", "12", "10"],
        "correct": 0,
        "explanation": "15 appears 3 times, more than any other value."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Hotel nightly rates: CHF 150, 175, 180, 185, 450. Which measure best represents typical rates?",
        "options": ["Median (CHF 180)", "Mean (CHF 228)", "Mode", "Maximum"],
        "correct": 0,
        "explanation": "The CHF 450 is an outlier. Median (180) is more representative."
      },
      {
        "id": "cp3",
        "type": "true_false",
        "question": "The median is always one of the values in the data set.",
        "correct": false,
        "explanation": "False! With an even count, the median is the average of two middle values, which may not be in the set."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "For data: 2, 4, 6, 8, 10. What are the mean and median?",
        "options": ["Mean = 6, Median = 6", "Mean = 5, Median = 6", "Mean = 6, Median = 5", "Mean = 30, Median = 6"],
        "correct": 0,
        "explanation": "Mean = (2+4+6+8+10)/5 = 30/5 = 6. Median = middle value = 6."
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

