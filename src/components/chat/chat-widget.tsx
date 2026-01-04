"use client";

import { useState, useRef, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { BobPopup } from "./bob-popup";
import { useChatContext } from "./chat-context";

interface Message {
  id: string;
  role: "user" | "assistant";
  content: string;
  timestamp: Date;
}

interface ChatWidgetProps {
  activityId?: string;
  skillId?: string;
  studentCode?: string;
  errorMessage?: string;
  currentQuestionText?: string;
  currentQuestionNumber?: number;
  courseName?: string;
  courseId?: string;
  className?: string;
}

export function ChatWidget({
  activityId,
  skillId,
  studentCode,
  errorMessage,
  currentQuestionText,
  currentQuestionNumber,
  courseName,
  courseId,
  className,
}: ChatWidgetProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [conversationId, setConversationId] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLTextAreaElement>(null);
  
  // Get popup state from context
  const { dismissPopup, markWelcomeSeen } = useChatContext();
  
  // Track the skillId for persistence
  const [currentSkillId, setCurrentSkillId] = useState<string | undefined>(skillId);
  
  // Storage key for persisting messages by skill
  const storageKey = skillId ? `tutorio-chat-${skillId}` : null;
  
  // Load messages from localStorage on mount or skill change
  useEffect(() => {
    if (skillId !== currentSkillId) {
      // Skill changed - load messages for new skill
      setCurrentSkillId(skillId);
      setConversationId(null);
      setError(null);
      
      if (skillId) {
        const stored = localStorage.getItem(`tutorio-chat-${skillId}`);
        if (stored) {
          try {
            const parsed = JSON.parse(stored);
            // Restore messages with Date objects
            const restoredMessages = parsed.messages?.map((m: Message & { timestamp: string }) => ({
              ...m,
              timestamp: new Date(m.timestamp)
            })) || [];
            setMessages(restoredMessages);
            setConversationId(parsed.conversationId || null);
          } catch {
            setMessages([]);
          }
        } else {
          setMessages([]);
        }
      } else {
        setMessages([]);
      }
    }
  }, [skillId, currentSkillId]);
  
  // Persist messages to localStorage when they change
  useEffect(() => {
    if (storageKey && messages.length > 0) {
      localStorage.setItem(storageKey, JSON.stringify({
        messages,
        conversationId,
        updatedAt: new Date().toISOString()
      }));
    }
  }, [messages, conversationId, storageKey]);
  
  // Clear chat history function
  const clearChatHistory = () => {
    setMessages([]);
    setConversationId(null);
    setError(null);
    if (storageKey) {
      localStorage.removeItem(storageKey);
    }
  };

  // Auto-scroll to bottom when messages change
  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  // Focus input when widget opens
  useEffect(() => {
    if (isOpen) {
      setTimeout(() => inputRef.current?.focus(), 100);
    }
  }, [isOpen]);

  const sendMessage = async () => {
    if (!input.trim() || isLoading) return;

    const userMessage: Message = {
      id: crypto.randomUUID(),
      role: "user",
      content: input.trim(),
      timestamp: new Date(),
    };

    setMessages(prev => [...prev, userMessage]);
    setInput("");
    setIsLoading(true);
    setError(null);

    try {
      const response = await fetch("/api/chat", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          message: userMessage.content,
          conversationId,
          activityId,
          skillId,
          studentCode,
          errorMessage,
          currentQuestionText,
          currentQuestionNumber,
          courseId,
        }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        if (response.status === 429) {
          setError("You've reached your daily message limit. Upgrade your plan for more messages.");
        } else if (response.status === 400) {
          // Validation error - provide user-friendly message
          if (errorData.details) {
            const firstError = Object.values(errorData.details)[0];
            const errorMsg = Array.isArray(firstError) ? firstError[0] : errorData.error;
            setError(errorMsg || "Please check your message and try again.");
          } else {
            setError("There was an issue with your message. Please try rephrasing it.");
          }
        } else if (response.status === 401) {
          setError("Please log in again to continue chatting with Bob.");
        } else if (response.status === 500) {
          setError("Bob is having some trouble right now. Please try again in a moment.");
        } else {
          setError(errorData.message || errorData.error || "Something went wrong. Please try again.");
        }
        return;
      }

      const data = await response.json();
      
      if (data.conversationId && !conversationId) {
        setConversationId(data.conversationId);
      }

      const assistantMessage: Message = {
        id: crypto.randomUUID(),
        role: "assistant",
        content: data.message,
        timestamp: new Date(),
      };

      setMessages(prev => [...prev, assistantMessage]);
    } catch (err) {
      console.error("Failed to send message:", err);
      setError("Failed to send message. Please try again.");
    } finally {
      setIsLoading(false);
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  };

  const toggleWidget = () => {
    const newIsOpen = !isOpen;
    setIsOpen(newIsOpen);
    
    // When opening the chat, dismiss any popup and mark welcome as seen
    if (newIsOpen) {
      dismissPopup();
      markWelcomeSeen();
    }
  };
  
  // Handler for when popup is clicked (opens chat)
  const handlePopupClick = () => {
    setIsOpen(true);
    dismissPopup();
    markWelcomeSeen();
  };

  return (
    <>
      {/* Bob Popup - appears next to the floating button */}
      <BobPopup onOpenChat={handlePopupClick} />
      
      {/* Floating Button */}
      <button
        onClick={toggleWidget}
        data-tour="chat-widget"
        className={cn(
          "fixed right-6 z-50 w-14 h-14 rounded-full shadow-lg safe-bottom",
          "bg-gradient-to-br from-[var(--primary)] to-[var(--primary-light)] text-white",
          "flex items-center justify-center",
          "hover:from-[var(--primary-hover)] hover:to-[var(--primary)] transition-all",
          "focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:ring-offset-2",
          isOpen && "rotate-90",
          className
        )}
        aria-label={isOpen ? "Close chat" : "Ask Bob for help"}
      >
        {isOpen ? (
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <line x1="18" y1="6" x2="6" y2="18" />
            <line x1="6" y1="6" x2="18" y2="18" />
          </svg>
        ) : (
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
          </svg>
        )}
      </button>

      {/* Chat Panel */}
      {isOpen && (
        <div
          className={cn(
            "fixed bottom-24 right-6 z-50",
            "w-[380px] max-w-[calc(100vw-48px)] h-[500px] max-h-[calc(100vh-150px)]",
            "bg-zinc-900 border border-zinc-800 rounded-2xl shadow-2xl",
            "flex flex-col overflow-hidden",
            "animate-in slide-in-from-bottom-5 duration-200"
          )}
        >
          {/* Header */}
          <div className="flex items-center justify-between px-4 py-3 border-b border-zinc-800 bg-zinc-900/80 backdrop-blur-sm">
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 rounded-full bg-gradient-to-br from-[var(--primary)] to-[var(--primary-light)] flex items-center justify-center">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
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
              <div>
                <h3 className="text-sm font-semibold text-white">Bob</h3>
                <p className="text-xs text-zinc-400">Your AI Tutor</p>
              </div>
            </div>
            <div className="flex items-center gap-2">
              {messages.length > 0 && (
                <button
                  onClick={clearChatHistory}
                  className="text-zinc-500 hover:text-zinc-300 transition-colors text-xs px-2 py-1 rounded hover:bg-zinc-800"
                  aria-label="Clear chat history"
                >
                  Clear
                </button>
              )}
              <button
                onClick={() => setIsOpen(false)}
                className="text-zinc-400 hover:text-white transition-colors"
                aria-label="Close chat"
              >
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <line x1="18" y1="6" x2="6" y2="18" />
                  <line x1="6" y1="6" x2="18" y2="18" />
                </svg>
              </button>
            </div>
          </div>

          {/* Messages */}
          <div className="flex-1 overflow-y-auto p-4 space-y-4">
            {messages.length === 0 && (
              <div className="text-center text-zinc-500 py-8">
                <div className="w-16 h-16 mx-auto mb-4 rounded-full bg-zinc-800 flex items-center justify-center">
                  <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" className="text-[var(--accent)]">
                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                  </svg>
                </div>
                <p className="text-sm font-medium text-zinc-300 mb-1">Hi! I&apos;m Bob, your AI Tutor</p>
                {activityId ? (
                  <p className="text-xs text-zinc-500">I can see the activity you&apos;re working on. Ask me anything about it!</p>
                ) : courseName ? (
                  <p className="text-xs text-zinc-500">Ask me anything about {courseName}.</p>
                ) : (
                  <p className="text-xs text-zinc-500">Ask me anything about your current lesson.</p>
                )}
              </div>
            )}

            {messages.map((message) => (
              <div
                key={message.id}
                className={cn(
                  "flex",
                  message.role === "user" ? "justify-end" : "justify-start"
                )}
              >
                <div
                  className={cn(
                    "max-w-[85%] rounded-2xl px-4 py-2.5 text-sm",
                    message.role === "user"
                      ? "bg-[var(--primary)] text-white rounded-br-md"
                      : "bg-zinc-800 text-zinc-100 rounded-bl-md"
                  )}
                >
                  <MessageContent content={message.content} />
                </div>
              </div>
            ))}

            {isLoading && (
              <div className="flex justify-start">
                <div className="bg-zinc-800 rounded-2xl rounded-bl-md px-4 py-3">
                  <div className="flex items-center gap-1">
                    <span className="w-2 h-2 bg-[var(--accent)] rounded-full animate-bounce" style={{ animationDelay: "0ms" }} />
                    <span className="w-2 h-2 bg-[var(--accent)] rounded-full animate-bounce" style={{ animationDelay: "150ms" }} />
                    <span className="w-2 h-2 bg-[var(--accent)] rounded-full animate-bounce" style={{ animationDelay: "300ms" }} />
                  </div>
                </div>
              </div>
            )}

            {error && (
              <div className="bg-red-500/10 border border-red-500/30 rounded-lg px-4 py-3 text-sm text-red-400">
                {error}
              </div>
            )}

            <div ref={messagesEndRef} />
          </div>

          {/* Input */}
          <div className="p-4 border-t border-zinc-800 bg-zinc-900/80 backdrop-blur-sm">
            <div className="flex items-end gap-2">
              <textarea
                ref={inputRef}
                value={input}
                onChange={(e) => setInput(e.target.value)}
                onKeyDown={handleKeyDown}
                placeholder="Ask me anything..."
                rows={1}
                className={cn(
                  "flex-1 resize-none rounded-xl border-0 bg-zinc-800 px-4 py-3",
                  "text-sm text-white placeholder:text-zinc-500",
                  "focus:outline-none focus:ring-2 focus:ring-[var(--primary)]",
                  "max-h-32"
                )}
                style={{ minHeight: "44px" }}
              />
              <Button
                onClick={sendMessage}
                disabled={!input.trim() || isLoading}
                className={cn(
                  "h-11 w-11 rounded-xl p-0",
                  "bg-[var(--accent)] hover:bg-[var(--accent-dark)] text-white",
                  "disabled:opacity-50 disabled:cursor-not-allowed"
                )}
              >
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <line x1="22" y1="2" x2="11" y2="13" />
                  <polygon points="22 2 15 22 11 13 2 9 22 2" />
                </svg>
              </Button>
            </div>
          </div>
        </div>
      )}
    </>
  );
}

/**
 * Message content with markdown-like rendering
 */
function MessageContent({ content }: { content: string }) {
  // Simple markdown-like parsing
  const parts = content.split(/(```[\s\S]*?```)/g);

  return (
    <div className="space-y-2">
      {parts.map((part, index) => {
        if (part.startsWith("```") && part.endsWith("```")) {
          // Code block
          const codeContent = part.slice(3, -3);
          const [lang, ...codeLines] = codeContent.split("\n");
          const code = codeLines.join("\n").trim();
          
          return (
            <pre
              key={index}
              className="bg-zinc-900 rounded-lg p-3 overflow-x-auto text-xs"
            >
              <code className="text-green-400">{code || lang}</code>
            </pre>
          );
        }
        
        // Regular text with basic formatting
        return (
          <div key={index} className="whitespace-pre-wrap break-words">
            {part.split(/(\*\*.*?\*\*)/g).map((segment, i) => {
              if (segment.startsWith("**") && segment.endsWith("**")) {
                return (
                  <strong key={i} className="font-semibold">
                    {segment.slice(2, -2)}
                  </strong>
                );
              }
              return segment;
            })}
          </div>
        );
      })}
    </div>
  );
}

