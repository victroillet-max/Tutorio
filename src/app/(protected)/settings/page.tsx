import { createClient } from "@/utils/supabase/server";
import { Bell, Shield, CreditCard, User } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";

export const metadata = {
  title: "Settings | Tutorio",
  description: "Manage your account settings",
};

export default async function SettingsPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  const { data: profile } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", user!.id)
    .single();

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* Header */}
      <div className="mb-8">
        <h1 
          className="text-3xl font-bold mb-2 text-[var(--foreground)]"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Settings
        </h1>
        <p className="text-[var(--foreground-muted)]">
          Manage your account preferences and settings.
        </p>
      </div>

      <div className="space-y-8">
        {/* Account Section */}
        <SettingsSection
          icon={User}
          title="Account"
          description="Manage your account details"
        >
          <div className="space-y-4">
            <SettingRow
              label="Email"
              value={user?.email || ""}
              action={
                <Button variant="outline" size="sm" disabled>
                  Change
                </Button>
              }
            />
            <SettingRow
              label="Full Name"
              value={profile?.full_name || "Not set"}
              action={
                <Button variant="outline" size="sm" disabled>
                  Edit
                </Button>
              }
            />
            <SettingRow
              label="Password"
              value="Last changed: Unknown"
              action={
                <Button variant="outline" size="sm" disabled>
                  Update
                </Button>
              }
            />
          </div>
        </SettingsSection>

        <Separator className="bg-[var(--border)]" />

        {/* Subscription Section */}
        <SettingsSection
          icon={CreditCard}
          title="Subscription"
          description="Manage your subscription and billing"
        >
          <div className="p-4 rounded-xl bg-[var(--background-secondary)] border border-[var(--border)]">
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium text-[var(--foreground)]">Free Plan</p>
                <p className="text-sm text-[var(--foreground-muted)]">
                  Access to free preview lessons only
                </p>
              </div>
              <Button>
                Upgrade
              </Button>
            </div>
          </div>
        </SettingsSection>

        <Separator className="bg-[var(--border)]" />

        {/* Notifications Section */}
        <SettingsSection
          icon={Bell}
          title="Notifications"
          description="Configure how you receive updates"
        >
          <div className="space-y-4">
            <ToggleSetting
              label="Email notifications"
              description="Receive updates about your courses"
              enabled={true}
            />
            <ToggleSetting
              label="Marketing emails"
              description="Receive news and special offers"
              enabled={false}
            />
          </div>
        </SettingsSection>

        <Separator className="bg-[var(--border)]" />

        {/* Security Section */}
        <SettingsSection
          icon={Shield}
          title="Security"
          description="Protect your account"
        >
          <div className="space-y-4">
            <SettingRow
              label="Two-factor authentication"
              value="Not enabled"
              action={
                <Button variant="outline" size="sm" disabled>
                  Enable
                </Button>
              }
            />
            <SettingRow
              label="Active sessions"
              value="1 active session"
              action={
                <Button variant="outline" size="sm" disabled>
                  Manage
                </Button>
              }
            />
          </div>
        </SettingsSection>

        <Separator className="bg-[var(--border)]" />

        {/* Danger Zone */}
        <div className="card-elevated p-6 border-red-200">
          <h3 
            className="text-lg font-semibold text-red-600 mb-2"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Danger Zone
          </h3>
          <p className="text-sm text-[var(--foreground-muted)] mb-4">
            Permanently delete your account and all associated data.
          </p>
          <Button variant="destructive" disabled>
            Delete Account
          </Button>
        </div>
      </div>
    </div>
  );
}

function SettingsSection({
  icon: Icon,
  title,
  description,
  children,
}: {
  icon: React.ComponentType<{ className?: string }>;
  title: string;
  description: string;
  children: React.ReactNode;
}) {
  return (
    <div>
      <div className="flex items-start gap-4 mb-6">
        <div className="w-10 h-10 rounded-lg bg-[var(--progress-bg)] flex items-center justify-center">
          <Icon className="w-5 h-5 text-[var(--primary)]" />
        </div>
        <div>
          <h2 
            className="text-lg font-semibold text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            {title}
          </h2>
          <p className="text-sm text-[var(--foreground-muted)]">{description}</p>
        </div>
      </div>
      <div className="ml-14">{children}</div>
    </div>
  );
}

function SettingRow({
  label,
  value,
  action,
}: {
  label: string;
  value: string;
  action?: React.ReactNode;
}) {
  return (
    <div className="flex items-center justify-between py-3">
      <div>
        <p className="font-medium text-[var(--foreground)]">{label}</p>
        <p className="text-sm text-[var(--foreground-muted)]">{value}</p>
      </div>
      {action}
    </div>
  );
}

function ToggleSetting({
  label,
  description,
  enabled,
}: {
  label: string;
  description: string;
  enabled: boolean;
}) {
  return (
    <div className="flex items-center justify-between py-3">
      <div>
        <p className="font-medium text-[var(--foreground)]">{label}</p>
        <p className="text-sm text-[var(--foreground-muted)]">{description}</p>
      </div>
      <button
        className={`relative w-11 h-6 rounded-full transition-colors ${
          enabled ? "bg-[var(--primary)]" : "bg-[var(--border)]"
        }`}
        disabled
      >
        <span
          className={`absolute top-1 w-4 h-4 rounded-full bg-white shadow-sm transition-transform ${
            enabled ? "left-6" : "left-1"
          }`}
        />
      </button>
    </div>
  );
}
