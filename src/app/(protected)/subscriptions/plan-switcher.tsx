"use client";

import { useState } from "react";
import { Loader2, ArrowUp, ArrowDown, Check, Crown, Zap, Shield } from "lucide-react";
import { Button } from "@/components/ui/button";
import { toast } from "sonner";
import type { UserCourseSubscription, SubscriptionTier } from "@/lib/database.types";

interface PlanSwitcherProps {
  subscription: UserCourseSubscription;
  tiers: SubscriptionTier[];
}

export function PlanSwitcher({ subscription, tiers }: PlanSwitcherProps) {
  const [isLoading, setIsLoading] = useState(false);
  const [showConfirmation, setShowConfirmation] = useState(false);
  const [selectedTier, setSelectedTier] = useState<SubscriptionTier | null>(null);

  const currentTier = tiers.find(t => t.slug === subscription.tier_slug);
  const otherTiers = tiers.filter(t => t.slug !== subscription.tier_slug);
  
  // Check if this subscription has a Stripe subscription ID
  // Admin accounts or manually created subscriptions won't have one
  if (!subscription.stripe_subscription_id) {
    return (
      <div className="p-4 rounded-lg bg-slate-50 border border-slate-200">
        <div className="flex items-start gap-3">
          <Shield className="w-5 h-5 text-slate-500 mt-0.5" />
          <div>
            <p className="text-sm font-medium text-slate-700">
              Manual Subscription
            </p>
            <p className="text-sm text-slate-500 mt-1">
              This subscription was created manually (e.g., admin access or promotional grant) and is not linked to Stripe billing. 
              Plan changes are not available for this type of subscription.
            </p>
          </div>
        </div>
      </div>
    );
  }
  
  if (otherTiers.length === 0) {
    return (
      <p className="text-sm text-[var(--foreground-muted)]">
        No other plans available.
      </p>
    );
  }

  const handlePlanChange = async (newTier: SubscriptionTier) => {
    setSelectedTier(newTier);
    setShowConfirmation(true);
  };

  const confirmPlanChange = async () => {
    if (!selectedTier) return;
    
    setIsLoading(true);

    try {
      const response = await fetch("/api/stripe/change-plan", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          subscriptionId: subscription.subscription_id,
          stripeSubscriptionId: subscription.stripe_subscription_id,
          newTierSlug: selectedTier.slug,
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || "Failed to change plan");
      }

      if (data.success) {
        const isUpgrade = selectedTier.price_monthly > (currentTier?.price_monthly || 0);
        toast.success(isUpgrade ? "Plan Upgraded!" : "Plan Changed!", {
          description: `Your subscription has been ${isUpgrade ? 'upgraded' : 'changed'} to ${selectedTier.name}. Changes are effective immediately.`,
        });
        
        // Refresh the page to show updated subscription
        window.location.reload();
      } else if (data.portalUrl) {
        // Fallback to Stripe portal
        toast.info("Redirecting to Stripe...", {
          description: "Complete the plan change in the Stripe portal.",
        });
        window.location.href = data.portalUrl;
      }
    } catch (error) {
      console.error("Plan change error:", error);
      toast.error("Plan Change Failed", {
        description: error instanceof Error ? error.message : "Please try again or contact support.",
      });
    } finally {
      setIsLoading(false);
      setShowConfirmation(false);
      setSelectedTier(null);
    }
  };

  const cancelConfirmation = () => {
    setShowConfirmation(false);
    setSelectedTier(null);
  };

  // Confirmation Dialog
  if (showConfirmation && selectedTier) {
    const isUpgrade = selectedTier.price_monthly > (currentTier?.price_monthly || 0);
    const priceDiff = Math.abs(selectedTier.price_monthly - (currentTier?.price_monthly || 0));
    
    return (
      <div className="bg-white rounded-xl border border-[var(--border)] p-6">
        <h5 className="font-semibold mb-3 text-[var(--foreground)]">
          Confirm Plan Change
        </h5>
        
        <div className="flex items-center gap-4 mb-4">
          {/* Current Plan */}
          <div className="flex-1 p-3 rounded-lg bg-slate-50 border border-slate-200">
            <div className="flex items-center gap-2 mb-1">
              <Zap className="w-4 h-4 text-slate-500" />
              <span className="text-sm font-medium text-slate-600">Current</span>
            </div>
            <p className="font-semibold">{currentTier?.name}</p>
            <p className="text-sm text-[var(--foreground-muted)]">
              CHF {currentTier?.price_monthly}/mo
            </p>
          </div>
          
          {/* Arrow */}
          <div className={`w-8 h-8 rounded-full flex items-center justify-center ${
            isUpgrade ? 'bg-emerald-100' : 'bg-amber-100'
          }`}>
            {isUpgrade ? (
              <ArrowUp className="w-4 h-4 text-emerald-600" />
            ) : (
              <ArrowDown className="w-4 h-4 text-amber-600" />
            )}
          </div>
          
          {/* New Plan */}
          <div className={`flex-1 p-3 rounded-lg border-2 ${
            isUpgrade 
              ? 'bg-[var(--primary)]/5 border-[var(--primary)]' 
              : 'bg-amber-50 border-amber-300'
          }`}>
            <div className="flex items-center gap-2 mb-1">
              {isUpgrade ? (
                <Crown className="w-4 h-4 text-[var(--primary)]" />
              ) : (
                <Zap className="w-4 h-4 text-amber-600" />
              )}
              <span className={`text-sm font-medium ${
                isUpgrade ? 'text-[var(--primary)]' : 'text-amber-600'
              }`}>
                {isUpgrade ? 'Upgrade' : 'Downgrade'}
              </span>
            </div>
            <p className="font-semibold">{selectedTier.name}</p>
            <p className="text-sm text-[var(--foreground-muted)]">
              CHF {selectedTier.price_monthly}/mo
            </p>
          </div>
        </div>
        
        {/* Info Box */}
        <div className={`p-3 rounded-lg mb-4 ${
          isUpgrade ? 'bg-emerald-50' : 'bg-amber-50'
        }`}>
          <p className={`text-sm ${isUpgrade ? 'text-emerald-700' : 'text-amber-700'}`}>
            {isUpgrade ? (
              <>
                You'll be charged a prorated amount of approximately CHF {priceDiff.toFixed(2)} for the remainder of this billing period. Your new plan benefits are available immediately.
              </>
            ) : (
              <>
                Your plan will be downgraded immediately. You'll receive a prorated credit of approximately CHF {priceDiff.toFixed(2)} on your next billing cycle.
              </>
            )}
          </p>
        </div>
        
        {/* Actions */}
        <div className="flex gap-3">
          <Button
            variant="outline"
            onClick={cancelConfirmation}
            disabled={isLoading}
            className="flex-1"
          >
            Cancel
          </Button>
          <Button
            onClick={confirmPlanChange}
            disabled={isLoading}
            className={`flex-1 ${
              isUpgrade 
                ? 'bg-[var(--primary)] hover:bg-[var(--primary-dark)]' 
                : 'bg-amber-600 hover:bg-amber-700'
            }`}
          >
            {isLoading ? (
              <>
                <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                Processing...
              </>
            ) : (
              <>
                <Check className="w-4 h-4 mr-2" />
                Confirm {isUpgrade ? 'Upgrade' : 'Downgrade'}
              </>
            )}
          </Button>
        </div>
      </div>
    );
  }

  return (
    <div className="grid sm:grid-cols-2 gap-4">
      {otherTiers.map((tier) => {
        const isUpgrade = tier.price_monthly > (currentTier?.price_monthly || 0);
        const priceDiff = Math.abs(tier.price_monthly - (currentTier?.price_monthly || 0));
        
        return (
          <div
            key={tier.id}
            className={`p-4 rounded-xl border-2 transition-all ${
              isUpgrade 
                ? 'border-[var(--primary)]/30 hover:border-[var(--primary)] bg-white'
                : 'border-slate-200 hover:border-slate-400 bg-white'
            }`}
          >
            <div className="flex items-center justify-between mb-3">
              <div className="flex items-center gap-2">
                {isUpgrade ? (
                  <Crown className="w-5 h-5 text-[var(--primary)]" />
                ) : (
                  <Zap className="w-5 h-5 text-slate-500" />
                )}
                <span className="font-semibold">{tier.name}</span>
              </div>
              <span className={`text-xs px-2 py-1 rounded-full font-medium ${
                isUpgrade 
                  ? 'bg-emerald-100 text-emerald-700' 
                  : 'bg-amber-100 text-amber-700'
              }`}>
                {isUpgrade ? `+CHF ${priceDiff}/mo` : `-CHF ${priceDiff}/mo`}
              </span>
            </div>
            
            <p className="text-sm text-[var(--foreground-muted)] mb-3">
              {tier.description || (isUpgrade 
                ? 'Get unlimited AI tutor access and priority support.'
                : 'Keep essential features at a lower price.'
              )}
            </p>
            
            <Button
              onClick={() => handlePlanChange(tier)}
              disabled={isLoading}
              variant={isUpgrade ? "default" : "outline"}
              className={`w-full ${
                isUpgrade 
                  ? 'bg-[var(--primary)] hover:bg-[var(--primary-dark)]' 
                  : ''
              }`}
            >
              {isUpgrade ? (
                <>
                  <ArrowUp className="w-4 h-4 mr-2" />
                  Upgrade to {tier.name}
                </>
              ) : (
                <>
                  <ArrowDown className="w-4 h-4 mr-2" />
                  Switch to {tier.name}
                </>
              )}
            </Button>
          </div>
        );
      })}
    </div>
  );
}

