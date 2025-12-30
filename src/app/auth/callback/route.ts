import { createClient } from "@/utils/supabase/server";
import { NextResponse } from "next/server";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "auth/callback" });

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
    const { error: exchangeError } = await supabase.auth.exchangeCodeForSession(code);

    if (exchangeError) {
      log.error("Code exchange error", new Error(exchangeError.message));
      const errorMessage = encodeURIComponent(exchangeError.message);
      return NextResponse.redirect(`${origin}/login?error=${errorMessage}`);
    }

    // Successful authentication - redirect to intended destination
    return NextResponse.redirect(`${origin}${next}`);
  }

  // No code provided - redirect to login with error
  return NextResponse.redirect(`${origin}/login?error=auth_callback_missing_code`);
}

