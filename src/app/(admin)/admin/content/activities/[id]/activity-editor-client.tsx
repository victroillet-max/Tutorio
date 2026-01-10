"use client";

import { useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import { 
  Save,
  Eye,
  EyeOff,
  Loader2,
  CheckCircle2,
  AlertCircle,
  SplitSquareVertical,
  Maximize2,
  X
} from "lucide-react";
import type { Activity } from "@/lib/database.types";
import { submitActivityChange } from "@/lib/admin/content-actions";
import { LessonEditor } from "@/components/admin/lesson-editor";
import { QuizEditor } from "@/components/admin/quiz-editor";
import { InteractiveEditor } from "@/components/admin/interactive-editor";
import { ActivityPreview } from "@/components/admin/activity-preview";

interface ActivityEditorClientProps {
  activity: Activity;
}

export function ActivityEditorClient({ activity }: ActivityEditorClientProps) {
  const router = useRouter();
  const [isPending, startTransition] = useTransition();
  
  // Editor state
  const [editedActivity, setEditedActivity] = useState<Activity>(activity);
  const [showPreview, setShowPreview] = useState(true);
  const [splitView, setSplitView] = useState(true);
  
  // Submission state
  const [submitDialogOpen, setSubmitDialogOpen] = useState(false);
  const [changeTitle, setChangeTitle] = useState("");
  const [changeDescription, setChangeDescription] = useState("");
  const [submitResult, setSubmitResult] = useState<{ success: boolean; message: string } | null>(null);

  // Check if there are unsaved changes
  const hasChanges = JSON.stringify(activity) !== JSON.stringify(editedActivity);

  // Handle content updates from specialized editors
  const handleContentChange = (newContent: Record<string, unknown>) => {
    setEditedActivity(prev => ({
      ...prev,
      content: newContent
    }));
  };

  // Handle metadata updates
  const handleMetadataChange = (field: keyof Activity, value: unknown) => {
    setEditedActivity(prev => ({
      ...prev,
      [field]: value
    }));
  };

  // Get the changed fields only
  const getChangedFields = (): Partial<Activity> => {
    const changes: Partial<Activity> = {};
    
    (Object.keys(editedActivity) as Array<keyof Activity>).forEach(key => {
      if (JSON.stringify(activity[key]) !== JSON.stringify(editedActivity[key])) {
        (changes as Record<string, unknown>)[key] = editedActivity[key];
      }
    });
    
    return changes;
  };

  // Handle submit for review
  const handleSubmit = () => {
    if (!changeTitle.trim()) return;
    
    const changes = getChangedFields();
    
    startTransition(async () => {
      const result = await submitActivityChange(
        activity.id,
        changes,
        changeTitle,
        changeDescription || undefined
      );
      
      if (result.success) {
        setSubmitResult({ success: true, message: "Changes submitted for review!" });
        setTimeout(() => {
          setSubmitDialogOpen(false);
          router.push("/admin/content");
        }, 1500);
      } else {
        setSubmitResult({ success: false, message: result.error || "Failed to submit changes" });
      }
    });
  };

  // Render the appropriate editor based on activity type
  const renderEditor = () => {
    switch (activity.type) {
      case "lesson":
        return (
          <LessonEditor
            content={editedActivity.content as { markdown?: string } | null}
            onChange={handleContentChange}
          />
        );
      case "quiz":
      case "checkpoint":
      case "mock_exam":
        return (
          <QuizEditor
            content={editedActivity.content as Record<string, unknown> | null}
            onChange={handleContentChange}
          />
        );
      case "interactive":
        return (
          <InteractiveEditor
            content={editedActivity.content as Record<string, unknown> | null}
            interactiveType={editedActivity.interactive_type}
            onChange={handleContentChange}
          />
        );
      default:
        return (
          <div className="p-6 text-center text-[var(--foreground-muted)]">
            <p>Editor not available for activity type: {activity.type}</p>
            <p className="text-sm mt-2">Raw JSON editing coming soon.</p>
          </div>
        );
    }
  };

  return (
    <div className="space-y-4">
      {/* Toolbar */}
      <div className="flex items-center justify-between p-4 bg-white border border-[var(--border)] rounded-xl">
        <div className="flex items-center gap-2">
          <button
            onClick={() => setSplitView(!splitView)}
            className={`p-2 rounded-lg transition-colors ${
              splitView 
                ? "bg-[var(--primary)] text-white" 
                : "bg-slate-100 text-slate-600 hover:bg-slate-200"
            }`}
            title="Toggle split view"
          >
            <SplitSquareVertical className="w-4 h-4" />
          </button>
          <button
            onClick={() => setShowPreview(!showPreview)}
            className={`p-2 rounded-lg transition-colors ${
              showPreview 
                ? "bg-[var(--primary)] text-white" 
                : "bg-slate-100 text-slate-600 hover:bg-slate-200"
            }`}
            title="Toggle preview"
          >
            {showPreview ? <Eye className="w-4 h-4" /> : <EyeOff className="w-4 h-4" />}
          </button>
        </div>
        
        <div className="flex items-center gap-3">
          {hasChanges && (
            <span className="text-xs text-amber-600 font-medium flex items-center gap-1">
              <span className="w-2 h-2 rounded-full bg-amber-500" />
              Unsaved changes
            </span>
          )}
          <button
            onClick={() => {
              setChangeTitle(`Update ${activity.title}`);
              setSubmitDialogOpen(true);
            }}
            disabled={!hasChanges}
            className={`inline-flex items-center gap-2 px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
              hasChanges
                ? "bg-[var(--primary)] text-white hover:bg-[var(--primary-dark)]"
                : "bg-slate-100 text-slate-400 cursor-not-allowed"
            }`}
          >
            <Save className="w-4 h-4" />
            Submit for Review
          </button>
        </div>
      </div>

      {/* Metadata Editor */}
      <div className="p-4 bg-white border border-[var(--border)] rounded-xl space-y-4">
        <h3 className="text-sm font-semibold text-[var(--foreground)]">Activity Details</h3>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <div>
            <label className="block text-xs text-[var(--foreground-muted)] mb-1">Title</label>
            <input
              type="text"
              value={editedActivity.title}
              onChange={(e) => handleMetadataChange("title", e.target.value)}
              className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent"
            />
          </div>
          <div>
            <label className="block text-xs text-[var(--foreground-muted)] mb-1">Minutes</label>
            <input
              type="number"
              value={editedActivity.minutes || 0}
              onChange={(e) => handleMetadataChange("minutes", parseInt(e.target.value) || 0)}
              className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent"
            />
          </div>
          <div>
            <label className="block text-xs text-[var(--foreground-muted)] mb-1">XP</label>
            <input
              type="number"
              value={editedActivity.xp}
              onChange={(e) => handleMetadataChange("xp", parseInt(e.target.value) || 0)}
              className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent"
            />
          </div>
          <div>
            <label className="block text-xs text-[var(--foreground-muted)] mb-1">Required Plan</label>
            <select
              value={editedActivity.required_plan}
              onChange={(e) => handleMetadataChange("required_plan", e.target.value)}
              className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent"
            >
              <option value="free">Free</option>
              <option value="basic">Basic</option>
              <option value="advanced">Advanced</option>
            </select>
          </div>
        </div>
      </div>

      {/* Editor and Preview */}
      <div className={`grid gap-4 ${splitView && showPreview ? "grid-cols-2" : "grid-cols-1"}`}>
        {/* Editor Panel */}
        <div className="bg-white border border-[var(--border)] rounded-xl overflow-hidden">
          <div className="px-4 py-3 border-b border-[var(--border)] bg-slate-50">
            <h3 className="text-sm font-semibold text-[var(--foreground)]">Content Editor</h3>
          </div>
          <div className="min-h-[500px]">
            {renderEditor()}
          </div>
        </div>

        {/* Preview Panel */}
        {showPreview && (
          <div className="bg-white border border-[var(--border)] rounded-xl overflow-hidden">
            <div className="px-4 py-3 border-b border-[var(--border)] bg-slate-50 flex items-center justify-between">
              <h3 className="text-sm font-semibold text-[var(--foreground)]">Live Preview</h3>
              <span className="text-xs text-[var(--foreground-muted)]">Student view</span>
            </div>
            <div className="min-h-[500px] max-h-[700px] overflow-y-auto">
              <ActivityPreview activity={editedActivity} />
            </div>
          </div>
        )}
      </div>

      {/* Submit Dialog */}
      {submitDialogOpen && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl p-6 w-full max-w-md shadow-xl">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-semibold text-[var(--foreground)]">Submit for Review</h3>
              <button
                onClick={() => {
                  setSubmitDialogOpen(false);
                  setSubmitResult(null);
                }}
                className="p-1 rounded-lg hover:bg-slate-100 transition-colors"
              >
                <X className="w-5 h-5 text-slate-500" />
              </button>
            </div>
            
            {submitResult ? (
              <div className={`p-4 rounded-lg ${
                submitResult.success ? "bg-emerald-50" : "bg-red-50"
              }`}>
                <div className="flex items-center gap-3">
                  {submitResult.success ? (
                    <CheckCircle2 className="w-6 h-6 text-emerald-500" />
                  ) : (
                    <AlertCircle className="w-6 h-6 text-red-500" />
                  )}
                  <p className={submitResult.success ? "text-emerald-700" : "text-red-700"}>
                    {submitResult.message}
                  </p>
                </div>
              </div>
            ) : (
              <>
                <p className="text-sm text-[var(--foreground-muted)] mb-4">
                  Describe your changes. This will help the reviewer understand what you modified.
                </p>
                
                <div className="space-y-4">
                  <div>
                    <label className="block text-sm font-medium text-[var(--foreground)] mb-1">
                      Change Title *
                    </label>
                    <input
                      type="text"
                      value={changeTitle}
                      onChange={(e) => setChangeTitle(e.target.value)}
                      placeholder="e.g., Fixed typo in explanation"
                      className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-[var(--foreground)] mb-1">
                      Description (optional)
                    </label>
                    <textarea
                      value={changeDescription}
                      onChange={(e) => setChangeDescription(e.target.value)}
                      placeholder="Provide more details about your changes..."
                      rows={3}
                      className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent resize-none"
                    />
                  </div>
                </div>

                {/* Changed Fields Summary */}
                <div className="mt-4 p-3 bg-slate-50 rounded-lg">
                  <p className="text-xs font-medium text-[var(--foreground-muted)] mb-2">Changed fields:</p>
                  <div className="flex flex-wrap gap-1">
                    {Object.keys(getChangedFields()).map(field => (
                      <span key={field} className="px-2 py-0.5 text-xs bg-amber-100 text-amber-700 rounded">
                        {field}
                      </span>
                    ))}
                  </div>
                </div>

                <div className="flex gap-3 mt-6">
                  <button
                    onClick={() => {
                      setSubmitDialogOpen(false);
                      setSubmitResult(null);
                    }}
                    className="flex-1 px-4 py-2 rounded-lg border border-[var(--border)] text-sm font-medium text-[var(--foreground)] hover:bg-slate-50 transition-colors"
                  >
                    Cancel
                  </button>
                  <button
                    onClick={handleSubmit}
                    disabled={!changeTitle.trim() || isPending}
                    className="flex-1 px-4 py-2 rounded-lg bg-[var(--primary)] text-white text-sm font-medium hover:bg-[var(--primary-dark)] transition-colors disabled:opacity-50 disabled:cursor-not-allowed inline-flex items-center justify-center gap-2"
                  >
                    {isPending ? (
                      <>
                        <Loader2 className="w-4 h-4 animate-spin" />
                        Submitting...
                      </>
                    ) : (
                      <>
                        <Save className="w-4 h-4" />
                        Submit
                      </>
                    )}
                  </button>
                </div>
              </>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

