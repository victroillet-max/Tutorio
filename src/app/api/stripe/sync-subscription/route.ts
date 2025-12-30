import { createClient } from "@/utils/supabase/server";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";
import { logger } from "@/lib/logging";
import { createClient as createServiceClient } from "@supabase/supabase-js";

const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: "2025-12-15.clover" }) : null;

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

    // Get the subscription
    const stripeSubscription = session.subscription as Stripe.Subscription | null;
    
    if (!stripeSubscription) {
      return NextResponse.json({ error: "No subscription in session" }, { status: 400 });
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
    const subscriptionData = {
      user_id: user.id,
      course_id: course_id,
      tier_id: tierData.id,
      status: stripeSubscription.status === "active" ? "active" : "trialing",
      current_period_start: new Date((stripeSubscription as unknown as { current_period_start: number }).current_period_start * 1000).toISOString(),
      current_period_end: new Date((stripeSubscription as unknown as { current_period_end: number }).current_period_end * 1000).toISOString(),
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

