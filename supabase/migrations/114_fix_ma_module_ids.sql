-- ============================================
-- Fix for MA Module ID Collision with CT
-- ============================================
-- Issue: MA migration (087) uses the same module IDs as CT (007):
--   d0000000-0000-0000-0000-000000000001 through 008
-- 
-- The ON CONFLICT clause only updates title/description, not course_id,
-- so MA modules never got linked to the MA course.
--
-- Solution:
--   1. Create new modules with unique IDs for MA
--   2. Update all MA activities to reference the new modules
-- ============================================

-- ============================================
-- Step 1: Create new MA modules with unique IDs
-- Using prefix 'e0' instead of 'd0' to avoid collision
-- ============================================

INSERT INTO modules (id, course_id, external_id, order_index, title, slug, description, estimated_minutes, total_xp, required_plan, is_mock_exam, is_midterm_boundary, is_published) VALUES
-- Module 1: MA Foundations (FREE)
(
  'e0000000-0000-0000-0000-000000000001',
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
  'e0000000-0000-0000-0000-000000000002',
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
  'e0000000-0000-0000-0000-000000000003',
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
  'e0000000-0000-0000-0000-000000000004',
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
  'e0000000-0000-0000-0000-000000000005',
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
  'e0000000-0000-0000-0000-000000000006',
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
  'e0000000-0000-0000-0000-000000000007',
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
  'e0000000-0000-0000-0000-000000000008',
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
  course_id = EXCLUDED.course_id,
  title = EXCLUDED.title,
  description = EXCLUDED.description;

-- ============================================
-- Step 2: Update MA activities to reference new modules
-- MA activities have ID pattern 'd0X00000-...' where X is the module number
-- e.g., Module 1: d0100000-..., Module 8: d0800000-...
-- ============================================

-- Module 1 activities (ID starts with 'd0100000')
UPDATE activities
SET module_id = 'e0000000-0000-0000-0000-000000000001'
WHERE id::text LIKE 'd0100000-%';

-- Module 2 activities (ID starts with 'd0200000')
UPDATE activities
SET module_id = 'e0000000-0000-0000-0000-000000000002'
WHERE id::text LIKE 'd0200000-%';

-- Module 3 activities (ID starts with 'd0300000')
UPDATE activities
SET module_id = 'e0000000-0000-0000-0000-000000000003'
WHERE id::text LIKE 'd0300000-%';

-- Module 4 activities (ID starts with 'd0400000')
UPDATE activities
SET module_id = 'e0000000-0000-0000-0000-000000000004'
WHERE id::text LIKE 'd0400000-%';

-- Module 5 activities (ID starts with 'd0500000')
UPDATE activities
SET module_id = 'e0000000-0000-0000-0000-000000000005'
WHERE id::text LIKE 'd0500000-%';

-- Module 6 activities (ID starts with 'd0600000')
UPDATE activities
SET module_id = 'e0000000-0000-0000-0000-000000000006'
WHERE id::text LIKE 'd0600000-%';

-- Module 7 activities (ID starts with 'd0700000')
UPDATE activities
SET module_id = 'e0000000-0000-0000-0000-000000000007'
WHERE id::text LIKE 'd0700000-%';

-- Module 8 activities (ID starts with 'd0800000')
UPDATE activities
SET module_id = 'e0000000-0000-0000-0000-000000000008'
WHERE id::text LIKE 'd0800000-%';

-- Also update Swiss Motel Capstone activities (from migration 096)
-- These may have different ID patterns (d09... or similar)
UPDATE activities
SET module_id = 'e0000000-0000-0000-0000-000000000008'
WHERE id::text LIKE 'd0900000-%';

-- ============================================
-- Step 3: Verification
-- ============================================

DO $$
DECLARE
  v_ma_modules INTEGER;
  v_ma_activities INTEGER;
  v_ct_modules INTEGER;
  v_ct_activities INTEGER;
BEGIN
  -- Count MA modules (should be 8)
  SELECT COUNT(*) INTO v_ma_modules
  FROM modules
  WHERE course_id = 'c0000000-0000-0000-0000-000000000004';
  
  -- Count MA activities
  SELECT COUNT(*) INTO v_ma_activities
  FROM activities a
  JOIN modules m ON a.module_id = m.id
  WHERE m.course_id = 'c0000000-0000-0000-0000-000000000004';
  
  -- Count CT modules (should be 17)
  SELECT COUNT(*) INTO v_ct_modules
  FROM modules
  WHERE course_id = 'c0000000-0000-0000-0000-000000000001';
  
  -- Count CT activities
  SELECT COUNT(*) INTO v_ct_activities
  FROM activities a
  JOIN modules m ON a.module_id = m.id
  WHERE m.course_id = 'c0000000-0000-0000-0000-000000000001';
  
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'MA Module ID Fix Complete';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'Managerial Accounting: % modules, % activities', v_ma_modules, v_ma_activities;
  RAISE NOTICE 'Computational Thinking: % modules, % activities', v_ct_modules, v_ct_activities;
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  
  IF v_ma_modules >= 8 THEN
    RAISE NOTICE 'SUCCESS: MA modules are now correctly linked.';
  ELSE
    RAISE WARNING 'WARNING: Expected 8 MA modules, found %', v_ma_modules;
  END IF;
END $$;

