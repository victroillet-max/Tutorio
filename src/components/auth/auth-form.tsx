"use client";

import { useState, useEffect } from "react";
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

// Context to share preserved email between AuthForm and EmailInput
import { createContext, useContext } from "react";
const PreservedEmailContext = createContext<string | undefined>(undefined);
export const usePreservedEmail = () => useContext(PreservedEmailContext);

function SubmitButton({ text, pendingText }: { text: string; pendingText?: string }) {
  const { pending } = useFormStatus();

  return (
    <Button 
      type="submit" 
      className="w-full"
      variant="accent"
      size="lg"
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

  // Preserve email from error response for better UX
  const preservedEmail = result?.error ? result.email : undefined;

  return (
    <PreservedEmailContext.Provider value={preservedEmail}>
      <form action={handleAction} className="space-y-6">
        {result?.error && (
          <Alert variant="destructive" className="bg-red-50 border-red-200 text-red-700">
            <AlertCircle className="h-4 w-4" />
            <AlertDescription>{result.error}</AlertDescription>
          </Alert>
        )}

        {result?.success && result.message && (
          <Alert className="bg-[var(--success-light)] border-[var(--success)]/30 text-[var(--success)]">
            <CheckCircle2 className="h-4 w-4" />
            <AlertDescription>{result.message}</AlertDescription>
          </Alert>
        )}

        {children}

        <SubmitButton text={submitText} pendingText={pendingText} />
      </form>
    </PreservedEmailContext.Provider>
  );
}

interface EmailInputProps {
  autoFocus?: boolean;
  defaultValue?: string;
}

export function EmailInput({ autoFocus = false, defaultValue = "" }: EmailInputProps) {
  // Use preserved email from context if available (for error recovery)
  const preservedEmail = usePreservedEmail();
  const [email, setEmail] = useState(defaultValue);
  const [error, setError] = useState("");
  const [touched, setTouched] = useState(false);
  
  // Update email when preserved email changes (after form error)
  useEffect(() => {
    if (preservedEmail) {
      setEmail(preservedEmail);
    }
  }, [preservedEmail]);
  
  const validateEmail = (value: string) => {
    if (!value) {
      return "Email is required";
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
      return "Please enter a valid email address";
    }
    return "";
  };
  
  const handleBlur = () => {
    setTouched(true);
    setError(validateEmail(email));
  };
  
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = e.target.value;
    setEmail(value);
    // Only validate on change if already touched
    if (touched) {
      setError(validateEmail(value));
    }
  };
  
  return (
    <div className="space-y-2">
      <Label htmlFor="email" className="text-sm font-semibold text-[var(--foreground)]">
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
        value={email}
        onChange={handleChange}
        onBlur={handleBlur}
        className={`h-12 bg-white border-[var(--card-border)] focus:border-[var(--primary)] focus:ring-[var(--primary)]/20 rounded-xl ${
          error && touched ? "border-red-500 focus:border-red-500 focus:ring-red-500/20" : ""
        }`}
      />
      {error && touched && (
        <p className="text-sm text-red-500 flex items-center gap-1.5">
          <AlertCircle className="w-3.5 h-3.5" />
          {error}
        </p>
      )}
    </div>
  );
}

interface PasswordInputProps {
  name?: string;
  label?: string;
  placeholder?: string;
  autoComplete?: string;
  showStrengthIndicator?: boolean;
  minLength?: number;
}

export function PasswordInput({
  name = "password",
  label = "Password",
  placeholder = "Enter your password",
  autoComplete = "current-password",
  showStrengthIndicator = false,
  minLength = 8,
}: PasswordInputProps) {
  const [showPassword, setShowPassword] = useState(false);
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [touched, setTouched] = useState(false);

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
  
  const validatePassword = (value: string) => {
    if (!value) {
      return "Password is required";
    }
    if (value.length < minLength) {
      return `Password must be at least ${minLength} characters`;
    }
    return "";
  };
  
  const handleBlur = () => {
    setTouched(true);
    setError(validatePassword(password));
  };
  
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = e.target.value;
    setPassword(value);
    // Only validate on change if already touched
    if (touched) {
      setError(validatePassword(value));
    }
  };

  const strength = getPasswordStrength(password);
  const hasError = error && touched;

  return (
    <div className="space-y-2">
      <Label htmlFor={name} className="text-sm font-semibold text-[var(--foreground)]">
        {label}
      </Label>
      <div className="relative">
        <Input
          id={name}
          name={name}
          type={showPassword ? "text" : "password"}
          placeholder={placeholder}
          required
          minLength={minLength}
          autoComplete={autoComplete}
          value={password}
          onChange={handleChange}
          onBlur={handleBlur}
          className={`h-12 pr-12 bg-white border-[var(--card-border)] focus:border-[var(--primary)] focus:ring-[var(--primary)]/20 rounded-xl ${
            hasError ? "border-red-500 focus:border-red-500 focus:ring-red-500/20" : ""
          }`}
        />
        <button
          type="button"
          onClick={() => setShowPassword(!showPassword)}
          className="absolute right-4 top-1/2 -translate-y-1/2 text-[var(--foreground-muted)] hover:text-[var(--foreground)] transition-colors"
        >
          {showPassword ? <EyeOff className="h-5 w-5" /> : <Eye className="h-5 w-5" />}
        </button>
      </div>
      
      {hasError && (
        <p className="text-sm text-red-500 flex items-center gap-1.5">
          <AlertCircle className="w-3.5 h-3.5" />
          {error}
        </p>
      )}
      
      {showStrengthIndicator && password.length > 0 && !hasError && (
        <div className="space-y-1.5">
          <div className="flex gap-1">
            {[1, 2, 3].map((level) => (
              <div
                key={level}
                className={`h-1.5 flex-1 rounded-full transition-colors ${
                  strength.level >= level
                    ? level === 1
                      ? "bg-red-500"
                      : level === 2
                      ? "bg-amber-500"
                      : "bg-[var(--success)]"
                    : "bg-[var(--card-border)]"
                }`}
              />
            ))}
          </div>
          <p className={`text-xs font-medium ${
            strength.level === 1 ? "text-red-600" : 
            strength.level === 2 ? "text-amber-600" : 
            strength.level === 3 ? "text-[var(--success)]" : 
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
      <Label htmlFor="fullName" className="text-sm font-semibold text-[var(--foreground)]">
        Full Name {!required && <span className="text-[var(--foreground-muted)] font-normal">(optional)</span>}
      </Label>
      <Input
        id="fullName"
        name="fullName"
        type="text"
        placeholder="John Doe"
        required={required}
        autoComplete="name"
        className="h-12 bg-white border-[var(--card-border)] focus:border-[var(--primary)] focus:ring-[var(--primary)]/20 rounded-xl"
      />
    </div>
  );
}
