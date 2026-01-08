import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { 
  BookOpen, 
  Clock, 
  ChevronRight,
  Play,
  Target,
  Zap,
  Sparkles,
  GraduationCap,
  Flame,
  TrendingUp,
  CheckCircle2
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { QuickStartButton } from "@/components/dashboard/quick-start-button";
import type { UserCourseSubscription } from "@/lib/database.types";

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

  // Get user's enrolled courses with progress and subscriptions in parallel
  const [coursesResult, subsResult] = await Promise.all([
    supabase.rpc("get_user_enrolled_courses", { p_user_id: user!.id }),
    supabase.rpc("get_user_subscriptions", { p_user_id: user!.id }),
  ]);

  const enrolledCourses: CourseWithProgress[] = coursesResult.data || [];
  const subscriptions: UserCourseSubscription[] = subsResult.data || [];

  // Create a map of course subscriptions for quick lookup
  const subscriptionMap = new Map<string, UserCourseSubscription>();
  subscriptions.forEach(sub => {
    if (sub.status === 'active' || sub.status === 'trialing') {
      subscriptionMap.set(sub.course_id, sub);
    }
  });

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

  const totalXp = userStreak?.total_xp || 0;
  
  // Calculate level from XP (1000 XP per level)
  const currentLevel = Math.floor(totalXp / 1000) + 1;
  const xpInCurrentLevel = totalXp % 1000;
  const xpForNextLevel = 1000;
  const levelProgress = Math.round((xpInCurrentLevel / xpForNextLevel) * 100);
  const xpToNextLevel = xpForNextLevel - xpInCurrentLevel;

  // Level names based on level number
  const levelNames = ['Beginner', 'Learner', 'Rising', 'Skilled', 'Advanced', 'Expert', 'Master'];
  const levelName = levelNames[Math.min(currentLevel - 1, levelNames.length - 1)];
  const nextLevelName = levelNames[Math.min(currentLevel, levelNames.length - 1)];

  const stats = {
    skillsMastered: skillsMastered || 0,
    lessonsCompleted: completedActivitiesCount || 0,
    hoursLearned: hoursLearned,
    currentStreak: userStreak?.current_streak || 0,
  };

  const hasEnrolledCourses = enrolledCourses.length > 0;

  return (
    <div className="max-w-[1280px] mx-auto px-4 sm:px-6 py-8">
      {/* Welcome Section */}
      <div className="mb-6">
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

      {/* XP Level Bar */}
      <div className="card-elevated p-4 sm:p-6 mb-6 flex flex-col sm:flex-row items-start sm:items-center gap-4">
        <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-[var(--accent)]/20 to-[var(--accent)]/10 flex items-center justify-center flex-shrink-0">
          <Flame className="w-6 h-6 text-[var(--accent)]" />
        </div>
        <div className="flex-1 min-w-0 w-full">
          <div className="flex flex-wrap items-center justify-between mb-2 gap-2">
            <div className="flex items-center gap-2">
              <span className="text-sm font-bold text-[var(--accent)]">Level {currentLevel}</span>
              <span className="text-sm font-semibold text-[var(--foreground)]">{levelName}</span>
            </div>
            <span className="text-xs text-[var(--foreground-muted)]">{xpInCurrentLevel.toLocaleString()} / {xpForNextLevel.toLocaleString()} XP</span>
          </div>
          <div className="h-3 bg-[var(--background-tertiary)] rounded-full overflow-hidden relative">
            <div 
              className="h-full rounded-full bg-gradient-to-r from-[var(--accent)] to-[var(--accent-light)] relative"
              style={{ width: `${levelProgress}%` }}
            >
              <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/30 to-transparent animate-shimmer" />
            </div>
          </div>
          <p className="text-xs text-[var(--foreground-muted)] mt-1.5">
            <span className="font-semibold">{xpToNextLevel.toLocaleString()} XP</span> to {nextLevelName}
          </p>
        </div>
        <div className="flex flex-col items-end flex-shrink-0">
          <span className="text-xs text-[var(--foreground-muted)]">Total XP</span>
          <span 
            className="text-xl font-bold text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            {totalXp.toLocaleString()}
          </span>
        </div>
      </div>

      {/* Active Courses Section */}
      {hasEnrolledCourses && (
        <div className="mb-8">
          <div className="flex items-center justify-between mb-4">
            <h2 
              className="text-xl font-bold text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Active Courses
            </h2>
            <Link 
              href="/courses"
              className="text-sm text-[var(--accent)] hover:text-[var(--accent-dark)] flex items-center gap-1 transition-colors font-semibold"
            >
              View all
              <ChevronRight className="w-4 h-4" />
            </Link>
          </div>

          <div className="grid sm:grid-cols-2 gap-6">
            {enrolledCourses.slice(0, 2).map((course) => (
              <CourseHeroCard 
                key={course.course_id} 
                course={course} 
                subscription={subscriptionMap.get(course.course_id) || null}
              />
            ))}
          </div>
        </div>
      )}

      {/* Main Grid */}
      <div className="grid lg:grid-cols-3 gap-8">
        {/* Main Content */}
        <div className="lg:col-span-2 space-y-6">
          {/* Stats Grid */}
          <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
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
          {/* Level Stats Card */}
          <div className="card-elevated p-6">
            <div className="flex items-center gap-2 mb-5">
              <Zap className="w-5 h-5 text-[var(--accent)]" />
              <h3 
                className="text-lg font-bold text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                Your Level
              </h3>
            </div>
            
            {/* Level Ring */}
            <div className="flex flex-col items-center mb-6">
              <div className="relative w-32 h-32 mb-3">
                <svg className="w-full h-full -rotate-90" viewBox="0 0 100 100">
                  <circle
                    cx="50"
                    cy="50"
                    r="45"
                    fill="none"
                    stroke="var(--background-tertiary)"
                    strokeWidth="6"
                  />
                  <circle
                    cx="50"
                    cy="50"
                    r="45"
                    fill="none"
                    stroke="var(--accent)"
                    strokeWidth="6"
                    strokeLinecap="round"
                    strokeDasharray="283"
                    strokeDashoffset={283 - (levelProgress / 100) * 283}
                    className="transition-all duration-1000 ease-out"
                  />
                </svg>
                <div className="absolute inset-4 rounded-full bg-gradient-to-br from-[var(--accent)]/20 to-[var(--accent)]/5 flex items-center justify-center shadow-lg">
                  <Flame className="w-10 h-10 text-[var(--accent)]" />
                </div>
              </div>
              <div 
                className="text-xl font-bold text-[var(--accent)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {levelName}
              </div>
              <div className="text-sm text-[var(--foreground-muted)]">Level {currentLevel}</div>
            </div>
            
            {/* XP Progress */}
            <div className="bg-[var(--background)] rounded-xl p-4 mb-4">
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm text-[var(--foreground-muted)]">Progress</span>
                <span className="text-sm font-semibold text-[var(--accent)]">{levelProgress}%</span>
              </div>
              <div className="h-2 bg-[var(--background-tertiary)] rounded-full overflow-hidden">
                <div 
                  className="h-full rounded-full bg-[var(--accent)]"
                  style={{ width: `${levelProgress}%` }}
                />
              </div>
              <div className="text-xs text-[var(--foreground-muted)] mt-2">
                {xpInCurrentLevel.toLocaleString()} / {xpForNextLevel.toLocaleString()} XP
              </div>
            </div>
            
            {/* Total XP */}
            <div className="flex items-center justify-between p-4 rounded-xl bg-gradient-to-r from-[var(--accent)]/10 to-[var(--accent-light)]/5 mb-4">
              <div className="flex items-center gap-2 text-sm font-medium text-[var(--foreground)]">
                <TrendingUp className="w-4 h-4 text-[var(--accent)]" />
                Total XP
              </div>
              <div 
                className="text-xl font-bold text-[var(--accent)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {totalXp.toLocaleString()}
              </div>
            </div>
          </div>

          {/* Quick Actions */}
          <div className="card-elevated p-6">
            <h3 
              className="text-lg font-bold mb-4 text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Quick Actions
            </h3>
            <div className="space-y-1">
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
    <div className="card-elevated p-4">
      <div className={`w-10 h-10 rounded-xl ${colorClasses[color]} flex items-center justify-center mb-3`}>
        <Icon className="w-5 h-5" />
      </div>
      <p 
        className="text-2xl font-bold text-[var(--foreground)] mb-0.5"
        style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
      >
        {value}
      </p>
      <p className="text-xs text-[var(--foreground-muted)]">{label}</p>
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
  // Python Programming categories
  ct_foundations: 'Foundations',
  python_basics: 'Python Basics',
  control_flow: 'Control Flow',
  data_structures: 'Data Structures',
  functions: 'Functions',
  advanced_topics: 'Advanced Topics',
  // Financial Accounting categories
  fa_foundations: 'FA Foundations',
  financial_statements: 'Financial Statements',
  accounting_equation: 'Accounting Equation',
  journal_entries: 'Journal Entries',
  trial_balance: 'Trial Balance',
  adjusting_entries: 'Adjusting Entries',
  cash_flow_statement: 'Cash Flow Statement',
  inventory: 'Inventory',
  // Managerial Accounting categories
  ma_foundations: 'MA Foundations',
  cost_behavior: 'Cost Behavior',
  cost_volume_profit: 'Cost-Volume-Profit',
  budgeting: 'Budgeting',
  variance_analysis: 'Variance Analysis',
  decision_making: 'Decision Making',
};

function CourseHeroCard({ course, subscription }: { course: CourseWithProgress; subscription: UserCourseSubscription | null }) {
  // Calculate the SVG stroke offset for the progress ring
  const circumference = 2 * Math.PI * 40; // radius = 40
  const strokeDashoffset = circumference - (course.overall_progress_percent / 100) * circumference;
  
  // Determine plan type from subscription
  const tierSlug = subscription?.tier_slug || 'free';
  const tierName = subscription?.tier_name || 'Free';
  const planLabel = `${tierName} Plan`;
  
  // Color scheme based on subscription tier
  const planColors: Record<string, { badge: string; icon: string; label: string }> = {
    free: { badge: 'bg-slate-100', icon: 'text-slate-500', label: 'text-slate-600' },
    basic: { badge: 'bg-blue-50', icon: 'text-blue-500', label: 'text-blue-600' },
    advanced: { badge: 'bg-purple-50', icon: 'text-purple-500', label: 'text-purple-600' },
  };
  const colors = planColors[tierSlug] || planColors.free;

  // Total lessons (foundations + skills activities)
  const totalLessons = course.foundations_total + course.skills_total;
  const completedLessons = course.foundations_mastered + course.skills_mastered;

  // Check if user has the highest tier (advanced) - no upgrade available
  const hasMaxTier = tierSlug === 'advanced';

  return (
    <div className="card-elevated p-5 sm:p-6 relative hover:shadow-lg transition-all group">
      {/* Upgrade Button - Top Right (only show if not on advanced plan) */}
      {!hasMaxTier && (
        <Link 
          href={`/pricing?course=${course.course_slug}`}
          className="absolute top-3 right-3 sm:top-4 sm:right-4 z-10 flex items-center gap-1 sm:gap-1.5 px-2 sm:px-3 py-1 sm:py-1.5 border border-[var(--accent)] rounded-lg bg-transparent text-[var(--accent)] text-xs font-semibold hover:bg-[var(--accent)] hover:text-white transition-all"
        >
          <Zap className="w-3 h-3" />
          <span>Upgrade</span>
          <ChevronRight className="w-3 h-3 opacity-0 -ml-1 group-hover:opacity-100 group-hover:ml-0 transition-all hidden sm:block" />
        </Link>
      )}

      <div className="flex gap-4 sm:gap-6">
        {/* Progress Ring */}
        <div className="flex-shrink-0 pt-6 sm:pt-0">
          <div className="relative w-[88px] h-[88px] sm:w-[112px] sm:h-[112px]">
            <svg className="w-full h-full -rotate-90" viewBox="0 0 100 100">
              <defs>
                <linearGradient id={`progressGradient-${course.course_id}`} x1="0%" y1="0%" x2="100%" y2="0%">
                  <stop offset="0%" stopColor="var(--accent)" />
                  <stop offset="100%" stopColor="var(--accent-light)" />
                </linearGradient>
              </defs>
              <circle
                cx="50"
                cy="50"
                r="40"
                fill="none"
                stroke="var(--background-tertiary)"
                strokeWidth="8"
              />
              <circle
                cx="50"
                cy="50"
                r="40"
                fill="none"
                stroke={`url(#progressGradient-${course.course_id})`}
                strokeWidth="8"
                strokeLinecap="round"
                strokeDasharray={circumference}
                strokeDashoffset={strokeDashoffset}
                className="transition-all duration-1000 ease-out drop-shadow-[0_0_6px_rgba(231,111,81,0.4)]"
              />
            </svg>
            <div className="absolute inset-0 flex flex-col items-center justify-center">
              <span 
                className="text-lg sm:text-2xl font-bold text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
              >
                {course.overall_progress_percent}%
              </span>
              <span className="text-[10px] sm:text-xs text-[var(--foreground-muted)]">complete</span>
            </div>
          </div>
        </div>

        {/* Course Details */}
        <div className="flex-1 min-w-0">
          {/* Plan Badge */}
          <div className="flex items-center gap-1.5 mb-1.5 sm:mb-2">
            <div className={`w-5 h-5 sm:w-6 sm:h-6 rounded-md ${colors.badge} flex items-center justify-center`}>
              <GraduationCap className={`w-3 h-3 sm:w-3.5 sm:h-3.5 ${colors.icon}`} />
            </div>
            <span className={`text-[10px] sm:text-xs font-semibold ${colors.label}`}>{planLabel}</span>
          </div>

          <h3 
            className="text-base sm:text-lg font-bold text-[var(--foreground)] mb-1.5 sm:mb-2 line-clamp-1 group-hover:text-[var(--primary)] transition-colors"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            {course.course_title}
          </h3>
          
          <p className="text-xs sm:text-sm text-[var(--foreground-muted)] mb-3 sm:mb-4 line-clamp-2">
            {course.course_short_description || course.course_description}
          </p>

          {/* Lesson Progress */}
          <div className="flex items-center gap-1 text-xs sm:text-sm text-[var(--foreground-muted)] mb-3 sm:mb-4">
            <BookOpen className="w-3.5 h-3.5 sm:w-4 sm:h-4 text-[var(--primary)]" />
            <span className="font-medium">{completedLessons}</span>
            <span>of {totalLessons} lessons completed</span>
          </div>

          {/* Continue Button */}
          <Link 
            href={`/courses/${course.course_slug}/learn`}
            className="inline-flex items-center gap-2 px-4 sm:px-5 py-2 sm:py-2.5 bg-[var(--accent)] text-white text-xs sm:text-sm font-semibold rounded-xl hover:bg-[var(--accent-dark)] transition-colors"
          >
            <Play className="w-3.5 h-3.5" fill="currentColor" />
            Continue
          </Link>
        </div>
      </div>
    </div>
  );
}

function SkillContinueCard({
  skillSlug,
  skillName,
  skillCategory,
  masteryLevel,
  activitySlug,
  activityTitle,
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
  
  return (
    <Link
      href={`/skills/${skillSlug}/${activitySlug}`}
      className="card-elevated p-5 flex items-center gap-4 hover:shadow-lg transition-all group"
    >
      {/* Activity Icon */}
      <div className={`w-14 h-14 rounded-2xl bg-gradient-to-br ${colors.bg} flex items-center justify-center flex-shrink-0`}>
        <BookOpen className={`w-6 h-6 ${colors.icon}`} />
      </div>
      
      {/* Content */}
      <div className="flex-1 min-w-0">
        <p className="text-xs text-[var(--foreground-muted)] mb-1">
          <span className={colors.icon}>{categoryLabel}</span>
          <span className="text-[var(--foreground-muted)]"> - {skillName}</span>
        </p>
        <h4 
          className="font-bold text-[var(--foreground)] truncate mb-2"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          {activityTitle}
        </h4>
        <div className="flex items-center gap-4 text-xs text-[var(--foreground-muted)]">
          <div className="flex items-center gap-2">
            <div className="w-16 h-1.5 bg-[var(--background-tertiary)] rounded-full overflow-hidden">
              <div 
                className="h-full rounded-full bg-[var(--accent)]"
                style={{ width: `${masteryLevel}%` }}
              />
            </div>
            <span className="font-medium">{masteryLevel}%</span>
          </div>
          <div className="flex items-center gap-1">
            <Clock className="w-3.5 h-3.5" />
            <span>5min</span>
          </div>
          <div className="flex items-center gap-1 text-[var(--accent)] font-semibold">
            <Zap className="w-3.5 h-3.5" />
            <span>+50 XP</span>
          </div>
        </div>
      </div>
      
      {/* Continue Button */}
      <div className="flex items-center gap-2 px-4 py-2.5 bg-[var(--accent)] text-white text-sm font-semibold rounded-xl group-hover:bg-[var(--accent-dark)] transition-colors flex-shrink-0">
        <Play className="w-4 h-4" fill="currentColor" />
        <span className="hidden sm:inline">Continue</span>
      </div>
    </Link>
  );
}
