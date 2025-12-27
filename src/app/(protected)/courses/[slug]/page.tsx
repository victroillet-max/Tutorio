import { createClient } from "@/utils/supabase/server";
import { notFound } from "next/navigation";
import Link from "next/link";
import { 
  Clock, 
  BookOpen, 
  Trophy,
  ChevronRight,
  Lock,
  CheckCircle2,
  PlayCircle,
  Zap,
  Sparkles,
  Crown
} from "lucide-react";
import type { Module, PlanTier, Activity } from "@/lib/database.types";

interface CoursePageProps {
  params: Promise<{ slug: string }>;
}

export async function generateMetadata({ params }: CoursePageProps) {
  const { slug } = await params;
  const supabase = await createClient();
  
  const { data: course } = await supabase
    .from("courses")
    .select("title, short_description")
    .eq("slug", slug)
    .single();

  return {
    title: course ? `${course.title} | Tutorio` : "Course | Tutorio",
    description: course?.short_description || "Learn with Tutorio",
  };
}

export default async function CoursePage({ params }: CoursePageProps) {
  const { slug } = await params;
  const supabase = await createClient();
  
  // Get current user
  const { data: { user } } = await supabase.auth.getUser();
  
  // Get user's profile (for admin check) and course subscription
  let isAdmin = false;
  let subscriptionTier: string | null = null;
  
  if (user) {
    const { data: profile } = await supabase
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();
    
    isAdmin = profile?.role === 'admin';
  }
  
  // Fetch course with modules and activities
  const { data: course, error } = await supabase
    .from("courses")
    .select(`
      *,
      category:categories(*),
      modules(
        *,
        activities(id, order_index, is_published)
      )
    `)
    .eq("slug", slug)
    .eq("is_published", true)
    .single();

  if (error || !course) {
    notFound();
  }

  // Get user's subscription for this course
  if (user && !isAdmin) {
    const { data: subscription } = await supabase
      .from("subscriptions")
      .select("tier:subscription_tiers(slug)")
      .eq("user_id", user.id)
      .eq("course_id", course.id)
      .in("status", ["active", "trialing"])
      .single();
    
    if (subscription?.tier) {
      const tier = subscription.tier as unknown as { slug: string }[] | { slug: string };
      subscriptionTier = Array.isArray(tier) ? tier[0]?.slug : tier.slug;
    }
  }

  const hasSubscription = isAdmin || subscriptionTier !== null;
  const demoActivityCount = course.demo_activity_count || 5;

  // Sort modules by order_index
  const modules = ((course.modules as (Module & { activities: Activity[] })[]) || []).sort(
    (a, b) => a.order_index - b.order_index
  );

  // Calculate global activity indices for demo badge
  let globalActivityIndex = 0;
  const moduleWithDemoInfo = modules.map(module => {
    const activities = (module.activities || [])
      .filter(a => a.is_published)
      .sort((a, b) => a.order_index - b.order_index);
    
    const activitiesWithDemoStatus = activities.map(activity => {
      globalActivityIndex++;
      return {
        ...activity,
        globalIndex: globalActivityIndex,
        isDemo: globalActivityIndex <= demoActivityCount
      };
    });

    return {
      ...module,
      activities: activitiesWithDemoStatus,
      demoActivitiesCount: activitiesWithDemoStatus.filter(a => a.isDemo).length,
      hasAnyDemoActivities: activitiesWithDemoStatus.some(a => a.isDemo),
      allActivitiesArePremium: activitiesWithDemoStatus.every(a => !a.isDemo)
    };
  });

  // Calculate totals
  const totalXp = modules.reduce((sum, m) => sum + (m.total_xp || 0), 0);
  const totalMinutes = modules.reduce((sum, m) => sum + (m.estimated_minutes || 0), 0);
  const totalHours = Math.round(totalMinutes / 60);
  const totalActivities = globalActivityIndex;

  // Get user progress for modules (if authenticated)
  let moduleProgress: Record<string, { completed: number; total: number }> = {};
  let completedDemoActivities = 0;

  if (user) {
    const { data: progress } = await supabase
      .from("activity_progress")
      .select(`
        activity:activities(module_id),
        completed
      `)
      .eq("user_id", user.id);

    if (progress) {
      // Count completed activities per module
      progress.forEach((p) => {
        const activity = p.activity as unknown as { module_id: string }[] | { module_id: string };
        const moduleId = Array.isArray(activity) ? activity[0]?.module_id : activity?.module_id;
        if (moduleId && p.completed) {
          if (!moduleProgress[moduleId]) {
            moduleProgress[moduleId] = { completed: 0, total: 0 };
          }
          moduleProgress[moduleId].completed++;
        }
      });
    }

    // Get total activities per module
    const { data: activityCounts } = await supabase
      .from("activities")
      .select("module_id")
      .eq("is_published", true);

    if (activityCounts) {
      activityCounts.forEach((a) => {
        if (!moduleProgress[a.module_id]) {
          moduleProgress[a.module_id] = { completed: 0, total: 0 };
        }
        moduleProgress[a.module_id].total++;
      });
    }

    // Count completed demo activities
    completedDemoActivities = Object.values(moduleProgress).reduce(
      (sum, p) => sum + p.completed, 0
    );
    // Cap at demo count for display purposes
    completedDemoActivities = Math.min(completedDemoActivities, demoActivityCount);
  }

  return (
    <div className="min-h-screen bg-[var(--background-secondary)]">
      {/* Hero Section */}
      <div className="bg-gradient-to-br from-[var(--primary)] to-[#1a4d7c] text-white">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <Link 
            href="/courses" 
            className="inline-flex items-center gap-1 text-white/70 hover:text-white text-sm mb-4 transition-colors"
          >
            <ChevronRight className="w-4 h-4 rotate-180" />
            Back to courses
          </Link>
          
          <div className="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-8">
            <div className="flex-1">
              {course.category && (
                <span className="inline-block px-3 py-1 rounded-full bg-white/20 text-sm font-medium mb-4">
                  {(() => {
                    const cat = course.category as unknown as { name: string }[] | { name: string };
                    return Array.isArray(cat) ? cat[0]?.name : cat.name;
                  })()}
                </span>
              )}
              
              <h1 
                className="text-3xl sm:text-4xl font-bold mb-4"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {course.title}
              </h1>
              
              <p className="text-lg text-white/80 mb-6 max-w-2xl">
                {course.description}
              </p>
              
              {/* Stats */}
              <div className="flex flex-wrap gap-6">
                <div className="flex items-center gap-2">
                  <BookOpen className="w-5 h-5 text-white/70" />
                  <span>{modules.length} Modules</span>
                </div>
                <div className="flex items-center gap-2">
                  <Clock className="w-5 h-5 text-white/70" />
                  <span>{totalHours} Hours</span>
                </div>
                <div className="flex items-center gap-2">
                  <Trophy className="w-5 h-5 text-white/70" />
                  <span>{totalXp.toLocaleString()} XP</span>
                </div>
              </div>
            </div>
            
            {/* Subscription CTA Card */}
            <div className="bg-white rounded-2xl p-6 text-[var(--foreground)] shadow-xl w-full lg:w-80">
              {hasSubscription ? (
                // User has subscription or is admin
                <div className="text-center">
                  <div className="w-14 h-14 rounded-full bg-emerald-100 flex items-center justify-center mx-auto mb-3">
                    {isAdmin ? (
                      <Crown className="w-7 h-7 text-emerald-600" />
                    ) : (
                      <CheckCircle2 className="w-7 h-7 text-emerald-600" />
                    )}
                  </div>
                  <p className="text-xl font-bold text-emerald-600 mb-1">
                    {isAdmin ? 'Admin Access' : `${subscriptionTier?.charAt(0).toUpperCase()}${subscriptionTier?.slice(1)} Plan`}
                  </p>
                  <p className="text-sm text-[var(--foreground-muted)] mb-4">
                    You have full access to this course
                  </p>
                  <Link
                    href={`/courses/${slug}/${modules[0]?.slug}`}
                    className="block w-full py-3 px-4 bg-[var(--primary)] text-white text-center font-semibold rounded-xl hover:bg-[var(--primary-dark)] transition-colors"
                  >
                    Continue Learning
                  </Link>
                </div>
              ) : (
                // No subscription - show pricing
                <>
                  <div className="text-center mb-4">
                    <div className="inline-flex items-center gap-1 px-3 py-1 bg-emerald-100 text-emerald-700 text-sm font-medium rounded-full mb-3">
                      <Zap className="w-4 h-4" />
                      {demoActivityCount} Free Lessons
                    </div>
                    <p className="text-sm text-[var(--foreground-muted)]">
                      {completedDemoActivities > 0 
                        ? `${completedDemoActivities}/${demoActivityCount} demo lessons completed`
                        : 'Try before you subscribe'
                      }
                    </p>
                  </div>
                  
                  <div className="border-t border-[var(--border)] pt-4 mb-4">
                    <p className="text-sm text-[var(--foreground-muted)] mb-2">
                      Unlock full course access
                    </p>
                    <div className="flex items-center justify-between mb-3">
                      <div>
                        <p className="font-semibold">Basic</p>
                        <p className="text-sm text-[var(--foreground-muted)]">25 AI messages/day</p>
                      </div>
                      <p className="text-xl font-bold">CHF 10<span className="text-sm font-normal">/mo</span></p>
                    </div>
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="font-semibold text-[var(--primary)]">Advanced</p>
                        <p className="text-sm text-[var(--foreground-muted)]">Unlimited AI</p>
                      </div>
                      <p className="text-xl font-bold text-[var(--primary)]">CHF 20<span className="text-sm font-normal">/mo</span></p>
                    </div>
                  </div>
                  
                  <Link
                    href={`/pricing?course=${slug}`}
                    className="block w-full py-3 px-4 bg-[var(--primary)] text-white text-center font-semibold rounded-xl hover:bg-[var(--primary-dark)] transition-colors mb-3"
                  >
                    Subscribe Now
                  </Link>
                  
                  {modules[0] && (
                    <Link
                      href={`/courses/${slug}/${modules[0].slug}`}
                      className="block w-full py-3 px-4 bg-[var(--background-secondary)] text-[var(--foreground)] text-center font-medium rounded-xl hover:bg-[var(--background-tertiary)] transition-colors"
                    >
                      Start Free Demo
                    </Link>
                  )}
                </>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* Modules List */}
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <h2 
          className="text-2xl font-bold mb-8 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Course Modules
        </h2>
        
        <div className="space-y-4">
          {moduleWithDemoInfo.map((module, index) => {
            const progress = moduleProgress[module.id];
            const progressPercent = progress 
              ? Math.round((progress.completed / progress.total) * 100) 
              : 0;
            const isCompleted = progressPercent === 100;
            const isLocked = !hasSubscription && module.allActivitiesArePremium;
            
            return (
              <ModuleCard
                key={module.id}
                module={module}
                index={index + 1}
                courseSlug={slug}
                isLocked={isLocked}
                isCompleted={isCompleted}
                progressPercent={progressPercent}
                hasSubscription={hasSubscription}
                demoActivitiesCount={module.demoActivitiesCount}
                totalActivities={module.activities.length}
              />
            );
          })}
        </div>

        {/* Upgrade CTA for non-subscribers */}
        {!hasSubscription && (
          <div className="mt-12 bg-gradient-to-r from-[var(--primary)]/10 to-[var(--primary)]/5 rounded-2xl p-8 text-center">
            <Sparkles className="w-10 h-10 text-[var(--primary)] mx-auto mb-4" />
            <h3 className="text-xl font-bold mb-2">Ready to Continue?</h3>
            <p className="text-[var(--foreground-muted)] mb-6 max-w-md mx-auto">
              Subscribe to unlock all {totalActivities} activities and get access to our AI tutor.
            </p>
            <Link
              href={`/pricing?course=${slug}`}
              className="inline-flex items-center gap-2 px-6 py-3 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-dark)] transition-colors"
            >
              View Subscription Options
              <ChevronRight className="w-4 h-4" />
            </Link>
          </div>
        )}
      </div>
    </div>
  );
}

interface ModuleCardProps {
  module: Module & { 
    activities: { id: string; globalIndex: number; isDemo: boolean }[];
    demoActivitiesCount: number;
    hasAnyDemoActivities: boolean;
  };
  index: number;
  courseSlug: string;
  isLocked: boolean;
  isCompleted: boolean;
  progressPercent: number;
  hasSubscription: boolean;
  demoActivitiesCount: number;
  totalActivities: number;
}

function ModuleCard({ 
  module, 
  index, 
  courseSlug, 
  isLocked, 
  isCompleted,
  progressPercent,
  hasSubscription,
  demoActivitiesCount,
  totalActivities
}: ModuleCardProps) {
  const hours = Math.floor((module.estimated_minutes || 0) / 60);
  const minutes = (module.estimated_minutes || 0) % 60;
  const timeString = hours > 0 ? `${hours}h ${minutes}m` : `${minutes}m`;

  const content = (
    <div className={`
      relative bg-white rounded-xl border border-[var(--border)] p-6
      transition-all duration-200
      ${isLocked 
        ? 'opacity-75' 
        : 'hover:border-[var(--primary)] hover:shadow-md cursor-pointer'
      }
    `}>
      {/* Progress bar background */}
      {progressPercent > 0 && !isLocked && (
        <div 
          className="absolute inset-0 bg-emerald-50 rounded-xl transition-all"
          style={{ width: `${progressPercent}%` }}
        />
      )}
      
      <div className="relative flex items-start gap-4">
        {/* Module Number */}
        <div className={`
          flex-shrink-0 w-12 h-12 rounded-xl flex items-center justify-center font-bold text-lg
          ${isCompleted 
            ? 'bg-emerald-100 text-emerald-600' 
            : isLocked 
              ? 'bg-slate-100 text-slate-400' 
              : 'bg-[var(--primary)]/10 text-[var(--primary)]'
          }
        `}>
          {isCompleted ? (
            <CheckCircle2 className="w-6 h-6" />
          ) : isLocked ? (
            <Lock className="w-5 h-5" />
          ) : (
            index
          )}
        </div>
        
        {/* Content */}
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-1 flex-wrap">
            <h3 
              className="text-lg font-semibold text-[var(--foreground)] truncate"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              {module.title}
            </h3>
            
            {/* Demo/Premium Badge */}
            {!hasSubscription && (
              <>
                {demoActivitiesCount > 0 && demoActivitiesCount < totalActivities && (
                  <span className="flex-shrink-0 px-2 py-0.5 text-xs font-medium bg-emerald-100 text-emerald-700 rounded-full">
                    {demoActivitiesCount} Free
                  </span>
                )}
                {demoActivitiesCount === totalActivities && (
                  <span className="flex-shrink-0 px-2 py-0.5 text-xs font-medium bg-emerald-100 text-emerald-700 rounded-full flex items-center gap-1">
                    <Zap className="w-3 h-3" />
                    Free
                  </span>
                )}
                {demoActivitiesCount === 0 && (
                  <span className="flex-shrink-0 px-2 py-0.5 text-xs font-medium bg-amber-100 text-amber-700 rounded-full flex items-center gap-1">
                    <Lock className="w-3 h-3" />
                    Premium
                  </span>
                )}
              </>
            )}
          </div>
          
          <p className="text-sm text-[var(--foreground-muted)] mb-3 line-clamp-1">
            {module.description}
          </p>
          
          <div className="flex items-center gap-4 text-sm text-[var(--foreground-muted)]">
            <span className="flex items-center gap-1">
              <Clock className="w-4 h-4" />
              {timeString}
            </span>
            <span className="flex items-center gap-1">
              <Zap className="w-4 h-4" />
              {module.total_xp} XP
            </span>
            <span className="flex items-center gap-1">
              <BookOpen className="w-4 h-4" />
              {totalActivities} activities
            </span>
            {progressPercent > 0 && !isLocked && (
              <span className="flex items-center gap-1 text-emerald-600">
                <PlayCircle className="w-4 h-4" />
                {progressPercent}% Complete
              </span>
            )}
          </div>
        </div>
        
        {/* Arrow */}
        {!isLocked && (
          <ChevronRight className="flex-shrink-0 w-5 h-5 text-[var(--foreground-muted)]" />
        )}
      </div>
    </div>
  );

  if (isLocked) {
    return content;
  }

  return (
    <Link href={`/courses/${courseSlug}/${module.slug}`}>
      {content}
    </Link>
  );
}
