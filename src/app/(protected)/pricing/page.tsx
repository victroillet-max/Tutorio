import { createClient } from "@/utils/supabase/server";
import { createClient as createServiceClient } from "@supabase/supabase-js";
import Link from "next/link";
import { redirect } from "next/navigation";
import { Suspense } from "react";
import { 
  Check, 
  X,
  ChevronLeft,
  BookOpen,
  ArrowRight,
  AlertCircle
} from "lucide-react";
import type { SubscriptionTier, Course, UserCourseSubscription } from "@/lib/database.types";
import { PricingError, FlipPricingCard } from "@/components/stripe";
import Stripe from "stripe";
import { STRIPE_API_VERSION } from "@/lib/stripe/types";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "pricing/page" });

export const metadata = {
  title: "Pricing | Tutorio",
  description: "Choose the plan that's right for you",
};

/**
 * Sync any Stripe subscriptions that may not be in the database
 * This handles cases where webhooks failed but the user paid
 */
async function syncStripeSubscriptions(
  userId: string,
  courseId: string,
  userEmail: string | undefined
): Promise<boolean> {
  const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
  const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  
  if (!stripeSecretKey || !supabaseServiceKey || !userEmail) {
    return false;
  }

  const stripe = new Stripe(stripeSecretKey, { apiVersion: STRIPE_API_VERSION });
  const serviceClient = createServiceClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    supabaseServiceKey
  );

  try {
    // First check if user has any existing customer ID
    const { data: existingCustomerSub } = await serviceClient
      .from("subscriptions")
      .select("stripe_customer_id")
      .eq("user_id", userId)
      .not("stripe_customer_id", "is", null)
      .limit(1)
      .single();

    // Try to find customer by existing ID or by email
    let customerId = existingCustomerSub?.stripe_customer_id;
    
    if (!customerId) {
      // Search for customer by email
      const customers = await stripe.customers.list({
        email: userEmail,
        limit: 1,
      });
      
      if (customers.data.length === 0) {
        return false; // No customer found
      }
      
      customerId = customers.data[0].id;
    }

    // Get active subscriptions for this customer
    const subscriptions = await stripe.subscriptions.list({
      customer: customerId,
      status: "active",
      limit: 100,
    });

    // Find subscription for this specific course
    const courseSubscription = subscriptions.data.find(
      sub => sub.metadata?.course_id === courseId
    );

    if (!courseSubscription) {
      return false; // No Stripe subscription for this course
    }

    const tier = courseSubscription.metadata?.tier;
    if (!tier) {
      return false;
    }

    // Get tier ID
    const { data: tierData } = await serviceClient
      .from("subscription_tiers")
      .select("id")
      .eq("slug", tier)
      .single();

    if (!tierData) {
      return false;
    }

    // Get period timestamps
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const subAny = courseSubscription as any;
    const periodStart = subAny.current_period_start;
    const periodEnd = subAny.current_period_end;

    const currentPeriodStart = typeof periodStart === 'number'
      ? new Date(periodStart * 1000).toISOString()
      : new Date().toISOString();
    const currentPeriodEnd = typeof periodEnd === 'number'
      ? new Date(periodEnd * 1000).toISOString()
      : new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString();

    // Upsert the subscription
    const { error } = await serviceClient
      .from("subscriptions")
      .upsert({
        user_id: userId,
        course_id: courseId,
        tier_id: tierData.id,
        status: courseSubscription.status === "active" ? "active" : "trialing",
        current_period_start: currentPeriodStart,
        current_period_end: currentPeriodEnd,
        stripe_subscription_id: courseSubscription.id,
        stripe_customer_id: customerId,
        cancel_at_period_end: courseSubscription.cancel_at_period_end,
      }, {
        onConflict: "user_id,course_id",
      });

    if (error) {
      log.error("Failed to sync Stripe subscription", error, { userId, courseId });
      return false;
    }

    log.info("Synced Stripe subscription from pricing page", { 
      userId, 
      courseId, 
      stripeSubscriptionId: courseSubscription.id 
    });
    return true;

  } catch (error) {
    log.error("Error syncing Stripe subscription", error);
    return false;
  }
}


export default async function PricingPage({
  searchParams,
}: {
  searchParams: Promise<{ course?: string }>;
}) {
  const params = await searchParams;
  const supabase = await createClient();
  
  // Get current user
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    redirect("/login?redirect=/pricing");
  }
  
  // Get course if specified (including Stripe price IDs)
  let selectedCourse: (Course & { stripe_basic_price_id: string | null; stripe_advanced_price_id: string | null }) | null = null;
  if (params.course) {
    const { data: course } = await supabase
      .from("courses")
      .select("*, stripe_basic_price_id, stripe_advanced_price_id")
      .eq("slug", params.course)
      .eq("is_published", true)
      .single();
    selectedCourse = course;
  }

  // Get all published courses for the course selector
  const { data: courses } = await supabase
    .from("courses")
    .select("id, title, slug, short_description, thumbnail_url")
    .eq("is_published", true)
    .order("sort_order");
  
  // Fetch subscription tiers
  const { data: tiers } = await supabase
    .from("subscription_tiers")
    .select("*")
    .eq("is_active", true)
    .order("sort_order");

  // Get user's current subscriptions
  let { data: subscriptions } = await supabase
    .rpc("get_user_subscriptions", { p_user_id: user.id });

  // If a course is selected and no subscription found, check Stripe directly
  // This handles cases where webhook failed but user paid
  if (selectedCourse && !subscriptions?.find((s: UserCourseSubscription) => s.course_id === selectedCourse!.id)) {
    const synced = await syncStripeSubscriptions(user.id, selectedCourse.id, user.email);
    if (synced) {
      // Refresh subscriptions after sync
      const { data: refreshedSubs } = await supabase
        .rpc("get_user_subscriptions", { p_user_id: user.id });
      subscriptions = refreshedSubs;
    }
  }

  // Check if Stripe is configured
  const stripeConfigured = !!process.env.STRIPE_SECRET_KEY;
  // Check for course-specific prices first, then fall back to global prices
  const hasCourseSpecificPrices = !!(selectedCourse?.stripe_basic_price_id && selectedCourse?.stripe_advanced_price_id);
  const hasGlobalPriceIds = !!(process.env.STRIPE_BASIC_PRICE_ID && process.env.STRIPE_ADVANCED_PRICE_ID);
  const hasPriceIds = hasCourseSpecificPrices || hasGlobalPriceIds;

  return (
    <div className="min-h-screen bg-[var(--background-secondary)]">
      {/* Error Handler */}
      <Suspense fallback={null}>
        <PricingError />
      </Suspense>

      {/* Stripe Not Configured Banner */}
      {!stripeConfigured && (
        <div className="bg-amber-50 border-b border-amber-200">
          <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-3">
            <div className="flex items-center gap-2 text-amber-800">
              <AlertCircle className="w-4 h-4" />
              <p className="text-sm">
                <strong>Demo Mode:</strong> Payment processing is not configured. Subscriptions are currently unavailable.
              </p>
            </div>
          </div>
        </div>
      )}

      {/* Header */}
      <div className="bg-white border-b border-[var(--border)]">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Link 
            href={selectedCourse ? `/courses/${selectedCourse.slug}` : "/dashboard"} 
            className="inline-flex items-center gap-1 text-[var(--foreground-muted)] hover:text-[var(--primary)] text-sm mb-4 transition-colors"
          >
            <ChevronLeft className="w-4 h-4" />
            {selectedCourse ? `Back to ${selectedCourse.title}` : "Back to Dashboard"}
          </Link>
          
          <h1 
            className="text-3xl sm:text-4xl font-bold text-center mb-4"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            {selectedCourse ? `Subscribe to ${selectedCourse.title}` : "Choose Your Plan"}
          </h1>
          
          <p className="text-center text-[var(--foreground-muted)] max-w-2xl mx-auto">
            {selectedCourse 
              ? "Unlock full access to all course content and AI tutor support. Pricing is per course - subscribe only to the courses you need."
              : "Start learning for free, then upgrade to unlock full access when you're ready. Each course has its own subscription."
            }
          </p>
        </div>
      </div>

      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {/* Course Selector (if no course selected) */}
        {!selectedCourse && courses && courses.length > 0 && (
          <div className="mb-12">
            <h2 
              className="text-xl font-bold mb-6 text-center"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Select a Course to Subscribe
            </h2>
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
              {courses.map((course) => {
                const existingSub = subscriptions?.find((s: UserCourseSubscription) => s.course_id === course.id);
                return (
                  <Link
                    key={course.id}
                    href={`/pricing?course=${course.slug}`}
                    className={`p-4 rounded-xl border transition-all hover:shadow-md ${
                      existingSub 
                        ? "bg-emerald-50 border-emerald-200" 
                        : "bg-white border-[var(--border)] hover:border-[var(--primary)]"
                    }`}
                  >
                    <div className="flex items-start gap-3">
                      <div className="w-10 h-10 rounded-lg bg-[var(--primary)]/10 flex items-center justify-center flex-shrink-0">
                        <BookOpen className="w-5 h-5 text-[var(--primary)]" />
                      </div>
                      <div className="flex-1 min-w-0">
                        <h3 className="font-semibold text-[var(--foreground)] truncate">
                          {course.title}
                        </h3>
                        {existingSub ? (
                          <span className="text-xs text-emerald-600 font-medium">
                            Subscribed ({existingSub.tier_name})
                          </span>
                        ) : (
                          <span className="text-xs text-[var(--foreground-muted)]">
                            {course.short_description?.slice(0, 50)}...
                          </span>
                        )}
                      </div>
                      <ArrowRight className="w-4 h-4 text-[var(--foreground-muted)] flex-shrink-0" />
                    </div>
                  </Link>
                );
              })}
            </div>
          </div>
        )}

        {/* Pricing Cards (shown when course is selected) */}
        {selectedCourse && tiers && (
          <>
            {/* Check if already subscribed */}
            {(() => {
              const currentSub = subscriptions?.find((s: UserCourseSubscription) => s.course_id === selectedCourse.id);
              return currentSub ? (
                <div className="mb-8 p-4 bg-emerald-50 border border-emerald-200 rounded-xl text-center">
                  <p className="text-emerald-800 font-medium">
                    You&apos;re subscribed to this course ({currentSub.tier_name})
                  </p>
                  <p className="text-sm text-emerald-700 mt-1">
                    You can upgrade or downgrade your plan below, or{' '}
                    <Link 
                      href="/subscriptions" 
                      className="text-emerald-600 hover:underline font-medium"
                    >
                      manage your subscription
                    </Link>
                  </p>
                </div>
              ) : null;
            })()}
            
            <div className="grid md:grid-cols-2 gap-8 max-w-3xl mx-auto">
              {tiers.map((tier) => (
                <FlipPricingCard 
                  key={tier.id} 
                  tier={tier as SubscriptionTier} 
                  courseId={selectedCourse.id}
                  courseName={selectedCourse.title}
                  existingSubscription={subscriptions?.find((s: UserCourseSubscription) => s.course_id === selectedCourse.id)}
                  stripeEnabled={stripeConfigured && hasPriceIds}
                />
              ))}
            </div>
          </>
        )}

        {/* Features Comparison */}
        {selectedCourse && (
          <div className="mt-16">
            <h2 
              className="text-2xl font-bold text-center mb-8"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Compare Plans
            </h2>
            
            <div className="bg-white rounded-2xl border border-[var(--border)] overflow-hidden">
              <table className="w-full">
                <thead>
                  <tr className="border-b border-[var(--border)]">
                    <th className="text-left p-4 font-medium text-[var(--foreground)]">Feature</th>
                    <th className="text-center p-4 font-medium text-slate-500">Free Demo</th>
                    <th className="text-center p-4 font-medium text-[var(--foreground)]">Basic</th>
                    <th className="text-center p-4 font-medium text-[var(--primary)]">Advanced</th>
                  </tr>
                </thead>
                <tbody>
                  <FeatureRow name="Activities Included" demo="First 5" basic="All" advanced="All" />
                  <FeatureRow name="AI Tutor Messages" demo="5/day" basic="25/day" advanced="Unlimited" />
                  <FeatureRow name="Coding Challenges" demo={false} basic={true} advanced={true} />
                  <FeatureRow name="Interactive Visualizers" demo={false} basic={true} advanced={true} />
                  <FeatureRow name="Advanced Debugging Help" demo={false} basic={false} advanced={true} />
                  <FeatureRow name="Priority Support" demo={false} basic={false} advanced={true} isLast />
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* FAQ */}
        <div className="mt-16">
          <h2 
            className="text-2xl font-bold text-center mb-8"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Frequently Asked Questions
          </h2>
          
          <div className="max-w-2xl mx-auto space-y-4">
            <FAQItem 
              question="Can I cancel my subscription anytime?"
              answer="Yes, you can cancel your subscription at any time. You'll continue to have access until the end of your billing period."
            />
            <FAQItem 
              question="What's included in the free demo?"
              answer="Every course includes the first 5 activities completely free. This lets you try the course before subscribing."
            />
            <FAQItem 
              question="What's the difference between Basic and Advanced?"
              answer="Both plans give you full course access. The key difference is AI tutor usage: Basic includes 25 messages per day, while Advanced gives you unlimited AI tutor access plus priority support."
            />
            <FAQItem 
              question="Can I upgrade from Basic to Advanced?"
              answer="Yes, you can upgrade at any time. Your billing will be adjusted accordingly."
            />
          </div>
        </div>
      </div>
    </div>
  );
}

function FeatureRow({ 
  name, 
  demo, 
  basic, 
  advanced,
  isLast = false
}: { 
  name: string; 
  demo: boolean | string; 
  basic: boolean | string; 
  advanced: boolean | string;
  isLast?: boolean;
}) {
  return (
    <tr className={isLast ? "" : "border-b border-[var(--border)]"}>
      <td className="p-4 text-[var(--foreground)]">{name}</td>
      <td className="p-4 text-center">
        <FeatureValue value={demo} />
      </td>
      <td className="p-4 text-center">
        <FeatureValue value={basic} />
      </td>
      <td className="p-4 text-center bg-[var(--primary)]/5">
        <FeatureValue value={advanced} />
      </td>
    </tr>
  );
}

function FeatureValue({ value }: { value: boolean | string }) {
  if (typeof value === 'boolean') {
    return value ? (
      <Check className="w-5 h-5 text-emerald-500 mx-auto" />
    ) : (
      <X className="w-5 h-5 text-slate-300 mx-auto" />
    );
  }
  return <span className="text-[var(--foreground)] font-medium">{value}</span>;
}

function FAQItem({ question, answer }: { question: string; answer: string }) {
  return (
    <details className="group bg-white rounded-xl border border-[var(--border)] overflow-hidden">
      <summary className="flex items-center justify-between p-4 cursor-pointer font-medium text-[var(--foreground)] hover:bg-slate-50 transition-colors">
        {question}
        <span className="text-[var(--foreground-muted)] group-open:rotate-180 transition-transform">
          <ChevronLeft className="w-5 h-5 -rotate-90" />
        </span>
      </summary>
      <div className="px-4 pb-4 text-[var(--foreground-muted)]">
        {answer}
      </div>
    </details>
  );
}
