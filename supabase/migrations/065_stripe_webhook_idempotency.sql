-- Migration: Add Stripe webhook idempotency tracking
-- This table prevents duplicate processing of webhook events

-- Create table to track processed webhook events
CREATE TABLE IF NOT EXISTS stripe_webhook_events (
  id TEXT PRIMARY KEY,                           -- Stripe event ID (evt_xxx)
  type TEXT NOT NULL,                            -- Event type (e.g., checkout.session.completed)
  processed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Add index for cleanup queries (events older than 30 days can be deleted)
CREATE INDEX IF NOT EXISTS idx_stripe_webhook_events_processed_at 
  ON stripe_webhook_events(processed_at);

-- Add comment for documentation
COMMENT ON TABLE stripe_webhook_events IS 
  'Tracks processed Stripe webhook events to ensure idempotency. Events are stored to prevent duplicate processing on webhook retries.';

-- Enable RLS (but allow service role to bypass)
ALTER TABLE stripe_webhook_events ENABLE ROW LEVEL SECURITY;

-- No policies needed - only service role (webhook handler) accesses this table
-- Service role bypasses RLS automatically

-- Optional: Create a function to clean up old events (older than 30 days)
CREATE OR REPLACE FUNCTION cleanup_old_stripe_events()
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  deleted_count INTEGER;
BEGIN
  DELETE FROM stripe_webhook_events 
  WHERE processed_at < NOW() - INTERVAL '30 days';
  
  GET DIAGNOSTICS deleted_count = ROW_COUNT;
  RETURN deleted_count;
END;
$$;

COMMENT ON FUNCTION cleanup_old_stripe_events IS 
  'Removes Stripe webhook events older than 30 days. Can be called periodically to prevent table bloat.';


