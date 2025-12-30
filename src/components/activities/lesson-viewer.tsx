"use client";

import { useState, useEffect, useRef, useCallback } from "react";
import { CheckCircle2, BookOpen, ChevronRight } from "lucide-react";
import type { Activity } from "@/lib/database.types";
import { markActivityComplete, trackActivityView, updateActivityProgress } from "@/lib/activities/actions";
import { EnhancedMarkdown } from "./enhanced-markdown";

interface LessonViewerProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
}

export function LessonViewer({ activity, userId, isCompleted }: LessonViewerProps) {
  const [completed, setCompleted] = useState(isCompleted);
  const [isMarking, setIsMarking] = useState(false);
  
  const content = activity.content as { markdown?: string } | null;
  const markdown = content?.markdown || "";
  
  // B8: Track time spent on activity for "Hours Learned" stat
  const lastSavedRef = useRef<number>(Date.now());
  
  // Save time spent when component unmounts or activity completes
  // Only saves NEW time since last save (server accumulates)
  const saveTimeSpent = useCallback(async () => {
    const now = Date.now();
    const timeSpent = Math.floor((now - lastSavedRef.current) / 1000);
    if (timeSpent > 0) {
      try {
        await updateActivityProgress(activity.id, { timeSpentSeconds: timeSpent });
        lastSavedRef.current = now; // Reset after successful save
      } catch (error) {
        console.error("Failed to save time spent:", error);
      }
    }
  }, [activity.id]);
  
  // Track time on page visibility change and unmount
  useEffect(() => {
    const handleVisibilityChange = () => {
      if (document.hidden) {
        // Page hidden - save time spent and reset timer
        saveTimeSpent();
      }
      // No need to reset on visibility change - lastSavedRef handles it
    };
    
    document.addEventListener("visibilitychange", handleVisibilityChange);
    
    return () => {
      document.removeEventListener("visibilitychange", handleVisibilityChange);
      saveTimeSpent();
    };
  }, [saveTimeSpent]);

  // Track activity view when component mounts
  useEffect(() => {
    trackActivityView(activity.id).catch(console.error);
  }, [activity.id]);

  // REMOVED: Auto-scroll and timer completion
  // Previously auto-completed on scroll or timer which allowed students to "master" without reading.
  // Now requires explicit button click (fixes B2 Progress State Mismatch and U1 Auto-Mastery Problem)

  async function handleComplete() {
    if (completed || isMarking) return;
    setIsMarking(true);
    
    try {
      // Save time spent before marking complete
      await saveTimeSpent();
      await markActivityComplete(activity.id);
      setCompleted(true);
    } catch (error) {
      console.error("Failed to mark activity complete:", error);
    } finally {
      setIsMarking(false);
    }
  }

  return (
    <div className="bg-white rounded-2xl shadow-sm border border-[var(--border)] overflow-hidden">
      {/* Header */}
      <div className="flex items-center justify-between px-6 py-4 border-b border-[var(--border)] bg-slate-50">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-lg bg-[var(--primary)]/10 flex items-center justify-center">
            <BookOpen className="w-5 h-5 text-[var(--primary)]" />
          </div>
          <div>
            <h1 
              className="text-xl font-bold text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              {activity.title}
            </h1>
            <p className="text-sm text-[var(--foreground-muted)]">
              Lesson - {activity.minutes} min read
            </p>
          </div>
        </div>
        
        {completed && (
          <div className="flex items-center gap-2 px-3 py-1.5 bg-emerald-100 text-emerald-700 rounded-full">
            <CheckCircle2 className="w-4 h-4" />
            <span className="text-sm font-medium">Completed</span>
          </div>
        )}
      </div>
      
      {/* Content */}
      <div className="p-6 sm:p-8">
        {/* Enhanced markdown with custom blocks for engaging content */}
        <EnhancedMarkdown content={markdown} />
      </div>
      
      {/* Footer - Single action button */}
      <div className="px-6 py-4 border-t border-[var(--border)] bg-slate-50">
        <div className="flex justify-end">
          {completed ? (
            <div className="flex items-center gap-2 text-emerald-600">
              <CheckCircle2 className="w-5 h-5" />
              <span className="font-medium">Lesson Complete</span>
            </div>
          ) : (
            <button
              onClick={handleComplete}
              disabled={isMarking}
              className="flex items-center gap-2 px-6 py-3 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-hover)] transition-colors disabled:opacity-50"
            >
              {isMarking ? "Saving..." : "Complete Lesson"}
              <ChevronRight className="w-4 h-4" />
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

