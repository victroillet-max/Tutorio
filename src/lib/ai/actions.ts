"use server";

import { createClient } from "@/utils/supabase/server";
import { revalidatePath } from "next/cache";
import type {
  ChatConversation,
  ChatMessage,
  AIUsage,
  UserRateLimit,
} from "@/lib/database.types";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "ai/actions" });

/**
 * Get user's rate limit information
 */
export async function getUserRateLimit(): Promise<UserRateLimit> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .rpc("get_user_rate_limit", {
      p_user_id: user.id,
    });

  if (error) {
    log.error("Failed to get rate limit", error);
    throw new Error("Failed to get rate limit");
  }

  return data?.[0] || {
    tier: "free",
    messages_per_day: 10,
    messages_per_hour: 5,
    messages_used_today: 0,
    messages_remaining_today: 10,
    features: { basicQA: true, errorExplanations: true },
  };
}

/**
 * Check if user can send a message
 */
export async function canSendMessage(): Promise<boolean> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return false;
  }

  const { data, error } = await supabase
    .rpc("can_send_ai_message", {
      p_user_id: user.id,
    });

  if (error) {
    log.error("Failed to check rate limit", error);
    return false;
  }

  return data;
}

/**
 * Create a new conversation
 */
export async function createConversation(
  activityId?: string,
  skillId?: string,
  title?: string
): Promise<ChatConversation> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .from("chat_conversations")
    .insert({
      user_id: user.id,
      activity_id: activityId || null,
      skill_id: skillId || null,
      title: title || "New Conversation",
    })
    .select()
    .single();

  if (error) {
    log.error("Failed to create conversation", error);
    throw new Error("Failed to create conversation");
  }

  return data;
}

/**
 * Get user's active conversations
 */
export async function getConversations(limit: number = 20): Promise<ChatConversation[]> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .from("chat_conversations")
    .select("*")
    .eq("user_id", user.id)
    .eq("is_active", true)
    .order("updated_at", { ascending: false })
    .limit(limit);

  if (error) {
    log.error("Failed to fetch conversations", error);
    throw new Error("Failed to fetch conversations");
  }

  return data || [];
}

/**
 * Get conversation messages
 */
export async function getConversationMessages(
  conversationId: string,
  limit: number = 50
): Promise<ChatMessage[]> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .from("chat_messages")
    .select("*")
    .eq("conversation_id", conversationId)
    .order("created_at", { ascending: true })
    .limit(limit);

  if (error) {
    log.error("Failed to fetch messages", error, { conversationId });
    throw new Error("Failed to fetch messages");
  }

  return data || [];
}

/**
 * Add a message to a conversation
 */
export async function addMessage(
  conversationId: string,
  role: "user" | "assistant" | "system",
  content: string,
  metadata?: Record<string, unknown>,
  tokensUsed?: number
): Promise<ChatMessage> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  // If it's a user message, check rate limit and increment usage
  if (role === "user") {
    const canSend = await canSendMessage();
    if (!canSend) {
      throw new Error("Rate limit exceeded. Please try again later.");
    }

    // Increment usage
    await supabase.rpc("increment_ai_usage", {
      p_user_id: user.id,
      p_tokens: tokensUsed || 0,
    });
  }

  const { data, error } = await supabase
    .from("chat_messages")
    .insert({
      conversation_id: conversationId,
      role,
      content,
      metadata: metadata || {},
      tokens_used: tokensUsed || 0,
    })
    .select()
    .single();

  if (error) {
    log.error("Failed to add message", error, { conversationId, role });
    throw new Error("Failed to add message");
  }

  return data;
}

/**
 * Update conversation title
 */
export async function updateConversationTitle(
  conversationId: string,
  title: string
): Promise<ChatConversation> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .from("chat_conversations")
    .update({ title })
    .eq("id", conversationId)
    .eq("user_id", user.id)
    .select()
    .single();

  if (error) {
    log.error("Failed to update conversation", error, { conversationId });
    throw new Error("Failed to update conversation");
  }

  return data;
}

/**
 * Archive a conversation
 */
export async function archiveConversation(conversationId: string): Promise<void> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { error } = await supabase
    .from("chat_conversations")
    .update({ is_active: false })
    .eq("id", conversationId)
    .eq("user_id", user.id);

  if (error) {
    log.error("Failed to archive conversation", error, { conversationId });
    throw new Error("Failed to archive conversation");
  }

  revalidatePath("/");
}

/**
 * Delete a conversation
 */
export async function deleteConversation(conversationId: string): Promise<void> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { error } = await supabase
    .from("chat_conversations")
    .delete()
    .eq("id", conversationId)
    .eq("user_id", user.id);

  if (error) {
    log.error("Failed to delete conversation", error, { conversationId });
    throw new Error("Failed to delete conversation");
  }

  revalidatePath("/");
}

/**
 * Get AI skill context for building prompts
 */
export async function getAISkillContext() {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .rpc("get_ai_skill_context", {
      p_user_id: user.id,
    });

  if (error) {
    log.error("Failed to get skill context", error);
    throw new Error("Failed to get skill context");
  }

  return data?.[0] || {
    mastered_skills: [],
    struggling_skills: [],
    current_activity_skill: null,
    mastery_levels: {},
  };
}

/**
 * Get usage statistics
 */
export async function getUsageStats(): Promise<AIUsage | null> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const today = new Date().toISOString().split("T")[0];

  const { data, error } = await supabase
    .from("ai_usage")
    .select("*")
    .eq("user_id", user.id)
    .eq("date", today)
    .single();

  if (error && error.code !== "PGRST116") {
    log.error("Failed to get usage stats", error);
    throw new Error("Failed to get usage stats");
  }

  return data || null;
}

/**
 * Get conversation with activity and skill context
 */
export async function getConversationWithContext(conversationId: string) {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    throw new Error("Not authenticated");
  }

  const { data, error } = await supabase
    .from("chat_conversations")
    .select(`
      *,
      activity:activities(id, title, type, content),
      skill:skills(id, name, slug, description)
    `)
    .eq("id", conversationId)
    .eq("user_id", user.id)
    .single();

  if (error) {
    log.error("Failed to get conversation", error, { conversationId });
    throw new Error("Failed to get conversation");
  }

  return data;
}

/**
 * Check if the user has ever sent a chat message
 * Used to determine if we should show the welcome popup for Bob
 */
export async function hasUserChatHistory(): Promise<boolean> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return false;
  }

  // Check if user has any conversations with messages
  const { count, error } = await supabase
    .from("chat_conversations")
    .select("id", { count: "exact", head: true })
    .eq("user_id", user.id)
    .gt("message_count", 0);

  if (error) {
    log.error("Failed to check chat history", error);
    return false;
  }

  return (count ?? 0) > 0;
}

/**
 * Get course info for a skill (used to display course name in chat widget)
 */
export async function getSkillCourseInfo(skillId: string): Promise<{
  courseName: string;
  courseId: string;
} | null> {
  const supabase = await createClient();
  
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) {
    return null;
  }

  // Get skill with its course
  const { data, error } = await supabase
    .from("skills")
    .select(`
      course_id,
      course:courses(id, title)
    `)
    .eq("id", skillId)
    .single();

  if (error || !data || !data.course) {
    log.error("Failed to get skill course info", error);
    return null;
  }

  // Handle both array and single object responses
  const course = Array.isArray(data.course) ? data.course[0] : data.course;
  
  return {
    courseName: course.title,
    courseId: course.id,
  };
}

