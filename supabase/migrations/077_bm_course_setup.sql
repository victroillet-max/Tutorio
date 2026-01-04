-- ============================================
-- Business Mathematics Course Setup
-- Course, Category, Modules
-- ============================================

-- ============================================
-- 1. Add Mathematics Category
-- ============================================

INSERT INTO categories (id, name, slug, description, icon, color, sort_order) VALUES
(
  'b0000000-0000-0000-0000-000000000003',
  'Mathematics',
  'mathematics',
  'Business mathematics, statistics, and quantitative analysis',
  'calculator',
  'indigo',
  3
)
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- 2. Create Business Mathematics Course
-- ============================================

INSERT INTO courses (id, category_id, title, slug, description, short_description, difficulty, duration_hours, is_published, is_featured, sort_order) VALUES
(
  'c0000000-0000-0000-0000-000000000003',
  'b0000000-0000-0000-0000-000000000003',
  'Business Mathematics',
  'business-mathematics',
  'Master essential mathematical skills for business success. This comprehensive course covers arithmetic fundamentals through calculus, with real-world applications in finance, hospitality, and management. Learn to analyze data, calculate interest, optimize decisions, and interpret business graphs with confidence.',
  'Master essential mathematical skills for business success',
  'beginner',
  30,
  true,
  true,
  3
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

-- ============================================
-- 3. Associate Skills with Course
-- ============================================

UPDATE skills SET course_id = 'c0000000-0000-0000-0000-000000000003'
WHERE slug LIKE 'bm-%';

-- ============================================
-- 4. Create Modules (for organizational purposes)
-- ============================================

INSERT INTO modules (id, course_id, external_id, order_index, title, slug, description, estimated_minutes, total_xp, required_plan, is_mock_exam, is_midterm_boundary, is_published) VALUES
-- Module 1: Math Foundations (FREE)
(
  'b0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-000000000003',
  'bm-mod-01',
  1,
  'Math Foundations',
  'math-foundations',
  'Build a solid foundation with arithmetic fundamentals, order of operations, and number types',
  80,
  200,
  'free',
  false,
  false,
  true
),
-- Module 2: Basic Statistics (FREE)
(
  'b0000000-0000-0000-0000-000000000002',
  'c0000000-0000-0000-0000-000000000003',
  'bm-mod-02',
  2,
  'Basic Statistics',
  'basic-statistics',
  'Master averages, weighted means, and summation notation for data analysis',
  90,
  250,
  'free',
  false,
  false,
  true
),
-- Module 3: Ratios and Percentages (BASIC)
(
  'b0000000-0000-0000-0000-000000000003',
  'c0000000-0000-0000-0000-000000000003',
  'bm-mod-03',
  3,
  'Ratios and Percentages',
  'ratios-percentages',
  'Work with fractions, ratios, percentages, markup, and margin calculations',
  120,
  350,
  'basic',
  false,
  false,
  true
),
-- Module 4: Exponents and Logarithms (BASIC)
(
  'b0000000-0000-0000-0000-000000000004',
  'c0000000-0000-0000-0000-000000000003',
  'bm-mod-04',
  4,
  'Exponents and Logarithms',
  'exponents-logarithms',
  'Master exponents, logarithms, compound interest, and time value of money',
  180,
  500,
  'basic',
  false,
  false,
  true
),
-- Module 5: Equations (BASIC)
(
  'b0000000-0000-0000-0000-000000000005',
  'c0000000-0000-0000-0000-000000000003',
  'bm-mod-05',
  5,
  'Equations',
  'equations',
  'Solve linear, quadratic, and systems of equations',
  150,
  400,
  'basic',
  false,
  true,
  true
),
-- Module 6: Functions and Graphs (BASIC)
(
  'b0000000-0000-0000-0000-000000000006',
  'c0000000-0000-0000-0000-000000000003',
  'bm-mod-06',
  6,
  'Functions and Graphs',
  'functions-graphs',
  'Understand function notation and graph linear, quadratic, and exponential functions',
  140,
  380,
  'basic',
  false,
  false,
  true
),
-- Module 7: Differential Calculus (BASIC)
(
  'b0000000-0000-0000-0000-000000000007',
  'c0000000-0000-0000-0000-000000000003',
  'bm-mod-07',
  7,
  'Differential Calculus',
  'differential-calculus',
  'Learn derivatives, optimization, and partial derivatives for business applications',
  250,
  650,
  'basic',
  false,
  false,
  true
),
-- Module 8: Integral Calculus (BASIC)
(
  'b0000000-0000-0000-0000-000000000008',
  'c0000000-0000-0000-0000-000000000003',
  'bm-mod-08',
  8,
  'Integral Calculus',
  'integral-calculus',
  'Master integration techniques and economic applications like consumer surplus',
  120,
  350,
  'basic',
  false,
  false,
  true
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

