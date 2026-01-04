import { createClient } from "@/utils/supabase/server";
import { NextRequest } from "next/server";
import { buildSystemPrompt, type SkillContext, type CourseMaterialContext } from "@/lib/ai/prompts";
import { chatMessageSchema, createValidationErrorResponse } from "@/lib/validation/schemas";
import { logger, startTimer } from "@/lib/logging";
import { getAIRateLimit } from "@/lib/config";

// Check if OpenAI is configured
const OPENAI_API_KEY = process.env.OPENAI_API_KEY;
const OPENAI_MODEL = process.env.OPENAI_MODEL || "gpt-4o-mini";

// Interface for activity with full context
interface ActivityWithContext {
  id: string;
  title: string;
  type: string;
  content: Record<string, unknown> | null;
  starter_code: string | null;
  hints?: string[];
  passing_score: number | null;
  module: {
    id: string;
    title: string;
    description: string | null;
    course: {
      id: string;
      title: string;
      description: string | null;
    };
  } | null;
}

export async function POST(request: NextRequest) {
  const timer = startTimer();
  const log = logger.child({ handler: "chat" });

  try {
    // Check authentication
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    
    if (!user) {
      log.warn("Unauthorized chat attempt");
      return new Response(JSON.stringify({ error: "Unauthorized" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Parse and validate request body
    let body;
    try {
      body = await request.json();
    } catch {
      log.warn("Chat request body parse failed");
      return new Response(JSON.stringify({ 
        error: "Invalid request",
        message: "Could not parse your message. Please try again.",
      }), {
        status: 400,
        headers: { "Content-Type": "application/json" },
      });
    }
    
    const validation = chatMessageSchema.safeParse(body);
    
    if (!validation.success) {
      log.warn("Chat validation failed", { errors: validation.error.flatten() });
      // Provide more helpful error messages
      const issues = validation.error.issues;
      const messageIssue = issues.find(i => i.path[0] === 'message');
      if (messageIssue) {
        return new Response(JSON.stringify({ 
          error: "Message issue",
          message: messageIssue.message,
        }), {
          status: 400,
          headers: { "Content-Type": "application/json" },
        });
      }
      return createValidationErrorResponse(validation.error.issues);
    }

    const { 
      message, 
      conversationId, 
      activityId, 
      skillId,
      courseId: providedCourseId,
      studentCode,
      errorMessage,
      currentQuestionText,
      currentQuestionNumber,
    } = validation.data;

    // If courseId not provided but skillId is, get course from skill
    let courseId = providedCourseId;
    if (!courseId && skillId) {
      const { data: skillData } = await supabase
        .from("skills")
        .select("course_id")
        .eq("id", skillId)
        .single();
      courseId = skillData?.course_id || undefined;
    }

    // Get user's rate limit info and check if they can send (per-course)
    const { data: rateLimitInfo } = await supabase.rpc("get_user_rate_limit", {
      p_user_id: user.id,
      p_course_id: courseId || null,
    });

    const rateLimit = rateLimitInfo?.[0];
    const tier = (rateLimit?.tier || 'free') as keyof typeof import("@/lib/config").AI_RATE_LIMITS;
    const messagesRemaining = rateLimit?.messages_remaining_today || 0;
    const tierConfig = getAIRateLimit(tier);

    // Check rate limit (per-course)
    const { data: canSend } = await supabase.rpc("can_send_ai_message", {
      p_user_id: user.id,
      p_course_id: courseId || null,
    });

    if (!canSend) {
      // Provide tier-specific messaging
      let upgradeMessage = "";
      if (tier === 'free') {
        upgradeMessage = "Subscribe to a course to unlock 25 AI messages per day with Basic, or unlimited with Advanced.";
      } else if (tier === 'basic') {
        upgradeMessage = "Upgrade to Advanced for unlimited AI tutor access.";
      }

      log.info("Rate limit exceeded", { userId: user.id, tier });

      return new Response(JSON.stringify({ 
        error: "Rate limit exceeded",
        message: `You've used all ${tierConfig.messagesPerDay} AI messages for today. ${upgradeMessage}`,
        tier,
        limit: tierConfig.messagesPerDay,
        remaining: 0,
      }), {
        status: 429,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Get or create conversation
    let convId = conversationId;
    if (!convId) {
      const { data: newConv, error: convError } = await supabase
        .from("chat_conversations")
        .insert({
          user_id: user.id,
          activity_id: activityId || null,
          skill_id: skillId || null,
          course_id: courseId || null,
          title: message.slice(0, 50) + (message.length > 50 ? "..." : ""),
        })
        .select()
        .single();

      if (convError) {
        log.error("Failed to create conversation", convError, { userId: user.id });
        return new Response(JSON.stringify({ error: "Failed to create conversation" }), {
          status: 500,
          headers: { "Content-Type": "application/json" },
        });
      }
      convId = newConv.id;
    }

    // Get skill context for personalized responses
    const { data: skillContext } = await supabase.rpc("get_ai_skill_context", {
      p_user_id: user.id,
    });

    // Get full activity context including module and course info
    let activityWithContext: ActivityWithContext | null = null;
    if (activityId) {
      const { data } = await supabase
        .from("activities")
        .select(`
          id,
          title,
          type,
          content,
          starter_code,
          passing_score,
          module:modules(
            id,
            title,
            description,
            course:courses(
              id,
              title,
              description
            )
          )
        `)
        .eq("id", activityId)
        .single();
      
      if (data) {
        const moduleData = data.module as unknown as ActivityWithContext["module"][] | ActivityWithContext["module"];
        activityWithContext = {
          ...data,
          module: Array.isArray(moduleData) ? moduleData[0] : moduleData,
        };
      }
    }

    // Get current skill if available
    let currentSkill = null;
    if (skillId) {
      const { data } = await supabase
        .from("skills")
        .select("slug, name")
        .eq("id", skillId)
        .single();
      currentSkill = data?.slug;
    }

    // Build course material context from activity data
    let courseMaterialContext: CourseMaterialContext | undefined;
    if (activityWithContext) {
      const content = activityWithContext.content as Record<string, unknown> | null;
      courseMaterialContext = {
        courseName: activityWithContext.module?.course?.title,
        courseDescription: activityWithContext.module?.course?.description || undefined,
        moduleName: activityWithContext.module?.title,
        moduleDescription: activityWithContext.module?.description || undefined,
        activityTitle: activityWithContext.title,
        activityType: activityWithContext.type,
        instructions: content?.instructions as string | undefined,
        hints: (content?.hints as string[]) || undefined,
        testCases: content?.test_cases || content?.testCases 
          ? formatTestCasesForPrompt(content?.test_cases || content?.testCases) 
          : undefined,
        starterCode: activityWithContext.starter_code || (content?.starter_code as string) || (content?.starterCode as string) || undefined,
        passingScore: activityWithContext.passing_score || undefined,
        quizQuestions: content?.questions ? formatQuizQuestionsForPrompt(content.questions) : undefined,
        lessonContent: activityWithContext.type === 'lesson' ? (content?.body as string) || (content?.content as string) : undefined,
      };
    }

    // Build skill context for prompt
    const context: SkillContext = {
      masteredSkills: skillContext?.[0]?.mastered_skills || [],
      strugglingSkills: skillContext?.[0]?.struggling_skills || [],
      currentSkill: currentSkill || undefined,
      masteryLevels: skillContext?.[0]?.mastery_levels || {},
      currentActivity: activityWithContext ? {
        title: activityWithContext.title,
        type: activityWithContext.type,
      } : undefined,
      studentCode: studentCode || undefined,
      errorMessage: errorMessage || undefined,
      courseMaterial: courseMaterialContext,
      currentQuestionText: currentQuestionText || undefined,
      currentQuestionNumber: currentQuestionNumber || undefined,
    };

    // Build system prompt
    const systemPrompt = buildSystemPrompt(context);

    // Get conversation history
    const { data: history } = await supabase
      .from("chat_messages")
      .select("role, content")
      .eq("conversation_id", convId)
      .order("created_at", { ascending: true })
      .limit(10);

    // Build messages array for OpenAI
    const messages = [
      { role: "system" as const, content: systemPrompt },
      ...(history || []).map(h => ({
        role: h.role as "user" | "assistant",
        content: h.content,
      })),
      { role: "user" as const, content: message },
    ];

    // Save user message
    await supabase.from("chat_messages").insert({
      conversation_id: convId,
      role: "user",
      content: message,
      metadata: {
        activityId,
        skillId,
        hasCode: !!studentCode,
        hasError: !!errorMessage,
      },
    });

    // Increment usage (per-course)
    await supabase.rpc("increment_ai_usage", {
      p_user_id: user.id,
      p_tokens: 0, // Will be updated after response
      p_course_id: courseId || null,
    });

    // Check if OpenAI is configured
    if (!OPENAI_API_KEY) {
      // Return a mock response for development
      const mockResponse = getMockResponse(message, context);
      
      // Save assistant message
      await supabase.from("chat_messages").insert({
        conversation_id: convId,
        role: "assistant",
        content: mockResponse,
        tokens_used: 0,
      });

      timer.log("Chat completed (mock)", { userId: user.id, conversationId: convId });

      return new Response(JSON.stringify({
        message: mockResponse,
        conversationId: convId,
        mock: true,
        rateLimit: {
          tier,
          limit: tierConfig.messagesPerDay,
          remaining: Math.max(0, messagesRemaining - 1),
        },
      }), {
        headers: { "Content-Type": "application/json" },
      });
    }

    // Call OpenAI API
    const openaiResponse = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${OPENAI_API_KEY}`,
      },
      body: JSON.stringify({
        model: OPENAI_MODEL,
        messages,
        temperature: 0.7,
        max_tokens: 1000,
        stream: false,
      }),
    });

    if (!openaiResponse.ok) {
      const errorData = await openaiResponse.json();
      log.error("OpenAI API error", new Error(errorData.error?.message), { statusCode: openaiResponse.status });
      return new Response(JSON.stringify({ 
        error: "AI service error",
        details: errorData.error?.message || "Unknown error",
      }), {
        status: 500,
        headers: { "Content-Type": "application/json" },
      });
    }

    const completion = await openaiResponse.json();
    const assistantMessage = completion.choices[0]?.message?.content || "I apologize, but I couldn't generate a response. Please try again.";
    const tokensUsed = completion.usage?.total_tokens || 0;

    // Save assistant message
    await supabase.from("chat_messages").insert({
      conversation_id: convId,
      role: "assistant",
      content: assistantMessage,
      tokens_used: tokensUsed,
    });

    timer.log("Chat completed", { userId: user.id, conversationId: convId, tokensUsed });

    return new Response(JSON.stringify({
      message: assistantMessage,
      conversationId: convId,
      tokensUsed,
      rateLimit: {
        tier,
        limit: tierConfig.messagesPerDay,
        remaining: Math.max(0, messagesRemaining - 1),
      },
    }), {
      headers: { "Content-Type": "application/json" },
    });

  } catch (error) {
    log.error("Chat API error", error);
    return new Response(JSON.stringify({ 
      error: "Internal server error",
      message: error instanceof Error ? error.message : "Unknown error",
    }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
}

/**
 * Mock response for development when OpenAI is not configured
 */
function getMockResponse(message: string, context: SkillContext): string {
  const lowerMessage = message.toLowerCase();
  const courseMaterial = context.courseMaterial;

  // If asking about the current question/problem and we have context
  if ((lowerMessage.includes("question") || lowerMessage.includes("problem") || lowerMessage.includes("this") || lowerMessage.includes("understand")) && courseMaterial) {
    // For quiz/checkpoint activities
    if (courseMaterial.quizQuestions) {
      return `I can see you're working on **${courseMaterial.activityTitle}** in the ${courseMaterial.moduleName || "current module"}.

Here's what this activity is about:
${courseMaterial.activityType === 'checkpoint' ? "This is a checkpoint assessment to test your understanding." : ""}

**The questions in this activity:**
${courseMaterial.quizQuestions}

I can help you understand any of these questions! Which one would you like help with? I'll guide you through the concept without giving away the answer.`;
    }

    // For code activities
    if (courseMaterial.instructions) {
      return `I can see you're working on **${courseMaterial.activityTitle}**.

**Instructions:**
${courseMaterial.instructions}

${courseMaterial.testCases ? `**Test Cases to pass:**\n${courseMaterial.testCases}` : ""}

What part would you like help understanding?`;
    }

    // Generic activity context
    return `I can see you're working on **${courseMaterial.activityTitle}** (${courseMaterial.activityType}).

${courseMaterial.moduleName ? `This is part of: ${courseMaterial.moduleName}` : ""}

What specifically would you like help with?`;
  }

  if (lowerMessage.includes("help") || lowerMessage.includes("stuck")) {
    const activityContext = courseMaterial 
      ? `I see you're working on "${courseMaterial.activityTitle}". ${courseMaterial.instructions ? `\n\n**The task:** ${courseMaterial.instructions.slice(0, 200)}...` : ""}\n\n`
      : (context.currentActivity ? `I see you're working on "${context.currentActivity.title}". ` : "");
    
    return `I'd be happy to help! 

${activityContext}Let me ask you a few questions to understand where you're at:
1. What are you trying to accomplish?
2. What have you tried so far?
3. What result are you getting vs. what you expected?

Take your time explaining - I'm here to help you learn, not just give answers!`;
  }

  if (lowerMessage.includes("error") || context.errorMessage) {
    return `I see you're encountering an error. Let's work through this together!

**Common debugging steps:**
1. Read the error message carefully - it often tells you exactly what's wrong
2. Check the line number mentioned in the error
3. Look for typos or missing syntax

${context.errorMessage ? `\nThe error mentions: \`${context.errorMessage}\`\n\nCan you tell me what you were trying to do when this happened?` : "Can you share the error message you're seeing?"}`;
  }

  if (lowerMessage.includes("loop") || lowerMessage.includes("for") || lowerMessage.includes("while")) {
    return `Great question about loops!

**Quick reminder:**
- \`for\` loops are great when you know how many times to repeat
- \`while\` loops are better when you repeat until a condition changes

\`\`\`python
# For loop example
for i in range(5):
    print(f"Iteration {i}")

# While loop example
count = 0
while count < 5:
    print(f"Count is {count}")
    count += 1
\`\`\`

What specifically about loops would you like to explore?`;
  }

  if (lowerMessage.includes("function") || lowerMessage.includes("def")) {
    return `Functions are a great topic! They help you organize and reuse code.

**Basic structure:**
\`\`\`python
def greet_guest(name):
    return f"Welcome, {name}!"

# Using the function
message = greet_guest("Alice")
print(message)  # Welcome, Alice!
\`\`\`

${context.strugglingSkills?.includes("fn-parameters-arguments") 
  ? "I notice you might benefit from reviewing parameters and arguments. Would you like me to explain those concepts?" 
  : "What would you like to know about functions?"}`;
  }

  // Default response with context awareness
  const activityInfo = courseMaterial 
    ? `I can see you're working on **${courseMaterial.activityTitle}**${courseMaterial.moduleName ? ` in ${courseMaterial.moduleName}` : ""}. Ask me anything about this ${courseMaterial.activityType}!`
    : "";

  return `Thanks for your question! 

I'm Bob, your AI Tutor. I'm here to help you learn and succeed.

${activityInfo}

${context.strugglingSkills?.length 
  ? `I notice you're working on mastering some concepts like ${context.strugglingSkills.slice(0, 2).join(" and ")}. Feel free to ask me about any of these!`
  : "Feel free to ask me about any concept, or share your work for help."}

**I can help with:**
- Explaining concepts in simple terms
- Debugging code and solving problems
- Providing hints for exercises
- Answering questions about your current activity

What would you like to explore?`;
}

/**
 * Format test cases for the AI prompt (hide actual expected outputs for challenges)
 */
function formatTestCasesForPrompt(testCases: unknown): string | undefined {
  if (!Array.isArray(testCases) || testCases.length === 0) return undefined;
  
  const formatted = testCases
    .filter((tc: { is_hidden?: boolean }) => !tc.is_hidden) // Only include visible test cases
    .map((tc: { description?: string; input?: string; expected_output?: string }, index: number) => {
      const parts = [`Test ${index + 1}:`];
      if (tc.description) parts.push(`  Description: ${tc.description}`);
      if (tc.input) parts.push(`  Input: ${tc.input}`);
      if (tc.expected_output) parts.push(`  Expected Output: ${tc.expected_output}`);
      return parts.join('\n');
    })
    .join('\n\n');
  
  return formatted || undefined;
}

/**
 * Format quiz questions for the AI prompt (without revealing answers)
 */
function formatQuizQuestionsForPrompt(questions: unknown): string | undefined {
  if (!Array.isArray(questions) || questions.length === 0) return undefined;
  
  const formatted = questions.map((q: { 
    question?: string; 
    type?: string;
    options?: string[];
  }, index: number) => {
    const parts = [`Question ${index + 1}: ${q.question || 'No question text'}`];
    if (q.type) parts.push(`  Type: ${q.type}`);
    if (q.options && Array.isArray(q.options)) {
      parts.push(`  Options: ${q.options.join(', ')}`);
    }
    return parts.join('\n');
  }).join('\n\n');
  
  return formatted || undefined;
}
