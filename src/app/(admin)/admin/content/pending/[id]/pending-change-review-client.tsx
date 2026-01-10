"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { 
  CheckCircle2, 
  XCircle, 
  Loader2,
  ArrowRight,
  Plus,
  Minus,
  AlertCircle
} from "lucide-react";
import type { PendingContentChangeWithSubmitter, Activity } from "@/lib/database.types";
import { approveChange, rejectChange } from "@/lib/admin/content-actions";

interface PendingChangeReviewClientProps {
  change: PendingContentChangeWithSubmitter;
  currentData: Activity | null;
  isPending: boolean;
}

export function PendingChangeReviewClient({ 
  change, 
  currentData, 
  isPending 
}: PendingChangeReviewClientProps) {
  const router = useRouter();
  const [isPendingAction, startTransition] = useTransition();
  
  const [showRejectDialog, setShowRejectDialog] = useState(false);
  const [rejectNotes, setRejectNotes] = useState("");
  const [approveNotes, setApproveNotes] = useState("");
  const [showApproveDialog, setShowApproveDialog] = useState(false);
  const [result, setResult] = useState<{ success: boolean; message: string } | null>(null);

  const handleApprove = () => {
    startTransition(async () => {
      const res = await approveChange(change.id, approveNotes || undefined);
      if (res.success) {
        setResult({ success: true, message: "Change approved and applied!" });
        setTimeout(() => router.push("/admin/content/pending"), 1500);
      } else {
        setResult({ success: false, message: res.error || "Failed to approve" });
      }
    });
  };

  const handleReject = () => {
    if (!rejectNotes.trim()) return;
    
    startTransition(async () => {
      const res = await rejectChange(change.id, rejectNotes);
      if (res.success) {
        setResult({ success: true, message: "Change rejected" });
        setTimeout(() => router.push("/admin/content/pending"), 1500);
      } else {
        setResult({ success: false, message: res.error || "Failed to reject" });
      }
    });
  };

  const proposedData = change.proposed_data as Record<string, unknown>;
  const originalData = (change.current_data || currentData || {}) as Record<string, unknown>;

  // Calculate diff
  const changedFields = getChangedFields(originalData, proposedData);

  return (
    <div className="space-y-6">
      {/* Result Message */}
      {result && (
        <div className={`p-4 rounded-xl ${
          result.success ? "bg-emerald-50 border border-emerald-200" : "bg-red-50 border border-red-200"
        }`}>
          <div className="flex items-center gap-3">
            {result.success ? (
              <CheckCircle2 className="w-5 h-5 text-emerald-500" />
            ) : (
              <AlertCircle className="w-5 h-5 text-red-500" />
            )}
            <p className={result.success ? "text-emerald-700" : "text-red-700"}>
              {result.message}
            </p>
          </div>
        </div>
      )}

      {/* Diff View */}
      <div className="card-elevated overflow-hidden">
        <div className="px-4 py-3 border-b border-[var(--border)] bg-slate-50">
          <h3 className="text-sm font-semibold text-[var(--foreground)]">Changes</h3>
        </div>
        
        <div className="divide-y divide-[var(--border)]">
          {changedFields.length > 0 ? (
            changedFields.map(({ field, oldValue, newValue, type }) => (
              <div key={field} className="p-4">
                <div className="flex items-center gap-2 mb-3">
                  <span className="text-xs font-medium text-[var(--foreground-muted)] uppercase tracking-wider">
                    {formatFieldName(field)}
                  </span>
                  <span className={`px-1.5 py-0.5 text-[10px] font-medium rounded ${
                    type === "added" ? "bg-emerald-100 text-emerald-700" :
                    type === "removed" ? "bg-red-100 text-red-700" :
                    "bg-amber-100 text-amber-700"
                  }`}>
                    {type}
                  </span>
                </div>
                
                <div className="grid grid-cols-2 gap-4">
                  {/* Old Value */}
                  <div className="relative">
                    <div className="absolute top-0 left-0 text-xs text-[var(--foreground-muted)] -mt-4">
                      Current
                    </div>
                    <div className={`p-3 rounded-lg text-sm font-mono whitespace-pre-wrap break-all ${
                      type === "removed" || type === "modified" 
                        ? "bg-red-50 border border-red-200" 
                        : "bg-slate-50 border border-slate-200"
                    }`}>
                      {type === "added" ? (
                        <span className="text-slate-400 italic">Not present</span>
                      ) : (
                        formatValue(oldValue)
                      )}
                    </div>
                  </div>
                  
                  {/* Arrow */}
                  <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 hidden">
                    <ArrowRight className="w-5 h-5 text-slate-300" />
                  </div>
                  
                  {/* New Value */}
                  <div className="relative">
                    <div className="absolute top-0 left-0 text-xs text-[var(--foreground-muted)] -mt-4">
                      Proposed
                    </div>
                    <div className={`p-3 rounded-lg text-sm font-mono whitespace-pre-wrap break-all ${
                      type === "added" || type === "modified" 
                        ? "bg-emerald-50 border border-emerald-200" 
                        : "bg-slate-50 border border-slate-200"
                    }`}>
                      {type === "removed" ? (
                        <span className="text-slate-400 italic">Will be removed</span>
                      ) : (
                        formatValue(newValue)
                      )}
                    </div>
                  </div>
                </div>
              </div>
            ))
          ) : (
            <div className="p-6 text-center text-[var(--foreground-muted)]">
              <p>No detailed diff available</p>
              <pre className="mt-4 p-4 bg-slate-50 rounded-lg text-left text-xs overflow-auto">
                {JSON.stringify(proposedData, null, 2)}
              </pre>
            </div>
          )}
        </div>
      </div>

      {/* Action Buttons */}
      {isPending && !result && (
        <div className="flex gap-4">
          <button
            onClick={() => setShowRejectDialog(true)}
            disabled={isPendingAction}
            className="flex-1 inline-flex items-center justify-center gap-2 px-4 py-3 rounded-xl border-2 border-red-200 text-red-600 font-medium hover:bg-red-50 transition-colors disabled:opacity-50"
          >
            <XCircle className="w-5 h-5" />
            Reject
          </button>
          <button
            onClick={() => setShowApproveDialog(true)}
            disabled={isPendingAction}
            className="flex-1 inline-flex items-center justify-center gap-2 px-4 py-3 rounded-xl bg-emerald-600 text-white font-medium hover:bg-emerald-700 transition-colors disabled:opacity-50"
          >
            {isPendingAction ? (
              <Loader2 className="w-5 h-5 animate-spin" />
            ) : (
              <CheckCircle2 className="w-5 h-5" />
            )}
            Approve & Apply
          </button>
        </div>
      )}

      {/* Approve Dialog */}
      {showApproveDialog && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl p-6 w-full max-w-md shadow-xl">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-10 h-10 rounded-full bg-emerald-100 flex items-center justify-center">
                <CheckCircle2 className="w-5 h-5 text-emerald-600" />
              </div>
              <h3 className="text-lg font-semibold text-[var(--foreground)]">Approve Change</h3>
            </div>
            
            <p className="text-sm text-[var(--foreground-muted)] mb-4">
              This will immediately apply the change to the live content. This action cannot be undone.
            </p>
            
            <div className="mb-4">
              <label className="block text-sm font-medium text-[var(--foreground)] mb-1">
                Notes (optional)
              </label>
              <textarea
                value={approveNotes}
                onChange={(e) => setApproveNotes(e.target.value)}
                rows={2}
                className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500 resize-none"
                placeholder="Add a note for the submitter..."
              />
            </div>

            <div className="flex gap-3">
              <button
                onClick={() => setShowApproveDialog(false)}
                className="flex-1 px-4 py-2 rounded-lg border border-[var(--border)] text-sm font-medium hover:bg-slate-50 transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={handleApprove}
                disabled={isPendingAction}
                className="flex-1 px-4 py-2 rounded-lg bg-emerald-600 text-white text-sm font-medium hover:bg-emerald-700 transition-colors disabled:opacity-50 inline-flex items-center justify-center gap-2"
              >
                {isPendingAction ? (
                  <Loader2 className="w-4 h-4 animate-spin" />
                ) : (
                  <CheckCircle2 className="w-4 h-4" />
                )}
                Approve
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Reject Dialog */}
      {showRejectDialog && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl p-6 w-full max-w-md shadow-xl">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-10 h-10 rounded-full bg-red-100 flex items-center justify-center">
                <XCircle className="w-5 h-5 text-red-600" />
              </div>
              <h3 className="text-lg font-semibold text-[var(--foreground)]">Reject Change</h3>
            </div>
            
            <p className="text-sm text-[var(--foreground-muted)] mb-4">
              Please provide feedback to help the content admin understand why this change was rejected.
            </p>
            
            <div className="mb-4">
              <label className="block text-sm font-medium text-[var(--foreground)] mb-1">
                Rejection Reason *
              </label>
              <textarea
                value={rejectNotes}
                onChange={(e) => setRejectNotes(e.target.value)}
                rows={3}
                className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-red-500 resize-none"
                placeholder="Explain why this change is being rejected..."
              />
            </div>

            <div className="flex gap-3">
              <button
                onClick={() => setShowRejectDialog(false)}
                className="flex-1 px-4 py-2 rounded-lg border border-[var(--border)] text-sm font-medium hover:bg-slate-50 transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={handleReject}
                disabled={!rejectNotes.trim() || isPendingAction}
                className="flex-1 px-4 py-2 rounded-lg bg-red-600 text-white text-sm font-medium hover:bg-red-700 transition-colors disabled:opacity-50 inline-flex items-center justify-center gap-2"
              >
                {isPendingAction ? (
                  <Loader2 className="w-4 h-4 animate-spin" />
                ) : (
                  <XCircle className="w-4 h-4" />
                )}
                Reject
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

// Helper functions

interface FieldChange {
  field: string;
  oldValue: unknown;
  newValue: unknown;
  type: "added" | "removed" | "modified";
}

function getChangedFields(
  original: Record<string, unknown>,
  proposed: Record<string, unknown>
): FieldChange[] {
  const changes: FieldChange[] = [];
  const allKeys = new Set([...Object.keys(original), ...Object.keys(proposed)]);
  
  // Skip metadata fields
  const skipFields = ["id", "created_at", "updated_at", "module_id", "external_id"];
  
  allKeys.forEach(key => {
    if (skipFields.includes(key)) return;
    
    const oldVal = original[key];
    const newVal = proposed[key];
    
    if (oldVal === undefined && newVal !== undefined) {
      changes.push({ field: key, oldValue: oldVal, newValue: newVal, type: "added" });
    } else if (oldVal !== undefined && newVal === undefined) {
      // Don't show as removed if not in proposed - proposed only contains changes
      // changes.push({ field: key, oldValue: oldVal, newValue: newVal, type: "removed" });
    } else if (JSON.stringify(oldVal) !== JSON.stringify(newVal) && newVal !== undefined) {
      changes.push({ field: key, oldValue: oldVal, newValue: newVal, type: "modified" });
    }
  });
  
  return changes;
}

function formatFieldName(field: string): string {
  return field
    .replace(/_/g, " ")
    .replace(/([A-Z])/g, " $1")
    .trim();
}

function formatValue(value: unknown): string {
  if (value === null || value === undefined) {
    return "(empty)";
  }
  if (typeof value === "object") {
    const str = JSON.stringify(value, null, 2);
    // Truncate very long values
    if (str.length > 500) {
      return str.substring(0, 500) + "...";
    }
    return str;
  }
  return String(value);
}

