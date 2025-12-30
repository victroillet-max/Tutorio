"use client";

import { useEffect, useCallback } from "react";
import { useRouter } from "next/navigation";

interface KeyboardNavigationProps {
  prevUrl?: string;
  nextUrl?: string;
  skillUrl?: string;
}

/**
 * Keyboard navigation component for activities
 * - Left Arrow: Previous activity
 * - Right Arrow: Next activity  
 * - Escape: Back to skill page
 */
export function KeyboardNavigation({ prevUrl, nextUrl, skillUrl }: KeyboardNavigationProps) {
  const router = useRouter();

  const handleKeyDown = useCallback((e: KeyboardEvent) => {
    // Don't trigger if user is typing in an input, textarea, or contenteditable
    const target = e.target as HTMLElement;
    if (
      target.tagName === 'INPUT' ||
      target.tagName === 'TEXTAREA' ||
      target.isContentEditable ||
      target.closest('[role="textbox"]')
    ) {
      return;
    }

    // Don't trigger if modifier keys are pressed (except for some shortcuts)
    if (e.ctrlKey || e.metaKey || e.altKey) {
      return;
    }

    switch (e.key) {
      case 'ArrowLeft':
        if (prevUrl) {
          e.preventDefault();
          router.push(prevUrl);
        }
        break;
      case 'ArrowRight':
        if (nextUrl) {
          e.preventDefault();
          router.push(nextUrl);
        }
        break;
      case 'Escape':
        if (skillUrl) {
          e.preventDefault();
          router.push(skillUrl);
        }
        break;
    }
  }, [prevUrl, nextUrl, skillUrl, router]);

  useEffect(() => {
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [handleKeyDown]);

  // This component doesn't render anything visible
  // It just adds keyboard event listeners
  return null;
}

/**
 * Keyboard shortcuts hint that can be displayed to users
 */
export function KeyboardShortcutsHint({ 
  hasPrev, 
  hasNext 
}: { 
  hasPrev: boolean; 
  hasNext: boolean;
}) {
  return (
    <div className="hidden md:flex items-center gap-4 text-xs text-[var(--foreground-muted)]">
      {hasPrev && (
        <span className="flex items-center gap-1">
          <kbd className="px-1.5 py-0.5 bg-slate-100 border border-slate-200 rounded text-[10px] font-mono">
            ←
          </kbd>
          <span>Prev</span>
        </span>
      )}
      {hasNext && (
        <span className="flex items-center gap-1">
          <kbd className="px-1.5 py-0.5 bg-slate-100 border border-slate-200 rounded text-[10px] font-mono">
            →
          </kbd>
          <span>Next</span>
        </span>
      )}
      <span className="flex items-center gap-1">
        <kbd className="px-1.5 py-0.5 bg-slate-100 border border-slate-200 rounded text-[10px] font-mono">
          Esc
        </kbd>
        <span>Back</span>
      </span>
    </div>
  );
}

