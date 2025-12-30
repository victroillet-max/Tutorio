/**
 * Standardized Result type for consistent error handling
 * across all server actions and services.
 * 
 * This pattern provides:
 * - Type-safe error handling
 * - Consistent API responses
 * - Better error tracking and debugging
 */

/**
 * Success result with data
 */
export interface SuccessResult<T> {
  success: true;
  data: T;
}

/**
 * Error result with error details
 */
export interface ErrorResult<E = Error> {
  success: false;
  error: E;
  code?: string;
  message?: string;
}

/**
 * Union type representing either success or failure
 */
export type Result<T, E = Error> = SuccessResult<T> | ErrorResult<E>;

/**
 * Async result type for promises
 */
export type AsyncResult<T, E = Error> = Promise<Result<T, E>>;

/**
 * Helper to create a success result
 */
export function ok<T>(data: T): SuccessResult<T> {
  return { success: true, data };
}

/**
 * Helper to create an error result
 */
export function err<E = Error>(error: E, code?: string, message?: string): ErrorResult<E> {
  return { 
    success: false, 
    error,
    code,
    message: message || (error instanceof Error ? error.message : String(error)),
  };
}

/**
 * Type guard to check if result is successful
 */
export function isOk<T, E>(result: Result<T, E>): result is SuccessResult<T> {
  return result.success === true;
}

/**
 * Type guard to check if result is an error
 */
export function isErr<T, E>(result: Result<T, E>): result is ErrorResult<E> {
  return result.success === false;
}

/**
 * Unwrap a result, throwing if it's an error
 */
export function unwrap<T, E>(result: Result<T, E>): T {
  if (isOk(result)) {
    return result.data;
  }
  throw result.error;
}

/**
 * Unwrap a result with a default value for errors
 */
export function unwrapOr<T, E>(result: Result<T, E>, defaultValue: T): T {
  if (isOk(result)) {
    return result.data;
  }
  return defaultValue;
}

/**
 * Map over a successful result
 */
export function map<T, U, E>(result: Result<T, E>, fn: (data: T) => U): Result<U, E> {
  if (isOk(result)) {
    return ok(fn(result.data));
  }
  return result;
}

/**
 * FlatMap over a successful result
 */
export function flatMap<T, U, E>(result: Result<T, E>, fn: (data: T) => Result<U, E>): Result<U, E> {
  if (isOk(result)) {
    return fn(result.data);
  }
  return result;
}

/**
 * Try to execute a function and wrap the result
 */
export async function tryCatch<T>(fn: () => Promise<T>): AsyncResult<T> {
  try {
    const data = await fn();
    return ok(data);
  } catch (error) {
    return err(error instanceof Error ? error : new Error(String(error)));
  }
}

/**
 * Combine multiple results into a single result
 * Returns the first error encountered, or all successful values
 */
export function combine<T extends readonly Result<unknown, unknown>[]>(
  results: T
): Result<{ [K in keyof T]: T[K] extends Result<infer U, unknown> ? U : never }, Error> {
  const values: unknown[] = [];
  
  for (const result of results) {
    if (isErr(result)) {
      return result as ErrorResult<Error>;
    }
    values.push(result.data);
  }
  
  return ok(values as { [K in keyof T]: T[K] extends Result<infer U, unknown> ? U : never });
}

