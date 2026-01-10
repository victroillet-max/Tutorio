import { createClient } from "@/utils/supabase/server";
import { createClient as createServiceClient } from "@supabase/supabase-js";
import { type EmailOtpType } from "@supabase/supabase-js";
import { NextResponse } from "next/server";
import { logger } from "@/lib/logging";
import { sendWelcomeEmail } from "@/lib/email/actions";

const log = logger.child({ module: "auth/confirm" });

// Service client for operations that bypass RLS
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

/**
 * Email confirmation handler for Supabase email verification
 * This route handles email confirmation links (signup verification, password reset, etc.)
 */
export async function GET(request: Request) {
  const { searchParams, origin } = new URL(request.url);
  const token_hash = searchParams.get("token_hash");
  const type = searchParams.get("type") as EmailOtpType | null;
  const next = searchParams.get("next") ?? "/dashboard";

  if (!token_hash || !type) {
    log.warn("Missing token_hash or type in confirm route");
    return NextResponse.redirect(`${origin}/login?error=invalid_confirmation_link`);
  }

  const supabase = await createClient();
  const { error } = await supabase.auth.verifyOtp({
    type,
    token_hash,
  });

  if (error) {
    log.error("OTP verification error", new Error(error.message), { type });
    
    // Handle specific error cases
    if (type === "recovery") {
      return NextResponse.redirect(`${origin}/forgot-password?error=${encodeURIComponent(error.message)}`);
    }
    
    return NextResponse.redirect(`${origin}/login?error=${encodeURIComponent(error.message)}`);
  }

  // Handle password reset flow - redirect to reset password page
  if (type === "recovery") {
    return NextResponse.redirect(`${origin}/reset-password`);
  }

  // For email verification (signup), send welcome email
  if (type === "signup" || type === "email") {
    // Get the current user to send welcome email
    const { data: { user } } = await supabase.auth.getUser();
    
    if (user?.email && supabaseServiceKey) {
      try {
        const serviceClient = createServiceClient(supabaseUrl, supabaseServiceKey);
        
        // Check if welcome email was already sent
        const { data: profile } = await serviceClient
          .from("profiles")
          .select("welcome_email_sent_at")
          .eq("id", user.id)
          .single();

        if (profile && !profile.welcome_email_sent_at) {
          // Send welcome email
          const emailResult = await sendWelcomeEmail({
            to: user.email,
            email: user.email,
            userName: user.user_metadata?.full_name || "",
          });

          if (emailResult.success) {
            // Mark welcome email as sent
            await serviceClient
              .from("profiles")
              .update({ welcome_email_sent_at: new Date().toISOString() })
              .eq("id", user.id);

            log.info("Welcome email sent successfully", { 
              userId: user.id, 
              email: user.email,
              emailId: emailResult.id,
            });
          } else {
            log.error("Failed to send welcome email", new Error(emailResult.error), { 
              userId: user.id 
            });
          }
        }
      } catch (err) {
        log.error("Error in welcome email flow", err, { userId: user.id });
      }
    }
  }

  // Redirect to dashboard
  return NextResponse.redirect(`${origin}${next}`);
}

