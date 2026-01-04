import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "middleware" });

/**
 * Hash a session token for validation using Web Crypto API (Edge-compatible)
 */
async function hashSessionToken(token: string): Promise<string> {
  const encoder = new TextEncoder();
  const data = encoder.encode(token);
  const hashBuffer = await crypto.subtle.digest("SHA-256", data);
  const hashArray = Array.from(new Uint8Array(hashBuffer));
  return hashArray.map(b => b.toString(16).padStart(2, "0")).join("");
}

/**
 * Middleware for session management and route protection
 * 
 * Key responsibilities:
 * 1. Refresh session on every request (prevents session expiry)
 * 2. Redirect unauthenticated users from protected routes to login
 * 3. Validate session against concurrent login limit
 * 4. Keep role checks lightweight - defer to page-level for admin checks
 */

// Routes that require authentication
const protectedRoutes = ["/dashboard", "/courses", "/profile", "/settings", "/subscriptions", "/pricing", "/skills", "/foundations"];

// Routes that should redirect authenticated users (auth pages)
const authRoutes = ["/login", "/signup", "/forgot-password"];

export async function middleware(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  // If Supabase is not configured, allow the request through
  // The page-level components will handle the error appropriately
  if (!supabaseUrl || !supabaseAnonKey) {
    log.error("Supabase environment variables not configured");
    return NextResponse.next({ request });
  }

  let supabaseResponse = NextResponse.next({
    request,
  });

  const supabase = createServerClient(
    supabaseUrl,
    supabaseAnonKey,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) =>
            request.cookies.set(name, value)
          );
          supabaseResponse = NextResponse.next({
            request,
          });
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options)
          );
        },
      },
    }
  );

  // IMPORTANT: Do not add any logic between createServerClient and getUser()
  // This can cause session management issues

  let user = null;
  let session = null;
  try {
    const { data: userData } = await supabase.auth.getUser();
    user = userData.user;
    
    const { data: sessionData } = await supabase.auth.getSession();
    session = sessionData.session;
  } catch (err) {
    // If getUser fails (e.g., invalid configuration), log and continue
    log.error("Failed to get user", err);
    return NextResponse.next({ request });
  }

  const { pathname } = request.nextUrl;

  // Check if current path matches any protected routes
  const isProtectedRoute = protectedRoutes.some(
    (route) => pathname === route || pathname.startsWith(`${route}/`)
  );

  // Check if current path matches auth routes
  const isAuthRoute = authRoutes.some(
    (route) => pathname === route || pathname.startsWith(`${route}/`)
  );

  // Redirect unauthenticated users from protected routes to login
  if (isProtectedRoute && !user) {
    const redirectUrl = new URL("/login", request.url);
    redirectUrl.searchParams.set("next", pathname);
    return NextResponse.redirect(redirectUrl);
  }

  // For protected routes with authenticated users, validate session against our tracking table
  // This ensures users are logged out when their session was invalidated due to login limit
  if (isProtectedRoute && user && session?.access_token) {
    try {
      const tokenHash = await hashSessionToken(session.access_token);
      
      // Query the user_sessions table to check if this session is still valid
      const { data: sessionValid } = await supabase.rpc("validate_session", {
        p_session_token_hash: tokenHash,
      });

      // If session is not valid in our tracking table, sign out the user
      // This happens when they were logged out from another device due to the login limit
      if (sessionValid === false) {
        log.info("Session invalidated due to concurrent login limit", { 
          userId: user.id,
          pathname 
        });
        
        // Sign out the user
        await supabase.auth.signOut();
        
        // Redirect to login with a message
        const redirectUrl = new URL("/login", request.url);
        redirectUrl.searchParams.set("error", "session_expired");
        redirectUrl.searchParams.set("message", "You were logged out because you signed in from another device.");
        return NextResponse.redirect(redirectUrl);
      }
    } catch (err) {
      // If validation fails, log but don't block the user
      // The session tracking is a secondary check, not the primary auth
      log.warn("Session validation check failed", { error: err });
    }
  }

  // Redirect authenticated users from auth routes to dashboard
  // Note: This is also handled in (auth)/layout.tsx as a safety net
  if (isAuthRoute && user) {
    return NextResponse.redirect(new URL("/dashboard", request.url));
  }

  // IMPORTANT: Always return supabaseResponse to maintain session cookies
  return supabaseResponse;
}

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico (favicon file)
     * - public files (images, etc.)
     */
    "/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)",
  ],
};
