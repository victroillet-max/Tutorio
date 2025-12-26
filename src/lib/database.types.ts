/**
 * TypeScript types for the Tutorio database schema
 * These types correspond to the Supabase tables defined in migrations
 */

// ============================================
// Enums
// ============================================

export type UserRole = 'user' | 'admin';

export type SubscriptionStatus = 'trialing' | 'active' | 'cancelled' | 'expired' | 'past_due';

export type ContentType = 'video' | 'text' | 'quiz' | 'audio';

export type DifficultyLevel = 'beginner' | 'intermediate' | 'advanced';

export type ActivityType = 'lesson' | 'quiz' | 'code' | 'challenge' | 'interactive' | 'checkpoint' | 'mock_exam';

export type PlanTier = 'free' | 'basic' | 'advanced';

// ============================================
// Database Tables
// ============================================

export interface Profile {
  id: string;
  email: string;
  full_name: string | null;
  avatar_url: string | null;
  role: UserRole;
  created_at: string;
  updated_at: string;
}

export interface SubscriptionTier {
  id: string;
  name: string;
  slug: string;
  description: string | null;
  price_monthly: number;
  price_yearly: number | null;
  features: Record<string, unknown>;
  is_active: boolean;
  sort_order: number;
  created_at: string;
  updated_at: string;
}

export interface Subscription {
  id: string;
  user_id: string;
  tier_id: string;
  status: SubscriptionStatus;
  current_period_start: string;
  current_period_end: string;
  trial_ends_at: string | null;
  cancelled_at: string | null;
  cancel_at_period_end: boolean;
  stripe_subscription_id: string | null;
  stripe_customer_id: string | null;
  created_at: string;
  updated_at: string;
}

export interface Category {
  id: string;
  name: string;
  slug: string;
  description: string | null;
  icon: string | null;
  color: string | null;
  sort_order: number;
  created_at: string;
  updated_at: string;
}

export interface Course {
  id: string;
  category_id: string | null;
  required_tier_id: string | null;
  title: string;
  slug: string;
  description: string | null;
  short_description: string | null;
  thumbnail_url: string | null;
  difficulty: DifficultyLevel;
  duration_hours: number | null;
  is_published: boolean;
  is_featured: boolean;
  sort_order: number;
  created_at: string;
  updated_at: string;
  published_at: string | null;
}

export interface Module {
  id: string;
  course_id: string;
  external_id: string;
  order_index: number;
  title: string;
  slug: string;
  description: string | null;
  estimated_minutes: number | null;
  total_xp: number;
  required_plan: PlanTier;
  is_mock_exam: boolean;
  is_midterm_boundary: boolean;
  is_published: boolean;
  created_at: string;
  updated_at: string;
}

export interface Activity {
  id: string;
  module_id: string;
  external_id: string;
  order_index: number;
  title: string;
  slug: string;
  type: ActivityType;
  minutes: number | null;
  xp: number;
  required_plan: PlanTier;
  content: Record<string, unknown> | null;
  interactive_type: string | null;
  starter_code: string | null;
  passing_score: number;
  time_limit: number | null;
  blocks_progress: boolean;
  is_published: boolean;
  created_at: string;
  updated_at: string;
}

export interface ActivityProgress {
  id: string;
  user_id: string;
  activity_id: string;
  completed: boolean;
  score: number | null;
  xp_earned: number;
  attempts: number;
  first_try_bonus: boolean;
  completed_at: string | null;
  last_position_seconds: number;
  time_spent_seconds: number;
  last_accessed_at: string;
  created_at: string;
  updated_at: string;
}

export interface ModuleProgress {
  id: string;
  user_id: string;
  module_id: string;
  started_at: string;
  completed_at: string | null;
  total_xp_earned: number;
  checkpoint_passed: boolean;
}

export interface UserStreak {
  user_id: string;
  current_streak: number;
  longest_streak: number;
  last_activity_date: string | null;
  streak_freeze_available: boolean;
  streak_freeze_used_at: string | null;
  total_xp: number;
  created_at: string;
  updated_at: string;
}

export interface Badge {
  id: string;
  name: string;
  description: string | null;
  icon: string | null;
  required_plan: PlanTier;
  unlock_criteria: Record<string, unknown> | null;
  sort_order: number;
  created_at: string;
}

export interface UserBadge {
  user_id: string;
  badge_id: string;
  earned_at: string;
}

// Legacy types (kept for backwards compatibility)
export interface Lesson {
  id: string;
  course_id: string;
  title: string;
  slug: string;
  description: string | null;
  content_type: ContentType;
  content: Record<string, unknown> | null;
  video_url: string | null;
  audio_url: string | null;
  duration_minutes: number | null;
  is_preview: boolean;
  is_published: boolean;
  sort_order: number;
  created_at: string;
  updated_at: string;
}

export interface LessonProgress {
  id: string;
  user_id: string;
  lesson_id: string;
  completed: boolean;
  completed_at: string | null;
  last_position_seconds: number;
  time_spent_seconds: number;
  last_accessed_at: string;
  created_at: string;
  updated_at: string;
}

export interface CourseEnrollment {
  id: string;
  user_id: string;
  course_id: string;
  enrolled_at: string;
  completed_at: string | null;
}

// ============================================
// Extended Types (with relations)
// ============================================

export interface CourseWithCategory extends Course {
  category: Category | null;
}

export interface CourseWithDetails extends Course {
  category: Category | null;
  required_tier: SubscriptionTier | null;
  modules_count?: number;
}

export interface ModuleWithActivities extends Module {
  activities: Activity[];
}

export interface ModuleWithProgress extends Module {
  progress?: {
    total_activities: number;
    completed_activities: number;
    progress_percentage: number;
    total_xp_earned: number;
    checkpoint_passed: boolean;
  };
}

export interface ActivityWithProgress extends Activity {
  progress: ActivityProgress | null;
}

export interface LessonWithProgress extends Lesson {
  progress: LessonProgress | null;
}

export interface SubscriptionWithTier extends Subscription {
  tier: SubscriptionTier;
}

export interface ProfileWithSubscription extends Profile {
  subscription: SubscriptionWithTier | null;
}

export interface ProfileWithStreak extends Profile {
  streak: UserStreak | null;
}

// ============================================
// Quiz/Interactive Content Types
// ============================================

export interface QuizQuestion {
  id: string;
  type: 'mcq' | 'true_false' | 'fill_blank';
  question: string;
  options?: string[];
  correct: number | string | boolean;
  explanation?: string;
}

export interface QuizContent {
  questions: QuizQuestion[];
  passing_score: number;
  shuffle_questions?: boolean;
  shuffle_options?: boolean;
}

export interface CodeTestCase {
  input: string;
  expected_output: string;
  is_hidden?: boolean;
  description?: string;
}

export interface CodeContent {
  instructions: string;
  starter_code: string;
  solution?: string;
  test_cases: CodeTestCase[];
  hints?: string[];
}

export interface InteractiveContent {
  type: string;
  config: Record<string, unknown>;
}

// ============================================
// Function Return Types
// ============================================

export interface CourseProgress {
  total_lessons: number;
  completed_lessons: number;
  progress_percentage: number;
  last_accessed_at: string | null;
}

export interface ModuleProgressResult {
  total_activities: number;
  completed_activities: number;
  progress_percentage: number;
  total_xp_earned: number;
  checkpoint_passed: boolean;
}

export interface UserStats {
  total_courses_enrolled: number;
  total_courses_completed: number;
  total_lessons_completed: number;
  total_time_spent_seconds: number;
  current_streak_days: number;
}

// ============================================
// Insert/Update Types
// ============================================

export type ProfileInsert = Omit<Profile, 'created_at' | 'updated_at'>;
export type ProfileUpdate = Partial<Omit<Profile, 'id' | 'created_at' | 'updated_at'>>;

export type SubscriptionInsert = Omit<Subscription, 'id' | 'created_at' | 'updated_at'>;
export type SubscriptionUpdate = Partial<Omit<Subscription, 'id' | 'user_id' | 'created_at' | 'updated_at'>>;

export type CourseInsert = Omit<Course, 'id' | 'created_at' | 'updated_at'>;
export type CourseUpdate = Partial<Omit<Course, 'id' | 'created_at' | 'updated_at'>>;

export type ModuleInsert = Omit<Module, 'id' | 'created_at' | 'updated_at'>;
export type ModuleUpdate = Partial<Omit<Module, 'id' | 'course_id' | 'created_at' | 'updated_at'>>;

export type ActivityInsert = Omit<Activity, 'id' | 'created_at' | 'updated_at'>;
export type ActivityUpdate = Partial<Omit<Activity, 'id' | 'module_id' | 'created_at' | 'updated_at'>>;

export type ActivityProgressInsert = Omit<ActivityProgress, 'id' | 'created_at' | 'updated_at'>;
export type ActivityProgressUpdate = Partial<Omit<ActivityProgress, 'id' | 'user_id' | 'activity_id' | 'created_at' | 'updated_at'>>;

export type LessonInsert = Omit<Lesson, 'id' | 'created_at' | 'updated_at'>;
export type LessonUpdate = Partial<Omit<Lesson, 'id' | 'course_id' | 'created_at' | 'updated_at'>>;

export type LessonProgressInsert = Omit<LessonProgress, 'id' | 'created_at' | 'updated_at'>;
export type LessonProgressUpdate = Partial<Omit<LessonProgress, 'id' | 'user_id' | 'lesson_id' | 'created_at' | 'updated_at'>>;

// ============================================
// Supabase Database Type Definition
// ============================================

export interface Database {
  public: {
    Tables: {
      profiles: {
        Row: Profile;
        Insert: ProfileInsert;
        Update: ProfileUpdate;
      };
      subscription_tiers: {
        Row: SubscriptionTier;
        Insert: Omit<SubscriptionTier, 'id' | 'created_at' | 'updated_at'>;
        Update: Partial<Omit<SubscriptionTier, 'id' | 'created_at' | 'updated_at'>>;
      };
      subscriptions: {
        Row: Subscription;
        Insert: SubscriptionInsert;
        Update: SubscriptionUpdate;
      };
      categories: {
        Row: Category;
        Insert: Omit<Category, 'id' | 'created_at' | 'updated_at'>;
        Update: Partial<Omit<Category, 'id' | 'created_at' | 'updated_at'>>;
      };
      courses: {
        Row: Course;
        Insert: CourseInsert;
        Update: CourseUpdate;
      };
      modules: {
        Row: Module;
        Insert: ModuleInsert;
        Update: ModuleUpdate;
      };
      activities: {
        Row: Activity;
        Insert: ActivityInsert;
        Update: ActivityUpdate;
      };
      activity_progress: {
        Row: ActivityProgress;
        Insert: ActivityProgressInsert;
        Update: ActivityProgressUpdate;
      };
      module_progress: {
        Row: ModuleProgress;
        Insert: Omit<ModuleProgress, 'id'>;
        Update: Partial<Omit<ModuleProgress, 'id' | 'user_id' | 'module_id'>>;
      };
      user_streaks: {
        Row: UserStreak;
        Insert: Omit<UserStreak, 'created_at' | 'updated_at'>;
        Update: Partial<Omit<UserStreak, 'user_id' | 'created_at' | 'updated_at'>>;
      };
      badges: {
        Row: Badge;
        Insert: Omit<Badge, 'created_at'>;
        Update: Partial<Omit<Badge, 'id' | 'created_at'>>;
      };
      user_badges: {
        Row: UserBadge;
        Insert: Omit<UserBadge, 'earned_at'>;
        Update: never;
      };
      // Legacy tables
      lessons: {
        Row: Lesson;
        Insert: LessonInsert;
        Update: LessonUpdate;
      };
      lesson_progress: {
        Row: LessonProgress;
        Insert: LessonProgressInsert;
        Update: LessonProgressUpdate;
      };
      course_enrollments: {
        Row: CourseEnrollment;
        Insert: Omit<CourseEnrollment, 'id'>;
        Update: Partial<Omit<CourseEnrollment, 'id' | 'user_id' | 'course_id'>>;
      };
    };
    Enums: {
      user_role: UserRole;
      subscription_status: SubscriptionStatus;
      content_type: ContentType;
      difficulty_level: DifficultyLevel;
      activity_type: ActivityType;
      plan_tier: PlanTier;
    };
    Functions: {
      is_admin: {
        Args: Record<string, never>;
        Returns: boolean;
      };
      has_active_subscription: {
        Args: { required_tier_id?: string };
        Returns: boolean;
      };
      user_has_plan_access: {
        Args: { required: PlanTier };
        Returns: boolean;
      };
      get_course_progress: {
        Args: { p_user_id: string; p_course_id: string };
        Returns: CourseProgress[];
      };
      get_module_progress: {
        Args: { p_user_id: string; p_module_id: string };
        Returns: ModuleProgressResult[];
      };
      get_user_stats: {
        Args: { p_user_id: string };
        Returns: UserStats[];
      };
      complete_activity: {
        Args: { p_activity_id: string; p_score?: number };
        Returns: ActivityProgress;
      };
      mark_lesson_complete: {
        Args: { p_lesson_id: string };
        Returns: LessonProgress;
      };
    };
  };
}
