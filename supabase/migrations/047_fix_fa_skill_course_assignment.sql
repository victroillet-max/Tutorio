-- ============================================
-- Fix Financial Accounting Skills Course Assignment
-- Links FA skills to the FA course and updates
-- foundation detection to be course-agnostic
-- ============================================

-- ============================================
-- 1. Assign FA skills to the Financial Accounting course
-- ============================================

-- Set course_id for all FA Foundations skills
UPDATE skills 
SET 
  course_id = 'c0000000-0000-0000-0000-000000000002',
  category_label = 'Foundations'
WHERE category = 'fa_foundations' AND course_id IS NULL;

-- Set course_id for Balance Sheet skills
UPDATE skills 
SET 
  course_id = 'c0000000-0000-0000-0000-000000000002',
  category_label = 'Balance Sheet'
WHERE category = 'balance_sheet' AND course_id IS NULL;

-- Set course_id for Income Statement skills
UPDATE skills 
SET 
  course_id = 'c0000000-0000-0000-0000-000000000002',
  category_label = 'Income Statement'
WHERE category = 'income_statement' AND course_id IS NULL;

-- Set course_id for Adjustments skills
UPDATE skills 
SET 
  course_id = 'c0000000-0000-0000-0000-000000000002',
  category_label = 'Adjustments'
WHERE category = 'adjustments' AND course_id IS NULL;

-- Set course_id for Specialized Assets skills
UPDATE skills 
SET 
  course_id = 'c0000000-0000-0000-0000-000000000002',
  category_label = 'Specialized Assets'
WHERE category = 'specialized_assets' AND course_id IS NULL;

-- Set course_id for Cash Flow skills
UPDATE skills 
SET 
  course_id = 'c0000000-0000-0000-0000-000000000002',
  category_label = 'Cash Flow'
WHERE category = 'cash_flow' AND course_id IS NULL;

-- Set course_id for Financial Analysis skills
UPDATE skills 
SET 
  course_id = 'c0000000-0000-0000-0000-000000000002',
  category_label = 'Financial Analysis'
WHERE category = 'financial_analysis' AND course_id IS NULL;

-- ============================================
-- 2. Update get_course_foundations to be course-agnostic
-- Now detects foundations based on category naming pattern
-- (categories ending in '_foundations' are treated as foundations)
-- ============================================

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
    WHERE s.course_id = p_course_id 
      AND s.is_active = true
      AND s.category::text LIKE '%_foundations'
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
    s.sort_order,
    COALESCE(ac.total_acts, 0) AS total_activities,
    COALESCE(ac.completed_acts, 0) AS completed_activities,
    COALESCE(ps.prereq_count = ps.prereqs_met, true) AS is_available,
    COALESCE(usp.mastery_level, 0) AS mastery_level
  FROM skills s
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  LEFT JOIN prereq_status ps ON s.id = ps.id
  LEFT JOIN activity_counts ac ON s.id = ac.skill_id
  WHERE s.course_id = p_course_id 
    AND s.is_active = true
    AND s.category::text LIKE '%_foundations'
  ORDER BY s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 3. Update get_course_coding_skills to exclude all foundation categories
-- ============================================

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
    WHERE s.course_id = p_course_id 
      AND s.is_active = true 
      AND s.category::text NOT LIKE '%_foundations'
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
  WHERE s.course_id = p_course_id 
    AND s.is_active = true 
    AND s.category::text NOT LIKE '%_foundations'
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 4. Update get_course_skill_progress to use the new pattern
-- ============================================

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
      s.category::text LIKE '%_foundations' AS is_foundation,
      COUNT(*)::INT AS total,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) >= 70)::INT AS mastered,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) > 0 AND COALESCE(usp.mastery_level, 0) < 70)::INT AS in_progress
    FROM skills s
    LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true
    GROUP BY s.category::text LIKE '%_foundations'
  )
  SELECT 
    COALESCE((SELECT total FROM skill_stats WHERE is_foundation = true), 0) AS foundations_total,
    COALESCE((SELECT mastered FROM skill_stats WHERE is_foundation = true), 0) AS foundations_mastered,
    COALESCE((SELECT in_progress FROM skill_stats WHERE is_foundation = true), 0) AS foundations_in_progress,
    COALESCE((SELECT total FROM skill_stats WHERE is_foundation = false), 0) AS skills_total,
    COALESCE((SELECT mastered FROM skill_stats WHERE is_foundation = false), 0) AS skills_mastered,
    COALESCE((SELECT in_progress FROM skill_stats WHERE is_foundation = false), 0) AS skills_in_progress,
    CASE 
      WHEN COALESCE((SELECT SUM(total) FROM skill_stats), 0) > 0 THEN
        (COALESCE((SELECT SUM(mastered) FROM skill_stats), 0) * 100 / 
         COALESCE((SELECT SUM(total) FROM skill_stats), 1))::INT
      ELSE 0
    END AS overall_progress_percent;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 5. Update get_course_skills to use the new pattern
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

