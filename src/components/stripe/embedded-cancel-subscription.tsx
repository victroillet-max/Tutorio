"use client";

import { useState, useEffect } from "react";
import { 
  Loader2,
  X as CloseIcon,
  AlertTriangle,
  XCircle,
  Calendar,
  Check,
  ShieldX
} from "lucide-react";
import { toast } from "sonner";
import type { UserCourseSubscription } from "@/lib/database.types";

interface EmbeddedCancelSubscriptionProps {
  subscription: UserCourseSubscription;
  onClose: () => void;
  onSuccess: () => void;
}

export function EmbeddedCancelSubscription({ 
  subscription,
  onClose,
  onSuccess
}: EmbeddedCancelSubscriptionProps) {
  const [isProcessing, setIsProcessing] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const periodEnd = new Date(subscription.current_period_end);

  // Lock body scroll when modal is open
  useEffect(() => {
    document.documentElement.style.overflow = 'hidden';
    document.body.style.overflow = 'hidden';
    document.body.style.position = 'fixed';
    document.body.style.width = '100%';
    document.body.style.top = `-${window.scrollY}px`;

    return () => {
      const scrollY = document.body.style.top;
      document.documentElement.style.overflow = '';
      document.body.style.overflow = '';
      document.body.style.position = '';
      document.body.style.width = '';
      document.body.style.top = '';
      if (scrollY) {
        window.scrollTo(0, parseInt(scrollY || '0') * -1);
      }
    };
  }, []);

  // Handle cancel subscription
  const handleCancel = async () => {
    setIsProcessing(true);
    setError(null);

    try {
      const response = await fetch("/api/stripe/cancel-subscription", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          subscriptionId: subscription.subscription_id,
          stripeSubscriptionId: subscription.stripe_subscription_id,
          cancelImmediately: false, // Cancel at period end
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || "Failed to cancel subscription");
      }

      if (data.success) {
        toast.success("Subscription Cancelled", {
          description: `You'll retain access until ${periodEnd.toLocaleDateString()}. You can resubscribe anytime.`,
        });
        onSuccess();
      }
    } catch (err) {
      console.error("Cancel subscription error:", err);
      setError(err instanceof Error ? err.message : "Failed to cancel subscription");
      toast.error("Cancellation Failed", {
        description: err instanceof Error ? err.message : "Please try again or contact support.",
      });
    } finally {
      setIsProcessing(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
      {/* Dark overlay */}
      <div 
        className="absolute inset-0 bg-black/60"
        onClick={onClose}
        style={{ animation: 'fadeIn 0.3s ease-out forwards' }}
      />
      
      {/* Modal */}
      <div 
        className="relative z-10 w-full max-w-lg bg-white rounded-2xl shadow-2xl overflow-hidden"
        style={{
          animation: 'scaleIn 0.4s cubic-bezier(0.16, 1, 0.3, 1) forwards',
          maxHeight: 'calc(100vh - 2rem)',
        }}
      >
        {/* Header */}
        <div className="flex items-center justify-between p-5 border-b border-[var(--border)] bg-gradient-to-r from-red-600 to-red-500">
          <div className="text-white">
            <div className="flex items-center gap-2 mb-1">
              <ShieldX className="w-5 h-5" />
              <h3 className="font-bold text-lg">
                Cancel Subscription
              </h3>
            </div>
            <p className="text-white/80 text-sm">
              {subscription.course_title}
            </p>
          </div>
          <button
            onClick={onClose}
            className="p-2 rounded-lg bg-white/10 hover:bg-white/20 transition-colors"
            aria-label="Close"
          >
            <CloseIcon className="w-5 h-5 text-white" />
          </button>
        </div>
        
        {/* Content */}
        <div 
          className="overflow-y-auto p-6"
          style={{ maxHeight: 'calc(100vh - 10rem)' }}
        >
          {/* Warning */}
          <div className="flex items-start gap-3 p-4 bg-amber-50 border border-amber-200 rounded-xl mb-6">
            <AlertTriangle className="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" />
            <div>
              <p className="text-sm font-medium text-amber-800">
                Are you sure you want to cancel?
              </p>
              <p className="text-sm text-amber-700 mt-1">
                You&apos;ll lose access to premium features when your current billing period ends.
              </p>
            </div>
          </div>

          {/* What you'll lose */}
          <div className="mb-6">
            <h4 className="font-medium mb-3 flex items-center gap-2 text-red-700">
              <XCircle className="w-4 h-4" />
              What you&apos;ll lose:
            </h4>
            <ul className="space-y-2">
              <LossItem>Full course access to {subscription.course_title}</LossItem>
              <LossItem>All activities & challenges</LossItem>
              <LossItem>AI tutor assistance</LossItem>
              <LossItem>Progress tracking features</LossItem>
            </ul>
          </div>

          {/* Access period info */}
          <div className="p-4 rounded-xl bg-slate-50 border border-slate-200 mb-6">
            <div className="flex items-center gap-3">
              <Calendar className="w-5 h-5 text-slate-500" />
              <div>
                <p className="text-sm font-medium text-slate-700">
                  You&apos;ll keep access until
                </p>
                <p className="text-lg font-semibold text-slate-900">
                  {periodEnd.toLocaleDateString('en-US', { 
                    weekday: 'long',
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric' 
                  })}
                </p>
              </div>
            </div>
          </div>

          {/* No refund policy */}
          <div className="p-4 rounded-xl bg-slate-50 border border-slate-200 mb-4">
            <p className="text-sm text-slate-600">
              <strong>No refund policy:</strong> Cancellations take effect at the end of your billing period. No refunds are provided for the remaining time.
            </p>
          </div>

          {/* Resubscribe info */}
          <div className="p-4 rounded-xl bg-emerald-50 border border-emerald-200 mb-6">
            <p className="text-sm text-emerald-700">
              <strong>Changed your mind?</strong> You can resubscribe anytime to regain full access. Your progress will be saved.
            </p>
          </div>

          {/* Error display */}
          {error && (
            <div className="p-3 mb-4 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm">
              {error}
            </div>
          )}

          {/* Actions */}
          <div className="flex gap-3">
            <button
              onClick={onClose}
              disabled={isProcessing}
              className="flex-1 py-3 px-4 bg-slate-100 text-slate-700 font-medium rounded-xl hover:bg-slate-200 transition-colors disabled:opacity-50"
            >
              Keep Subscription
            </button>
            <button
              onClick={handleCancel}
              disabled={isProcessing}
              className="flex-1 py-3 px-4 font-semibold rounded-xl transition-all disabled:opacity-50 bg-red-600 text-white hover:bg-red-700"
            >
              {isProcessing ? (
                <span className="flex items-center justify-center gap-2">
                  <Loader2 className="w-4 h-4 animate-spin" />
                  Processing...
                </span>
              ) : (
                <span className="flex items-center justify-center gap-2">
                  <Check className="w-4 h-4" />
                  Confirm Cancellation
                </span>
              )}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

function LossItem({ children }: { children: React.ReactNode }) {
  return (
    <li className="flex items-center gap-2 text-sm">
      <XCircle className="w-4 h-4 flex-shrink-0 text-red-400" />
      <span className="text-[var(--foreground-muted)]">{children}</span>
    </li>
  );
}

