import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import { resetPassword } from "@/lib/auth/actions";
import { AuthForm, PasswordInput } from "@/components/auth/auth-form";
import { KeyRound } from "lucide-react";

export const metadata = {
  title: "Reset Password | Tutorio",
  description: "Create a new password for your Tutorio account",
};

export default async function ResetPasswordPage() {
  // User must be authenticated via the password reset flow
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // If no user (they haven't clicked the reset link), redirect to forgot-password
  if (!user) {
    redirect("/forgot-password");
  }

  return (
    <div className="space-y-8">
      {/* Header */}
      <div className="space-y-2">
        <div className="w-14 h-14 rounded-2xl bg-[var(--progress-bg)] flex items-center justify-center mb-4">
          <KeyRound className="w-7 h-7 text-[var(--primary)]" />
        </div>
        <h1 
          className="text-3xl font-bold text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Create new password
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Your new password must be at least 8 characters long.
        </p>
      </div>

      {/* Form Card */}
      <div className="card-elevated p-8">
        <AuthForm 
          action={resetPassword} 
          submitText="Reset Password"
          pendingText="Updating..."
        >
          <PasswordInput 
            name="password"
            label="New Password"
            placeholder="Enter new password"
            autoComplete="new-password"
            showStrengthIndicator
          />
          <PasswordInput 
            name="confirmPassword"
            label="Confirm Password"
            placeholder="Confirm new password"
            autoComplete="new-password"
          />
        </AuthForm>
      </div>
    </div>
  );
}
