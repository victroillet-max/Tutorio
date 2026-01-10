"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { 
  LayoutDashboard,
  Users,
  GraduationCap,
  Settings,
  BarChart3,
  CreditCard,
  FileEdit,
  ClipboardCheck,
  LucideIcon
} from "lucide-react";

const iconMap: Record<string, LucideIcon> = {
  LayoutDashboard,
  Users,
  GraduationCap,
  Settings,
  BarChart3,
  CreditCard,
  FileEdit,
  ClipboardCheck,
};

interface AdminSidebarLinkProps {
  href: string;
  iconName: string;
  children: React.ReactNode;
  exact?: boolean;
}

export function AdminSidebarLink({ 
  href, 
  iconName, 
  children, 
  exact = false 
}: AdminSidebarLinkProps) {
  const pathname = usePathname();
  const Icon = iconMap[iconName] || LayoutDashboard;
  
  const isActive = exact 
    ? pathname === href 
    : pathname === href || pathname.startsWith(`${href}/`);

  return (
    <Link
      href={href}
      className={`flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-lg transition-colors ${
        isActive
          ? "bg-[var(--progress-bg)] text-[var(--primary)]"
          : "text-[var(--foreground-muted)] hover:text-[var(--primary)] hover:bg-[var(--background-secondary)]"
      }`}
    >
      <Icon className="w-4 h-4" />
      {children}
    </Link>
  );
}
