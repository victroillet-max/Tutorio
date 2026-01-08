"use client";

import Link from "next/link";
import { Crown, Zap, Sparkles, Lock, ArrowRight, Check } from "lucide-react";
import { cn } from "@/lib/utils";

export type UpgradeVariant = "inline" | "card" | "banner" | "modal" | "compact";
export type UserTier = "free" | "basic" | "advanced";

interface UpgradePromptCardProps {
  courseSlug: string;
  courseName?: string;
  variant?: UpgradeVariant;
  currentTier?: UserTier;
  showPricing?: boolean;
  context?: string;
  className?: string;
  // For demo completion prompts
  demoActivitiesRemaining?: number;
  totalLockedActivities?: number;
  onDismiss?: () => void;
}

const BASIC_PRICE = 8;
const ADVANCED_PRICE = 15;

const tierFeatures = {
  basic: [
    "Full course access",
    "All activities & challenges",
    "AI tutor (25 messages/day)",
    "Progress tracking",
  ],
  advanced: [
    "Everything in Basic",
    "Unlimited AI tutor",
    "Priority support",
    "Advanced debugging help",
  ],
};

/**
 * Reusable upgrade prompt component with multiple display variants
 * Used across the app for consistent upgrade CTAs
 */
export function UpgradePromptCard({
  courseSlug,
  courseName,
  variant = "card",
  currentTier = "free",
  showPricing = true,
  context,
  className,
  demoActivitiesRemaining,
  totalLockedActivities,
  onDismiss,
}: UpgradePromptCardProps) {
  const pricingUrl = `/pricing?course=${courseSlug}`;
  
  // Determine what to show based on current tier
  const isBasicUser = currentTier === "basic";
  const targetTier = isBasicUser ? "advanced" : "basic";
  const targetPrice = isBasicUser ? ADVANCED_PRICE : BASIC_PRICE;
  const Icon = isBasicUser ? Crown : Zap;

  if (variant === "inline") {
    return (
      <Link
        href={pricingUrl}
        className={cn(
          "inline-flex items-center gap-1.5 px-3 py-1.5",
          "text-sm font-semibold rounded-lg transition-all",
          "border border-[var(--accent)] text-[var(--accent)]",
          "hover:bg-[var(--accent)] hover:text-white",
          className
        )}
      >
        <Icon className="w-3.5 h-3.5" />
        <span>{isBasicUser ? "Upgrade" : "Subscribe"}</span>
      </Link>
    );
  }

  if (variant === "compact") {
    return (
      <Link
        href={pricingUrl}
        className={cn(
          "flex items-center gap-2 px-3 py-2 rounded-lg",
          "bg-gradient-to-r from-[var(--accent)]/10 to-[var(--accent)]/5",
          "border border-[var(--accent)]/20",
          "hover:border-[var(--accent)]/40 transition-all group",
          className
        )}
      >
        <div className="w-8 h-8 rounded-lg bg-[var(--accent)]/10 flex items-center justify-center">
          <Icon className="w-4 h-4 text-[var(--accent)]" />
        </div>
        <div className="flex-1 min-w-0">
          <p className="text-sm font-semibold text-[var(--foreground)]">
            {isBasicUser ? "Upgrade to Advanced" : "Unlock Full Access"}
          </p>
          {showPricing && (
            <p className="text-xs text-[var(--foreground-muted)]">
              CHF {targetPrice}/month
            </p>
          )}
        </div>
        <ArrowRight className="w-4 h-4 text-[var(--accent)] group-hover:translate-x-0.5 transition-transform" />
      </Link>
    );
  }

  if (variant === "banner") {
    return (
      <div
        className={cn(
          "flex items-center justify-between gap-4 px-4 py-3 rounded-xl",
          "bg-gradient-to-r from-[var(--accent)]/10 via-[var(--accent)]/5 to-transparent",
          "border border-[var(--accent)]/20",
          className
        )}
      >
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-[var(--accent)]/10 flex items-center justify-center">
            <Icon className="w-5 h-5 text-[var(--accent)]" />
          </div>
          <div>
            <p className="font-semibold text-[var(--foreground)]">
              {context || (isBasicUser ? "Want unlimited AI tutor access?" : "Unlock all course content")}
            </p>
            {showPricing && (
              <p className="text-sm text-[var(--foreground-muted)]">
                {isBasicUser ? "Advanced" : "Basic"} plan - CHF {targetPrice}/month
              </p>
            )}
          </div>
        </div>
        <Link
          href={pricingUrl}
          className="flex items-center gap-2 px-4 py-2 bg-[var(--accent)] text-white text-sm font-semibold rounded-lg hover:bg-[var(--accent-dark)] transition-colors"
        >
          {isBasicUser ? "Upgrade" : "Subscribe"}
          <ArrowRight className="w-4 h-4" />
        </Link>
      </div>
    );
  }

  if (variant === "modal") {
    return (
      <div className={cn("fixed inset-0 z-50 flex items-center justify-center p-4", className)}>
        {/* Overlay */}
        <div 
          className="absolute inset-0 bg-black/50 backdrop-blur-sm"
          onClick={onDismiss}
        />
        
        {/* Modal Content */}
        <div className="relative z-10 w-full max-w-md bg-white rounded-2xl shadow-2xl overflow-hidden animate-in zoom-in-95 duration-200">
          {/* Header */}
          <div className="bg-gradient-to-br from-[var(--accent)] to-[var(--accent-dark)] px-6 py-8 text-white text-center">
            <div className="w-16 h-16 mx-auto mb-4 rounded-2xl bg-white/20 flex items-center justify-center">
              <Sparkles className="w-8 h-8" />
            </div>
            <h2 className="text-2xl font-bold mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
              {demoActivitiesRemaining === 0 
                ? "You've Completed the Free Demo!" 
                : "Unlock Full Access"}
            </h2>
            <p className="text-white/80">
              {context || (totalLockedActivities 
                ? `Subscribe to unlock ${totalLockedActivities}+ more activities`
                : courseName 
                  ? `Get full access to ${courseName}`
                  : "Continue your learning journey")}
            </p>
          </div>
          
          {/* Features */}
          <div className="px-6 py-6">
            <p className="text-sm font-medium text-[var(--foreground-muted)] mb-3">
              What you'll get:
            </p>
            <ul className="space-y-2 mb-6">
              {tierFeatures.basic.map((feature) => (
                <li key={feature} className="flex items-center gap-2 text-sm text-[var(--foreground)]">
                  <Check className="w-4 h-4 text-emerald-500 flex-shrink-0" />
                  {feature}
                </li>
              ))}
            </ul>
            
            {showPricing && (
              <div className="text-center mb-6">
                <span className="text-3xl font-bold text-[var(--foreground)]">
                  CHF {BASIC_PRICE}
                </span>
                <span className="text-[var(--foreground-muted)]">/month</span>
              </div>
            )}
            
            {/* CTAs */}
            <div className="space-y-3">
              <Link
                href={pricingUrl}
                className="block w-full py-3 text-center bg-[var(--accent)] text-white font-semibold rounded-xl hover:bg-[var(--accent-dark)] transition-colors"
              >
                Subscribe Now
              </Link>
              {onDismiss && (
                <button
                  onClick={onDismiss}
                  className="block w-full py-3 text-center text-[var(--foreground-muted)] font-medium hover:text-[var(--foreground)] transition-colors"
                >
                  Maybe Later
                </button>
              )}
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Default: card variant
  return (
    <div
      className={cn(
        "bg-white rounded-2xl border border-[var(--border)] overflow-hidden shadow-sm",
        className
      )}
    >
      {/* Card Header */}
      <div className="bg-gradient-to-br from-[var(--accent)]/10 to-[var(--accent)]/5 px-6 py-5 border-b border-[var(--border)]">
        <div className="flex items-center gap-3">
          <div className="w-12 h-12 rounded-xl bg-[var(--accent)]/10 flex items-center justify-center">
            <Icon className="w-6 h-6 text-[var(--accent)]" />
          </div>
          <div>
            <h3 className="font-bold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
              {isBasicUser ? "Upgrade to Advanced" : "Unlock Full Access"}
            </h3>
            <p className="text-sm text-[var(--foreground-muted)]">
              {context || (courseName ? `For ${courseName}` : "Get more from your learning")}
            </p>
          </div>
        </div>
      </div>
      
      {/* Features List */}
      <div className="px-6 py-5">
        <ul className="space-y-2.5 mb-5">
          {(isBasicUser ? tierFeatures.advanced : tierFeatures.basic).map((feature) => (
            <li key={feature} className="flex items-center gap-2.5 text-sm">
              <Check className="w-4 h-4 text-emerald-500 flex-shrink-0" />
              <span className="text-[var(--foreground)]">{feature}</span>
            </li>
          ))}
        </ul>
        
        {showPricing && (
          <div className="flex items-baseline gap-1 mb-5">
            <span className="text-2xl font-bold text-[var(--foreground)]">
              CHF {targetPrice}
            </span>
            <span className="text-[var(--foreground-muted)]">/month</span>
          </div>
        )}
        
        <Link
          href={pricingUrl}
          className="flex items-center justify-center gap-2 w-full py-3 bg-[var(--accent)] text-white font-semibold rounded-xl hover:bg-[var(--accent-dark)] transition-colors"
        >
          {isBasicUser ? "Upgrade Now" : "Subscribe"}
          <ArrowRight className="w-4 h-4" />
        </Link>
      </div>
    </div>
  );
}

/**
 * Small upgrade badge for skill/activity cards
 */
export function UpgradeBadge({ 
  courseSlug,
  className 
}: { 
  courseSlug: string;
  className?: string;
}) {
  return (
    <Link
      href={`/pricing?course=${courseSlug}`}
      className={cn(
        "inline-flex items-center gap-1 px-2 py-1",
        "text-xs font-semibold rounded-full",
        "bg-[var(--accent)]/10 text-[var(--accent)]",
        "hover:bg-[var(--accent)] hover:text-white transition-all",
        className
      )}
    >
      <Lock className="w-3 h-3" />
      <span>Unlock</span>
    </Link>
  );
}

/**
 * Subscription tier badge for displaying current status
 */
export function SubscriptionBadge({
  tier,
  className,
}: {
  tier: UserTier;
  className?: string;
}) {
  const config = {
    free: {
      label: "Free Demo",
      bg: "bg-slate-100",
      text: "text-slate-600",
      icon: null,
    },
    basic: {
      label: "Basic",
      bg: "bg-blue-100",
      text: "text-blue-700",
      icon: Zap,
    },
    advanced: {
      label: "Advanced",
      bg: "bg-[var(--accent)]/10",
      text: "text-[var(--accent)]",
      icon: Crown,
    },
  };

  const { label, bg, text, icon: BadgeIcon } = config[tier];

  return (
    <span
      className={cn(
        "inline-flex items-center gap-1 px-2 py-1 text-xs font-semibold rounded-full",
        bg,
        text,
        className
      )}
    >
      {BadgeIcon && <BadgeIcon className="w-3 h-3" />}
      {label}
    </span>
  );
}

