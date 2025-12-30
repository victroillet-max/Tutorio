/**
 * Google Sheets Integration Module
 * 
 * This module provides everything needed to integrate Google Sheets
 * with the Financial Analysis course exercises.
 */

// Client-side types and utilities (can be imported in client components)
export type {
  SheetCellValue,
  SheetGradingResult,
  SheetExerciseResult,
  CopySheetResult,
  GradingCriteria,
} from './client';

// Server-side service (only import in server components/actions)
export {
  GoogleSheetsService,
  getGoogleSheetsService,
  isGoogleSheetsConfigured,
} from './client';

// Server actions (for use in client components via form actions)
export {
  getUserSheet,
  createUserSheet,
  gradeUserSheet,
  resetUserSheet,
  getActivityGradingCriteria,
  checkGoogleSheetsStatus,
  type UserSheet,
  type GetUserSheetResult,
  type CreateSheetResult,
  type GradeSheetResult,
} from './actions';

