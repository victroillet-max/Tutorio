-- ============================================
-- User Session Management - Limit to 2 concurrent sessions
-- ============================================

-- ----------------------------------------
-- User Sessions Table
-- Tracks active sessions per user to enforce concurrent login limit
-- ----------------------------------------
CREATE TABLE user_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  session_token_hash TEXT NOT NULL, -- Hash of the session access token for security
  device_info TEXT, -- Optional device/browser info
  ip_address TEXT, -- IP address of the session
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  last_active_at TIMESTAMPTZ DEFAULT now() NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  is_active BOOLEAN DEFAULT true NOT NULL,
  
  CONSTRAINT unique_session_token UNIQUE(session_token_hash)
);

-- Indexes for efficient queries
CREATE INDEX idx_user_sessions_user_id ON user_sessions(user_id);
CREATE INDEX idx_user_sessions_active ON user_sessions(user_id, is_active) WHERE is_active = true;
CREATE INDEX idx_user_sessions_expires ON user_sessions(expires_at);

-- ----------------------------------------
-- Function to count active sessions for a user
-- ----------------------------------------
CREATE OR REPLACE FUNCTION count_active_sessions(p_user_id UUID)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN (
    SELECT COUNT(*)::INT
    FROM user_sessions
    WHERE user_id = p_user_id
      AND is_active = true
      AND expires_at > now()
  );
END;
$$;

-- ----------------------------------------
-- Function to register a new session
-- Returns: session_id if successful, NULL if limit exceeded (without invalidation)
-- ----------------------------------------
CREATE OR REPLACE FUNCTION register_session(
  p_user_id UUID,
  p_session_token_hash TEXT,
  p_device_info TEXT DEFAULT NULL,
  p_ip_address TEXT DEFAULT NULL,
  p_expires_at TIMESTAMPTZ DEFAULT NULL
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_session_id UUID;
  v_expires TIMESTAMPTZ;
BEGIN
  -- Set expiration (default 7 days if not provided)
  v_expires := COALESCE(p_expires_at, now() + INTERVAL '7 days');
  
  -- First, clean up expired sessions
  UPDATE user_sessions
  SET is_active = false
  WHERE user_id = p_user_id
    AND (expires_at <= now() OR is_active = false);
  
  -- Delete very old inactive sessions (older than 30 days)
  DELETE FROM user_sessions
  WHERE user_id = p_user_id
    AND is_active = false
    AND expires_at < now() - INTERVAL '30 days';
  
  -- Insert the new session
  INSERT INTO user_sessions (
    user_id,
    session_token_hash,
    device_info,
    ip_address,
    expires_at
  ) VALUES (
    p_user_id,
    p_session_token_hash,
    p_device_info,
    p_ip_address,
    v_expires
  )
  ON CONFLICT (session_token_hash) 
  DO UPDATE SET
    last_active_at = now(),
    expires_at = v_expires,
    is_active = true
  RETURNING id INTO v_session_id;
  
  RETURN v_session_id;
END;
$$;

-- ----------------------------------------
-- Function to enforce session limit (invalidates oldest if over limit)
-- Returns: number of sessions invalidated
-- ----------------------------------------
CREATE OR REPLACE FUNCTION enforce_session_limit(
  p_user_id UUID,
  p_max_sessions INT DEFAULT 2
)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_active_count INT;
  v_to_invalidate INT;
  v_invalidated INT := 0;
BEGIN
  -- Count current active sessions
  SELECT COUNT(*)::INT INTO v_active_count
  FROM user_sessions
  WHERE user_id = p_user_id
    AND is_active = true
    AND expires_at > now();
  
  -- Calculate how many to invalidate
  v_to_invalidate := v_active_count - p_max_sessions;
  
  -- If over limit, invalidate oldest sessions
  IF v_to_invalidate > 0 THEN
    WITH oldest_sessions AS (
      SELECT id
      FROM user_sessions
      WHERE user_id = p_user_id
        AND is_active = true
        AND expires_at > now()
      ORDER BY created_at ASC
      LIMIT v_to_invalidate
    )
    UPDATE user_sessions
    SET is_active = false
    WHERE id IN (SELECT id FROM oldest_sessions);
    
    GET DIAGNOSTICS v_invalidated = ROW_COUNT;
  END IF;
  
  RETURN v_invalidated;
END;
$$;

-- ----------------------------------------
-- Function to validate a session
-- Returns: true if session is valid, false otherwise
-- Also updates last_active_at for valid sessions
-- ----------------------------------------
CREATE OR REPLACE FUNCTION validate_session(
  p_session_token_hash TEXT
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_is_valid BOOLEAN;
BEGIN
  -- Check if session exists and is valid
  UPDATE user_sessions
  SET last_active_at = now()
  WHERE session_token_hash = p_session_token_hash
    AND is_active = true
    AND expires_at > now()
  RETURNING true INTO v_is_valid;
  
  RETURN COALESCE(v_is_valid, false);
END;
$$;

-- ----------------------------------------
-- Function to invalidate a specific session (logout)
-- ----------------------------------------
CREATE OR REPLACE FUNCTION invalidate_session(
  p_session_token_hash TEXT
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_invalidated BOOLEAN;
BEGIN
  UPDATE user_sessions
  SET is_active = false
  WHERE session_token_hash = p_session_token_hash
  RETURNING true INTO v_invalidated;
  
  RETURN COALESCE(v_invalidated, false);
END;
$$;

-- ----------------------------------------
-- Function to invalidate all sessions for a user (force logout everywhere)
-- ----------------------------------------
CREATE OR REPLACE FUNCTION invalidate_all_sessions(
  p_user_id UUID
)
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_count INT;
BEGIN
  UPDATE user_sessions
  SET is_active = false
  WHERE user_id = p_user_id
    AND is_active = true;
  
  GET DIAGNOSTICS v_count = ROW_COUNT;
  RETURN v_count;
END;
$$;

-- ----------------------------------------
-- Function to get active sessions for a user (for settings page)
-- ----------------------------------------
CREATE OR REPLACE FUNCTION get_user_sessions(p_user_id UUID)
RETURNS TABLE (
  id UUID,
  device_info TEXT,
  ip_address TEXT,
  created_at TIMESTAMPTZ,
  last_active_at TIMESTAMPTZ,
  is_current BOOLEAN
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id,
    s.device_info,
    s.ip_address,
    s.created_at,
    s.last_active_at,
    false AS is_current -- Will be updated client-side based on current token
  FROM user_sessions s
  WHERE s.user_id = p_user_id
    AND s.is_active = true
    AND s.expires_at > now()
  ORDER BY s.last_active_at DESC;
END;
$$;

-- ----------------------------------------
-- RLS Policies for user_sessions
-- ----------------------------------------
ALTER TABLE user_sessions ENABLE ROW LEVEL SECURITY;

-- Users can view their own sessions
CREATE POLICY "Users can view own sessions"
  ON user_sessions FOR SELECT
  USING (auth.uid() = user_id);

-- Only server-side operations can insert/update/delete (via SECURITY DEFINER functions)
-- No direct insert/update/delete policies for regular users

-- ----------------------------------------
-- Cleanup job - can be run periodically by a cron job or edge function
-- ----------------------------------------
CREATE OR REPLACE FUNCTION cleanup_expired_sessions()
RETURNS INT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_deleted INT;
BEGIN
  -- Mark expired sessions as inactive
  UPDATE user_sessions
  SET is_active = false
  WHERE is_active = true
    AND expires_at <= now();
  
  -- Delete very old inactive sessions (older than 90 days)
  DELETE FROM user_sessions
  WHERE is_active = false
    AND expires_at < now() - INTERVAL '90 days';
  
  GET DIAGNOSTICS v_deleted = ROW_COUNT;
  RETURN v_deleted;
END;
$$;

