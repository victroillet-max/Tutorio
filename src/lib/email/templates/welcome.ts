import { getSiteUrl } from "@/lib/env";
import { 
  baseEmailTemplate, 
  emailHeading, 
  emailParagraph, 
  emailButton,
  emailDivider,
  emailColors,
  emailFeatureItem,
} from "./base";

export interface WelcomeEmailData {
  userName: string;
  email: string;
}

/**
 * Welcome email sent after user confirms their account
 */
export function welcomeEmailTemplate(data: WelcomeEmailData): { html: string; text: string; subject: string } {
  const siteUrl = getSiteUrl();
  const displayName = data.userName || "there";
  
  const content = `
    ${emailHeading(`Welcome to Tutorio, ${displayName}!`)}
    
    ${emailParagraph(`
      We're thrilled to have you on board. Tutorio is designed to help you master exam preparation 
      with AI-structured learning paths, interactive exercises, and personalized guidance.
    `)}
    
    ${emailButton("Go to Dashboard", `${siteUrl}/dashboard`)}
    
    ${emailDivider()}
    
    <p style="margin: 0 0 16px 0; font-size: 16px; font-weight: 600; color: ${emailColors.text};">
      Here's what you can do:
    </p>
    
    <table role="presentation" cellpadding="0" cellspacing="0" width="100%">
      ${emailFeatureItem("Explore Courses", "Browse our catalog and find the perfect course for your goals.")}
      ${emailFeatureItem("Track Your Progress", "Your dashboard shows your learning journey and achievements.")}
      ${emailFeatureItem("Get AI Assistance", "Our AI tutor Bob is always ready to help you understand concepts.")}
    </table>
    
    ${emailDivider()}
    
    ${emailParagraph(`
      If you have any questions, just reply to this email or visit our 
      <a href="${siteUrl}/contact" style="color: ${emailColors.accent}; text-decoration: none; font-weight: 500;">contact page</a>.
    `)}
    
    <p style="margin: 28px 0 0 0; font-size: 15px; color: ${emailColors.textMuted};">
      Happy learning,<br/>
      <strong style="color: ${emailColors.text};">The Tutorio Team</strong>
    </p>
  `;
  
  const html = baseEmailTemplate(content, {
    previewText: `Welcome to Tutorio! Start your learning journey today.`,
  }).replace(/\$\{siteUrl\}/g, siteUrl);
  
  const text = `
Welcome to Tutorio, ${displayName}!

We're thrilled to have you on board. Tutorio is designed to help you master exam preparation with AI-structured learning paths, interactive exercises, and personalized guidance.

Get started: ${siteUrl}/dashboard

Here's what you can do:

- Explore Courses: Browse our catalog and find the perfect course for your goals.
- Track Your Progress: Your dashboard shows your learning journey and achievements.
- Get AI Assistance: Our AI tutor Bob is always ready to help you understand concepts.

If you have any questions, just reply to this email or visit our contact page at ${siteUrl}/contact.

Happy learning,
The Tutorio Team
  `.trim();
  
  return {
    html,
    text,
    subject: `Welcome to Tutorio, ${displayName}!`,
  };
}
