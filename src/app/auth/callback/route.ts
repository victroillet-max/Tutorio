import { createClient } from "@/utils/supabase/server";
import { NextResponse } from "next/server";
import { headers } from "next/headers";
import { logger } from "@/lib/logging";
import { registerSession } from "@/lib/auth/session-manager";
import { sendWelcomeEmail } from "@/lib/email/actions";

const log = logger.child({ module: "auth/callback" });

/**
 * Get the client IP from headers
 */
async function getClientIp(): Promise<string> {
  const headersList = await headers();
  const forwarded = headersList.get("x-forwarded-for");
  if (forwarded) {
    return forwarded.split(",")[0].trim();
  }
  const realIp = headersList.get("x-real-ip");
  if (realIp) {
    return realIp;
  }
  return "unknown";
}

/**
 * Auth callback handler for Supabase OAuth and magic link authentication
 * This route handles the redirect from Supabase after successful authentication
 */
export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url);
  const code = searchParams.get("code");
  const next = searchParams.get("next") ?? "/dashboard";
  const error = searchParams.get("error");
  const errorDescription = searchParams.get("error_description");

  // Handle OAuth/magic link errors
  if (error) {
    log.error("Auth callback error", undefined, { error, errorDescription });
    const errorMessage = encodeURIComponent(errorDescription || error);
    return NextResponse.redirect(`${origin}/login?error=${errorMessage}`);
  }

  // Exchange the code for a session
  if (code) {
    const supabase = await createClient();
    const { data, error: exchangeError } = await supabase.auth.exchangeCodeForSession(code);

    if (exchangeError) {
      log.error("Code exchange error", new Error(exchangeError.message));
      const errorMessage = encodeURIComponent(exchangeError.message);
      return NextResponse.redirect(`${origin}/login?error=${errorMessage}`);
    }

    // Register the session to enforce concurrent login limit
    if (data.session && data.user) {
      const headersList = await headers();
      const ip = await getClientIp();
      
      const sessionResult = await registerSession(
        data.user.id,
        data.session.access_token,
        {
          ipAddress: ip,
          deviceInfo: headersList.get("user-agent") || undefined,
          expiresAt: new Date(data.session.expires_at! * 1000),
        }
      );

      if (sessionResult.sessionsInvalidated && sessionResult.sessionsInvalidated > 0) {
        log.info("Previous sessions invalidated due to login limit (OAuth)", {
          userId: data.user.id,
          invalidatedCount: sessionResult.sessionsInvalidated,
        });
      }

      // Check if this is a new user (created within the last minute) to send welcome email
      const userCreatedAt = new Date(data.user.created_at);
      const now = new Date();
      const isNewUser = (now.getTime() - userCreatedAt.getTime()) < 60000; // Within 1 minute

      if (isNewUser && data.user.email) {
        // Send welcome email for new OAuth users
        sendWelcomeEmail({
          to: data.user.email,
          email: data.user.email,
          userName: data.user.user_metadata?.full_name || data.user.user_metadata?.name || "",
        }).catch((err) => {
          log.error("Failed to send welcome email for OAuth user", err, { userId: data.user.id });
        });

        log.info("Welcome email triggered for OAuth user", { 
          userId: data.user.id, 
          email: data.user.email,
        });
      }
    }

    // Successful authentication - redirect to intended destination
    return NextResponse.redirect(`${origin}${next}`);
  }

  // No code provided - redirect to login with error
  return NextResponse.redirect(`${origin}/login?error=auth_callback_missing_code`);
}

