import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { 
  BookOpen, 
  ChevronRight,
  Target,
  Sparkles,
  Trophy,
  Play,
  Zap,
  Crown,
  Clock
} from "lucide-react";
import type { UserCourseSubscription } from "@/lib/database.types";
import { UpgradeButton } from "@/components/courses/upgrade-button";
import { CourseIcon } from "@/components/courses/course-icon";

// Force dynamic rendering to ensure subscription data is always fresh
export const dynamic = "force-dynamic";

export const metadata = {
  title: "My Courses | Tutorio",
  description: "Your enrolled courses and learning progress",
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

interface AvailableCourse {
  id: string;
  slug: string;
  title: string;
  description: string;
  short_description: string;
  difficulty: string;
  total_skills: number;
}

export default async function CoursesPage() {
  const supabase = await createClient();
  const { data: { user }, error: userError } = await supabase.auth.getUser();
  
  if (userError) {
    console.error("Error getting user:", userError);
  }
  
  // Get user's enrolled courses with progress and subscriptions in parallel
  let enrolledCourses: CourseWithProgress[] = [];
  let subscriptions: UserCourseSubscription[] = [];
  
  if (user) {
    const [coursesResult, subsResult] = await Promise.all([
      supabase.rpc("get_user_enrolled_courses", { p_user_id: user.id }),
      supabase.rpc("get_user_subscriptions", { p_user_id: user.id }),
    ]);
    
    if (coursesResult.error) {
      console.error("Error fetching enrolled courses:", coursesResult.error);
    }
    if (subsResult.error) {
      console.error("Error fetching subscriptions:", subsResult.error);
    }
    
    enrolledCourses = coursesResult.data || [];
    subscriptions = subsResult.data || [];
  }
  
  // Create a map of course subscriptions
  const subscriptionMap = new Map<string, UserCourseSubscription>();
  subscriptions.forEach(sub => {
    if (sub.status === 'active' || sub.status === 'trialing') {
      subscriptionMap.set(sub.course_id, sub);
    }
  });

  // Get all available courses (that user hasn't enrolled in)
  const enrolledIds = enrolledCourses.map(c => c.course_id);
  
  const { data: availableCoursesData } = await supabase
    .from("courses")
    .select(`
      id,
      slug,
      title,
      description,
      short_description,
      difficulty
    `)
    .eq("is_published", true)
    .order("sort_order");

  // Filter out already enrolled courses and count skills per course
  const availableCourses: AvailableCourse[] = [];
  
  for (const course of (availableCoursesData || [])) {
    if (!enrolledIds.includes(course.id)) {
      // Count skills for this course
      const { count } = await supabase
        .from("skills")
        .select("id", { count: "exact", head: true })
        .eq("course_id", course.id)
        .eq("is_active", true);
      
      availableCourses.push({
        ...course,
        total_skills: count || 0
      });
    }
  }

  const hasEnrolledCourses = enrolledCourses.length > 0;
  const hasAvailableCourses = availableCourses.length > 0;

  return (
    <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Header */}
      <div className="mb-8">
        <h1 
          className="text-3xl font-bold text-[var(--foreground)] mb-2"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          My Courses
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Your learning journey across all enrolled courses
        </p>
      </div>

      <div className="space-y-12">
        {/* Enrolled Courses */}
        {hasEnrolledCourses && (
          <section>
            <h2 
              className="text-xl font-bold text-[var(--foreground)] mb-6"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Continue Learning
            </h2>

            <div className="grid gap-6">
              {enrolledCourses.map((course) => (
                <EnrolledCourseCard 
                  key={course.course_id} 
                  course={course} 
                  subscription={subscriptionMap.get(course.course_id)}
                />
              ))}
            </div>
          </section>
        )}

        {/* Available Courses */}
        {hasAvailableCourses && (
          <section>
            <h2 
              className="text-xl font-bold text-[var(--foreground)] mb-6"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              {hasEnrolledCourses ? 'Explore More Courses' : 'Available Courses'}
            </h2>

            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
              {availableCourses.map((course) => (
                <AvailableCourseCard key={course.id} course={course} />
              ))}
            </div>
          </section>
        )}

        {/* Empty State */}
        {!hasEnrolledCourses && !hasAvailableCourses && (
          <div className="text-center py-16">
            <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-slate-100 flex items-center justify-center">
              <BookOpen className="w-8 h-8 text-slate-400" />
            </div>
            <h3 className="text-lg font-semibold text-[var(--foreground)] mb-2">No Courses Available</h3>
            <p className="text-[var(--foreground-muted)]">
              Check back soon for new learning opportunities.
            </p>
          </div>
        )}
      </div>
    </div>
  );
}

function EnrolledCourseCard({ 
  course, 
  subscription 
}: { 
  course: CourseWithProgress;
  subscription?: UserCourseSubscription;
}) {
  const tierConfig = {
    basic: { label: "Basic", icon: Zap, bgColor: "bg-blue-100", textColor: "text-blue-700" },
    advanced: { label: "Advanced", icon: Crown, bgColor: "bg-[var(--accent)]/10", textColor: "text-[var(--accent)]" },
  };
  
  const tier = subscription?.tier_slug as 'basic' | 'advanced' | undefined;
  const tierInfo = tier ? tierConfig[tier] : null;
  const TierIcon = tierInfo?.icon;
  const isFree = !subscription;
  
  return (
    <Link
      href={`/courses/${course.course_slug}/learn`}
      className="group block card-elevated p-6 hover:shadow-lg transition-all"
    >
      <div className="flex flex-col lg:flex-row lg:items-center gap-6">
        {/* Course Icon */}
        <CourseIcon courseSlug={course.course_slug} size="xl" />

        {/* Course Info */}
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-2 flex-wrap">
            {/* Subscription Badge - Primary badge showing user's plan */}
            {tierInfo && TierIcon ? (
              <span className={`inline-flex items-center gap-1 px-2 py-0.5 text-xs font-medium rounded-full ${tierInfo.bgColor} ${tierInfo.textColor}`}>
                <TierIcon className="w-3 h-3" />
                {tierInfo.label} Plan
              </span>
            ) : (
              <span className="px-2 py-0.5 text-xs font-medium rounded-full bg-slate-100 text-slate-600">
                Free Demo
              </span>
            )}
            
            <span className="text-xs text-[var(--foreground-muted)]">
              Last accessed {formatTimeAgo(course.last_accessed_at)}
            </span>
          </div>
          
          <h3 
            className="text-xl font-bold text-[var(--foreground)] mb-2 group-hover:text-[var(--primary)] transition-colors"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            {course.course_title}
          </h3>
          
          <p className="text-sm text-[var(--foreground-muted)] line-clamp-2">
            {course.course_short_description || course.course_description}
          </p>
        </div>

        {/* Progress Section */}
        <div className="flex flex-col sm:flex-row lg:flex-col gap-4 lg:w-64">
          {/* Overall Progress */}
          <div className="flex-1 bg-[var(--background-secondary)] rounded-xl p-4">
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm font-medium text-[var(--foreground)]">Progress</span>
              <span className="text-lg font-bold text-[var(--primary)]">
                {course.overall_progress_percent}%
              </span>
            </div>
            <div className="h-2 bg-slate-200 rounded-full overflow-hidden">
              <div 
                className="h-full rounded-full bg-gradient-to-r from-[var(--primary)] to-blue-500 transition-all"
                style={{ width: `${course.overall_progress_percent}%` }}
              />
            </div>
          </div>

          {/* Skills Breakdown */}
          <div className="flex gap-3">
            <div className="flex-1 bg-amber-50 rounded-xl p-3 text-center">
              <Sparkles className="w-4 h-4 text-amber-600 mx-auto mb-1" />
              <p className="text-lg font-bold text-[var(--foreground)]">
                {course.foundations_mastered}/{course.foundations_total}
              </p>
              <p className="text-xs text-[var(--foreground-muted)]">Foundations</p>
            </div>
            <div className="flex-1 bg-blue-50 rounded-xl p-3 text-center">
              <Target className="w-4 h-4 text-blue-600 mx-auto mb-1" />
              <p className="text-lg font-bold text-[var(--foreground)]">
                {course.skills_mastered}/{course.skills_total}
              </p>
              <p className="text-xs text-[var(--foreground-muted)]">Skills</p>
            </div>
          </div>
        </div>

        {/* Action */}
        <div className="flex-shrink-0 flex flex-col gap-2">
          <div className="flex items-center gap-2 px-4 py-2 bg-[var(--primary)] text-white rounded-lg group-hover:bg-[var(--primary-hover)] transition-colors">
            <Play className="w-4 h-4" />
            <span className="font-medium">Continue</span>
            <ChevronRight className="w-4 h-4" />
          </div>
          
          {/* Upgrade CTA for free users */}
          {isFree && (
            <UpgradeButton courseSlug={course.course_slug} />
          )}
        </div>
      </div>

      {/* Completion Status */}
      {course.overall_progress_percent === 100 && (
        <div className="mt-4 pt-4 border-t border-[var(--border)] flex items-center gap-2 text-emerald-600">
          <Trophy className="w-4 h-4" />
          <span className="text-sm font-medium">Course Completed!</span>
        </div>
      )}
    </Link>
  );
}

function AvailableCourseCard({ course }: { course: AvailableCourse }) {
  // Estimate hours based on skills (roughly 1 hour per skill)
  const estimatedHours = Math.max(Math.round(course.total_skills * 1.2), 10);
  
  return (
    <Link
      href={`/courses/${course.slug}/learn`}
      className="group block card-elevated p-6 hover:shadow-lg transition-all relative"
    >
      {/* Free Preview Badge - positioned top right */}
      <div className="absolute top-4 right-4">
        <span className="inline-flex items-center gap-1 px-2.5 py-1 text-xs font-semibold rounded-full bg-[var(--success-light)] text-[var(--success)]">
          <Sparkles className="w-3 h-3" />
          Free Preview
        </span>
      </div>

      {/* Course Icon */}
      <div className="mb-4">
        <CourseIcon courseSlug={course.slug} size="lg" />
      </div>

      <h3 
        className="text-lg font-bold text-[var(--foreground)] mb-2 group-hover:text-[var(--primary)] transition-colors pr-20"
        style={{ fontFamily: 'var(--font-heading)' }}
      >
        {course.title}
      </h3>
      
      <p className="text-sm text-[var(--foreground-muted)] mb-4 line-clamp-2">
        {course.short_description || course.description}
      </p>

      {/* Stats row */}
      <div className="flex items-center gap-4 text-xs text-[var(--foreground-muted)] mb-4">
        <span className="flex items-center gap-1">
          <Target className="w-3.5 h-3.5" />
          {course.total_skills} skills
        </span>
        <span className="flex items-center gap-1">
          <Clock className="w-3.5 h-3.5" />
          {estimatedHours} hours
        </span>
      </div>

      {/* CTA */}
      <div className="flex items-center gap-1 text-sm font-semibold text-[var(--accent)] group-hover:text-[var(--accent-dark)] transition-colors">
        <span>Start Learning</span>
        <ChevronRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
      </div>
    </Link>
  );
}

function formatTimeAgo(dateString: string): string {
  const date = new Date(dateString);
  const now = new Date();
  const seconds = Math.floor((now.getTime() - date.getTime()) / 1000);
  
  if (seconds < 60) return "just now";
  if (seconds < 3600) return `${Math.floor(seconds / 60)}m ago`;
  if (seconds < 86400) return `${Math.floor(seconds / 3600)}h ago`;
  if (seconds < 604800) return `${Math.floor(seconds / 86400)}d ago`;
  return date.toLocaleDateString();
}
