-- ============================================
-- Skills Database Schema
-- Part of CT Course Restructure Plan
-- ============================================

-- ============================================
-- Skill Category Enum
-- ============================================

CREATE TYPE skill_category AS ENUM (
  'ct_foundations',      -- Computational Thinking foundations
  'python_basics',       -- Python fundamentals
  'control_flow',        -- Conditionals and loops
  'data_structures',     -- Lists, dictionaries, etc.
  'functions',           -- Function definitions and usage
  'advanced_topics'      -- File handling, exceptions, libraries
);

-- ============================================
-- Skills Table
-- ============================================

CREATE TABLE skills (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT NOT NULL UNIQUE,            -- 'ct-decomposition', 'py-variables', etc.
  name TEXT NOT NULL,                    -- 'Decomposition', 'Variables', etc.
  description TEXT,
  category skill_category NOT NULL,
  difficulty_level INT DEFAULT 1 CHECK (difficulty_level BETWEEN 1 AND 5),
  estimated_minutes INT DEFAULT 30,
  icon TEXT,                             -- Icon identifier
  color TEXT,                            -- Color for UI
  sort_order INT DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

CREATE INDEX idx_skills_slug ON skills(slug);
CREATE INDEX idx_skills_category ON skills(category);
CREATE INDEX idx_skills_active ON skills(is_active);

-- ============================================
-- Skill Prerequisites
-- ============================================

CREATE TABLE skill_prerequisites (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  skill_id UUID NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
  prerequisite_skill_id UUID NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
  is_required BOOLEAN DEFAULT true,     -- Required vs recommended
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  
  CONSTRAINT unique_skill_prerequisite UNIQUE(skill_id, prerequisite_skill_id),
  CONSTRAINT no_self_prerequisite CHECK (skill_id != prerequisite_skill_id)
);

CREATE INDEX idx_skill_prereqs_skill ON skill_prerequisites(skill_id);
CREATE INDEX idx_skill_prereqs_prereq ON skill_prerequisites(prerequisite_skill_id);

-- ============================================
-- Activity Skills (Many-to-Many)
-- ============================================

CREATE TABLE activity_skills (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  activity_id UUID NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
  skill_id UUID NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
  is_primary BOOLEAN DEFAULT false,     -- Primary skill taught by this activity
  teaches BOOLEAN DEFAULT true,         -- Does it teach or just require the skill?
  weight DECIMAL(3, 2) DEFAULT 1.0,     -- Weight for mastery calculation (0.0 - 1.0)
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  
  CONSTRAINT unique_activity_skill UNIQUE(activity_id, skill_id)
);

CREATE INDEX idx_activity_skills_activity ON activity_skills(activity_id);
CREATE INDEX idx_activity_skills_skill ON activity_skills(skill_id);
CREATE INDEX idx_activity_skills_primary ON activity_skills(skill_id) WHERE is_primary = true;

-- ============================================
-- Question Skills (Many-to-Many)
-- For tagging individual quiz questions with skills
-- ============================================

CREATE TABLE question_skills (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  activity_id UUID NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
  question_id TEXT NOT NULL,            -- ID of the question within the activity's content
  skill_id UUID NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
  weight DECIMAL(3, 2) DEFAULT 1.0,     -- Weight for skill mastery calculation
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  
  CONSTRAINT unique_question_skill UNIQUE(activity_id, question_id, skill_id)
);

CREATE INDEX idx_question_skills_activity ON question_skills(activity_id);
CREATE INDEX idx_question_skills_skill ON question_skills(skill_id);

-- ============================================
-- User Skill Progress
-- ============================================

CREATE TABLE user_skill_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  skill_id UUID NOT NULL REFERENCES skills(id) ON DELETE CASCADE,
  mastery_level INT DEFAULT 0 CHECK (mastery_level BETWEEN 0 AND 100),
  times_practiced INT DEFAULT 0,
  correct_answers INT DEFAULT 0,
  total_answers INT DEFAULT 0,
  last_practiced_at TIMESTAMPTZ,
  first_practiced_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  
  CONSTRAINT unique_user_skill UNIQUE(user_id, skill_id)
);

CREATE INDEX idx_user_skill_progress_user ON user_skill_progress(user_id);
CREATE INDEX idx_user_skill_progress_skill ON user_skill_progress(skill_id);
CREATE INDEX idx_user_skill_progress_mastery ON user_skill_progress(user_id, mastery_level);

-- ============================================
-- Diagnostic Quiz Results
-- ============================================

CREATE TABLE diagnostic_results (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  skill_cluster TEXT NOT NULL,          -- e.g., 'control_flow', 'data_structures'
  total_questions INT NOT NULL,
  correct_answers INT NOT NULL,
  score INT NOT NULL CHECK (score BETWEEN 0 AND 100),
  gaps_identified UUID[],               -- Array of skill IDs that need review
  recommendations JSONB,                 -- AI-generated or system recommendations
  completed_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

CREATE INDEX idx_diagnostic_results_user ON diagnostic_results(user_id);
CREATE INDEX idx_diagnostic_results_cluster ON diagnostic_results(skill_cluster);

-- ============================================
-- Enable RLS
-- ============================================

ALTER TABLE skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE skill_prerequisites ENABLE ROW LEVEL SECURITY;
ALTER TABLE activity_skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_skills ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_skill_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE diagnostic_results ENABLE ROW LEVEL SECURITY;

-- ============================================
-- RLS Policies
-- ============================================

-- Skills: Anyone can view active skills
CREATE POLICY "Anyone can view active skills"
  ON skills FOR SELECT
  USING (is_active = true);

-- Admins can manage skills
CREATE POLICY "Admins can manage skills"
  ON skills FOR ALL
  USING (is_admin());

-- Skill Prerequisites: Anyone can view
CREATE POLICY "Anyone can view skill prerequisites"
  ON skill_prerequisites FOR SELECT
  USING (true);

-- Admins can manage skill prerequisites
CREATE POLICY "Admins can manage skill prerequisites"
  ON skill_prerequisites FOR ALL
  USING (is_admin());

-- Activity Skills: Anyone can view
CREATE POLICY "Anyone can view activity skills"
  ON activity_skills FOR SELECT
  USING (true);

-- Admins can manage activity skills
CREATE POLICY "Admins can manage activity skills"
  ON activity_skills FOR ALL
  USING (is_admin());

-- Question Skills: Anyone can view
CREATE POLICY "Anyone can view question skills"
  ON question_skills FOR SELECT
  USING (true);

-- Admins can manage question skills
CREATE POLICY "Admins can manage question skills"
  ON question_skills FOR ALL
  USING (is_admin());

-- User Skill Progress: Users can manage their own
CREATE POLICY "Users can view own skill progress"
  ON user_skill_progress FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create own skill progress"
  ON user_skill_progress FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own skill progress"
  ON user_skill_progress FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Admins can view all skill progress
CREATE POLICY "Admins can view all skill progress"
  ON user_skill_progress FOR SELECT
  USING (is_admin());

-- Diagnostic Results: Users can manage their own
CREATE POLICY "Users can view own diagnostic results"
  ON diagnostic_results FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create own diagnostic results"
  ON diagnostic_results FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Admins can view all diagnostic results
CREATE POLICY "Admins can view all diagnostic results"
  ON diagnostic_results FOR SELECT
  USING (is_admin());

-- ============================================
-- Triggers
-- ============================================

CREATE TRIGGER update_skills_updated_at
  BEFORE UPDATE ON skills
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_skill_progress_updated_at
  BEFORE UPDATE ON user_skill_progress
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- Helper Functions
-- ============================================

-- Get skill mastery for a user
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

-- Get skill prerequisites with mastery status
CREATE OR REPLACE FUNCTION get_skill_prerequisites_status(p_user_id UUID, p_skill_id UUID)
RETURNS TABLE (
  prerequisite_skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  is_required BOOLEAN,
  mastery_level INT,
  is_mastered BOOLEAN
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    sp.prerequisite_skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    sp.is_required,
    COALESCE(usp.mastery_level, 0) AS mastery_level,
    COALESCE(usp.mastery_level, 0) >= 70 AS is_mastered
  FROM skill_prerequisites sp
  JOIN skills s ON sp.prerequisite_skill_id = s.id
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  WHERE sp.skill_id = p_skill_id
  ORDER BY s.sort_order;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Calculate skill mastery based on activity performance
CREATE OR REPLACE FUNCTION calculate_skill_mastery(
  p_user_id UUID,
  p_skill_id UUID
)
RETURNS INT AS $$
DECLARE
  v_total_weight DECIMAL;
  v_weighted_score DECIMAL;
  v_mastery INT;
BEGIN
  -- Calculate weighted average of activity scores for this skill
  SELECT 
    COALESCE(SUM(asks.weight), 0),
    COALESCE(SUM(
      CASE 
        WHEN ap.completed THEN asks.weight * COALESCE(ap.score, 100)
        ELSE 0
      END
    ), 0)
  INTO v_total_weight, v_weighted_score
  FROM activity_skills asks
  JOIN activities a ON asks.activity_id = a.id
  LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE asks.skill_id = p_skill_id;
  
  -- Calculate mastery (0-100)
  IF v_total_weight > 0 THEN
    v_mastery := ROUND(v_weighted_score / v_total_weight);
  ELSE
    v_mastery := 0;
  END IF;
  
  -- Update user skill progress
  INSERT INTO user_skill_progress (user_id, skill_id, mastery_level, last_practiced_at)
  VALUES (p_user_id, p_skill_id, v_mastery, now())
  ON CONFLICT (user_id, skill_id)
  DO UPDATE SET
    mastery_level = v_mastery,
    times_practiced = user_skill_progress.times_practiced + 1,
    last_practiced_at = now();
  
  RETURN v_mastery;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Get struggling skills for a user (mastery < 70%)
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

-- Search skills by name or description
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

