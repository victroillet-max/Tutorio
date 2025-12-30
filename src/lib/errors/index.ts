/**
 * Centralized error types for consistent error handling
 * 
 * These error classes provide:
 * - Standardized error codes
 * - HTTP status code mapping
 * - Structured error details for debugging
 */

/**
 * Base application error class
 */
export class AppError extends Error {
  public readonly code: string;
  public readonly statusCode: number;
  public readonly details?: Record<string, unknown>;
  public readonly isOperational: boolean;

  constructor(
    message: string,
    code: string,
    statusCode: number = 500,
    details?: Record<string, unknown>,
    isOperational: boolean = true
  ) {
    super(message);
    this.name = this.constructor.name;
    this.code = code;
    this.statusCode = statusCode;
    this.details = details;
    this.isOperational = isOperational;
    
    // Maintains proper stack trace for where error was thrown
    Error.captureStackTrace(this, this.constructor);
  }

  /**
   * Convert to JSON for API responses
   */
  toJSON() {
    return {
      error: this.message,
      code: this.code,
      ...(this.details && { details: this.details }),
    };
  }
}

/**
 * Authentication errors (401)
 */
export class UnauthorizedError extends AppError {
  constructor(message: string = "Not authenticated") {
    super(message, "UNAUTHORIZED", 401);
  }
}

/**
 * Authorization errors (403)
 */
export class ForbiddenError extends AppError {
  constructor(message: string = "Access denied") {
    super(message, "FORBIDDEN", 403);
  }
}

/**
 * Not found errors (404)
 */
export class NotFoundError extends AppError {
  constructor(resource: string, identifier?: string) {
    const message = identifier 
      ? `${resource} not found: ${identifier}`
      : `${resource} not found`;
    super(message, "NOT_FOUND", 404, { resource, identifier });
  }
}

/**
 * Validation errors (400)
 */
export class ValidationError extends AppError {
  constructor(message: string, details?: Record<string, unknown>) {
    super(message, "VALIDATION_ERROR", 400, details);
  }
}

/**
 * Conflict errors (409)
 */
export class ConflictError extends AppError {
  constructor(message: string, details?: Record<string, unknown>) {
    super(message, "CONFLICT", 409, details);
  }
}

/**
 * Rate limit errors (429)
 */
export class RateLimitError extends AppError {
  public readonly retryAfter?: number;

  constructor(message: string = "Too many requests", retryAfter?: number) {
    super(message, "RATE_LIMIT_EXCEEDED", 429, { retryAfter });
    this.retryAfter = retryAfter;
  }
}

/**
 * Service unavailable errors (503)
 */
export class ServiceUnavailableError extends AppError {
  constructor(service: string, message?: string) {
    super(
      message || `${service} is temporarily unavailable`,
      "SERVICE_UNAVAILABLE",
      503,
      { service }
    );
  }
}

/**
 * External service errors (502)
 */
export class ExternalServiceError extends AppError {
  constructor(service: string, originalError?: Error) {
    super(
      `External service error: ${service}`,
      "EXTERNAL_SERVICE_ERROR",
      502,
      { 
        service, 
        originalMessage: originalError?.message 
      }
    );
  }
}

/**
 * Database errors (500)
 */
export class DatabaseError extends AppError {
  constructor(operation: string, originalError?: Error) {
    super(
      `Database error during ${operation}`,
      "DATABASE_ERROR",
      500,
      { 
        operation, 
        originalMessage: originalError?.message 
      }
    );
  }
}

/**
 * Payment errors (402)
 */
export class PaymentError extends AppError {
  constructor(message: string, details?: Record<string, unknown>) {
    super(message, "PAYMENT_ERROR", 402, details);
  }
}

/**
 * Configuration errors (500)
 */
export class ConfigurationError extends AppError {
  constructor(message: string, missingConfig?: string[]) {
    super(message, "CONFIGURATION_ERROR", 500, { missingConfig }, false);
  }
}

/**
 * Type guard to check if error is an AppError
 */
export function isAppError(error: unknown): error is AppError {
  return error instanceof AppError;
}

/**
 * Convert any error to AppError
 */
export function toAppError(error: unknown): AppError {
  if (isAppError(error)) {
    return error;
  }
  
  if (error instanceof Error) {
    return new AppError(error.message, "INTERNAL_ERROR", 500);
  }
  
  return new AppError(String(error), "INTERNAL_ERROR", 500);
}

/**
 * Error codes enum for type safety
 */
export const ErrorCodes = {
  UNAUTHORIZED: "UNAUTHORIZED",
  FORBIDDEN: "FORBIDDEN",
  NOT_FOUND: "NOT_FOUND",
  VALIDATION_ERROR: "VALIDATION_ERROR",
  CONFLICT: "CONFLICT",
  RATE_LIMIT_EXCEEDED: "RATE_LIMIT_EXCEEDED",
  SERVICE_UNAVAILABLE: "SERVICE_UNAVAILABLE",
  EXTERNAL_SERVICE_ERROR: "EXTERNAL_SERVICE_ERROR",
  DATABASE_ERROR: "DATABASE_ERROR",
  PAYMENT_ERROR: "PAYMENT_ERROR",
  CONFIGURATION_ERROR: "CONFIGURATION_ERROR",
  INTERNAL_ERROR: "INTERNAL_ERROR",
} as const;

export type ErrorCode = (typeof ErrorCodes)[keyof typeof ErrorCodes];

