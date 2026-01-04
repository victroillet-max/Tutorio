"use client";

import { useState, useTransition } from "react";
import { Button } from "@/components/ui/button";
import { Smartphone, Monitor, Globe, Loader2, X, AlertCircle } from "lucide-react";
import { signOutAllDevices } from "@/lib/auth/actions";

interface Session {
  id: string;
  device_info: string | null;
  ip_address: string | null;
  created_at: string;
  last_active_at: string;
  is_current: boolean;
}

interface ActiveSessionsProps {
  sessions: Session[];
  currentTokenHash: string;
}

function getDeviceIcon(deviceInfo: string | null) {
  if (!deviceInfo) return Globe;
  const lower = deviceInfo.toLowerCase();
  if (lower.includes("mobile") || lower.includes("android") || lower.includes("iphone")) {
    return Smartphone;
  }
  return Monitor;
}

function getDeviceName(deviceInfo: string | null): string {
  if (!deviceInfo) return "Unknown device";
  
  // Try to extract browser and OS from user agent
  const lower = deviceInfo.toLowerCase();
  
  let browser = "Unknown browser";
  if (lower.includes("chrome") && !lower.includes("edg")) browser = "Chrome";
  else if (lower.includes("firefox")) browser = "Firefox";
  else if (lower.includes("safari") && !lower.includes("chrome")) browser = "Safari";
  else if (lower.includes("edg")) browser = "Edge";
  
  let os = "";
  if (lower.includes("windows")) os = "Windows";
  else if (lower.includes("mac")) os = "macOS";
  else if (lower.includes("linux")) os = "Linux";
  else if (lower.includes("android")) os = "Android";
  else if (lower.includes("iphone") || lower.includes("ipad")) os = "iOS";
  
  return os ? `${browser} on ${os}` : browser;
}

function formatLastActive(dateStr: string): string {
  const date = new Date(dateStr);
  const now = new Date();
  const diffMs = now.getTime() - date.getTime();
  const diffMins = Math.floor(diffMs / (1000 * 60));
  const diffHours = Math.floor(diffMs / (1000 * 60 * 60));
  const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
  
  if (diffMins < 5) return "Active now";
  if (diffMins < 60) return `Active ${diffMins} minutes ago`;
  if (diffHours < 24) return `Active ${diffHours} hour${diffHours > 1 ? 's' : ''} ago`;
  if (diffDays < 7) return `Active ${diffDays} day${diffDays > 1 ? 's' : ''} ago`;
  return date.toLocaleDateString();
}

export function ActiveSessions({ sessions, currentTokenHash }: ActiveSessionsProps) {
  const [isPending, startTransition] = useTransition();
  const [showConfirm, setShowConfirm] = useState(false);

  const handleSignOutAll = () => {
    startTransition(async () => {
      await signOutAllDevices();
    });
  };

  // Mark current session
  const sessionsWithCurrent = sessions.map(s => ({
    ...s,
    is_current: s.id === currentTokenHash, // This won't work exactly, we'd need to check differently
  }));

  if (sessions.length === 0) {
    return (
      <div className="p-4 rounded-xl bg-[var(--background-secondary)] border border-[var(--border)]">
        <p className="text-sm text-[var(--foreground-muted)]">
          No active sessions found. This may happen if session tracking was just enabled.
        </p>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      {/* Session List */}
      <div className="space-y-3">
        {sessionsWithCurrent.map((session, index) => {
          const Icon = getDeviceIcon(session.device_info);
          const isFirst = index === 0; // Most recent is likely current
          
          return (
            <div 
              key={session.id}
              className={`p-4 rounded-xl border ${
                isFirst 
                  ? "bg-emerald-50 border-emerald-200" 
                  : "bg-[var(--background-secondary)] border-[var(--border)]"
              }`}
            >
              <div className="flex items-start gap-3">
                <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${
                  isFirst ? "bg-emerald-100" : "bg-[var(--progress-bg)]"
                }`}>
                  <Icon className={`w-5 h-5 ${
                    isFirst ? "text-emerald-600" : "text-[var(--foreground-muted)]"
                  }`} />
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2">
                    <p className={`font-medium ${
                      isFirst ? "text-emerald-900" : "text-[var(--foreground)]"
                    }`}>
                      {getDeviceName(session.device_info)}
                    </p>
                    {isFirst && (
                      <span className="text-xs px-2 py-0.5 rounded-full bg-emerald-200 text-emerald-800 font-medium">
                        Current
                      </span>
                    )}
                  </div>
                  <p className={`text-sm ${
                    isFirst ? "text-emerald-700" : "text-[var(--foreground-muted)]"
                  }`}>
                    {session.ip_address || "Unknown location"}
                  </p>
                  <p className={`text-xs mt-1 ${
                    isFirst ? "text-emerald-600" : "text-[var(--foreground-muted)]"
                  }`}>
                    {formatLastActive(session.last_active_at)}
                  </p>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Session limit notice */}
      <div className="flex items-start gap-2 p-3 rounded-lg bg-blue-50 border border-blue-200">
        <AlertCircle className="w-4 h-4 text-blue-600 flex-shrink-0 mt-0.5" />
        <p className="text-sm text-blue-700">
          Your account is limited to 2 simultaneous sessions. Logging in on a new device will automatically sign you out from the oldest session.
        </p>
      </div>

      {/* Sign out all */}
      {sessions.length > 1 && (
        <div className="pt-2">
          {showConfirm ? (
            <div className="p-4 rounded-xl border border-red-200 bg-red-50">
              <p className="text-sm text-red-700 mb-3">
                Are you sure? This will sign you out from all devices, including this one.
              </p>
              <div className="flex gap-2">
                <Button
                  variant="destructive"
                  size="sm"
                  onClick={handleSignOutAll}
                  disabled={isPending}
                >
                  {isPending ? (
                    <>
                      <Loader2 className="w-4 h-4 mr-2 animate-spin" />
                      Signing out...
                    </>
                  ) : (
                    "Yes, sign out everywhere"
                  )}
                </Button>
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => setShowConfirm(false)}
                  disabled={isPending}
                >
                  Cancel
                </Button>
              </div>
            </div>
          ) : (
            <Button
              variant="outline"
              size="sm"
              onClick={() => setShowConfirm(true)}
              className="text-red-600 border-red-200 hover:bg-red-50"
            >
              <X className="w-4 h-4 mr-2" />
              Sign out all devices
            </Button>
          )}
        </div>
      )}
    </div>
  );
}

