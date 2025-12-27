"use client";

import { cn } from "@/lib/utils";
import type { SkillWithProgress } from "@/lib/database.types";

interface SkillCardProps {
  skill: SkillWithProgress;
  onClick?: () => void;
  showProgress?: boolean;
  compact?: boolean;
  className?: string;
}

const CATEGORY_COLORS: Record<string, { bg: string; border: string; text: string }> = {
  ct_foundations: { bg: "bg-amber-500/10", border: "border-amber-500/30", text: "text-amber-400" },
  python_basics: { bg: "bg-blue-500/10", border: "border-blue-500/30", text: "text-blue-400" },
  control_flow: { bg: "bg-violet-500/10", border: "border-violet-500/30", text: "text-violet-400" },
  data_structures: { bg: "bg-emerald-500/10", border: "border-emerald-500/30", text: "text-emerald-400" },
  functions: { bg: "bg-rose-500/10", border: "border-rose-500/30", text: "text-rose-400" },
  advanced_topics: { bg: "bg-cyan-500/10", border: "border-cyan-500/30", text: "text-cyan-400" },
};

export function SkillCard({
  skill,
  onClick,
  showProgress = true,
  compact = false,
  className,
}: SkillCardProps) {
  const mastery = skill.progress?.mastery_level || 0;
  const colors = CATEGORY_COLORS[skill.category] || CATEGORY_COLORS.ct_foundations;

  const getMasteryLabel = () => {
    if (mastery >= 90) return "Mastered";
    if (mastery >= 70) return "Proficient";
    if (mastery >= 40) return "Learning";
    if (mastery > 0) return "Started";
    return "Not Started";
  };

  const getMasteryColor = () => {
    if (mastery >= 70) return "text-emerald-400";
    if (mastery >= 40) return "text-amber-400";
    if (mastery > 0) return "text-orange-400";
    return "text-zinc-500";
  };

  if (compact) {
    return (
      <button
        onClick={onClick}
        className={cn(
          "flex items-center gap-3 p-3 rounded-xl border transition-all",
          colors.bg,
          colors.border,
          onClick && "hover:scale-[1.02] cursor-pointer",
          className
        )}
      >
        {/* Status Indicator */}
        <div className={cn(
          "w-3 h-3 rounded-full flex-shrink-0",
          mastery >= 70 ? "bg-emerald-500" : mastery > 0 ? "bg-amber-500" : "bg-zinc-600"
        )} />
        
        <div className="flex-1 min-w-0 text-left">
          <h4 className="text-sm font-medium text-white truncate">
            {skill.name}
          </h4>
        </div>

        {showProgress && (
          <span className={cn("text-xs font-medium", getMasteryColor())}>
            {mastery}%
          </span>
        )}
      </button>
    );
  }

  return (
    <button
      onClick={onClick}
      className={cn(
        "relative p-5 rounded-xl border text-left transition-all w-full",
        colors.bg,
        colors.border,
        onClick && "hover:scale-[1.02] cursor-pointer",
        className
      )}
    >
      {/* Mastery Badge */}
      <div className="absolute top-3 right-3">
        <span className={cn(
          "text-[10px] font-medium px-2 py-1 rounded-full",
          mastery >= 70 ? "bg-emerald-500/20 text-emerald-400" :
          mastery > 0 ? "bg-amber-500/20 text-amber-400" :
          "bg-zinc-700/50 text-zinc-500"
        )}>
          {getMasteryLabel()}
        </span>
      </div>

      {/* Content */}
      <div className="pr-16">
        <h4 className="text-base font-semibold text-white mb-1">
          {skill.name}
        </h4>
        {skill.description && (
          <p className="text-sm text-zinc-400 line-clamp-2 mb-4">
            {skill.description}
          </p>
        )}
      </div>

      {/* Progress Bar */}
      {showProgress && (
        <div className="mt-4">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs text-zinc-500">Progress</span>
            <span className={cn("text-xs font-medium", getMasteryColor())}>
              {mastery}%
            </span>
          </div>
          <div className="h-1.5 bg-zinc-700 rounded-full overflow-hidden">
            <div
              className={cn(
                "h-full rounded-full transition-all",
                mastery >= 70 ? "bg-emerald-500" : mastery > 0 ? "bg-amber-500" : "bg-zinc-600"
              )}
              style={{ width: `${mastery}%` }}
            />
          </div>
        </div>
      )}

      {/* Stats */}
      <div className="flex items-center gap-4 mt-4 pt-4 border-t border-zinc-700/50">
        <div className="flex items-center gap-1.5 text-xs text-zinc-500">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <circle cx="12" cy="12" r="10" />
            <polyline points="12 6 12 12 16 14" />
          </svg>
          <span>{skill.estimated_minutes} min</span>
        </div>
        <div className="flex items-center gap-1.5 text-xs text-zinc-500">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <path d="M12 2L15.09 8.26L22 9.27L17 14.14L18.18 21.02L12 17.77L5.82 21.02L7 14.14L2 9.27L8.91 8.26L12 2Z" />
          </svg>
          <span>Difficulty {skill.difficulty_level}/5</span>
        </div>
      </div>
    </button>
  );
}

