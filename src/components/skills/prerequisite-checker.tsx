"use client";

import { useState, useEffect } from "react";
import { cn } from "@/lib/utils";
import Link from "next/link";

interface PrerequisiteStatus {
  skillId: string;
  name: string;
  mastery: number;
  isRequired: boolean;
}

interface PrerequisiteCheckerProps {
  skillId: string;
  skillName: string;
  onProceed?: () => void;
  onReview?: (skillId: string) => void;
  className?: string;
}

export function PrerequisiteChecker({
  skillId,
  skillName,
  onProceed,
  onReview,
  className,
}: PrerequisiteCheckerProps) {
  const [isLoading, setIsLoading] = useState(true);
  const [prerequisites, setPrerequisites] = useState<PrerequisiteStatus[]>([]);
  const [allMet, setAllMet] = useState(true);

  useEffect(() => {
    async function checkPrerequisites() {
      setIsLoading(true);
      try {
        const response = await fetch(`/api/skills/${skillId}/prerequisites`);
        if (response.ok) {
          const data = await response.json();
          setPrerequisites(data.prerequisites || []);
          setAllMet(data.allMet);
        }
      } catch (error) {
        console.error("Failed to check prerequisites:", error);
      } finally {
        setIsLoading(false);
      }
    }

    checkPrerequisites();
  }, [skillId]);

  if (isLoading) {
    return (
      <div className={cn("animate-pulse", className)}>
        <div className="h-32 bg-zinc-800 rounded-xl" />
      </div>
    );
  }

  if (allMet || prerequisites.length === 0) {
    return null; // Don't show anything if all prerequisites are met
  }

  const requiredUnmet = prerequisites.filter(p => p.isRequired && p.mastery < 70);
  const recommendedUnmet = prerequisites.filter(p => !p.isRequired && p.mastery < 70);

  return (
    <div className={cn(
      "bg-amber-500/10 border border-amber-500/30 rounded-xl p-5",
      className
    )}>
      <div className="flex items-start gap-3 mb-4">
        <div className="w-10 h-10 rounded-full bg-amber-500/20 flex items-center justify-center flex-shrink-0">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-amber-400">
            <circle cx="12" cy="12" r="10" />
            <line x1="12" y1="8" x2="12" y2="12" />
            <line x1="12" y1="16" x2="12.01" y2="16" />
          </svg>
        </div>
        <div>
          <h3 className="text-base font-semibold text-amber-300">
            Before You Start
          </h3>
          <p className="text-sm text-amber-200/70 mt-1">
            {skillName} builds on some foundational concepts. Review them first for the best experience.
          </p>
        </div>
      </div>

      {/* Required Prerequisites */}
      {requiredUnmet.length > 0 && (
        <div className="mb-4">
          <h4 className="text-xs font-medium text-amber-400 uppercase tracking-wider mb-2">
            Required Prerequisites
          </h4>
          <div className="space-y-2">
            {requiredUnmet.map((prereq) => (
              <div
                key={prereq.skillId}
                className="flex items-center justify-between bg-zinc-900/50 rounded-lg p-3"
              >
                <div className="flex items-center gap-3">
                  <div className={cn(
                    "w-2 h-2 rounded-full",
                    prereq.mastery >= 70 ? "bg-emerald-500" :
                    prereq.mastery > 0 ? "bg-amber-500" :
                    "bg-zinc-600"
                  )} />
                  <span className="text-sm text-zinc-200">{prereq.name}</span>
                </div>
                <div className="flex items-center gap-3">
                  <span className="text-xs text-zinc-500">{prereq.mastery}%</span>
                  <button
                    onClick={() => onReview?.(prereq.skillId)}
                    className="text-xs text-amber-400 hover:text-amber-300 font-medium transition-colors"
                  >
                    Review
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Recommended Prerequisites */}
      {recommendedUnmet.length > 0 && (
        <div className="mb-4">
          <h4 className="text-xs font-medium text-zinc-400 uppercase tracking-wider mb-2">
            Recommended
          </h4>
          <div className="space-y-2">
            {recommendedUnmet.map((prereq) => (
              <div
                key={prereq.skillId}
                className="flex items-center justify-between bg-zinc-900/30 rounded-lg p-3"
              >
                <div className="flex items-center gap-3">
                  <div className={cn(
                    "w-2 h-2 rounded-full",
                    prereq.mastery >= 70 ? "bg-emerald-500" :
                    prereq.mastery > 0 ? "bg-amber-500" :
                    "bg-zinc-600"
                  )} />
                  <span className="text-sm text-zinc-300">{prereq.name}</span>
                </div>
                <div className="flex items-center gap-3">
                  <span className="text-xs text-zinc-500">{prereq.mastery}%</span>
                  <button
                    onClick={() => onReview?.(prereq.skillId)}
                    className="text-xs text-zinc-400 hover:text-zinc-300 font-medium transition-colors"
                  >
                    Review
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Actions */}
      <div className="flex gap-3 mt-4 pt-4 border-t border-amber-500/20">
        <Link
          href="/courses/computational-thinking"
          className={cn(
            "flex-1 py-2.5 px-4 rounded-lg text-sm font-medium text-center",
            "bg-amber-500 text-zinc-900 hover:bg-amber-400 transition-colors"
          )}
        >
          Review Prerequisites
        </Link>
        <button
          onClick={onProceed}
          className={cn(
            "px-4 py-2.5 rounded-lg text-sm font-medium",
            "bg-zinc-800 text-zinc-300 hover:bg-zinc-700 transition-colors"
          )}
        >
          Continue Anyway
        </button>
      </div>
    </div>
  );
}

/**
 * Inline prerequisite warning for activity pages
 */
export function PrerequisiteWarning({
  unmetPrerequisites,
  className,
}: {
  unmetPrerequisites: { name: string; mastery: number }[];
  className?: string;
}) {
  if (unmetPrerequisites.length === 0) return null;

  return (
    <div className={cn(
      "flex items-center gap-2 px-4 py-3 rounded-lg",
      "bg-amber-500/10 border border-amber-500/30",
      className
    )}>
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-amber-400 flex-shrink-0">
        <circle cx="12" cy="12" r="10" />
        <line x1="12" y1="8" x2="12" y2="12" />
        <line x1="12" y1="16" x2="12.01" y2="16" />
      </svg>
      <p className="text-sm text-amber-200">
        <span className="font-medium">Struggling?</span> You might want to review{" "}
        {unmetPrerequisites.map((p, i) => (
          <span key={p.name}>
            {i > 0 && i === unmetPrerequisites.length - 1 ? " and " : i > 0 ? ", " : ""}
            <button className="underline hover:no-underline">{p.name}</button>
          </span>
        ))}
        .
      </p>
    </div>
  );
}

