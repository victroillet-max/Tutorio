import { createClient } from "@/utils/supabase/server";
import { logger } from "@/lib/logging";
import { createHash } from "crypto";

const log = logger.child({ module: "session-manager" });

// Maximum number of concurrent sessions allowed per user
const MAX_SESSIONS = 2;

/**
 * Hash a session token for secure storage
 * We never store the raw token in the database
 */
export function hashSessionToken(token: string): string {
  return createHash("sha256").update(token).digest("hex");
}

/**
 * Register a new session for a user
 * This is called after successful authentication
 */
export async function registerSession(
  userId: string,
  accessToken: string,
  options?: {
    deviceInfo?: string;
    ipAddress?: string;
    expiresAt?: Date;
  }
): Promise<{ success: boolean; sessionId?: string; sessionsInvalidated?: number }> {
  try {
    const supabase = await createClient();
    const tokenHash = hashSessionToken(accessToken);
    
    // Register the new session
    const { data: sessionId, error: registerError } = await supabase.rpc(
      "register_session",
      {
        p_user_id: userId,
        p_session_token_hash: tokenHash,
        p_device_info: options?.deviceInfo || null,
        p_ip_address: options?.ipAddress || null,
        p_expires_at: options?.expiresAt?.toISOString() || null,
      }
    );

    if (registerError) {
      log.error("Failed to register session", new Error(registerError.message), { userId });
      return { success: false };
    }

    // Enforce the session limit - this will invalidate oldest sessions if over limit
    const { data: invalidatedCount, error: enforceError } = await supabase.rpc(
      "enforce_session_limit",
      {
        p_user_id: userId,
        p_max_sessions: MAX_SESSIONS,
      }
    );

    if (enforceError) {
      log.warn("Failed to enforce session limit", { userId, error: enforceError.message });
    }

    if (invalidatedCount && invalidatedCount > 0) {
      log.info("Invalidated old sessions due to limit", { 
        userId, 
        invalidatedCount,
        maxSessions: MAX_SESSIONS 
      });
    }

    return { 
      success: true, 
      sessionId: sessionId as string,
      sessionsInvalidated: invalidatedCount as number || 0
    };
  } catch (err) {
    log.error("Exception registering session", err instanceof Error ? err : new Error(String(err)));
    return { success: false };
  }
}

/**
 * Validate that a session is still active
 * Returns false if the session was invalidated (e.g., due to login limit)
 */
export async function validateSession(accessToken: string): Promise<boolean> {
  try {
    const supabase = await createClient();
    const tokenHash = hashSessionToken(accessToken);

    const { data: isValid, error } = await supabase.rpc("validate_session", {
      p_session_token_hash: tokenHash,
    });

    if (error) {
      log.warn("Session validation error", { error: error.message });
      return false;
    }

    return isValid as boolean;
  } catch (err) {
    log.error("Exception validating session", err instanceof Error ? err : new Error(String(err)));
    return false;
  }
}

/**
 * Invalidate a specific session (used for logout)
 */
export async function invalidateSession(accessToken: string): Promise<boolean> {
  try {
    const supabase = await createClient();
    const tokenHash = hashSessionToken(accessToken);

    const { data: success, error } = await supabase.rpc("invalidate_session", {
      p_session_token_hash: tokenHash,
    });

    if (error) {
      log.warn("Failed to invalidate session", { error: error.message });
      return false;
    }

    return success as boolean;
  } catch (err) {
    log.error("Exception invalidating session", err instanceof Error ? err : new Error(String(err)));
    return false;
  }
}

/**
 * Invalidate all sessions for a user (force logout everywhere)
 */
export async function invalidateAllSessions(userId: string): Promise<number> {
  try {
    const supabase = await createClient();

    const { data: count, error } = await supabase.rpc("invalidate_all_sessions", {
      p_user_id: userId,
    });

    if (error) {
      log.error("Failed to invalidate all sessions", new Error(error.message), { userId });
      return 0;
    }

    log.info("Invalidated all sessions for user", { userId, count });
    return count as number;
  } catch (err) {
    log.error("Exception invalidating all sessions", err instanceof Error ? err : new Error(String(err)));
    return 0;
  }
}

/**
 * Get active session count for a user
 */
export async function getActiveSessionCount(userId: string): Promise<number> {
  try {
    const supabase = await createClient();

    const { data: count, error } = await supabase.rpc("count_active_sessions", {
      p_user_id: userId,
    });

    if (error) {
      log.warn("Failed to count sessions", { userId, error: error.message });
      return 0;
    }

    return count as number;
  } catch (err) {
    log.error("Exception counting sessions", err instanceof Error ? err : new Error(String(err)));
    return 0;
  }
}

/**
 * Get all active sessions for a user (for settings page)
 */
export async function getUserSessions(userId: string): Promise<{
  id: string;
  device_info: string | null;
  ip_address: string | null;
  created_at: string;
  last_active_at: string;
}[]> {
  try {
    const supabase = await createClient();

    const { data, error } = await supabase.rpc("get_user_sessions", {
      p_user_id: userId,
    });

    if (error) {
      log.error("Failed to get user sessions", new Error(error.message), { userId });
      return [];
    }

    return (data || []) as {
      id: string;
      device_info: string | null;
      ip_address: string | null;
      created_at: string;
      last_active_at: string;
    }[];
  } catch (err) {
    log.error("Exception getting user sessions", err instanceof Error ? err : new Error(String(err)));
    return [];
  }
}

