"use server";

import { createClient } from "@/utils/supabase/server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { headers } from "next/headers";
import { getSiteUrl } from "@/lib/env";
import { logger } from "@/lib/logging";
import { rateLimiters, getIpRateLimitKey } from "@/lib/rate-limit";

// Module-level logger
const log = logger.child({ module: "auth/actions" });

/**
 * Get the client IP from headers for rate limiting
 */
async function getClientIpFromHeaders(): Promise<string> {
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

export type AuthActionResult = {
  error?: string;
  success?: boolean;
  message?: string;
  // Preserve form values on error for better UX
  email?: string;
};

/**
 * Sign up a new user with email and password
 */
export async function signUp(formData: FormData): Promise<AuthActionResult> {
  // Apply rate limiting
  const ip = await getClientIpFromHeaders();
  const rateLimitKey = getIpRateLimitKey(ip, "auth");
  const rateLimitResult = rateLimiters.auth.check(rateLimitKey);
  
  if (!rateLimitResult.success) {
    log.warn("Rate limit exceeded for signup", { ip });
    return {
      error: `Too many attempts. Please try again in ${rateLimitResult.retryAfter} seconds.`,
      email: formData.get("email") as string,
    };
  }

  const supabase = await createClient();

  const email = formData.get("email") as string;
  const password = formData.get("password") as string;
  const fullName = formData.get("fullName") as string;

  if (!email || !password) {
    return { error: "Email and password are required", email };
  }

  if (password.length < 8) {
    return { error: "Password must be at least 8 characters", email };
  }

  const siteUrl = getSiteUrl();
  
  const { error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      emailRedirectTo: `${siteUrl}/auth/callback?next=/dashboard`,
      data: {
        full_name: fullName || null,
      },
    },
  });

  if (error) {
    log.warn("Signup failed", { email, errorMessage: error.message });
    return { error: error.message, email };
  }

  return { 
    success: true, 
    message: "Check your email to confirm your account" 
  };
}

/**
 * Sign in an existing user with email and password
 */
export async function signIn(formData: FormData): Promise<AuthActionResult> {
  const email = formData.get("email") as string;
  const password = formData.get("password") as string;

  if (!email || !password) {
    return { error: "Email and password are required", email };
  }

  // Apply rate limiting
  const ip = await getClientIpFromHeaders();
  const rateLimitKey = getIpRateLimitKey(ip, "auth");
  const rateLimitResult = rateLimiters.auth.check(rateLimitKey);
  
  if (!rateLimitResult.success) {
    log.warn("Rate limit exceeded for signin", { ip, email });
    return {
      error: `Too many login attempts. Please try again in ${rateLimitResult.retryAfter} seconds.`,
      email,
    };
  }

  let supabase;
  try {
    supabase = await createClient();
  } catch (err) {
    log.error("Failed to create Supabase client", err);
    return { error: "Authentication service is unavailable. Please try again later.", email };
  }

  try {
    const { error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (error) {
      log.warn("Login failed", { email, errorMessage: error.message });
      return { error: error.message, email };
    }
  } catch (err) {
    log.error("Sign in exception", err);
    // Check for common configuration errors
    if (err instanceof Error) {
      if (err.message.includes("Unexpected end of JSON input")) {
        return { 
          error: "Authentication service configuration error. Please check Supabase environment variables.",
          email 
        };
      }
      return { error: err.message, email };
    }
    return { error: "An unexpected error occurred during sign in", email };
  }

  revalidatePath("/", "layout");
  redirect("/dashboard");
}

/**
 * Sign in with OAuth provider (Google, GitHub, etc.)
 */
export async function signInWithOAuth(provider: "google" | "github") {
  // Apply rate limiting
  const ip = await getClientIpFromHeaders();
  const rateLimitKey = getIpRateLimitKey(ip, "auth");
  const rateLimitResult = rateLimiters.auth.check(rateLimitKey);
  
  if (!rateLimitResult.success) {
    log.warn("Rate limit exceeded for OAuth", { ip, provider });
    return {
      error: `Too many attempts. Please try again in ${rateLimitResult.retryAfter} seconds.`,
    };
  }

  const supabase = await createClient();
  const siteUrl = getSiteUrl();

  const { data, error } = await supabase.auth.signInWithOAuth({
    provider,
    options: {
      redirectTo: `${siteUrl}/auth/callback?next=/dashboard`,
    },
  });

  if (error) {
    log.error("OAuth error", new Error(error.message), { provider });
    return { error: error.message };
  }

  if (data.url) {
    redirect(data.url);
  }

  return { error: "Failed to initiate OAuth flow" };
}

/**
 * Sign out the current user
 */
export async function signOut() {
  const supabase = await createClient();
  await supabase.auth.signOut();
  revalidatePath("/", "layout");
  redirect("/");
}

/**
 * Request password reset email
 */
export async function forgotPassword(formData: FormData): Promise<AuthActionResult> {
  const email = formData.get("email") as string;

  if (!email) {
    return { error: "Email is required" };
  }

  // Apply stricter rate limiting for password reset
  const ip = await getClientIpFromHeaders();
  const rateLimitKey = getIpRateLimitKey(ip, "passwordReset");
  const rateLimitResult = rateLimiters.passwordReset.check(rateLimitKey);
  
  if (!rateLimitResult.success) {
    log.warn("Rate limit exceeded for password reset", { ip, email });
    return {
      error: `Too many password reset requests. Please try again in ${rateLimitResult.retryAfter} seconds.`,
    };
  }

  const supabase = await createClient();
  const siteUrl = getSiteUrl();

  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: `${siteUrl}/auth/confirm?type=recovery&next=/reset-password`,
  });

  if (error) {
    log.warn("Password reset failed", { email, errorMessage: error.message });
    return { error: error.message };
  }

  return { 
    success: true, 
    message: "Check your email for a password reset link" 
  };
}

/**
 * Reset password with new password
 */
export async function resetPassword(formData: FormData): Promise<AuthActionResult> {
  // Apply rate limiting
  const ip = await getClientIpFromHeaders();
  const rateLimitKey = getIpRateLimitKey(ip, "passwordReset");
  const rateLimitResult = rateLimiters.passwordReset.check(rateLimitKey);
  
  if (!rateLimitResult.success) {
    log.warn("Rate limit exceeded for password update", { ip });
    return {
      error: `Too many attempts. Please try again in ${rateLimitResult.retryAfter} seconds.`,
    };
  }

  const supabase = await createClient();
  const password = formData.get("password") as string;
  const confirmPassword = formData.get("confirmPassword") as string;

  if (!password || !confirmPassword) {
    return { error: "Password and confirmation are required" };
  }

  if (password !== confirmPassword) {
    return { error: "Passwords do not match" };
  }

  if (password.length < 8) {
    return { error: "Password must be at least 8 characters" };
  }

  const { error } = await supabase.auth.updateUser({
    password,
  });

  if (error) {
    log.error("Password update failed", new Error(error.message));
    return { error: error.message };
  }

  revalidatePath("/", "layout");
  redirect("/dashboard");
}

/**
 * Get the current user's session
 */
export async function getSession() {
  const supabase = await createClient();
  const { data: { session } } = await supabase.auth.getSession();
  return session;
}

/**
 * Get the current user
 */
export async function getUser() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  return user;
}
