"use client";

import { useState } from "react";
import Link from "next/link";
import { cn } from "@/lib/utils";
import type { SkillWithProgress, SkillCategory } from "@/lib/database.types";

interface SkillTreeData {
  categories: Record<SkillCategory, SkillWithProgress[]>;
  prerequisites: { skill_id: string; prerequisite_skill_id: string; is_required: boolean }[];
  totalSkills: number;
  masteredSkills: number;
}

interface SkillTreeProps {
  data: SkillTreeData;
  onSkillClick?: (skill: SkillWithProgress) => void;
  excludeFoundations?: boolean;
  className?: string;
}

const CATEGORY_LABELS: Record<SkillCategory, string> = {
  ct_foundations: "CT Foundations",
  python_basics: "Python Basics",
  control_flow: "Control Flow",
  data_structures: "Data Structures",
  functions: "Functions",
  advanced_topics: "Advanced Topics",
};

const CATEGORY_COLORS: Record<SkillCategory, { bg: string; border: string; text: string }> = {
  ct_foundations: { bg: "bg-amber-500/10", border: "border-amber-500/30", text: "text-amber-400" },
  python_basics: { bg: "bg-blue-500/10", border: "border-blue-500/30", text: "text-blue-400" },
  control_flow: { bg: "bg-violet-500/10", border: "border-violet-500/30", text: "text-violet-400" },
  data_structures: { bg: "bg-emerald-500/10", border: "border-emerald-500/30", text: "text-emerald-400" },
  functions: { bg: "bg-rose-500/10", border: "border-rose-500/30", text: "text-rose-400" },
  advanced_topics: { bg: "bg-cyan-500/10", border: "border-cyan-500/30", text: "text-cyan-400" },
};

export function SkillTree({ data, onSkillClick, excludeFoundations = true, className }: SkillTreeProps) {
  const [viewMode, setViewMode] = useState<"grid" | "tree">("grid");

  // Filter out ct_foundations if excludeFoundations is true
  const filteredCategories = excludeFoundations 
    ? Object.fromEntries(
        Object.entries(data.categories).filter(([category]) => category !== 'ct_foundations')
      ) as Record<SkillCategory, SkillWithProgress[]>
    : data.categories;

  // Recalculate totals for filtered skills
  const allFilteredSkills = Object.values(filteredCategories).flat();
  const totalSkills = allFilteredSkills.length;
  const masteredSkills = allFilteredSkills.filter(s => (s.progress?.mastery_level || 0) >= 70).length;

  return (
    <div className={cn("space-y-6", className)}>
      {/* Progress Header */}
      <div className="flex items-center justify-between">
        <div>
          <h2 className="text-xl font-bold text-white">Coding Skills</h2>
          <p className="text-sm text-zinc-400">
            {masteredSkills} of {totalSkills} skills mastered
          </p>
        </div>
        
        <div className="flex items-center gap-2">
          <div className="flex items-center gap-4 text-xs text-zinc-400 mr-4">
            <span className="flex items-center gap-1.5">
              <span className="w-2.5 h-2.5 rounded-full bg-emerald-500" />
              Mastered
            </span>
            <span className="flex items-center gap-1.5">
              <span className="w-2.5 h-2.5 rounded-full bg-amber-500" />
              Learning
            </span>
            <span className="flex items-center gap-1.5">
              <span className="w-2.5 h-2.5 rounded-full bg-zinc-600" />
              Locked
            </span>
          </div>
          
          <div className="flex bg-zinc-800 rounded-lg p-1">
            <button
              onClick={() => setViewMode("grid")}
              className={cn(
                "px-3 py-1.5 text-xs font-medium rounded-md transition-colors",
                viewMode === "grid"
                  ? "bg-zinc-700 text-white"
                  : "text-zinc-400 hover:text-white"
              )}
            >
              Grid
            </button>
            <button
              onClick={() => setViewMode("tree")}
              className={cn(
                "px-3 py-1.5 text-xs font-medium rounded-md transition-colors",
                viewMode === "tree"
                  ? "bg-zinc-700 text-white"
                  : "text-zinc-400 hover:text-white"
              )}
            >
              Tree
            </button>
          </div>
        </div>
      </div>

      {/* Overall Progress Bar */}
      <div className="bg-zinc-800/50 rounded-xl p-4">
        <div className="flex items-center justify-between mb-2">
          <span className="text-sm font-medium text-white">Overall Progress</span>
          <span className="text-sm text-zinc-400">
            {totalSkills > 0 ? Math.round((masteredSkills / totalSkills) * 100) : 0}%
          </span>
        </div>
        <div className="h-3 bg-zinc-700 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-violet-500 to-indigo-500 rounded-full transition-all duration-500"
            style={{ width: `${totalSkills > 0 ? (masteredSkills / totalSkills) * 100 : 0}%` }}
          />
        </div>
      </div>

      {/* Skill Categories */}
      <div className="space-y-6">
        {(Object.entries(filteredCategories) as [SkillCategory, SkillWithProgress[]][]).map(
          ([category, skills]) => {
            if (skills.length === 0) return null;
            
            const colors = CATEGORY_COLORS[category];
            const masteredInCategory = skills.filter(s => (s.progress?.mastery_level || 0) >= 70).length;
            
            return (
              <div key={category} className="space-y-3">
                <div className="flex items-center justify-between">
                  <h3 className={cn("text-sm font-semibold", colors.text)}>
                    {CATEGORY_LABELS[category]}
                  </h3>
                  <span className="text-xs text-zinc-500">
                    {masteredInCategory}/{skills.length} mastered
                  </span>
                </div>
                
                <div className={cn(
                  viewMode === "grid"
                    ? "grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-3"
                    : "flex flex-wrap gap-3"
                )}>
                  {skills.map((skill) => (
                    <SkillNode
                      key={skill.id}
                      skill={skill}
                      categoryColors={colors}
                      prerequisites={data.prerequisites.filter(p => p.skill_id === skill.id)}
                      allSkills={Object.values(data.categories).flat()}
                      onSkillClick={onSkillClick}
                    />
                  ))}
                </div>
              </div>
            );
          }
        )}
      </div>
    </div>
  );
}

interface SkillNodeProps {
  skill: SkillWithProgress;
  categoryColors: { bg: string; border: string; text: string };
  prerequisites: { skill_id: string; prerequisite_skill_id: string; is_required: boolean }[];
  allSkills: SkillWithProgress[];
  onSkillClick?: (skill: SkillWithProgress) => void;
}

function SkillNode({
  skill,
  categoryColors,
  prerequisites,
  allSkills,
  onSkillClick,
}: SkillNodeProps) {
  const mastery = skill.progress?.mastery_level || 0;
  const isLocked = prerequisites.some(p => {
    const prereqSkill = allSkills.find(s => s.id === p.prerequisite_skill_id);
    return p.is_required && (prereqSkill?.progress?.mastery_level || 0) < 70;
  });

  const content = (
    <div
      className={cn(
        "relative p-4 rounded-xl border text-left transition-all h-full",
        categoryColors.bg,
        categoryColors.border,
        isLocked
          ? "opacity-50 cursor-not-allowed"
          : "hover:scale-[1.02] cursor-pointer"
      )}
    >
      {/* Mastery Indicator */}
      <div className="absolute top-2 right-2">
        <div className={cn(
          "w-3 h-3 rounded-full",
          mastery >= 70 ? "bg-emerald-500" : mastery > 0 ? "bg-amber-500" : "bg-zinc-600"
        )} />
      </div>

      {/* Lock Icon */}
      {isLocked && (
        <div className="absolute top-2 left-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-zinc-500">
            <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
            <path d="M7 11V7a5 5 0 0 1 10 0v4" />
          </svg>
        </div>
      )}

      <h4 className="text-sm font-medium text-white line-clamp-2 mb-2 pr-4">
        {skill.name}
      </h4>
      
      {/* Progress Bar */}
      <div className="h-1.5 bg-zinc-700 rounded-full overflow-hidden">
        <div
          className={cn(
            "h-full rounded-full transition-all",
            mastery >= 70 ? "bg-emerald-500" : mastery > 0 ? "bg-amber-500" : "bg-zinc-600"
          )}
          style={{ width: `${mastery}%` }}
        />
      </div>
      
      <div className="flex items-center justify-between mt-2">
        <span className="text-xs text-zinc-400">{mastery}%</span>
        <span className="text-xs text-zinc-500">{skill.estimated_minutes}min</span>
      </div>
    </div>
  );

  if (isLocked) {
    return content;
  }

  return (
    <Link 
      href={`/skills/${skill.slug}`}
      onClick={() => onSkillClick?.(skill)}
    >
      {content}
    </Link>
  );
}

interface SkillDetailPanelProps {
  skill: SkillWithProgress;
  prerequisites: { skill_id: string; prerequisite_skill_id: string; is_required: boolean }[];
  allSkills: SkillWithProgress[];
  onClose: () => void;
}

function SkillDetailPanel({
  skill,
  prerequisites,
  allSkills,
  onClose,
}: SkillDetailPanelProps) {
  const mastery = skill.progress?.mastery_level || 0;
  const prereqSkills = prerequisites.map(p => ({
    ...p,
    skill: allSkills.find(s => s.id === p.prerequisite_skill_id),
  }));

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
      <div className="w-full max-w-md bg-zinc-900 rounded-2xl border border-zinc-800 shadow-2xl overflow-hidden animate-in zoom-in-95 duration-200">
        {/* Header */}
        <div className="flex items-start justify-between p-6 border-b border-zinc-800">
          <div>
            <h3 className="text-lg font-semibold text-white">{skill.name}</h3>
            <p className="text-sm text-zinc-400 mt-1">{skill.description}</p>
          </div>
          <button
            onClick={onClose}
            className="text-zinc-400 hover:text-white transition-colors"
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <line x1="18" y1="6" x2="6" y2="18" />
              <line x1="6" y1="6" x2="18" y2="18" />
            </svg>
          </button>
        </div>

        {/* Content */}
        <div className="p-6 space-y-6">
          {/* Mastery Progress */}
          <div>
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm font-medium text-white">Mastery Level</span>
              <span className={cn(
                "text-sm font-medium",
                mastery >= 70 ? "text-emerald-400" : mastery > 0 ? "text-amber-400" : "text-zinc-400"
              )}>
                {mastery}%
              </span>
            </div>
            <div className="h-3 bg-zinc-700 rounded-full overflow-hidden">
              <div
                className={cn(
                  "h-full rounded-full transition-all",
                  mastery >= 70 ? "bg-emerald-500" : mastery > 0 ? "bg-amber-500" : "bg-zinc-600"
                )}
                style={{ width: `${mastery}%` }}
              />
            </div>
          </div>

          {/* Stats */}
          <div className="grid grid-cols-2 gap-4">
            <div className="bg-zinc-800/50 rounded-lg p-3">
              <p className="text-xs text-zinc-400">Difficulty</p>
              <p className="text-sm font-medium text-white">
                {"*".repeat(skill.difficulty_level)}{Array.from({ length: 5 - skill.difficulty_level }).map((_, i) => <span key={`empty-star-${i}`} className="text-zinc-600">*</span>)}
              </p>
            </div>
            <div className="bg-zinc-800/50 rounded-lg p-3">
              <p className="text-xs text-zinc-400">Est. Time</p>
              <p className="text-sm font-medium text-white">{skill.estimated_minutes} min</p>
            </div>
            <div className="bg-zinc-800/50 rounded-lg p-3">
              <p className="text-xs text-zinc-400">Times Practiced</p>
              <p className="text-sm font-medium text-white">{skill.progress?.times_practiced || 0}</p>
            </div>
            <div className="bg-zinc-800/50 rounded-lg p-3">
              <p className="text-xs text-zinc-400">Last Practiced</p>
              <p className="text-sm font-medium text-white">
                {skill.progress?.last_practiced_at
                  ? new Date(skill.progress.last_practiced_at).toLocaleDateString()
                  : "Never"}
              </p>
            </div>
          </div>

          {/* Prerequisites */}
          {prereqSkills.length > 0 && (
            <div>
              <h4 className="text-sm font-medium text-white mb-3">Prerequisites</h4>
              <div className="space-y-2">
                {prereqSkills.map(({ skill: prereqSkill, is_required }) => {
                  if (!prereqSkill) return null;
                  const prereqMastery = prereqSkill.progress?.mastery_level || 0;
                  const isMet = prereqMastery >= 70;
                  
                  return (
                    <div
                      key={prereqSkill.id}
                      className={cn(
                        "flex items-center justify-between p-3 rounded-lg",
                        isMet ? "bg-emerald-500/10 border border-emerald-500/30" : "bg-zinc-800/50"
                      )}
                    >
                      <div className="flex items-center gap-2">
                        {isMet ? (
                          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-emerald-400">
                            <polyline points="20 6 9 17 4 12" />
                          </svg>
                        ) : (
                          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-zinc-500">
                            <circle cx="12" cy="12" r="10" />
                          </svg>
                        )}
                        <span className={cn(
                          "text-sm",
                          isMet ? "text-emerald-400" : "text-zinc-300"
                        )}>
                          {prereqSkill.name}
                        </span>
                      </div>
                      <span className={cn(
                        "text-xs",
                        is_required ? "text-zinc-400" : "text-zinc-500"
                      )}>
                        {is_required ? "Required" : "Recommended"}
                      </span>
                    </div>
                  );
                })}
              </div>
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="p-6 border-t border-zinc-800">
          <button
            onClick={onClose}
            className="w-full py-3 px-4 bg-violet-600 hover:bg-violet-500 text-white font-medium rounded-xl transition-colors"
          >
            Start Practicing
          </button>
        </div>
      </div>
    </div>
  );
}

