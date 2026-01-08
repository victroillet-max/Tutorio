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

export interface Day3EngagementEmailData {
  userName: string;
  email: string;
  coursesStarted: number;
  activitiesCompleted: number;
  nextSkillName?: string;
  nextSkillSlug?: string;
  courseSlug?: string;
}

/**
 * Day 3 engagement email - encourages users to continue learning
 * and complete their first skill
 */
export function day3EngagementEmailTemplate(data: Day3EngagementEmailData): { 
  html: string; 
  text: string; 
  subject: string;
} {
  const siteUrl = getSiteUrl();
  const displayName = data.userName || "there";
  const hasStarted = data.activitiesCompleted > 0;
  
  // Personalized subject line based on activity
  const subject = hasStarted 
    ? `${displayName}, continue your learning streak!`
    : `${displayName}, ready to start your first lesson?`;
  
  const dashboardUrl = data.courseSlug 
    ? `${siteUrl}/courses/${data.courseSlug}/learn` 
    : `${siteUrl}/dashboard`;
  
  const skillUrl = data.nextSkillSlug 
    ? `${siteUrl}/skills/${data.nextSkillSlug}` 
    : dashboardUrl;

  const content = hasStarted ? `
    ${emailHeading(`Great progress, ${displayName}!`)}
    
    ${emailParagraph(`
      You've completed <strong>${data.activitiesCompleted} ${data.activitiesCompleted === 1 ? 'activity' : 'activities'}</strong> 
      so far. Keep that momentum going!
    `)}
    
    ${data.nextSkillName ? `
      <div style="background-color: ${emailColors.backgroundSecondary}; border-radius: 12px; padding: 20px; margin: 24px 0;">
        <p style="margin: 0 0 8px 0; font-size: 13px; color: ${emailColors.textMuted}; text-transform: uppercase; letter-spacing: 0.5px;">
          Up Next
        </p>
        <p style="margin: 0 0 16px 0; font-size: 18px; font-weight: 600; color: ${emailColors.text};">
          ${data.nextSkillName}
        </p>
        <a href="${skillUrl}" style="display: inline-block; padding: 10px 20px; background-color: ${emailColors.accent}; color: white; text-decoration: none; border-radius: 8px; font-weight: 600; font-size: 14px;">
          Continue Learning
        </a>
      </div>
    ` : emailButton("Continue Learning", dashboardUrl)}
    
    ${emailDivider()}
    
    <p style="margin: 0 0 16px 0; font-size: 16px; font-weight: 600; color: ${emailColors.text};">
      Why keep going?
    </p>
    
    <table role="presentation" cellpadding="0" cellspacing="0" width="100%">
      ${emailFeatureItem("Build Strong Foundations", "Master core concepts before tackling advanced challenges.")}
      ${emailFeatureItem("Track Your Progress", "Watch your mastery grow with each completed skill.")}
      ${emailFeatureItem("Get Help Anytime", "Bob, our AI tutor, is ready to answer your questions 24/7.")}
    </table>
  ` : `
    ${emailHeading(`Hey ${displayName}, ready to begin?`)}
    
    ${emailParagraph(`
      We noticed you haven't started learning yet. No worries - there's no better time than now!
    `)}
    
    ${emailParagraph(`
      Tutorio's courses are designed to take you from zero to confident, one step at a time.
    `)}
    
    ${emailButton("Start Your First Lesson", dashboardUrl)}
    
    ${emailDivider()}
    
    <p style="margin: 0 0 16px 0; font-size: 16px; font-weight: 600; color: ${emailColors.text};">
      What makes Tutorio different?
    </p>
    
    <table role="presentation" cellpadding="0" cellspacing="0" width="100%">
      ${emailFeatureItem("Structured Learning Paths", "Each course is carefully designed to build your skills progressively.")}
      ${emailFeatureItem("Interactive Exercises", "Practice with real coding challenges and quizzes.")}
      ${emailFeatureItem("AI-Powered Help", "Get instant explanations from Bob, your personal AI tutor.")}
    </table>
  `;
  
  const finalContent = content + `
    ${emailDivider()}
    
    ${emailParagraph(`
      Have questions? Just reply to this email - we're here to help.
    `)}
    
    <p style="margin: 28px 0 0 0; font-size: 15px; color: ${emailColors.textMuted};">
      Keep learning,<br/>
      <strong style="color: ${emailColors.text};">The Tutorio Team</strong>
    </p>
  `;
  
  const html = baseEmailTemplate(finalContent, {
    previewText: hasStarted 
      ? `You've completed ${data.activitiesCompleted} activities - keep the momentum going!`
      : `Your learning journey awaits. Start your first lesson today.`,
  }).replace(/\$\{siteUrl\}/g, siteUrl);
  
  const text = hasStarted ? `
Hey ${displayName}!

You've completed ${data.activitiesCompleted} ${data.activitiesCompleted === 1 ? 'activity' : 'activities'} so far. Keep that momentum going!

${data.nextSkillName ? `Up Next: ${data.nextSkillName}` : ''}

Continue Learning: ${dashboardUrl}

Why keep going?

- Build Strong Foundations: Master core concepts before tackling advanced challenges.
- Track Your Progress: Watch your mastery grow with each completed skill.
- Get Help Anytime: Bob, our AI tutor, is ready to answer your questions 24/7.

Have questions? Just reply to this email - we're here to help.

Keep learning,
The Tutorio Team
  `.trim() : `
Hey ${displayName}!

We noticed you haven't started learning yet. No worries - there's no better time than now!

Tutorio's courses are designed to take you from zero to confident, one step at a time.

Start Your First Lesson: ${dashboardUrl}

What makes Tutorio different?

- Structured Learning Paths: Each course is carefully designed to build your skills progressively.
- Interactive Exercises: Practice with real coding challenges and quizzes.
- AI-Powered Help: Get instant explanations from Bob, your personal AI tutor.

Have questions? Just reply to this email - we're here to help.

Keep learning,
The Tutorio Team
  `.trim();
  
  return {
    html,
    text,
    subject,
  };
}

