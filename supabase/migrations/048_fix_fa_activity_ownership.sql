-- ============================================
-- Fix Financial Accounting Activity Ownership
-- Sets is_owner=true for FA activity_skills records
-- so activities appear under their skills
-- ============================================

-- The activity_skills table uses is_owner to determine
-- which skill "owns" an activity (for displaying in skill pages).
-- Migration 046 only set is_primary, not is_owner.

-- ============================================
-- 1. Set is_owner = true for FA activity_skills where is_primary = true
-- ============================================

UPDATE activity_skills
SET is_owner = true
WHERE is_primary = true
  AND activity_id IN (
    SELECT id FROM activities 
    WHERE module_id IN (
      SELECT id FROM modules 
      WHERE course_id = 'c0000000-0000-0000-0000-000000000002'
    )
  )
  AND is_owner = false;

-- ============================================
-- 2. For activities without a primary skill tag, set the first one as owner
-- ============================================

-- Find FA activities that have skill tags but none have is_owner=true
-- and set the first one (highest weight) as owner

WITH fa_activities_without_owner AS (
  SELECT DISTINCT a.id as activity_id
  FROM activities a
  JOIN modules m ON a.module_id = m.id
  JOIN activity_skills asks ON a.id = asks.activity_id
  WHERE m.course_id = 'c0000000-0000-0000-0000-000000000002'
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
-- 3. Set order_index for FA activities under each skill
-- ============================================

WITH ranked_activities AS (
  SELECT 
    asks.activity_id,
    asks.skill_id,
    ROW_NUMBER() OVER (
      PARTITION BY asks.skill_id 
      ORDER BY a.order_index ASC, a.id
    ) as new_order_index
  FROM activity_skills asks
  JOIN activities a ON asks.activity_id = a.id
  JOIN modules m ON a.module_id = m.id
  WHERE m.course_id = 'c0000000-0000-0000-0000-000000000002'
    AND asks.is_owner = true
)
UPDATE activity_skills
SET order_index = ranked_activities.new_order_index
FROM ranked_activities
WHERE activity_skills.activity_id = ranked_activities.activity_id
  AND activity_skills.skill_id = ranked_activities.skill_id;

-- ============================================
-- 4. Verify the fix by checking activity counts per skill
-- ============================================

-- This should show non-zero activity counts for FA skills
-- SELECT 
--   s.name as skill_name,
--   COUNT(asks.activity_id) as activity_count
-- FROM skills s
-- LEFT JOIN activity_skills asks ON s.id = asks.skill_id AND asks.is_owner = true
-- LEFT JOIN activities a ON asks.activity_id = a.id AND a.is_published = true
-- WHERE s.course_id = 'c0000000-0000-0000-0000-000000000002'
-- GROUP BY s.id, s.name
-- ORDER BY s.sort_order;

