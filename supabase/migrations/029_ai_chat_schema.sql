-- ============================================
-- AI Chat Database Schema
-- Conversations, messages, and usage tracking
-- ============================================

-- ============================================
-- Chat Conversations Table
-- ============================================

CREATE TABLE chat_conversations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  activity_id UUID REFERENCES activities(id) ON DELETE SET NULL,
  skill_id UUID REFERENCES skills(id) ON DELETE SET NULL,
  title TEXT,
  is_active BOOLEAN DEFAULT true,
  message_count INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

CREATE INDEX idx_chat_conversations_user ON chat_conversations(user_id);
CREATE INDEX idx_chat_conversations_activity ON chat_conversations(activity_id);
CREATE INDEX idx_chat_conversations_skill ON chat_conversations(skill_id);
CREATE INDEX idx_chat_conversations_active ON chat_conversations(user_id, is_active);

-- ============================================
-- Chat Messages Table
-- ============================================

CREATE TABLE chat_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id UUID NOT NULL REFERENCES chat_conversations(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('user', 'assistant', 'system')),
  content TEXT NOT NULL,
  metadata JSONB DEFAULT '{}'::jsonb,  -- Stores skill context, code snippets, etc.
  tokens_used INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

CREATE INDEX idx_chat_messages_conversation ON chat_messages(conversation_id);
CREATE INDEX idx_chat_messages_created ON chat_messages(conversation_id, created_at);

-- ============================================
-- AI Usage Tracking (for rate limiting)
-- ============================================

CREATE TABLE ai_usage (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  messages_count INT DEFAULT 0,
  tokens_used INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  
  CONSTRAINT unique_user_date UNIQUE(user_id, date)
);

CREATE INDEX idx_ai_usage_user ON ai_usage(user_id);
CREATE INDEX idx_ai_usage_date ON ai_usage(user_id, date);

-- ============================================
-- AI Rate Limits (by tier)
-- ============================================

CREATE TABLE ai_rate_limits (
  tier plan_tier PRIMARY KEY,
  messages_per_day INT NOT NULL,
  messages_per_hour INT NOT NULL,
  max_context_messages INT DEFAULT 10,
  features JSONB DEFAULT '{}'::jsonb
);

-- Insert default rate limits
INSERT INTO ai_rate_limits (tier, messages_per_day, messages_per_hour, max_context_messages, features) VALUES
('free', 10, 5, 5, '{"basicQA": true, "errorExplanations": true, "hints": false, "debugging": false, "diagnostics": false}'::jsonb),
('basic', 50, 20, 10, '{"basicQA": true, "errorExplanations": true, "hints": true, "debugging": true, "diagnostics": false, "skillSuggestions": true}'::jsonb),
('advanced', 500, 50, 20, '{"basicQA": true, "errorExplanations": true, "hints": true, "debugging": true, "diagnostics": true, "skillSuggestions": true, "personalizedTutoring": true}'::jsonb);

-- ============================================
-- Enable RLS
-- ============================================

ALTER TABLE chat_conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE chat_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_usage ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_rate_limits ENABLE ROW LEVEL SECURITY;

-- ============================================
-- RLS Policies
-- ============================================

-- Chat Conversations: Users can manage their own
CREATE POLICY "Users can view own conversations"
  ON chat_conversations FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create own conversations"
  ON chat_conversations FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own conversations"
  ON chat_conversations FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own conversations"
  ON chat_conversations FOR DELETE
  USING (auth.uid() = user_id);

-- Admins can view all conversations
CREATE POLICY "Admins can view all conversations"
  ON chat_conversations FOR SELECT
  USING (is_admin());

-- Chat Messages: Users can manage their own (via conversation)
CREATE POLICY "Users can view own messages"
  ON chat_messages FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM chat_conversations cc
      WHERE cc.id = chat_messages.conversation_id
      AND cc.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can create own messages"
  ON chat_messages FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM chat_conversations cc
      WHERE cc.id = chat_messages.conversation_id
      AND cc.user_id = auth.uid()
    )
  );

-- Admins can view all messages
CREATE POLICY "Admins can view all messages"
  ON chat_messages FOR SELECT
  USING (is_admin());

-- AI Usage: Users can view their own usage
CREATE POLICY "Users can view own usage"
  ON ai_usage FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create own usage"
  ON ai_usage FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own usage"
  ON ai_usage FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Admins can view all usage
CREATE POLICY "Admins can view all usage"
  ON ai_usage FOR SELECT
  USING (is_admin());

-- AI Rate Limits: Anyone can view
CREATE POLICY "Anyone can view rate limits"
  ON ai_rate_limits FOR SELECT
  USING (true);

-- Admins can manage rate limits
CREATE POLICY "Admins can manage rate limits"
  ON ai_rate_limits FOR ALL
  USING (is_admin());

-- ============================================
-- Triggers
-- ============================================

CREATE TRIGGER update_chat_conversations_updated_at
  BEFORE UPDATE ON chat_conversations
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_ai_usage_updated_at
  BEFORE UPDATE ON ai_usage
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Update conversation message count when message is added
CREATE OR REPLACE FUNCTION update_conversation_message_count()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE chat_conversations
  SET message_count = message_count + 1,
      updated_at = now()
  WHERE id = NEW.conversation_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER increment_message_count
  AFTER INSERT ON chat_messages
  FOR EACH ROW EXECUTE FUNCTION update_conversation_message_count();

-- ============================================
-- Helper Functions
-- ============================================

-- Get user's current rate limit based on subscription
CREATE OR REPLACE FUNCTION get_user_rate_limit(p_user_id UUID)
RETURNS TABLE (
  tier plan_tier,
  messages_per_day INT,
  messages_per_hour INT,
  messages_used_today INT,
  messages_remaining_today INT,
  features JSONB
) AS $$
DECLARE
  v_user_tier plan_tier;
  v_messages_today INT;
BEGIN
  -- Get user's subscription tier (default to 'free')
  SELECT COALESCE(
    (SELECT st.slug::plan_tier
     FROM subscriptions s
     JOIN subscription_tiers st ON s.tier_id = st.id
     WHERE s.user_id = p_user_id
       AND s.status IN ('active', 'trialing')
       AND s.current_period_end > now()
     LIMIT 1),
    'free'::plan_tier
  ) INTO v_user_tier;
  
  -- Get messages used today
  SELECT COALESCE(au.messages_count, 0)
  INTO v_messages_today
  FROM ai_usage au
  WHERE au.user_id = p_user_id AND au.date = CURRENT_DATE;
  
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
    arl.features
  FROM ai_rate_limits arl
  WHERE arl.tier = v_user_tier;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Check if user can send message
CREATE OR REPLACE FUNCTION can_send_ai_message(p_user_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
  v_limit RECORD;
  v_hourly_count INT;
BEGIN
  -- Get rate limit info
  SELECT * INTO v_limit FROM get_user_rate_limit(p_user_id);
  
  IF v_limit IS NULL THEN
    RETURN false;
  END IF;
  
  -- Check daily limit
  IF v_limit.messages_used_today >= v_limit.messages_per_day THEN
    RETURN false;
  END IF;
  
  -- Check hourly limit
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

-- Increment usage when message is sent
CREATE OR REPLACE FUNCTION increment_ai_usage(
  p_user_id UUID,
  p_tokens INT DEFAULT 0
)
RETURNS VOID AS $$
BEGIN
  INSERT INTO ai_usage (user_id, date, messages_count, tokens_used)
  VALUES (p_user_id, CURRENT_DATE, 1, p_tokens)
  ON CONFLICT (user_id, date)
  DO UPDATE SET
    messages_count = ai_usage.messages_count + 1,
    tokens_used = ai_usage.tokens_used + p_tokens,
    updated_at = now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Get conversation history with context
CREATE OR REPLACE FUNCTION get_conversation_context(
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
  FROM chat_messages cm
  WHERE cm.conversation_id = p_conversation_id
  ORDER BY cm.created_at DESC
  LIMIT p_limit;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create a new conversation with skill context
CREATE OR REPLACE FUNCTION create_ai_conversation(
  p_user_id UUID,
  p_activity_id UUID DEFAULT NULL,
  p_skill_id UUID DEFAULT NULL,
  p_title TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  v_conversation_id UUID;
BEGIN
  INSERT INTO chat_conversations (user_id, activity_id, skill_id, title)
  VALUES (p_user_id, p_activity_id, p_skill_id, COALESCE(p_title, 'New Conversation'))
  RETURNING id INTO v_conversation_id;
  
  RETURN v_conversation_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Get skill context for AI prompt building
CREATE OR REPLACE FUNCTION get_ai_skill_context(p_user_id UUID)
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
      SELECT s.slug FROM skills s
      JOIN user_skill_progress usp ON s.id = usp.skill_id
      WHERE usp.user_id = p_user_id AND usp.mastery_level >= 70
    ) AS mastered_skills,
    ARRAY(
      SELECT s.slug FROM skills s
      JOIN user_skill_progress usp ON s.id = usp.skill_id
      WHERE usp.user_id = p_user_id AND usp.mastery_level < 70 AND usp.mastery_level > 0
    ) AS struggling_skills,
    NULL::TEXT AS current_activity_skill,
    (
      SELECT jsonb_object_agg(s.slug, usp.mastery_level)
      FROM skills s
      JOIN user_skill_progress usp ON s.id = usp.skill_id
      WHERE usp.user_id = p_user_id
    ) AS mastery_levels;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

