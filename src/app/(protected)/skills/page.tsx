import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";

/**
 * Skills page - now redirects to the Computational Thinking course
 * Skills are now part of a course structure
 */
export default async function SkillsPage() {
  const supabase = await createClient();
  
  // Find the course that contains skills (primarily CT course)
  const { data: course } = await supabase
    .from("courses")
    .select("slug")
    .eq("slug", "computational-thinking")
    .single();

  if (course) {
    redirect(`/courses/${course.slug}/learn?tab=skills`);
  }

  // Fallback to courses page if no CT course exists
  redirect("/courses");
}
