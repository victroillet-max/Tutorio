import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { 
  BookOpen, 
  ChevronRight,
  Target,
  ArrowLeft,
  Sparkles,
  ArrowRight,
  Clock
} from "lucide-react";
import { CourseIcon } from "@/components/courses/course-icon";

export const metadata = {
  title: "Explore Courses | Tutorio",
  description: "Browse our course library and start learning today",
};

interface Course {
  id: string;
  slug: string;
  title: string;
  description: string;
  short_description: string;
  difficulty: string;
  total_skills: number;
  total_foundations: number;
}

export default async function ExplorePage() {
  const supabase = await createClient();
  
  // Check if user is logged in (but don't require it)
  const { data: { user } } = await supabase.auth.getUser();
  
  // Get all published courses
  const { data: coursesData } = await supabase
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

  // Count skills and foundations for each course
  const courses: Course[] = [];
  
  for (const course of (coursesData || [])) {
    const { count: skillsCount } = await supabase
      .from("skills")
      .select("id", { count: "exact", head: true })
      .eq("course_id", course.id)
      .eq("is_active", true)
      .neq("category", "ct_foundations");
    
    const { count: foundationsCount } = await supabase
      .from("skills")
      .select("id", { count: "exact", head: true })
      .eq("course_id", course.id)
      .eq("is_active", true)
      .eq("category", "ct_foundations");
    
    courses.push({
      ...course,
      total_skills: skillsCount || 0,
      total_foundations: foundationsCount || 0
    });
  }

  return (
    <div className="min-h-screen bg-[var(--background)]">
      {/* Header */}
      <header className="bg-white/95 backdrop-blur-xl border-b border-[var(--card-border)] sticky top-0 z-50">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            <Link href="/" className="flex items-center gap-3 group">
              <div className="w-10 h-10 rounded-xl bg-[var(--primary)] flex items-center justify-center transition-transform group-hover:rotate-[-5deg] group-hover:scale-105">
                <BookOpen className="w-5 h-5 text-white" />
              </div>
              <span 
                className="text-lg font-bold tracking-tight text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                Tutorio
              </span>
            </Link>
            
            <div className="flex items-center gap-4">
              {user ? (
                <Link
                  href="/dashboard"
                  className="px-5 py-2.5 bg-[var(--primary)] text-white text-sm font-semibold rounded-xl hover:bg-[var(--primary-light)] transition-all shadow-md shadow-[var(--primary)]/25"
                >
                  Go to Dashboard
                </Link>
              ) : (
                <>
                  <Link
                    href="/login"
                    className="text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors font-medium"
                  >
                    Sign In
                  </Link>
                  <Link
                    href="/signup"
                    className="px-5 py-2.5 bg-[var(--accent)] text-white text-sm font-semibold rounded-xl hover:bg-[var(--accent-dark)] transition-all shadow-md shadow-[var(--accent)]/30"
                  >
                    Get Started Free
                  </Link>
                </>
              )}
            </div>
          </div>
        </div>
      </header>

      {/* Content */}
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        {/* Back Link */}
        <Link 
          href="/"
          className="inline-flex items-center gap-1.5 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors mb-8 font-medium"
        >
          <ArrowLeft className="w-4 h-4" />
          Back to Home
        </Link>

        {/* Header */}
        <div className="mb-10">
          <h1 
            className="text-4xl font-bold text-[var(--foreground)] mb-3"
            style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
          >
            Explore Courses
          </h1>
          <p className="text-lg text-[var(--foreground-muted)]">
            Browse our complete course library. Sign up free to start learning!
          </p>
        </div>

        {/* Courses Grid */}
        {courses.length > 0 ? (
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-7">
            {courses.map((course) => (
              <CourseCard 
                key={course.id} 
                course={course} 
                isLoggedIn={!!user} 
              />
            ))}
          </div>
        ) : (
          <div className="text-center py-20 bg-white rounded-2xl border border-[var(--card-border)]">
            <div className="w-18 h-18 mx-auto mb-5 rounded-full bg-[var(--background-secondary)] flex items-center justify-center w-[72px] h-[72px]">
              <BookOpen className="w-9 h-9 text-[var(--foreground-muted)]" />
            </div>
            <h3 
              className="text-xl font-bold text-[var(--foreground)] mb-2"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              No Courses Available
            </h3>
            <p className="text-[var(--foreground-muted)]">
              Check back soon for new learning opportunities.
            </p>
          </div>
        )}

        {/* CTA Section */}
        {!user && courses.length > 0 && (
          <div className="mt-16 text-center cta-section rounded-[28px] p-12 relative overflow-hidden">
            <div className="relative z-10">
              <h2 
                className="text-3xl font-bold mb-4 text-white"
                style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
              >
                Ready to Start Learning?
              </h2>
              <p className="text-white/80 mb-8 max-w-md mx-auto text-lg">
                Create your free account and get instant access to our course library.
              </p>
              <Link
                href="/signup"
                className="inline-flex items-center gap-2 px-7 py-4 bg-white text-[var(--primary)] font-semibold rounded-xl hover:bg-[var(--background)] transition-all shadow-lg"
              >
                Sign Up Free
                <ArrowRight className="w-5 h-5" />
              </Link>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

function CourseCard({ course, isLoggedIn }: { course: Course; isLoggedIn: boolean }) {
  const totalContent = course.total_skills + course.total_foundations;
  // Estimate hours based on content (roughly 45 min per skill)
  const estimatedHours = Math.max(Math.round(totalContent * 0.75), 10);
  
  return (
    <div className="group bg-white rounded-2xl border border-[var(--card-border)] p-7 hover:shadow-xl transition-all duration-300 relative">
      {/* Free Preview Badge */}
      <div className="absolute top-5 right-5">
        <span className="inline-flex items-center gap-1 px-2.5 py-1 text-xs font-semibold rounded-full bg-[var(--success-light)] text-[var(--success)]">
          <Sparkles className="w-3 h-3" />
          Free Preview
        </span>
      </div>

      {/* Course Icon */}
      <div className="mb-5">
        <CourseIcon courseSlug={course.slug} size="lg" />
      </div>

      <h3 
        className="text-xl font-bold text-[var(--foreground)] mb-3 group-hover:text-[var(--primary)] transition-colors pr-16"
        style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.01em' }}
      >
        {course.title}
      </h3>
      
      <p className="text-sm text-[var(--foreground-muted)] mb-5 line-clamp-2 leading-relaxed">
        {course.short_description || course.description}
      </p>

      {/* Course Stats */}
      <div className="flex items-center gap-4 text-xs text-[var(--foreground-muted)] mb-5 pb-5 border-b border-[var(--card-border)]">
        <span className="flex items-center gap-1.5">
          <Target className="w-4 h-4 text-[var(--primary)]" />
          {totalContent} skills
        </span>
        <span className="flex items-center gap-1.5">
          <Clock className="w-4 h-4 text-[var(--foreground-muted)]" />
          {estimatedHours} hours
        </span>
      </div>

      {/* CTA */}
      <Link
        href={isLoggedIn ? `/courses/${course.slug}/learn` : `/explore/${course.slug}`}
        className="flex items-center justify-between w-full px-5 py-3 bg-[var(--background)] rounded-xl text-sm font-semibold text-[var(--foreground)] group-hover:bg-[var(--accent)] group-hover:text-white transition-all"
      >
        <span>{isLoggedIn ? 'Start Learning' : 'View Course'}</span>
        <ChevronRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
      </Link>
    </div>
  );
}
