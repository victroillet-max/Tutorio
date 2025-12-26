import { createClient } from "@/utils/supabase/server";
import { User, Mail, Calendar, Award } from "lucide-react";

export const metadata = {
  title: "Profile | Tutorio",
  description: "Your profile and learning statistics",
};

export default async function ProfilePage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  const { data: profile } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", user!.id)
    .single();

  const displayName = profile?.full_name || user?.email?.split("@")[0] || "User";
  const initials = displayName
    .split(" ")
    .map((n: string) => n[0])
    .join("")
    .toUpperCase()
    .slice(0, 2);

  const memberSince = new Date(user?.created_at || Date.now()).toLocaleDateString("en-US", {
    month: "long",
    year: "numeric",
  });

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Header */}
      <div className="mb-8">
        <h1 
          className="text-3xl font-bold mb-2 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Your Profile
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Manage your account information and view your learning progress.
        </p>
      </div>

      {/* Profile Card */}
      <div className="card-elevated p-8 mb-8">
        <div className="flex items-start gap-6">
          {/* Avatar */}
          <div className="w-24 h-24 rounded-2xl bg-[var(--primary)] flex items-center justify-center text-white text-3xl font-bold shadow-lg shadow-[var(--primary)]/25">
            {initials}
          </div>

          {/* Info */}
          <div className="flex-1">
            <h2 
              className="text-2xl font-bold mb-1 text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)' }}
            >
              {displayName}
            </h2>
            
            <div className="space-y-2 mt-4">
              <div className="flex items-center gap-2 text-[var(--foreground-muted)]">
                <Mail className="w-4 h-4" />
                <span>{user?.email}</span>
              </div>
              <div className="flex items-center gap-2 text-[var(--foreground-muted)]">
                <Calendar className="w-4 h-4" />
                <span>Member since {memberSince}</span>
              </div>
              <div className="flex items-center gap-2 text-[var(--foreground-muted)]">
                <Award className="w-4 h-4" />
                <span className="capitalize">{profile?.role || "user"} account</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <StatCard label="Courses Started" value="0" color="blue" />
        <StatCard label="Lessons Completed" value="0" color="green" />
        <StatCard label="Hours Learned" value="0" color="purple" />
        <StatCard label="Certificates" value="0" color="orange" />
      </div>

      {/* Recent Activity */}
      <div className="card-elevated p-6">
        <h3 
          className="text-lg font-semibold mb-4 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Recent Activity
        </h3>
        <div className="text-center py-8 text-[var(--foreground-muted)]">
          <p>No activity yet.</p>
          <p className="text-sm mt-2">Start learning to see your progress here.</p>
        </div>
      </div>
    </div>
  );
}

function StatCard({ label, value, color }: { label: string; value: string; color: "blue" | "green" | "purple" | "orange" }) {
  const colorClasses = {
    blue: "bg-blue-50 text-blue-600 border-blue-100",
    green: "bg-emerald-50 text-emerald-600 border-emerald-100",
    purple: "bg-purple-50 text-purple-600 border-purple-100",
    orange: "bg-orange-50 text-orange-600 border-orange-100",
  };

  return (
    <div className="card-elevated p-5 text-center">
      <p className={`text-2xl font-bold mb-1 ${colorClasses[color].split(' ')[1]}`} style={{ fontFamily: 'var(--font-heading)' }}>
        {value}
      </p>
      <p className="text-sm text-[var(--foreground-muted)]">{label}</p>
    </div>
  );
}
