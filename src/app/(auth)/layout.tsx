import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import Link from "next/link";
import Image from "next/image";

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
    <div className="min-h-screen flex flex-col bg-[var(--background)]">
      {/* Header */}
      <header className="p-6">
        <Link href="/" className="inline-flex items-center gap-3 group">
          <Image 
            src="/logo-cropped.svg" 
            alt="Tutorio" 
            width={44}
            height={44}
            className="transition-transform duration-300 group-hover:rotate-[-5deg] group-hover:scale-105"
          />
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
        {/* Top right gradient */}
        <div className="absolute top-[-20%] right-[-10%] w-[50%] h-[100%] bg-gradient-to-br from-[var(--primary)]/5 via-[var(--primary-light)]/3 to-[var(--accent)]/5 rounded-[0_0_0_40%]" />
        {/* Bottom left circle */}
        <div className="absolute bottom-[10%] left-[-10%] w-[400px] h-[400px] bg-[var(--accent)]/5 rounded-full blur-[80px]" />
        {/* Center circle */}
        <div className="absolute top-[40%] right-[20%] w-[300px] h-[300px] bg-[var(--primary)]/4 rounded-full blur-[60px]" />
      </div>
    </div>
  );
}
