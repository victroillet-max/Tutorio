"use server";

import { createClient } from "@/utils/supabase/server";
import { revalidatePath } from "next/cache";
import { withAuth, type AuthContext } from "@/lib/auth/with-auth";
import { createActivityService } from "@/lib/services";
import { logger } from "@/lib/logging";
import { Result, ok, err, isOk } from "@/lib/types/result";
import { SupabaseClient } from "@supabase/supabase-js";

// Create a typed logger for this module
const log = logger.child({ module: "activities/actions" });

/**
 * Retry wrapper for async operations with exponential backoff
 * Helps handle transient network errors (B4: Failed Server Actions)
 */
async function withRetry<T>(
  fn: () => Promise<T>,
  options: { maxRetries?: number; initialDelayMs?: number } = {}
): Promise<T> {
  const { maxRetries = 3, initialDelayMs = 500 } = options;
  let lastError: Error | unknown;
  
  for (let attempt = 0; attempt < maxRetries; attempt++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error;
      
      // Don't retry on authentication errors or validation errors
      if (error instanceof Error) {
        const message = error.message.toLowerCase();
        if (message.includes('not authenticated') || 
            message.includes('not found') || 
            message.includes('validation')) {
          throw error;
        }
      }
      
      // Exponential backoff with jitter
      if (attempt < maxRetries - 1) {
        const delay = initialDelayMs * Math.pow(2, attempt) + Math.random() * 100;
        await new Promise(resolve => setTimeout(resolve, delay));
      }
    }
  }
  
  throw lastError;
}

/**
 * Helper to revalidate paths after activity operations
 */
function revalidateActivityPaths(
  moduleData?: { slug: string; course: { slug: string } } | null
) {
  if (moduleData) {
    revalidatePath(`/courses/${moduleData.course.slug}`);
    revalidatePath(`/courses/${moduleData.course.slug}/${moduleData.slug}`);
  }
  revalidatePath("/profile");
  revalidatePath("/skills");
  revalidatePath("/foundations");
  revalidatePath("/dashboard");
}

/**
 * Mark an activity as complete and award XP
 * Uses the new service layer pattern
 */
export const markActivityComplete = withAuth(
  async ({ user, supabase }: AuthContext, activityId: string, score?: number) => {
    const service = createActivityService(supabase as SupabaseClient, user.id);
    
    const result = await withRetry(async () => {
      return service.completeActivity(activityId, score);
    });

    if (isOk(result)) {
      // Revalidate paths
      revalidateActivityPaths(result.data.activity.module);
      
      log.info("Activity completed", {
        userId: user.id,
        activityId,
        xpEarned: result.data.xpEarned,
        isFirstCompletion: result.data.isFirstCompletion,
      });

      return { 
        success: true, 
        xpEarned: result.data.xpEarned 
      };
    }

    log.error("Failed to complete activity", result.error, { activityId });
    throw result.error;
  }
);

/**
 * Update activity progress (for partial progress like scroll position)
 * For time tracking: timeSpentSeconds should be the NEW time to ADD (not total)
 */
export const updateActivityProgress = withAuth(
  async ({ user, supabase }: AuthContext, activityId: string, data: {
    lastPositionSeconds?: number;
    timeSpentSeconds?: number;
  }) => {
    const service = createActivityService(supabase as SupabaseClient, user.id);
    
    const result = await service.updatePartialProgress(activityId, data);

    if (!isOk(result)) {
      log.error("Failed to update progress", result.error, { activityId });
      throw result.error;
    }

    return { success: true };
  }
);

/**
 * Track when a user views/starts an activity (creates progress record if not exists)
 * This allows us to show "Continue Learning" on the dashboard
 */
export const trackActivityView = withAuth(
  async ({ user, supabase }: AuthContext, activityId: string) => {
    const service = createActivityService(supabase as SupabaseClient, user.id);
    
    await service.trackActivityView(activityId);

    // Revalidate dashboard and profile to show updated continue learning
    revalidatePath("/dashboard");
    revalidatePath("/profile");

    return { success: true };
  }
);

/**
 * Enroll user in a course
 */
export const enrollInCourse = withAuth(
  async ({ user, supabase }: AuthContext, courseId: string) => {
    const { error } = await supabase
      .from("course_enrollments")
      .upsert({
        user_id: user.id,
        course_id: courseId,
        enrolled_at: new Date().toISOString(),
      }, {
        onConflict: "user_id,course_id",
      });

    if (error) {
      log.error("Failed to enroll", error, { courseId });
      throw new Error("Failed to enroll in course");
    }

    revalidatePath("/courses");
    revalidatePath("/dashboard");

    return { success: true };
  }
);

/**
 * Quick start learning - enrolls user in recommended course and returns first activity URL
 * Used for one-click onboarding from the empty dashboard state
 */
export const quickStartLearning = withAuth(
  async ({ user, supabase }: AuthContext): Promise<{ success: boolean; redirectUrl?: string; error?: string }> => {
    try {
      // Find the first published beginner course (or first course if none marked beginner)
      const { data: course } = await supabase
        .from("courses")
        .select("id, slug")
        .eq("is_published", true)
        .order("sort_order")
        .limit(1)
        .single();

      if (!course) {
        return { success: false, error: "No courses available" };
      }

      // Enroll user in course
      await supabase
        .from("course_enrollments")
        .upsert({
          user_id: user.id,
          course_id: course.id,
          enrolled_at: new Date().toISOString(),
        }, {
          onConflict: "user_id,course_id",
        });

      // Get first skill for this course
      const { data: firstSkill } = await supabase
        .from("skills")
        .select("id, slug")
        .eq("course_id", course.id)
        .eq("is_active", true)
        .order("sort_order")
        .limit(1)
        .single();

      if (!firstSkill) {
        // No skills yet, just go to course page
        return { success: true, redirectUrl: `/courses/${course.slug}/learn` };
      }

      // Get first activity for this skill
      const { data: skillActivities } = await supabase
        .rpc("get_skill_activities", {
          p_skill_id: firstSkill.id,
          p_user_id: user.id
        });

      if (skillActivities && skillActivities.length > 0) {
        const firstActivity = skillActivities[0];
        revalidatePath("/dashboard");
        
        log.info("Quick start initiated", { 
          userId: user.id, 
          courseSlug: course.slug,
          skillSlug: firstSkill.slug 
        });
        
        return { 
          success: true, 
          redirectUrl: `/skills/${firstSkill.slug}/${firstActivity.activity_slug}` 
        };
      }

      // Fallback to skill page
      revalidatePath("/dashboard");
      return { success: true, redirectUrl: `/skills/${firstSkill.slug}` };
    } catch (error) {
      log.error("Quick start failed", error, { userId: user.id });
      return { success: false, error: "Failed to start learning" };
    }
  }
);

/**
 * Recalculate all skill mastery for the current user
 * This is useful after database migrations or to fix inconsistent data
 */
export const recalculateAllSkillMastery = withAuth(
  async ({ user, supabase }: AuthContext) => {
    const { error } = await supabase.rpc("recalculate_all_skill_mastery", {
      p_user_id: user.id,
    });
    
    if (error) {
      log.error("Failed to recalculate skill mastery", error, { userId: user.id });
      throw new Error("Failed to recalculate skill mastery");
    }
    
    // Revalidate skill-related pages
    revalidatePath("/skills");
    revalidatePath("/foundations");
    revalidatePath("/dashboard");
    
    log.info("Skill mastery recalculated", { userId: user.id });
    
    return { success: true };
  }
);
