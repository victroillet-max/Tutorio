"use client";

import { useState, useEffect, useCallback, useRef } from "react";
import {
  CheckCircle2,
  Loader2,
  AlertCircle,
  FileSpreadsheet,
  Target,
  ChevronDown,
  ChevronUp,
  Info,
  HelpCircle,
  Maximize2,
  Minimize2,
} from "lucide-react";
import type { Activity } from "@/lib/database.types";

// Resizable Sheet Viewer Component
function ResizableSheetViewer({ templateSheetId }: { templateSheetId: string }) {
  const [height, setHeight] = useState(450);
  const [resizeType, setResizeType] = useState<'none' | 'vertical'>('none');
  const [isExpanded, setIsExpanded] = useState(false);
  const [loadError, setLoadError] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const startPos = useRef({ y: 0 });
  const startHeight = useRef(0);

  const MIN_HEIGHT = 300;
  const MAX_HEIGHT = 800;

  const handleIframeLoad = () => {
    setIsLoading(false);
  };

  const handleIframeError = () => {
    setLoadError(true);
    setIsLoading(false);
  };

  const sheetUrl = `https://docs.google.com/spreadsheets/d/${templateSheetId}/preview?rm=minimal`;

  const handleMouseDown = (e: React.MouseEvent) => {
    e.preventDefault();
    setResizeType('vertical');
    startPos.current = { y: e.clientY };
    startHeight.current = height;
  };

  useEffect(() => {
    const handleMouseMove = (e: MouseEvent) => {
      if (resizeType === 'none') return;
      const deltaY = e.clientY - startPos.current.y;
      const newHeight = Math.min(MAX_HEIGHT, Math.max(MIN_HEIGHT, startHeight.current + deltaY));
      setHeight(newHeight);
    };

    const handleMouseUp = () => {
      setResizeType('none');
    };

    if (resizeType !== 'none') {
      document.addEventListener("mousemove", handleMouseMove);
      document.addEventListener("mouseup", handleMouseUp);
      document.body.style.cursor = 'ns-resize';
      document.body.style.userSelect = 'none';
    }

    return () => {
      document.removeEventListener("mousemove", handleMouseMove);
      document.removeEventListener("mouseup", handleMouseUp);
      document.body.style.cursor = '';
      document.body.style.userSelect = '';
    };
  }, [resizeType]);

  const toggleExpand = () => {
    if (isExpanded) {
      setHeight(450);
    } else {
      setHeight(700);
    }
    setIsExpanded(!isExpanded);
  };

  const isResizing = resizeType !== 'none';

  return (
    <div className="bg-white rounded-xl border border-slate-200 overflow-hidden">
      <div className="bg-slate-50 px-4 py-3 border-b border-slate-200 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <Info className="w-4 h-4 text-slate-500" />
          <span className="text-sm font-medium text-slate-700">Reference Data</span>
        </div>
        <div className="flex items-center gap-3">
          <span className="text-xs text-slate-400">Drag bottom to resize</span>
          <button
            onClick={toggleExpand}
            className="flex items-center gap-1.5 px-2 py-1 text-xs rounded-lg hover:bg-slate-200 transition-colors text-slate-600"
            title={isExpanded ? "Collapse" : "Expand"}
          >
            {isExpanded ? (
              <>
                <Minimize2 className="w-3.5 h-3.5" />
                <span>Smaller</span>
              </>
            ) : (
              <>
                <Maximize2 className="w-3.5 h-3.5" />
                <span>Larger</span>
              </>
            )}
          </button>
        </div>
      </div>
      <div className="relative">
        {/* Loading indicator */}
        {isLoading && !loadError && (
          <div 
            className="absolute inset-0 flex items-center justify-center bg-slate-50 z-10"
            style={{ height: `${height}px` }}
          >
            <div className="text-center">
              <Loader2 className="w-8 h-8 animate-spin text-violet-600 mx-auto mb-2" />
              <p className="text-sm text-slate-500">Loading spreadsheet...</p>
            </div>
          </div>
        )}

        {/* Error fallback */}
        {loadError ? (
          <div 
            className="flex flex-col items-center justify-center bg-slate-50 border-2 border-dashed border-slate-200 rounded-lg"
            style={{ height: `${height}px` }}
          >
            <AlertCircle className="w-12 h-12 text-amber-500 mb-3" />
            <h4 className="text-lg font-medium text-slate-700 mb-1">Unable to load spreadsheet</h4>
            <p className="text-sm text-slate-500 mb-4 text-center max-w-md px-4">
              The reference spreadsheet could not be loaded. This may be due to browser security settings or network issues.
            </p>
            <a
              href={sheetUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="px-4 py-2 bg-violet-600 text-white text-sm font-medium rounded-lg hover:bg-violet-700 transition-colors"
            >
              Open in Google Sheets
            </a>
          </div>
        ) : (
          <iframe
            src={sheetUrl}
            className="w-full"
            style={{ height: `${height}px`, border: "none" }}
            title="Financial Data Reference"
            onLoad={handleIframeLoad}
            onError={handleIframeError}
            sandbox="allow-scripts allow-same-origin"
          />
        )}
        
        {/* Bottom resize handle */}
        {!loadError && (
          <div
            onMouseDown={handleMouseDown}
            className={`
              absolute bottom-0 left-0 right-0 h-4 cursor-ns-resize
              flex items-center justify-center
              bg-gradient-to-t from-slate-200/80 to-transparent
              hover:from-slate-300/80 transition-colors
              ${isResizing ? "from-violet-200/80" : ""}
            `}
          >
            <div className="w-12 h-1 bg-slate-400 rounded-full" />
          </div>
        )}
      </div>
      
      {/* Height indicator during resize */}
      {isResizing && (
        <div className="absolute bottom-8 left-1/2 -translate-x-1/2 bg-slate-800 text-white text-xs px-3 py-1.5 rounded-lg shadow-lg z-50">
          {height}px
        </div>
      )}
    </div>
  );
}

interface SpreadsheetExerciseViewerProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
  onComplete: () => void;
}

interface GradingCriterion {
  id: string;
  cellReference: string;
  cellName: string;
  expectedValue: string;
  expectedType: string;
  tolerance: number;
  isRequired: boolean;
  points: number;
  sortOrder: number;
  hintOnError: string | null;
}

interface GradingResult {
  cellName: string;
  userValue: string | number;
  expectedValue: string | number;
  isCorrect: boolean;
  points: number;
  earnedPoints: number;
  hint?: string;
}

interface AnswerState {
  [cellName: string]: string;
}

export function SpreadsheetExerciseViewer({
  activity,
  userId,
  isCompleted,
  onComplete,
}: SpreadsheetExerciseViewerProps) {
  const [loading, setLoading] = useState(true);
  const [grading, setGrading] = useState(false);
  const [criteria, setCriteria] = useState<GradingCriterion[]>([]);
  const [answers, setAnswers] = useState<AnswerState>({});
  const [results, setResults] = useState<GradingResult[] | null>(null);
  const [showResults, setShowResults] = useState(false);
  const [showHints, setShowHints] = useState(false);
  const [totalPoints, setTotalPoints] = useState(0);
  const [error, setError] = useState<string | null>(null);

  const content = activity.content as {
    template_sheet_id?: string;
    instructions?: string;
    exercise_title?: string;
    hints?: string[];
  } | null;

  const templateSheetId = content?.template_sheet_id;
  const instructions = content?.instructions || "Complete the exercise by entering your answers below.";
  const hints = content?.hints || [];

  // Fetch grading criteria
  const fetchCriteria = useCallback(async () => {
    setLoading(true);
    try {
      const res = await fetch(`/api/sheets?activityId=${activity.id}&action=criteria`);
      const data = await res.json();
      
      if (data.criteria) {
        setCriteria(data.criteria);
        setTotalPoints(data.totalPoints || 0);
        
        // Initialize answers state
        const initialAnswers: AnswerState = {};
        data.criteria.forEach((c: GradingCriterion) => {
          initialAnswers[c.cellName] = "";
        });
        setAnswers(initialAnswers);
      }
    } catch (err) {
      console.error("Error fetching criteria:", err);
      setError("Failed to load exercise");
    } finally {
      setLoading(false);
    }
  }, [activity.id]);

  useEffect(() => {
    fetchCriteria();
  }, [fetchCriteria]);

  // Update answer
  const handleAnswerChange = (cellName: string, value: string) => {
    setAnswers(prev => ({ ...prev, [cellName]: value }));
    // Clear results when user changes an answer
    if (results) {
      setResults(null);
      setShowResults(false);
    }
  };

  // Grade answers locally
  const handleGrade = async () => {
    setGrading(true);
    setError(null);

    try {
      const gradingResults: GradingResult[] = [];
      let earnedTotal = 0;

      for (const criterion of criteria) {
        const userValue = answers[criterion.cellName]?.trim() || "";
        const expectedValue = criterion.expectedValue;
        
        let isCorrect = false;
        
        if (criterion.expectedType === "number") {
          const userNum = parseFloat(userValue.replace(/,/g, ""));
          const expectedNum = parseFloat(expectedValue);
          
          if (!isNaN(userNum) && !isNaN(expectedNum)) {
            if (criterion.tolerance > 0) {
              const diff = Math.abs(userNum - expectedNum);
              const maxDiff = Math.abs(expectedNum) * criterion.tolerance;
              isCorrect = diff <= maxDiff;
            } else {
              isCorrect = Math.abs(userNum - expectedNum) < 0.01;
            }
          }
        } else {
          isCorrect = userValue.toLowerCase() === expectedValue.toLowerCase();
        }

        const earned = isCorrect ? criterion.points : 0;
        earnedTotal += earned;

        gradingResults.push({
          cellName: criterion.cellName,
          userValue: userValue || "(empty)",
          expectedValue: criterion.expectedValue,
          isCorrect,
          points: criterion.points,
          earnedPoints: earned,
          hint: !isCorrect ? (criterion.hintOnError || undefined) : undefined,
        });
      }

      setResults(gradingResults);
      setShowResults(true);

      const scorePercent = totalPoints > 0 ? Math.round((earnedTotal / totalPoints) * 100) : 0;
      const passed = scorePercent >= (activity.passing_score || 70);

      // Save progress to database
      await fetch("/api/sheets", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          activityId: activity.id,
          answers,
          score: scorePercent,
          passed,
        }),
      });

      if (passed && !isCompleted) {
        onComplete();
      }
    } catch (err) {
      console.error("Error grading:", err);
      setError("Failed to grade answers");
    } finally {
      setGrading(false);
    }
  };

  // Calculate current score from results
  const currentScore = results
    ? {
        earned: results.reduce((sum, r) => sum + r.earnedPoints, 0),
        total: totalPoints,
        percent: Math.round((results.reduce((sum, r) => sum + r.earnedPoints, 0) / totalPoints) * 100),
        passed: Math.round((results.reduce((sum, r) => sum + r.earnedPoints, 0) / totalPoints) * 100) >= (activity.passing_score || 70),
      }
    : null;

  // Group criteria by section (based on cell reference patterns)
  const groupedCriteria = criteria.reduce((acc, c) => {
    // Extract section from cell name (e.g., "Operating Activities", "Investing Activities")
    let section = "Answers";
    if (c.cellName.includes("Operating") || c.cellReference.includes("D10") || c.cellReference.includes("D13") || c.cellReference.includes("D16") || c.cellReference.includes("D17") || c.cellReference.includes("D18") || c.cellReference.includes("D19") || c.cellReference.includes("D20") || c.cellReference.includes("D22")) {
      section = "Operating Activities";
    } else if (c.cellName.includes("Investing") || c.cellReference.includes("D27") || c.cellReference.includes("D28") || c.cellReference.includes("D30")) {
      section = "Investing Activities";
    } else if (c.cellName.includes("Financing") || c.cellReference.includes("D35") || c.cellReference.includes("D36") || c.cellReference.includes("D37") || c.cellReference.includes("D39")) {
      section = "Financing Activities";
    } else if (c.cellName.includes("Net") || c.cellName.includes("Beginning") || c.cellName.includes("Ending") || c.cellReference.includes("D42") || c.cellReference.includes("D44") || c.cellReference.includes("D45")) {
      section = "Summary";
    }
    
    if (!acc[section]) acc[section] = [];
    acc[section].push(c);
    return acc;
  }, {} as Record<string, GradingCriterion[]>);

  if (loading) {
    return (
      <div className="flex items-center justify-center py-16">
        <Loader2 className="w-8 h-8 animate-spin text-violet-600" />
        <span className="ml-3 text-[var(--foreground-muted)]">Loading exercise...</span>
      </div>
    );
  }

  if (error && criteria.length === 0) {
    return (
      <div className="text-center py-12">
        <AlertCircle className="w-12 h-12 text-red-500 mx-auto mb-4" />
        <p className="text-red-600">{error}</p>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="bg-white rounded-xl border border-slate-200 p-6">
        <div className="flex items-start gap-4">
          <div className="w-12 h-12 bg-violet-100 rounded-xl flex items-center justify-center flex-shrink-0">
            <FileSpreadsheet className="w-6 h-6 text-violet-600" />
          </div>
          <div className="flex-1">
            <h2 className="text-xl font-bold text-slate-900 mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
              {activity.title}
            </h2>
            <p className="text-slate-600">{instructions}</p>
          </div>
        </div>
      </div>

      {/* Embedded Template Sheet (Read-only for reference) */}
      {templateSheetId && (
        <ResizableSheetViewer templateSheetId={templateSheetId} />
      )}

      {/* Hints Section */}
      {hints.length > 0 && (
        <div className="bg-amber-50 border border-amber-200 rounded-xl">
          <button
            onClick={() => setShowHints(!showHints)}
            className="w-full px-4 py-3 flex items-center justify-between text-left"
          >
            <div className="flex items-center gap-2">
              <HelpCircle className="w-5 h-5 text-amber-600" />
              <span className="font-medium text-amber-800">Helpful Hints</span>
            </div>
            {showHints ? (
              <ChevronUp className="w-5 h-5 text-amber-600" />
            ) : (
              <ChevronDown className="w-5 h-5 text-amber-600" />
            )}
          </button>
          {showHints && (
            <div className="px-4 pb-4">
              <ul className="space-y-2">
                {hints.map((hint, idx) => (
                  <li key={idx} className="flex items-start gap-2 text-sm text-amber-700">
                    <span className="text-amber-500 mt-1">•</span>
                    <span>{hint}</span>
                  </li>
                ))}
              </ul>
            </div>
          )}
        </div>
      )}

      {/* Answer Form */}
      <div className="bg-white rounded-xl border border-slate-200 p-6">
        <div className="flex items-center gap-2 mb-6">
          <Target className="w-5 h-5 text-violet-600" />
          <h3 className="text-lg font-semibold text-slate-900">Enter Your Answers</h3>
          <span className="text-sm text-slate-500 ml-auto">
            {totalPoints} points total
          </span>
        </div>

        <div className="space-y-8">
          {Object.entries(groupedCriteria).map(([section, sectionCriteria]) => (
            <div key={section}>
              <h4 className="text-sm font-semibold text-slate-500 uppercase tracking-wider mb-4">
                {section}
              </h4>
              <div className="grid gap-4">
                {sectionCriteria.map((criterion) => {
                  const result = results?.find(r => r.cellName === criterion.cellName);
                  
                  return (
                    <div
                      key={criterion.id}
                      className={`flex items-center gap-4 p-4 rounded-lg border transition-colors ${
                        result
                          ? result.isCorrect
                            ? "bg-emerald-50 border-emerald-200"
                            : "bg-red-50 border-red-200"
                          : "bg-slate-50 border-slate-200"
                      }`}
                    >
                      <div className="flex-1">
                        <label className="block text-sm font-medium text-slate-700 mb-1">
                          {criterion.cellName}
                          {criterion.isRequired && <span className="text-red-500 ml-1">*</span>}
                        </label>
                        <div className="flex items-center gap-2">
                          <span className="text-slate-400">$</span>
                          <input
                            type="text"
                            value={answers[criterion.cellName] || ""}
                            onChange={(e) => handleAnswerChange(criterion.cellName, e.target.value)}
                            placeholder="Enter amount..."
                            className={`flex-1 px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-violet-500 ${
                              result
                                ? result.isCorrect
                                  ? "border-emerald-300 bg-white"
                                  : "border-red-300 bg-white"
                                : "border-slate-300"
                            }`}
                          />
                        </div>
                        {result && !result.isCorrect && result.hint && (
                          <p className="text-sm text-red-600 mt-2 flex items-start gap-1">
                            <HelpCircle className="w-4 h-4 flex-shrink-0 mt-0.5" />
                            {result.hint}
                          </p>
                        )}
                      </div>
                      <div className="text-right">
                        <span className={`text-sm font-medium ${
                          result
                            ? result.isCorrect
                              ? "text-emerald-600"
                              : "text-red-600"
                            : "text-slate-400"
                        }`}>
                          {result ? `${result.earnedPoints}/${criterion.points}` : `${criterion.points} pts`}
                        </span>
                        {result && (
                          <div className="mt-1">
                            {result.isCorrect ? (
                              <CheckCircle2 className="w-5 h-5 text-emerald-600" />
                            ) : (
                              <AlertCircle className="w-5 h-5 text-red-600" />
                            )}
                          </div>
                        )}
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          ))}
        </div>

        {/* Grade Button */}
        <div className="mt-8 flex items-center justify-between">
          <button
            onClick={handleGrade}
            disabled={grading}
            className="flex items-center gap-2 px-6 py-3 bg-violet-600 text-white font-semibold rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50"
          >
            {grading ? (
              <>
                <Loader2 className="w-5 h-5 animate-spin" />
                Checking...
              </>
            ) : (
              <>
                <CheckCircle2 className="w-5 h-5" />
                Check Answers
              </>
            )}
          </button>

          {currentScore && (
            <div className={`text-right px-4 py-2 rounded-lg ${
              currentScore.passed ? "bg-emerald-100" : "bg-amber-100"
            }`}>
              <div className={`text-2xl font-bold ${
                currentScore.passed ? "text-emerald-700" : "text-amber-700"
              }`}>
                {currentScore.percent}%
              </div>
              <div className={`text-sm ${
                currentScore.passed ? "text-emerald-600" : "text-amber-600"
              }`}>
                {currentScore.earned}/{currentScore.total} points
                {currentScore.passed ? " - Passed!" : ` - Need ${activity.passing_score}%`}
              </div>
            </div>
          )}
        </div>

        {error && (
          <p className="mt-4 text-sm text-red-600 flex items-center gap-2">
            <AlertCircle className="w-4 h-4" />
            {error}
          </p>
        )}
      </div>
    </div>
  );
}

