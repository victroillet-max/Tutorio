-- ============================================
-- Per-Course AI Usage Tracking
-- Updates AI usage to be tracked per course
-- ============================================

-- Add course_id to ai_usage table
ALTER TABLE ai_usage ADD COLUMN IF NOT EXISTS course_id UUID REFERENCES courses(id) ON DELETE CASCADE;

-- Drop the old unique constraint
ALTER TABLE ai_usage DROP CONSTRAINT IF EXISTS unique_user_date;

-- Add new unique constraint for user + date + course
ALTER TABLE ai_usage ADD CONSTRAINT unique_user_date_course UNIQUE(user_id, date, course_id);

-- Create index for course-based queries
CREATE INDEX IF NOT EXISTS idx_ai_usage_course ON ai_usage(course_id);
CREATE INDEX IF NOT EXISTS idx_ai_usage_user_date_course ON ai_usage(user_id, date, course_id);

-- ============================================
-- Update get_user_rate_limit to be per-course
-- ============================================

DROP FUNCTION IF EXISTS get_user_rate_limit(UUID);

CREATE OR REPLACE FUNCTION get_user_rate_limit(
  p_user_id UUID,
  p_course_id UUID DEFAULT NULL
)
RETURNS TABLE (
  tier plan_tier,
  messages_per_day INT,
  messages_per_hour INT,
  messages_used_today INT,
  messages_remaining_today INT,
  features JSONB,
  course_id UUID
) AS $$
DECLARE
  v_user_tier plan_tier;
  v_messages_today INT;
BEGIN
  -- Get user's subscription tier for the specific course (or highest tier if no course specified)
  IF p_course_id IS NOT NULL THEN
    SELECT COALESCE(
      (SELECT st.slug::plan_tier
       FROM subscriptions s
       JOIN subscription_tiers st ON s.tier_id = st.id
       WHERE s.user_id = p_user_id
         AND s.course_id = p_course_id
         AND s.status IN ('active', 'trialing')
         AND s.current_period_end > now()
       LIMIT 1),
      'free'::plan_tier
    ) INTO v_user_tier;
  ELSE
    -- Get best tier across all courses (fallback for backward compatibility)
    SELECT COALESCE(
      (SELECT st.slug::plan_tier
       FROM subscriptions s
       JOIN subscription_tiers st ON s.tier_id = st.id
       WHERE s.user_id = p_user_id
         AND s.status IN ('active', 'trialing')
         AND s.current_period_end > now()
       ORDER BY CASE st.slug WHEN 'advanced' THEN 1 WHEN 'basic' THEN 2 ELSE 3 END
       LIMIT 1),
      'free'::plan_tier
    ) INTO v_user_tier;
  END IF;
  
  -- Get messages used today for this course
  IF p_course_id IS NOT NULL THEN
    SELECT COALESCE(SUM(au.messages_count), 0)
    INTO v_messages_today
    FROM ai_usage au
    WHERE au.user_id = p_user_id 
      AND au.date = CURRENT_DATE
      AND au.course_id = p_course_id;
  ELSE
    -- Get total messages across all courses (fallback)
    SELECT COALESCE(SUM(au.messages_count), 0)
    INTO v_messages_today
    FROM ai_usage au
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
  FROM ai_rate_limits arl
  WHERE arl.tier = v_user_tier;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- Update can_send_ai_message to be per-course
-- ============================================

DROP FUNCTION IF EXISTS can_send_ai_message(UUID);

CREATE OR REPLACE FUNCTION can_send_ai_message(
  p_user_id UUID,
  p_course_id UUID DEFAULT NULL
)
RETURNS BOOLEAN AS $$
DECLARE
  v_limit RECORD;
  v_hourly_count INT;
BEGIN
  -- Get rate limit info for this course
  SELECT * INTO v_limit FROM get_user_rate_limit(p_user_id, p_course_id);
  
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
  FROM chat_messages cm
  JOIN chat_conversations cc ON cm.conversation_id = cc.id
  WHERE cc.user_id = p_user_id
    AND cm.role = 'user'
    AND cm.created_at >= now() - interval '1 hour';
  
  IF v_hourly_count >= v_limit.messages_per_hour THEN
    RETURN false;
  END IF;
  
  RETURN true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- Update increment_ai_usage to support course_id
-- ============================================

DROP FUNCTION IF EXISTS increment_ai_usage(UUID, INT);

CREATE OR REPLACE FUNCTION increment_ai_usage(
  p_user_id UUID,
  p_tokens INT DEFAULT 0,
  p_course_id UUID DEFAULT NULL
)
RETURNS VOID AS $$
BEGIN
  INSERT INTO ai_usage (user_id, date, messages_count, tokens_used, course_id)
  VALUES (p_user_id, CURRENT_DATE, 1, p_tokens, p_course_id)
  ON CONFLICT (user_id, date, course_id)
  DO UPDATE SET
    messages_count = ai_usage.messages_count + 1,
    tokens_used = ai_usage.tokens_used + p_tokens,
    updated_at = now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- Add course_id to chat_conversations for better tracking
-- ============================================

ALTER TABLE chat_conversations ADD COLUMN IF NOT EXISTS course_id UUID REFERENCES courses(id) ON DELETE SET NULL;
CREATE INDEX IF NOT EXISTS idx_chat_conversations_course ON chat_conversations(course_id);

-- ============================================
-- Update create_ai_conversation to support course_id
-- ============================================

DROP FUNCTION IF EXISTS create_ai_conversation(UUID, UUID, UUID, TEXT);

CREATE OR REPLACE FUNCTION create_ai_conversation(
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
    FROM skills s
    WHERE s.id = p_skill_id;
  ELSE
    v_course_id := p_course_id;
  END IF;

  INSERT INTO chat_conversations (user_id, activity_id, skill_id, title, course_id)
  VALUES (p_user_id, p_activity_id, p_skill_id, COALESCE(p_title, 'New Conversation'), v_course_id)
  RETURNING id INTO v_conversation_id;
  
  RETURN v_conversation_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


