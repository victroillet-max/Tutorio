import { createClient } from "@/utils/supabase/server";
import { notFound } from "next/navigation";
import Link from "next/link";
import { Suspense } from "react";
import { 
  ChevronLeft, 
  ChevronRight,
  CheckCircle2, 
  Lock,
  Play,
  Clock,
  Target,
  Sparkles,
  BookOpen,
  Trophy,
  TrendingUp,
  Zap
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { SubscriptionSuccessPopup } from "@/components/stripe";

interface CourseLearnPageProps {
  params: Promise<{ slug: string }>;
  searchParams: Promise<{ tab?: string }>;
}

export async function generateMetadata({ params }: CourseLearnPageProps) {
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

interface SkillData {
  skill_id: string;
  skill_slug: string;
  skill_name: string;
  skill_description: string;
  category: string;
  category_label: string | null;
  sort_order: number;
  total_activities: number;
  completed_activities: number;
  is_available: boolean;
  mastery_level: number;
}

export default async function CourseLearnPage({ params, searchParams }: CourseLearnPageProps) {
  const { slug } = await params;
  const { tab = 'foundations' } = await searchParams;
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // Get course details
  const { data: course, error: courseError } = await supabase
    .from("courses")
    .select("*")
    .eq("slug", slug)
    .eq("is_published", true)
    .single();

  if (courseError || !course) {
    notFound();
  }

  // Auto-enroll user in this course
  if (user) {
    await supabase.rpc("enroll_user_in_course", {
      p_user_id: user.id,
      p_course_id: course.id
    });
  }

  // Get course skill progress summary
  const { data: progressData } = await supabase
    .rpc("get_course_skill_progress", {
      p_course_id: course.id,
      p_user_id: user?.id || null
    });

  const progress = progressData?.[0] || {
    foundations_total: 0,
    foundations_mastered: 0,
    foundations_in_progress: 0,
    skills_total: 0,
    skills_mastered: 0,
    skills_in_progress: 0,
    overall_progress_percent: 0
  };

  // Get foundations skills
  const { data: foundationsData } = await supabase
    .rpc("get_course_foundations", {
      p_course_id: course.id,
      p_user_id: user?.id || null
    });

  const foundationSkills: SkillData[] = (foundationsData || []).map((s: Record<string, unknown>) => ({
    ...s,
    category: 'ct_foundations',
    category_label: 'Foundations'
  }));

  // Get coding skills (non-foundations)
  const { data: codingSkillsData } = await supabase
    .rpc("get_course_coding_skills", {
      p_course_id: course.id,
      p_user_id: user?.id || null
    });

  const codingSkills: SkillData[] = codingSkillsData || [];

  // Group coding skills by category
  const skillsByCategory = codingSkills.reduce((acc, skill) => {
    const cat = skill.category_label || skill.category;
    if (!acc[cat]) acc[cat] = [];
    acc[cat].push(skill);
    return acc;
  }, {} as Record<string, SkillData[]>);

  // Find next skill to work on
  const allSkills = [...foundationSkills, ...codingSkills];
  const nextSkill = allSkills.find(s => s.is_available && s.mastery_level < 70);
  
  const foundationsComplete = progress.foundations_total > 0 && 
    progress.foundations_mastered === progress.foundations_total;

  return (
    <div className="min-h-screen bg-[var(--background-secondary)]">
      {/* Subscription Success Popup */}
      <Suspense fallback={null}>
        <SubscriptionSuccessPopup 
          courseTitle={course.title} 
          courseSlug={course.slug}
        />
      </Suspense>

      {/* Header */}
      <div className="bg-gradient-to-br from-[var(--primary)] to-[#1a4d7c] text-white">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Link 
            href="/courses" 
            className="inline-flex items-center gap-1 text-white/70 hover:text-white text-sm mb-4 transition-colors"
          >
            <ChevronLeft className="w-4 h-4" />
            All Courses
          </Link>
          
          <div className="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-6">
            <div className="flex-1">
              <h1 
                className="text-3xl sm:text-4xl font-bold mb-3"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {course.title}
              </h1>
              <p className="text-lg text-white/80 max-w-2xl">
                {course.description}
              </p>
            </div>

            {/* Progress Summary Card */}
            <div className="bg-white rounded-2xl p-6 text-[var(--foreground)] shadow-xl w-full lg:w-80">
              <div className="text-center mb-4">
                <div className="text-4xl font-bold text-[var(--primary)] mb-1" style={{ fontFamily: 'var(--font-heading)' }}>
                  {progress.overall_progress_percent}%
                </div>
                <p className="text-sm text-[var(--foreground-muted)]">Course Progress</p>
              </div>
              
              <div className="h-3 bg-slate-100 rounded-full overflow-hidden mb-4">
                <div 
                  className="h-full rounded-full bg-gradient-to-r from-[var(--primary)] to-blue-500 transition-all"
                  style={{ width: `${progress.overall_progress_percent}%` }}
                />
              </div>

              <div className="grid grid-cols-2 gap-3 text-sm mb-4">
                <div className="bg-amber-50 rounded-xl p-3">
                  <div className="flex items-center gap-2 text-amber-600 mb-1">
                    <Sparkles className="w-4 h-4" />
                    <span className="font-medium">Foundations</span>
                  </div>
                  <p className="text-[var(--foreground-muted)]">
                    {progress.foundations_mastered}/{progress.foundations_total} mastered
                  </p>
                </div>
                <div className="bg-blue-50 rounded-xl p-3">
                  <div className="flex items-center gap-2 text-blue-600 mb-1">
                    <Target className="w-4 h-4" />
                    <span className="font-medium">Skills</span>
                  </div>
                  <p className="text-[var(--foreground-muted)]">
                    {progress.skills_mastered}/{progress.skills_total} mastered
                  </p>
                </div>
              </div>

              {nextSkill && (
                <Link href={`/skills/${nextSkill.skill_slug}`}>
                  <Button className="w-full bg-[var(--primary)] hover:bg-[var(--primary-hover)] text-white">
                    <Play className="w-4 h-4 mr-2" />
                    Continue Learning
                  </Button>
                </Link>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* Tab Navigation */}
      <div className="sticky top-16 z-30 border-b border-[var(--border)] bg-white shadow-sm">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex gap-1">
            <TabLink 
              href={`/courses/${slug}/learn?tab=foundations`}
              active={tab === 'foundations'}
              icon={Sparkles}
              label="Foundations"
              count={progress.foundations_total}
              completed={progress.foundations_mastered}
              color="amber"
            />
            <TabLink 
              href={`/courses/${slug}/learn?tab=skills`}
              active={tab === 'skills'}
              icon={Target}
              label="Skills"
              count={progress.skills_total}
              completed={progress.skills_mastered}
              color="blue"
              locked={!foundationsComplete && progress.foundations_total > 0}
            />
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {tab === 'foundations' ? (
          <FoundationsTab 
            skills={foundationSkills}
            isComplete={foundationsComplete}
            courseSlug={slug}
          />
        ) : (
          <SkillsTab 
            skillsByCategory={skillsByCategory}
            foundationsComplete={foundationsComplete}
            totalFoundations={progress.foundations_total}
            courseSlug={slug}
          />
        )}
      </div>
    </div>
  );
}

function TabLink({
  href,
  active,
  icon: Icon,
  label,
  count,
  completed,
  color,
  locked = false,
}: {
  href: string;
  active: boolean;
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  count: number;
  completed: number;
  color: 'amber' | 'blue';
  locked?: boolean;
}) {
  const colorClasses = {
    amber: active 
      ? 'text-amber-600 border-amber-500' 
      : 'text-[var(--foreground-muted)] border-transparent hover:text-amber-600',
    blue: active 
      ? 'text-blue-600 border-blue-500' 
      : 'text-[var(--foreground-muted)] border-transparent hover:text-blue-600',
  };

  return (
    <Link
      href={href}
      className={`flex items-center gap-2 px-4 py-3 border-b-2 font-medium transition-colors ${colorClasses[color]}`}
    >
      {locked ? <Lock className="w-4 h-4" /> : <Icon className="w-4 h-4" />}
      <span>{label}</span>
      <span className="text-xs text-[var(--foreground-muted)]">
        {completed}/{count}
      </span>
    </Link>
  );
}

function FoundationsTab({
  skills,
  isComplete,
  courseSlug,
}: {
  skills: SkillData[];
  isComplete: boolean;
  courseSlug: string;
}) {
  if (skills.length === 0) {
    return (
      <div className="text-center py-16">
        <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-slate-100 flex items-center justify-center">
          <Sparkles className="w-8 h-8 text-slate-400" />
        </div>
        <h3 className="text-lg font-semibold text-[var(--foreground)] mb-2">No Foundations</h3>
        <p className="text-[var(--foreground-muted)]">This course doesn&apos;t have foundation skills yet.</p>
      </div>
    );
  }

  return (
    <div className="space-y-8">
      {/* Introduction */}
      <div className="bg-gradient-to-br from-amber-50 to-orange-50 border border-amber-200 rounded-2xl p-6">
        <div className="flex items-start gap-4">
          <div className="w-12 h-12 rounded-xl bg-amber-100 flex items-center justify-center flex-shrink-0">
            <Sparkles className="w-6 h-6 text-amber-600" />
          </div>
          <div>
            <h2 className="text-xl font-bold text-[var(--foreground)] mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
              Course Foundations
            </h2>
            <p className="text-[var(--foreground-muted)]">
              Master these core concepts before moving on to practical skills. 
              These foundations will give you the mental framework for solving any problem in this course.
            </p>
          </div>
        </div>
      </div>

      {/* Completion Banner */}
      {isComplete && (
        <div className="bg-gradient-to-r from-emerald-50 to-teal-50 border border-emerald-200 rounded-2xl p-6 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-full bg-emerald-100 flex items-center justify-center">
              <Trophy className="w-5 h-5 text-emerald-600" />
            </div>
            <div>
              <h3 className="font-semibold text-[var(--foreground)]">Foundations Complete!</h3>
              <p className="text-sm text-[var(--foreground-muted)]">You can now start learning practical skills.</p>
            </div>
          </div>
          <Link href={`/courses/${courseSlug}/learn?tab=skills`}>
            <Button className="bg-emerald-600 hover:bg-emerald-700 text-white">
              Go to Skills
              <ChevronRight className="w-4 h-4 ml-1" />
            </Button>
          </Link>
        </div>
      )}

      {/* Skills Path */}
      <div className="relative">
        {/* Vertical Line */}
        <div className="absolute left-6 top-0 bottom-0 w-0.5 bg-amber-200" />

        <div className="space-y-4">
          {skills.map((skill, index) => (
            <SkillCard 
              key={skill.skill_id}
              skill={skill}
              index={index + 1}
              color="amber"
            />
          ))}
        </div>
      </div>
    </div>
  );
}

function SkillsTab({
  skillsByCategory,
  foundationsComplete,
  totalFoundations,
  courseSlug,
}: {
  skillsByCategory: Record<string, SkillData[]>;
  foundationsComplete: boolean;
  totalFoundations: number;
  courseSlug: string;
}) {
  const categories = Object.keys(skillsByCategory);

  // If foundations not complete, show locked message
  if (!foundationsComplete && totalFoundations > 0) {
    return (
      <div className="text-center py-16">
        <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-slate-100 flex items-center justify-center">
          <Lock className="w-8 h-8 text-slate-400" />
        </div>
        <h3 className="text-lg font-semibold text-[var(--foreground)] mb-2">Complete Foundations First</h3>
        <p className="text-[var(--foreground-muted)] mb-6 max-w-md mx-auto">
          Master all foundation skills before unlocking the practical skills section.
        </p>
        <Link href={`/courses/${courseSlug}/learn?tab=foundations`}>
          <Button className="bg-amber-600 hover:bg-amber-700 text-white">
            <Sparkles className="w-4 h-4 mr-2" />
            Go to Foundations
          </Button>
        </Link>
      </div>
    );
  }

  if (categories.length === 0) {
    return (
      <div className="text-center py-16">
        <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-slate-100 flex items-center justify-center">
          <Target className="w-8 h-8 text-slate-400" />
        </div>
        <h3 className="text-lg font-semibold text-[var(--foreground)] mb-2">No Skills Yet</h3>
        <p className="text-[var(--foreground-muted)]">Skills for this course are coming soon.</p>
      </div>
    );
  }

  const categoryColors: Record<string, 'blue' | 'violet' | 'emerald' | 'rose' | 'cyan'> = {
    'Python Basics': 'blue',
    'python_basics': 'blue',
    'Control Flow': 'violet',
    'control_flow': 'violet',
    'Data Structures': 'emerald',
    'data_structures': 'emerald',
    'Functions': 'rose',
    'functions': 'rose',
    'Advanced Topics': 'cyan',
    'advanced_topics': 'cyan',
  };

  return (
    <div className="space-y-10">
      {categories.map((category) => {
        const color = categoryColors[category] || 'blue';
        const colorClasses = {
          blue: 'text-blue-600',
          violet: 'text-violet-600',
          emerald: 'text-emerald-600',
          rose: 'text-rose-600',
          cyan: 'text-cyan-600',
        };

        return (
          <div key={category}>
            <div className="flex items-center gap-3 mb-4">
              <Target className={`w-5 h-5 ${colorClasses[color]}`} />
              <h2 
                className="text-xl font-bold text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {category.replace(/_/g, ' ').replace(/\b\w/g, c => c.toUpperCase())}
              </h2>
              <span className="text-sm text-[var(--foreground-muted)]">
                {skillsByCategory[category].filter(s => s.mastery_level >= 70).length}/
                {skillsByCategory[category].length} mastered
              </span>
            </div>
            
            <div className="grid md:grid-cols-2 gap-4">
              {skillsByCategory[category].map((skill) => (
                <SkillCard 
                  key={skill.skill_id}
                  skill={skill}
                  color={color}
                  compact
                />
              ))}
            </div>
          </div>
        );
      })}
    </div>
  );
}

function SkillCard({
  skill,
  index,
  color,
  compact = false,
}: {
  skill: SkillData;
  index?: number;
  color: 'amber' | 'blue' | 'violet' | 'emerald' | 'rose' | 'cyan';
  compact?: boolean;
}) {
  const isCompleted = skill.mastery_level >= 70;
  const isInProgress = skill.mastery_level > 0 && skill.mastery_level < 70;
  const isLocked = !skill.is_available;
  const progress = skill.total_activities > 0 
    ? Math.round((skill.completed_activities / skill.total_activities) * 100)
    : 0;

  const colorClasses = {
    amber: { bg: 'bg-amber-100', border: 'border-amber-200', text: 'text-amber-600', progress: 'bg-amber-500' },
    blue: { bg: 'bg-blue-100', border: 'border-blue-200', text: 'text-blue-600', progress: 'bg-blue-500' },
    violet: { bg: 'bg-violet-100', border: 'border-violet-200', text: 'text-violet-600', progress: 'bg-violet-500' },
    emerald: { bg: 'bg-emerald-100', border: 'border-emerald-200', text: 'text-emerald-600', progress: 'bg-emerald-500' },
    rose: { bg: 'bg-rose-100', border: 'border-rose-200', text: 'text-rose-600', progress: 'bg-rose-500' },
    cyan: { bg: 'bg-cyan-100', border: 'border-cyan-200', text: 'text-cyan-600', progress: 'bg-cyan-500' },
  };

  const colors = colorClasses[color];

  const content = (
    <div className={`
      relative bg-white rounded-xl border-2 p-4 transition-all
      ${compact ? '' : 'ml-12'}
      ${isCompleted 
        ? 'border-emerald-200 shadow-sm' 
        : isInProgress 
          ? `${colors.border} shadow-md` 
          : isLocked 
            ? 'border-slate-200 opacity-60' 
            : `border-slate-200 hover:${colors.border} hover:shadow-md cursor-pointer`
      }
    `}>
      {/* Status Node (for non-compact) */}
      {!compact && (
        <div className={`
          absolute -left-12 top-4 w-10 h-10 rounded-full flex items-center justify-center z-10
          ${isCompleted 
            ? 'bg-emerald-500 text-white' 
            : isInProgress 
              ? `${colors.bg} ${colors.text}` 
              : isLocked 
                ? 'bg-slate-200 text-slate-400' 
                : `${colors.bg} ${colors.text}`
          }
        `}>
          {isCompleted ? (
            <CheckCircle2 className="w-5 h-5" />
          ) : isLocked ? (
            <Lock className="w-4 h-4" />
          ) : (
            <span className="font-bold text-sm">{index}</span>
          )}
        </div>
      )}

      <div className="flex items-start justify-between gap-4">
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-1">
            {compact && (
              <div className={`w-8 h-8 rounded-lg ${isCompleted ? 'bg-emerald-100' : colors.bg} flex items-center justify-center flex-shrink-0`}>
                {isCompleted ? (
                  <CheckCircle2 className="w-4 h-4 text-emerald-600" />
                ) : isLocked ? (
                  <Lock className="w-4 h-4 text-slate-400" />
                ) : (
                  <Target className={`w-4 h-4 ${colors.text}`} />
                )}
              </div>
            )}
            <h3 
              className="font-semibold text-[var(--foreground)] truncate"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              {skill.skill_name}
            </h3>
          </div>
          
          {!compact && (
            <p className="text-sm text-[var(--foreground-muted)] mb-3 line-clamp-2">
              {skill.skill_description}
            </p>
          )}

          {/* Progress bar */}
          {skill.total_activities > 0 && !isLocked && (
            <div className="mb-2">
              <div className="flex items-center justify-between text-xs text-[var(--foreground-muted)] mb-1">
                <span>{skill.completed_activities}/{skill.total_activities} activities</span>
                <span>{skill.mastery_level}% mastery</span>
              </div>
              <div className="h-1.5 bg-slate-100 rounded-full overflow-hidden">
                <div 
                  className={`h-full rounded-full transition-all ${
                    isCompleted ? 'bg-emerald-500' : colors.progress
                  }`}
                  style={{ width: `${progress}%` }}
                />
              </div>
            </div>
          )}

          {/* Meta info */}
          <div className="flex items-center gap-3 text-xs text-[var(--foreground-muted)]">
            {isCompleted && (
              <span className="flex items-center gap-1 text-emerald-600 font-medium">
                <Trophy className="w-3 h-3" />
                Mastered
              </span>
            )}
            {isInProgress && (
              <span className={`flex items-center gap-1 ${colors.text} font-medium`}>
                <TrendingUp className="w-3 h-3" />
                In Progress
              </span>
            )}
            {isLocked && (
              <span className="flex items-center gap-1 text-slate-400">
                <Lock className="w-3 h-3" />
                Complete prerequisites
              </span>
            )}
          </div>
        </div>

        {/* Action */}
        {!isLocked && !isCompleted && (
          <div className="flex-shrink-0">
            <div className={`w-8 h-8 rounded-full ${colors.bg} flex items-center justify-center ${colors.text}`}>
              <Play className="w-4 h-4 ml-0.5" />
            </div>
          </div>
        )}
      </div>
    </div>
  );

  if (isLocked) {
    return content;
  }

  return (
    <Link href={`/skills/${skill.skill_slug}`}>
      {content}
    </Link>
  );
}
