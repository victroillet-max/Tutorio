import { createClient } from "@/utils/supabase/server";
import { notFound } from "next/navigation";
import Link from "next/link";
import { 
  ChevronRight,
  Clock,
  Zap,
  Lock,
  CheckCircle2,
  BookOpen,
  HelpCircle,
  Code,
  Sword,
  Sparkles,
  Flag
} from "lucide-react";
import type { Activity, ActivityType, PlanTier } from "@/lib/database.types";

interface ModulePageProps {
  params: Promise<{ slug: string; moduleSlug: string }>;
}

export async function generateMetadata({ params }: ModulePageProps) {
  const { moduleSlug } = await params;
  const supabase = await createClient();
  
  const { data: module } = await supabase
    .from("modules")
    .select("title")
    .eq("slug", moduleSlug)
    .single();

  return {
    title: module ? `${module.title} | Tutorio` : "Module | Tutorio",
  };
}

const activityIcons: Record<ActivityType, React.ComponentType<{ className?: string }>> = {
  lesson: BookOpen,
  quiz: HelpCircle,
  code: Code,
  challenge: Sword,
  interactive: Sparkles,
  checkpoint: Flag,
  mock_exam: Flag,
};

const activityLabels: Record<ActivityType, string> = {
  lesson: "Lesson",
  quiz: "Quiz",
  code: "Code Exercise",
  challenge: "Challenge",
  interactive: "Interactive",
  checkpoint: "Checkpoint",
  mock_exam: "Mock Exam",
};

export default async function ModulePage({ params }: ModulePageProps) {
  const { slug: courseSlug, moduleSlug } = await params;
  const supabase = await createClient();
  
  // Get current user and their subscription
  const { data: { user } } = await supabase.auth.getUser();
  
  // Get user's profile (for admin check) and subscription tier
  let isAdmin = false;
  let userPlan: PlanTier = 'free';
  
  if (user) {
    const { data: profile } = await supabase
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();
    
    isAdmin = profile?.role === 'admin';
    
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
  }
  
  // Fetch module with course and activities
  const { data: module, error } = await supabase
    .from("modules")
    .select(`
      *,
      course:courses(id, title, slug),
      activities(*)
    `)
    .eq("slug", moduleSlug)
    .eq("is_published", true)
    .single();

  if (error || !module) {
    notFound();
  }

  // Verify course slug matches
  const courseData = module.course as { id: string; title: string; slug: string }[] | { id: string; title: string; slug: string };
  const course = Array.isArray(courseData) ? courseData[0] : courseData;
  if (!course || course.slug !== courseSlug) {
    notFound();
  }

  // Check if module is accessible (admins have full access)
  const moduleAccessible = isAdmin || hasAccess(module.required_plan as PlanTier, userPlan);

  // Sort activities by order_index
  const activities = ((module.activities as Activity[]) || []).sort(
    (a, b) => a.order_index - b.order_index
  );

  // Get user progress for activities
  let activityProgress: Record<string, { completed: boolean; score?: number }> = {};
  if (user) {
    const { data: progress } = await supabase
      .from("activity_progress")
      .select("activity_id, completed, score")
      .eq("user_id", user.id)
      .in("activity_id", activities.map(a => a.id));

    if (progress) {
      progress.forEach((p) => {
        activityProgress[p.activity_id] = { 
          completed: p.completed, 
          score: p.score ?? undefined 
        };
      });
    }
  }

  // Find first incomplete activity for "Continue" button
  const firstIncomplete = activities.find(a => {
    const progress = activityProgress[a.id];
    return !progress?.completed && (isAdmin || hasAccess(a.required_plan as PlanTier, userPlan));
  });

  // Calculate progress stats
  const completedCount = activities.filter(a => activityProgress[a.id]?.completed).length;
  const progressPercent = activities.length > 0 
    ? Math.round((completedCount / activities.length) * 100) 
    : 0;

  return (
    <div className="min-h-screen bg-[var(--background-secondary)]">
      {/* Header */}
      <div className="bg-white border-b border-[var(--border)]">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          {/* Breadcrumb */}
          <nav className="flex items-center gap-2 text-sm text-[var(--foreground-muted)] mb-4">
            <Link href="/courses" className="hover:text-[var(--primary)]">
              Courses
            </Link>
            <ChevronRight className="w-4 h-4" />
            <Link href={`/courses/${courseSlug}`} className="hover:text-[var(--primary)]">
              {course.title}
            </Link>
            <ChevronRight className="w-4 h-4" />
            <span className="text-[var(--foreground)]">{module.title}</span>
          </nav>
          
          <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
            <div>
              <div className="flex items-center gap-3 mb-2">
                <span className="px-3 py-1 text-sm font-medium bg-[var(--primary)]/10 text-[var(--primary)] rounded-full">
                  Module {Math.floor(module.order_index)}
                </span>
                {module.required_plan !== 'free' && (
                  <span className="px-3 py-1 text-sm font-medium bg-amber-100 text-amber-700 rounded-full">
                    {(module.required_plan as string).toUpperCase()}
                  </span>
                )}
              </div>
              
              <h1 
                className="text-2xl sm:text-3xl font-bold text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {module.title}
              </h1>
              
              <p className="text-[var(--foreground-muted)] mt-2">
                {module.description}
              </p>
            </div>
            
            {/* Progress Ring */}
            <div className="flex items-center gap-4">
              <div className="relative w-20 h-20">
                <svg className="w-20 h-20 transform -rotate-90">
                  <circle
                    cx="40"
                    cy="40"
                    r="36"
                    stroke="currentColor"
                    strokeWidth="6"
                    fill="none"
                    className="text-slate-200"
                  />
                  <circle
                    cx="40"
                    cy="40"
                    r="36"
                    stroke="currentColor"
                    strokeWidth="6"
                    fill="none"
                    strokeDasharray={`${2 * Math.PI * 36}`}
                    strokeDashoffset={`${2 * Math.PI * 36 * (1 - progressPercent / 100)}`}
                    className="text-emerald-500 transition-all duration-500"
                    strokeLinecap="round"
                  />
                </svg>
                <div className="absolute inset-0 flex items-center justify-center">
                  <span className="text-lg font-bold text-[var(--foreground)]">
                    {progressPercent}%
                  </span>
                </div>
              </div>
              
              <div className="text-sm text-[var(--foreground-muted)]">
                <p><strong className="text-[var(--foreground)]">{completedCount}</strong> of {activities.length}</p>
                <p>activities done</p>
              </div>
            </div>
          </div>
          
          {/* Module Stats */}
          <div className="flex items-center gap-6 mt-6 pt-6 border-t border-[var(--border)]">
            <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
              <Clock className="w-4 h-4" />
              <span>{module.estimated_minutes} minutes</span>
            </div>
            <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
              <Zap className="w-4 h-4" />
              <span>{module.total_xp} XP available</span>
            </div>
            <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
              <BookOpen className="w-4 h-4" />
              <span>{activities.length} activities</span>
            </div>
          </div>
        </div>
      </div>

      {/* Activities List */}
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Continue Button */}
        {firstIncomplete && moduleAccessible && (
          <Link
            href={`/courses/${courseSlug}/${moduleSlug}/${firstIncomplete.slug}`}
            className="flex items-center justify-center gap-2 w-full py-4 mb-8 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-hover)] transition-colors shadow-lg shadow-[var(--primary)]/25"
          >
            Continue Learning
            <ChevronRight className="w-5 h-5" />
          </Link>
        )}

        {!moduleAccessible && (
          <div className="flex items-center justify-between p-6 mb-8 bg-amber-50 border border-amber-200 rounded-xl">
            <div className="flex items-center gap-3">
              <Lock className="w-6 h-6 text-amber-600" />
              <div>
                <p className="font-medium text-amber-900">This module requires a {module.required_plan} plan</p>
                <p className="text-sm text-amber-700">Upgrade to access all content</p>
              </div>
            </div>
            <Link
              href="/pricing"
              className="px-4 py-2 bg-amber-600 text-white font-medium rounded-lg hover:bg-amber-700 transition-colors"
            >
              Upgrade
            </Link>
          </div>
        )}

        {/* Activity Cards */}
        <div className="space-y-3">
          {activities.map((activity, index) => {
            const progress = activityProgress[activity.id];
            const isCompleted = progress?.completed ?? false;
            const activityLocked = !isAdmin && !hasAccess(activity.required_plan as PlanTier, userPlan);
            const Icon = activityIcons[activity.type];
            
            return (
              <ActivityCard
                key={activity.id}
                activity={activity}
                index={index + 1}
                courseSlug={courseSlug}
                moduleSlug={moduleSlug}
                isCompleted={isCompleted}
                isLocked={activityLocked}
                score={progress?.score}
                Icon={Icon}
              />
            );
          })}
        </div>
      </div>
    </div>
  );
}

function hasAccess(required: PlanTier, userPlan: PlanTier): boolean {
  const tierOrder: Record<PlanTier, number> = { free: 0, basic: 1, advanced: 2 };
  return tierOrder[userPlan] >= tierOrder[required];
}

interface ActivityCardProps {
  activity: Activity;
  index: number;
  courseSlug: string;
  moduleSlug: string;
  isCompleted: boolean;
  isLocked: boolean;
  score?: number;
  Icon: React.ComponentType<{ className?: string }>;
}

function ActivityCard({ 
  activity, 
  index, 
  courseSlug, 
  moduleSlug, 
  isCompleted, 
  isLocked,
  score,
  Icon
}: ActivityCardProps) {
  const content = (
    <div className={`
      flex items-center gap-4 p-4 bg-white rounded-xl border border-[var(--border)]
      transition-all duration-200
      ${isLocked 
        ? 'opacity-60' 
        : 'hover:border-[var(--primary)] hover:shadow-sm cursor-pointer'
      }
    `}>
      {/* Activity Icon/Number */}
      <div className={`
        flex-shrink-0 w-10 h-10 rounded-lg flex items-center justify-center
        ${isCompleted 
          ? 'bg-emerald-100 text-emerald-600' 
          : isLocked 
            ? 'bg-slate-100 text-slate-400' 
            : 'bg-[var(--primary)]/10 text-[var(--primary)]'
        }
      `}>
        {isCompleted ? (
          <CheckCircle2 className="w-5 h-5" />
        ) : isLocked ? (
          <Lock className="w-4 h-4" />
        ) : (
          <Icon className="w-5 h-5" />
        )}
      </div>
      
      {/* Content */}
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-2">
          <span className="text-xs text-[var(--foreground-muted)]">
            {activity.external_id}
          </span>
          <span className="text-xs px-2 py-0.5 bg-slate-100 text-slate-600 rounded-full">
            {activityLabels[activity.type]}
          </span>
          {activity.required_plan !== 'free' && (
            <span className="text-xs px-2 py-0.5 bg-amber-100 text-amber-700 rounded-full">
              {activity.required_plan.toUpperCase()}
            </span>
          )}
        </div>
        
        <h3 className="font-medium text-[var(--foreground)] mt-1 truncate">
          {activity.title}
        </h3>
      </div>
      
      {/* Meta */}
      <div className="flex-shrink-0 flex items-center gap-4 text-sm text-[var(--foreground-muted)]">
        {score !== undefined && (
          <span className="font-medium text-emerald-600">{score}%</span>
        )}
        <div className="flex items-center gap-1">
          <Clock className="w-4 h-4" />
          <span>{activity.minutes}m</span>
        </div>
        <div className="flex items-center gap-1">
          <Zap className="w-4 h-4" />
          <span>{activity.xp}</span>
        </div>
        {!isLocked && (
          <ChevronRight className="w-5 h-5" />
        )}
      </div>
    </div>
  );

  if (isLocked) {
    return content;
  }

  return (
    <Link href={`/courses/${courseSlug}/${moduleSlug}/${activity.slug}`}>
      {content}
    </Link>
  );
}

