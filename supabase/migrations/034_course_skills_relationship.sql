-- ============================================
-- Course-Skills Relationship Migration
-- Associates skills with specific courses/classes
-- ============================================

-- ============================================
-- 1. Add course_id to skills table
-- ============================================

ALTER TABLE skills 
  ADD COLUMN IF NOT EXISTS course_id UUID REFERENCES courses(id) ON DELETE SET NULL;

-- Create index for efficient course-based queries
CREATE INDEX IF NOT EXISTS idx_skills_course 
  ON skills(course_id);

-- Create composite index for category within a course
CREATE INDEX IF NOT EXISTS idx_skills_course_category 
  ON skills(course_id, category, sort_order);

-- ============================================
-- 2. Update the SkillCategory enum to be more generic
-- The categories are now relative to each course
-- ============================================

-- First, let's see what categories we have and update them to be more generic
-- ct_foundations -> foundations
-- python_basics -> basics  
-- control_flow -> intermediate
-- data_structures -> data_structures
-- functions -> functions
-- advanced_topics -> advanced

-- For backwards compatibility, we'll keep the existing categories
-- but add a new column for display purposes

ALTER TABLE skills 
  ADD COLUMN IF NOT EXISTS category_label TEXT;

-- ============================================
-- 3. Create or replace helper function to get course skills
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

-- ============================================
-- 4. Get course foundations (ct_foundations category)
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
  FROM get_course_skills(p_course_id, p_user_id, 'ct_foundations'::skill_category) cs;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 5. Get course coding skills (non-foundations)
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
    WHERE s.course_id = p_course_id AND s.is_active = true AND s.category != 'ct_foundations'
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
  WHERE s.course_id = p_course_id AND s.is_active = true AND s.category != 'ct_foundations'
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 6. Get course progress summary
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
      s.category = 'ct_foundations' AS is_foundation,
      COUNT(*)::INT AS total,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) >= 70)::INT AS mastered,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) > 0 AND COALESCE(usp.mastery_level, 0) < 70)::INT AS in_progress
    FROM skills s
    LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true
    GROUP BY s.category = 'ct_foundations'
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
-- 7. Link existing skills to the Computational Thinking course
-- ============================================

-- First, let's find or create the CT course
DO $$
DECLARE
  ct_course_id UUID;
BEGIN
  -- Try to find existing CT course
  SELECT id INTO ct_course_id 
  FROM courses 
  WHERE slug = 'computational-thinking' OR title ILIKE '%computational thinking%'
  LIMIT 1;
  
  -- If no CT course exists, create one
  IF ct_course_id IS NULL THEN
    INSERT INTO courses (
      title, 
      slug, 
      description, 
      short_description,
      difficulty, 
      is_published, 
      is_featured,
      sort_order
    ) VALUES (
      'Computational Thinking',
      'computational-thinking',
      'Master the fundamentals of Computational Thinking and Python programming. This comprehensive course covers problem decomposition, pattern recognition, abstraction, algorithmic thinking, and hands-on Python coding skills.',
      'Learn to think like a programmer with CT fundamentals and Python',
      'beginner',
      true,
      true,
      1
    )
    RETURNING id INTO ct_course_id;
  END IF;
  
  -- Update all existing skills to belong to this course
  UPDATE skills 
  SET course_id = ct_course_id 
  WHERE course_id IS NULL;
  
  -- Also update category_label for better display
  UPDATE skills SET category_label = 'Foundations' WHERE category = 'ct_foundations';
  UPDATE skills SET category_label = 'Python Basics' WHERE category = 'python_basics';
  UPDATE skills SET category_label = 'Control Flow' WHERE category = 'control_flow';
  UPDATE skills SET category_label = 'Data Structures' WHERE category = 'data_structures';
  UPDATE skills SET category_label = 'Functions' WHERE category = 'functions';
  UPDATE skills SET category_label = 'Advanced Topics' WHERE category = 'advanced_topics';
END $$;

-- ============================================
-- 8. Add user course enrollment for skill-based progress
-- ============================================

CREATE TABLE IF NOT EXISTS user_course_enrollment (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  course_id UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  enrolled_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  last_accessed_at TIMESTAMPTZ DEFAULT now(),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  
  CONSTRAINT unique_user_course_enrollment UNIQUE(user_id, course_id)
);

CREATE INDEX IF NOT EXISTS idx_user_course_enrollment_user 
  ON user_course_enrollment(user_id);
CREATE INDEX IF NOT EXISTS idx_user_course_enrollment_course 
  ON user_course_enrollment(course_id);
CREATE INDEX IF NOT EXISTS idx_user_course_enrollment_active 
  ON user_course_enrollment(user_id, is_active);

-- ============================================
-- 9. Function to get user's enrolled courses with progress
-- ============================================

CREATE OR REPLACE FUNCTION get_user_enrolled_courses(p_user_id UUID)
RETURNS TABLE (
  course_id UUID,
  course_slug TEXT,
  course_title TEXT,
  course_description TEXT,
  course_short_description TEXT,
  course_difficulty difficulty_level,
  enrolled_at TIMESTAMPTZ,
  last_accessed_at TIMESTAMPTZ,
  foundations_total INT,
  foundations_mastered INT,
  skills_total INT,
  skills_mastered INT,
  overall_progress_percent INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    c.id AS course_id,
    c.slug AS course_slug,
    c.title AS course_title,
    c.description AS course_description,
    c.short_description AS course_short_description,
    c.difficulty AS course_difficulty,
    uce.enrolled_at,
    uce.last_accessed_at,
    COALESCE(progress.foundations_total, 0),
    COALESCE(progress.foundations_mastered, 0),
    COALESCE(progress.skills_total, 0),
    COALESCE(progress.skills_mastered, 0),
    COALESCE(progress.overall_progress_percent, 0)
  FROM user_course_enrollment uce
  JOIN courses c ON uce.course_id = c.id
  LEFT JOIN LATERAL get_course_skill_progress(c.id, p_user_id) progress ON true
  WHERE uce.user_id = p_user_id AND uce.is_active = true
  ORDER BY uce.last_accessed_at DESC NULLS LAST;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 10. Auto-enroll function when user accesses a course
-- ============================================

CREATE OR REPLACE FUNCTION enroll_user_in_course(p_user_id UUID, p_course_id UUID)
RETURNS user_course_enrollment AS $$
DECLARE
  enrollment user_course_enrollment;
BEGIN
  INSERT INTO user_course_enrollment (user_id, course_id)
  VALUES (p_user_id, p_course_id)
  ON CONFLICT (user_id, course_id) 
  DO UPDATE SET last_accessed_at = now(), is_active = true
  RETURNING * INTO enrollment;
  
  RETURN enrollment;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 11. RLS Policies for user_course_enrollment
-- ============================================

ALTER TABLE user_course_enrollment ENABLE ROW LEVEL SECURITY;

-- Users can view their own enrollments
CREATE POLICY "Users can view own enrollments"
  ON user_course_enrollment FOR SELECT
  USING (auth.uid() = user_id);

-- Users can insert their own enrollments
CREATE POLICY "Users can create own enrollments"
  ON user_course_enrollment FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can update their own enrollments
CREATE POLICY "Users can update own enrollments"
  ON user_course_enrollment FOR UPDATE
  USING (auth.uid() = user_id);

-- Admins can view all enrollments
CREATE POLICY "Admins can view all enrollments"
  ON user_course_enrollment FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

