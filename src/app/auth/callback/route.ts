import { createClient } from "@/utils/supabase/server";
import { createClient as createServiceClient } from "@supabase/supabase-js";
import { NextResponse } from "next/server";
import { headers } from "next/headers";
import { logger } from "@/lib/logging";
import { registerSession } from "@/lib/auth/session-manager";
import { sendWelcomeEmail } from "@/lib/email/actions";

const log = logger.child({ module: "auth/callback" });

// Service client for operations that bypass RLS
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

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

      // Check if we need to send welcome email (only once per user)
      if (data.user.email && supabaseServiceKey) {
        try {
          const serviceClient = createServiceClient(supabaseUrl, supabaseServiceKey);
          
          // Check if welcome email was already sent
          const { data: profile } = await serviceClient
            .from("profiles")
            .select("welcome_email_sent_at")
            .eq("id", data.user.id)
            .single();

          if (profile && !profile.welcome_email_sent_at) {
            // Send welcome email
            const emailResult = await sendWelcomeEmail({
              to: data.user.email,
              email: data.user.email,
              userName: data.user.user_metadata?.full_name || data.user.user_metadata?.name || "",
            });

            if (emailResult.success) {
              // Mark welcome email as sent
              await serviceClient
                .from("profiles")
                .update({ welcome_email_sent_at: new Date().toISOString() })
                .eq("id", data.user.id);

              log.info("Welcome email sent successfully", { 
                userId: data.user.id, 
                email: data.user.email,
                emailId: emailResult.id,
              });
            } else {
              log.error("Failed to send welcome email", new Error(emailResult.error), { 
                userId: data.user.id 
              });
            }
          }
        } catch (err) {
          log.error("Error in welcome email flow", err, { userId: data.user.id });
        }
      }
    }

    // Successful authentication - redirect to intended destination
    return NextResponse.redirect(`${origin}${next}`);
  }

  // No code provided - redirect to login with error
  return NextResponse.redirect(`${origin}/login?error=auth_callback_missing_code`);
}

