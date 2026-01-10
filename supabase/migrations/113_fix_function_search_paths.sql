-- ============================================
-- Security Fix: Set search_path on all SECURITY DEFINER functions
-- This migration addresses the "Function Search Path Mutable" security warnings
-- by adding SET search_path = '' to all affected functions
-- ============================================

-- ============================================
-- 1. is_admin (from 003_rls_policies.sql, updated in 20260110_fix_rls_performance.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = (SELECT auth.uid()) AND role = 'admin'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 2. has_active_subscription (from 003_rls_policies.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.has_active_subscription(required_tier_id UUID DEFAULT NULL)
RETURNS BOOLEAN AS $$
DECLARE
  user_tier_order INT;
  required_tier_order INT;
BEGIN
  -- Get user's current tier order
  SELECT st.sort_order INTO user_tier_order
  FROM public.subscriptions s
  JOIN public.subscription_tiers st ON s.tier_id = st.id
  WHERE s.user_id = auth.uid()
    AND s.status IN ('active', 'trialing')
    AND s.current_period_end > now();
  
  -- If no required tier, just check if user has any active subscription
  IF required_tier_id IS NULL THEN
    RETURN user_tier_order IS NOT NULL;
  END IF;
  
  -- Get required tier order
  SELECT sort_order INTO required_tier_order
  FROM public.subscription_tiers
  WHERE id = required_tier_id;
  
  -- User's tier must be >= required tier
  RETURN user_tier_order IS NOT NULL AND user_tier_order >= required_tier_order;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 3. update_updated_at_column (from 004_functions_triggers.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql
SET search_path = '';

-- ============================================
-- 4. handle_new_user (from 004_functions_triggers.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
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
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 5. get_course_progress (from 004_functions_triggers.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_course_progress(p_user_id UUID, p_course_id UUID)
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
  FROM public.lessons l
  LEFT JOIN public.lesson_progress lp ON l.id = lp.lesson_id AND lp.user_id = p_user_id
  WHERE l.course_id = p_course_id AND l.is_published = true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 6. get_user_stats (from 004_functions_triggers.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_user_stats(p_user_id UUID)
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
    (SELECT COUNT(*)::INT FROM public.course_enrollments WHERE user_id = p_user_id),
    (SELECT COUNT(*)::INT FROM public.course_enrollments WHERE user_id = p_user_id AND completed_at IS NOT NULL),
    (SELECT COUNT(*)::INT FROM public.lesson_progress WHERE user_id = p_user_id AND completed = true),
    (SELECT COALESCE(SUM(time_spent_seconds), 0)::BIGINT FROM public.lesson_progress WHERE user_id = p_user_id),
    0::INT AS current_streak_days;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 7. mark_lesson_complete (from 004_functions_triggers.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.mark_lesson_complete(p_lesson_id UUID)
RETURNS public.lesson_progress AS $$
DECLARE
  v_progress public.lesson_progress;
  v_course_id UUID;
  v_all_completed BOOLEAN;
BEGIN
  -- Get course ID for the lesson
  SELECT course_id INTO v_course_id FROM public.lessons WHERE id = p_lesson_id;
  
  -- Upsert progress record
  INSERT INTO public.lesson_progress (user_id, lesson_id, completed, completed_at, last_accessed_at)
  VALUES (auth.uid(), p_lesson_id, true, now(), now())
  ON CONFLICT (user_id, lesson_id) 
  DO UPDATE SET 
    completed = true,
    completed_at = COALESCE(public.lesson_progress.completed_at, now()),
    last_accessed_at = now(),
    updated_at = now()
  RETURNING * INTO v_progress;
  
  -- Check if all lessons in course are completed
  SELECT NOT EXISTS (
    SELECT 1 FROM public.lessons l
    LEFT JOIN public.lesson_progress lp ON l.id = lp.lesson_id AND lp.user_id = auth.uid()
    WHERE l.course_id = v_course_id 
      AND l.is_published = true 
      AND (lp.completed IS NULL OR lp.completed = false)
  ) INTO v_all_completed;
  
  -- If all lessons completed, mark course enrollment as complete
  IF v_all_completed THEN
    UPDATE public.course_enrollments
    SET completed_at = now()
    WHERE user_id = auth.uid() AND course_id = v_course_id AND completed_at IS NULL;
  END IF;
  
  RETURN v_progress;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 8. user_has_plan_access (from 005_learning_system.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.user_has_plan_access(required public.plan_tier)
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
  FROM public.subscriptions s
  JOIN public.subscription_tiers st ON s.tier_id = st.id
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
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 9. get_module_progress (from 005_learning_system.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_module_progress(p_user_id UUID, p_module_id UUID)
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
      (SELECT mp.checkpoint_passed FROM public.module_progress mp 
       WHERE mp.user_id = p_user_id AND mp.module_id = p_module_id),
      false
    ) AS checkpoint_passed
  FROM public.activities a
  LEFT JOIN public.activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE a.module_id = p_module_id AND a.is_published = true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 10. complete_activity (from 005_learning_system.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.complete_activity(
  p_activity_id UUID,
  p_score INT DEFAULT NULL
)
RETURNS public.activity_progress AS $$
DECLARE
  v_progress public.activity_progress;
  v_activity public.activities;
  v_xp_earned INT;
  v_first_try BOOLEAN;
  v_existing_attempts INT;
BEGIN
  -- Get activity details
  SELECT * INTO v_activity FROM public.activities WHERE id = p_activity_id;
  
  IF v_activity IS NULL THEN
    RAISE EXCEPTION 'Activity not found';
  END IF;
  
  -- Check existing attempts
  SELECT attempts INTO v_existing_attempts 
  FROM public.activity_progress 
  WHERE user_id = auth.uid() AND activity_id = p_activity_id;
  
  v_first_try := v_existing_attempts IS NULL;
  
  -- Calculate XP (with first-try bonus)
  v_xp_earned := v_activity.xp;
  IF v_first_try THEN
    v_xp_earned := ROUND(v_xp_earned * 1.5);
  END IF;
  
  -- Upsert progress
  INSERT INTO public.activity_progress (
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
    score = COALESCE(p_score, public.activity_progress.score),
    xp_earned = GREATEST(public.activity_progress.xp_earned, v_xp_earned),
    attempts = public.activity_progress.attempts + 1,
    completed_at = COALESCE(public.activity_progress.completed_at, now()),
    last_accessed_at = now()
  RETURNING * INTO v_progress;
  
  -- Update user's total XP
  INSERT INTO public.user_streaks (user_id, total_xp, last_activity_date, current_streak)
  VALUES (auth.uid(), v_xp_earned, CURRENT_DATE, 1)
  ON CONFLICT (user_id) DO UPDATE SET
    total_xp = public.user_streaks.total_xp + v_xp_earned,
    last_activity_date = CURRENT_DATE,
    current_streak = CASE 
      WHEN public.user_streaks.last_activity_date = CURRENT_DATE - 1 
      THEN public.user_streaks.current_streak + 1
      WHEN public.user_streaks.last_activity_date = CURRENT_DATE 
      THEN public.user_streaks.current_streak
      ELSE 1
    END;
  
  RETURN v_progress;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 11. get_skill_prerequisites_status (from 026_skills_schema.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_skill_prerequisites_status(p_user_id UUID, p_skill_id UUID)
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
  FROM public.skill_prerequisites sp
  JOIN public.skills s ON sp.prerequisite_skill_id = s.id
  LEFT JOIN public.user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  WHERE sp.skill_id = p_skill_id
  ORDER BY s.sort_order;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 12. calculate_skill_mastery (from 033_fix_mastery_calculation.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.calculate_skill_mastery(
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
  -- Only consider activities where is_owner = true
  SELECT 
    COALESCE(SUM(asks.weight), 0),
    COALESCE(SUM(
      CASE 
        WHEN ap.completed THEN asks.weight * COALESCE(ap.score, 100)
        ELSE 0
      END
    ), 0)
  INTO v_total_weight, v_weighted_score
  FROM public.activity_skills asks
  JOIN public.activities a ON asks.activity_id = a.id
  LEFT JOIN public.activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE asks.skill_id = p_skill_id
    AND asks.is_owner = true;
  
  -- Calculate mastery (0-100)
  IF v_total_weight > 0 THEN
    v_mastery := ROUND(v_weighted_score / v_total_weight);
  ELSE
    v_mastery := 0;
  END IF;
  
  -- Update user skill progress
  INSERT INTO public.user_skill_progress (user_id, skill_id, mastery_level, last_practiced_at)
  VALUES (p_user_id, p_skill_id, v_mastery, now())
  ON CONFLICT (user_id, skill_id)
  DO UPDATE SET
    mastery_level = v_mastery,
    times_practiced = public.user_skill_progress.times_practiced + 1,
    last_practiced_at = now();
  
  RETURN v_mastery;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 13. recalculate_all_skill_mastery (from 033_fix_mastery_calculation.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.recalculate_all_skill_mastery(p_user_id UUID)
RETURNS void AS $$
DECLARE
  v_skill RECORD;
BEGIN
  -- Loop through all skills that the user has activity progress for
  FOR v_skill IN 
    SELECT DISTINCT asks.skill_id
    FROM public.activity_skills asks
    JOIN public.activity_progress ap ON asks.activity_id = ap.activity_id
    WHERE ap.user_id = p_user_id
      AND asks.is_owner = true
  LOOP
    PERFORM public.calculate_skill_mastery(p_user_id, v_skill.skill_id);
  END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 14. update_conversation_message_count (from 029_ai_chat_schema.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.update_conversation_message_count()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE public.chat_conversations
  SET message_count = message_count + 1,
      updated_at = now()
  WHERE id = NEW.conversation_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql
SET search_path = '';

-- ============================================
-- 15. get_conversation_context (from 029_ai_chat_schema.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_conversation_context(
  p_conversation_id UUID,
  p_limit INT DEFAULT 10
)
RETURNS TABLE (
  role TEXT,
  content TEXT,
  created_at TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    cm.role,
    cm.content,
    cm.created_at
  FROM public.chat_messages cm
  WHERE cm.conversation_id = p_conversation_id
  ORDER BY cm.created_at DESC
  LIMIT p_limit;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 16. get_ai_skill_context (from 029_ai_chat_schema.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_ai_skill_context(p_user_id UUID)
RETURNS TABLE (
  mastered_skills TEXT[],
  struggling_skills TEXT[],
  current_activity_skill TEXT,
  mastery_levels JSONB
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    ARRAY(
      SELECT s.slug FROM public.skills s
      JOIN public.user_skill_progress usp ON s.id = usp.skill_id
      WHERE usp.user_id = p_user_id AND usp.mastery_level >= 70
    ) AS mastered_skills,
    ARRAY(
      SELECT s.slug FROM public.skills s
      JOIN public.user_skill_progress usp ON s.id = usp.skill_id
      WHERE usp.user_id = p_user_id AND usp.mastery_level < 70 AND usp.mastery_level > 0
    ) AS struggling_skills,
    NULL::TEXT AS current_activity_skill,
    (
      SELECT jsonb_object_agg(s.slug, usp.mastery_level)
      FROM public.skills s
      JOIN public.user_skill_progress usp ON s.id = usp.skill_id
      WHERE usp.user_id = p_user_id
    ) AS mastery_levels;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 17. get_skill_activities (from 031_skill_first_schema.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_skill_activities(p_skill_id UUID, p_user_id UUID DEFAULT NULL)
RETURNS TABLE (
  activity_id UUID,
  activity_title TEXT,
  activity_slug TEXT,
  activity_type public.activity_type,
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
  FROM public.activity_skills asks
  JOIN public.activities a ON asks.activity_id = a.id
  LEFT JOIN public.activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE asks.skill_id = p_skill_id
    AND asks.is_owner = true
    AND a.is_published = true
  ORDER BY asks.order_index ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 18. get_next_skill_activity (from 031_skill_first_schema.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_next_skill_activity(p_skill_id UUID, p_user_id UUID)
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
  FROM public.activity_skills asks
  JOIN public.activities a ON asks.activity_id = a.id
  JOIN public.skills s ON asks.skill_id = s.id
  LEFT JOIN public.activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE asks.skill_id = p_skill_id
    AND asks.is_owner = true
    AND a.is_published = true
    AND (ap.completed IS NULL OR ap.completed = false)
  ORDER BY asks.order_index ASC
  LIMIT 1;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 19. get_skill_progress_summary (from 031_skill_first_schema.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_skill_progress_summary(p_skill_id UUID, p_user_id UUID)
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
  FROM public.activity_skills asks
  JOIN public.activities a ON asks.activity_id = a.id
  LEFT JOIN public.activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE asks.skill_id = p_skill_id
    AND asks.is_owner = true
    AND a.is_published = true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 20. get_user_enrolled_courses (from 034_course_skills_relationship.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_user_enrolled_courses(p_user_id UUID)
RETURNS TABLE (
  course_id UUID,
  course_slug TEXT,
  course_title TEXT,
  course_description TEXT,
  course_short_description TEXT,
  course_difficulty public.difficulty_level,
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
  FROM public.user_course_enrollment uce
  JOIN public.courses c ON uce.course_id = c.id
  LEFT JOIN LATERAL public.get_course_skill_progress(c.id, p_user_id) progress ON true
  WHERE uce.user_id = p_user_id AND uce.is_active = true
  ORDER BY uce.last_accessed_at DESC NULLS LAST;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 21. enroll_user_in_course (from 034_course_skills_relationship.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.enroll_user_in_course(p_user_id UUID, p_course_id UUID)
RETURNS public.user_course_enrollment AS $$
DECLARE
  enrollment public.user_course_enrollment;
BEGIN
  INSERT INTO public.user_course_enrollment (user_id, course_id)
  VALUES (p_user_id, p_course_id)
  ON CONFLICT (user_id, course_id) 
  DO UPDATE SET last_accessed_at = now(), is_active = true
  RETURNING * INTO enrollment;
  
  RETURN enrollment;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 22. has_course_subscription (from 035_per_course_subscriptions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.has_course_subscription(p_course_id UUID, required_tier TEXT DEFAULT NULL)
RETURNS BOOLEAN AS $$
DECLARE
  v_user_tier TEXT;
BEGIN
  -- Get user's subscription tier for this course
  SELECT st.slug INTO v_user_tier
  FROM public.subscriptions s
  JOIN public.subscription_tiers st ON s.tier_id = st.id
  WHERE s.user_id = auth.uid()
    AND s.course_id = p_course_id
    AND s.status IN ('active', 'trialing')
    AND s.current_period_end > now();
  
  -- If no tier required, just check if any subscription exists
  IF required_tier IS NULL THEN
    RETURN v_user_tier IS NOT NULL;
  END IF;
  
  -- Check tier hierarchy (advanced includes basic)
  IF required_tier = 'basic' THEN
    RETURN v_user_tier IN ('basic', 'advanced');
  ELSIF required_tier = 'advanced' THEN
    RETURN v_user_tier = 'advanced';
  END IF;
  
  RETURN false;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 23. get_course_subscription_tier (from 035_per_course_subscriptions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_course_subscription_tier(p_course_id UUID)
RETURNS TEXT AS $$
DECLARE
  v_tier TEXT;
BEGIN
  SELECT st.slug INTO v_tier
  FROM public.subscriptions s
  JOIN public.subscription_tiers st ON s.tier_id = st.id
  WHERE s.user_id = auth.uid()
    AND s.course_id = p_course_id
    AND s.status IN ('active', 'trialing')
    AND s.current_period_end > now();
  
  RETURN v_tier;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 24. is_demo_activity (from 035_per_course_subscriptions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.is_demo_activity(p_activity_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
  v_activity_global_index INT;
  v_demo_limit INT;
  v_course_id UUID;
BEGIN
  -- Get the course and calculate the global activity index
  SELECT 
    c.id,
    c.demo_activity_count,
    (
      SELECT COUNT(*)
      FROM public.activities a2
      JOIN public.modules m2 ON a2.module_id = m2.id
      WHERE m2.course_id = c.id
        AND a2.is_published = true
        AND (
          m2.order_index < m.order_index
          OR (m2.order_index = m.order_index AND a2.order_index <= a.order_index)
        )
    )::INT
  INTO v_course_id, v_demo_limit, v_activity_global_index
  FROM public.activities a
  JOIN public.modules m ON a.module_id = m.id
  JOIN public.courses c ON m.course_id = c.id
  WHERE a.id = p_activity_id;
  
  -- If we couldn't find the activity, return false
  IF v_course_id IS NULL THEN
    RETURN false;
  END IF;
  
  -- Check if within demo limit
  RETURN v_activity_global_index <= v_demo_limit;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 25. get_activity_access (from 035_per_course_subscriptions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_activity_access(p_activity_id UUID)
RETURNS TABLE (
  has_access BOOLEAN,
  is_demo BOOLEAN,
  subscription_tier TEXT,
  course_id UUID,
  demo_activities_used INT,
  demo_activities_total INT
) AS $$
DECLARE
  v_course_id UUID;
  v_is_demo BOOLEAN;
  v_tier TEXT;
  v_demo_count INT;
  v_demo_limit INT;
BEGIN
  -- Get course info
  SELECT c.id, c.demo_activity_count
  INTO v_course_id, v_demo_limit
  FROM public.activities a
  JOIN public.modules m ON a.module_id = m.id
  JOIN public.courses c ON m.course_id = c.id
  WHERE a.id = p_activity_id;
  
  IF v_course_id IS NULL THEN
    RETURN;
  END IF;
  
  -- Check if demo activity
  v_is_demo := public.is_demo_activity(p_activity_id);
  
  -- Get subscription tier
  v_tier := public.get_course_subscription_tier(v_course_id);
  
  -- Count demo activities completed by user in this course
  SELECT COUNT(*)::INT INTO v_demo_count
  FROM public.activity_progress ap
  JOIN public.activities a ON ap.activity_id = a.id
  JOIN public.modules m ON a.module_id = m.id
  WHERE ap.user_id = auth.uid()
    AND m.course_id = v_course_id
    AND ap.completed = true
    AND public.is_demo_activity(a.id);
  
  RETURN QUERY SELECT 
    (v_is_demo OR v_tier IS NOT NULL) AS has_access,
    v_is_demo AS is_demo,
    v_tier AS subscription_tier,
    v_course_id,
    COALESCE(v_demo_count, 0) AS demo_activities_used,
    v_demo_limit AS demo_activities_total;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 26. create_course_subscription (from 035_per_course_subscriptions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.create_course_subscription(
  p_user_id UUID,
  p_course_id UUID,
  p_tier_slug TEXT,
  p_stripe_subscription_id TEXT DEFAULT NULL,
  p_stripe_customer_id TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  v_tier_id UUID;
  v_subscription_id UUID;
BEGIN
  -- Get the tier ID
  SELECT id INTO v_tier_id
  FROM public.subscription_tiers
  WHERE slug = p_tier_slug AND is_active = true;
  
  IF v_tier_id IS NULL THEN
    RAISE EXCEPTION 'Invalid subscription tier: %', p_tier_slug;
  END IF;
  
  -- Create or update the subscription
  INSERT INTO public.subscriptions (
    user_id,
    course_id,
    tier_id,
    status,
    current_period_start,
    current_period_end,
    stripe_subscription_id,
    stripe_customer_id
  ) VALUES (
    p_user_id,
    p_course_id,
    v_tier_id,
    'active',
    now(),
    now() + interval '1 month',
    p_stripe_subscription_id,
    p_stripe_customer_id
  )
  ON CONFLICT (user_id, course_id) DO UPDATE SET
    tier_id = v_tier_id,
    status = 'active',
    current_period_start = now(),
    current_period_end = now() + interval '1 month',
    stripe_subscription_id = COALESCE(p_stripe_subscription_id, public.subscriptions.stripe_subscription_id),
    stripe_customer_id = COALESCE(p_stripe_customer_id, public.subscriptions.stripe_customer_id),
    updated_at = now()
  RETURNING id INTO v_subscription_id;
  
  RETURN v_subscription_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 27. upgrade_course_subscription (from 035_per_course_subscriptions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.upgrade_course_subscription(
  p_user_id UUID,
  p_course_id UUID
)
RETURNS BOOLEAN AS $$
DECLARE
  v_advanced_tier_id UUID;
BEGIN
  -- Get advanced tier ID
  SELECT id INTO v_advanced_tier_id
  FROM public.subscription_tiers
  WHERE slug = 'advanced' AND is_active = true;
  
  IF v_advanced_tier_id IS NULL THEN
    RETURN false;
  END IF;
  
  -- Update the subscription
  UPDATE public.subscriptions
  SET tier_id = v_advanced_tier_id,
      updated_at = now()
  WHERE user_id = p_user_id
    AND course_id = p_course_id
    AND status IN ('active', 'trialing');
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 28. cancel_course_subscription (from 035_per_course_subscriptions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.cancel_course_subscription(
  p_user_id UUID,
  p_course_id UUID
)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE public.subscriptions
  SET cancel_at_period_end = true,
      cancelled_at = now(),
      updated_at = now()
  WHERE user_id = p_user_id
    AND course_id = p_course_id
    AND status IN ('active', 'trialing');
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 29. update_user_sheets_updated_at (from 049_google_sheets_integration.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.update_user_sheets_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql
SET search_path = '';

-- ============================================
-- 30. get_user_sheet (from 049_google_sheets_integration.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_user_sheet(
    p_user_id UUID,
    p_activity_id UUID
) RETURNS TABLE(
    sheet_id TEXT,
    sheet_url TEXT,
    is_completed BOOLEAN,
    completion_data JSONB,
    created_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        us.user_sheet_id,
        us.user_sheet_url,
        us.is_completed,
        us.completion_data,
        us.created_at
    FROM public.user_sheets us
    WHERE us.user_id = p_user_id
    AND us.activity_id = p_activity_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 31. complete_sheet_exercise (from 049_google_sheets_integration.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.complete_sheet_exercise(
    p_user_id UUID,
    p_activity_id UUID,
    p_completion_data JSONB
) RETURNS BOOLEAN AS $$
DECLARE
    v_total_points INTEGER;
    v_earned_points INTEGER;
    v_passing_score DECIMAL;
    v_score DECIMAL;
BEGIN
    -- Calculate score from completion data
    SELECT 
        COALESCE(SUM(CASE WHEN (p_completion_data->cell_reference->>'is_correct')::boolean THEN points ELSE 0 END), 0),
        COALESCE(SUM(points), 0)
    INTO v_earned_points, v_total_points
    FROM public.sheet_grading_criteria
    WHERE activity_id = p_activity_id;
    
    -- Get passing score from activity
    SELECT passing_score INTO v_passing_score
    FROM public.activities
    WHERE id = p_activity_id;
    
    IF v_total_points > 0 THEN
        v_score := (v_earned_points::DECIMAL / v_total_points::DECIMAL) * 100;
    ELSE
        v_score := 100;
    END IF;
    
    -- Update user sheet record
    UPDATE public.user_sheets
    SET 
        is_completed = v_score >= v_passing_score,
        completion_data = p_completion_data,
        last_synced_at = NOW()
    WHERE user_id = p_user_id
    AND activity_id = p_activity_id;
    
    RETURN v_score >= v_passing_score;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 32. setup_sheets_exercise (from 050_example_cfs_exercise.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.setup_sheets_exercise(
    p_activity_id UUID,
    p_template_sheet_id TEXT,
    p_exercise_title TEXT,
    p_instructions TEXT,
    p_grading_cells JSONB
) RETURNS VOID AS $$
DECLARE
    v_cell JSONB;
    v_sort_order INTEGER := 1;
BEGIN
    -- Update the activity content
    UPDATE public.activities
    SET 
        content = jsonb_build_object(
            'template_sheet_id', p_template_sheet_id,
            'exercise_title', p_exercise_title,
            'instructions', p_instructions
        ),
        interactive_type = 'google-sheets'
    WHERE id = p_activity_id;
    
    -- Clear existing grading criteria
    DELETE FROM public.sheet_grading_criteria WHERE activity_id = p_activity_id;
    
    -- Insert new grading criteria
    FOR v_cell IN SELECT * FROM jsonb_array_elements(p_grading_cells)
    LOOP
        INSERT INTO public.sheet_grading_criteria (
            activity_id,
            cell_reference,
            cell_name,
            expected_value,
            expected_type,
            tolerance,
            is_required,
            points,
            sort_order,
            hint_on_error
        ) VALUES (
            p_activity_id,
            v_cell->>'cell',
            v_cell->>'name',
            v_cell->>'expected',
            COALESCE(v_cell->>'type', 'number'),
            COALESCE((v_cell->>'tolerance')::DECIMAL, 0.01),
            COALESCE((v_cell->>'required')::BOOLEAN, true),
            COALESCE((v_cell->>'points')::INTEGER, 1),
            v_sort_order,
            v_cell->>'hint'
        );
        v_sort_order := v_sort_order + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql
SET search_path = '';

-- ============================================
-- 33. cleanup_old_stripe_events (from 065_stripe_webhook_idempotency.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.cleanup_old_stripe_events()
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  deleted_count INTEGER;
BEGIN
  DELETE FROM public.stripe_webhook_events 
  WHERE processed_at < NOW() - INTERVAL '30 days';
  
  GET DIAGNOSTICS deleted_count = ROW_COUNT;
  RETURN deleted_count;
END;
$$;

-- ============================================
-- 34. get_user_rate_limit (from 066_per_course_ai_usage.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_user_rate_limit(
  p_user_id UUID,
  p_course_id UUID DEFAULT NULL
)
RETURNS TABLE (
  tier public.plan_tier,
  messages_per_day INT,
  messages_per_hour INT,
  messages_used_today INT,
  messages_remaining_today INT,
  features JSONB,
  course_id UUID
) AS $$
DECLARE
  v_user_tier public.plan_tier;
  v_messages_today INT;
BEGIN
  -- Get user's subscription tier for the specific course (or highest tier if no course specified)
  IF p_course_id IS NOT NULL THEN
    SELECT COALESCE(
      (SELECT st.slug::public.plan_tier
       FROM public.subscriptions s
       JOIN public.subscription_tiers st ON s.tier_id = st.id
       WHERE s.user_id = p_user_id
         AND s.course_id = p_course_id
         AND s.status IN ('active', 'trialing')
         AND s.current_period_end > now()
       LIMIT 1),
      'free'::public.plan_tier
    ) INTO v_user_tier;
  ELSE
    -- Get best tier across all courses (fallback for backward compatibility)
    SELECT COALESCE(
      (SELECT st.slug::public.plan_tier
       FROM public.subscriptions s
       JOIN public.subscription_tiers st ON s.tier_id = st.id
       WHERE s.user_id = p_user_id
         AND s.status IN ('active', 'trialing')
         AND s.current_period_end > now()
       ORDER BY CASE st.slug WHEN 'advanced' THEN 1 WHEN 'basic' THEN 2 ELSE 3 END
       LIMIT 1),
      'free'::public.plan_tier
    ) INTO v_user_tier;
  END IF;
  
  -- Get messages used today for this course
  IF p_course_id IS NOT NULL THEN
    SELECT COALESCE(SUM(au.messages_count), 0)
    INTO v_messages_today
    FROM public.ai_usage au
    WHERE au.user_id = p_user_id 
      AND au.date = CURRENT_DATE
      AND au.course_id = p_course_id;
  ELSE
    -- Get total messages across all courses (fallback)
    SELECT COALESCE(SUM(au.messages_count), 0)
    INTO v_messages_today
    FROM public.ai_usage au
    WHERE au.user_id = p_user_id AND au.date = CURRENT_DATE;
  END IF;
  
  IF v_messages_today IS NULL THEN
    v_messages_today := 0;
  END IF;
  
  RETURN QUERY
  SELECT 
    arl.tier,
    arl.messages_per_day,
    arl.messages_per_hour,
    v_messages_today AS messages_used_today,
    GREATEST(0, arl.messages_per_day - v_messages_today) AS messages_remaining_today,
    arl.features,
    p_course_id AS course_id
  FROM public.ai_rate_limits arl
  WHERE arl.tier = v_user_tier;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 35. can_send_ai_message (from 066_per_course_ai_usage.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.can_send_ai_message(
  p_user_id UUID,
  p_course_id UUID DEFAULT NULL
)
RETURNS BOOLEAN AS $$
DECLARE
  v_limit RECORD;
  v_hourly_count INT;
BEGIN
  -- Get rate limit info for this course
  SELECT * INTO v_limit FROM public.get_user_rate_limit(p_user_id, p_course_id);
  
  IF v_limit IS NULL THEN
    RETURN false;
  END IF;
  
  -- Check daily limit
  IF v_limit.messages_used_today >= v_limit.messages_per_day THEN
    RETURN false;
  END IF;
  
  -- Check hourly limit (across all courses since it's a safety measure)
  SELECT COUNT(*)
  INTO v_hourly_count
  FROM public.chat_messages cm
  JOIN public.chat_conversations cc ON cm.conversation_id = cc.id
  WHERE cc.user_id = p_user_id
    AND cm.role = 'user'
    AND cm.created_at >= now() - interval '1 hour';
  
  IF v_hourly_count >= v_limit.messages_per_hour THEN
    RETURN false;
  END IF;
  
  RETURN true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 36. increment_ai_usage (from 066_per_course_ai_usage.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.increment_ai_usage(
  p_user_id UUID,
  p_tokens INT DEFAULT 0,
  p_course_id UUID DEFAULT NULL
)
RETURNS VOID AS $$
BEGIN
  INSERT INTO public.ai_usage (user_id, date, messages_count, tokens_used, course_id)
  VALUES (p_user_id, CURRENT_DATE, 1, p_tokens, p_course_id)
  ON CONFLICT (user_id, date, course_id)
  DO UPDATE SET
    messages_count = public.ai_usage.messages_count + 1,
    tokens_used = public.ai_usage.tokens_used + p_tokens,
    updated_at = now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 37. create_ai_conversation (from 066_per_course_ai_usage.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.create_ai_conversation(
  p_user_id UUID,
  p_activity_id UUID DEFAULT NULL,
  p_skill_id UUID DEFAULT NULL,
  p_title TEXT DEFAULT NULL,
  p_course_id UUID DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  v_conversation_id UUID;
  v_course_id UUID;
BEGIN
  -- If course_id not provided but skill_id is, get course from skill
  IF p_course_id IS NULL AND p_skill_id IS NOT NULL THEN
    SELECT s.course_id INTO v_course_id
    FROM public.skills s
    WHERE s.id = p_skill_id;
  ELSE
    v_course_id := p_course_id;
  END IF;

  INSERT INTO public.chat_conversations (user_id, activity_id, skill_id, title, course_id)
  VALUES (p_user_id, p_activity_id, p_skill_id, COALESCE(p_title, 'New Conversation'), v_course_id)
  RETURNING id INTO v_conversation_id;
  
  RETURN v_conversation_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 38. count_active_sessions (from 075_user_session_limit.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.count_active_sessions(p_user_id UUID)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  RETURN (
    SELECT COUNT(*)::INT
    FROM public.user_sessions
    WHERE user_id = p_user_id
      AND is_active = true
      AND expires_at > now()
  );
END;
$$;

-- ============================================
-- 39. register_session (from 075_user_session_limit.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.register_session(
  p_user_id UUID,
  p_session_token_hash TEXT,
  p_device_info TEXT DEFAULT NULL,
  p_ip_address TEXT DEFAULT NULL,
  p_expires_at TIMESTAMPTZ DEFAULT NULL
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_session_id UUID;
  v_expires TIMESTAMPTZ;
BEGIN
  -- Set expiration (default 7 days if not provided)
  v_expires := COALESCE(p_expires_at, now() + INTERVAL '7 days');
  
  -- First, clean up expired sessions
  UPDATE public.user_sessions
  SET is_active = false
  WHERE user_id = p_user_id
    AND (expires_at <= now() OR is_active = false);
  
  -- Delete very old inactive sessions (older than 30 days)
  DELETE FROM public.user_sessions
  WHERE user_id = p_user_id
    AND is_active = false
    AND expires_at < now() - INTERVAL '30 days';
  
  -- Insert the new session
  INSERT INTO public.user_sessions (
    user_id,
    session_token_hash,
    device_info,
    ip_address,
    expires_at
  ) VALUES (
    p_user_id,
    p_session_token_hash,
    p_device_info,
    p_ip_address,
    v_expires
  )
  ON CONFLICT (session_token_hash) 
  DO UPDATE SET
    last_active_at = now(),
    expires_at = v_expires,
    is_active = true
  RETURNING id INTO v_session_id;
  
  RETURN v_session_id;
END;
$$;

-- ============================================
-- 40. enforce_session_limit (from 075_user_session_limit.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.enforce_session_limit(
  p_user_id UUID,
  p_max_sessions INT DEFAULT 2
)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_active_count INT;
  v_to_invalidate INT;
  v_invalidated INT := 0;
BEGIN
  -- Count current active sessions
  SELECT COUNT(*)::INT INTO v_active_count
  FROM public.user_sessions
  WHERE user_id = p_user_id
    AND is_active = true
    AND expires_at > now();
  
  -- Calculate how many to invalidate
  v_to_invalidate := v_active_count - p_max_sessions;
  
  -- If over limit, invalidate oldest sessions
  IF v_to_invalidate > 0 THEN
    WITH oldest_sessions AS (
      SELECT id
      FROM public.user_sessions
      WHERE user_id = p_user_id
        AND is_active = true
        AND expires_at > now()
      ORDER BY created_at ASC
      LIMIT v_to_invalidate
    )
    UPDATE public.user_sessions
    SET is_active = false
    WHERE id IN (SELECT id FROM oldest_sessions);
    
    GET DIAGNOSTICS v_invalidated = ROW_COUNT;
  END IF;
  
  RETURN v_invalidated;
END;
$$;

-- ============================================
-- 41. validate_session (from 075_user_session_limit.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.validate_session(
  p_session_token_hash TEXT
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_is_valid BOOLEAN;
BEGIN
  -- Check if session exists and is valid
  UPDATE public.user_sessions
  SET last_active_at = now()
  WHERE session_token_hash = p_session_token_hash
    AND is_active = true
    AND expires_at > now()
  RETURNING true INTO v_is_valid;
  
  RETURN COALESCE(v_is_valid, false);
END;
$$;

-- ============================================
-- 42. invalidate_session (from 075_user_session_limit.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.invalidate_session(
  p_session_token_hash TEXT
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_invalidated BOOLEAN;
BEGIN
  UPDATE public.user_sessions
  SET is_active = false
  WHERE session_token_hash = p_session_token_hash
  RETURNING true INTO v_invalidated;
  
  RETURN COALESCE(v_invalidated, false);
END;
$$;

-- ============================================
-- 43. invalidate_all_sessions (from 075_user_session_limit.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.invalidate_all_sessions(
  p_user_id UUID
)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_count INT;
BEGIN
  UPDATE public.user_sessions
  SET is_active = false
  WHERE user_id = p_user_id
    AND is_active = true;
  
  GET DIAGNOSTICS v_count = ROW_COUNT;
  RETURN v_count;
END;
$$;

-- ============================================
-- 44. get_user_sessions (from 075_user_session_limit.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_user_sessions(p_user_id UUID)
RETURNS TABLE (
  id UUID,
  device_info TEXT,
  ip_address TEXT,
  created_at TIMESTAMPTZ,
  last_active_at TIMESTAMPTZ,
  is_current BOOLEAN
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id,
    s.device_info,
    s.ip_address,
    s.created_at,
    s.last_active_at,
    false AS is_current
  FROM public.user_sessions s
  WHERE s.user_id = p_user_id
    AND s.is_active = true
    AND s.expires_at > now()
  ORDER BY s.last_active_at DESC;
END;
$$;

-- ============================================
-- 45. cleanup_expired_sessions (from 075_user_session_limit.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.cleanup_expired_sessions()
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_deleted INT;
BEGIN
  -- Mark expired sessions as inactive
  UPDATE public.user_sessions
  SET is_active = false
  WHERE is_active = true
    AND expires_at <= now();
  
  -- Delete very old inactive sessions (older than 90 days)
  DELETE FROM public.user_sessions
  WHERE is_active = false
    AND expires_at < now() - INTERVAL '90 days';
  
  GET DIAGNOSTICS v_deleted = ROW_COUNT;
  RETURN v_deleted;
END;
$$;

-- ============================================
-- 46. get_course_skills (from 086_ma_skill_definitions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_course_skills(
  p_course_id UUID, 
  p_user_id UUID DEFAULT NULL,
  p_category public.skill_category DEFAULT NULL
)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  category public.skill_category,
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
    FROM public.skills s
    LEFT JOIN public.skill_prerequisites sp ON s.id = sp.skill_id
    LEFT JOIN public.user_skill_progress usp ON sp.prerequisite_skill_id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true
      AND (p_category IS NULL OR s.category = p_category)
    GROUP BY s.id
  ),
  activity_counts AS (
    SELECT 
      asks.skill_id,
      COUNT(a.id)::INT AS total_acts,
      COUNT(ap.id) FILTER (WHERE ap.completed = true)::INT AS completed_acts
    FROM public.activity_skills asks
    JOIN public.activities a ON asks.activity_id = a.id AND a.is_published = true
    LEFT JOIN public.activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
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
  FROM public.skills s
  LEFT JOIN public.user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  LEFT JOIN prereq_status ps ON s.id = ps.id
  LEFT JOIN activity_counts ac ON s.id = ac.skill_id
  WHERE s.course_id = p_course_id AND s.is_active = true
    AND (p_category IS NULL OR s.category = p_category)
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 47. get_course_foundations (from 086_ma_skill_definitions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_course_foundations(p_course_id UUID, p_user_id UUID DEFAULT NULL)
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
DECLARE
  foundation_category public.skill_category;
BEGIN
  -- Determine which foundation category to use based on course
  SELECT 
    CASE 
      WHEN c.slug = 'computational-thinking' THEN 'ct_foundations'::public.skill_category
      WHEN c.slug = 'financial-accounting' THEN 'fa_foundations'::public.skill_category
      WHEN c.slug = 'business-mathematics' THEN 'math_foundations'::public.skill_category
      WHEN c.slug = 'managerial-accounting' THEN 'ma_foundations'::public.skill_category
      ELSE 'ct_foundations'::public.skill_category
    END INTO foundation_category
  FROM public.courses c
  WHERE c.id = p_course_id;

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
  FROM public.get_course_skills(p_course_id, p_user_id, foundation_category) cs;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 48. get_course_coding_skills (from 086_ma_skill_definitions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_course_coding_skills(p_course_id UUID, p_user_id UUID DEFAULT NULL)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  category public.skill_category,
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
DECLARE
  foundation_category public.skill_category;
BEGIN
  -- Determine which foundation category to exclude based on course
  SELECT 
    CASE 
      WHEN c.slug = 'computational-thinking' THEN 'ct_foundations'::public.skill_category
      WHEN c.slug = 'financial-accounting' THEN 'fa_foundations'::public.skill_category
      WHEN c.slug = 'business-mathematics' THEN 'math_foundations'::public.skill_category
      WHEN c.slug = 'managerial-accounting' THEN 'ma_foundations'::public.skill_category
      ELSE 'ct_foundations'::public.skill_category
    END INTO foundation_category
  FROM public.courses c
  WHERE c.id = p_course_id;

  RETURN QUERY
  WITH prereq_status AS (
    SELECT 
      s.id,
      COUNT(sp.prerequisite_skill_id)::INT AS prereq_count,
      COUNT(sp.prerequisite_skill_id) FILTER (
        WHERE NOT sp.is_required OR COALESCE(usp.mastery_level, 0) >= 70
      )::INT AS prereqs_met
    FROM public.skills s
    LEFT JOIN public.skill_prerequisites sp ON s.id = sp.skill_id
    LEFT JOIN public.user_skill_progress usp ON sp.prerequisite_skill_id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true AND s.category != foundation_category
    GROUP BY s.id
  ),
  activity_counts AS (
    SELECT 
      asks.skill_id,
      COUNT(a.id)::INT AS total_acts,
      COUNT(ap.id) FILTER (WHERE ap.completed = true)::INT AS completed_acts
    FROM public.activity_skills asks
    JOIN public.activities a ON asks.activity_id = a.id AND a.is_published = true
    LEFT JOIN public.activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
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
  FROM public.skills s
  LEFT JOIN public.user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  LEFT JOIN prereq_status ps ON s.id = ps.id
  LEFT JOIN activity_counts ac ON s.id = ac.skill_id
  WHERE s.course_id = p_course_id AND s.is_active = true AND s.category != foundation_category
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 49. get_course_skill_progress (from 086_ma_skill_definitions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_course_skill_progress(p_course_id UUID, p_user_id UUID)
RETURNS TABLE (
  foundations_total INT,
  foundations_mastered INT,
  foundations_in_progress INT,
  skills_total INT,
  skills_mastered INT,
  skills_in_progress INT,
  overall_progress_percent INT
) AS $$
DECLARE
  foundation_category public.skill_category;
BEGIN
  -- Determine which foundation category based on course
  SELECT 
    CASE 
      WHEN c.slug = 'computational-thinking' THEN 'ct_foundations'::public.skill_category
      WHEN c.slug = 'financial-accounting' THEN 'fa_foundations'::public.skill_category
      WHEN c.slug = 'business-mathematics' THEN 'math_foundations'::public.skill_category
      WHEN c.slug = 'managerial-accounting' THEN 'ma_foundations'::public.skill_category
      ELSE 'ct_foundations'::public.skill_category
    END INTO foundation_category
  FROM public.courses c
  WHERE c.id = p_course_id;

  RETURN QUERY
  WITH skill_stats AS (
    SELECT 
      s.category = foundation_category AS is_foundation,
      COUNT(*)::INT AS total,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) >= 70)::INT AS mastered,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) > 0 AND COALESCE(usp.mastery_level, 0) < 70)::INT AS in_progress
    FROM public.skills s
    LEFT JOIN public.user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true
    GROUP BY s.category = foundation_category
  )
  SELECT 
    COALESCE((SELECT total FROM skill_stats WHERE is_foundation = true), 0),
    COALESCE((SELECT mastered FROM skill_stats WHERE is_foundation = true), 0),
    COALESCE((SELECT in_progress FROM skill_stats WHERE is_foundation = true), 0),
    COALESCE((SELECT total FROM skill_stats WHERE is_foundation = false), 0),
    COALESCE((SELECT mastered FROM skill_stats WHERE is_foundation = false), 0),
    COALESCE((SELECT in_progress FROM skill_stats WHERE is_foundation = false), 0),
    CASE 
      WHEN COALESCE(SUM(total), 0) = 0 THEN 0
      ELSE (COALESCE(SUM(mastered), 0) * 100 / COALESCE(SUM(total), 1))::INT
    END
  FROM skill_stats;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 50. get_user_skill_mastery (from 086_ma_skill_definitions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_user_skill_mastery(p_user_id UUID)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  category public.skill_category,
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
  FROM public.skills s
  LEFT JOIN public.user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  WHERE s.is_active = true
  ORDER BY s.category, s.sort_order;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 51. get_struggling_skills (from 086_ma_skill_definitions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_struggling_skills(p_user_id UUID)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  category public.skill_category,
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
      FROM public.skill_prerequisites sp
      LEFT JOIN public.user_skill_progress prereq_usp ON sp.prerequisite_skill_id = prereq_usp.skill_id AND prereq_usp.user_id = p_user_id
      WHERE sp.skill_id = s.id 
        AND sp.is_required = true
        AND COALESCE(prereq_usp.mastery_level, 0) < 70
    ) AS prerequisite_gaps
  FROM public.skills s
  JOIN public.user_skill_progress usp ON s.id = usp.skill_id
  WHERE usp.user_id = p_user_id
    AND usp.mastery_level < 70
    AND s.is_active = true
  ORDER BY usp.mastery_level ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 52. search_skills (from 086_ma_skill_definitions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.search_skills(p_query TEXT)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  category public.skill_category,
  difficulty_level INT,
  match_rank REAL
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.description AS skill_description,
    s.category,
    s.difficulty_level,
    ts_rank(
      to_tsvector('english', s.name || ' ' || COALESCE(s.description, '')),
      plainto_tsquery('english', p_query)
    ) AS match_rank
  FROM public.skills s
  WHERE s.is_active = true
    AND (
      s.name ILIKE '%' || p_query || '%'
      OR s.description ILIKE '%' || p_query || '%'
      OR to_tsvector('english', s.name || ' ' || COALESCE(s.description, '')) @@ plainto_tsquery('english', p_query)
    )
  ORDER BY match_rank DESC, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 53. get_coding_skill_tree (from 086_ma_skill_definitions.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_coding_skill_tree(p_user_id UUID DEFAULT NULL)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  category public.skill_category,
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
    FROM public.skills s
    LEFT JOIN public.skill_prerequisites sp ON s.id = sp.skill_id
    LEFT JOIN public.user_skill_progress usp ON sp.prerequisite_skill_id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.category NOT IN ('ct_foundations', 'fa_foundations', 'math_foundations', 'ma_foundations') AND s.is_active = true
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
  FROM public.skills s
  LEFT JOIN public.user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  LEFT JOIN prereq_status ps ON s.id = ps.id
  WHERE s.category NOT IN ('ct_foundations', 'fa_foundations', 'math_foundations', 'ma_foundations') AND s.is_active = true
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 54. update_pending_changes_updated_at (from 111_content_management.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.update_pending_changes_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql
SET search_path = '';

-- ============================================
-- 55. is_content_admin (from 111_content_management.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.is_content_admin()
RETURNS BOOLEAN AS $$
DECLARE
  user_role_val public.user_role;
BEGIN
  SELECT role INTO user_role_val
  FROM public.profiles
  WHERE id = auth.uid();
  
  RETURN user_role_val IN ('admin', 'contentadmin');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 56. is_super_admin (from 111_content_management.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.is_super_admin()
RETURNS BOOLEAN AS $$
DECLARE
  user_role_val public.user_role;
BEGIN
  SELECT role INTO user_role_val
  FROM public.profiles
  WHERE id = auth.uid();
  
  RETURN user_role_val = 'admin';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 57. apply_activity_change (from 111_content_management.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.apply_activity_change(change_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
  change_record public.pending_content_changes;
  proposed JSONB;
BEGIN
  -- Get the change record
  SELECT * INTO change_record
  FROM public.pending_content_changes
  WHERE id = change_id AND status = 'approved';
  
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Change not found or not approved';
  END IF;
  
  proposed := change_record.proposed_data;
  
  -- Apply based on change type
  CASE change_record.change_type
    WHEN 'update' THEN
      UPDATE public.activities
      SET
        title = COALESCE(proposed->>'title', title),
        slug = COALESCE(proposed->>'slug', slug),
        type = COALESCE((proposed->>'type')::public.activity_type, type),
        minutes = COALESCE((proposed->>'minutes')::INTEGER, minutes),
        xp = COALESCE((proposed->>'xp')::INTEGER, xp),
        required_plan = COALESCE((proposed->>'required_plan')::public.plan_tier, required_plan),
        content = COALESCE(proposed->'content', content),
        interactive_type = COALESCE(proposed->>'interactive_type', interactive_type),
        starter_code = COALESCE(proposed->>'starter_code', starter_code),
        passing_score = COALESCE((proposed->>'passing_score')::INTEGER, passing_score),
        time_limit = COALESCE((proposed->>'time_limit')::INTEGER, time_limit),
        blocks_progress = COALESCE((proposed->>'blocks_progress')::BOOLEAN, blocks_progress),
        is_published = COALESCE((proposed->>'is_published')::BOOLEAN, is_published),
        updated_at = NOW()
      WHERE id = change_record.entity_id;
      
    WHEN 'create' THEN
      INSERT INTO public.activities (
        id, module_id, external_id, order_index, title, slug, type,
        minutes, xp, required_plan, content, interactive_type,
        starter_code, passing_score, time_limit, blocks_progress, is_published
      ) VALUES (
        COALESCE((proposed->>'id')::UUID, gen_random_uuid()),
        (proposed->>'module_id')::UUID,
        COALESCE(proposed->>'external_id', 'NEW-' || gen_random_uuid()::TEXT),
        COALESCE((proposed->>'order_index')::INTEGER, 999),
        proposed->>'title',
        proposed->>'slug',
        (proposed->>'type')::public.activity_type,
        (proposed->>'minutes')::INTEGER,
        COALESCE((proposed->>'xp')::INTEGER, 10),
        COALESCE((proposed->>'required_plan')::public.plan_tier, 'basic'),
        proposed->'content',
        proposed->>'interactive_type',
        proposed->>'starter_code',
        COALESCE((proposed->>'passing_score')::INTEGER, 70),
        (proposed->>'time_limit')::INTEGER,
        COALESCE((proposed->>'blocks_progress')::BOOLEAN, FALSE),
        COALESCE((proposed->>'is_published')::BOOLEAN, TRUE)
      );
      
    WHEN 'delete' THEN
      -- Soft delete by unpublishing
      UPDATE public.activities
      SET is_published = FALSE, updated_at = NOW()
      WHERE id = change_record.entity_id;
      
    WHEN 'reorder' THEN
      -- Reorder is handled specially - proposed_data contains array of {id, order_index}
      DECLARE
        item JSONB;
      BEGIN
        FOR item IN SELECT * FROM jsonb_array_elements(proposed->'order')
        LOOP
          UPDATE public.activities
          SET order_index = (item->>'order_index')::INTEGER, updated_at = NOW()
          WHERE id = (item->>'id')::UUID;
        END LOOP;
      END;
  END CASE;
  
  RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 58. get_user_subscriptions (from 20251231_fix_subscription_queries.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_user_subscriptions(p_user_id UUID)
RETURNS TABLE (
  subscription_id UUID,
  course_id UUID,
  course_title TEXT,
  course_slug TEXT,
  tier_name TEXT,
  tier_slug TEXT,
  price_monthly DECIMAL,
  status public.subscription_status,
  current_period_start TIMESTAMPTZ,
  current_period_end TIMESTAMPTZ,
  cancel_at_period_end BOOLEAN,
  stripe_subscription_id TEXT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id,
    c.id,
    c.title,
    c.slug,
    st.name,
    st.slug,
    st.price_monthly,
    s.status,
    s.current_period_start,
    s.current_period_end,
    s.cancel_at_period_end,
    s.stripe_subscription_id
  FROM public.subscriptions s
  JOIN public.subscription_tiers st ON s.tier_id = st.id
  JOIN public.courses c ON s.course_id = c.id
  WHERE s.user_id = p_user_id
    AND s.status IN ('active', 'trialing', 'cancelled')
    AND s.current_period_end > now()
  ORDER BY s.current_period_end DESC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- 59. get_user_course_subscription (from 20251231_fix_subscription_queries.sql)
-- ============================================
CREATE OR REPLACE FUNCTION public.get_user_course_subscription(p_user_id UUID, p_course_id UUID)
RETURNS TABLE (
  subscription_id UUID,
  tier_name TEXT,
  tier_slug TEXT,
  status public.subscription_status,
  current_period_start TIMESTAMPTZ,
  current_period_end TIMESTAMPTZ,
  cancel_at_period_end BOOLEAN,
  stripe_subscription_id TEXT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id,
    st.name,
    st.slug,
    s.status,
    s.current_period_start,
    s.current_period_end,
    s.cancel_at_period_end,
    s.stripe_subscription_id
  FROM public.subscriptions s
  JOIN public.subscription_tiers st ON s.tier_id = st.id
  WHERE s.user_id = p_user_id
    AND s.course_id = p_course_id
    AND s.status IN ('active', 'trialing', 'cancelled')
    AND s.current_period_end > now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = '';

-- ============================================
-- Verification Notice
-- ============================================

DO $$
BEGIN
  RAISE NOTICE '═══════════════════════════════════════════════════════════════════';
  RAISE NOTICE 'Security Fix Migration Complete';
  RAISE NOTICE '═══════════════════════════════════════════════════════════════════';
  RAISE NOTICE 'Fixed search_path on 59 functions to prevent search path injection';
  RAISE NOTICE 'All SECURITY DEFINER functions now have SET search_path = ''''';
  RAISE NOTICE '═══════════════════════════════════════════════════════════════════';
END $$;

