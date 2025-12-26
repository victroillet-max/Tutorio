"use client";

import { useState, useEffect } from "react";
import { CheckCircle2, BookOpen, ChevronRight } from "lucide-react";
import type { Activity } from "@/lib/database.types";
import { markActivityComplete, trackActivityView } from "@/lib/activities/actions";

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

  // Track activity view when component mounts
  useEffect(() => {
    trackActivityView(activity.id).catch(console.error);
  }, [activity.id]);

  // Mark as complete when user scrolls to bottom or after reading time
  useEffect(() => {
    if (completed) return;

    const handleScroll = () => {
      const scrollHeight = document.documentElement.scrollHeight;
      const scrollTop = document.documentElement.scrollTop;
      const clientHeight = document.documentElement.clientHeight;
      
      // Check if scrolled to bottom (within 100px)
      if (scrollTop + clientHeight >= scrollHeight - 100) {
        handleComplete();
      }
    };

    // Also auto-complete after estimated reading time
    const readingTime = (activity.minutes || 5) * 60 * 1000; // Convert to ms
    const timer = setTimeout(() => {
      handleComplete();
    }, readingTime);

    window.addEventListener("scroll", handleScroll);
    
    return () => {
      window.removeEventListener("scroll", handleScroll);
      clearTimeout(timer);
    };
  }, [completed, activity.minutes]);

  async function handleComplete() {
    if (completed || isMarking) return;
    setIsMarking(true);
    
    try {
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
        <article className="prose prose-slate max-w-none prose-headings:font-bold prose-h1:text-2xl prose-h2:text-xl prose-h3:text-lg prose-p:text-[var(--foreground-muted)] prose-strong:text-[var(--foreground)] prose-code:bg-slate-100 prose-code:px-1.5 prose-code:py-0.5 prose-code:rounded prose-code:before:content-none prose-code:after:content-none prose-pre:bg-slate-900 prose-pre:text-slate-100">
          <MarkdownRenderer content={markdown} />
        </article>
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

// Simple markdown renderer (we can enhance this later)
function MarkdownRenderer({ content }: { content: string }) {
  // Parse markdown into HTML-like structure
  const lines = content.split('\n');
  const elements: React.ReactNode[] = [];
  let currentList: string[] = [];
  let inCodeBlock = false;
  let codeContent = "";
  let codeLanguage = "";
  
  const flushList = () => {
    if (currentList.length > 0) {
      elements.push(
        <ul key={`list-${elements.length}`} className="list-disc pl-6 space-y-1">
          {currentList.map((item, i) => (
            <li key={i}>{parseInline(item)}</li>
          ))}
        </ul>
      );
      currentList = [];
    }
  };

  const parseInline = (text: string): React.ReactNode => {
    // Bold: **text** or __text__
    text = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
    text = text.replace(/__(.*?)__/g, '<strong>$1</strong>');
    
    // Italic: *text* or _text_
    text = text.replace(/\*(.*?)\*/g, '<em>$1</em>');
    text = text.replace(/_(.*?)_/g, '<em>$1</em>');
    
    // Code: `text`
    text = text.replace(/`([^`]+)`/g, '<code>$1</code>');
    
    return <span dangerouslySetInnerHTML={{ __html: text }} />;
  };

  lines.forEach((line, index) => {
    // Code blocks
    if (line.startsWith('```')) {
      if (inCodeBlock) {
        elements.push(
          <pre key={`code-${elements.length}`} className="bg-slate-900 text-slate-100 p-4 rounded-lg overflow-x-auto">
            <code>{codeContent.trim()}</code>
          </pre>
        );
        codeContent = "";
        inCodeBlock = false;
      } else {
        flushList();
        codeLanguage = line.slice(3);
        inCodeBlock = true;
      }
      return;
    }
    
    if (inCodeBlock) {
      codeContent += line + '\n';
      return;
    }
    
    // Headers
    if (line.startsWith('# ')) {
      flushList();
      elements.push(
        <h1 key={`h1-${index}`} className="text-2xl font-bold mt-8 mb-4 first:mt-0">
          {line.slice(2)}
        </h1>
      );
      return;
    }
    if (line.startsWith('## ')) {
      flushList();
      elements.push(
        <h2 key={`h2-${index}`} className="text-xl font-bold mt-6 mb-3">
          {line.slice(3)}
        </h2>
      );
      return;
    }
    if (line.startsWith('### ')) {
      flushList();
      elements.push(
        <h3 key={`h3-${index}`} className="text-lg font-semibold mt-4 mb-2">
          {line.slice(4)}
        </h3>
      );
      return;
    }
    
    // List items
    if (line.startsWith('- ') || line.startsWith('* ')) {
      currentList.push(line.slice(2));
      return;
    }
    
    // Numbered list
    if (/^\d+\.\s/.test(line)) {
      currentList.push(line.replace(/^\d+\.\s/, ''));
      return;
    }
    
    // Empty line
    if (line.trim() === '') {
      flushList();
      return;
    }
    
    // Paragraph
    flushList();
    elements.push(
      <p key={`p-${index}`} className="mb-4 text-[var(--foreground-muted)] leading-relaxed">
        {parseInline(line)}
      </p>
    );
  });
  
  flushList();
  
  return <>{elements}</>;
}

