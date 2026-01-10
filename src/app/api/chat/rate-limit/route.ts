import { createClient } from "@/utils/supabase/server";
import { NextResponse } from "next/server";

/**
 * GET /api/chat/rate-limit
 * Returns the current user's AI chat rate limit info
 */
export async function GET() {
  try {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    
    if (!user) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { data, error } = await supabase.rpc("get_user_rate_limit", {
      p_user_id: user.id,
    });

    if (error || !data?.[0]) {
      // Return default free tier limits if not found
      return NextResponse.json({
        tier: "free",
        messagesPerDay: 5,
        messagesUsedToday: 0,
        messagesRemaining: 5,
      });
    }

    const limit = data[0];
    return NextResponse.json({
      tier: limit.tier,
      messagesPerDay: limit.messages_per_day,
      messagesUsedToday: limit.messages_used_today,
      messagesRemaining: limit.messages_remaining_today,
    });
  } catch (error) {
    console.error("Error fetching rate limit:", error);
    return NextResponse.json(
      { error: "Failed to fetch rate limit" },
      { status: 500 }
    );
  }
}


