import { createClient } from "@/utils/supabase/server";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";
import { getSiteUrl } from "@/lib/env";
import { checkoutSchema, createValidationErrorResponse } from "@/lib/validation/schemas";
import { logger, startTimer } from "@/lib/logging";
import { applyRateLimit, createRateLimitResponse } from "@/lib/rate-limit";
import { STRIPE_API_VERSION } from "@/lib/stripe/types";

// Initialize Stripe
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: STRIPE_API_VERSION }) : null;

// Fallback price IDs from environment (used if course doesn't have specific prices)
const FALLBACK_PRICE_IDS: Record<string, string | undefined> = {
  basic: process.env.STRIPE_BASIC_PRICE_ID,
  advanced: process.env.STRIPE_ADVANCED_PRICE_ID,
};

const log = logger.child({ handler: "stripe/embedded-checkout" });

/**
 * Get price ID for a course and tier
 * First checks course-specific prices, then falls back to global prices
 */
function getPriceId(
  course: { stripe_basic_price_id: string | null; stripe_advanced_price_id: string | null },
  tier: 'basic' | 'advanced'
): string | null {
  if (tier === 'basic') {
    return course.stripe_basic_price_id || FALLBACK_PRICE_IDS.basic || null;
  }
  return course.stripe_advanced_price_id || FALLBACK_PRICE_IDS.advanced || null;
}

/**
 * POST /api/stripe/embedded-checkout
 * Creates a Stripe Checkout session for embedded checkout (returns client_secret)
 */
export async function POST(request: NextRequest) {
  const timer = startTimer();
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    log.warn("Unauthorized checkout attempt");
    return NextResponse.json(
      { error: "Not authenticated" },
      { status: 401 }
    );
  }

  // Apply rate limiting
  const rateLimitResult = await applyRateLimit(request, user.id, "checkout");
  if (rateLimitResult) {
    log.warn("Rate limit exceeded for checkout", { userId: user.id });
    return createRateLimitResponse(rateLimitResult);
  }

  // Check if Stripe is configured
  if (!stripe) {
    log.error("Stripe not configured");
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
    
    // Validate input
    const validation = checkoutSchema.safeParse(body);
    if (!validation.success) {
      log.warn("Checkout validation failed", { errors: validation.error.flatten() });
      return createValidationErrorResponse(validation.error.issues);
    }

    const { courseId, tier } = validation.data;

    // Get course details including Stripe price IDs
    const { data: course, error: courseError } = await supabase
      .from("courses")
      .select("id, title, slug, stripe_basic_price_id, stripe_advanced_price_id")
      .eq("id", courseId)
      .single();

    if (courseError || !course) {
      log.warn("Course not found for checkout", { courseId });
      return NextResponse.json(
        { error: "Course not found" },
        { status: 404 }
      );
    }

    // Get the price ID for this course and tier
    const priceId = getPriceId(course, tier);
    if (!priceId) {
      log.warn("Pricing not configured", { courseId, tier });
      return NextResponse.json(
        { 
          error: "Pricing not configured",
          message: `Pricing for ${tier} tier is not configured for this course.`
        },
        { status: 501 }
      );
    }

    // Check for existing subscription in our database
    const { data: existingSubscription } = await supabase
      .from("subscriptions")
      .select("id, tier:subscription_tiers(slug), stripe_subscription_id")
      .eq("user_id", user.id)
      .eq("course_id", courseId)
      .in("status", ["active", "trialing"])
      .single();

    // If already subscribed to same or higher tier, return error
    if (existingSubscription) {
      const currentTier = existingSubscription.tier as unknown as { slug: string }[] | { slug: string };
      const currentTierSlug = Array.isArray(currentTier) ? currentTier[0]?.slug : currentTier?.slug;
      
      if (currentTierSlug === tier || (currentTierSlug === 'advanced' && tier === 'basic')) {
        log.info("Already subscribed (database)", { userId: user.id, courseId, currentTier: currentTierSlug });
        return NextResponse.json(
          { error: "You already have an active subscription for this course" },
          { status: 400 }
        );
      }
    }

    // Also check Stripe directly for any active subscriptions for this user/course
    // This handles cases where webhook failed but subscription exists in Stripe
    const { data: anySubscription } = await supabase
      .from("subscriptions")
      .select("stripe_customer_id")
      .eq("user_id", user.id)
      .not("stripe_customer_id", "is", null)
      .limit(1)
      .single();

    if (anySubscription?.stripe_customer_id) {
      try {
        // Check if this customer has any active subscriptions in Stripe
        const stripeSubscriptions = await stripe.subscriptions.list({
          customer: anySubscription.stripe_customer_id,
          status: "active",
          limit: 100,
        });

        // Look for a subscription matching this course
        const existingStripeSubscription = stripeSubscriptions.data.find(
          sub => sub.metadata?.course_id === courseId
        );

        if (existingStripeSubscription) {
          log.warn("Found existing Stripe subscription not in database", {
            userId: user.id,
            courseId,
            stripeSubscriptionId: existingStripeSubscription.id
          });
          return NextResponse.json(
            { 
              error: "You already have an active subscription for this course",
              message: "Your subscription may not have synced properly. Please check your subscriptions page and use 'Recover Purchase' if needed."
            },
            { status: 400 }
          );
        }
      } catch (stripeError) {
        log.error("Error checking Stripe subscriptions", stripeError);
        // Continue with checkout if we can't check Stripe
      }
    }

    // Get or create Stripe customer
    const { data: profile } = await supabase
      .from("profiles")
      .select("email, full_name")
      .eq("id", user.id)
      .single();

    // Reuse the customer ID from the earlier query (anySubscription already fetched above)
    let customerId = anySubscription?.stripe_customer_id;

    if (!customerId) {
      // Create new Stripe customer
      const customer = await stripe.customers.create({
        email: profile?.email || user.email,
        name: profile?.full_name || undefined,
        metadata: {
          supabase_user_id: user.id,
        },
      });
      customerId = customer.id;
      log.info("Created Stripe customer", { userId: user.id, customerId });
    }

    const siteUrl = getSiteUrl();

    // Create Checkout session for embedded checkout (ui_mode: 'embedded')
    // Note: We don't specify payment_method_types to allow Stripe to dynamically
    // choose the best payment methods based on customer location and preferences
    const session = await stripe.checkout.sessions.create({
      customer: customerId,
      mode: "subscription",
      ui_mode: "embedded",
      line_items: [
        {
          price: priceId,
          quantity: 1,
        },
      ],
      metadata: {
        supabase_user_id: user.id,
        course_id: courseId,
        course_slug: course.slug,
        tier: tier,
      },
      subscription_data: {
        metadata: {
          supabase_user_id: user.id,
          course_id: courseId,
          course_slug: course.slug,
          tier: tier,
        },
      },
      return_url: `${siteUrl}/courses/${course.slug}?checkout=success&session_id={CHECKOUT_SESSION_ID}`,
      allow_promotion_codes: true,
    });

    log.info("Embedded checkout session created", { 
      userId: user.id, 
      courseId, 
      tier, 
      sessionId: session.id 
    });
    timer.log("Embedded checkout session created");

    return NextResponse.json({
      clientSecret: session.client_secret,
      sessionId: session.id,
    });

  } catch (error) {
    log.error("Stripe embedded checkout error", error);
    return NextResponse.json(
      { 
        error: "Failed to create checkout session",
        message: error instanceof Error ? error.message : "Unknown error"
      },
      { status: 500 }
    );
  }
}

