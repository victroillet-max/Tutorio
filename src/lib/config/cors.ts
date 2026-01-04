/**
 * CORS Configuration
 *
 * Provides utilities for handling Cross-Origin Resource Sharing (CORS)
 * in API routes that need to accept requests from specific origins.
 */

import { getSiteUrl } from "@/lib/env";

/**
 * Get allowed origins for CORS
 * In production, this should be restricted to your known domains
 */
function getAllowedOrigins(): string[] {
  const siteUrl = getSiteUrl();
  const origins = [siteUrl];

  // In development, also allow localhost variants
  if (process.env.NODE_ENV === "development") {
    origins.push(
      "http://localhost:3000",
      "http://127.0.0.1:3000",
      "http://localhost:3001"
    );
  }

  // Add any additional allowed origins from environment
  const additionalOrigins = process.env.ALLOWED_ORIGINS;
  if (additionalOrigins) {
    origins.push(...additionalOrigins.split(",").map((o) => o.trim()));
  }

  return origins;
}

/**
 * Check if an origin is allowed
 */
export function isOriginAllowed(origin: string | null): boolean {
  if (!origin) return false;
  const allowedOrigins = getAllowedOrigins();
  return allowedOrigins.includes(origin);
}

/**
 * Standard CORS headers for allowed origins
 */
export function getCorsHeaders(origin: string | null): HeadersInit {
  if (!origin || !isOriginAllowed(origin)) {
    return {};
  }

  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Max-Age": "86400", // 24 hours
    "Access-Control-Allow-Credentials": "true",
  };
}

/**
 * Handle OPTIONS preflight request
 */
export function handleCorsPreflightRequest(request: Request): Response | null {
  const origin = request.headers.get("origin");

  if (request.method !== "OPTIONS") {
    return null;
  }

  if (isOriginAllowed(origin)) {
    return new Response(null, {
      status: 204,
      headers: getCorsHeaders(origin),
    });
  }

  // Origin not allowed
  return new Response(null, { status: 403 });
}

/**
 * Add CORS headers to an existing response
 */
export function withCorsHeaders(
  response: Response,
  request: Request
): Response {
  const origin = request.headers.get("origin");

  if (!origin || !isOriginAllowed(origin)) {
    return response;
  }

  const corsHeaders = getCorsHeaders(origin);
  const headers = new Headers(response.headers);

  Object.entries(corsHeaders).forEach(([key, value]) => {
    headers.set(key, value);
  });

  return new Response(response.body, {
    status: response.status,
    statusText: response.statusText,
    headers,
  });
}

/**
 * Higher-order function to wrap an API handler with CORS support
 *
 * Usage:
 * ```ts
 * export const GET = withCors(async (request) => {
 *   return NextResponse.json({ data: "..." });
 * });
 *
 * export const OPTIONS = withCors();
 * ```
 */
export function withCors<T extends (request: Request) => Promise<Response>>(
  handler?: T
): (request: Request) => Promise<Response> {
  return async (request: Request): Promise<Response> => {
    // Handle preflight
    const preflightResponse = handleCorsPreflightRequest(request);
    if (preflightResponse) {
      return preflightResponse;
    }

    // If no handler provided (for OPTIONS export), return 204
    if (!handler) {
      return new Response(null, {
        status: 204,
        headers: getCorsHeaders(request.headers.get("origin")),
      });
    }

    // Execute handler and add CORS headers
    const response = await handler(request);
    return withCorsHeaders(response, request);
  };
}


