-- ============================================
-- Track Welcome Email Sent Status
-- ============================================
-- This migration adds a column to track if welcome email was sent,
-- preventing duplicate emails on subsequent logins.

-- Add welcome_email_sent_at column to profiles
ALTER TABLE profiles 
ADD COLUMN IF NOT EXISTS welcome_email_sent_at TIMESTAMPTZ;

-- Comment for documentation
COMMENT ON COLUMN profiles.welcome_email_sent_at IS 'Timestamp when welcome email was sent to prevent duplicates';

-- Index for potential queries on this column
CREATE INDEX IF NOT EXISTS idx_profiles_welcome_email ON profiles(welcome_email_sent_at) WHERE welcome_email_sent_at IS NULL;

