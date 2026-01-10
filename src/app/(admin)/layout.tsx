import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import Link from "next/link";
import { 
  ChevronLeft,
  LogOut
} from "lucide-react";
import { signOut } from "@/lib/auth/actions";
import { AdminSidebarLink } from "./sidebar-link";
import type { UserRole } from "@/lib/database.types";

// Roles that can access the admin area
const ADMIN_ROLES: UserRole[] = ["admin", "contentadmin"];

/**
 * Admin layout - wraps all admin routes
 * Supports multiple admin role levels:
 * - admin: Full access to all admin features (financial, users, content)
 * - contentadmin: Access only to content management
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

  const userRole = profile?.role as UserRole | undefined;

  // Redirect non-admins to dashboard
  if (!userRole || !ADMIN_ROLES.includes(userRole)) {
    redirect("/dashboard");
  }

  // Determine access levels
  const isSuperAdmin = userRole === "admin";
  const isContentAdmin = userRole === "contentadmin";

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
          {/* Super Admin Only - Dashboard & Financial */}
          {isSuperAdmin && (
            <>
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
            </>
          )}
          
          {/* Content Management - Available to both roles */}
          <div className={isSuperAdmin ? "pt-4 mt-4 border-t border-[var(--border)]" : ""}>
            {isSuperAdmin && (
              <p className="px-3 mb-2 text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                Content
              </p>
            )}
            <AdminSidebarLink href="/admin/content" iconName="FileEdit">
              Content Manager
            </AdminSidebarLink>
            {isSuperAdmin && (
              <AdminSidebarLink href="/admin/content/pending" iconName="ClipboardCheck">
                Pending Reviews
              </AdminSidebarLink>
            )}
          </div>
          
          {/* Settings - Super Admin Only */}
          {isSuperAdmin && (
            <div className="pt-4 mt-4 border-t border-[var(--border)]">
              <AdminSidebarLink href="/admin/settings" iconName="Settings">
                Settings
              </AdminSidebarLink>
            </div>
          )}
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
        <div className="h-16 px-8 flex items-center justify-between border-b border-[var(--border)] bg-white">
          <p className="text-sm text-[var(--foreground-muted)]">
            Logged in as <span className="text-[var(--foreground)] font-medium">{user.email}</span>
          </p>
          <span className={`px-2.5 py-1 text-xs font-medium rounded-full ${
            isSuperAdmin 
              ? "bg-purple-100 text-purple-700" 
              : isContentAdmin 
                ? "bg-blue-100 text-blue-700" 
                : "bg-slate-100 text-slate-700"
          }`}>
            {isSuperAdmin ? "Super Admin" : isContentAdmin ? "Content Admin" : "Admin"}
          </span>
        </div>
        <div className="p-8">
          {children}
        </div>
      </main>
    </div>
  );
}
