import { createClient } from "@/utils/supabase/server";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";
import { logger } from "@/lib/logging";
import { applyRateLimit, createRateLimitResponse } from "@/lib/rate-limit";
import { STRIPE_API_VERSION } from "@/lib/stripe/types";

const log = logger.child({ module: "api/stripe/plan-change-checkout" });

// Initialize Stripe
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: STRIPE_API_VERSION }) : null;

// Fallback price IDs from environment
const FALLBACK_PRICE_IDS: Record<string, string | undefined> = {
  basic: process.env.STRIPE_BASIC_PRICE_ID,
  advanced: process.env.STRIPE_ADVANCED_PRICE_ID,
};

/**
 * POST /api/stripe/plan-change-checkout
 * Prepares a plan change - determines if we can use embedded checkout or need direct update
 * 
 * For existing Stripe subscriptions, we use direct API updates with proration
 * since embedded checkout is for creating new subscriptions.
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
    log.warn("Rate limit exceeded for plan-change-checkout", { userId: user.id });
    return createRateLimitResponse(rateLimitResult);
  }

  // Check if Stripe is configured
  if (!stripe) {
    return NextResponse.json(
      { 
        error: "Stripe not configured",
        message: "Stripe integration is not set up."
      },
      { status: 501 }
    );
  }

  try {
    const body = await request.json();
    const { subscriptionId, stripeSubscriptionId, newTierSlug, courseId } = body;

    if (!subscriptionId || !newTierSlug) {
      return NextResponse.json(
        { error: "Missing required parameters" },
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
        stripe_customer_id,
        tier:subscription_tiers(slug),
        course:courses(id, title, slug, stripe_basic_price_id, stripe_advanced_price_id)
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

    // Get the course for pricing info
    const course = subscription.course as unknown as { 
      id: string;
      title: string;
      slug: string;
      stripe_basic_price_id: string | null; 
      stripe_advanced_price_id: string | null;
    }[] | { 
      id: string; 
      title: string;
      slug: string;
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

    // For existing Stripe subscriptions, we use direct update
    // Embedded checkout is for NEW subscriptions only
    if (stripeSubscriptionId) {
      log.info("Plan change requested for existing subscription", {
        userId: user.id,
        subscriptionId,
        currentTier: currentTierSlug,
        newTier: newTierSlug
      });

      // Return signal to use direct update
      return NextResponse.json({
        useDirectUpdate: true,
        subscriptionId,
        stripeSubscriptionId,
        newTierSlug,
        newPriceId,
        courseSlug: courseData?.slug
      });
    }

    // If no Stripe subscription ID (shouldn't happen for paid plans), 
    // also use direct update approach
    return NextResponse.json({
      useDirectUpdate: true,
      subscriptionId,
      newTierSlug,
      newPriceId
    });

  } catch (error) {
    log.error("Plan change checkout error", error);
    return NextResponse.json(
      { 
        error: "Failed to process plan change",
        message: error instanceof Error ? error.message : "Unknown error"
      },
      { status: 500 }
    );
  }
}


