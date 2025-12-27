import { createClient } from "@/utils/supabase/server";
import { Mail, Calendar, Award, BookOpen, CheckCircle, Clock } from "lucide-react";
import Link from "next/link";

export const metadata = {
  title: "Profile | Tutorio",
  description: "Your profile and learning statistics",
};

// Force dynamic rendering to always show fresh data
export const dynamic = "force-dynamic";

interface ActivityProgressRow {
  id: string;
  completed: boolean;
  completed_at: string | null;
  time_spent_seconds: number;
  xp_earned: number;
  last_accessed_at: string;
  activity: {
    id: string;
    title: string;
    slug: string;
    type: string;
    xp: number;
    module: {
      id: string;
      title: string;
      slug: string;
      course: {
        id: string;
        title: string;
        slug: string;
      };
    };
  };
}

export default async function ProfilePage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // Fetch all data in parallel for better performance
  const [
    { data: profile },
    { data: activityProgress },
    { data: badges },
  ] = await Promise.all([
    supabase
      .from("profiles")
      .select("*")
      .eq("id", user!.id)
      .single(),
    supabase
      .from("activity_progress")
      .select(`
        id,
        completed,
        completed_at,
        time_spent_seconds,
        xp_earned,
        last_accessed_at,
        activity:activities(
          id,
          title,
          slug,
          type,
          xp,
          module:modules(
            id,
            title,
            slug,
            course:courses(
              id,
              title,
              slug
            )
          )
        )
      `)
      .eq("user_id", user!.id)
      .order("last_accessed_at", { ascending: false }),
    supabase
      .from("user_badges")
      .select("badge_id")
      .eq("user_id", user!.id),
  ]);

  const typedActivityProgress = activityProgress as unknown as ActivityProgressRow[] | null;

  // Calculate unique courses started from activity progress
  const uniqueCourseIds = new Set<string>();
  typedActivityProgress?.forEach(p => {
    const activity = Array.isArray(p.activity) ? p.activity[0] : p.activity;
    const module = activity ? (Array.isArray(activity.module) ? activity.module[0] : activity.module) : null;
    const course = module ? (Array.isArray(module.course) ? module.course[0] : module.course) : null;
    if (course?.id) {
      uniqueCourseIds.add(course.id);
    }
  });
  const coursesStarted = uniqueCourseIds.size;
  
  const lessonsCompleted = typedActivityProgress?.filter(p => p.completed)?.length || 0;
  
  const totalTimeSeconds = typedActivityProgress?.reduce(
    (sum, p) => sum + (p.time_spent_seconds || 0),
    0
  ) || 0;
  const hoursLearned = Math.round(totalTimeSeconds / 3600 * 10) / 10; // Round to 1 decimal
  
  const certificatesCount = badges?.length || 0;

  // Get recent activity (last 5 activities)
  const recentActivity = typedActivityProgress?.slice(0, 5) || [];

  const displayName = profile?.full_name || user?.email?.split("@")[0] || "User";
  const initials = displayName
    .split(" ")
    .map((n: string) => n[0])
    .join("")
    .toUpperCase()
    .slice(0, 2);

  const memberSince = new Date(user?.created_at || Date.now()).toLocaleDateString("en-US", {
    month: "long",
    year: "numeric",
  });

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Header */}
      <div className="mb-8">
        <h1 
          className="text-3xl font-bold mb-2 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Your Profile
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Manage your account information and view your learning progress.
        </p>
      </div>

      {/* Profile Card */}
      <div className="card-elevated p-8 mb-8">
        <div className="flex items-start gap-6">
          {/* Avatar */}
          <div className="w-24 h-24 rounded-2xl bg-[var(--primary)] flex items-center justify-center text-white text-3xl font-bold shadow-lg shadow-[var(--primary)]/25">
            {initials}
          </div>

          {/* Info */}
          <div className="flex-1">
            <h2 
              className="text-2xl font-bold mb-1 text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              {displayName}
            </h2>
            
            <div className="space-y-2 mt-4">
              <div className="flex items-center gap-2 text-[var(--foreground-muted)]">
                <Mail className="w-4 h-4" />
                <span>{user?.email}</span>
              </div>
              <div className="flex items-center gap-2 text-[var(--foreground-muted)]">
                <Calendar className="w-4 h-4" />
                <span>Member since {memberSince}</span>
              </div>
              <div className="flex items-center gap-2 text-[var(--foreground-muted)]">
                <Award className="w-4 h-4" />
                <span className="capitalize">{profile?.role || "user"} account</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <StatCard label="Courses Started" value={coursesStarted.toString()} color="blue" />
        <StatCard label="Lessons Completed" value={lessonsCompleted.toString()} color="green" />
        <StatCard label="Hours Learned" value={hoursLearned.toString()} color="purple" />
        <StatCard label="Badges Earned" value={certificatesCount.toString()} color="orange" />
      </div>

      {/* Recent Activity */}
      <div className="card-elevated p-6">
        <h3 
          className="text-lg font-semibold mb-4 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Recent Activity
        </h3>
        {recentActivity.length > 0 ? (
          <div className="space-y-3">
            {recentActivity.map((item) => {
              const activity = Array.isArray(item.activity) ? item.activity[0] : item.activity;
              if (!activity) return null;
              
              const module = Array.isArray(activity.module) ? activity.module[0] : activity.module;
              if (!module) return null;
              
              const course = Array.isArray(module.course) ? module.course[0] : module.course;
              if (!course) return null;
              
              const activityUrl = `/courses/${course.slug}/${module.slug}/${activity.slug}`;
              const timeAgo = getTimeAgo(item.last_accessed_at);
              
              return (
                <Link
                  key={item.id}
                  href={activityUrl}
                  className="flex items-center gap-4 p-3 rounded-lg hover:bg-[var(--background-secondary)] transition-colors"
                >
                  <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${
                    item.completed 
                      ? 'bg-emerald-100 text-emerald-600' 
                      : 'bg-blue-100 text-blue-600'
                  }`}>
                    {item.completed ? (
                      <CheckCircle className="w-5 h-5" />
                    ) : (
                      <BookOpen className="w-5 h-5" />
                    )}
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="font-medium text-[var(--foreground)] truncate">
                      {activity.title}
                    </p>
                    <p className="text-sm text-[var(--foreground-muted)] truncate">
                      {course.title} - {module.title}
                    </p>
                  </div>
                  <div className="text-right flex-shrink-0">
                    <p className="text-sm text-[var(--foreground-muted)]">
                      {timeAgo}
                    </p>
                    {item.completed && item.xp_earned > 0 && (
                      <p className="text-xs text-emerald-600 font-medium">
                        +{item.xp_earned} XP
                      </p>
                    )}
                  </div>
                </Link>
              );
            })}
          </div>
        ) : (
          <div className="text-center py-8 text-[var(--foreground-muted)]">
            <p>No activity yet.</p>
            <p className="text-sm mt-2">Start learning to see your progress here.</p>
          </div>
        )}
      </div>
    </div>
  );
}

function getTimeAgo(dateString: string): string {
  const date = new Date(dateString);
  const now = new Date();
  const diffMs = now.getTime() - date.getTime();
  const diffMins = Math.floor(diffMs / 60000);
  const diffHours = Math.floor(diffMs / 3600000);
  const diffDays = Math.floor(diffMs / 86400000);

  if (diffMins < 1) return "Just now";
  if (diffMins < 60) return `${diffMins}m ago`;
  if (diffHours < 24) return `${diffHours}h ago`;
  if (diffDays === 1) return "Yesterday";
  if (diffDays < 7) return `${diffDays}d ago`;
  
  return date.toLocaleDateString("en-US", { month: "short", day: "numeric" });
}

function StatCard({ label, value, color }: { label: string; value: string; color: "blue" | "green" | "purple" | "orange" }) {
  const colorClasses = {
    blue: "bg-blue-50 text-blue-600 border-blue-100",
    green: "bg-emerald-50 text-emerald-600 border-emerald-100",
    purple: "bg-purple-50 text-purple-600 border-purple-100",
    orange: "bg-orange-50 text-orange-600 border-orange-100",
  };

  return (
    <div className="card-elevated p-5 text-center">
      <p className={`text-2xl font-bold mb-1 ${colorClasses[color].split(' ')[1]}`} style={{ fontFamily: 'var(--font-heading)' }}>
        {value}
      </p>
      <p className="text-sm text-[var(--foreground-muted)]">{label}</p>
    </div>
  );
}
