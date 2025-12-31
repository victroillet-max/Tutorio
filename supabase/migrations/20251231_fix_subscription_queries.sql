-- ============================================
-- Fix Subscription Query Functions
-- Ensures proper period_end filtering
-- ============================================

-- Update get_user_subscriptions to filter out truly expired subscriptions
-- but keep cancelled ones that still have access until period_end
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
    -- Only show subscriptions that are still within their access period
    AND s.current_period_end > now()
  ORDER BY s.current_period_end DESC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Also update get_user_course_subscription to ensure consistency
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

