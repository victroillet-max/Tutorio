import { createClient, SupabaseClient } from "@supabase/supabase-js";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";
import { logger, startTimer } from "@/lib/logging";

// Initialize Stripe
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: "2025-12-15.clover" }) : null;

// Use service role for webhook processing (bypasses RLS)
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY!;

// eslint-disable-next-line @typescript-eslint/no-explicit-any
type SupabaseServiceClient = SupabaseClient<any, "public", any>;

const log = logger.child({ handler: "stripe/webhook" });

/**
 * Retry wrapper for Stripe API calls
 * Implements exponential backoff for transient failures
 */
async function withRetry<T>(
  fn: () => Promise<T>,
  maxRetries = 3,
  baseDelayMs = 1000
): Promise<T> {
  let lastError: Error | undefined;
  
  for (let attempt = 0; attempt < maxRetries; attempt++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error instanceof Error ? error : new Error(String(error));
      
      // Don't retry on non-retryable errors
      if (error instanceof Stripe.errors.StripeError) {
        // Only retry on rate limits or temporary server errors
        if (!['rate_limit', 'api_connection_error'].includes(error.type)) {
          throw error;
        }
      }
      
      // Wait with exponential backoff before retrying
      if (attempt < maxRetries - 1) {
        const delay = baseDelayMs * Math.pow(2, attempt);
        await new Promise(resolve => setTimeout(resolve, delay));
      }
    }
  }
  
  throw lastError;
}

/**
 * Check if a webhook event has already been processed (idempotency)
 * Returns true if the event was already processed
 */
async function isEventProcessed(
  supabase: SupabaseServiceClient,
  eventId: string
): Promise<boolean> {
  const { data } = await supabase
    .from("stripe_webhook_events")
    .select("id")
    .eq("id", eventId)
    .single();
  
  return !!data;
}

/**
 * Mark a webhook event as processed
 */
async function markEventProcessed(
  supabase: SupabaseServiceClient,
  eventId: string,
  eventType: string
): Promise<void> {
  await supabase
    .from("stripe_webhook_events")
    .upsert(
      { id: eventId, type: eventType },
      { onConflict: "id", ignoreDuplicates: true }
    );
}

/**
 * POST /api/stripe/webhook
 * Handles Stripe webhook events for subscription management
 */
export async function POST(request: NextRequest) {
  const timer = startTimer();
  
  if (!stripe || !webhookSecret) {
    log.error("Stripe webhook not configured");
    return NextResponse.json(
      { error: "Webhook not configured" },
      { status: 501 }
    );
  }

  if (!supabaseServiceKey) {
    log.error("Supabase service role key not configured");
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
    log.error("Webhook signature verification failed", err);
    return NextResponse.json(
      { error: "Invalid signature" },
      { status: 400 }
    );
  }

  // Idempotency check: Skip if event was already processed
  const alreadyProcessed = await isEventProcessed(supabase, event.id);
  if (alreadyProcessed) {
    log.info("Event already processed, skipping", { eventId: event.id, eventType: event.type });
    return NextResponse.json({ received: true, skipped: true });
  }
  
  log.info("Processing webhook event", { eventId: event.id, eventType: event.type });

  try {
    switch (event.type) {
      case "checkout.session.completed": {
        const session = event.data.object as Stripe.Checkout.Session;
        await handleCheckoutCompleted(supabase, session);
        break;
      }

      case "customer.subscription.updated": {
        const subscription = event.data.object as Stripe.Subscription & { current_period_start: number; current_period_end: number };
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
        log.debug("Unhandled event type", { eventType: event.type });
    }

    // Mark event as processed after successful handling
    await markEventProcessed(supabase, event.id, event.type);

    timer.log("Webhook processed", { eventId: event.id, eventType: event.type });
    return NextResponse.json({ received: true });

  } catch (error) {
    log.error("Webhook handler error", error, { eventId: event.id, eventType: event.type });
    // Don't mark as processed on error - Stripe will retry
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
  supabase: SupabaseServiceClient,
  session: Stripe.Checkout.Session
) {
  const { supabase_user_id, course_id, tier } = session.metadata || {};

  if (!supabase_user_id || !course_id || !tier) {
    log.error("Missing metadata in checkout session", undefined, { sessionId: session.id });
    return;
  }

  // Get the subscription from Stripe
  const stripeSubscriptionId = session.subscription as string;
  if (!stripeSubscriptionId) {
    log.error("No subscription in checkout session", undefined, { sessionId: session.id });
    return;
  }

  const stripeSubscription = await withRetry(() => 
    stripe!.subscriptions.retrieve(stripeSubscriptionId)
  ) as unknown as Stripe.Subscription & {
    current_period_start: number;
    current_period_end: number;
  };

  // Get the tier ID from our database
  const { data: tierData, error: tierError } = await supabase
    .from("subscription_tiers")
    .select("id")
    .eq("slug", tier)
    .single();

  if (tierError || !tierData) {
    log.error("Failed to find tier", tierError, { tier });
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
    log.error("Failed to create/update subscription", subError, { 
      userId: supabase_user_id, 
      courseId: course_id 
    });
    return;
  }

  log.info("Subscription created/updated", { 
    userId: supabase_user_id, 
    courseId: course_id, 
    tier 
  });
}

/**
 * Handle subscription updates (e.g., plan changes, cancellations)
 */
async function handleSubscriptionUpdated(
  supabase: SupabaseServiceClient,
  subscription: Stripe.Subscription & { current_period_start: number; current_period_end: number }
) {
  // Verify subscription exists in our database before updating
  const { data: existingSub } = await supabase
    .from("subscriptions")
    .select("id")
    .eq("stripe_subscription_id", subscription.id)
    .single();

  if (!existingSub) {
    log.error("Could not find subscription to update", undefined, { 
      stripeSubscriptionId: subscription.id 
    });
    return;
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

  // Check if the tier changed (from metadata)
  const newTierSlug = subscription.metadata?.tier;
  let tierId: string | undefined;

  if (newTierSlug) {
    const { data: tierData } = await supabase
      .from("subscription_tiers")
      .select("id")
      .eq("slug", newTierSlug)
      .single();
    
    if (tierData) {
      tierId = tierData.id;
    }
  }

  // Build update object
  const updateData: Record<string, unknown> = {
    status,
    current_period_start: new Date(subscription.current_period_start * 1000).toISOString(),
    current_period_end: new Date(subscription.current_period_end * 1000).toISOString(),
    cancel_at_period_end: subscription.cancel_at_period_end,
    cancelled_at: subscription.canceled_at 
      ? new Date(subscription.canceled_at * 1000).toISOString() 
      : null,
    updated_at: new Date().toISOString(),
  };

  // Include tier update if tier changed
  if (tierId) {
    updateData.tier_id = tierId;
  }

  // Update subscription in database
  const { error } = await supabase
    .from("subscriptions")
    .update(updateData)
    .eq("stripe_subscription_id", subscription.id);

  if (error) {
    log.error("Failed to update subscription", error, { 
      stripeSubscriptionId: subscription.id 
    });
  } else if (tierId) {
    log.info("Subscription tier updated", { 
      stripeSubscriptionId: subscription.id, 
      newTier: newTierSlug 
    });
  }
}

/**
 * Handle subscription deletion/cancellation
 */
async function handleSubscriptionDeleted(
  supabase: SupabaseServiceClient,
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
    log.error("Failed to mark subscription as expired", error, { 
      stripeSubscriptionId: subscription.id 
    });
  } else {
    log.info("Subscription marked as expired", { 
      stripeSubscriptionId: subscription.id 
    });
  }
}

/**
 * Handle successful payment - extend subscription
 */
async function handlePaymentSucceeded(
  supabase: SupabaseServiceClient,
  invoice: Stripe.Invoice
) {
  // subscription can be a string ID or an expanded Subscription object
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const subscriptionData = (invoice as any).subscription;
  const subscriptionId = typeof subscriptionData === 'string' 
    ? subscriptionData 
    : (subscriptionData as { id?: string } | null)?.id;
  if (!subscriptionId) return;

  // Get the updated subscription from Stripe with retry logic
  const subscription = await withRetry(() => 
    stripe!.subscriptions.retrieve(subscriptionId)
  ) as unknown as Stripe.Subscription & {
    current_period_start: number;
    current_period_end: number;
  };

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
    log.error("Failed to update subscription after payment", error, { 
      stripeSubscriptionId: subscriptionId 
    });
  } else {
    log.info("Subscription renewed", { stripeSubscriptionId: subscriptionId });
  }
}

/**
 * Handle failed payment
 */
async function handlePaymentFailed(
  supabase: SupabaseServiceClient,
  invoice: Stripe.Invoice
) {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const subscriptionData = (invoice as any).subscription;
  const subscriptionId = typeof subscriptionData === 'string' 
    ? subscriptionData 
    : (subscriptionData as { id?: string } | null)?.id;
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
    log.error("Failed to mark subscription as past_due", error, { 
      stripeSubscriptionId: subscriptionId 
    });
  } else {
    log.warn("Subscription marked as past_due due to payment failure", { 
      stripeSubscriptionId: subscriptionId 
    });
  }
}

