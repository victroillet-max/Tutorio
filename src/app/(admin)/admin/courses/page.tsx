import { 
  GraduationCap, 
  BookOpen, 
  Users,
  Trophy,
  Clock,
  Eye,
  EyeOff,
  Star,
  ChevronRight,
  Plus,
  Layers
} from "lucide-react";
import Link from "next/link";
import { getCourses, type AdminCourse } from "@/lib/admin/actions";

export const metadata = {
  title: "Courses | Admin Dashboard",
  description: "Manage all courses and content",
};

export default async function CoursesPage() {
  const courses = await getCourses();
  
  const publishedCount = courses.filter(c => c.is_published).length;
  const totalEnrollments = courses.reduce((sum, c) => sum + c.enrollments_count, 0);
  const totalXp = courses.reduce((sum, c) => sum + c.total_xp, 0);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 
            className="text-2xl font-bold text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Courses
          </h1>
          <p className="text-[var(--foreground-muted)]">
            Manage all courses, modules, and activities
          </p>
        </div>
        <button className="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-[var(--primary)] text-white text-sm font-medium hover:bg-[var(--primary-dark)] transition-colors">
          <Plus className="w-4 h-4" />
          Add Course
        </button>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <StatCard 
          icon={GraduationCap} 
          label="Total Courses" 
          value={courses.length}
          color="blue" 
        />
        <StatCard 
          icon={Eye} 
          label="Published" 
          value={publishedCount}
          color="green" 
        />
        <StatCard 
          icon={Users} 
          label="Total Enrollments" 
          value={totalEnrollments}
          color="purple" 
        />
        <StatCard 
          icon={Trophy} 
          label="Total XP Available" 
          value={totalXp.toLocaleString()}
          color="orange" 
        />
      </div>

      {/* Courses Grid */}
      {courses.length > 0 ? (
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {courses.map((course) => (
            <CourseCard key={course.id} course={course} />
          ))}
        </div>
      ) : (
        <div className="card-elevated p-12 text-center">
          <div className="w-16 h-16 mx-auto mb-4 rounded-2xl bg-slate-100 flex items-center justify-center">
            <GraduationCap className="w-8 h-8 text-slate-400" />
          </div>
          <h3 className="text-lg font-semibold text-[var(--foreground)] mb-2">
            No courses yet
          </h3>
          <p className="text-[var(--foreground-muted)] mb-6">
            Create your first course to get started.
          </p>
          <button className="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-[var(--primary)] text-white text-sm font-medium hover:bg-[var(--primary-dark)] transition-colors">
            <Plus className="w-4 h-4" />
            Create Course
          </button>
        </div>
      )}
    </div>
  );
}

const colorClasses = {
  blue: "bg-blue-50 text-blue-600",
  green: "bg-emerald-50 text-emerald-600",
  purple: "bg-purple-50 text-purple-600",
  orange: "bg-orange-50 text-orange-600",
};

function StatCard({
  icon: Icon,
  label,
  value,
  color,
}: {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  value: string | number;
  color: keyof typeof colorClasses;
}) {
  return (
    <div className="bg-white border border-[var(--border)] rounded-xl p-4 flex items-center gap-3">
      <div className={`w-10 h-10 rounded-lg ${colorClasses[color]} flex items-center justify-center flex-shrink-0`}>
        <Icon className="w-5 h-5" />
      </div>
      <div>
        <p className="text-xl font-bold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
          {value}
        </p>
        <p className="text-xs text-[var(--foreground-muted)]">{label}</p>
      </div>
    </div>
  );
}

const difficultyColors = {
  beginner: "bg-emerald-100 text-emerald-700",
  intermediate: "bg-amber-100 text-amber-700",
  advanced: "bg-rose-100 text-rose-700",
};

function CourseCard({ course }: { course: AdminCourse }) {
  const difficultyColor = difficultyColors[course.difficulty as keyof typeof difficultyColors] || difficultyColors.beginner;
  
  return (
    <Link
      href={`/admin/courses/${course.slug}`}
      className="card-elevated p-6 hover:shadow-lg transition-all group flex flex-col"
    >
      {/* Header badges */}
      <div className="flex items-center justify-between mb-4">
        <span className={`px-2.5 py-1 text-xs font-medium rounded-full ${difficultyColor}`}>
          {course.difficulty}
        </span>
        <div className="flex items-center gap-2">
          {course.is_featured && (
            <span className="flex items-center gap-1 px-2 py-1 text-xs font-medium rounded-full bg-amber-50 text-amber-600">
              <Star className="w-3 h-3" />
              Featured
            </span>
          )}
          {course.is_published ? (
            <span className="flex items-center gap-1 px-2 py-1 text-xs font-medium rounded-full bg-emerald-50 text-emerald-600">
              <Eye className="w-3 h-3" />
              Published
            </span>
          ) : (
            <span className="flex items-center gap-1 px-2 py-1 text-xs font-medium rounded-full bg-slate-100 text-slate-600">
              <EyeOff className="w-3 h-3" />
              Draft
            </span>
          )}
        </div>
      </div>

      {/* Category */}
      {course.category && (
        <p className="text-xs text-[var(--primary)] font-semibold uppercase tracking-wider mb-2">
          {course.category.name}
        </p>
      )}

      {/* Title */}
      <h3 
        className="text-lg font-semibold mb-2 text-[var(--foreground)] group-hover:text-[var(--primary)] transition-colors"
        style={{ fontFamily: 'var(--font-heading)' }}
      >
        {course.title}
      </h3>

      {/* Description */}
      <p className="text-sm text-[var(--foreground-muted)] mb-4 line-clamp-2 flex-1">
        {course.description || "No description provided."}
      </p>

      {/* Stats Grid */}
      <div className="grid grid-cols-2 gap-3 mb-4 py-4 border-y border-[var(--border)]">
        <div className="flex items-center gap-2">
          <Layers className="w-4 h-4 text-[var(--foreground-muted)]" />
          <span className="text-sm text-[var(--foreground)]">
            <strong>{course.modules_count}</strong> modules
          </span>
        </div>
        <div className="flex items-center gap-2">
          <BookOpen className="w-4 h-4 text-[var(--foreground-muted)]" />
          <span className="text-sm text-[var(--foreground)]">
            <strong>{course.activities_count}</strong> activities
          </span>
        </div>
        <div className="flex items-center gap-2">
          <Users className="w-4 h-4 text-[var(--foreground-muted)]" />
          <span className="text-sm text-[var(--foreground)]">
            <strong>{course.enrollments_count}</strong> enrolled
          </span>
        </div>
        <div className="flex items-center gap-2">
          <Trophy className="w-4 h-4 text-[var(--foreground-muted)]" />
          <span className="text-sm text-[var(--foreground)]">
            <strong>{course.total_xp.toLocaleString()}</strong> XP
          </span>
        </div>
      </div>

      {/* Footer */}
      <div className="flex items-center justify-between">
        <span className="text-xs text-[var(--foreground-muted)]">
          Updated {new Date(course.updated_at).toLocaleDateString()}
        </span>
        <span className="flex items-center gap-1 text-sm font-medium text-[var(--primary)]">
          Manage
          <ChevronRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
        </span>
      </div>
    </Link>
  );
}

