import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { redirect } from "next/navigation";
import { 
  ChevronLeft,
  CreditCard,
  Calendar,
  BookOpen,
  Crown,
  Zap,
  AlertCircle,
  ExternalLink,
  ArrowUpRight
} from "lucide-react";
import { Button } from "@/components/ui/button";
import type { UserCourseSubscription } from "@/lib/database.types";

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
    console.error("Error fetching subscriptions:", error);
  }

  const activeSubscriptions = subscriptions?.filter(
    (s: UserCourseSubscription) => s.status === 'active' || s.status === 'trialing'
  ) || [];
  
  const cancelledSubscriptions = subscriptions?.filter(
    (s: UserCourseSubscription) => s.status === 'cancelled'
  ) || [];

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Header */}
      <div className="mb-8">
        <Link 
          href="/settings" 
          className="inline-flex items-center gap-1 text-[var(--foreground-muted)] hover:text-[var(--primary)] text-sm mb-4 transition-colors"
        >
          <ChevronLeft className="w-4 h-4" />
          Back to Settings
        </Link>
        
        <h1 
          className="text-3xl font-bold mb-2 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          My Subscriptions
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Manage your course subscriptions and billing.
        </p>
      </div>

      {/* No Subscriptions State */}
      {activeSubscriptions.length === 0 && cancelledSubscriptions.length === 0 && (
        <div className="bg-white rounded-2xl border border-[var(--border)] p-8 text-center">
          <div className="w-16 h-16 rounded-full bg-[var(--background-secondary)] flex items-center justify-center mx-auto mb-4">
            <CreditCard className="w-8 h-8 text-[var(--foreground-muted)]" />
          </div>
          <h2 className="text-xl font-semibold mb-2">No Active Subscriptions</h2>
          <p className="text-[var(--foreground-muted)] mb-6 max-w-md mx-auto">
            You don't have any active subscriptions yet. Browse our courses and subscribe to unlock full access.
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
          <div className="space-y-4">
            {activeSubscriptions.map((sub: UserCourseSubscription) => (
              <SubscriptionCard key={sub.subscription_id} subscription={sub} />
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
              <SubscriptionCard key={sub.subscription_id} subscription={sub} isCancelled />
            ))}
          </div>
        </div>
      )}

      {/* Manage Billing Section */}
      {(activeSubscriptions.length > 0 || cancelledSubscriptions.length > 0) && (
        <div className="bg-white rounded-2xl border border-[var(--border)] p-6">
          <h2 className="text-lg font-semibold mb-4">Billing & Payment</h2>
          <p className="text-[var(--foreground-muted)] mb-4">
            Manage your payment methods, view invoices, and update billing information through our secure payment portal.
          </p>
          <Link
            href="/api/stripe/portal"
            className="inline-flex items-center gap-2 px-4 py-2 bg-slate-100 text-slate-700 font-medium rounded-lg hover:bg-slate-200 transition-colors"
          >
            <ExternalLink className="w-4 h-4" />
            Open Billing Portal
          </Link>
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
  isCancelled?: boolean;
}

function SubscriptionCard({ subscription, isCancelled = false }: SubscriptionCardProps) {
  const isAdvanced = subscription.tier_slug === 'advanced';
  const periodEnd = new Date(subscription.current_period_end);
  const daysRemaining = Math.ceil((periodEnd.getTime() - Date.now()) / (1000 * 60 * 60 * 24));
  
  return (
    <div className={`bg-white rounded-xl border p-5 ${
      isCancelled ? 'border-amber-200 bg-amber-50/50' : 'border-[var(--border)]'
    }`}>
      <div className="flex items-start justify-between gap-4">
        <div className="flex items-start gap-4">
          {/* Course Icon */}
          <div className={`w-12 h-12 rounded-xl flex items-center justify-center flex-shrink-0 ${
            isAdvanced ? 'bg-[var(--primary)]/10' : 'bg-slate-100'
          }`}>
            {isAdvanced ? (
              <Crown className="w-6 h-6 text-[var(--primary)]" />
            ) : (
              <Zap className="w-6 h-6 text-slate-600" />
            )}
          </div>
          
          {/* Course Info */}
          <div>
            <h3 className="font-semibold text-[var(--foreground)]">
              {subscription.course_title}
            </h3>
            <div className="flex items-center gap-2 mt-1">
              <span className={`px-2 py-0.5 text-xs font-medium rounded-full ${
                isAdvanced 
                  ? 'bg-[var(--primary)]/10 text-[var(--primary)]'
                  : 'bg-slate-100 text-slate-600'
              }`}>
                {subscription.tier_name}
              </span>
              <span className="text-sm text-[var(--foreground-muted)]">
                CHF {subscription.price_monthly.toFixed(0)}/month
              </span>
            </div>
            
            {/* Status */}
            <div className="flex items-center gap-2 mt-3 text-sm">
              <Calendar className="w-4 h-4 text-[var(--foreground-muted)]" />
              {isCancelled ? (
                <span className="text-amber-600">
                  Access until {periodEnd.toLocaleDateString()} ({daysRemaining} days remaining)
                </span>
              ) : subscription.cancel_at_period_end ? (
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
        
        {/* Actions */}
        <div className="flex flex-col gap-2">
          <Link
            href={`/courses/${subscription.course_slug}`}
            className="px-4 py-2 text-sm font-medium text-[var(--primary)] hover:bg-[var(--primary)]/5 rounded-lg transition-colors text-center"
          >
            Go to Course
          </Link>
          
          {!isCancelled && !subscription.cancel_at_period_end && (
            <>
              {subscription.tier_slug === 'basic' && (
                <Link
                  href={`/pricing?course=${subscription.course_slug}`}
                  className="px-4 py-2 text-sm font-medium bg-[var(--primary)] text-white rounded-lg hover:bg-[var(--primary-dark)] transition-colors text-center"
                >
                  Upgrade
                </Link>
              )}
              <CancelSubscriptionButton subscriptionId={subscription.subscription_id} />
            </>
          )}
          
          {isCancelled && (
            <Link
              href={`/pricing?course=${subscription.course_slug}`}
              className="px-4 py-2 text-sm font-medium bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors text-center"
            >
              Resubscribe
            </Link>
          )}
        </div>
      </div>
    </div>
  );
}

function CancelSubscriptionButton({ subscriptionId }: { subscriptionId: string }) {
  // This would normally be a client component with a confirmation dialog
  // For now, we'll link to the Stripe portal for cancellation
  return (
    <Link
      href="/api/stripe/portal"
      className="px-4 py-2 text-sm font-medium text-red-600 hover:bg-red-50 rounded-lg transition-colors text-center"
    >
      Cancel
    </Link>
  );
}

