import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { redirect } from "next/navigation";
import { Suspense } from "react";
import { 
  Check, 
  X,
  Zap,
  Crown,
  ChevronLeft,
  Sparkles,
  BookOpen,
  ArrowRight,
  AlertCircle
} from "lucide-react";
import type { SubscriptionTier, Course } from "@/lib/database.types";
import { PricingError } from "@/components/stripe";
import { SubscribeButton } from "@/components/stripe";

export const metadata = {
  title: "Pricing | Tutorio",
  description: "Choose the plan that's right for you",
};

// Features comparison for the tiers
const tierFeatures = {
  demo: [
    { name: "First 5 activities", included: true },
    { name: "Basic AI tutor (5 messages/day)", included: true },
    { name: "Progress tracking", included: true },
    { name: "Full course access", included: false },
    { name: "Unlimited AI tutor", included: false },
  ],
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
  const { data: subscriptions } = await supabase
    .rpc("get_user_subscriptions", { p_user_id: user.id });

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
              ? "Unlock full access to all course content and AI tutor support."
              : "Start learning for free, then upgrade to unlock full access when you're ready."
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
                const existingSub = subscriptions?.find((s: { course_id: string; tier_name: string }) => s.course_id === course.id);
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
            {subscriptions?.find((s: { course_id: string; tier_name: string }) => s.course_id === selectedCourse.id) && (
              <div className="mb-8 p-4 bg-emerald-50 border border-emerald-200 rounded-xl text-center">
                <p className="text-emerald-800 font-medium">
                  You're already subscribed to this course ({subscriptions.find((s: { course_id: string; tier_name: string }) => s.course_id === selectedCourse.id)?.tier_name})
                </p>
                <Link 
                  href="/subscriptions" 
                  className="text-sm text-emerald-600 hover:underline mt-1 inline-block"
                >
                  Manage your subscription
                </Link>
              </div>
            )}
            
            <div className="grid md:grid-cols-2 gap-8 max-w-3xl mx-auto">
              {tiers.map((tier) => (
                <PricingCard 
                  key={tier.id} 
                  tier={tier as SubscriptionTier} 
                  course={selectedCourse}
                  existingSubscription={subscriptions?.find((s: { course_id: string; tier_slug: string; tier_name: string }) => s.course_id === selectedCourse.id)}
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

interface PricingCardProps {
  tier: SubscriptionTier;
  course: Course;
  existingSubscription?: {
    tier_slug: string;
    tier_name: string;
  };
  stripeEnabled: boolean;
}

function PricingCard({ tier, course, existingSubscription, stripeEnabled }: PricingCardProps) {
  const isAdvanced = tier.slug === 'advanced';
  const isCurrentPlan = existingSubscription?.tier_slug === tier.slug;
  const canUpgrade = existingSubscription?.tier_slug === 'basic' && tier.slug === 'advanced';
  
  const Icon = isAdvanced ? Crown : Zap;
  
  return (
    <div className={`
      relative bg-white rounded-2xl border-2 p-6 transition-all
      ${isCurrentPlan ? 'border-emerald-500 shadow-lg' : isAdvanced ? 'border-[var(--primary)]' : 'border-[var(--border)]'}
    `}>
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
      
      <div className="text-center mb-6">
        <div className={`w-14 h-14 rounded-xl flex items-center justify-center mx-auto mb-4 ${
          isAdvanced ? 'bg-[var(--primary)]/10' : 'bg-slate-100'
        }`}>
          <Icon className={`w-7 h-7 ${isAdvanced ? 'text-[var(--primary)]' : 'text-slate-600'}`} />
        </div>
        
        <h3 className="text-xl font-bold mb-2">{tier.name}</h3>
        
        <div className="mb-2">
          <span className="text-4xl font-bold">
            CHF {tier.price_monthly.toFixed(0)}
          </span>
          <span className="text-[var(--foreground-muted)]">/month</span>
        </div>
        
        {/* AI Limit Badge */}
        <div className="inline-flex items-center gap-1 px-2 py-1 bg-[var(--progress-bg)] rounded-lg">
          <Sparkles className="w-3 h-3 text-[var(--primary)]" />
          <span className="text-xs font-medium text-[var(--primary)]">
            AI Tutor: {isAdvanced ? 'Unlimited' : '25/day'}
          </span>
        </div>
      </div>
      
      <p className="text-[var(--foreground-muted)] text-center text-sm mb-6">
        {tier.description}
      </p>
      
      {/* Features List */}
      <ul className="space-y-3 mb-6">
        {(isAdvanced ? tierFeatures.advanced : tierFeatures.basic).map((feature) => (
          <FeatureItem key={feature.name} included={feature.included}>
            {feature.name}
          </FeatureItem>
        ))}
      </ul>
      
      {/* CTA Button */}
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
        <SubscribeButton
          courseId={course.id}
          tier={tier.slug as "basic" | "advanced"}
          upgrade
          className="w-full py-3 px-4 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-dark)] transition-colors"
        >
          Upgrade to {tier.name}
        </SubscribeButton>
      ) : (
        <SubscribeButton
          courseId={course.id}
          tier={tier.slug as "basic" | "advanced"}
          className={`w-full py-3 px-4 font-semibold rounded-xl transition-colors ${
            isAdvanced 
              ? 'bg-[var(--primary)] text-white hover:bg-[var(--primary-dark)]'
              : 'bg-slate-100 text-slate-700 hover:bg-slate-200'
          }`}
          variant={isAdvanced ? "default" : "secondary"}
        >
          Subscribe to {tier.name}
        </SubscribeButton>
      )}
    </div>
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
    <li className="flex items-center gap-3">
      {included ? (
        <Check className="w-5 h-5 text-emerald-500 flex-shrink-0" />
      ) : (
        <X className="w-5 h-5 text-slate-300 flex-shrink-0" />
      )}
      <span className={included ? 'text-[var(--foreground)]' : 'text-slate-400'}>
        {children}
      </span>
    </li>
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
