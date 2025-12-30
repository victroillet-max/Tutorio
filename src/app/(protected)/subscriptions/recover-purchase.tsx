"use client";

import { useState } from "react";
import { RefreshCw, AlertCircle, CheckCircle2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useRouter } from "next/navigation";

/**
 * Component to recover a purchase when webhook fails
 * Allows user to enter their Stripe session ID to sync the subscription
 */
export function RecoverPurchase() {
  const router = useRouter();
  const [sessionId, setSessionId] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [isExpanded, setIsExpanded] = useState(false);

  const handleSync = async () => {
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
      setSessionId("");
      
      // Refresh the page to show the new subscription
      setTimeout(() => {
        router.refresh();
      }, 1500);
    } catch (err) {
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
            <p className="font-medium">Subscription recovered successfully!</p>
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
            <p className="text-sm text-[var(--foreground-muted)]">
              If you completed a payment but your subscription isn&apos;t showing, 
              enter your Stripe session ID below. You can find it in the URL after 
              checkout (starts with <code className="bg-slate-100 px-1 rounded">cs_</code>).
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
                onClick={handleSync}
                disabled={isLoading || !sessionId.trim()}
                className="px-4"
              >
                {isLoading ? (
                  <RefreshCw className="w-4 h-4 animate-spin" />
                ) : (
                  "Recover"
                )}
              </Button>
            </div>

            {error && (
              <div className="flex items-center gap-2 text-sm text-red-600">
                <AlertCircle className="w-4 h-4" />
                {error}
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

