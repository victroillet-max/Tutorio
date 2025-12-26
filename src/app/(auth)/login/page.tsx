import Link from "next/link";
import { signIn } from "@/lib/auth/actions";
import { AuthForm, EmailInput, PasswordInput } from "@/components/auth/auth-form";
import { GoogleButton } from "@/components/auth/oauth-buttons";
import { Separator } from "@/components/ui/separator";

export const metadata = {
  title: "Sign In | Tutorio",
  description: "Sign in to your Tutorio account",
};

export default function LoginPage({
  searchParams,
}: {
  searchParams: Promise<{ error?: string; message?: string }>;
}) {
  return (
    <div className="space-y-8">
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

        <div className="relative my-8">
          <Separator className="bg-[var(--border)]" />
          <span className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 bg-white px-4 text-sm text-[var(--foreground-muted)]">
            or
          </span>
        </div>

        {/* Social Login */}
        <div className="space-y-3">
          <GoogleButton />
        </div>
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
