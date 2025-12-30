"use client";

import { useState, useEffect, useCallback } from "react";
import {
  CheckCircle2,
  Loader2,
  ExternalLink,
  RefreshCw,
  AlertCircle,
  FileSpreadsheet,
  Target,
  RotateCcw,
  ChevronDown,
  ChevronUp,
  Info,
} from "lucide-react";
import type { Activity } from "@/lib/database.types";
import type { SheetExerciseResult, GradingCriteria } from "@/lib/google-sheets/client";

interface GoogleSheetsViewerProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
  onComplete: () => void;
}

interface UserSheetData {
  id: string;
  userSheetId: string;
  userSheetUrl: string;
  sheetTitle: string | null;
  isCompleted: boolean;
  completionData: SheetExerciseResult | null;
}

interface SheetState {
  loading: boolean;
  creating: boolean;
  grading: boolean;
  resetting: boolean;
  error: string | null;
  sheet: UserSheetData | null;
  embedUrl: string | null;
  editUrl: string | null;
  needsCreation: boolean;
  gradingResult: SheetExerciseResult | null;
  criteria: GradingCriteria[];
  totalPoints: number;
}

export function GoogleSheetsViewer({
  activity,
  userId,
  isCompleted,
  onComplete,
}: GoogleSheetsViewerProps) {
  const [state, setState] = useState<SheetState>({
    loading: true,
    creating: false,
    grading: false,
    resetting: false,
    error: null,
    sheet: null,
    embedUrl: null,
    editUrl: null,
    needsCreation: false,
    gradingResult: null,
    criteria: [],
    totalPoints: 0,
  });

  const [showCriteria, setShowCriteria] = useState(false);
  const [showResults, setShowResults] = useState(false);

  const content = activity.content as {
    template_sheet_id?: string;
    instructions?: string;
    exercise_title?: string;
    grading_cells?: { cell: string; name: string; expected: string | number }[];
    hints?: string[];
    sheet_tab?: string;
  } | null;

  const templateSheetId = content?.template_sheet_id;
  const instructions = content?.instructions || "Complete the exercise in the Google Sheet below.";
  const exerciseTitle = content?.exercise_title || activity.title;

  // Fetch user's sheet status
  const fetchSheetStatus = useCallback(async () => {
    setState(prev => ({ ...prev, loading: true, error: null }));

    try {
      const [sheetRes, criteriaRes] = await Promise.all([
        fetch(`/api/sheets?activityId=${activity.id}`),
        fetch(`/api/sheets?activityId=${activity.id}&action=criteria`),
      ]);

      const sheetData = await sheetRes.json();
      const criteriaData = await criteriaRes.json();

      if (sheetData.error) {
        throw new Error(sheetData.error);
      }

      setState(prev => ({
        ...prev,
        loading: false,
        sheet: sheetData.sheet ? {
          id: sheetData.sheet.id,
          userSheetId: sheetData.sheet.userSheetId,
          userSheetUrl: sheetData.sheet.userSheetUrl,
          sheetTitle: sheetData.sheet.sheetTitle,
          isCompleted: sheetData.sheet.isCompleted,
          completionData: sheetData.sheet.completionData,
        } : null,
        embedUrl: sheetData.embedUrl,
        editUrl: sheetData.editUrl,
        needsCreation: sheetData.needsCreation,
        gradingResult: sheetData.sheet?.completionData || null,
        criteria: criteriaData.criteria || [],
        totalPoints: criteriaData.totalPoints || 0,
      }));
    } catch (error) {
      console.error("Error fetching sheet status:", error);
      setState(prev => ({
        ...prev,
        loading: false,
        error: error instanceof Error ? error.message : "Failed to load sheet",
      }));
    }
  }, [activity.id]);

  useEffect(() => {
    fetchSheetStatus();
  }, [fetchSheetStatus]);

  // Create a new sheet for the user
  const handleCreateSheet = async () => {
    if (!templateSheetId) {
      setState(prev => ({ ...prev, error: "No template sheet configured for this exercise" }));
      return;
    }

    setState(prev => ({ ...prev, creating: true, error: null }));

    try {
      const res = await fetch("/api/sheets", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          activityId: activity.id,
          templateSheetId,
          exerciseTitle,
        }),
      });

      const data = await res.json();

      if (!data.success) {
        throw new Error(data.error || "Failed to create sheet");
      }

      setState(prev => ({
        ...prev,
        creating: false,
        sheet: data.sheet ? {
          id: data.sheet.id,
          userSheetId: data.sheet.userSheetId,
          userSheetUrl: data.sheet.userSheetUrl,
          sheetTitle: data.sheet.sheetTitle,
          isCompleted: data.sheet.isCompleted,
          completionData: data.sheet.completionData,
        } : null,
        embedUrl: data.embedUrl,
        editUrl: data.editUrl,
        needsCreation: false,
      }));
    } catch (error) {
      console.error("Error creating sheet:", error);
      setState(prev => ({
        ...prev,
        creating: false,
        error: error instanceof Error ? error.message : "Failed to create sheet",
      }));
    }
  };

  // Grade the sheet
  const handleGradeSheet = async () => {
    setState(prev => ({ ...prev, grading: true, error: null }));

    try {
      const res = await fetch("/api/sheets", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ activityId: activity.id }),
      });

      const data = await res.json();

      if (!data.success) {
        throw new Error(data.error || "Failed to grade sheet");
      }

      setState(prev => ({
        ...prev,
        grading: false,
        gradingResult: data.result,
        sheet: prev.sheet ? { ...prev.sheet, isCompleted: data.passed } : null,
      }));

      setShowResults(true);

      if (data.passed && !isCompleted) {
        onComplete();
      }
    } catch (error) {
      console.error("Error grading sheet:", error);
      setState(prev => ({
        ...prev,
        grading: false,
        error: error instanceof Error ? error.message : "Failed to grade sheet",
      }));
    }
  };

  // Reset the sheet
  const handleResetSheet = async () => {
    if (!confirm("Are you sure you want to reset your sheet? This will delete your current work and create a fresh copy.")) {
      return;
    }

    setState(prev => ({ ...prev, resetting: true, error: null }));

    try {
      const res = await fetch(`/api/sheets?activityId=${activity.id}`, {
        method: "DELETE",
      });

      const data = await res.json();

      if (!data.success) {
        throw new Error(data.error || "Failed to reset sheet");
      }

      setState(prev => ({
        ...prev,
        resetting: false,
        sheet: null,
        embedUrl: null,
        editUrl: null,
        needsCreation: true,
        gradingResult: null,
      }));

      setShowResults(false);
    } catch (error) {
      console.error("Error resetting sheet:", error);
      setState(prev => ({
        ...prev,
        resetting: false,
        error: error instanceof Error ? error.message : "Failed to reset sheet",
      }));
    }
  };

  // Loading state
  if (state.loading) {
    return (
      <div className="flex items-center justify-center py-16">
        <Loader2 className="w-8 h-8 animate-spin text-violet-600" />
        <span className="ml-3 text-[var(--foreground-muted)]">Loading exercise...</span>
      </div>
    );
  }

  // Error state
  if (state.error && !state.sheet) {
    return (
      <div className="text-center py-12">
        <div className="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <AlertCircle className="w-8 h-8 text-red-600" />
        </div>
        <h3 className="text-lg font-semibold mb-2">Error Loading Exercise</h3>
        <p className="text-[var(--foreground-muted)] mb-4">{state.error}</p>
        <button
          onClick={fetchSheetStatus}
          className="px-4 py-2 bg-violet-600 text-white rounded-lg hover:bg-violet-700 transition-colors"
        >
          Try Again
        </button>
      </div>
    );
  }

  // Need to create sheet
  if (state.needsCreation) {
    return (
      <div className="text-center py-12">
        <div className="w-20 h-20 bg-violet-100 rounded-full flex items-center justify-center mx-auto mb-6">
          <FileSpreadsheet className="w-10 h-10 text-violet-600" />
        </div>
        
        <h3 className="text-xl font-bold mb-3" style={{ fontFamily: 'var(--font-heading)' }}>
          Spreadsheet Exercise
        </h3>
        
        <p className="text-[var(--foreground-muted)] max-w-md mx-auto mb-6">
          {instructions}
        </p>

        {/* Grading criteria preview */}
        {state.criteria.length > 0 && (
          <div className="max-w-md mx-auto mb-6">
            <button
              onClick={() => setShowCriteria(!showCriteria)}
              className="flex items-center gap-2 text-sm text-violet-600 hover:text-violet-700 mx-auto"
            >
              <Target className="w-4 h-4" />
              <span>View grading criteria ({state.criteria.length} checkpoints)</span>
              {showCriteria ? <ChevronUp className="w-4 h-4" /> : <ChevronDown className="w-4 h-4" />}
            </button>
            
            {showCriteria && (
              <div className="mt-3 text-left bg-slate-50 rounded-xl p-4 space-y-2">
                {state.criteria.map((c, idx) => (
                  <div key={idx} className="flex items-center gap-2 text-sm">
                    <div className="w-5 h-5 rounded-full bg-violet-100 flex items-center justify-center text-xs font-medium text-violet-700">
                      {c.points}
                    </div>
                    <span className="text-slate-700">{c.cellName}</span>
                  </div>
                ))}
                <div className="pt-2 border-t border-slate-200">
                  <span className="text-sm font-medium text-slate-600">
                    Total: {state.totalPoints} points
                  </span>
                </div>
              </div>
            )}
          </div>
        )}

        <button
          onClick={handleCreateSheet}
          disabled={state.creating || !templateSheetId}
          className="flex items-center gap-2 px-6 py-3 bg-violet-600 text-white font-semibold rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed mx-auto"
        >
          {state.creating ? (
            <>
              <Loader2 className="w-5 h-5 animate-spin" />
              Creating your sheet...
            </>
          ) : (
            <>
              <FileSpreadsheet className="w-5 h-5" />
              Start Exercise
            </>
          )}
        </button>

        {!templateSheetId && (
          <p className="text-sm text-amber-600 mt-4">
            <AlertCircle className="w-4 h-4 inline mr-1" />
            This exercise is not properly configured. Please contact support.
          </p>
        )}
      </div>
    );
  }

  // Sheet exists - show the embedded sheet
  return (
    <div className="space-y-6">
      {/* Instructions */}
      <div className="bg-blue-50 border border-blue-200 rounded-xl p-4">
        <div className="flex items-start gap-3">
          <Info className="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" />
          <div>
            <p className="text-sm text-blue-800">{instructions}</p>
            <p className="text-xs text-blue-600 mt-2">
              Your work is automatically saved to your personal Google Sheet.
            </p>
          </div>
        </div>
      </div>

      {/* Error message */}
      {state.error && (
        <div className="bg-red-50 border border-red-200 rounded-xl p-4 flex items-center gap-3">
          <AlertCircle className="w-5 h-5 text-red-600 flex-shrink-0" />
          <p className="text-sm text-red-800">{state.error}</p>
          <button
            onClick={() => setState(prev => ({ ...prev, error: null }))}
            className="ml-auto text-red-600 hover:text-red-700"
          >
            Dismiss
          </button>
        </div>
      )}

      {/* Action bar */}
      <div className="flex flex-wrap items-center justify-between gap-4 bg-slate-50 rounded-xl p-4">
        <div className="flex items-center gap-3">
          <FileSpreadsheet className="w-5 h-5 text-slate-600" />
          <span className="text-sm font-medium text-slate-700">
            {state.sheet?.sheetTitle || exerciseTitle}
          </span>
          {state.sheet?.isCompleted && (
            <span className="flex items-center gap-1 px-2 py-1 bg-emerald-100 text-emerald-700 text-xs font-medium rounded-full">
              <CheckCircle2 className="w-3 h-3" />
              Completed
            </span>
          )}
        </div>

        <div className="flex items-center gap-2">
          <a
            href={state.editUrl || "#"}
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center gap-2 px-3 py-2 text-sm text-slate-600 hover:text-slate-800 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <ExternalLink className="w-4 h-4" />
            Open in Google Sheets
          </a>

          <button
            onClick={handleResetSheet}
            disabled={state.resetting}
            className="flex items-center gap-2 px-3 py-2 text-sm text-slate-600 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors disabled:opacity-50"
          >
            {state.resetting ? (
              <Loader2 className="w-4 h-4 animate-spin" />
            ) : (
              <RotateCcw className="w-4 h-4" />
            )}
            Reset
          </button>
        </div>
      </div>

      {/* Embedded Google Sheet */}
      <div className="border border-slate-200 rounded-xl overflow-hidden bg-white">
        <iframe
          src={state.embedUrl || ""}
          className="w-full"
          style={{ height: "600px", border: "none" }}
          title={exerciseTitle}
          sandbox="allow-scripts allow-same-origin allow-popups allow-forms"
        />
      </div>

      {/* Grading section */}
      <div className="bg-white border border-slate-200 rounded-xl p-6">
        <h4 className="font-semibold text-slate-800 mb-4 flex items-center gap-2">
          <Target className="w-5 h-5 text-violet-600" />
          Check Your Work
        </h4>

        {/* Grading criteria */}
        {state.criteria.length > 0 && (
          <div className="mb-6">
            <button
              onClick={() => setShowCriteria(!showCriteria)}
              className="flex items-center gap-2 text-sm text-violet-600 hover:text-violet-700"
            >
              <span>View grading criteria ({state.criteria.length} checkpoints, {state.totalPoints} points)</span>
              {showCriteria ? <ChevronUp className="w-4 h-4" /> : <ChevronDown className="w-4 h-4" />}
            </button>
            
            {showCriteria && (
              <div className="mt-3 bg-slate-50 rounded-lg p-4 space-y-2">
                {state.criteria.map((c, idx) => (
                  <div key={idx} className="flex items-center justify-between text-sm">
                    <span className="text-slate-700">{c.cellName}</span>
                    <span className="text-slate-500 font-mono text-xs">{c.cellReference}</span>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* Grade button */}
        <button
          onClick={handleGradeSheet}
          disabled={state.grading}
          className="flex items-center gap-2 px-6 py-3 bg-violet-600 text-white font-semibold rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50"
        >
          {state.grading ? (
            <>
              <Loader2 className="w-5 h-5 animate-spin" />
              Checking answers...
            </>
          ) : (
            <>
              <RefreshCw className="w-5 h-5" />
              Check Answers
            </>
          )}
        </button>

        {/* Grading results */}
        {state.gradingResult && showResults && (
          <div className="mt-6">
            <div className={`p-4 rounded-xl border ${
              state.gradingResult.passed 
                ? 'bg-emerald-50 border-emerald-200' 
                : 'bg-amber-50 border-amber-200'
            }`}>
              <div className="flex items-center justify-between mb-4">
                <div className="flex items-center gap-3">
                  {state.gradingResult.passed ? (
                    <CheckCircle2 className="w-8 h-8 text-emerald-600" />
                  ) : (
                    <AlertCircle className="w-8 h-8 text-amber-600" />
                  )}
                  <div>
                    <h5 className={`font-bold ${state.gradingResult.passed ? 'text-emerald-700' : 'text-amber-700'}`}>
                      {state.gradingResult.passed ? 'Excellent Work!' : 'Keep Trying!'}
                    </h5>
                    <p className="text-sm text-slate-600">
                      Score: {state.gradingResult.scorePercent}% ({state.gradingResult.earnedPoints}/{state.gradingResult.totalPoints} points)
                    </p>
                  </div>
                </div>

                <button
                  onClick={() => setShowResults(false)}
                  className="text-slate-400 hover:text-slate-600"
                >
                  <ChevronUp className="w-5 h-5" />
                </button>
              </div>

              {/* Detailed results */}
              <div className="space-y-2">
                {state.gradingResult.results.map((result, idx) => (
                  <div
                    key={idx}
                    className={`flex items-center justify-between p-3 rounded-lg ${
                      result.isCorrect ? 'bg-emerald-100' : 'bg-red-100'
                    }`}
                  >
                    <div className="flex items-center gap-2">
                      {result.isCorrect ? (
                        <CheckCircle2 className="w-4 h-4 text-emerald-600" />
                      ) : (
                        <AlertCircle className="w-4 h-4 text-red-600" />
                      )}
                      <span className={`text-sm font-medium ${result.isCorrect ? 'text-emerald-800' : 'text-red-800'}`}>
                        {result.cellName}
                      </span>
                    </div>
                    <div className="text-right">
                      <span className={`text-xs font-mono ${result.isCorrect ? 'text-emerald-600' : 'text-red-600'}`}>
                        {result.earnedPoints}/{result.points} pts
                      </span>
                      {!result.isCorrect && result.hint && (
                        <p className="text-xs text-red-600 mt-1">{result.hint}</p>
                      )}
                    </div>
                  </div>
                ))}
              </div>

              {!state.gradingResult.passed && (
                <p className="text-sm text-amber-700 mt-4">
                  You need {activity.passing_score}% to pass this exercise. Review your answers and try again.
                </p>
              )}
            </div>
          </div>
        )}

        {/* Show previous result indicator if collapsed */}
        {state.gradingResult && !showResults && (
          <button
            onClick={() => setShowResults(true)}
            className={`mt-4 flex items-center gap-2 text-sm ${
              state.gradingResult.passed ? 'text-emerald-600' : 'text-amber-600'
            }`}
          >
            {state.gradingResult.passed ? (
              <CheckCircle2 className="w-4 h-4" />
            ) : (
              <AlertCircle className="w-4 h-4" />
            )}
            <span>
              Last attempt: {state.gradingResult.scorePercent}% - Click to view details
            </span>
            <ChevronDown className="w-4 h-4" />
          </button>
        )}
      </div>
    </div>
  );
}

