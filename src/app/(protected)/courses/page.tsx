import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { 
  BookOpen, 
  Clock, 
  ChevronRight,
  Zap,
  Lock,
  Search,
  Trophy
} from "lucide-react";
import type { Course, Category, Module } from "@/lib/database.types";

export const metadata = {
  title: "Courses | Tutorio",
  description: "Browse all available courses",
};

export default async function CoursesPage() {
  const supabase = await createClient();
  
  // Fetch courses with their modules and categories
  const { data: courses, error } = await supabase
    .from("courses")
    .select(`
      *,
      category:categories(*),
      modules(id, total_xp, estimated_minutes, required_plan)
    `)
    .eq("is_published", true)
    .order("sort_order");

  if (error) {
    console.error("Failed to fetch courses:", error);
  }

  // Fetch categories for filters
  const { data: categories } = await supabase
    .from("categories")
    .select("*")
    .order("sort_order");

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Header */}
      <div className="mb-8">
        <h1 
          className="text-3xl font-bold mb-2 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Course Library
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Explore our comprehensive collection of courses designed for learning success.
        </p>
      </div>

      {/* Search and Filters */}
      <div className="flex flex-col sm:flex-row gap-4 mb-8">
        {/* Search */}
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-[var(--foreground-muted)]" />
          <input
            type="text"
            placeholder="Search courses..."
            className="w-full pl-10 pr-4 py-2.5 rounded-xl border border-[var(--border)] bg-white text-[var(--foreground)] placeholder:text-[var(--foreground-muted)] focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent transition-all"
          />
        </div>
      </div>

      {/* Category Filters */}
      <div className="flex flex-wrap gap-2 mb-8">
        <FilterButton active>All Courses</FilterButton>
        {categories?.map((category) => (
          <FilterButton key={category.id}>{category.name}</FilterButton>
        ))}
      </div>

      {/* Course Grid */}
      {courses && courses.length > 0 ? (
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {courses.map((course) => (
            <CourseCard 
              key={course.id} 
              course={course as Course & { category: Category | null; modules: Module[] }} 
            />
          ))}
        </div>
      ) : (
        <div className="text-center py-16">
          <div className="w-16 h-16 bg-slate-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <BookOpen className="w-8 h-8 text-slate-400" />
          </div>
          <h3 className="text-lg font-semibold text-[var(--foreground)] mb-2">
            No courses available
          </h3>
          <p className="text-[var(--foreground-muted)]">
            Check back soon for new courses.
          </p>
        </div>
      )}
    </div>
  );
}

function FilterButton({ 
  children, 
  active = false 
}: { 
  children: React.ReactNode; 
  active?: boolean;
}) {
  return (
    <button
      className={`px-4 py-2 rounded-lg text-sm font-medium transition-all ${
        active
          ? "bg-[var(--primary)] text-white shadow-md shadow-[var(--primary)]/25"
          : "bg-white border border-[var(--border)] text-[var(--foreground-muted)] hover:text-[var(--primary)] hover:border-[var(--primary)]"
      }`}
    >
      {children}
    </button>
  );
}

const colorClasses: Record<string, { bg: string; text: string }> = {
  blue: { bg: "bg-blue-50", text: "text-blue-600" },
  purple: { bg: "bg-purple-50", text: "text-purple-600" },
  green: { bg: "bg-emerald-50", text: "text-emerald-600" },
  orange: { bg: "bg-orange-50", text: "text-orange-600" },
  rose: { bg: "bg-rose-50", text: "text-rose-600" },
  cyan: { bg: "bg-cyan-50", text: "text-cyan-600" },
};

const difficultyConfig: Record<string, { label: string; color: string }> = {
  beginner: { label: "Beginner", color: "text-emerald-600 bg-emerald-50" },
  intermediate: { label: "Intermediate", color: "text-amber-600 bg-amber-50" },
  advanced: { label: "Advanced", color: "text-rose-600 bg-rose-50" },
};

interface CourseCardProps {
  course: Course & { 
    category: Category | null; 
    modules: Pick<Module, 'id' | 'total_xp' | 'estimated_minutes' | 'required_plan'>[];
  };
}

function CourseCard({ course }: CourseCardProps) {
  const category = course.category;
  const colors = colorClasses[category?.color || 'blue'] || colorClasses.blue;
  const difficulty = difficultyConfig[course.difficulty] || difficultyConfig.beginner;
  
  // Calculate totals from modules
  const totalXp = course.modules.reduce((sum, m) => sum + (m.total_xp || 0), 0);
  const totalMinutes = course.modules.reduce((sum, m) => sum + (m.estimated_minutes || 0), 0);
  const totalHours = Math.round(totalMinutes / 60);
  const modulesCount = course.modules.length;
  
  // Check if course has free content
  const hasFreeContent = course.modules.some(m => m.required_plan === 'free');

  return (
    <Link
      href={`/courses/${course.slug}`}
      className="group card-elevated p-6 hover:scale-[1.02] transition-all duration-300 flex flex-col"
    >
      {/* Header: Badges */}
      <div className="flex items-center justify-between mb-4">
        <span className={`px-2.5 py-1 text-xs font-medium rounded-full ${difficulty.color}`}>
          {difficulty.label}
        </span>
        {hasFreeContent ? (
          <span className="flex items-center gap-1 px-2.5 py-1 text-xs font-medium rounded-full bg-emerald-50 text-emerald-600">
            <Zap className="w-3 h-3" />
            Free Preview
          </span>
        ) : (
          <span className="flex items-center gap-1 px-2.5 py-1 text-xs font-medium rounded-full bg-slate-100 text-slate-600">
            <Lock className="w-3 h-3" />
            Premium
          </span>
        )}
      </div>

      {/* Category Icon */}
      <div className={`w-12 h-12 rounded-xl ${colors.bg} flex items-center justify-center mb-4`}>
        <BookOpen className={`w-5 h-5 ${colors.text}`} />
      </div>

      {/* Category Label */}
      {category && (
        <p className="text-xs text-[var(--primary)] font-semibold uppercase tracking-wider mb-2">
          {category.name}
        </p>
      )}

      {/* Title */}
      <h3 
        className="text-lg font-semibold mb-2 text-[var(--foreground)] group-hover:text-[var(--primary)] transition-colors line-clamp-2"
        style={{ fontFamily: 'var(--font-heading)' }}
      >
        {course.title}
      </h3>

      {/* Description */}
      <p className="text-sm text-[var(--foreground-muted)] mb-4 line-clamp-2 flex-1">
        {course.short_description || course.description}
      </p>

      {/* Stats */}
      <div className="flex items-center gap-4 text-sm text-[var(--foreground-muted)] mb-4">
        <span className="flex items-center gap-1">
          <Clock className="w-4 h-4" />
          {totalHours}h
        </span>
        <span className="flex items-center gap-1">
          <BookOpen className="w-4 h-4" />
          {modulesCount} modules
        </span>
        <span className="flex items-center gap-1">
          <Trophy className="w-4 h-4" />
          {totalXp.toLocaleString()} XP
        </span>
      </div>

      {/* Footer */}
      <div className="flex items-center justify-between pt-4 border-t border-[var(--border)]">
        <span className="text-sm font-medium text-[var(--primary)]">
          Start Learning
        </span>
        <ChevronRight className="w-5 h-5 text-[var(--foreground-muted)] group-hover:text-[var(--primary)] group-hover:translate-x-1 transition-all" />
      </div>
    </Link>
  );
}
