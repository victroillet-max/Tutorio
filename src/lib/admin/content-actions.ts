"use server";

import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";
import { revalidatePath } from "next/cache";
import { logger } from "@/lib/logging";
import type { 
  Activity, 
  Module, 
  Course, 
  UserRole,
  ContentChangeType,
  ContentEntityType,
  ContentChangeStatus,
  PendingContentChange,
  PendingContentChangeWithSubmitter
} from "@/lib/database.types";

const log = logger.child({ module: "admin/content-actions" });

// ============================================
// Role Verification Helpers
// ============================================

/**
 * Verify that the current user has content admin access
 * Accepts both 'admin' and 'contentadmin' roles
 */
async function verifyContentAdmin() {
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
  
  const role = profile?.role as UserRole | undefined;
  
  if (!role || !["admin", "contentadmin"].includes(role)) {
    redirect("/dashboard");
  }
  
  return { supabase, user, role };
}

/**
 * Verify that the current user is a super admin
 * Only 'admin' role has full access
 */
async function verifySuperAdmin() {
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
// Content Browsing (Read Operations)
// ============================================

export interface CourseWithModules extends Course {
  modules: (Module & {
    activities: Activity[];
  })[];
}

/**
 * Get all courses with their modules and activities for the content tree
 */
export async function getContentTree(): Promise<CourseWithModules[]> {
  const { supabase } = await verifyContentAdmin();
  
  const { data: courses, error } = await supabase
    .from("courses")
    .select(`
      *,
      modules(
        *,
        activities(*)
      )
    `)
    .order("sort_order");
  
  if (error) {
    log.error("Error fetching content tree", error);
    return [];
  }
  
  // Sort modules and activities by order_index
  return (courses || []).map(course => ({
    ...course,
    modules: (course.modules || [])
      .sort((a: Module, b: Module) => a.order_index - b.order_index)
      .map((module: Module & { activities: Activity[] }) => ({
        ...module,
        activities: (module.activities || [])
          .sort((a: Activity, b: Activity) => a.order_index - b.order_index)
      }))
  }));
}

/**
 * Get a single activity by ID for editing
 */
export async function getActivityById(activityId: string): Promise<Activity | null> {
  const { supabase } = await verifyContentAdmin();
  
  const { data, error } = await supabase
    .from("activities")
    .select("*")
    .eq("id", activityId)
    .single();
  
  if (error) {
    log.error("Error fetching activity", error, { activityId });
    return null;
  }
  
  return data;
}

/**
 * Get a module with its activities
 */
export async function getModuleWithActivities(moduleId: string): Promise<(Module & { activities: Activity[] }) | null> {
  const { supabase } = await verifyContentAdmin();
  
  const { data, error } = await supabase
    .from("modules")
    .select(`
      *,
      activities(*)
    `)
    .eq("id", moduleId)
    .single();
  
  if (error) {
    log.error("Error fetching module", error, { moduleId });
    return null;
  }
  
  return {
    ...data,
    activities: (data.activities || []).sort((a: Activity, b: Activity) => a.order_index - b.order_index)
  };
}

// ============================================
// Pending Changes Management
// ============================================

/**
 * Submit a change to an existing activity for review
 */
export async function submitActivityChange(
  activityId: string,
  proposedData: Partial<Activity>,
  title: string,
  description?: string
): Promise<{ success: boolean; changeId?: string; error?: string }> {
  const { supabase, user } = await verifyContentAdmin();
  
  try {
    // Get current activity data
    const { data: currentActivity, error: fetchError } = await supabase
      .from("activities")
      .select("*")
      .eq("id", activityId)
      .single();
    
    if (fetchError || !currentActivity) {
      return { success: false, error: "Activity not found" };
    }
    
    // Create pending change record
    const { data: change, error: insertError } = await supabase
      .from("pending_content_changes")
      .insert({
        entity_type: "activity" as ContentEntityType,
        entity_id: activityId,
        parent_id: currentActivity.module_id,
        change_type: "update" as ContentChangeType,
        current_data: currentActivity,
        proposed_data: proposedData,
        submitted_by: user.id,
        title,
        description
      })
      .select()
      .single();
    
    if (insertError) {
      log.error("Error creating pending change", insertError);
      return { success: false, error: "Failed to submit change" };
    }
    
    revalidatePath("/admin/content");
    revalidatePath("/admin/content/pending");
    
    return { success: true, changeId: change.id };
  } catch (err) {
    log.error("Error in submitActivityChange", err);
    return { success: false, error: "An unexpected error occurred" };
  }
}

/**
 * Submit a new activity for review
 */
export async function submitNewActivity(
  moduleId: string,
  activityData: Omit<Activity, "id" | "created_at" | "updated_at">,
  title: string,
  description?: string
): Promise<{ success: boolean; changeId?: string; error?: string }> {
  const { supabase, user } = await verifyContentAdmin();
  
  try {
    // Verify module exists
    const { data: module, error: moduleError } = await supabase
      .from("modules")
      .select("id")
      .eq("id", moduleId)
      .single();
    
    if (moduleError || !module) {
      return { success: false, error: "Module not found" };
    }
    
    // Create pending change record for new activity
    const { data: change, error: insertError } = await supabase
      .from("pending_content_changes")
      .insert({
        entity_type: "activity" as ContentEntityType,
        entity_id: null, // NULL for new entities
        parent_id: moduleId,
        change_type: "create" as ContentChangeType,
        current_data: null,
        proposed_data: { ...activityData, module_id: moduleId },
        submitted_by: user.id,
        title,
        description
      })
      .select()
      .single();
    
    if (insertError) {
      log.error("Error creating pending new activity", insertError);
      return { success: false, error: "Failed to submit new activity" };
    }
    
    revalidatePath("/admin/content");
    revalidatePath("/admin/content/pending");
    
    return { success: true, changeId: change.id };
  } catch (err) {
    log.error("Error in submitNewActivity", err);
    return { success: false, error: "An unexpected error occurred" };
  }
}

/**
 * Submit an activity deletion for review
 */
export async function submitActivityDelete(
  activityId: string,
  title: string,
  description?: string
): Promise<{ success: boolean; changeId?: string; error?: string }> {
  const { supabase, user } = await verifyContentAdmin();
  
  try {
    // Get current activity data
    const { data: currentActivity, error: fetchError } = await supabase
      .from("activities")
      .select("*")
      .eq("id", activityId)
      .single();
    
    if (fetchError || !currentActivity) {
      return { success: false, error: "Activity not found" };
    }
    
    // Create pending change record
    const { data: change, error: insertError } = await supabase
      .from("pending_content_changes")
      .insert({
        entity_type: "activity" as ContentEntityType,
        entity_id: activityId,
        parent_id: currentActivity.module_id,
        change_type: "delete" as ContentChangeType,
        current_data: currentActivity,
        proposed_data: { deleted: true },
        submitted_by: user.id,
        title,
        description
      })
      .select()
      .single();
    
    if (insertError) {
      log.error("Error creating pending deletion", insertError);
      return { success: false, error: "Failed to submit deletion" };
    }
    
    revalidatePath("/admin/content");
    revalidatePath("/admin/content/pending");
    
    return { success: true, changeId: change.id };
  } catch (err) {
    log.error("Error in submitActivityDelete", err);
    return { success: false, error: "An unexpected error occurred" };
  }
}

/**
 * Submit a reorder of activities within a module
 */
export async function submitReorder(
  moduleId: string,
  newOrder: Array<{ id: string; order_index: number }>,
  title: string,
  description?: string
): Promise<{ success: boolean; changeId?: string; error?: string }> {
  const { supabase, user } = await verifyContentAdmin();
  
  try {
    // Get current activities order
    const { data: currentActivities, error: fetchError } = await supabase
      .from("activities")
      .select("id, order_index")
      .eq("module_id", moduleId)
      .order("order_index");
    
    if (fetchError) {
      return { success: false, error: "Failed to fetch current order" };
    }
    
    // Create pending change record
    const { data: change, error: insertError } = await supabase
      .from("pending_content_changes")
      .insert({
        entity_type: "module" as ContentEntityType,
        entity_id: moduleId,
        parent_id: null,
        change_type: "reorder" as ContentChangeType,
        current_data: { order: currentActivities },
        proposed_data: { order: newOrder },
        submitted_by: user.id,
        title,
        description
      })
      .select()
      .single();
    
    if (insertError) {
      log.error("Error creating pending reorder", insertError);
      return { success: false, error: "Failed to submit reorder" };
    }
    
    revalidatePath("/admin/content");
    revalidatePath("/admin/content/pending");
    
    return { success: true, changeId: change.id };
  } catch (err) {
    log.error("Error in submitReorder", err);
    return { success: false, error: "An unexpected error occurred" };
  }
}

// ============================================
// Super Admin Review Actions
// ============================================

/**
 * Get all pending changes (Super Admin only)
 */
export async function getPendingChanges(options?: {
  status?: ContentChangeStatus;
  entityType?: ContentEntityType;
  limit?: number;
}): Promise<PendingContentChangeWithSubmitter[]> {
  const { supabase } = await verifySuperAdmin();
  
  let query = supabase
    .from("pending_content_changes")
    .select(`
      *,
      submitter:profiles!pending_content_changes_submitted_by_fkey(id, email, full_name, avatar_url),
      reviewer:profiles!pending_content_changes_reviewed_by_fkey(id, email, full_name)
    `)
    .order("submitted_at", { ascending: false });
  
  if (options?.status) {
    query = query.eq("status", options.status);
  }
  
  if (options?.entityType) {
    query = query.eq("entity_type", options.entityType);
  }
  
  if (options?.limit) {
    query = query.limit(options.limit);
  }
  
  const { data, error } = await query;
  
  if (error) {
    log.error("Error fetching pending changes", error);
    return [];
  }
  
  return data as PendingContentChangeWithSubmitter[];
}

/**
 * Get pending changes count (Super Admin only)
 */
export async function getPendingChangesCount(): Promise<number> {
  const { supabase } = await verifySuperAdmin();
  
  const { count, error } = await supabase
    .from("pending_content_changes")
    .select("*", { count: "exact", head: true })
    .eq("status", "pending");
  
  if (error) {
    log.error("Error counting pending changes", error);
    return 0;
  }
  
  return count || 0;
}

/**
 * Get a single pending change by ID
 */
export async function getPendingChangeById(changeId: string): Promise<PendingContentChangeWithSubmitter | null> {
  const { supabase } = await verifySuperAdmin();
  
  const { data, error } = await supabase
    .from("pending_content_changes")
    .select(`
      *,
      submitter:profiles!pending_content_changes_submitted_by_fkey(id, email, full_name, avatar_url),
      reviewer:profiles!pending_content_changes_reviewed_by_fkey(id, email, full_name)
    `)
    .eq("id", changeId)
    .single();
  
  if (error) {
    log.error("Error fetching pending change", error, { changeId });
    return null;
  }
  
  return data as PendingContentChangeWithSubmitter;
}

/**
 * Approve a pending change and apply it to the database
 */
export async function approveChange(
  changeId: string,
  notes?: string
): Promise<{ success: boolean; error?: string }> {
  const { supabase, user } = await verifySuperAdmin();
  
  try {
    // Get the pending change
    const { data: change, error: fetchError } = await supabase
      .from("pending_content_changes")
      .select("*")
      .eq("id", changeId)
      .eq("status", "pending")
      .single();
    
    if (fetchError || !change) {
      return { success: false, error: "Change not found or already processed" };
    }
    
    // Apply the change based on type
    const applyResult = await applyContentChange(supabase, change);
    
    if (!applyResult.success) {
      return { success: false, error: applyResult.error };
    }
    
    // Update the change record
    const { error: updateError } = await supabase
      .from("pending_content_changes")
      .update({
        status: "approved" as ContentChangeStatus,
        reviewed_by: user.id,
        reviewed_at: new Date().toISOString(),
        review_notes: notes
      })
      .eq("id", changeId);
    
    if (updateError) {
      log.error("Error updating change status", updateError);
      return { success: false, error: "Failed to update change status" };
    }
    
    revalidatePath("/admin/content");
    revalidatePath("/admin/content/pending");
    revalidatePath("/courses");
    
    return { success: true };
  } catch (err) {
    log.error("Error in approveChange", err);
    return { success: false, error: "An unexpected error occurred" };
  }
}

/**
 * Reject a pending change with feedback
 */
export async function rejectChange(
  changeId: string,
  notes: string
): Promise<{ success: boolean; error?: string }> {
  const { supabase, user } = await verifySuperAdmin();
  
  try {
    const { error: updateError } = await supabase
      .from("pending_content_changes")
      .update({
        status: "rejected" as ContentChangeStatus,
        reviewed_by: user.id,
        reviewed_at: new Date().toISOString(),
        review_notes: notes
      })
      .eq("id", changeId)
      .eq("status", "pending");
    
    if (updateError) {
      log.error("Error rejecting change", updateError);
      return { success: false, error: "Failed to reject change" };
    }
    
    revalidatePath("/admin/content");
    revalidatePath("/admin/content/pending");
    
    return { success: true };
  } catch (err) {
    log.error("Error in rejectChange", err);
    return { success: false, error: "An unexpected error occurred" };
  }
}

// ============================================
// Helper Functions
// ============================================

/**
 * Apply a content change to the database
 */
async function applyContentChange(
  supabase: Awaited<ReturnType<typeof createClient>>,
  change: PendingContentChange
): Promise<{ success: boolean; error?: string }> {
  const proposed = change.proposed_data as Record<string, unknown>;
  
  try {
    switch (change.change_type) {
      case "update":
        if (!change.entity_id) {
          return { success: false, error: "No entity ID for update" };
        }
        
        if (change.entity_type === "activity") {
          const { error } = await supabase
            .from("activities")
            .update({
              title: proposed.title as string | undefined,
              slug: proposed.slug as string | undefined,
              type: proposed.type as string | undefined,
              minutes: proposed.minutes as number | undefined,
              xp: proposed.xp as number | undefined,
              required_plan: proposed.required_plan as string | undefined,
              content: proposed.content as Record<string, unknown> | undefined,
              interactive_type: proposed.interactive_type as string | undefined,
              starter_code: proposed.starter_code as string | undefined,
              passing_score: proposed.passing_score as number | undefined,
              time_limit: proposed.time_limit as number | undefined,
              blocks_progress: proposed.blocks_progress as boolean | undefined,
              is_published: proposed.is_published as boolean | undefined
            })
            .eq("id", change.entity_id);
          
          if (error) {
            log.error("Error updating activity", error);
            return { success: false, error: "Failed to update activity" };
          }
        }
        break;
        
      case "create":
        if (change.entity_type === "activity") {
          const { error } = await supabase
            .from("activities")
            .insert({
              module_id: proposed.module_id as string,
              external_id: (proposed.external_id as string) || `NEW-${Date.now()}`,
              order_index: (proposed.order_index as number) || 999,
              title: proposed.title as string,
              slug: proposed.slug as string,
              type: proposed.type as string,
              minutes: proposed.minutes as number | undefined,
              xp: (proposed.xp as number) || 10,
              required_plan: (proposed.required_plan as string) || "basic",
              content: proposed.content as Record<string, unknown>,
              interactive_type: proposed.interactive_type as string | undefined,
              starter_code: proposed.starter_code as string | undefined,
              passing_score: (proposed.passing_score as number) || 70,
              time_limit: proposed.time_limit as number | undefined,
              blocks_progress: (proposed.blocks_progress as boolean) || false,
              is_published: (proposed.is_published as boolean) ?? true
            });
          
          if (error) {
            log.error("Error creating activity", error);
            return { success: false, error: "Failed to create activity" };
          }
        }
        break;
        
      case "delete":
        if (!change.entity_id) {
          return { success: false, error: "No entity ID for delete" };
        }
        
        if (change.entity_type === "activity") {
          // Soft delete by unpublishing
          const { error } = await supabase
            .from("activities")
            .update({ is_published: false })
            .eq("id", change.entity_id);
          
          if (error) {
            log.error("Error deleting activity", error);
            return { success: false, error: "Failed to delete activity" };
          }
        }
        break;
        
      case "reorder":
        if (change.entity_type === "module" && proposed.order) {
          const orderItems = proposed.order as Array<{ id: string; order_index: number }>;
          
          for (const item of orderItems) {
            const { error } = await supabase
              .from("activities")
              .update({ order_index: item.order_index })
              .eq("id", item.id);
            
            if (error) {
              log.error("Error reordering activity", error, { activityId: item.id });
              return { success: false, error: "Failed to reorder activities" };
            }
          }
        }
        break;
        
      default:
        return { success: false, error: `Unknown change type: ${change.change_type}` };
    }
    
    return { success: true };
  } catch (err) {
    log.error("Error applying content change", err);
    return { success: false, error: "Failed to apply change" };
  }
}

/**
 * Get user's own pending changes (for content admins)
 */
export async function getMyPendingChanges(): Promise<PendingContentChange[]> {
  const { supabase, user } = await verifyContentAdmin();
  
  const { data, error } = await supabase
    .from("pending_content_changes")
    .select("*")
    .eq("submitted_by", user.id)
    .order("submitted_at", { ascending: false });
  
  if (error) {
    log.error("Error fetching user pending changes", error);
    return [];
  }
  
  return data as PendingContentChange[];
}

/**
 * Cancel a pending change (only by the submitter, only if still pending)
 */
export async function cancelPendingChange(changeId: string): Promise<{ success: boolean; error?: string }> {
  const { supabase, user } = await verifyContentAdmin();
  
  const { error } = await supabase
    .from("pending_content_changes")
    .delete()
    .eq("id", changeId)
    .eq("submitted_by", user.id)
    .eq("status", "pending");
  
  if (error) {
    log.error("Error canceling pending change", error);
    return { success: false, error: "Failed to cancel change" };
  }
  
  revalidatePath("/admin/content");
  revalidatePath("/admin/content/pending");
  
  return { success: true };
}

