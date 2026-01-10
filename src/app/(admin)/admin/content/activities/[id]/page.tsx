import { 
  ChevronLeft,
  FileText,
  HelpCircle,
  Play,
  Code,
  CheckCircle2,
  BarChart3,
  Save,
  Eye,
  Clock,
  AlertCircle
} from "lucide-react";
import Link from "next/link";
import { notFound } from "next/navigation";
import { getActivityById, getModuleWithActivities } from "@/lib/admin/content-actions";
import { ActivityEditorClient } from "./activity-editor-client";

interface PageProps {
  params: Promise<{ id: string }>;
}

export async function generateMetadata({ params }: PageProps) {
  const { id } = await params;
  const activity = await getActivityById(id);
  return {
    title: activity ? `Edit: ${activity.title} | Content Manager` : "Activity Not Found",
  };
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

export default async function ActivityEditorPage({ params }: PageProps) {
  const { id } = await params;
  const activity = await getActivityById(id);
  
  if (!activity) {
    notFound();
  }
  
  // Get the module info for breadcrumb
  const module = activity.module_id ? await getModuleWithActivities(activity.module_id) : null;
  
  const Icon = activityIcons[activity.type] || FileText;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-start justify-between">
        <div>
          <Link 
            href="/admin/content"
            className="inline-flex items-center gap-1 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] mb-2 transition-colors"
          >
            <ChevronLeft className="w-4 h-4" />
            Back to Content Manager
          </Link>
          
          {/* Breadcrumb */}
          {module && (
            <p className="text-xs text-[var(--foreground-muted)] mb-2">
              Module {module.order_index}: {module.title}
            </p>
          )}
          
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-lg bg-[var(--primary)] text-white flex items-center justify-center">
              <Icon className="w-5 h-5" />
            </div>
            <div>
              <h1 
                className="text-2xl font-bold text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {activity.title}
              </h1>
              <div className="flex items-center gap-3 mt-1">
                <span className="text-xs text-[var(--foreground-muted)] capitalize">
                  {activity.type}
                </span>
                <span className="text-xs text-[var(--foreground-muted)]">
                  {activity.minutes || 0} min
                </span>
                <span className="text-xs text-amber-600 font-medium">
                  {activity.xp} XP
                </span>
              </div>
            </div>
          </div>
        </div>
        
        <div className="flex items-center gap-2">
          <span className={`px-2.5 py-1 text-xs font-medium rounded-full ${
            activity.is_published 
              ? "bg-emerald-100 text-emerald-700" 
              : "bg-slate-100 text-slate-600"
          }`}>
            {activity.is_published ? "Published" : "Draft"}
          </span>
        </div>
      </div>

      {/* Info Banner */}
      <div className="flex items-start gap-3 p-4 rounded-lg bg-blue-50 border border-blue-100">
        <AlertCircle className="w-5 h-5 text-blue-500 flex-shrink-0 mt-0.5" />
        <div className="text-sm text-blue-800">
          <p className="font-medium">Content Admin Mode</p>
          <p className="text-blue-600 mt-1">
            Changes you make will be submitted for review. Once approved by a super admin, 
            they will be applied to the live content.
          </p>
        </div>
      </div>

      {/* Editor */}
      <ActivityEditorClient activity={activity} />
    </div>
  );
}

