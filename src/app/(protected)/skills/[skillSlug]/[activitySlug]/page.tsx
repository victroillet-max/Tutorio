import { createClient } from "@/utils/supabase/server";
import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { 
  ChevronLeft,
  ChevronRight,
  Clock,
  Zap
} from "lucide-react";
import type { Activity } from "@/lib/database.types";
import { LessonViewer } from "@/components/activities/lesson-viewer";
import { QuizViewer } from "@/components/activities/quiz-viewer";
import { CodeEditor } from "@/components/activities/code-editor";
import { InteractiveViewer } from "@/components/activities/interactive-viewer";
import { CheckpointViewer } from "@/components/activities/checkpoint-viewer";
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
        <ActivityRenderer 
          activity={activity as Activity} 
          userId={user.id}
          isCompleted={progress?.completed ?? false}
          nextActivity={nextActivity ? {
            slug: nextActivity.activity_slug,
            title: nextActivity.activity_title,
            skillSlug: skillSlug
          } : undefined}
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

interface NextActivityInfo {
  slug: string;
  title: string;
  skillSlug: string;
}

interface ActivityRendererProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
  nextActivity?: NextActivityInfo;
}

function ActivityRenderer({ activity, userId, isCompleted, nextActivity }: ActivityRendererProps) {
  switch (activity.type) {
    case 'lesson':
      return (
        <LessonViewer 
          activity={activity} 
          userId={userId}
          isCompleted={isCompleted}
          nextActivity={nextActivity}
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

