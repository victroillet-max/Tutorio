import { createClient } from "@/utils/supabase/server";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";
import { getSiteUrl } from "@/lib/env";

// Initialize Stripe
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: "2025-12-15.clover" }) : null;

// Price IDs from environment
const PRICE_IDS: Record<string, string | undefined> = {
  basic: process.env.STRIPE_BASIC_PRICE_ID,
  advanced: process.env.STRIPE_ADVANCED_PRICE_ID,
};

/**
 * POST /api/stripe/checkout
 * Creates a Stripe Checkout session for per-course subscription
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
    const { courseId, tier, upgrade } = body;

    if (!courseId || !tier) {
      return NextResponse.json(
        { error: "Missing required parameters: courseId and tier" },
        { status: 400 }
      );
    }

    // Validate tier
    if (!['basic', 'advanced'].includes(tier)) {
      return NextResponse.json(
        { error: "Invalid tier. Must be 'basic' or 'advanced'" },
        { status: 400 }
      );
    }

    // Get course details
    const { data: course, error: courseError } = await supabase
      .from("courses")
      .select("id, title, slug")
      .eq("id", courseId)
      .single();

    if (courseError || !course) {
      return NextResponse.json(
        { error: "Course not found" },
        { status: 404 }
      );
    }

    // Check for existing subscription
    const { data: existingSubscription } = await supabase
      .from("subscriptions")
      .select("id, tier:subscription_tiers(slug), stripe_subscription_id")
      .eq("user_id", user.id)
      .eq("course_id", courseId)
      .in("status", ["active", "trialing"])
      .single();

    // If upgrading, handle differently
    if (upgrade && existingSubscription?.stripe_subscription_id) {
      // TODO: Implement subscription upgrade via Stripe
      // For now, redirect to billing portal
      return NextResponse.json({
        redirectUrl: "/api/stripe/portal",
        message: "Please use the billing portal to upgrade your subscription"
      });
    }

    // If already subscribed to same or higher tier, return error
    if (existingSubscription) {
      const currentTier = existingSubscription.tier as unknown as { slug: string }[] | { slug: string };
      const currentTierSlug = Array.isArray(currentTier) ? currentTier[0]?.slug : currentTier?.slug;
      
      if (currentTierSlug === tier || (currentTierSlug === 'advanced' && tier === 'basic')) {
        return NextResponse.json(
          { error: "You already have an active subscription for this course" },
          { status: 400 }
        );
      }
    }

    // Get price ID for the tier
    const priceId = PRICE_IDS[tier];
    if (!priceId) {
      return NextResponse.json(
        { 
          error: "Price not configured",
          message: `Please configure STRIPE_${tier.toUpperCase()}_PRICE_ID in environment variables`
        },
        { status: 501 }
      );
    }

    // Get or create Stripe customer
    const { data: profile } = await supabase
      .from("profiles")
      .select("email, full_name")
      .eq("id", user.id)
      .single();

    // Check if user already has a Stripe customer ID from any subscription
    const { data: anySubscription } = await supabase
      .from("subscriptions")
      .select("stripe_customer_id")
      .eq("user_id", user.id)
      .not("stripe_customer_id", "is", null)
      .limit(1)
      .single();

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
    }

    const siteUrl = getSiteUrl();

    // Create Checkout session
    const session = await stripe.checkout.sessions.create({
      customer: customerId,
      payment_method_types: ["card"],
      mode: "subscription",
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
      success_url: `${siteUrl}/courses/${course.slug}?checkout=success`,
      cancel_url: `${siteUrl}/pricing?course=${course.slug}&checkout=cancelled`,
      allow_promotion_codes: true,
    });

    return NextResponse.json({
      checkoutUrl: session.url,
      sessionId: session.id,
    });

  } catch (error) {
    console.error("Stripe checkout error:", error);
    return NextResponse.json(
      { 
        error: "Failed to create checkout session",
        message: error instanceof Error ? error.message : "Unknown error"
      },
      { status: 500 }
    );
  }
}

/**
 * GET /api/stripe/checkout
 * Redirects to checkout based on query params
 */
export async function GET(request: NextRequest) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    const siteUrl = getSiteUrl();
    return NextResponse.redirect(new URL("/login?redirect=/pricing", siteUrl));
  }

  // Check if Stripe is configured
  if (!stripe) {
    const siteUrl = getSiteUrl();
    return NextResponse.redirect(new URL("/pricing?error=stripe_not_configured", siteUrl));
  }

  const { searchParams } = new URL(request.url);
  const courseId = searchParams.get("course");
  const tier = searchParams.get("tier") || "basic";
  const upgrade = searchParams.get("upgrade") === "true";

  if (!courseId) {
    const siteUrl = getSiteUrl();
    return NextResponse.redirect(new URL("/pricing?error=missing_course", siteUrl));
  }

  try {
    // Use the POST endpoint logic
    const response = await POST(
      new NextRequest(request.url, {
        method: "POST",
        headers: request.headers,
        body: JSON.stringify({ courseId, tier, upgrade }),
      })
    );

    const data = await response.json();

    if (data.checkoutUrl) {
      return NextResponse.redirect(data.checkoutUrl);
    }

    if (data.redirectUrl) {
      const siteUrl = getSiteUrl();
      return NextResponse.redirect(new URL(data.redirectUrl, siteUrl));
    }

    // Error case
    const siteUrl = getSiteUrl();
    return NextResponse.redirect(
      new URL(`/pricing?error=${encodeURIComponent(data.error || 'checkout_failed')}`, siteUrl)
    );

  } catch (error) {
    console.error("Checkout redirect error:", error);
    const siteUrl = getSiteUrl();
    return NextResponse.redirect(new URL("/pricing?error=checkout_failed", siteUrl));
  }
}
