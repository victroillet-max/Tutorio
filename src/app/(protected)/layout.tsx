import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import Link from "next/link";
import { 
  BookOpen, 
  Home, 
  GraduationCap, 
  User, 
  Settings, 
  LogOut,
  ChevronDown,
  CreditCard
} from "lucide-react";
import { signOut } from "@/lib/auth/actions";
import { ChatWrapper } from "@/components/chat";
import { OnboardingTour } from "@/components/onboarding";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

/**
 * Protected layout - wraps all authenticated routes
 * Handles session verification and provides consistent navigation
 */
export default async function ProtectedLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // Double-check authentication (middleware should handle this, but safety first)
  if (!user) {
    redirect("/login");
  }

  // Get user profile
  const { data: profile } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", user.id)
    .single();

  const displayName = profile?.full_name || user.email?.split("@")[0] || "User";
  const initials = displayName
    .split(" ")
    .map((n: string) => n[0])
    .join("")
    .toUpperCase()
    .slice(0, 2);

  return (
    <div className="min-h-screen bg-[var(--background-secondary)]">
      {/* Top Navigation */}
      <nav className="fixed top-0 left-0 right-0 z-50 h-16 bg-white/95 backdrop-blur-xl border-b border-[var(--card-border)] shadow-sm">
        <div className="max-w-7xl mx-auto h-full px-4 sm:px-6 lg:px-8 flex items-center justify-between">
          {/* Logo */}
          <Link href="/dashboard" className="flex items-center gap-3 group">
            <div className="w-10 h-10 rounded-xl bg-[var(--primary)] flex items-center justify-center transition-transform group-hover:rotate-[-5deg] group-hover:scale-105">
              <BookOpen className="w-5 h-5 text-white" />
            </div>
            <span 
              className="text-lg font-bold tracking-tight text-[var(--foreground)] hidden sm:block"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Tutorio
            </span>
          </Link>

          {/* Center Nav Links */}
          <div className="hidden md:flex items-center gap-1">
            <NavLink href="/dashboard" icon={Home}>
              Dashboard
            </NavLink>
            <NavLink href="/courses" icon={GraduationCap}>
              My Courses
            </NavLink>
          </div>

          {/* User Menu - Accessible Click-based Dropdown */}
          <div className="flex items-center gap-4">
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <button className="flex items-center gap-2.5 p-2 rounded-xl hover:bg-[var(--background-secondary)] transition-colors focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:ring-offset-2">
                  <div className="w-9 h-9 rounded-full bg-gradient-to-br from-[var(--primary)] to-[var(--primary-light)] flex items-center justify-center text-white text-sm font-semibold">
                    {initials}
                  </div>
                  <span className="hidden sm:block text-sm font-medium text-[var(--foreground)] max-w-[120px] truncate">
                    {displayName}
                  </span>
                  <ChevronDown className="w-4 h-4 text-[var(--foreground-muted)]" />
                </button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-56">
                <DropdownMenuLabel className="font-normal">
                  <div className="flex flex-col space-y-1">
                    <p className="text-sm font-medium text-[var(--foreground)] truncate">{displayName}</p>
                    <p className="text-xs text-[var(--foreground-muted)] truncate">{user.email}</p>
                  </div>
                </DropdownMenuLabel>
                <DropdownMenuSeparator />
                <DropdownMenuItem asChild>
                  <Link href="/profile" className="flex items-center gap-3 cursor-pointer">
                    <User className="w-4 h-4" />
                    Profile
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuItem asChild>
                  <Link href="/settings" className="flex items-center gap-3 cursor-pointer">
                    <Settings className="w-4 h-4" />
                    Settings
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuItem asChild>
                  <Link href="/subscriptions" className="flex items-center gap-3 cursor-pointer">
                    <CreditCard className="w-4 h-4" />
                    Subscriptions
                  </Link>
                </DropdownMenuItem>
                <DropdownMenuSeparator />
                <form action={signOut}>
                  <DropdownMenuItem asChild>
                    <button
                      type="submit"
                      className="w-full flex items-center gap-3 text-red-500 cursor-pointer"
                    >
                      <LogOut className="w-4 h-4" />
                      Sign out
                    </button>
                  </DropdownMenuItem>
                </form>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
        </div>
      </nav>

      {/* Mobile Bottom Navigation */}
      <nav className="fixed bottom-0 left-0 right-0 z-50 h-16 bg-white/95 backdrop-blur-xl border-t border-[var(--card-border)] shadow-lg md:hidden">
        <div className="h-full grid grid-cols-3 items-center">
          <MobileNavLink href="/dashboard" icon={Home} label="Home" />
          <MobileNavLink href="/courses" icon={GraduationCap} label="Courses" />
          <MobileNavLink href="/profile" icon={User} label="Profile" />
        </div>
      </nav>

      {/* Main Content with Chat Context */}
      <ChatWrapper>
        <main className="pt-16 pb-20 md:pb-0 min-h-screen">
          {children}
        </main>
        
        {/* Onboarding Tour for new users */}
        <OnboardingTour />
      </ChatWrapper>
    </div>
  );
}

// Navigation components
function NavLink({
  href,
  icon: Icon,
  children,
}: {
  href: string;
  icon: React.ComponentType<{ className?: string }>;
  children: React.ReactNode;
}) {
  return (
    <Link
      href={href}
      className="flex items-center gap-2 px-4 py-2.5 text-sm font-medium text-[var(--foreground-muted)] hover:text-[var(--primary)] hover:bg-[var(--background-secondary)] rounded-xl transition-all"
    >
      <Icon className="w-4 h-4" />
      {children}
    </Link>
  );
}


function MobileNavLink({
  href,
  icon: Icon,
  label,
}: {
  href: string;
  icon: React.ComponentType<{ className?: string }>;
  label: string;
}) {
  return (
    <Link
      href={href}
      className="flex flex-col items-center justify-center gap-1 text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors"
    >
      <Icon className="w-5 h-5" />
      <span className="text-xs font-medium">{label}</span>
    </Link>
  );
}
