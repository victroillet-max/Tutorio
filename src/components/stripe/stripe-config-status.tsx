import { CheckCircle2, AlertTriangle, XCircle } from "lucide-react";

interface StripeConfigStatusProps {
  isConfigured: boolean;
  hasPrices: boolean;
  hasWebhook: boolean;
}

/**
 * Admin component showing Stripe configuration status
 */
export function StripeConfigStatus({
  isConfigured,
  hasPrices,
  hasWebhook,
}: StripeConfigStatusProps) {
  const allConfigured = isConfigured && hasPrices && hasWebhook;

  return (
    <div className="card-elevated p-6">
      <div className="flex items-center gap-3 mb-4">
        {allConfigured ? (
          <div className="w-10 h-10 rounded-lg bg-emerald-100 flex items-center justify-center">
            <CheckCircle2 className="w-5 h-5 text-emerald-600" />
          </div>
        ) : (
          <div className="w-10 h-10 rounded-lg bg-amber-100 flex items-center justify-center">
            <AlertTriangle className="w-5 h-5 text-amber-600" />
          </div>
        )}
        <div>
          <h3 className="font-semibold text-[var(--foreground)]">
            Stripe Integration
          </h3>
          <p className="text-sm text-[var(--foreground-muted)]">
            {allConfigured
              ? "Ready to accept payments"
              : "Configuration incomplete"}
          </p>
        </div>
      </div>

      <div className="space-y-3">
        <ConfigItem
          label="API Key"
          description="STRIPE_SECRET_KEY"
          configured={isConfigured}
        />
        <ConfigItem
          label="Price IDs"
          description="STRIPE_BASIC_PRICE_ID, STRIPE_ADVANCED_PRICE_ID"
          configured={hasPrices}
        />
        <ConfigItem
          label="Webhook Secret"
          description="STRIPE_WEBHOOK_SECRET"
          configured={hasWebhook}
        />
      </div>

      {!allConfigured && (
        <div className="mt-4 p-3 bg-amber-50 border border-amber-200 rounded-lg text-sm text-amber-800">
          <p className="font-medium mb-1">Setup Required</p>
          <p>
            Add the missing environment variables to enable payment processing.
            See the setup guide for instructions.
          </p>
        </div>
      )}
    </div>
  );
}

function ConfigItem({
  label,
  description,
  configured,
}: {
  label: string;
  description: string;
  configured: boolean;
}) {
  return (
    <div className="flex items-center justify-between py-2 border-b border-[var(--border)] last:border-0">
      <div>
        <p className="font-medium text-sm text-[var(--foreground)]">{label}</p>
        <p className="text-xs text-[var(--foreground-muted)] font-mono">
          {description}
        </p>
      </div>
      {configured ? (
        <CheckCircle2 className="w-5 h-5 text-emerald-500" />
      ) : (
        <XCircle className="w-5 h-5 text-red-400" />
      )}
    </div>
  );
}

