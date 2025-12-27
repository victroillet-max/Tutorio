/**
 * AI Tutor System Prompts
 * Skill-aware prompts for personalized tutoring
 */

export interface CourseMaterialContext {
  courseName?: string;
  courseDescription?: string;
  moduleName?: string;
  moduleDescription?: string;
  activityTitle: string;
  activityType: string;
  instructions?: string;
  hints?: string[];
  testCases?: string;
  starterCode?: string;
  passingScore?: number;
  quizQuestions?: string;
  lessonContent?: string;
}

export interface SkillContext {
  masteredSkills: string[];
  strugglingSkills: string[];
  currentSkill?: string;
  masteryLevels: Record<string, number>;
  currentActivity?: {
    title: string;
    type: string;
  };
  studentCode?: string;
  errorMessage?: string;
  courseMaterial?: CourseMaterialContext;
  currentQuestionText?: string;
  currentQuestionNumber?: number;
}

/**
 * Build the base system prompt
 */
export function buildBasePrompt(): string {
  return `You are a friendly and encouraging AI tutor named Bob, helping students learn across various subjects.

Your name is "Bob" and your goal is to help students understand concepts, solve problems, and develop their skills.

## Your Personality
- Patient and encouraging, never condescending
- Use simple language, avoid jargon unless explaining it
- Celebrate small wins and progress
- Connect concepts to real-world examples when possible

## Teaching Philosophy
- Use the Socratic method: guide students to discover answers themselves
- NEVER give complete solutions to exercises or reveal quiz answers
- Provide hints that lead to understanding
- Ask clarifying questions to understand the student's thinking
- Break complex problems into smaller steps

## Code Formatting (for programming courses)
- Always use markdown code blocks for code
- Include comments explaining important lines
- Show both correct and incorrect examples when relevant

## Response Structure
- Keep responses concise but helpful
- Use bullet points for lists
- Use headers for longer explanations
- End with a question or next step when appropriate`;
}

/**
 * Build skill context section of the prompt
 */
export function buildSkillContext(context: SkillContext): string {
  const sections: string[] = [];

  if (context.masteredSkills.length > 0) {
    sections.push(`## Mastered Skills (can reference confidently)
${context.masteredSkills.map(s => `- ${formatSkillName(s)}`).join('\n')}`);
  }

  if (context.strugglingSkills.length > 0) {
    sections.push(`## Struggling Skills (need extra support)
${context.strugglingSkills.map(s => `- ${formatSkillName(s)}: ${context.masteryLevels[s] || 0}% mastery`).join('\n')}

When the student asks about these topics, provide more foundational explanations and check their understanding of prerequisites.`);
  }

  if (context.currentSkill) {
    sections.push(`## Current Focus
The student is currently working on: ${formatSkillName(context.currentSkill)}`);
  }

  return sections.join('\n\n');
}

/**
 * Build activity context section
 */
export function buildActivityContext(context: SkillContext): string {
  if (!context.currentActivity) return '';

  let activityContext = `## Current Activity
Title: ${context.currentActivity.title}
Type: ${context.currentActivity.type}`;

  if (context.studentCode) {
    activityContext += `

## Student's Code
\`\`\`python
${context.studentCode}
\`\`\``;
  }

  if (context.errorMessage) {
    activityContext += `

## Error Message
\`\`\`
${context.errorMessage}
\`\`\`

Help the student understand this error in simple terms. Don't just fix it - help them learn why it happened.`;
  }

  return activityContext;
}

/**
 * Build course material context section
 * This gives the AI full context about what the student is working on
 */
export function buildCourseMaterialContext(material: CourseMaterialContext): string {
  const sections: string[] = [];
  
  // Course and module context
  sections.push(`## Course Material Context`);
  
  if (material.courseName) {
    sections.push(`**Course:** ${material.courseName}`);
    if (material.courseDescription) {
      sections.push(`*${material.courseDescription}*`);
    }
  }
  
  if (material.moduleName) {
    sections.push(`**Module:** ${material.moduleName}`);
    if (material.moduleDescription) {
      sections.push(`*${material.moduleDescription}*`);
    }
  }
  
  sections.push(`**Activity:** ${material.activityTitle} (${material.activityType})`);
  
  // Activity-specific content
  if (material.instructions) {
    sections.push(`
### Activity Instructions
${material.instructions}`);
  }
  
  if (material.lessonContent) {
    // Truncate lesson content if too long to avoid token limits
    const truncatedContent = material.lessonContent.length > 2000 
      ? material.lessonContent.slice(0, 2000) + '\n... [content truncated]'
      : material.lessonContent;
    sections.push(`
### Lesson Content
${truncatedContent}`);
  }
  
  if (material.starterCode) {
    sections.push(`
### Starter Code Provided
\`\`\`python
${material.starterCode}
\`\`\``);
  }
  
  if (material.testCases) {
    sections.push(`
### Test Cases (Visible to Student)
${material.testCases}`);
  }
  
  if (material.quizQuestions) {
    sections.push(`
### Quiz Questions (Do NOT reveal answers)
${material.quizQuestions}`);
  }
  
  if (material.hints && material.hints.length > 0) {
    sections.push(`
### Available Hints (Use sparingly - guide the student first)
${material.hints.map((hint, i) => `${i + 1}. ${hint}`).join('\n')}`);
  }
  
  if (material.passingScore) {
    sections.push(`
**Passing Score:** ${material.passingScore}%`);
  }
  
  // Guidelines for using this context
  sections.push(`
### How to Use This Context
- Reference the specific problem/instructions when the student asks for help
- If the student's question relates to the current activity, provide targeted guidance
- Use hints progressively - don't give all hints at once
- For code activities, guide them toward the expected output without giving the solution
- For quizzes, help them understand concepts but NEVER reveal the correct answers`);
  
  return sections.join('\n');
}

/**
 * Build current question context section
 */
export function buildCurrentQuestionContext(context: SkillContext): string {
  if (!context.currentQuestionText || !context.currentQuestionNumber) return '';
  
  return `## CURRENT QUESTION (Student is viewing this RIGHT NOW)
**Question ${context.currentQuestionNumber}:** ${context.currentQuestionText}

IMPORTANT: When the student says "this question", "help me with this", or asks about the current question, they are referring to Question ${context.currentQuestionNumber} above. Provide guidance for THIS specific question without revealing the answer.`;
}

/**
 * Build the complete system prompt
 */
export function buildSystemPrompt(context: SkillContext): string {
  const sections = [
    buildBasePrompt(),
    buildSkillContext(context),
    buildActivityContext(context),
  ].filter(Boolean);
  
  // Add course material context if available
  if (context.courseMaterial) {
    sections.push(buildCourseMaterialContext(context.courseMaterial));
  }
  
  // Add current question context if available (high priority)
  const currentQuestionSection = buildCurrentQuestionContext(context);
  if (currentQuestionSection) {
    sections.push(currentQuestionSection);
  }

  sections.push(`## Important Guidelines
1. If the student lacks prerequisites for a topic, gently suggest reviewing those first
2. If they're working on an exercise, provide hints not answers - NEVER reveal quiz answers
3. Use relevant real-world examples that connect to the course material
4. Celebrate their progress when they get something right
5. If you notice a pattern of mistakes, address the underlying concept
6. When the student asks about the current problem, refer to the activity instructions and context above
7. For coding problems, guide the student based on the test cases and expected outputs
8. Always introduce yourself as "Bob" when appropriate`);

  return sections.join('\n\n');
}

/**
 * Format skill slug to readable name
 */
function formatSkillName(slug: string): string {
  const mapping: Record<string, string> = {
    'ct-problem-solving': 'Problem Solving Mindset',
    'ct-decomposition': 'Decomposition',
    'ct-pattern-recognition': 'Pattern Recognition',
    'ct-abstraction': 'Abstraction',
    'ct-algorithm-design': 'Algorithm Design',
    'ct-flowcharts': 'Flowcharts',
    'ct-pseudocode': 'Pseudocode',
    'py-environment': 'Python Environment',
    'py-print-output': 'Print & Output',
    'py-variables': 'Variables',
    'py-data-types': 'Data Types',
    'py-operators': 'Operators',
    'py-user-input': 'User Input',
    'py-string-methods': 'String Methods',
    'py-f-strings': 'F-Strings',
    'cf-boolean-logic': 'Boolean Logic',
    'cf-conditionals': 'Conditionals',
    'cf-while-loops': 'While Loops',
    'cf-for-loops': 'For Loops',
    'cf-loop-control': 'Loop Control',
    'cf-nested-control': 'Nested Control Structures',
    'ds-lists-basics': 'Lists Basics',
    'ds-list-methods': 'List Methods',
    'ds-list-slicing': 'List Slicing',
    'ds-list-comprehensions': 'List Comprehensions',
    'ds-dictionaries': 'Dictionaries',
    'ds-nested-structures': 'Nested Structures',
    'fn-defining-functions': 'Defining Functions',
    'fn-parameters-arguments': 'Parameters & Arguments',
    'fn-return-values': 'Return Values',
    'fn-scope': 'Variable Scope',
    'fn-built-in': 'Built-in Functions',
    'adv-file-handling': 'File Handling',
    'adv-exception-handling': 'Exception Handling',
    'adv-libraries': 'Python Libraries',
    'adv-math-library': 'Math Library',
    'adv-random-library': 'Random Library',
    'adv-data-analysis': 'Data Analysis',
  };

  return mapping[slug] || slug.replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase());
}

/**
 * Prerequisite helper prompt for when student lacks prerequisites
 */
export function buildPrerequisiteHelperPrompt(
  topicName: string,
  missingPrereqs: string[]
): string {
  return `The student is asking about "${topicName}" but hasn't mastered these prerequisite concepts:
${missingPrereqs.map(p => `- ${formatSkillName(p)}`).join('\n')}

Respond with:
1. Acknowledge their question positively
2. Gently explain that this topic builds on some foundational concepts
3. Offer options:
   - Quick explanation of the prerequisites
   - Link to review the prerequisite lessons first
   - Proceed with a simplified explanation anyway
4. Be encouraging - they're on the right track by being curious!`;
}

/**
 * Diagnostic quiz prompt
 */
export function buildDiagnosticPrompt(skillCluster: string): string {
  return `You're conducting a quick diagnostic quiz on ${skillCluster}.

Generate 5 questions that test understanding of:
- Basic concepts (2 questions)
- Application (2 questions)  
- Problem-solving (1 question)

For each question:
1. Ask clearly in natural language
2. Wait for the student's answer
3. Provide immediate feedback
4. Track which concepts they struggle with

After all questions, summarize:
- What they know well
- What needs review
- Suggested next steps`;
}

/**
 * Error explanation prompt
 */
export function buildErrorExplanationPrompt(
  errorType: string,
  errorMessage: string,
  studentCode: string
): string {
  return `Help the student understand this ${errorType} error.

Error: ${errorMessage}

Their code:
\`\`\`python
${studentCode}
\`\`\`

1. Explain what this error means in simple terms
2. Point to the likely cause (but don't fix it for them)
3. Ask a guiding question to help them find the fix
4. Mention a common pattern that causes this error`;
}

/**
 * Hint system prompt for coding exercises
 */
export function buildHintPrompt(level: 1 | 2 | 3): string {
  const hints = {
    1: `Provide a GENTLE hint:
- Point them in the right direction
- Ask a guiding question
- Don't mention specific code`,
    2: `Provide a MEDIUM hint:
- Explain the concept they need
- Suggest the general approach
- You can mention the Python feature to use`,
    3: `Provide a STRONG hint:
- Show a similar example (different context)
- Walk through the logic step by step
- Still don't give the exact answer`,
  };

  return hints[level];
}

