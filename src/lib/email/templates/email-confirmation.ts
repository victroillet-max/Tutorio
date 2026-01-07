import { getSiteUrl } from "@/lib/env";
import { 
  baseEmailTemplate, 
  emailHeading, 
  emailParagraph, 
  emailButton,
  emailInfoBox,
  emailColors,
} from "./base";

export interface EmailConfirmationData {
  userName: string;
  confirmationUrl: string;
}

/**
 * Email confirmation email sent when user signs up
 */
export function emailConfirmationTemplate(data: EmailConfirmationData): { html: string; text: string; subject: string } {
  const siteUrl = getSiteUrl();
  const displayName = data.userName || "there";
  
  const content = `
    ${emailHeading(`Confirm your email address`)}
    
    ${emailParagraph(`
      Hi ${displayName}, thanks for signing up for Tutorio! Please confirm your email address 
      by clicking the button below to complete your registration.
    `)}
    
    ${emailButton("Confirm Email Address", data.confirmationUrl)}
    
    ${emailInfoBox(`This link will expire in 24 hours. If you didn't create an account with Tutorio, you can safely ignore this email.`)}
    
    ${emailParagraph(`
      If the button doesn't work, copy and paste this link into your browser:
    `)}
    
    <p style="margin: 0; padding: 14px 16px; background-color: ${emailColors.backgroundSecondary}; border-radius: 8px; font-size: 12px; color: ${emailColors.textMuted}; word-break: break-all; border: 1px solid ${emailColors.cardBorder};">
      ${data.confirmationUrl}
    </p>
    
    <p style="margin: 28px 0 0 0; font-size: 15px; color: ${emailColors.textMuted};">
      Best regards,<br/>
      <strong style="color: ${emailColors.text};">The Tutorio Team</strong>
    </p>
  `;
  
  const html = baseEmailTemplate(content, {
    previewText: `Confirm your email to get started with Tutorio`,
  }).replace(/\$\{siteUrl\}/g, siteUrl);
  
  const text = `
Confirm your email address

Hi ${displayName}, thanks for signing up for Tutorio! Please confirm your email address by clicking the link below to complete your registration.

Confirm your email: ${data.confirmationUrl}

This link will expire in 24 hours. If you didn't create an account with Tutorio, you can safely ignore this email.

Best regards,
The Tutorio Team
  `.trim();
  
  return {
    html,
    text,
    subject: "Confirm your Tutorio account",
  };
}
