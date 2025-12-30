"use client";

import { useState, useCallback, useEffect } from "react";
import type { Stripe } from "@stripe/stripe-js";
import { 
  Check, 
  X, 
  Zap, 
  Crown, 
  Sparkles,
  Loader2,
  X as CloseIcon
} from "lucide-react";
import { toast } from "sonner";
import type { SubscriptionTier } from "@/lib/database.types";

// Features for each tier
const tierFeatures = {
  basic: [
    { name: "Full course access", included: true },
    { name: "All activities & challenges", included: true },
    { name: "AI tutor (25 messages/day)", included: true },
    { name: "Progress tracking", included: true },
    { name: "Unlimited AI tutor", included: false },
  ],
  advanced: [
    { name: "Full course access", included: true },
    { name: "All activities & challenges", included: true },
    { name: "Unlimited AI tutor", included: true },
    { name: "Priority support", included: true },
    { name: "Advanced debugging help", included: true },
  ],
};

interface FlipPricingCardProps {
  tier: SubscriptionTier;
  courseId: string;
  courseName: string;
  existingSubscription?: {
    tier_slug: string;
    tier_name: string;
  };
  stripeEnabled: boolean;
}

export function FlipPricingCard({ 
  tier, 
  courseId,
  courseName,
  existingSubscription, 
  stripeEnabled 
}: FlipPricingCardProps) {
  const [isFlipped, setIsFlipped] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [clientSecret, setClientSecret] = useState<string | null>(null);
  const [stripePromise, setStripePromise] = useState<Promise<Stripe | null> | null>(null);

  const isAdvanced = tier.slug === 'advanced';
  const isCurrentPlan = existingSubscription?.tier_slug === tier.slug;
  const canUpgrade = existingSubscription?.tier_slug === 'basic' && tier.slug === 'advanced';
  
  const Icon = isAdvanced ? Crown : Zap;

  // Lock body scroll when modal is open
  useEffect(() => {
    if (isFlipped) {
      // Lock scroll on both html and body for cross-browser support
      document.documentElement.style.overflow = 'hidden';
      document.body.style.overflow = 'hidden';
      document.body.style.position = 'fixed';
      document.body.style.width = '100%';
      document.body.style.top = `-${window.scrollY}px`;
    } else {
      const scrollY = document.body.style.top;
      document.documentElement.style.overflow = '';
      document.body.style.overflow = '';
      document.body.style.position = '';
      document.body.style.width = '';
      document.body.style.top = '';
      // Restore scroll position
      if (scrollY) {
        window.scrollTo(0, parseInt(scrollY || '0') * -1);
      }
    }
    return () => {
      document.documentElement.style.overflow = '';
      document.body.style.overflow = '';
      document.body.style.position = '';
      document.body.style.width = '';
      document.body.style.top = '';
    };
  }, [isFlipped]);

  // Lazy load Stripe only when needed
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

  const fetchClientSecret = useCallback(async () => {
    try {
      const response = await fetch("/api/stripe/embedded-checkout", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          courseId,
          tier: tier.slug,
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        console.error("Checkout API error:", data);
        throw new Error(data.error || data.details?.courseId?.[0] || "Failed to create checkout session");
      }

      return data.clientSecret;
    } catch (error) {
      console.error("Error fetching client secret:", error);
      throw error;
    }
  }, [courseId, tier.slug]);

  const handleSubscribeClick = async () => {
    if (!process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY) {
      toast.error("Payment Not Available", {
        description: "Stripe is not configured. Please try again later.",
      });
      return;
    }

    setIsLoading(true);

    try {
      // Load Stripe and fetch client secret in parallel
      const [stripe, secret] = await Promise.all([
        loadStripeAsync(),
        fetchClientSecret()
      ]);

      if (!stripe) {
        throw new Error("Failed to load payment system");
      }

      setClientSecret(secret);
      setIsFlipped(true);
      setIsLoading(false);
    } catch (error) {
      setIsLoading(false);
      toast.error("Checkout Failed", {
        description: error instanceof Error ? error.message : "Please try again.",
      });
    }
  };

  const handleClose = () => {
    setIsFlipped(false);
    // Clear client secret after animation completes
    setTimeout(() => {
      setClientSecret(null);
    }, 400);
  };

  return (
    <>
      {/* Checkout Modal Overlay */}
      {isFlipped && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
          {/* Dark overlay */}
          <div 
            className="absolute inset-0 bg-black/60"
            onClick={handleClose}
            style={{
              animation: 'fadeIn 0.3s ease-out forwards',
            }}
          />
          
          {/* Checkout Modal */}
          <div 
            className="relative z-10 w-full max-w-lg bg-white rounded-2xl shadow-2xl overflow-hidden"
            style={{
              animation: 'scaleIn 0.4s cubic-bezier(0.16, 1, 0.3, 1) forwards',
              maxHeight: 'calc(100vh - 2rem)',
            }}
          >
            {/* Header */}
            <div className="flex items-center justify-between p-5 border-b border-[var(--border)] bg-gradient-to-r from-[var(--primary)] to-[var(--primary-light)]">
              <div className="text-white">
                <h3 className="font-bold text-lg">
                  Subscribe to {tier.name}
                </h3>
                <p className="text-white/80 text-sm">
                  {courseName} - CHF {tier.price_monthly.toFixed(0)}/month
                </p>
              </div>
              <button
                onClick={handleClose}
                className="p-2 rounded-lg bg-white/10 hover:bg-white/20 transition-colors"
                aria-label="Close"
              >
                <CloseIcon className="w-5 h-5 text-white" />
              </button>
            </div>
            
            {/* Stripe Embedded Checkout */}
            <div 
              className="overflow-y-auto pb-6"
              style={{ maxHeight: 'calc(100vh - 8rem)' }}
            >
              {clientSecret && stripePromise ? (
                <StripeCheckoutWrapper 
                  stripePromise={stripePromise} 
                  clientSecret={clientSecret} 
                />
              ) : (
                <div className="flex items-center justify-center h-96">
                  <Loader2 className="w-8 h-8 animate-spin text-[var(--primary)]" />
                </div>
              )}
            </div>
          </div>
        </div>
      )}
      
      {/* Pricing Card */}
      <div 
        className={`
          relative bg-white rounded-2xl border-2 p-6 flex flex-col transition-all duration-300
          ${isCurrentPlan ? 'border-emerald-500 shadow-lg' : isAdvanced ? 'border-[var(--primary)] shadow-md' : 'border-[var(--border)]'}
          ${isLoading ? 'scale-[0.98] opacity-90' : 'hover:shadow-lg'}
        `}
      >
        {isCurrentPlan && (
          <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-emerald-500 text-white text-xs font-medium rounded-full">
            Current Plan
          </div>
        )}
        
        {isAdvanced && !isCurrentPlan && (
          <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-[var(--primary)] text-white text-xs font-medium rounded-full">
            Best Value
          </div>
        )}
        
        <div className="text-center mb-4">
          <div className={`w-12 h-12 rounded-xl flex items-center justify-center mx-auto mb-3 ${
            isAdvanced ? 'bg-[var(--primary)]/10' : 'bg-slate-100'
          }`}>
            <Icon className={`w-6 h-6 ${isAdvanced ? 'text-[var(--primary)]' : 'text-slate-600'}`} />
          </div>
          
          <h3 className="text-xl font-bold mb-1">{tier.name}</h3>
          
          <div className="mb-2">
            <span className="text-3xl font-bold">
              CHF {tier.price_monthly.toFixed(0)}
            </span>
            <span className="text-[var(--foreground-muted)] text-sm">/month</span>
          </div>
          
          {/* AI Limit Badge */}
          <div className="inline-flex items-center gap-1 px-2 py-1 bg-[var(--progress-bg)] rounded-lg">
            <Sparkles className="w-3 h-3 text-[var(--primary)]" />
            <span className="text-xs font-medium text-[var(--primary)]">
              AI Tutor: {isAdvanced ? 'Unlimited' : '25/day'}
            </span>
          </div>
        </div>
        
        <p className="text-[var(--foreground-muted)] text-center text-sm mb-4">
          {tier.description}
        </p>
        
        {/* Features List */}
        <ul className="space-y-2 mb-6 flex-grow">
          {(isAdvanced ? tierFeatures.advanced : tierFeatures.basic).map((feature) => (
            <FeatureItem key={feature.name} included={feature.included}>
              {feature.name}
            </FeatureItem>
          ))}
        </ul>
        
        {/* CTA Button */}
        <div className="mt-auto">
          {isCurrentPlan ? (
            <button
              disabled
              className="w-full py-3 px-4 bg-slate-100 text-slate-500 font-semibold rounded-xl cursor-not-allowed"
            >
              Current Plan
            </button>
          ) : !stripeEnabled ? (
            <button
              disabled
              className="w-full py-3 px-4 bg-slate-100 text-slate-400 font-semibold rounded-xl cursor-not-allowed"
            >
              Coming Soon
            </button>
          ) : canUpgrade ? (
            <button
              onClick={handleSubscribeClick}
              disabled={isLoading}
              className="w-full py-3 px-4 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-dark)] transition-all disabled:opacity-50"
            >
              {isLoading ? (
                <span className="flex items-center justify-center gap-2">
                  <Loader2 className="w-4 h-4 animate-spin" />
                  Loading...
                </span>
              ) : (
                `Upgrade to ${tier.name}`
              )}
            </button>
          ) : (
            <button
              onClick={handleSubscribeClick}
              disabled={isLoading}
              className={`w-full py-3 px-4 font-semibold rounded-xl transition-all disabled:opacity-50 ${
                isAdvanced 
                  ? 'bg-[var(--primary)] text-white hover:bg-[var(--primary-dark)] hover:shadow-lg hover:scale-[1.02]'
                  : 'bg-slate-100 text-slate-700 hover:bg-slate-200'
              }`}
            >
              {isLoading ? (
                <span className="flex items-center justify-center gap-2">
                  <Loader2 className="w-4 h-4 animate-spin" />
                  Preparing...
                </span>
              ) : (
                `Subscribe to ${tier.name}`
              )}
            </button>
          )}
        </div>
      </div>
    </>
  );
}

// Separate component for Stripe checkout to enable dynamic import
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

function FeatureItem({ 
  children, 
  included 
}: { 
  children: React.ReactNode; 
  included: boolean;
}) {
  return (
    <li className="flex items-center gap-2 text-sm">
      {included ? (
        <Check className="w-4 h-4 text-emerald-500 flex-shrink-0" />
      ) : (
        <X className="w-4 h-4 text-slate-300 flex-shrink-0" />
      )}
      <span className={included ? 'text-[var(--foreground)]' : 'text-slate-400'}>
        {children}
      </span>
    </li>
  );
}
