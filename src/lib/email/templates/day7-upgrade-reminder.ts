import { getSiteUrl } from "@/lib/env";
import { 
  baseEmailTemplate, 
  emailHeading, 
  emailParagraph, 
  emailButton,
  emailDivider,
  emailColors,
} from "./base";

export interface Day7UpgradeReminderEmailData {
  userName: string;
  email: string;
  activitiesCompleted: number;
  courseName?: string;
  courseSlug?: string;
  lockedActivitiesCount: number;
}

/**
 * Day 7 upgrade reminder email - encourages free users to subscribe
 * Highlights the value of premium features
 */
export function day7UpgradeReminderEmailTemplate(data: Day7UpgradeReminderEmailData): { 
  html: string; 
  text: string; 
  subject: string;
} {
  const siteUrl = getSiteUrl();
  const displayName = data.userName || "there";
  
  const pricingUrl = data.courseSlug 
    ? `${siteUrl}/pricing?course=${data.courseSlug}` 
    : `${siteUrl}/pricing`;
  
  const dashboardUrl = `${siteUrl}/dashboard`;
  
  const subject = data.activitiesCompleted > 0
    ? `${displayName}, unlock your full learning potential`
    : `${displayName}, ready to take your learning further?`;

  const content = `
    ${emailHeading(`Hey ${displayName}, you're doing great!`)}
    
    ${data.activitiesCompleted > 0 ? emailParagraph(`
      You've already completed <strong>${data.activitiesCompleted} ${data.activitiesCompleted === 1 ? 'activity' : 'activities'}</strong>.
      That's a solid start! But there's so much more waiting for you.
    `) : emailParagraph(`
      You signed up for Tutorio a week ago. Ready to start your learning journey?
    `)}
    
    ${emailDivider()}
    
    <div style="background: linear-gradient(135deg, ${emailColors.accent}15, ${emailColors.accent}08); border-radius: 16px; padding: 28px; margin: 24px 0; border: 1px solid ${emailColors.accent}30;">
      <p style="margin: 0 0 6px 0; font-size: 13px; color: ${emailColors.accent}; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600;">
        Unlock Full Access
      </p>
      <p style="margin: 0 0 16px 0; font-size: 22px; font-weight: 700; color: ${emailColors.text};">
        ${data.lockedActivitiesCount}+ premium activities
      </p>
      
      <table role="presentation" cellpadding="0" cellspacing="0" style="margin-bottom: 20px;">
        <tr>
          <td style="padding: 8px 0;">
            <span style="display: inline-block; width: 24px; height: 24px; background-color: ${emailColors.successLight}; border-radius: 50%; text-align: center; line-height: 24px; margin-right: 12px;">
              <span style="color: ${emailColors.success}; font-size: 14px;">&#10003;</span>
            </span>
            <span style="color: ${emailColors.text}; font-size: 15px;">All course activities & challenges</span>
          </td>
        </tr>
        <tr>
          <td style="padding: 8px 0;">
            <span style="display: inline-block; width: 24px; height: 24px; background-color: ${emailColors.successLight}; border-radius: 50%; text-align: center; line-height: 24px; margin-right: 12px;">
              <span style="color: ${emailColors.success}; font-size: 14px;">&#10003;</span>
            </span>
            <span style="color: ${emailColors.text}; font-size: 15px;">AI tutor with 25 messages/day (or unlimited)</span>
          </td>
        </tr>
        <tr>
          <td style="padding: 8px 0;">
            <span style="display: inline-block; width: 24px; height: 24px; background-color: ${emailColors.successLight}; border-radius: 50%; text-align: center; line-height: 24px; margin-right: 12px;">
              <span style="color: ${emailColors.success}; font-size: 14px;">&#10003;</span>
            </span>
            <span style="color: ${emailColors.text}; font-size: 15px;">Progress tracking & certificates</span>
          </td>
        </tr>
        <tr>
          <td style="padding: 8px 0;">
            <span style="display: inline-block; width: 24px; height: 24px; background-color: ${emailColors.successLight}; border-radius: 50%; text-align: center; line-height: 24px; margin-right: 12px;">
              <span style="color: ${emailColors.success}; font-size: 14px;">&#10003;</span>
            </span>
            <span style="color: ${emailColors.text}; font-size: 15px;">Cancel anytime</span>
          </td>
        </tr>
      </table>
      
      <div style="text-align: center;">
        <p style="margin: 0 0 16px 0; font-size: 28px; font-weight: 700; color: ${emailColors.text};">
          Starting at CHF 8<span style="font-size: 16px; font-weight: 400; color: ${emailColors.textMuted};">/month</span>
        </p>
        <a href="${pricingUrl}" style="display: inline-block; padding: 14px 32px; background-color: ${emailColors.accent}; color: white; text-decoration: none; border-radius: 10px; font-weight: 600; font-size: 16px;">
          View Plans
        </a>
      </div>
    </div>
    
    ${emailDivider()}
    
    ${emailParagraph(`
      Not ready to subscribe yet? No problem! You can still continue with the free demo activities:
    `)}
    
    ${emailButton("Continue Free Demo", dashboardUrl)}
    
    ${emailDivider()}
    
    ${emailParagraph(`
      Questions about our plans? Just reply to this email - we're happy to help.
    `)}
    
    <p style="margin: 28px 0 0 0; font-size: 15px; color: ${emailColors.textMuted};">
      Happy learning,<br/>
      <strong style="color: ${emailColors.text};">The Tutorio Team</strong>
    </p>
  `;
  
  const html = baseEmailTemplate(content, {
    previewText: `Unlock ${data.lockedActivitiesCount}+ premium activities starting at CHF 8/month`,
  }).replace(/\$\{siteUrl\}/g, siteUrl);
  
  const text = `
Hey ${displayName}!

${data.activitiesCompleted > 0 
  ? `You've already completed ${data.activitiesCompleted} ${data.activitiesCompleted === 1 ? 'activity' : 'activities'}. That's a solid start! But there's so much more waiting for you.`
  : `You signed up for Tutorio a week ago. Ready to start your learning journey?`}

---

UNLOCK FULL ACCESS - ${data.lockedActivitiesCount}+ premium activities

What you get:
- All course activities & challenges
- AI tutor with 25 messages/day (or unlimited)
- Progress tracking & certificates
- Cancel anytime

Starting at CHF 8/month

View Plans: ${pricingUrl}

---

Not ready to subscribe yet? No problem! You can still continue with the free demo activities:

Continue Free Demo: ${dashboardUrl}

---

Questions about our plans? Just reply to this email - we're happy to help.

Happy learning,
The Tutorio Team
  `.trim();
  
  return {
    html,
    text,
    subject,
  };
}

