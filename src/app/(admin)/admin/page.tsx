import { 
  Users, 
  GraduationCap, 
  CreditCard, 
  TrendingUp,
  ArrowUpRight,
  ArrowDownRight,
  Activity,
  Target,
  DollarSign,
  Clock,
  UserPlus,
  ShoppingCart,
  BookOpen,
  CheckCircle2,
  AlertTriangle,
  XCircle
} from "lucide-react";
import Link from "next/link";
import { getDashboardStats, getRecentActivity, type RecentActivity } from "@/lib/admin/actions";

export const metadata = {
  title: "Admin Dashboard | Tutorio",
  description: "Admin overview and statistics",
};

export default async function AdminDashboardPage() {
  const stats = await getDashboardStats();
  const recentActivity = await getRecentActivity(8);

  return (
    <div className="space-y-8">
      {/* Header */}
      <div>
        <h1 
          className="text-3xl font-bold mb-2 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Admin Dashboard
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Overview of your platform metrics and activity.
        </p>
      </div>

      {/* Primary Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <StatCard
          icon={Users}
          label="Total Users"
          value={stats.totalUsers}
          change={stats.userGrowth}
          subtext={`${stats.newUsersThisWeek} this week`}
          color="blue"
          href="/admin/users"
        />
        <StatCard
          icon={GraduationCap}
          label="Courses"
          value={stats.totalCourses}
          subtext={`${stats.publishedCourses} published`}
          color="purple"
          href="/admin/courses"
        />
        <StatCard
          icon={CreditCard}
          label="Active Subscriptions"
          value={stats.activeSubscriptions}
          change={stats.subscriptionGrowth}
          color="green"
          href="/admin/subscriptions"
        />
        <StatCard
          icon={TrendingUp}
          label="Monthly Revenue"
          value={`CHF ${stats.monthlyRevenue.toFixed(2)}`}
          change={stats.revenueGrowth}
          color="orange"
          href="/admin/subscriptions"
          isRevenue
        />
      </div>

      {/* Secondary Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <MiniStatCard
          icon={Activity}
          label="Total Activities"
          value={stats.totalActivities}
        />
        <MiniStatCard
          icon={Target}
          label="Completions"
          value={stats.completedActivities}
        />
        <MiniStatCard
          icon={DollarSign}
          label="Last Month Revenue"
          value={`CHF ${stats.lastMonthRevenue.toFixed(2)}`}
        />
        <MiniStatCard
          icon={Clock}
          label="Subs Last Month"
          value={stats.subscriptionsLastMonth}
        />
      </div>

      {/* Stripe Configuration Status */}
      <StripeConfigStatus />

      {/* Quick Actions & Recent Activity */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="card-elevated p-6">
          <h2 
            className="text-xl font-semibold mb-4 text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Quick Actions
          </h2>
          <div className="grid grid-cols-2 gap-4">
            <QuickActionButton label="View All Users" href="/admin/users" icon={Users} />
            <QuickActionButton label="Manage Courses" href="/admin/courses" icon={GraduationCap} />
            <QuickActionButton label="Revenue Report" href="/admin/subscriptions" icon={DollarSign} />
            <QuickActionButton label="Back to App" href="/dashboard" icon={BookOpen} />
          </div>
        </div>

        <div className="card-elevated p-6">
          <div className="flex items-center justify-between mb-4">
            <h2 
              className="text-xl font-semibold text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Recent Activity
            </h2>
            <span className="text-xs text-[var(--foreground-muted)]">
              Last 8 events
            </span>
          </div>
          
          {recentActivity.length > 0 ? (
            <div className="space-y-3 max-h-[300px] overflow-y-auto">
              {recentActivity.map((activity) => (
                <ActivityItem key={activity.id} activity={activity} />
              ))}
            </div>
          ) : (
            <div className="text-center py-8 text-[var(--foreground-muted)]">
              <p>No recent activity to display.</p>
              <p className="text-sm mt-2">Activity will appear here once users start interacting with the platform.</p>
            </div>
          )}
        </div>
      </div>

      {/* Platform Health */}
      <div className="card-elevated p-6">
        <h2 
          className="text-xl font-semibold mb-4 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Platform Overview
        </h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
          <div className="text-center">
            <div className="text-3xl font-bold text-[var(--primary)]" style={{ fontFamily: 'var(--font-heading)' }}>
              {stats.totalUsers > 0 
                ? Math.round((stats.activeSubscriptions / stats.totalUsers) * 100)
                : 0}%
            </div>
            <p className="text-sm text-[var(--foreground-muted)] mt-1">Conversion Rate</p>
          </div>
          <div className="text-center">
            <div className="text-3xl font-bold text-emerald-600" style={{ fontFamily: 'var(--font-heading)' }}>
              {stats.totalActivities > 0
                ? Math.round((stats.completedActivities / stats.totalActivities) * 100)
                : 0}%
            </div>
            <p className="text-sm text-[var(--foreground-muted)] mt-1">Completion Rate</p>
          </div>
          <div className="text-center">
            <div className="text-3xl font-bold text-purple-600" style={{ fontFamily: 'var(--font-heading)' }}>
              {stats.totalCourses > 0
                ? Math.round((stats.publishedCourses / stats.totalCourses) * 100)
                : 0}%
            </div>
            <p className="text-sm text-[var(--foreground-muted)] mt-1">Published Rate</p>
          </div>
          <div className="text-center">
            <div className="text-3xl font-bold text-orange-600" style={{ fontFamily: 'var(--font-heading)' }}>
              CHF {(stats.monthlyRevenue * 12).toFixed(0)}
            </div>
            <p className="text-sm text-[var(--foreground-muted)] mt-1">Projected ARR</p>
          </div>
        </div>
      </div>
    </div>
  );
}

const colorClasses = {
  blue: "bg-blue-50 text-blue-600",
  purple: "bg-purple-50 text-purple-600",
  green: "bg-emerald-50 text-emerald-600",
  orange: "bg-orange-50 text-orange-600",
};

function StatCard({
  icon: Icon,
  label,
  value,
  change,
  subtext,
  color,
  href,
  isRevenue = false,
}: {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  value: string | number;
  change?: number;
  subtext?: string;
  color: "blue" | "purple" | "green" | "orange";
  href?: string;
  isRevenue?: boolean;
}) {
  const isPositive = change && change > 0;
  const isNegative = change && change < 0;

  const content = (
    <div className={`card-elevated p-6 ${href ? 'hover:shadow-lg transition-shadow cursor-pointer' : ''}`}>
      <div className="flex items-center justify-between mb-4">
        <div className={`w-10 h-10 rounded-lg ${colorClasses[color]} flex items-center justify-center`}>
          <Icon className="w-5 h-5" />
        </div>
        {change !== undefined && (
          <div className={`flex items-center gap-1 text-sm ${
            isPositive ? "text-emerald-600" : isNegative ? "text-red-600" : "text-[var(--foreground-muted)]"
          }`}>
            {isPositive ? (
              <ArrowUpRight className="w-4 h-4" />
            ) : isNegative ? (
              <ArrowDownRight className="w-4 h-4" />
            ) : null}
            {Math.abs(change)}%
          </div>
        )}
      </div>
      <p className="text-2xl font-bold mb-1 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
        {value}
      </p>
      <p className="text-sm text-[var(--foreground-muted)]">{label}</p>
      {subtext && (
        <p className="text-xs text-[var(--foreground-muted)] mt-1">{subtext}</p>
      )}
    </div>
  );

  if (href) {
    return <Link href={href}>{content}</Link>;
  }
  return content;
}

function MiniStatCard({
  icon: Icon,
  label,
  value,
}: {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  value: string | number;
}) {
  return (
    <div className="bg-white border border-[var(--border)] rounded-xl p-4 flex items-center gap-3">
      <div className="w-8 h-8 rounded-lg bg-slate-100 flex items-center justify-center flex-shrink-0">
        <Icon className="w-4 h-4 text-slate-600" />
      </div>
      <div className="min-w-0">
        <p className="text-lg font-semibold text-[var(--foreground)] truncate">{value}</p>
        <p className="text-xs text-[var(--foreground-muted)] truncate">{label}</p>
      </div>
    </div>
  );
}

function QuickActionButton({ 
  label, 
  href, 
  icon: Icon 
}: { 
  label: string; 
  href: string;
  icon: React.ComponentType<{ className?: string }>;
}) {
  return (
    <Link
      href={href}
      className="p-4 rounded-xl bg-[var(--background-secondary)] border border-[var(--border)] flex items-center gap-3 hover:border-[var(--primary)] hover:text-[var(--primary)] transition-colors group"
    >
      <div className="w-8 h-8 rounded-lg bg-white border border-[var(--border)] flex items-center justify-center group-hover:bg-[var(--primary)] group-hover:border-[var(--primary)] transition-colors">
        <Icon className="w-4 h-4 text-[var(--foreground-muted)] group-hover:text-white transition-colors" />
      </div>
      <span className="text-sm font-medium">{label}</span>
    </Link>
  );
}

const activityIcons = {
  signup: UserPlus,
  subscription: ShoppingCart,
  completion: Target,
  course_start: BookOpen,
};

const activityColors = {
  signup: "bg-blue-50 text-blue-600",
  subscription: "bg-emerald-50 text-emerald-600",
  completion: "bg-purple-50 text-purple-600",
  course_start: "bg-orange-50 text-orange-600",
};

function ActivityItem({ activity }: { activity: RecentActivity }) {
  const Icon = activityIcons[activity.type];
  const colorClass = activityColors[activity.type];
  const timeAgo = getTimeAgo(new Date(activity.timestamp));

  return (
    <div className="flex items-start gap-3 py-2 border-b border-[var(--border)] last:border-0">
      <div className={`w-8 h-8 rounded-lg ${colorClass} flex items-center justify-center flex-shrink-0`}>
        <Icon className="w-4 h-4" />
      </div>
      <div className="min-w-0 flex-1">
        <p className="text-sm text-[var(--foreground)] truncate">
          {activity.description}
        </p>
        <p className="text-xs text-[var(--foreground-muted)] truncate">
          {activity.user.name || activity.user.email}
        </p>
      </div>
      <span className="text-xs text-[var(--foreground-muted)] flex-shrink-0">
        {timeAgo}
      </span>
    </div>
  );
}

function getTimeAgo(date: Date): string {
  const seconds = Math.floor((new Date().getTime() - date.getTime()) / 1000);
  
  if (seconds < 60) return "Just now";
  if (seconds < 3600) return `${Math.floor(seconds / 60)}m ago`;
  if (seconds < 86400) return `${Math.floor(seconds / 3600)}h ago`;
  if (seconds < 604800) return `${Math.floor(seconds / 86400)}d ago`;
  return date.toLocaleDateString();
}

function StripeConfigStatus() {
  const isConfigured = !!process.env.STRIPE_SECRET_KEY;
  const hasPrices = !!(process.env.STRIPE_BASIC_PRICE_ID && process.env.STRIPE_ADVANCED_PRICE_ID);
  const hasWebhook = !!process.env.STRIPE_WEBHOOK_SECRET;
  const allConfigured = isConfigured && hasPrices && hasWebhook;

  return (
    <div className={`rounded-xl border p-4 ${
      allConfigured 
        ? 'bg-emerald-50 border-emerald-200' 
        : 'bg-amber-50 border-amber-200'
    }`}>
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          {allConfigured ? (
            <div className="w-10 h-10 rounded-lg bg-emerald-100 flex items-center justify-center">
              <CheckCircle2 className="w-5 h-5 text-emerald-600" />
            </div>
          ) : (
            <div className="w-10 h-10 rounded-lg bg-amber-100 flex items-center justify-center">
              <AlertTriangle className="w-5 h-5 text-amber-600" />
            </div>
          )}
          <div>
            <h3 className="font-semibold text-[var(--foreground)]">
              Stripe Integration
            </h3>
            <p className="text-sm text-[var(--foreground-muted)]">
              {allConfigured
                ? "Ready to accept payments"
                : "Configuration incomplete - payments disabled"}
            </p>
          </div>
        </div>

        <div className="flex items-center gap-4">
          <ConfigBadge label="API Key" configured={isConfigured} />
          <ConfigBadge label="Prices" configured={hasPrices} />
          <ConfigBadge label="Webhook" configured={hasWebhook} />
        </div>
      </div>
    </div>
  );
}

function ConfigBadge({ label, configured }: { label: string; configured: boolean }) {
  return (
    <div className="flex items-center gap-1.5">
      {configured ? (
        <CheckCircle2 className="w-4 h-4 text-emerald-500" />
      ) : (
        <XCircle className="w-4 h-4 text-red-400" />
      )}
      <span className={`text-xs font-medium ${configured ? 'text-emerald-700' : 'text-red-600'}`}>
        {label}
      </span>
    </div>
  );
}
