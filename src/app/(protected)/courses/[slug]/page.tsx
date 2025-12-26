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
  Zap
} from "lucide-react";
import type { Module, PlanTier } from "@/lib/database.types";

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
      const tier = subscription.tier as unknown as { slug: string }[] | { slug: string };
      userPlan = (Array.isArray(tier) ? tier[0]?.slug : tier.slug) as PlanTier;
    }
  }
  
  // Fetch course with modules
  const { data: course, error } = await supabase
    .from("courses")
    .select(`
      *,
      category:categories(*),
      modules(*)
    `)
    .eq("slug", slug)
    .eq("is_published", true)
    .single();

  if (error || !course) {
    notFound();
  }

  // Sort modules by order_index
  const modules = ((course.modules as Module[]) || []).sort(
    (a, b) => a.order_index - b.order_index
  );

  // Calculate totals
  const totalXp = modules.reduce((sum, m) => sum + (m.total_xp || 0), 0);
  const totalMinutes = modules.reduce((sum, m) => sum + (m.estimated_minutes || 0), 0);
  const totalHours = Math.round(totalMinutes / 60);

  // Get user progress for modules (if authenticated)
  let moduleProgress: Record<string, { completed: number; total: number }> = {};
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
            
            {/* CTA Card */}
            <div className="bg-white rounded-2xl p-6 text-[var(--foreground)] shadow-xl w-full lg:w-80">
              <div className="text-center mb-4">
                <p className="text-sm text-[var(--foreground-muted)] mb-1">Your Plan</p>
                <p className="text-2xl font-bold capitalize">{userPlan}</p>
              </div>
              
              {userPlan === 'free' && !isAdmin && (
                <>
                  <div className="border-t border-[var(--border)] pt-4 mb-4">
                    <p className="text-sm text-[var(--foreground-muted)] mb-2">
                      Unlock all modules with Basic
                    </p>
                    <p className="text-3xl font-bold">
                      CHF 9.90<span className="text-base font-normal text-[var(--foreground-muted)]">/month</span>
                    </p>
                  </div>
                  <Link
                    href="/pricing"
                    className="block w-full py-3 px-4 bg-[var(--primary)] text-white text-center font-semibold rounded-xl hover:bg-[var(--primary-hover)] transition-colors"
                  >
                    Upgrade to Basic
                  </Link>
                </>
              )}
              
              {(userPlan !== 'free' || isAdmin) && (
                <div className="flex items-center justify-center gap-2 text-emerald-600">
                  <CheckCircle2 className="w-5 h-5" />
                  <span className="font-medium">{isAdmin ? 'Admin Access' : 'Full Access'}</span>
                </div>
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
          {modules.map((module, index) => {
            const isLocked = !isAdmin && !hasAccess(module.required_plan, userPlan);
            const progress = moduleProgress[module.id];
            const progressPercent = progress 
              ? Math.round((progress.completed / progress.total) * 100) 
              : 0;
            const isCompleted = progressPercent === 100;
            
            return (
              <ModuleCard
                key={module.id}
                module={module}
                index={index + 1}
                courseSlug={slug}
                isLocked={isLocked}
                isCompleted={isCompleted}
                progressPercent={progressPercent}
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

interface ModuleCardProps {
  module: Module;
  index: number;
  courseSlug: string;
  isLocked: boolean;
  isCompleted: boolean;
  progressPercent: number;
}

function ModuleCard({ 
  module, 
  index, 
  courseSlug, 
  isLocked, 
  isCompleted,
  progressPercent 
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
          <div className="flex items-center gap-2 mb-1">
            <h3 
              className="text-lg font-semibold text-[var(--foreground)] truncate"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              {module.title}
            </h3>
            {module.required_plan !== 'free' && (
              <span className="flex-shrink-0 px-2 py-0.5 text-xs font-medium bg-amber-100 text-amber-700 rounded-full">
                {module.required_plan.toUpperCase()}
              </span>
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

