import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { 
  BookOpen, 
  ChevronRight,
  Target,
  Sparkles,
  Trophy,
  Play,
  GraduationCap
} from "lucide-react";

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
  const { data: { user } } = await supabase.auth.getUser();
  
  // Get user's enrolled courses with progress
  let enrolledCourses: CourseWithProgress[] = [];
  if (user) {
    const { data: coursesData } = await supabase
      .rpc("get_user_enrolled_courses", { p_user_id: user.id });
    enrolledCourses = coursesData || [];
  }

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
                <EnrolledCourseCard key={course.course_id} course={course} />
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

function EnrolledCourseCard({ course }: { course: CourseWithProgress }) {
  return (
    <Link
      href={`/courses/${course.course_slug}/learn`}
      className="group block card-elevated p-6 hover:shadow-lg transition-all"
    >
      <div className="flex flex-col lg:flex-row lg:items-center gap-6">
        {/* Course Icon */}
        <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-[var(--primary)]/10 to-blue-500/10 flex items-center justify-center flex-shrink-0">
          <GraduationCap className="w-8 h-8 text-[var(--primary)]" />
        </div>

        {/* Course Info */}
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-2">
            <span className={`px-2 py-0.5 text-xs font-medium rounded-full capitalize
              ${course.course_difficulty === 'beginner' ? 'bg-emerald-100 text-emerald-700' :
                course.course_difficulty === 'intermediate' ? 'bg-amber-100 text-amber-700' :
                'bg-rose-100 text-rose-700'
              }
            `}>
              {course.course_difficulty}
            </span>
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
        <div className="flex-shrink-0">
          <div className="flex items-center gap-2 px-4 py-2 bg-[var(--primary)] text-white rounded-lg group-hover:bg-[var(--primary-hover)] transition-colors">
            <Play className="w-4 h-4" />
            <span className="font-medium">Continue</span>
            <ChevronRight className="w-4 h-4" />
          </div>
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
  return (
    <Link
      href={`/courses/${course.slug}/learn`}
      className="group block card-elevated p-6 hover:shadow-lg transition-all"
    >
      <div className="flex items-center gap-2 mb-3">
        <span className={`px-2 py-0.5 text-xs font-medium rounded-full capitalize
          ${course.difficulty === 'beginner' ? 'bg-emerald-100 text-emerald-700' :
            course.difficulty === 'intermediate' ? 'bg-amber-100 text-amber-700' :
            'bg-rose-100 text-rose-700'
          }
        `}>
          {course.difficulty}
        </span>
      </div>

      <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-[var(--primary)]/10 to-blue-500/10 flex items-center justify-center mb-4">
        <GraduationCap className="w-6 h-6 text-[var(--primary)]" />
      </div>

      <h3 
        className="text-lg font-bold text-[var(--foreground)] mb-2 group-hover:text-[var(--primary)] transition-colors"
        style={{ fontFamily: 'var(--font-heading)' }}
      >
        {course.title}
      </h3>
      
      <p className="text-sm text-[var(--foreground-muted)] mb-4 line-clamp-2">
        {course.short_description || course.description}
      </p>

      <div className="flex items-center justify-between text-sm text-[var(--foreground-muted)]">
        <span className="flex items-center gap-1">
          <Target className="w-4 h-4" />
          {course.total_skills} skills
        </span>
        <span className="flex items-center gap-1 text-[var(--primary)] group-hover:translate-x-1 transition-transform">
          Start Learning
          <ChevronRight className="w-4 h-4" />
        </span>
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
