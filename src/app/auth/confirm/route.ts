import { createClient } from "@/utils/supabase/server";
import { type EmailOtpType } from "@supabase/supabase-js";
import { NextResponse } from "next/server";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "auth/confirm" });

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

  // For email verification, redirect to dashboard
  return NextResponse.redirect(`${origin}${next}`);
}

