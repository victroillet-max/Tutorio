"use client";

import { AlertTriangle } from "lucide-react";

/**
 * Banner that displays when Stripe is in test mode
 * Only renders if the publishable key starts with pk_test_
 */
export function StripeTestModeBanner() {
  const publishableKey = process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY;
  const isTestMode = publishableKey?.startsWith("pk_test_");

  if (!isTestMode) {
    return null;
  }

  return (
    <div className="fixed bottom-0 left-0 right-0 z-50 bg-amber-500 text-amber-950 px-4 py-2 text-center text-sm font-medium shadow-lg">
      <div className="flex items-center justify-center gap-2">
        <AlertTriangle className="w-4 h-4" />
        <span>
          Stripe Test Mode - Use card <code className="bg-amber-400/50 px-1 rounded">4242 4242 4242 4242</code> for testing
        </span>
      </div>
    </div>
  );
}

/**
 * Inline test mode indicator for use near payment forms
 */
export function StripeTestModeIndicator() {
  const publishableKey = process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY;
  const isTestMode = publishableKey?.startsWith("pk_test_");

  if (!isTestMode) {
    return null;
  }

  return (
    <div className="inline-flex items-center gap-1.5 px-2 py-1 bg-amber-100 text-amber-800 text-xs font-medium rounded-full border border-amber-300">
      <AlertTriangle className="w-3 h-3" />
      Test Mode
    </div>
  );
}

