"use client";

import { useState } from "react";
import { ArrowUp, ArrowDown, Crown, Zap, Shield, ExternalLink, Check, XCircle, User } from "lucide-react";
import { Button } from "@/components/ui/button";
import Link from "next/link";
import type { UserCourseSubscription, SubscriptionTier } from "@/lib/database.types";
import { EmbeddedPlanSwitcher } from "@/components/stripe/embedded-plan-switcher";
import { EmbeddedCancelSubscription } from "@/components/stripe/embedded-cancel-subscription";

interface PlanSwitcherProps {
  subscription: UserCourseSubscription;
  tiers: SubscriptionTier[];
}

export function PlanSwitcher({ subscription, tiers }: PlanSwitcherProps) {
  const [selectedTier, setSelectedTier] = useState<SubscriptionTier | null>(null);
  const [showModal, setShowModal] = useState(false);
  const [showCancelModal, setShowCancelModal] = useState(false);

  const currentTier = tiers.find(t => t.slug === subscription.tier_slug);
  const otherTiers = tiers.filter(t => t.slug !== subscription.tier_slug);
  
  // Sort tiers by price (lowest first) for consistent display
  const sortedTiers = [...tiers].sort((a, b) => a.price_monthly - b.price_monthly);
  
  // Check if this subscription has a Stripe subscription ID
  // Admin accounts or manually created subscriptions won't have one
  if (!subscription.stripe_subscription_id) {
    return (
      <div className="p-4 rounded-lg bg-slate-50 border border-slate-200">
        <div className="flex items-start gap-3">
          <Shield className="w-5 h-5 text-slate-500 mt-0.5" />
          <div className="flex-1">
            <p className="text-sm font-medium text-slate-700">
              Manual Subscription
            </p>
            <p className="text-sm text-slate-500 mt-1">
              This subscription was created manually (e.g., admin access or promotional grant) and is not linked to Stripe billing.
            </p>
            {otherTiers.length > 0 && (
              <div className="mt-3">
                <p className="text-sm text-slate-600 mb-2">
                  To switch plans, you can subscribe through our billing system:
                </p>
                <Link
                  href={`/pricing?course=${subscription.course_slug}`}
                  className="inline-flex items-center gap-2 px-3 py-2 text-sm font-medium bg-[var(--primary)] text-white rounded-lg hover:bg-[var(--primary-dark)] transition-colors"
                >
                  <ExternalLink className="w-4 h-4" />
                  View Subscription Options
                </Link>
              </div>
            )}
          </div>
        </div>
      </div>
    );
  }
  
  if (sortedTiers.length === 0) {
    return (
      <p className="text-sm text-[var(--foreground-muted)]">
        No plans available.
      </p>
    );
  }

  const handlePlanSelect = (tier: SubscriptionTier) => {
    setSelectedTier(tier);
    setShowModal(true);
  };

  const handleClose = () => {
    setShowModal(false);
    setSelectedTier(null);
  };

  const handleSuccess = () => {
    setShowModal(false);
    setSelectedTier(null);
    // Refresh the page to show updated subscription
    window.location.reload();
  };

  const handleCancelSuccess = () => {
    setShowCancelModal(false);
    // Refresh the page to show updated subscription
    window.location.reload();
  };

  return (
    <>
      {/* Plan Switcher Modal */}
      {showModal && selectedTier && (
        <EmbeddedPlanSwitcher
          subscription={subscription}
          targetTier={selectedTier}
          onClose={handleClose}
          onSuccess={handleSuccess}
        />
      )}

      {/* Cancel Subscription Modal */}
      {showCancelModal && (
        <EmbeddedCancelSubscription
          subscription={subscription}
          onClose={() => setShowCancelModal(false)}
          onSuccess={handleCancelSuccess}
        />
      )}

      {/* Plan Options - Show Free + all paid tiers */}
      <div className="grid sm:grid-cols-3 gap-4">
        {/* Free Tier - Cancel subscription option */}
        <div className="p-4 rounded-xl border-2 border-slate-200 hover:border-red-300 bg-white transition-all">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center gap-2">
              <User className="w-5 h-5 text-slate-400" />
              <span className="font-semibold">Free</span>
            </div>
            <span className="text-xs px-2 py-1 rounded-full font-medium bg-red-100 text-red-700">
              -CHF {currentTier?.price_monthly || 0}/mo
            </span>
          </div>
          
          <p className="text-sm text-[var(--foreground-muted)] mb-3">
            Demo access only. Cancel your subscription to switch to free.
          </p>
          
          <Button
            variant="outline"
            className="w-full border-red-200 text-red-600 hover:bg-red-50 hover:border-red-300"
            onClick={() => setShowCancelModal(true)}
          >
            <XCircle className="w-4 h-4 mr-2" />
            Cancel Subscription
          </Button>
        </div>

        {/* Paid Tiers */}
        {sortedTiers.map((tier) => {
          const isCurrent = tier.slug === subscription.tier_slug;
          const isUpgrade = tier.price_monthly > (currentTier?.price_monthly || 0);
          const priceDiff = Math.abs(tier.price_monthly - (currentTier?.price_monthly || 0));
          
          return (
            <div
              key={tier.id}
              className={`p-4 rounded-xl border-2 transition-all ${
                isCurrent
                  ? 'border-emerald-500 bg-emerald-50/50'
                  : isUpgrade 
                    ? 'border-[var(--primary)]/30 hover:border-[var(--primary)] bg-white'
                    : 'border-slate-200 hover:border-slate-400 bg-white'
              }`}
            >
              <div className="flex items-center justify-between mb-3">
                <div className="flex items-center gap-2">
                  {tier.slug === 'advanced' ? (
                    <Crown className={`w-5 h-5 ${isCurrent ? 'text-emerald-600' : 'text-[var(--primary)]'}`} />
                  ) : (
                    <Zap className={`w-5 h-5 ${isCurrent ? 'text-emerald-600' : 'text-slate-500'}`} />
                  )}
                  <span className="font-semibold">{tier.name}</span>
                </div>
                {isCurrent ? (
                  <span className="text-xs px-2 py-1 rounded-full font-medium bg-emerald-100 text-emerald-700 flex items-center gap-1">
                    <Check className="w-3 h-3" />
                    Current
                  </span>
                ) : (
                  <span className={`text-xs px-2 py-1 rounded-full font-medium ${
                    isUpgrade 
                      ? 'bg-[var(--primary)]/10 text-[var(--primary)]' 
                      : 'bg-amber-100 text-amber-700'
                  }`}>
                    {isUpgrade ? `+CHF ${priceDiff}/mo` : `-CHF ${priceDiff}/mo`}
                  </span>
                )}
              </div>
              
              <p className="text-sm text-[var(--foreground-muted)] mb-3">
                {tier.description || (tier.slug === 'advanced'
                  ? 'Complete course access with unlimited AI tutor assistance.'
                  : 'Full course access with essential features.'
                )}
              </p>
              
              {isCurrent ? (
                <div className="w-full py-2 text-center text-sm font-medium text-emerald-700 bg-emerald-100 rounded-lg">
                  Your Current Plan
                </div>
              ) : (
                <Button
                  onClick={() => handlePlanSelect(tier)}
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
                      Upgrade Now
                    </>
                  ) : (
                    <>
                      <ArrowDown className="w-4 h-4 mr-2" />
                      Schedule Downgrade
                    </>
                  )}
                </Button>
              )}
            </div>
          );
        })}
      </div>
    </>
  );
}
