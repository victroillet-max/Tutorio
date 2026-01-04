/**
 * Activity Content Validation Schemas
 * 
 * Defines Zod schemas for validating the content structure of different
 * activity types and interactive components. Helps catch format mismatches
 * early during content creation or migration.
 */

import { z } from "zod";

// ============================================
// Common Schemas
// ============================================

/**
 * Base question schema for quiz/review questions
 */
const baseQuestionSchema = z.object({
  id: z.string(),
  question: z.string().min(1, "Question text is required"),
});

/**
 * Multiple choice question schema
 */
export const choiceQuestionSchema = baseQuestionSchema.extend({
  answer_type: z.literal("choice"),
  options: z.array(z.string()).min(2, "At least 2 options required"),
  correct_answer: z.string(),
  explanation: z.string().optional(),
  hint: z.string().optional(),
});

/**
 * Numeric answer question schema
 */
export const numericQuestionSchema = baseQuestionSchema.extend({
  answer_type: z.literal("numeric"),
  correct_answer: z.union([z.number(), z.string()]),
  tolerance: z.number().optional().default(0),
  explanation: z.string().optional(),
  hint: z.string().optional(),
});

/**
 * Text answer question schema
 */
export const textQuestionSchema = baseQuestionSchema.extend({
  answer_type: z.literal("text"),
  correct_answer: z.string(),
  explanation: z.string().optional(),
  hint: z.string().optional(),
});

/**
 * Union of all question types
 */
export const questionSchema = z.discriminatedUnion("answer_type", [
  choiceQuestionSchema,
  numericQuestionSchema,
  textQuestionSchema,
]);

export type Question = z.infer<typeof questionSchema>;

// ============================================
// Interactive Content Schemas
// ============================================

/**
 * Drag-and-drop match content
 */
export const dragDropMatchContentSchema = z.object({
  instructions: z.string().optional(),
  pairs: z.array(z.object({
    left: z.string(),
    right: z.string(),
    explanation: z.string().optional(),
  })).min(2, "At least 2 pairs required"),
});

export type DragDropMatchContent = z.infer<typeof dragDropMatchContentSchema>;

/**
 * Journal entry builder content
 */
export const journalEntryBuilderContentSchema = z.object({
  instructions: z.string().optional(),
  account_options: z.array(z.string()).min(2, "At least 2 account options required"),
  transactions: z.array(z.object({
    id: z.string(),
    description: z.string(),
    date: z.string().optional(),
    hint: z.string().optional(),
    solution: z.array(z.object({
      account: z.string(),
      debit: z.number().optional(),
      credit: z.number().optional(),
    })),
    explanation: z.string().optional(),
  })).min(1, "At least 1 transaction required"),
});

export type JournalEntryBuilderContent = z.infer<typeof journalEntryBuilderContentSchema>;

/**
 * Equation analyzer content (transaction effects on accounting equation)
 */
export const equationAnalyzerContentSchema = z.object({
  instructions: z.string().optional(),
  scenarios: z.array(z.object({
    id: z.string().optional(),
    description: z.string(),
    effects: z.object({
      assets: z.number(),
      liabilities: z.number(),
      equity: z.number(),
    }),
    explanation: z.string().optional(),
  })).min(1, "At least 1 scenario required"),
});

export type EquationAnalyzerContent = z.infer<typeof equationAnalyzerContentSchema>;

/**
 * Review calculator content (question-based review)
 */
export const reviewCalculatorContentSchema = z.object({
  title: z.string().optional(),
  description: z.string().optional(),
  topics_covered: z.array(z.string()).optional(),
  questions: z.array(z.object({
    id: z.string(),
    question: z.string(),
    answer_type: z.enum(["choice", "numeric", "text"]),
    correct_answer: z.union([z.string(), z.number()]),
    tolerance: z.number().optional(),
    options: z.array(z.string()).optional(),
    hint: z.string().optional(),
    explanation: z.string(),
  })).min(1, "At least 1 question required"),
  passing_score: z.number().min(0).max(100).optional().default(70),
});

export type ReviewCalculatorContent = z.infer<typeof reviewCalculatorContentSchema>;

/**
 * Mock exam content
 */
export const mockExamContentSchema = z.object({
  exam_title: z.string().optional(),
  instructions: z.string().optional(),
  time_limit_minutes: z.number().min(1).optional().default(90),
  passing_score: z.number().min(0).max(100).optional().default(60),
  sections: z.array(z.object({
    id: z.string(),
    title: z.string(),
    description: z.string().optional(),
    questions: z.array(z.object({
      id: z.string(),
      question: z.string(),
      type: z.enum(["multiple_choice", "true_false", "calculation", "short_answer"]),
      options: z.array(z.string()).optional(),
      correct_answer: z.union([z.string(), z.number()]),
      points: z.number().default(1),
      topic: z.string().optional(),
      explanation: z.string().optional(),
    })),
  })).min(1, "At least 1 section required"),
});

export type MockExamContent = z.infer<typeof mockExamContentSchema>;

/**
 * Trial balance builder content
 */
export const trialBalanceBuilderContentSchema = z.object({
  instructions: z.string().optional(),
  accounts: z.array(z.object({
    name: z.string(),
    expected_debit: z.number().optional(),
    expected_credit: z.number().optional(),
    normal_balance: z.enum(["debit", "credit"]),
    hint: z.string().optional(),
  })).min(2, "At least 2 accounts required"),
  verification_rules: z.array(z.string()).optional(),
});

export type TrialBalanceBuilderContent = z.infer<typeof trialBalanceBuilderContentSchema>;

/**
 * Pattern game content
 */
export const patternGameContentSchema = z.object({
  instructions: z.string().optional(),
  patterns: z.array(z.object({
    sequence: z.array(z.union([z.string(), z.number()])),
    next: z.union([z.string(), z.number()]),
    rule: z.string().optional(),
    explanation: z.string().optional(),
  })).min(1, "At least 1 pattern required"),
});

export type PatternGameContent = z.infer<typeof patternGameContentSchema>;

/**
 * Filter essential content
 */
export const filterEssentialContentSchema = z.object({
  instructions: z.string().optional(),
  problem: z.string(),
  items: z.array(z.object({
    text: z.string(),
    is_essential: z.boolean(),
    explanation: z.string().optional(),
  })).min(3, "At least 3 items required"),
});

export type FilterEssentialContent = z.infer<typeof filterEssentialContentSchema>;

/**
 * Timed classification content
 */
export const timedClassificationContentSchema = z.object({
  instructions: z.string().optional(),
  time_limit_seconds: z.number().min(10).optional().default(60),
  categories: z.array(z.object({
    id: z.string(),
    name: z.string(),
    color: z.string().optional(),
  })).min(2, "At least 2 categories required"),
  items: z.array(z.object({
    text: z.string(),
    category_id: z.string(),
    explanation: z.string().optional(),
  })).min(4, "At least 4 items required"),
});

export type TimedClassificationContent = z.infer<typeof timedClassificationContentSchema>;

/**
 * CFS Classifier content
 */
export const cfsClassifierContentSchema = z.object({
  instructions: z.string().optional(),
  transactions: z.array(z.object({
    id: z.string(),
    description: z.string(),
    amount: z.number(),
    correct_category: z.enum(["operating", "investing", "financing", "non_cash"]),
    explanation: z.string().optional(),
  })).min(3, "At least 3 transactions required"),
});

export type CFSClassifierContent = z.infer<typeof cfsClassifierContentSchema>;

/**
 * Inventory calculator content
 */
export const inventoryCalculatorContentSchema = z.object({
  instructions: z.string().optional(),
  method: z.enum(["fifo", "lifo", "weighted_average", "specific_identification"]).optional(),
  transactions: z.array(z.object({
    date: z.string(),
    type: z.enum(["purchase", "sale"]),
    units: z.number(),
    unit_cost: z.number().optional(),
    unit_price: z.number().optional(),
  })).min(2, "At least 2 transactions required"),
  expected_cogs: z.number().optional(),
  expected_ending_inventory: z.number().optional(),
});

export type InventoryCalculatorContent = z.infer<typeof inventoryCalculatorContentSchema>;

// ============================================
// Quiz/Checkpoint Content Schemas
// ============================================

/**
 * Quiz content schema
 */
export const quizContentSchema = z.object({
  title: z.string().optional(),
  instructions: z.string().optional(),
  questions: z.array(z.object({
    id: z.string().optional(),
    question: z.string(),
    options: z.array(z.string()).min(2),
    correct: z.union([z.number(), z.string()]),
    explanation: z.string().optional(),
  })).min(1, "At least 1 question required"),
  passing_score: z.number().optional(),
});

export type QuizContent = z.infer<typeof quizContentSchema>;

/**
 * Checkpoint content schema
 */
export const checkpointContentSchema = z.object({
  title: z.string().optional(),
  instructions: z.string().optional(),
  time_limit_minutes: z.number().optional(),
  questions: z.array(z.object({
    id: z.string().optional(),
    question: z.string(),
    options: z.array(z.string()).min(2),
    correct: z.union([z.number(), z.string()]),
    explanation: z.string().optional(),
  })).min(1, "At least 1 question required"),
  passing_score: z.number().min(0).max(100).optional().default(75),
});

export type CheckpointContent = z.infer<typeof checkpointContentSchema>;

// ============================================
// Lesson Content Schemas
// ============================================

/**
 * Lesson content schema
 */
export const lessonContentSchema = z.object({
  body: z.string().optional(),
  content: z.string().optional(),
  sections: z.array(z.object({
    title: z.string().optional(),
    content: z.string(),
  })).optional(),
  key_takeaways: z.array(z.string()).optional(),
  quick_checks: z.array(z.object({
    question: z.string(),
    answer: z.string(),
  })).optional(),
}).refine(
  (data) => data.body || data.content || (data.sections && data.sections.length > 0),
  { message: "Lesson must have body, content, or sections" }
);

export type LessonContent = z.infer<typeof lessonContentSchema>;

// ============================================
// Master Validation Functions
// ============================================

/**
 * Map of interactive types to their content schemas
 */
export const interactiveContentSchemas: Record<string, z.ZodSchema> = {
  'drag-drop-match': dragDropMatchContentSchema,
  'journal-entry-builder': journalEntryBuilderContentSchema,
  'equation-analyzer': equationAnalyzerContentSchema,
  'review-calculator': reviewCalculatorContentSchema,
  'mock-exam': mockExamContentSchema,
  'trial-balance-builder': trialBalanceBuilderContentSchema,
  'pattern-game': patternGameContentSchema,
  'filter-essential': filterEssentialContentSchema,
  'timed-classification': timedClassificationContentSchema,
  'cfs-classifier': cfsClassifierContentSchema,
  'inventory-calculator': inventoryCalculatorContentSchema,
};

/**
 * Validate activity content based on type and interactive_type
 */
export function validateActivityContent(
  activityType: string,
  interactiveType: string | null,
  content: unknown
): { valid: boolean; errors?: z.ZodIssue[] } {
  try {
    if (activityType === 'lesson') {
      const result = lessonContentSchema.safeParse(content);
      return result.success ? { valid: true } : { valid: false, errors: result.error.issues };
    }
    
    if (activityType === 'quiz') {
      const result = quizContentSchema.safeParse(content);
      return result.success ? { valid: true } : { valid: false, errors: result.error.issues };
    }
    
    if (activityType === 'checkpoint') {
      const result = checkpointContentSchema.safeParse(content);
      return result.success ? { valid: true } : { valid: false, errors: result.error.issues };
    }
    
    if (activityType === 'interactive' && interactiveType) {
      const schema = interactiveContentSchemas[interactiveType];
      if (schema) {
        const result = schema.safeParse(content);
        return result.success ? { valid: true } : { valid: false, errors: result.error.issues };
      }
      // No schema for this interactive type - consider valid
      return { valid: true };
    }
    
    // Unknown activity type - consider valid
    return { valid: true };
  } catch (error) {
    console.error("Content validation error:", error);
    return { valid: false, errors: [{ code: "custom", message: "Validation failed", path: [] }] };
  }
}

/**
 * Get human-readable validation error messages
 */
export function formatContentValidationErrors(errors: z.ZodIssue[]): string[] {
  return errors.map(error => {
    const path = error.path.length > 0 ? `${error.path.join('.')}: ` : '';
    return `${path}${error.message}`;
  });
}

/**
 * Check if content matches expected schema and suggest fixes
 */
export function diagnoseContentIssues(
  interactiveType: string,
  content: Record<string, unknown> | null
): {
  issues: string[];
  suggestions: string[];
  hasQuizFormat: boolean;
  hasExpectedFormat: boolean;
} {
  const issues: string[] = [];
  const suggestions: string[] = [];
  
  if (!content) {
    return {
      issues: ["No content provided"],
      suggestions: ["Add content object with required fields"],
      hasQuizFormat: false,
      hasExpectedFormat: false,
    };
  }
  
  // Check if content has quiz-style format (common mismatch)
  const hasQuizFormat = Array.isArray(content.questions) && 
    content.questions.length > 0 &&
    typeof content.questions[0] === 'object' &&
    'question' in content.questions[0];
  
  // Check expected format based on interactive type
  const schema = interactiveContentSchemas[interactiveType];
  let hasExpectedFormat = false;
  
  if (schema) {
    const result = schema.safeParse(content);
    hasExpectedFormat = result.success;
    
    if (!result.success) {
      issues.push(...formatContentValidationErrors(result.error.issues));
    }
  }
  
  // Specific suggestions based on interactive type
  if (interactiveType === 'equation-analyzer' && hasQuizFormat && !hasExpectedFormat) {
    issues.push("Content has quiz format but equation-analyzer expects 'scenarios' array");
    suggestions.push("Convert 'questions' to 'scenarios' with { description, effects: { assets, liabilities, equity }, explanation }");
  }
  
  if (interactiveType === 'journal-entry-builder' && hasQuizFormat && !hasExpectedFormat) {
    issues.push("Content has quiz format but journal-entry-builder expects 'transactions' and 'account_options'");
    suggestions.push("Add 'account_options' array with account names");
    suggestions.push("Convert 'questions' to 'transactions' with { description, solution: [{ account, debit, credit }] }");
  }
  
  if (interactiveType === 'review-calculator' && hasQuizFormat) {
    // review-calculator can accept quiz format
    hasExpectedFormat = true;
    issues.length = 0;
  }
  
  return {
    issues,
    suggestions,
    hasQuizFormat,
    hasExpectedFormat,
  };
}


