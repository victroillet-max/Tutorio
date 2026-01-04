-- ============================================
-- Business Mathematics Skill Definitions
-- 42 skills across 8 categories with prerequisites
-- ============================================

-- ============================================
-- Add BM Skill Categories to Enum
-- ============================================

-- Drop ALL dependent functions that use skill_category in return type or parameters
DROP FUNCTION IF EXISTS get_course_skills(UUID, UUID, skill_category) CASCADE;
DROP FUNCTION IF EXISTS get_user_skill_progress(UUID, skill_category) CASCADE;
DROP FUNCTION IF EXISTS get_user_skill_mastery(UUID) CASCADE;
DROP FUNCTION IF EXISTS get_struggling_skills(UUID) CASCADE;
DROP FUNCTION IF EXISTS search_skills(TEXT) CASCADE;
DROP FUNCTION IF EXISTS get_coding_skill_tree(UUID) CASCADE;
DROP FUNCTION IF EXISTS get_course_coding_skills(UUID, UUID) CASCADE;
DROP FUNCTION IF EXISTS get_course_foundations(UUID, UUID) CASCADE;
DROP FUNCTION IF EXISTS get_foundations_progress(UUID) CASCADE;
DROP FUNCTION IF EXISTS get_course_skill_progress(UUID, UUID) CASCADE;

-- First, drop the NOT NULL constraint temporarily
ALTER TABLE skills ALTER COLUMN category DROP NOT NULL;

-- Create new enum with all values (including existing + new math categories)
DROP TYPE IF EXISTS skill_category_new CASCADE;
CREATE TYPE skill_category_new AS ENUM (
  -- Existing CT categories
  'ct_foundations',
  'python_basics',
  'control_flow',
  'data_structures',
  'functions',
  'advanced_topics',
  -- Existing FA categories
  'fa_foundations',
  'balance_sheet',
  'income_statement',
  'adjustments',
  'specialized_assets',
  'cash_flow',
  'financial_analysis',
  -- NEW Business Mathematics categories
  'math_foundations',
  'basic_statistics',
  'ratios_percentages',
  'exponents_logs',
  'equations',
  'functions_graphs',
  'differential_calculus',
  'integral_calculus'
);

-- Update the skills table to use the new enum
ALTER TABLE skills 
  ALTER COLUMN category TYPE skill_category_new 
  USING category::text::skill_category_new;

-- Drop old enum and rename new one
DROP TYPE skill_category;
ALTER TYPE skill_category_new RENAME TO skill_category;

-- Restore the NOT NULL constraint
ALTER TABLE skills ALTER COLUMN category SET NOT NULL;

-- ============================================
-- Math Foundations Skills (4 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- MF-01: Arithmetic Fundamentals
(
  'c0000000-0000-0000-0001-000000000001',
  'bm-arithmetic-fundamentals',
  'Arithmetic Fundamentals',
  'Master operations with integers, decimals, and negative numbers. The essential building blocks for all mathematical operations in business contexts.',
  'math_foundations',
  'Math Foundations',
  1,
  25,
  200
),
-- MF-02: Order of Operations
(
  'c0000000-0000-0000-0001-000000000002',
  'bm-order-of-operations',
  'Order of Operations',
  'Apply PEMDAS/BODMAS rules correctly to evaluate complex expressions. Critical for financial calculations and formula interpretation.',
  'math_foundations',
  'Math Foundations',
  1,
  20,
  201
),
-- MF-03: Number Types
(
  'c0000000-0000-0000-0001-000000000003',
  'bm-number-types',
  'Number Types',
  'Understand integers, rationals, irrationals, and real numbers. Know which number types appear in different business contexts.',
  'math_foundations',
  'Math Foundations',
  1,
  20,
  202
),
-- MF-04: Calculator Proficiency
(
  'c0000000-0000-0000-0001-000000000004',
  'bm-calculator-proficiency',
  'Calculator Proficiency',
  'Use scientific calculators effectively for business math. Master memory functions, exponents, and percentage calculations.',
  'math_foundations',
  'Math Foundations',
  1,
  15,
  203
);

-- ============================================
-- Basic Statistics Skills (4 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- ST-01: Arithmetic Mean
(
  'c0000000-0000-0000-0002-000000000001',
  'bm-arithmetic-mean',
  'Arithmetic Mean',
  'Calculate simple averages and understand their meaning in business contexts such as average revenue, occupancy rates, and customer spending.',
  'basic_statistics',
  'Basic Statistics',
  1,
  25,
  210
),
-- ST-02: Weighted Averages
(
  'c0000000-0000-0000-0002-000000000002',
  'bm-weighted-averages',
  'Weighted Averages',
  'Compute weighted means for business scenarios including grade calculations, price indices, and portfolio returns.',
  'basic_statistics',
  'Basic Statistics',
  2,
  30,
  211
),
-- ST-03: Summation Notation
(
  'c0000000-0000-0000-0002-000000000003',
  'bm-summation-notation',
  'Summation Notation',
  'Understand and use sigma notation to express sums concisely. Essential for statistical formulas and financial calculations.',
  'basic_statistics',
  'Basic Statistics',
  2,
  35,
  212
),
-- ST-04: Central Tendency Measures
(
  'c0000000-0000-0000-0002-000000000004',
  'bm-central-tendency',
  'Central Tendency Measures',
  'Compare mean, median, and mode. Know when to use each measure for different business data sets.',
  'basic_statistics',
  'Basic Statistics',
  2,
  25,
  213
);

-- ============================================
-- Ratios and Percentages Skills (6 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- RP-01: Fraction Operations
(
  'c0000000-0000-0000-0003-000000000001',
  'bm-fraction-operations',
  'Fraction Operations',
  'Add, subtract, multiply, and divide fractions with confidence. Convert between fractions, decimals, and mixed numbers.',
  'ratios_percentages',
  'Ratios & Percentages',
  1,
  30,
  220
),
-- RP-02: Ratios and Proportions
(
  'c0000000-0000-0000-0003-000000000002',
  'bm-ratios-proportions',
  'Ratios and Proportions',
  'Set up and solve ratio problems including recipe scaling, staff ratios, and unit conversions in hospitality contexts.',
  'ratios_percentages',
  'Ratios & Percentages',
  2,
  30,
  221
),
-- RP-03: Percentage Calculations
(
  'c0000000-0000-0000-0003-000000000003',
  'bm-percentage-calculations',
  'Percentage Calculations',
  'Convert between fractions, decimals, and percentages. Calculate percentages of amounts and find original values.',
  'ratios_percentages',
  'Ratios & Percentages',
  2,
  25,
  222
),
-- RP-04: Percentage Change
(
  'c0000000-0000-0000-0003-000000000004',
  'bm-percentage-change',
  'Percentage Change',
  'Calculate increases, decreases, and growth rates. Understand year-over-year changes and compound growth.',
  'ratios_percentages',
  'Ratios & Percentages',
  2,
  30,
  223
),
-- RP-05: Markup and Margin
(
  'c0000000-0000-0000-0003-000000000005',
  'bm-markup-margin',
  'Markup and Margin',
  'Master price markup, profit margin, and business pricing strategies. Understand the difference between markup and margin.',
  'ratios_percentages',
  'Ratios & Percentages',
  3,
  35,
  224
),
-- RP-06: Index Numbers
(
  'c0000000-0000-0000-0003-000000000006',
  'bm-index-numbers',
  'Index Numbers',
  'Understand price indices, weighted indices, and their business applications including CPI and market indices.',
  'ratios_percentages',
  'Ratios & Percentages',
  3,
  30,
  225
);

-- ============================================
-- Exponents and Logarithms Skills (8 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- EL-01: Exponent Rules
(
  'c0000000-0000-0000-0004-000000000001',
  'bm-exponent-rules',
  'Exponent Rules',
  'Apply product, quotient, and power rules for exponents. Simplify expressions with multiple exponents.',
  'exponents_logs',
  'Exponents & Logarithms',
  2,
  35,
  230
),
-- EL-02: Negative and Fractional Exponents
(
  'c0000000-0000-0000-0004-000000000002',
  'bm-negative-fractional-exponents',
  'Negative and Fractional Exponents',
  'Work with negative exponents (reciprocals) and fractional exponents (roots). Convert between radical and exponential forms.',
  'exponents_logs',
  'Exponents & Logarithms',
  2,
  30,
  231
),
-- EL-03: Scientific Notation
(
  'c0000000-0000-0000-0004-000000000003',
  'bm-scientific-notation',
  'Scientific Notation',
  'Represent very large and small numbers efficiently. Perform calculations with numbers in scientific notation.',
  'exponents_logs',
  'Exponents & Logarithms',
  2,
  20,
  232
),
-- EL-04: Logarithm Basics
(
  'c0000000-0000-0000-0004-000000000004',
  'bm-logarithm-basics',
  'Logarithm Basics',
  'Understand logarithms as inverse of exponentiation. Evaluate common and natural logarithms.',
  'exponents_logs',
  'Exponents & Logarithms',
  3,
  35,
  233
),
-- EL-05: Logarithm Rules
(
  'c0000000-0000-0000-0004-000000000005',
  'bm-logarithm-rules',
  'Logarithm Rules',
  'Apply product, quotient, and power rules for logarithms. Expand and condense logarithmic expressions.',
  'exponents_logs',
  'Exponents & Logarithms',
  3,
  30,
  234
),
-- EL-06: Compound Interest
(
  'c0000000-0000-0000-0004-000000000006',
  'bm-compound-interest',
  'Compound Interest',
  'Calculate simple and compound interest. Understand compounding periods and their effect on investment growth.',
  'exponents_logs',
  'Exponents & Logarithms',
  3,
  40,
  235
),
-- EL-07: Continuous Compounding
(
  'c0000000-0000-0000-0004-000000000007',
  'bm-continuous-compounding',
  'Continuous Compounding',
  'Understand the number e and continuous growth models. Apply continuous compounding to financial calculations.',
  'exponents_logs',
  'Exponents & Logarithms',
  3,
  35,
  236
),
-- EL-08: Time Value of Money
(
  'c0000000-0000-0000-0004-000000000008',
  'bm-time-value-money',
  'Time Value of Money',
  'Calculate present value, future value, and discounting. Essential for investment analysis and loan calculations.',
  'exponents_logs',
  'Exponents & Logarithms',
  4,
  45,
  237
);

-- ============================================
-- Equations Skills (6 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- EQ-01: Linear Equations
(
  'c0000000-0000-0000-0005-000000000001',
  'bm-linear-equations',
  'Linear Equations',
  'Solve single-variable linear equations systematically. Apply to break-even analysis and simple business problems.',
  'equations',
  'Equations',
  2,
  30,
  240
),
-- EQ-02: Equation Manipulation
(
  'c0000000-0000-0000-0005-000000000002',
  'bm-equation-manipulation',
  'Equation Manipulation',
  'Rearrange formulas and isolate variables. Transform business formulas to solve for different unknowns.',
  'equations',
  'Equations',
  2,
  30,
  241
),
-- EQ-03: Quadratic Equations
(
  'c0000000-0000-0000-0005-000000000003',
  'bm-quadratic-equations',
  'Quadratic Equations',
  'Solve quadratics by factoring, completing the square, and using the quadratic formula. Apply to optimization problems.',
  'equations',
  'Equations',
  3,
  40,
  242
),
-- EQ-04: Systems of Two Equations
(
  'c0000000-0000-0000-0005-000000000004',
  'bm-systems-two-equations',
  'Systems of Two Equations',
  'Solve systems using substitution and elimination methods. Apply to supply-demand equilibrium and resource allocation.',
  'equations',
  'Equations',
  3,
  40,
  243
),
-- EQ-05: Systems of Three Equations
(
  'c0000000-0000-0000-0005-000000000005',
  'bm-systems-three-equations',
  'Systems of Three Equations',
  'Solve larger systems systematically using elimination and back-substitution. Handle complex business scenarios.',
  'equations',
  'Equations',
  4,
  45,
  244
),
-- EQ-06: Matrix Notation
(
  'c0000000-0000-0000-0005-000000000006',
  'bm-matrix-notation',
  'Matrix Notation',
  'Represent systems of equations as matrices. Understand matrix operations and their applications.',
  'equations',
  'Equations',
  4,
  30,
  245
);

-- ============================================
-- Functions and Graphs Skills (6 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- FG-01: Function Notation
(
  'c0000000-0000-0000-0006-000000000001',
  'bm-function-notation',
  'Function Notation',
  'Understand f(x) notation, domain, range, and function evaluation. Interpret functions in business contexts.',
  'functions_graphs',
  'Functions & Graphs',
  2,
  30,
  250
),
-- FG-02: Linear Functions
(
  'c0000000-0000-0000-0006-000000000002',
  'bm-linear-functions',
  'Linear Functions',
  'Master slope, intercepts, and graphing linear functions. Model cost, revenue, and demand with linear functions.',
  'functions_graphs',
  'Functions & Graphs',
  2,
  35,
  251
),
-- FG-03: Quadratic Functions
(
  'c0000000-0000-0000-0006-000000000003',
  'bm-quadratic-functions',
  'Quadratic Functions',
  'Graph parabolas, find vertices, and understand vertex form. Apply to profit maximization and projectile motion.',
  'functions_graphs',
  'Functions & Graphs',
  3,
  40,
  252
),
-- FG-04: Polynomial Functions
(
  'c0000000-0000-0000-0006-000000000004',
  'bm-polynomial-functions',
  'Polynomial Functions',
  'Analyze higher-degree polynomials, their zeros, and end behavior. Understand polynomial models in business.',
  'functions_graphs',
  'Functions & Graphs',
  3,
  35,
  253
),
-- FG-05: Exponential Functions
(
  'c0000000-0000-0000-0006-000000000005',
  'bm-exponential-functions',
  'Exponential Functions',
  'Model growth and decay with exponential functions. Apply to population growth, depreciation, and viral marketing.',
  'functions_graphs',
  'Functions & Graphs',
  3,
  35,
  254
),
-- FG-06: Graph Interpretation
(
  'c0000000-0000-0000-0006-000000000006',
  'bm-graph-interpretation',
  'Graph Interpretation',
  'Read and analyze business graphs including supply-demand curves, time series, and financial charts.',
  'functions_graphs',
  'Functions & Graphs',
  3,
  30,
  255
);

-- ============================================
-- Differential Calculus Skills (9 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- DC-01: Limits and Continuity
(
  'c0000000-0000-0000-0007-000000000001',
  'bm-limits-continuity',
  'Limits and Continuity',
  'Develop intuitive understanding of limits and continuous functions. Foundation for understanding derivatives.',
  'differential_calculus',
  'Differential Calculus',
  3,
  35,
  260
),
-- DC-02: Derivative Concept
(
  'c0000000-0000-0000-0007-000000000002',
  'bm-derivative-concept',
  'Derivative Concept',
  'Understand rate of change and the derivative as slope of tangent line. Connect to marginal cost and revenue.',
  'differential_calculus',
  'Differential Calculus',
  3,
  40,
  261
),
-- DC-03: Basic Derivative Rules
(
  'c0000000-0000-0000-0007-000000000003',
  'bm-basic-derivative-rules',
  'Basic Derivative Rules',
  'Apply power rule, constant rule, and sum/difference rules. Differentiate polynomial and simple functions.',
  'differential_calculus',
  'Differential Calculus',
  3,
  40,
  262
),
-- DC-04: Product and Quotient Rules
(
  'c0000000-0000-0000-0007-000000000004',
  'bm-product-quotient-rules',
  'Product and Quotient Rules',
  'Differentiate products and quotients of functions. Apply to complex business functions.',
  'differential_calculus',
  'Differential Calculus',
  4,
  40,
  263
),
-- DC-05: Chain Rule
(
  'c0000000-0000-0000-0007-000000000005',
  'bm-chain-rule',
  'Chain Rule',
  'Differentiate composite functions using the chain rule. Essential for complex real-world models.',
  'differential_calculus',
  'Differential Calculus',
  4,
  45,
  264
),
-- DC-06: Higher-Order Derivatives
(
  'c0000000-0000-0000-0007-000000000006',
  'bm-higher-order-derivatives',
  'Higher-Order Derivatives',
  'Find second and higher-order derivatives. Analyze concavity and inflection points.',
  'differential_calculus',
  'Differential Calculus',
  4,
  35,
  265
),
-- DC-07: Partial Derivatives
(
  'c0000000-0000-0000-0007-000000000007',
  'bm-partial-derivatives',
  'Partial Derivatives',
  'Differentiate multivariable functions with respect to one variable. Apply to functions of multiple inputs.',
  'differential_calculus',
  'Differential Calculus',
  4,
  45,
  266
),
-- DC-08: Optimization
(
  'c0000000-0000-0000-0007-000000000008',
  'bm-optimization',
  'Optimization',
  'Find maxima and minima using first and second derivative tests. Maximize profit and minimize cost.',
  'differential_calculus',
  'Differential Calculus',
  4,
  50,
  267
),
-- DC-09: Constrained Optimization
(
  'c0000000-0000-0000-0007-000000000009',
  'bm-constrained-optimization',
  'Constrained Optimization',
  'Optimize with constraints using Lagrange multipliers. Solve resource allocation with limited inputs.',
  'differential_calculus',
  'Differential Calculus',
  5,
  45,
  268
);

-- ============================================
-- Integral Calculus Skills (4 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- IC-01: Antiderivatives
(
  'c0000000-0000-0000-0008-000000000001',
  'bm-antiderivatives',
  'Antiderivatives',
  'Reverse differentiation to find antiderivatives. Apply basic integration rules to polynomial functions.',
  'integral_calculus',
  'Integral Calculus',
  3,
  35,
  270
),
-- IC-02: Definite Integrals
(
  'c0000000-0000-0000-0008-000000000002',
  'bm-definite-integrals',
  'Definite Integrals',
  'Calculate area under curves using the fundamental theorem of calculus. Apply to accumulated change.',
  'integral_calculus',
  'Integral Calculus',
  4,
  45,
  271
),
-- IC-03: Integration Techniques
(
  'c0000000-0000-0000-0008-000000000003',
  'bm-integration-techniques',
  'Integration Techniques',
  'Apply substitution and basic integration methods. Handle more complex integrands.',
  'integral_calculus',
  'Integral Calculus',
  4,
  45,
  272
),
-- IC-04: Consumer and Producer Surplus
(
  'c0000000-0000-0000-0008-000000000004',
  'bm-consumer-producer-surplus',
  'Consumer and Producer Surplus',
  'Apply integration to calculate economic surplus. Understand welfare analysis in market equilibrium.',
  'integral_calculus',
  'Integral Calculus',
  4,
  40,
  273
);

-- ============================================
-- Skill Prerequisites
-- ============================================

INSERT INTO skill_prerequisites (skill_id, prerequisite_skill_id, is_required) VALUES
-- Math Foundations prerequisites (none - entry level)

-- Basic Statistics prerequisites
('c0000000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0001-000000000001', true),  -- Arithmetic Mean requires Arithmetic Fundamentals
('c0000000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0002-000000000001', true),  -- Weighted Averages requires Arithmetic Mean
('c0000000-0000-0000-0002-000000000003', 'c0000000-0000-0000-0001-000000000002', true),  -- Summation Notation requires Order of Operations
('c0000000-0000-0000-0002-000000000004', 'c0000000-0000-0000-0002-000000000001', true),  -- Central Tendency requires Arithmetic Mean

-- Ratios and Percentages prerequisites
('c0000000-0000-0000-0003-000000000001', 'c0000000-0000-0000-0001-000000000001', true),  -- Fractions requires Arithmetic Fundamentals
('c0000000-0000-0000-0003-000000000002', 'c0000000-0000-0000-0003-000000000001', true),  -- Ratios requires Fractions
('c0000000-0000-0000-0003-000000000003', 'c0000000-0000-0000-0003-000000000001', true),  -- Percentages requires Fractions
('c0000000-0000-0000-0003-000000000004', 'c0000000-0000-0000-0003-000000000003', true),  -- Percent Change requires Percentages
('c0000000-0000-0000-0003-000000000005', 'c0000000-0000-0000-0003-000000000004', true),  -- Markup/Margin requires Percent Change
('c0000000-0000-0000-0003-000000000006', 'c0000000-0000-0000-0002-000000000002', true),  -- Index Numbers requires Weighted Averages

-- Exponents and Logarithms prerequisites
('c0000000-0000-0000-0004-000000000001', 'c0000000-0000-0000-0001-000000000002', true),  -- Exponent Rules requires Order of Operations
('c0000000-0000-0000-0004-000000000002', 'c0000000-0000-0000-0004-000000000001', true),  -- Neg/Frac Exponents requires Exponent Rules
('c0000000-0000-0000-0004-000000000003', 'c0000000-0000-0000-0004-000000000001', true),  -- Scientific Notation requires Exponent Rules
('c0000000-0000-0000-0004-000000000004', 'c0000000-0000-0000-0004-000000000002', true),  -- Logarithm Basics requires Neg/Frac Exponents
('c0000000-0000-0000-0004-000000000005', 'c0000000-0000-0000-0004-000000000004', true),  -- Logarithm Rules requires Logarithm Basics
('c0000000-0000-0000-0004-000000000006', 'c0000000-0000-0000-0003-000000000004', true),  -- Compound Interest requires Percent Change
('c0000000-0000-0000-0004-000000000006', 'c0000000-0000-0000-0004-000000000002', true),  -- Compound Interest requires Neg/Frac Exponents
('c0000000-0000-0000-0004-000000000007', 'c0000000-0000-0000-0004-000000000006', true),  -- Continuous Compounding requires Compound Interest
('c0000000-0000-0000-0004-000000000007', 'c0000000-0000-0000-0004-000000000004', true),  -- Continuous Compounding requires Logarithm Basics
('c0000000-0000-0000-0004-000000000008', 'c0000000-0000-0000-0004-000000000007', true),  -- Time Value of Money requires Continuous Compounding

-- Equations prerequisites
('c0000000-0000-0000-0005-000000000001', 'c0000000-0000-0000-0001-000000000002', true),  -- Linear Equations requires Order of Operations
('c0000000-0000-0000-0005-000000000002', 'c0000000-0000-0000-0005-000000000001', true),  -- Equation Manipulation requires Linear Equations
('c0000000-0000-0000-0005-000000000003', 'c0000000-0000-0000-0005-000000000001', true),  -- Quadratic Equations requires Linear Equations
('c0000000-0000-0000-0005-000000000003', 'c0000000-0000-0000-0004-000000000002', true),  -- Quadratic Equations requires Neg/Frac Exponents
('c0000000-0000-0000-0005-000000000004', 'c0000000-0000-0000-0005-000000000001', true),  -- Systems of Two requires Linear Equations
('c0000000-0000-0000-0005-000000000005', 'c0000000-0000-0000-0005-000000000004', true),  -- Systems of Three requires Systems of Two
('c0000000-0000-0000-0005-000000000006', 'c0000000-0000-0000-0005-000000000005', true),  -- Matrix Notation requires Systems of Three

-- Functions and Graphs prerequisites
('c0000000-0000-0000-0006-000000000001', 'c0000000-0000-0000-0005-000000000001', true),  -- Function Notation requires Linear Equations
('c0000000-0000-0000-0006-000000000002', 'c0000000-0000-0000-0006-000000000001', true),  -- Linear Functions requires Function Notation
('c0000000-0000-0000-0006-000000000003', 'c0000000-0000-0000-0006-000000000002', true),  -- Quadratic Functions requires Linear Functions
('c0000000-0000-0000-0006-000000000003', 'c0000000-0000-0000-0005-000000000003', true),  -- Quadratic Functions requires Quadratic Equations
('c0000000-0000-0000-0006-000000000004', 'c0000000-0000-0000-0006-000000000003', true),  -- Polynomial Functions requires Quadratic Functions
('c0000000-0000-0000-0006-000000000005', 'c0000000-0000-0000-0006-000000000002', true),  -- Exponential Functions requires Linear Functions
('c0000000-0000-0000-0006-000000000005', 'c0000000-0000-0000-0004-000000000006', true),  -- Exponential Functions requires Compound Interest
('c0000000-0000-0000-0006-000000000006', 'c0000000-0000-0000-0006-000000000002', true),  -- Graph Interpretation requires Linear Functions

-- Differential Calculus prerequisites
('c0000000-0000-0000-0007-000000000001', 'c0000000-0000-0000-0006-000000000002', true),  -- Limits requires Linear Functions
('c0000000-0000-0000-0007-000000000002', 'c0000000-0000-0000-0007-000000000001', true),  -- Derivative Concept requires Limits
('c0000000-0000-0000-0007-000000000003', 'c0000000-0000-0000-0007-000000000002', true),  -- Basic Derivative Rules requires Derivative Concept
('c0000000-0000-0000-0007-000000000004', 'c0000000-0000-0000-0007-000000000003', true),  -- Product/Quotient Rules requires Basic Rules
('c0000000-0000-0000-0007-000000000005', 'c0000000-0000-0000-0007-000000000003', true),  -- Chain Rule requires Basic Rules
('c0000000-0000-0000-0007-000000000006', 'c0000000-0000-0000-0007-000000000003', true),  -- Higher-Order Derivatives requires Basic Rules
('c0000000-0000-0000-0007-000000000007', 'c0000000-0000-0000-0007-000000000005', true),  -- Partial Derivatives requires Chain Rule
('c0000000-0000-0000-0007-000000000008', 'c0000000-0000-0000-0007-000000000006', true),  -- Optimization requires Higher-Order Derivatives
('c0000000-0000-0000-0007-000000000009', 'c0000000-0000-0000-0007-000000000008', true),  -- Constrained Optimization requires Optimization
('c0000000-0000-0000-0007-000000000009', 'c0000000-0000-0000-0007-000000000007', true),  -- Constrained Optimization requires Partial Derivatives

-- Integral Calculus prerequisites
('c0000000-0000-0000-0008-000000000001', 'c0000000-0000-0000-0007-000000000003', true),  -- Antiderivatives requires Basic Derivative Rules
('c0000000-0000-0000-0008-000000000002', 'c0000000-0000-0000-0008-000000000001', true),  -- Definite Integrals requires Antiderivatives
('c0000000-0000-0000-0008-000000000003', 'c0000000-0000-0000-0008-000000000002', true),  -- Integration Techniques requires Definite Integrals
('c0000000-0000-0000-0008-000000000003', 'c0000000-0000-0000-0007-000000000005', true),  -- Integration Techniques requires Chain Rule
('c0000000-0000-0000-0008-000000000004', 'c0000000-0000-0000-0008-000000000002', true),  -- Consumer/Producer Surplus requires Definite Integrals
('c0000000-0000-0000-0008-000000000004', 'c0000000-0000-0000-0006-000000000006', true);  -- Consumer/Producer Surplus requires Graph Interpretation


-- ============================================
-- Recreate functions that were dropped due to enum dependency
-- ============================================

CREATE OR REPLACE FUNCTION get_course_skills(
  p_course_id UUID, 
  p_user_id UUID DEFAULT NULL,
  p_category skill_category DEFAULT NULL
)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  category skill_category,
  category_label TEXT,
  difficulty_level INT,
  estimated_minutes INT,
  sort_order INT,
  mastery_level INT,
  is_available BOOLEAN,
  prerequisite_count INT,
  prerequisites_met INT,
  total_activities INT,
  completed_activities INT
) AS $$
BEGIN
  RETURN QUERY
  WITH prereq_status AS (
    SELECT 
      s.id,
      COUNT(sp.prerequisite_skill_id)::INT AS prereq_count,
      COUNT(sp.prerequisite_skill_id) FILTER (
        WHERE NOT sp.is_required OR COALESCE(usp.mastery_level, 0) >= 70
      )::INT AS prereqs_met
    FROM skills s
    LEFT JOIN skill_prerequisites sp ON s.id = sp.skill_id
    LEFT JOIN user_skill_progress usp ON sp.prerequisite_skill_id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true
      AND (p_category IS NULL OR s.category = p_category)
    GROUP BY s.id
  ),
  activity_counts AS (
    SELECT 
      asks.skill_id,
      COUNT(a.id)::INT AS total_acts,
      COUNT(ap.id) FILTER (WHERE ap.completed = true)::INT AS completed_acts
    FROM activity_skills asks
    JOIN activities a ON asks.activity_id = a.id AND a.is_published = true
    LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
    WHERE asks.is_owner = true
    GROUP BY asks.skill_id
  )
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.description AS skill_description,
    s.category,
    s.category_label,
    s.difficulty_level,
    s.estimated_minutes,
    s.sort_order,
    COALESCE(usp.mastery_level, 0) AS mastery_level,
    COALESCE(ps.prereq_count = ps.prereqs_met, true) AS is_available,
    COALESCE(ps.prereq_count, 0) AS prerequisite_count,
    COALESCE(ps.prereqs_met, 0) AS prerequisites_met,
    COALESCE(ac.total_acts, 0) AS total_activities,
    COALESCE(ac.completed_acts, 0) AS completed_activities
  FROM skills s
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  LEFT JOIN prereq_status ps ON s.id = ps.id
  LEFT JOIN activity_counts ac ON s.id = ac.skill_id
  WHERE s.course_id = p_course_id AND s.is_active = true
    AND (p_category IS NULL OR s.category = p_category)
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION get_course_foundations(p_course_id UUID, p_user_id UUID DEFAULT NULL)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  sort_order INT,
  total_activities INT,
  completed_activities INT,
  is_available BOOLEAN,
  mastery_level INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    cs.skill_id,
    cs.skill_slug,
    cs.skill_name,
    cs.skill_description,
    cs.sort_order,
    cs.total_activities,
    cs.completed_activities,
    cs.is_available,
    cs.mastery_level
  FROM get_course_skills(p_course_id, p_user_id, 'ct_foundations'::skill_category) cs;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION get_course_coding_skills(p_course_id UUID, p_user_id UUID DEFAULT NULL)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  category skill_category,
  category_label TEXT,
  difficulty_level INT,
  estimated_minutes INT,
  sort_order INT,
  mastery_level INT,
  is_available BOOLEAN,
  prerequisite_count INT,
  prerequisites_met INT,
  total_activities INT,
  completed_activities INT
) AS $$
BEGIN
  RETURN QUERY
  WITH prereq_status AS (
    SELECT 
      s.id,
      COUNT(sp.prerequisite_skill_id)::INT AS prereq_count,
      COUNT(sp.prerequisite_skill_id) FILTER (
        WHERE NOT sp.is_required OR COALESCE(usp.mastery_level, 0) >= 70
      )::INT AS prereqs_met
    FROM skills s
    LEFT JOIN skill_prerequisites sp ON s.id = sp.skill_id
    LEFT JOIN user_skill_progress usp ON sp.prerequisite_skill_id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true AND s.category != 'ct_foundations'
    GROUP BY s.id
  ),
  activity_counts AS (
    SELECT 
      asks.skill_id,
      COUNT(a.id)::INT AS total_acts,
      COUNT(ap.id) FILTER (WHERE ap.completed = true)::INT AS completed_acts
    FROM activity_skills asks
    JOIN activities a ON asks.activity_id = a.id AND a.is_published = true
    LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
    WHERE asks.is_owner = true
    GROUP BY asks.skill_id
  )
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.description AS skill_description,
    s.category,
    s.category_label,
    s.difficulty_level,
    s.estimated_minutes,
    s.sort_order,
    COALESCE(usp.mastery_level, 0) AS mastery_level,
    COALESCE(ps.prereq_count = ps.prereqs_met, true) AS is_available,
    COALESCE(ps.prereq_count, 0) AS prerequisite_count,
    COALESCE(ps.prereqs_met, 0) AS prerequisites_met,
    COALESCE(ac.total_acts, 0) AS total_activities,
    COALESCE(ac.completed_acts, 0) AS completed_activities
  FROM skills s
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  LEFT JOIN prereq_status ps ON s.id = ps.id
  LEFT JOIN activity_counts ac ON s.id = ac.skill_id
  WHERE s.course_id = p_course_id AND s.is_active = true AND s.category != 'ct_foundations'
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION get_course_skill_progress(p_course_id UUID, p_user_id UUID)
RETURNS TABLE (
  foundations_total INT,
  foundations_mastered INT,
  foundations_in_progress INT,
  skills_total INT,
  skills_mastered INT,
  skills_in_progress INT,
  overall_progress_percent INT
) AS $$
BEGIN
  RETURN QUERY
  WITH skill_stats AS (
    SELECT 
      s.category IN ('ct_foundations', 'fa_foundations', 'math_foundations') AS is_foundation,
      COUNT(*)::INT AS total,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) >= 70)::INT AS mastered,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) > 0 AND COALESCE(usp.mastery_level, 0) < 70)::INT AS in_progress
    FROM skills s
    LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true
    GROUP BY s.category IN ('ct_foundations', 'fa_foundations', 'math_foundations')
  )
  SELECT 
    COALESCE((SELECT total FROM skill_stats WHERE is_foundation = true), 0),
    COALESCE((SELECT mastered FROM skill_stats WHERE is_foundation = true), 0),
    COALESCE((SELECT in_progress FROM skill_stats WHERE is_foundation = true), 0),
    COALESCE((SELECT total FROM skill_stats WHERE is_foundation = false), 0),
    COALESCE((SELECT mastered FROM skill_stats WHERE is_foundation = false), 0),
    COALESCE((SELECT in_progress FROM skill_stats WHERE is_foundation = false), 0),
    CASE 
      WHEN COALESCE(SUM(total), 0) = 0 THEN 0
      ELSE (COALESCE(SUM(mastered), 0) * 100 / COALESCE(SUM(total), 1))::INT
    END
  FROM skill_stats;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate get_user_skill_mastery
CREATE OR REPLACE FUNCTION get_user_skill_mastery(p_user_id UUID)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  category skill_category,
  mastery_level INT,
  times_practiced INT,
  last_practiced_at TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.category,
    COALESCE(usp.mastery_level, 0) AS mastery_level,
    COALESCE(usp.times_practiced, 0) AS times_practiced,
    usp.last_practiced_at
  FROM skills s
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  WHERE s.is_active = true
  ORDER BY s.category, s.sort_order;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate get_struggling_skills
CREATE OR REPLACE FUNCTION get_struggling_skills(p_user_id UUID)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  category skill_category,
  mastery_level INT,
  prerequisite_gaps UUID[]
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.category,
    usp.mastery_level,
    ARRAY(
      SELECT sp.prerequisite_skill_id 
      FROM skill_prerequisites sp
      LEFT JOIN user_skill_progress prereq_usp ON sp.prerequisite_skill_id = prereq_usp.skill_id AND prereq_usp.user_id = p_user_id
      WHERE sp.skill_id = s.id 
        AND sp.is_required = true
        AND COALESCE(prereq_usp.mastery_level, 0) < 70
    ) AS prerequisite_gaps
  FROM skills s
  JOIN user_skill_progress usp ON s.id = usp.skill_id
  WHERE usp.user_id = p_user_id
    AND usp.mastery_level < 70
    AND s.is_active = true
  ORDER BY usp.mastery_level ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate search_skills
CREATE OR REPLACE FUNCTION search_skills(p_query TEXT)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  description TEXT,
  category skill_category,
  relevance REAL
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.description,
    s.category,
    ts_rank(
      to_tsvector('english', COALESCE(s.name, '') || ' ' || COALESCE(s.description, '')),
      plainto_tsquery('english', p_query)
    ) AS relevance
  FROM skills s
  WHERE s.is_active = true
    AND (
      s.name ILIKE '%' || p_query || '%'
      OR s.description ILIKE '%' || p_query || '%'
      OR s.slug ILIKE '%' || p_query || '%'
    )
  ORDER BY relevance DESC, s.sort_order
  LIMIT 20;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate get_coding_skill_tree
CREATE OR REPLACE FUNCTION get_coding_skill_tree(p_user_id UUID DEFAULT NULL)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  category skill_category,
  difficulty_level INT,
  estimated_minutes INT,
  sort_order INT,
  mastery_level INT,
  is_available BOOLEAN,
  prerequisite_count INT,
  prerequisites_met INT
) AS $$
BEGIN
  RETURN QUERY
  WITH prereq_status AS (
    SELECT 
      s.id,
      COUNT(sp.prerequisite_skill_id)::INT AS prereq_count,
      COUNT(sp.prerequisite_skill_id) FILTER (
        WHERE NOT sp.is_required OR COALESCE(usp.mastery_level, 0) >= 70
      )::INT AS prereqs_met
    FROM skills s
    LEFT JOIN skill_prerequisites sp ON s.id = sp.skill_id
    LEFT JOIN user_skill_progress usp ON sp.prerequisite_skill_id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.category != 'ct_foundations' AND s.is_active = true
    GROUP BY s.id
  )
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.description AS skill_description,
    s.category,
    s.difficulty_level,
    s.estimated_minutes,
    s.sort_order,
    COALESCE(usp.mastery_level, 0) AS mastery_level,
    COALESCE(ps.prereq_count = ps.prereqs_met, true) AS is_available,
    COALESCE(ps.prereq_count, 0) AS prerequisite_count,
    COALESCE(ps.prereqs_met, 0) AS prerequisites_met
  FROM skills s
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  LEFT JOIN prereq_status ps ON s.id = ps.id
  WHERE s.category != 'ct_foundations' AND s.is_active = true
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate get_foundations_progress
CREATE OR REPLACE FUNCTION get_foundations_progress(p_user_id UUID)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  sort_order INT,
  total_activities INT,
  completed_activities INT,
  is_available BOOLEAN,
  mastery_level INT
) AS $$
BEGIN
  RETURN QUERY
  WITH skill_progress AS (
    SELECT 
      s.id,
      COUNT(a.id)::INT AS total_acts,
      COUNT(ap.id) FILTER (WHERE ap.completed = true)::INT AS completed_acts
    FROM skills s
    LEFT JOIN activity_skills asks ON s.id = asks.skill_id AND asks.is_owner = true
    LEFT JOIN activities a ON asks.activity_id = a.id AND a.is_published = true
    LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
    WHERE s.category IN ('ct_foundations', 'fa_foundations', 'math_foundations') AND s.is_active = true
    GROUP BY s.id
  ),
  prereq_check AS (
    SELECT 
      s.id,
      BOOL_AND(
        CASE 
          WHEN sp.is_required THEN COALESCE(usp.mastery_level, 0) >= 70
          ELSE true
        END
      ) AS all_prereqs_met
    FROM skills s
    LEFT JOIN skill_prerequisites sp ON s.id = sp.skill_id
    LEFT JOIN user_skill_progress usp ON sp.prerequisite_skill_id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.category IN ('ct_foundations', 'fa_foundations', 'math_foundations') AND s.is_active = true
    GROUP BY s.id
  )
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.description AS skill_description,
    s.sort_order,
    COALESCE(sp.total_acts, 0) AS total_activities,
    COALESCE(sp.completed_acts, 0) AS completed_activities,
    COALESCE(pc.all_prereqs_met, true) AS is_available,
    COALESCE(usp.mastery_level, 0) AS mastery_level
  FROM skills s
  LEFT JOIN skill_progress sp ON s.id = sp.id
  LEFT JOIN prereq_check pc ON s.id = pc.id
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  WHERE s.category IN ('ct_foundations', 'fa_foundations', 'math_foundations') AND s.is_active = true
  ORDER BY s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

