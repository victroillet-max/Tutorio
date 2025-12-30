import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { 
  BookOpen, 
  ChevronRight,
  Target,
  GraduationCap,
  ArrowLeft,
  Sparkles,
  ArrowRight,
  Star
} from "lucide-react";

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

// Accent colors for courses
const courseAccents = ['coral', 'teal', 'gold', 'navy', 'purple', 'rose'];
const accentClasses: Record<string, { icon: string; border: string }> = {
  coral: { 
    icon: "bg-gradient-to-br from-[#e76f51] to-[#f4a261] text-white", 
    border: "hover:border-t-[#e76f51]"
  },
  teal: { 
    icon: "bg-gradient-to-br from-[#2a9d8f] to-[#40c9b4] text-white", 
    border: "hover:border-t-[#2a9d8f]"
  },
  gold: { 
    icon: "bg-gradient-to-br from-[#e9c46a] to-[#f4d58d] text-[#8a6d2e]", 
    border: "hover:border-t-[#e9c46a]"
  },
  navy: { 
    icon: "bg-gradient-to-br from-[#1e3a5f] to-[#2d5a8b] text-white", 
    border: "hover:border-t-[#1e3a5f]"
  },
  purple: { 
    icon: "bg-gradient-to-br from-[#7c3aed] to-[#a78bfa] text-white", 
    border: "hover:border-t-[#7c3aed]"
  },
  rose: { 
    icon: "bg-gradient-to-br from-[#f43f5e] to-[#fb7185] text-white", 
    border: "hover:border-t-[#f43f5e]"
  },
};

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
            {courses.map((course, index) => (
              <CourseCard 
                key={course.id} 
                course={course} 
                isLoggedIn={!!user} 
                accent={courseAccents[index % courseAccents.length]}
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

function CourseCard({ course, isLoggedIn, accent }: { course: Course; isLoggedIn: boolean; accent: string }) {
  const totalContent = course.total_skills + course.total_foundations;
  const colors = accentClasses[accent] || accentClasses.coral;
  
  return (
    <div className={`group bg-white rounded-2xl border border-[var(--card-border)] p-7 hover:shadow-xl transition-all duration-300 border-t-4 border-t-transparent ${colors.border}`}>
      <div className="flex items-center gap-2 mb-4">
        <span className={`px-3 py-1 text-xs font-semibold rounded-full capitalize
          ${course.difficulty === 'beginner' ? 'bg-[var(--success-light)] text-[var(--success)]' :
            course.difficulty === 'intermediate' ? 'bg-amber-100 text-amber-700' :
            'bg-rose-100 text-rose-700'
          }
        `}>
          {course.difficulty}
        </span>
      </div>

      <div className={`w-14 h-14 rounded-2xl ${colors.icon} flex items-center justify-center mb-5 relative`}>
        <GraduationCap className="w-7 h-7" />
        <div className={`absolute inset-[-4px] rounded-[18px] ${colors.icon} opacity-20 -z-10`} />
      </div>

      <h3 
        className="text-xl font-bold text-[var(--foreground)] mb-3 group-hover:text-[var(--primary)] transition-colors"
        style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.01em' }}
      >
        {course.title}
      </h3>
      
      <p className="text-sm text-[var(--foreground-muted)] mb-5 line-clamp-2 leading-relaxed">
        {course.short_description || course.description}
      </p>

      {/* Course Stats */}
      <div className="flex items-center gap-4 text-xs text-[var(--foreground-muted)] mb-5 pb-5 border-b border-[var(--card-border)]">
        {course.total_foundations > 0 && (
          <span className="flex items-center gap-1.5">
            <Sparkles className="w-4 h-4 text-amber-500" />
            {course.total_foundations} foundations
          </span>
        )}
        <span className="flex items-center gap-1.5">
          <Target className="w-4 h-4 text-[var(--primary)]" />
          {course.total_skills} skills
        </span>
      </div>

      {/* CTA */}
      <Link
        href={isLoggedIn ? `/courses/${course.slug}/learn` : `/explore/${course.slug}`}
        className="flex items-center justify-between w-full px-5 py-3 bg-[var(--background)] rounded-xl text-sm font-semibold text-[var(--foreground)] group-hover:bg-[var(--primary)] group-hover:text-white transition-all"
      >
        <span>{isLoggedIn ? 'Start Learning' : 'View Course'}</span>
        <ChevronRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
      </Link>
    </div>
  );
}
