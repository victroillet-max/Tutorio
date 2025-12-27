import { createClient } from "@/utils/supabase/server";
import { NextRequest } from "next/server";

export async function GET(request: NextRequest) {
  try {
    const searchParams = request.nextUrl.searchParams;
    const query = searchParams.get("q");

    if (!query || query.trim().length < 2) {
      return new Response(JSON.stringify({ skills: [] }), {
        headers: { "Content-Type": "application/json" },
      });
    }

    const supabase = await createClient();

    // Use the search_skills function
    const { data, error } = await supabase.rpc("search_skills", {
      p_query: query.trim(),
    });

    if (error) {
      console.error("Search error:", error);
      return new Response(JSON.stringify({ error: "Search failed" }), {
        status: 500,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Transform the response
    const skills = (data || []).map((s: Record<string, unknown>) => ({
      id: s.skill_id,
      slug: s.skill_slug,
      name: s.skill_name,
      description: s.description,
      category: s.category,
    }));

    return new Response(JSON.stringify({ skills }), {
      headers: { "Content-Type": "application/json" },
    });
  } catch (error) {
    console.error("Search error:", error);
    return new Response(JSON.stringify({ error: "Internal server error" }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
}

