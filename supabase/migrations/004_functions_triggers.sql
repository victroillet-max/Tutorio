-- ============================================
-- Tutorio Database Schema - Part 4: Functions & Triggers
-- ============================================

-- ============================================
-- Updated At Trigger Function
-- ============================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply updated_at trigger to all tables with that column
CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_subscription_tiers_updated_at
  BEFORE UPDATE ON subscription_tiers
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_subscriptions_updated_at
  BEFORE UPDATE ON subscriptions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_categories_updated_at
  BEFORE UPDATE ON categories
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_courses_updated_at
  BEFORE UPDATE ON courses
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_lessons_updated_at
  BEFORE UPDATE ON lessons
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_lesson_progress_updated_at
  BEFORE UPDATE ON lesson_progress
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- Auto-create Profile on User Signup
-- ============================================

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, avatar_url)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.raw_user_meta_data->>'name'),
    NEW.raw_user_meta_data->>'avatar_url'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger on auth.users insert
CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- ============================================
-- Course Progress Calculation Function
-- ============================================

CREATE OR REPLACE FUNCTION get_course_progress(p_user_id UUID, p_course_id UUID)
RETURNS TABLE (
  total_lessons INT,
  completed_lessons INT,
  progress_percentage DECIMAL(5, 2),
  last_accessed_at TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COUNT(l.id)::INT AS total_lessons,
    COUNT(lp.id) FILTER (WHERE lp.completed = true)::INT AS completed_lessons,
    CASE 
      WHEN COUNT(l.id) = 0 THEN 0
      ELSE ROUND((COUNT(lp.id) FILTER (WHERE lp.completed = true)::DECIMAL / COUNT(l.id)::DECIMAL) * 100, 2)
    END AS progress_percentage,
    MAX(lp.last_accessed_at) AS last_accessed_at
  FROM lessons l
  LEFT JOIN lesson_progress lp ON l.id = lp.lesson_id AND lp.user_id = p_user_id
  WHERE l.course_id = p_course_id AND l.is_published = true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- User Statistics Function
-- ============================================

CREATE OR REPLACE FUNCTION get_user_stats(p_user_id UUID)
RETURNS TABLE (
  total_courses_enrolled INT,
  total_courses_completed INT,
  total_lessons_completed INT,
  total_time_spent_seconds BIGINT,
  current_streak_days INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    (SELECT COUNT(*)::INT FROM course_enrollments WHERE user_id = p_user_id),
    (SELECT COUNT(*)::INT FROM course_enrollments WHERE user_id = p_user_id AND completed_at IS NOT NULL),
    (SELECT COUNT(*)::INT FROM lesson_progress WHERE user_id = p_user_id AND completed = true),
    (SELECT COALESCE(SUM(time_spent_seconds), 0)::BIGINT FROM lesson_progress WHERE user_id = p_user_id),
    0::INT AS current_streak_days; -- TODO: Implement streak calculation
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- Mark Lesson Complete Function
-- ============================================

CREATE OR REPLACE FUNCTION mark_lesson_complete(p_lesson_id UUID)
RETURNS lesson_progress AS $$
DECLARE
  v_progress lesson_progress;
  v_course_id UUID;
  v_all_completed BOOLEAN;
BEGIN
  -- Get course ID for the lesson
  SELECT course_id INTO v_course_id FROM lessons WHERE id = p_lesson_id;
  
  -- Upsert progress record
  INSERT INTO lesson_progress (user_id, lesson_id, completed, completed_at, last_accessed_at)
  VALUES (auth.uid(), p_lesson_id, true, now(), now())
  ON CONFLICT (user_id, lesson_id) 
  DO UPDATE SET 
    completed = true,
    completed_at = COALESCE(lesson_progress.completed_at, now()),
    last_accessed_at = now(),
    updated_at = now()
  RETURNING * INTO v_progress;
  
  -- Check if all lessons in course are completed
  SELECT NOT EXISTS (
    SELECT 1 FROM lessons l
    LEFT JOIN lesson_progress lp ON l.id = lp.lesson_id AND lp.user_id = auth.uid()
    WHERE l.course_id = v_course_id 
      AND l.is_published = true 
      AND (lp.completed IS NULL OR lp.completed = false)
  ) INTO v_all_completed;
  
  -- If all lessons completed, mark course enrollment as complete
  IF v_all_completed THEN
    UPDATE course_enrollments
    SET completed_at = now()
    WHERE user_id = auth.uid() AND course_id = v_course_id AND completed_at IS NULL;
  END IF;
  
  RETURN v_progress;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

