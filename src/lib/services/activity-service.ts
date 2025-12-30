/**
 * Activity Service
 * 
 * Business logic for activity-related operations.
 * Separates concerns from server actions and provides testable units.
 */

import { SupabaseClient } from "@supabase/supabase-js";
import { XP_CONFIG, MASTERY_CONFIG } from "@/lib/config";
import { logger } from "@/lib/logging";
import { NotFoundError, DatabaseError } from "@/lib/errors";
import { Result, ok, err } from "@/lib/types/result";

/**
 * Activity with module and course information
 */
interface ActivityWithContext {
  id: string;
  xp: number | null;
  module: {
    slug: string;
    course: {
      slug: string;
    };
  } | null;
}

/**
 * Existing progress record
 */
interface ExistingProgress {
  id: string;
  completed: boolean;
  xp_earned: number;
  attempts: number;
  score: number | null;
  completed_at: string | null;
  time_spent_seconds: number;
}

/**
 * Result of completing an activity
 */
export interface ActivityCompletionResult {
  success: boolean;
  xpEarned: number;
  isFirstCompletion: boolean;
  firstTryBonus: boolean;
  attempts: number;
  activity: ActivityWithContext;
}

/**
 * Badge unlock criteria
 */
interface BadgeCriteria {
  type: string;
  count?: number;
  activityType?: string;
  all?: boolean;
  modules?: string[];
  days?: number;
}

/**
 * Activity Service Class
 */
export class ActivityService {
  private log = logger.child({ service: "ActivityService" });

  constructor(
    private supabase: SupabaseClient,
    private userId: string
  ) {}

  /**
   * Get activity by ID with context
   */
  async getActivity(activityId: string): Promise<ActivityWithContext> {
    const { data, error } = await this.supabase
      .from("activities")
      .select("id, xp, module:modules(slug, course:courses(slug))")
      .eq("id", activityId)
      .single();

    if (error || !data) {
      this.log.error("Activity not found", error, { activityId });
      throw new NotFoundError("Activity", activityId);
    }

    // Handle the nested data structure
    const moduleData = data.module as unknown as { slug: string; course: { slug: string } }[] | { slug: string; course: { slug: string } } | null;
    const module = Array.isArray(moduleData) ? moduleData[0] : moduleData;

    return {
      id: data.id,
      xp: data.xp,
      module: module || null,
    };
  }

  /**
   * Get existing progress for an activity
   */
  async getProgress(activityId: string): Promise<ExistingProgress | null> {
    const { data, error } = await this.supabase
      .from("activity_progress")
      .select("id, completed, xp_earned, attempts, score, completed_at, time_spent_seconds")
      .eq("user_id", this.userId)
      .eq("activity_id", activityId)
      .single();

    if (error && error.code !== "PGRST116") {
      this.log.error("Failed to fetch progress", error, { activityId });
      throw new DatabaseError("fetch progress", error);
    }

    return data as ExistingProgress | null;
  }

  /**
   * Calculate XP and bonus for activity completion
   */
  calculateXpAndBonus(
    activity: ActivityWithContext,
    existingProgress: ExistingProgress | null,
    score?: number
  ): { xpEarned: number; firstTryBonus: boolean; attempts: number; isFirstCompletion: boolean } {
    const isFirstCompletion = !existingProgress?.completed;
    const attempts = (existingProgress?.attempts || 0) + 1;

    let xpEarned = activity.xp || 0;
    const firstTryBonus = isFirstCompletion && attempts === 1;

    if (firstTryBonus) {
      xpEarned = Math.round(xpEarned * XP_CONFIG.FIRST_TRY_MULTIPLIER);
    }

    // Only award XP on first completion
    if (!isFirstCompletion) {
      xpEarned = 0;
    }

    return { xpEarned, firstTryBonus, attempts, isFirstCompletion };
  }

  /**
   * Save activity progress
   */
  async saveProgress(
    activityId: string,
    data: {
      completed: boolean;
      score: number | null;
      xpEarned: number;
      attempts: number;
      firstTryBonus: boolean;
      isFirstCompletion: boolean;
      completedAt: string | null;
    }
  ): Promise<Result<void>> {
    const { error } = await this.supabase
      .from("activity_progress")
      .upsert({
        user_id: this.userId,
        activity_id: activityId,
        completed: data.completed,
        score: data.score,
        xp_earned: data.isFirstCompletion ? data.xpEarned : 0,
        attempts: data.attempts,
        first_try_bonus: data.firstTryBonus,
        completed_at: data.isFirstCompletion ? new Date().toISOString() : data.completedAt,
        last_accessed_at: new Date().toISOString(),
      }, {
        onConflict: "user_id,activity_id",
      });

    if (error) {
      this.log.error("Failed to save progress", error, { activityId });
      return err(new DatabaseError("save progress", error));
    }

    return ok(undefined);
  }

  /**
   * Update partial progress (position, time spent)
   */
  async updatePartialProgress(
    activityId: string,
    data: {
      lastPositionSeconds?: number;
      timeSpentSeconds?: number;
    }
  ): Promise<Result<void>> {
    // Fetch existing to accumulate time
    const existing = await this.getProgress(activityId);
    const existingTimeSpent = existing?.time_spent_seconds || 0;
    const newTimeSpent = data.timeSpentSeconds 
      ? existingTimeSpent + data.timeSpentSeconds 
      : existingTimeSpent;

    const { error } = await this.supabase
      .from("activity_progress")
      .upsert({
        user_id: this.userId,
        activity_id: activityId,
        last_position_seconds: data.lastPositionSeconds,
        time_spent_seconds: newTimeSpent,
        last_accessed_at: new Date().toISOString(),
      }, {
        onConflict: "user_id,activity_id",
      });

    if (error) {
      this.log.error("Failed to update progress", error, { activityId });
      return err(new DatabaseError("update progress", error));
    }

    return ok(undefined);
  }

  /**
   * Update user streaks after activity completion
   */
  async updateStreaks(xpEarned: number): Promise<void> {
    const now = new Date();
    const today = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;

    const { data: streak } = await this.supabase
      .from("user_streaks")
      .select("*")
      .eq("user_id", this.userId)
      .single();

    if (streak) {
      const yesterday = new Date();
      yesterday.setDate(yesterday.getDate() - 1);
      const yesterdayStr = `${yesterday.getFullYear()}-${String(yesterday.getMonth() + 1).padStart(2, '0')}-${String(yesterday.getDate()).padStart(2, '0')}`;

      const lastActivityDate = streak.last_activity_date 
        ? streak.last_activity_date.split('T')[0] 
        : null;

      let newStreak = 1;
      if (lastActivityDate === today) {
        newStreak = streak.current_streak || 1;
      } else if (lastActivityDate === yesterdayStr) {
        newStreak = (streak.current_streak || 0) + 1;
      }

      await this.supabase
        .from("user_streaks")
        .update({
          total_xp: (streak.total_xp || 0) + xpEarned,
          last_activity_date: today,
          current_streak: newStreak,
          longest_streak: Math.max(streak.longest_streak || 0, newStreak),
        })
        .eq("user_id", this.userId);

      this.log.info("Streak updated", { 
        userId: this.userId, 
        newStreak, 
        xpEarned,
        totalXp: (streak.total_xp || 0) + xpEarned 
      });
    } else {
      await this.supabase
        .from("user_streaks")
        .insert({
          user_id: this.userId,
          total_xp: xpEarned,
          last_activity_date: today,
          current_streak: 1,
          longest_streak: 1,
        });

      this.log.info("Streak created", { userId: this.userId, xpEarned });
    }
  }

  /**
   * Check and award badges based on progress
   */
  async checkAndAwardBadges(): Promise<string[]> {
    const [{ data: allBadges }, { data: userBadges }, { data: progress }] = await Promise.all([
      this.supabase.from("badges").select("*"),
      this.supabase.from("user_badges").select("badge_id").eq("user_id", this.userId),
      this.supabase.from("activity_progress")
        .select("*, activity:activities(type, module:modules(external_id))")
        .eq("user_id", this.userId)
        .eq("completed", true),
    ]);

    if (!allBadges || !progress) return [];

    const earnedBadgeIds = new Set(userBadges?.map(b => b.badge_id) || []);
    const newBadges: string[] = [];

    for (const badge of allBadges) {
      if (earnedBadgeIds.has(badge.id)) continue;

      const criteria = badge.unlock_criteria as BadgeCriteria | null;
      if (!criteria) continue;

      let earned = false;

      switch (criteria.type) {
        case 'activity_count':
          earned = progress.length >= (criteria.count || 0);
          break;

        case 'activity_type_complete':
          const typeCount = progress.filter(p => {
            const activity = p.activity as unknown as { type: string }[] | { type: string };
            const type = Array.isArray(activity) ? activity[0]?.type : activity?.type;
            return type === criteria.activityType;
          }).length;
          earned = criteria.all 
            ? typeCount > 0
            : typeCount >= (criteria.count || 0);
          break;

        case 'modules_complete':
          const requiredModules = criteria.modules || [];
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
          const { data: streak } = await this.supabase
            .from("user_streaks")
            .select("current_streak, longest_streak")
            .eq("user_id", this.userId)
            .single();
          earned = (streak?.longest_streak || 0) >= (criteria.days || 0);
          break;
      }

      if (earned) {
        newBadges.push(badge.id);
      }
    }

    if (newBadges.length > 0) {
      await this.supabase
        .from("user_badges")
        .insert(newBadges.map(badgeId => ({
          user_id: this.userId,
          badge_id: badgeId,
        })));

      this.log.info("Badges awarded", { userId: this.userId, badges: newBadges });
    }

    return newBadges;
  }

  /**
   * Update skill mastery for skills associated with an activity
   */
  async updateSkillMastery(activityId: string): Promise<void> {
    const { data: activitySkills } = await this.supabase
      .from("activity_skills")
      .select("skill_id, weight, teaches")
      .eq("activity_id", activityId);

    if (!activitySkills || activitySkills.length === 0) return;

    for (const activitySkill of activitySkills) {
      try {
        await this.supabase.rpc("calculate_skill_mastery", {
          p_user_id: this.userId,
          p_skill_id: activitySkill.skill_id,
        });
      } catch (error) {
        this.log.error("Failed to update skill mastery", error, { 
          skillId: activitySkill.skill_id 
        });
      }
    }
  }

  /**
   * Complete an activity (main orchestration method)
   */
  async completeActivity(
    activityId: string,
    score?: number
  ): Promise<Result<ActivityCompletionResult>> {
    try {
      // Get activity and existing progress
      const activity = await this.getActivity(activityId);
      const existingProgress = await this.getProgress(activityId);

      // Calculate XP and bonus
      const { xpEarned, firstTryBonus, attempts, isFirstCompletion } = 
        this.calculateXpAndBonus(activity, existingProgress, score);

      // Save progress
      const saveResult = await this.saveProgress(activityId, {
        completed: true,
        score: score ?? existingProgress?.score ?? null,
        xpEarned,
        attempts,
        firstTryBonus,
        isFirstCompletion,
        completedAt: existingProgress?.completed_at || null,
      });

      if (!saveResult.success) {
        return saveResult as Result<ActivityCompletionResult>;
      }

      // Update streaks and check badges only on first completion
      if (isFirstCompletion && xpEarned > 0) {
        await this.updateStreaks(xpEarned);
        await this.checkAndAwardBadges();
        await this.updateSkillMastery(activityId);
      }

      this.log.info("Activity completed", {
        userId: this.userId,
        activityId,
        xpEarned,
        isFirstCompletion,
        attempts,
      });

      return ok({
        success: true,
        xpEarned: isFirstCompletion ? xpEarned : 0,
        isFirstCompletion,
        firstTryBonus,
        attempts,
        activity,
      });
    } catch (error) {
      this.log.error("Failed to complete activity", error, { activityId });
      return err(error instanceof Error ? error : new Error(String(error)));
    }
  }

  /**
   * Track activity view (for continue learning)
   */
  async trackActivityView(activityId: string): Promise<Result<void>> {
    const existing = await this.getProgress(activityId);

    if (!existing) {
      const { error } = await this.supabase
        .from("activity_progress")
        .insert({
          user_id: this.userId,
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
        this.log.warn("Failed to track activity view", { activityId, error });
        // Don't fail - this is non-critical
      }
    } else {
      await this.supabase
        .from("activity_progress")
        .update({ last_accessed_at: new Date().toISOString() })
        .eq("user_id", this.userId)
        .eq("activity_id", activityId);
    }

    return ok(undefined);
  }
}

/**
 * Factory function to create ActivityService
 */
export function createActivityService(
  supabase: SupabaseClient,
  userId: string
): ActivityService {
  return new ActivityService(supabase, userId);
}

