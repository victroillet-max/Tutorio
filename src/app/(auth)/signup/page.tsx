import Link from "next/link";
import { signUp } from "@/lib/auth/actions";
import { AuthForm, EmailInput, PasswordInput, FullNameInput } from "@/components/auth/auth-form";
import { GoogleButton } from "@/components/auth/oauth-buttons";
import { CheckCircle2 } from "lucide-react";

export const metadata = {
  title: "Sign Up | Tutorio",
  description: "Create your Tutorio account and start learning",
};

const benefits = [
  "Access to free course previews",
  "Track your learning progress",
  "AI-structured study materials",
  "Join 5,000+ successful students",
];

export default function SignupPage() {
  return (
    <div className="space-y-8">
      {/* Header */}
      <div className="text-center space-y-2">
        <h1 
          className="text-3xl font-bold text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Create your account
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Start your journey to exam success
        </p>
      </div>

      {/* Benefits */}
      <div className="grid grid-cols-2 gap-3">
        {benefits.map((benefit) => (
          <div 
            key={benefit}
            className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]"
          >
            <CheckCircle2 className="w-4 h-4 text-emerald-500 flex-shrink-0" />
            <span>{benefit}</span>
          </div>
        ))}
      </div>

      {/* Form Card */}
      <div className="card-elevated p-8">
        {/* Google OAuth */}
        <GoogleButton />

        {/* Divider */}
        <div className="relative my-6">
          <div className="absolute inset-0 flex items-center">
            <div className="w-full border-t border-[var(--border)]" />
          </div>
          <div className="relative flex justify-center text-sm">
            <span className="px-4 bg-white text-[var(--foreground-muted)]">or</span>
          </div>
        </div>

        <AuthForm 
          action={signUp} 
          submitText="Create Account"
          pendingText="Creating account..."
        >
          <FullNameInput />
          <EmailInput />
          <PasswordInput 
            autoComplete="new-password"
            placeholder="Create a password (min. 8 characters)"
            showStrengthIndicator
          />
        </AuthForm>

        {/* Terms */}
        <p className="mt-6 text-xs text-center text-[var(--foreground-muted)]">
          By creating an account, you agree to our{" "}
          <Link href="/terms" className="text-[var(--primary)] hover:underline">
            Terms of Service
          </Link>{" "}
          and{" "}
          <Link href="/privacy" className="text-[var(--primary)] hover:underline">
            Privacy Policy
          </Link>
        </p>
      </div>

      {/* Footer */}
      <p className="text-center text-sm text-[var(--foreground-muted)]">
        Already have an account?{" "}
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
