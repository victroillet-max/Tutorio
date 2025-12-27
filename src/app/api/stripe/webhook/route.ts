import { createClient } from "@supabase/supabase-js";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";

// Initialize Stripe
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: "2024-12-18.acacia" }) : null;

// Use service role for webhook processing (bypasses RLS)
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY!;

/**
 * POST /api/stripe/webhook
 * Handles Stripe webhook events for subscription management
 */
export async function POST(request: NextRequest) {
  if (!stripe || !webhookSecret) {
    console.error("Stripe webhook not configured");
    return NextResponse.json(
      { error: "Webhook not configured" },
      { status: 501 }
    );
  }

  if (!supabaseServiceKey) {
    console.error("Supabase service role key not configured");
    return NextResponse.json(
      { error: "Server configuration error" },
      { status: 500 }
    );
  }

  const supabase = createClient(supabaseUrl, supabaseServiceKey);

  // Get the raw body for signature verification
  const body = await request.text();
  const signature = request.headers.get("stripe-signature");

  if (!signature) {
    return NextResponse.json(
      { error: "Missing signature" },
      { status: 400 }
    );
  }

  let event: Stripe.Event;

  try {
    event = stripe.webhooks.constructEvent(body, signature, webhookSecret);
  } catch (err) {
    console.error("Webhook signature verification failed:", err);
    return NextResponse.json(
      { error: "Invalid signature" },
      { status: 400 }
    );
  }

  try {
    switch (event.type) {
      case "checkout.session.completed": {
        const session = event.data.object as Stripe.Checkout.Session;
        await handleCheckoutCompleted(supabase, session);
        break;
      }

      case "customer.subscription.updated": {
        const subscription = event.data.object as Stripe.Subscription;
        await handleSubscriptionUpdated(supabase, subscription);
        break;
      }

      case "customer.subscription.deleted": {
        const subscription = event.data.object as Stripe.Subscription;
        await handleSubscriptionDeleted(supabase, subscription);
        break;
      }

      case "invoice.payment_succeeded": {
        const invoice = event.data.object as Stripe.Invoice;
        await handlePaymentSucceeded(supabase, invoice);
        break;
      }

      case "invoice.payment_failed": {
        const invoice = event.data.object as Stripe.Invoice;
        await handlePaymentFailed(supabase, invoice);
        break;
      }

      default:
        console.log(`Unhandled event type: ${event.type}`);
    }

    return NextResponse.json({ received: true });

  } catch (error) {
    console.error("Webhook handler error:", error);
    return NextResponse.json(
      { error: "Webhook handler failed" },
      { status: 500 }
    );
  }
}

/**
 * Handle successful checkout session completion
 * Creates or updates the subscription in our database
 */
async function handleCheckoutCompleted(
  supabase: ReturnType<typeof createClient>,
  session: Stripe.Checkout.Session
) {
  const { supabase_user_id, course_id, tier } = session.metadata || {};

  if (!supabase_user_id || !course_id || !tier) {
    console.error("Missing metadata in checkout session:", session.id);
    return;
  }

  // Get the subscription from Stripe
  const stripeSubscriptionId = session.subscription as string;
  if (!stripeSubscriptionId) {
    console.error("No subscription in checkout session:", session.id);
    return;
  }

  const stripeSubscription = await stripe!.subscriptions.retrieve(stripeSubscriptionId);

  // Get the tier ID from our database
  const { data: tierData, error: tierError } = await supabase
    .from("subscription_tiers")
    .select("id")
    .eq("slug", tier)
    .single();

  if (tierError || !tierData) {
    console.error("Failed to find tier:", tier, tierError);
    return;
  }

  // Create or update subscription in our database
  const { error: subError } = await supabase
    .from("subscriptions")
    .upsert({
      user_id: supabase_user_id,
      course_id: course_id,
      tier_id: tierData.id,
      status: stripeSubscription.status === "active" ? "active" : "trialing",
      current_period_start: new Date(stripeSubscription.current_period_start * 1000).toISOString(),
      current_period_end: new Date(stripeSubscription.current_period_end * 1000).toISOString(),
      stripe_subscription_id: stripeSubscriptionId,
      stripe_customer_id: session.customer as string,
      cancel_at_period_end: stripeSubscription.cancel_at_period_end,
    }, {
      onConflict: "user_id,course_id",
    });

  if (subError) {
    console.error("Failed to create/update subscription:", subError);
    return;
  }

  console.log(`Subscription created/updated for user ${supabase_user_id} on course ${course_id}`);
}

/**
 * Handle subscription updates (e.g., plan changes, cancellations)
 */
async function handleSubscriptionUpdated(
  supabase: ReturnType<typeof createClient>,
  subscription: Stripe.Subscription
) {
  const { supabase_user_id, course_id, tier } = subscription.metadata || {};

  if (!supabase_user_id || !course_id) {
    // Try to find by stripe_subscription_id
    const { data: existingSub } = await supabase
      .from("subscriptions")
      .select("user_id, course_id")
      .eq("stripe_subscription_id", subscription.id)
      .single();

    if (!existingSub) {
      console.error("Could not find subscription:", subscription.id);
      return;
    }
  }

  // Map Stripe status to our status
  const statusMap: Record<string, string> = {
    active: "active",
    trialing: "trialing",
    past_due: "past_due",
    canceled: "cancelled",
    unpaid: "expired",
  };

  const status = statusMap[subscription.status] || "expired";

  // Update subscription in database
  const { error } = await supabase
    .from("subscriptions")
    .update({
      status,
      current_period_start: new Date(subscription.current_period_start * 1000).toISOString(),
      current_period_end: new Date(subscription.current_period_end * 1000).toISOString(),
      cancel_at_period_end: subscription.cancel_at_period_end,
      cancelled_at: subscription.canceled_at 
        ? new Date(subscription.canceled_at * 1000).toISOString() 
        : null,
      updated_at: new Date().toISOString(),
    })
    .eq("stripe_subscription_id", subscription.id);

  if (error) {
    console.error("Failed to update subscription:", error);
  }
}

/**
 * Handle subscription deletion/cancellation
 */
async function handleSubscriptionDeleted(
  supabase: ReturnType<typeof createClient>,
  subscription: Stripe.Subscription
) {
  const { error } = await supabase
    .from("subscriptions")
    .update({
      status: "expired",
      cancelled_at: new Date().toISOString(),
      updated_at: new Date().toISOString(),
    })
    .eq("stripe_subscription_id", subscription.id);

  if (error) {
    console.error("Failed to mark subscription as expired:", error);
  }
}

/**
 * Handle successful payment - extend subscription
 */
async function handlePaymentSucceeded(
  supabase: ReturnType<typeof createClient>,
  invoice: Stripe.Invoice
) {
  const subscriptionId = invoice.subscription as string;
  if (!subscriptionId) return;

  // Get the updated subscription from Stripe
  const subscription = await stripe!.subscriptions.retrieve(subscriptionId);

  // Update the subscription period
  const { error } = await supabase
    .from("subscriptions")
    .update({
      status: "active",
      current_period_start: new Date(subscription.current_period_start * 1000).toISOString(),
      current_period_end: new Date(subscription.current_period_end * 1000).toISOString(),
      updated_at: new Date().toISOString(),
    })
    .eq("stripe_subscription_id", subscriptionId);

  if (error) {
    console.error("Failed to update subscription after payment:", error);
  }
}

/**
 * Handle failed payment
 */
async function handlePaymentFailed(
  supabase: ReturnType<typeof createClient>,
  invoice: Stripe.Invoice
) {
  const subscriptionId = invoice.subscription as string;
  if (!subscriptionId) return;

  // Mark subscription as past_due
  const { error } = await supabase
    .from("subscriptions")
    .update({
      status: "past_due",
      updated_at: new Date().toISOString(),
    })
    .eq("stripe_subscription_id", subscriptionId);

  if (error) {
    console.error("Failed to mark subscription as past_due:", error);
  }
}

