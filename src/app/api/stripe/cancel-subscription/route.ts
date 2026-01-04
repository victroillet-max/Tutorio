import { createClient } from "@/utils/supabase/server";
import { createClient as createSupabaseClient } from "@supabase/supabase-js";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";
import { logger } from "@/lib/logging";
import { applyRateLimit, createRateLimitResponse } from "@/lib/rate-limit";
import { STRIPE_API_VERSION } from "@/lib/stripe/types";

const log = logger.child({ module: "api/stripe/cancel-subscription" });

// Service role client for bypassing RLS on subscription updates
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

// Initialize Stripe
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: STRIPE_API_VERSION }) : null;

/**
 * POST /api/stripe/cancel-subscription
 * Cancels a user's subscription at the end of the billing period
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
    log.warn("Rate limit exceeded for cancel-subscription", { userId: user.id });
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
    const { subscriptionId, stripeSubscriptionId, cancelImmediately = false } = body;

    if (!subscriptionId || !stripeSubscriptionId) {
      return NextResponse.json(
        { error: "Missing required parameters: subscriptionId and stripeSubscriptionId" },
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
        current_period_end
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

    try {
      let cancelledSubscription;

      if (cancelImmediately) {
        // Cancel immediately - stops access right away
        cancelledSubscription = await stripe.subscriptions.cancel(stripeSubscriptionId);
        log.info("Subscription cancelled immediately", { subscriptionId: stripeSubscriptionId });
      } else {
        // Cancel at period end - user keeps access until billing period ends
        cancelledSubscription = await stripe.subscriptions.update(stripeSubscriptionId, {
          cancel_at_period_end: true,
        });
        log.info("Subscription set to cancel at period end", { 
          subscriptionId: stripeSubscriptionId,
          cancelAt: cancelledSubscription.cancel_at 
        });
      }

      // Update our database using service role to bypass RLS
      if (supabaseUrl && supabaseServiceKey) {
        const serviceClient = createSupabaseClient(supabaseUrl, supabaseServiceKey);
        
        const updateData: Record<string, unknown> = {
          cancel_at_period_end: cancelImmediately ? false : true,
          cancelled_at: new Date().toISOString(),
          updated_at: new Date().toISOString(),
        };

        if (cancelImmediately) {
          updateData.status = 'cancelled';
        }

        const { error: updateError } = await serviceClient
          .from("subscriptions")
          .update(updateData)
          .eq("id", subscriptionId);

        if (updateError) {
          log.error("Failed to update local subscription", updateError, { subscriptionId });
        } else {
          log.info("Local subscription updated for cancellation", { subscriptionId, cancelImmediately });
        }
      }

      const periodEnd = new Date(subscription.current_period_end);

      return NextResponse.json({
        success: true,
        message: cancelImmediately 
          ? "Subscription cancelled immediately" 
          : "Subscription will be cancelled at the end of your billing period",
        accessUntil: cancelImmediately ? null : periodEnd.toISOString(),
      });

    } catch (stripeError) {
      log.error("Stripe subscription cancel error", stripeError, { subscriptionId });
      
      return NextResponse.json(
        { 
          error: "Failed to cancel subscription",
          message: stripeError instanceof Error ? stripeError.message : "Please try again or contact support."
        },
        { status: 500 }
      );
    }

  } catch (error) {
    log.error("Cancel subscription error", error);
    return NextResponse.json(
      { 
        error: "Failed to process cancellation",
        message: error instanceof Error ? error.message : "Unknown error"
      },
      { status: 500 }
    );
  }
}


