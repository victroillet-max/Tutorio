import { createClient } from "@/utils/supabase/server";
import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { 
  ChevronLeft,
  ChevronRight,
  Clock,
  Zap,
  Lock
} from "lucide-react";
import type { Activity, PlanTier } from "@/lib/database.types";
import { LessonViewer } from "@/components/activities/lesson-viewer";
import { QuizViewer } from "@/components/activities/quiz-viewer";
import { CodeEditor } from "@/components/activities/code-editor";
import { InteractiveViewer } from "@/components/activities/interactive-viewer";
import { CheckpointViewer } from "@/components/activities/checkpoint-viewer";

interface ActivityPageProps {
  params: Promise<{ slug: string; moduleSlug: string; activitySlug: string }>;
}

export async function generateMetadata({ params }: ActivityPageProps) {
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

export default async function ActivityPage({ params }: ActivityPageProps) {
  const { slug: courseSlug, moduleSlug, activitySlug } = await params;
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
    const tier = subscription.tier as { slug: string }[] | { slug: string };
    userPlan = (Array.isArray(tier) ? tier[0]?.slug : tier.slug) as PlanTier;
  }
  
  // Fetch activity with module and course info
  const { data: activity, error } = await supabase
    .from("activities")
    .select(`
      *,
      module:modules(
        id,
        title,
        slug,
        course:courses(id, title, slug)
      )
    `)
    .eq("slug", activitySlug)
    .eq("is_published", true)
    .single();

  if (error || !activity) {
    notFound();
  }

  const module = activity.module as { 
    id: string; 
    title: string; 
    slug: string; 
    course: { id: string; title: string; slug: string };
  };
  
  // Verify slugs match
  if (module.slug !== moduleSlug || module.course.slug !== courseSlug) {
    notFound();
  }

  // Check access (admins have full access)
  const hasAccess = isAdmin || checkAccess(activity.required_plan as PlanTier, userPlan);
  
  if (!hasAccess) {
    return (
      <div className="min-h-screen bg-[var(--background-secondary)] flex items-center justify-center p-4">
        <div className="max-w-md w-full bg-white rounded-2xl p-8 text-center shadow-lg">
          <div className="w-16 h-16 bg-amber-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <Lock className="w-8 h-8 text-amber-600" />
          </div>
          <h1 className="text-2xl font-bold text-[var(--foreground)] mb-2">
            Premium Content
          </h1>
          <p className="text-[var(--foreground-muted)] mb-6">
            This activity requires a {activity.required_plan} plan to access.
          </p>
          <div className="space-y-3">
            <Link
              href="/pricing"
              className="block w-full py-3 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-hover)] transition-colors"
            >
              Upgrade to {activity.required_plan}
            </Link>
            <Link
              href={`/courses/${courseSlug}/${moduleSlug}`}
              className="block w-full py-3 border border-[var(--border)] text-[var(--foreground)] font-medium rounded-xl hover:bg-slate-50 transition-colors"
            >
              Back to Module
            </Link>
          </div>
        </div>
      </div>
    );
  }

  // Get all activities in this module for navigation
  const { data: allActivities } = await supabase
    .from("activities")
    .select("id, slug, title, order_index")
    .eq("module_id", module.id)
    .eq("is_published", true)
    .order("order_index");

  const activities = allActivities || [];
  const currentIndex = activities.findIndex(a => a.slug === activitySlug);
  const prevActivity = currentIndex > 0 ? activities[currentIndex - 1] : null;
  const nextActivity = currentIndex < activities.length - 1 ? activities[currentIndex + 1] : null;

  // Get user's progress for this activity
  const { data: progress } = await supabase
    .from("activity_progress")
    .select("*")
    .eq("user_id", user.id)
    .eq("activity_id", activity.id)
    .single();

  return (
    <div className="min-h-screen bg-[var(--background-secondary)]">
      {/* Header */}
      <div className="sticky top-16 z-40 bg-white border-b border-[var(--border)]">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between py-3">
            {/* Back Link */}
            <Link
              href={`/courses/${courseSlug}/${moduleSlug}`}
              className="flex items-center gap-1 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors"
            >
              <ChevronLeft className="w-4 h-4" />
              <span className="hidden sm:inline">{module.title}</span>
              <span className="sm:hidden">Back</span>
            </Link>
            
            {/* Activity Info */}
            <div className="flex items-center gap-4 text-sm text-[var(--foreground-muted)]">
              <span className="font-medium text-[var(--foreground)]">
                {activity.external_id}
              </span>
              <div className="flex items-center gap-1">
                <Clock className="w-4 h-4" />
                <span>{activity.minutes}m</span>
              </div>
              <div className="flex items-center gap-1">
                <Zap className="w-4 h-4" />
                <span>{activity.xp} XP</span>
              </div>
            </div>
            
            {/* Progress Indicator */}
            <div className="text-sm text-[var(--foreground-muted)]">
              {currentIndex + 1} / {activities.length}
            </div>
          </div>
          
          {/* Progress Bar */}
          <div className="h-1 bg-slate-100 -mx-4 sm:-mx-6 lg:-mx-8">
            <div 
              className="h-full bg-[var(--primary)] transition-all duration-300"
              style={{ width: `${((currentIndex + 1) / activities.length) * 100}%` }}
            />
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <ActivityRenderer 
          activity={activity as Activity} 
          userId={user.id}
          isCompleted={progress?.completed ?? false}
        />
      </div>

      {/* Navigation Footer */}
      <div className="sticky bottom-0 bg-white/95 backdrop-blur-sm border-t border-[var(--border)] py-3">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between">
            {prevActivity ? (
              <Link
                href={`/courses/${courseSlug}/${moduleSlug}/${prevActivity.slug}`}
                className="flex items-center gap-1.5 px-3 py-2 text-sm text-[var(--foreground-muted)] hover:text-[var(--foreground)] hover:bg-slate-100 rounded-lg transition-colors"
              >
                <ChevronLeft className="w-4 h-4" />
                <span className="hidden sm:inline">Previous</span>
              </Link>
            ) : (
              <div />
            )}
            
            {/* Center progress dots */}
            <div className="hidden sm:flex items-center gap-1.5">
              {activities.slice(Math.max(0, currentIndex - 2), Math.min(activities.length, currentIndex + 3)).map((a, i) => {
                const actualIndex = Math.max(0, currentIndex - 2) + i;
                return (
                  <Link
                    key={a.id}
                    href={`/courses/${courseSlug}/${moduleSlug}/${a.slug}`}
                    className={`w-2 h-2 rounded-full transition-all ${
                      actualIndex === currentIndex 
                        ? 'bg-[var(--primary)] scale-125' 
                        : actualIndex < currentIndex
                          ? 'bg-[var(--primary)]/40'
                          : 'bg-slate-300 hover:bg-slate-400'
                    }`}
                    title={a.title}
                  />
                );
              })}
            </div>
            
            {nextActivity ? (
              <Link
                href={`/courses/${courseSlug}/${moduleSlug}/${nextActivity.slug}`}
                className="flex items-center gap-1.5 px-4 py-2 bg-[var(--primary)] text-white text-sm font-medium rounded-lg hover:bg-[var(--primary-hover)] transition-colors"
              >
                <span>Next</span>
                <ChevronRight className="w-4 h-4" />
              </Link>
            ) : (
              <Link
                href={`/courses/${courseSlug}/${moduleSlug}`}
                className="flex items-center gap-1.5 px-4 py-2 bg-emerald-600 text-white text-sm font-medium rounded-lg hover:bg-emerald-700 transition-colors"
              >
                <span>Complete</span>
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

interface ActivityRendererProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
}

function ActivityRenderer({ activity, userId, isCompleted }: ActivityRendererProps) {
  switch (activity.type) {
    case 'lesson':
      return (
        <LessonViewer 
          activity={activity} 
          userId={userId}
          isCompleted={isCompleted}
        />
      );
    
    case 'quiz':
      return (
        <QuizViewer 
          activity={activity} 
          userId={userId}
          isCompleted={isCompleted}
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

