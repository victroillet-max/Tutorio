import Link from "next/link";
import { signIn } from "@/lib/auth/actions";
import { AuthForm, EmailInput, PasswordInput } from "@/components/auth/auth-form";
import { GoogleButton } from "@/components/auth/oauth-buttons";
import { AlertCircle, LogOut } from "lucide-react";

export const metadata = {
  title: "Sign In | Tutorio",
  description: "Sign in to your Tutorio account",
};

export default async function LoginPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string; message?: string }>;
}) {
  const params = await searchParams;
  const isSessionExpired = params.error === "session_expired";

  return (
    <div className="space-y-8">
      {/* Session expired notice */}
      {isSessionExpired && params.message && (
        <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 flex items-start gap-3">
          <LogOut className="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" />
          <div>
            <p className="text-sm font-medium text-amber-800">
              Session ended
            </p>
            <p className="text-sm text-amber-700 mt-1">
              {decodeURIComponent(params.message)}
            </p>
          </div>
        </div>
      )}

      {/* Other errors */}
      {params.error && !isSessionExpired && (
        <div className="bg-red-50 border border-red-200 rounded-xl p-4 flex items-start gap-3">
          <AlertCircle className="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
          <p className="text-sm text-red-700">
            {decodeURIComponent(params.error)}
          </p>
        </div>
      )}

      {/* Header */}
      <div className="text-center space-y-2">
        <h1 
          className="text-3xl font-bold text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Welcome back
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Sign in to continue your learning journey
        </p>
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
          action={signIn} 
          submitText="Sign In"
          pendingText="Signing in..."
        >
          <EmailInput autoFocus />
          <PasswordInput />
          
          <div className="flex justify-end">
            <Link 
              href="/forgot-password"
              className="text-sm text-[var(--primary)] hover:text-[var(--primary-dark)] transition-colors"
            >
              Forgot password?
            </Link>
          </div>
        </AuthForm>
      </div>

      {/* Footer */}
      <p className="text-center text-sm text-[var(--foreground-muted)]">
        Don&apos;t have an account?{" "}
        <Link 
          href="/signup"
          className="text-[var(--primary)] hover:text-[var(--primary-dark)] font-medium transition-colors"
        >
          Sign up
        </Link>
      </p>
    </div>
  );
}
