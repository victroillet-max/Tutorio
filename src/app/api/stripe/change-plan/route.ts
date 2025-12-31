import { createClient } from "@/utils/supabase/server";
import { createClient as createSupabaseClient } from "@supabase/supabase-js";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";
import { getSiteUrl } from "@/lib/env";
import { logger } from "@/lib/logging";
import { applyRateLimit, createRateLimitResponse } from "@/lib/rate-limit";
import { STRIPE_API_VERSION, StripeSubscriptionWithPeriods } from "@/lib/stripe/types";

const log = logger.child({ module: "api/stripe/change-plan" });

// Service role client for bypassing RLS on subscription updates
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

// Initialize Stripe
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: STRIPE_API_VERSION }) : null;

// Fallback price IDs from environment
const FALLBACK_PRICE_IDS: Record<string, string | undefined> = {
  basic: process.env.STRIPE_BASIC_PRICE_ID,
  advanced: process.env.STRIPE_ADVANCED_PRICE_ID,
};

/**
 * POST /api/stripe/change-plan
 * Changes a user's subscription plan (upgrade or downgrade)
 */
export async function POST(request: NextRequest) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    return NextResponse.json(
      { error: "Not authenticated" },
      { status: 401 }
    );
  }

  // Apply rate limiting
  const rateLimitResult = await applyRateLimit(request, user.id, "checkout");
  if (rateLimitResult) {
    log.warn("Rate limit exceeded for change-plan", { userId: user.id });
    return createRateLimitResponse(rateLimitResult);
  }

  // Check if Stripe is configured
  if (!stripe) {
    return NextResponse.json(
      { 
        error: "Stripe not configured",
        message: "Stripe integration is not set up. Please add STRIPE_SECRET_KEY to environment variables."
      },
      { status: 501 }
    );
  }

  try {
    const body = await request.json();
    const { subscriptionId, stripeSubscriptionId, newTierSlug } = body;

    if (!subscriptionId || !stripeSubscriptionId || !newTierSlug) {
      return NextResponse.json(
        { error: "Missing required parameters: subscriptionId, stripeSubscriptionId, and newTierSlug" },
        { status: 400 }
      );
    }

    // Validate tier
    if (!['basic', 'advanced'].includes(newTierSlug)) {
      return NextResponse.json(
        { error: "Invalid tier. Must be 'basic' or 'advanced'" },
        { status: 400 }
      );
    }

    // Verify the subscription belongs to this user
    const { data: subscription, error: subError } = await supabase
      .from("subscriptions")
      .select(`
        id,
        user_id,
        course_id,
        stripe_subscription_id,
        tier:subscription_tiers(slug),
        course:courses(id, stripe_basic_price_id, stripe_advanced_price_id)
      `)
      .eq("id", subscriptionId)
      .eq("user_id", user.id)
      .single();

    if (subError || !subscription) {
      return NextResponse.json(
        { error: "Subscription not found or access denied" },
        { status: 404 }
      );
    }

    // Check if already on the same tier
    const currentTier = subscription.tier as unknown as { slug: string }[] | { slug: string };
    const currentTierSlug = Array.isArray(currentTier) ? currentTier[0]?.slug : currentTier?.slug;
    
    if (currentTierSlug === newTierSlug) {
      return NextResponse.json(
        { error: "You are already on this plan" },
        { status: 400 }
      );
    }

    // Get the course for pricing
    const course = subscription.course as unknown as { 
      id: string; 
      stripe_basic_price_id: string | null; 
      stripe_advanced_price_id: string | null;
    }[] | { 
      id: string; 
      stripe_basic_price_id: string | null; 
      stripe_advanced_price_id: string | null;
    };
    
    const courseData = Array.isArray(course) ? course[0] : course;

    // Get the new price ID
    const newPriceId = newTierSlug === 'basic'
      ? (courseData?.stripe_basic_price_id || FALLBACK_PRICE_IDS.basic)
      : (courseData?.stripe_advanced_price_id || FALLBACK_PRICE_IDS.advanced);

    if (!newPriceId) {
      return NextResponse.json(
        { 
          error: "Pricing not configured",
          message: `Pricing for ${newTierSlug} tier is not configured for this course.`
        },
        { status: 501 }
      );
    }

    try {
      // Retrieve the current Stripe subscription
      const stripeSubscription = await stripe.subscriptions.retrieve(stripeSubscriptionId) as unknown as StripeSubscriptionWithPeriods;

      if (!stripeSubscription.items.data.length) {
        return NextResponse.json(
          { error: "Invalid subscription state" },
          { status: 400 }
        );
      }

      // Determine if this is an upgrade or downgrade
      const isUpgrade = newTierSlug === 'advanced';

      // Get period end date for response messaging
      const periodEnd = new Date(stripeSubscription.current_period_end * 1000);

      if (isUpgrade) {
        // UPGRADE: Charge immediately with proration
        // User pays the prorated difference right away and gets immediate access
        const updatedSubscription = await stripe.subscriptions.update(
          stripeSubscriptionId,
          {
            items: [
              {
                id: stripeSubscription.items.data[0].id,
                price: newPriceId,
              },
            ],
            // "always_invoice" creates an invoice immediately for the prorated amount
            proration_behavior: "always_invoice",
            metadata: {
              ...stripeSubscription.metadata,
              tier: newTierSlug,
            },
          }
        );

        log.info("Subscription upgraded with immediate billing", {
          subscriptionId: stripeSubscriptionId,
          latestInvoice: updatedSubscription.latest_invoice,
        });

        // Update our database immediately for upgrades
        if (supabaseUrl && supabaseServiceKey) {
          const serviceClient = createSupabaseClient(supabaseUrl, supabaseServiceKey);
          
          const { data: tierData } = await serviceClient
            .from("subscription_tiers")
            .select("id")
            .eq("slug", newTierSlug)
            .single();

          if (tierData) {
            await serviceClient
              .from("subscriptions")
              .update({
                tier_id: tierData.id,
                updated_at: new Date().toISOString(),
              })
              .eq("id", subscriptionId);

            log.info("Local subscription tier updated for upgrade", { subscriptionId, newTierSlug });
          }
        }

        return NextResponse.json({
          success: true,
          message: "Subscription upgraded successfully",
          newTier: newTierSlug,
          effectiveImmediately: true,
        });
      } else {
        // DOWNGRADE: Schedule change for end of billing period using Subscription Schedule
        // No refund - user keeps current tier access until period ends
        // The new lower tier will take effect at the next billing period
        
        // Check if there's already a schedule for this subscription
        const existingSchedules = await stripe.subscriptionSchedules.list({
          customer: typeof stripeSubscription.customer === 'string' 
            ? stripeSubscription.customer 
            : stripeSubscription.customer.id,
          limit: 10,
        });

        const existingSchedule = existingSchedules.data.find(
          s => s.subscription === stripeSubscriptionId && s.status === 'active'
        );

        if (existingSchedule) {
          // Update existing schedule - replace the future phase
          await stripe.subscriptionSchedules.update(existingSchedule.id, {
            phases: [
              {
                items: [{ price: stripeSubscription.items.data[0].price.id, quantity: 1 }],
                start_date: existingSchedule.phases[0].start_date,
                end_date: stripeSubscription.current_period_end,
              },
              {
                items: [{ price: newPriceId, quantity: 1 }],
                start_date: stripeSubscription.current_period_end,
                proration_behavior: 'none',
                metadata: {
                  ...stripeSubscription.metadata,
                  tier: newTierSlug,
                },
              },
            ],
          });

          log.info("Updated existing schedule for downgrade", {
            scheduleId: existingSchedule.id,
            subscriptionId: stripeSubscriptionId,
            effectiveAt: periodEnd.toISOString(),
          });
        } else {
          // Create a new schedule from the subscription
          const schedule = await stripe.subscriptionSchedules.create({
            from_subscription: stripeSubscriptionId,
          });

          // Update the schedule with the downgrade phase
          await stripe.subscriptionSchedules.update(schedule.id, {
            end_behavior: 'release',
            phases: [
              {
                items: [{ price: stripeSubscription.items.data[0].price.id, quantity: 1 }],
                start_date: schedule.phases[0].start_date,
                end_date: stripeSubscription.current_period_end,
              },
              {
                items: [{ price: newPriceId, quantity: 1 }],
                start_date: stripeSubscription.current_period_end,
                proration_behavior: 'none',
                metadata: {
                  ...stripeSubscription.metadata,
                  tier: newTierSlug,
                },
              },
            ],
          });

          log.info("Created subscription schedule for downgrade", {
            scheduleId: schedule.id,
            subscriptionId: stripeSubscriptionId,
            newTier: newTierSlug,
            effectiveAt: periodEnd.toISOString(),
          });
        }

        // NOTE: We don't update the tier in our database yet.
        // The tier will be updated when the Stripe webhook fires for the subscription update
        // when the scheduled phase change takes effect.
        log.info("Downgrade scheduled - tier will be updated via webhook when phase changes", { 
          subscriptionId, 
          pendingTier: newTierSlug,
          effectiveAt: periodEnd.toISOString(),
        });

        return NextResponse.json({
          success: true,
          message: `Plan downgrade scheduled for ${periodEnd.toLocaleDateString()}. You'll keep your current plan access until then.`,
          newTier: newTierSlug,
          effectiveAt: periodEnd.toISOString(),
          effectiveImmediately: false,
        });
      }

    } catch (stripeError) {
      log.error("Stripe subscription update error", stripeError, { subscriptionId, newTierSlug });
      
      // If direct update fails, redirect to billing portal
      try {
        const { data: subForCustomer } = await supabase
          .from("subscriptions")
          .select("stripe_customer_id")
          .eq("user_id", user.id)
          .not("stripe_customer_id", "is", null)
          .limit(1)
          .single();

        if (subForCustomer?.stripe_customer_id) {
          const siteUrl = getSiteUrl();
          const portalSession = await stripe.billingPortal.sessions.create({
            customer: subForCustomer.stripe_customer_id,
            return_url: `${siteUrl}/subscriptions`,
          });

          return NextResponse.json({
            success: false,
            portalUrl: portalSession.url,
            message: "Please complete the plan change in the Stripe portal"
          });
        }
      } catch (portalError) {
        log.error("Failed to create portal session", portalError);
      }

      return NextResponse.json(
        { 
          error: "Failed to change plan",
          message: stripeError instanceof Error ? stripeError.message : "Please try again or contact support."
        },
        { status: 500 }
      );
    }

  } catch (error) {
    log.error("Plan change error", error);
    return NextResponse.json(
      { 
        error: "Failed to process plan change",
        message: error instanceof Error ? error.message : "Unknown error"
      },
      { status: 500 }
    );
  }
}

