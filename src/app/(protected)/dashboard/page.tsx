import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { 
  BookOpen, 
  Clock, 
  TrendingUp, 
  ChevronRight,
  Play,
  Target,
  Award,
  Zap,
  Sparkles,
  GraduationCap,
  Trophy,
  CheckCircle2,
  Flame
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { QuickStartButton } from "@/components/dashboard/quick-start-button";

export const metadata = {
  title: "Dashboard | Tutorio",
  description: "Your learning dashboard",
};

interface CourseWithProgress {
  course_id: string;
  course_slug: string;
  course_title: string;
  course_description: string;
  course_short_description: string;
  course_difficulty: string;
  enrolled_at: string;
  last_accessed_at: string;
  foundations_total: number;
  foundations_mastered: number;
  skills_total: number;
  skills_mastered: number;
  overall_progress_percent: number;
}

interface SkillWithActivity {
  skill_id: string;
  skill_slug: string;
  skill_name: string;
  skill_category: string;
  mastery_level: number;
  activity_id: string;
  activity_slug: string;
  activity_title: string;
  last_accessed: string;
}

export default async function DashboardPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // Get user profile
  const { data: profile } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", user!.id)
    .single();

  const displayName = profile?.full_name || user?.email?.split("@")[0] || "there";
  const firstName = displayName.split(" ")[0];

  // Get time-based greeting
  const hour = new Date().getHours();
  const greeting = hour < 12 ? "Good morning" : hour < 18 ? "Good afternoon" : "Good evening";

  // Get user's enrolled courses with progress
  const { data: enrolledCoursesData } = await supabase
    .rpc("get_user_enrolled_courses", { p_user_id: user!.id });

  const enrolledCourses: CourseWithProgress[] = enrolledCoursesData || [];

  // Get user's skills with progress - find in-progress skills
  const { data: skillProgress } = await supabase
    .from("user_skill_progress")
    .select(`
      skill_id,
      mastery_level,
      last_practiced_at,
      skill:skills(id, slug, name, category, course_id)
    `)
    .eq("user_id", user!.id)
    .lt("mastery_level", 70)
    .gt("mastery_level", 0)
    .order("last_practiced_at", { ascending: false })
    .limit(5);

  // Build continue learning items from in-progress skills
  const continueLearningItems: SkillWithActivity[] = [];

  for (const progress of skillProgress || []) {
    const skillData = progress.skill as unknown as { id: string; slug: string; name: string; category: string; course_id: string }[] | { id: string; slug: string; name: string; category: string; course_id: string };
    const skill = Array.isArray(skillData) ? skillData[0] : skillData;
    
    if (!skill) continue;

    // Get next activity for this skill
    const { data: nextActivity } = await supabase.rpc("get_next_skill_activity", {
      p_skill_id: skill.id,
      p_user_id: user!.id
    });

    if (nextActivity && nextActivity.length > 0) {
      continueLearningItems.push({
        skill_id: skill.id,
        skill_slug: skill.slug,
        skill_name: skill.name,
        skill_category: skill.category,
        mastery_level: progress.mastery_level,
        activity_id: nextActivity[0].activity_id,
        activity_slug: nextActivity[0].activity_slug,
        activity_title: nextActivity[0].activity_title,
        last_accessed: progress.last_practiced_at,
      });
    }
  }

  // Get user stats from database
  const { data: userStreak } = await supabase
    .from("user_streaks")
    .select("current_streak, total_xp")
    .eq("user_id", user!.id)
    .single();

  const { count: completedActivitiesCount } = await supabase
    .from("activity_progress")
    .select("id", { count: "exact", head: true })
    .eq("user_id", user!.id)
    .eq("completed", true);

  const { data: totalTimeData } = await supabase
    .from("activity_progress")
    .select("time_spent_seconds")
    .eq("user_id", user!.id);

  const totalTimeSeconds = totalTimeData?.reduce((sum, p) => sum + (p.time_spent_seconds || 0), 0) || 0;
  const hoursLearned = Math.round(totalTimeSeconds / 3600 * 10) / 10;

  // Count mastered skills
  const { count: skillsMastered } = await supabase
    .from("user_skill_progress")
    .select("id", { count: "exact", head: true })
    .eq("user_id", user!.id)
    .gte("mastery_level", 70);

  const stats = {
    skillsMastered: skillsMastered || 0,
    lessonsCompleted: completedActivitiesCount || 0,
    hoursLearned: hoursLearned,
    currentStreak: userStreak?.current_streak || 0,
  };

  const hasEnrolledCourses = enrolledCourses.length > 0;

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Welcome Section */}
      <div className="mb-8" data-tour="dashboard-welcome">
        <h1 
          className="text-3xl font-bold mb-2 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
        >
          {greeting}, {firstName}
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Continue your learning journey where you left off.
        </p>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        <StatCard
          icon={Target}
          label="Skills Mastered"
          value={stats.skillsMastered}
          color="navy"
        />
        <StatCard
          icon={BookOpen}
          label="Activities Done"
          value={stats.lessonsCompleted}
          color="teal"
        />
        <StatCard
          icon={Clock}
          label="Hours Learned"
          value={stats.hoursLearned}
          color="purple"
        />
        <StatCard
          icon={Flame}
          label="Day Streak"
          value={stats.currentStreak}
          color="coral"
        />
      </div>

      {/* Main Content Grid */}
      <div className="grid lg:grid-cols-3 gap-8">
        {/* Continue Learning */}
        <div className="lg:col-span-2 space-y-6">
          {/* Active Courses Section */}
          {hasEnrolledCourses && (
            <div>
              <div className="flex items-center justify-between mb-4">
                <h2 
                  className="text-xl font-bold text-[var(--foreground)]"
                  style={{ fontFamily: 'var(--font-heading)' }}
                >
                  Your Courses
                </h2>
                <Link 
                  href="/courses"
                  className="text-sm text-[var(--accent)] hover:text-[var(--accent-dark)] flex items-center gap-1 transition-colors font-semibold"
                >
                  View all
                  <ChevronRight className="w-4 h-4" />
                </Link>
              </div>

              <div className="space-y-4">
                {enrolledCourses.slice(0, 2).map((course) => (
                  <CourseProgressCard key={course.course_id} course={course} />
                ))}
              </div>
            </div>
          )}

          {/* Continue Learning Activities */}
          <div>
            <div className="flex items-center justify-between mb-4">
              <h2 
                className="text-xl font-bold text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                Continue Learning
              </h2>
            </div>

            {continueLearningItems.length > 0 ? (
              <div className="space-y-3">
                {continueLearningItems.map((item) => (
                  <SkillContinueCard
                    key={item.skill_id}
                    skillSlug={item.skill_slug}
                    skillName={item.skill_name}
                    skillCategory={item.skill_category}
                    masteryLevel={item.mastery_level}
                    activitySlug={item.activity_slug}
                    activityTitle={item.activity_title}
                    lastAccessed={item.last_accessed}
                  />
                ))}
              </div>
            ) : hasEnrolledCourses ? (
              /* Empty state when enrolled but no activities in progress */
              <div className="card-elevated p-8 text-center">
                <div className="w-14 h-14 mx-auto mb-4 rounded-2xl bg-gradient-to-br from-[var(--accent)]/10 to-[var(--accent)]/5 flex items-center justify-center">
                  <Play className="w-7 h-7 text-[var(--accent)]" />
                </div>
                <h3 
                  className="text-lg font-bold mb-2 text-[var(--foreground)]"
                  style={{ fontFamily: 'var(--font-heading)' }}
                >
                  Ready for your next activity?
                </h3>
                <p className="text-sm text-[var(--foreground-muted)] mb-6">
                  Continue with your enrolled courses to keep making progress.
                </p>
                <Link href={`/courses/${enrolledCourses[0].course_slug}/learn`}>
                  <Button variant="accent">
                    Continue Course
                  </Button>
                </Link>
              </div>
            ) : (
              /* Enhanced Empty State - No courses with Quick Start button */
              <div className="card-elevated p-10 text-center">
                <div className="w-18 h-18 mx-auto mb-5 rounded-2xl bg-gradient-to-br from-[var(--primary)]/10 to-[var(--accent)]/10 flex items-center justify-center w-[72px] h-[72px]">
                  <Sparkles className="w-9 h-9 text-[var(--primary)]" />
                </div>
                
                <h3 
                  className="text-xl font-bold mb-3 text-[var(--foreground)]"
                  style={{ fontFamily: 'var(--font-heading)' }}
                >
                  Ready to Start Learning?
                </h3>
                <p className="text-[var(--foreground-muted)] mb-8 max-w-sm mx-auto">
                  Start your learning journey with just one click. We&apos;ll enroll you in our recommended beginner course.
                </p>
                
                {/* Onboarding checklist */}
                <div className="text-left max-w-xs mx-auto mb-8 space-y-3">
                  <div className="flex items-center gap-3 text-sm">
                    <div className="w-6 h-6 rounded-full bg-[var(--success)] flex items-center justify-center flex-shrink-0">
                      <CheckCircle2 className="w-4 h-4 text-white" />
                    </div>
                    <span className="text-[var(--foreground-muted)]">Account created</span>
                  </div>
                  <div className="flex items-center gap-3 text-sm">
                    <div className="w-6 h-6 rounded-full border-2 border-[var(--accent)] flex-shrink-0 flex items-center justify-center">
                      <div className="w-2 h-2 rounded-full bg-[var(--accent)]" />
                    </div>
                    <span className="text-[var(--foreground)] font-medium">Start first activity</span>
                  </div>
                  <div className="flex items-center gap-3 text-sm">
                    <div className="w-6 h-6 rounded-full border-2 border-[var(--card-border)] flex-shrink-0" />
                    <span className="text-[var(--foreground-muted)]">Master your first skill</span>
                  </div>
                </div>
                
                {/* Quick Start Button - one click to first activity */}
                <div className="mb-4">
                  <QuickStartButton />
                </div>
                
                {/* Alternative: Browse courses */}
                <p className="text-sm text-[var(--foreground-muted)]">
                  or{" "}
                  <Link href="/courses" className="text-[var(--accent)] hover:underline font-medium">
                    browse all courses
                  </Link>
                </p>
              </div>
            )}
          </div>
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Quick Actions */}
          <div className="card-elevated p-6" data-tour="quick-actions">
            <h3 
              className="text-lg font-bold mb-5 text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Quick Actions
            </h3>
            <div className="space-y-2">
              <QuickAction
                href="/courses"
                icon={GraduationCap}
                label="My Courses"
                description="All enrolled courses"
              />
              <QuickAction
                href="/profile"
                icon={TrendingUp}
                label="View Progress"
                description="Track your learning"
              />
            </div>
          </div>

          {/* Subscription Status */}
          <div className="card-elevated p-6">
            <h3 
              className="text-lg font-bold mb-5 text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Your Plan
            </h3>
            <div className="p-5 rounded-xl bg-gradient-to-br from-[var(--background)] to-[var(--background-secondary)] border border-[var(--card-border)]">
              <div className="flex items-center gap-2 mb-2">
                <Zap className="w-5 h-5 text-[var(--accent)]" />
                <p className="font-semibold text-[var(--foreground)]">Free Access</p>
              </div>
              <p className="text-sm text-[var(--foreground-muted)] mb-5">
                Preview lessons available
              </p>
              <Link href="/#pricing">
                <Button variant="outline" size="sm" className="w-full">
                  Upgrade Plan
                </Button>
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

function StatCard({
  icon: Icon,
  label,
  value,
  color,
}: {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  value: number;
  color: "navy" | "teal" | "purple" | "coral";
}) {
  const colorClasses = {
    navy: "bg-[var(--primary)]/10 text-[var(--primary)]",
    teal: "bg-[var(--success)]/10 text-[var(--success)]",
    purple: "bg-purple-100 text-purple-600",
    coral: "bg-[var(--accent)]/10 text-[var(--accent)]",
  };

  return (
    <div className="card-elevated p-5">
      <div className={`w-11 h-11 rounded-xl ${colorClasses[color]} flex items-center justify-center mb-4`}>
        <Icon className="w-5 h-5" />
      </div>
      <p 
        className="text-3xl font-bold text-[var(--foreground)] mb-1"
        style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
      >
        {value}
      </p>
      <p className="text-sm text-[var(--foreground-muted)]">{label}</p>
    </div>
  );
}

function QuickAction({
  href,
  icon: Icon,
  label,
  description,
}: {
  href: string;
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  description: string;
}) {
  return (
    <Link
      href={href}
      className="flex items-center gap-4 p-4 rounded-xl hover:bg-[var(--background)] transition-all group"
    >
      <div className="w-11 h-11 rounded-xl bg-[var(--progress-bg)] flex items-center justify-center group-hover:bg-[var(--primary)] transition-colors">
        <Icon className="w-5 h-5 text-[var(--primary)] group-hover:text-white transition-colors" />
      </div>
      <div className="flex-1">
        <p className="font-medium text-sm text-[var(--foreground)]">{label}</p>
        <p className="text-xs text-[var(--foreground-muted)]">{description}</p>
      </div>
      <ChevronRight className="w-4 h-4 text-[var(--foreground-muted)] opacity-0 group-hover:opacity-100 group-hover:translate-x-1 transition-all" />
    </Link>
  );
}

const categoryColors: Record<string, { bg: string; icon: string }> = {
  ct_foundations: { bg: 'from-amber-500/20 to-orange-500/10', icon: 'text-amber-600' },
  python_basics: { bg: 'from-[var(--primary)]/20 to-blue-500/10', icon: 'text-[var(--primary)]' },
  control_flow: { bg: 'from-purple-500/20 to-violet-500/10', icon: 'text-purple-600' },
  data_structures: { bg: 'from-[var(--success)]/20 to-teal-500/10', icon: 'text-[var(--success)]' },
  functions: { bg: 'from-rose-500/20 to-pink-500/10', icon: 'text-rose-600' },
  advanced_topics: { bg: 'from-cyan-500/20 to-blue-500/10', icon: 'text-cyan-600' },
};

const categoryLabels: Record<string, string> = {
  ct_foundations: 'Foundations',
  python_basics: 'Python Basics',
  control_flow: 'Control Flow',
  data_structures: 'Data Structures',
  functions: 'Functions',
  advanced_topics: 'Advanced Topics',
};

function CourseProgressCard({ course }: { course: CourseWithProgress }) {
  return (
    <Link
      href={`/courses/${course.course_slug}/learn`}
      className="card-elevated p-5 flex items-center gap-5 hover:shadow-lg transition-all group"
    >
      {/* Course Icon */}
      <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-[var(--primary)]/20 to-[var(--primary-light)]/10 flex items-center justify-center flex-shrink-0">
        <GraduationCap className="w-8 h-8 text-[var(--primary)]" />
      </div>
      
      {/* Content */}
      <div className="flex-1 min-w-0">
        <h4 
          className="font-bold text-[var(--foreground)] truncate mb-1"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          {course.course_title}
        </h4>
        <div className="flex items-center gap-4 mt-1.5">
          <div className="flex items-center gap-1.5 text-xs text-[var(--foreground-muted)]">
            <Sparkles className="w-3.5 h-3.5 text-amber-500" />
            <span>{course.foundations_mastered}/{course.foundations_total}</span>
          </div>
          <div className="flex items-center gap-1.5 text-xs text-[var(--foreground-muted)]">
            <Target className="w-3.5 h-3.5 text-[var(--primary)]" />
            <span>{course.skills_mastered}/{course.skills_total}</span>
          </div>
        </div>
        <div className="mt-3">
          <div className="flex items-center justify-between text-xs text-[var(--foreground-muted)] mb-1.5">
            <span>Progress</span>
            <span className="font-semibold text-[var(--accent)]">{course.overall_progress_percent}%</span>
          </div>
          <div className="h-2 bg-[var(--background-tertiary)] rounded-full overflow-hidden">
            <div 
              className="h-full rounded-full bg-gradient-to-r from-[var(--accent)] to-[var(--accent-light)]"
              style={{ width: `${course.overall_progress_percent}%` }}
            />
          </div>
        </div>
      </div>
      
      {/* Continue Button */}
      <div className="flex items-center gap-2 px-4 py-2 bg-[var(--accent)] text-white text-sm font-semibold rounded-xl group-hover:bg-[var(--accent-dark)] transition-colors flex-shrink-0">
        <Play className="w-4 h-4" />
        <span className="hidden sm:inline">Continue</span>
      </div>
    </Link>
  );
}

function SkillContinueCard({
  skillSlug,
  skillName,
  skillCategory,
  masteryLevel,
  activitySlug,
  activityTitle,
  lastAccessed,
}: {
  skillSlug: string;
  skillName: string;
  skillCategory: string;
  masteryLevel: number;
  activitySlug: string;
  activityTitle: string;
  lastAccessed: string;
}) {
  const colors = categoryColors[skillCategory] || categoryColors.python_basics;
  const categoryLabel = categoryLabels[skillCategory] || skillCategory;
  const timeAgo = getTimeAgo(lastAccessed);
  
  return (
    <Link
      href={`/skills/${skillSlug}/${activitySlug}`}
      className="card-elevated p-5 flex items-center gap-4 hover:shadow-lg transition-all group"
    >
      {/* Skill Icon */}
      <div className={`w-14 h-14 rounded-2xl bg-gradient-to-br ${colors.bg} flex items-center justify-center flex-shrink-0`}>
        <Target className={`w-6 h-6 ${colors.icon}`} />
      </div>
      
      {/* Content */}
      <div className="flex-1 min-w-0">
        <p className="text-xs text-[var(--foreground-muted)] mb-1">
          {categoryLabel} - {skillName}
        </p>
        <h4 
          className="font-bold text-[var(--foreground)] truncate"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          {activityTitle}
        </h4>
        <div className="flex items-center gap-4 mt-2 text-xs text-[var(--foreground-muted)]">
          <div className="flex items-center gap-1.5">
            <div className="w-14 h-1.5 bg-[var(--background-tertiary)] rounded-full overflow-hidden">
              <div 
                className={`h-full rounded-full ${masteryLevel >= 70 ? 'bg-[var(--success)]' : 'bg-[var(--accent)]'}`}
                style={{ width: `${masteryLevel}%` }}
              />
            </div>
            <span className="font-medium">{masteryLevel}%</span>
          </div>
          <span>{timeAgo}</span>
        </div>
      </div>
      
      {/* Continue Button */}
      <div className="flex items-center gap-2 px-4 py-2 bg-[var(--accent)] text-white text-sm font-semibold rounded-xl group-hover:bg-[var(--accent-dark)] transition-colors flex-shrink-0">
        <Play className="w-4 h-4" />
        <span className="hidden sm:inline">Continue</span>
      </div>
    </Link>
  );
}

function getTimeAgo(dateString: string): string {
  const date = new Date(dateString);
  const now = new Date();
  const seconds = Math.floor((now.getTime() - date.getTime()) / 1000);
  
  if (seconds < 60) return "Just now";
  if (seconds < 3600) return `${Math.floor(seconds / 60)}m ago`;
  if (seconds < 86400) return `${Math.floor(seconds / 3600)}h ago`;
  if (seconds < 604800) return `${Math.floor(seconds / 86400)}d ago`;
  return date.toLocaleDateString();
}
