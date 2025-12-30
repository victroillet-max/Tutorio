"use client";

import { useState } from "react";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { toast } from "sonner";

interface SubscribeButtonProps {
  courseId: string;
  tier: "basic" | "advanced";
  children: React.ReactNode;
  className?: string;
  variant?: "default" | "outline" | "secondary";
  upgrade?: boolean;
}

/**
 * Client-side subscribe button that handles the checkout flow
 */
export function SubscribeButton({
  courseId,
  tier,
  children,
  className,
  variant = "default",
  upgrade = false,
}: SubscribeButtonProps) {
  const [isLoading, setIsLoading] = useState(false);

  const handleSubscribe = async () => {
    setIsLoading(true);

    try {
      const response = await fetch("/api/stripe/checkout", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          courseId,
          tier,
          upgrade,
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        // Handle specific errors
        if (response.status === 501) {
          toast.error("Payments Not Configured", {
            description: data.message || "Stripe is not set up yet.",
          });
          return;
        }

        if (response.status === 400) {
          toast.error("Already Subscribed", {
            description: data.error || "You already have an active subscription.",
          });
          return;
        }

        throw new Error(data.error || "Failed to create checkout session");
      }

      // Handle different response types
      if (data.checkoutUrl) {
        // New subscription - redirect to Stripe Checkout
        window.location.href = data.checkoutUrl;
      } else if (data.success && data.redirectUrl) {
        // Successful upgrade - show success and redirect
        toast.success("Subscription Upgraded!", {
          description: "Your plan has been upgraded successfully.",
        });
        window.location.href = data.redirectUrl;
      } else if (data.redirectUrl) {
        // Fallback to portal
        window.location.href = data.redirectUrl;
      }
    } catch (error) {
      console.error("Checkout error:", error);
      toast.error("Checkout Failed", {
        description: error instanceof Error ? error.message : "Please try again.",
      });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Button
      onClick={handleSubscribe}
      disabled={isLoading}
      className={className}
      variant={variant}
    >
      {isLoading ? (
        <>
          <Loader2 className="w-4 h-4 mr-2 animate-spin" />
          Processing...
        </>
      ) : (
        children
      )}
    </Button>
  );
}

