/**
 * Google Sheets API Client
 * 
 * This module provides a comprehensive integration with Google Sheets API
 * for the Financial Analysis course exercises. It handles:
 * - Creating user-specific copies of template sheets
 * - Reading cell values for auto-grading
 * - Managing sheet permissions
 */

import { google, sheets_v4, drive_v3 } from 'googleapis';

// Types for our Google Sheets integration
export interface SheetCellValue {
  cell: string;
  value: string | number | boolean | null;
  formattedValue: string;
  formula?: string;
}

export interface SheetGradingResult {
  cell: string;
  cellName: string;
  userValue: string | number | null;
  expectedValue: string | number;
  isCorrect: boolean;
  points: number;
  earnedPoints: number;
  hint?: string;
}

export interface SheetExerciseResult {
  sheetId: string;
  totalPoints: number;
  earnedPoints: number;
  scorePercent: number;
  passed: boolean;
  results: SheetGradingResult[];
  gradedAt: string;
}

export interface CopySheetResult {
  sheetId: string;
  sheetUrl: string;
  title: string;
}

export interface GradingCriteria {
  cellReference: string;
  cellName: string;
  expectedValue: string | number;
  expectedType: 'number' | 'text' | 'formula' | 'boolean';
  tolerance: number;
  isRequired: boolean;
  points: number;
  hintOnError?: string;
}

/**
 * Google Sheets Service Class
 * Handles all interactions with the Google Sheets API
 */
export class GoogleSheetsService {
  private sheets: sheets_v4.Sheets;
  private drive: drive_v3.Drive;
  private folderId: string | undefined;

  constructor() {
    const email = process.env.GOOGLE_SERVICE_ACCOUNT_EMAIL;
    const privateKey = process.env.GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY;
    this.folderId = process.env.GOOGLE_SHEETS_FOLDER_ID;

    if (!email || !privateKey) {
      throw new Error('Google Sheets credentials not configured. Set GOOGLE_SERVICE_ACCOUNT_EMAIL and GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY.');
    }

    // Parse the private key (handle escaped newlines from env vars)
    const parsedKey = privateKey.replace(/\\n/g, '\n');

    // Create JWT auth client
    const auth = new google.auth.JWT({
      email,
      key: parsedKey,
      scopes: [
        'https://www.googleapis.com/auth/spreadsheets',
        'https://www.googleapis.com/auth/drive',
      ],
    });

    this.sheets = google.sheets({ version: 'v4', auth });
    this.drive = google.drive({ version: 'v3', auth });
  }

  /**
   * Create a copy of a template sheet for a specific user
   * Creates a new spreadsheet directly in the target folder using Drive API
   */
  async copyTemplateForUser(
    templateSheetId: string,
    userEmail: string,
    sheetTitle: string
  ): Promise<CopySheetResult> {
    try {
      console.log('[GoogleSheets] Creating sheet for user:', {
        templateSheetId,
        sheetTitle,
        targetFolderId: this.folderId || 'NOT SET',
        userEmail
      });

      if (!this.folderId) {
        throw new Error('GOOGLE_SHEETS_FOLDER_ID not configured. Please set this in your .env.local');
      }

      // Step 1: Create a new Google Sheets file directly in the target folder using Drive API
      // This creates the file as owned by the folder owner, not the service account
      const createResponse = await this.drive.files.create({
        supportsAllDrives: true,
        requestBody: {
          name: sheetTitle,
          mimeType: 'application/vnd.google-apps.spreadsheet',
          parents: [this.folderId],
        },
      });

      const newSheetId = createResponse.data.id;
      if (!newSheetId) {
        throw new Error('Failed to create sheet - no ID returned');
      }

      console.log('[GoogleSheets] Created new sheet in folder:', newSheetId);

      // Step 2: Get the template sheet structure and data
      const templateInfo = await this.sheets.spreadsheets.get({
        spreadsheetId: templateSheetId,
        includeGridData: false,
      });

      const templateSheets = templateInfo.data.sheets || [];

      // Step 3: Get the default sheet ID in the new spreadsheet
      const newSheetInfo = await this.sheets.spreadsheets.get({
        spreadsheetId: newSheetId,
      });

      const defaultSheetId = newSheetInfo.data.sheets?.[0]?.properties?.sheetId;

      // Step 4: Create additional sheets to match template structure and copy data
      const requests: sheets_v4.Schema$Request[] = [];

      // Rename the default sheet if needed
      if (templateSheets[0]?.properties?.title && defaultSheetId !== undefined) {
        requests.push({
          updateSheetProperties: {
            properties: {
              sheetId: defaultSheetId,
              title: templateSheets[0].properties.title,
            },
            fields: 'title',
          },
        });
      }

      // Add additional sheets
      for (let i = 1; i < templateSheets.length; i++) {
        const sheet = templateSheets[i];
        if (sheet.properties?.title) {
          requests.push({
            addSheet: {
              properties: {
                title: sheet.properties.title,
                gridProperties: sheet.properties.gridProperties,
              },
            },
          });
        }
      }

      if (requests.length > 0) {
        await this.sheets.spreadsheets.batchUpdate({
          spreadsheetId: newSheetId,
          requestBody: { requests },
        });
      }

      // Step 5: Copy data from each tab of the template
      for (const sheet of templateSheets) {
        const sheetName = sheet.properties?.title;
        if (!sheetName) continue;

        try {
          const dataResponse = await this.sheets.spreadsheets.values.get({
            spreadsheetId: templateSheetId,
            range: `'${sheetName}'`,
            valueRenderOption: 'UNFORMATTED_VALUE',
          });

          const values = dataResponse.data.values;
          if (values && values.length > 0) {
            await this.sheets.spreadsheets.values.update({
              spreadsheetId: newSheetId,
              range: `'${sheetName}'!A1`,
              valueInputOption: 'RAW',
              requestBody: { values },
            });
          }
        } catch (copyErr) {
          console.warn(`[GoogleSheets] Could not copy data for sheet "${sheetName}":`, copyErr);
        }
      }

      // Step 6: Share the sheet with the user (writer access)
      await this.drive.permissions.create({
        fileId: newSheetId,
        supportsAllDrives: true,
        requestBody: {
          type: 'user',
          role: 'writer',
          emailAddress: userEmail,
        },
        sendNotificationEmail: false,
      });

      // Also make it viewable by anyone with the link (for embedding)
      await this.drive.permissions.create({
        fileId: newSheetId,
        supportsAllDrives: true,
        requestBody: {
          type: 'anyone',
          role: 'reader',
        },
      });

      const sheetUrl = `https://docs.google.com/spreadsheets/d/${newSheetId}/edit`;

      console.log('[GoogleSheets] Sheet ready:', sheetUrl);

      return {
        sheetId: newSheetId,
        sheetUrl,
        title: sheetTitle,
      };
    } catch (error) {
      console.error('Error creating user sheet:', error);
      throw new Error(`Failed to create sheet copy: ${error instanceof Error ? error.message : 'Unknown error'}`);
    }
  }

  /**
   * Read values from specific cells in a spreadsheet
   */
  async readCellValues(
    spreadsheetId: string,
    ranges: string[]
  ): Promise<SheetCellValue[]> {
    try {
      const response = await this.sheets.spreadsheets.values.batchGet({
        spreadsheetId,
        ranges,
        valueRenderOption: 'UNFORMATTED_VALUE',
        dateTimeRenderOption: 'FORMATTED_STRING',
      });

      // Also get formatted values for display
      const formattedResponse = await this.sheets.spreadsheets.values.batchGet({
        spreadsheetId,
        ranges,
        valueRenderOption: 'FORMATTED_VALUE',
      });

      const results: SheetCellValue[] = [];

      response.data.valueRanges?.forEach((valueRange, index) => {
        const range = valueRange.range || ranges[index];
        const value = valueRange.values?.[0]?.[0] ?? null;
        const formattedValue = formattedResponse.data.valueRanges?.[index]?.values?.[0]?.[0] ?? '';

        results.push({
          cell: range,
          value,
          formattedValue: String(formattedValue),
        });
      });

      return results;
    } catch (error) {
      console.error('Error reading cell values:', error);
      throw new Error(`Failed to read sheet values: ${error instanceof Error ? error.message : 'Unknown error'}`);
    }
  }

  /**
   * Read a single cell value
   */
  async readCell(spreadsheetId: string, cellReference: string): Promise<SheetCellValue> {
    const results = await this.readCellValues(spreadsheetId, [cellReference]);
    return results[0] || { cell: cellReference, value: null, formattedValue: '' };
  }

  /**
   * Grade a sheet exercise by checking cell values against expected values
   */
  async gradeSheetExercise(
    spreadsheetId: string,
    criteria: GradingCriteria[],
    passingScore: number = 80
  ): Promise<SheetExerciseResult> {
    // Get all cell references to check
    const cellRefs = criteria.map(c => c.cellReference);
    const cellValues = await this.readCellValues(spreadsheetId, cellRefs);

    // Create a map for easy lookup
    const valueMap = new Map<string, SheetCellValue>();
    cellValues.forEach(cv => {
      // Normalize the cell reference (remove sheet name for matching)
      const normalizedRef = cv.cell.split('!').pop() || cv.cell;
      valueMap.set(normalizedRef, cv);
      valueMap.set(cv.cell, cv); // Also store with full reference
    });

    const results: SheetGradingResult[] = [];
    let totalPoints = 0;
    let earnedPoints = 0;

    for (const crit of criteria) {
      const normalizedRef = crit.cellReference.split('!').pop() || crit.cellReference;
      const cellValue = valueMap.get(crit.cellReference) || valueMap.get(normalizedRef);
      const userValue = cellValue?.value ?? null;

      const isCorrect = this.checkValueMatch(
        userValue,
        crit.expectedValue,
        crit.expectedType,
        crit.tolerance
      );

      const points = crit.points;
      const earned = isCorrect ? points : 0;

      totalPoints += points;
      earnedPoints += earned;

      results.push({
        cell: crit.cellReference,
        cellName: crit.cellName,
        userValue,
        expectedValue: crit.expectedValue,
        isCorrect,
        points,
        earnedPoints: earned,
        hint: !isCorrect ? crit.hintOnError : undefined,
      });
    }

    const scorePercent = totalPoints > 0 ? Math.round((earnedPoints / totalPoints) * 100) : 100;

    return {
      sheetId: spreadsheetId,
      totalPoints,
      earnedPoints,
      scorePercent,
      passed: scorePercent >= passingScore,
      results,
      gradedAt: new Date().toISOString(),
    };
  }

  /**
   * Check if a user value matches the expected value
   */
  private checkValueMatch(
    userValue: string | number | boolean | null,
    expectedValue: string | number,
    expectedType: string,
    tolerance: number
  ): boolean {
    if (userValue === null || userValue === undefined || userValue === '') {
      return false;
    }

    switch (expectedType) {
      case 'number': {
        const userNum = typeof userValue === 'number' ? userValue : parseFloat(String(userValue));
        const expectedNum = typeof expectedValue === 'number' ? expectedValue : parseFloat(String(expectedValue));
        
        if (isNaN(userNum) || isNaN(expectedNum)) {
          return false;
        }

        // Check with tolerance (as a percentage)
        if (tolerance > 0) {
          const diff = Math.abs(userNum - expectedNum);
          const maxDiff = Math.abs(expectedNum) * tolerance;
          return diff <= maxDiff;
        }

        // Exact match (with small floating point tolerance)
        return Math.abs(userNum - expectedNum) < 0.001;
      }

      case 'text':
        return String(userValue).toLowerCase().trim() === String(expectedValue).toLowerCase().trim();

      case 'boolean':
        return Boolean(userValue) === (expectedValue === 'true' || expectedValue === true);

      case 'formula':
        // For formulas, we check the result matches
        return String(userValue) === String(expectedValue);

      default:
        return String(userValue) === String(expectedValue);
    }
  }

  /**
   * Delete a user's sheet (for cleanup)
   */
  async deleteSheet(spreadsheetId: string): Promise<void> {
    try {
      await this.drive.files.delete({
        fileId: spreadsheetId,
      });
    } catch (error) {
      console.error('Error deleting sheet:', error);
      // Don't throw - deletion failures shouldn't break the flow
    }
  }

  /**
   * Get the embed URL for a sheet (for iframe embedding)
   */
  getEmbedUrl(spreadsheetId: string, gid: string = '0'): string {
    return `https://docs.google.com/spreadsheets/d/${spreadsheetId}/edit?gid=${gid}&widget=true&embedded=true`;
  }

  /**
   * Get the interactive edit URL for a sheet
   */
  getEditUrl(spreadsheetId: string): string {
    return `https://docs.google.com/spreadsheets/d/${spreadsheetId}/edit`;
  }

  /**
   * Check if a sheet exists and is accessible
   */
  async sheetExists(spreadsheetId: string): Promise<boolean> {
    try {
      await this.sheets.spreadsheets.get({
        spreadsheetId,
        fields: 'spreadsheetId',
      });
      return true;
    } catch {
      return false;
    }
  }

  /**
   * Get sheet metadata (title, tabs, etc.)
   */
  async getSheetMetadata(spreadsheetId: string): Promise<{
    title: string;
    sheets: { title: string; sheetId: number }[];
  }> {
    const response = await this.sheets.spreadsheets.get({
      spreadsheetId,
      fields: 'properties.title,sheets.properties.title,sheets.properties.sheetId',
    });

    return {
      title: response.data.properties?.title || 'Untitled',
      sheets: response.data.sheets?.map(s => ({
        title: s.properties?.title || 'Sheet',
        sheetId: s.properties?.sheetId || 0,
      })) || [],
    };
  }
}

// Singleton instance
let sheetsServiceInstance: GoogleSheetsService | null = null;

/**
 * Get the Google Sheets service instance
 * Returns null if credentials are not configured
 */
export function getGoogleSheetsService(): GoogleSheetsService | null {
  if (!process.env.GOOGLE_SERVICE_ACCOUNT_EMAIL || !process.env.GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY) {
    return null;
  }

  if (!sheetsServiceInstance) {
    sheetsServiceInstance = new GoogleSheetsService();
  }

  return sheetsServiceInstance;
}

/**
 * Check if Google Sheets integration is configured
 */
export function isGoogleSheetsConfigured(): boolean {
  return !!(
    process.env.GOOGLE_SERVICE_ACCOUNT_EMAIL &&
    process.env.GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY
  );
}

