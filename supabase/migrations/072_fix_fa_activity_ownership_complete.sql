-- ============================================
-- Complete Fix for FA Activity Ownership
-- Ensures is_owner=true for all FA activity_skills entries
-- where is_primary=true, regardless of previous state
-- ============================================

-- The issue: Some FA activities added in migrations 053-063
-- have is_primary=true but is_owner=false, causing 404 errors
-- when accessing activities through skill pages.

-- ============================================
-- Step 1: Set is_owner = true for ALL FA activity_skills
-- where is_primary = true (ignore current is_owner value)
-- ============================================

UPDATE activity_skills
SET is_owner = true
WHERE is_primary = true
  AND activity_id IN (
    SELECT a.id FROM activities a
    JOIN modules m ON a.module_id = m.id
    WHERE m.course_id = 'c0000000-0000-0000-0000-000000000002'
  );

-- ============================================
-- Step 2: For activities that have skill links but no is_owner,
-- set the first/highest-weight one as owner
-- ============================================

WITH fa_activities_without_owner AS (
  SELECT DISTINCT a.id as activity_id
  FROM activities a
  JOIN modules m ON a.module_id = m.id
  LEFT JOIN activity_skills asks ON a.id = asks.activity_id
  WHERE m.course_id = 'c0000000-0000-0000-0000-000000000002'
    AND EXISTS (SELECT 1 FROM activity_skills WHERE activity_id = a.id)
    AND NOT EXISTS (
      SELECT 1 FROM activity_skills 
      WHERE activity_id = a.id AND is_owner = true
    )
),
first_skill_per_activity AS (
  SELECT DISTINCT ON (asks.activity_id)
    asks.activity_id,
    asks.skill_id
  FROM activity_skills asks
  JOIN fa_activities_without_owner fao ON asks.activity_id = fao.activity_id
  ORDER BY asks.activity_id, asks.weight DESC, asks.skill_id
)
UPDATE activity_skills
SET is_owner = true
FROM first_skill_per_activity fspa
WHERE activity_skills.activity_id = fspa.activity_id
  AND activity_skills.skill_id = fspa.skill_id;

-- ============================================
-- Step 3: Set proper order_index for activities without one
-- ============================================

WITH ranked_activities AS (
  SELECT 
    asks.activity_id,
    asks.skill_id,
    ROW_NUMBER() OVER (
      PARTITION BY asks.skill_id 
      ORDER BY a.order_index, a.id
    ) as new_order_index
  FROM activity_skills asks
  JOIN activities a ON asks.activity_id = a.id
  JOIN modules m ON a.module_id = m.id
  WHERE m.course_id = 'c0000000-0000-0000-0000-000000000002'
    AND asks.is_owner = true
    AND asks.order_index = 0
)
UPDATE activity_skills
SET order_index = ranked_activities.new_order_index
FROM ranked_activities
WHERE activity_skills.activity_id = ranked_activities.activity_id
  AND activity_skills.skill_id = ranked_activities.skill_id;

-- ============================================
-- Verification
-- ============================================

DO $$
DECLARE
  v_total_activities INTEGER;
  v_activities_with_owner INTEGER;
  v_activities_without_owner INTEGER;
BEGIN
  -- Count total FA activities with skill links
  SELECT COUNT(DISTINCT a.id) INTO v_total_activities
  FROM activities a
  JOIN modules m ON a.module_id = m.id
  JOIN activity_skills asks ON a.id = asks.activity_id
  WHERE m.course_id = 'c0000000-0000-0000-0000-000000000002';
  
  -- Count FA activities with is_owner=true
  SELECT COUNT(DISTINCT asks.activity_id) INTO v_activities_with_owner
  FROM activity_skills asks
  JOIN activities a ON asks.activity_id = a.id
  JOIN modules m ON a.module_id = m.id
  WHERE m.course_id = 'c0000000-0000-0000-0000-000000000002'
    AND asks.is_owner = true;
  
  v_activities_without_owner := v_total_activities - v_activities_with_owner;
  
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'FA Activity Ownership Fix Complete';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'Total FA activities with skill links: %', v_total_activities;
  RAISE NOTICE 'Activities with is_owner=true: %', v_activities_with_owner;
  RAISE NOTICE 'Activities still without owner: %', v_activities_without_owner;
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  
  IF v_activities_without_owner > 0 THEN
    RAISE WARNING 'Some activities still have no owner! Check activity_skills table.';
  ELSE
    RAISE NOTICE 'SUCCESS: All FA activities now have proper ownership.';
  END IF;
END $$;


