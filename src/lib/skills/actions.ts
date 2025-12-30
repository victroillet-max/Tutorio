"use server";

import { createClient } from "@/utils/supabase/server";
import { revalidatePath } from "next/cache";
import type {
  Skill,
  SkillWithProgress,
  UserSkillProgress,
  SkillCategory,
  DiagnosticResult,
} from "@/lib/database.types";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "skills/actions" });

/**
 * Get all skills with user progress
 */
export async function getSkillsWithProgress(): Promise<SkillWithProgress[]> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  // Get all active skills
  const { data: skills, error: skillsError } = await supabase
    .from("skills")
    .select("*")
    .eq("is_active", true)
    .order("category")
    .order("sort_order");

  if (skillsError) {
    log.error("Failed to fetch skills", skillsError);
    throw new Error("Failed to fetch skills");
  }

  // Get user's skill progress
  const { data: progress, error: progressError } = await supabase
    .from("user_skill_progress")
    .select("*")
    .eq("user_id", user.id);

  if (progressError) {
    log.error("Failed to fetch skill progress", progressError);
    throw new Error("Failed to fetch skill progress");
  }

  // Map progress to skills
  const progressMap = new Map(progress?.map(p => [p.skill_id, p]) || []);
  
  return (skills || []).map(skill => ({
    ...skill,
    progress: progressMap.get(skill.id) || null,
  }));
}

/**
 * Get skills by category
 */
export async function getSkillsByCategory(category: SkillCategory): Promise<Skill[]> {
  const supabase = await createClient();
  
  const { data, error } = await supabase
    .from("skills")
    .select("*")
    .eq("category", category)
    .eq("is_active", true)
    .order("sort_order");

  if (error) {
    log.error("Failed to fetch skills by category", error, { category });
    throw new Error("Failed to fetch skills");
  }

  return data || [];
}

/**
 * Get skill prerequisites with mastery status
 */
export async function getSkillPrerequisites(skillId: string) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .rpc("get_skill_prerequisites_status", {
      p_user_id: user.id,
      p_skill_id: skillId,
    });

  if (error) {
    log.error("Failed to fetch skill prerequisites", error, { skillId });
    throw new Error("Failed to fetch skill prerequisites");
  }

  return data || [];
}

/**
 * Get user's struggling skills (mastery < 70%)
 */
export async function getStrugglingSkills() {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .rpc("get_struggling_skills", {
      p_user_id: user.id,
    });

  if (error) {
    log.error("Failed to fetch struggling skills", error);
    throw new Error("Failed to fetch struggling skills");
  }

  return data || [];
}

/**
 * Get user's overall skill mastery
 */
export async function getUserSkillMastery() {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .rpc("get_user_skill_mastery", {
      p_user_id: user.id,
    });

  if (error) {
    log.error("Failed to fetch skill mastery", error);
    throw new Error("Failed to fetch skill mastery");
  }

  return data || [];
}

/**
 * Calculate and update skill mastery based on activity completion
 */
export async function updateSkillMastery(skillId: string): Promise<number> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .rpc("calculate_skill_mastery", {
      p_user_id: user.id,
      p_skill_id: skillId,
    });

  if (error) {
    log.error("Failed to calculate skill mastery", error, { skillId });
    throw new Error("Failed to calculate skill mastery");
  }

  // Revalidate skill-related pages
  revalidatePath("/courses");
  revalidatePath("/profile");

  return data;
}

/**
 * Update skill progress after answering a question
 */
export async function updateSkillProgressFromQuestion(
  skillId: string,
  isCorrect: boolean
): Promise<UserSkillProgress> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  // Get current progress
  const { data: existing } = await supabase
    .from("user_skill_progress")
    .select("*")
    .eq("user_id", user.id)
    .eq("skill_id", skillId)
    .single();

  const currentCorrect = existing?.correct_answers || 0;
  const currentTotal = existing?.total_answers || 0;
  const newCorrect = currentCorrect + (isCorrect ? 1 : 0);
  const newTotal = currentTotal + 1;
  
  // Calculate new mastery level (0-100)
  const newMastery = newTotal > 0 ? Math.round((newCorrect / newTotal) * 100) : 0;

  // Upsert progress
  const { data: progress, error } = await supabase
    .from("user_skill_progress")
    .upsert({
      user_id: user.id,
      skill_id: skillId,
      mastery_level: newMastery,
      times_practiced: (existing?.times_practiced || 0) + 1,
      correct_answers: newCorrect,
      total_answers: newTotal,
      last_practiced_at: new Date().toISOString(),
      first_practiced_at: existing?.first_practiced_at || new Date().toISOString(),
    }, {
      onConflict: "user_id,skill_id",
    })
    .select()
    .single();

  if (error) {
    log.error("Failed to update skill progress", error, { skillId, isCorrect });
    throw new Error("Failed to update skill progress");
  }

  return progress;
}

/**
 * Search skills by name or description
 */
export async function searchSkills(query: string): Promise<Skill[]> {
  const supabase = await createClient();
  
  const { data, error } = await supabase
    .rpc("search_skills", {
      p_query: query,
    });

  if (error) {
    log.error("Failed to search skills", error, { query });
    throw new Error("Failed to search skills");
  }

  return data || [];
}

/**
 * Get activities for a specific skill
 */
export async function getActivitiesForSkill(skillId: string) {
  const supabase = await createClient();

  const { data, error } = await supabase
    .from("activity_skills")
    .select(`
      *,
      activity:activities(
        id,
        title,
        slug,
        type,
        minutes,
        xp,
        module:modules(
          slug,
          title,
          course:courses(slug, title)
        )
      )
    `)
    .eq("skill_id", skillId)
    .eq("teaches", true)
    .order("is_primary", { ascending: false });

  if (error) {
    log.error("Failed to fetch activities for skill", error, { skillId });
    throw new Error("Failed to fetch activities for skill");
  }

  return data || [];
}

/**
 * Save diagnostic quiz result
 */
export async function saveDiagnosticResult(
  skillCluster: string,
  totalQuestions: number,
  correctAnswers: number,
  gapsIdentified: string[],
  recommendations?: Record<string, unknown>
): Promise<DiagnosticResult> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const score = Math.round((correctAnswers / totalQuestions) * 100);

  const { data, error } = await supabase
    .from("diagnostic_results")
    .insert({
      user_id: user.id,
      skill_cluster: skillCluster,
      total_questions: totalQuestions,
      correct_answers: correctAnswers,
      score,
      gaps_identified: gapsIdentified,
      recommendations: recommendations || null,
    })
    .select()
    .single();

  if (error) {
    log.error("Failed to save diagnostic result", error, { skillCluster });
    throw new Error("Failed to save diagnostic result");
  }

  revalidatePath("/courses");
  revalidatePath("/profile");

  return data;
}

/**
 * Get diagnostic history for user
 */
export async function getDiagnosticHistory(skillCluster?: string) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  let query = supabase
    .from("diagnostic_results")
    .select("*")
    .eq("user_id", user.id)
    .order("completed_at", { ascending: false });

  if (skillCluster) {
    query = query.eq("skill_cluster", skillCluster);
  }

  const { data, error } = await query;

  if (error) {
    log.error("Failed to fetch diagnostic history", error, { skillCluster });
    throw new Error("Failed to fetch diagnostic history");
  }

  return data || [];
}

/**
 * Get skill tree structure (skills with prerequisites)
 */
export async function getSkillTree() {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  
  // Get all skills
  const { data: skills, error: skillsError } = await supabase
    .from("skills")
    .select("*")
    .eq("is_active", true)
    .order("category")
    .order("sort_order");

  if (skillsError) {
    log.error("Failed to fetch skills", skillsError);
    throw new Error("Failed to fetch skills");
  }

  // Get all prerequisites
  const { data: prerequisites, error: prereqError } = await supabase
    .from("skill_prerequisites")
    .select("*");

  if (prereqError) {
    log.error("Failed to fetch prerequisites", prereqError);
    throw new Error("Failed to fetch prerequisites");
  }

  // Get user progress if authenticated
  let progressMap = new Map<string, UserSkillProgress>();
  if (user) {
    const { data: progress } = await supabase
      .from("user_skill_progress")
      .select("*")
      .eq("user_id", user.id);
    
    progressMap = new Map(progress?.map(p => [p.skill_id, p]) || []);
  }

  // Build skill tree structure
  const prereqMap = new Map<string, string[]>();
  prerequisites?.forEach(p => {
    const existing = prereqMap.get(p.skill_id) || [];
    existing.push(p.prerequisite_skill_id);
    prereqMap.set(p.skill_id, existing);
  });

  // Group by category
  const categories: Record<SkillCategory, SkillWithProgress[]> = {
    ct_foundations: [],
    python_basics: [],
    control_flow: [],
    data_structures: [],
    functions: [],
    advanced_topics: [],
  };

  skills?.forEach(skill => {
    const skillWithProgress: SkillWithProgress = {
      ...skill,
      progress: progressMap.get(skill.id) || null,
      prerequisites: prerequisites?.filter(p => p.skill_id === skill.id) || [],
    };
    categories[skill.category as SkillCategory].push(skillWithProgress);
  });

  return {
    categories,
    prerequisites: prerequisites || [],
    totalSkills: skills?.length || 0,
    masteredSkills: Array.from(progressMap.values()).filter(p => p.mastery_level >= 70).length,
  };
}

/**
 * Check if user has mastered all prerequisites for a skill
 */
export async function checkPrerequisitesMet(skillId: string): Promise<{
  allMet: boolean;
  unmetPrerequisites: { skillId: string; name: string; mastery: number }[];
}> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const prereqs = await getSkillPrerequisites(skillId);
  
  interface PrereqItem {
    is_required: boolean;
    is_mastered: boolean;
    prerequisite_skill_id: string;
    skill_name: string;
    mastery_level: number;
  }
  
  const unmet = (prereqs as PrereqItem[])
    .filter((p: PrereqItem) => p.is_required && !p.is_mastered)
    .map((p: PrereqItem) => ({
      skillId: p.prerequisite_skill_id,
      name: p.skill_name,
      mastery: p.mastery_level,
    }));

  return {
    allMet: unmet.length === 0,
    unmetPrerequisites: unmet,
  };
}

/**
 * Get skills for a specific course
 */
export async function getCourseSkills(courseId: string) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();

  // Get all skills for the course
  const { data, error } = await supabase
    .rpc("get_course_skills", {
      p_course_id: courseId,
      p_user_id: user?.id || null,
      p_category: null
    });

  if (error) {
    log.error("Failed to fetch course skills", error, { courseId });
    throw new Error("Failed to fetch course skills");
  }

  return data || [];
}

/**
 * Get course foundations (ct_foundations category)
 */
export async function getCourseFoundations(courseId: string) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();

  const { data, error } = await supabase
    .rpc("get_course_foundations", {
      p_course_id: courseId,
      p_user_id: user?.id || null
    });

  if (error) {
    log.error("Failed to fetch course foundations", error, { courseId });
    throw new Error("Failed to fetch course foundations");
  }

  return data || [];
}

/**
 * Get course coding skills (non-foundations)
 */
export async function getCourseCodingSkills(courseId: string) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();

  const { data, error } = await supabase
    .rpc("get_course_coding_skills", {
      p_course_id: courseId,
      p_user_id: user?.id || null
    });

  if (error) {
    log.error("Failed to fetch course coding skills", error, { courseId });
    throw new Error("Failed to fetch course coding skills");
  }

  return data || [];
}

/**
 * Get course skill progress summary
 */
export async function getCourseSkillProgress(courseId: string) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return {
      foundations_total: 0,
      foundations_mastered: 0,
      foundations_in_progress: 0,
      skills_total: 0,
      skills_mastered: 0,
      skills_in_progress: 0,
      overall_progress_percent: 0
    };
  }

  const { data, error } = await supabase
    .rpc("get_course_skill_progress", {
      p_course_id: courseId,
      p_user_id: user.id
    });

  if (error) {
    log.error("Failed to fetch course skill progress", error, { courseId });
    throw new Error("Failed to fetch course skill progress");
  }

  return data?.[0] || {
    foundations_total: 0,
    foundations_mastered: 0,
    foundations_in_progress: 0,
    skills_total: 0,
    skills_mastered: 0,
    skills_in_progress: 0,
    overall_progress_percent: 0
  };
}

/**
 * Enroll user in a course
 */
export async function enrollInCourse(courseId: string) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .rpc("enroll_user_in_course", {
      p_user_id: user.id,
      p_course_id: courseId
    });

  if (error) {
    log.error("Failed to enroll in course", error, { courseId });
    throw new Error("Failed to enroll in course");
  }

  revalidatePath("/courses");
  revalidatePath("/dashboard");

  return data;
}

/**
 * Get user's enrolled courses with progress
 */
export async function getEnrolledCourses() {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return [];
  }

  const { data, error } = await supabase
    .rpc("get_user_enrolled_courses", {
      p_user_id: user.id
    });

  if (error) {
    log.error("Failed to fetch enrolled courses", error);
    throw new Error("Failed to fetch enrolled courses");
  }

  return data || [];
}

