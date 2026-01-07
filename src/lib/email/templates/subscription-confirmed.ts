import { getSiteUrl } from "@/lib/env";
import { 
  baseEmailTemplate, 
  emailHeading, 
  emailParagraph, 
  emailButton,
  emailDivider,
  emailColors,
} from "./base";

export interface SubscriptionConfirmedData {
  userName: string;
  courseName: string;
  tierName: string;
  amount: string;
  nextBillingDate: string;
}

/**
 * Subscription confirmation email sent after successful payment
 */
export function subscriptionConfirmedTemplate(data: SubscriptionConfirmedData): { html: string; text: string; subject: string } {
  const siteUrl = getSiteUrl();
  const displayName = data.userName || "there";
  
  const content = `
    <!-- Success Badge -->
    <div style="text-align: center; margin-bottom: 24px;">
      <div style="display: inline-block; padding: 8px 20px; background-color: ${emailColors.successLight}; color: ${emailColors.success}; border-radius: 100px; font-size: 13px; font-weight: 600;">
        Subscription Confirmed
      </div>
    </div>
    
    ${emailHeading(`You're all set, ${displayName}!`)}
    
    ${emailParagraph(`
      Your subscription to <strong style="color: ${emailColors.text};">${data.courseName}</strong> 
      has been successfully activated. You now have full access to all course materials.
    `)}
    
    ${emailButton("Start Learning", `${siteUrl}/courses`)}
    
    ${emailDivider()}
    
    <!-- Subscription Details Box -->
    <div style="background-color: ${emailColors.backgroundSecondary}; border-radius: 12px; padding: 24px; border: 1px solid ${emailColors.cardBorder};">
      <p style="margin: 0 0 16px 0; font-size: 14px; font-weight: 600; color: ${emailColors.text}; text-transform: uppercase; letter-spacing: 0.5px;">
        Subscription Details
      </p>
      <table role="presentation" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <td style="padding: 10px 0; border-bottom: 1px solid ${emailColors.cardBorder};">
            <span style="font-size: 14px; color: ${emailColors.textMuted};">Plan</span>
          </td>
          <td align="right" style="padding: 10px 0; border-bottom: 1px solid ${emailColors.cardBorder};">
            <span style="font-size: 14px; font-weight: 600; color: ${emailColors.text};">${data.tierName}</span>
          </td>
        </tr>
        <tr>
          <td style="padding: 10px 0; border-bottom: 1px solid ${emailColors.cardBorder};">
            <span style="font-size: 14px; color: ${emailColors.textMuted};">Amount</span>
          </td>
          <td align="right" style="padding: 10px 0; border-bottom: 1px solid ${emailColors.cardBorder};">
            <span style="font-size: 14px; font-weight: 600; color: ${emailColors.accent};">${data.amount}/month</span>
          </td>
        </tr>
        <tr>
          <td style="padding: 10px 0;">
            <span style="font-size: 14px; color: ${emailColors.textMuted};">Next billing</span>
          </td>
          <td align="right" style="padding: 10px 0;">
            <span style="font-size: 14px; font-weight: 600; color: ${emailColors.text};">${data.nextBillingDate}</span>
          </td>
        </tr>
      </table>
    </div>
    
    ${emailDivider()}
    
    ${emailParagraph(`
      You can manage your subscription anytime from your 
      <a href="${siteUrl}/subscriptions" style="color: ${emailColors.accent}; text-decoration: none; font-weight: 500;">subscription settings</a>.
    `)}
    
    <p style="margin: 28px 0 0 0; font-size: 15px; color: ${emailColors.textMuted};">
      Happy learning,<br/>
      <strong style="color: ${emailColors.text};">The Tutorio Team</strong>
    </p>
  `;
  
  const html = baseEmailTemplate(content, {
    previewText: `Your subscription to ${data.courseName} is now active!`,
  }).replace(/\$\{siteUrl\}/g, siteUrl);
  
  const text = `
Subscription Confirmed - You're all set!

Hi ${displayName}, your subscription to ${data.courseName} has been successfully activated. You now have full access to all course materials.

Start learning: ${siteUrl}/courses

Subscription Details:
- Plan: ${data.tierName}
- Amount: ${data.amount}/month
- Next billing date: ${data.nextBillingDate}

You can manage your subscription anytime from your subscription settings at ${siteUrl}/subscriptions.

Happy learning,
The Tutorio Team
  `.trim();
  
  return {
    html,
    text,
    subject: `Your ${data.courseName} subscription is active`,
  };
}
