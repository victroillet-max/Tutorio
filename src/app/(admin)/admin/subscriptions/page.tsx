import { 
  CreditCard, 
  TrendingUp,
  TrendingDown,
  DollarSign,
  Users,
  BarChart3,
  PieChart,
  Calendar,
  AlertCircle,
  CheckCircle2,
  Clock,
  XCircle,
  Repeat
} from "lucide-react";
import { getRevenueData, getDashboardStats } from "@/lib/admin/actions";

export const metadata = {
  title: "Subscriptions & Revenue | Admin Dashboard",
  description: "Revenue breakdown and subscription analytics",
};

export default async function SubscriptionsPage() {
  const [revenueData, stats] = await Promise.all([
    getRevenueData(),
    getDashboardStats(),
  ]);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 
          className="text-2xl font-bold text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Subscriptions & Revenue
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Track revenue, subscriptions, and financial metrics
        </p>
      </div>

      {/* Key Metrics */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <MetricCard
          icon={DollarSign}
          label="Monthly Recurring Revenue"
          value={`CHF ${revenueData.mrr.toFixed(2)}`}
          subtext="Current MRR"
          color="green"
        />
        <MetricCard
          icon={TrendingUp}
          label="Annual Run Rate"
          value={`CHF ${revenueData.arr.toFixed(2)}`}
          subtext="Projected ARR"
          color="blue"
        />
        <MetricCard
          icon={Users}
          label="Active Subscriptions"
          value={stats.activeSubscriptions}
          change={stats.subscriptionGrowth}
          subtext="vs last month"
          color="purple"
        />
        <MetricCard
          icon={Repeat}
          label="Churn Rate"
          value={`${revenueData.churnRate}%`}
          subtext="This month"
          color={revenueData.churnRate > 5 ? "red" : "green"}
        />
      </div>

      {/* Revenue Chart */}
      <div className="card-elevated p-6">
        <h2 
          className="text-lg font-semibold text-[var(--foreground)] mb-4"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Revenue Trend (Last 6 Months)
        </h2>
        <div className="h-64">
          <RevenueChart data={revenueData.monthlyRevenue} />
        </div>
      </div>

      {/* Two Column Layout */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Subscriptions by Tier */}
        <div className="card-elevated p-6">
          <div className="flex items-center gap-2 mb-4">
            <PieChart className="w-5 h-5 text-[var(--primary)]" />
            <h2 
              className="text-lg font-semibold text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Subscriptions by Tier
            </h2>
          </div>
          {revenueData.subscriptionsByTier.length > 0 ? (
            <div className="space-y-4">
              {revenueData.subscriptionsByTier.map((tier, index) => {
                const total = revenueData.subscriptionsByTier.reduce((sum, t) => sum + t.count, 0);
                const percentage = total > 0 ? Math.round((tier.count / total) * 100) : 0;
                const colors = ['bg-blue-500', 'bg-purple-500', 'bg-emerald-500', 'bg-amber-500'];
                const bgColors = ['bg-blue-100', 'bg-purple-100', 'bg-emerald-100', 'bg-amber-100'];
                
                return (
                  <div key={tier.tier_name}>
                    <div className="flex items-center justify-between mb-2">
                      <div className="flex items-center gap-2">
                        <div className={`w-3 h-3 rounded-full ${colors[index % colors.length]}`} />
                        <span className="text-sm font-medium text-[var(--foreground)]">
                          {tier.tier_name}
                        </span>
                      </div>
                      <div className="text-right">
                        <span className="text-sm font-semibold text-[var(--foreground)]">
                          {tier.count} subscribers
                        </span>
                        <span className="text-xs text-[var(--foreground-muted)] ml-2">
                          ({percentage}%)
                        </span>
                      </div>
                    </div>
                    <div className={`h-2 rounded-full ${bgColors[index % bgColors.length]}`}>
                      <div 
                        className={`h-full rounded-full ${colors[index % colors.length]}`}
                        style={{ width: `${percentage}%` }}
                      />
                    </div>
                    <p className="text-xs text-[var(--foreground-muted)] mt-1">
                      CHF {tier.revenue.toFixed(2)} / month
                    </p>
                  </div>
                );
              })}
            </div>
          ) : (
            <div className="text-center py-8 text-[var(--foreground-muted)]">
              <PieChart className="w-12 h-12 mx-auto mb-2 opacity-50" />
              <p>No active subscriptions yet</p>
            </div>
          )}
        </div>

        {/* Subscriptions by Status */}
        <div className="card-elevated p-6">
          <div className="flex items-center gap-2 mb-4">
            <BarChart3 className="w-5 h-5 text-[var(--primary)]" />
            <h2 
              className="text-lg font-semibold text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              Subscriptions by Status
            </h2>
          </div>
          {revenueData.subscriptionsByStatus.length > 0 ? (
            <div className="space-y-3">
              {revenueData.subscriptionsByStatus.map((status) => {
                const config = statusConfig[status.status] || statusConfig.active;
                const Icon = config.icon;
                
                return (
                  <div 
                    key={status.status}
                    className={`p-4 rounded-xl flex items-center justify-between ${config.bg}`}
                  >
                    <div className="flex items-center gap-3">
                      <div className={`w-10 h-10 rounded-lg ${config.iconBg} flex items-center justify-center`}>
                        <Icon className={`w-5 h-5 ${config.iconColor}`} />
                      </div>
                      <div>
                        <p className="font-medium text-[var(--foreground)] capitalize">
                          {status.status.replace('_', ' ')}
                        </p>
                        <p className="text-xs text-[var(--foreground-muted)]">
                          {config.description}
                        </p>
                      </div>
                    </div>
                    <span className="text-2xl font-bold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
                      {status.count}
                    </span>
                  </div>
                );
              })}
            </div>
          ) : (
            <div className="text-center py-8 text-[var(--foreground-muted)]">
              <BarChart3 className="w-12 h-12 mx-auto mb-2 opacity-50" />
              <p>No subscription data available</p>
            </div>
          )}
        </div>
      </div>

      {/* Monthly Revenue Table */}
      <div className="card-elevated overflow-hidden">
        <div className="p-4 border-b border-[var(--border)] flex items-center gap-2">
          <Calendar className="w-5 h-5 text-[var(--primary)]" />
          <h2 
            className="text-lg font-semibold text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Monthly Breakdown
          </h2>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-slate-50 border-b border-[var(--border)]">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                  Month
                </th>
                <th className="px-6 py-3 text-right text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                  New Subscriptions
                </th>
                <th className="px-6 py-3 text-right text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                  Revenue
                </th>
                <th className="px-6 py-3 text-right text-xs font-semibold text-[var(--foreground-muted)] uppercase tracking-wider">
                  Change
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-[var(--border)]">
              {revenueData.monthlyRevenue.map((month, index) => {
                const prevMonth = revenueData.monthlyRevenue[index - 1];
                const change = prevMonth && prevMonth.revenue > 0
                  ? Math.round(((month.revenue - prevMonth.revenue) / prevMonth.revenue) * 100)
                  : null;
                
                return (
                  <tr key={month.month} className="hover:bg-slate-50 transition-colors">
                    <td className="px-6 py-4">
                      <span className="font-medium text-[var(--foreground)]">
                        {month.month}
                      </span>
                    </td>
                    <td className="px-6 py-4 text-right">
                      <span className="text-[var(--foreground)]">
                        {month.subscriptions}
                      </span>
                    </td>
                    <td className="px-6 py-4 text-right">
                      <span className="font-semibold text-[var(--foreground)]">
                        CHF {month.revenue.toFixed(2)}
                      </span>
                    </td>
                    <td className="px-6 py-4 text-right">
                      {change !== null ? (
                        <span className={`inline-flex items-center gap-1 text-sm ${
                          change > 0 ? 'text-emerald-600' : change < 0 ? 'text-red-600' : 'text-slate-500'
                        }`}>
                          {change > 0 ? <TrendingUp className="w-3 h-3" /> : change < 0 ? <TrendingDown className="w-3 h-3" /> : null}
                          {change > 0 ? '+' : ''}{change}%
                        </span>
                      ) : (
                        <span className="text-slate-400">-</span>
                      )}
                    </td>
                  </tr>
                );
              })}
              {revenueData.monthlyRevenue.length === 0 && (
                <tr>
                  <td colSpan={4} className="px-6 py-12 text-center text-[var(--foreground-muted)]">
                    No revenue data available yet.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

const statusConfig: Record<string, {
  icon: React.ComponentType<{ className?: string }>;
  bg: string;
  iconBg: string;
  iconColor: string;
  description: string;
}> = {
  active: {
    icon: CheckCircle2,
    bg: 'bg-emerald-50',
    iconBg: 'bg-emerald-100',
    iconColor: 'text-emerald-600',
    description: 'Fully paid and active',
  },
  trialing: {
    icon: Clock,
    bg: 'bg-blue-50',
    iconBg: 'bg-blue-100',
    iconColor: 'text-blue-600',
    description: 'In trial period',
  },
  cancelled: {
    icon: XCircle,
    bg: 'bg-slate-50',
    iconBg: 'bg-slate-100',
    iconColor: 'text-slate-600',
    description: 'Cancelled but active until period ends',
  },
  expired: {
    icon: AlertCircle,
    bg: 'bg-red-50',
    iconBg: 'bg-red-100',
    iconColor: 'text-red-600',
    description: 'Subscription has ended',
  },
  past_due: {
    icon: AlertCircle,
    bg: 'bg-amber-50',
    iconBg: 'bg-amber-100',
    iconColor: 'text-amber-600',
    description: 'Payment failed',
  },
};

function MetricCard({
  icon: Icon,
  label,
  value,
  subtext,
  change,
  color,
}: {
  icon: React.ComponentType<{ className?: string }>;
  label: string;
  value: string | number;
  subtext: string;
  change?: number;
  color: "blue" | "green" | "purple" | "red";
}) {
  const colorClasses = {
    blue: "bg-blue-50 text-blue-600",
    green: "bg-emerald-50 text-emerald-600",
    purple: "bg-purple-50 text-purple-600",
    red: "bg-red-50 text-red-600",
  };

  return (
    <div className="card-elevated p-6">
      <div className="flex items-center justify-between mb-4">
        <div className={`w-10 h-10 rounded-lg ${colorClasses[color]} flex items-center justify-center`}>
          <Icon className="w-5 h-5" />
        </div>
        {change !== undefined && (
          <div className={`flex items-center gap-1 text-sm ${
            change > 0 ? "text-emerald-600" : change < 0 ? "text-red-600" : "text-slate-500"
          }`}>
            {change > 0 ? <TrendingUp className="w-4 h-4" /> : change < 0 ? <TrendingDown className="w-4 h-4" /> : null}
            {change > 0 ? '+' : ''}{change}%
          </div>
        )}
      </div>
      <p className="text-2xl font-bold mb-1 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
        {value}
      </p>
      <p className="text-sm text-[var(--foreground-muted)]">{label}</p>
      <p className="text-xs text-[var(--foreground-muted)] mt-1">{subtext}</p>
    </div>
  );
}

interface MonthlyData {
  month: string;
  revenue: number;
  subscriptions: number;
}

function RevenueChart({ data }: { data: MonthlyData[] }) {
  if (data.length === 0) {
    return (
      <div className="h-full flex items-center justify-center text-[var(--foreground-muted)]">
        <div className="text-center">
          <BarChart3 className="w-12 h-12 mx-auto mb-2 opacity-50" />
          <p>No revenue data available</p>
        </div>
      </div>
    );
  }

  const maxRevenue = Math.max(...data.map(d => d.revenue), 1);
  
  return (
    <div className="h-full flex items-end gap-4 px-4">
      {data.map((month) => {
        const heightPercentage = (month.revenue / maxRevenue) * 100;
        
        return (
          <div key={month.month} className="flex-1 flex flex-col items-center gap-2">
            <div className="w-full h-48 flex flex-col justify-end">
              <div 
                className="w-full bg-gradient-to-t from-[var(--primary)] to-[var(--primary-light)] rounded-t-lg transition-all duration-500 relative group"
                style={{ height: `${Math.max(heightPercentage, 5)}%` }}
              >
                {/* Tooltip */}
                <div className="absolute -top-12 left-1/2 -translate-x-1/2 bg-slate-800 text-white text-xs px-2 py-1 rounded opacity-0 group-hover:opacity-100 transition-opacity whitespace-nowrap">
                  CHF {month.revenue.toFixed(2)}
                  <br />
                  {month.subscriptions} subs
                </div>
              </div>
            </div>
            <span className="text-xs text-[var(--foreground-muted)]">{month.month}</span>
          </div>
        );
      })}
    </div>
  );
}

