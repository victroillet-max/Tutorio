import { createClient } from "@/utils/supabase/server";
import { NextRequest, NextResponse } from "next/server";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "api/admin/courses/stripe-prices" });

/**
 * POST /api/admin/courses/stripe-prices
 * Updates Stripe price IDs for a course
 */
export async function POST(request: NextRequest) {
  const supabase = await createClient();
  
  // Check authentication
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    return NextResponse.json(
      { error: "Not authenticated" },
      { status: 401 }
    );
  }

  // Check if user is admin
  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .single();

  if (profile?.role !== "admin") {
    return NextResponse.json(
      { error: "Not authorized" },
      { status: 403 }
    );
  }

  try {
    const body = await request.json();
    const { courseId, basicPriceId, advancedPriceId } = body;

    if (!courseId) {
      return NextResponse.json(
        { error: "Missing courseId" },
        { status: 400 }
      );
    }

    // Validate price IDs format (should start with "price_" if provided)
    if (basicPriceId && !basicPriceId.startsWith("price_")) {
      return NextResponse.json(
        { error: "Invalid basic price ID format. Should start with 'price_'" },
        { status: 400 }
      );
    }

    if (advancedPriceId && !advancedPriceId.startsWith("price_")) {
      return NextResponse.json(
        { error: "Invalid advanced price ID format. Should start with 'price_'" },
        { status: 400 }
      );
    }

    // Update the course with the new price IDs
    const { error } = await supabase
      .from("courses")
      .update({
        stripe_basic_price_id: basicPriceId || null,
        stripe_advanced_price_id: advancedPriceId || null,
        updated_at: new Date().toISOString(),
      })
      .eq("id", courseId);

    if (error) {
      log.error("Error updating stripe prices", error, { courseId });
      return NextResponse.json(
        { error: "Failed to update stripe prices" },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      message: "Stripe prices updated successfully",
    });

  } catch (error) {
    log.error("Stripe prices update error", error);
    return NextResponse.json(
      { error: "Failed to process request" },
      { status: 500 }
    );
  }
}

