"use server";

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";

/**
 * Admin data fetching utilities
 * All functions check for admin role before returning data
 */

// Helper to verify admin access
async function verifyAdmin() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    redirect("/login");
  }
  
  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .single();
  
  if (profile?.role !== "admin") {
    redirect("/dashboard");
  }
  
  return { supabase, user };
}

// ============================================
// Dashboard Stats
// ============================================

export interface DashboardStats {
  totalUsers: number;
  newUsersThisWeek: number;
  newUsersLastWeek: number;
  userGrowth: number;
  totalCourses: number;
  publishedCourses: number;
  activeSubscriptions: number;
  subscriptionsLastMonth: number;
  subscriptionGrowth: number;
  monthlyRevenue: number;
  lastMonthRevenue: number;
  revenueGrowth: number;
  totalActivities: number;
  completedActivities: number;
}

export async function getDashboardStats(): Promise<DashboardStats> {
  const { supabase } = await verifyAdmin();
  
  const now = new Date();
  const oneWeekAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
  const twoWeeksAgo = new Date(now.getTime() - 14 * 24 * 60 * 60 * 1000);
  const oneMonthAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
  const twoMonthsAgo = new Date(now.getTime() - 60 * 24 * 60 * 60 * 1000);
  
  // Total users
  const { count: totalUsers } = await supabase
    .from("profiles")
    .select("*", { count: "exact", head: true });
  
  // New users this week
  const { count: newUsersThisWeek } = await supabase
    .from("profiles")
    .select("*", { count: "exact", head: true })
    .gte("created_at", oneWeekAgo.toISOString());
  
  // New users last week
  const { count: newUsersLastWeek } = await supabase
    .from("profiles")
    .select("*", { count: "exact", head: true })
    .gte("created_at", twoWeeksAgo.toISOString())
    .lt("created_at", oneWeekAgo.toISOString());
  
  // Courses
  const { count: totalCourses } = await supabase
    .from("courses")
    .select("*", { count: "exact", head: true });
  
  const { count: publishedCourses } = await supabase
    .from("courses")
    .select("*", { count: "exact", head: true })
    .eq("is_published", true);
  
  // Active subscriptions
  const { count: activeSubscriptions } = await supabase
    .from("subscriptions")
    .select("*", { count: "exact", head: true })
    .in("status", ["active", "trialing"])
    .gt("current_period_end", now.toISOString());
  
  // Subscriptions last month
  const { count: subscriptionsLastMonth } = await supabase
    .from("subscriptions")
    .select("*", { count: "exact", head: true })
    .in("status", ["active", "trialing"])
    .gte("created_at", twoMonthsAgo.toISOString())
    .lt("created_at", oneMonthAgo.toISOString());
  
  // Revenue calculation
  const { data: currentMonthSubs } = await supabase
    .from("subscriptions")
    .select("tier_id")
    .in("status", ["active", "trialing"])
    .gte("created_at", oneMonthAgo.toISOString());
  
  const { data: lastMonthSubs } = await supabase
    .from("subscriptions")
    .select("tier_id")
    .in("status", ["active", "trialing"])
    .gte("created_at", twoMonthsAgo.toISOString())
    .lt("created_at", oneMonthAgo.toISOString());
  
  const { data: tiers } = await supabase
    .from("subscription_tiers")
    .select("id, price_monthly");
  
  const tierPrices = new Map(tiers?.map(t => [t.id, t.price_monthly]) || []);
  
  const monthlyRevenue = currentMonthSubs?.reduce((sum, sub) => {
    return sum + (tierPrices.get(sub.tier_id) || 0);
  }, 0) || 0;
  
  const lastMonthRevenue = lastMonthSubs?.reduce((sum, sub) => {
    return sum + (tierPrices.get(sub.tier_id) || 0);
  }, 0) || 0;
  
  // Activities
  const { count: totalActivities } = await supabase
    .from("activities")
    .select("*", { count: "exact", head: true });
  
  const { count: completedActivities } = await supabase
    .from("activity_progress")
    .select("*", { count: "exact", head: true })
    .eq("completed", true);
  
  // Calculate growth percentages
  const userGrowth = newUsersLastWeek 
    ? Math.round(((newUsersThisWeek || 0) - (newUsersLastWeek || 0)) / newUsersLastWeek * 100)
    : (newUsersThisWeek || 0) > 0 ? 100 : 0;
  
  const subscriptionGrowth = subscriptionsLastMonth
    ? Math.round(((activeSubscriptions || 0) - (subscriptionsLastMonth || 0)) / subscriptionsLastMonth * 100)
    : (activeSubscriptions || 0) > 0 ? 100 : 0;
  
  const revenueGrowth = lastMonthRevenue
    ? Math.round((monthlyRevenue - lastMonthRevenue) / lastMonthRevenue * 100)
    : monthlyRevenue > 0 ? 100 : 0;
  
  return {
    totalUsers: totalUsers || 0,
    newUsersThisWeek: newUsersThisWeek || 0,
    newUsersLastWeek: newUsersLastWeek || 0,
    userGrowth,
    totalCourses: totalCourses || 0,
    publishedCourses: publishedCourses || 0,
    activeSubscriptions: activeSubscriptions || 0,
    subscriptionsLastMonth: subscriptionsLastMonth || 0,
    subscriptionGrowth,
    monthlyRevenue,
    lastMonthRevenue,
    revenueGrowth,
    totalActivities: totalActivities || 0,
    completedActivities: completedActivities || 0,
  };
}

// ============================================
// User Management
// ============================================

export interface AdminUser {
  id: string;
  email: string;
  full_name: string | null;
  avatar_url: string | null;
  role: "user" | "admin";
  created_at: string;
  subscription?: {
    status: string;
    tier_name: string;
    current_period_end: string;
  } | null;
  stats?: {
    total_xp: number;
    current_streak: number;
    activities_completed: number;
  } | null;
}

export async function getUsers(options?: {
  page?: number;
  limit?: number;
  search?: string;
  role?: "user" | "admin" | "all";
}): Promise<{ users: AdminUser[]; total: number }> {
  const { supabase } = await verifyAdmin();
  const page = options?.page || 1;
  const limit = options?.limit || 20;
  const offset = (page - 1) * limit;
  
  let query = supabase
    .from("profiles")
    .select(`
      *,
      subscriptions(
        status,
        current_period_end,
        subscription_tiers(name)
      ),
      user_streaks(total_xp, current_streak)
    `, { count: "exact" });
  
  if (options?.search) {
    query = query.or(`email.ilike.%${options.search}%,full_name.ilike.%${options.search}%`);
  }
  
  if (options?.role && options.role !== "all") {
    query = query.eq("role", options.role);
  }
  
  const { data, count, error } = await query
    .order("created_at", { ascending: false })
    .range(offset, offset + limit - 1);
  
  if (error) {
    console.error("Error fetching users:", error);
    return { users: [], total: 0 };
  }
  
  // Get activity completion counts
  const userIds = data?.map(u => u.id) || [];
  const { data: activityCounts } = await supabase
    .from("activity_progress")
    .select("user_id")
    .in("user_id", userIds)
    .eq("completed", true);
  
  const completionMap = new Map<string, number>();
  activityCounts?.forEach(ac => {
    completionMap.set(ac.user_id, (completionMap.get(ac.user_id) || 0) + 1);
  });
  
  const users: AdminUser[] = (data || []).map(u => ({
    id: u.id,
    email: u.email,
    full_name: u.full_name,
    avatar_url: u.avatar_url,
    role: u.role,
    created_at: u.created_at,
    subscription: u.subscriptions?.[0] ? {
      status: u.subscriptions[0].status,
      tier_name: u.subscriptions[0].subscription_tiers?.name || "Unknown",
      current_period_end: u.subscriptions[0].current_period_end,
    } : null,
    stats: {
      total_xp: u.user_streaks?.total_xp || 0,
      current_streak: u.user_streaks?.current_streak || 0,
      activities_completed: completionMap.get(u.id) || 0,
    },
  }));
  
  return { users, total: count || 0 };
}

export async function updateUserRole(userId: string, role: "user" | "admin") {
  const { supabase } = await verifyAdmin();
  
  const { error } = await supabase
    .from("profiles")
    .update({ role })
    .eq("id", userId);
  
  if (error) {
    throw new Error("Failed to update user role");
  }
  
  return { success: true };
}

// ============================================
// Course Management
// ============================================

export interface AdminCourse {
  id: string;
  title: string;
  slug: string;
  description: string | null;
  difficulty: string;
  is_published: boolean;
  is_featured: boolean;
  created_at: string;
  updated_at: string;
  category: { id: string; name: string } | null;
  modules_count: number;
  activities_count: number;
  enrollments_count: number;
  total_xp: number;
}

export async function getCourses(): Promise<AdminCourse[]> {
  const { supabase } = await verifyAdmin();
  
  // Fetch all courses (including unpublished)
  const { data: courses, error } = await supabase
    .from("courses")
    .select(`
      *,
      category:categories(id, name),
      modules(id, total_xp, activities(id))
    `)
    .order("sort_order");
  
  if (error) {
    console.error("Error fetching courses:", error);
    return [];
  }
  
  // Get enrollment counts
  const courseIds = courses?.map(c => c.id) || [];
  const { data: enrollments } = await supabase
    .from("course_enrollments")
    .select("course_id")
    .in("course_id", courseIds);
  
  const enrollmentMap = new Map<string, number>();
  enrollments?.forEach(e => {
    enrollmentMap.set(e.course_id, (enrollmentMap.get(e.course_id) || 0) + 1);
  });
  
  return (courses || []).map(c => ({
    id: c.id,
    title: c.title,
    slug: c.slug,
    description: c.description,
    difficulty: c.difficulty,
    is_published: c.is_published,
    is_featured: c.is_featured,
    created_at: c.created_at,
    updated_at: c.updated_at,
    category: c.category,
    modules_count: c.modules?.length || 0,
    activities_count: c.modules?.reduce((sum: number, m: { activities: unknown[] }) => sum + (m.activities?.length || 0), 0) || 0,
    enrollments_count: enrollmentMap.get(c.id) || 0,
    total_xp: c.modules?.reduce((sum: number, m: { total_xp: number }) => sum + (m.total_xp || 0), 0) || 0,
  }));
}

export interface AdminCourseDetail {
  course: AdminCourse & {
    short_description: string | null;
    thumbnail_url: string | null;
    duration_hours: number | null;
    stripe_basic_price_id: string | null;
    stripe_advanced_price_id: string | null;
  };
  modules: Array<{
    id: string;
    title: string;
    slug: string;
    order_index: number;
    estimated_minutes: number | null;
    total_xp: number;
    required_plan: string;
    is_published: boolean;
    activities: Array<{
      id: string;
      title: string;
      slug: string;
      type: string;
      xp: number;
      required_plan: string;
      is_published: boolean;
      completions_count: number;
    }>;
  }>;
}

export async function getCourseDetail(slug: string): Promise<AdminCourseDetail | null> {
  const { supabase } = await verifyAdmin();
  
  const { data: course, error } = await supabase
    .from("courses")
    .select(`
      *,
      category:categories(id, name),
      modules(
        id, title, slug, order_index, estimated_minutes, total_xp, required_plan, is_published,
        activities(id, title, slug, type, xp, required_plan, is_published, order_index)
      )
    `)
    .eq("slug", slug)
    .single();
  
  if (error || !course) {
    console.error("Error fetching course:", error);
    return null;
  }
  
  // Get activity completion counts
  const activityIds = course.modules?.flatMap((m: { activities: { id: string }[] }) => 
    m.activities?.map((a: { id: string }) => a.id) || []
  ) || [];
  
  const { data: completions } = await supabase
    .from("activity_progress")
    .select("activity_id")
    .in("activity_id", activityIds)
    .eq("completed", true);
  
  const completionMap = new Map<string, number>();
  completions?.forEach(c => {
    completionMap.set(c.activity_id, (completionMap.get(c.activity_id) || 0) + 1);
  });
  
  // Get enrollment count
  const { count: enrollments } = await supabase
    .from("course_enrollments")
    .select("*", { count: "exact", head: true })
    .eq("course_id", course.id);
  
  return {
    course: {
      id: course.id,
      title: course.title,
      slug: course.slug,
      description: course.description,
      short_description: course.short_description,
      thumbnail_url: course.thumbnail_url,
      duration_hours: course.duration_hours,
      difficulty: course.difficulty,
      is_published: course.is_published,
      is_featured: course.is_featured,
      created_at: course.created_at,
      updated_at: course.updated_at,
      category: course.category,
      modules_count: course.modules?.length || 0,
      activities_count: activityIds.length,
      enrollments_count: enrollments || 0,
      total_xp: course.modules?.reduce((sum: number, m: { total_xp: number }) => sum + (m.total_xp || 0), 0) || 0,
      stripe_basic_price_id: course.stripe_basic_price_id || null,
      stripe_advanced_price_id: course.stripe_advanced_price_id || null,
    },
    modules: (course.modules || [])
      .sort((a: { order_index: number }, b: { order_index: number }) => a.order_index - b.order_index)
      .map((m: {
        id: string;
        title: string;
        slug: string;
        order_index: number;
        estimated_minutes: number | null;
        total_xp: number;
        required_plan: string;
        is_published: boolean;
        activities: Array<{
          id: string;
          title: string;
          slug: string;
          type: string;
          xp: number;
          required_plan: string;
          is_published: boolean;
          order_index: number;
        }>;
      }) => ({
        ...m,
        activities: (m.activities || [])
          .sort((a, b) => a.order_index - b.order_index)
          .map(a => ({
            ...a,
            completions_count: completionMap.get(a.id) || 0,
          })),
      })),
  };
}

// ============================================
// Revenue & Subscriptions
// ============================================

export interface RevenueData {
  subscriptionsByTier: Array<{
    tier_name: string;
    count: number;
    revenue: number;
  }>;
  subscriptionsByStatus: Array<{
    status: string;
    count: number;
  }>;
  monthlyRevenue: Array<{
    month: string;
    revenue: number;
    subscriptions: number;
  }>;
  totalRevenue: number;
  mrr: number;
  arr: number;
  churnRate: number;
}

export async function getRevenueData(): Promise<RevenueData> {
  const { supabase } = await verifyAdmin();
  
  // Get all subscriptions with tiers
  const { data: subscriptions } = await supabase
    .from("subscriptions")
    .select(`
      *,
      tier:subscription_tiers(id, name, price_monthly)
    `);
  
  // Get all tiers
  const { data: tiers } = await supabase
    .from("subscription_tiers")
    .select("*");
  
  const now = new Date();
  
  // Calculate subscriptions by tier
  const tierCounts = new Map<string, { count: number; revenue: number }>();
  
  subscriptions?.forEach(sub => {
    if (sub.status === "active" || sub.status === "trialing") {
      const tierName = sub.tier?.name || "Unknown";
      const current = tierCounts.get(tierName) || { count: 0, revenue: 0 };
      tierCounts.set(tierName, {
        count: current.count + 1,
        revenue: current.revenue + (sub.tier?.price_monthly || 0),
      });
    }
  });
  
  const subscriptionsByTier = Array.from(tierCounts.entries()).map(([tier_name, data]) => ({
    tier_name,
    count: data.count,
    revenue: data.revenue,
  }));
  
  // Calculate subscriptions by status
  const statusCounts = new Map<string, number>();
  subscriptions?.forEach(sub => {
    statusCounts.set(sub.status, (statusCounts.get(sub.status) || 0) + 1);
  });
  
  const subscriptionsByStatus = Array.from(statusCounts.entries()).map(([status, count]) => ({
    status,
    count,
  }));
  
  // Calculate monthly revenue for the past 6 months
  const monthlyRevenue: Array<{ month: string; revenue: number; subscriptions: number }> = [];
  
  for (let i = 5; i >= 0; i--) {
    const monthStart = new Date(now.getFullYear(), now.getMonth() - i, 1);
    const monthEnd = new Date(now.getFullYear(), now.getMonth() - i + 1, 0);
    const monthName = monthStart.toLocaleString('default', { month: 'short', year: '2-digit' });
    
    const monthSubs = subscriptions?.filter(sub => {
      const createdAt = new Date(sub.created_at);
      return createdAt >= monthStart && createdAt <= monthEnd && 
             (sub.status === "active" || sub.status === "trialing");
    }) || [];
    
    const revenue = monthSubs.reduce((sum, sub) => sum + (sub.tier?.price_monthly || 0), 0);
    
    monthlyRevenue.push({
      month: monthName,
      revenue,
      subscriptions: monthSubs.length,
    });
  }
  
  // Calculate MRR (Monthly Recurring Revenue)
  const activeSubs = subscriptions?.filter(sub => 
    (sub.status === "active" || sub.status === "trialing") &&
    new Date(sub.current_period_end) > now
  ) || [];
  
  const mrr = activeSubs.reduce((sum, sub) => sum + (sub.tier?.price_monthly || 0), 0);
  const arr = mrr * 12;
  
  // Calculate churn rate
  const cancelledThisMonth = subscriptions?.filter(sub => {
    if (sub.status !== "cancelled" && sub.status !== "expired") return false;
    const cancelledAt = sub.cancelled_at ? new Date(sub.cancelled_at) : null;
    if (!cancelledAt) return false;
    const monthStart = new Date(now.getFullYear(), now.getMonth(), 1);
    return cancelledAt >= monthStart;
  }).length || 0;
  
  const totalActiveStart = activeSubs.length + cancelledThisMonth;
  const churnRate = totalActiveStart > 0 ? Math.round((cancelledThisMonth / totalActiveStart) * 100) : 0;
  
  // Total revenue (all time)
  const totalRevenue = subscriptions?.reduce((sum, sub) => {
    if (sub.status === "active" || sub.status === "trialing") {
      return sum + (sub.tier?.price_monthly || 0);
    }
    return sum;
  }, 0) || 0;
  
  return {
    subscriptionsByTier,
    subscriptionsByStatus,
    monthlyRevenue,
    totalRevenue,
    mrr,
    arr,
    churnRate,
  };
}

// ============================================
// Recent Activity
// ============================================

export interface RecentActivity {
  id: string;
  type: "signup" | "subscription" | "completion" | "course_start";
  description: string;
  user: { email: string; name: string | null };
  timestamp: string;
}

export async function getRecentActivity(limit = 10): Promise<RecentActivity[]> {
  const { supabase } = await verifyAdmin();
  
  const activities: RecentActivity[] = [];
  
  // Recent signups
  const { data: recentUsers } = await supabase
    .from("profiles")
    .select("id, email, full_name, created_at")
    .order("created_at", { ascending: false })
    .limit(5);
  
  recentUsers?.forEach(u => {
    activities.push({
      id: `signup-${u.id}`,
      type: "signup",
      description: "New user signed up",
      user: { email: u.email, name: u.full_name },
      timestamp: u.created_at,
    });
  });
  
  // Recent subscriptions
  const { data: recentSubs } = await supabase
    .from("subscriptions")
    .select(`
      id, created_at, status,
      user:profiles(email, full_name),
      tier:subscription_tiers(name)
    `)
    .order("created_at", { ascending: false })
    .limit(5);
  
  recentSubs?.forEach(s => {
    const tier = Array.isArray(s.tier) ? s.tier[0] : s.tier;
    const user = Array.isArray(s.user) ? s.user[0] : s.user;
    activities.push({
      id: `sub-${s.id}`,
      type: "subscription",
      description: `Subscribed to ${tier?.name || "Unknown"} (${s.status})`,
      user: { email: user?.email || "", name: user?.full_name },
      timestamp: s.created_at,
    });
  });
  
  // Recent course enrollments
  const { data: recentEnrollments } = await supabase
    .from("course_enrollments")
    .select(`
      id, enrolled_at,
      user:profiles(email, full_name),
      course:courses(title)
    `)
    .order("enrolled_at", { ascending: false })
    .limit(5);
  
  recentEnrollments?.forEach(e => {
    const course = Array.isArray(e.course) ? e.course[0] : e.course;
    const user = Array.isArray(e.user) ? e.user[0] : e.user;
    activities.push({
      id: `enroll-${e.id}`,
      type: "course_start",
      description: `Started course: ${course?.title || "Unknown"}`,
      user: { email: user?.email || "", name: user?.full_name },
      timestamp: e.enrolled_at,
    });
  });
  
  // Sort by timestamp and return limited results
  return activities
    .sort((a, b) => new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime())
    .slice(0, limit);
}

