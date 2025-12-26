import { createClient } from "@/utils/supabase/server";
import Link from "next/link";
import { 
  Check, 
  X,
  Zap,
  Crown,
  ChevronLeft
} from "lucide-react";
import type { SubscriptionTier, PlanTier } from "@/lib/database.types";

export const metadata = {
  title: "Pricing | Tutorio",
  description: "Choose the plan that's right for you",
};

const planIcons: Record<string, React.ComponentType<{ className?: string }>> = {
  free: Zap,
  basic: Crown,
};

const planColors: Record<string, { bg: string; text: string; border: string; button: string }> = {
  free: {
    bg: "bg-slate-50",
    text: "text-slate-600",
    border: "border-slate-200",
    button: "bg-slate-600 hover:bg-slate-700",
  },
  basic: {
    bg: "bg-[var(--primary)]/5",
    text: "text-[var(--primary)]",
    border: "border-[var(--primary)]",
    button: "bg-[var(--primary)] hover:bg-[var(--primary-hover)]",
  },
};

// Features comparison
const features = [
  { name: "Access to Modules 1-2", free: true, basic: true },
  { name: "Access to all 15+ Modules", free: false, basic: true },
  { name: "Text Lessons", free: true, basic: true },
  { name: "Basic Quizzes", free: true, basic: true },
  { name: "Code Editor (5 uses/day)", free: true, basic: false },
  { name: "Unlimited Code Editor", free: false, basic: true },
  { name: "Coding Challenges", free: false, basic: true },
  { name: "Interactive Visualizers", free: false, basic: true },
  { name: "Progress Dashboard", free: "Basic", basic: "Full" },
  { name: "Badges & Achievements", free: "3", basic: "15+" },
  { name: "Ad-Free Experience", free: false, basic: true },
  { name: "Streak Freeze", free: false, basic: true },
];

export default async function PricingPage() {
  const supabase = await createClient();
  
  // Get current user and subscription
  const { data: { user } } = await supabase.auth.getUser();
  
  let currentPlan: PlanTier = 'free';
  if (user) {
    const { data: subscription } = await supabase
      .from("subscriptions")
      .select("tier:subscription_tiers(slug)")
      .eq("user_id", user.id)
      .in("status", ["active", "trialing"])
      .single();
    
    if (subscription?.tier) {
      const tier = subscription.tier as unknown as { slug: string }[] | { slug: string };
      currentPlan = (Array.isArray(tier) ? tier[0]?.slug : tier.slug) as PlanTier;
    }
  }
  
  // Fetch subscription tiers
  const { data: tiers } = await supabase
    .from("subscription_tiers")
    .select("*")
    .eq("is_active", true)
    .order("sort_order");

  return (
    <div className="min-h-screen bg-[var(--background-secondary)]">
      {/* Header */}
      <div className="bg-white border-b border-[var(--border)]">
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <Link 
            href="/dashboard" 
            className="inline-flex items-center gap-1 text-[var(--foreground-muted)] hover:text-[var(--primary)] text-sm mb-4 transition-colors"
          >
            <ChevronLeft className="w-4 h-4" />
            Back to Dashboard
          </Link>
          
          <h1 
            className="text-3xl sm:text-4xl font-bold text-center mb-4"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Choose Your Plan
          </h1>
          
          <p className="text-center text-[var(--foreground-muted)] max-w-2xl mx-auto">
            Start learning for free, then upgrade to unlock all content and features when you're ready.
          </p>
        </div>
      </div>

      {/* Pricing Cards */}
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid md:grid-cols-2 gap-8 max-w-3xl mx-auto">
          {tiers?.map((tier) => (
            <PricingCard 
              key={tier.id} 
              tier={tier as SubscriptionTier} 
              currentPlan={currentPlan}
            />
          ))}
        </div>

        {/* Features Comparison */}
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
                  <th className="text-center p-4 font-medium text-[var(--foreground)]">Free</th>
                  <th className="text-center p-4 font-medium text-[var(--primary)]">Basic</th>
                </tr>
              </thead>
              <tbody>
                {features.map((feature, index) => (
                  <tr 
                    key={feature.name} 
                    className={index !== features.length - 1 ? "border-b border-[var(--border)]" : ""}
                  >
                    <td className="p-4 text-[var(--foreground)]">{feature.name}</td>
                    <td className="p-4 text-center">
                      <FeatureValue value={feature.free} />
                    </td>
                    <td className="p-4 text-center bg-[var(--primary)]/5">
                      <FeatureValue value={feature.basic} />
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

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
              question="What payment methods do you accept?"
              answer="We accept all major credit cards through our secure payment processor Stripe."
            />
            <FAQItem 
              question="Is there a free trial?"
              answer="The Free plan gives you access to the first 2 modules permanently. Try before you upgrade!"
            />
            <FAQItem 
              question="Can I switch plans later?"
              answer="Yes, you can upgrade or downgrade your plan at any time. Changes take effect immediately."
            />
          </div>
        </div>
      </div>
    </div>
  );
}

interface PricingCardProps {
  tier: SubscriptionTier;
  currentPlan: PlanTier;
}

function PricingCard({ tier, currentPlan }: PricingCardProps) {
  const slug = tier.slug as PlanTier;
  const isCurrentPlan = currentPlan === slug;
  const colors = planColors[slug] || planColors.free;
  const Icon = planIcons[slug] || Zap;
  const features = tier.features as Record<string, unknown>;
  
  return (
    <div className={`
      relative bg-white rounded-2xl border-2 p-6 transition-all
      ${isCurrentPlan ? 'border-emerald-500 shadow-lg' : colors.border}
    `}>
      {isCurrentPlan && (
        <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-emerald-500 text-white text-xs font-medium rounded-full">
          Current Plan
        </div>
      )}
      
      {slug === 'basic' && !isCurrentPlan && (
        <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-[var(--primary)] text-white text-xs font-medium rounded-full">
          Recommended
        </div>
      )}
      
      <div className="text-center mb-6">
        <div className={`w-14 h-14 rounded-xl ${colors.bg} flex items-center justify-center mx-auto mb-4`}>
          <Icon className={`w-7 h-7 ${colors.text}`} />
        </div>
        
        <h3 className="text-xl font-bold mb-2">{tier.name}</h3>
        
        <div className="mb-2">
          <span className="text-4xl font-bold">
            {tier.price_monthly === 0 ? 'CHF 0' : `CHF ${tier.price_monthly.toFixed(2)}`}
          </span>
          {tier.price_monthly > 0 && (
            <span className="text-[var(--foreground-muted)]">/month</span>
          )}
        </div>
        
        {tier.price_yearly && tier.price_yearly > 0 && (
          <p className="text-sm text-[var(--foreground-muted)]">
            or CHF {tier.price_yearly.toFixed(2)}/year (save 17%)
          </p>
        )}
      </div>
      
      <p className="text-[var(--foreground-muted)] text-center mb-6">
        {tier.description}
      </p>
      
      {/* Features List */}
      <ul className="space-y-3 mb-6">
        {slug === 'free' && (
          <>
            <FeatureItem included>Access to first 2 modules</FeatureItem>
            <FeatureItem included>Text lessons & quizzes</FeatureItem>
            <FeatureItem included>5 code editor uses/day</FeatureItem>
            <FeatureItem included={false}>Interactive visualizers</FeatureItem>
            <FeatureItem included={false}>Coding challenges</FeatureItem>
          </>
        )}
        {slug === 'basic' && (
          <>
            <FeatureItem included>All 15+ modules</FeatureItem>
            <FeatureItem included>Unlimited code editor</FeatureItem>
            <FeatureItem included>Interactive visualizers</FeatureItem>
            <FeatureItem included>Coding challenges</FeatureItem>
            <FeatureItem included>Full progress dashboard</FeatureItem>
            <FeatureItem included>15+ badges & achievements</FeatureItem>
          </>
        )}
      </ul>
      
      {/* CTA Button */}
      {isCurrentPlan ? (
        <button
          disabled
          className="w-full py-3 px-4 bg-slate-100 text-slate-500 font-semibold rounded-xl cursor-not-allowed"
        >
          Current Plan
        </button>
      ) : slug === 'free' ? (
        <button
          disabled
          className="w-full py-3 px-4 bg-slate-100 text-slate-600 font-semibold rounded-xl cursor-not-allowed"
        >
          Already Included
        </button>
      ) : (
        <Link
          href="/api/stripe/checkout"
          className={`block w-full py-3 px-4 text-white text-center font-semibold rounded-xl transition-colors ${colors.button}`}
        >
          Upgrade to {tier.name}
        </Link>
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

function FeatureValue({ value }: { value: boolean | string }) {
  if (typeof value === 'boolean') {
    return value ? (
      <Check className="w-5 h-5 text-emerald-500 mx-auto" />
    ) : (
      <X className="w-5 h-5 text-slate-300 mx-auto" />
    );
  }
  return <span className="text-[var(--foreground)]">{value}</span>;
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

