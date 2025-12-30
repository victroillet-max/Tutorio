"use client";

import { useEffect, useState, useCallback, useRef } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import Link from "next/link";
import { 
  PartyPopper, 
  BookOpen, 
  CreditCard, 
  X,
  Sparkles,
  ArrowRight,
  Loader2
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Confetti } from "@/components/ui/confetti";

interface SubscriptionSuccessPopupProps {
  courseTitle?: string;
  courseSlug?: string;
}

/**
 * Subscription success popup modal with confetti
 * Shows after successful Stripe checkout
 * Also syncs subscription if session_id is present (handles webhook failures)
 */
export function SubscriptionSuccessPopup({ 
  courseTitle,
  courseSlug 
}: SubscriptionSuccessPopupProps) {
  const searchParams = useSearchParams();
  const router = useRouter();
  const [isOpen, setIsOpen] = useState(false);
  const [showConfetti, setShowConfetti] = useState(false);
  const [isSyncing, setIsSyncing] = useState(false);
  const [syncError, setSyncError] = useState<string | null>(null);
  const syncAttempted = useRef(false);

  useEffect(() => {
    const checkout = searchParams.get("checkout");
    const sessionId = searchParams.get("session_id");
    
    if (checkout === "success") {
      setIsOpen(true);
      // Trigger confetti with a small delay for visual effect
      setTimeout(() => setShowConfetti(true), 100);
      
      // If we have a session_id, sync the subscription (handles webhook failures)
      if (sessionId && !syncAttempted.current) {
        syncAttempted.current = true;
        syncSubscription(sessionId);
      }
    }
  }, [searchParams]);

  const syncSubscription = async (sessionId: string) => {
    setIsSyncing(true);
    setSyncError(null);
    
    try {
      const response = await fetch("/api/stripe/sync-subscription", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ sessionId }),
      });
      
      if (!response.ok) {
        const data = await response.json();
        // Don't show error if subscription already exists (duplicate sync)
        if (data.error !== "Session does not belong to this user") {
          console.error("Subscription sync failed:", data.error);
        }
      }
    } catch (error) {
      console.error("Failed to sync subscription:", error);
    } finally {
      setIsSyncing(false);
    }
  };

  const handleClose = useCallback(() => {
    setIsOpen(false);
    setShowConfetti(false);
    
    // Clean up URL
    const url = new URL(window.location.href);
    url.searchParams.delete("checkout");
    router.replace(url.pathname + url.search, { scroll: false });
  }, [router]);

  const handleConfettiComplete = useCallback(() => {
    setShowConfetti(false);
  }, []);

  // Handle escape key
  useEffect(() => {
    const handleEscape = (e: KeyboardEvent) => {
      if (e.key === "Escape" && isOpen) {
        handleClose();
      }
    };

    document.addEventListener("keydown", handleEscape);
    return () => document.removeEventListener("keydown", handleEscape);
  }, [isOpen, handleClose]);

  // Lock body scroll when open
  useEffect(() => {
    if (isOpen) {
      document.body.style.overflow = "hidden";
    } else {
      document.body.style.overflow = "";
    }
    return () => {
      document.body.style.overflow = "";
    };
  }, [isOpen]);

  if (!isOpen) return null;

  return (
    <>
      {/* Confetti Animation */}
      <Confetti 
        trigger={showConfetti} 
        onComplete={handleConfettiComplete}
        duration={4000}
        particleCount={150}
      />

      {/* Backdrop */}
      <div 
        className="fixed inset-0 z-[100] bg-black/60 backdrop-blur-sm animate-fadeIn"
        onClick={handleClose}
        aria-hidden="true"
        style={{ animation: "fadeIn 0.3s ease-out" }}
      />

      {/* Modal */}
      <div 
        className="fixed inset-0 z-[101] flex items-center justify-center p-4 pointer-events-none"
        role="dialog"
        aria-modal="true"
        aria-labelledby="success-title"
      >
        <div 
          className="relative w-full max-w-lg bg-white rounded-3xl shadow-2xl pointer-events-auto overflow-hidden"
          style={{ animation: "scaleIn 0.4s ease-out" }}
        >
          {/* Decorative Header Background */}
          <div className="absolute top-0 left-0 right-0 h-40 bg-gradient-to-br from-[var(--primary)] via-[var(--primary-light)] to-[#2a9d8f] opacity-10" />
          <div className="absolute top-0 left-0 right-0 h-40 overflow-hidden">
            <div className="absolute -top-20 -right-20 w-40 h-40 rounded-full bg-[var(--accent)]/10" />
            <div className="absolute -top-10 -left-10 w-32 h-32 rounded-full bg-[var(--primary)]/10" />
          </div>

          {/* Close Button */}
          <button
            onClick={handleClose}
            className="absolute top-4 right-4 p-2 rounded-full hover:bg-slate-100 transition-colors z-10"
            aria-label="Close"
          >
            <X className="w-5 h-5 text-[var(--foreground-muted)]" />
          </button>

          {/* Content */}
          <div className="relative px-8 py-10 text-center">
            {/* Success Icon */}
            <div className="relative inline-flex mb-6">
              <div className="w-20 h-20 rounded-full bg-gradient-to-br from-emerald-400 to-teal-500 flex items-center justify-center shadow-lg shadow-emerald-200">
                <PartyPopper className="w-10 h-10 text-white" />
              </div>
              {/* Sparkle decorations */}
              <Sparkles className="absolute -top-2 -right-2 w-6 h-6 text-amber-400 animate-pulse" />
              <Sparkles className="absolute -bottom-1 -left-3 w-5 h-5 text-[var(--accent)] animate-pulse animation-delay-300" />
            </div>

            {/* Title */}
            <h2 
              id="success-title"
              className="text-2xl sm:text-3xl font-bold text-[var(--foreground)] mb-3"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Welcome Aboard!
            </h2>

            {/* Message */}
            <p className="text-[var(--foreground-muted)] mb-2 text-lg">
              {isSyncing ? "Setting up your subscription..." : "Your subscription is now active."}
            </p>
            {isSyncing ? (
              <div className="flex items-center justify-center gap-2 text-[var(--foreground-muted)] mb-8">
                <Loader2 className="w-4 h-4 animate-spin" />
                <span>Please wait a moment...</span>
              </div>
            ) : (
              <p className="text-[var(--foreground-muted)] mb-8">
                {courseTitle ? (
                  <>
                    You now have full access to <span className="font-semibold text-[var(--primary)]">{courseTitle}</span>. 
                    Your learning journey starts now!
                  </>
                ) : (
                  "You now have full access to your course. Your learning journey starts now!"
                )}
              </p>
            )}

            {/* Action Buttons */}
            <div className="space-y-3">
              {/* Primary CTA - Go to Course */}
              <Link 
                href={courseSlug ? `/courses/${courseSlug}/learn` : "/courses"}
                onClick={handleClose}
                className="block"
              >
                <Button className="w-full h-12 text-base bg-[var(--primary)] hover:bg-[var(--primary-light)] gap-2 shadow-lg shadow-[var(--primary)]/20">
                  <BookOpen className="w-5 h-5" />
                  Start Learning
                  <ArrowRight className="w-4 h-4 ml-1" />
                </Button>
              </Link>

              {/* Secondary CTA - Manage Subscription */}
              <Link 
                href="/subscriptions"
                onClick={handleClose}
                className="block"
              >
                <Button variant="outline" className="w-full h-11 text-base gap-2 border-2">
                  <CreditCard className="w-4 h-4" />
                  Manage Subscription
                </Button>
              </Link>
            </div>

            {/* Subtle footer note */}
            <p className="mt-6 text-xs text-[var(--foreground-subtle)]">
              You can manage your subscription anytime from your account settings.
            </p>
          </div>
        </div>
      </div>
    </>
  );
}

