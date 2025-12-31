import { createClient } from "@/utils/supabase/server";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";
import { logger } from "@/lib/logging";
import { createClient as createServiceClient } from "@supabase/supabase-js";
import { applyRateLimit, createRateLimitResponse } from "@/lib/rate-limit";
import { STRIPE_API_VERSION } from "@/lib/stripe/types";

const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: STRIPE_API_VERSION }) : null;

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

const log = logger.child({ handler: "stripe/sync-subscription" });

/**
 * POST /api/stripe/sync-subscription
 * Manually syncs subscription from Stripe for the current user
 * Useful when webhook fails or for local development
 */
export async function POST(request: NextRequest) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
  }

  // Apply rate limiting
  const rateLimitResult = await applyRateLimit(request, user.id, "checkout");
  if (rateLimitResult) {
    log.warn("Rate limit exceeded for sync-subscription", { userId: user.id });
    return createRateLimitResponse(rateLimitResult);
  }

  if (!stripe) {
    return NextResponse.json({ error: "Stripe not configured" }, { status: 501 });
  }

  if (!supabaseServiceKey) {
    return NextResponse.json({ error: "Service role key not configured" }, { status: 500 });
  }

  const serviceClient = createServiceClient(supabaseUrl, supabaseServiceKey);

  try {
    const { sessionId } = await request.json();

    if (!sessionId) {
      return NextResponse.json({ error: "Session ID required" }, { status: 400 });
    }

    // Retrieve the checkout session from Stripe
    const session = await stripe.checkout.sessions.retrieve(sessionId, {
      expand: ['subscription']
    });

    if (!session) {
      return NextResponse.json({ error: "Session not found" }, { status: 404 });
    }

    // Verify the session belongs to this user
    if (session.metadata?.supabase_user_id !== user.id) {
      log.warn("Session user mismatch", { 
        sessionUserId: session.metadata?.supabase_user_id, 
        currentUserId: user.id 
      });
      return NextResponse.json({ error: "Session does not belong to this user" }, { status: 403 });
    }

    const { course_id, tier } = session.metadata || {};

    if (!course_id || !tier) {
      return NextResponse.json({ error: "Missing metadata in session" }, { status: 400 });
    }

    // Get the subscription - it might be a string ID or an expanded object
    let stripeSubscription: Stripe.Subscription;
    const subscriptionData_raw = session.subscription;
    
    if (!subscriptionData_raw) {
      return NextResponse.json({ error: "No subscription in session" }, { status: 400 });
    }
    
    // If it's a string, retrieve the full subscription
    if (typeof subscriptionData_raw === 'string') {
      stripeSubscription = await stripe.subscriptions.retrieve(subscriptionData_raw);
    } else {
      stripeSubscription = subscriptionData_raw as Stripe.Subscription;
    }

    // Get tier ID
    const { data: tierData, error: tierError } = await serviceClient
      .from("subscription_tiers")
      .select("id")
      .eq("slug", tier)
      .single();

    if (tierError || !tierData) {
      return NextResponse.json({ error: `Tier '${tier}' not found` }, { status: 400 });
    }

    // Create or update subscription
    // Access the period timestamps - they are Unix timestamps (seconds)
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const subAny = stripeSubscription as any;
    const periodStart = subAny.current_period_start;
    const periodEnd = subAny.current_period_end;
    
    // Convert Unix timestamps to ISO strings
    const currentPeriodStart = typeof periodStart === 'number' 
      ? new Date(periodStart * 1000).toISOString()
      : new Date().toISOString();
    const currentPeriodEnd = typeof periodEnd === 'number'
      ? new Date(periodEnd * 1000).toISOString()
      : new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(); // Default 30 days

    const subscriptionData = {
      user_id: user.id,
      course_id: course_id,
      tier_id: tierData.id,
      status: stripeSubscription.status === "active" ? "active" : "trialing",
      current_period_start: currentPeriodStart,
      current_period_end: currentPeriodEnd,
      stripe_subscription_id: stripeSubscription.id,
      stripe_customer_id: session.customer as string,
      cancel_at_period_end: stripeSubscription.cancel_at_period_end,
    };

    const { error: subError } = await serviceClient
      .from("subscriptions")
      .upsert(subscriptionData, {
        onConflict: "user_id,course_id",
      });

    if (subError) {
      log.error("Failed to sync subscription", subError);
      return NextResponse.json({ error: "Failed to save subscription" }, { status: 500 });
    }

    log.info("Subscription synced manually", { 
      userId: user.id, 
      courseId: course_id, 
      tier 
    });

    return NextResponse.json({ 
      success: true, 
      message: "Subscription synced successfully",
      subscription: {
        courseId: course_id,
        tier,
        status: subscriptionData.status
      }
    });

  } catch (error) {
    log.error("Sync subscription error", error);
    return NextResponse.json(
      { error: error instanceof Error ? error.message : "Sync failed" },
      { status: 500 }
    );
  }
}

