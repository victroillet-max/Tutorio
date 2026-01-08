"use client";

import { useState } from "react";
import { createClient } from "@/utils/supabase/client";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { X, Check, Loader2 } from "lucide-react";

interface EditableNameProps {
  currentName: string;
  userId: string;
}

export function EditableName({ currentName, userId }: EditableNameProps) {
  const [isEditing, setIsEditing] = useState(false);
  const [name, setName] = useState(currentName || "");
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSave = async () => {
    if (!name.trim()) {
      setError("Name cannot be empty");
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      const supabase = createClient();
      const { error: updateError } = await supabase
        .from("profiles")
        .update({ full_name: name.trim() })
        .eq("id", userId);

      if (updateError) {
        setError(updateError.message);
        return;
      }

      setIsEditing(false);
      // Refresh the page to show updated name
      window.location.reload();
    } catch (err) {
      setError("Failed to update name");
    } finally {
      setIsLoading(false);
    }
  };

  const handleCancel = () => {
    setName(currentName || "");
    setIsEditing(false);
    setError(null);
  };

  if (!isEditing) {
    return (
      <div className="flex items-center justify-between py-3">
        <div>
          <p className="font-medium text-[var(--foreground)]">Full Name</p>
          <p className="text-sm text-[var(--foreground-muted)]">{currentName || "Not set"}</p>
        </div>
        <Button variant="outline" size="sm" onClick={() => setIsEditing(true)}>
          Edit
        </Button>
      </div>
    );
  }

  return (
    <div className="py-3">
      <p className="font-medium text-[var(--foreground)] mb-2">Full Name</p>
      <div className="flex items-center gap-2">
        <Input
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Enter your name"
          className="max-w-xs"
          disabled={isLoading}
        />
        <Button
          size="sm"
          onClick={handleSave}
          disabled={isLoading}
          className="bg-emerald-600 hover:bg-emerald-700"
        >
          {isLoading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Check className="w-4 h-4" />}
        </Button>
        <Button
          size="sm"
          variant="outline"
          onClick={handleCancel}
          disabled={isLoading}
        >
          <X className="w-4 h-4" />
        </Button>
      </div>
      {error && <p className="text-sm text-red-600 mt-2">{error}</p>}
    </div>
  );
}

interface PasswordUpdateProps {
  userEmail: string;
}

export function PasswordUpdate({ userEmail }: PasswordUpdateProps) {
  const [isEditing, setIsEditing] = useState(false);
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);

  const handleSave = async () => {
    setError(null);
    setSuccess(false);

    if (newPassword.length < 8) {
      setError("Password must be at least 8 characters");
      return;
    }

    if (newPassword !== confirmPassword) {
      setError("Passwords do not match");
      return;
    }

    setIsLoading(true);

    try {
      const supabase = createClient();
      
      // First verify current password by signing in
      const { error: signInError } = await supabase.auth.signInWithPassword({
        email: userEmail,
        password: currentPassword,
      });

      if (signInError) {
        setError("Current password is incorrect");
        setIsLoading(false);
        return;
      }

      // Update the password
      const { error: updateError } = await supabase.auth.updateUser({
        password: newPassword,
      });

      if (updateError) {
        setError(updateError.message);
        return;
      }

      setSuccess(true);
      setCurrentPassword("");
      setNewPassword("");
      setConfirmPassword("");
      setTimeout(() => {
        setIsEditing(false);
        setSuccess(false);
      }, 2000);
    } catch (err) {
      setError("Failed to update password");
    } finally {
      setIsLoading(false);
    }
  };

  const handleCancel = () => {
    setCurrentPassword("");
    setNewPassword("");
    setConfirmPassword("");
    setIsEditing(false);
    setError(null);
    setSuccess(false);
  };

  if (!isEditing) {
    return (
      <div className="flex items-center justify-between py-3">
        <div>
          <p className="font-medium text-[var(--foreground)]">Password</p>
          <p className="text-sm text-[var(--foreground-muted)]">Update your password</p>
        </div>
        <Button variant="outline" size="sm" onClick={() => setIsEditing(true)}>
          Update
        </Button>
      </div>
    );
  }

  return (
    <div className="py-3">
      <p className="font-medium text-[var(--foreground)] mb-3">Update Password</p>
      <div className="space-y-3 max-w-sm">
        <div>
          <label className="text-sm text-[var(--foreground-muted)]">Current Password</label>
          <Input
            type="password"
            value={currentPassword}
            onChange={(e) => setCurrentPassword(e.target.value)}
            placeholder="Current password"
            disabled={isLoading}
          />
        </div>
        <div>
          <label className="text-sm text-[var(--foreground-muted)]">New Password</label>
          <Input
            type="password"
            value={newPassword}
            onChange={(e) => setNewPassword(e.target.value)}
            placeholder="New password (min 8 characters)"
            disabled={isLoading}
          />
        </div>
        <div>
          <label className="text-sm text-[var(--foreground-muted)]">Confirm New Password</label>
          <Input
            type="password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            placeholder="Confirm new password"
            disabled={isLoading}
          />
        </div>
        <div className="flex items-center gap-2 pt-2">
          <Button
            size="sm"
            onClick={handleSave}
            disabled={isLoading}
            className="bg-emerald-600 hover:bg-emerald-700"
          >
            {isLoading ? (
              <Loader2 className="w-4 h-4 animate-spin mr-2" />
            ) : success ? (
              <Check className="w-4 h-4 mr-2" />
            ) : null}
            {success ? "Updated!" : "Save Password"}
          </Button>
          <Button
            size="sm"
            variant="outline"
            onClick={handleCancel}
            disabled={isLoading}
          >
            Cancel
          </Button>
        </div>
        {error && <p className="text-sm text-red-600">{error}</p>}
        {success && <p className="text-sm text-emerald-600">Password updated successfully!</p>}
      </div>
    </div>
  );
}

