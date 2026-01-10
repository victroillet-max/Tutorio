"use server";

import { createClient } from "@/utils/supabase/server";
import type { UserCourseSubscription, CourseSubscriptionInfo } from "@/lib/database.types";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "subscriptions/actions" });

/**
 * Get all subscriptions for the current user
 */
export async function getUserSubscriptions(): Promise<UserCourseSubscription[]> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return [];
  }

  const { data, error } = await supabase.rpc("get_user_subscriptions", {
    p_user_id: user.id,
  });

  if (error) {
    log.error("Error fetching subscriptions", error, { userId: user.id });
    return [];
  }

  return data || [];
}

/**
 * Get subscription for a specific course
 */
export async function getCourseSubscription(courseId: string): Promise<CourseSubscriptionInfo | null> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return null;
  }

  const { data, error } = await supabase.rpc("get_user_course_subscription", {
    p_user_id: user.id,
    p_course_id: courseId,
  });

  if (error) {
    log.error("Error fetching course subscription", error, { userId: user.id, courseId });
    return null;
  }

  return data?.[0] || null;
}

/**
 * Get the user's subscription tier for a specific course
 */
export async function getCourseSubscriptionTier(courseId: string): Promise<string | null> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return null;
  }

  // Check if user is admin
  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .single();

  if (profile?.role === "admin") {
    return "admin";
  }

  const { data, error } = await supabase.rpc("get_course_subscription_tier", {
    p_course_id: courseId,
  });

  if (error) {
    log.error("Error getting course subscription tier", error, { courseId });
    return null;
  }

  return data;
}

/**
 * Get user's AI rate limit info
 */
export async function getUserRateLimit(): Promise<{
  tier: string;
  messagesPerDay: number;
  messagesUsedToday: number;
  messagesRemaining: number;
} | null> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return null;
  }

  const { data, error } = await supabase.rpc("get_user_rate_limit", {
    p_user_id: user.id,
  });

  if (error || !data?.[0]) {
    log.error("Error getting rate limit", error, { userId: user.id });
    return null;
  }

  const limit = data[0];
  return {
    tier: limit.tier,
    messagesPerDay: limit.messages_per_day,
    messagesUsedToday: limit.messages_used_today,
    messagesRemaining: limit.messages_remaining_today,
  };
}

/**
 * Count active subscriptions for the current user
 */
export async function countActiveSubscriptions(): Promise<number> {
  const subscriptions = await getUserSubscriptions();
  return subscriptions.filter(
    s => s.status === 'active' || s.status === 'trialing'
  ).length;
}

