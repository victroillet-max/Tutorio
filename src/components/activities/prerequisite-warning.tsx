"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import { cn } from "@/lib/utils";

interface PrerequisiteStatus {
  name: string;
  mastery: number;
  isRequired: boolean;
}

interface ActivityPrerequisiteWarningProps {
  activityId: string;
  className?: string;
}

export function ActivityPrerequisiteWarning({
  activityId,
  className,
}: ActivityPrerequisiteWarningProps) {
  const [isLoading, setIsLoading] = useState(true);
  const [prerequisites, setPrerequisites] = useState<PrerequisiteStatus[]>([]);
  const [dismissed, setDismissed] = useState(false);

  useEffect(() => {
    async function fetchPrerequisites() {
      try {
        const response = await fetch(`/api/skills/${activityId}/prerequisites`);
        if (response.ok) {
          const data = await response.json();
          // Filter to show only unmet prerequisites
          const unmet = (data.prerequisites || []).filter(
            (p: PrerequisiteStatus) => p.mastery < 70
          );
          setPrerequisites(unmet);
        }
      } catch (error) {
        console.error("Failed to fetch prerequisites:", error);
      } finally {
        setIsLoading(false);
      }
    }

    fetchPrerequisites();
  }, [activityId]);

  // Don't show anything while loading or if dismissed
  if (isLoading || dismissed) {
    return null;
  }

  // Don't show if all prerequisites are met
  if (prerequisites.length === 0) {
    return null;
  }

  const requiredUnmet = prerequisites.filter(p => p.isRequired);
  const recommendedUnmet = prerequisites.filter(p => !p.isRequired);

  return (
    <div className={cn(
      "rounded-xl border overflow-hidden mb-6",
      requiredUnmet.length > 0
        ? "bg-amber-50 border-amber-200"
        : "bg-blue-50 border-blue-200",
      className
    )}>
      <div className="p-4">
        <div className="flex items-start gap-3">
          {/* Icon */}
          <div className={cn(
            "w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0",
            requiredUnmet.length > 0 ? "bg-amber-100" : "bg-blue-100"
          )}>
            {requiredUnmet.length > 0 ? (
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-amber-600">
                <path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z" />
                <line x1="12" y1="9" x2="12" y2="13" />
                <line x1="12" y1="17" x2="12.01" y2="17" />
              </svg>
            ) : (
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-blue-600">
                <circle cx="12" cy="12" r="10" />
                <line x1="12" y1="16" x2="12" y2="12" />
                <line x1="12" y1="8" x2="12.01" y2="8" />
              </svg>
            )}
          </div>

          {/* Content */}
          <div className="flex-1">
            <h3 className={cn(
              "font-semibold text-sm",
              requiredUnmet.length > 0 ? "text-amber-800" : "text-blue-800"
            )}>
              {requiredUnmet.length > 0 
                ? "Foundational Skills Needed" 
                : "Recommended Review"}
            </h3>
            <p className={cn(
              "text-sm mt-1",
              requiredUnmet.length > 0 ? "text-amber-700" : "text-blue-700"
            )}>
              {requiredUnmet.length > 0 
                ? "This activity builds on concepts you haven't mastered yet. Consider reviewing them first for better understanding."
                : "You might find this easier after reviewing some related concepts."}
            </p>

            {/* Skill list */}
            <div className="mt-3 space-y-2">
              {requiredUnmet.map((prereq) => (
                <div
                  key={prereq.name}
                  className="flex items-center justify-between bg-white/60 rounded-lg px-3 py-2"
                >
                  <span className="text-sm font-medium text-slate-700">
                    {prereq.name}
                  </span>
                  <span className="text-xs text-slate-500">
                    {prereq.mastery}% mastery
                  </span>
                </div>
              ))}
              {recommendedUnmet.slice(0, 2).map((prereq) => (
                <div
                  key={prereq.name}
                  className="flex items-center justify-between bg-white/40 rounded-lg px-3 py-2"
                >
                  <span className="text-sm text-slate-600">
                    {prereq.name}
                  </span>
                  <span className="text-xs text-slate-400">
                    {prereq.mastery}% mastery
                  </span>
                </div>
              ))}
            </div>
          </div>

          {/* Dismiss button */}
          <button
            onClick={() => setDismissed(true)}
            className={cn(
              "p-1 rounded-full transition-colors",
              requiredUnmet.length > 0
                ? "text-amber-500 hover:bg-amber-200"
                : "text-blue-500 hover:bg-blue-200"
            )}
            aria-label="Dismiss"
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <line x1="18" y1="6" x2="6" y2="18" />
              <line x1="6" y1="6" x2="18" y2="18" />
            </svg>
          </button>
        </div>
      </div>

      {/* Action bar */}
      <div className={cn(
        "flex items-center gap-3 px-4 py-3 border-t",
        requiredUnmet.length > 0
          ? "bg-amber-100/50 border-amber-200"
          : "bg-blue-100/50 border-blue-200"
      )}>
        <Link
          href="/skills"
          className={cn(
            "flex-1 text-center py-2 px-4 rounded-lg text-sm font-medium transition-colors",
            requiredUnmet.length > 0
              ? "bg-amber-500 text-white hover:bg-amber-600"
              : "bg-blue-500 text-white hover:bg-blue-600"
          )}
        >
          Review Skills
        </Link>
        <button
          onClick={() => setDismissed(true)}
          className={cn(
            "py-2 px-4 rounded-lg text-sm font-medium transition-colors",
            requiredUnmet.length > 0
              ? "text-amber-700 hover:bg-amber-200"
              : "text-blue-700 hover:bg-blue-200"
          )}
        >
          Continue Anyway
        </button>
      </div>
    </div>
  );
}

