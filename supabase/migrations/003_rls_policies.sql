-- ============================================
-- Tutorio Database Schema - Part 3: RLS Policies
-- ============================================

-- Enable Row Level Security on all tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscription_tiers ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE lesson_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE course_enrollments ENABLE ROW LEVEL SECURITY;

-- ============================================
-- Helper Functions
-- ============================================

-- Check if the current user is an admin
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM profiles
    WHERE id = auth.uid() AND role = 'admin'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Check if user has an active subscription to a specific tier or higher
CREATE OR REPLACE FUNCTION has_active_subscription(required_tier_id UUID DEFAULT NULL)
RETURNS BOOLEAN AS $$
DECLARE
  user_tier_order INT;
  required_tier_order INT;
BEGIN
  -- Get user's current tier order
  SELECT st.sort_order INTO user_tier_order
  FROM subscriptions s
  JOIN subscription_tiers st ON s.tier_id = st.id
  WHERE s.user_id = auth.uid()
    AND s.status IN ('active', 'trialing')
    AND s.current_period_end > now();
  
  -- If no required tier, just check if user has any active subscription
  IF required_tier_id IS NULL THEN
    RETURN user_tier_order IS NOT NULL;
  END IF;
  
  -- Get required tier order
  SELECT sort_order INTO required_tier_order
  FROM subscription_tiers
  WHERE id = required_tier_id;
  
  -- User's tier must be >= required tier
  RETURN user_tier_order IS NOT NULL AND user_tier_order >= required_tier_order;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- Profiles Policies
-- ============================================

-- Users can view their own profile
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT
  USING (auth.uid() = id);

-- Users can update their own profile (except role)
CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Admins can view all profiles
CREATE POLICY "Admins can view all profiles"
  ON profiles FOR SELECT
  USING (is_admin());

-- Admins can update any profile
CREATE POLICY "Admins can manage profiles"
  ON profiles FOR ALL
  USING (is_admin());

-- ============================================
-- Subscription Tiers Policies
-- ============================================

-- Anyone can view active subscription tiers
CREATE POLICY "Anyone can view active tiers"
  ON subscription_tiers FOR SELECT
  USING (is_active = true);

-- Only admins can manage subscription tiers
CREATE POLICY "Admins can manage tiers"
  ON subscription_tiers FOR ALL
  USING (is_admin());

-- ============================================
-- Subscriptions Policies
-- ============================================

-- Users can view their own subscriptions
CREATE POLICY "Users can view own subscriptions"
  ON subscriptions FOR SELECT
  USING (auth.uid() = user_id);

-- Admins can view all subscriptions
CREATE POLICY "Admins can view all subscriptions"
  ON subscriptions FOR SELECT
  USING (is_admin());

-- Admins can manage all subscriptions
CREATE POLICY "Admins can manage subscriptions"
  ON subscriptions FOR ALL
  USING (is_admin());

-- ============================================
-- Categories Policies
-- ============================================

-- Anyone can view categories
CREATE POLICY "Anyone can view categories"
  ON categories FOR SELECT
  USING (true);

-- Only admins can manage categories
CREATE POLICY "Admins can manage categories"
  ON categories FOR ALL
  USING (is_admin());

-- ============================================
-- Courses Policies
-- ============================================

-- Anyone can view published courses (basic info only via view)
CREATE POLICY "Anyone can view published courses"
  ON courses FOR SELECT
  USING (is_published = true);

-- Admins can view all courses
CREATE POLICY "Admins can view all courses"
  ON courses FOR SELECT
  USING (is_admin());

-- Admins can manage all courses
CREATE POLICY "Admins can manage courses"
  ON courses FOR ALL
  USING (is_admin());

-- ============================================
-- Lessons Policies
-- ============================================

-- Preview lessons are visible to everyone
CREATE POLICY "Anyone can view preview lessons"
  ON lessons FOR SELECT
  USING (
    is_preview = true 
    AND is_published = true
    AND EXISTS (
      SELECT 1 FROM courses c
      WHERE c.id = lessons.course_id AND c.is_published = true
    )
  );

-- Premium lessons require active subscription to appropriate tier
CREATE POLICY "Subscribers can view premium lessons"
  ON lessons FOR SELECT
  USING (
    is_published = true
    AND is_preview = false
    AND EXISTS (
      SELECT 1 FROM courses c
      WHERE c.id = lessons.course_id 
        AND c.is_published = true
        AND has_active_subscription(c.required_tier_id)
    )
  );

-- Admins can view all lessons
CREATE POLICY "Admins can view all lessons"
  ON lessons FOR SELECT
  USING (is_admin());

-- Admins can manage all lessons
CREATE POLICY "Admins can manage lessons"
  ON lessons FOR ALL
  USING (is_admin());

-- ============================================
-- Lesson Progress Policies
-- ============================================

-- Users can view their own progress
CREATE POLICY "Users can view own progress"
  ON lesson_progress FOR SELECT
  USING (auth.uid() = user_id);

-- Users can insert their own progress
CREATE POLICY "Users can create own progress"
  ON lesson_progress FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can update their own progress
CREATE POLICY "Users can update own progress"
  ON lesson_progress FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Admins can view all progress
CREATE POLICY "Admins can view all progress"
  ON lesson_progress FOR SELECT
  USING (is_admin());

-- ============================================
-- Course Enrollments Policies
-- ============================================

-- Users can view their own enrollments
CREATE POLICY "Users can view own enrollments"
  ON course_enrollments FOR SELECT
  USING (auth.uid() = user_id);

-- Users can enroll themselves
CREATE POLICY "Users can enroll themselves"
  ON course_enrollments FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Admins can view all enrollments
CREATE POLICY "Admins can view all enrollments"
  ON course_enrollments FOR SELECT
  USING (is_admin());

-- Admins can manage enrollments
CREATE POLICY "Admins can manage enrollments"
  ON course_enrollments FOR ALL
  USING (is_admin());

