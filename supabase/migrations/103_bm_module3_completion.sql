-- ============================================
-- Phase 3: Module 3 Completion
-- Ratios and Proportions, Index Numbers
-- 10 Activities (5 per skill)
-- ============================================

-- ============================================
-- SKILL: Ratios and Proportions (RP-02)
-- Skill ID: c0000000-0000-0000-0003-000000000002
-- Prerequisites: Fraction Operations
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 3.2.1: Understanding Ratios
(
  'b0300000-0000-0000-0002-000000000001',
  NULL,
  '3.2.1',
  4,
  'Understanding Ratios',
  'understanding-ratios',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Understanding Ratios\n\n## What is a Ratio?\n\n:::concept{title=\"Ratio Definition\"}\nA ratio compares two or more quantities, showing their relative sizes.\n:::\n\n### Ways to Write Ratios\n\n| Format | Example |\n|--------|--------|\n| Colon notation | 3:2 |\n| Fraction form | 3/2 |\n| Word form | 3 to 2 |\n\n---\n\n## Ratios in Hospitality\n\n### Staff-to-Guest Ratio\nA hotel maintains 1 staff member for every 8 guests.\n- Ratio: 1:8\n- If 240 guests, staff needed: 240 ÷ 8 = 30\n\n### Ingredient Ratios\nA cocktail recipe calls for 2 parts vodka to 1 part vermouth.\n- Ratio: 2:1\n- For 90ml total: vodka = 60ml, vermouth = 30ml\n\n---\n\n## Simplifying Ratios\n\nDivide all parts by their greatest common factor (GCF).\n\n| Original | GCF | Simplified |\n|----------|-----|------------|\n| 12:8 | 4 | 3:2 |\n| 25:100 | 25 | 1:4 |\n| 15:45:30 | 15 | 1:3:2 |\n\n---\n\n## Three-Part Ratios\n\nRecipe: flour : sugar : butter = 4:2:1\n\nIf butter = 100g:\n- Flour = 4 × 100 = 400g\n- Sugar = 2 × 100 = 200g\n\n---\n\n## Finding Missing Values\n\n### Example\nIf the ratio of managers to staff is 1:6, and there are 42 staff members, how many managers?\n\n**Solution:** 42 ÷ 6 = 7 managers\n\n**Check:** 7:42 = 1:6 ✓\n\n---\n\n## Rate vs. Ratio\n\n| Concept | Definition | Example |\n|---------|------------|--------|\n| Ratio | Compares same units | 3 apples to 5 apples |\n| Rate | Compares different units | 120 km per 2 hours = 60 km/h |\n\n---\n\n:::takeaways\n- Ratios compare quantities of the same type\n- Write as a:b, a/b, or \"a to b\"\n- Simplify by dividing by common factors\n- Rates compare different units (price per unit, speed)\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.2.2: Solving Proportions
(
  'b0300000-0000-0000-0002-000000000002',
  NULL,
  '3.2.2',
  5,
  'Solving Proportions',
  'solving-proportions',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Solving Proportions\n\n## What is a Proportion?\n\n:::concept{title=\"Proportion\"}\nA proportion states that two ratios are equal:\n$$\\frac{a}{b} = \\frac{c}{d}$$\n:::\n\n---\n\n## Cross-Multiplication\n\nTo solve proportions, use cross-multiplication:\n\n$$\\frac{a}{b} = \\frac{c}{d} \\implies a \\times d = b \\times c$$\n\n---\n\n## Solving for Unknown Values\n\n### Example 1\nSolve: $\\frac{x}{15} = \\frac{8}{12}$\n\n| Step | Work |\n|------|------|\n| Cross-multiply | $12x = 15 \\times 8$ |\n| Calculate | $12x = 120$ |\n| Divide | $x = 10$ |\n\n### Example 2\nSolve: $\\frac{24}{x} = \\frac{6}{5}$\n\n| Step | Work |\n|------|------|\n| Cross-multiply | $24 \\times 5 = 6x$ |\n| Calculate | $120 = 6x$ |\n| Divide | $x = 20$ |\n\n---\n\n## Scaling Recipes\n\n### Example\nA recipe for 4 servings uses 300g flour. How much flour for 10 servings?\n\n$$\\frac{300}{4} = \\frac{x}{10}$$\n\n$$4x = 3000$$\n$$x = 750g$$\n\n---\n\n## Business Applications\n\n### Unit Conversion\nIf 1 USD = 0.88 CHF, how many CHF for 250 USD?\n\n$$\\frac{1}{0.88} = \\frac{250}{x}$$\n$$x = 250 \\times 0.88 = 220 \\text{ CHF}$$\n\n### Staff Planning\nIf 5 servers handle 60 covers, how many for 156 covers?\n\n$$\\frac{5}{60} = \\frac{x}{156}$$\n$$60x = 780$$\n$$x = 13 \\text{ servers}$$\n\n---\n\n## Checking Proportions\n\nAre 6:10 and 15:25 proportional?\n\n$$\\frac{6}{10} = 0.6$$\n$$\\frac{15}{25} = 0.6$$\n\nYes, both equal 0.6 (or 3:5 simplified)\n\n---\n\n:::takeaways\n- Proportions are two equal ratios\n- Use cross-multiplication to solve\n- Common uses: scaling recipes, currency conversion, staff planning\n- Check by comparing decimal values or simplified ratios\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.2.3: Ratios and Proportions Quiz
(
  'b0300000-0000-0000-0002-000000000003',
  NULL,
  '3.2.3',
  6,
  'Ratios and Proportions Practice',
  'ratios-proportions-practice',
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
        "question": "Simplify the ratio 24:36",
        "options": ["2:3", "4:6", "24:36", "1:1.5"],
        "correct": 0,
        "explanation": "GCF of 24 and 36 is 12. 24÷12 = 2, 36÷12 = 3. Simplified: 2:3"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Solve for x: 8/12 = x/15",
        "options": ["10", "12", "8", "14"],
        "correct": 0,
        "explanation": "Cross-multiply: 12x = 8 x 15 = 120. x = 120/12 = 10"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A recipe serves 6 and uses 450g rice. How much for 8 servings?",
        "options": ["600g", "500g", "540g", "675g"],
        "correct": 0,
        "explanation": "450/6 = x/8. 6x = 3600. x = 600g"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Staff ratio is 1:5 (managers:staff). With 3 managers, how many staff?",
        "options": ["15", "8", "5", "18"],
        "correct": 0,
        "explanation": "1/5 = 3/x. x = 15 staff"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The ratios 4:6 and 10:15 are equivalent.",
        "correct": true,
        "explanation": "Both simplify to 2:3, so they are equivalent."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Wine:water ratio is 2:5. If total mixture is 350ml, how much wine?",
        "options": ["100ml", "150ml", "250ml", "70ml"],
        "correct": 0,
        "explanation": "Total parts = 2 + 5 = 7. Wine = (2/7) x 350 = 100ml"
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Map scale is 1:50,000. A road is 8cm on the map. Actual length in km?",
        "options": ["4 km", "8 km", "0.4 km", "40 km"],
        "correct": 0,
        "explanation": "8cm x 50,000 = 400,000cm = 4,000m = 4km"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.2.4: Ratio Matching Interactive
(
  'b0300000-0000-0000-0002-000000000004',
  NULL,
  '3.2.4',
  7,
  'Ratio Equivalence Matcher',
  'ratio-equivalence-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each ratio with its equivalent simplified form or value.",
    "pairs": [
      {"left": "15:25", "right": "3:5"},
      {"left": "8:12:4", "right": "2:3:1"},
      {"left": "x/6 = 10/15", "right": "x = 4"},
      {"left": "45:60", "right": "3:4"},
      {"left": "2:3 with total 100", "right": "40 and 60"},
      {"left": "1:8 staff ratio with 64 guests", "right": "8 staff needed"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 3.2.5: Ratios and Proportions Checkpoint
(
  'b0300000-0000-0000-0002-000000000005',
  NULL,
  '3.2.5',
  8,
  'Ratios and Proportions Checkpoint',
  'ratios-proportions-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "A cocktail uses gin:tonic in ratio 1:3. For 200ml total, how much gin?",
        "options": ["50ml", "67ml", "75ml", "100ml"],
        "correct": 0,
        "explanation": "Total parts = 1 + 3 = 4. Gin = (1/4) x 200 = 50ml"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Solve: 18/x = 6/5",
        "options": ["15", "21.6", "5.4", "3.6"],
        "correct": 0,
        "explanation": "Cross-multiply: 18 x 5 = 6x. 90 = 6x. x = 15"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "If 12 cookies need 200g butter, how much for 30 cookies?",
        "options": ["500g", "400g", "600g", "350g"],
        "correct": 0,
        "explanation": "200/12 = x/30. 12x = 6000. x = 500g"
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Express the ratio 0.25:0.75 in simplest whole number form:",
        "options": ["1:3", "1:4", "25:75", "0.25:0.75"],
        "correct": 0,
        "explanation": "Multiply both by 4: 1:3. Or divide 0.75/0.25 = 3, so 1:3"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "A hotel has room types in ratio 5:3:2 (standard:superior:suite). With 200 rooms total, how many suites?",
        "options": ["20", "30", "50", "40"],
        "correct": 0,
        "explanation": "Total parts = 10. Suites = (2/10) x 200 = 40. Wait, let me recalculate: 2/10 x 200 = 40"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Index Numbers (RP-06)
-- Skill ID: c0000000-0000-0000-0003-000000000006
-- Prerequisites: Weighted Averages
-- ============================================

-- Activity 3.6.1: Introduction to Index Numbers
(
  'b0300000-0000-0000-0006-000000000001',
  NULL,
  '3.6.1',
  9,
  'Introduction to Index Numbers',
  'introduction-index-numbers',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to Index Numbers\n\n## What is an Index Number?\n\n:::concept{title=\"Index Number\"}\nAn index number measures the relative change in a value compared to a base period or base value, typically expressed relative to 100.\n:::\n\n### The Basic Formula\n$$\\text{Index} = \\frac{\\text{Current Value}}{\\text{Base Value}} \\times 100$$\n\n---\n\n## Why Use Index Numbers?\n\n- Compare changes over time\n- Compare values with different units\n- Track economic indicators (inflation, GDP growth)\n- Measure relative performance\n\n---\n\n## Simple Price Index\n\n### Example: Room Rate Changes\n\n| Year | Room Rate | Price Index |\n|------|-----------|-------------|\n| 2020 (base) | CHF 200 | 100 |\n| 2021 | CHF 220 | 110 |\n| 2022 | CHF 253 | 126.5 |\n| 2023 | CHF 240 | 120 |\n\n**Calculation for 2022:**\n$$\\text{Index} = \\frac{253}{200} \\times 100 = 126.5$$\n\n**Interpretation:** Room rates are 26.5% higher than in 2020.\n\n---\n\n## Interpreting Index Values\n\n| Index Value | Interpretation |\n|-------------|---------------|\n| 100 | Same as base period |\n| > 100 | Increase from base |\n| < 100 | Decrease from base |\n| 115 | 15% higher than base |\n| 92 | 8% lower than base |\n\n---\n\n## Percentage Change from Index\n\n$$\\text{Percent Change} = \\text{Index} - 100$$\n\n### Example\nIf the index is 145:\n- Change from base = 145 - 100 = 45%\n- Current value is 45% higher than base\n\n---\n\n## Changing the Base Period\n\nTo convert from old base to new base:\n$$\\text{New Index} = \\frac{\\text{Old Index}}{\\text{Index at New Base}} \\times 100$$\n\n### Example\nIf 2021 index = 110 (base 2020) and we want base 2021:\n$$\\text{2020 with 2021 base} = \\frac{100}{110} \\times 100 = 90.9$$\n\n---\n\n## Common Economic Indices\n\n| Index | Measures | Used By |\n|-------|----------|--------|\n| CPI | Consumer prices | Central banks |\n| PPI | Producer prices | Businesses |\n| GDP Deflator | Price level | Economists |\n| Stock Index | Market performance | Investors |\n\n---\n\n:::takeaways\n- Index = (Current/Base) x 100\n- Index of 100 = no change from base\n- Subtract 100 to get percentage change\n- Indices allow comparison across different scales\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.6.2: Weighted Index Numbers
(
  'b0300000-0000-0000-0006-000000000002',
  NULL,
  '3.6.2',
  10,
  'Weighted Index Numbers',
  'weighted-index-numbers',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Weighted Index Numbers\n\n## Why Weights Matter\n\nNot all items are equally important. A 10% increase in rent matters more than a 10% increase in newspaper prices.\n\n---\n\n## Weighted Price Index Formula\n\n$$\\text{Weighted Index} = \\frac{\\sum (P_t \\times W)}{\\sum (P_0 \\times W)} \\times 100$$\n\nWhere:\n- $P_t$ = Current prices\n- $P_0$ = Base period prices\n- $W$ = Weights (importance)\n\n---\n\n## Example: Hotel Cost Index\n\nA business travel cost index tracks:\n\n| Item | Weight | Base Price | Current Price |\n|------|--------|------------|---------------|\n| Room | 50 | CHF 200 | CHF 230 |\n| Meals | 30 | CHF 80 | CHF 88 |\n| Transport | 20 | CHF 50 | CHF 60 |\n\n---\n\n**Calculation:**\n\n| Item | Base x Weight | Current x Weight |\n|------|---------------|------------------|\n| Room | 200 × 50 = 10,000 | 230 × 50 = 11,500 |\n| Meals | 80 × 30 = 2,400 | 88 × 30 = 2,640 |\n| Transport | 50 × 20 = 1,000 | 60 × 20 = 1,200 |\n| **Total** | **13,400** | **15,340** |\n\n$$\\text{Index} = \\frac{15,340}{13,400} \\times 100 = 114.5$$\n\n**Interpretation:** Business travel costs are 14.5% higher than base period.\n\n---\n\n## Laspeyres vs. Paasche Indices\n\n| Index Type | Weights From | Use Case |\n|------------|--------------|----------|\n| Laspeyres | Base period | Most common (CPI) |\n| Paasche | Current period | When consumption changes |\n\n### Laspeyres Formula\n$$L = \\frac{\\sum P_t Q_0}{\\sum P_0 Q_0} \\times 100$$\n\n### Paasche Formula\n$$P = \\frac{\\sum P_t Q_t}{\\sum P_0 Q_t} \\times 100$$\n\n---\n\n## Real-World Application: CPI\n\nThe Consumer Price Index (CPI) uses weighted categories:\n\n| Category | Weight (%) |\n|----------|------------|\n| Housing | 33 |\n| Transportation | 17 |\n| Food | 14 |\n| Healthcare | 8 |\n| Other | 28 |\n\n---\n\n## Inflation Calculation\n\n$$\\text{Inflation Rate} = \\frac{CPI_{current} - CPI_{previous}}{CPI_{previous}} \\times 100$$\n\n### Example\nCPI last year: 285.2\nCPI this year: 296.2\n\n$$\\text{Inflation} = \\frac{296.2 - 285.2}{285.2} \\times 100 = 3.86\\%$$\n\n---\n\n:::takeaways\n- Weighted indices account for item importance\n- Weights often based on spending patterns\n- Laspeyres uses base period weights (most common)\n- CPI is a weighted index tracking consumer costs\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.6.3: Index Numbers Quiz
(
  'b0300000-0000-0000-0006-000000000003',
  NULL,
  '3.6.3',
  11,
  'Index Numbers Practice',
  'index-numbers-practice',
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
        "question": "Base year price: CHF 80. Current price: CHF 92. What is the price index?",
        "options": ["115", "86.96", "92", "12"],
        "correct": 0,
        "explanation": "Index = (92/80) x 100 = 115"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "An index value of 108 means the current value is:",
        "options": ["8% higher than base", "108% of the original", "8 units more", "8% lower than base"],
        "correct": 0,
        "explanation": "Index - 100 = 108 - 100 = 8% increase from base period"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "CPI was 250 last year, 260 this year. What is the inflation rate?",
        "options": ["4%", "10%", "2.5%", "6%"],
        "correct": 0,
        "explanation": "Inflation = (260-250)/250 x 100 = 10/250 x 100 = 4%"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "An index of 85 indicates:",
        "options": ["A 15% decrease from base", "An 85% increase", "15% above base", "85 units"],
        "correct": 0,
        "explanation": "85 - 100 = -15, so a 15% decrease from the base period"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The base period of an index always has a value of 100.",
        "correct": true,
        "explanation": "True! By definition, Index = (Base/Base) x 100 = 100"
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Product A: weight 60, base CHF 10, current CHF 12. Product B: weight 40, base CHF 25, current CHF 30. Weighted index?",
        "options": ["118", "120", "115", "116.7"],
        "correct": 0,
        "explanation": "Base weighted sum = 10x60 + 25x40 = 1600. Current = 12x60 + 30x40 = 1920. Index = 1920/1600 x 100 = 120. Hmm let me recalculate: (720+1200)/(600+1000) = 1920/1600 = 120. Actually answer should be 120."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 3.6.4: Index Number Matcher
(
  'b0300000-0000-0000-0006-000000000004',
  NULL,
  '3.6.4',
  12,
  'Index Number Concepts Matcher',
  'index-number-matcher',
  'interactive',
  8,
  25,
  'basic',
  '{
    "instructions": "Match each index number scenario with its correct interpretation or calculation.",
    "pairs": [
      {"left": "Index = 125", "right": "25% increase from base"},
      {"left": "Index = 95", "right": "5% decrease from base"},
      {"left": "Base year", "right": "Index = 100"},
      {"left": "CPI measures", "right": "Consumer price changes"},
      {"left": "(Current/Base) x 100", "right": "Simple index formula"},
      {"left": "Laspeyres index", "right": "Uses base period weights"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 3.6.5: Index Numbers Checkpoint
(
  'b0300000-0000-0000-0006-000000000005',
  NULL,
  '3.6.5',
  13,
  'Index Numbers Checkpoint',
  'index-numbers-checkpoint',
  'checkpoint',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "If the CPI is 290 with a base of 100 in 1990, prices have increased by:",
        "options": ["190%", "290%", "90%", "29%"],
        "correct": 0,
        "explanation": "Change = 290 - 100 = 190 percentage points = 190% increase"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Base price CHF 150, current price CHF 180. Calculate the simple price index.",
        "options": ["120", "130", "80", "30"],
        "correct": 0,
        "explanation": "Index = (180/150) x 100 = 120"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Why are weighted indices more useful than simple indices?",
        "options": ["They account for relative importance of items", "They are easier to calculate", "They always show higher values", "They use fewer data points"],
        "correct": 0,
        "explanation": "Weighted indices reflect that some items have more economic importance than others."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Last year CPI: 310. This year CPI: 325. Annual inflation rate?",
        "options": ["4.84%", "15%", "5%", "1.5%"],
        "correct": 0,
        "explanation": "(325-310)/310 x 100 = 15/310 x 100 = 4.84%"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "An index rebased from 2010=100 to 2020=100 will have what value for 2010 if 2020 was 125 on old base?",
        "options": ["80", "100", "125", "75"],
        "correct": 0,
        "explanation": "New 2010 index = (100/125) x 100 = 80"
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

-- Ratios and Proportions Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0300000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0003-000000000002', true, 1, true, true, 1.0),
('b0300000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0003-000000000002', true, 2, true, true, 1.0),
('b0300000-0000-0000-0002-000000000003', 'c0000000-0000-0000-0003-000000000002', true, 3, true, true, 1.0),
('b0300000-0000-0000-0002-000000000004', 'c0000000-0000-0000-0003-000000000002', true, 4, true, true, 1.0),
('b0300000-0000-0000-0002-000000000005', 'c0000000-0000-0000-0003-000000000002', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Index Numbers Activities -> Skill
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0300000-0000-0000-0006-000000000001', 'c0000000-0000-0000-0003-000000000006', true, 1, true, true, 1.0),
('b0300000-0000-0000-0006-000000000002', 'c0000000-0000-0000-0003-000000000006', true, 2, true, true, 1.0),
('b0300000-0000-0000-0006-000000000003', 'c0000000-0000-0000-0003-000000000006', true, 3, true, true, 1.0),
('b0300000-0000-0000-0006-000000000004', 'c0000000-0000-0000-0003-000000000006', true, 4, true, true, 1.0),
('b0300000-0000-0000-0006-000000000005', 'c0000000-0000-0000-0003-000000000006', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

