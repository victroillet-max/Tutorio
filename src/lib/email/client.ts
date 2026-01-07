import { Resend } from "resend";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "email/client" });

// Initialize Resend client
const resendApiKey = process.env.RESEND_API_KEY;
const resend = resendApiKey ? new Resend(resendApiKey) : null;

// Email configuration
const FROM_EMAIL = process.env.RESEND_FROM_EMAIL || "onboarding@resend.dev";
const FROM_NAME = process.env.RESEND_FROM_NAME || "Tutorio";

export interface SendEmailOptions {
  to: string | string[];
  subject: string;
  html: string;
  text?: string;
  replyTo?: string;
  tags?: { name: string; value: string }[];
}

export interface SendEmailResult {
  success: boolean;
  id?: string;
  error?: string;
}

/**
 * Send an email using Resend
 */
export async function sendEmail(options: SendEmailOptions): Promise<SendEmailResult> {
  if (!resend) {
    log.warn("Resend not configured - RESEND_API_KEY is missing");
    return { 
      success: false, 
      error: "Email service not configured" 
    };
  }

  try {
    const { data, error } = await resend.emails.send({
      from: `${FROM_NAME} <${FROM_EMAIL}>`,
      to: options.to,
      subject: options.subject,
      html: options.html,
      text: options.text,
      replyTo: options.replyTo,
      tags: options.tags,
    });

    if (error) {
      log.error("Failed to send email", new Error(error.message), {
        to: options.to,
        subject: options.subject,
      });
      return { success: false, error: error.message };
    }

    log.info("Email sent successfully", {
      id: data?.id,
      to: options.to,
      subject: options.subject,
    });

    return { success: true, id: data?.id };
  } catch (err) {
    const errorMessage = err instanceof Error ? err.message : "Unknown error";
    log.error("Email send exception", err, {
      to: options.to,
      subject: options.subject,
    });
    return { success: false, error: errorMessage };
  }
}

/**
 * Check if email service is configured
 */
export function isEmailConfigured(): boolean {
  return !!resend;
}

