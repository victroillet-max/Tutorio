import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import Link from "next/link";
import { 
  ChevronLeft,
  LogOut
} from "lucide-react";
import { signOut } from "@/lib/auth/actions";
import { AdminSidebarLink } from "./sidebar-link";

/**
 * Admin layout - wraps all admin routes
 * Checks for admin role at page level (not middleware) to avoid DB calls on every request
 */
export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  // Check admin role
  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .single();

  // Redirect non-admins to dashboard
  if (profile?.role !== "admin") {
    redirect("/dashboard");
  }

  return (
    <div className="min-h-screen bg-[var(--background-secondary)] flex">
      {/* Sidebar */}
      <aside className="fixed left-0 top-0 bottom-0 w-64 bg-white border-r border-[var(--border)] flex flex-col shadow-sm z-50">
        {/* Logo */}
        <div className="h-16 px-6 flex items-center border-b border-[var(--border)]">
          <Link href="/admin" className="flex items-center gap-3 group">
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img 
              src="/logo-cropped.svg" 
              alt="Tutorio" 
              className="w-11 h-11 transition-transform duration-300 group-hover:rotate-[-5deg] group-hover:scale-105"
            />
            <div>
              <span 
                className="text-lg font-bold tracking-tight text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                Tutorio
              </span>
              <span className="ml-2 text-xs text-[var(--primary)] font-medium">
                Admin
              </span>
            </div>
          </Link>
        </div>

        {/* Navigation */}
        <nav className="flex-1 p-4 space-y-1">
          <AdminSidebarLink href="/admin" iconName="LayoutDashboard" exact>
            Dashboard
          </AdminSidebarLink>
          <AdminSidebarLink href="/admin/courses" iconName="GraduationCap">
            Courses
          </AdminSidebarLink>
          <AdminSidebarLink href="/admin/users" iconName="Users">
            Users
          </AdminSidebarLink>
          <AdminSidebarLink href="/admin/subscriptions" iconName="CreditCard">
            Subscriptions
          </AdminSidebarLink>
          <AdminSidebarLink href="/admin/analytics" iconName="BarChart3">
            Analytics
          </AdminSidebarLink>
          <AdminSidebarLink href="/admin/settings" iconName="Settings">
            Settings
          </AdminSidebarLink>
        </nav>

        {/* Footer */}
        <div className="p-4 border-t border-[var(--border)] space-y-2">
          <Link
            href="/dashboard"
            className="flex items-center gap-2 px-3 py-2 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] hover:bg-[var(--background-secondary)] rounded-lg transition-colors"
          >
            <ChevronLeft className="w-4 h-4" />
            Back to App
          </Link>
          <form action={signOut}>
            <button
              type="submit"
              className="w-full flex items-center gap-2 px-3 py-2 text-sm text-red-500 hover:bg-red-50 rounded-lg transition-colors"
            >
              <LogOut className="w-4 h-4" />
              Sign out
            </button>
          </form>
        </div>
      </aside>

      {/* Main Content */}
      <main className="flex-1 ml-64">
        <div className="h-16 px-8 flex items-center border-b border-[var(--border)] bg-white">
          <p className="text-sm text-[var(--foreground-muted)]">
            Logged in as <span className="text-[var(--foreground)] font-medium">{user.email}</span>
          </p>
        </div>
        <div className="p-8">
          {children}
        </div>
      </main>
    </div>
  );
}
