"use server";

import { createClient } from "@/utils/supabase/server";
import { revalidatePath } from "next/cache";
import { getGoogleSheetsService, isGoogleSheetsConfigured, type SheetExerciseResult, type GradingCriteria } from "./client";
import { markActivityComplete } from "@/lib/activities/actions";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "google-sheets/actions" });

export interface UserSheet {
  id: string;
  userId: string;
  activityId: string;
  templateSheetId: string;
  userSheetId: string;
  userSheetUrl: string;
  sheetTitle: string | null;
  lastSyncedAt: string | null;
  isCompleted: boolean;
  completionData: SheetExerciseResult | null;
  createdAt: string;
}

export interface GetUserSheetResult {
  sheet: UserSheet | null;
  embedUrl: string | null;
  editUrl: string | null;
  needsCreation: boolean;
  error?: string;
}

export interface CreateSheetResult {
  success: boolean;
  sheet?: UserSheet;
  embedUrl?: string;
  editUrl?: string;
  error?: string;
}

export interface GradeSheetResult {
  success: boolean;
  result?: SheetExerciseResult;
  passed?: boolean;
  error?: string;
}

/**
 * Get or check if a user has a sheet for a specific activity
 */
export async function getUserSheet(activityId: string): Promise<GetUserSheetResult> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return { sheet: null, embedUrl: null, editUrl: null, needsCreation: false, error: "Not authenticated" };
  }

  // Check if user already has a sheet for this activity
  const { data: existingSheet, error } = await supabase
    .from("user_sheets")
    .select("*")
    .eq("user_id", user.id)
    .eq("activity_id", activityId)
    .single();

  if (error && error.code !== "PGRST116") { // PGRST116 = no rows returned
    log.error("Error fetching user sheet", error, { activityId });
    return { sheet: null, embedUrl: null, editUrl: null, needsCreation: false, error: "Failed to fetch sheet" };
  }

  if (!existingSheet) {
    return { sheet: null, embedUrl: null, editUrl: null, needsCreation: true };
  }

  const sheetsService = getGoogleSheetsService();
  
  // Verify the sheet still exists
  if (sheetsService) {
    const exists = await sheetsService.sheetExists(existingSheet.user_sheet_id);
    if (!exists) {
      // Sheet was deleted externally, remove the record
      await supabase
        .from("user_sheets")
        .delete()
        .eq("id", existingSheet.id);
      
      return { sheet: null, embedUrl: null, editUrl: null, needsCreation: true };
    }
  }

  const userSheet: UserSheet = {
    id: existingSheet.id,
    userId: existingSheet.user_id,
    activityId: existingSheet.activity_id,
    templateSheetId: existingSheet.template_sheet_id,
    userSheetId: existingSheet.user_sheet_id,
    userSheetUrl: existingSheet.user_sheet_url,
    sheetTitle: existingSheet.sheet_title,
    lastSyncedAt: existingSheet.last_synced_at,
    isCompleted: existingSheet.is_completed,
    completionData: existingSheet.completion_data as SheetExerciseResult | null,
    createdAt: existingSheet.created_at,
  };

  const embedUrl = sheetsService?.getEmbedUrl(existingSheet.user_sheet_id) || null;
  const editUrl = sheetsService?.getEditUrl(existingSheet.user_sheet_id) || null;

  return { sheet: userSheet, embedUrl, editUrl, needsCreation: false };
}

/**
 * Create a new sheet copy for the user
 */
export async function createUserSheet(
  activityId: string,
  templateSheetId: string,
  exerciseTitle: string
): Promise<CreateSheetResult> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return { success: false, error: "Not authenticated" };
  }

  if (!isGoogleSheetsConfigured()) {
    return { success: false, error: "Google Sheets integration not configured" };
  }

  const sheetsService = getGoogleSheetsService();
  if (!sheetsService) {
    return { success: false, error: "Failed to initialize Google Sheets service" };
  }

  // Get user's email for sharing
  const { data: profile } = await supabase
    .from("profiles")
    .select("email")
    .eq("id", user.id)
    .single();

  if (!profile?.email) {
    return { success: false, error: "User email not found" };
  }

  try {
    // Create the sheet copy
    const sheetTitle = `${exerciseTitle} - ${profile.email.split("@")[0]}`;
    const copyResult = await sheetsService.copyTemplateForUser(
      templateSheetId,
      profile.email,
      sheetTitle
    );

    // Save to database
    const { data: newSheet, error: insertError } = await supabase
      .from("user_sheets")
      .insert({
        user_id: user.id,
        activity_id: activityId,
        template_sheet_id: templateSheetId,
        user_sheet_id: copyResult.sheetId,
        user_sheet_url: copyResult.sheetUrl,
        sheet_title: copyResult.title,
      })
      .select()
      .single();

    if (insertError) {
      // Clean up the created sheet if database insert fails
      await sheetsService.deleteSheet(copyResult.sheetId);
      log.error("Failed to save sheet record", insertError, { activityId });
      return { success: false, error: "Failed to save sheet record" };
    }

    const userSheet: UserSheet = {
      id: newSheet.id,
      userId: newSheet.user_id,
      activityId: newSheet.activity_id,
      templateSheetId: newSheet.template_sheet_id,
      userSheetId: newSheet.user_sheet_id,
      userSheetUrl: newSheet.user_sheet_url,
      sheetTitle: newSheet.sheet_title,
      lastSyncedAt: newSheet.last_synced_at,
      isCompleted: newSheet.is_completed,
      completionData: null,
      createdAt: newSheet.created_at,
    };

    return {
      success: true,
      sheet: userSheet,
      embedUrl: sheetsService.getEmbedUrl(copyResult.sheetId),
      editUrl: sheetsService.getEditUrl(copyResult.sheetId),
    };
  } catch (error) {
    log.error("Error creating user sheet", error, { activityId });
    return { success: false, error: error instanceof Error ? error.message : "Failed to create sheet" };
  }
}

/**
 * Grade a user's sheet exercise
 */
export async function gradeUserSheet(activityId: string): Promise<GradeSheetResult> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return { success: false, error: "Not authenticated" };
  }

  const sheetsService = getGoogleSheetsService();
  if (!sheetsService) {
    return { success: false, error: "Google Sheets integration not configured" };
  }

  // Get user's sheet
  const { data: userSheet } = await supabase
    .from("user_sheets")
    .select("*")
    .eq("user_id", user.id)
    .eq("activity_id", activityId)
    .single();

  if (!userSheet) {
    return { success: false, error: "No sheet found for this activity" };
  }

  // Get grading criteria for this activity
  const { data: criteria } = await supabase
    .from("sheet_grading_criteria")
    .select("*")
    .eq("activity_id", activityId)
    .order("sort_order");

  if (!criteria || criteria.length === 0) {
    return { success: false, error: "No grading criteria defined for this activity" };
  }

  // Get activity passing score
  const { data: activity } = await supabase
    .from("activities")
    .select("passing_score, module:modules(course:courses(slug), slug)")
    .eq("id", activityId)
    .single();

  const passingScore = activity?.passing_score || 80;

  // Convert criteria to the format expected by the grading function
  const gradingCriteria: GradingCriteria[] = criteria.map(c => ({
    cellReference: c.cell_reference,
    cellName: c.cell_name || c.cell_reference,
    expectedValue: c.expected_value,
    expectedType: c.expected_type as 'number' | 'text' | 'formula' | 'boolean',
    tolerance: parseFloat(c.tolerance) || 0,
    isRequired: c.is_required,
    points: c.points || 1,
    hintOnError: c.hint_on_error,
  }));

  try {
    // Grade the sheet
    const result = await sheetsService.gradeSheetExercise(
      userSheet.user_sheet_id,
      gradingCriteria,
      passingScore
    );

    // Update the user_sheets record
    await supabase
      .from("user_sheets")
      .update({
        is_completed: result.passed,
        completion_data: result,
        last_synced_at: new Date().toISOString(),
      })
      .eq("id", userSheet.id);

    // If passed, also mark the activity as complete
    if (result.passed) {
      await markActivityComplete(activityId, result.scorePercent);
    }

    // Revalidate relevant pages
    if (activity?.module) {
      const moduleData = activity.module as unknown as { slug: string; course: { slug: string } };
      revalidatePath(`/courses/${moduleData.course.slug}`);
      revalidatePath(`/courses/${moduleData.course.slug}/${moduleData.slug}`);
    }
    revalidatePath("/dashboard");
    revalidatePath("/skills");

    return { success: true, result, passed: result.passed };
  } catch (error) {
    log.error("Error grading sheet", error, { activityId });
    return { success: false, error: error instanceof Error ? error.message : "Failed to grade sheet" };
  }
}

/**
 * Reset a user's sheet (delete and allow re-creation)
 */
export async function resetUserSheet(activityId: string): Promise<{ success: boolean; error?: string }> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return { success: false, error: "Not authenticated" };
  }

  // Get user's sheet
  const { data: userSheet } = await supabase
    .from("user_sheets")
    .select("*")
    .eq("user_id", user.id)
    .eq("activity_id", activityId)
    .single();

  if (!userSheet) {
    return { success: true }; // No sheet to reset
  }

  const sheetsService = getGoogleSheetsService();
  
  // Delete the Google Sheet
  if (sheetsService) {
    await sheetsService.deleteSheet(userSheet.user_sheet_id);
  }

  // Delete the database record
  await supabase
    .from("user_sheets")
    .delete()
    .eq("id", userSheet.id);

  return { success: true };
}

/**
 * Extended grading criteria with ID for the Answer Form approach
 */
export interface GradingCriteriaWithId extends GradingCriteria {
  id: string;
  sortOrder: number;
}

/**
 * Get the grading criteria for an activity (for display purposes)
 */
export async function getActivityGradingCriteria(activityId: string): Promise<{
  criteria: GradingCriteriaWithId[];
  totalPoints: number;
}> {
  const supabase = await createClient();

  const { data: criteria } = await supabase
    .from("sheet_grading_criteria")
    .select("*")
    .eq("activity_id", activityId)
    .order("sort_order");

  if (!criteria) {
    return { criteria: [], totalPoints: 0 };
  }

  const gradingCriteria: GradingCriteriaWithId[] = criteria.map(c => ({
    id: c.id,
    cellReference: c.cell_reference,
    cellName: c.cell_name || c.cell_reference,
    expectedValue: c.expected_value,
    expectedType: c.expected_type as 'number' | 'text' | 'formula' | 'boolean',
    tolerance: parseFloat(c.tolerance) || 0,
    isRequired: c.is_required,
    points: c.points || 1,
    hintOnError: c.hint_on_error,
    sortOrder: c.sort_order || 0,
  }));

  const totalPoints = gradingCriteria.reduce((sum, c) => sum + c.points, 0);

  return { criteria: gradingCriteria, totalPoints };
}

/**
 * Check if Google Sheets is configured (for UI display)
 */
export async function checkGoogleSheetsStatus(): Promise<{
  configured: boolean;
  message?: string;
}> {
  return {
    configured: isGoogleSheetsConfigured(),
    message: isGoogleSheetsConfigured() 
      ? undefined 
      : "Google Sheets integration is not configured. Contact your administrator.",
  };
}

