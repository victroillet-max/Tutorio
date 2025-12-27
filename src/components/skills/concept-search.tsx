"use client";

import { useState, useEffect, useRef, useCallback } from "react";
import { cn } from "@/lib/utils";
import type { Skill } from "@/lib/database.types";

interface ConceptSearchProps {
  onSelect?: (skill: Skill) => void;
  placeholder?: string;
  className?: string;
}

export function ConceptSearch({
  onSelect,
  placeholder = "Search concepts...",
  className,
}: ConceptSearchProps) {
  const [query, setQuery] = useState("");
  const [results, setResults] = useState<Skill[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isOpen, setIsOpen] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(0);
  const inputRef = useRef<HTMLInputElement>(null);
  const containerRef = useRef<HTMLDivElement>(null);

  // Debounced search
  const searchSkills = useCallback(async (searchQuery: string) => {
    if (!searchQuery.trim()) {
      setResults([]);
      return;
    }

    setIsLoading(true);
    try {
      const response = await fetch(`/api/skills/search?q=${encodeURIComponent(searchQuery)}`);
      if (response.ok) {
        const data = await response.json();
        setResults(data.skills || []);
      }
    } catch (error) {
      console.error("Search failed:", error);
      setResults([]);
    } finally {
      setIsLoading(false);
    }
  }, []);

  // Debounce effect
  useEffect(() => {
    const timer = setTimeout(() => {
      searchSkills(query);
    }, 300);

    return () => clearTimeout(timer);
  }, [query, searchSkills]);

  // Click outside to close
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setIsOpen(false);
      }
    };

    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (!isOpen || results.length === 0) return;

    switch (e.key) {
      case "ArrowDown":
        e.preventDefault();
        setSelectedIndex(prev => (prev + 1) % results.length);
        break;
      case "ArrowUp":
        e.preventDefault();
        setSelectedIndex(prev => (prev - 1 + results.length) % results.length);
        break;
      case "Enter":
        e.preventDefault();
        if (results[selectedIndex]) {
          handleSelect(results[selectedIndex]);
        }
        break;
      case "Escape":
        setIsOpen(false);
        inputRef.current?.blur();
        break;
    }
  };

  const handleSelect = (skill: Skill) => {
    setQuery("");
    setIsOpen(false);
    setResults([]);
    onSelect?.(skill);
  };

  const getCategoryLabel = (category: string) => {
    const labels: Record<string, string> = {
      ct_foundations: "CT Foundations",
      python_basics: "Python Basics",
      control_flow: "Control Flow",
      data_structures: "Data Structures",
      functions: "Functions",
      advanced_topics: "Advanced",
    };
    return labels[category] || category;
  };

  const getCategoryColor = (category: string) => {
    const colors: Record<string, string> = {
      ct_foundations: "bg-amber-500/20 text-amber-400",
      python_basics: "bg-blue-500/20 text-blue-400",
      control_flow: "bg-violet-500/20 text-violet-400",
      data_structures: "bg-emerald-500/20 text-emerald-400",
      functions: "bg-rose-500/20 text-rose-400",
      advanced_topics: "bg-cyan-500/20 text-cyan-400",
    };
    return colors[category] || "bg-zinc-500/20 text-zinc-400";
  };

  return (
    <div ref={containerRef} className={cn("relative", className)}>
      {/* Search Input */}
      <div className="relative">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="18"
          height="18"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          strokeLinecap="round"
          strokeLinejoin="round"
          className="absolute left-4 top-1/2 -translate-y-1/2 text-zinc-500"
        >
          <circle cx="11" cy="11" r="8" />
          <line x1="21" y1="21" x2="16.65" y2="16.65" />
        </svg>
        
        <input
          ref={inputRef}
          type="text"
          value={query}
          onChange={(e) => {
            setQuery(e.target.value);
            setIsOpen(true);
            setSelectedIndex(0);
          }}
          onFocus={() => setIsOpen(true)}
          onKeyDown={handleKeyDown}
          placeholder={placeholder}
          className={cn(
            "w-full pl-11 pr-4 py-3 rounded-xl",
            "bg-zinc-800 border border-zinc-700",
            "text-white placeholder:text-zinc-500",
            "focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent",
            "transition-all"
          )}
        />

        {isLoading && (
          <div className="absolute right-4 top-1/2 -translate-y-1/2">
            <svg
              className="animate-spin h-4 w-4 text-zinc-500"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
            >
              <circle
                className="opacity-25"
                cx="12"
                cy="12"
                r="10"
                stroke="currentColor"
                strokeWidth="4"
              />
              <path
                className="opacity-75"
                fill="currentColor"
                d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
              />
            </svg>
          </div>
        )}

        {!isLoading && query && (
          <button
            onClick={() => {
              setQuery("");
              setResults([]);
              inputRef.current?.focus();
            }}
            className="absolute right-4 top-1/2 -translate-y-1/2 text-zinc-500 hover:text-white transition-colors"
          >
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <line x1="18" y1="6" x2="6" y2="18" />
              <line x1="6" y1="6" x2="18" y2="18" />
            </svg>
          </button>
        )}
      </div>

      {/* Results Dropdown */}
      {isOpen && (query.trim() || results.length > 0) && (
        <div className={cn(
          "absolute top-full left-0 right-0 mt-2 z-50",
          "bg-zinc-900 border border-zinc-800 rounded-xl shadow-2xl",
          "max-h-80 overflow-y-auto",
          "animate-in fade-in slide-in-from-top-2 duration-200"
        )}>
          {results.length === 0 && !isLoading && query.trim() && (
            <div className="px-4 py-8 text-center">
              <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" className="mx-auto text-zinc-600 mb-2">
                <circle cx="11" cy="11" r="8" />
                <line x1="21" y1="21" x2="16.65" y2="16.65" />
              </svg>
              <p className="text-sm text-zinc-500">No concepts found for &quot;{query}&quot;</p>
            </div>
          )}

          {results.length > 0 && (
            <ul className="py-2">
              {results.map((skill, index) => (
                <li key={skill.id}>
                  <button
                    onClick={() => handleSelect(skill)}
                    className={cn(
                      "w-full px-4 py-3 text-left flex items-start gap-3",
                      "transition-colors",
                      selectedIndex === index
                        ? "bg-violet-500/10"
                        : "hover:bg-zinc-800/50"
                    )}
                  >
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 mb-1">
                        <span className="text-sm font-medium text-white truncate">
                          {skill.name}
                        </span>
                        <span className={cn(
                          "text-[10px] font-medium px-1.5 py-0.5 rounded-full",
                          getCategoryColor(skill.category)
                        )}>
                          {getCategoryLabel(skill.category)}
                        </span>
                      </div>
                      {skill.description && (
                        <p className="text-xs text-zinc-500 line-clamp-2">
                          {skill.description}
                        </p>
                      )}
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-zinc-600 flex-shrink-0 mt-0.5">
                      <polyline points="9 18 15 12 9 6" />
                    </svg>
                  </button>
                </li>
              ))}
            </ul>
          )}

          {!query.trim() && results.length === 0 && (
            <div className="px-4 py-6 text-center">
              <p className="text-sm text-zinc-500">Start typing to search concepts</p>
              <div className="flex items-center justify-center gap-2 mt-3 text-xs text-zinc-600">
                <kbd className="px-1.5 py-0.5 rounded bg-zinc-800 border border-zinc-700">
                  /
                </kbd>
                <span>to search</span>
                <kbd className="px-1.5 py-0.5 rounded bg-zinc-800 border border-zinc-700">
                  esc
                </kbd>
                <span>to close</span>
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

