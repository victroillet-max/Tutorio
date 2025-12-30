"use server";

import { createClient } from "@/utils/supabase/server";
import { revalidatePath } from "next/cache";

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
 * Mark an activity as complete and award XP
 */
export async function markActivityComplete(activityId: string, score?: number) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  // Get activity details
  const { data: activity, error: activityError } = await supabase
    .from("activities")
    .select("*, module:modules(course:courses(slug), slug)")
    .eq("id", activityId)
    .single();

  if (activityError || !activity) {
    throw new Error("Activity not found");
  }

  // Check if already completed (to avoid duplicate XP)
  const { data: existingProgress } = await supabase
    .from("activity_progress")
    .select("id, completed, xp_earned, attempts, score, completed_at")
    .eq("user_id", user.id)
    .eq("activity_id", activityId)
    .single();

  const isFirstCompletion = !existingProgress?.completed;
  const attempts = (existingProgress?.attempts || 0) + 1;
  
  // Calculate XP (first-try bonus is 1.5x)
  let xpEarned = activity.xp || 0;
  const firstTryBonus = isFirstCompletion && attempts === 1;
  if (firstTryBonus) {
    xpEarned = Math.round(xpEarned * 1.5);
  }

  // Upsert activity progress with retry for transient errors
  await withRetry(async () => {
    const { error: progressError } = await supabase
      .from("activity_progress")
      .upsert({
        user_id: user.id,
        activity_id: activityId,
        completed: true,
        score: score ?? existingProgress?.score ?? null,
        xp_earned: isFirstCompletion ? xpEarned : (existingProgress?.xp_earned || 0),
        attempts,
        first_try_bonus: firstTryBonus,
        completed_at: isFirstCompletion ? new Date().toISOString() : existingProgress?.completed_at,
        last_accessed_at: new Date().toISOString(),
      }, {
        onConflict: "user_id,activity_id",
      });

    if (progressError) {
      console.error("Failed to save progress:", progressError);
      throw new Error("Failed to save progress");
    }
  });

  // Update user streaks and total XP (only on first completion)
  if (isFirstCompletion) {
    // Use local date for streak tracking (more intuitive for users)
    const now = new Date();
    const today = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;
    
    // Get current streak data
    const { data: streak } = await supabase
      .from("user_streaks")
      .select("*")
      .eq("user_id", user.id)
      .single();

    if (streak) {
      const yesterday = new Date();
      yesterday.setDate(yesterday.getDate() - 1);
      const yesterdayStr = `${yesterday.getFullYear()}-${String(yesterday.getMonth() + 1).padStart(2, '0')}-${String(yesterday.getDate()).padStart(2, '0')}`;
      
      // Normalize the database date to YYYY-MM-DD format (handles both DATE and TIMESTAMPTZ)
      const lastActivityDate = streak.last_activity_date 
        ? streak.last_activity_date.split('T')[0] 
        : null;
      
      let newStreak = 1;
      if (lastActivityDate === today) {
        // Already active today, keep current streak
        newStreak = streak.current_streak || 1;
      } else if (lastActivityDate === yesterdayStr) {
        // Consecutive day, increment streak
        newStreak = (streak.current_streak || 0) + 1;
      }
      // else: Gap of 2+ days, reset to 1
      
      await supabase
        .from("user_streaks")
        .update({
          total_xp: (streak.total_xp || 0) + xpEarned,
          last_activity_date: today,
          current_streak: newStreak,
          longest_streak: Math.max(streak.longest_streak || 0, newStreak),
        })
        .eq("user_id", user.id);
    } else {
      // Create new streak record
      await supabase
        .from("user_streaks")
        .insert({
          user_id: user.id,
          total_xp: xpEarned,
          last_activity_date: today,
          current_streak: 1,
          longest_streak: 1,
        });
    }
  }

  // Check and award badges
  await checkAndAwardBadges(user.id);

  // Update skill mastery for all skills associated with this activity
  await updateSkillMasteryForActivity(user.id, activityId);

  // Revalidate the course pages, skill pages and profile to show updated progress
  const moduleData = activity.module as unknown as { slug: string; course: { slug: string } }[] | { slug: string; course: { slug: string } };
  const module = Array.isArray(moduleData) ? moduleData[0] : moduleData;
  if (module) {
    revalidatePath(`/courses/${module.course.slug}`);
    revalidatePath(`/courses/${module.course.slug}/${module.slug}`);
  }
  revalidatePath("/profile");
  revalidatePath("/skills");
  revalidatePath("/foundations");
  revalidatePath("/dashboard");

  return { success: true, xpEarned: isFirstCompletion ? xpEarned : 0 };
}

/**
 * Update activity progress (for partial progress like scroll position)
 * For time tracking: timeSpentSeconds should be the NEW time to ADD (not total)
 */
export async function updateActivityProgress(
  activityId: string, 
  data: {
    lastPositionSeconds?: number;
    timeSpentSeconds?: number;
  }
) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  // Fetch existing progress to accumulate time spent
  const { data: existingProgress } = await supabase
    .from("activity_progress")
    .select("time_spent_seconds")
    .eq("user_id", user.id)
    .eq("activity_id", activityId)
    .single();

  // Accumulate time spent instead of replacing it
  const existingTimeSpent = existingProgress?.time_spent_seconds || 0;
  const newTimeSpent = data.timeSpentSeconds 
    ? existingTimeSpent + data.timeSpentSeconds 
    : existingTimeSpent;

  const { error } = await supabase
    .from("activity_progress")
    .upsert({
      user_id: user.id,
      activity_id: activityId,
      last_position_seconds: data.lastPositionSeconds,
      time_spent_seconds: newTimeSpent,
      last_accessed_at: new Date().toISOString(),
    }, {
      onConflict: "user_id,activity_id",
    });

  if (error) {
    console.error("Failed to update progress:", error);
    throw new Error("Failed to update progress");
  }

  return { success: true };
}

/**
 * Check and award badges based on user's progress
 */
async function checkAndAwardBadges(userId: string) {
  const supabase = await createClient();

  // Get all badges and user's current badges
  const [{ data: allBadges }, { data: userBadges }, { data: progress }] = await Promise.all([
    supabase.from("badges").select("*"),
    supabase.from("user_badges").select("badge_id").eq("user_id", userId),
    supabase.from("activity_progress").select("*, activity:activities(type, module:modules(external_id))").eq("user_id", userId).eq("completed", true),
  ]);

  if (!allBadges || !progress) return;

  const earnedBadgeIds = new Set(userBadges?.map(b => b.badge_id) || []);
  const newBadges: string[] = [];

  for (const badge of allBadges) {
    if (earnedBadgeIds.has(badge.id)) continue;

    const criteria = badge.unlock_criteria as Record<string, unknown> | null;
    if (!criteria) continue;

    let earned = false;

    switch (criteria.type) {
      case 'activity_count':
        earned = progress.length >= (criteria.count as number);
        break;
      
      case 'activity_type_complete':
        const typeCount = progress.filter(p => {
          const activity = p.activity as unknown as { type: string }[] | { type: string };
          const type = Array.isArray(activity) ? activity[0]?.type : activity?.type;
          return type === criteria.activityType;
        }).length;
        earned = criteria.all 
          ? typeCount > 0 // Simplified: just check if any completed
          : typeCount >= (criteria.count as number);
        break;
      
      case 'modules_complete':
        const requiredModules = criteria.modules as string[];
        const completedModules = new Set(
          progress.map(p => {
            const activity = p.activity as unknown as { module: { external_id: string } }[] | { module: { external_id: string } };
            const act = Array.isArray(activity) ? activity[0] : activity;
            return act?.module?.external_id;
          })
        );
        earned = requiredModules.every(m => completedModules.has(m));
        break;
      
      case 'streak':
        const { data: streak } = await supabase
          .from("user_streaks")
          .select("current_streak, longest_streak")
          .eq("user_id", userId)
          .single();
        earned = (streak?.longest_streak || 0) >= (criteria.days as number);
        break;
    }

    if (earned) {
      newBadges.push(badge.id);
    }
  }

  // Award new badges
  if (newBadges.length > 0) {
    await supabase
      .from("user_badges")
      .insert(newBadges.map(badgeId => ({
        user_id: userId,
        badge_id: badgeId,
      })));
  }
}

/**
 * Enroll user in a course
 */
/**
 * Track when a user views/starts an activity (creates progress record if not exists)
 * This allows us to show "Continue Learning" on the dashboard
 */
export async function trackActivityView(activityId: string) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  // Check if progress record already exists
  const { data: existingProgress } = await supabase
    .from("activity_progress")
    .select("id")
    .eq("user_id", user.id)
    .eq("activity_id", activityId)
    .single();

  // Only create if doesn't exist
  if (!existingProgress) {
    const { error } = await supabase
      .from("activity_progress")
      .insert({
        user_id: user.id,
        activity_id: activityId,
        completed: false,
        xp_earned: 0,
        attempts: 0,
        first_try_bonus: false,
        last_position_seconds: 0,
        time_spent_seconds: 0,
        last_accessed_at: new Date().toISOString(),
      });

    if (error) {
      console.error("Failed to track activity view:", error);
      // Don't throw - this is non-critical
    }
  } else {
    // Update last_accessed_at
    await supabase
      .from("activity_progress")
      .update({
        last_accessed_at: new Date().toISOString(),
      })
      .eq("user_id", user.id)
      .eq("activity_id", activityId);
  }

  // Revalidate dashboard and profile to show updated continue learning
  revalidatePath("/dashboard");
  revalidatePath("/profile");

  return { success: true };
}

export async function enrollInCourse(courseId: string) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

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
    console.error("Failed to enroll:", error);
    throw new Error("Failed to enroll in course");
  }

  return { success: true };
}

/**
 * Update skill mastery for all skills associated with an activity
 */
async function updateSkillMasteryForActivity(userId: string, activityId: string) {
  const supabase = await createClient();

  // Get all skills associated with this activity
  const { data: activitySkills } = await supabase
    .from("activity_skills")
    .select("skill_id, weight, teaches")
    .eq("activity_id", activityId);

  if (!activitySkills || activitySkills.length === 0) return;

  // Calculate and update mastery for each skill
  for (const activitySkill of activitySkills) {
    try {
      // Use the database function to calculate mastery
      await supabase.rpc("calculate_skill_mastery", {
        p_user_id: userId,
        p_skill_id: activitySkill.skill_id,
      });
    } catch (error) {
      console.error(`Failed to update mastery for skill ${activitySkill.skill_id}:`, error);
      // Continue with other skills even if one fails
    }
  }
}

/**
 * Quick start learning - enrolls user in recommended course and returns first activity URL
 * Used for one-click onboarding from the empty dashboard state
 */
export async function quickStartLearning(): Promise<{ success: boolean; redirectUrl?: string; error?: string }> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return { success: false, error: "Not authenticated" };
  }

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
      return { 
        success: true, 
        redirectUrl: `/skills/${firstSkill.slug}/${firstActivity.activity_slug}` 
      };
    }

    // Fallback to skill page
    revalidatePath("/dashboard");
    return { success: true, redirectUrl: `/skills/${firstSkill.slug}` };
  } catch (error) {
    console.error("Quick start failed:", error);
    return { success: false, error: "Failed to start learning" };
  }
}

/**
 * Recalculate all skill mastery for the current user
 * This is useful after database migrations or to fix inconsistent data
 */
export async function recalculateAllSkillMastery() {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  try {
    const { error } = await supabase.rpc("recalculate_all_skill_mastery", {
      p_user_id: user.id,
    });
    
    if (error) {
      console.error("Failed to recalculate skill mastery:", error);
      throw new Error("Failed to recalculate skill mastery");
    }
    
    // Revalidate skill-related pages
    revalidatePath("/skills");
    revalidatePath("/foundations");
    revalidatePath("/dashboard");
    
    return { success: true };
  } catch (error) {
    console.error("Failed to recalculate skill mastery:", error);
    throw new Error("Failed to recalculate skill mastery");
  }
}

