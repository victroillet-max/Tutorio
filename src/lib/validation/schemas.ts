/**
 * Zod Validation Schemas
 * 
 * Centralized validation schemas for API routes and server actions.
 * Ensures consistent input validation across the application.
 */

import { z } from "zod";

// ============================================
// Primitive Validators
// ============================================

/**
 * UUID validator
 * Uses regex pattern to accept UUID-like format (including non-RFC4122 compliant UUIDs)
 * This is more permissive than z.string().uuid() which requires strict RFC 4122 compliance
 */
export const uuidSchema = z.string().regex(
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i,
  "Invalid UUID format"
);

/**
 * Non-empty string validator
 */
export const nonEmptyString = z.string().min(1, "This field is required");

/**
 * Email validator
 */
export const emailSchema = z.string().email("Invalid email address");

/**
 * Pagination validator
 */
export const paginationSchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  limit: z.coerce.number().int().min(1).max(100).default(20),
});

// ============================================
// Chat API Schemas
// ============================================

/**
 * Optional UUID that also accepts empty strings (converts to undefined)
 */
const optionalUuid = z.preprocess(
  (val) => (val === "" || val === null ? undefined : val),
  uuidSchema.optional()
);

/**
 * Optional string that also accepts empty strings (converts to undefined)
 */
const optionalString = (maxLen: number) => z.preprocess(
  (val) => (val === "" || val === null ? undefined : val),
  z.string().max(maxLen).optional()
);

/**
 * Optional number that also accepts empty strings or string numbers (converts appropriately)
 */
const optionalNumber = z.preprocess(
  (val) => {
    if (val === "" || val === null || val === undefined) return undefined;
    if (typeof val === "string") {
      const num = parseInt(val, 10);
      return isNaN(num) ? undefined : num;
    }
    return val;
  },
  z.number().int().min(1).max(100).optional()
);

/**
 * Enhanced question context schema
 */
const currentQuestionSchema = z.object({
  number: z.number().int().min(1).max(1000),
  text: z.string().max(5000),
  type: z.string().max(50).optional(),
  options: z.array(z.string().max(1000)).max(20).optional(),
  hint: z.string().max(2000).optional(),
}).optional();

/**
 * Scenario context schema
 */
const currentScenarioSchema = z.object({
  title: z.string().max(500).optional(),
  description: z.string().max(5000),
  companyName: z.string().max(200).optional(),
}).optional();

/**
 * Reference data item schema
 */
const referenceDataItemSchema = z.object({
  title: z.string().max(200),
  content: z.string().max(10000),
});

/**
 * Chat message request schema
 */
export const chatMessageSchema = z.object({
  message: z
    .string()
    .min(1, "Message is required")
    .max(10000, "Message is too long (max 10,000 characters)"),
  conversationId: optionalUuid,
  activityId: optionalUuid,
  skillId: optionalUuid,
  courseId: optionalUuid,
  studentCode: optionalString(50000),
  errorMessage: optionalString(5000),
  currentQuestionText: optionalString(2000),
  currentQuestionNumber: optionalNumber,
  // Enhanced context fields
  currentQuestion: currentQuestionSchema,
  currentScenario: currentScenarioSchema,
  referenceData: z.array(referenceDataItemSchema).max(20).optional(),
  activityTitle: optionalString(500),
  activityType: optionalString(100),
  activityInstructions: optionalString(5000),
});

export type ChatMessageInput = z.infer<typeof chatMessageSchema>;

// ============================================
// Stripe API Schemas
// ============================================

/**
 * Checkout request schema
 */
export const checkoutSchema = z.object({
  courseId: uuidSchema,
  tier: z.enum(["basic", "advanced"]),
  upgrade: z.boolean().optional().default(false),
});

export type CheckoutInput = z.infer<typeof checkoutSchema>;

/**
 * Change plan request schema
 */
export const changePlanSchema = z.object({
  subscriptionId: uuidSchema,
  newTier: z.enum(["basic", "advanced"]),
});

export type ChangePlanInput = z.infer<typeof changePlanSchema>;

// ============================================
// Activity Schemas
// ============================================

/**
 * Mark activity complete request
 */
export const markActivityCompleteSchema = z.object({
  activityId: uuidSchema,
  score: z.number().min(0).max(100).optional(),
});

export type MarkActivityCompleteInput = z.infer<typeof markActivityCompleteSchema>;

/**
 * Update activity progress request
 */
export const updateActivityProgressSchema = z.object({
  activityId: uuidSchema,
  lastPositionSeconds: z.number().int().min(0).optional(),
  timeSpentSeconds: z.number().int().min(0).max(86400).optional(), // Max 24 hours
});

export type UpdateActivityProgressInput = z.infer<typeof updateActivityProgressSchema>;

/**
 * Quiz answer submission
 */
export const quizAnswerSchema = z.object({
  activityId: uuidSchema,
  questionId: z.string(),
  answer: z.union([z.string(), z.number(), z.boolean()]),
});

export type QuizAnswerInput = z.infer<typeof quizAnswerSchema>;

// ============================================
// Skills Schemas
// ============================================

/**
 * Skill search schema
 */
export const skillSearchSchema = z.object({
  query: z.string().min(1).max(100),
  category: z.enum([
    "ct_foundations",
    "python_basics",
    "control_flow",
    "data_structures",
    "functions",
    "advanced_topics",
  ]).optional(),
  limit: z.coerce.number().int().min(1).max(50).default(20),
});

export type SkillSearchInput = z.infer<typeof skillSearchSchema>;

/**
 * Update skill progress schema
 */
export const updateSkillProgressSchema = z.object({
  skillId: uuidSchema,
  isCorrect: z.boolean(),
});

export type UpdateSkillProgressInput = z.infer<typeof updateSkillProgressSchema>;

// ============================================
// Google Sheets Schemas
// ============================================

/**
 * Create user sheet request
 */
export const createUserSheetSchema = z.object({
  activityId: uuidSchema,
  templateSheetId: z.string().min(1, "Template sheet ID is required"),
  exerciseTitle: z.string().min(1).max(200),
});

export type CreateUserSheetInput = z.infer<typeof createUserSheetSchema>;

/**
 * Grade sheet request
 */
export const gradeSheetSchema = z.object({
  activityId: uuidSchema,
});

export type GradeSheetInput = z.infer<typeof gradeSheetSchema>;

// ============================================
// Auth Schemas
// ============================================

/**
 * Sign up schema
 */
export const signUpSchema = z.object({
  email: emailSchema,
  password: z.string().min(8, "Password must be at least 8 characters"),
  fullName: z.string().max(100).optional(),
});

export type SignUpInput = z.infer<typeof signUpSchema>;

/**
 * Sign in schema
 */
export const signInSchema = z.object({
  email: emailSchema,
  password: z.string().min(1, "Password is required"),
});

export type SignInInput = z.infer<typeof signInSchema>;

/**
 * Password reset schema
 */
export const resetPasswordSchema = z.object({
  password: z.string().min(8, "Password must be at least 8 characters"),
  confirmPassword: z.string(),
}).refine((data) => data.password === data.confirmPassword, {
  message: "Passwords do not match",
  path: ["confirmPassword"],
});

export type ResetPasswordInput = z.infer<typeof resetPasswordSchema>;

// ============================================
// Admin Schemas
// ============================================

/**
 * Update user role schema
 */
export const updateUserRoleSchema = z.object({
  userId: uuidSchema,
  role: z.enum(["user", "admin"]),
});

export type UpdateUserRoleInput = z.infer<typeof updateUserRoleSchema>;

/**
 * User list query schema
 */
export const userListQuerySchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  limit: z.coerce.number().int().min(1).max(100).default(20),
  search: z.string().max(100).optional(),
  role: z.enum(["user", "admin", "all"]).default("all"),
});

export type UserListQueryInput = z.infer<typeof userListQuerySchema>;

// ============================================
// Validation Helper
// ============================================

/**
 * Validate input against a schema and return formatted result
 */
export function validateInput<T extends z.ZodSchema>(
  schema: T,
  data: unknown
): { success: true; data: z.infer<T> } | { success: false; errors: z.ZodIssue[] } {
  const result = schema.safeParse(data);
  
  if (result.success) {
    return { success: true, data: result.data };
  }
  
  return { success: false, errors: result.error.issues };
}

/**
 * Format Zod errors for API response
 */
export function formatZodErrors(errors: z.ZodIssue[]): Record<string, string[]> {
  const formatted: Record<string, string[]> = {};
  
  for (const error of errors) {
    const path = error.path.join(".");
    const key = path || "root";
    
    if (!formatted[key]) {
      formatted[key] = [];
    }
    formatted[key].push(error.message);
  }
  
  return formatted;
}

/**
 * Create a validation error response for API routes
 */
export function createValidationErrorResponse(errors: z.ZodIssue[]) {
  return new Response(
    JSON.stringify({
      error: "Validation error",
      details: formatZodErrors(errors),
    }),
    {
      status: 400,
      headers: { "Content-Type": "application/json" },
    }
  );
}

