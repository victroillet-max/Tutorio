import { createClient } from "@/utils/supabase/server";
import { notFound } from "next/navigation";
import Link from "next/link";
import { 
  ChevronLeft, 
  ChevronRight,
  CheckCircle2, 
  Lock,
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

  // Check prerequisites
  const { data: prereqsData } = await supabase
    .rpc("get_skill_prerequisites_status", {
      p_user_id: user?.id || null,
      p_skill_id: skill.id
    });

  const prerequisites = prereqsData || [];
  const unmetPrereqs = prerequisites.filter((p: { is_required: boolean; is_mastered: boolean }) => 
    p.is_required && !p.is_mastered
  );

  // Find next activity to continue
  const nextActivity = activities.find(a => !a.is_completed);
  const allCompleted = activities.length > 0 && activities.every(a => a.is_completed);
  const isMastered = masteryLevel >= 70;

  // Get course info for back link
  const { data: courseData } = await supabase
    .from("courses")
    .select("slug, title")
    .eq("id", skill.course_id)
    .single();
  
  const isFoundation = skill.category === 'ct_foundations';
  const courseSlug = courseData?.slug || 'computational-thinking';
  const courseTitle = courseData?.title || 'Course';
  const backLink = `/courses/${courseSlug}/learn?tab=${isFoundation ? 'foundations' : 'skills'}`;
  const backLabel = `${courseTitle} - ${isFoundation ? 'Foundations' : 'Skills'}`;

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

              {unmetPrereqs.length > 0 ? (
                <div className="text-center">
                  <div className="flex items-center justify-center gap-2 text-amber-600 mb-2">
                    <Lock className="w-4 h-4" />
                    <span className="text-sm font-medium">Prerequisites needed</span>
                  </div>
                  <p className="text-xs text-slate-500">
                    Complete {unmetPrereqs.length} prerequisite{unmetPrereqs.length > 1 ? 's' : ''} first
                  </p>
                </div>
              ) : nextActivity ? (
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

      {/* Prerequisites Warning */}
      {unmetPrereqs.length > 0 && (
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 pt-6">
          <div className="bg-amber-50 border border-amber-200 rounded-xl p-4">
            <div className="flex items-start gap-3">
              <Lock className="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" />
              <div>
                <h3 className="font-semibold text-amber-800">Prerequisites Required</h3>
                <p className="text-sm text-amber-700 mt-1 mb-3">
                  Master these skills before starting this one:
                </p>
                <div className="flex flex-wrap gap-2">
                  {unmetPrereqs.map((prereq: { prerequisite_skill_id: string; skill_name: string; skill_slug: string; mastery_level: number }) => (
                    <Link
                      key={prereq.prerequisite_skill_id}
                      href={`/skills/${prereq.skill_slug}`}
                      className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-white border border-amber-200 text-sm hover:bg-amber-100 transition-colors"
                    >
                      <span className="font-medium text-amber-800">{prereq.skill_name}</span>
                      <span className="text-amber-600">{prereq.mastery_level}%</span>
                    </Link>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>
      )}

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
              // Completed activities are always accessible
              if (activity.is_completed) {
                return (
                  <ActivityCard
                    key={activity.activity_id}
                    activity={activity}
                    index={index + 1}
                    skillSlug={skillSlug}
                    isLocked={false}
                    colors={colors}
                  />
                );
              }
              
              // For incomplete activities, check if locked:
              // 1. Skill has unmet prerequisites, OR
              // 2. Previous activity in the sequence is not completed (sequential unlock)
              const previousActivity = index > 0 ? activities[index - 1] : null;
              const isPreviousCompleted = previousActivity ? previousActivity.is_completed : true;
              const isActivityLocked = unmetPrereqs.length > 0 || !isPreviousCompleted;
              
              return (
                <ActivityCard
                  key={activity.activity_id}
                  activity={activity}
                  index={index + 1}
                  skillSlug={skillSlug}
                  isLocked={isActivityLocked}
                  colors={colors}
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
}: {
  activity: SkillActivity;
  index: number;
  skillSlug: string;
  isLocked: boolean;
  colors: { bg: string; border: string; text: string };
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

  const content = (
    <div className={`
      bg-white rounded-xl border p-4 transition-all flex items-center gap-4
      ${activity.is_completed 
        ? 'border-emerald-200' 
        : isLocked 
          ? 'border-slate-200 opacity-60' 
          : 'border-slate-200 hover:border-slate-300 hover:shadow-sm cursor-pointer'
      }
    `}>
      {/* Status Icon */}
      <div className={`
        w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0
        ${activity.is_completed 
          ? 'bg-emerald-100 text-emerald-600' 
          : isLocked 
            ? 'bg-slate-100 text-slate-400' 
            : `bg-slate-100 ${colors.text}`
        }
      `}>
        {activity.is_completed ? (
          <CheckCircle2 className="w-5 h-5" />
        ) : isLocked ? (
          <Lock className="w-4 h-4" />
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
          <span className={`flex items-center gap-1 px-2 py-0.5 rounded-full bg-slate-100`}>
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
        ) : !isLocked && (
          <ChevronRight className="w-5 h-5 text-slate-400" />
        )}
      </div>
    </div>
  );

  if (isLocked) {
    return content;
  }

  return (
    <Link href={`/skills/${skillSlug}/${activity.activity_slug}`}>
      {content}
    </Link>
  );
}

