import { createClient } from "@/utils/supabase/server";
import { NextResponse } from "next/server";
import Stripe from "stripe";
import { getSiteUrl } from "@/lib/env";

// Initialize Stripe
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;
const stripe = stripeSecretKey ? new Stripe(stripeSecretKey, { apiVersion: "2025-12-15.clover" }) : null;

/**
 * GET /api/stripe/portal
 * Redirects user to Stripe Customer Portal to manage subscriptions
 */
export async function GET() {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    const siteUrl = getSiteUrl();
    return NextResponse.redirect(new URL("/login?redirect=/subscriptions", siteUrl));
  }

  // Check if Stripe is configured
  if (!stripe) {
    const siteUrl = getSiteUrl();
    return NextResponse.redirect(new URL("/subscriptions?error=stripe_not_configured", siteUrl));
  }

  try {
    // Get user's Stripe customer ID from any subscription
    const { data: subscription } = await supabase
      .from("subscriptions")
      .select("stripe_customer_id")
      .eq("user_id", user.id)
      .not("stripe_customer_id", "is", null)
      .limit(1)
      .single();

    if (!subscription?.stripe_customer_id) {
      // No Stripe customer, redirect back to subscriptions page
      const siteUrl = getSiteUrl();
      return NextResponse.redirect(new URL("/subscriptions?error=no_customer", siteUrl));
    }

    const siteUrl = getSiteUrl();

    // Create a billing portal session
    const portalSession = await stripe.billingPortal.sessions.create({
      customer: subscription.stripe_customer_id,
      return_url: `${siteUrl}/subscriptions`,
    });

    return NextResponse.redirect(portalSession.url);

  } catch (error) {
    console.error("Stripe portal error:", error);
    const siteUrl = getSiteUrl();
    return NextResponse.redirect(new URL("/subscriptions?error=portal_failed", siteUrl));
  }
}

