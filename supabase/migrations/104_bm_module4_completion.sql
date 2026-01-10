-- ============================================
-- Phase 3: Module 4 Completion
-- Continuous Compounding
-- 5 Activities
-- ============================================

-- ============================================
-- SKILL: Continuous Compounding (EL-07)
-- Skill ID: c0000000-0000-0000-0004-000000000007
-- Prerequisites: Compound Interest, Logarithm Basics
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 4.7.1: The Number e and Continuous Growth
(
  'b0400000-0000-0000-0007-000000000001',
  NULL,
  '4.7.1',
  30,
  'The Number e and Continuous Growth',
  'number-e-continuous-growth',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# The Number e and Continuous Growth\n\n## Where Does e Come From?\n\nImagine compounding interest more and more frequently:\n\n| Compounding | Formula | Value (CHF 1 at 100% for 1 year) |\n|-------------|---------|----------------------------------|\n| Yearly | $(1 + 1)^1$ | 2.000 |\n| Semi-annually | $(1 + 0.5)^2$ | 2.250 |\n| Quarterly | $(1 + 0.25)^4$ | 2.441 |\n| Monthly | $(1 + 1/12)^{12}$ | 2.613 |\n| Daily | $(1 + 1/365)^{365}$ | 2.714 |\n| Hourly | $(1 + 1/8760)^{8760}$ | 2.718 |\n\n---\n\n## Defining e\n\n:::concept{title=\"Euler''s Number\"}\n$$e = \\lim_{n \\to \\infty} \\left(1 + \\frac{1}{n}\\right)^n \\approx 2.71828...$$\n\nAs compounding becomes infinitely frequent, the growth factor approaches e.\n:::\n\n---\n\n## Continuous Compounding Formula\n\n$$A = Pe^{rt}$$\n\nWhere:\n- A = Final amount\n- P = Principal (initial amount)\n- e ≈ 2.71828\n- r = Annual interest rate (decimal)\n- t = Time in years\n\n---\n\n## Example: Comparing Compounding Methods\n\nCHF 10,000 at 5% for 3 years:\n\n| Method | Formula | Final Amount |\n|--------|---------|---------------|\n| Annual | $10000(1.05)^3$ | CHF 11,576.25 |\n| Monthly | $10000(1 + 0.05/12)^{36}$ | CHF 11,614.72 |\n| Continuous | $10000 \\cdot e^{0.05 \\times 3}$ | CHF 11,618.34 |\n\n:::tip{title=\"Key Insight\"}\nContinuous compounding gives the highest return, but the difference is often small.\n:::\n\n---\n\n## Calculating with Your Calculator\n\n### To find $e^{0.15}$:\n1. Enter 0.15\n2. Press $e^x$ button (often 2nd + LN)\n3. Result: 1.1618\n\n### Or use: $e^x = e^x$\n- Most scientific calculators have an $e^x$ function\n\n---\n\n## Continuous Growth Rate\n\nIf an investment grows continuously at rate r:\n- After t years: $A = Pe^{rt}$\n- Growth rate per year: $e^r - 1$\n\n### Example\n6% continuous rate:\n- Effective annual rate = $e^{0.06} - 1 = 1.0618 - 1 = 6.18\\%$\n\n---\n\n## Natural Logarithm Connection\n\nThe natural logarithm (ln) is the inverse of $e^x$:\n\n$$\\ln(e^x) = x$$\n$$e^{\\ln(x)} = x$$\n\nThis is crucial for solving continuous growth problems.\n\n---\n\n:::takeaways\n- e ≈ 2.71828 is the limit of frequent compounding\n- Continuous compounding: $A = Pe^{rt}$\n- e and ln are inverse functions\n- Continuous gives slightly more than any discrete compounding\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.7.2: Solving Continuous Growth Problems
(
  'b0400000-0000-0000-0007-000000000002',
  NULL,
  '4.7.2',
  31,
  'Solving Continuous Growth Problems',
  'solving-continuous-growth',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Solving Continuous Growth Problems\n\n## Four Types of Problems\n\nWith $A = Pe^{rt}$, we can solve for any variable:\n\n| Find | Given | Method |\n|------|-------|--------|\n| A | P, r, t | Direct calculation |\n| P | A, r, t | Divide by $e^{rt}$ |\n| t | P, A, r | Use natural log |\n| r | P, A, t | Use natural log |\n\n---\n\n## Finding Future Value (A)\n\n### Example\nCHF 5,000 at 4% continuous for 8 years.\n\n$$A = 5000 \\cdot e^{0.04 \\times 8} = 5000 \\cdot e^{0.32}$$\n$$A = 5000 \\times 1.3771 = CHF 6,885.50$$\n\n---\n\n## Finding Present Value (P)\n\nRearrange: $P = \\frac{A}{e^{rt}} = Ae^{-rt}$\n\n### Example\nHow much to invest now for CHF 20,000 in 6 years at 5% continuous?\n\n$$P = 20000 \\cdot e^{-0.05 \\times 6} = 20000 \\cdot e^{-0.30}$$\n$$P = 20000 \\times 0.7408 = CHF 14,816$$\n\n---\n\n## Finding Time (t)\n\nStart with: $A = Pe^{rt}$\n\nSolve:\n$$\\frac{A}{P} = e^{rt}$$\n$$\\ln\\left(\\frac{A}{P}\\right) = rt$$\n$$t = \\frac{\\ln(A/P)}{r}$$\n\n### Example\nHow long for CHF 10,000 to grow to CHF 15,000 at 6% continuous?\n\n$$t = \\frac{\\ln(15000/10000)}{0.06} = \\frac{\\ln(1.5)}{0.06} = \\frac{0.4055}{0.06} = 6.76 \\text{ years}$$\n\n---\n\n## Finding Rate (r)\n\n$$r = \\frac{\\ln(A/P)}{t}$$\n\n### Example\nAn investment grew from CHF 8,000 to CHF 12,000 in 5 years. What continuous rate?\n\n$$r = \\frac{\\ln(12000/8000)}{5} = \\frac{\\ln(1.5)}{5} = \\frac{0.4055}{5} = 0.0811 = 8.11\\%$$\n\n---\n\n## Doubling Time Formula\n\nFor continuous compounding, doubling time:\n\n$$t_{double} = \\frac{\\ln(2)}{r} = \\frac{0.693}{r}$$\n\n### Example\nAt 7% continuous rate:\n$$t_{double} = \\frac{0.693}{0.07} = 9.9 \\text{ years}$$\n\n:::tip{title=\"Compare to Rule of 72\"}\nRule of 72 gives: 72/7 = 10.3 years\nThe ln(2)/r formula is more precise.\n:::\n\n---\n\n## Decay Applications\n\nFor decay (decreasing), use negative rate:\n\n$$A = Pe^{-rt}$$\n\n### Example: Depreciation\nAsset depreciates continuously at 15% per year.\nValue after 3 years if original is CHF 50,000:\n\n$$A = 50000 \\cdot e^{-0.15 \\times 3} = 50000 \\cdot e^{-0.45} = 50000 \\times 0.6376 = CHF 31,880$$\n\n---\n\n:::takeaways\n- For A: $A = Pe^{rt}$\n- For P: $P = Ae^{-rt}$\n- For t: $t = \\ln(A/P)/r$\n- For r: $r = \\ln(A/P)/t$\n- Doubling time: $t = 0.693/r$\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.7.3: Continuous Compounding Quiz
(
  'b0400000-0000-0000-0007-000000000003',
  NULL,
  '4.7.3',
  32,
  'Continuous Compounding Practice',
  'continuous-compounding-practice',
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
        "question": "The number e is approximately:",
        "options": ["2.718", "3.142", "1.414", "2.303"],
        "correct": 0,
        "explanation": "e ≈ 2.71828... It is the base of natural logarithms."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "CHF 1,000 at 8% continuous for 5 years. Find final amount.",
        "options": ["CHF 1,492", "CHF 1,469", "CHF 1,400", "CHF 1,500"],
        "correct": 0,
        "explanation": "A = 1000 x e^(0.08 x 5) = 1000 x e^0.4 = 1000 x 1.4918 = CHF 1,492"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What amount now will grow to CHF 50,000 in 10 years at 4% continuous?",
        "options": ["CHF 33,516", "CHF 34,500", "CHF 32,000", "CHF 37,000"],
        "correct": 0,
        "explanation": "P = 50000 x e^(-0.04 x 10) = 50000 x e^(-0.4) = 50000 x 0.6703 = CHF 33,516"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "How long for money to triple at 9% continuous rate?",
        "options": ["12.2 years", "8 years", "33.3 years", "11.1 years"],
        "correct": 0,
        "explanation": "t = ln(3)/0.09 = 1.0986/0.09 = 12.2 years"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Continuous compounding always yields more interest than monthly compounding at the same nominal rate.",
        "correct": true,
        "explanation": "True! Continuous is the theoretical maximum - more frequent compounding always yields more interest."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "An investment grew from CHF 6,000 to CHF 9,000 in 4 years. What is the continuous rate?",
        "options": ["10.14%", "12.5%", "8.66%", "11.25%"],
        "correct": 0,
        "explanation": "r = ln(9000/6000)/4 = ln(1.5)/4 = 0.4055/4 = 0.1014 = 10.14%"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 4.7.4: Continuous vs Discrete Compounding Interactive
(
  'b0400000-0000-0000-0007-000000000004',
  NULL,
  '4.7.4',
  33,
  'Compounding Comparison Matcher',
  'compounding-comparison-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each continuous compounding formula or concept with its correct description or result.",
    "pairs": [
      {"left": "A = Pe^(rt)", "right": "Continuous compounding formula"},
      {"left": "e ≈ 2.718", "right": "Base of natural logarithm"},
      {"left": "t = ln(A/P)/r", "right": "Time to reach target amount"},
      {"left": "t = 0.693/r", "right": "Continuous doubling time"},
      {"left": "e^(0.10) - 1", "right": "Effective annual rate at 10% continuous"},
      {"left": "A = Pe^(-rt)", "right": "Continuous decay formula"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 4.7.5: Continuous Compounding Checkpoint
(
  'b0400000-0000-0000-0007-000000000005',
  NULL,
  '4.7.5',
  34,
  'Continuous Compounding Checkpoint',
  'continuous-compounding-checkpoint',
  'checkpoint',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Calculate: e^(0.06 x 2) =",
        "options": ["1.127", "1.12", "0.127", "2.12"],
        "correct": 0,
        "explanation": "e^0.12 ≈ 1.1275"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "CHF 25,000 at 5% continuous. Balance after 4 years?",
        "options": ["CHF 30,546", "CHF 30,000", "CHF 31,000", "CHF 28,500"],
        "correct": 0,
        "explanation": "A = 25000 x e^(0.05 x 4) = 25000 x e^0.2 = 25000 x 1.2214 = CHF 30,535 ≈ CHF 30,546"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Doubling time at 6% continuous rate is approximately:",
        "options": ["11.6 years", "12 years", "10 years", "8.3 years"],
        "correct": 0,
        "explanation": "t = ln(2)/0.06 = 0.693/0.06 = 11.55 ≈ 11.6 years"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "A car depreciates continuously at 12% per year. Value of CHF 40,000 car after 2 years?",
        "options": ["CHF 31,472", "CHF 30,976", "CHF 35,200", "CHF 32,000"],
        "correct": 0,
        "explanation": "A = 40000 x e^(-0.12 x 2) = 40000 x e^(-0.24) = 40000 x 0.7866 = CHF 31,464 ≈ 31,472"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "The relationship between e and ln is:",
        "options": ["They are inverse functions", "They are equal", "ln(e) = 0", "e^x = x"],
        "correct": 0,
        "explanation": "e^x and ln(x) are inverse functions: ln(e^x) = x and e^(ln(x)) = x"
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

-- Continuous Compounding Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0400000-0000-0000-0007-000000000001', 'c0000000-0000-0000-0004-000000000007', true, 1, true, true, 1.0),
('b0400000-0000-0000-0007-000000000002', 'c0000000-0000-0000-0004-000000000007', true, 2, true, true, 1.0),
('b0400000-0000-0000-0007-000000000003', 'c0000000-0000-0000-0004-000000000007', true, 3, true, true, 1.0),
('b0400000-0000-0000-0007-000000000004', 'c0000000-0000-0000-0004-000000000007', true, 4, true, true, 1.0),
('b0400000-0000-0000-0007-000000000005', 'c0000000-0000-0000-0004-000000000007', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

