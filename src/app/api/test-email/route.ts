import { NextRequest, NextResponse } from "next/server";
import { sendEmail, isEmailConfigured } from "@/lib/email";
import { welcomeEmailTemplate } from "@/lib/email/templates/welcome";

/**
 * Test endpoint for verifying email configuration
 * DELETE THIS FILE before deploying to production!
 * 
 * Usage: POST /api/test-email
 * Body: { "to": "your-email@example.com" }
 */
export async function POST(request: NextRequest) {
  // Only allow in development
  if (process.env.NODE_ENV === "production") {
    return NextResponse.json(
      { error: "Test endpoint disabled in production" },
      { status: 403 }
    );
  }

  if (!isEmailConfigured()) {
    return NextResponse.json(
      { error: "Email not configured. Check RESEND_API_KEY in .env.local" },
      { status: 500 }
    );
  }

  try {
    const body = await request.json();
    const { to } = body;

    if (!to) {
      return NextResponse.json(
        { error: "Missing 'to' email address in request body" },
        { status: 400 }
      );
    }

    // Generate a test welcome email
    const template = welcomeEmailTemplate({
      userName: "Test User",
      email: to,
    });

    const result = await sendEmail({
      to,
      subject: `[TEST] ${template.subject}`,
      html: template.html,
      text: template.text,
    });

    if (result.success) {
      return NextResponse.json({
        success: true,
        message: `Test email sent to ${to}`,
        emailId: result.id,
      });
    } else {
      return NextResponse.json(
        { error: result.error },
        { status: 500 }
      );
    }
  } catch (error) {
    return NextResponse.json(
      { error: error instanceof Error ? error.message : "Unknown error" },
      { status: 500 }
    );
  }
}

export async function GET() {
  return NextResponse.json({
    configured: isEmailConfigured(),
    message: isEmailConfigured() 
      ? "Email is configured. Send a POST request with { \"to\": \"your-email@example.com\" } to test."
      : "Email not configured. Add RESEND_API_KEY to .env.local",
  });
}

