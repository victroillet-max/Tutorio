import { 
  Clock,
  CheckCircle2,
  XCircle,
  Filter,
  User,
  FileText,
  Layers,
  GraduationCap,
  ChevronRight,
  Calendar,
  AlertCircle
} from "lucide-react";
import Link from "next/link";
import { getPendingChanges, getPendingChangesCount } from "@/lib/admin/content-actions";

export const metadata = {
  title: "Pending Reviews | Content Manager",
  description: "Review and approve content changes",
};

const changeTypeLabels = {
  create: { label: "New", color: "bg-emerald-100 text-emerald-700" },
  update: { label: "Update", color: "bg-blue-100 text-blue-700" },
  delete: { label: "Delete", color: "bg-red-100 text-red-700" },
  reorder: { label: "Reorder", color: "bg-purple-100 text-purple-700" },
};

const entityTypeIcons = {
  activity: FileText,
  module: Layers,
  course: GraduationCap,
};

const statusColors = {
  pending: "bg-amber-100 text-amber-700",
  approved: "bg-emerald-100 text-emerald-700",
  rejected: "bg-red-100 text-red-700",
};

export default async function PendingChangesPage() {
  const [pendingChanges, pendingCount, allChanges] = await Promise.all([
    getPendingChanges({ status: "pending" }),
    getPendingChangesCount(),
    getPendingChanges({ limit: 50 })
  ]);

  const recentlyReviewed = allChanges.filter(c => c.status !== "pending").slice(0, 10);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 
            className="text-2xl font-bold text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Pending Reviews
          </h1>
          <p className="text-[var(--foreground-muted)]">
            Review and approve content changes submitted by content admins
          </p>
        </div>
        {pendingCount > 0 && (
          <span className="px-3 py-1.5 rounded-full bg-amber-100 text-amber-700 text-sm font-medium">
            {pendingCount} pending
          </span>
        )}
      </div>

      {/* Stats */}
      <div className="grid grid-cols-3 gap-4">
        <StatCard 
          icon={Clock} 
          label="Pending" 
          value={pendingCount}
          color="amber" 
        />
        <StatCard 
          icon={CheckCircle2} 
          label="Approved Today" 
          value={allChanges.filter(c => 
            c.status === "approved" && 
            c.reviewed_at && 
            new Date(c.reviewed_at).toDateString() === new Date().toDateString()
          ).length}
          color="emerald" 
        />
        <StatCard 
          icon={XCircle} 
          label="Rejected Today" 
          value={allChanges.filter(c => 
            c.status === "rejected" && 
            c.reviewed_at && 
            new Date(c.reviewed_at).toDateString() === new Date().toDateString()
          ).length}
          color="red" 
        />
      </div>

      {/* Pending Changes */}
      <div className="card-elevated">
        <div className="p-4 border-b border-[var(--border)] flex items-center justify-between">
          <h2 className="text-lg font-semibold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
            Awaiting Review
          </h2>
          <button className="inline-flex items-center gap-2 px-3 py-1.5 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] hover:bg-[var(--background-secondary)] rounded-lg transition-colors">
            <Filter className="w-4 h-4" />
            Filter
          </button>
        </div>

        {pendingChanges.length > 0 ? (
          <div className="divide-y divide-[var(--border)]">
            {pendingChanges.map(change => {
              const EntityIcon = entityTypeIcons[change.entity_type] || FileText;
              const changeType = changeTypeLabels[change.change_type] || changeTypeLabels.update;
              
              return (
                <Link
                  key={change.id}
                  href={`/admin/content/pending/${change.id}`}
                  className="flex items-center gap-4 p-4 hover:bg-[var(--background-secondary)] transition-colors group"
                >
                  {/* Entity Icon */}
                  <div className="w-10 h-10 rounded-lg bg-slate-100 flex items-center justify-center flex-shrink-0">
                    <EntityIcon className="w-5 h-5 text-slate-600" />
                  </div>

                  {/* Change Info */}
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 mb-1">
                      <h3 className="text-sm font-medium text-[var(--foreground)] truncate group-hover:text-[var(--primary)]">
                        {change.title}
                      </h3>
                      <span className={`px-2 py-0.5 text-xs font-medium rounded-full ${changeType.color}`}>
                        {changeType.label}
                      </span>
                    </div>
                    <div className="flex items-center gap-3 text-xs text-[var(--foreground-muted)]">
                      <span className="flex items-center gap-1">
                        <User className="w-3 h-3" />
                        {change.submitter?.full_name || change.submitter?.email}
                      </span>
                      <span className="flex items-center gap-1">
                        <Calendar className="w-3 h-3" />
                        {formatTimeAgo(new Date(change.submitted_at))}
                      </span>
                    </div>
                  </div>

                  {/* Status */}
                  <span className={`px-2.5 py-1 text-xs font-medium rounded-full ${statusColors.pending}`}>
                    Pending
                  </span>

                  {/* Arrow */}
                  <ChevronRight className="w-5 h-5 text-slate-300 group-hover:text-[var(--primary)] group-hover:translate-x-1 transition-all" />
                </Link>
              );
            })}
          </div>
        ) : (
          <div className="p-12 text-center">
            <CheckCircle2 className="w-12 h-12 text-emerald-300 mx-auto mb-4" />
            <p className="text-lg font-medium text-[var(--foreground)]">All caught up!</p>
            <p className="text-sm text-[var(--foreground-muted)] mt-1">
              No pending changes to review
            </p>
          </div>
        )}
      </div>

      {/* Recently Reviewed */}
      {recentlyReviewed.length > 0 && (
        <div className="card-elevated">
          <div className="p-4 border-b border-[var(--border)]">
            <h2 className="text-lg font-semibold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
              Recently Reviewed
            </h2>
          </div>
          <div className="divide-y divide-[var(--border)]">
            {recentlyReviewed.map(change => {
              const EntityIcon = entityTypeIcons[change.entity_type] || FileText;
              const statusColor = statusColors[change.status] || statusColors.pending;
              
              return (
                <Link
                  key={change.id}
                  href={`/admin/content/pending/${change.id}`}
                  className="flex items-center gap-4 p-4 hover:bg-[var(--background-secondary)] transition-colors group opacity-75 hover:opacity-100"
                >
                  <div className="w-10 h-10 rounded-lg bg-slate-100 flex items-center justify-center flex-shrink-0">
                    <EntityIcon className="w-5 h-5 text-slate-600" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <h3 className="text-sm font-medium text-[var(--foreground)] truncate">
                      {change.title}
                    </h3>
                    <p className="text-xs text-[var(--foreground-muted)]">
                      Reviewed {change.reviewed_at ? formatTimeAgo(new Date(change.reviewed_at)) : ""}
                    </p>
                  </div>
                  <span className={`px-2.5 py-1 text-xs font-medium rounded-full ${statusColor}`}>
                    {change.status}
                  </span>
                </Link>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}

const colorClasses = {
  amber: "bg-amber-50 text-amber-600",
  emerald: "bg-emerald-50 text-emerald-600",
  red: "bg-red-50 text-red-600",
};

function StatCard({
  icon: Icon,
  label,
  value,
  color,
}: {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  value: number;
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

function formatTimeAgo(date: Date): string {
  const seconds = Math.floor((new Date().getTime() - date.getTime()) / 1000);
  
  if (seconds < 60) return "Just now";
  if (seconds < 3600) return `${Math.floor(seconds / 60)}m ago`;
  if (seconds < 86400) return `${Math.floor(seconds / 3600)}h ago`;
  if (seconds < 604800) return `${Math.floor(seconds / 86400)}d ago`;
  return date.toLocaleDateString();
}

