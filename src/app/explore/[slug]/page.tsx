import { createClient } from "@/utils/supabase/server";
import { notFound } from "next/navigation";
import Link from "next/link";
import { 
  BookOpen, 
  ChevronRight,
  Target,
  GraduationCap,
  ArrowLeft,
  Sparkles,
  Clock,
  CheckCircle2,
  Lock,
  Play
} from "lucide-react";

interface CoursePreviewPageProps {
  params: Promise<{ slug: string }>;
}

export async function generateMetadata({ params }: CoursePreviewPageProps) {
  const { slug } = await params;
  const supabase = await createClient();
  
  const { data: course } = await supabase
    .from("courses")
    .select("title, short_description")
    .eq("slug", slug)
    .eq("is_published", true)
    .single();

  return {
    title: course ? `${course.title} | Tutorio` : "Course | Tutorio",
    description: course?.short_description || "Explore this course on Tutorio",
  };
}

export default async function CoursePreviewPage({ params }: CoursePreviewPageProps) {
  const { slug } = await params;
  const supabase = await createClient();
  
  // Check if user is logged in
  const { data: { user } } = await supabase.auth.getUser();
  
  // Get course details
  const { data: course, error: courseError } = await supabase
    .from("courses")
    .select("*")
    .eq("slug", slug)
    .eq("is_published", true)
    .single();

  if (courseError || !course) {
    notFound();
  }

  // Get skills grouped by category
  const { data: skillsData } = await supabase
    .from("skills")
    .select(`
      id,
      slug,
      name,
      category,
      sort_order
    `)
    .eq("course_id", course.id)
    .eq("is_active", true)
    .order("sort_order");

  const skills = skillsData || [];
  
  // Group skills by category
  const foundations = skills.filter(s => s.category === 'ct_foundations');
  const regularSkills = skills.filter(s => s.category !== 'ct_foundations');

  // Get sample activities (first 3 for preview)
  const sampleActivities: Array<{ title: string; type: string; minutes: number }> = [];
  if (skills.length > 0) {
    const { data: activities } = await supabase
      .from("activities")
      .select("title, type, minutes")
      .eq("is_published", true)
      .in("id", 
        await supabase
          .from("activity_skills")
          .select("activity_id")
          .in("skill_id", skills.slice(0, 2).map(s => s.id))
          .then(res => (res.data || []).map(a => a.activity_id))
      )
      .limit(5);
    
    if (activities) {
      sampleActivities.push(...activities);
    }
  }

  return (
    <div className="min-h-screen bg-[var(--background-secondary)]">
      {/* Header */}
      <header className="bg-white border-b border-[var(--border)] sticky top-0 z-50">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
          <div className="flex items-center justify-between">
            <Link href="/" className="flex items-center gap-2 group">
              <div className="w-9 h-9 rounded-lg bg-[var(--primary)] flex items-center justify-center transition-transform group-hover:scale-105">
                <BookOpen className="w-4 h-4 text-white" />
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
                  href={`/courses/${course.slug}/learn`}
                  className="px-4 py-2 bg-[var(--primary)] text-white text-sm font-semibold rounded-lg hover:bg-[var(--primary-dark)] transition-colors"
                >
                  Start Learning
                </Link>
              ) : (
                <>
                  <Link
                    href="/login"
                    className="text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors"
                  >
                    Sign In
                  </Link>
                  <Link
                    href={`/signup?course=${course.slug}`}
                    className="px-4 py-2 bg-[var(--primary)] text-white text-sm font-semibold rounded-lg hover:bg-[var(--primary-dark)] transition-colors"
                  >
                    Start Free
                  </Link>
                </>
              )}
            </div>
          </div>
        </div>
      </header>

      {/* Content */}
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Back Link */}
        <Link 
          href="/explore"
          className="inline-flex items-center gap-1 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors mb-6"
        >
          <ArrowLeft className="w-4 h-4" />
          Back to Courses
        </Link>

        <div className="grid lg:grid-cols-3 gap-8">
          {/* Main Content */}
          <div className="lg:col-span-2 space-y-8">
            {/* Course Header */}
            <div className="bg-white rounded-2xl border border-[var(--border)] p-8">
              <div className="flex items-center gap-2 mb-4">
                <span className={`px-3 py-1 text-xs font-medium rounded-full capitalize
                  ${course.difficulty === 'beginner' ? 'bg-emerald-100 text-emerald-700' :
                    course.difficulty === 'intermediate' ? 'bg-amber-100 text-amber-700' :
                    'bg-rose-100 text-rose-700'
                  }
                `}>
                  {course.difficulty}
                </span>
              </div>
              
              <div className="flex items-start gap-4 mb-6">
                <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-[var(--primary)]/10 to-blue-500/10 flex items-center justify-center flex-shrink-0">
                  <GraduationCap className="w-8 h-8 text-[var(--primary)]" />
                </div>
                <div>
                  <h1 
                    className="text-3xl font-bold text-[var(--foreground)] mb-2"
                    style={{ fontFamily: 'var(--font-heading)' }}
                  >
                    {course.title}
                  </h1>
                  <p className="text-[var(--foreground-muted)]">
                    {course.short_description || course.description}
                  </p>
                </div>
              </div>

              {/* Course Stats */}
              <div className="flex flex-wrap gap-6 pt-6 border-t border-[var(--border)]">
                {foundations.length > 0 && (
                  <div className="flex items-center gap-2">
                    <div className="w-10 h-10 rounded-lg bg-amber-100 flex items-center justify-center">
                      <Sparkles className="w-5 h-5 text-amber-600" />
                    </div>
                    <div>
                      <p className="text-lg font-bold text-[var(--foreground)]">{foundations.length}</p>
                      <p className="text-xs text-[var(--foreground-muted)]">Foundations</p>
                    </div>
                  </div>
                )}
                <div className="flex items-center gap-2">
                  <div className="w-10 h-10 rounded-lg bg-violet-100 flex items-center justify-center">
                    <Target className="w-5 h-5 text-violet-600" />
                  </div>
                  <div>
                    <p className="text-lg font-bold text-[var(--foreground)]">{regularSkills.length}</p>
                    <p className="text-xs text-[var(--foreground-muted)]">Skills</p>
                  </div>
                </div>
              </div>
            </div>

            {/* Course Description */}
            {course.description && (
              <div className="bg-white rounded-2xl border border-[var(--border)] p-8">
                <h2 
                  className="text-xl font-bold text-[var(--foreground)] mb-4"
                  style={{ fontFamily: 'var(--font-heading)' }}
                >
                  About This Course
                </h2>
                <div className="text-[var(--foreground-muted)] whitespace-pre-wrap">
                  {course.description}
                </div>
              </div>
            )}

            {/* Curriculum Preview */}
            <div className="bg-white rounded-2xl border border-[var(--border)] p-8">
              <h2 
                className="text-xl font-bold text-[var(--foreground)] mb-6"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                What You&apos;ll Learn
              </h2>
              
              {/* Foundations */}
              {foundations.length > 0 && (
                <div className="mb-8">
                  <h3 className="flex items-center gap-2 text-sm font-semibold text-amber-700 mb-3">
                    <Sparkles className="w-4 h-4" />
                    Foundations
                  </h3>
                  <div className="space-y-2">
                    {foundations.slice(0, 5).map((skill) => (
                      <div key={skill.id} className="flex items-center gap-3 p-3 bg-amber-50 rounded-lg">
                        <CheckCircle2 className="w-4 h-4 text-amber-500" />
                        <span className="text-sm text-[var(--foreground)]">{skill.name}</span>
                      </div>
                    ))}
                    {foundations.length > 5 && (
                      <p className="text-sm text-[var(--foreground-muted)] pl-7">
                        +{foundations.length - 5} more foundations
                      </p>
                    )}
                  </div>
                </div>
              )}

              {/* Skills */}
              {regularSkills.length > 0 && (
                <div>
                  <h3 className="flex items-center gap-2 text-sm font-semibold text-violet-700 mb-3">
                    <Target className="w-4 h-4" />
                    Skills
                  </h3>
                  <div className="space-y-2">
                    {regularSkills.slice(0, 6).map((skill) => (
                      <div key={skill.id} className="flex items-center gap-3 p-3 bg-violet-50 rounded-lg">
                        <CheckCircle2 className="w-4 h-4 text-violet-500" />
                        <span className="text-sm text-[var(--foreground)]">{skill.name}</span>
                      </div>
                    ))}
                    {regularSkills.length > 6 && (
                      <p className="text-sm text-[var(--foreground-muted)] pl-7">
                        +{regularSkills.length - 6} more skills
                      </p>
                    )}
                  </div>
                </div>
              )}
            </div>

            {/* Sample Activities */}
            {sampleActivities.length > 0 && (
              <div className="bg-white rounded-2xl border border-[var(--border)] p-8">
                <h2 
                  className="text-xl font-bold text-[var(--foreground)] mb-6"
                  style={{ fontFamily: 'var(--font-heading)' }}
                >
                  Sample Activities
                </h2>
                <div className="space-y-3">
                  {sampleActivities.map((activity, index) => (
                    <div key={index} className="flex items-center gap-4 p-4 border border-[var(--border)] rounded-xl">
                      <div className="w-10 h-10 rounded-lg bg-[var(--background-secondary)] flex items-center justify-center">
                        {activity.type === 'lesson' ? (
                          <BookOpen className="w-5 h-5 text-blue-500" />
                        ) : activity.type === 'quiz' ? (
                          <Target className="w-5 h-5 text-emerald-500" />
                        ) : (
                          <Play className="w-5 h-5 text-violet-500" />
                        )}
                      </div>
                      <div className="flex-1">
                        <p className="font-medium text-[var(--foreground)]">{activity.title}</p>
                        <p className="text-xs text-[var(--foreground-muted)] capitalize">
                          {activity.type} - {activity.minutes} min
                        </p>
                      </div>
                      {!user && (
                        <Lock className="w-4 h-4 text-[var(--foreground-muted)]" />
                      )}
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Enrollment Card */}
            <div className="bg-white rounded-2xl border border-[var(--border)] p-6 sticky top-24">
              <div className="text-center mb-6">
                <p className="text-sm text-[var(--foreground-muted)] mb-1">Start learning today</p>
                <p className="text-3xl font-bold text-[var(--primary)]" style={{ fontFamily: 'var(--font-heading)' }}>
                  Free
                </p>
                <p className="text-xs text-[var(--foreground-muted)]">First activities free, then from CHF 10/mo</p>
              </div>
              
              {user ? (
                <Link
                  href={`/courses/${course.slug}/learn`}
                  className="flex items-center justify-center gap-2 w-full py-3 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-dark)] transition-colors"
                >
                  <Play className="w-4 h-4" />
                  Start Learning
                </Link>
              ) : (
                <>
                  <Link
                    href={`/signup?course=${course.slug}`}
                    className="flex items-center justify-center gap-2 w-full py-3 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-dark)] transition-colors mb-3"
                  >
                    Get Started Free
                    <ChevronRight className="w-4 h-4" />
                  </Link>
                  <p className="text-center text-xs text-[var(--foreground-muted)]">
                    Already have an account?{" "}
                    <Link href="/login" className="text-[var(--primary)] hover:underline">
                      Sign in
                    </Link>
                  </p>
                </>
              )}

              {/* Benefits */}
              <div className="mt-6 pt-6 border-t border-[var(--border)] space-y-3">
                <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
                  <CheckCircle2 className="w-4 h-4 text-emerald-500 flex-shrink-0" />
                  <span>Free preview activities</span>
                </div>
                <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
                  <CheckCircle2 className="w-4 h-4 text-emerald-500 flex-shrink-0" />
                  <span>AI tutor assistance</span>
                </div>
                <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
                  <CheckCircle2 className="w-4 h-4 text-emerald-500 flex-shrink-0" />
                  <span>Progress tracking</span>
                </div>
                <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
                  <CheckCircle2 className="w-4 h-4 text-emerald-500 flex-shrink-0" />
                  <span>Cancel anytime</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

