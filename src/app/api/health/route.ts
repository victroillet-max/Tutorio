import { NextResponse } from "next/server";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";

/**
 * Health check endpoint to verify Supabase configuration
 * GET /api/health
 */
export async function GET() {
  const checks: Record<string, unknown> = {
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV,
  };

  // Check environment variables
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  checks.envVars = {
    NEXT_PUBLIC_SUPABASE_URL: supabaseUrl ? "set" : "MISSING",
    NEXT_PUBLIC_SUPABASE_ANON_KEY: supabaseAnonKey ? "set" : "MISSING",
    SUPABASE_SERVICE_ROLE_KEY: serviceRoleKey ? "set" : "not set (optional)",
    NEXT_PUBLIC_SITE_URL: process.env.NEXT_PUBLIC_SITE_URL || "not set (using fallback)",
  };

  // Validate URL format
  if (supabaseUrl) {
    try {
      const url = new URL(supabaseUrl);
      checks.supabaseUrlValid = true;
      checks.supabaseUrlHost = url.host;
    } catch {
      checks.supabaseUrlValid = false;
      checks.supabaseUrlError = "Invalid URL format";
    }
  }

  // Test Supabase connection
  if (supabaseUrl && supabaseAnonKey) {
    try {
      const cookieStore = await cookies();
      const supabase = createServerClient(supabaseUrl, supabaseAnonKey, {
        cookies: {
          getAll() {
            return cookieStore.getAll();
          },
          setAll() {
            // Read-only for health check
          },
        },
      });

      // Try to make a simple API call
      const { error } = await supabase.auth.getSession();
      
      if (error) {
        checks.supabaseConnection = "error";
        checks.supabaseError = error.message;
      } else {
        checks.supabaseConnection = "ok";
      }
    } catch (err) {
      checks.supabaseConnection = "failed";
      checks.supabaseError = err instanceof Error ? err.message : "Unknown error";
    }
  } else {
    checks.supabaseConnection = "skipped (missing env vars)";
  }

  const allOk = 
    checks.supabaseUrlValid === true && 
    checks.supabaseConnection === "ok";

  return NextResponse.json(
    { status: allOk ? "healthy" : "unhealthy", checks },
    { status: allOk ? 200 : 503 }
  );
}

