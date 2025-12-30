"use client";

import { useState } from "react";
import { CreditCard, CheckCircle2, AlertCircle, Loader2, ExternalLink } from "lucide-react";
import { Button } from "@/components/ui/button";
import { toast } from "sonner";

interface StripePriceConfigProps {
  courseId: string;
  courseName: string;
  basicPriceId: string;
  advancedPriceId: string;
}

export function StripePriceConfig({
  courseId,
  courseName,
  basicPriceId: initialBasicPriceId,
  advancedPriceId: initialAdvancedPriceId,
}: StripePriceConfigProps) {
  const [basicPriceId, setBasicPriceId] = useState(initialBasicPriceId);
  const [advancedPriceId, setAdvancedPriceId] = useState(initialAdvancedPriceId);
  const [isSaving, setIsSaving] = useState(false);
  const [hasChanges, setHasChanges] = useState(false);

  const isConfigured = basicPriceId && advancedPriceId;

  const handleBasicChange = (value: string) => {
    setBasicPriceId(value);
    setHasChanges(value !== initialBasicPriceId || advancedPriceId !== initialAdvancedPriceId);
  };

  const handleAdvancedChange = (value: string) => {
    setAdvancedPriceId(value);
    setHasChanges(basicPriceId !== initialBasicPriceId || value !== initialAdvancedPriceId);
  };

  const handleSave = async () => {
    setIsSaving(true);

    try {
      const response = await fetch("/api/admin/courses/stripe-prices", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          courseId,
          basicPriceId: basicPriceId || null,
          advancedPriceId: advancedPriceId || null,
        }),
      });

      if (!response.ok) {
        const data = await response.json();
        throw new Error(data.error || "Failed to save prices");
      }

      toast.success("Stripe Prices Saved", {
        description: "The pricing configuration has been updated.",
      });
      setHasChanges(false);
    } catch (error) {
      console.error("Error saving prices:", error);
      toast.error("Failed to Save", {
        description: error instanceof Error ? error.message : "Please try again.",
      });
    } finally {
      setIsSaving(false);
    }
  };

  return (
    <div className="card-elevated p-6">
      <div className="flex items-start justify-between mb-4">
        <div className="flex items-center gap-3">
          <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${
            isConfigured ? 'bg-emerald-100' : 'bg-amber-100'
          }`}>
            {isConfigured ? (
              <CheckCircle2 className="w-5 h-5 text-emerald-600" />
            ) : (
              <AlertCircle className="w-5 h-5 text-amber-600" />
            )}
          </div>
          <div>
            <h2 
              className="text-lg font-semibold text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Stripe Pricing
            </h2>
            <p className="text-sm text-[var(--foreground-muted)]">
              {isConfigured 
                ? "Payments are enabled for this course" 
                : "Configure Stripe price IDs to enable payments"
              }
            </p>
          </div>
        </div>
        <a
          href="https://dashboard.stripe.com/products"
          target="_blank"
          rel="noopener noreferrer"
          className="inline-flex items-center gap-1 text-sm text-[var(--primary)] hover:underline"
        >
          Open Stripe
          <ExternalLink className="w-3 h-3" />
        </a>
      </div>

      <div className="grid md:grid-cols-2 gap-4 mb-4">
        {/* Basic Price */}
        <div>
          <label className="block text-sm font-medium text-[var(--foreground)] mb-1">
            Basic Tier Price ID
          </label>
          <div className="relative">
            <input
              type="text"
              value={basicPriceId}
              onChange={(e) => handleBasicChange(e.target.value)}
              placeholder="price_..."
              className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm font-mono focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent"
            />
            {basicPriceId && (
              <CheckCircle2 className="absolute right-3 top-1/2 -translate-y-1/2 w-4 h-4 text-emerald-500" />
            )}
          </div>
          <p className="text-xs text-[var(--foreground-muted)] mt-1">
            CHF 10/month subscription price
          </p>
        </div>

        {/* Advanced Price */}
        <div>
          <label className="block text-sm font-medium text-[var(--foreground)] mb-1">
            Advanced Tier Price ID
          </label>
          <div className="relative">
            <input
              type="text"
              value={advancedPriceId}
              onChange={(e) => handleAdvancedChange(e.target.value)}
              placeholder="price_..."
              className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm font-mono focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent"
            />
            {advancedPriceId && (
              <CheckCircle2 className="absolute right-3 top-1/2 -translate-y-1/2 w-4 h-4 text-emerald-500" />
            )}
          </div>
          <p className="text-xs text-[var(--foreground-muted)] mt-1">
            CHF 25/month subscription price
          </p>
        </div>
      </div>

      {/* Instructions */}
      <div className="p-3 bg-slate-50 rounded-lg text-sm text-[var(--foreground-muted)] mb-4">
        <p className="font-medium text-[var(--foreground)] mb-1">How to get Price IDs:</p>
        <ol className="list-decimal list-inside space-y-1">
          <li>Go to Stripe Dashboard → Products</li>
          <li>Find "{courseName}" products (Basic and Advanced)</li>
          <li>Click on each product and copy the Price ID (starts with "price_")</li>
          <li>Paste the IDs above and save</li>
        </ol>
      </div>

      {/* Save Button */}
      <div className="flex items-center justify-between">
        <div className="text-sm text-[var(--foreground-muted)]">
          {hasChanges && <span className="text-amber-600">Unsaved changes</span>}
        </div>
        <Button
          onClick={handleSave}
          disabled={isSaving || !hasChanges}
          className="bg-[var(--primary)] hover:bg-[var(--primary-dark)]"
        >
          {isSaving ? (
            <>
              <Loader2 className="w-4 h-4 mr-2 animate-spin" />
              Saving...
            </>
          ) : (
            <>
              <CreditCard className="w-4 h-4 mr-2" />
              Save Prices
            </>
          )}
        </Button>
      </div>
    </div>
  );
}

