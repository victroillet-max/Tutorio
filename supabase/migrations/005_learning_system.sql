-- ============================================
-- Tutorio Database Schema - Part 5: Learning System
-- Modules, Activities, Badges, Progress, Streaks
-- ============================================

-- ============================================
-- New Enums
-- ============================================

-- Activity types for the learning system
CREATE TYPE activity_type AS ENUM (
  'lesson',      -- Markdown text with syntax highlighting
  'quiz',        -- MCQ, True/False, Fill-in-blank
  'code',        -- Monaco Editor + Pyodide
  'challenge',   -- Extended coding with hidden tests
  'interactive', -- Custom visualizers
  'checkpoint',  -- Module assessment (blocks progress)
  'mock_exam'    -- Timed exam simulation
);

-- Plan tier enum for access control
CREATE TYPE plan_tier AS ENUM ('free', 'basic', 'advanced');

-- ============================================
-- Modules Table
-- ============================================

CREATE TABLE modules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  external_id TEXT NOT NULL,           -- 'mod-01', 'mod-02', etc.
  order_index DECIMAL(5,2) NOT NULL,   -- Supports 6.5 for midterm mock
  title TEXT NOT NULL,
  slug TEXT NOT NULL,
  description TEXT,
  estimated_minutes INT,
  total_xp INT DEFAULT 0,
  required_plan plan_tier DEFAULT 'free',
  is_mock_exam BOOLEAN DEFAULT false,
  is_midterm_boundary BOOLEAN DEFAULT false,
  is_published BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  
  CONSTRAINT unique_module_per_course UNIQUE(course_id, slug),
  CONSTRAINT unique_module_order UNIQUE(course_id, order_index)
);

CREATE INDEX idx_modules_course ON modules(course_id);
CREATE INDEX idx_modules_order ON modules(course_id, order_index);

-- ============================================
-- Activities Table
-- ============================================

CREATE TABLE activities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id UUID NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  external_id TEXT NOT NULL,            -- '1.1', '1.2', etc.
  order_index INT NOT NULL,
  title TEXT NOT NULL,
  slug TEXT NOT NULL,
  type activity_type NOT NULL,
  minutes INT,
  xp INT DEFAULT 0,
  required_plan plan_tier DEFAULT 'free',
  
  -- Content storage (flexible JSONB for different activity types)
  content JSONB,
  
  -- Interactive-specific
  interactive_type TEXT,                -- 'drag-drop-match', 'tree-builder', etc.
  
  -- Code-specific
  starter_code TEXT,
  
  -- Quiz/Checkpoint/Exam specific
  passing_score INT DEFAULT 70,
  time_limit INT,                       -- In minutes, for timed activities
  blocks_progress BOOLEAN DEFAULT false,
  
  is_published BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  
  CONSTRAINT unique_activity_per_module UNIQUE(module_id, slug),
  CONSTRAINT unique_activity_order UNIQUE(module_id, order_index)
);

CREATE INDEX idx_activities_module ON activities(module_id);
CREATE INDEX idx_activities_order ON activities(module_id, order_index);
CREATE INDEX idx_activities_type ON activities(type);

-- ============================================
-- Activity Progress
-- ============================================

CREATE TABLE activity_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  activity_id UUID NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
  completed BOOLEAN DEFAULT false,
  score INT,                            -- For quizzes/checkpoints (0-100)
  xp_earned INT DEFAULT 0,
  attempts INT DEFAULT 1,
  first_try_bonus BOOLEAN DEFAULT false,
  completed_at TIMESTAMPTZ,
  last_position_seconds INT DEFAULT 0,  -- For resumable content
  time_spent_seconds INT DEFAULT 0,
  last_accessed_at TIMESTAMPTZ DEFAULT now(),
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  
  CONSTRAINT unique_user_activity UNIQUE(user_id, activity_id)
);

CREATE INDEX idx_activity_progress_user ON activity_progress(user_id);
CREATE INDEX idx_activity_progress_activity ON activity_progress(activity_id);
CREATE INDEX idx_activity_progress_completed ON activity_progress(user_id, completed);

-- ============================================
-- Module Progress (derived/cached)
-- ============================================

CREATE TABLE module_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  module_id UUID NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  started_at TIMESTAMPTZ DEFAULT now(),
  completed_at TIMESTAMPTZ,
  total_xp_earned INT DEFAULT 0,
  checkpoint_passed BOOLEAN DEFAULT false,
  
  CONSTRAINT unique_user_module UNIQUE(user_id, module_id)
);

CREATE INDEX idx_module_progress_user ON module_progress(user_id);

-- ============================================
-- User Streaks
-- ============================================

CREATE TABLE user_streaks (
  user_id UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  current_streak INT DEFAULT 0,
  longest_streak INT DEFAULT 0,
  last_activity_date DATE,
  streak_freeze_available BOOLEAN DEFAULT false,
  streak_freeze_used_at DATE,
  total_xp INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- ============================================
-- Badges
-- ============================================

CREATE TABLE badges (
  id TEXT PRIMARY KEY,                  -- 'first-steps', 'pythonista', etc.
  name TEXT NOT NULL,
  description TEXT,
  icon TEXT,                            -- Icon identifier (not emoji)
  required_plan plan_tier DEFAULT 'free',
  unlock_criteria JSONB,                -- Flexible criteria definition
  sort_order INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

CREATE TABLE user_badges (
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  badge_id TEXT REFERENCES badges(id) ON DELETE CASCADE,
  earned_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  PRIMARY KEY (user_id, badge_id)
);

CREATE INDEX idx_user_badges_user ON user_badges(user_id);

-- ============================================
-- Enable RLS
-- ============================================

ALTER TABLE modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE activity_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE module_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_streaks ENABLE ROW LEVEL SECURITY;
ALTER TABLE badges ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_badges ENABLE ROW LEVEL SECURITY;

-- ============================================
-- RLS Policies
-- ============================================

-- Modules: Anyone can view published modules of published courses
CREATE POLICY "Anyone can view published modules"
  ON modules FOR SELECT
  USING (
    is_published = true
    AND EXISTS (
      SELECT 1 FROM courses c
      WHERE c.id = modules.course_id AND c.is_published = true
    )
  );

-- Admins can manage modules
CREATE POLICY "Admins can manage modules"
  ON modules FOR ALL
  USING (is_admin());

-- Activities: Free activities visible to all authenticated users
CREATE POLICY "Authenticated users can view free activities"
  ON activities FOR SELECT
  USING (
    is_published = true
    AND required_plan = 'free'
    AND auth.uid() IS NOT NULL
  );

-- Activities: Basic activities visible to users with basic+ subscription
CREATE POLICY "Subscribers can view basic activities"
  ON activities FOR SELECT
  USING (
    is_published = true
    AND required_plan = 'basic'
    AND has_active_subscription(NULL)
  );

-- Activities: Advanced activities visible to users with advanced subscription
CREATE POLICY "Advanced subscribers can view advanced activities"
  ON activities FOR SELECT
  USING (
    is_published = true
    AND required_plan = 'advanced'
    AND EXISTS (
      SELECT 1 FROM subscriptions s
      JOIN subscription_tiers st ON s.tier_id = st.id
      WHERE s.user_id = auth.uid()
        AND s.status IN ('active', 'trialing')
        AND s.current_period_end > now()
        AND st.slug = 'advanced'
    )
  );

-- Admins can manage activities
CREATE POLICY "Admins can manage activities"
  ON activities FOR ALL
  USING (is_admin());

-- Activity Progress: Users can manage their own progress
CREATE POLICY "Users can view own activity progress"
  ON activity_progress FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create own activity progress"
  ON activity_progress FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own activity progress"
  ON activity_progress FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Module Progress: Users can manage their own progress
CREATE POLICY "Users can view own module progress"
  ON module_progress FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create own module progress"
  ON module_progress FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own module progress"
  ON module_progress FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- User Streaks: Users can manage their own streaks
CREATE POLICY "Users can view own streaks"
  ON user_streaks FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create own streaks"
  ON user_streaks FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own streaks"
  ON user_streaks FOR UPDATE
  USING (auth.uid() = user_id);

-- Badges: Anyone can view badges
CREATE POLICY "Anyone can view badges"
  ON badges FOR SELECT
  USING (true);

-- Admins can manage badges
CREATE POLICY "Admins can manage badges"
  ON badges FOR ALL
  USING (is_admin());

-- User Badges: Users can view their own badges
CREATE POLICY "Users can view own badges"
  ON user_badges FOR SELECT
  USING (auth.uid() = user_id);

-- Admins can view all user badges
CREATE POLICY "Admins can view all user badges"
  ON user_badges FOR SELECT
  USING (is_admin());

-- ============================================
-- Triggers
-- ============================================

CREATE TRIGGER update_modules_updated_at
  BEFORE UPDATE ON modules
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_activities_updated_at
  BEFORE UPDATE ON activities
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_activity_progress_updated_at
  BEFORE UPDATE ON activity_progress
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_streaks_updated_at
  BEFORE UPDATE ON user_streaks
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- Helper Functions
-- ============================================

-- Check if user can access a specific plan tier
CREATE OR REPLACE FUNCTION user_has_plan_access(required plan_tier)
RETURNS BOOLEAN AS $$
DECLARE
  user_tier_slug TEXT;
BEGIN
  -- Free is always accessible to authenticated users
  IF required = 'free' AND auth.uid() IS NOT NULL THEN
    RETURN true;
  END IF;
  
  -- Get user's current subscription tier
  SELECT st.slug INTO user_tier_slug
  FROM subscriptions s
  JOIN subscription_tiers st ON s.tier_id = st.id
  WHERE s.user_id = auth.uid()
    AND s.status IN ('active', 'trialing')
    AND s.current_period_end > now();
  
  -- Check tier hierarchy
  IF required = 'basic' THEN
    RETURN user_tier_slug IN ('basic', 'advanced');
  ELSIF required = 'advanced' THEN
    RETURN user_tier_slug = 'advanced';
  END IF;
  
  RETURN false;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Get module progress for a user
CREATE OR REPLACE FUNCTION get_module_progress(p_user_id UUID, p_module_id UUID)
RETURNS TABLE (
  total_activities INT,
  completed_activities INT,
  progress_percentage DECIMAL(5, 2),
  total_xp_earned INT,
  checkpoint_passed BOOLEAN
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COUNT(a.id)::INT AS total_activities,
    COUNT(ap.id) FILTER (WHERE ap.completed = true)::INT AS completed_activities,
    CASE 
      WHEN COUNT(a.id) = 0 THEN 0
      ELSE ROUND((COUNT(ap.id) FILTER (WHERE ap.completed = true)::DECIMAL / COUNT(a.id)::DECIMAL) * 100, 2)
    END AS progress_percentage,
    COALESCE(SUM(ap.xp_earned), 0)::INT AS total_xp_earned,
    COALESCE(
      (SELECT mp.checkpoint_passed FROM module_progress mp 
       WHERE mp.user_id = p_user_id AND mp.module_id = p_module_id),
      false
    ) AS checkpoint_passed
  FROM activities a
  LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE a.module_id = p_module_id AND a.is_published = true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Mark activity complete and award XP
CREATE OR REPLACE FUNCTION complete_activity(
  p_activity_id UUID,
  p_score INT DEFAULT NULL
)
RETURNS activity_progress AS $$
DECLARE
  v_progress activity_progress;
  v_activity activities;
  v_xp_earned INT;
  v_first_try BOOLEAN;
  v_existing_attempts INT;
BEGIN
  -- Get activity details
  SELECT * INTO v_activity FROM activities WHERE id = p_activity_id;
  
  IF v_activity IS NULL THEN
    RAISE EXCEPTION 'Activity not found';
  END IF;
  
  -- Check existing attempts
  SELECT attempts INTO v_existing_attempts 
  FROM activity_progress 
  WHERE user_id = auth.uid() AND activity_id = p_activity_id;
  
  v_first_try := v_existing_attempts IS NULL;
  
  -- Calculate XP (with first-try bonus)
  v_xp_earned := v_activity.xp;
  IF v_first_try THEN
    v_xp_earned := ROUND(v_xp_earned * 1.5);
  END IF;
  
  -- Upsert progress
  INSERT INTO activity_progress (
    user_id, activity_id, completed, score, xp_earned, 
    attempts, first_try_bonus, completed_at, last_accessed_at
  )
  VALUES (
    auth.uid(), p_activity_id, true, p_score, v_xp_earned,
    1, v_first_try, now(), now()
  )
  ON CONFLICT (user_id, activity_id) 
  DO UPDATE SET 
    completed = true,
    score = COALESCE(p_score, activity_progress.score),
    xp_earned = GREATEST(activity_progress.xp_earned, v_xp_earned),
    attempts = activity_progress.attempts + 1,
    completed_at = COALESCE(activity_progress.completed_at, now()),
    last_accessed_at = now()
  RETURNING * INTO v_progress;
  
  -- Update user's total XP
  INSERT INTO user_streaks (user_id, total_xp, last_activity_date, current_streak)
  VALUES (auth.uid(), v_xp_earned, CURRENT_DATE, 1)
  ON CONFLICT (user_id)
  DO UPDATE SET
    total_xp = user_streaks.total_xp + v_xp_earned,
    last_activity_date = CURRENT_DATE,
    current_streak = CASE
      WHEN user_streaks.last_activity_date = CURRENT_DATE - 1 
        THEN user_streaks.current_streak + 1
      WHEN user_streaks.last_activity_date = CURRENT_DATE 
        THEN user_streaks.current_streak
      ELSE 1
    END,
    longest_streak = GREATEST(
      user_streaks.longest_streak,
      CASE
        WHEN user_streaks.last_activity_date = CURRENT_DATE - 1 
          THEN user_streaks.current_streak + 1
        WHEN user_streaks.last_activity_date = CURRENT_DATE 
          THEN user_streaks.current_streak
        ELSE 1
      END
    );
  
  RETURN v_progress;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

