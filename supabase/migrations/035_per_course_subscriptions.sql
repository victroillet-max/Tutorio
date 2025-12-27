-- ============================================
-- Per-Course Subscription Model Migration
-- Transforms global subscriptions to per-course subscriptions
-- ============================================

-- ============================================
-- Phase 1: Schema Changes for Subscriptions
-- ============================================

-- Add course_id to subscriptions table (making subscriptions per-course)
ALTER TABLE subscriptions ADD COLUMN course_id UUID REFERENCES courses(id) ON DELETE CASCADE;

-- Drop the old unique constraint (one subscription per user)
ALTER TABLE subscriptions DROP CONSTRAINT IF EXISTS unique_active_subscription;

-- Add new unique constraint (one subscription per user per course)
ALTER TABLE subscriptions ADD CONSTRAINT unique_course_subscription UNIQUE (user_id, course_id);

-- Create index for course-based subscription lookups
CREATE INDEX IF NOT EXISTS idx_subscriptions_course ON subscriptions(course_id);
CREATE INDEX IF NOT EXISTS idx_subscriptions_user_course ON subscriptions(user_id, course_id);

-- ============================================
-- Phase 2: Add Demo Configuration to Courses
-- ============================================

-- Add demo_activity_count column to courses (default: 5 free activities)
ALTER TABLE courses ADD COLUMN IF NOT EXISTS demo_activity_count INT DEFAULT 5;

-- ============================================
-- Phase 3: Update Subscription Tiers
-- ============================================

-- Delete existing tiers and create new ones for per-course model
DELETE FROM subscription_tiers WHERE slug IN ('free', 'basic', 'advanced');

-- Insert new subscription tiers for per-course model
INSERT INTO subscription_tiers (id, name, slug, description, price_monthly, price_yearly, features, is_active, sort_order) VALUES
  (
    'a0000000-0000-0000-0000-000000000010',
    'Basic',
    'basic',
    'Core course access with limited AI tutor assistance',
    10.00,
    100.00,
    '{
      "fullCourseAccess": true,
      "aiMessagesPerDay": 25,
      "textLessons": true,
      "quizzes": true,
      "codeEditor": true,
      "interactiveVisualizers": true,
      "codingChallenges": true,
      "progressDashboard": "full",
      "limitedAiTutor": true
    }'::jsonb,
    true,
    1
  ),
  (
    'a0000000-0000-0000-0000-000000000011',
    'Advanced',
    'advanced',
    'Complete course access with unlimited AI tutor assistance',
    20.00,
    200.00,
    '{
      "fullCourseAccess": true,
      "aiMessagesPerDay": "unlimited",
      "textLessons": true,
      "quizzes": true,
      "codeEditor": true,
      "interactiveVisualizers": true,
      "codingChallenges": true,
      "progressDashboard": "full",
      "unlimitedAiTutor": true,
      "prioritySupport": true
    }'::jsonb,
    true,
    2
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price_monthly = EXCLUDED.price_monthly,
  price_yearly = EXCLUDED.price_yearly,
  features = EXCLUDED.features,
  sort_order = EXCLUDED.sort_order;

-- ============================================
-- Phase 4: Update AI Rate Limits
-- ============================================

-- Update rate limits for new tier structure
-- Demo users (no subscription): 5 messages/day
-- Basic: 25 messages/day
-- Advanced: 1000 messages/day (effectively unlimited)

UPDATE ai_rate_limits SET 
  messages_per_day = 5,
  messages_per_hour = 3,
  max_context_messages = 5,
  features = '{"basicQA": true, "errorExplanations": true, "hints": false, "debugging": false}'::jsonb
WHERE tier = 'free';

UPDATE ai_rate_limits SET 
  messages_per_day = 25,
  messages_per_hour = 15,
  max_context_messages = 10,
  features = '{"basicQA": true, "errorExplanations": true, "hints": true, "debugging": true, "skillSuggestions": true}'::jsonb
WHERE tier = 'basic';

UPDATE ai_rate_limits SET 
  messages_per_day = 1000,
  messages_per_hour = 100,
  max_context_messages = 20,
  features = '{"basicQA": true, "errorExplanations": true, "hints": true, "debugging": true, "skillSuggestions": true, "personalizedTutoring": true, "codeReview": true}'::jsonb
WHERE tier = 'advanced';

-- ============================================
-- Phase 5: Course-Aware Access Control Functions
-- ============================================

-- Check if user has an active subscription for a specific course
CREATE OR REPLACE FUNCTION has_course_subscription(p_course_id UUID, required_tier TEXT DEFAULT NULL)
RETURNS BOOLEAN AS $$
DECLARE
  v_user_tier TEXT;
BEGIN
  -- Get user's subscription tier for this course
  SELECT st.slug INTO v_user_tier
  FROM subscriptions s
  JOIN subscription_tiers st ON s.tier_id = st.id
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
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Get user's subscription tier for a specific course
CREATE OR REPLACE FUNCTION get_course_subscription_tier(p_course_id UUID)
RETURNS TEXT AS $$
DECLARE
  v_tier TEXT;
BEGIN
  SELECT st.slug INTO v_tier
  FROM subscriptions s
  JOIN subscription_tiers st ON s.tier_id = st.id
  WHERE s.user_id = auth.uid()
    AND s.course_id = p_course_id
    AND s.status IN ('active', 'trialing')
    AND s.current_period_end > now();
  
  RETURN v_tier;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Check if an activity is within the demo limit for its course
CREATE OR REPLACE FUNCTION is_demo_activity(p_activity_id UUID)
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
      FROM activities a2
      JOIN modules m2 ON a2.module_id = m2.id
      WHERE m2.course_id = c.id
        AND a2.is_published = true
        AND (
          m2.order_index < m.order_index
          OR (m2.order_index = m.order_index AND a2.order_index <= a.order_index)
        )
    )::INT
  INTO v_course_id, v_demo_limit, v_activity_global_index
  FROM activities a
  JOIN modules m ON a.module_id = m.id
  JOIN courses c ON m.course_id = c.id
  WHERE a.id = p_activity_id;
  
  -- If we couldn't find the activity, return false
  IF v_course_id IS NULL THEN
    RETURN false;
  END IF;
  
  -- Check if within demo limit
  RETURN v_activity_global_index <= v_demo_limit;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Get activity access status for a user
CREATE OR REPLACE FUNCTION get_activity_access(p_activity_id UUID)
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
  FROM activities a
  JOIN modules m ON a.module_id = m.id
  JOIN courses c ON m.course_id = c.id
  WHERE a.id = p_activity_id;
  
  IF v_course_id IS NULL THEN
    RETURN;
  END IF;
  
  -- Check if demo activity
  v_is_demo := is_demo_activity(p_activity_id);
  
  -- Get subscription tier
  v_tier := get_course_subscription_tier(v_course_id);
  
  -- Count demo activities completed by user in this course
  SELECT COUNT(*)::INT INTO v_demo_count
  FROM activity_progress ap
  JOIN activities a ON ap.activity_id = a.id
  JOIN modules m ON a.module_id = m.id
  WHERE ap.user_id = auth.uid()
    AND m.course_id = v_course_id
    AND ap.completed = true
    AND is_demo_activity(a.id);
  
  RETURN QUERY SELECT 
    (v_is_demo OR v_tier IS NOT NULL) AS has_access,
    v_is_demo AS is_demo,
    v_tier AS subscription_tier,
    v_course_id,
    COALESCE(v_demo_count, 0) AS demo_activities_used,
    v_demo_limit AS demo_activities_total;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Get user's subscription info for a course
CREATE OR REPLACE FUNCTION get_user_course_subscription(p_user_id UUID, p_course_id UUID)
RETURNS TABLE (
  subscription_id UUID,
  tier_name TEXT,
  tier_slug TEXT,
  status subscription_status,
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
  FROM subscriptions s
  JOIN subscription_tiers st ON s.tier_id = st.id
  WHERE s.user_id = p_user_id
    AND s.course_id = p_course_id
    AND s.status IN ('active', 'trialing', 'cancelled')
    AND s.current_period_end > now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Get all active subscriptions for a user
CREATE OR REPLACE FUNCTION get_user_subscriptions(p_user_id UUID)
RETURNS TABLE (
  subscription_id UUID,
  course_id UUID,
  course_title TEXT,
  course_slug TEXT,
  tier_name TEXT,
  tier_slug TEXT,
  price_monthly DECIMAL,
  status subscription_status,
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
  FROM subscriptions s
  JOIN subscription_tiers st ON s.tier_id = st.id
  JOIN courses c ON s.course_id = c.id
  WHERE s.user_id = p_user_id
    AND s.status IN ('active', 'trialing', 'cancelled')
  ORDER BY s.current_period_end DESC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- Phase 6: Update AI Rate Limit Functions
-- ============================================

-- Update get_user_rate_limit to be course-aware
-- For AI, we use the HIGHEST tier the user has across all their subscriptions
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
  -- Get user's highest subscription tier across all courses
  -- Priority: advanced > basic > free (demo)
  SELECT COALESCE(
    (SELECT 
      CASE 
        WHEN st.slug = 'advanced' THEN 'advanced'::plan_tier
        WHEN st.slug = 'basic' THEN 'basic'::plan_tier
        ELSE 'free'::plan_tier
      END
     FROM subscriptions s
     JOIN subscription_tiers st ON s.tier_id = st.id
     WHERE s.user_id = p_user_id
       AND s.status IN ('active', 'trialing')
       AND s.current_period_end > now()
     ORDER BY st.sort_order DESC
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

-- ============================================
-- Phase 7: Update RLS Policies for Activities
-- ============================================

-- Drop existing activity policies
DROP POLICY IF EXISTS "Authenticated users can view free activities" ON activities;
DROP POLICY IF EXISTS "Subscribers can view basic activities" ON activities;
DROP POLICY IF EXISTS "Advanced subscribers can view advanced activities" ON activities;

-- New policy: Demo activities (first N) are visible to all authenticated users
CREATE POLICY "Authenticated users can view demo activities"
  ON activities FOR SELECT
  USING (
    is_published = true
    AND auth.uid() IS NOT NULL
    AND is_demo_activity(id)
  );

-- New policy: All activities visible to users with course subscription
CREATE POLICY "Subscribers can view all course activities"
  ON activities FOR SELECT
  USING (
    is_published = true
    AND EXISTS (
      SELECT 1 FROM modules m
      JOIN courses c ON m.course_id = c.id
      WHERE m.id = activities.module_id
        AND has_course_subscription(c.id, NULL)
    )
  );

-- Keep admin policy (should already exist, but ensure it does)
DROP POLICY IF EXISTS "Admins can manage activities" ON activities;
CREATE POLICY "Admins can manage activities"
  ON activities FOR ALL
  USING (is_admin());

-- ============================================
-- Phase 8: Helper View for Course Subscription Status
-- ============================================

-- Create a view to easily check course subscription status
CREATE OR REPLACE VIEW user_course_access AS
SELECT 
  c.id AS course_id,
  c.title AS course_title,
  c.slug AS course_slug,
  c.demo_activity_count,
  get_course_subscription_tier(c.id) AS subscription_tier,
  CASE 
    WHEN get_course_subscription_tier(c.id) IS NOT NULL THEN true
    ELSE false
  END AS has_full_access,
  (
    SELECT COUNT(*)::INT
    FROM activities a
    JOIN modules m ON a.module_id = m.id
    WHERE m.course_id = c.id AND a.is_published = true
  ) AS total_activities
FROM courses c
WHERE c.is_published = true;

-- ============================================
-- Phase 9: Subscription Management Functions
-- ============================================

-- Create or update a course subscription
CREATE OR REPLACE FUNCTION create_course_subscription(
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
  FROM subscription_tiers
  WHERE slug = p_tier_slug AND is_active = true;
  
  IF v_tier_id IS NULL THEN
    RAISE EXCEPTION 'Invalid subscription tier: %', p_tier_slug;
  END IF;
  
  -- Create or update the subscription
  INSERT INTO subscriptions (
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
    stripe_subscription_id = COALESCE(p_stripe_subscription_id, subscriptions.stripe_subscription_id),
    stripe_customer_id = COALESCE(p_stripe_customer_id, subscriptions.stripe_customer_id),
    updated_at = now()
  RETURNING id INTO v_subscription_id;
  
  RETURN v_subscription_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Upgrade a subscription from basic to advanced
CREATE OR REPLACE FUNCTION upgrade_course_subscription(
  p_user_id UUID,
  p_course_id UUID
)
RETURNS BOOLEAN AS $$
DECLARE
  v_advanced_tier_id UUID;
BEGIN
  -- Get advanced tier ID
  SELECT id INTO v_advanced_tier_id
  FROM subscription_tiers
  WHERE slug = 'advanced' AND is_active = true;
  
  IF v_advanced_tier_id IS NULL THEN
    RETURN false;
  END IF;
  
  -- Update the subscription
  UPDATE subscriptions
  SET tier_id = v_advanced_tier_id,
      updated_at = now()
  WHERE user_id = p_user_id
    AND course_id = p_course_id
    AND status IN ('active', 'trialing');
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Cancel a course subscription (will expire at period end)
CREATE OR REPLACE FUNCTION cancel_course_subscription(
  p_user_id UUID,
  p_course_id UUID
)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE subscriptions
  SET cancel_at_period_end = true,
      cancelled_at = now(),
      updated_at = now()
  WHERE user_id = p_user_id
    AND course_id = p_course_id
    AND status IN ('active', 'trialing');
  
  RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- Phase 10: Grant Permissions
-- ============================================

-- Grant execute permissions on new functions
GRANT EXECUTE ON FUNCTION has_course_subscription(UUID, TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION get_course_subscription_tier(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION is_demo_activity(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION get_activity_access(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION get_user_course_subscription(UUID, UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION get_user_subscriptions(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION create_course_subscription(UUID, UUID, TEXT, TEXT, TEXT) TO service_role;
GRANT EXECUTE ON FUNCTION upgrade_course_subscription(UUID, UUID) TO service_role;
GRANT EXECUTE ON FUNCTION cancel_course_subscription(UUID, UUID) TO service_role;

-- Grant access to the view
GRANT SELECT ON user_course_access TO authenticated;

