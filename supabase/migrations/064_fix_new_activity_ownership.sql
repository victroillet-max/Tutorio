-- ============================================
-- Fix New Activity Ownership
-- Sets is_owner=true for newly added FA activities
-- so they appear in skill activity counts
-- ============================================

-- The activity_skills table uses is_owner to determine
-- which skill "owns" an activity (for displaying in skill pages).
-- Migrations 053-063 only set is_primary, not is_owner.

-- ============================================
-- Set is_owner = true for all new FA activity_skills
-- where is_primary = true
-- ============================================

UPDATE activity_skills
SET is_owner = true
WHERE is_primary = true
  AND is_owner = false
  AND activity_id IN (
    SELECT a.id FROM activities a
    JOIN modules m ON a.module_id = m.id
    WHERE m.course_id = 'c0000000-0000-0000-0000-000000000002'
  );

-- ============================================
-- Verify the update
-- ============================================

-- This should show activity counts > 0 for FA skills
DO $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM activity_skills asks
  JOIN activities a ON asks.activity_id = a.id
  JOIN modules m ON a.module_id = m.id
  WHERE m.course_id = 'c0000000-0000-0000-0000-000000000002'
    AND asks.is_owner = true;
    
  RAISE NOTICE 'FA activities with is_owner=true: %', v_count;
END $$;

