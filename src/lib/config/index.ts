/**
 * Configuration Module
 * 
 * Central export point for all application configuration.
 */

export * from "./gamification";
export * from "./rate-limits";

/**
 * Application-wide configuration
 */
export const APP_CONFIG = {
  /** Application name */
  name: "Tutorio",
  
  /** Default page title suffix */
  titleSuffix: " | Tutorio",
  
  /** Support email */
  supportEmail: "support@tutorio.com",
  
  /** Maximum file upload size (bytes) */
  maxUploadSize: 10 * 1024 * 1024, // 10MB
  
  /** Session timeout (minutes) */
  sessionTimeout: 60,
  
  /** Pagination defaults */
  pagination: {
    defaultPageSize: 20,
    maxPageSize: 100,
  },
} as const;

/**
 * Feature flags
 * Toggle features on/off for gradual rollout
 */
export const FEATURE_FLAGS = {
  /** Enable AI chatbot */
  aiChatEnabled: true,
  
  /** Enable Google Sheets integration */
  googleSheetsEnabled: true,
  
  /** Enable Stripe payments */
  paymentsEnabled: true,
  
  /** Enable skill prerequisites enforcement */
  enforcePrerequisites: false,
  
  /** Enable streak freeze feature */
  streakFreezeEnabled: true,
  
  /** Enable dark mode */
  darkModeEnabled: true,
  
  /** Enable beta features for testing */
  betaFeaturesEnabled: false,
} as const;

/**
 * External service configuration
 */
export const EXTERNAL_SERVICES = {
  stripe: {
    apiVersion: "2025-12-15.clover",
    trialDays: 7,
    allowPromotionCodes: true,
  },
  openai: {
    defaultModel: "gpt-4o-mini",
    maxTokens: 1000,
    temperature: 0.7,
  },
  googleSheets: {
    defaultSheetName: "Sheet1",
    maxCellsToGrade: 100,
  },
} as const;

/**
 * Cache configuration
 */
export const CACHE_CONFIG = {
  /** Revalidation intervals (seconds) */
  revalidate: {
    course: 3600,      // 1 hour
    skills: 300,       // 5 minutes
    progress: 60,      // 1 minute
    leaderboard: 300,  // 5 minutes
  },
  
  /** Cache tags for targeted invalidation */
  tags: {
    courses: "courses",
    skills: "skills",
    progress: "progress",
    user: "user",
  },
} as const;

