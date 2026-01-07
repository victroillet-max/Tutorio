-- ============================================
-- Fix for MA Activity Ownership
-- Ensures is_owner=true for all MA activity_skills entries
-- where is_primary=true, so activities appear in skill pages
-- ============================================

-- The issue: MA activities added in migrations 088-096
-- have is_primary=true but missing is_owner=true, causing 
-- "No Activity" to display on skill pages.

-- ============================================
-- Step 1: Set is_owner = true for ALL MA activity_skills
-- Identify MA skills by their skill_id prefix (d0000000-0000-0000-000X)
-- ============================================

UPDATE activity_skills
SET is_owner = true
WHERE is_primary = true
  AND skill_id IN (
    SELECT id FROM skills WHERE slug LIKE 'ma-%'
  );

-- ============================================
-- Step 2: Set proper order_index for MA activities without one
-- Based on the activity's order_index within its module
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
  JOIN skills s ON asks.skill_id = s.id
  WHERE s.slug LIKE 'ma-%'
    AND asks.is_owner = true
    AND (asks.order_index = 0 OR asks.order_index IS NULL)
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
  v_total_entries INTEGER;
  v_with_owner INTEGER;
BEGIN
  -- Count total MA activity_skills entries
  SELECT COUNT(*) INTO v_total_entries
  FROM activity_skills asks
  JOIN skills s ON asks.skill_id = s.id
  WHERE s.slug LIKE 'ma-%';
  
  -- Count MA activity_skills with is_owner=true
  SELECT COUNT(*) INTO v_with_owner
  FROM activity_skills asks
  JOIN skills s ON asks.skill_id = s.id
  WHERE s.slug LIKE 'ma-%'
    AND asks.is_owner = true;
  
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'MA Activity Ownership Fix Complete';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'Total MA activity_skills entries: %', v_total_entries;
  RAISE NOTICE 'Entries with is_owner=true: %', v_with_owner;
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  
  IF v_with_owner > 0 THEN
    RAISE NOTICE 'SUCCESS: MA activities now have proper ownership.';
  ELSE
    RAISE WARNING 'No MA activity_skills entries found or updated!';
  END IF;
END $$;

