import { createClient } from "@/utils/supabase/server";
import { NextRequest } from "next/server";

export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ skillId: string }> }
) {
  try {
    const { skillId } = await params;
    const supabase = await createClient();
    
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Get prerequisites with mastery status
    const { data, error } = await supabase.rpc("get_skill_prerequisites_status", {
      p_user_id: user.id,
      p_skill_id: skillId,
    });

    if (error) {
      console.error("Prerequisites error:", error);
      return new Response(JSON.stringify({ error: "Failed to get prerequisites" }), {
        status: 500,
        headers: { "Content-Type": "application/json" },
      });
    }

    const prerequisites = (data || []).map((p: Record<string, unknown>) => ({
      skillId: p.prerequisite_skill_id,
      name: p.skill_name,
      mastery: p.mastery_level,
      isRequired: p.is_required,
      isMet: p.is_mastered,
    }));

    const allMet = prerequisites.every(
      (p: { isRequired: boolean; isMet: boolean }) => !p.isRequired || p.isMet
    );

    return new Response(JSON.stringify({
      prerequisites,
      allMet,
    }), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (error) {
    console.error("Prerequisites error:", error);
    return new Response(JSON.stringify({ error: "Internal server error" }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
}

