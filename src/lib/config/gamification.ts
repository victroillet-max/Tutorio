/**
 * Gamification Configuration
 * 
 * Centralized constants for XP, streaks, mastery levels, and achievements.
 * Single source of truth for all gamification-related values.
 */

/**
 * XP (Experience Points) configuration
 */
export const XP_CONFIG = {
  /** Multiplier for completing activity on first attempt */
  FIRST_TRY_MULTIPLIER: 1.5,
  
  /** Minimum XP for any activity */
  MIN_ACTIVITY_XP: 5,
  
  /** Maximum XP for any single activity */
  MAX_ACTIVITY_XP: 100,
  
  /** XP thresholds for levels */
  LEVEL_THRESHOLDS: [
    0,      // Level 1
    100,    // Level 2
    300,    // Level 3
    600,    // Level 4
    1000,   // Level 5
    1500,   // Level 6
    2100,   // Level 7
    2800,   // Level 8
    3600,   // Level 9
    4500,   // Level 10
  ] as const,
} as const;

/**
 * Streak configuration
 */
export const STREAK_CONFIG = {
  /** Streak freeze duration in hours */
  FREEZE_DURATION_HOURS: 24,
  
  /** Days required for streak milestones */
  MILESTONES: [3, 7, 14, 30, 60, 100, 365] as const,
  
  /** Bonus XP multiplier per consecutive day (e.g., 1.1 = 10% bonus) */
  DAILY_BONUS_MULTIPLIER: 1.1,
  
  /** Maximum streak bonus multiplier */
  MAX_BONUS_MULTIPLIER: 2.0,
} as const;

/**
 * Skill mastery configuration
 */
export const MASTERY_CONFIG = {
  /** Mastery level thresholds (0-100 scale) */
  THRESHOLDS: {
    NOT_STARTED: 0,
    STARTED: 10,
    LEARNING: 30,
    PRACTICING: 50,
    PROFICIENT: 70,
    MASTERED: 85,
    EXPERT: 95,
  } as const,
  
  /** Minimum mastery to unlock dependent skills */
  PREREQUISITE_THRESHOLD: 70,
  
  /** Weight of activity completion in mastery calculation */
  ACTIVITY_WEIGHT: 0.6,
  
  /** Weight of quiz performance in mastery calculation */
  QUIZ_WEIGHT: 0.4,
  
  /** Decay rate for mastery (per week of inactivity) */
  DECAY_RATE_PER_WEEK: 0.05,
  
  /** Minimum mastery after decay */
  MIN_MASTERY_AFTER_DECAY: 30,
} as const;

/**
 * Quiz and assessment configuration
 */
export const QUIZ_CONFIG = {
  /** Default passing score for quizzes (percentage) */
  DEFAULT_PASSING_SCORE: 80,
  
  /** Passing score for checkpoint activities */
  CHECKPOINT_PASSING_SCORE: 70,
  
  /** Passing score for mock exams */
  MOCK_EXAM_PASSING_SCORE: 60,
  
  /** Maximum attempts before hints are shown */
  MAX_ATTEMPTS_BEFORE_HINTS: 2,
  
  /** Cooldown period between quiz attempts (minutes) */
  ATTEMPT_COOLDOWN_MINUTES: 5,
} as const;

/**
 * Activity time configuration
 */
export const TIME_CONFIG = {
  /** Minimum time (seconds) to count as activity engagement */
  MIN_ENGAGEMENT_SECONDS: 30,
  
  /** Maximum trackable time per session (seconds) */
  MAX_SESSION_SECONDS: 3600,
  
  /** Idle timeout (seconds) before pausing time tracking */
  IDLE_TIMEOUT_SECONDS: 300,
} as const;

/**
 * Badge unlock criteria types
 */
export const BADGE_CRITERIA_TYPES = {
  ACTIVITY_COUNT: "activity_count",
  ACTIVITY_TYPE_COMPLETE: "activity_type_complete",
  MODULES_COMPLETE: "modules_complete",
  STREAK: "streak",
  XP_THRESHOLD: "xp_threshold",
  MASTERY_LEVEL: "mastery_level",
  PERFECT_SCORE: "perfect_score",
} as const;

/**
 * Helper function to calculate level from XP
 */
export function calculateLevel(totalXp: number): number {
  const thresholds = XP_CONFIG.LEVEL_THRESHOLDS;
  for (let i = thresholds.length - 1; i >= 0; i--) {
    if (totalXp >= thresholds[i]) {
      return i + 1;
    }
  }
  return 1;
}

/**
 * Helper function to calculate XP needed for next level
 */
export function xpForNextLevel(totalXp: number): { current: number; required: number; progress: number } {
  const level = calculateLevel(totalXp);
  const thresholds = XP_CONFIG.LEVEL_THRESHOLDS;
  
  const currentThreshold = thresholds[level - 1] || 0;
  const nextThreshold = thresholds[level] || thresholds[thresholds.length - 1];
  
  const current = totalXp - currentThreshold;
  const required = nextThreshold - currentThreshold;
  const progress = Math.min(100, Math.round((current / required) * 100));
  
  return { current, required, progress };
}

/**
 * Helper function to get mastery level label
 */
export function getMasteryLabel(mastery: number): string {
  const { THRESHOLDS } = MASTERY_CONFIG;
  
  if (mastery >= THRESHOLDS.EXPERT) return "Expert";
  if (mastery >= THRESHOLDS.MASTERED) return "Mastered";
  if (mastery >= THRESHOLDS.PROFICIENT) return "Proficient";
  if (mastery >= THRESHOLDS.PRACTICING) return "Practicing";
  if (mastery >= THRESHOLDS.LEARNING) return "Learning";
  if (mastery >= THRESHOLDS.STARTED) return "Started";
  return "Not Started";
}

/**
 * Helper function to calculate streak bonus
 */
export function calculateStreakBonus(currentStreak: number): number {
  const bonus = Math.pow(STREAK_CONFIG.DAILY_BONUS_MULTIPLIER, currentStreak - 1);
  return Math.min(bonus, STREAK_CONFIG.MAX_BONUS_MULTIPLIER);
}

/**
 * Helper function to check if mastery meets prerequisite
 */
export function meetsPrerequisite(mastery: number): boolean {
  return mastery >= MASTERY_CONFIG.PREREQUISITE_THRESHOLD;
}

export type MasteryLevel = keyof typeof MASTERY_CONFIG.THRESHOLDS;
export type BadgeCriteriaType = (typeof BADGE_CRITERIA_TYPES)[keyof typeof BADGE_CRITERIA_TYPES];

