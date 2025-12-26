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
  ChevronDown
} from "lucide-react";
import { signOut } from "@/lib/auth/actions";

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
      <nav className="fixed top-0 left-0 right-0 z-50 h-16 bg-white border-b border-[var(--border)] shadow-sm">
        <div className="max-w-7xl mx-auto h-full px-4 sm:px-6 lg:px-8 flex items-center justify-between">
          {/* Logo */}
          <Link href="/dashboard" className="flex items-center gap-2 group">
            <div className="w-9 h-9 rounded-lg bg-[var(--primary)] flex items-center justify-center transition-transform group-hover:scale-105">
              <BookOpen className="w-4 h-4 text-white" />
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
              Courses
            </NavLink>
          </div>

          {/* User Menu */}
          <div className="flex items-center gap-4">
            <div className="relative group">
              <button className="flex items-center gap-2 p-2 rounded-lg hover:bg-[var(--background-secondary)] transition-colors">
                <div className="w-8 h-8 rounded-full bg-[var(--primary)] flex items-center justify-center text-white text-sm font-semibold">
                  {initials}
                </div>
                <span className="hidden sm:block text-sm font-medium text-[var(--foreground)] max-w-[120px] truncate">
                  {displayName}
                </span>
                <ChevronDown className="w-4 h-4 text-[var(--foreground-muted)]" />
              </button>

              {/* Dropdown */}
              <div className="absolute right-0 top-full mt-2 w-56 py-2 rounded-xl bg-white border border-[var(--border)] shadow-lg opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all">
                <div className="px-4 py-2 border-b border-[var(--border)]">
                  <p className="text-sm font-medium text-[var(--foreground)] truncate">{displayName}</p>
                  <p className="text-xs text-[var(--foreground-muted)] truncate">{user.email}</p>
                </div>

                <div className="py-1">
                  <DropdownLink href="/profile" icon={User}>
                    Profile
                  </DropdownLink>
                  <DropdownLink href="/settings" icon={Settings}>
                    Settings
                  </DropdownLink>
                </div>

                <div className="pt-1 border-t border-[var(--border)]">
                  <form action={signOut}>
                    <button
                      type="submit"
                      className="w-full flex items-center gap-3 px-4 py-2 text-sm text-red-500 hover:bg-red-50 transition-colors"
                    >
                      <LogOut className="w-4 h-4" />
                      Sign out
                    </button>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </nav>

      {/* Mobile Bottom Navigation */}
      <nav className="fixed bottom-0 left-0 right-0 z-50 h-16 bg-white border-t border-[var(--border)] shadow-lg md:hidden">
        <div className="h-full grid grid-cols-4 items-center">
          <MobileNavLink href="/dashboard" icon={Home} label="Home" />
          <MobileNavLink href="/courses" icon={GraduationCap} label="Courses" />
          <MobileNavLink href="/profile" icon={User} label="Profile" />
          <MobileNavLink href="/settings" icon={Settings} label="Settings" />
        </div>
      </nav>

      {/* Main Content */}
      <main className="pt-16 pb-20 md:pb-0 min-h-screen">
        {children}
      </main>
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
      className="flex items-center gap-2 px-4 py-2 text-sm font-medium text-[var(--foreground-muted)] hover:text-[var(--primary)] hover:bg-[var(--background-secondary)] rounded-lg transition-colors"
    >
      <Icon className="w-4 h-4" />
      {children}
    </Link>
  );
}

function DropdownLink({
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
      className="flex items-center gap-3 px-4 py-2 text-sm text-[var(--foreground-muted)] hover:text-[var(--foreground)] hover:bg-[var(--background-secondary)] transition-colors"
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
      <span className="text-xs">{label}</span>
    </Link>
  );
}
