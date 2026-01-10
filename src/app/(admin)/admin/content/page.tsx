import { 
  Search,
  ChevronRight,
  ChevronDown,
  GraduationCap,
  Layers,
  FileText,
  HelpCircle,
  Play,
  Code,
  CheckCircle2,
  BarChart3,
  Plus,
  Clock,
  Zap,
  Eye,
  EyeOff,
  Filter
} from "lucide-react";
import Link from "next/link";
import { getContentTree, getMyPendingChanges } from "@/lib/admin/content-actions";
import { ContentTreeClient } from "./content-tree-client";

export const metadata = {
  title: "Content Manager | Admin Dashboard",
  description: "Browse and manage course content",
};

const activityIcons: Record<string, React.ComponentType<{ className?: string }>> = {
  lesson: FileText,
  quiz: HelpCircle,
  code: Code,
  challenge: Code,
  interactive: Play,
  checkpoint: CheckCircle2,
  mock_exam: BarChart3,
};

export default async function ContentManagerPage() {
  const [contentTree, myPendingChanges] = await Promise.all([
    getContentTree(),
    getMyPendingChanges()
  ]);
  
  const totalActivities = contentTree.reduce(
    (sum, course) => sum + course.modules.reduce(
      (mSum, module) => mSum + module.activities.length, 0
    ), 0
  );
  
  const totalModules = contentTree.reduce(
    (sum, course) => sum + course.modules.length, 0
  );
  
  const pendingCount = myPendingChanges.filter(c => c.status === "pending").length;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 
            className="text-2xl font-bold text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Content Manager
          </h1>
          <p className="text-[var(--foreground-muted)]">
            Browse, edit, and manage course content
          </p>
        </div>
        <Link 
          href="/admin/content/new"
          className="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-[var(--primary)] text-white text-sm font-medium hover:bg-[var(--primary-dark)] transition-colors"
        >
          <Plus className="w-4 h-4" />
          New Activity
        </Link>
      </div>

      {/* Stats Row */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <StatCard 
          icon={GraduationCap} 
          label="Courses" 
          value={contentTree.length}
          color="blue" 
        />
        <StatCard 
          icon={Layers} 
          label="Modules" 
          value={totalModules}
          color="purple" 
        />
        <StatCard 
          icon={FileText} 
          label="Activities" 
          value={totalActivities}
          color="emerald" 
        />
        <StatCard 
          icon={Clock} 
          label="Pending Changes" 
          value={pendingCount}
          color={pendingCount > 0 ? "amber" : "slate"}
          href={pendingCount > 0 ? "/admin/content/pending" : undefined}
        />
      </div>

      {/* My Pending Changes */}
      {myPendingChanges.length > 0 && (
        <div className="card-elevated p-4">
          <h2 className="text-sm font-semibold text-[var(--foreground)] mb-3 flex items-center gap-2">
            <Clock className="w-4 h-4 text-amber-500" />
            Your Pending Changes
          </h2>
          <div className="space-y-2">
            {myPendingChanges.slice(0, 5).map(change => (
              <div 
                key={change.id}
                className="flex items-center justify-between py-2 px-3 rounded-lg bg-[var(--background-secondary)]"
              >
                <div className="flex items-center gap-3">
                  <span className={`w-2 h-2 rounded-full ${
                    change.status === "pending" ? "bg-amber-500" :
                    change.status === "approved" ? "bg-emerald-500" :
                    "bg-red-500"
                  }`} />
                  <span className="text-sm text-[var(--foreground)]">{change.title}</span>
                  <span className="text-xs text-[var(--foreground-muted)]">
                    {change.change_type} {change.entity_type}
                  </span>
                </div>
                <span className={`px-2 py-0.5 text-xs font-medium rounded-full ${
                  change.status === "pending" ? "bg-amber-100 text-amber-700" :
                  change.status === "approved" ? "bg-emerald-100 text-emerald-700" :
                  "bg-red-100 text-red-700"
                }`}>
                  {change.status}
                </span>
              </div>
            ))}
            {myPendingChanges.length > 5 && (
              <p className="text-xs text-[var(--foreground-muted)] text-center pt-2">
                +{myPendingChanges.length - 5} more changes
              </p>
            )}
          </div>
        </div>
      )}

      {/* Content Tree */}
      <div className="card-elevated">
        {/* Search & Filter Bar */}
        <div className="p-4 border-b border-[var(--border)] flex items-center gap-4">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-[var(--foreground-muted)]" />
            <input
              type="text"
              placeholder="Search activities..."
              className="w-full pl-10 pr-4 py-2 rounded-lg border border-[var(--border)] bg-white text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent"
            />
          </div>
          <button className="inline-flex items-center gap-2 px-3 py-2 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] hover:bg-[var(--background-secondary)] rounded-lg transition-colors">
            <Filter className="w-4 h-4" />
            Filter
          </button>
        </div>

        {/* Tree View */}
        <ContentTreeClient courses={contentTree} />
      </div>
    </div>
  );
}

const colorClasses = {
  blue: "bg-blue-50 text-blue-600",
  emerald: "bg-emerald-50 text-emerald-600",
  purple: "bg-purple-50 text-purple-600",
  amber: "bg-amber-50 text-amber-600",
  slate: "bg-slate-50 text-slate-600",
};

function StatCard({
  icon: Icon,
  label,
  value,
  color,
  href,
}: {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  value: string | number;
  color: keyof typeof colorClasses;
  href?: string;
}) {
  const content = (
    <div className={`bg-white border border-[var(--border)] rounded-xl p-4 flex items-center gap-3 ${href ? "hover:shadow-md transition-shadow cursor-pointer" : ""}`}>
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
  
  if (href) {
    return <Link href={href}>{content}</Link>;
  }
  
  return content;
}

