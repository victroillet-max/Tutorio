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

const log = logger.child({ handler: "stripe/recover-subscriptions" });

/**
 * POST /api/stripe/recover-subscriptions
 * Finds and syncs all Stripe subscriptions for the current user
 * Works by looking up the user's email in Stripe
 */
export async function POST(request: NextRequest) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
  }

  // Apply rate limiting (use a stricter limit for recovery to prevent abuse)
  const rateLimitResult = await applyRateLimit(request, user.id, "checkout");
  if (rateLimitResult) {
    log.warn("Rate limit exceeded for recover-subscriptions", { userId: user.id });
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
    // Get user's email
    const userEmail = user.email;
    
    if (!userEmail) {
      return NextResponse.json({ error: "User email not found" }, { status: 400 });
    }

    // Search for Stripe customers with this email
    const customers = await stripe.customers.list({
      email: userEmail,
      limit: 10,
    });

    if (customers.data.length === 0) {
      log.info("No Stripe customers found for email", { email: userEmail });
      return NextResponse.json({ 
        success: true, 
        message: "No purchases found for your email",
        recovered: 0 
      });
    }

    let totalRecovered = 0;
    const errors: string[] = [];

    // For each customer, get their subscriptions
    for (const customer of customers.data) {
      // Verify the customer's metadata matches our user ID (if set)
      const customerUserId = customer.metadata?.supabase_user_id;
      if (customerUserId && customerUserId !== user.id) {
        // Skip customers that belong to a different user
        log.warn("Customer belongs to different user", { 
          customerId: customer.id, 
          customerUserId,
          currentUserId: user.id 
        });
        continue;
      }

      // Get all active subscriptions for this customer
      const subscriptions = await stripe.subscriptions.list({
        customer: customer.id,
        status: "active",
        limit: 100,
      });

      // Also check for trialing subscriptions
      const trialingSubscriptions = await stripe.subscriptions.list({
        customer: customer.id,
        status: "trialing",
        limit: 100,
      });

      const allSubscriptions = [
        ...subscriptions.data,
        ...trialingSubscriptions.data,
      ];

      for (const subscription of allSubscriptions) {
        const courseId = subscription.metadata?.course_id;
        const tier = subscription.metadata?.tier;

        if (!courseId || !tier) {
          log.warn("Subscription missing metadata, skipping", { 
            subscriptionId: subscription.id 
          });
          continue;
        }

        // Check if subscription already exists in our database
        const { data: existingSub } = await serviceClient
          .from("subscriptions")
          .select("id, status")
          .eq("stripe_subscription_id", subscription.id)
          .single();

        if (existingSub && existingSub.status === "active") {
          // Already synced
          continue;
        }

        // Get tier ID
        const { data: tierData, error: tierError } = await serviceClient
          .from("subscription_tiers")
          .select("id")
          .eq("slug", tier)
          .single();

        if (tierError || !tierData) {
          errors.push(`Tier '${tier}' not found for subscription ${subscription.id}`);
          continue;
        }

        // Upsert the subscription
        // Access the period timestamps - they are Unix timestamps (seconds)
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        const subAny = subscription as any;
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
          course_id: courseId,
          tier_id: tierData.id,
          status: subscription.status === "active" ? "active" : "trialing",
          current_period_start: currentPeriodStart,
          current_period_end: currentPeriodEnd,
          stripe_subscription_id: subscription.id,
          stripe_customer_id: customer.id,
          cancel_at_period_end: subscription.cancel_at_period_end,
        };

        const { error: subError } = await serviceClient
          .from("subscriptions")
          .upsert(subscriptionData, {
            onConflict: "user_id,course_id",
          });

        if (subError) {
          log.error("Failed to sync subscription", subError, { 
            subscriptionId: subscription.id 
          });
          errors.push(`Failed to sync subscription ${subscription.id}`);
          continue;
        }

        totalRecovered++;
        log.info("Subscription recovered", { 
          userId: user.id, 
          courseId, 
          subscriptionId: subscription.id,
          tier 
        });
      }
    }

    return NextResponse.json({ 
      success: true, 
      message: totalRecovered > 0 
        ? `Recovered ${totalRecovered} subscription(s)` 
        : "No unsynced subscriptions found",
      recovered: totalRecovered,
      errors: errors.length > 0 ? errors : undefined,
    });

  } catch (error) {
    log.error("Recover subscriptions error", error);
    return NextResponse.json(
      { error: error instanceof Error ? error.message : "Recovery failed" },
      { status: 500 }
    );
  }
}

