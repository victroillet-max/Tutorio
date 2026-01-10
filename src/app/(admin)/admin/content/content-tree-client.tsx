"use client";

import { useState } from "react";
import Link from "next/link";
import { 
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
  Zap,
  Eye,
  EyeOff,
  Lock,
  Unlock,
  Edit3
} from "lucide-react";
import type { CourseWithModules } from "@/lib/admin/content-actions";

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

interface ContentTreeClientProps {
  courses: CourseWithModules[];
}

export function ContentTreeClient({ courses }: ContentTreeClientProps) {
  const [expandedCourses, setExpandedCourses] = useState<Set<string>>(new Set());
  const [expandedModules, setExpandedModules] = useState<Set<string>>(new Set());
  const [searchQuery, setSearchQuery] = useState("");

  const toggleCourse = (courseId: string) => {
    setExpandedCourses(prev => {
      const next = new Set(prev);
      if (next.has(courseId)) {
        next.delete(courseId);
      } else {
        next.add(courseId);
      }
      return next;
    });
  };

  const toggleModule = (moduleId: string) => {
    setExpandedModules(prev => {
      const next = new Set(prev);
      if (next.has(moduleId)) {
        next.delete(moduleId);
      } else {
        next.add(moduleId);
      }
      return next;
    });
  };

  const expandAll = () => {
    setExpandedCourses(new Set(courses.map(c => c.id)));
    setExpandedModules(new Set(courses.flatMap(c => c.modules.map(m => m.id))));
  };

  const collapseAll = () => {
    setExpandedCourses(new Set());
    setExpandedModules(new Set());
  };

  return (
    <div>
      {/* Expand/Collapse Controls */}
      <div className="px-4 py-2 border-b border-[var(--border)] flex items-center gap-4 text-xs">
        <button 
          onClick={expandAll}
          className="text-[var(--primary)] hover:underline"
        >
          Expand All
        </button>
        <button 
          onClick={collapseAll}
          className="text-[var(--foreground-muted)] hover:underline"
        >
          Collapse All
        </button>
      </div>

      {/* Tree Content */}
      <div className="divide-y divide-[var(--border)]">
        {courses.map(course => (
          <div key={course.id}>
            {/* Course Row */}
            <button
              onClick={() => toggleCourse(course.id)}
              className="w-full px-4 py-3 flex items-center gap-3 hover:bg-[var(--background-secondary)] transition-colors text-left"
            >
              {expandedCourses.has(course.id) ? (
                <ChevronDown className="w-4 h-4 text-[var(--foreground-muted)]" />
              ) : (
                <ChevronRight className="w-4 h-4 text-[var(--foreground-muted)]" />
              )}
              <div className="w-8 h-8 rounded-lg bg-[var(--primary)] text-white flex items-center justify-center">
                <GraduationCap className="w-4 h-4" />
              </div>
              <div className="flex-1">
                <p className="font-medium text-[var(--foreground)]">{course.title}</p>
                <p className="text-xs text-[var(--foreground-muted)]">
                  {course.modules.length} modules, {course.modules.reduce((s, m) => s + m.activities.length, 0)} activities
                </p>
              </div>
              {!course.is_published && (
                <span className="flex items-center gap-1 px-2 py-0.5 text-xs font-medium rounded-full bg-slate-100 text-slate-600">
                  <EyeOff className="w-3 h-3" />
                  Draft
                </span>
              )}
            </button>

            {/* Modules */}
            {expandedCourses.has(course.id) && (
              <div className="bg-slate-50/50">
                {course.modules.map(module => (
                  <div key={module.id}>
                    {/* Module Row */}
                    <button
                      onClick={() => toggleModule(module.id)}
                      className="w-full pl-12 pr-4 py-2.5 flex items-center gap-3 hover:bg-[var(--background-secondary)] transition-colors text-left"
                    >
                      {expandedModules.has(module.id) ? (
                        <ChevronDown className="w-4 h-4 text-[var(--foreground-muted)]" />
                      ) : (
                        <ChevronRight className="w-4 h-4 text-[var(--foreground-muted)]" />
                      )}
                      <div className="w-7 h-7 rounded-lg bg-slate-200 text-slate-600 flex items-center justify-center">
                        <Layers className="w-3.5 h-3.5" />
                      </div>
                      <div className="flex-1">
                        <p className="text-sm font-medium text-[var(--foreground)]">
                          {module.order_index}. {module.title}
                        </p>
                        <p className="text-xs text-[var(--foreground-muted)]">
                          {module.activities.length} activities · {module.total_xp} XP
                        </p>
                      </div>
                      <span className={`px-2 py-0.5 text-xs font-medium rounded-full ${
                        planColors[module.required_plan as keyof typeof planColors] || planColors.basic
                      }`}>
                        {module.required_plan === "free" ? (
                          <span className="flex items-center gap-1"><Unlock className="w-3 h-3" /> Free</span>
                        ) : (
                          <span className="flex items-center gap-1"><Lock className="w-3 h-3" /> {module.required_plan}</span>
                        )}
                      </span>
                      {!module.is_published && (
                        <EyeOff className="w-3 h-3 text-slate-400" />
                      )}
                    </button>

                    {/* Activities */}
                    {expandedModules.has(module.id) && (
                      <div className="bg-white border-l-2 border-slate-200 ml-16">
                        {module.activities.map(activity => {
                          const Icon = activityIcons[activity.type] || FileText;
                          
                          return (
                            <Link
                              key={activity.id}
                              href={`/admin/content/activities/${activity.id}`}
                              className="flex items-center gap-3 px-4 py-2.5 hover:bg-[var(--progress-bg)] transition-colors group"
                            >
                              <div className="w-6 h-6 rounded-lg bg-slate-100 flex items-center justify-center group-hover:bg-[var(--primary)] group-hover:text-white transition-colors">
                                <Icon className="w-3.5 h-3.5" />
                              </div>
                              <div className="flex-1 min-w-0">
                                <p className="text-sm text-[var(--foreground)] truncate group-hover:text-[var(--primary)]">
                                  {activity.title}
                                </p>
                                <p className="text-xs text-[var(--foreground-muted)]">
                                  {activity.type} · {activity.minutes || 0} min
                                </p>
                              </div>
                              <span className="flex items-center gap-1 text-xs text-amber-600">
                                <Zap className="w-3 h-3" />
                                {activity.xp} XP
                              </span>
                              <span className={`px-1.5 py-0.5 text-[10px] font-medium rounded ${
                                planColors[activity.required_plan as keyof typeof planColors] || planColors.basic
                              }`}>
                                {activity.required_plan}
                              </span>
                              {!activity.is_published && (
                                <EyeOff className="w-3 h-3 text-slate-400" />
                              )}
                              <Edit3 className="w-4 h-4 text-slate-300 group-hover:text-[var(--primary)] transition-colors" />
                            </Link>
                          );
                        })}
                        
                        {module.activities.length === 0 && (
                          <div className="px-4 py-6 text-center text-sm text-[var(--foreground-muted)]">
                            No activities in this module
                          </div>
                        )}
                      </div>
                    )}
                  </div>
                ))}
                
                {course.modules.length === 0 && (
                  <div className="px-4 py-6 text-center text-sm text-[var(--foreground-muted)]">
                    No modules in this course
                  </div>
                )}
              </div>
            )}
          </div>
        ))}
        
        {courses.length === 0 && (
          <div className="px-4 py-12 text-center">
            <GraduationCap className="w-12 h-12 text-slate-300 mx-auto mb-4" />
            <p className="text-[var(--foreground-muted)]">No courses found</p>
          </div>
        )}
      </div>
    </div>
  );
}

