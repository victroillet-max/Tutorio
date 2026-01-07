/**
 * Email Module Exports
 * 
 * This module provides email sending functionality using Resend
 */

export { sendEmail, isEmailConfigured, type SendEmailOptions, type SendEmailResult } from "./client";

// Email templates
export { welcomeEmailTemplate, type WelcomeEmailData } from "./templates/welcome";
export { emailConfirmationTemplate, type EmailConfirmationData } from "./templates/email-confirmation";
export { subscriptionConfirmedTemplate, type SubscriptionConfirmedData } from "./templates/subscription-confirmed";
export { subscriptionEndedTemplate, type SubscriptionEndedData } from "./templates/subscription-ended";

// Template utilities
export { baseEmailTemplate, emailButton, emailHeading, emailParagraph, emailDivider, emailInfoBox } from "./templates/base";

// Email actions (server actions for sending specific emails)
export { 
  sendWelcomeEmail,
  sendSubscriptionConfirmedEmail,
  sendSubscriptionEndedEmail,
} from "./actions";

// Utility functions
export { formatCurrency, formatEmailDate } from "./utils";

