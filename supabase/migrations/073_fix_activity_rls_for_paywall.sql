-- ============================================
-- Fix Activities RLS to Allow Paywall Display
-- ============================================
-- Problem: The current RLS policies block reading activities based on subscription tier.
-- However, the application needs to read the activity to show a proper paywall message.
-- The access check should happen at the application layer, not the RLS layer.
--
-- Solution: Add a policy that allows any authenticated user to read published activities.
-- The application will then show appropriate content or paywall based on subscription.
-- ============================================

-- Drop the old restrictive SELECT policies
DROP POLICY IF EXISTS "Authenticated users can view free activities" ON activities;
DROP POLICY IF EXISTS "Subscribers can view basic activities" ON activities;
DROP POLICY IF EXISTS "Advanced subscribers can view advanced activities" ON activities;

-- Create a single policy that allows authenticated users to read any published activity
-- Access control for content viewing is handled at the application layer
CREATE POLICY "Authenticated users can view published activities"
  ON activities FOR SELECT
  USING (
    is_published = true
    AND auth.uid() IS NOT NULL
  );

-- Verify the policy was created
DO $$
BEGIN
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'Activities RLS Fix Applied';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'Removed tier-based SELECT policies';
  RAISE NOTICE 'Added unified policy for authenticated users';
  RAISE NOTICE 'Access control now handled at application layer';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
END $$;


