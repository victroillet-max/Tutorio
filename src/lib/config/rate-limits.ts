/**
 * Rate Limiting Configuration
 * 
 * Centralized rate limit settings for API endpoints and features.
 * These values are used both for display and enforcement.
 */

/**
 * AI Chat rate limits per subscription tier
 */
export const AI_RATE_LIMITS = {
  free: {
    messagesPerDay: 10,
    messagesPerHour: 5,
    maxContextMessages: 5,
    features: {
      basicQA: true,
      errorExplanations: true,
      codeHints: false,
      fullCodeReview: false,
      unlimitedContext: false,
    },
  },
  basic: {
    messagesPerDay: 25,
    messagesPerHour: 15,
    maxContextMessages: 10,
    features: {
      basicQA: true,
      errorExplanations: true,
      codeHints: true,
      fullCodeReview: false,
      unlimitedContext: false,
    },
  },
  advanced: {
    messagesPerDay: Infinity,
    messagesPerHour: Infinity,
    maxContextMessages: 50,
    features: {
      basicQA: true,
      errorExplanations: true,
      codeHints: true,
      fullCodeReview: true,
      unlimitedContext: true,
    },
  },
} as const;

/**
 * API endpoint rate limits
 * Format: { requests: number, windowSeconds: number }
 */
export const API_RATE_LIMITS = {
  /** Stripe checkout - prevent abuse */
  checkout: {
    requests: 5,
    windowSeconds: 60, // 5 per minute
  },
  
  /** Code validation endpoint */
  validate: {
    requests: 30,
    windowSeconds: 60, // 30 per minute
  },
  
  /** Sheet grading endpoint */
  sheets: {
    requests: 10,
    windowSeconds: 60, // 10 per minute
  },
  
  /** General API calls */
  general: {
    requests: 100,
    windowSeconds: 60, // 100 per minute
  },
  
  /** Auth-related endpoints */
  auth: {
    requests: 10,
    windowSeconds: 60, // 10 per minute
  },
  
  /** Password reset */
  passwordReset: {
    requests: 3,
    windowSeconds: 300, // 3 per 5 minutes
  },
  
  /** Admin endpoints */
  admin: {
    requests: 50,
    windowSeconds: 60, // 50 per minute
  },
} as const;

/**
 * Server action rate limits
 */
export const ACTION_RATE_LIMITS = {
  /** Activity completion - prevent rapid spam */
  completeActivity: {
    requests: 20,
    windowSeconds: 60,
  },
  
  /** Progress updates */
  updateProgress: {
    requests: 60,
    windowSeconds: 60,
  },
  
  /** Skill recalculation */
  recalculateSkills: {
    requests: 5,
    windowSeconds: 300,
  },
  
  /** Sheet operations */
  sheetOperations: {
    requests: 10,
    windowSeconds: 60,
  },
} as const;

/**
 * Burst limits for short-term rate limiting
 * Used for sudden spike detection
 */
export const BURST_LIMITS = {
  /** Maximum requests in 1 second */
  perSecond: 10,
  
  /** Maximum requests in 10 seconds */
  per10Seconds: 30,
} as const;

/**
 * Rate limit headers to include in responses
 */
export const RATE_LIMIT_HEADERS = {
  LIMIT: "X-RateLimit-Limit",
  REMAINING: "X-RateLimit-Remaining",
  RESET: "X-RateLimit-Reset",
  RETRY_AFTER: "Retry-After",
} as const;

/**
 * Get AI rate limit for a specific tier
 */
export function getAIRateLimit(tier: keyof typeof AI_RATE_LIMITS) {
  return AI_RATE_LIMITS[tier] || AI_RATE_LIMITS.free;
}

/**
 * Get default rate limit for unauthenticated users
 */
export function getDefaultRateLimit() {
  return AI_RATE_LIMITS.free;
}

/**
 * Calculate remaining messages for display
 */
export function getRemainingMessages(
  tier: keyof typeof AI_RATE_LIMITS,
  usedToday: number
): { remaining: number; limit: number; unlimited: boolean } {
  const limits = getAIRateLimit(tier);
  const limit = limits.messagesPerDay;
  
  if (limit === Infinity) {
    return { remaining: Infinity, limit: Infinity, unlimited: true };
  }
  
  return {
    remaining: Math.max(0, limit - usedToday),
    limit,
    unlimited: false,
  };
}

/**
 * Check if user can send AI message based on rate limits
 */
export function canSendAIMessage(
  tier: keyof typeof AI_RATE_LIMITS,
  usedToday: number,
  usedThisHour: number
): { allowed: boolean; reason?: string } {
  const limits = getAIRateLimit(tier);
  
  if (limits.messagesPerDay !== Infinity && usedToday >= limits.messagesPerDay) {
    return {
      allowed: false,
      reason: `Daily limit of ${limits.messagesPerDay} messages reached`,
    };
  }
  
  if (limits.messagesPerHour !== Infinity && usedThisHour >= limits.messagesPerHour) {
    return {
      allowed: false,
      reason: `Hourly limit of ${limits.messagesPerHour} messages reached`,
    };
  }
  
  return { allowed: true };
}

export type SubscriptionTier = keyof typeof AI_RATE_LIMITS;
export type APIEndpoint = keyof typeof API_RATE_LIMITS;
export type ActionType = keyof typeof ACTION_RATE_LIMITS;

