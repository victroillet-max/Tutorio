"use server";

import { sendEmail } from "./client";
import { welcomeEmailTemplate, WelcomeEmailData } from "./templates/welcome";
import { subscriptionConfirmedTemplate, SubscriptionConfirmedData } from "./templates/subscription-confirmed";
import { subscriptionEndedTemplate, SubscriptionEndedData } from "./templates/subscription-ended";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "email/actions" });

/**
 * Send a welcome email to a new user
 */
export async function sendWelcomeEmail(data: WelcomeEmailData & { to: string }) {
  const template = welcomeEmailTemplate(data);
  
  const result = await sendEmail({
    to: data.to,
    subject: template.subject,
    html: template.html,
    text: template.text,
    tags: [{ name: "type", value: "welcome" }],
  });
  
  if (!result.success) {
    log.error("Failed to send welcome email", new Error(result.error), { email: data.to });
  }
  
  return result;
}

/**
 * Send a subscription confirmation email
 */
export async function sendSubscriptionConfirmedEmail(data: SubscriptionConfirmedData & { to: string }) {
  const template = subscriptionConfirmedTemplate(data);
  
  const result = await sendEmail({
    to: data.to,
    subject: template.subject,
    html: template.html,
    text: template.text,
    tags: [
      { name: "type", value: "subscription_confirmed" },
      { name: "course", value: data.courseName },
    ],
  });
  
  if (!result.success) {
    log.error("Failed to send subscription confirmation email", new Error(result.error), { 
      email: data.to,
      course: data.courseName,
    });
  }
  
  return result;
}

/**
 * Send a subscription ended email
 */
export async function sendSubscriptionEndedEmail(data: SubscriptionEndedData & { to: string }) {
  const template = subscriptionEndedTemplate(data);
  
  const result = await sendEmail({
    to: data.to,
    subject: template.subject,
    html: template.html,
    text: template.text,
    tags: [
      { name: "type", value: "subscription_ended" },
      { name: "course", value: data.courseName },
      { name: "reason", value: data.reason || "expired" },
    ],
  });
  
  if (!result.success) {
    log.error("Failed to send subscription ended email", new Error(result.error), { 
      email: data.to,
      course: data.courseName,
      reason: data.reason,
    });
  }
  
  return result;
}

