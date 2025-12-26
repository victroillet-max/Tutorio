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
  Zap
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { ProgressBar } from "@/components/ui/duration-bar";
import type { Activity, Module, Course } from "@/lib/database.types";

export const metadata = {
  title: "Dashboard | Tutorio",
  description: "Your learning dashboard",
};

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

  // Get user's recent activity progress to find courses they're working on
  const { data: recentProgress } = await supabase
    .from("activity_progress")
    .select(`
      id,
      activity_id,
      completed,
      last_accessed_at,
      xp_earned,
      activity:activities(
        id,
        title,
        slug,
        type,
        minutes,
        xp,
        order_index,
        module_id,
        module:modules(
          id,
          title,
          slug,
          order_index,
          course_id,
          course:courses(
            id,
            title,
            slug,
            thumbnail_url
          )
        )
      )
    `)
    .eq("user_id", user!.id)
    .order("last_accessed_at", { ascending: false })
    .limit(20);

  // Get unique courses the user has been working on
  const courseIds = new Set<string>();
  const courseLastAccessed = new Map<string, string>();
  
  for (const progress of recentProgress || []) {
    const activity = progress.activity as Activity & { module: Module & { course: Course } } | null;
    if (activity?.module?.course) {
      const courseId = activity.module.course.id;
      if (!courseIds.has(courseId)) {
        courseIds.add(courseId);
        courseLastAccessed.set(courseId, progress.last_accessed_at);
      }
    }
  }

  // For each course, find the next incomplete activity
  const continueLearningItems: {
    course: Course;
    module: Module;
    activity: Activity;
    lastAccessed: string;
  }[] = [];

  for (const courseId of Array.from(courseIds).slice(0, 3)) {
    // Get all activities in this course with their completion status
    const { data: courseActivities } = await supabase
      .from("activities")
      .select(`
        id,
        title,
        slug,
        type,
        minutes,
        xp,
        order_index,
        module:modules!inner(
          id,
          title,
          slug,
          order_index,
          course_id,
          course:courses!inner(
            id,
            title,
            slug,
            thumbnail_url
          )
        )
      `)
      .eq("module.course_id", courseId)
      .eq("is_published", true)
      .order("order_index");

    if (!courseActivities || courseActivities.length === 0) continue;

    // Get user's completed activities for this course
    const activityIds = courseActivities.map(a => a.id);
    const { data: completedProgress } = await supabase
      .from("activity_progress")
      .select("activity_id, completed")
      .eq("user_id", user!.id)
      .in("activity_id", activityIds)
      .eq("completed", true);

    const completedIds = new Set(completedProgress?.map(p => p.activity_id) || []);

    // Sort by module order_index, then activity order_index
    const sortedActivities = courseActivities.sort((a, b) => {
      const moduleA = a.module as Module & { course: Course };
      const moduleB = b.module as Module & { course: Course };
      if (moduleA.order_index !== moduleB.order_index) {
        return moduleA.order_index - moduleB.order_index;
      }
      return a.order_index - b.order_index;
    });

    // Find first incomplete activity
    const nextActivity = sortedActivities.find(a => !completedIds.has(a.id));
    
    if (nextActivity) {
      const module = nextActivity.module as Module & { course: Course };
      continueLearningItems.push({
        course: module.course,
        module: module,
        activity: nextActivity as unknown as Activity,
        lastAccessed: courseLastAccessed.get(courseId) || new Date().toISOString(),
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

  // Count unique courses the user has started
  const { count: coursesStarted } = await supabase
    .from("activity_progress")
    .select("activity:activities(module:modules(course_id))", { count: "exact", head: true })
    .eq("user_id", user!.id);

  const stats = {
    coursesEnrolled: coursesStarted || 0,
    lessonsCompleted: completedActivitiesCount || 0,
    hoursLearned: hoursLearned,
    currentStreak: userStreak?.current_streak || 0,
  };

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Welcome Section */}
      <div className="mb-8">
        <h1 
          className="text-3xl font-bold mb-2 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Welcome back, {firstName}
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Continue your learning journey where you left off.
        </p>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        <StatCard
          icon={BookOpen}
          label="Courses Enrolled"
          value={stats.coursesEnrolled}
          color="blue"
        />
        <StatCard
          icon={Target}
          label="Lessons Completed"
          value={stats.lessonsCompleted}
          color="green"
        />
        <StatCard
          icon={Clock}
          label="Hours Learned"
          value={stats.hoursLearned}
          color="purple"
        />
        <StatCard
          icon={Award}
          label="Day Streak"
          value={stats.currentStreak}
          color="orange"
        />
      </div>

      {/* Main Content Grid */}
      <div className="grid lg:grid-cols-3 gap-8">
        {/* Continue Learning */}
        <div className="lg:col-span-2 space-y-6">
          <div className="flex items-center justify-between">
            <h2 
              className="text-xl font-semibold text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Continue Learning
            </h2>
            <Link 
              href="/courses"
              className="text-sm text-[var(--primary)] hover:text-[var(--primary-dark)] flex items-center gap-1 transition-colors font-medium"
            >
              View all courses
              <ChevronRight className="w-4 h-4" />
            </Link>
          </div>

          {/* Continue Learning Cards */}
          {continueLearningItems.length > 0 ? (
            <div className="space-y-4">
              {continueLearningItems.map((item) => (
                <ContinueLearningCard
                  key={item.course.id}
                  course={item.course}
                  module={item.module}
                  activity={item.activity}
                  lastAccessed={item.lastAccessed}
                />
              ))}
            </div>
          ) : (
            /* Empty State */
            <div className="card-elevated p-8 text-center">
              <div className="w-16 h-16 mx-auto mb-4 rounded-2xl bg-[var(--progress-bg)] flex items-center justify-center">
                <Play className="w-8 h-8 text-[var(--primary)]" />
              </div>
              <h3 
                className="text-lg font-semibold mb-2 text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                Start your first course
              </h3>
              <p className="text-[var(--foreground-muted)] mb-6 max-w-sm mx-auto">
                Browse our library of business courses and begin your journey to exam success.
              </p>
              <Link href="/courses">
                <Button className="bg-[var(--primary)] text-white font-semibold hover:bg-[var(--primary-dark)] shadow-md shadow-[var(--primary)]/25">
                  Browse Courses
                </Button>
              </Link>
            </div>
          )}
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Quick Actions */}
          <div className="card-elevated p-6">
            <h3 
              className="text-lg font-semibold mb-4 text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Quick Actions
            </h3>
            <div className="space-y-3">
              <QuickAction
                href="/courses"
                icon={BookOpen}
                label="Explore Courses"
                description="Find your next topic"
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
              className="text-lg font-semibold mb-4 text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Your Plan
            </h3>
            <div className="p-4 rounded-xl bg-[var(--background-secondary)] border border-[var(--border)]">
              <div className="flex items-center gap-2 mb-1">
                <Zap className="w-4 h-4 text-[var(--primary)]" />
                <p className="font-medium text-[var(--foreground)]">Free Access</p>
              </div>
              <p className="text-sm text-[var(--foreground-muted)] mb-4">
                Preview lessons available
              </p>
              <Link href="/#pricing">
                <Button variant="outline" size="sm" className="w-full border-[var(--primary)] text-[var(--primary)] hover:bg-[var(--progress-bg)]">
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
  color: "blue" | "green" | "purple" | "orange";
}) {
  const colorClasses = {
    blue: "bg-blue-50 text-blue-600",
    green: "bg-emerald-50 text-emerald-600",
    purple: "bg-purple-50 text-purple-600",
    orange: "bg-orange-50 text-orange-600",
  };

  return (
    <div className="card-elevated p-5">
      <div className={`w-10 h-10 rounded-lg ${colorClasses[color]} flex items-center justify-center mb-3`}>
        <Icon className="w-5 h-5" />
      </div>
      <p className="text-2xl font-bold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
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
      className="flex items-center gap-3 p-3 rounded-xl hover:bg-[var(--background-secondary)] transition-colors group"
    >
      <div className="w-10 h-10 rounded-lg bg-[var(--progress-bg)] flex items-center justify-center group-hover:bg-[var(--primary)] transition-colors">
        <Icon className="w-5 h-5 text-[var(--primary)] group-hover:text-white transition-colors" />
      </div>
      <div>
        <p className="font-medium text-sm text-[var(--foreground)]">{label}</p>
        <p className="text-xs text-[var(--foreground-muted)]">{description}</p>
      </div>
      <ChevronRight className="w-4 h-4 text-[var(--foreground-muted)] ml-auto opacity-0 group-hover:opacity-100 transition-opacity" />
    </Link>
  );
}

function ContinueLearningCard({
  course,
  module,
  activity,
  lastAccessed,
}: {
  course: { id: string; title: string; slug: string; thumbnail_url: string | null };
  module: { id: string; title: string; slug: string };
  activity: { id: string; title: string; slug: string; type: string; minutes: number | null };
  lastAccessed: string;
}) {
  const activityTypeLabels: Record<string, string> = {
    lesson: "Lesson",
    quiz: "Quiz",
    code: "Code Exercise",
    challenge: "Challenge",
    interactive: "Interactive",
    checkpoint: "Checkpoint",
    mock_exam: "Mock Exam",
  };

  const timeAgo = getTimeAgo(lastAccessed);
  
  return (
    <Link
      href={`/courses/${course.slug}/${module.slug}/${activity.slug}`}
      className="card-elevated p-4 flex items-center gap-4 hover:shadow-md transition-shadow group"
    >
      {/* Course Thumbnail or Placeholder */}
      <div className="w-16 h-16 rounded-xl bg-gradient-to-br from-[var(--primary)]/20 to-[var(--primary)]/5 flex items-center justify-center flex-shrink-0">
        <BookOpen className="w-7 h-7 text-[var(--primary)]" />
      </div>
      
      {/* Content */}
      <div className="flex-1 min-w-0">
        <p className="text-xs text-[var(--foreground-muted)] mb-0.5">
          {course.title}
        </p>
        <h4 
          className="font-semibold text-[var(--foreground)] truncate"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          {activity.title}
        </h4>
        <div className="flex items-center gap-3 mt-1 text-xs text-[var(--foreground-muted)]">
          <span className="px-2 py-0.5 rounded-full bg-[var(--background-secondary)]">
            {activityTypeLabels[activity.type] || activity.type}
          </span>
          {activity.minutes && (
            <span className="flex items-center gap-1">
              <Clock className="w-3 h-3" />
              {activity.minutes} min
            </span>
          )}
          <span>{timeAgo}</span>
        </div>
      </div>
      
      {/* Continue Button */}
      <div className="flex items-center gap-2 px-4 py-2 bg-[var(--primary)] text-white text-sm font-medium rounded-lg group-hover:bg-[var(--primary-hover)] transition-colors flex-shrink-0">
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
