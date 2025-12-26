import Link from "next/link";
import { forgotPassword } from "@/lib/auth/actions";
import { AuthForm, EmailInput } from "@/components/auth/auth-form";
import { ArrowLeft, Mail } from "lucide-react";

export const metadata = {
  title: "Forgot Password | Tutorio",
  description: "Reset your Tutorio account password",
};

export default function ForgotPasswordPage() {
  return (
    <div className="space-y-8">
      {/* Back Link */}
      <Link 
        href="/login"
        className="inline-flex items-center gap-2 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors"
      >
        <ArrowLeft className="w-4 h-4" />
        Back to login
      </Link>

      {/* Header */}
      <div className="space-y-2">
        <div className="w-14 h-14 rounded-2xl bg-[var(--progress-bg)] flex items-center justify-center mb-4">
          <Mail className="w-7 h-7 text-[var(--primary)]" />
        </div>
        <h1 
          className="text-3xl font-bold text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Forgot your password?
        </h1>
        <p className="text-[var(--foreground-muted)]">
          No worries! Enter your email and we&apos;ll send you a reset link.
        </p>
      </div>

      {/* Form Card */}
      <div className="card-elevated p-8">
        <AuthForm 
          action={forgotPassword} 
          submitText="Send Reset Link"
          pendingText="Sending..."
        >
          <EmailInput autoFocus />
        </AuthForm>
      </div>

      {/* Help Text */}
      <p className="text-center text-sm text-[var(--foreground-muted)]">
        Remember your password?{" "}
        <Link 
          href="/login"
          className="text-[var(--primary)] hover:text-[var(--primary-dark)] font-medium transition-colors"
        >
          Sign in
        </Link>
      </p>
    </div>
  );
}
