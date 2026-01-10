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

// Enhanced question context from frontend
export interface EnhancedQuestionContext {
  number: number;
  text: string;
  type?: string;
  options?: string[];
  hint?: string;
}

// Scenario context from frontend
export interface ScenarioContext {
  title?: string;
  description: string;
  companyName?: string;
}

// Reference data item from frontend
export interface ReferenceDataItem {
  title: string;
  content: string;
}

// Related lesson for course-wide context
export interface RelatedLesson {
  title: string;
  type: string;
  summary?: string;
}

export interface SkillContext {
  masteredSkills: string[];
  strugglingSkills: string[];
  currentSkill?: string;
  currentSkillName?: string;
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
  // Enhanced context from frontend
  enhancedQuestion?: EnhancedQuestionContext;
  currentScenario?: ScenarioContext;
  referenceData?: ReferenceDataItem[];
  activityInstructions?: string;
  // Course-wide context
  relatedLessons?: RelatedLesson[];
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
  // Use enhanced question context if available, fall back to legacy fields
  const questionText = context.enhancedQuestion?.text || context.currentQuestionText;
  const questionNumber = context.enhancedQuestion?.number || context.currentQuestionNumber;
  
  if (!questionText || !questionNumber) return '';
  
  let questionSection = `## CURRENT QUESTION (Student is viewing this RIGHT NOW)
**Question ${questionNumber}:** ${questionText}`;

  // Add question type and options if available
  if (context.enhancedQuestion) {
    if (context.enhancedQuestion.type) {
      questionSection += `\n**Type:** ${context.enhancedQuestion.type}`;
    }
    if (context.enhancedQuestion.options && context.enhancedQuestion.options.length > 0) {
      questionSection += `\n**Options:**\n${context.enhancedQuestion.options.map((opt, i) => `  ${String.fromCharCode(65 + i)}. ${opt}`).join('\n')}`;
    }
    if (context.enhancedQuestion.hint) {
      questionSection += `\n**Available Hint:** ${context.enhancedQuestion.hint}`;
    }
  }

  questionSection += `

IMPORTANT INSTRUCTIONS FOR HELPING WITH THIS QUESTION:
1. When the student says they got this question wrong, IMMEDIATELY provide a clear explanation of the underlying concept
2. Explain WHY the correct answer is correct (without just stating which answer is right)
3. Use real-world examples or analogies to make the concept memorable
4. Do NOT list all quiz questions - focus ONLY on THIS specific question
5. Keep your response focused and helpful - explain the concept in 2-3 paragraphs maximum
6. If the student's message includes an explanation from the quiz, build upon it to deepen their understanding`;
  
  return questionSection;
}

/**
 * Build scenario and reference data context section
 * This is the PRIMARY source of context when student asks "help me on this"
 */
export function buildViewingContext(context: SkillContext): string {
  const sections: string[] = [];
  
  // Scenario/background context
  if (context.currentScenario) {
    let scenarioText = `## CURRENT SCENARIO (What the student is working on)`;
    if (context.currentScenario.title || context.currentScenario.companyName) {
      scenarioText += `\n**${context.currentScenario.companyName || context.currentScenario.title}**`;
    }
    scenarioText += `\n${context.currentScenario.description}`;
    sections.push(scenarioText);
  }
  
  // Activity instructions if available
  if (context.activityInstructions) {
    sections.push(`## ACTIVITY INSTRUCTIONS
${context.activityInstructions}`);
  }
  
  // Reference data (financial tables, formulas, etc.)
  if (context.referenceData && context.referenceData.length > 0) {
    let refDataText = `## REFERENCE DATA (Available to the student)
The student can see the following data while working on this exercise:`;
    
    for (const item of context.referenceData) {
      refDataText += `\n\n### ${item.title}\n${item.content}`;
    }
    
    refDataText += `\n\n**IMPORTANT:** When the student asks about "this problem" or needs help, USE THIS DATA in your explanations. Show them how to apply the values from the reference data.`;
    
    sections.push(refDataText);
  }
  
  if (sections.length === 0) return '';
  
  return sections.join('\n\n');
}

/**
 * Build course-wide context section
 * Provides background on related lessons for curriculum-aligned explanations
 */
export function buildCourseWideContext(context: SkillContext): string {
  if (!context.relatedLessons || context.relatedLessons.length === 0) return '';
  
  let courseContext = `## COURSE CONTEXT (For curriculum-aligned explanations)`;
  
  if (context.currentSkillName) {
    courseContext += `\n**Current Skill:** ${context.currentSkillName}`;
  }
  
  courseContext += `\n\n**Related Lessons in this Skill:**`;
  
  for (const lesson of context.relatedLessons) {
    courseContext += `\n- **${lesson.title}**`;
    if (lesson.summary) {
      courseContext += `: ${lesson.summary}`;
    }
  }
  
  courseContext += `\n\n**How to use this context:**
- When explaining concepts, relate them to what the student has learned in these lessons
- Use consistent terminology from the course material
- Build on foundational concepts they should already know
- Connect new ideas to previously covered material`;
  
  return courseContext;
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
  
  // Add course-wide context for curriculum alignment
  const courseWideContext = buildCourseWideContext(context);
  if (courseWideContext) {
    sections.push(courseWideContext);
  }
  
  // Add viewing context (scenario, reference data) - HIGH PRIORITY
  const viewingContext = buildViewingContext(context);
  if (viewingContext) {
    sections.push(viewingContext);
  }
  
  // Add current question context if available (high priority)
  const currentQuestionSection = buildCurrentQuestionContext(context);
  if (currentQuestionSection) {
    sections.push(currentQuestionSection);
  }

  sections.push(`## Important Guidelines for Answering

### When Student Says "Help me on this" or Similar
1. IMMEDIATELY refer to the CURRENT QUESTION, SCENARIO, and REFERENCE DATA sections above
2. Use specific values from the reference data to illustrate your explanation
3. Guide them through the problem step-by-step using the actual numbers provided
4. Don't just give the answer - explain the concept using the specific context

### Teaching Approach (Hints First, Then More Direct Help)
1. Start with guiding hints that point toward the solution
2. If the student is clearly stuck after one attempt, provide more direct explanation
3. When they explicitly ask for help understanding something, give a clear conceptual explanation
4. For quiz questions: explain WHY an answer is correct without directly stating which option it is
5. For calculation exercises: show the methodology using reference data, let them compute the final answer

### General Guidelines
1. If the student lacks prerequisites, gently suggest reviewing those first
2. Use real-world examples that connect to the course material
3. Celebrate progress when they get something right
4. If you notice a pattern of mistakes, address the underlying concept
5. For coding problems, guide based on test cases and expected outputs
6. Always introduce yourself as "Bob" when appropriate`);

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

