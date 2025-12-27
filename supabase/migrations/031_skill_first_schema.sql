-- ============================================
-- Skill-First Architecture Schema Updates
-- Phase 1: Database Schema Changes
-- ============================================

-- ============================================
-- 1.1 Enhance activity_skills table
-- Add ordering support for activity sequences within skills
-- ============================================

-- Add order_index column for activity ordering within a skill
ALTER TABLE activity_skills 
  ADD COLUMN IF NOT EXISTS order_index INT DEFAULT 0;

-- Add is_owner column to mark primary ownership (skill "owns" this activity)
ALTER TABLE activity_skills 
  ADD COLUMN IF NOT EXISTS is_owner BOOLEAN DEFAULT false;

-- Create index for efficient ordering queries
CREATE INDEX IF NOT EXISTS idx_activity_skills_order 
  ON activity_skills(skill_id, order_index) 
  WHERE is_owner = true;

-- ============================================
-- 1.2 Make module_id optional on activities
-- This allows activities to exist without modules
-- ============================================

ALTER TABLE activities 
  ALTER COLUMN module_id DROP NOT NULL;

-- ============================================
-- 1.3 Add helper function to get activities for a skill
-- Returns activities in learning path order
-- ============================================

CREATE OR REPLACE FUNCTION get_skill_activities(p_skill_id UUID, p_user_id UUID DEFAULT NULL)
RETURNS TABLE (
  activity_id UUID,
  activity_title TEXT,
  activity_slug TEXT,
  activity_type activity_type,
  minutes INT,
  xp INT,
  order_index INT,
  is_completed BOOLEAN,
  score INT,
  attempts INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    a.id AS activity_id,
    a.title AS activity_title,
    a.slug AS activity_slug,
    a.type AS activity_type,
    a.minutes,
    a.xp,
    asks.order_index,
    COALESCE(ap.completed, false) AS is_completed,
    ap.score,
    COALESCE(ap.attempts, 0) AS attempts
  FROM activity_skills asks
  JOIN activities a ON asks.activity_id = a.id
  LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE asks.skill_id = p_skill_id
    AND asks.is_owner = true
    AND a.is_published = true
  ORDER BY asks.order_index ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 1.4 Add function to get next activity in skill path
-- ============================================

CREATE OR REPLACE FUNCTION get_next_skill_activity(p_skill_id UUID, p_user_id UUID)
RETURNS TABLE (
  activity_id UUID,
  activity_title TEXT,
  activity_slug TEXT,
  skill_slug TEXT,
  order_index INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    a.id AS activity_id,
    a.title AS activity_title,
    a.slug AS activity_slug,
    s.slug AS skill_slug,
    asks.order_index
  FROM activity_skills asks
  JOIN activities a ON asks.activity_id = a.id
  JOIN skills s ON asks.skill_id = s.id
  LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE asks.skill_id = p_skill_id
    AND asks.is_owner = true
    AND a.is_published = true
    AND (ap.completed IS NULL OR ap.completed = false)
  ORDER BY asks.order_index ASC
  LIMIT 1;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 1.5 Add function to get skill progress summary
-- ============================================

CREATE OR REPLACE FUNCTION get_skill_progress_summary(p_skill_id UUID, p_user_id UUID)
RETURNS TABLE (
  total_activities INT,
  completed_activities INT,
  total_xp INT,
  earned_xp INT,
  progress_percent INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COUNT(a.id)::INT AS total_activities,
    COUNT(ap.id) FILTER (WHERE ap.completed = true)::INT AS completed_activities,
    COALESCE(SUM(a.xp), 0)::INT AS total_xp,
    COALESCE(SUM(CASE WHEN ap.completed THEN ap.xp_earned ELSE 0 END), 0)::INT AS earned_xp,
    CASE 
      WHEN COUNT(a.id) > 0 THEN 
        (COUNT(ap.id) FILTER (WHERE ap.completed = true) * 100 / COUNT(a.id))::INT
      ELSE 0
    END AS progress_percent
  FROM activity_skills asks
  JOIN activities a ON asks.activity_id = a.id
  LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE asks.skill_id = p_skill_id
    AND asks.is_owner = true
    AND a.is_published = true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 1.6 Add function to get CT Foundations progress
-- For the separate foundations learning path
-- ============================================

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
    WHERE s.category = 'ct_foundations' AND s.is_active = true
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
    WHERE s.category = 'ct_foundations' AND s.is_active = true
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
  WHERE s.category = 'ct_foundations' AND s.is_active = true
  ORDER BY s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 1.7 Add function to get skill tree for coding skills only
-- Excludes ct_foundations category
-- ============================================

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

