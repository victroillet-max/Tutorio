import { 
  ChevronLeft,
  User,
  Calendar,
  FileText,
  Layers,
  GraduationCap,
  CheckCircle2,
  XCircle,
  Clock,
  AlertCircle
} from "lucide-react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { getPendingChangeById, getActivityById } from "@/lib/admin/content-actions";
import { PendingChangeReviewClient } from "./pending-change-review-client";

interface PageProps {
  params: Promise<{ id: string }>;
}

export async function generateMetadata({ params }: PageProps) {
  const { id } = await params;
  const change = await getPendingChangeById(id);
  return {
    title: change ? `Review: ${change.title} | Content Manager` : "Change Not Found",
  };
}

const entityTypeIcons = {
  activity: FileText,
  module: Layers,
  course: GraduationCap,
};

const changeTypeLabels = {
  create: { label: "Create New", color: "bg-emerald-100 text-emerald-700", description: "Adding new content" },
  update: { label: "Update", color: "bg-blue-100 text-blue-700", description: "Modifying existing content" },
  delete: { label: "Delete", color: "bg-red-100 text-red-700", description: "Removing content" },
  reorder: { label: "Reorder", color: "bg-purple-100 text-purple-700", description: "Changing order" },
};

const statusConfig = {
  pending: { label: "Pending", color: "bg-amber-100 text-amber-700", icon: Clock },
  approved: { label: "Approved", color: "bg-emerald-100 text-emerald-700", icon: CheckCircle2 },
  rejected: { label: "Rejected", color: "bg-red-100 text-red-700", icon: XCircle },
};

export default async function PendingChangeReviewPage({ params }: PageProps) {
  const { id } = await params;
  const change = await getPendingChangeById(id);
  
  if (!change) {
    notFound();
  }
  
  // Get current activity data if this is an update
  let currentActivity = null;
  if (change.entity_type === "activity" && change.entity_id) {
    currentActivity = await getActivityById(change.entity_id);
  }
  
  const EntityIcon = entityTypeIcons[change.entity_type] || FileText;
  const changeType = changeTypeLabels[change.change_type] || changeTypeLabels.update;
  const status = statusConfig[change.status] || statusConfig.pending;
  const StatusIcon = status.icon;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-start justify-between">
        <div>
          <Link 
            href="/admin/content/pending"
            className="inline-flex items-center gap-1 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] mb-2 transition-colors"
          >
            <ChevronLeft className="w-4 h-4" />
            Back to Pending Reviews
          </Link>
          
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 rounded-lg bg-slate-100 flex items-center justify-center">
              <EntityIcon className="w-6 h-6 text-slate-600" />
            </div>
            <div>
              <h1 
                className="text-2xl font-bold text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {change.title}
              </h1>
              <div className="flex items-center gap-3 mt-1">
                <span className={`px-2 py-0.5 text-xs font-medium rounded-full ${changeType.color}`}>
                  {changeType.label}
                </span>
                <span className="text-xs text-[var(--foreground-muted)]">
                  {change.entity_type}
                </span>
              </div>
            </div>
          </div>
        </div>
        
        <span className={`inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-sm font-medium ${status.color}`}>
          <StatusIcon className="w-4 h-4" />
          {status.label}
        </span>
      </div>

      {/* Submission Info */}
      <div className="flex items-center gap-6 p-4 bg-slate-50 rounded-xl border border-[var(--border)]">
        <div className="flex items-center gap-2">
          <User className="w-4 h-4 text-[var(--foreground-muted)]" />
          <span className="text-sm text-[var(--foreground)]">
            <span className="text-[var(--foreground-muted)]">Submitted by </span>
            <span className="font-medium">{change.submitter?.full_name || change.submitter?.email}</span>
          </span>
        </div>
        <div className="flex items-center gap-2">
          <Calendar className="w-4 h-4 text-[var(--foreground-muted)]" />
          <span className="text-sm text-[var(--foreground)]">
            {new Date(change.submitted_at).toLocaleString()}
          </span>
        </div>
      </div>

      {/* Description */}
      {change.description && (
        <div className="p-4 bg-white rounded-xl border border-[var(--border)]">
          <h3 className="text-sm font-semibold text-[var(--foreground)] mb-2">Description</h3>
          <p className="text-sm text-[var(--foreground-muted)]">{change.description}</p>
        </div>
      )}

      {/* Already Reviewed Notice */}
      {change.status !== "pending" && (
        <div className={`p-4 rounded-xl border ${
          change.status === "approved" 
            ? "bg-emerald-50 border-emerald-200" 
            : "bg-red-50 border-red-200"
        }`}>
          <div className="flex items-start gap-3">
            {change.status === "approved" ? (
              <CheckCircle2 className="w-5 h-5 text-emerald-500 flex-shrink-0 mt-0.5" />
            ) : (
              <XCircle className="w-5 h-5 text-red-500 flex-shrink-0 mt-0.5" />
            )}
            <div>
              <p className={`font-medium ${
                change.status === "approved" ? "text-emerald-700" : "text-red-700"
              }`}>
                This change has been {change.status}
              </p>
              {change.reviewer && (
                <p className="text-sm text-slate-600 mt-1">
                  By {change.reviewer.full_name || change.reviewer.email} on{" "}
                  {change.reviewed_at ? new Date(change.reviewed_at).toLocaleString() : ""}
                </p>
              )}
              {change.review_notes && (
                <p className="text-sm mt-2 p-2 bg-white/50 rounded">{change.review_notes}</p>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Diff View and Review Actions */}
      <PendingChangeReviewClient 
        change={change}
        currentData={currentActivity}
        isPending={change.status === "pending"}
      />
    </div>
  );
}

