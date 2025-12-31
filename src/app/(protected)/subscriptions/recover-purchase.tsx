"use client";

import { useState } from "react";
import { RefreshCw, AlertCircle, CheckCircle2, Search } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useRouter } from "next/navigation";

/**
 * Component to recover a purchase when webhook fails
 * Offers automatic recovery (searches by email) and manual recovery (session ID)
 */
export function RecoverPurchase() {
  const router = useRouter();
  const [sessionId, setSessionId] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [isAutoRecovering, setIsAutoRecovering] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [recoveredCount, setRecoveredCount] = useState(0);
  const [isExpanded, setIsExpanded] = useState(false);
  const [showManual, setShowManual] = useState(false);

  // Automatic recovery - searches Stripe by user email
  const handleAutoRecover = async () => {
    setIsAutoRecovering(true);
    setError(null);

    try {
      const response = await fetch("/api/stripe/recover-subscriptions", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
      });

      const data = await response.json();

      if (!response.ok) {
        setError(data.error || "Failed to recover subscriptions");
        return;
      }

      if (data.recovered > 0) {
        setSuccess(true);
        setRecoveredCount(data.recovered);
        // Refresh the page to show the new subscriptions
        setTimeout(() => {
          router.refresh();
        }, 1500);
      } else {
        setError("No unsynced purchases found for your email. If you made a purchase with a different email, try the manual recovery below.");
        setShowManual(true);
      }
    } catch {
      setError("Network error. Please try again.");
    } finally {
      setIsAutoRecovering(false);
    }
  };

  // Manual recovery - uses session ID
  const handleManualSync = async () => {
    if (!sessionId.trim()) {
      setError("Please enter a session ID");
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      const response = await fetch("/api/stripe/sync-subscription", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ sessionId: sessionId.trim() }),
      });

      const data = await response.json();

      if (!response.ok) {
        setError(data.error || "Failed to sync subscription");
        return;
      }

      setSuccess(true);
      setRecoveredCount(1);
      setSessionId("");
      
      // Refresh the page to show the new subscription
      setTimeout(() => {
        router.refresh();
      }, 1500);
    } catch {
      setError("Network error. Please try again.");
    } finally {
      setIsLoading(false);
    }
  };

  if (success) {
    return (
      <div className="mb-6 p-4 bg-emerald-50 border border-emerald-200 rounded-xl">
        <div className="flex items-center gap-3 text-emerald-700">
          <CheckCircle2 className="w-5 h-5" />
          <div>
            <p className="font-medium">
              {recoveredCount > 1 
                ? `${recoveredCount} subscriptions recovered successfully!`
                : "Subscription recovered successfully!"}
            </p>
            <p className="text-sm text-emerald-600">Refreshing page...</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="mb-6 bg-white rounded-xl border border-[var(--border)] overflow-hidden">
      <button
        onClick={() => setIsExpanded(!isExpanded)}
        className="w-full p-4 flex items-center justify-between text-left hover:bg-slate-50 transition-colors"
      >
        <div className="flex items-center gap-3">
          <RefreshCw className="w-5 h-5 text-[var(--foreground-muted)]" />
          <div>
            <p className="font-medium text-[var(--foreground)]">
              Made a purchase but don&apos;t see it here?
            </p>
            <p className="text-sm text-[var(--foreground-muted)]">
              Click to recover your subscription
            </p>
          </div>
        </div>
        <span className="text-[var(--foreground-muted)]">
          {isExpanded ? "−" : "+"}
        </span>
      </button>

      {isExpanded && (
        <div className="px-4 pb-4 border-t border-[var(--border)]">
          <div className="pt-4 space-y-4">
            {/* Automatic Recovery - Primary Option */}
            <div className="bg-slate-50 rounded-lg p-4">
              <p className="text-sm text-[var(--foreground-muted)] mb-3">
                Click the button below to automatically find and sync any purchases made with your email address.
              </p>
              <Button
                onClick={handleAutoRecover}
                disabled={isAutoRecovering}
                className="w-full sm:w-auto"
              >
                {isAutoRecovering ? (
                  <>
                    <RefreshCw className="w-4 h-4 animate-spin mr-2" />
                    Searching...
                  </>
                ) : (
                  <>
                    <Search className="w-4 h-4 mr-2" />
                    Find My Purchases
                  </>
                )}
              </Button>
            </div>

            {/* Manual Recovery - Secondary Option */}
            {showManual && (
              <div className="border-t border-[var(--border)] pt-4">
                <p className="text-sm font-medium text-[var(--foreground)] mb-2">
                  Manual Recovery
                </p>
                <p className="text-sm text-[var(--foreground-muted)] mb-3">
                  If you have a Stripe session ID from your checkout URL (starts with <code className="bg-slate-100 px-1 rounded">cs_</code>), enter it below:
                </p>
                
                <div className="flex gap-2">
                  <input
                    type="text"
                    value={sessionId}
                    onChange={(e) => setSessionId(e.target.value)}
                    placeholder="cs_live_... or cs_test_..."
                    className="flex-1 px-3 py-2 border border-[var(--border)] rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent"
                  />
                  <Button
                    onClick={handleManualSync}
                    disabled={isLoading || !sessionId.trim()}
                    variant="outline"
                  >
                    {isLoading ? (
                      <RefreshCw className="w-4 h-4 animate-spin" />
                    ) : (
                      "Recover"
                    )}
                  </Button>
                </div>
              </div>
            )}

            {/* Show manual option link if not already shown */}
            {!showManual && (
              <button
                onClick={() => setShowManual(true)}
                className="text-sm text-[var(--primary)] hover:underline"
              >
                Have a session ID? Try manual recovery
              </button>
            )}

            {error && (
              <div className="flex items-start gap-2 text-sm text-red-600">
                <AlertCircle className="w-4 h-4 flex-shrink-0 mt-0.5" />
                <span>{error}</span>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

