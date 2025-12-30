import { 
  Users, 
  GraduationCap, 
  CreditCard, 
  TrendingUp,
  TrendingDown,
  ArrowUpRight,
  ArrowDownRight,
  DollarSign,
  UserPlus,
  ShoppingCart,
  BookOpen,
  Target,
  CheckCircle2,
  AlertTriangle,
  XCircle,
  Zap,
  RefreshCw,
  Calendar,
  BarChart3,
  AlertCircle
} from "lucide-react";
import Link from "next/link";
import { getDashboardStats, getRecentActivity, type RecentActivity } from "@/lib/admin/actions";

export const metadata = {
  title: "Admin Dashboard | Tutorio",
  description: "Admin overview and statistics",
};

export default async function AdminDashboardPage() {
  const stats = await getDashboardStats();
  const recentActivity = await getRecentActivity(6);

  // Calculate business health alerts
  const alerts: Array<{ type: 'error' | 'warning' | 'success'; message: string }> = [];
  
  if (stats.churnRate > 5) {
    alerts.push({ type: 'error', message: `Churn rate is ${stats.churnRate}% (threshold: 5%)` });
  }
  if (stats.conversionRate < 5 && stats.totalUsers > 10) {
    alerts.push({ type: 'warning', message: `Low conversion rate: ${stats.conversionRate}%` });
  }
  if (stats.ltvCacRatio < 3 && stats.ltvCacRatio > 0) {
    alerts.push({ type: 'warning', message: `LTV/CAC ratio is ${stats.ltvCacRatio}x (target: 3x+)` });
  }
  if (stats.subscriptionGrowth > 20) {
    alerts.push({ type: 'success', message: `Subscription growth +${stats.subscriptionGrowth}% this month` });
  }

  return (
    <div className="space-y-8">
      {/* Header with Period Indicator */}
      <div className="flex items-center justify-between">
        <div>
          <h1 
            className="text-3xl font-bold mb-1 text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Dashboard
          </h1>
          <p className="text-[var(--foreground-muted)]">
            Real-time business metrics and KPIs
          </p>
        </div>
        <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)] bg-white border border-[var(--border)] rounded-lg px-4 py-2">
          <Calendar className="w-4 h-4" />
          <span>Current Period</span>
        </div>
      </div>

      {/* Primary KPIs - The "Headline Numbers" */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <PrimaryKPICard
          label="MRR"
          value={`CHF ${stats.mrr.toFixed(0)}`}
          change={stats.revenueGrowth}
          trend={stats.mrrTrend.slice(-3).map(t => t.mrr)}
          color="indigo"
          href="/admin/subscriptions"
        />
        <PrimaryKPICard
          label="ARR"
          value={`CHF ${stats.arr.toFixed(0)}`}
          subtext="Annual projection"
          color="emerald"
          href="/admin/subscriptions"
        />
        <PrimaryKPICard
          label="Active Subscribers"
          value={stats.activeSubscriptions}
          change={stats.subscriptionGrowth}
          subtext={`${stats.newUsersThisWeek} new this week`}
          color="blue"
          href="/admin/subscriptions"
        />
        <PrimaryKPICard
          label="Conversion Rate"
          value={`${stats.conversionRate}%`}
          subtext={`${stats.activeSubscriptions}/${stats.totalUsers} users`}
          color={stats.conversionRate >= 5 ? "emerald" : "amber"}
          href="/admin/users"
        />
      </div>

      {/* MRR Growth Chart & Alerts */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 card-elevated p-6">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h2 
                className="text-lg font-semibold text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                MRR Growth
              </h2>
              <p className="text-sm text-[var(--foreground-muted)]">Last 6 months</p>
            </div>
            <Link 
              href="/admin/subscriptions"
              className="text-sm text-[var(--primary)] hover:underline"
            >
              View details
            </Link>
          </div>
          <MRRChart data={stats.mrrTrend} />
        </div>

        {/* Alerts Panel */}
        <div className="card-elevated p-6">
          <div className="flex items-center gap-2 mb-4">
            <AlertCircle className="w-5 h-5 text-[var(--primary)]" />
            <h2 
              className="text-lg font-semibold text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Business Health
            </h2>
          </div>
          {alerts.length > 0 ? (
            <div className="space-y-3">
              {alerts.map((alert, i) => (
                <AlertItem key={i} type={alert.type} message={alert.message} />
              ))}
            </div>
          ) : (
            <div className="flex flex-col items-center justify-center py-8 text-center">
              <div className="w-12 h-12 rounded-full bg-emerald-100 flex items-center justify-center mb-3">
                <CheckCircle2 className="w-6 h-6 text-emerald-600" />
              </div>
              <p className="text-sm font-medium text-[var(--foreground)]">All metrics healthy</p>
              <p className="text-xs text-[var(--foreground-muted)] mt-1">No issues detected</p>
            </div>
          )}
          
          {/* Stripe Status */}
          <div className="mt-4 pt-4 border-t border-[var(--border)]">
            <StripeStatusBadge />
          </div>
        </div>
      </div>

      {/* Unit Economics */}
      <div className="card-elevated p-6">
        <div className="flex items-center gap-2 mb-6">
          <BarChart3 className="w-5 h-5 text-[var(--primary)]" />
          <h2 
            className="text-lg font-semibold text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Unit Economics
          </h2>
        </div>
        <div className="grid grid-cols-2 md:grid-cols-5 gap-6">
          <UnitMetric
            label="ARPU"
            value={`CHF ${stats.avgRevenuePerUser.toFixed(0)}`}
            tooltip="Average Revenue Per User"
          />
          <UnitMetric
            label="LTV"
            value={`CHF ${stats.ltv.toFixed(0)}`}
            tooltip="Customer Lifetime Value"
          />
          <UnitMetric
            label="CAC"
            value={`CHF ${stats.cac.toFixed(0)}`}
            tooltip="Customer Acquisition Cost"
          />
          <UnitMetric
            label="LTV/CAC"
            value={`${stats.ltvCacRatio}x`}
            status={stats.ltvCacRatio >= 3 ? 'good' : stats.ltvCacRatio >= 2 ? 'warning' : 'bad'}
            tooltip="Ratio should be 3x or higher"
          />
          <UnitMetric
            label="Payback"
            value={`${stats.paybackMonths} mo`}
            status={stats.paybackMonths <= 12 ? 'good' : stats.paybackMonths <= 18 ? 'warning' : 'bad'}
            tooltip="Months to recover CAC"
          />
        </div>
      </div>

      {/* Secondary Metrics Row */}
      <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4">
        <SecondaryMetric
          icon={Users}
          label="Total Users"
          value={stats.totalUsers}
          change={stats.userGrowth}
          href="/admin/users"
        />
        <SecondaryMetric
          icon={GraduationCap}
          label="Courses"
          value={stats.totalCourses}
          subtext={`${stats.publishedCourses} published`}
          href="/admin/courses"
        />
        <SecondaryMetric
          icon={Target}
          label="Completions"
          value={stats.completedActivities}
        />
        <SecondaryMetric
          icon={BookOpen}
          label="Activities"
          value={stats.totalActivities}
        />
        <SecondaryMetric
          icon={RefreshCw}
          label="Churn Rate"
          value={`${stats.churnRate}%`}
          status={stats.churnRate <= 5 ? 'good' : 'bad'}
        />
        <SecondaryMetric
          icon={Zap}
          label="NRR"
          value={`${stats.netRevenueRetention}%`}
          status={stats.netRevenueRetention >= 100 ? 'good' : 'warning'}
        />
      </div>

      {/* Quick Actions & Recent Activity */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="card-elevated p-6">
          <h2 
            className="text-lg font-semibold mb-4 text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Quick Actions
          </h2>
          <div className="grid grid-cols-2 gap-3">
            <QuickActionButton label="Manage Users" href="/admin/users" icon={Users} />
            <QuickActionButton label="View Courses" href="/admin/courses" icon={GraduationCap} />
            <QuickActionButton label="Revenue Report" href="/admin/subscriptions" icon={DollarSign} />
            <QuickActionButton label="Back to App" href="/dashboard" icon={BookOpen} />
          </div>
        </div>

        <div className="card-elevated p-6">
          <div className="flex items-center justify-between mb-4">
            <h2 
              className="text-lg font-semibold text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Recent Activity
            </h2>
            <span className="text-xs text-[var(--foreground-muted)]">
              Last 6 events
            </span>
          </div>
          
          {recentActivity.length > 0 ? (
            <div className="space-y-2">
              {recentActivity.map((activity) => (
                <ActivityItem key={activity.id} activity={activity} />
              ))}
            </div>
          ) : (
            <div className="text-center py-6 text-[var(--foreground-muted)]">
              <p className="text-sm">No recent activity</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

// ============================================
// Primary KPI Card - Large, prominent display
// ============================================
function PrimaryKPICard({
  label,
  value,
  change,
  subtext,
  trend,
  color,
  href,
}: {
  label: string;
  value: string | number;
  change?: number;
  subtext?: string;
  trend?: number[];
  color: "indigo" | "emerald" | "blue" | "amber";
  href?: string;
}) {
  const colorConfig = {
    indigo: { bg: 'bg-indigo-50', text: 'text-indigo-600', border: 'border-indigo-200' },
    emerald: { bg: 'bg-emerald-50', text: 'text-emerald-600', border: 'border-emerald-200' },
    blue: { bg: 'bg-blue-50', text: 'text-blue-600', border: 'border-blue-200' },
    amber: { bg: 'bg-amber-50', text: 'text-amber-600', border: 'border-amber-200' },
  };

  const isPositive = change && change > 0;
  const isNegative = change && change < 0;

  const content = (
    <div className={`relative overflow-hidden rounded-2xl bg-white border ${colorConfig[color].border} p-6 ${href ? 'hover:shadow-lg transition-all cursor-pointer hover:-translate-y-0.5' : ''}`}>
      {/* Mini trend chart in background */}
      {trend && trend.length > 0 && (
        <div className="absolute right-4 bottom-4 opacity-20">
          <MiniSparkline data={trend} color={color} />
        </div>
      )}
      
      <div className="relative">
        <p className="text-sm font-medium text-[var(--foreground-muted)] mb-1">{label}</p>
        <p className="text-3xl font-bold text-[var(--foreground)] mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
          {value}
        </p>
        <div className="flex items-center gap-2">
          {change !== undefined && (
            <span className={`inline-flex items-center gap-0.5 text-sm font-medium ${
              isPositive ? "text-emerald-600" : isNegative ? "text-red-500" : "text-slate-500"
            }`}>
              {isPositive ? <ArrowUpRight className="w-3.5 h-3.5" /> : isNegative ? <ArrowDownRight className="w-3.5 h-3.5" /> : null}
              {isPositive ? '+' : ''}{change}%
            </span>
          )}
          {subtext && (
            <span className="text-xs text-[var(--foreground-muted)]">{subtext}</span>
          )}
        </div>
      </div>
    </div>
  );

  if (href) {
    return <Link href={href}>{content}</Link>;
  }
  return content;
}

// ============================================
// Mini Sparkline for trend visualization
// ============================================
function MiniSparkline({ data, color }: { data: number[]; color: string }) {
  const max = Math.max(...data, 1);
  const min = Math.min(...data, 0);
  const range = max - min || 1;
  
  const points = data.map((val, i) => {
    const x = (i / (data.length - 1)) * 60;
    const y = 30 - ((val - min) / range) * 28;
    return `${x},${y}`;
  }).join(' ');

  const colorMap: Record<string, string> = {
    indigo: '#6366f1',
    emerald: '#10b981',
    blue: '#3b82f6',
    amber: '#f59e0b',
  };

  return (
    <svg width="60" height="30" className="opacity-60">
      <polyline
        fill="none"
        stroke={colorMap[color]}
        strokeWidth="2"
        points={points}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

// ============================================
// MRR Chart Component
// ============================================
function MRRChart({ data }: { data: Array<{ month: string; mrr: number; subscribers: number }> }) {
  if (data.length === 0) {
    return (
      <div className="h-48 flex items-center justify-center text-[var(--foreground-muted)]">
        <p>No revenue data available</p>
      </div>
    );
  }

  const maxMrr = Math.max(...data.map(d => d.mrr), 1);
  
  return (
    <div className="h-48 flex items-end gap-3">
      {data.map((month, index) => {
        const heightPercent = (month.mrr / maxMrr) * 100;
        const isLast = index === data.length - 1;
        
        return (
          <div key={month.month} className="flex-1 flex flex-col items-center group">
            <div className="relative w-full flex justify-center mb-2">
              {/* Tooltip */}
              <div className="absolute -top-14 left-1/2 -translate-x-1/2 bg-slate-800 text-white text-xs px-3 py-2 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap z-10 shadow-lg">
                <p className="font-semibold">CHF {month.mrr.toFixed(0)}</p>
                <p className="text-slate-300">{month.subscribers} subscribers</p>
              </div>
              
              <div 
                className={`w-full max-w-[60px] rounded-t-lg transition-all duration-300 ${
                  isLast 
                    ? 'bg-gradient-to-t from-[var(--primary)] to-[var(--primary-light)]' 
                    : 'bg-slate-200 group-hover:bg-slate-300'
                }`}
                style={{ height: `${Math.max(heightPercent * 1.6, 8)}px` }}
              />
            </div>
            <span className={`text-xs ${isLast ? 'text-[var(--primary)] font-medium' : 'text-[var(--foreground-muted)]'}`}>
              {month.month}
            </span>
          </div>
        );
      })}
    </div>
  );
}

// ============================================
// Unit Economics Metric
// ============================================
function UnitMetric({
  label,
  value,
  status,
  tooltip,
}: {
  label: string;
  value: string;
  status?: 'good' | 'warning' | 'bad';
  tooltip?: string;
}) {
  const statusColors = {
    good: 'text-emerald-600',
    warning: 'text-amber-600',
    bad: 'text-red-600',
  };

  return (
    <div className="text-center group relative">
      <p className={`text-2xl font-bold ${status ? statusColors[status] : 'text-[var(--foreground)]'}`} style={{ fontFamily: 'var(--font-heading)' }}>
        {value}
      </p>
      <p className="text-xs text-[var(--foreground-muted)] mt-1">{label}</p>
      {tooltip && (
        <div className="absolute -top-8 left-1/2 -translate-x-1/2 bg-slate-800 text-white text-xs px-2 py-1 rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap z-10">
          {tooltip}
        </div>
      )}
    </div>
  );
}

// ============================================
// Secondary Metric Card
// ============================================
function SecondaryMetric({
  icon: Icon,
  label,
  value,
  change,
  subtext,
  status,
  href,
}: {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  value: string | number;
  change?: number;
  subtext?: string;
  status?: 'good' | 'warning' | 'bad';
  href?: string;
}) {
  const statusConfig = {
    good: 'border-l-emerald-500',
    warning: 'border-l-amber-500',
    bad: 'border-l-red-500',
  };

  const content = (
    <div className={`bg-white rounded-xl border border-[var(--border)] p-4 ${status ? `border-l-4 ${statusConfig[status]}` : ''} ${href ? 'hover:shadow-md transition-shadow cursor-pointer' : ''}`}>
      <div className="flex items-center gap-2 mb-2">
        <Icon className="w-4 h-4 text-[var(--foreground-muted)]" />
        <span className="text-xs text-[var(--foreground-muted)]">{label}</span>
      </div>
      <p className="text-xl font-bold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
        {value}
      </p>
      {(change !== undefined || subtext) && (
        <p className={`text-xs mt-1 ${change && change > 0 ? 'text-emerald-600' : change && change < 0 ? 'text-red-500' : 'text-[var(--foreground-muted)]'}`}>
          {change !== undefined ? `${change > 0 ? '+' : ''}${change}%` : subtext}
        </p>
      )}
    </div>
  );

  if (href) {
    return <Link href={href}>{content}</Link>;
  }
  return content;
}

// ============================================
// Alert Item
// ============================================
function AlertItem({ type, message }: { type: 'error' | 'warning' | 'success'; message: string }) {
  const config = {
    error: { bg: 'bg-red-50', border: 'border-red-200', icon: XCircle, iconColor: 'text-red-500' },
    warning: { bg: 'bg-amber-50', border: 'border-amber-200', icon: AlertTriangle, iconColor: 'text-amber-500' },
    success: { bg: 'bg-emerald-50', border: 'border-emerald-200', icon: CheckCircle2, iconColor: 'text-emerald-500' },
  };
  
  const Icon = config[type].icon;
  
  return (
    <div className={`flex items-start gap-2 p-3 rounded-lg ${config[type].bg} border ${config[type].border}`}>
      <Icon className={`w-4 h-4 mt-0.5 flex-shrink-0 ${config[type].iconColor}`} />
      <span className="text-sm text-[var(--foreground)]">{message}</span>
    </div>
  );
}

// ============================================
// Quick Action Button
// ============================================
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
      className="p-3 rounded-xl bg-[var(--background-secondary)] border border-[var(--border)] flex items-center gap-3 hover:border-[var(--primary)] hover:bg-[var(--progress-bg)] transition-colors group"
    >
      <div className="w-8 h-8 rounded-lg bg-white border border-[var(--border)] flex items-center justify-center group-hover:bg-[var(--primary)] group-hover:border-[var(--primary)] transition-colors">
        <Icon className="w-4 h-4 text-[var(--foreground-muted)] group-hover:text-white transition-colors" />
      </div>
      <span className="text-sm font-medium text-[var(--foreground)]">{label}</span>
    </Link>
  );
}

// ============================================
// Activity Item
// ============================================
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
    <div className="flex items-center gap-3 py-2 px-3 rounded-lg hover:bg-slate-50 transition-colors">
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
  if (seconds < 3600) return `${Math.floor(seconds / 60)}m`;
  if (seconds < 86400) return `${Math.floor(seconds / 3600)}h`;
  if (seconds < 604800) return `${Math.floor(seconds / 86400)}d`;
  return date.toLocaleDateString();
}

// ============================================
// Stripe Status Badge
// ============================================
function StripeStatusBadge() {
  const isConfigured = !!process.env.STRIPE_SECRET_KEY;
  const hasPrices = !!(process.env.STRIPE_BASIC_PRICE_ID && process.env.STRIPE_ADVANCED_PRICE_ID);
  const hasWebhook = !!process.env.STRIPE_WEBHOOK_SECRET;
  const allConfigured = isConfigured && hasPrices && hasWebhook;

  return (
    <div className="flex items-center justify-between">
      <div className="flex items-center gap-2">
        <CreditCard className="w-4 h-4 text-[var(--foreground-muted)]" />
        <span className="text-sm text-[var(--foreground)]">Stripe</span>
      </div>
      <div className={`flex items-center gap-1.5 px-2 py-1 rounded-full text-xs font-medium ${
        allConfigured 
          ? 'bg-emerald-100 text-emerald-700' 
          : 'bg-amber-100 text-amber-700'
      }`}>
        {allConfigured ? (
          <>
            <CheckCircle2 className="w-3 h-3" />
            Connected
          </>
        ) : (
          <>
            <AlertTriangle className="w-3 h-3" />
            Setup required
          </>
        )}
      </div>
    </div>
  );
}
