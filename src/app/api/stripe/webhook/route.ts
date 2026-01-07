import { createClient, SupabaseClient } from "@supabase/supabase-js";
import { NextRequest, NextResponse } from "next/server";
import Stripe from "stripe";
import { logger, startTimer } from "@/lib/logging";
import { 
  STRIPE_API_VERSION, 
  StripeSubscriptionWithPeriods, 
  mapStripeStatus 
} from "@/lib/stripe/types";
import { 
  sendSubscriptionConfirmedEmail, 
  sendSubscriptionEndedEmail,
} from "@/lib/email/actions";
import { formatCurrency, formatEmailDate } from "@/lib/email/utils";

// Initialize Stripe
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: STRIPE_API_VERSION }) : null;

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

      case "customer.subscription.created": {
        // Backup handler in case checkout.session.completed fails
        const subscription = event.data.object as StripeSubscriptionWithPeriods;
        await handleSubscriptionCreated(supabase, subscription);
        break;
      }

      case "customer.subscription.updated": {
        const subscription = event.data.object as StripeSubscriptionWithPeriods;
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

      case "invoice.upcoming": {
        const invoice = event.data.object as Stripe.Invoice;
        await handleUpcomingInvoice(supabase, invoice);
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

  // Also enroll user in the course when they subscribe
  const { error: enrollError } = await supabase
    .from("course_enrollments")
    .upsert({
      user_id: supabase_user_id,
      course_id: course_id,
      enrolled_at: new Date().toISOString(),
    }, {
      onConflict: "user_id,course_id",
    });

  if (enrollError) {
    log.warn("Failed to enroll user in course after subscription", { 
      error: enrollError.message,
      userId: supabase_user_id, 
      courseId: course_id 
    });
    // Don't fail - subscription was created successfully
  }

  // Send subscription confirmation email
  try {
    // Get user profile and course details for email
    const { data: userData } = await supabase
      .from("profiles")
      .select("email, full_name")
      .eq("id", supabase_user_id)
      .single();

    const { data: courseData } = await supabase
      .from("courses")
      .select("title")
      .eq("id", course_id)
      .single();

    const { data: tierInfo } = await supabase
      .from("subscription_tiers")
      .select("name, price")
      .eq("slug", tier)
      .single();

    if (userData?.email && courseData && tierInfo) {
      await sendSubscriptionConfirmedEmail({
        to: userData.email,
        userName: userData.full_name || "",
        courseName: courseData.title,
        tierName: tierInfo.name,
        amount: formatCurrency(tierInfo.price),
        nextBillingDate: formatEmailDate(stripeSubscription.current_period_end),
      });
      
      log.info("Subscription confirmation email sent", { 
        userId: supabase_user_id, 
        email: userData.email 
      });
    }
  } catch (emailError) {
    log.error("Failed to send subscription confirmation email", emailError, {
      userId: supabase_user_id,
    });
    // Don't fail the webhook - email is not critical
  }

  log.info("Subscription created/updated", { 
    userId: supabase_user_id, 
    courseId: course_id, 
    tier 
  });
}

/**
 * Handle new subscription created (backup for checkout.session.completed)
 * This handles cases where checkout.session.completed fails but the subscription was created
 */
async function handleSubscriptionCreated(
  supabase: SupabaseServiceClient,
  subscription: StripeSubscriptionWithPeriods
) {
  const { supabase_user_id, course_id, tier } = subscription.metadata || {};

  // If metadata is missing, we can't create the subscription properly
  // This can happen if the subscription was created outside of our checkout flow
  if (!supabase_user_id || !course_id || !tier) {
    log.warn("Subscription created without required metadata", { 
      subscriptionId: subscription.id,
      hasUserId: !!supabase_user_id,
      hasCourseId: !!course_id,
      hasTier: !!tier
    });
    return;
  }

  // Check if subscription already exists in our database
  const { data: existingSub } = await supabase
    .from("subscriptions")
    .select("id")
    .eq("stripe_subscription_id", subscription.id)
    .single();

  if (existingSub) {
    log.debug("Subscription already exists, skipping creation", { 
      stripeSubscriptionId: subscription.id 
    });
    return;
  }

  // Get the tier ID from our database
  const { data: tierData, error: tierError } = await supabase
    .from("subscription_tiers")
    .select("id")
    .eq("slug", tier)
    .single();

  if (tierError || !tierData) {
    log.error("Failed to find tier for subscription.created", tierError, { tier });
    return;
  }

  // Create subscription in our database
  const { error: subError } = await supabase
    .from("subscriptions")
    .upsert({
      user_id: supabase_user_id,
      course_id: course_id,
      tier_id: tierData.id,
      status: mapStripeStatus(subscription.status),
      current_period_start: new Date(subscription.current_period_start * 1000).toISOString(),
      current_period_end: new Date(subscription.current_period_end * 1000).toISOString(),
      stripe_subscription_id: subscription.id,
      stripe_customer_id: typeof subscription.customer === 'string' 
        ? subscription.customer 
        : subscription.customer?.id,
      cancel_at_period_end: subscription.cancel_at_period_end,
    }, {
      onConflict: "user_id,course_id",
    });

  if (subError) {
    log.error("Failed to create subscription from subscription.created", subError, { 
      userId: supabase_user_id, 
      courseId: course_id 
    });
    return;
  }

  log.info("Subscription created from subscription.created event", { 
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
  subscription: StripeSubscriptionWithPeriods
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

  const status = mapStripeStatus(subscription.status);

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
  // First, get the subscription details before marking as expired
  const { data: subData } = await supabase
    .from("subscriptions")
    .select(`
      user_id,
      course_id,
      profiles:user_id (email, full_name),
      courses:course_id (title)
    `)
    .eq("stripe_subscription_id", subscription.id)
    .single();

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

    // Send subscription ended email
    if (subData) {
      // Supabase joins return arrays, but with single() we expect single records
      const profileData = subData.profiles as unknown as { email: string; full_name: string } | null;
      const courseData = subData.courses as unknown as { title: string } | null;

      if (profileData?.email && courseData) {
        try {
          await sendSubscriptionEndedEmail({
            to: profileData.email,
            userName: profileData.full_name || "",
            courseName: courseData.title,
            endDate: formatEmailDate(new Date()),
            reason: subscription.cancellation_details?.reason === "payment_failed" 
              ? "payment_failed" 
              : "cancelled",
          });

          log.info("Subscription ended email sent", {
            userId: subData.user_id,
            email: profileData.email,
          });
        } catch (emailError) {
          log.error("Failed to send subscription ended email", emailError, {
            userId: subData.user_id,
          });
        }
      }
    }
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
  ) as unknown as StripeSubscriptionWithPeriods;

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

/**
 * Handle upcoming invoice notification
 * This event fires ~3 days before a subscription renews
 * Use this to notify users about upcoming charges
 */
async function handleUpcomingInvoice(
  supabase: SupabaseServiceClient,
  invoice: Stripe.Invoice
) {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const subscriptionData = (invoice as any).subscription;
  const subscriptionId = typeof subscriptionData === 'string' 
    ? subscriptionData 
    : (subscriptionData as { id?: string } | null)?.id;
  
  if (!subscriptionId) {
    log.debug("No subscription in upcoming invoice");
    return;
  }

  // Get subscription details from our database
  const { data: subscription, error } = await supabase
    .from("subscriptions")
    .select(`
      id,
      user_id,
      course_id,
      profiles:user_id (email, full_name),
      courses:course_id (title)
    `)
    .eq("stripe_subscription_id", subscriptionId)
    .single();

  if (error || !subscription) {
    log.warn("Could not find subscription for upcoming invoice", { 
      stripeSubscriptionId: subscriptionId 
    });
    return;
  }

  // Log the upcoming renewal for now
  // In production, you would send an email notification here
  // Example: await sendRenewalReminderEmail(subscription.profiles.email, ...)
  log.info("Upcoming subscription renewal", { 
    stripeSubscriptionId: subscriptionId,
    userId: subscription.user_id,
    courseId: subscription.course_id,
    amountDue: invoice.amount_due,
    currency: invoice.currency,
    nextPaymentDate: invoice.next_payment_attempt 
      ? new Date(invoice.next_payment_attempt * 1000).toISOString()
      : undefined
  });

  // TODO: Implement email notification
  // You can integrate with your email service here to notify users
  // about their upcoming renewal. Example:
  //
  // await sendEmail({
  //   to: subscription.profiles.email,
  //   subject: `Your subscription to ${subscription.courses.title} renews soon`,
  //   template: 'renewal-reminder',
  //   data: {
  //     userName: subscription.profiles.full_name,
  //     courseTitle: subscription.courses.title,
  //     amount: formatCurrency(invoice.amount_due, invoice.currency),
  //     renewalDate: formatDate(invoice.next_payment_attempt),
  //   }
  // });
}

