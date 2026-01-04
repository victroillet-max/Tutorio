-- ============================================
-- Module 4: Exponents and Logarithms Activities  
-- Key Skills: Exponent Rules, Compound Interest, Time Value of Money
-- ============================================

-- ============================================
-- SKILL: Exponent Rules (EL-01)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

(
  'b0400000-0000-0000-0001-000000000001',
  'b0000000-0000-0000-0000-000000000004',
  '4.1.1',
  1,
  'Mastering Exponent Rules',
  'mastering-exponent-rules',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Mastering Exponent Rules\n\n## What is an Exponent?\n\n$$a^n = a × a × a × ... × a \\text{ (n times)}$$\n\n- **Base**: The number being multiplied (a)\n- **Exponent**: How many times to multiply (n)\n\n---\n\n## The Seven Exponent Rules\n\n### 1. Product Rule\n$$a^m × a^n = a^{m+n}$$\n\nExample: $2^3 × 2^4 = 2^7 = 128$\n\n### 2. Quotient Rule\n$$\\frac{a^m}{a^n} = a^{m-n}$$\n\nExample: $\\frac{5^6}{5^2} = 5^4 = 625$\n\n### 3. Power Rule\n$$(a^m)^n = a^{m×n}$$\n\nExample: $(3^2)^4 = 3^8 = 6561$\n\n### 4. Product to Power\n$$(ab)^n = a^n × b^n$$\n\nExample: $(2×5)^3 = 2^3 × 5^3 = 8 × 125 = 1000$\n\n### 5. Quotient to Power\n$$\\left(\\frac{a}{b}\\right)^n = \\frac{a^n}{b^n}$$\n\n### 6. Zero Exponent\n$$a^0 = 1 \\text{ (for a ≠ 0)}$$\n\n### 7. Negative Exponent\n$$a^{-n} = \\frac{1}{a^n}$$\n\n---\n\n## Examples with Solutions\n\n| Expression | Steps | Answer |\n|------------|-------|--------|\n| $3^2 × 3^5$ | Add exponents | $3^7 = 2187$ |\n| $\\frac{x^8}{x^3}$ | Subtract exponents | $x^5$ |\n| $(4^2)^3$ | Multiply exponents | $4^6 = 4096$ |\n| $5^{-2}$ | Take reciprocal | $\\frac{1}{25}$ |\n| $7^0$ | Any nonzero to 0 | $1$ |\n\n---\n\n## Business Applications\n\n### Compound Growth\nIf a quantity grows by factor r each period:\n$$\\text{After n periods} = \\text{Initial} × r^n$$\n\n### Example\nPopulation doubles every year. After 5 years:\n$$\\text{Population} = P_0 × 2^5 = 32 × P_0$$\n\n---\n\n:::takeaways\n- Product rule: Add exponents when multiplying same base\n- Quotient rule: Subtract exponents when dividing\n- Power rule: Multiply exponents for power of a power\n- Negative exponent means reciprocal\n- Any nonzero number to the power 0 equals 1\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0400000-0000-0000-0001-000000000002',
  'b0000000-0000-0000-0000-000000000004',
  '4.1.2',
  2,
  'Exponent Rules Quiz',
  'exponent-rules-quiz',
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
        "question": "Simplify: 2^3 x 2^4",
        "options": ["2^7 = 128", "2^12", "4^7", "2^3"],
        "correct": 0,
        "explanation": "Product rule: add exponents. 2^(3+4) = 2^7 = 128"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is 4^(-2)?",
        "options": ["1/16", "-16", "-8", "1/8"],
        "correct": 0,
        "explanation": "4^(-2) = 1/4^2 = 1/16"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Simplify: (x^3)^4",
        "options": ["x^12", "x^7", "x^64", "4x^3"],
        "correct": 0,
        "explanation": "Power rule: multiply exponents. x^(3×4) = x^12"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Simplify: x^5 / x^2",
        "options": ["x^3", "x^7", "x^10", "x^2.5"],
        "correct": 0,
        "explanation": "Quotient rule: subtract exponents. x^(5-2) = x^3"
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Simplify: (2^3 x 3^3) / 6",
        "options": ["36", "6", "216", "72"],
        "correct": 0,
        "explanation": "2^3 x 3^3 = 8 x 27 = 216. Then 216/6 = 36"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0400000-0000-0000-0001-000000000003',
  'b0000000-0000-0000-0000-000000000004',
  '4.1.3',
  3,
  'Exponent Rules Checkpoint',
  'exponent-rules-checkpoint',
  'checkpoint',
  8,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "What is 10^0?",
        "options": ["1", "0", "10", "Undefined"],
        "correct": 0,
        "explanation": "Any nonzero number to the power 0 equals 1."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Simplify: (a^2b^3)^2",
        "options": ["a^4b^6", "a^4b^5", "a^2b^6", "2a^2b^3"],
        "correct": 0,
        "explanation": "Distribute the exponent: a^(2×2)b^(3×2) = a^4b^6"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "What is 8^(1/3)?",
        "options": ["2", "8/3", "24", "2.67"],
        "correct": 0,
        "explanation": "8^(1/3) is the cube root of 8, which is 2."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Simplify: 3^(-1) x 3^4",
        "options": ["3^3 = 27", "3^(-4)", "3^5", "1/81"],
        "correct": 0,
        "explanation": "Add exponents: 3^(-1+4) = 3^3 = 27"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Compound Interest (EL-06)
-- ============================================

(
  'b0400000-0000-0000-0006-000000000001',
  'b0000000-0000-0000-0000-000000000004',
  '4.6.1',
  4,
  'Understanding Compound Interest',
  'understanding-compound-interest',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Understanding Compound Interest\n\n## Simple vs. Compound Interest\n\n| Type | Interest Earned On |\n|------|-------------------|\n| Simple | Original principal only |\n| Compound | Principal + accumulated interest |\n\n---\n\n## Simple Interest Formula\n\n$$I = P × r × t$$\n$$A = P + I = P(1 + rt)$$\n\nWhere:\n- P = Principal (initial amount)\n- r = Annual interest rate (decimal)\n- t = Time in years\n- A = Final amount\n\n### Example\nCHF 1,000 at 5% simple interest for 3 years:\n$$I = 1000 × 0.05 × 3 = CHF 150$$\n$$A = 1000 + 150 = CHF 1,150$$\n\n---\n\n## Compound Interest Formula\n\n$$A = P\\left(1 + \\frac{r}{n}\\right)^{nt}$$\n\nWhere:\n- n = Compounding frequency per year\n- Other variables same as above\n\n| Compounding | n value |\n|-------------|--------|\n| Annually | 1 |\n| Semi-annually | 2 |\n| Quarterly | 4 |\n| Monthly | 12 |\n| Daily | 365 |\n\n---\n\n## Example: Compound Interest\n\nCHF 1,000 at 5% compounded annually for 3 years:\n\n$$A = 1000\\left(1 + \\frac{0.05}{1}\\right)^{1×3}$$\n$$A = 1000(1.05)^3 = 1000 × 1.157625 = CHF 1,157.63$$\n\n:::concept{title=\"The Power of Compounding\"}\n- Simple interest: CHF 1,150\n- Compound interest: CHF 1,157.63\n- Extra CHF 7.63 from \"interest on interest\"\n:::\n\n---\n\n## Monthly Compounding Example\n\nCHF 10,000 at 6% compounded monthly for 2 years:\n\n$$A = 10000\\left(1 + \\frac{0.06}{12}\\right)^{12×2}$$\n$$A = 10000(1.005)^{24} = 10000 × 1.1272 = CHF 11,272$$\n\n---\n\n## The Rule of 72\n\n:::tip{title=\"Quick Estimate\"}\nTo estimate how long it takes to double your money:\n$$\\text{Years to double} ≈ \\frac{72}{\\text{Interest rate (%)}}$$\n\nAt 6% interest: 72/6 = 12 years to double\n:::\n\n---\n\n:::takeaways\n- Simple interest: I = Prt (interest only on principal)\n- Compound interest: A = P(1 + r/n)^(nt)\n- More frequent compounding = more growth\n- Rule of 72 estimates doubling time\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0400000-0000-0000-0006-000000000002',
  'b0000000-0000-0000-0000-000000000004',
  '4.6.2',
  5,
  'Compound Interest Quiz',
  'compound-interest-quiz',
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
        "question": "CHF 5,000 at 4% simple interest for 2 years. Total interest?",
        "options": ["CHF 400", "CHF 200", "CHF 408", "CHF 500"],
        "correct": 0,
        "explanation": "I = 5000 × 0.04 × 2 = CHF 400"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "CHF 2,000 at 8% compounded annually for 3 years. Final amount?",
        "options": ["CHF 2,519.42", "CHF 2,480.00", "CHF 2,560.00", "CHF 2,500.00"],
        "correct": 0,
        "explanation": "A = 2000(1.08)^3 = 2000 × 1.259712 = CHF 2,519.42"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Using Rule of 72, how long to double at 9% interest?",
        "options": ["8 years", "9 years", "7.2 years", "12 years"],
        "correct": 0,
        "explanation": "72 / 9 = 8 years (approximately)"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which gives more interest: 6% annual or 6% monthly compounding?",
        "options": ["Monthly compounding", "Annual compounding", "They are equal", "Cannot determine"],
        "correct": 0,
        "explanation": "More frequent compounding always yields more interest at the same nominal rate."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "CHF 10,000 at 5% compounded quarterly for 1 year. Final amount?",
        "options": ["CHF 10,509.45", "CHF 10,500.00", "CHF 10,512.00", "CHF 10,525.00"],
        "correct": 0,
        "explanation": "A = 10000(1 + 0.05/4)^4 = 10000(1.0125)^4 = CHF 10,509.45"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0400000-0000-0000-0006-000000000003',
  'b0000000-0000-0000-0000-000000000004',
  '4.6.3',
  6,
  'Compound Interest Checkpoint',
  'compound-interest-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Simple interest on CHF 8,000 at 3.5% for 4 years?",
        "options": ["CHF 1,120", "CHF 280", "CHF 1,166", "CHF 1,000"],
        "correct": 0,
        "explanation": "I = 8000 × 0.035 × 4 = CHF 1,120"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "In the formula A = P(1 + r/n)^(nt), what does n represent?",
        "options": ["Compounding frequency per year", "Number of years", "Interest rate", "Principal"],
        "correct": 0,
        "explanation": "n is how many times per year interest is compounded."
      },
      {
        "id": "cp3",
        "type": "true_false",
        "question": "Compound interest always exceeds simple interest for the same rate and time (assuming t > 1).",
        "correct": true,
        "explanation": "True! Compound interest earns interest on interest, so it grows faster."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "At 12% annual rate, approximately how long to double (Rule of 72)?",
        "options": ["6 years", "12 years", "8 years", "4 years"],
        "correct": 0,
        "explanation": "72 / 12 = 6 years"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Time Value of Money (EL-08)
-- ============================================

(
  'b0400000-0000-0000-0008-000000000001',
  'b0000000-0000-0000-0000-000000000004',
  '4.8.1',
  7,
  'Time Value of Money Concepts',
  'time-value-money-concepts',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Time Value of Money\n\n## The Core Principle\n\n:::concept{title=\"TVM Principle\"}\nA dollar today is worth more than a dollar tomorrow.\n\nWhy? Because today''s dollar can be invested to earn interest.\n:::\n\n---\n\n## Present Value vs. Future Value\n\n| Concept | Question Answered | Direction |\n|---------|-------------------|----------|\n| Future Value (FV) | What will X be worth later? | Forward in time |\n| Present Value (PV) | What is future X worth now? | Backward in time |\n\n---\n\n## Future Value Formula\n\n$$FV = PV × (1 + r)^n$$\n\n### Example\nYou invest CHF 5,000 today at 6% for 10 years.\n$$FV = 5000 × (1.06)^{10} = 5000 × 1.7908 = CHF 8,954$$\n\n---\n\n## Present Value Formula\n\n$$PV = \\frac{FV}{(1 + r)^n}$$\n\n### Example\nYou will receive CHF 10,000 in 5 years. At 8% discount rate, what is it worth today?\n$$PV = \\frac{10000}{(1.08)^5} = \\frac{10000}{1.4693} = CHF 6,806$$\n\n---\n\n## Discount Rate\n\nThe discount rate represents:\n- Opportunity cost of capital\n- Required return\n- Risk adjustment\n\n:::warning{title=\"Key Insight\"}\nHigher discount rate = Lower present value\n\nA risky investment requires higher returns, so future cash flows are worth less today.\n:::\n\n---\n\n## Business Applications\n\n### Investment Decisions\nCompare PV of future cash flows to initial investment.\n\n### Loan Calculations\nDetermine payment amounts based on present value of loan.\n\n### Retirement Planning\nCalculate how much to save today for future goals.\n\n---\n\n:::takeaways\n- Money has time value due to earning potential\n- FV = PV × (1+r)^n (move money forward)\n- PV = FV / (1+r)^n (move money backward)\n- Higher discount rate = lower present value\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'b0400000-0000-0000-0008-000000000002',
  'b0000000-0000-0000-0000-000000000004',
  '4.8.2',
  8,
  'Time Value of Money Quiz',
  'time-value-money-quiz',
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
        "question": "CHF 1,000 invested at 5% for 2 years. Future Value?",
        "options": ["CHF 1,102.50", "CHF 1,100.00", "CHF 1,105.00", "CHF 1,050.00"],
        "correct": 0,
        "explanation": "FV = 1000 × (1.05)^2 = 1000 × 1.1025 = CHF 1,102.50"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Present value of CHF 5,000 in 3 years at 10% discount rate?",
        "options": ["CHF 3,757", "CHF 4,545", "CHF 5,000", "CHF 6,655"],
        "correct": 0,
        "explanation": "PV = 5000 / (1.10)^3 = 5000 / 1.331 = CHF 3,757"
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "A higher discount rate increases the present value of future cash flows.",
        "correct": false,
        "explanation": "False! Higher discount rate = MORE discounting = LOWER present value."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "You need CHF 50,000 in 5 years. At 7%, how much must you invest today?",
        "options": ["CHF 35,653", "CHF 42,500", "CHF 40,000", "CHF 37,500"],
        "correct": 0,
        "explanation": "PV = 50000 / (1.07)^5 = 50000 / 1.4026 = CHF 35,653"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'b0400000-0000-0000-0008-000000000003',
  'b0000000-0000-0000-0000-000000000004',
  '4.8.3',
  9,
  'Time Value of Money Checkpoint',
  'time-value-money-checkpoint',
  'checkpoint',
  10,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Why is CHF 100 today worth more than CHF 100 in one year?",
        "options": ["Today''s money can earn interest", "Inflation only", "Tax reasons", "Exchange rates"],
        "correct": 0,
        "explanation": "Money today can be invested to earn a return, making it worth more than the same amount in the future."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Future value of CHF 2,000 at 8% for 4 years?",
        "options": ["CHF 2,721", "CHF 2,640", "CHF 2,800", "CHF 2,500"],
        "correct": 0,
        "explanation": "FV = 2000 × (1.08)^4 = 2000 × 1.3605 = CHF 2,721"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "The process of finding present value is called:",
        "options": ["Discounting", "Compounding", "Amortizing", "Capitalizing"],
        "correct": 0,
        "explanation": "Discounting is moving future values back to present values."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Which would you prefer: CHF 1,000 today or CHF 1,200 in 2 years (at 8%)?",
        "options": ["CHF 1,000 today", "CHF 1,200 in 2 years", "They are equal", "Cannot determine"],
        "correct": 1,
        "explanation": "PV of CHF 1,200 in 2 years = 1200 / 1.08^2 = CHF 1,029. This exceeds CHF 1,000, so take the future amount."
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

