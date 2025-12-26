-- ============================================
-- Tutorio Database Schema - Part 1: Enums
-- ============================================

-- User roles for access control
CREATE TYPE user_role AS ENUM ('user', 'admin');

-- Subscription status lifecycle
CREATE TYPE subscription_status AS ENUM (
  'trialing',    -- User is on a trial period
  'active',      -- Subscription is active and paid
  'cancelled',   -- User cancelled but still has access until period ends
  'expired',     -- Subscription period has ended
  'past_due'     -- Payment failed, grace period
);

-- Content types for lessons
CREATE TYPE content_type AS ENUM (
  'video',       -- Video lesson content
  'text',        -- Text/article content
  'quiz',        -- Interactive quiz
  'audio'        -- Audio/podcast content
);

-- Course difficulty levels
CREATE TYPE difficulty_level AS ENUM (
  'beginner',
  'intermediate',
  'advanced'
);

