"use client";

import { useEffect } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import { toast } from "sonner";

interface CheckoutResultProps {
  courseTitle?: string;
}

/**
 * Component that handles checkout result notifications
 * Reads URL params and shows appropriate toast messages
 */
export function CheckoutResult({ courseTitle }: CheckoutResultProps) {
  const searchParams = useSearchParams();
  const router = useRouter();
  
  useEffect(() => {
    const checkout = searchParams.get("checkout");
    
    if (checkout === "success") {
      toast.success("Subscription Activated!", {
        description: courseTitle 
          ? `You now have full access to ${courseTitle}. Start learning!`
          : "Your subscription is now active. Start learning!",
        duration: 6000,
      });
      
      // Clean up URL
      const url = new URL(window.location.href);
      url.searchParams.delete("checkout");
      router.replace(url.pathname + url.search, { scroll: false });
    }
    
    if (checkout === "cancelled") {
      toast.info("Checkout Cancelled", {
        description: "No worries! You can subscribe whenever you're ready.",
        duration: 4000,
      });
      
      // Clean up URL
      const url = new URL(window.location.href);
      url.searchParams.delete("checkout");
      router.replace(url.pathname + url.search, { scroll: false });
    }
  }, [searchParams, router, courseTitle]);
  
  return null;
}

/**
 * Component that handles pricing page error notifications
 */
export function PricingError() {
  const searchParams = useSearchParams();
  const router = useRouter();
  
  useEffect(() => {
    const error = searchParams.get("error");
    
    if (error) {
      const errorMessages: Record<string, { title: string; description: string }> = {
        stripe_not_configured: {
          title: "Payments Unavailable",
          description: "Payment processing is not set up yet. Please try again later.",
        },
        missing_course: {
          title: "Course Not Found",
          description: "Please select a course to subscribe to.",
        },
        checkout_failed: {
          title: "Checkout Failed",
          description: "Something went wrong. Please try again.",
        },
        no_customer: {
          title: "No Active Subscription",
          description: "You don't have any subscriptions to manage yet.",
        },
        portal_failed: {
          title: "Portal Unavailable",
          description: "Could not open the billing portal. Please try again.",
        },
      };
      
      const errorInfo = errorMessages[error] || {
        title: "Error",
        description: error.replace(/_/g, " "),
      };
      
      toast.error(errorInfo.title, {
        description: errorInfo.description,
        duration: 5000,
      });
      
      // Clean up URL
      const url = new URL(window.location.href);
      url.searchParams.delete("error");
      router.replace(url.pathname + url.search, { scroll: false });
    }
  }, [searchParams, router]);
  
  return null;
}

