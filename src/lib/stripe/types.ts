/**
 * Stripe Type Extensions
 * 
 * Shared types for Stripe API responses that include additional fields
 * not always present in the base type definitions.
 */

import Stripe from "stripe";

/**
 * Stripe subscription with period timestamps
 * The Stripe SDK types don't always include these as numbers,
 * but the API returns them as Unix timestamps (seconds).
 */
export type StripeSubscriptionWithPeriods = Stripe.Subscription & {
  current_period_start: number;
  current_period_end: number;
};

/**
 * Stripe API version to use across all endpoints
 * Pin to a stable version to avoid breaking changes
 * 
 * @see https://stripe.com/docs/api/versioning
 */
export const STRIPE_API_VERSION = "2025-12-15.clover" as const;

/**
 * Check if Stripe is in test mode based on the publishable key
 */
export function isStripeTestMode(): boolean {
  const publishableKey = process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY;
  return publishableKey?.startsWith("pk_test_") ?? true;
}

/**
 * Check if Stripe is configured (has required keys)
 */
export function isStripeConfigured(): boolean {
  return !!(
    process.env.STRIPE_SECRET_KEY &&
    process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY
  );
}

/**
 * Subscription status mapping from Stripe to our database
 */
export const STRIPE_STATUS_MAP: Record<Stripe.Subscription.Status, string> = {
  active: "active",
  trialing: "trialing",
  past_due: "past_due",
  canceled: "cancelled",
  unpaid: "expired",
  incomplete: "expired",
  incomplete_expired: "expired",
  paused: "cancelled",
};

/**
 * Get our internal status from Stripe status
 */
export function mapStripeStatus(stripeStatus: Stripe.Subscription.Status): string {
  return STRIPE_STATUS_MAP[stripeStatus] || "expired";
}

