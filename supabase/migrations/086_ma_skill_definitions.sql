-- ============================================
-- Managerial Accounting Skill Definitions
-- 31 skills across 8 categories with prerequisites
-- ============================================

-- ============================================
-- Add MA Skill Categories to Enum
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

-- Create new enum with all values (including existing + new MA categories)
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
  -- Existing BM categories
  'math_foundations',
  'basic_statistics',
  'ratios_percentages',
  'exponents_logs',
  'equations',
  'functions_graphs',
  'differential_calculus',
  'integral_calculus',
  -- NEW Managerial Accounting categories
  'ma_foundations',
  'cost_classification',
  'cost_behavior',
  'cvp_analysis',
  'costing_systems',
  'decision_making',
  'budgeting',
  'variance_analysis'
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
-- Category 1: MA Foundations Skills (3 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- MA-01: Managerial vs Financial Accounting
(
  'd0000000-0000-0000-0001-000000000001',
  'ma-managerial-vs-financial',
  'Managerial vs Financial Accounting',
  'Understand the key differences between managerial and financial accounting, their users, reports, and purposes in business decision-making.',
  'ma_foundations',
  'MA Foundations',
  1,
  25,
  300
),
-- MA-02: Cost Terminology Basics
(
  'd0000000-0000-0000-0001-000000000002',
  'ma-cost-terminology',
  'Cost Terminology Basics',
  'Master fundamental cost concepts including cost objects, cost drivers, cost pools, and the building blocks of managerial accounting vocabulary.',
  'ma_foundations',
  'MA Foundations',
  1,
  30,
  301
),
-- MA-03: Manufacturing Cost Flows
(
  'd0000000-0000-0000-0001-000000000003',
  'ma-manufacturing-cost-flows',
  'Manufacturing Cost Flows',
  'Trace how costs flow from raw materials through work-in-process to finished goods, understanding the manufacturing accounts.',
  'ma_foundations',
  'MA Foundations',
  2,
  35,
  302
);

-- ============================================
-- Category 2: Cost Classification Skills (3 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- MA-04: Direct vs Indirect Costs
(
  'd0000000-0000-0000-0002-000000000001',
  'ma-direct-indirect-costs',
  'Direct vs Indirect Costs',
  'Classify costs as direct or indirect based on traceability to cost objects. Essential for accurate product costing in hospitality.',
  'cost_classification',
  'Cost Classification',
  2,
  30,
  310
),
-- MA-05: Product vs Period Costs
(
  'd0000000-0000-0000-0002-000000000002',
  'ma-product-period-costs',
  'Product vs Period Costs',
  'Distinguish between inventoriable product costs and period costs, understanding their impact on financial statements.',
  'cost_classification',
  'Cost Classification',
  2,
  25,
  311
),
-- MA-06: Prime Costs & Conversion Costs
(
  'd0000000-0000-0000-0002-000000000003',
  'ma-prime-conversion-costs',
  'Prime Costs & Conversion Costs',
  'Calculate and apply prime costs (DM + DL) and conversion costs (DL + MOH). Understand the overlap and manufacturing cost relationships.',
  'cost_classification',
  'Cost Classification',
  2,
  25,
  312
);

-- ============================================
-- Category 3: Cost Behavior Skills (4 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- MA-07: Variable Costs
(
  'd0000000-0000-0000-0003-000000000001',
  'ma-variable-costs',
  'Variable Costs',
  'Understand variable cost behavior - constant per unit, varying in total with activity level. Apply to hospitality scenarios.',
  'cost_behavior',
  'Cost Behavior',
  2,
  25,
  320
),
-- MA-08: Fixed Costs
(
  'd0000000-0000-0000-0003-000000000002',
  'ma-fixed-costs',
  'Fixed Costs',
  'Master fixed cost behavior - constant in total, varying per unit. Recognize committed vs discretionary fixed costs.',
  'cost_behavior',
  'Cost Behavior',
  2,
  25,
  321
),
-- MA-09: Mixed Costs & High-Low Method
(
  'd0000000-0000-0000-0003-000000000003',
  'ma-mixed-costs-high-low',
  'Mixed Costs & High-Low Method',
  'Separate mixed costs into fixed and variable components using the high-low method. Essential for cost estimation.',
  'cost_behavior',
  'Cost Behavior',
  3,
  35,
  322
),
-- MA-10: Contribution Margin Format
(
  'd0000000-0000-0000-0003-000000000004',
  'ma-contribution-margin-format',
  'Contribution Margin Format',
  'Prepare and interpret contribution margin income statements. Understand CM per unit and CM ratio for decision making.',
  'cost_behavior',
  'Cost Behavior',
  2,
  30,
  323
);

-- ============================================
-- Category 4: CVP Analysis Skills (5 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- MA-11: Break-Even Analysis
(
  'd0000000-0000-0000-0004-000000000001',
  'ma-break-even-analysis',
  'Break-Even Analysis',
  'Calculate break-even point in units and sales dollars. Understand the CVP graph and profit-volume relationship.',
  'cvp_analysis',
  'CVP Analysis',
  3,
  40,
  330
),
-- MA-12: Target Profit Analysis
(
  'd0000000-0000-0000-0004-000000000002',
  'ma-target-profit',
  'Target Profit Analysis',
  'Determine required sales volume to achieve target profit. Apply to hotel and restaurant goal-setting scenarios.',
  'cvp_analysis',
  'CVP Analysis',
  3,
  30,
  331
),
-- MA-13: Margin of Safety
(
  'd0000000-0000-0000-0004-000000000003',
  'ma-margin-of-safety',
  'Margin of Safety',
  'Calculate margin of safety in units, dollars, and percentage. Assess business risk and cushion above break-even.',
  'cvp_analysis',
  'CVP Analysis',
  2,
  25,
  332
),
-- MA-14: Operating Leverage
(
  'd0000000-0000-0000-0004-000000000004',
  'ma-operating-leverage',
  'Operating Leverage',
  'Compute degree of operating leverage (DOL) and understand profit sensitivity to sales changes.',
  'cvp_analysis',
  'CVP Analysis',
  3,
  30,
  333
),
-- MA-15: Sales Mix Analysis
(
  'd0000000-0000-0000-0004-000000000005',
  'ma-sales-mix-analysis',
  'Sales Mix Analysis',
  'Apply CVP analysis to multi-product scenarios using weighted average contribution margin. Analyze product mix decisions.',
  'cvp_analysis',
  'CVP Analysis',
  3,
  35,
  334
);

-- ============================================
-- Category 5: Costing Systems Skills (4 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- MA-16: Job-Order Costing Fundamentals
(
  'd0000000-0000-0000-0005-000000000001',
  'ma-job-order-costing',
  'Job-Order Costing Fundamentals',
  'Apply job-order costing to unique products or services. Build job cost sheets and track costs for catering events and custom orders.',
  'costing_systems',
  'Costing Systems',
  3,
  35,
  340
),
-- MA-17: Predetermined Overhead Rates
(
  'd0000000-0000-0000-0005-000000000002',
  'ma-predetermined-overhead-rates',
  'Predetermined Overhead Rates',
  'Calculate and apply predetermined overhead rates (POHR). Understand allocation bases and their impact on product costs.',
  'costing_systems',
  'Costing Systems',
  3,
  35,
  341
),
-- MA-18: Over/Under Applied Overhead
(
  'd0000000-0000-0000-0005-000000000003',
  'ma-over-under-applied-overhead',
  'Over/Under Applied Overhead',
  'Reconcile actual and applied overhead. Handle overapplied and underapplied overhead at period end.',
  'costing_systems',
  'Costing Systems',
  3,
  30,
  342
),
-- MA-19: Service Department Cost Allocation
(
  'd0000000-0000-0000-0005-000000000004',
  'ma-service-dept-allocation',
  'Service Department Cost Allocation',
  'Allocate service department costs using direct and step-down methods. Apply to hotel support services like IT and HR.',
  'costing_systems',
  'Costing Systems',
  3,
  40,
  343
);

-- ============================================
-- Category 6: Decision Making Skills (4 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- MA-20: Relevant vs Irrelevant Costs
(
  'd0000000-0000-0000-0006-000000000001',
  'ma-relevant-costs',
  'Relevant vs Irrelevant Costs',
  'Identify differential, avoidable, and sunk costs. Focus decision analysis on costs that matter for the choice at hand.',
  'decision_making',
  'Decision Making',
  3,
  30,
  350
),
-- MA-21: Make or Buy Decisions
(
  'd0000000-0000-0000-0006-000000000002',
  'ma-make-or-buy',
  'Make or Buy Decisions',
  'Analyze outsourcing decisions considering quantitative and qualitative factors. Apply to hotel laundry and restaurant food production.',
  'decision_making',
  'Decision Making',
  3,
  35,
  351
),
-- MA-22: Special Order Decisions
(
  'd0000000-0000-0000-0006-000000000003',
  'ma-special-order',
  'Special Order Decisions',
  'Evaluate one-time special orders using incremental analysis. Consider capacity constraints and long-term implications.',
  'decision_making',
  'Decision Making',
  3,
  30,
  352
),
-- MA-23: Keep or Drop Decisions
(
  'd0000000-0000-0000-0006-000000000004',
  'ma-keep-or-drop',
  'Keep or Drop Decisions',
  'Analyze segment profitability focusing on avoidable costs. Decide whether to retain or eliminate product lines or departments.',
  'decision_making',
  'Decision Making',
  3,
  30,
  353
);

-- ============================================
-- Category 7: Budgeting Skills (4 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- MA-24: Master Budget Overview
(
  'd0000000-0000-0000-0007-000000000001',
  'ma-master-budget',
  'Master Budget Overview',
  'Understand the components of a master budget and how operating and financial budgets interconnect.',
  'budgeting',
  'Budgeting',
  2,
  30,
  360
),
-- MA-25: Sales & Production Budgets
(
  'd0000000-0000-0000-0007-000000000002',
  'ma-sales-production-budgets',
  'Sales & Production Budgets',
  'Prepare sales budgets and production budgets including desired ending inventory calculations.',
  'budgeting',
  'Budgeting',
  3,
  35,
  361
),
-- MA-26: Cash Budget
(
  'd0000000-0000-0000-0007-000000000003',
  'ma-cash-budget',
  'Cash Budget',
  'Build cash budgets with collections schedules and disbursement patterns. Identify financing needs for seasonal businesses.',
  'budgeting',
  'Budgeting',
  3,
  40,
  362
),
-- MA-27: Flexible Budgets
(
  'd0000000-0000-0000-0007-000000000004',
  'ma-flexible-budgets',
  'Flexible Budgets',
  'Prepare flexible budgets that adjust for actual activity levels. Compare static vs flexible budget performance.',
  'budgeting',
  'Budgeting',
  3,
  30,
  363
);

-- ============================================
-- Category 8: Variance Analysis Skills (4 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, category_label, difficulty_level, estimated_minutes, sort_order) VALUES
-- MA-28: Standard Costing Basics
(
  'd0000000-0000-0000-0008-000000000001',
  'ma-standard-costing',
  'Standard Costing Basics',
  'Understand standard costs, standard cost cards, and the purpose of standards for planning and control.',
  'variance_analysis',
  'Variance Analysis',
  3,
  30,
  370
),
-- MA-29: Direct Materials Variances
(
  'd0000000-0000-0000-0008-000000000002',
  'ma-materials-variances',
  'Direct Materials Variances',
  'Calculate and interpret materials price variance and materials quantity variance. Identify causes and responsibilities.',
  'variance_analysis',
  'Variance Analysis',
  3,
  35,
  371
),
-- MA-30: Direct Labor Variances
(
  'd0000000-0000-0000-0008-000000000003',
  'ma-labor-variances',
  'Direct Labor Variances',
  'Calculate labor rate variance and labor efficiency variance. Analyze housekeeping and kitchen staff performance.',
  'variance_analysis',
  'Variance Analysis',
  3,
  35,
  372
),
-- MA-31: Overhead Variances
(
  'd0000000-0000-0000-0008-000000000004',
  'ma-overhead-variances',
  'Overhead Variances',
  'Analyze variable overhead spending and efficiency variances, and fixed overhead budget and volume variances.',
  'variance_analysis',
  'Variance Analysis',
  4,
  40,
  373
);

-- ============================================
-- Skill Prerequisites
-- ============================================

INSERT INTO skill_prerequisites (skill_id, prerequisite_skill_id, is_required) VALUES
-- MA Foundations prerequisites
('d0000000-0000-0000-0001-000000000002', 'd0000000-0000-0000-0001-000000000001', true),  -- Cost Terminology requires MA vs FA
('d0000000-0000-0000-0001-000000000003', 'd0000000-0000-0000-0001-000000000002', true),  -- Manufacturing Flows requires Cost Terminology

-- Cost Classification prerequisites
('d0000000-0000-0000-0002-000000000001', 'd0000000-0000-0000-0001-000000000002', true),  -- Direct/Indirect requires Cost Terminology
('d0000000-0000-0000-0002-000000000002', 'd0000000-0000-0000-0002-000000000001', true),  -- Product/Period requires Direct/Indirect
('d0000000-0000-0000-0002-000000000003', 'd0000000-0000-0000-0002-000000000001', true),  -- Prime/Conversion requires Direct/Indirect

-- Cost Behavior prerequisites
('d0000000-0000-0000-0003-000000000001', 'd0000000-0000-0000-0002-000000000002', true),  -- Variable Costs requires Product/Period
('d0000000-0000-0000-0003-000000000002', 'd0000000-0000-0000-0003-000000000001', true),  -- Fixed Costs requires Variable Costs
('d0000000-0000-0000-0003-000000000003', 'd0000000-0000-0000-0003-000000000002', true),  -- Mixed Costs requires Fixed Costs
('d0000000-0000-0000-0003-000000000004', 'd0000000-0000-0000-0003-000000000002', true),  -- CM Format requires Fixed Costs

-- CVP Analysis prerequisites
('d0000000-0000-0000-0004-000000000001', 'd0000000-0000-0000-0003-000000000004', true),  -- Break-Even requires CM Format
('d0000000-0000-0000-0004-000000000002', 'd0000000-0000-0000-0004-000000000001', true),  -- Target Profit requires Break-Even
('d0000000-0000-0000-0004-000000000003', 'd0000000-0000-0000-0004-000000000001', true),  -- Margin of Safety requires Break-Even
('d0000000-0000-0000-0004-000000000004', 'd0000000-0000-0000-0004-000000000003', true),  -- Operating Leverage requires Margin of Safety
('d0000000-0000-0000-0004-000000000005', 'd0000000-0000-0000-0004-000000000002', true),  -- Sales Mix requires Target Profit

-- Costing Systems prerequisites
('d0000000-0000-0000-0005-000000000001', 'd0000000-0000-0000-0001-000000000003', true),  -- Job-Order requires Manufacturing Flows
('d0000000-0000-0000-0005-000000000002', 'd0000000-0000-0000-0005-000000000001', true),  -- POHR requires Job-Order
('d0000000-0000-0000-0005-000000000003', 'd0000000-0000-0000-0005-000000000002', true),  -- Over/Under Overhead requires POHR
('d0000000-0000-0000-0005-000000000004', 'd0000000-0000-0000-0005-000000000002', true),  -- Service Dept requires POHR

-- Decision Making prerequisites
('d0000000-0000-0000-0006-000000000001', 'd0000000-0000-0000-0003-000000000004', true),  -- Relevant Costs requires CM Format
('d0000000-0000-0000-0006-000000000002', 'd0000000-0000-0000-0006-000000000001', true),  -- Make or Buy requires Relevant Costs
('d0000000-0000-0000-0006-000000000003', 'd0000000-0000-0000-0006-000000000001', true),  -- Special Order requires Relevant Costs
('d0000000-0000-0000-0006-000000000004', 'd0000000-0000-0000-0006-000000000001', true),  -- Keep or Drop requires Relevant Costs

-- Budgeting prerequisites
('d0000000-0000-0000-0007-000000000001', 'd0000000-0000-0000-0003-000000000004', true),  -- Master Budget requires CM Format
('d0000000-0000-0000-0007-000000000002', 'd0000000-0000-0000-0007-000000000001', true),  -- Sales/Production requires Master Budget
('d0000000-0000-0000-0007-000000000003', 'd0000000-0000-0000-0007-000000000002', true),  -- Cash Budget requires Sales/Production
('d0000000-0000-0000-0007-000000000004', 'd0000000-0000-0000-0007-000000000001', true),  -- Flexible Budgets requires Master Budget

-- Variance Analysis prerequisites
('d0000000-0000-0000-0008-000000000001', 'd0000000-0000-0000-0007-000000000004', true),  -- Standard Costing requires Flexible Budgets
('d0000000-0000-0000-0008-000000000002', 'd0000000-0000-0000-0008-000000000001', true),  -- Materials Variances requires Standard Costing
('d0000000-0000-0000-0008-000000000003', 'd0000000-0000-0000-0008-000000000001', true),  -- Labor Variances requires Standard Costing
('d0000000-0000-0000-0008-000000000004', 'd0000000-0000-0000-0008-000000000002', true);  -- Overhead Variances requires Materials Variances

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
DECLARE
  foundation_category skill_category;
BEGIN
  -- Determine which foundation category to use based on course
  SELECT 
    CASE 
      WHEN c.slug = 'computational-thinking' THEN 'ct_foundations'::skill_category
      WHEN c.slug = 'financial-accounting' THEN 'fa_foundations'::skill_category
      WHEN c.slug = 'business-mathematics' THEN 'math_foundations'::skill_category
      WHEN c.slug = 'managerial-accounting' THEN 'ma_foundations'::skill_category
      ELSE 'ct_foundations'::skill_category
    END INTO foundation_category
  FROM courses c
  WHERE c.id = p_course_id;

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
  FROM get_course_skills(p_course_id, p_user_id, foundation_category) cs;
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
DECLARE
  foundation_category skill_category;
BEGIN
  -- Determine which foundation category to exclude based on course
  SELECT 
    CASE 
      WHEN c.slug = 'computational-thinking' THEN 'ct_foundations'::skill_category
      WHEN c.slug = 'financial-accounting' THEN 'fa_foundations'::skill_category
      WHEN c.slug = 'business-mathematics' THEN 'math_foundations'::skill_category
      WHEN c.slug = 'managerial-accounting' THEN 'ma_foundations'::skill_category
      ELSE 'ct_foundations'::skill_category
    END INTO foundation_category
  FROM courses c
  WHERE c.id = p_course_id;

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
    WHERE s.course_id = p_course_id AND s.is_active = true AND s.category != foundation_category
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
  WHERE s.course_id = p_course_id AND s.is_active = true AND s.category != foundation_category
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
DECLARE
  foundation_category skill_category;
BEGIN
  -- Determine which foundation category based on course
  SELECT 
    CASE 
      WHEN c.slug = 'computational-thinking' THEN 'ct_foundations'::skill_category
      WHEN c.slug = 'financial-accounting' THEN 'fa_foundations'::skill_category
      WHEN c.slug = 'business-mathematics' THEN 'math_foundations'::skill_category
      WHEN c.slug = 'managerial-accounting' THEN 'ma_foundations'::skill_category
      ELSE 'ct_foundations'::skill_category
    END INTO foundation_category
  FROM courses c
  WHERE c.id = p_course_id;

  RETURN QUERY
  WITH skill_stats AS (
    SELECT 
      s.category = foundation_category AS is_foundation,
      COUNT(*)::INT AS total,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) >= 70)::INT AS mastered,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) > 0 AND COALESCE(usp.mastery_level, 0) < 70)::INT AS in_progress
    FROM skills s
    LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true
    GROUP BY s.category = foundation_category
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

