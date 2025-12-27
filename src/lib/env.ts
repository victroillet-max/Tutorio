import { z } from "zod";

/**
 * Environment variable validation schema
 * This ensures all required environment variables are present at runtime
 */
const envSchema = z.object({
  // Supabase (public - exposed to client)
  NEXT_PUBLIC_SUPABASE_URL: z.string().url("NEXT_PUBLIC_SUPABASE_URL must be a valid URL"),
  NEXT_PUBLIC_SUPABASE_ANON_KEY: z.string().min(1, "NEXT_PUBLIC_SUPABASE_ANON_KEY is required"),
  
  // Site URL (public - for auth redirects)
  NEXT_PUBLIC_SITE_URL: z.string().url("NEXT_PUBLIC_SITE_URL must be a valid URL").optional(),
  
  // Supabase Service Role (server-only - never expose to client)
  SUPABASE_SERVICE_ROLE_KEY: z.string().min(1).optional(),
  
  // OpenAI API Key (server-only - for AI code validation and chat)
  OPENAI_API_KEY: z.string().min(1).optional(),
  
  // OpenAI Model (server-only - defaults to gpt-4o-mini)
  OPENAI_MODEL: z.string().default("gpt-4o-mini").optional(),
  
  // Stripe (server-only - for payment processing)
  STRIPE_SECRET_KEY: z.string().min(1).optional(),
  STRIPE_WEBHOOK_SECRET: z.string().min(1).optional(),
  STRIPE_BASIC_PRICE_ID: z.string().min(1).optional(),
  STRIPE_ADVANCED_PRICE_ID: z.string().min(1).optional(),
});

/**
 * Client-safe environment variables (only NEXT_PUBLIC_ prefixed)
 */
const clientEnvSchema = z.object({
  NEXT_PUBLIC_SUPABASE_URL: z.string().url(),
  NEXT_PUBLIC_SUPABASE_ANON_KEY: z.string().min(1),
  NEXT_PUBLIC_SITE_URL: z.string().url().optional(),
});

export type Env = z.infer<typeof envSchema>;
export type ClientEnv = z.infer<typeof clientEnvSchema>;

/**
 * Validates and returns server-side environment variables
 * Call this in server components or API routes
 */
export function getServerEnv(): Env {
  const parsed = envSchema.safeParse(process.env);
  
  if (!parsed.success) {
    console.error("❌ Invalid environment variables:", parsed.error.flatten().fieldErrors);
    throw new Error("Invalid environment variables. Check server logs for details.");
  }
  
  return parsed.data;
}

/**
 * Validates and returns client-safe environment variables
 * Safe to use in client components
 */
export function getClientEnv(): ClientEnv {
  const parsed = clientEnvSchema.safeParse({
    NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL,
    NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    NEXT_PUBLIC_SITE_URL: process.env.NEXT_PUBLIC_SITE_URL,
  });
  
  if (!parsed.success) {
    console.error("❌ Invalid client environment variables:", parsed.error.flatten().fieldErrors);
    throw new Error("Invalid client environment variables.");
  }
  
  return parsed.data;
}

/**
 * Get the site URL for redirects
 * Falls back to localhost in development
 */
export function getSiteUrl(): string {
  const siteUrl = process.env.NEXT_PUBLIC_SITE_URL;
  if (siteUrl) return siteUrl;
  
  // Fallback for development
  if (process.env.NODE_ENV === "development") {
    return "http://localhost:3000";
  }
  
  // Vercel deployment
  if (process.env.VERCEL_URL) {
    return `https://${process.env.VERCEL_URL}`;
  }
  
  return "http://localhost:3000";
}

