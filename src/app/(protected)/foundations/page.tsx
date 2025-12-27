import { createClient } from "@/utils/supabase/server";
import { redirect } from "next/navigation";

/**
 * Foundations page - now redirects to the Computational Thinking course
 * Foundations are now part of a course structure
 */
export default async function FoundationsPage() {
  const supabase = await createClient();
  
  // Find the course that contains CT foundations (or any course with skills)
  const { data: course } = await supabase
    .from("courses")
    .select("slug")
    .eq("slug", "computational-thinking")
    .single();

  if (course) {
    redirect(`/courses/${course.slug}/learn?tab=foundations`);
  }

  // Fallback to courses page if no CT course exists
  redirect("/courses");
}
