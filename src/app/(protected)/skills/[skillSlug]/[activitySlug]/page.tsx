import { createClient } from "@/utils/supabase/server";
import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { 
  ChevronLeft,
  ChevronRight,
  Clock,
  Zap,
  Lock,
  Check,
  Sparkles,
  Crown,
  BookOpen,
  MessageCircle,
  ArrowRight
} from "lucide-react";
import type { Activity, PlanTier } from "@/lib/database.types";
import { LessonViewer } from "@/components/activities/lesson-viewer";
import { QuizViewer } from "@/components/activities/quiz-viewer";
import { CodeEditor } from "@/components/activities/code-editor";
import { InteractiveViewer } from "@/components/activities/interactive-viewer";
import { CheckpointViewer } from "@/components/activities/checkpoint-viewer";
import { ActivityPrerequisiteWarning } from "@/components/activities/prerequisite-warning";
import { ActivityChatContext } from "@/components/activities/activity-chat-context";
import { KeyboardNavigation, KeyboardShortcutsHint } from "@/components/activities/keyboard-navigation";

interface SkillActivityPageProps {
  params: Promise<{ skillSlug: string; activitySlug: string }>;
}

export async function generateMetadata({ params }: SkillActivityPageProps) {
  const { activitySlug } = await params;
  const supabase = await createClient();
  
  const { data: activity } = await supabase
    .from("activities")
    .select("title")
    .eq("slug", activitySlug)
    .single();

  return {
    title: activity ? `${activity.title} | Tutorio` : "Activity | Tutorio",
  };
}

export default async function SkillActivityPage({ params }: SkillActivityPageProps) {
  const { skillSlug, activitySlug } = await params;
  const supabase = await createClient();
  
  // Get current user
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    redirect("/login");
  }
  
  // Get user's profile (for admin check) and subscription tier
  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .single();
  
  const isAdmin = profile?.role === 'admin';
  
  let userPlan: PlanTier = 'free';
  const { data: subscription } = await supabase
    .from("subscriptions")
    .select("tier:subscription_tiers(slug)")
    .eq("user_id", user.id)
    .in("status", ["active", "trialing"])
    .single();
  
  if (subscription?.tier) {
    const tier = subscription.tier as unknown as { slug: string }[] | { slug: string };
    userPlan = (Array.isArray(tier) ? tier[0]?.slug : tier.slug) as PlanTier;
  }
  
  // Get the skill
  const { data: skill, error: skillError } = await supabase
    .from("skills")
    .select("*")
    .eq("slug", skillSlug)
    .eq("is_active", true)
    .single();

  if (skillError || !skill) {
    notFound();
  }

  // Get the activity that belongs to this skill
  // We query through activity_skills to handle duplicate slugs across courses
  const { data: activitySkillData, error: activitySkillError } = await supabase
    .from("activity_skills")
    .select(`
      *,
      activities!inner (*)
    `)
    .eq("skill_id", skill.id)
    .eq("is_owner", true)
    .eq("activities.slug", activitySlug)
    .eq("activities.is_published", true)
    .single();

  if (activitySkillError || !activitySkillData) {
    notFound();
  }

  const activity = activitySkillData.activities as Activity;
  const activitySkill = activitySkillData;

  // Check access (admins have full access)
  const hasAccess = isAdmin || checkAccess(activity.required_plan as PlanTier, userPlan);
  
  if (!hasAccess) {
    // Get course info for the paywall
    const { data: courseData } = await supabase
      .from("skills")
      .select("course:courses(id, slug, title)")
      .eq("id", skill.id)
      .single();
    
    const courseRaw = courseData?.course as unknown;
    const course = (Array.isArray(courseRaw) ? courseRaw[0] : courseRaw) as { id: string; slug: string; title: string } | null;
    
    // Count total and locked activities for this course
    let totalActivities = 0;
    let lockedActivities = 0;
    
    if (course?.id) {
      const { count: total } = await supabase
        .from("activities")
        .select("id", { count: "exact", head: true })
        .eq("is_published", true);
      
      const { count: locked } = await supabase
        .from("activities")
        .select("id", { count: "exact", head: true })
        .eq("is_published", true)
        .neq("required_plan", "free");
      
      totalActivities = total || 0;
      lockedActivities = locked || 0;
    }

    const isAdvancedRequired = activity.required_plan === 'advanced';
    const Icon = isAdvancedRequired ? Crown : Zap;
    const planPrice = isAdvancedRequired ? 15 : 8;
    const planName = isAdvancedRequired ? "Advanced" : "Basic";

    const features = isAdvancedRequired ? [
      { icon: BookOpen, text: "Full course access" },
      { icon: Sparkles, text: "All activities & challenges" },
      { icon: MessageCircle, text: "Unlimited AI tutor" },
      { icon: Check, text: "Priority support" },
    ] : [
      { icon: BookOpen, text: "Full course access" },
      { icon: Sparkles, text: "All activities & challenges" },
      { icon: MessageCircle, text: "AI tutor (25 messages/day)" },
      { icon: Check, text: "Progress tracking" },
    ];

    return (
      <div className="min-h-screen bg-[var(--background-secondary)] flex items-center justify-center p-4">
        <div className="max-w-lg w-full overflow-hidden">
          {/* Header with gradient */}
          <div className="bg-gradient-to-br from-[var(--accent)] to-[var(--accent-dark)] rounded-t-2xl px-8 py-8 text-white text-center">
            <div className="w-16 h-16 mx-auto mb-4 rounded-2xl bg-white/20 backdrop-blur-sm flex items-center justify-center">
              <Icon className="w-8 h-8" />
            </div>
            <h1 
              className="text-2xl font-bold mb-2"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Unlock This Activity
            </h1>
            <p className="text-white/80">
              {course?.title ? `Continue your ${course.title} journey` : "Subscribe to access premium content"}
            </p>
          </div>
          
          {/* Content */}
          <div className="bg-white rounded-b-2xl p-8 shadow-lg">
            {/* Activity preview */}
            <div className="flex items-center gap-3 p-4 bg-slate-50 rounded-xl mb-6">
              <Lock className="w-5 h-5 text-slate-400" />
              <div>
                <p className="font-medium text-[var(--foreground)]">{activity.title}</p>
                <p className="text-sm text-[var(--foreground-muted)]">
                  Requires {planName} plan
                </p>
              </div>
            </div>

            {/* Stats */}
            {lockedActivities > 0 && (
              <div className="flex items-center justify-center gap-6 mb-6 py-3 border-y border-[var(--border)]">
                <div className="text-center">
                  <p className="text-2xl font-bold text-[var(--accent)]">{lockedActivities}+</p>
                  <p className="text-xs text-[var(--foreground-muted)]">Activities to unlock</p>
                </div>
                <div className="w-px h-10 bg-[var(--border)]" />
                <div className="text-center">
                  <p className="text-2xl font-bold text-[var(--accent)]">24/7</p>
                  <p className="text-xs text-[var(--foreground-muted)]">AI tutor access</p>
                </div>
              </div>
            )}
            
            {/* Features */}
            <div className="mb-6">
              <p className="text-sm font-medium text-[var(--foreground-muted)] mb-3">
                What you&apos;ll get with {planName}:
              </p>
              <ul className="space-y-2.5">
                {features.map(({ icon: FeatureIcon, text }) => (
                  <li key={text} className="flex items-center gap-2.5 text-sm">
                    <div className="w-5 h-5 rounded-full bg-emerald-100 flex items-center justify-center flex-shrink-0">
                      <FeatureIcon className="w-3 h-3 text-emerald-600" />
                    </div>
                    <span className="text-[var(--foreground)]">{text}</span>
                  </li>
                ))}
              </ul>
            </div>
            
            {/* Pricing */}
            <div className="text-center mb-6">
              <span className="text-3xl font-bold text-[var(--foreground)]">CHF {planPrice}</span>
              <span className="text-[var(--foreground-muted)]">/month</span>
              <p className="text-xs text-[var(--foreground-muted)] mt-1">Cancel anytime</p>
            </div>
            
            {/* CTAs */}
            <div className="space-y-3">
              <Link
                href={course?.slug ? `/pricing?course=${course.slug}` : "/pricing"}
                className="flex items-center justify-center gap-2 w-full py-3.5 bg-[var(--accent)] text-white font-semibold rounded-xl hover:bg-[var(--accent-dark)] transition-colors"
              >
                Subscribe to {planName}
                <ArrowRight className="w-4 h-4" />
              </Link>
              <Link
                href={course?.slug ? `/pricing?course=${course.slug}` : "/pricing"}
                className="block w-full py-3 text-center text-[var(--foreground-muted)] font-medium hover:text-[var(--foreground)] transition-colors"
              >
                View all plans
              </Link>
              <Link
                href={`/skills/${skillSlug}`}
                className="block w-full py-2 text-center text-sm text-[var(--foreground-muted)] hover:underline transition-colors"
              >
                Back to skill
              </Link>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Get all activities for this skill in order
  const { data: skillActivitiesData } = await supabase
    .rpc("get_skill_activities", {
      p_skill_id: skill.id,
      p_user_id: user.id
    });

  const activities = skillActivitiesData || [];
  const currentIndex = activities.findIndex((a: { activity_slug: string }) => a.activity_slug === activitySlug);
  const prevActivity = currentIndex > 0 ? activities[currentIndex - 1] : null;
  const nextActivity = currentIndex < activities.length - 1 ? activities[currentIndex + 1] : null;

  // Get user's progress for this activity
  const { data: progress } = await supabase
    .from("activity_progress")
    .select("*")
    .eq("user_id", user.id)
    .eq("activity_id", activity.id)
    .single();

  // Determine back link and color based on category
  const isFoundation = skill.category === 'ct_foundations';
  
  const categoryColors: Record<string, string> = {
    ct_foundations: 'bg-amber-500',
    python_basics: 'bg-blue-500',
    control_flow: 'bg-violet-500',
    data_structures: 'bg-emerald-500',
    functions: 'bg-rose-500',
    advanced_topics: 'bg-cyan-500',
  };

  const primaryColor = categoryColors[skill.category] || 'bg-blue-500';
  
  // Check if this is a spreadsheet/wide layout activity
  const isWideLayout = activity.type === 'interactive' && 
    ['google-sheets', 'spreadsheet', 'cfs-builder', 'statement-builder'].includes(activity.interactive_type || '');
  
  // Use much wider max-width for spreadsheet exercises (7xl = 80rem = 1280px)
  const containerClass = isWideLayout ? 'max-w-7xl' : 'max-w-4xl';

  // Get demo info for upgrade prompts (only for free users)
  let demoInfo = undefined;
  if (userPlan === 'free' && activity.required_plan === 'free') {
    // Get course info
    const { data: courseData } = await supabase
      .from("skills")
      .select("course:courses(id, slug, title)")
      .eq("id", skill.id)
      .single();
    
    const courseRaw2 = courseData?.course as unknown;
    const course = (Array.isArray(courseRaw2) ? courseRaw2[0] : courseRaw2) as { id: string; slug: string; title: string } | null;
    
    if (course) {
      // Count demo (free) activities completed by user in this course
      const { count: demoActivitiesRemaining } = await supabase
        .from("activities")
        .select("id", { count: "exact", head: true })
        .eq("required_plan", "free")
        .eq("is_published", true)
        .not("id", "in", `(SELECT activity_id FROM activity_progress WHERE user_id = '${user.id}' AND completed = true)`);
      
      // Count locked activities
      const { count: lockedCount } = await supabase
        .from("activities")
        .select("id", { count: "exact", head: true })
        .eq("is_published", true)
        .neq("required_plan", "free");
      
      demoInfo = {
        isDemoActivity: true,
        demoActivitiesRemaining: demoActivitiesRemaining || 0,
        totalLockedActivities: lockedCount || 0,
        courseSlug: course.slug,
        courseName: course.title,
      };
    }
  }

  return (
    <div className="min-h-screen bg-[var(--background-secondary)]">
      {/* Set activity context for AI tutor */}
      <ActivityChatContext activityId={activity.id} skillId={skill.id} />
      
      {/* Keyboard navigation (Left/Right arrows, Esc) */}
      <KeyboardNavigation
        prevUrl={prevActivity ? `/skills/${skillSlug}/${prevActivity.activity_slug}` : undefined}
        nextUrl={nextActivity ? `/skills/${skillSlug}/${nextActivity.activity_slug}` : undefined}
        skillUrl={`/skills/${skillSlug}`}
      />
      
      {/* Header */}
      <div className="sticky top-16 z-40 bg-white border-b border-[var(--border)]">
        <div className={`${containerClass} mx-auto px-4 sm:px-6 lg:px-8`}>
          <div className="flex items-center justify-between py-3">
            {/* Back Link */}
            <Link
              href={`/skills/${skillSlug}`}
              className="flex items-center gap-1 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors"
            >
              <ChevronLeft className="w-4 h-4" />
              <span className="hidden sm:inline">{skill.name}</span>
              <span className="sm:hidden">Back</span>
            </Link>
            
            {/* Activity Info */}
            <div className="flex items-center gap-4 text-sm text-[var(--foreground-muted)]">
              <span className="font-medium text-[var(--foreground)] truncate max-w-[150px]">
                {activity.title}
              </span>
              {activity.minutes && (
                <div className="hidden sm:flex items-center gap-1">
                  <Clock className="w-4 h-4" />
                  <span>{activity.minutes}m</span>
                </div>
              )}
              {activity.xp && (
                <div className="hidden sm:flex items-center gap-1">
                  <Zap className="w-4 h-4" />
                  <span>{activity.xp} XP</span>
                </div>
              )}
            </div>
            
            {/* Progress Indicator */}
            <div className="text-sm text-[var(--foreground-muted)]">
              {currentIndex + 1} / {activities.length}
            </div>
          </div>
          
          {/* Progress Bar */}
          <div className="h-1 bg-slate-100 -mx-4 sm:-mx-6 lg:-mx-8">
            <div 
              className={`h-full ${primaryColor} transition-all duration-300`}
              style={{ width: `${((currentIndex + 1) / activities.length) * 100}%` }}
            />
          </div>
        </div>
      </div>

      {/* Content */}
      <div className={`${containerClass} mx-auto px-4 sm:px-6 lg:px-8 py-8`}>
        {/* Prerequisite Warning - shows only for code/quiz activities with unmet prerequisites */}
        {(activity.type === 'code' || activity.type === 'quiz' || activity.type === 'challenge') && (
          <ActivityPrerequisiteWarning activityId={activity.id} />
        )}
        
        <ActivityRenderer 
          activity={activity as Activity} 
          userId={user.id}
          isCompleted={progress?.completed ?? false}
          nextActivity={nextActivity ? {
            slug: nextActivity.activity_slug,
            title: nextActivity.activity_title,
            skillSlug: skillSlug
          } : undefined}
          demoInfo={demoInfo}
        />
      </div>

      {/* Navigation Footer */}
      <div className="sticky bottom-0 bg-white/95 backdrop-blur-sm border-t border-[var(--border)] py-3">
        <div className={`${containerClass} mx-auto px-4 sm:px-6 lg:px-8`}>
          <div className="flex items-center justify-between">
            {prevActivity ? (
              <Link
                href={`/skills/${skillSlug}/${prevActivity.activity_slug}`}
                className="flex items-center gap-1.5 px-3 py-2 text-sm text-[var(--foreground-muted)] hover:text-[var(--foreground)] hover:bg-slate-100 rounded-lg transition-colors"
              >
                <ChevronLeft className="w-4 h-4" />
                <span className="hidden sm:inline">Previous</span>
              </Link>
            ) : (
              <div />
            )}
            
            {/* Center progress dots + keyboard hints */}
            <div className="hidden sm:flex items-center gap-4">
              {/* Keyboard shortcuts hint */}
              <KeyboardShortcutsHint hasPrev={!!prevActivity} hasNext={!!nextActivity} />
              
              <div className="flex items-center gap-1.5">
              {activities.slice(Math.max(0, currentIndex - 2), Math.min(activities.length, currentIndex + 3)).map((a: { activity_id: string; activity_slug: string; activity_title: string }, i: number) => {
                const actualIndex = Math.max(0, currentIndex - 2) + i;
                return (
                  <Link
                    key={a.activity_id}
                    href={`/skills/${skillSlug}/${a.activity_slug}`}
                    className={`w-2 h-2 rounded-full transition-all ${
                      actualIndex === currentIndex 
                        ? `${primaryColor} scale-125` 
                        : actualIndex < currentIndex
                          ? `${primaryColor}/40`
                          : 'bg-slate-300 hover:bg-slate-400'
                    }`}
                    title={a.activity_title}
                  />
                );
              })}
              </div>
            </div>
            
            {nextActivity ? (
              <Link
                href={`/skills/${skillSlug}/${nextActivity.activity_slug}`}
                className={`flex items-center gap-1.5 px-4 py-2 ${primaryColor} text-white text-sm font-medium rounded-lg hover:opacity-90 transition-colors`}
              >
                <span>Next</span>
                <ChevronRight className="w-4 h-4" />
              </Link>
            ) : (
              <Link
                href={`/skills/${skillSlug}`}
                className="flex items-center gap-1.5 px-4 py-2 bg-emerald-600 text-white text-sm font-medium rounded-lg hover:bg-emerald-700 transition-colors"
              >
                <span>Complete Skill</span>
                <ChevronRight className="w-4 h-4" />
              </Link>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

function checkAccess(required: PlanTier, userPlan: PlanTier): boolean {
  const tierOrder: Record<PlanTier, number> = { free: 0, basic: 1, advanced: 2 };
  return tierOrder[userPlan] >= tierOrder[required];
}

interface NextActivityInfo {
  slug: string;
  title: string;
  skillSlug: string;
}

interface DemoInfo {
  isDemoActivity: boolean;
  demoActivitiesRemaining: number;
  totalLockedActivities: number;
  courseSlug: string;
  courseName: string;
}

interface ActivityRendererProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
  nextActivity?: NextActivityInfo;
  demoInfo?: DemoInfo;
}

function ActivityRenderer({ activity, userId, isCompleted, nextActivity, demoInfo }: ActivityRendererProps) {
  switch (activity.type) {
    case 'lesson':
      return (
        <LessonViewer 
          activity={activity} 
          userId={userId}
          isCompleted={isCompleted}
          nextActivity={nextActivity}
          demoInfo={demoInfo}
        />
      );
    
    case 'quiz':
      return (
        <QuizViewer 
          activity={activity} 
          userId={userId}
          isCompleted={isCompleted}
          nextActivity={nextActivity}
        />
      );
    
    case 'code':
    case 'challenge':
      return (
        <CodeEditor 
          activity={activity} 
          userId={userId}
          isCompleted={isCompleted}
        />
      );
    
    case 'interactive':
      return (
        <InteractiveViewer 
          activity={activity} 
          userId={userId}
          isCompleted={isCompleted}
        />
      );
    
    case 'checkpoint':
    case 'mock_exam':
      return (
        <CheckpointViewer 
          activity={activity} 
          userId={userId}
          isCompleted={isCompleted}
        />
      );
    
    default:
      return (
        <div className="bg-white rounded-xl p-8 text-center">
          <p className="text-[var(--foreground-muted)]">
            Activity type not yet implemented: {activity.type}
          </p>
        </div>
      );
  }
}

