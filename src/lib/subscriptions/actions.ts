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
 * Check if user has access to a specific activity
 */
export async function checkActivityAccess(activityId: string): Promise<{
  hasAccess: boolean;
  isDemo: boolean;
  subscriptionTier: string | null;
  courseId: string | null;
}> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return {
      hasAccess: false,
      isDemo: false,
      subscriptionTier: null,
      courseId: null,
    };
  }

  // Check if user is admin
  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .single();

  if (profile?.role === "admin") {
    return {
      hasAccess: true,
      isDemo: false,
      subscriptionTier: "admin",
      courseId: null,
    };
  }

  const { data, error } = await supabase.rpc("get_activity_access", {
    p_activity_id: activityId,
  });

  if (error || !data?.[0]) {
    log.error("Error checking activity access", error, { activityId });
    return {
      hasAccess: false,
      isDemo: false,
      subscriptionTier: null,
      courseId: null,
    };
  }

  const access = data[0];
  return {
    hasAccess: access.has_access,
    isDemo: access.is_demo,
    subscriptionTier: access.subscription_tier,
    courseId: access.course_id,
  };
}

/**
 * Check if an activity is part of the demo (first N activities)
 */
export async function isActivityDemo(activityId: string): Promise<boolean> {
  const supabase = await createClient();
  
  const { data, error } = await supabase.rpc("is_demo_activity", {
    p_activity_id: activityId,
  });

  if (error) {
    log.error("Error checking if activity is demo", error, { activityId });
    return false;
  }

  return data || false;
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

