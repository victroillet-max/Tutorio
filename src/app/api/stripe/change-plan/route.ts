import { createClient } from "@/utils/supabase/server";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";
import { getSiteUrl } from "@/lib/env";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "api/stripe/change-plan" });

// Initialize Stripe
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: "2025-12-15.clover" }) : null;

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
      const stripeSubscription = await stripe.subscriptions.retrieve(stripeSubscriptionId);

      if (!stripeSubscription.items.data.length) {
        return NextResponse.json(
          { error: "Invalid subscription state" },
          { status: 400 }
        );
      }

      // Determine if this is an upgrade or downgrade
      const isUpgrade = newTierSlug === 'advanced';

      // Update the subscription in Stripe
      // For both upgrade and downgrade, we use proration
      await stripe.subscriptions.update(
        stripeSubscriptionId,
        {
          items: [
            {
              id: stripeSubscription.items.data[0].id,
              price: newPriceId,
            },
          ],
          proration_behavior: "create_prorations",
          metadata: {
            ...stripeSubscription.metadata,
            tier: newTierSlug,
          },
        }
      );

      // Update our database immediately
      const { data: tierData } = await supabase
        .from("subscription_tiers")
        .select("id")
        .eq("slug", newTierSlug)
        .single();

      if (tierData) {
        const { error: updateError } = await supabase
          .from("subscriptions")
          .update({
            tier_id: tierData.id,
            updated_at: new Date().toISOString(),
          })
          .eq("id", subscriptionId);

        if (updateError) {
          log.error("Failed to update local subscription", updateError, { subscriptionId });
          // Don't fail the request - Stripe webhook will catch this
        }
      }

      return NextResponse.json({
        success: true,
        message: isUpgrade 
          ? "Subscription upgraded successfully" 
          : "Subscription changed successfully",
        newTier: newTierSlug,
      });

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

