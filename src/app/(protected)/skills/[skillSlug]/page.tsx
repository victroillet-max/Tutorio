import { createClient } from "@/utils/supabase/server";
import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { 
  ChevronLeft, 
  ChevronRight,
  CheckCircle2, 
  Lock,
  LockOpen,
  Play,
  Clock,
  Target,
  BookOpen,
  Code,
  HelpCircle,
  Zap,
  Trophy
} from "lucide-react";
import { Button } from "@/components/ui/button";

interface SkillPageProps {
  params: Promise<{ skillSlug: string }>;
}

interface CourseSubscription {
  subscription_id: string;
  tier_name: string;
  tier_slug: string;
  status: string;
}

export async function generateMetadata({ params }: SkillPageProps) {
  const { skillSlug } = await params;
  const supabase = await createClient();
  
  const { data: skill } = await supabase
    .from("skills")
    .select("name, description")
    .eq("slug", skillSlug)
    .single();

  return {
    title: skill ? `${skill.name} | Tutorio` : "Skill | Tutorio",
    description: skill?.description || "Learn this skill with Tutorio",
  };
}

interface SkillActivity {
  activity_id: string;
  activity_title: string;
  activity_slug: string;
  activity_type: string;
  minutes: number | null;
  xp: number | null;
  order_index: number;
  is_completed: boolean;
  score: number | null;
  attempts: number;
}

export default async function SkillDetailPage({ params }: SkillPageProps) {
  const { skillSlug } = await params;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // Get skill details
  const { data: skill, error: skillError } = await supabase
    .from("skills")
    .select("*")
    .eq("slug", skillSlug)
    .eq("is_active", true)
    .single();

  if (skillError || !skill) {
    notFound();
  }

  // Get activities for this skill
  const { data: activitiesData } = await supabase
    .rpc("get_skill_activities", { 
      p_skill_id: skill.id, 
      p_user_id: user?.id || null 
    });

  const activities: SkillActivity[] = activitiesData || [];

  // Auto-redirect to activity if skill has exactly one activity
  // This saves users an extra click
  if (activities.length === 1) {
    redirect(`/skills/${skillSlug}/${activities[0].activity_slug}`);
  }

  // Get skill progress summary
  const { data: progressData } = await supabase
    .rpc("get_skill_progress_summary", {
      p_skill_id: skill.id,
      p_user_id: user?.id || null
    });

  const progress = progressData?.[0] || {
    total_activities: 0,
    completed_activities: 0,
    total_xp: 0,
    earned_xp: 0,
    progress_percent: 0
  };

  // Get user's mastery level for this skill
  let masteryLevel = 0;
  if (user) {
    const { data: userProgress } = await supabase
      .from("user_skill_progress")
      .select("mastery_level")
      .eq("user_id", user.id)
      .eq("skill_id", skill.id)
      .single();
    
    masteryLevel = userProgress?.mastery_level || 0;
  }

  // Find next activity to continue
  const nextActivity = activities.find(a => !a.is_completed);
  const isMastered = masteryLevel >= 70;

  // Get course info for back link and demo activity count
  const { data: courseData } = await supabase
    .from("courses")
    .select("id, slug, title, demo_activity_count")
    .eq("id", skill.course_id)
    .single();
  
  const isFoundation = skill.category === 'ct_foundations';
  const courseSlug = courseData?.slug || 'computational-thinking';
  const courseTitle = courseData?.title || 'Course';
  const demoActivityCount = courseData?.demo_activity_count || 5;
  const backLink = `/courses/${courseSlug}/learn?tab=${isFoundation ? 'foundations' : 'skills'}`;
  const backLabel = `${courseTitle} - ${isFoundation ? 'Foundations' : 'Skills'}`;

  // Check user's subscription for this course
  let hasSubscription = false;
  if (user && courseData?.id) {
    const { data: subscriptionData } = await supabase
      .rpc("get_user_course_subscription", {
        p_user_id: user.id,
        p_course_id: courseData.id
      });
    
    const subscription = subscriptionData?.[0] as CourseSubscription | undefined;
    hasSubscription = subscription?.status === 'active' || subscription?.status === 'trialing';
  }

  // Category colors
  const categoryColors: Record<string, { bg: string; border: string; text: string; gradient: string }> = {
    ct_foundations: { bg: 'bg-amber-500', border: 'border-amber-200', text: 'text-amber-600', gradient: 'from-amber-500 to-orange-600' },
    python_basics: { bg: 'bg-blue-500', border: 'border-blue-200', text: 'text-blue-600', gradient: 'from-blue-500 to-indigo-600' },
    control_flow: { bg: 'bg-violet-500', border: 'border-violet-200', text: 'text-violet-600', gradient: 'from-violet-500 to-purple-600' },
    data_structures: { bg: 'bg-emerald-500', border: 'border-emerald-200', text: 'text-emerald-600', gradient: 'from-emerald-500 to-teal-600' },
    functions: { bg: 'bg-rose-500', border: 'border-rose-200', text: 'text-rose-600', gradient: 'from-rose-500 to-pink-600' },
    advanced_topics: { bg: 'bg-cyan-500', border: 'border-cyan-200', text: 'text-cyan-600', gradient: 'from-cyan-500 to-blue-600' },
  };

  const colors = categoryColors[skill.category] || categoryColors.python_basics;

  return (
    <div className="min-h-screen bg-slate-50">
      {/* Header */}
      <div className={`bg-gradient-to-br ${colors.gradient} text-white`}>
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <Link 
            href={backLink} 
            className="inline-flex items-center gap-1 text-white/70 hover:text-white text-sm mb-6 transition-colors"
          >
            <ChevronLeft className="w-4 h-4" />
            Back to {backLabel}
          </Link>
          
          <div className="flex flex-col md:flex-row md:items-start md:justify-between gap-6">
            <div className="flex-1">
              <div className="flex items-center gap-3 mb-4">
                <div className="px-3 py-1 rounded-full bg-white/20 text-sm font-medium capitalize">
                  {skill.category.replace('_', ' ')}
                </div>
                {isMastered && (
                  <div className="flex items-center gap-1 px-3 py-1 rounded-full bg-emerald-400/30 text-sm font-medium">
                    <Trophy className="w-4 h-4" />
                    Mastered
                  </div>
                )}
              </div>
              
              <h1 
                className="text-3xl sm:text-4xl font-bold mb-3"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {skill.name}
              </h1>
              
              <p className="text-lg text-white/80 max-w-2xl">
                {skill.description}
              </p>

              {/* Stats */}
              <div className="flex flex-wrap gap-6 mt-6">
                <div className="flex items-center gap-2">
                  <BookOpen className="w-5 h-5 text-white/70" />
                  <span>{activities.length} Activities</span>
                </div>
                <div className="flex items-center gap-2">
                  <Clock className="w-5 h-5 text-white/70" />
                  <span>{skill.estimated_minutes} min</span>
                </div>
                <div className="flex items-center gap-2">
                  <Zap className="w-5 h-5 text-white/70" />
                  <span>{progress.total_xp} XP</span>
                </div>
                <div className="flex items-center gap-2">
                  <Target className="w-5 h-5 text-white/70" />
                  <span>Level {skill.difficulty_level}/5</span>
                </div>
              </div>
            </div>

            {/* Progress Card */}
            <div className="bg-white rounded-2xl p-6 text-slate-900 shadow-xl w-full md:w-72">
              <div className="text-center mb-4">
                <div className="text-4xl font-bold mb-1" style={{ fontFamily: 'var(--font-heading)' }}>
                  {masteryLevel}%
                </div>
                <p className="text-sm text-slate-500">Mastery Level</p>
              </div>
              
              <div className="h-3 bg-slate-100 rounded-full overflow-hidden mb-4">
                <div 
                  className={`h-full rounded-full transition-all ${
                    masteryLevel >= 70 ? 'bg-emerald-500' : masteryLevel > 0 ? 'bg-amber-500' : 'bg-slate-200'
                  }`}
                  style={{ width: `${masteryLevel}%` }}
                />
              </div>

              <div className="flex items-center justify-between text-sm text-slate-500 mb-4">
                <span>{progress.completed_activities}/{progress.total_activities} done</span>
                <span>{progress.earned_xp}/{progress.total_xp} XP</span>
              </div>

              {nextActivity ? (
                <Link href={`/skills/${skillSlug}/${nextActivity.activity_slug}`}>
                  <Button className={`w-full ${colors.bg} text-white hover:opacity-90`}>
                    <Play className="w-4 h-4 mr-2" />
                    {progress.completed_activities > 0 ? 'Continue' : 'Start Learning'}
                  </Button>
                </Link>
              ) : (
                <div className="text-center">
                  <div className="flex items-center justify-center gap-2 text-emerald-600 mb-1">
                    <CheckCircle2 className="w-5 h-5" />
                    <span className="font-medium">All Complete!</span>
                  </div>
                  <p className="text-xs text-slate-500">Practice more to improve mastery</p>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* Activities List */}
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 
          className="text-xl font-bold mb-6 text-slate-900"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Learning Path
        </h2>

        {activities.length > 0 ? (
          <div className="space-y-3">
            {activities.map((activity, index) => {
              // Demo activities (first N activities) are always unlocked
              // Activities are locked if user has no subscription and it's not a demo activity
              const isDemoActivity = activity.order_index < demoActivityCount;
              const isActivityLocked = !hasSubscription && !isDemoActivity && !activity.is_completed;
              
              return (
                <ActivityCard
                  key={activity.activity_id}
                  activity={activity}
                  index={index + 1}
                  skillSlug={skillSlug}
                  isLocked={isActivityLocked}
                  colors={colors}
                  courseSlug={courseSlug}
                />
              );
            })}
          </div>
        ) : (
          <div className="bg-white rounded-xl border border-slate-200 p-8 text-center">
            <div className="w-12 h-12 mx-auto mb-4 rounded-full bg-slate-100 flex items-center justify-center">
              <BookOpen className="w-6 h-6 text-slate-400" />
            </div>
            <h3 className="font-semibold text-slate-900 mb-1">No Activities Yet</h3>
            <p className="text-sm text-slate-500">Activities for this skill are coming soon.</p>
          </div>
        )}
      </div>
    </div>
  );
}

function ActivityCard({
  activity,
  index,
  skillSlug,
  isLocked,
  colors,
  courseSlug,
}: {
  activity: SkillActivity;
  index: number;
  skillSlug: string;
  isLocked: boolean;
  colors: { bg: string; border: string; text: string };
  courseSlug: string;
}) {
  const typeIcons: Record<string, React.ComponentType<{ className?: string }>> = {
    lesson: BookOpen,
    quiz: HelpCircle,
    code: Code,
    challenge: Zap,
    interactive: Target,
    checkpoint: Trophy,
    mock_exam: Trophy,
  };

  const typeLabels: Record<string, string> = {
    lesson: 'Lesson',
    quiz: 'Quiz',
    code: 'Code Exercise',
    challenge: 'Challenge',
    interactive: 'Interactive',
    checkpoint: 'Checkpoint',
    mock_exam: 'Mock Exam',
  };

  const Icon = typeIcons[activity.activity_type] || BookOpen;
  const typeLabel = typeLabels[activity.activity_type] || activity.activity_type;

  // Locked card content - visible but with lock overlay
  if (isLocked) {
    return (
      <Link href={`/pricing?course=${courseSlug}`} className="block group">
        <div className="relative bg-white rounded-xl border border-slate-200 p-4 transition-all hover:border-amber-300 hover:shadow-md hover:bg-slate-100 cursor-pointer overflow-hidden">
          {/* Lock Overlay - appears on hover */}
          <div className="absolute inset-0 bg-transparent group-hover:bg-slate-200/40 transition-colors duration-300 pointer-events-none" />
          
          {/* Lock Icon Badge with text - animates on hover */}
          <div className="absolute top-3 right-3 z-10 flex items-center gap-2">
            {/* Subscribe text - hidden by default, appears on hover */}
            <span className="text-xs font-medium text-amber-600 whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity duration-300">
              Subscribe to unlock
            </span>
            <div className="relative w-8 h-8 rounded-full bg-amber-100 flex items-center justify-center shadow-sm border border-amber-200 transition-all duration-300 group-hover:bg-amber-50 group-hover:scale-110">
              {/* Closed lock - visible by default, fades on hover */}
              <Lock className="w-4 h-4 text-amber-600 absolute transition-all duration-300 group-hover:opacity-0 group-hover:rotate-[-15deg] group-hover:translate-y-[-2px]" />
              {/* Open lock - hidden by default, appears on hover */}
              <LockOpen className="w-4 h-4 text-amber-500 absolute opacity-0 transition-all duration-300 group-hover:opacity-100" />
            </div>
          </div>

          <div className="flex items-center gap-4">
            {/* Status Icon */}
            <div className={`w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0 bg-slate-100 ${colors.text}`}>
              <span className="font-semibold text-sm">{index}</span>
            </div>

            {/* Content */}
            <div className="flex-1 min-w-0">
              <h3 className="font-medium text-slate-900 truncate">
                {activity.activity_title}
              </h3>
              <div className="flex items-center gap-3 mt-1 text-xs text-slate-500">
                <span className="flex items-center gap-1 px-2 py-0.5 rounded-full bg-slate-100">
                  <Icon className="w-3 h-3" />
                  {typeLabel}
                </span>
                {activity.minutes && (
                  <span className="flex items-center gap-1">
                    <Clock className="w-3 h-3" />
                    {activity.minutes} min
                  </span>
                )}
                {activity.xp && (
                  <span className="flex items-center gap-1">
                    <Zap className="w-3 h-3" />
                    {activity.xp} XP
                  </span>
                )}
              </div>
            </div>
          </div>
        </div>
      </Link>
    );
  }

  // Unlocked/Completed card content
  const content = (
    <div className={`
      bg-white rounded-xl border p-4 transition-all flex items-center gap-4
      ${activity.is_completed 
        ? 'border-emerald-200' 
        : 'border-slate-200 hover:border-slate-300 hover:shadow-sm cursor-pointer'
      }
    `}>
      {/* Status Icon */}
      <div className={`
        w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0
        ${activity.is_completed 
          ? 'bg-emerald-100 text-emerald-600' 
          : `bg-slate-100 ${colors.text}`
        }
      `}>
        {activity.is_completed ? (
          <CheckCircle2 className="w-5 h-5" />
        ) : (
          <span className="font-semibold text-sm">{index}</span>
        )}
      </div>

      {/* Content */}
      <div className="flex-1 min-w-0">
        <h3 className="font-medium text-slate-900 truncate">
          {activity.activity_title}
        </h3>
        <div className="flex items-center gap-3 mt-1 text-xs text-slate-500">
          <span className="flex items-center gap-1 px-2 py-0.5 rounded-full bg-slate-100">
            <Icon className="w-3 h-3" />
            {typeLabel}
          </span>
          {activity.minutes && (
            <span className="flex items-center gap-1">
              <Clock className="w-3 h-3" />
              {activity.minutes} min
            </span>
          )}
          {activity.xp && (
            <span className="flex items-center gap-1">
              <Zap className="w-3 h-3" />
              {activity.xp} XP
            </span>
          )}
        </div>
      </div>

      {/* Score/Status */}
      <div className="flex-shrink-0">
        {activity.is_completed ? (
          <div className="text-right">
            {activity.score !== null && (
              <div className="text-sm font-medium text-emerald-600">{activity.score}%</div>
            )}
            <div className="text-xs text-slate-500">{activity.attempts} attempt{activity.attempts !== 1 ? 's' : ''}</div>
          </div>
        ) : (
          <ChevronRight className="w-5 h-5 text-slate-400" />
        )}
      </div>
    </div>
  );

  return (
    <Link href={`/skills/${skillSlug}/${activity.activity_slug}`}>
      {content}
    </Link>
  );
}

