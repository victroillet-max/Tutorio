-- ============================================
-- Migration: Fix RLS Performance Issues
-- ============================================
-- This migration addresses two types of performance issues flagged by
-- the Supabase Performance Advisor:
--
-- 1. Auth RLS Init Plan: Wrapping auth.uid() in (SELECT auth.uid())
--    to prevent per-row re-evaluation
--
-- 2. Multiple Permissive Policies: Consolidating overlapping policies
--    to reduce the number of policy evaluations per query
-- ============================================

-- ============================================
-- PHASE 1: Fix is_admin() function
-- The is_admin() function also needs to use (SELECT auth.uid())
-- ============================================

CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM profiles
    WHERE id = (SELECT auth.uid()) AND role = 'admin'
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- PHASE 2: Fix profiles table policies
-- ============================================

-- Drop existing policies
DROP POLICY IF EXISTS "Users can view own profile" ON profiles;
DROP POLICY IF EXISTS "Users can update own profile" ON profiles;
DROP POLICY IF EXISTS "Admins can view all profiles" ON profiles;
DROP POLICY IF EXISTS "Admins can manage profiles" ON profiles;

-- Recreate with optimized auth.uid() and consolidated admin policies
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT
  USING ((SELECT auth.uid()) = id);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING ((SELECT auth.uid()) = id)
  WITH CHECK ((SELECT auth.uid()) = id);

-- Single admin policy for all operations (SELECT included via FOR ALL)
CREATE POLICY "Admins can manage profiles"
  ON profiles FOR ALL
  USING (is_admin());

-- ============================================
-- PHASE 3: Fix subscriptions table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own subscriptions" ON subscriptions;
DROP POLICY IF EXISTS "Admins can view all subscriptions" ON subscriptions;
DROP POLICY IF EXISTS "Admins can manage subscriptions" ON subscriptions;

-- Combined user + admin SELECT policy
CREATE POLICY "Users can view own subscriptions"
  ON subscriptions FOR SELECT
  USING ((SELECT auth.uid()) = user_id OR is_admin());

-- Admin management for write operations
CREATE POLICY "Admins can manage subscriptions"
  ON subscriptions FOR ALL
  USING (is_admin());

-- ============================================
-- PHASE 4: Fix user_streaks table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own streaks" ON user_streaks;
DROP POLICY IF EXISTS "Users can create own streaks" ON user_streaks;
DROP POLICY IF EXISTS "Users can update own streaks" ON user_streaks;

CREATE POLICY "Users can view own streaks"
  ON user_streaks FOR SELECT
  USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can create own streaks"
  ON user_streaks FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own streaks"
  ON user_streaks FOR UPDATE
  USING ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 5: Fix lesson_progress table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own progress" ON lesson_progress;
DROP POLICY IF EXISTS "Users can create own progress" ON lesson_progress;
DROP POLICY IF EXISTS "Users can update own progress" ON lesson_progress;
DROP POLICY IF EXISTS "Admins can view all progress" ON lesson_progress;

-- Combined user + admin SELECT policy
CREATE POLICY "Users can view own progress"
  ON lesson_progress FOR SELECT
  USING ((SELECT auth.uid()) = user_id OR is_admin());

CREATE POLICY "Users can create own progress"
  ON lesson_progress FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own progress"
  ON lesson_progress FOR UPDATE
  USING ((SELECT auth.uid()) = user_id)
  WITH CHECK ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 6: Fix course_enrollments table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own enrollments" ON course_enrollments;
DROP POLICY IF EXISTS "Users can enroll themselves" ON course_enrollments;
DROP POLICY IF EXISTS "Admins can view all enrollments" ON course_enrollments;
DROP POLICY IF EXISTS "Admins can manage enrollments" ON course_enrollments;

-- Combined user + admin SELECT policy
CREATE POLICY "Users can view own enrollments"
  ON course_enrollments FOR SELECT
  USING ((SELECT auth.uid()) = user_id OR is_admin());

-- Combined user + admin INSERT policy
CREATE POLICY "Users can enroll themselves"
  ON course_enrollments FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id OR is_admin());

-- Admin management for UPDATE/DELETE
CREATE POLICY "Admins can manage enrollments"
  ON course_enrollments FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete enrollments"
  ON course_enrollments FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 7: Fix activity_progress table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own activity progress" ON activity_progress;
DROP POLICY IF EXISTS "Users can create own activity progress" ON activity_progress;
DROP POLICY IF EXISTS "Users can update own activity progress" ON activity_progress;

CREATE POLICY "Users can view own activity progress"
  ON activity_progress FOR SELECT
  USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can create own activity progress"
  ON activity_progress FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own activity progress"
  ON activity_progress FOR UPDATE
  USING ((SELECT auth.uid()) = user_id)
  WITH CHECK ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 8: Fix module_progress table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own module progress" ON module_progress;
DROP POLICY IF EXISTS "Users can create own module progress" ON module_progress;
DROP POLICY IF EXISTS "Users can update own module progress" ON module_progress;

CREATE POLICY "Users can view own module progress"
  ON module_progress FOR SELECT
  USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can create own module progress"
  ON module_progress FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own module progress"
  ON module_progress FOR UPDATE
  USING ((SELECT auth.uid()) = user_id)
  WITH CHECK ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 9: Fix user_badges table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own badges" ON user_badges;
DROP POLICY IF EXISTS "Admins can view all user badges" ON user_badges;

-- Combined user + admin SELECT policy
CREATE POLICY "Users can view own badges"
  ON user_badges FOR SELECT
  USING ((SELECT auth.uid()) = user_id OR is_admin());

-- ============================================
-- PHASE 10: Fix user_skill_progress table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own skill progress" ON user_skill_progress;
DROP POLICY IF EXISTS "Users can create own skill progress" ON user_skill_progress;
DROP POLICY IF EXISTS "Users can update own skill progress" ON user_skill_progress;
DROP POLICY IF EXISTS "Admins can view all skill progress" ON user_skill_progress;

-- Combined user + admin SELECT policy
CREATE POLICY "Users can view own skill progress"
  ON user_skill_progress FOR SELECT
  USING ((SELECT auth.uid()) = user_id OR is_admin());

CREATE POLICY "Users can create own skill progress"
  ON user_skill_progress FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own skill progress"
  ON user_skill_progress FOR UPDATE
  USING ((SELECT auth.uid()) = user_id)
  WITH CHECK ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 11: Fix diagnostic_results table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own diagnostic results" ON diagnostic_results;
DROP POLICY IF EXISTS "Users can create own diagnostic results" ON diagnostic_results;
DROP POLICY IF EXISTS "Admins can view all diagnostic results" ON diagnostic_results;

-- Combined user + admin SELECT policy
CREATE POLICY "Users can view own diagnostic results"
  ON diagnostic_results FOR SELECT
  USING ((SELECT auth.uid()) = user_id OR is_admin());

CREATE POLICY "Users can create own diagnostic results"
  ON diagnostic_results FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 12: Fix chat_conversations table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own conversations" ON chat_conversations;
DROP POLICY IF EXISTS "Users can create own conversations" ON chat_conversations;
DROP POLICY IF EXISTS "Users can update own conversations" ON chat_conversations;
DROP POLICY IF EXISTS "Users can delete own conversations" ON chat_conversations;
DROP POLICY IF EXISTS "Admins can view all conversations" ON chat_conversations;

-- Combined user + admin SELECT policy
CREATE POLICY "Users can view own conversations"
  ON chat_conversations FOR SELECT
  USING ((SELECT auth.uid()) = user_id OR is_admin());

CREATE POLICY "Users can create own conversations"
  ON chat_conversations FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own conversations"
  ON chat_conversations FOR UPDATE
  USING ((SELECT auth.uid()) = user_id)
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can delete own conversations"
  ON chat_conversations FOR DELETE
  USING ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 13: Fix chat_messages table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own messages" ON chat_messages;
DROP POLICY IF EXISTS "Users can create own messages" ON chat_messages;
DROP POLICY IF EXISTS "Admins can view all messages" ON chat_messages;

-- Combined user + admin SELECT policy
CREATE POLICY "Users can view own messages"
  ON chat_messages FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM chat_conversations cc
      WHERE cc.id = chat_messages.conversation_id
      AND cc.user_id = (SELECT auth.uid())
    )
    OR is_admin()
  );

CREATE POLICY "Users can create own messages"
  ON chat_messages FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM chat_conversations cc
      WHERE cc.id = chat_messages.conversation_id
      AND cc.user_id = (SELECT auth.uid())
    )
  );

-- ============================================
-- PHASE 14: Fix ai_usage table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own usage" ON ai_usage;
DROP POLICY IF EXISTS "Users can create own usage" ON ai_usage;
DROP POLICY IF EXISTS "Users can update own usage" ON ai_usage;
DROP POLICY IF EXISTS "Admins can view all usage" ON ai_usage;

-- Combined user + admin SELECT policy
CREATE POLICY "Users can view own usage"
  ON ai_usage FOR SELECT
  USING ((SELECT auth.uid()) = user_id OR is_admin());

CREATE POLICY "Users can create own usage"
  ON ai_usage FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own usage"
  ON ai_usage FOR UPDATE
  USING ((SELECT auth.uid()) = user_id)
  WITH CHECK ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 15: Fix ai_rate_limits table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view rate limits" ON ai_rate_limits;
DROP POLICY IF EXISTS "Admins can manage rate limits" ON ai_rate_limits;

-- Anyone can view (no need for auth.uid() here)
CREATE POLICY "Anyone can view rate limits"
  ON ai_rate_limits FOR SELECT
  USING (true);

-- Admin write operations only
CREATE POLICY "Admins can manage rate limits"
  ON ai_rate_limits FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update rate limits"
  ON ai_rate_limits FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete rate limits"
  ON ai_rate_limits FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 16: Fix user_course_enrollment table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own enrollments" ON user_course_enrollment;
DROP POLICY IF EXISTS "Users can create own enrollments" ON user_course_enrollment;
DROP POLICY IF EXISTS "Users can update own enrollments" ON user_course_enrollment;
DROP POLICY IF EXISTS "Admins can view all enrollments" ON user_course_enrollment;

-- Combined user + admin SELECT policy
CREATE POLICY "Users can view own enrollments"
  ON user_course_enrollment FOR SELECT
  USING ((SELECT auth.uid()) = user_id OR is_admin());

CREATE POLICY "Users can create own enrollments"
  ON user_course_enrollment FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own enrollments"
  ON user_course_enrollment FOR UPDATE
  USING ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 17: Fix activities table policies
-- ============================================

DROP POLICY IF EXISTS "Authenticated users can view demo activities" ON activities;
DROP POLICY IF EXISTS "Authenticated users can view published activities" ON activities;
DROP POLICY IF EXISTS "Subscribers can view all course activities" ON activities;
DROP POLICY IF EXISTS "Admins can manage activities" ON activities;

-- Single consolidated SELECT policy for all activity access
CREATE POLICY "Authenticated users can view published activities"
  ON activities FOR SELECT
  USING (
    is_published = true
    AND (SELECT auth.uid()) IS NOT NULL
  );

-- Admin management for all operations
CREATE POLICY "Admins can manage activities"
  ON activities FOR ALL
  USING (is_admin());

-- ============================================
-- PHASE 18: Fix user_sheets table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own sheets" ON user_sheets;
DROP POLICY IF EXISTS "Users can insert own sheets" ON user_sheets;
DROP POLICY IF EXISTS "Users can update own sheets" ON user_sheets;
DROP POLICY IF EXISTS "Users can delete own sheets" ON user_sheets;

CREATE POLICY "Users can view own sheets"
  ON user_sheets FOR SELECT
  USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can insert own sheets"
  ON user_sheets FOR INSERT
  WITH CHECK ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can update own sheets"
  ON user_sheets FOR UPDATE
  USING ((SELECT auth.uid()) = user_id);

CREATE POLICY "Users can delete own sheets"
  ON user_sheets FOR DELETE
  USING ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 19: Fix sheet_grading_criteria table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view grading criteria" ON sheet_grading_criteria;
DROP POLICY IF EXISTS "Admins can manage grading criteria" ON sheet_grading_criteria;

-- Anyone can view
CREATE POLICY "Anyone can view grading criteria"
  ON sheet_grading_criteria FOR SELECT
  USING (true);

-- Admin write operations only
CREATE POLICY "Admins can manage grading criteria"
  ON sheet_grading_criteria FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update grading criteria"
  ON sheet_grading_criteria FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete grading criteria"
  ON sheet_grading_criteria FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 20: Fix user_sessions table policies
-- ============================================

DROP POLICY IF EXISTS "Users can view own sessions" ON user_sessions;

CREATE POLICY "Users can view own sessions"
  ON user_sessions FOR SELECT
  USING ((SELECT auth.uid()) = user_id);

-- ============================================
-- PHASE 21: Fix modules table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view published modules" ON modules;
DROP POLICY IF EXISTS "Admins can manage modules" ON modules;

-- Anyone can view published modules
CREATE POLICY "Anyone can view published modules"
  ON modules FOR SELECT
  USING (
    is_published = true
    AND EXISTS (
      SELECT 1 FROM courses c
      WHERE c.id = modules.course_id AND c.is_published = true
    )
  );

-- Admin management for all operations
CREATE POLICY "Admins can manage modules"
  ON modules FOR ALL
  USING (is_admin());

-- ============================================
-- PHASE 22: Fix courses table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view published courses" ON courses;
DROP POLICY IF EXISTS "Admins can view all courses" ON courses;
DROP POLICY IF EXISTS "Admins can manage courses" ON courses;

-- Combined public + admin SELECT policy
CREATE POLICY "Anyone can view published courses"
  ON courses FOR SELECT
  USING (is_published = true OR is_admin());

-- Admin management for write operations
CREATE POLICY "Admins can manage courses"
  ON courses FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update courses"
  ON courses FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete courses"
  ON courses FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 23: Fix lessons table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view preview lessons" ON lessons;
DROP POLICY IF EXISTS "Subscribers can view premium lessons" ON lessons;
DROP POLICY IF EXISTS "Admins can view all lessons" ON lessons;
DROP POLICY IF EXISTS "Admins can manage lessons" ON lessons;

-- Single consolidated SELECT policy for lessons
CREATE POLICY "Users can view accessible lessons"
  ON lessons FOR SELECT
  USING (
    -- Admin can see all
    is_admin()
    OR
    -- Published preview lessons
    (
      is_preview = true 
      AND is_published = true
      AND EXISTS (
        SELECT 1 FROM courses c
        WHERE c.id = lessons.course_id AND c.is_published = true
      )
    )
    OR
    -- Premium lessons for subscribers
    (
      is_published = true
      AND is_preview = false
      AND EXISTS (
        SELECT 1 FROM courses c
        WHERE c.id = lessons.course_id 
          AND c.is_published = true
          AND has_active_subscription(c.required_tier_id)
      )
    )
  );

-- Admin management for write operations
CREATE POLICY "Admins can manage lessons"
  ON lessons FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update lessons"
  ON lessons FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete lessons"
  ON lessons FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 24: Fix categories table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view categories" ON categories;
DROP POLICY IF EXISTS "Admins can manage categories" ON categories;

-- Anyone can view
CREATE POLICY "Anyone can view categories"
  ON categories FOR SELECT
  USING (true);

-- Admin write operations only
CREATE POLICY "Admins can manage categories"
  ON categories FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update categories"
  ON categories FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete categories"
  ON categories FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 25: Fix subscription_tiers table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view active tiers" ON subscription_tiers;
DROP POLICY IF EXISTS "Admins can manage tiers" ON subscription_tiers;

-- Combined public + admin SELECT policy
CREATE POLICY "Anyone can view active tiers"
  ON subscription_tiers FOR SELECT
  USING (is_active = true OR is_admin());

-- Admin write operations only
CREATE POLICY "Admins can manage tiers"
  ON subscription_tiers FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update tiers"
  ON subscription_tiers FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete tiers"
  ON subscription_tiers FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 26: Fix badges table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view badges" ON badges;
DROP POLICY IF EXISTS "Admins can manage badges" ON badges;

-- Anyone can view
CREATE POLICY "Anyone can view badges"
  ON badges FOR SELECT
  USING (true);

-- Admin write operations only
CREATE POLICY "Admins can manage badges"
  ON badges FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update badges"
  ON badges FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete badges"
  ON badges FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 27: Fix skills table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view active skills" ON skills;
DROP POLICY IF EXISTS "Admins can manage skills" ON skills;

-- Combined public + admin SELECT policy
CREATE POLICY "Anyone can view active skills"
  ON skills FOR SELECT
  USING (is_active = true OR is_admin());

-- Admin write operations only
CREATE POLICY "Admins can manage skills"
  ON skills FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update skills"
  ON skills FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete skills"
  ON skills FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 28: Fix skill_prerequisites table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view skill prerequisites" ON skill_prerequisites;
DROP POLICY IF EXISTS "Admins can manage skill prerequisites" ON skill_prerequisites;

-- Anyone can view
CREATE POLICY "Anyone can view skill prerequisites"
  ON skill_prerequisites FOR SELECT
  USING (true);

-- Admin write operations only
CREATE POLICY "Admins can manage skill prerequisites"
  ON skill_prerequisites FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update skill prerequisites"
  ON skill_prerequisites FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete skill prerequisites"
  ON skill_prerequisites FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 29: Fix activity_skills table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view activity skills" ON activity_skills;
DROP POLICY IF EXISTS "Admins can manage activity skills" ON activity_skills;

-- Anyone can view
CREATE POLICY "Anyone can view activity skills"
  ON activity_skills FOR SELECT
  USING (true);

-- Admin write operations only
CREATE POLICY "Admins can manage activity skills"
  ON activity_skills FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update activity skills"
  ON activity_skills FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete activity skills"
  ON activity_skills FOR DELETE
  USING (is_admin());

-- ============================================
-- PHASE 30: Fix question_skills table policies
-- ============================================

DROP POLICY IF EXISTS "Anyone can view question skills" ON question_skills;
DROP POLICY IF EXISTS "Admins can manage question skills" ON question_skills;

-- Anyone can view
CREATE POLICY "Anyone can view question skills"
  ON question_skills FOR SELECT
  USING (true);

-- Admin write operations only
CREATE POLICY "Admins can manage question skills"
  ON question_skills FOR INSERT
  WITH CHECK (is_admin());

CREATE POLICY "Admins can update question skills"
  ON question_skills FOR UPDATE
  USING (is_admin());

CREATE POLICY "Admins can delete question skills"
  ON question_skills FOR DELETE
  USING (is_admin());

-- ============================================
-- Verification Notice
-- ============================================

DO $$
BEGIN
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'RLS Performance Optimization Migration Complete';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'Fixed auth.uid() init plan issues (wrapped in SELECT)';
  RAISE NOTICE 'Consolidated multiple permissive policies';
  RAISE NOTICE 'Updated is_admin() function with optimized auth.uid()';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
END $$;

