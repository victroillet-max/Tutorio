/**
 * Rate Limiting Infrastructure
 * 
 * In-memory rate limiter for development and small deployments.
 * For production at scale, replace with Redis-based implementation (e.g., @upstash/ratelimit).
 */

import { API_RATE_LIMITS, RATE_LIMIT_HEADERS } from "@/lib/config/rate-limits";
import { RateLimitError } from "@/lib/errors";
import { logger } from "@/lib/logging";

/**
 * Rate limit entry in the store
 */
interface RateLimitEntry {
  count: number;
  resetAt: number;
}

/**
 * In-memory store for rate limiting
 * Note: In production with multiple instances, use Redis or similar
 */
const rateLimitStore = new Map<string, RateLimitEntry>();

/**
 * Cleanup old entries periodically
 */
const CLEANUP_INTERVAL = 60 * 1000; // 1 minute
let cleanupTimer: NodeJS.Timeout | null = null;

function startCleanup() {
  if (cleanupTimer) return;
  
  cleanupTimer = setInterval(() => {
    const now = Date.now();
    for (const [key, entry] of rateLimitStore.entries()) {
      if (entry.resetAt < now) {
        rateLimitStore.delete(key);
      }
    }
  }, CLEANUP_INTERVAL);
  
  // Don't prevent process exit
  if (cleanupTimer.unref) {
    cleanupTimer.unref();
  }
}

// Start cleanup on module load
startCleanup();

/**
 * Rate limit configuration
 */
export interface RateLimitConfig {
  requests: number;
  windowSeconds: number;
}

/**
 * Rate limit result
 */
export interface RateLimitResult {
  success: boolean;
  limit: number;
  remaining: number;
  reset: number; // Unix timestamp
  retryAfter?: number; // Seconds until reset
}

/**
 * Check and update rate limit for a key
 */
export function checkRateLimit(
  key: string,
  config: RateLimitConfig
): RateLimitResult {
  const now = Date.now();
  const windowMs = config.windowSeconds * 1000;
  const entry = rateLimitStore.get(key);
  
  // If no entry or window has passed, create new entry
  if (!entry || entry.resetAt < now) {
    const resetAt = now + windowMs;
    rateLimitStore.set(key, { count: 1, resetAt });
    
    return {
      success: true,
      limit: config.requests,
      remaining: config.requests - 1,
      reset: Math.ceil(resetAt / 1000),
    };
  }
  
  // Check if limit exceeded
  if (entry.count >= config.requests) {
    const retryAfter = Math.ceil((entry.resetAt - now) / 1000);
    
    logger.warn("Rate limit exceeded", {
      key,
      limit: config.requests,
      windowSeconds: config.windowSeconds,
      retryAfter,
    });
    
    return {
      success: false,
      limit: config.requests,
      remaining: 0,
      reset: Math.ceil(entry.resetAt / 1000),
      retryAfter,
    };
  }
  
  // Increment counter
  entry.count++;
  
  return {
    success: true,
    limit: config.requests,
    remaining: config.requests - entry.count,
    reset: Math.ceil(entry.resetAt / 1000),
  };
}

/**
 * Create rate limit headers for Response
 */
export function createRateLimitHeaders(result: RateLimitResult): HeadersInit {
  const headers: Record<string, string> = {
    [RATE_LIMIT_HEADERS.LIMIT]: String(result.limit),
    [RATE_LIMIT_HEADERS.REMAINING]: String(result.remaining),
    [RATE_LIMIT_HEADERS.RESET]: String(result.reset),
  };
  
  if (result.retryAfter) {
    headers[RATE_LIMIT_HEADERS.RETRY_AFTER] = String(result.retryAfter);
  }
  
  return headers;
}

/**
 * Rate limiter class for more complex scenarios
 */
export class RateLimiter {
  constructor(private config: RateLimitConfig) {}
  
  /**
   * Check if request is allowed
   */
  check(key: string): RateLimitResult {
    return checkRateLimit(key, this.config);
  }
  
  /**
   * Check and throw if rate limited
   */
  checkOrThrow(key: string): RateLimitResult {
    const result = this.check(key);
    
    if (!result.success) {
      throw new RateLimitError(
        `Rate limit exceeded. Try again in ${result.retryAfter} seconds.`,
        result.retryAfter
      );
    }
    
    return result;
  }
}

/**
 * Create rate limiter from API config
 */
export function createRateLimiter(endpoint: keyof typeof API_RATE_LIMITS): RateLimiter {
  return new RateLimiter(API_RATE_LIMITS[endpoint]);
}

/**
 * Pre-configured rate limiters for common endpoints
 */
export const rateLimiters = {
  checkout: createRateLimiter("checkout"),
  validate: createRateLimiter("validate"),
  sheets: createRateLimiter("sheets"),
  general: createRateLimiter("general"),
  auth: createRateLimiter("auth"),
  passwordReset: createRateLimiter("passwordReset"),
  admin: createRateLimiter("admin"),
};

/**
 * Higher-order function to wrap API route with rate limiting
 */
export function withRateLimit(
  endpoint: keyof typeof API_RATE_LIMITS,
  keyFn: (request: Request) => string
) {
  const limiter = createRateLimiter(endpoint);
  
  return function <T extends (request: Request) => Promise<Response>>(handler: T): T {
    return (async (request: Request) => {
      const key = keyFn(request);
      const result = limiter.check(key);
      
      if (!result.success) {
        return new Response(
          JSON.stringify({
            error: "Too many requests",
            retryAfter: result.retryAfter,
          }),
          {
            status: 429,
            headers: {
              "Content-Type": "application/json",
              ...createRateLimitHeaders(result),
            },
          }
        );
      }
      
      // Add rate limit headers to successful response
      const response = await handler(request);
      const headers = new Headers(response.headers);
      
      Object.entries(createRateLimitHeaders(result)).forEach(([key, value]) => {
        headers.set(key, value);
      });
      
      return new Response(response.body, {
        status: response.status,
        statusText: response.statusText,
        headers,
      });
    }) as T;
  };
}

/**
 * Get rate limit key for user-based limiting
 */
export function getUserRateLimitKey(userId: string, endpoint: string): string {
  return `user:${userId}:${endpoint}`;
}

/**
 * Get rate limit key for IP-based limiting
 */
export function getIpRateLimitKey(ip: string, endpoint: string): string {
  return `ip:${ip}:${endpoint}`;
}

/**
 * Extract client IP from request
 */
export function getClientIp(request: Request): string {
  const forwarded = request.headers.get("x-forwarded-for");
  if (forwarded) {
    return forwarded.split(",")[0].trim();
  }
  
  const realIp = request.headers.get("x-real-ip");
  if (realIp) {
    return realIp;
  }
  
  return "unknown";
}

/**
 * Middleware-style rate limiting for API routes
 */
export async function applyRateLimit(
  request: Request,
  userId: string | undefined,
  endpoint: keyof typeof API_RATE_LIMITS
): Promise<RateLimitResult | null> {
  const limiter = createRateLimiter(endpoint);
  
  // Use user ID if available, otherwise use IP
  const key = userId 
    ? getUserRateLimitKey(userId, endpoint)
    : getIpRateLimitKey(getClientIp(request), endpoint);
  
  const result = limiter.check(key);
  
  if (!result.success) {
    return result;
  }
  
  return null; // Rate limit not exceeded
}

/**
 * Create a 429 response
 */
export function createRateLimitResponse(result: RateLimitResult): Response {
  return new Response(
    JSON.stringify({
      error: "Too many requests",
      message: `Rate limit exceeded. Try again in ${result.retryAfter} seconds.`,
      retryAfter: result.retryAfter,
    }),
    {
      status: 429,
      headers: {
        "Content-Type": "application/json",
        ...createRateLimitHeaders(result),
      },
    }
  );
}

