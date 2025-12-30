/**
 * Google Sheets API Routes
 * 
 * Handles sheet operations including:
 * - GET: Get user's sheet for an activity
 * - POST: Create a new sheet copy for user
 * - PUT: Grade a sheet exercise
 * - DELETE: Reset/delete a user's sheet
 */

import { NextRequest, NextResponse } from "next/server";
import { createClient } from "@/utils/supabase/server";
import {
  getUserSheet,
  createUserSheet,
  gradeUserSheet,
  resetUserSheet,
  getActivityGradingCriteria,
  checkGoogleSheetsStatus,
} from "@/lib/google-sheets/actions";

export async function GET(request: NextRequest) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(request.url);
  const activityId = searchParams.get("activityId");
  const action = searchParams.get("action");

  // Check status action
  if (action === "status") {
    const status = await checkGoogleSheetsStatus();
    return NextResponse.json(status);
  }

  // Get grading criteria action
  if (action === "criteria" && activityId) {
    const criteria = await getActivityGradingCriteria(activityId);
    return NextResponse.json(criteria);
  }

  // Get user sheet
  if (!activityId) {
    return NextResponse.json({ error: "activityId is required" }, { status: 400 });
  }

  const result = await getUserSheet(activityId);
  return NextResponse.json(result);
}

export async function POST(request: NextRequest) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const body = await request.json();
    const { activityId, templateSheetId, exerciseTitle } = body;

    if (!activityId || !templateSheetId || !exerciseTitle) {
      return NextResponse.json(
        { error: "activityId, templateSheetId, and exerciseTitle are required" },
        { status: 400 }
      );
    }

    const result = await createUserSheet(activityId, templateSheetId, exerciseTitle);
    
    if (!result.success) {
      return NextResponse.json({ error: result.error }, { status: 500 });
    }

    return NextResponse.json(result);
  } catch (error) {
    console.error("Error in POST /api/sheets:", error);
    return NextResponse.json(
      { error: "Failed to create sheet" },
      { status: 500 }
    );
  }
}

export async function PUT(request: NextRequest) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const body = await request.json();
    const { activityId, answers, score, passed } = body;

    if (!activityId) {
      return NextResponse.json({ error: "activityId is required" }, { status: 400 });
    }

    // If answers are provided, this is the Answer Form approach (no Google Sheets API)
    if (answers !== undefined && score !== undefined) {
      // Save progress directly using activity_progress
      const { data: activity } = await supabase
        .from("activities")
        .select("module:modules(course:courses(slug), slug)")
        .eq("id", activityId)
        .single();

      // Upsert activity progress
      const { error: progressError } = await supabase
        .from("activity_progress")
        .upsert({
          user_id: user.id,
          activity_id: activityId,
          score: score,
          completed_at: passed ? new Date().toISOString() : null,
          updated_at: new Date().toISOString(),
        }, {
          onConflict: 'user_id,activity_id'
        });

      if (progressError) {
        console.error("Error saving progress:", progressError);
        return NextResponse.json({ error: "Failed to save progress" }, { status: 500 });
      }

      return NextResponse.json({ 
        success: true, 
        score, 
        passed,
        message: passed ? "Great job! You passed!" : "Keep trying!"
      });
    }

    // Otherwise, use the old Google Sheets grading approach
    const result = await gradeUserSheet(activityId);
    
    if (!result.success) {
      return NextResponse.json({ error: result.error }, { status: 500 });
    }

    return NextResponse.json(result);
  } catch (error) {
    console.error("Error in PUT /api/sheets:", error);
    return NextResponse.json(
      { error: "Failed to grade sheet" },
      { status: 500 }
    );
  }
}

export async function DELETE(request: NextRequest) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(request.url);
  const activityId = searchParams.get("activityId");

  if (!activityId) {
    return NextResponse.json({ error: "activityId is required" }, { status: 400 });
  }

  const result = await resetUserSheet(activityId);
  
  if (!result.success) {
    return NextResponse.json({ error: result.error }, { status: 500 });
  }

  return NextResponse.json(result);
}

