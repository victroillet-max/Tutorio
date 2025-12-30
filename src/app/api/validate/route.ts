import { NextRequest, NextResponse } from "next/server";
import OpenAI from "openai";
import { createClient } from "@/utils/supabase/server";
import { logger } from "@/lib/logging";

const log = logger.child({ module: "api/validate" });

// Lazy initialization of OpenAI client to avoid build-time errors
function getOpenAIClient() {
  return new OpenAI({
    apiKey: process.env.OPENAI_API_KEY,
  });
}

interface ValidationRequest {
  code: string;
  output: string;
  instructions: string;
  aiPrompt?: string;
  activityTitle?: string;
}

interface ValidationResult {
  passed: boolean;
  score: number; // 0-100
  feedback: string;
  suggestions: string[];
  details: {
    requirementsMet: boolean;
    codeQuality: "good" | "acceptable" | "needs_improvement";
    issues: string[];
  };
}

export async function POST(request: NextRequest) {
  try {
    // Verify user is authenticated
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    
    if (!user) {
      return NextResponse.json(
        { error: "Unauthorized" },
        { status: 401 }
      );
    }

    // Check if OpenAI API key is configured
    if (!process.env.OPENAI_API_KEY) {
      return NextResponse.json(
        { error: "AI validation is not configured" },
        { status: 500 }
      );
    }

    const body: ValidationRequest = await request.json();
    const { code, output, instructions, aiPrompt, activityTitle } = body;

    if (!code || !instructions) {
      return NextResponse.json(
        { error: "Missing required fields: code, instructions" },
        { status: 400 }
      );
    }

    // Build the validation prompt
    const systemPrompt = `You are a Python programming tutor evaluating student code. 
Your job is to determine if the student's code meets the exercise requirements.

Be encouraging but accurate. If the code doesn't fully meet requirements, explain what's missing.
Focus on whether the requirements are met, not on advanced best practices for beginners.

Respond in JSON format with this structure:
{
  "passed": boolean,
  "score": number (0-100),
  "feedback": "Brief, friendly feedback message",
  "suggestions": ["suggestion 1", "suggestion 2"],
  "details": {
    "requirementsMet": boolean,
    "codeQuality": "good" | "acceptable" | "needs_improvement",
    "issues": ["issue 1 if any"]
  }
}`;

    const userPrompt = `Exercise: ${activityTitle || "Python Exercise"}

Instructions:
${instructions}

${aiPrompt ? `Specific Requirements to Check:\n${aiPrompt}\n` : ""}
Student's Code:
\`\`\`python
${code}
\`\`\`

Output produced:
\`\`\`
${output || "(no output)"}
\`\`\`

Evaluate if this code meets the exercise requirements. Be specific about what's correct and what needs improvement.`;

    // Call OpenAI API
    const openai = getOpenAIClient();
    const completion = await openai.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
        { role: "system", content: systemPrompt },
        { role: "user", content: userPrompt },
      ],
      temperature: 0.3,
      max_tokens: 500,
      response_format: { type: "json_object" },
    });

    const responseText = completion.choices[0]?.message?.content;
    
    if (!responseText) {
      return NextResponse.json(
        { error: "No response from AI" },
        { status: 500 }
      );
    }

    // Parse the JSON response
    let result: ValidationResult;
    try {
      result = JSON.parse(responseText);
    } catch {
      log.error("Failed to parse AI response", undefined, { responseText });
      return NextResponse.json(
        { error: "Invalid AI response format" },
        { status: 500 }
      );
    }

    // Ensure all required fields exist
    const validatedResult: ValidationResult = {
      passed: result.passed ?? false,
      score: result.score ?? (result.passed ? 100 : 0),
      feedback: result.feedback ?? "Unable to evaluate code",
      suggestions: Array.isArray(result.suggestions) ? result.suggestions : [],
      details: {
        requirementsMet: result.details?.requirementsMet ?? result.passed ?? false,
        codeQuality: result.details?.codeQuality ?? "acceptable",
        issues: Array.isArray(result.details?.issues) ? result.details.issues : [],
      },
    };

    return NextResponse.json(validatedResult);

  } catch (error) {
    log.error("Validation error", error);
    
    // Handle specific OpenAI errors
    if (error instanceof OpenAI.APIError) {
      if (error.status === 401) {
        return NextResponse.json(
          { error: "Invalid OpenAI API key" },
          { status: 500 }
        );
      }
      if (error.status === 429) {
        return NextResponse.json(
          { error: "AI rate limit exceeded. Please try again in a moment." },
          { status: 429 }
        );
      }
    }

    return NextResponse.json(
      { error: "Failed to validate code" },
      { status: 500 }
    );
  }
}

