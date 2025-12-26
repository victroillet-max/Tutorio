"use client";

import { useState } from "react";
import { useFormStatus } from "react-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Loader2, AlertCircle, CheckCircle2, Eye, EyeOff } from "lucide-react";
import type { AuthActionResult } from "@/lib/auth/actions";

interface AuthFormProps {
  action: (formData: FormData) => Promise<AuthActionResult>;
  children: React.ReactNode;
  submitText: string;
  pendingText?: string;
}

function SubmitButton({ text, pendingText }: { text: string; pendingText?: string }) {
  const { pending } = useFormStatus();

  return (
    <Button 
      type="submit" 
      className="w-full h-12 bg-[var(--primary)] text-white font-semibold hover:bg-[var(--primary-dark)] transition-colors shadow-md shadow-[var(--primary)]/25"
      disabled={pending}
    >
      {pending ? (
        <>
          <Loader2 className="mr-2 h-4 w-4 animate-spin" />
          {pendingText || "Please wait..."}
        </>
      ) : (
        text
      )}
    </Button>
  );
}

export function AuthForm({ action, children, submitText, pendingText }: AuthFormProps) {
  const [result, setResult] = useState<AuthActionResult | null>(null);

  async function handleAction(formData: FormData) {
    setResult(null);
    const response = await action(formData);
    setResult(response);
  }

  return (
    <form action={handleAction} className="space-y-6">
      {result?.error && (
        <Alert variant="destructive" className="bg-red-50 border-red-200 text-red-700">
          <AlertCircle className="h-4 w-4" />
          <AlertDescription>{result.error}</AlertDescription>
        </Alert>
      )}

      {result?.success && result.message && (
        <Alert className="bg-emerald-50 border-emerald-200 text-emerald-700">
          <CheckCircle2 className="h-4 w-4" />
          <AlertDescription>{result.message}</AlertDescription>
        </Alert>
      )}

      {children}

      <SubmitButton text={submitText} pendingText={pendingText} />
    </form>
  );
}

interface EmailInputProps {
  autoFocus?: boolean;
}

export function EmailInput({ autoFocus = false }: EmailInputProps) {
  return (
    <div className="space-y-2">
      <Label htmlFor="email" className="text-sm font-medium text-[var(--foreground)]">
        Email
      </Label>
      <Input
        id="email"
        name="email"
        type="email"
        placeholder="you@example.com"
        required
        autoFocus={autoFocus}
        autoComplete="email"
        className="h-12 bg-white border-[var(--border)] focus:border-[var(--primary)] focus:ring-[var(--primary)]/20"
      />
    </div>
  );
}

interface PasswordInputProps {
  name?: string;
  label?: string;
  placeholder?: string;
  autoComplete?: string;
  showStrengthIndicator?: boolean;
}

export function PasswordInput({
  name = "password",
  label = "Password",
  placeholder = "Enter your password",
  autoComplete = "current-password",
  showStrengthIndicator = false,
}: PasswordInputProps) {
  const [showPassword, setShowPassword] = useState(false);
  const [password, setPassword] = useState("");

  const getPasswordStrength = (pwd: string) => {
    if (pwd.length === 0) return { level: 0, text: "" };
    if (pwd.length < 8) return { level: 1, text: "Too short" };
    
    let strength = 0;
    if (pwd.length >= 8) strength++;
    if (pwd.length >= 12) strength++;
    if (/[a-z]/.test(pwd) && /[A-Z]/.test(pwd)) strength++;
    if (/[0-9]/.test(pwd)) strength++;
    if (/[^a-zA-Z0-9]/.test(pwd)) strength++;

    if (strength <= 2) return { level: 1, text: "Weak" };
    if (strength <= 3) return { level: 2, text: "Medium" };
    return { level: 3, text: "Strong" };
  };

  const strength = getPasswordStrength(password);

  return (
    <div className="space-y-2">
      <Label htmlFor={name} className="text-sm font-medium text-[var(--foreground)]">
        {label}
      </Label>
      <div className="relative">
        <Input
          id={name}
          name={name}
          type={showPassword ? "text" : "password"}
          placeholder={placeholder}
          required
          minLength={8}
          autoComplete={autoComplete}
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          className="h-12 pr-12 bg-white border-[var(--border)] focus:border-[var(--primary)] focus:ring-[var(--primary)]/20"
        />
        <button
          type="button"
          onClick={() => setShowPassword(!showPassword)}
          className="absolute right-3 top-1/2 -translate-y-1/2 text-[var(--foreground-muted)] hover:text-[var(--foreground)] transition-colors"
        >
          {showPassword ? <EyeOff className="h-5 w-5" /> : <Eye className="h-5 w-5" />}
        </button>
      </div>
      
      {showStrengthIndicator && password.length > 0 && (
        <div className="space-y-1">
          <div className="flex gap-1">
            {[1, 2, 3].map((level) => (
              <div
                key={level}
                className={`h-1 flex-1 rounded-full transition-colors ${
                  strength.level >= level
                    ? level === 1
                      ? "bg-red-500"
                      : level === 2
                      ? "bg-amber-500"
                      : "bg-emerald-500"
                    : "bg-[var(--border)]"
                }`}
              />
            ))}
          </div>
          <p className={`text-xs ${
            strength.level === 1 ? "text-red-600" : 
            strength.level === 2 ? "text-amber-600" : 
            strength.level === 3 ? "text-emerald-600" : 
            "text-[var(--foreground-muted)]"
          }`}>
            {strength.text}
          </p>
        </div>
      )}
    </div>
  );
}

interface FullNameInputProps {
  required?: boolean;
}

export function FullNameInput({ required = false }: FullNameInputProps) {
  return (
    <div className="space-y-2">
      <Label htmlFor="fullName" className="text-sm font-medium text-[var(--foreground)]">
        Full Name {!required && <span className="text-[var(--foreground-muted)]">(optional)</span>}
      </Label>
      <Input
        id="fullName"
        name="fullName"
        type="text"
        placeholder="John Doe"
        required={required}
        autoComplete="name"
        className="h-12 bg-white border-[var(--border)] focus:border-[var(--primary)] focus:ring-[var(--primary)]/20"
      />
    </div>
  );
}
