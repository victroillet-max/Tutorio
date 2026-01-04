"use client";

import { useState, useCallback, useEffect } from "react";
import type { Stripe } from "@stripe/stripe-js";
import { 
  Loader2,
  X as CloseIcon,
  ArrowUp,
  ArrowDown,
  Crown,
  Zap,
  Sparkles,
  Check
} from "lucide-react";
import { toast } from "sonner";
import type { SubscriptionTier, UserCourseSubscription } from "@/lib/database.types";

interface EmbeddedPlanSwitcherProps {
  subscription: UserCourseSubscription;
  targetTier: SubscriptionTier;
  onClose: () => void;
  onSuccess: () => void;
}

export function EmbeddedPlanSwitcher({ 
  subscription,
  targetTier,
  onClose,
  onSuccess
}: EmbeddedPlanSwitcherProps) {
  const [isLoading, setIsLoading] = useState(true);
  const [clientSecret, setClientSecret] = useState<string | null>(null);
  const [stripePromise, setStripePromise] = useState<Promise<Stripe | null> | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [isDirectUpdate, setIsDirectUpdate] = useState(false);
  const [isProcessing, setIsProcessing] = useState(false);

  const isUpgrade = targetTier.price_monthly > subscription.price_monthly;
  const priceDiff = Math.abs(targetTier.price_monthly - subscription.price_monthly);

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

  // Lazy load Stripe
  const loadStripeAsync = useCallback(async () => {
    if (stripePromise) return stripePromise;
    
    const publishableKey = process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY;
    if (!publishableKey) {
      console.error("Stripe publishable key not found");
      return null;
    }
    
    const { loadStripe } = await import("@stripe/stripe-js");
    const promise = loadStripe(publishableKey);
    setStripePromise(promise);
    return promise;
  }, [stripePromise]);

  // Try to get checkout session for plan change, fall back to direct update
  useEffect(() => {
    const initPlanChange = async () => {
      try {
        // First try embedded checkout for plan change
        const response = await fetch("/api/stripe/plan-change-checkout", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            subscriptionId: subscription.subscription_id,
            stripeSubscriptionId: subscription.stripe_subscription_id,
            newTierSlug: targetTier.slug,
            courseId: subscription.course_id,
          }),
        });

        const data = await response.json();

        if (response.ok && data.clientSecret) {
          // Use embedded checkout
          await loadStripeAsync();
          setClientSecret(data.clientSecret);
          setIsLoading(false);
        } else if (response.ok && data.useDirectUpdate) {
          // Fall back to direct update (simpler UI)
          setIsDirectUpdate(true);
          setIsLoading(false);
        } else {
          throw new Error(data.error || "Failed to initialize plan change");
        }
      } catch (err) {
        console.error("Plan change init error:", err);
        // Fall back to direct update on any error
        setIsDirectUpdate(true);
        setIsLoading(false);
      }
    };

    initPlanChange();
  }, [subscription, targetTier, loadStripeAsync]);

  // Handle direct plan update (without embedded checkout)
  const handleDirectUpdate = async () => {
    setIsProcessing(true);
    setError(null);

    try {
      const response = await fetch("/api/stripe/change-plan", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          subscriptionId: subscription.subscription_id,
          stripeSubscriptionId: subscription.stripe_subscription_id,
          newTierSlug: targetTier.slug,
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || "Failed to change plan");
      }

      if (data.success) {
        if (isUpgrade) {
          toast.success("Plan Upgraded!", {
            description: `Your subscription has been upgraded to ${targetTier.name}. Changes are effective immediately.`,
          });
        } else {
          toast.success("Downgrade Scheduled!", {
            description: data.effectiveAt 
              ? `Your plan will change to ${targetTier.name} on ${new Date(data.effectiveAt).toLocaleDateString()}. You'll keep ${subscription.tier_name} access until then.`
              : `Your plan will change to ${targetTier.name} at the end of your billing period.`,
          });
        }
        onSuccess();
      } else if (data.portalUrl) {
        toast.info("Redirecting to Stripe...", {
          description: "Complete the plan change in the Stripe portal.",
        });
        window.location.href = data.portalUrl;
      }
    } catch (err) {
      console.error("Plan change error:", err);
      setError(err instanceof Error ? err.message : "Failed to change plan");
      toast.error("Plan Change Failed", {
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
        <div className={`flex items-center justify-between p-5 border-b border-[var(--border)] ${
          isUpgrade 
            ? 'bg-gradient-to-r from-[var(--primary)] to-[var(--primary-light)]' 
            : 'bg-gradient-to-r from-slate-600 to-slate-500'
        }`}>
          <div className="text-white">
            <div className="flex items-center gap-2 mb-1">
              {isUpgrade ? (
                <ArrowUp className="w-5 h-5" />
              ) : (
                <ArrowDown className="w-5 h-5" />
              )}
              <h3 className="font-bold text-lg">
                {isUpgrade ? 'Upgrade' : 'Downgrade'} to {targetTier.name}
              </h3>
            </div>
            <p className="text-white/80 text-sm">
              {subscription.course_title} - CHF {targetTier.price_monthly.toFixed(0)}/month
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
          className="overflow-y-auto"
          style={{ maxHeight: 'calc(100vh - 10rem)' }}
        >
          {isLoading ? (
            <div className="flex flex-col items-center justify-center h-64 gap-4">
              <Loader2 className="w-8 h-8 animate-spin text-[var(--primary)]" />
              <p className="text-[var(--foreground-muted)]">Preparing plan change...</p>
            </div>
          ) : isDirectUpdate ? (
            // Direct update UI (without embedded checkout)
            <div className="p-6">
              {/* Plan comparison */}
              <div className="flex items-center gap-4 mb-6">
                {/* Current Plan */}
                <div className="flex-1 p-4 rounded-xl bg-slate-50 border border-slate-200">
                  <div className="flex items-center gap-2 mb-2">
                    <Zap className="w-5 h-5 text-slate-500" />
                    <span className="text-sm font-medium text-slate-600">Current</span>
                  </div>
                  <p className="font-semibold text-lg">{subscription.tier_name}</p>
                  <p className="text-sm text-[var(--foreground-muted)]">
                    CHF {subscription.price_monthly.toFixed(0)}/mo
                  </p>
                </div>
                
                {/* Arrow */}
                <div className={`w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0 ${
                  isUpgrade ? 'bg-emerald-100' : 'bg-amber-100'
                }`}>
                  {isUpgrade ? (
                    <ArrowUp className="w-5 h-5 text-emerald-600" />
                  ) : (
                    <ArrowDown className="w-5 h-5 text-amber-600" />
                  )}
                </div>
                
                {/* New Plan */}
                <div className={`flex-1 p-4 rounded-xl border-2 ${
                  isUpgrade 
                    ? 'bg-[var(--primary)]/5 border-[var(--primary)]' 
                    : 'bg-amber-50 border-amber-300'
                }`}>
                  <div className="flex items-center gap-2 mb-2">
                    {isUpgrade ? (
                      <Crown className="w-5 h-5 text-[var(--primary)]" />
                    ) : (
                      <Zap className="w-5 h-5 text-amber-600" />
                    )}
                    <span className={`text-sm font-medium ${
                      isUpgrade ? 'text-[var(--primary)]' : 'text-amber-600'
                    }`}>
                      New Plan
                    </span>
                  </div>
                  <p className="font-semibold text-lg">{targetTier.name}</p>
                  <p className="text-sm text-[var(--foreground-muted)]">
                    CHF {targetTier.price_monthly.toFixed(0)}/mo
                  </p>
                </div>
              </div>

              {/* Features for new tier */}
              <div className="mb-6">
                <h4 className="font-medium mb-3 flex items-center gap-2">
                  <Sparkles className="w-4 h-4 text-[var(--primary)]" />
                  {isUpgrade ? "What you'll get:" : "Plan includes:"}
                </h4>
                <ul className="space-y-2">
                  {targetTier.slug === 'advanced' ? (
                    <>
                      <FeatureItem>Full course access</FeatureItem>
                      <FeatureItem>All activities & challenges</FeatureItem>
                      <FeatureItem highlighted>Unlimited AI tutor</FeatureItem>
                      <FeatureItem highlighted>Priority support</FeatureItem>
                      <FeatureItem highlighted>Advanced debugging help</FeatureItem>
                    </>
                  ) : (
                    <>
                      <FeatureItem>Full course access</FeatureItem>
                      <FeatureItem>All activities & challenges</FeatureItem>
                      <FeatureItem>AI tutor (25 messages/day)</FeatureItem>
                      <FeatureItem>Progress tracking</FeatureItem>
                    </>
                  )}
                </ul>
              </div>

              {/* Billing info */}
              <div className={`p-4 rounded-xl mb-6 ${
                isUpgrade ? 'bg-emerald-50' : 'bg-amber-50'
              }`}>
                <p className={`text-sm ${isUpgrade ? 'text-emerald-700' : 'text-amber-700'}`}>
                  {isUpgrade ? (
                    <>
                      You&apos;ll be charged <strong>CHF {priceDiff.toFixed(2)}</strong> immediately for the prorated upgrade. Your new plan benefits are available right away.
                    </>
                  ) : (
                    <>
                      Your plan will change at the end of your current billing period. You&apos;ll continue to enjoy your current plan benefits until then. <strong>No refund will be issued</strong> for the remaining time on your current plan.
                    </>
                  )}
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
                  Cancel
                </button>
                <button
                  onClick={handleDirectUpdate}
                  disabled={isProcessing}
                  className={`flex-1 py-3 px-4 font-semibold rounded-xl transition-all disabled:opacity-50 ${
                    isUpgrade 
                      ? 'bg-[var(--primary)] text-white hover:bg-[var(--primary-dark)]' 
                      : 'bg-amber-600 text-white hover:bg-amber-700'
                  }`}
                >
                  {isProcessing ? (
                    <span className="flex items-center justify-center gap-2">
                      <Loader2 className="w-4 h-4 animate-spin" />
                      Processing...
                    </span>
                  ) : (
                    <span className="flex items-center justify-center gap-2">
                      <Check className="w-4 h-4" />
                      {isUpgrade ? 'Confirm Upgrade' : 'Schedule Downgrade'}
                    </span>
                  )}
                </button>
              </div>
            </div>
          ) : clientSecret && stripePromise ? (
            // Embedded Stripe checkout
            <div className="pb-6">
              <StripeCheckoutWrapper 
                stripePromise={stripePromise} 
                clientSecret={clientSecret} 
              />
            </div>
          ) : (
            <div className="flex items-center justify-center h-64">
              <Loader2 className="w-8 h-8 animate-spin text-[var(--primary)]" />
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

// Stripe checkout wrapper (same as in flip-pricing-card)
function StripeCheckoutWrapper({ 
  stripePromise, 
  clientSecret 
}: { 
  stripePromise: Promise<Stripe | null>;
  clientSecret: string;
}) {
  const [StripeComponents, setStripeComponents] = useState<{
    EmbeddedCheckoutProvider: typeof import("@stripe/react-stripe-js").EmbeddedCheckoutProvider;
    EmbeddedCheckout: typeof import("@stripe/react-stripe-js").EmbeddedCheckout;
  } | null>(null);

  useEffect(() => {
    import("@stripe/react-stripe-js").then((mod) => {
      setStripeComponents({
        EmbeddedCheckoutProvider: mod.EmbeddedCheckoutProvider,
        EmbeddedCheckout: mod.EmbeddedCheckout,
      });
    });
  }, []);

  if (!StripeComponents) {
    return (
      <div className="flex items-center justify-center h-64">
        <Loader2 className="w-8 h-8 animate-spin text-[var(--primary)]" />
      </div>
    );
  }

  const { EmbeddedCheckoutProvider, EmbeddedCheckout } = StripeComponents;

  return (
    <EmbeddedCheckoutProvider
      stripe={stripePromise}
      options={{ clientSecret }}
    >
      <EmbeddedCheckout />
    </EmbeddedCheckoutProvider>
  );
}

function FeatureItem({ children, highlighted = false }: { children: React.ReactNode; highlighted?: boolean }) {
  return (
    <li className="flex items-center gap-2 text-sm">
      <Check className={`w-4 h-4 flex-shrink-0 ${highlighted ? 'text-[var(--primary)]' : 'text-emerald-500'}`} />
      <span className={highlighted ? 'text-[var(--foreground)] font-medium' : 'text-[var(--foreground)]'}>
        {children}
      </span>
    </li>
  );
}

