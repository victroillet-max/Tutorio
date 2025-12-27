import { createClient } from "@/utils/supabase/server";
import { NextResponse } from "next/server";

export async function POST() {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return NextResponse.json({ error: "Not authenticated" }, { status: 401 });
  }

  try {
    // Call the recalculate function
    const { error } = await supabase.rpc("recalculate_all_skill_mastery", {
      p_user_id: user.id,
    });
    
    if (error) {
      console.error("Failed to recalculate skill mastery:", error);
      return NextResponse.json({ error: error.message }, { status: 500 });
    }
    
    return NextResponse.json({ success: true });
  } catch (error) {
    console.error("Failed to recalculate skill mastery:", error);
    return NextResponse.json({ error: "Failed to recalculate" }, { status: 500 });
  }
}

