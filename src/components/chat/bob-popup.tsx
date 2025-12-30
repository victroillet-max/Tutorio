"use client";

import { useChatContext } from "./chat-context";
import { cn } from "@/lib/utils";

interface BobPopupProps {
  onOpenChat: () => void;
}

/**
 * Speech bubble popup that appears next to Bob (the AI tutor button)
 * Shows contextual messages to encourage students to use the AI tutor
 */
export function BobPopup({ onOpenChat }: BobPopupProps) {
  const { popup, dismissPopup } = useChatContext();

  if (!popup.show) return null;

  const handleClick = () => {
    dismissPopup();
    onOpenChat();
  };

  const handleClose = (e: React.MouseEvent) => {
    e.stopPropagation();
    dismissPopup();
  };

  return (
    <div
      className={cn(
        "fixed bottom-6 right-24 z-50 max-w-[280px]",
        "animate-in slide-in-from-right-5 fade-in duration-300"
      )}
    >
      {/* Speech bubble */}
        <div
          onClick={handleClick}
          className={cn(
            "relative cursor-pointer rounded-2xl px-4 py-3 shadow-lg",
            "border transition-all hover:scale-[1.02]",
            popup.type === "welcome"
              ? "bg-gradient-to-br from-[var(--primary)] to-[var(--primary-light)] border-[var(--primary)] text-white"
              : "bg-zinc-800 border-zinc-700 text-zinc-100"
          )}
        >
        {/* Close button */}
        <button
          onClick={handleClose}
          className={cn(
            "absolute -top-2 -right-2 w-6 h-6 rounded-full flex items-center justify-center",
            "transition-colors shadow-md",
            popup.type === "welcome"
              ? "bg-[var(--primary-dark)] hover:bg-[var(--primary)] text-white"
              : "bg-zinc-700 hover:bg-zinc-600 text-zinc-300"
          )}
          aria-label="Dismiss"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="14"
            height="14"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <line x1="18" y1="6" x2="6" y2="18" />
            <line x1="6" y1="6" x2="18" y2="18" />
          </svg>
        </button>

        {/* Avatar for welcome message */}
        {popup.type === "welcome" && (
          <div className="flex items-start gap-3">
            <div className="flex-shrink-0 w-10 h-10 rounded-full bg-white/20 flex items-center justify-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="20"
                height="20"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <circle cx="12" cy="12" r="3" />
                <path d="M12 2v2" />
                <path d="M12 20v2" />
                <path d="m4.93 4.93 1.41 1.41" />
                <path d="m17.66 17.66 1.41 1.41" />
                <path d="M2 12h2" />
                <path d="M20 12h2" />
                <path d="m6.34 17.66-1.41 1.41" />
                <path d="m19.07 4.93-1.41 1.41" />
              </svg>
            </div>
            <div className="flex-1">
              <p className="font-semibold text-sm mb-0.5">Bob</p>
              <p className="text-sm text-white/90 leading-snug">{popup.message}</p>
            </div>
          </div>
        )}

        {/* Help message - simpler layout */}
        {popup.type === "help" && (
          <div className="flex items-start gap-3">
            <div className="flex-shrink-0 w-8 h-8 rounded-full bg-[var(--accent)]/20 flex items-center justify-center">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                className="text-[var(--accent)]"
              >
                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
              </svg>
            </div>
            <div className="flex-1">
              <p className="text-sm leading-snug">{popup.message}</p>
              <p className="text-xs text-zinc-400 mt-1">Click to chat with Bob</p>
            </div>
          </div>
        )}

        {/* Speech bubble tail pointing to Bob button */}
        <div
          className={cn(
            "absolute -right-2 bottom-4 w-4 h-4 rotate-45",
            popup.type === "welcome"
              ? "bg-[var(--primary-light)]"
              : "bg-zinc-800 border-r border-b border-zinc-700"
          )}
        />
      </div>
    </div>
  );
}

