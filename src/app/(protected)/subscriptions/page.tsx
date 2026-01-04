import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { redirect } from "next/navigation";
import { Suspense } from "react";
import { 
  ChevronLeft,
  CreditCard,
  Calendar,
  BookOpen,
  Crown,
  Zap,
  AlertCircle,
  ExternalLink,
  ArrowUpRight,
  Check,
  Sparkles,
  Shield
} from "lucide-react";
import { Button } from "@/components/ui/button";
import type { UserCourseSubscription, SubscriptionTier } from "@/lib/database.types";
import { PlanSwitcher } from "./plan-switcher";
import { RecoverPurchase } from "./recover-purchase";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "subscriptions/page" });

export const metadata = {
  title: "My Subscriptions | Tutorio",
  description: "Manage your course subscriptions",
};

export default async function SubscriptionsPage() {
  const supabase = await createClient();
  
  // Get current user
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    redirect("/login?redirect=/subscriptions");
  }

  // Get user's subscriptions
  const { data: subscriptions, error } = await supabase
    .rpc("get_user_subscriptions", { p_user_id: user.id });

  if (error) {
    log.error("Error fetching subscriptions", error);
  }

  // Get all subscription tiers for plan comparison
  const { data: tiers } = await supabase
    .from("subscription_tiers")
    .select("*")
    .eq("is_active", true)
    .order("sort_order");

  const activeSubscriptions = subscriptions?.filter(
    (s: UserCourseSubscription) => s.status === 'active' || s.status === 'trialing'
  ) || [];
  
  const cancelledSubscriptions = subscriptions?.filter(
    (s: UserCourseSubscription) => s.status === 'cancelled'
  ) || [];

  // Check if Stripe is configured
  const stripeConfigured = !!process.env.STRIPE_SECRET_KEY;

  return (
    <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Header */}
      <div className="mb-8">
        <Link 
          href="/dashboard" 
          className="inline-flex items-center gap-1 text-[var(--foreground-muted)] hover:text-[var(--primary)] text-sm mb-4 transition-colors"
        >
          <ChevronLeft className="w-4 h-4" />
          Back to Dashboard
        </Link>
        
        <h1 
          className="text-3xl font-bold mb-2 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Subscription Management
        </h1>
        <p className="text-[var(--foreground-muted)]">
          View, upgrade, or downgrade your course subscriptions.
        </p>
      </div>

      {/* Stripe Not Configured Banner */}
      {!stripeConfigured && (
        <div className="mb-6 p-4 bg-amber-50 border border-amber-200 rounded-xl">
          <div className="flex items-center gap-2 text-amber-800">
            <AlertCircle className="w-4 h-4" />
            <p className="text-sm">
              <strong>Demo Mode:</strong> Payment processing is not configured. Subscription management is limited.
            </p>
          </div>
        </div>
      )}

      {/* Recover Purchase - for when webhook fails */}
      {stripeConfigured && activeSubscriptions.length === 0 && (
        <RecoverPurchase />
      )}

      {/* No Subscriptions State */}
      {activeSubscriptions.length === 0 && cancelledSubscriptions.length === 0 && (
        <div className="bg-white rounded-2xl border border-[var(--border)] p-8 text-center">
          <div className="w-16 h-16 rounded-full bg-[var(--background-secondary)] flex items-center justify-center mx-auto mb-4">
            <CreditCard className="w-8 h-8 text-[var(--foreground-muted)]" />
          </div>
          <h2 className="text-xl font-semibold mb-2">No Active Subscriptions</h2>
          <p className="text-[var(--foreground-muted)] mb-6 max-w-md mx-auto">
            You don&apos;t have any active subscriptions yet. Browse our courses and subscribe to unlock full access.
          </p>
          <Link
            href="/courses"
            className="inline-flex items-center gap-2 px-6 py-3 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-dark)] transition-colors"
          >
            Browse Courses
            <ArrowUpRight className="w-4 h-4" />
          </Link>
        </div>
      )}

      {/* Active Subscriptions */}
      {activeSubscriptions.length > 0 && (
        <div className="mb-8">
          <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
            <Zap className="w-5 h-5 text-emerald-500" />
            Active Subscriptions
          </h2>
          <div className="space-y-6">
            {activeSubscriptions.map((sub: UserCourseSubscription) => (
              <SubscriptionCard 
                key={sub.subscription_id} 
                subscription={sub}
                tiers={tiers || []}
                stripeEnabled={stripeConfigured}
              />
            ))}
          </div>
        </div>
      )}

      {/* Cancelled Subscriptions (still active until period end) */}
      {cancelledSubscriptions.length > 0 && (
        <div className="mb-8">
          <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
            <AlertCircle className="w-5 h-5 text-amber-500" />
            Expiring Subscriptions
          </h2>
          <div className="space-y-4">
            {cancelledSubscriptions.map((sub: UserCourseSubscription) => (
              <ExpiredSubscriptionCard 
                key={sub.subscription_id} 
                subscription={sub} 
              />
            ))}
          </div>
        </div>
      )}

      {/* Manage Billing Section */}
      {(activeSubscriptions.length > 0 || cancelledSubscriptions.length > 0) && stripeConfigured && (
        <div className="bg-white rounded-2xl border border-[var(--border)] p-6">
          <div className="flex items-start gap-4">
            <div className="w-12 h-12 rounded-xl bg-slate-100 flex items-center justify-center flex-shrink-0">
              <Shield className="w-6 h-6 text-slate-600" />
            </div>
            <div className="flex-1">
              <h2 className="text-lg font-semibold mb-2">Billing & Payment</h2>
              <p className="text-[var(--foreground-muted)] mb-4">
                Manage your payment methods, view invoices, and update billing information through our secure Stripe payment portal.
              </p>
              <Link
                href="/api/stripe/portal"
                className="inline-flex items-center gap-2 px-4 py-2 bg-slate-100 text-slate-700 font-medium rounded-lg hover:bg-slate-200 transition-colors"
              >
                <ExternalLink className="w-4 h-4" />
                Open Billing Portal
              </Link>
            </div>
          </div>
        </div>
      )}

      {/* Plan Comparison */}
      {tiers && tiers.length > 0 && (
        <div className="mt-12">
          <h2 
            className="text-xl font-bold mb-6 text-center"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Plan Comparison
          </h2>
          <PlanComparisonTable tiers={tiers} />
        </div>
      )}

      {/* Add New Subscription CTA */}
      {activeSubscriptions.length > 0 && (
        <div className="mt-8 text-center">
          <Link
            href="/courses"
            className="inline-flex items-center gap-2 text-[var(--primary)] hover:underline font-medium"
          >
            <BookOpen className="w-4 h-4" />
            Browse more courses to subscribe
          </Link>
        </div>
      )}
    </div>
  );
}

interface SubscriptionCardProps {
  subscription: UserCourseSubscription;
  tiers: SubscriptionTier[];
  stripeEnabled: boolean;
}

function SubscriptionCard({ subscription, tiers, stripeEnabled }: SubscriptionCardProps) {
  const isAdvanced = subscription.tier_slug === 'advanced';
  const periodEnd = new Date(subscription.current_period_end);
  
  return (
    <div className="bg-white rounded-2xl border border-[var(--border)] overflow-hidden">
      {/* Card Header */}
      <div className="p-6 border-b border-[var(--border)]">
        <div className="flex items-start justify-between gap-4">
          <div className="flex items-start gap-4">
            {/* Course Icon */}
            <div className={`w-14 h-14 rounded-xl flex items-center justify-center flex-shrink-0 ${
              isAdvanced ? 'bg-[var(--primary)]/10' : 'bg-slate-100'
            }`}>
              {isAdvanced ? (
                <Crown className="w-7 h-7 text-[var(--primary)]" />
              ) : (
                <Zap className="w-7 h-7 text-slate-600" />
              )}
            </div>
            
            {/* Course Info */}
            <div>
              <h3 className="text-lg font-semibold text-[var(--foreground)]">
                {subscription.course_title}
              </h3>
              <div className="flex items-center gap-3 mt-2">
                <span className={`px-3 py-1 text-sm font-medium rounded-full ${
                  isAdvanced 
                    ? 'bg-[var(--primary)]/10 text-[var(--primary)]'
                    : 'bg-slate-100 text-slate-600'
                }`}>
                  {subscription.tier_name} Plan
                </span>
                <span className="text-[var(--foreground-muted)]">
                  CHF {subscription.price_monthly.toFixed(0)}/month
                </span>
              </div>
              
              {/* Status */}
              <div className="flex items-center gap-2 mt-3 text-sm">
                <Calendar className="w-4 h-4 text-[var(--foreground-muted)]" />
                {subscription.cancel_at_period_end ? (
                  <span className="text-amber-600">
                    Cancels on {periodEnd.toLocaleDateString()}
                  </span>
                ) : (
                  <span className="text-[var(--foreground-muted)]">
                    Renews on {periodEnd.toLocaleDateString()}
                  </span>
                )}
              </div>
            </div>
          </div>
          
          {/* Quick Actions */}
          <Link
            href={`/courses/${subscription.course_slug}`}
            className="px-4 py-2 text-sm font-medium text-[var(--primary)] hover:bg-[var(--primary)]/5 rounded-lg transition-colors"
          >
            Go to Course
          </Link>
        </div>
      </div>
      
      {/* Plan Switching Section */}
      {!subscription.cancel_at_period_end && stripeEnabled && (
        <div className="p-6 bg-[var(--background-secondary)]">
          <h4 className="font-medium mb-4 flex items-center gap-2">
            <Sparkles className="w-4 h-4 text-[var(--primary)]" />
            Change Your Plan
          </h4>
          <Suspense fallback={<div className="h-20 animate-pulse bg-slate-100 rounded-lg" />}>
            <PlanSwitcher 
              subscription={subscription}
              tiers={tiers}
            />
          </Suspense>
        </div>
      )}
      
      {/* Cancel Notice */}
      {subscription.cancel_at_period_end && (
        <div className="p-4 bg-amber-50 border-t border-amber-100">
          <p className="text-sm text-amber-700">
            Your subscription is set to cancel. You&apos;ll retain access until {periodEnd.toLocaleDateString()}.
          </p>
          <Link
            href={`/pricing?course=${subscription.course_slug}`}
            className="text-sm text-amber-800 font-medium hover:underline mt-1 inline-block"
          >
            Resubscribe
          </Link>
        </div>
      )}
    </div>
  );
}

function ExpiredSubscriptionCard({ subscription }: { subscription: UserCourseSubscription }) {
  const periodEnd = new Date(subscription.current_period_end);
  // Server component - Date.now() runs once per request so it's safe
  const daysRemaining = Math.ceil((periodEnd.getTime() - Date.now()) / (1000 * 60 * 60 * 24));
  
  return (
    <div className="bg-white rounded-xl border border-amber-200 p-5 bg-amber-50/50">
      <div className="flex items-start justify-between gap-4">
        <div className="flex items-start gap-4">
          <div className="w-12 h-12 rounded-xl bg-amber-100 flex items-center justify-center flex-shrink-0">
            <AlertCircle className="w-6 h-6 text-amber-600" />
          </div>
          <div>
            <h3 className="font-semibold text-[var(--foreground)]">
              {subscription.course_title}
            </h3>
            <p className="text-sm text-amber-600 mt-1">
              Access until {periodEnd.toLocaleDateString()} ({daysRemaining} days remaining)
            </p>
          </div>
        </div>
        
        <Link
          href={`/pricing?course=${subscription.course_slug}`}
          className="px-4 py-2 text-sm font-medium bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors"
        >
          Resubscribe
        </Link>
      </div>
    </div>
  );
}

function PlanComparisonTable({ tiers }: { tiers: SubscriptionTier[] }) {
  const features = [
    { name: "Full course access", basic: true, advanced: true },
    { name: "All activities & challenges", basic: true, advanced: true },
    { name: "AI Tutor messages", basic: "25/day", advanced: "Unlimited" },
    { name: "Progress tracking", basic: true, advanced: true },
    { name: "Priority support", basic: false, advanced: true },
    { name: "Advanced debugging help", basic: false, advanced: true },
  ];

  const basicTier = tiers.find(t => t.slug === 'basic');
  const advancedTier = tiers.find(t => t.slug === 'advanced');

  return (
    <div className="bg-white rounded-2xl border border-[var(--border)] overflow-hidden">
      <table className="w-full">
        <thead>
          <tr className="border-b border-[var(--border)]">
            <th className="text-left p-4 font-medium text-[var(--foreground)]">Feature</th>
            <th className="text-center p-4">
              <div className="flex flex-col items-center">
                <Zap className="w-5 h-5 text-slate-500 mb-1" />
                <span className="font-semibold text-[var(--foreground)]">Basic</span>
                {basicTier && (
                  <span className="text-sm text-[var(--foreground-muted)]">
                    CHF {basicTier.price_monthly}/mo
                  </span>
                )}
              </div>
            </th>
            <th className="text-center p-4 bg-[var(--primary)]/5">
              <div className="flex flex-col items-center">
                <Crown className="w-5 h-5 text-[var(--primary)] mb-1" />
                <span className="font-semibold text-[var(--primary)]">Advanced</span>
                {advancedTier && (
                  <span className="text-sm text-[var(--primary)]">
                    CHF {advancedTier.price_monthly}/mo
                  </span>
                )}
              </div>
            </th>
          </tr>
        </thead>
        <tbody>
          {features.map((feature, index) => (
            <tr 
              key={feature.name}
              className={index < features.length - 1 ? "border-b border-[var(--border)]" : ""}
            >
              <td className="p-4 text-[var(--foreground)]">{feature.name}</td>
              <td className="p-4 text-center">
                <FeatureValue value={feature.basic} />
              </td>
              <td className="p-4 text-center bg-[var(--primary)]/5">
                <FeatureValue value={feature.advanced} />
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

function FeatureValue({ value }: { value: boolean | string }) {
  if (typeof value === 'boolean') {
    return value ? (
      <Check className="w-5 h-5 text-emerald-500 mx-auto" />
    ) : (
      <span className="text-slate-300">-</span>
    );
  }
  return <span className="text-[var(--foreground)] font-medium">{value}</span>;
}
