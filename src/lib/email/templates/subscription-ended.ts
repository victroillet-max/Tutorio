import { getSiteUrl } from "@/lib/env";
import { 
  baseEmailTemplate, 
  emailHeading, 
  emailParagraph, 
  emailButton,
  emailDivider,
  emailInfoBox,
  emailColors,
  emailFeatureItem,
} from "./base";

export interface SubscriptionEndedData {
  userName: string;
  courseName: string;
  endDate: string;
  reason?: "cancelled" | "payment_failed" | "expired";
}

/**
 * Subscription ended email sent when a subscription is cancelled or expires
 */
export function subscriptionEndedTemplate(data: SubscriptionEndedData): { html: string; text: string; subject: string } {
  const siteUrl = getSiteUrl();
  const displayName = data.userName || "there";
  
  const reasonMessages = {
    cancelled: "Your subscription has been cancelled as requested.",
    payment_failed: "Your subscription has ended due to a payment issue.",
    expired: "Your subscription period has ended.",
  };
  
  const reasonMessage = reasonMessages[data.reason || "expired"];
  
  const content = `
    ${emailHeading(`Your subscription has ended`)}
    
    ${emailParagraph(`
      Hi ${displayName}, ${reasonMessage} Your access to 
      <strong style="color: ${emailColors.text};">${data.courseName}</strong> ended on ${data.endDate}.
    `)}
    
    ${data.reason === "payment_failed" ? emailInfoBox(
      `We had trouble processing your payment. Please update your payment method to reactivate your subscription.`,
      "warning"
    ) : ""}
    
    ${emailDivider()}
    
    ${emailParagraph(`
      We'd love to have you back! You can resubscribe anytime to continue your learning journey.
    `)}
    
    ${emailButton("Resubscribe Now", `${siteUrl}/pricing`)}
    
    <p style="margin: 24px 0 16px 0; font-size: 16px; font-weight: 600; color: ${emailColors.text};">
      What you'll get back:
    </p>
    
    <table role="presentation" cellpadding="0" cellspacing="0" width="100%">
      ${emailFeatureItem("Full Course Access", "All materials, lessons, and exercises unlocked.")}
      ${emailFeatureItem("Your Progress Saved", "Pick up right where you left off.")}
      ${emailFeatureItem("AI Tutor Assistance", "Get help from Bob whenever you need it.")}
    </table>
    
    ${emailDivider()}
    
    ${emailParagraph(`
      If you have any questions or feedback about your experience, we'd love to hear from you at 
      <a href="${siteUrl}/contact" style="color: ${emailColors.accent}; text-decoration: none; font-weight: 500;">our contact page</a>.
    `)}
    
    <p style="margin: 28px 0 0 0; font-size: 15px; color: ${emailColors.textMuted};">
      Thanks for learning with us,<br/>
      <strong style="color: ${emailColors.text};">The Tutorio Team</strong>
    </p>
  `;
  
  const html = baseEmailTemplate(content, {
    previewText: `Your ${data.courseName} subscription has ended`,
  }).replace(/\$\{siteUrl\}/g, siteUrl);
  
  const text = `
Your subscription has ended

Hi ${displayName}, ${reasonMessage} Your access to ${data.courseName} ended on ${data.endDate}.

${data.reason === "payment_failed" ? "We had trouble processing your payment. Please update your payment method to reactivate your subscription.\n" : ""}
We'd love to have you back! You can resubscribe anytime to continue your learning journey.

Resubscribe: ${siteUrl}/pricing

What you'll get back:
- Full Course Access: All materials, lessons, and exercises unlocked.
- Your Progress Saved: Pick up right where you left off.
- AI Tutor Assistance: Get help from Bob whenever you need it.

If you have any questions or feedback about your experience, we'd love to hear from you at ${siteUrl}/contact.

Thanks for learning with us,
The Tutorio Team
  `.trim();
  
  return {
    html,
    text,
    subject: `Your ${data.courseName} subscription has ended`,
  };
}
