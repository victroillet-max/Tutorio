-- ============================================
-- Module 3: Ratios and Percentages Activities
-- 6 Skills: Fractions, Ratios, Percentages, Percent Change, Markup/Margin, Index Numbers
-- ============================================

-- ============================================
-- SKILL: Fraction Operations (RP-01)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

(
  'b0300000-0000-0000-0001-000000000001',
  'b0000000-0000-0000-0000-000000000003',
  '3.1.1',
  1,
  'Mastering Fractions',
  'mastering-fractions',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Mastering Fractions\n\n## Why Fractions in Business?\n\nFractions appear everywhere:\n- 3/4 of the budget is allocated\n- 2/5 of customers prefer option A\n- Recipe scaled to 1/2 the original size\n\n---\n\n## Fraction Basics\n\n$$\\frac{\\text{Numerator}}{\\text{Denominator}} = \\frac{3}{4}$$\n\n- **Numerator**: Parts you have\n- **Denominator**: Total parts\n\n---\n\n## Simplifying Fractions\n\nDivide both numerator and denominator by their Greatest Common Divisor (GCD):\n\n$$\\frac{12}{18} = \\frac{12 ÷ 6}{18 ÷ 6} = \\frac{2}{3}$$\n\n---\n\n## Adding and Subtracting Fractions\n\n:::concept{title=\"Same Denominator\"}\nJust add/subtract the numerators:\n$$\\frac{3}{8} + \\frac{2}{8} = \\frac{5}{8}$$\n:::\n\n### Different Denominators\nFind a common denominator first:\n\n$$\\frac{1}{4} + \\frac{2}{3} = \\frac{3}{12} + \\frac{8}{12} = \\frac{11}{12}$$\n\n---\n\n## Multiplying Fractions\n\nMultiply numerators and multiply denominators:\n\n$$\\frac{2}{3} × \\frac{4}{5} = \\frac{2 × 4}{3 × 5} = \\frac{8}{15}$$\n\n---\n\n## Dividing Fractions\n\n:::tip{title=\"Keep-Change-Flip\"}\nKeep the first fraction, change ÷ to ×, flip the second fraction:\n$$\\frac{3}{4} ÷ \\frac{2}{5} = \\frac{3}{4} × \\frac{5}{2} = \\frac{15}{8}$$\n:::\n\n---\n\n## Converting Between Decimals and Fractions\n\n| Decimal | Fraction | Simplify |\n|---------|----------|----------|\n| 0.5 | 5/10 | 1/2 |\n| 0.25 | 25/100 | 1/4 |\n| 0.75 | 75/100 | 3/4 |\n| 0.125 | 125/1000 | 1/8 |\n\n---\n\n:::takeaways\n- Find common denominators for adding/subtracting\n- Multiply straight across for multiplication\n- Flip and multiply for division\n- Always simplify your final answer\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0300000-0000-0000-0001-000000000002',
  'b0000000-0000-0000-0000-000000000003',
  '3.1.2',
  2,
  'Fraction Operations Quiz',
  'fraction-operations-quiz',
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
        "question": "Calculate: 2/5 + 1/5",
        "options": ["3/5", "3/10", "2/5", "1/2"],
        "correct": 0,
        "explanation": "Same denominator: 2/5 + 1/5 = 3/5"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Calculate: 3/4 x 2/3",
        "options": ["1/2", "6/7", "5/7", "6/12"],
        "correct": 0,
        "explanation": "3/4 x 2/3 = 6/12 = 1/2"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Calculate: 1/2 + 1/3",
        "options": ["5/6", "2/5", "1/5", "2/6"],
        "correct": 0,
        "explanation": "LCD is 6: 3/6 + 2/6 = 5/6"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Calculate: 4/5 ÷ 2/3",
        "options": ["6/5 or 1.2", "8/15", "2/5", "6/15"],
        "correct": 0,
        "explanation": "4/5 ÷ 2/3 = 4/5 x 3/2 = 12/10 = 6/5"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Simplify: 36/48",
        "options": ["3/4", "4/5", "6/8", "9/12"],
        "correct": 0,
        "explanation": "GCD of 36 and 48 is 12. 36/12 = 3, 48/12 = 4. Answer: 3/4"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0300000-0000-0000-0001-000000000003',
  'b0000000-0000-0000-0000-000000000003',
  '3.1.3',
  3,
  'Fractions Checkpoint',
  'fractions-checkpoint',
  'checkpoint',
  8,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "3/8 + 5/8 = ?",
        "options": ["1", "8/16", "8/8", "2"],
        "correct": 0,
        "explanation": "3/8 + 5/8 = 8/8 = 1"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "2/3 x 3/4 = ?",
        "options": ["1/2", "6/12", "5/7", "6/7"],
        "correct": 0,
        "explanation": "2/3 x 3/4 = 6/12 = 1/2"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Convert 0.375 to a fraction:",
        "options": ["3/8", "3/4", "5/8", "375/100"],
        "correct": 0,
        "explanation": "0.375 = 375/1000 = 3/8"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "5/6 - 1/4 = ?",
        "options": ["7/12", "4/2", "6/10", "1/3"],
        "correct": 0,
        "explanation": "LCD is 12: 10/12 - 3/12 = 7/12"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Percentage Calculations (RP-03)
-- ============================================

(
  'b0300000-0000-0000-0003-000000000001',
  'b0000000-0000-0000-0000-000000000003',
  '3.3.1',
  4,
  'Understanding Percentages',
  'understanding-percentages',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Understanding Percentages\n\n## What is a Percentage?\n\nPercent means \"per hundred.\"\n\n$$25\\% = \\frac{25}{100} = 0.25$$\n\n---\n\n## Converting Between Forms\n\n| Percentage | Decimal | Fraction |\n|------------|---------|----------|\n| 50% | 0.50 | 1/2 |\n| 25% | 0.25 | 1/4 |\n| 10% | 0.10 | 1/10 |\n| 75% | 0.75 | 3/4 |\n| 100% | 1.00 | 1/1 |\n| 150% | 1.50 | 3/2 |\n\n### Conversion Rules:\n- **% to Decimal:** Divide by 100 (move decimal left 2 places)\n- **Decimal to %:** Multiply by 100 (move decimal right 2 places)\n\n---\n\n## Three Basic Percentage Problems\n\n### Type 1: Find the Part\n**What is 15% of 200?**\n$$\\text{Part} = \\text{Whole} × \\text{Percent} = 200 × 0.15 = 30$$\n\n### Type 2: Find the Percent\n**What percent of 80 is 20?**\n$$\\text{Percent} = \\frac{\\text{Part}}{\\text{Whole}} = \\frac{20}{80} = 0.25 = 25\\%$$\n\n### Type 3: Find the Whole\n**30 is 25% of what number?**\n$$\\text{Whole} = \\frac{\\text{Part}}{\\text{Percent}} = \\frac{30}{0.25} = 120$$\n\n---\n\n## Business Applications\n\n### VAT Calculation\nPrice before VAT: CHF 100, VAT rate: 7.7%\n$$\\text{VAT} = 100 × 0.077 = CHF 7.70$$\n$$\\text{Total} = 100 + 7.70 = CHF 107.70$$\n\n### Commission\nSales: CHF 50,000, Commission: 8%\n$$\\text{Commission} = 50,000 × 0.08 = CHF 4,000$$\n\n### Tip Calculation\nBill: CHF 85, Tip: 15%\n$$\\text{Tip} = 85 × 0.15 = CHF 12.75$$\n\n---\n\n:::takeaways\n- Percent means \"out of 100\"\n- To find X% of Y: Multiply Y by X/100\n- To find what percent A is of B: Divide A by B, multiply by 100\n- VAT, tips, commissions are all percentage applications\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0300000-0000-0000-0003-000000000002',
  'b0000000-0000-0000-0000-000000000003',
  '3.3.2',
  5,
  'Percentage Calculations Quiz',
  'percentage-calculations-quiz',
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
        "question": "What is 20% of 150?",
        "options": ["30", "25", "35", "20"],
        "correct": 0,
        "explanation": "150 x 0.20 = 30"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Convert 0.35 to a percentage:",
        "options": ["35%", "3.5%", "350%", "0.35%"],
        "correct": 0,
        "explanation": "0.35 x 100 = 35%"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A meal costs CHF 75. With 15% tip, what is the total?",
        "options": ["CHF 86.25", "CHF 90.00", "CHF 82.50", "CHF 80.00"],
        "correct": 0,
        "explanation": "Tip = 75 x 0.15 = 11.25. Total = 75 + 11.25 = CHF 86.25"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "45 is what percent of 180?",
        "options": ["25%", "20%", "30%", "15%"],
        "correct": 0,
        "explanation": "45 / 180 = 0.25 = 25%"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If 15% of a number is 45, what is the number?",
        "options": ["300", "450", "270", "200"],
        "correct": 0,
        "explanation": "45 / 0.15 = 300"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0300000-0000-0000-0003-000000000003',
  'b0000000-0000-0000-0000-000000000003',
  '3.3.3',
  6,
  'Percentages Checkpoint',
  'percentages-checkpoint',
  'checkpoint',
  8,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "What is 8% of 250?",
        "options": ["20", "25", "18", "32"],
        "correct": 0,
        "explanation": "250 x 0.08 = 20"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Add 7.7% VAT to CHF 200:",
        "options": ["CHF 215.40", "CHF 207.70", "CHF 277.00", "CHF 214.00"],
        "correct": 0,
        "explanation": "VAT = 200 x 0.077 = 15.40. Total = 200 + 15.40 = CHF 215.40"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "What percent is 42 of 168?",
        "options": ["25%", "30%", "20%", "35%"],
        "correct": 0,
        "explanation": "42 / 168 = 0.25 = 25%"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Express 3/5 as a percentage:",
        "options": ["60%", "35%", "50%", "65%"],
        "correct": 0,
        "explanation": "3 / 5 = 0.6 = 60%"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Percentage Change (RP-04)
-- ============================================

(
  'b0300000-0000-0000-0004-000000000001',
  'b0000000-0000-0000-0000-000000000003',
  '3.4.1',
  7,
  'Calculating Percentage Change',
  'calculating-percentage-change',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Calculating Percentage Change\n\n## The Formula\n\n$$\\text{Percentage Change} = \\frac{\\text{New Value} - \\text{Old Value}}{\\text{Old Value}} × 100\\%$$\n\nOr simply:\n$$\\text{% Change} = \\frac{\\text{Change}}{\\text{Original}} × 100\\%$$\n\n---\n\n## Increase vs. Decrease\n\n| Result | Meaning |\n|--------|--------|\n| Positive % | Increase |\n| Negative % | Decrease |\n\n---\n\n## Examples\n\n### Example 1: Price Increase\nOld price: CHF 80, New price: CHF 100\n\n$$\\text{% Change} = \\frac{100 - 80}{80} × 100\\% = \\frac{20}{80} × 100\\% = 25\\%$$\n\n**The price increased by 25%.**\n\n### Example 2: Sales Decrease\nLast year: CHF 500,000, This year: CHF 450,000\n\n$$\\text{% Change} = \\frac{450,000 - 500,000}{500,000} × 100\\% = \\frac{-50,000}{500,000} × 100\\% = -10\\%$$\n\n**Sales decreased by 10%.**\n\n---\n\n## Successive Changes\n\n:::warning{title=\"Common Mistake\"}\nSuccessive percentage changes do NOT add!\n:::\n\n### Example: 20% increase followed by 20% decrease\n\nStart: CHF 100\n- After 20% increase: 100 × 1.20 = CHF 120\n- After 20% decrease: 120 × 0.80 = CHF 96\n\nFinal result: CHF 96 (a 4% decrease, not 0%!)\n\n---\n\n## The Multiplier Method\n\n| Change | Multiplier | Calculation |\n|--------|------------|-------------|\n| +10% | 1.10 | Value × 1.10 |\n| +25% | 1.25 | Value × 1.25 |\n| -15% | 0.85 | Value × 0.85 |\n| -50% | 0.50 | Value × 0.50 |\n\n---\n\n:::takeaways\n- % Change = (New - Old) / Old × 100\n- Always divide by the ORIGINAL value\n- Successive changes multiply, not add\n- Use multipliers: 1 + (rate/100) for increases, 1 - (rate/100) for decreases\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0300000-0000-0000-0004-000000000002',
  'b0000000-0000-0000-0000-000000000003',
  '3.4.2',
  8,
  'Percentage Change Quiz',
  'percentage-change-quiz',
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
        "question": "Price went from CHF 50 to CHF 60. What is the percentage increase?",
        "options": ["20%", "10%", "16.67%", "25%"],
        "correct": 0,
        "explanation": "(60-50)/50 × 100 = 10/50 × 100 = 20%"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Revenue dropped from CHF 200,000 to CHF 170,000. What is the percentage change?",
        "options": ["-15%", "15%", "-30%", "-17.6%"],
        "correct": 0,
        "explanation": "(170,000-200,000)/200,000 × 100 = -30,000/200,000 × 100 = -15%"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A 10% increase followed by a 10% decrease on CHF 100 gives:",
        "options": ["CHF 99", "CHF 100", "CHF 90", "CHF 101"],
        "correct": 0,
        "explanation": "100 × 1.10 = 110. Then 110 × 0.90 = 99"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If a stock drops 40% and then rises 50%, what is the net change from original?",
        "options": ["-10%", "+10%", "0%", "-25%"],
        "correct": 0,
        "explanation": "100 × 0.60 = 60. Then 60 × 1.50 = 90. Net change = -10%"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0300000-0000-0000-0004-000000000003',
  'b0000000-0000-0000-0000-000000000003',
  '3.4.3',
  9,
  'Percentage Change Checkpoint',
  'percentage-change-checkpoint',
  'checkpoint',
  8,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Occupancy rose from 60% to 75%. What is the percentage point increase?",
        "options": ["15 percentage points", "25%", "15%", "12.5%"],
        "correct": 0,
        "explanation": "75% - 60% = 15 percentage points. Note: The percentage CHANGE would be (75-60)/60 = 25%"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "What multiplier represents a 35% decrease?",
        "options": ["0.65", "1.35", "0.35", "-0.35"],
        "correct": 0,
        "explanation": "1 - 0.35 = 0.65"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Cost increased from CHF 40 to CHF 52. The percentage increase is:",
        "options": ["30%", "12%", "23%", "52%"],
        "correct": 0,
        "explanation": "(52-40)/40 × 100 = 12/40 × 100 = 30%"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "A 50% decrease followed by a 50% increase returns you to the original value.",
        "correct": false,
        "explanation": "False! 100 × 0.50 = 50. Then 50 × 1.50 = 75. You end up at 75%, not 100%."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Markup and Margin (RP-05)
-- ============================================

(
  'b0300000-0000-0000-0005-000000000001',
  'b0000000-0000-0000-0000-000000000003',
  '3.5.1',
  10,
  'Understanding Markup and Margin',
  'understanding-markup-margin',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Understanding Markup and Margin\n\n## The Key Difference\n\n:::concept{title=\"Critical Distinction\"}\n- **Markup** = Profit / Cost\n- **Margin** = Profit / Selling Price\n\nThey are NOT the same!\n:::\n\n---\n\n## Definitions\n\n### Markup Percentage\n$$\\text{Markup \\%} = \\frac{\\text{Selling Price} - \\text{Cost}}{\\text{Cost}} × 100\\%$$\n\n### Gross Margin Percentage\n$$\\text{Margin \\%} = \\frac{\\text{Selling Price} - \\text{Cost}}{\\text{Selling Price}} × 100\\%$$\n\n---\n\n## Example Comparison\n\n**Cost: CHF 80, Selling Price: CHF 100**\n\n| Measure | Calculation | Result |\n|---------|-------------|--------|\n| Profit | 100 - 80 | CHF 20 |\n| Markup | 20 / 80 | 25% |\n| Margin | 20 / 100 | 20% |\n\n:::warning{title=\"Same Numbers, Different Percentages\"}\nThe same CHF 20 profit gives 25% markup but only 20% margin!\n:::\n\n---\n\n## Converting Between Markup and Margin\n\n### Margin to Markup\n$$\\text{Markup \\%} = \\frac{\\text{Margin \\%}}{1 - \\text{Margin \\%}}$$\n\n### Markup to Margin\n$$\\text{Margin \\%} = \\frac{\\text{Markup \\%}}{1 + \\text{Markup \\%}}$$\n\n### Example\nIf margin = 20% (0.20):\n$$\\text{Markup} = \\frac{0.20}{1 - 0.20} = \\frac{0.20}{0.80} = 0.25 = 25\\%$$\n\n---\n\n## Common Markup/Margin Pairs\n\n| Markup | Margin |\n|--------|--------|\n| 25% | 20% |\n| 33.3% | 25% |\n| 50% | 33.3% |\n| 100% | 50% |\n| 200% | 66.7% |\n\n---\n\n## Pricing Calculations\n\n### Finding Selling Price from Cost and Markup\n$$\\text{Selling Price} = \\text{Cost} × (1 + \\text{Markup \\%})$$\n\nCost = CHF 60, Markup = 40%\n$$\\text{SP} = 60 × 1.40 = CHF 84$$\n\n### Finding Selling Price from Cost and Margin\n$$\\text{Selling Price} = \\frac{\\text{Cost}}{1 - \\text{Margin \\%}}$$\n\nCost = CHF 60, Margin = 25%\n$$\\text{SP} = \\frac{60}{1 - 0.25} = \\frac{60}{0.75} = CHF 80$$\n\n---\n\n:::takeaways\n- Markup is based on COST\n- Margin is based on SELLING PRICE\n- Same profit gives higher markup % than margin %\n- To achieve a target margin, divide cost by (1 - margin)\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0300000-0000-0000-0005-000000000002',
  'b0000000-0000-0000-0000-000000000003',
  '3.5.2',
  11,
  'Markup and Margin Quiz',
  'markup-margin-quiz',
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
        "question": "Cost is CHF 50, Selling Price is CHF 75. What is the markup?",
        "options": ["50%", "33.3%", "25%", "75%"],
        "correct": 0,
        "explanation": "Markup = (75-50)/50 = 25/50 = 50%"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Cost is CHF 50, Selling Price is CHF 75. What is the margin?",
        "options": ["33.3%", "50%", "25%", "66.7%"],
        "correct": 0,
        "explanation": "Margin = (75-50)/75 = 25/75 = 33.3%"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "To achieve a 25% margin on a product costing CHF 60, the selling price should be:",
        "options": ["CHF 80", "CHF 75", "CHF 85", "CHF 72"],
        "correct": 0,
        "explanation": "SP = Cost / (1 - margin) = 60 / 0.75 = CHF 80"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "A 100% markup means the selling price is double the cost.",
        "correct": true,
        "explanation": "True! 100% markup: SP = Cost × 2.00"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If margin is 40%, what is the equivalent markup?",
        "options": ["66.7%", "40%", "60%", "80%"],
        "correct": 0,
        "explanation": "Markup = margin / (1 - margin) = 0.40 / 0.60 = 0.667 = 66.7%"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0300000-0000-0000-0005-000000000003',
  'b0000000-0000-0000-0000-000000000003',
  '3.5.3',
  12,
  'Markup and Margin Checkpoint',
  'markup-margin-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Which is always larger for the same transaction?",
        "options": ["Markup percentage", "Margin percentage", "They are always equal", "Depends on the numbers"],
        "correct": 0,
        "explanation": "Markup is based on the smaller number (cost), so it is always a higher percentage than margin."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Cost: CHF 120, Target markup: 25%. Selling price?",
        "options": ["CHF 150", "CHF 145", "CHF 160", "CHF 144"],
        "correct": 0,
        "explanation": "SP = 120 × 1.25 = CHF 150"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "If a product has a 50% margin, the markup is:",
        "options": ["100%", "50%", "150%", "75%"],
        "correct": 0,
        "explanation": "Markup = 0.50 / (1 - 0.50) = 0.50 / 0.50 = 1.00 = 100%"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Selling price CHF 200, Cost CHF 150. Gross margin?",
        "options": ["25%", "33%", "50%", "75%"],
        "correct": 0,
        "explanation": "Margin = (200-150)/200 = 50/200 = 25%"
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

