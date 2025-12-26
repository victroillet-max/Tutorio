import { NextRequest, NextResponse } from "next/server";
import OpenAI from "openai";
import { createClient } from "@/utils/supabase/server";

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

interface ErrorExplanationRequest {
  error: string;
  code: string;
  activityTitle?: string;
}

interface ErrorExplanationResult {
  explanation: string;
  fix: string;
  example?: string;
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

    if (!process.env.OPENAI_API_KEY) {
      return NextResponse.json(
        { error: "AI is not configured" },
        { status: 500 }
      );
    }

    const body: ErrorExplanationRequest = await request.json();
    const { error, code, activityTitle } = body;

    if (!error || !code) {
      return NextResponse.json(
        { error: "Missing required fields" },
        { status: 400 }
      );
    }

    const systemPrompt = `You are a friendly Python tutor helping a beginner understand their error.

Your job is to:
1. Explain the error in simple, beginner-friendly language
2. Show them how to fix it
3. Optionally provide a small code example

Be encouraging and patient. Use simple terms. Avoid jargon.

Respond in JSON format:
{
  "explanation": "Simple explanation of what went wrong",
  "fix": "How to fix this specific error",
  "example": "Optional: A small code snippet showing the correct way (or null)"
}`;

    const userPrompt = `Exercise: ${activityTitle || "Python Exercise"}

Student's code:
\`\`\`python
${code}
\`\`\`

Error message:
${error}

Please explain this error to a beginner Python student.`;

    const completion = await openai.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
        { role: "system", content: systemPrompt },
        { role: "user", content: userPrompt },
      ],
      temperature: 0.3,
      max_tokens: 400,
      response_format: { type: "json_object" },
    });

    const responseText = completion.choices[0]?.message?.content;
    
    if (!responseText) {
      return NextResponse.json(
        { error: "No response from AI" },
        { status: 500 }
      );
    }

    let result: ErrorExplanationResult;
    try {
      result = JSON.parse(responseText);
    } catch {
      console.error("Failed to parse AI response:", responseText);
      return NextResponse.json(
        { error: "Invalid AI response" },
        { status: 500 }
      );
    }

    return NextResponse.json({
      explanation: result.explanation || "An error occurred in your code.",
      fix: result.fix || "Check your code for typos and syntax issues.",
      example: result.example || null,
    });

  } catch (error) {
    console.error("Error explanation failed:", error);
    return NextResponse.json(
      { error: "Failed to explain error" },
      { status: 500 }
    );
  }
}

