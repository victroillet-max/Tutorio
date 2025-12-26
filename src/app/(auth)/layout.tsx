import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import Link from "next/link";
import { BookOpen } from "lucide-react";

/**
 * Auth layout - wraps login, signup, forgot-password, reset-password
 * Redirects authenticated users away from auth pages
 */
export default async function AuthLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // If user is already authenticated, redirect to dashboard
  if (user) {
    redirect("/dashboard");
  }

  return (
    <div className="min-h-screen flex flex-col bg-gradient-to-b from-white to-[var(--background-secondary)]">
      {/* Header */}
      <header className="p-6">
        <Link href="/" className="inline-flex items-center gap-2 group">
          <div className="w-10 h-10 rounded-xl bg-[var(--primary)] flex items-center justify-center transition-transform group-hover:scale-105 shadow-md shadow-[var(--primary)]/25">
            <BookOpen className="w-5 h-5 text-white" />
          </div>
          <span 
            className="text-xl font-bold tracking-tight text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Tutorio
          </span>
        </Link>
      </header>

      {/* Main content */}
      <main className="flex-1 flex items-center justify-center px-4 py-12">
        <div className="w-full max-w-md">
          {children}
        </div>
      </main>

      {/* Background decoration */}
      <div className="fixed inset-0 -z-10 overflow-hidden pointer-events-none">
        <div className="absolute top-1/4 -left-32 w-96 h-96 bg-[var(--primary)]/5 rounded-full blur-3xl" />
        <div className="absolute bottom-1/4 -right-32 w-80 h-80 bg-[var(--primary)]/10 rounded-full blur-3xl" />
      </div>
    </div>
  );
}
