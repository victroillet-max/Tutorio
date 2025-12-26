"use server";

import { createClient } from "@/utils/supabase/server";
import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { getSiteUrl } from "@/lib/env";

export type AuthActionResult = {
  error?: string;
  success?: boolean;
  message?: string;
};

/**
 * Sign up a new user with email and password
 */
export async function signUp(formData: FormData): Promise<AuthActionResult> {
  const supabase = await createClient();

  const email = formData.get("email") as string;
  const password = formData.get("password") as string;
  const fullName = formData.get("fullName") as string;

  if (!email || !password) {
    return { error: "Email and password are required" };
  }

  if (password.length < 8) {
    return { error: "Password must be at least 8 characters" };
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
    console.error("Signup error:", error.message);
    return { error: error.message };
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
  const supabase = await createClient();

  const email = formData.get("email") as string;
  const password = formData.get("password") as string;

  if (!email || !password) {
    return { error: "Email and password are required" };
  }

  const { error } = await supabase.auth.signInWithPassword({
    email,
    password,
  });

  if (error) {
    console.error("Login error:", error.message);
    return { error: error.message };
  }

  revalidatePath("/", "layout");
  redirect("/dashboard");
}

/**
 * Sign in with OAuth provider (Google, GitHub, etc.)
 */
export async function signInWithOAuth(provider: "google" | "github") {
  const supabase = await createClient();
  const siteUrl = getSiteUrl();

  const { data, error } = await supabase.auth.signInWithOAuth({
    provider,
    options: {
      redirectTo: `${siteUrl}/auth/callback?next=/dashboard`,
    },
  });

  if (error) {
    console.error("OAuth error:", error.message);
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
  const supabase = await createClient();
  const email = formData.get("email") as string;

  if (!email) {
    return { error: "Email is required" };
  }

  const siteUrl = getSiteUrl();

  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: `${siteUrl}/auth/confirm?type=recovery&next=/reset-password`,
  });

  if (error) {
    console.error("Password reset error:", error.message);
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
    console.error("Password update error:", error.message);
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

