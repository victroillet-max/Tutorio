/**
 * Base email template styles and layout
 * Matches Tutorio's "Swiss Premium" design system
 */

export const emailColors = {
  // Primary - Navy Blue
  primary: "#1e3a5f",
  primaryLight: "#2d5a8b",
  primaryDark: "#152a45",
  
  // Accent - Warm Coral/Orange
  accent: "#e76f51",
  accentLight: "#f4a261",
  accentDark: "#d35836",
  
  // Backgrounds - Warm Light
  background: "#faf9f7",
  backgroundSecondary: "#f5f3ef",
  card: "#ffffff",
  cardBorder: "#e8e5df",
  
  // Text
  text: "#1a1a2e",
  textMuted: "#5a5a6e",
  textSubtle: "#8a8a9e",
  
  // Status colors
  success: "#2a9d8f",
  successLight: "#d4ede9",
  warning: "#e9c46a",
  warningLight: "#fef3c7",
  error: "#ef4444",
};

export const emailStyles = {
  fontFamily: "'DM Sans', 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif",
  fontHeading: "'Space Grotesk', 'Segoe UI', Roboto, sans-serif",
};

/**
 * Wrap email content in a consistent base template
 */
export function baseEmailTemplate(content: string, options?: { 
  previewText?: string;
  showFooter?: boolean;
}): string {
  const { previewText = "", showFooter = true } = options || {};
  
  return `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Tutorio</title>
  <!--[if mso]>
  <noscript>
    <xml>
      <o:OfficeDocumentSettings>
        <o:PixelsPerInch>96</o:PixelsPerInch>
      </o:OfficeDocumentSettings>
    </xml>
  </noscript>
  <![endif]-->
  <style>
    @media only screen and (max-width: 600px) {
      .container { width: 100% !important; padding: 16px !important; }
      .content { padding: 32px 24px !important; }
      .button { padding: 14px 24px !important; }
    }
  </style>
</head>
<body style="margin: 0; padding: 0; background-color: ${emailColors.background}; font-family: ${emailStyles.fontFamily};">
  ${previewText ? `<div style="display: none; max-height: 0; overflow: hidden;">${previewText}</div>` : ""}
  
  <table role="presentation" cellpadding="0" cellspacing="0" width="100%" style="background-color: ${emailColors.background};">
    <tr>
      <td align="center" style="padding: 48px 20px;">
        <table role="presentation" cellpadding="0" cellspacing="0" width="100%" class="container" style="max-width: 560px;">
          
          <!-- Logo -->
          <tr>
            <td align="center" style="padding-bottom: 32px;">
              <div style="font-size: 28px; font-weight: 700; color: ${emailColors.primary}; letter-spacing: -0.5px; font-family: ${emailStyles.fontHeading};">
                <span style="color: ${emailColors.accent};">T</span>utorio
              </div>
            </td>
          </tr>
          
          <!-- Main Content Card -->
          <tr>
            <td>
              <table role="presentation" cellpadding="0" cellspacing="0" width="100%" style="background-color: ${emailColors.card}; border-radius: 16px; border: 1px solid ${emailColors.cardBorder}; box-shadow: 0 1px 3px rgba(30, 58, 95, 0.06), 0 1px 2px rgba(30, 58, 95, 0.04);">
                <tr>
                  <td class="content" style="padding: 48px 40px;">
                    ${content}
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          
          ${showFooter ? `
          <!-- Footer -->
          <tr>
            <td style="padding-top: 32px; text-align: center;">
              <p style="margin: 0 0 12px 0; font-size: 13px; color: ${emailColors.textMuted};">
                Tutorio - Your path to exam success
              </p>
              <p style="margin: 0; font-size: 12px; color: ${emailColors.textSubtle};">
                <a href="\${siteUrl}/terms" style="color: ${emailColors.textSubtle}; text-decoration: underline;">Terms</a>
                &nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="\${siteUrl}/privacy" style="color: ${emailColors.textSubtle}; text-decoration: underline;">Privacy</a>
                &nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="\${siteUrl}/contact" style="color: ${emailColors.textSubtle}; text-decoration: underline;">Contact</a>
              </p>
            </td>
          </tr>
          ` : ""}
          
        </table>
      </td>
    </tr>
  </table>
</body>
</html>
  `.trim();
}

/**
 * Create a styled button - Coral/Orange accent color
 */
export function emailButton(text: string, href: string, variant: "primary" | "secondary" = "primary"): string {
  const bgColor = variant === "primary" ? emailColors.accent : "transparent";
  const textColor = variant === "primary" ? "#ffffff" : emailColors.accent;
  const border = variant === "primary" ? "none" : `2px solid ${emailColors.accent}`;
  
  return `
    <table role="presentation" cellpadding="0" cellspacing="0" style="margin: 28px 0;">
      <tr>
        <td align="center" style="border-radius: 10px; background-color: ${bgColor}; border: ${border};">
          <a href="${href}" target="_blank" class="button" style="display: inline-block; padding: 16px 36px; font-size: 15px; font-weight: 600; color: ${textColor}; text-decoration: none; border-radius: 10px; font-family: ${emailStyles.fontFamily};">
            ${text}
          </a>
        </td>
      </tr>
    </table>
  `;
}

/**
 * Create a heading
 */
export function emailHeading(text: string, level: 1 | 2 | 3 = 1): string {
  const sizes = { 1: "26px", 2: "20px", 3: "17px" };
  const margins = { 1: "0 0 20px 0", 2: "28px 0 14px 0", 3: "20px 0 10px 0" };
  
  return `<h${level} style="margin: ${margins[level]}; font-size: ${sizes[level]}; font-weight: 700; color: ${emailColors.text}; line-height: 1.3; font-family: ${emailStyles.fontHeading};">${text}</h${level}>`;
}

/**
 * Create a paragraph
 */
export function emailParagraph(text: string): string {
  return `<p style="margin: 0 0 18px 0; font-size: 15px; line-height: 1.7; color: ${emailColors.textMuted};">${text}</p>`;
}

/**
 * Create a divider
 */
export function emailDivider(): string {
  return `<hr style="margin: 28px 0; border: none; border-top: 1px solid ${emailColors.cardBorder};" />`;
}

/**
 * Create an info box
 */
export function emailInfoBox(content: string, variant: "info" | "success" | "warning" = "info"): string {
  const colors = {
    info: { bg: "#f0f4f8", border: emailColors.primary, text: emailColors.primary },
    success: { bg: emailColors.successLight, border: emailColors.success, text: emailColors.success },
    warning: { bg: emailColors.warningLight, border: emailColors.warning, text: "#92650a" },
  };
  const style = colors[variant];
  
  return `
    <div style="margin: 24px 0; padding: 18px 20px; background-color: ${style.bg}; border-left: 4px solid ${style.border}; border-radius: 0 10px 10px 0;">
      <p style="margin: 0; font-size: 14px; line-height: 1.6; color: ${style.text};">${content}</p>
    </div>
  `;
}

/**
 * Create a feature list item with coral bullet
 */
export function emailFeatureItem(title: string, description: string): string {
  return `
    <tr>
      <td style="padding: 14px 0;">
        <p style="margin: 0 0 4px 0; font-size: 15px; font-weight: 600; color: ${emailColors.text};">
          <span style="color: ${emailColors.accent}; margin-right: 8px;">&#9679;</span>${title}
        </p>
        <p style="margin: 0; padding-left: 20px; font-size: 14px; color: ${emailColors.textMuted};">${description}</p>
      </td>
    </tr>
  `;
}
