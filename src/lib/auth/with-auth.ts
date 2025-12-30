/**
 * Authentication wrapper for server actions
 * 
 * This higher-order function eliminates repetitive auth boilerplate
 * from server actions, ensuring consistent authentication handling.
 */

import { createClient } from "@/utils/supabase/server";
import { User, SupabaseClient } from "@supabase/supabase-js";
import { UnauthorizedError, ForbiddenError } from "@/lib/errors";
import { Result, ok, err } from "@/lib/types/result";

/**
 * Context provided to authenticated functions
 */
export interface AuthContext {
  user: User;
  supabase: SupabaseClient;
  isAdmin: boolean;
}

/**
 * Profile with role information
 */
interface ProfileWithRole {
  role: "user" | "admin";
}

/**
 * Wrap a server action with authentication
 * Automatically handles auth check and provides user context
 * 
 * @example
 * export const myAction = withAuth(async ({ user, supabase }, arg1: string) => {
 *   // user is guaranteed to be authenticated here
 *   return { success: true };
 * });
 */
export function withAuth<TArgs extends unknown[], TReturn>(
  fn: (ctx: AuthContext, ...args: TArgs) => Promise<TReturn>
): (...args: TArgs) => Promise<TReturn> {
  return async (...args: TArgs): Promise<TReturn> => {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    
    if (!user) {
      throw new UnauthorizedError();
    }
    
    // Check if user is admin
    const { data: profile } = await supabase
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();
    
    const isAdmin = (profile as ProfileWithRole | null)?.role === "admin";
    
    return fn({ user, supabase: supabase as SupabaseClient, isAdmin }, ...args);
  };
}

/**
 * Wrap a server action with admin-only authentication
 * Automatically handles auth check and admin role verification
 * 
 * @example
 * export const adminOnlyAction = withAdmin(async ({ user, supabase }, arg1: string) => {
 *   // user is guaranteed to be an admin here
 *   return { success: true };
 * });
 */
export function withAdmin<TArgs extends unknown[], TReturn>(
  fn: (ctx: AuthContext, ...args: TArgs) => Promise<TReturn>
): (...args: TArgs) => Promise<TReturn> {
  return async (...args: TArgs): Promise<TReturn> => {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    
    if (!user) {
      throw new UnauthorizedError();
    }
    
    // Check if user is admin
    const { data: profile } = await supabase
      .from("profiles")
      .select("role")
      .eq("id", user.id)
      .single();
    
    const isAdmin = (profile as ProfileWithRole | null)?.role === "admin";
    
    if (!isAdmin) {
      throw new ForbiddenError("Admin access required");
    }
    
    return fn({ user, supabase: supabase as SupabaseClient, isAdmin: true }, ...args);
  };
}

/**
 * Wrap a server action with optional authentication
 * Provides user context if authenticated, null otherwise
 * 
 * @example
 * export const optionalAuthAction = withOptionalAuth(async ({ user, supabase }, arg1: string) => {
 *   if (user) {
 *     // User is authenticated
 *   } else {
 *     // Anonymous access
 *   }
 *   return { success: true };
 * });
 */
export interface OptionalAuthContext {
  user: User | null;
  supabase: SupabaseClient;
  isAdmin: boolean;
}

export function withOptionalAuth<TArgs extends unknown[], TReturn>(
  fn: (ctx: OptionalAuthContext, ...args: TArgs) => Promise<TReturn>
): (...args: TArgs) => Promise<TReturn> {
  return async (...args: TArgs): Promise<TReturn> => {
    const supabase = await createClient();
    const { data: { user } } = await supabase.auth.getUser();
    
    let isAdmin = false;
    if (user) {
      const { data: profile } = await supabase
        .from("profiles")
        .select("role")
        .eq("id", user.id)
        .single();
      
      isAdmin = (profile as ProfileWithRole | null)?.role === "admin";
    }
    
    return fn({ user, supabase: supabase as SupabaseClient, isAdmin }, ...args);
  };
}

/**
 * Version that returns Result type instead of throwing
 * Useful for actions that need to handle auth errors gracefully
 */
export function withAuthResult<TArgs extends unknown[], TReturn>(
  fn: (ctx: AuthContext, ...args: TArgs) => Promise<TReturn>
): (...args: TArgs) => Promise<Result<TReturn, Error>> {
  return async (...args: TArgs): Promise<Result<TReturn, Error>> => {
    try {
      const supabase = await createClient();
      const { data: { user } } = await supabase.auth.getUser();
      
      if (!user) {
        return err(new UnauthorizedError(), "UNAUTHORIZED");
      }
      
      // Check if user is admin
      const { data: profile } = await supabase
        .from("profiles")
        .select("role")
        .eq("id", user.id)
        .single();
      
      const isAdmin = (profile as ProfileWithRole | null)?.role === "admin";
      
      const result = await fn({ user, supabase: supabase as SupabaseClient, isAdmin }, ...args);
      return ok(result);
    } catch (error) {
      return err(error instanceof Error ? error : new Error(String(error)));
    }
  };
}

/**
 * Get current auth context without wrapping a function
 * Useful for one-off checks in complex functions
 */
export async function getAuthContext(): Promise<AuthContext | null> {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    return null;
  }
  
  const { data: profile } = await supabase
    .from("profiles")
    .select("role")
    .eq("id", user.id)
    .single();
  
  const isAdmin = (profile as ProfileWithRole | null)?.role === "admin";
  
  return { user, supabase: supabase as SupabaseClient, isAdmin };
}

/**
 * Require auth context or throw
 */
export async function requireAuthContext(): Promise<AuthContext> {
  const ctx = await getAuthContext();
  if (!ctx) {
    throw new UnauthorizedError();
  }
  return ctx;
}

/**
 * Require admin context or throw
 */
export async function requireAdminContext(): Promise<AuthContext> {
  const ctx = await getAuthContext();
  if (!ctx) {
    throw new UnauthorizedError();
  }
  if (!ctx.isAdmin) {
    throw new ForbiddenError("Admin access required");
  }
  return ctx;
}

