-- ============================================
-- Managerial Accounting Course Setup
-- Course, Category, Modules
-- ============================================

-- ============================================
-- 1. Add Accounting Category (if not exists)
-- ============================================

INSERT INTO categories (id, name, slug, description, icon, color, sort_order) VALUES
(
  'b0000000-0000-0000-0000-000000000004',
  'Managerial Accounting',
  'managerial-accounting',
  'Cost accounting, budgeting, and decision-making for managers',
  'chart-bar',
  'emerald',
  4
)
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- 2. Create Managerial Accounting Course
-- ============================================

INSERT INTO courses (id, category_id, title, slug, description, short_description, difficulty, duration_hours, is_published, is_featured, sort_order) VALUES
(
  'c0000000-0000-0000-0000-000000000004',
  'b0000000-0000-0000-0000-000000000004',
  'Managerial Accounting',
  'managerial-accounting',
  'Master cost accounting and management decision-making. This comprehensive course covers cost classification, CVP analysis, job-order costing, budgeting, and variance analysis with real-world hospitality applications. Learn to make informed business decisions using accounting information.',
  'Master cost accounting and management decision-making',
  'intermediate',
  45,
  true,
  true,
  4
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

-- ============================================
-- 3. Associate Skills with Course
-- ============================================

UPDATE skills SET course_id = 'c0000000-0000-0000-0000-000000000004'
WHERE slug LIKE 'ma-%';

-- ============================================
-- 4. Create Modules (for organizational purposes)
-- ============================================

INSERT INTO modules (id, course_id, external_id, order_index, title, slug, description, estimated_minutes, total_xp, required_plan, is_mock_exam, is_midterm_boundary, is_published) VALUES
-- Module 1: MA Foundations (FREE)
(
  'd0000000-0000-0000-0000-000000000001',
  'c0000000-0000-0000-0000-000000000004',
  'ma-mod-01',
  1,
  'MA Foundations',
  'ma-foundations',
  'Understand managerial accounting purpose, cost terminology, and manufacturing cost flows',
  90,
  200,
  'free',
  false,
  false,
  true
),
-- Module 2: Cost Classification (FREE)
(
  'd0000000-0000-0000-0000-000000000002',
  'c0000000-0000-0000-0000-000000000004',
  'ma-mod-02',
  2,
  'Cost Classification',
  'cost-classification',
  'Master direct vs indirect costs, product vs period costs, and prime vs conversion costs',
  80,
  200,
  'free',
  false,
  false,
  true
),
-- Module 3: Cost Behavior (BASIC)
(
  'd0000000-0000-0000-0000-000000000003',
  'c0000000-0000-0000-0000-000000000004',
  'ma-mod-03',
  3,
  'Cost Behavior',
  'cost-behavior',
  'Understand variable, fixed, and mixed costs. Learn the high-low method and contribution margin format',
  100,
  280,
  'basic',
  false,
  false,
  true
),
-- Module 4: CVP Analysis (BASIC)
(
  'd0000000-0000-0000-0000-000000000004',
  'c0000000-0000-0000-0000-000000000004',
  'ma-mod-04',
  4,
  'CVP Analysis',
  'cvp-analysis',
  'Master break-even analysis, target profit, margin of safety, operating leverage, and sales mix',
  150,
  400,
  'basic',
  false,
  true,
  true
),
-- Module 5: Costing Systems (BASIC)
(
  'd0000000-0000-0000-0000-000000000005',
  'c0000000-0000-0000-0000-000000000004',
  'ma-mod-05',
  5,
  'Costing Systems',
  'costing-systems',
  'Apply job-order costing, predetermined overhead rates, and service department cost allocation',
  140,
  350,
  'basic',
  false,
  false,
  true
),
-- Module 6: Decision Making (BASIC)
(
  'd0000000-0000-0000-0000-000000000006',
  'c0000000-0000-0000-0000-000000000004',
  'ma-mod-06',
  6,
  'Decision Making',
  'decision-making',
  'Identify relevant costs and apply to make-or-buy, special order, and keep-or-drop decisions',
  120,
  300,
  'basic',
  false,
  false,
  true
),
-- Module 7: Budgeting (BASIC)
(
  'd0000000-0000-0000-0000-000000000007',
  'c0000000-0000-0000-0000-000000000004',
  'ma-mod-07',
  7,
  'Budgeting',
  'budgeting',
  'Build master budgets, sales and production budgets, cash budgets, and flexible budgets',
  140,
  350,
  'basic',
  false,
  false,
  true
),
-- Module 8: Variance Analysis (BASIC)
(
  'd0000000-0000-0000-0000-000000000008',
  'c0000000-0000-0000-0000-000000000004',
  'ma-mod-08',
  8,
  'Variance Analysis',
  'variance-analysis',
  'Set standards and calculate materials, labor, and overhead variances for performance evaluation',
  150,
  400,
  'basic',
  false,
  false,
  true
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

