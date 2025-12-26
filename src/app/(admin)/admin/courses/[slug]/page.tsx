import { 
  ChevronLeft,
  BookOpen, 
  Users,
  Trophy,
  Eye,
  EyeOff,
  Star,
  Layers,
  Play,
  FileText,
  Code,
  HelpCircle,
  Zap,
  CheckCircle2,
  Lock,
  Unlock,
  Clock,
  Edit,
  BarChart3
} from "lucide-react";
import Link from "next/link";
import { getCourseDetail } from "@/lib/admin/actions";
import { notFound } from "next/navigation";

interface PageProps {
  params: Promise<{ slug: string }>;
}

export async function generateMetadata({ params }: PageProps) {
  const { slug } = await params;
  const data = await getCourseDetail(slug);
  return {
    title: data ? `${data.course.title} | Admin Dashboard` : "Course Not Found",
  };
}

export default async function CourseDetailPage({ params }: PageProps) {
  const { slug } = await params;
  const data = await getCourseDetail(slug);
  
  if (!data) {
    notFound();
  }
  
  const { course, modules } = data;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-start justify-between">
        <div>
          <Link 
            href="/admin/courses"
            className="inline-flex items-center gap-1 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] mb-2 transition-colors"
          >
            <ChevronLeft className="w-4 h-4" />
            Back to Courses
          </Link>
          <h1 
            className="text-2xl font-bold text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            {course.title}
          </h1>
          <div className="flex items-center gap-3 mt-2">
            {course.category && (
              <span className="text-xs text-[var(--primary)] font-semibold uppercase tracking-wider">
                {course.category.name}
              </span>
            )}
            <span className={`px-2.5 py-1 text-xs font-medium rounded-full ${
              course.difficulty === 'beginner' ? 'bg-emerald-100 text-emerald-700' :
              course.difficulty === 'intermediate' ? 'bg-amber-100 text-amber-700' :
              'bg-rose-100 text-rose-700'
            }`}>
              {course.difficulty}
            </span>
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
        <button className="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-[var(--primary)] text-white text-sm font-medium hover:bg-[var(--primary-dark)] transition-colors">
          <Edit className="w-4 h-4" />
          Edit Course
        </button>
      </div>

      {/* Course Stats */}
      <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
        <StatCard icon={Layers} label="Modules" value={course.modules_count} />
        <StatCard icon={BookOpen} label="Activities" value={course.activities_count} />
        <StatCard icon={Users} label="Enrolled" value={course.enrollments_count} />
        <StatCard icon={Trophy} label="Total XP" value={course.total_xp.toLocaleString()} />
        <StatCard icon={Clock} label="Duration" value={`${course.duration_hours || 0}h`} />
      </div>

      {/* Description */}
      {course.description && (
        <div className="card-elevated p-6">
          <h2 className="text-lg font-semibold text-[var(--foreground)] mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
            Description
          </h2>
          <p className="text-[var(--foreground-muted)]">{course.description}</p>
        </div>
      )}

      {/* Modules & Activities */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-lg font-semibold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
            Course Content
          </h2>
          <span className="text-sm text-[var(--foreground-muted)]">
            {modules.length} modules, {course.activities_count} activities
          </span>
        </div>

        {modules.map((module, index) => (
          <ModuleCard key={module.id} module={module} index={index + 1} />
        ))}
      </div>
    </div>
  );
}

function StatCard({
  icon: Icon,
  label,
  value,
}: {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  value: string | number;
}) {
  return (
    <div className="bg-white border border-[var(--border)] rounded-xl p-4 text-center">
      <div className="w-10 h-10 rounded-lg bg-slate-100 flex items-center justify-center mx-auto mb-2">
        <Icon className="w-5 h-5 text-slate-600" />
      </div>
      <p className="text-xl font-bold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
        {value}
      </p>
      <p className="text-xs text-[var(--foreground-muted)]">{label}</p>
    </div>
  );
}

const activityIcons: Record<string, React.ComponentType<{ className?: string }>> = {
  lesson: FileText,
  quiz: HelpCircle,
  code: Code,
  challenge: Code,
  interactive: Play,
  checkpoint: CheckCircle2,
  mock_exam: BarChart3,
};

const planColors = {
  free: "bg-emerald-100 text-emerald-700",
  basic: "bg-blue-100 text-blue-700",
  advanced: "bg-purple-100 text-purple-700",
};

interface ModuleData {
  id: string;
  title: string;
  slug: string;
  order_index: number;
  estimated_minutes: number | null;
  total_xp: number;
  required_plan: string;
  is_published: boolean;
  activities: Array<{
    id: string;
    title: string;
    slug: string;
    type: string;
    xp: number;
    required_plan: string;
    is_published: boolean;
    completions_count: number;
  }>;
}

function ModuleCard({ module, index }: { module: ModuleData; index: number }) {
  const totalCompletions = module.activities.reduce((sum, a) => sum + a.completions_count, 0);
  
  return (
    <div className="card-elevated overflow-hidden">
      {/* Module Header */}
      <div className="p-4 bg-slate-50 border-b border-[var(--border)] flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="w-8 h-8 rounded-lg bg-[var(--primary)] text-white flex items-center justify-center text-sm font-bold">
            {index}
          </div>
          <div>
            <h3 className="font-semibold text-[var(--foreground)]">{module.title}</h3>
            <div className="flex items-center gap-3 text-xs text-[var(--foreground-muted)]">
              <span>{module.activities.length} activities</span>
              <span>{module.estimated_minutes || 0} min</span>
              <span>{module.total_xp} XP</span>
            </div>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <span className={`px-2 py-1 text-xs font-medium rounded-full ${planColors[module.required_plan as keyof typeof planColors] || planColors.free}`}>
            {module.required_plan === 'free' ? (
              <span className="flex items-center gap-1"><Unlock className="w-3 h-3" /> Free</span>
            ) : (
              <span className="flex items-center gap-1"><Lock className="w-3 h-3" /> {module.required_plan}</span>
            )}
          </span>
          {!module.is_published && (
            <span className="flex items-center gap-1 px-2 py-1 text-xs font-medium rounded-full bg-slate-100 text-slate-600">
              <EyeOff className="w-3 h-3" />
              Draft
            </span>
          )}
        </div>
      </div>

      {/* Activities */}
      <div className="divide-y divide-[var(--border)]">
        {module.activities.map((activity) => {
          const Icon = activityIcons[activity.type] || FileText;
          
          return (
            <div 
              key={activity.id}
              className="px-4 py-3 flex items-center gap-4 hover:bg-slate-50 transition-colors"
            >
              <div className="w-8 h-8 rounded-lg bg-slate-100 flex items-center justify-center flex-shrink-0">
                <Icon className="w-4 h-4 text-slate-600" />
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-sm font-medium text-[var(--foreground)] truncate">
                  {activity.title}
                </p>
                <p className="text-xs text-[var(--foreground-muted)]">
                  {activity.type}
                </p>
              </div>
              <div className="flex items-center gap-3 flex-shrink-0">
                <span className="flex items-center gap-1 text-xs text-amber-600">
                  <Zap className="w-3 h-3" />
                  {activity.xp} XP
                </span>
                <span className={`px-2 py-0.5 text-xs font-medium rounded-full ${
                  planColors[activity.required_plan as keyof typeof planColors] || planColors.free
                }`}>
                  {activity.required_plan}
                </span>
                {!activity.is_published && (
                  <EyeOff className="w-3 h-3 text-slate-400" />
                )}
                <div className="text-right">
                  <p className="text-xs font-medium text-[var(--foreground)]">
                    {activity.completions_count}
                  </p>
                  <p className="text-xs text-[var(--foreground-muted)]">
                    completions
                  </p>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Module Footer */}
      <div className="px-4 py-3 bg-slate-50 border-t border-[var(--border)] flex items-center justify-between text-xs text-[var(--foreground-muted)]">
        <span>Total completions: {totalCompletions}</span>
        <Link 
          href={`/courses/${module.slug}`}
          className="text-[var(--primary)] hover:underline"
        >
          Preview as Student
        </Link>
      </div>
    </div>
  );
}

