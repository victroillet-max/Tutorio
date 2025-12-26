import { 
  Users as UsersIcon, 
  Search, 
  Shield, 
  User,
  Mail,
  Calendar,
  Award,
  Zap,
  Crown,
  MoreVertical,
  ChevronLeft,
  ChevronRight
} from "lucide-react";
import { getUsers, type AdminUser } from "@/lib/admin/actions";

export const metadata = {
  title: "Users | Admin Dashboard",
  description: "Manage platform users",
};

interface PageProps {
  searchParams: Promise<{ 
    page?: string; 
    search?: string; 
    role?: string;
  }>;
}

export default async function UsersPage({ searchParams }: PageProps) {
  const params = await searchParams;
  const page = parseInt(params.page || "1");
  const search = params.search || "";
  const role = (params.role || "all") as "user" | "admin" | "all";
  
  const { users, total } = await getUsers({ 
    page, 
    limit: 20, 
    search: search || undefined,
    role,
  });
  
  const totalPages = Math.ceil(total / 20);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 
            className="text-2xl font-bold text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Users
          </h1>
          <p className="text-[var(--foreground-muted)]">
            Manage and view all platform users
          </p>
        </div>
        <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
          <UsersIcon className="w-4 h-4" />
          <span>{total} total users</span>
        </div>
      </div>

      {/* Filters */}
      <div className="card-elevated p-4">
        <form className="flex flex-col sm:flex-row gap-4">
          {/* Search */}
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-[var(--foreground-muted)]" />
            <input
              type="text"
              name="search"
              placeholder="Search by email or name..."
              defaultValue={search}
              className="w-full pl-10 pr-4 py-2 rounded-lg border border-[var(--border)] bg-white text-sm text-[var(--foreground)] placeholder:text-[var(--foreground-muted)] focus:outline-none focus:ring-2 focus:ring-[var(--primary)] focus:border-transparent"
            />
          </div>
          
          {/* Role Filter */}
          <select
            name="role"
            defaultValue={role}
            className="px-4 py-2 rounded-lg border border-[var(--border)] bg-white text-sm text-[var(--foreground)] focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
          >
            <option value="all">All Roles</option>
            <option value="user">Users</option>
            <option value="admin">Admins</option>
          </select>
          
          <button
            type="submit"
            className="px-4 py-2 rounded-lg bg-[var(--primary)] text-white text-sm font-medium hover:bg-[var(--primary-dark)] transition-colors"
          >
            Filter
          </button>
        </form>
      </div>

      {/* Users Table */}
      <div className="card-elevated overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-slate-50 border-b border-[var(--border)]">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                  User
                </th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                  Role
                </th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                  Subscription
                </th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                  Stats
                </th>
                <th className="px-6 py-3 text-left text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                  Joined
                </th>
                <th className="px-6 py-3 text-right text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-[var(--border)]">
              {users.map((user) => (
                <UserRow key={user.id} user={user} />
              ))}
              {users.length === 0 && (
                <tr>
                  <td colSpan={6} className="px-6 py-12 text-center text-[var(--foreground-muted)]">
                    No users found matching your criteria.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        {totalPages > 1 && (
          <div className="px-6 py-4 border-t border-[var(--border)] flex items-center justify-between">
            <p className="text-sm text-[var(--foreground-muted)]">
              Showing {(page - 1) * 20 + 1} to {Math.min(page * 20, total)} of {total} users
            </p>
            <div className="flex items-center gap-2">
              <PaginationLink 
                page={page - 1} 
                search={search} 
                role={role}
                disabled={page <= 1}
              >
                <ChevronLeft className="w-4 h-4" />
                Previous
              </PaginationLink>
              <span className="px-3 py-1 text-sm text-[var(--foreground)]">
                Page {page} of {totalPages}
              </span>
              <PaginationLink 
                page={page + 1} 
                search={search} 
                role={role}
                disabled={page >= totalPages}
              >
                Next
                <ChevronRight className="w-4 h-4" />
              </PaginationLink>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

function UserRow({ user }: { user: AdminUser }) {
  const joinDate = new Date(user.created_at);
  const isActive = user.subscription?.status === "active" || user.subscription?.status === "trialing";
  
  return (
    <tr className="hover:bg-slate-50 transition-colors">
      <td className="px-6 py-4">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-[var(--primary)] flex items-center justify-center text-white font-medium text-sm">
            {user.avatar_url ? (
              <img src={user.avatar_url} alt="" className="w-full h-full rounded-full object-cover" />
            ) : (
              (user.full_name?.[0] || user.email[0]).toUpperCase()
            )}
          </div>
          <div>
            <p className="text-sm font-medium text-[var(--foreground)]">
              {user.full_name || "No name"}
            </p>
            <p className="text-xs text-[var(--foreground-muted)] flex items-center gap-1">
              <Mail className="w-3 h-3" />
              {user.email}
            </p>
          </div>
        </div>
      </td>
      <td className="px-6 py-4">
        {user.role === "admin" ? (
          <span className="inline-flex items-center gap-1 px-2.5 py-1 text-xs font-medium rounded-full bg-purple-100 text-purple-700">
            <Shield className="w-3 h-3" />
            Admin
          </span>
        ) : (
          <span className="inline-flex items-center gap-1 px-2.5 py-1 text-xs font-medium rounded-full bg-slate-100 text-slate-600">
            <User className="w-3 h-3" />
            User
          </span>
        )}
      </td>
      <td className="px-6 py-4">
        {user.subscription ? (
          <div>
            <span className={`inline-flex items-center gap-1 px-2.5 py-1 text-xs font-medium rounded-full ${
              isActive 
                ? "bg-emerald-100 text-emerald-700"
                : "bg-slate-100 text-slate-600"
            }`}>
              <Crown className="w-3 h-3" />
              {user.subscription.tier_name}
            </span>
            <p className="text-xs text-[var(--foreground-muted)] mt-1">
              {user.subscription.status}
            </p>
          </div>
        ) : (
          <span className="text-xs text-[var(--foreground-muted)]">Free</span>
        )}
      </td>
      <td className="px-6 py-4">
        <div className="flex items-center gap-4 text-xs text-[var(--foreground-muted)]">
          <span className="flex items-center gap-1" title="Total XP">
            <Zap className="w-3 h-3 text-amber-500" />
            {user.stats?.total_xp || 0}
          </span>
          <span className="flex items-center gap-1" title="Streak">
            <Award className="w-3 h-3 text-orange-500" />
            {user.stats?.current_streak || 0}d
          </span>
          <span title="Activities completed">
            {user.stats?.activities_completed || 0} done
          </span>
        </div>
      </td>
      <td className="px-6 py-4">
        <div className="flex items-center gap-1 text-xs text-[var(--foreground-muted)]">
          <Calendar className="w-3 h-3" />
          {joinDate.toLocaleDateString()}
        </div>
      </td>
      <td className="px-6 py-4 text-right">
        <button className="p-2 rounded-lg hover:bg-slate-100 transition-colors">
          <MoreVertical className="w-4 h-4 text-[var(--foreground-muted)]" />
        </button>
      </td>
    </tr>
  );
}

function PaginationLink({ 
  page, 
  search, 
  role, 
  disabled, 
  children 
}: { 
  page: number; 
  search: string; 
  role: string;
  disabled: boolean;
  children: React.ReactNode;
}) {
  const params = new URLSearchParams();
  params.set("page", page.toString());
  if (search) params.set("search", search);
  if (role !== "all") params.set("role", role);
  
  if (disabled) {
    return (
      <span className="inline-flex items-center gap-1 px-3 py-1.5 text-sm text-slate-300 cursor-not-allowed">
        {children}
      </span>
    );
  }
  
  return (
    <a
      href={`/admin/users?${params.toString()}`}
      className="inline-flex items-center gap-1 px-3 py-1.5 text-sm text-[var(--primary)] hover:bg-[var(--progress-bg)] rounded-lg transition-colors"
    >
      {children}
    </a>
  );
}

