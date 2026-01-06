"use client";

import { useState, useEffect, useRef, useCallback } from "react";
import { 
  Play, 
  CheckCircle2, 
  XCircle, 
  Code, 
  Lightbulb, 
  RotateCcw,
  Terminal,
  FileCode,
  ChevronDown,
  ChevronUp,
  AlertCircle,
  Sparkles,
  Trophy,
  Target,
  Bot,
  Loader2,
  ThumbsUp,
  MessageSquare
} from "lucide-react";
import type { Activity } from "@/lib/database.types";
import { markActivityComplete, trackActivityView, updateActivityProgress } from "@/lib/activities/actions";
import { useChatContext } from "@/components/chat";

interface CodeEditorProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
}

interface TestCase {
  input: string;
  expected_output: string | null;
  is_hidden?: boolean;
  description?: string;
  validation?: string; // Custom validation rule like "line_count >= 3" or "ai"
  ai_prompt?: string; // Specific requirements for AI to check
}

interface AIValidationResult {
  passed: boolean;
  score: number;
  feedback: string;
  suggestions: string[];
  details: {
    requirementsMet: boolean;
    codeQuality: "good" | "acceptable" | "needs_improvement";
    issues: string[];
  };
}

interface TestResult {
  passed: boolean;
  message: string;
  expected?: string;
  actual?: string;
  isHidden?: boolean;
  error?: string;
  matchDetails?: {
    exactMatch: boolean;
    lengthMatch: boolean;
    expectedLength: number;
    actualLength: number;
    firstDiffIndex: number;
    diffDescription: string;
  };
  // AI validation specific fields
  isAIValidation?: boolean;
  aiResult?: AIValidationResult;
  // AI error explanation
  aiErrorExplanation?: {
    explanation: string;
    fix: string;
    example?: string;
  };
  isLoadingAIError?: boolean;
}

interface CodeContent {
  // Support both snake_case and camelCase from database
  instructions?: string;
  starter_code?: string;
  starterCode?: string;
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  test_cases?: any[];
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  testCases?: any[];
  hints?: string[];
  solution?: string;
}

export function CodeEditor({ activity, userId, isCompleted }: CodeEditorProps) {
  const content = activity.content as CodeContent | null;
  const starterCode = activity.starter_code || content?.starter_code || content?.starterCode || "# Write your code here\n";
  
  // Normalize test cases to handle both camelCase and snake_case from database
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const rawTestCases: any[] = content?.test_cases || content?.testCases || [];
  const testCases: TestCase[] = rawTestCases.map((tc) => ({
    input: tc.input || '',
    // Handle null expectedOutput for validation-based tests
    expected_output: tc.expected_output ?? tc.expectedOutput ?? null,
    is_hidden: tc.is_hidden || tc.isHidden || false,
    description: tc.description,
    validation: tc.validation, // Custom validation rule or "ai"
    ai_prompt: tc.ai_prompt || tc.aiPrompt, // AI-specific requirements
  }));
  
  const hints = content?.hints || [];
  
  const [code, setCode] = useState(starterCode);
  const [output, setOutput] = useState<string>("");
  const [isRunning, setIsRunning] = useState(false);
  const [testResults, setTestResults] = useState<TestResult[]>([]);
  const [showHints, setShowHints] = useState(false);
  const [currentHint, setCurrentHint] = useState(0);
  const [completed, setCompleted] = useState(isCompleted);
  const [pyodideReady, setPyodideReady] = useState(false);
  const [pyodideLoading, setPyodideLoading] = useState(true);
  const [activeTab, setActiveTab] = useState<'output' | 'tests'>('tests');
  const [expandedTests, setExpandedTests] = useState<Set<number>>(new Set());
  const [showCelebration, setShowCelebration] = useState(false);
  const [isAIValidating, setIsAIValidating] = useState(false);
  
  // Struggling detection state
  const [consecutiveFailures, setConsecutiveFailures] = useState(0);
  const [hasShownHelpPopup, setHasShownHelpPopup] = useState(false);
  const activityStartTime = useRef<number>(Date.now());
  // B8: Track time for "Hours Learned" - saves incrementally when page is hidden
  const lastSavedTimeRef = useRef<number>(Date.now());
  
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const pyodideRef = useRef<any>(null);
  const textareaRef = useRef<HTMLTextAreaElement>(null);
  
  // Chat context for AI tutor integration
  const chatContext = useChatContext();

  // Update chat context with current code (debounced to avoid too many updates)
  const updateChatCodeContext = useCallback((newCode: string) => {
    chatContext.updateStudentCode(newCode);
  }, [chatContext]);
  
  // Update code and sync with chat context
  const handleCodeChange = useCallback((newCode: string) => {
    setCode(newCode);
    // Debounce the chat context update
    const timeoutId = setTimeout(() => {
      updateChatCodeContext(newCode);
    }, 1000);
    return () => clearTimeout(timeoutId);
  }, [updateChatCodeContext]);
  
  // B8: Save time spent incrementally (server accumulates)
  const saveTimeSpent = useCallback(async () => {
    const now = Date.now();
    const timeSpent = Math.floor((now - lastSavedTimeRef.current) / 1000);
    if (timeSpent > 0) {
      try {
        await updateActivityProgress(activity.id, { timeSpentSeconds: timeSpent });
        lastSavedTimeRef.current = now;
      } catch (error) {
        console.error("Failed to save time spent:", error);
      }
    }
  }, [activity.id]);
  
  // Track activity view and set up visibility change handler
  useEffect(() => {
    trackActivityView(activity.id).catch(console.error);
    // Reset activity start time
    activityStartTime.current = Date.now();
    lastSavedTimeRef.current = Date.now();
    
    // Save time when page is hidden
    const handleVisibilityChange = () => {
      if (document.hidden) {
        saveTimeSpent();
      }
    };
    
    document.addEventListener("visibilitychange", handleVisibilityChange);
    
    return () => {
      document.removeEventListener("visibilitychange", handleVisibilityChange);
      saveTimeSpent();
    };
  }, [activity.id, saveTimeSpent]);

  // Time-based struggling detection (3+ minutes without success)
  useEffect(() => {
    if (completed || hasShownHelpPopup) return;
    
    const checkTimeSpent = () => {
      const timeSpent = Date.now() - activityStartTime.current;
      const threeMinutes = 3 * 60 * 1000;
      
      if (timeSpent >= threeMinutes && !hasShownHelpPopup && !chatContext.hasDismissedHelp) {
        setHasShownHelpPopup(true);
        chatContext.triggerPopup(
          "Stuck? I can give you a hint without spoiling the answer.",
          "help"
        );
      }
    };

    // Check every 30 seconds
    const interval = setInterval(checkTimeSpent, 30000);
    
    return () => clearInterval(interval);
  }, [completed, hasShownHelpPopup, chatContext]);

  // Load Pyodide
  useEffect(() => {
    async function loadPyodide() {
      if (pyodideRef.current) return;
      
      try {
        // Dynamically load Pyodide from CDN
        const script = document.createElement('script');
        script.src = 'https://cdn.jsdelivr.net/pyodide/v0.24.1/full/pyodide.js';
        script.async = true;
        
        script.onload = async () => {
          try {
            // @ts-expect-error - Pyodide is loaded from CDN
            const pyodide = await window.loadPyodide({
              indexURL: 'https://cdn.jsdelivr.net/pyodide/v0.24.1/full/',
            });
            pyodideRef.current = pyodide;
            setPyodideReady(true);
          } catch (error) {
            console.error('Failed to initialize Pyodide:', error);
            setOutput('Failed to load Python environment. Please refresh the page.');
          } finally {
            setPyodideLoading(false);
          }
        };
        
        script.onerror = () => {
          setPyodideLoading(false);
          setOutput('Failed to load Python environment. Please check your internet connection.');
        };
        
        document.head.appendChild(script);
      } catch (error) {
        console.error('Failed to load Pyodide:', error);
        setPyodideLoading(false);
      }
    }
    
    loadPyodide();
  }, []);

  const toggleTestExpanded = (index: number) => {
    setExpandedTests(prev => {
      const next = new Set(prev);
      if (next.has(index)) {
        next.delete(index);
      } else {
        next.add(index);
      }
      return next;
    });
  };

  // Detailed comparison function for exact matching
  const analyzeMatch = (expected: string, actual: string): TestResult['matchDetails'] => {
    const exactMatch = expected === actual;
    const lengthMatch = expected.length === actual.length;
    
    // Find first difference
    let firstDiffIndex = -1;
    for (let i = 0; i < Math.max(expected.length, actual.length); i++) {
      if (expected[i] !== actual[i]) {
        firstDiffIndex = i;
        break;
      }
    }
    
    // Generate diff description
    let diffDescription = '';
    if (exactMatch) {
      diffDescription = 'Output matches exactly';
    } else if (!lengthMatch) {
      diffDescription = `Length mismatch: expected ${expected.length} characters, got ${actual.length}`;
    } else if (firstDiffIndex >= 0) {
      const expectedChar = expected[firstDiffIndex];
      const actualChar = actual[firstDiffIndex];
      const charDesc = (c: string | undefined) => {
        if (c === undefined) return 'end of string';
        if (c === ' ') return 'space';
        if (c === '\n') return 'newline';
        if (c === '\t') return 'tab';
        return `"${c}"`;
      };
      diffDescription = `Difference at position ${firstDiffIndex + 1}: expected ${charDesc(expectedChar)}, got ${charDesc(actualChar)}`;
    }
    
    return {
      exactMatch,
      lengthMatch,
      expectedLength: expected.length,
      actualLength: actual.length,
      firstDiffIndex,
      diffDescription,
    };
  };

  // Normalize output for comparison (handles different line endings)
  const normalizeOutput = (str: string): string => {
    return str
      .replace(/\r\n/g, '\n')  // Windows line endings
      .replace(/\r/g, '\n')     // Old Mac line endings
      .trim();                   // Remove leading/trailing whitespace
  };

  // Evaluate custom validation rules
  const evaluateValidation = (
    validation: string,
    output: string,
    userCode: string
  ): { passed: boolean; message: string } => {
    const lines = output.split('\n').filter(line => line.trim() !== '');
    const lineCount = lines.length;
    
    // Parse validation rule
    // Supports: line_count >= N, line_count == N, line_count > N, contains "text", print_count >= N
    
    // Count print statements in code
    const printCount = (userCode.match(/print\s*\(/g) || []).length;
    
    // line_count validations
    const lineCountMatch = validation.match(/line_count\s*(>=|<=|==|>|<)\s*(\d+)/);
    if (lineCountMatch) {
      const operator = lineCountMatch[1];
      const value = parseInt(lineCountMatch[2]);
      let passed = false;
      
      switch (operator) {
        case '>=': passed = lineCount >= value; break;
        case '<=': passed = lineCount <= value; break;
        case '==': passed = lineCount === value; break;
        case '>': passed = lineCount > value; break;
        case '<': passed = lineCount < value; break;
      }
      
      return {
        passed,
        message: passed 
          ? `Output has ${lineCount} line${lineCount !== 1 ? 's' : ''}`
          : `Expected at least ${value} lines of output, got ${lineCount}`
      };
    }
    
    // print_count validations (counts print() in code)
    const printCountMatch = validation.match(/print_count\s*(>=|<=|==|>|<)\s*(\d+)/);
    if (printCountMatch) {
      const operator = printCountMatch[1];
      const value = parseInt(printCountMatch[2]);
      let passed = false;
      
      switch (operator) {
        case '>=': passed = printCount >= value; break;
        case '<=': passed = printCount <= value; break;
        case '==': passed = printCount === value; break;
        case '>': passed = printCount > value; break;
        case '<': passed = printCount < value; break;
      }
      
      return {
        passed,
        message: passed 
          ? `Code has ${printCount} print statement${printCount !== 1 ? 's' : ''}`
          : `Expected at least ${value} print statement${value !== 1 ? 's' : ''}, found ${printCount}`
      };
    }
    
    // contains validation
    const containsMatch = validation.match(/contains\s*["'](.+?)["']/);
    if (containsMatch) {
      const text = containsMatch[1];
      const passed = output.includes(text);
      return {
        passed,
        message: passed 
          ? `Output contains "${text}"`
          : `Output should contain "${text}"`
      };
    }
    
    // Fallback - unknown validation
    return { passed: false, message: `Unknown validation: ${validation}` };
  };

  // Call AI error explanation API
  const callAIErrorExplanation = async (
    errorMessage: string,
    userCode: string
  ): Promise<{ explanation: string; fix: string; example?: string }> => {
    const response = await fetch('/api/validate/error', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        error: errorMessage,
        code: userCode,
        activityTitle: activity.title,
      }),
    });

    if (!response.ok) {
      throw new Error('Failed to get AI error explanation');
    }

    return response.json();
  };

  // Call AI validation API
  const callAIValidation = async (
    userCode: string,
    codeOutput: string,
    aiPrompt?: string
  ): Promise<AIValidationResult> => {
    const response = await fetch('/api/validate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        code: userCode,
        output: codeOutput,
        instructions: content?.instructions || activity.title,
        aiPrompt: aiPrompt,
        activityTitle: activity.title,
      }),
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'AI validation failed');
    }

    return response.json();
  };

  const runCode = async () => {
    if (!pyodideRef.current || isRunning) return;
    
    setIsRunning(true);
    setOutput("");
    setTestResults([]);
    setActiveTab('tests');
    setShowCelebration(false);
    
    try {
      const pyodide = pyodideRef.current;
      
      // Capture stdout
      pyodide.runPython(`
import sys
from io import StringIO
sys.stdout = StringIO()
      `);
      
      // Run user code
      try {
        pyodide.runPython(code);
      } catch (error) {
        const errorMessage = error instanceof Error ? error.message : String(error);
        setOutput(`Error: ${errorMessage}`);
        
        // Update chat context with the error for AI tutor
        chatContext.updateErrorMessage(errorMessage);
        
        // Create initial error result with loading state
        const errorResult: TestResult = {
          passed: false,
          message: "Code Error",
          error: errorMessage,
          isLoadingAIError: true,
        };
        setTestResults([errorResult]);
        setExpandedTests(new Set([0])); // Auto-expand the error card
        setIsRunning(false);
        
        // Call AI to explain the error
        try {
          const aiExplanation = await callAIErrorExplanation(errorMessage, code);
          setTestResults([{
            ...errorResult,
            isLoadingAIError: false,
            aiErrorExplanation: aiExplanation,
          }]);
        } catch {
          // If AI fails, just show the raw error
          setTestResults([{
            ...errorResult,
            isLoadingAIError: false,
          }]);
        }
        return;
      }
      
      // Get stdout
      const stdout = pyodide.runPython("sys.stdout.getvalue()");
      setOutput(stdout || "(No output)");
      
      // Run test cases if any
      if (testCases.length > 0) {
        const results: TestResult[] = [];
        
        for (let i = 0; i < testCases.length; i++) {
          const testCase = testCases[i];
          try {
            // Reset stdout for each test
            pyodide.runPython("sys.stdout = StringIO()");
            
            // Run test input
            const testCode = `${code}\n${testCase.input}`;
            pyodide.runPython(testCode);
            
            const rawOutput = pyodide.runPython("sys.stdout.getvalue()");
            const testOutput = normalizeOutput(rawOutput);
            
            // Check if this is an AI validation test
            if (testCase.validation === 'ai') {
              // AI validation will be done after the loop
              results.push({
                passed: false, // Placeholder, will be updated by AI
                message: testCase.description || `AI Validation`,
                actual: testOutput,
                isHidden: testCase.is_hidden,
                isAIValidation: true,
                matchDetails: {
                  exactMatch: false,
                  lengthMatch: true,
                  expectedLength: 0,
                  actualLength: testOutput.length,
                  firstDiffIndex: -1,
                  diffDescription: 'Waiting for AI validation...'
                }
              });
            // Check if this is a custom validation-based test (no expected output)
            } else if (testCase.validation && (testCase.expected_output === null || testCase.expected_output === '')) {
              // Use custom validation
              const validationResult = evaluateValidation(testCase.validation, testOutput, code);
              results.push({ 
                passed: validationResult.passed,
                message: testCase.description || `Test Case ${i + 1}`,
                actual: testOutput,
                isHidden: testCase.is_hidden,
                matchDetails: {
                  exactMatch: validationResult.passed,
                  lengthMatch: true,
                  expectedLength: 0,
                  actualLength: testOutput.length,
                  firstDiffIndex: -1,
                  diffDescription: validationResult.message
                }
              });
            } else {
              // Standard output comparison
              const expected = normalizeOutput(testCase.expected_output || '');
              
              // Perform detailed analysis
              const matchDetails = analyzeMatch(expected, testOutput);
              const isExactMatch = matchDetails?.exactMatch ?? false;
              
              if (isExactMatch) {
              results.push({ 
                passed: true, 
                  message: testCase.description || `Test Case ${i + 1}`,
                  expected: expected,
                  actual: testOutput,
                  isHidden: testCase.is_hidden,
                  matchDetails
              });
            } else {
              results.push({ 
                passed: false, 
                  message: testCase.description || `Test Case ${i + 1}`,
                  expected: testCase.is_hidden ? '[Hidden]' : expected,
                  actual: testCase.is_hidden ? '[Hidden]' : testOutput,
                  isHidden: testCase.is_hidden,
                  matchDetails: testCase.is_hidden ? undefined : matchDetails
                });
              }
            }
          } catch (error) {
            results.push({ 
              passed: false, 
              message: testCase.description || `Test Case ${i + 1}`,
              error: error instanceof Error ? error.message : String(error),
              isHidden: testCase.is_hidden
            });
          }
        }
        
        setTestResults(results);
        
        // Check if we have any AI validation tests
        const aiTestIndices = results
          .map((r, idx) => r.isAIValidation ? idx : -1)
          .filter(idx => idx >= 0);
        
        if (aiTestIndices.length > 0) {
          // Run AI validation
          setIsAIValidating(true);
          setIsRunning(false); // Allow user to see code ran, but AI is validating
          
          try {
            // Get the corresponding test cases and run AI validation
            for (const idx of aiTestIndices) {
              const testCase = testCases[idx];
              const testOutput = results[idx].actual || '';
              
              try {
                const aiResult = await callAIValidation(code, testOutput, testCase.ai_prompt);
                
                // Update the result with AI response
                results[idx] = {
                  ...results[idx],
                  passed: aiResult.passed,
                  aiResult,
                  matchDetails: {
                    exactMatch: aiResult.passed,
                    lengthMatch: true,
                    expectedLength: 0,
                    actualLength: testOutput.length,
                    firstDiffIndex: -1,
                    diffDescription: aiResult.feedback
                  }
                };
              } catch (aiError) {
                results[idx] = {
                  ...results[idx],
                  passed: false,
                  error: aiError instanceof Error ? aiError.message : 'AI validation failed',
                  matchDetails: {
                    exactMatch: false,
                    lengthMatch: true,
                    expectedLength: 0,
                    actualLength: testOutput.length,
                    firstDiffIndex: -1,
                    diffDescription: 'AI validation error - please try again'
                  }
                };
              }
            }
            
            // Update results after AI validation
            setTestResults([...results]);
          } finally {
            setIsAIValidating(false);
          }
        }
        
        // Check if all tests passed (after AI validation)
        const allPassed = results.every(r => r.passed);
        
        // Clear error from chat context if all tests passed
        if (allPassed) {
          chatContext.updateErrorMessage(undefined);
          // Reset struggling detection on success
          setConsecutiveFailures(0);
        } else {
          // Track consecutive failures for struggling detection
          const newFailureCount = consecutiveFailures + 1;
          setConsecutiveFailures(newFailureCount);
          
          // Trigger help popup after 2+ consecutive failures
          if (newFailureCount >= 2 && !hasShownHelpPopup && !chatContext.hasDismissedHelp) {
            setHasShownHelpPopup(true);
            chatContext.triggerPopup(
              "Having trouble with your code? I can help you debug!",
              "help"
            );
          }
        }
        
        if (allPassed && !completed) {
          try {
            // B8: Save time spent before marking complete
            await saveTimeSpent();
            
            await markActivityComplete(activity.id, 100);
            setCompleted(true);
            setShowCelebration(true);
            // Hide celebration after 3 seconds
            setTimeout(() => setShowCelebration(false), 3000);
          } catch (error) {
            console.error('Failed to mark complete:', error);
          }
        }
      }
    } catch (error) {
      setOutput(`Error: ${error instanceof Error ? error.message : String(error)}`);
    } finally {
      setIsRunning(false);
      setIsAIValidating(false);
    }
  };

  const resetCode = () => {
    setCode(starterCode);
    setOutput("");
    setTestResults([]);
  };

  // Handle tab key in textarea
  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (e.key === 'Tab') {
      e.preventDefault();
      const start = e.currentTarget.selectionStart;
      const end = e.currentTarget.selectionEnd;
      const newCode = code.substring(0, start) + '    ' + code.substring(end);
      setCode(newCode);
      // Set cursor position after tab
      setTimeout(() => {
        if (textareaRef.current) {
          textareaRef.current.selectionStart = textareaRef.current.selectionEnd = start + 4;
        }
      }, 0);
    }
  };

  const allTestsPassed = testResults.length > 0 && testResults.every(r => r.passed);
  const passedCount = testResults.filter(r => r.passed).length;
  const totalTests = testResults.length;

  return (
    <>
      {/* Previously Completed Banner - shows when revisiting a completed activity */}
      {isCompleted && (
        <div className="mb-4 flex items-center gap-3 px-4 py-3 bg-emerald-50 border border-emerald-200 rounded-xl">
          <div className="flex-shrink-0 w-8 h-8 bg-emerald-100 rounded-full flex items-center justify-center">
            <CheckCircle2 className="w-5 h-5 text-emerald-600" />
          </div>
          <div>
            <p className="font-medium text-emerald-800">Previously Completed</p>
            <p className="text-sm text-emerald-600">You&apos;ve already solved this challenge. Feel free to practice again.</p>
          </div>
        </div>
      )}
    
    <div className="bg-white rounded-2xl shadow-sm border border-[var(--border)] overflow-hidden relative">
      {/* Celebration Overlay */}
      {showCelebration && (
        <div className="absolute inset-0 z-50 flex items-center justify-center bg-emerald-500/10 backdrop-blur-sm animate-fade-in">
          <div className="bg-white rounded-2xl p-8 shadow-2xl text-center transform animate-bounce-in">
            <div className="w-20 h-20 bg-gradient-to-br from-emerald-400 to-emerald-600 rounded-full flex items-center justify-center mx-auto mb-4 shadow-lg">
              <Trophy className="w-10 h-10 text-white" />
            </div>
            <h2 className="text-2xl font-bold text-emerald-700 mb-2">All Tests Passed!</h2>
            <p className="text-slate-600">Excellent work! Your code works perfectly.</p>
          </div>
        </div>
      )}
      
      {/* Header */}
      <div className="flex items-center justify-between px-6 py-4 border-b border-[var(--border)] bg-slate-50">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-lg bg-amber-100 flex items-center justify-center">
            <Code className="w-5 h-5 text-amber-600" />
          </div>
          <div>
            <h1 className="text-xl font-bold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
              {activity.title}
            </h1>
            <p className="text-sm text-[var(--foreground-muted)]">
              {activity.type === 'challenge' ? 'Challenge' : 'Code Exercise'} - Python
            </p>
          </div>
        </div>
        
        <div className="flex items-center gap-3">
          {testCases.length > 0 && testResults.length > 0 && (
            <div className={`flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-medium ${
              allTestsPassed 
                ? 'bg-emerald-100 text-emerald-700' 
                : 'bg-slate-100 text-slate-600'
            }`}>
              <Target className="w-4 h-4" />
              <span>{passedCount}/{totalTests} Tests</span>
            </div>
          )}
        
        {completed && (
          <div className="flex items-center gap-2 px-3 py-1.5 bg-emerald-100 text-emerald-700 rounded-full">
            <CheckCircle2 className="w-4 h-4" />
            <span className="text-sm font-medium">Completed</span>
          </div>
        )}
        </div>
      </div>
      
      {/* Instructions */}
      {content?.instructions && (
        <div className="px-6 py-4 bg-blue-50 border-b border-blue-100">
          <p className="text-sm text-blue-800 leading-relaxed">{content.instructions}</p>
        </div>
      )}
      
      {/* Code Editor - 60/40 split for larger code area */}
      <div className="grid md:grid-cols-[3fr_2fr] divide-y md:divide-y-0 md:divide-x divide-[var(--border)]">
        {/* Editor Panel - Larger */}
        <div className="flex flex-col">
          <div className="flex items-center justify-between px-4 py-3 bg-slate-800 text-slate-400 text-sm">
            <div className="flex items-center gap-2">
              <FileCode className="w-4 h-4" />
            <span>main.py</span>
            </div>
            <div className="flex items-center gap-3">
              <button
                onClick={resetCode}
                className="p-1.5 hover:text-white transition-colors hover:bg-slate-700 rounded"
                title="Reset code"
              >
                <RotateCcw className="w-4 h-4" />
              </button>
              <button
                onClick={runCode}
                disabled={!pyodideReady || isRunning}
                className="flex items-center gap-1.5 px-5 py-2 bg-emerald-600 text-white text-sm font-medium rounded-lg hover:bg-emerald-500 transition-all disabled:opacity-50 disabled:cursor-not-allowed shadow-sm hover:shadow"
              >
                <Play className="w-4 h-4" />
                {isRunning ? "Running..." : "Run Code"}
              </button>
            </div>
          </div>
          
          <textarea
            ref={textareaRef}
            value={code}
            onChange={(e) => handleCodeChange(e.target.value)}
            onKeyDown={handleKeyDown}
            spellCheck={false}
            className="flex-1 min-h-[450px] p-5 font-mono text-sm bg-slate-900 text-slate-100 resize-none focus:outline-none leading-relaxed"
            placeholder="# Write your Python code here..."
          />
        </div>
        
        {/* Output Panel */}
        <div className="flex flex-col">
          {/* Tabs */}
          <div className="flex items-center bg-slate-100 border-b border-slate-200">
            <button
              onClick={() => setActiveTab('tests')}
              className={`flex items-center gap-2 px-4 py-2.5 text-sm font-medium transition-colors ${
                activeTab === 'tests'
                  ? 'bg-white text-slate-800 border-b-2 border-emerald-500'
                  : 'text-slate-500 hover:text-slate-700'
              }`}
            >
              <Target className="w-4 h-4" />
              Test Results
              {testResults.length > 0 && (
                <span className={`ml-1 px-1.5 py-0.5 rounded text-xs ${
                  allTestsPassed ? 'bg-emerald-100 text-emerald-700' : 'bg-red-100 text-red-700'
                }`}>
                  {passedCount}/{totalTests}
                </span>
              )}
            </button>
            <button
              onClick={() => setActiveTab('output')}
              className={`flex items-center gap-2 px-4 py-2.5 text-sm font-medium transition-colors ${
                activeTab === 'output'
                  ? 'bg-white text-slate-800 border-b-2 border-emerald-500'
                  : 'text-slate-500 hover:text-slate-700'
              }`}
            >
              <Terminal className="w-4 h-4" />
              Console Output
            </button>
            <div className="flex-1" />
            {pyodideLoading && (
              <span className="text-xs text-amber-600 px-4 flex items-center gap-2">
                <Sparkles className="w-3 h-3 animate-pulse" />
                Loading Python...
              </span>
            )}
            {isAIValidating && (
              <span className="text-xs text-blue-600 px-4 flex items-center gap-2">
                <Loader2 className="w-3 h-3 animate-spin" />
                AI Validating...
              </span>
            )}
          </div>
          
          <div className="flex-1 min-h-[450px] overflow-auto">
            {/* Console Output Tab */}
            {activeTab === 'output' && (
              <div className="p-4 font-mono text-sm bg-slate-900 min-h-full">
            {output ? (
                  <pre className="whitespace-pre-wrap text-emerald-400">{output}</pre>
                ) : (
                  <p className="text-slate-500 italic">Run your code to see console output...</p>
                )}
              </div>
            )}
            
            {/* Test Results Tab */}
            {activeTab === 'tests' && (
              <div className="p-4 bg-slate-50 min-h-full">
                {testCases.length === 0 ? (
                  <div className="text-center py-8 text-slate-500">
                    <Target className="w-8 h-8 mx-auto mb-2 opacity-50" />
                    <p>No test cases for this exercise</p>
                    <p className="text-sm mt-1">Run your code to see the output</p>
                  </div>
                ) : testResults.length === 0 ? (
                  <div className="text-center py-8 text-slate-500">
                    <Play className="w-8 h-8 mx-auto mb-2 opacity-50" />
                    <p>Run your code to check tests</p>
                    <p className="text-sm mt-1">{testCases.length} test{testCases.length > 1 ? 's' : ''} waiting</p>
                  </div>
                ) : (
                  <div className="space-y-3">
                    {/* Summary Bar */}
                    <div className={`p-3 rounded-lg flex items-center gap-3 ${
                      allTestsPassed 
                        ? 'bg-emerald-100 border border-emerald-200' 
                        : 'bg-amber-50 border border-amber-200'
                    }`}>
                      {allTestsPassed ? (
                        <>
                          <CheckCircle2 className="w-5 h-5 text-emerald-600" />
                          <span className="font-medium text-emerald-800">All tests passed!</span>
                        </>
                      ) : (
                        <>
                          <AlertCircle className="w-5 h-5 text-amber-600" />
                          <span className="font-medium text-amber-800">
                            {passedCount} of {totalTests} tests passing
                          </span>
                        </>
                      )}
                      
                      {/* Progress bar */}
                      <div className="flex-1 h-2 bg-white/50 rounded-full overflow-hidden ml-2">
                        <div 
                          className={`h-full transition-all duration-500 ${
                            allTestsPassed ? 'bg-emerald-500' : 'bg-amber-500'
                          }`}
                          style={{ width: `${(passedCount / totalTests) * 100}%` }}
                        />
                      </div>
                    </div>
                    
                    {/* P3: Failed Requirements Summary - quick overview of what's failing */}
                    {!allTestsPassed && (
                      <div className="bg-red-50 border border-red-200 rounded-lg p-3">
                        <p className="text-xs font-medium text-red-800 mb-2 flex items-center gap-1.5">
                          <XCircle className="w-3.5 h-3.5" />
                          Requirements Not Met:
                        </p>
                        <ul className="text-xs text-red-700 space-y-1">
                          {testResults
                            .filter(r => !r.passed)
                            .slice(0, 3) // Show max 3 failed tests
                            .map((r, idx) => (
                              <li key={idx} className="flex items-start gap-2">
                                <span className="text-red-400 mt-0.5">-</span>
                                <span>{r.message}</span>
                              </li>
                            ))
                          }
                          {testResults.filter(r => !r.passed).length > 3 && (
                            <li className="text-red-500 italic">
                              + {testResults.filter(r => !r.passed).length - 3} more issues
                            </li>
                          )}
                        </ul>
                        <p className="text-xs text-red-600 mt-2">Click on each test below for detailed explanations</p>
                      </div>
                    )}
                    
                    {/* Individual Tests */}
                <div className="space-y-2">
                  {testResults.map((result, index) => (
                    <div
                      key={index}
                          className={`rounded-lg border overflow-hidden transition-all ${
                            result.isAIValidation && !result.aiResult 
                              ? 'border-blue-200 bg-blue-50' // AI pending
                              : result.passed 
                                ? 'border-emerald-200 bg-emerald-50' 
                                : 'border-red-200 bg-red-50'
                          }`}
                        >
                          {/* Test Header */}
                          <button
                            onClick={() => toggleTestExpanded(index)}
                            className="w-full flex items-center gap-3 p-3 text-left hover:bg-black/5 transition-colors"
                    >
                      {result.isAIValidation && !result.aiResult ? (
                              <Loader2 className="w-5 h-5 text-blue-600 flex-shrink-0 animate-spin" />
                            ) : result.passed ? (
                              <CheckCircle2 className="w-5 h-5 text-emerald-600 flex-shrink-0" />
                            ) : (
                              <XCircle className="w-5 h-5 text-red-600 flex-shrink-0" />
                            )}
                            <span className={`font-medium flex-1 ${
                              result.isAIValidation && !result.aiResult
                                ? 'text-blue-800'
                                : result.passed ? 'text-emerald-800' : 'text-red-800'
                            }`}>
                              {result.isAIValidation && <Bot className="w-4 h-4 inline mr-1.5" />}
                              {result.message}
                              {result.isHidden && (
                                <span className="ml-2 text-xs opacity-60">(Hidden)</span>
                              )}
                            </span>
                            {(result.isAIValidation || !result.passed) && (
                              expandedTests.has(index) 
                                ? <ChevronUp className="w-4 h-4 text-slate-400" />
                                : <ChevronDown className="w-4 h-4 text-slate-400" />
                            )}
                          </button>
                          
                          {/* Test Details (for failed tests or AI validation) */}
                          {((!result.passed || result.isAIValidation) && expandedTests.has(index)) && (
                            <div className="px-3 pb-3 pt-0">
                              <div className={`bg-white rounded-lg p-3 space-y-3 text-sm border ${
                                result.passed ? 'border-emerald-100' : 'border-red-100'
                              }`}>
                                {result.error ? (
                                  <div className="space-y-3">
                                    {/* Raw Error */}
                                    <div>
                                      <span className="text-red-600 font-medium">Error: </span>
                                      <code className="text-red-700 font-mono text-xs bg-red-50 px-1 py-0.5 rounded block mt-1 p-2 whitespace-pre-wrap">
                                        {result.error}
                                      </code>
                                    </div>
                                    
                                    {/* AI Error Explanation */}
                                    {result.isLoadingAIError && (
                                      <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 flex items-center gap-2">
                                        <Loader2 className="w-4 h-4 text-blue-600 animate-spin" />
                                        <span className="text-blue-700 text-sm">AI is analyzing your error...</span>
                                      </div>
                                    )}
                                    
                                    {result.aiErrorExplanation && (
                                      <div className="space-y-2">
                                        {/* Explanation */}
                                        <div className="bg-amber-50 border border-amber-200 rounded-lg p-3">
                                          <div className="flex items-center gap-2 font-medium mb-2 text-amber-800">
                                            <Bot className="w-4 h-4" />
                                            <span>What went wrong?</span>
                                          </div>
                                          <p className="text-sm text-amber-700">
                                            {result.aiErrorExplanation.explanation}
                                          </p>
                                        </div>
                                        
                                        {/* How to fix */}
                                        <div className="bg-emerald-50 border border-emerald-200 rounded-lg p-3">
                                          <div className="flex items-center gap-2 font-medium mb-2 text-emerald-800">
                                            <Lightbulb className="w-4 h-4" />
                                            <span>How to fix it</span>
                                          </div>
                                          <p className="text-sm text-emerald-700">
                                            {result.aiErrorExplanation.fix}
                                          </p>
                                        </div>
                                        
                                        {/* Example if provided */}
                                        {result.aiErrorExplanation.example && (
                                          <div className="bg-slate-50 border border-slate-200 rounded-lg p-3">
                                            <div className="flex items-center gap-2 font-medium mb-2 text-slate-700">
                                              <Code className="w-4 h-4" />
                                              <span>Example</span>
                                            </div>
                                            <pre className="text-xs font-mono bg-slate-900 text-emerald-400 p-2 rounded overflow-x-auto">
                                              {result.aiErrorExplanation.example}
                                            </pre>
                                          </div>
                                        )}
                                      </div>
                                    )}
                                  </div>
                                ) : result.isAIValidation && result.aiResult ? (
                                  /* AI Validation Results */
                                  <div className="space-y-3">
                                    {/* AI Feedback */}
                                    <div className={`rounded-lg p-3 ${
                                      result.passed 
                                        ? 'bg-emerald-50 border border-emerald-200' 
                                        : 'bg-amber-50 border border-amber-200'
                                    }`}>
                                      <div className="flex items-center gap-2 font-medium mb-2">
                                        <MessageSquare className={`w-4 h-4 ${result.passed ? 'text-emerald-600' : 'text-amber-600'}`} />
                                        <span className={result.passed ? 'text-emerald-800' : 'text-amber-800'}>
                                          AI Feedback
                                        </span>
                                        {result.aiResult.score !== undefined && (
                                          <span className={`ml-auto text-xs px-2 py-0.5 rounded-full ${
                                            result.aiResult.score >= 80 
                                              ? 'bg-emerald-100 text-emerald-700' 
                                              : result.aiResult.score >= 50 
                                                ? 'bg-amber-100 text-amber-700' 
                                                : 'bg-red-100 text-red-700'
                                          }`}>
                                            Score: {result.aiResult.score}%
                                          </span>
                                        )}
                                      </div>
                                      <p className={`text-sm ${result.passed ? 'text-emerald-700' : 'text-amber-700'}`}>
                                        {result.aiResult.feedback}
                                      </p>
                                    </div>
                                    
                                    {/* Suggestions */}
                                    {result.aiResult.suggestions && result.aiResult.suggestions.length > 0 && (
                                      <div className="bg-blue-50 border border-blue-200 rounded-lg p-3">
                                        <div className="flex items-center gap-2 font-medium mb-2 text-blue-800">
                                          <ThumbsUp className="w-4 h-4" />
                                          <span>Suggestions</span>
                                        </div>
                                        <ul className="text-sm text-blue-700 space-y-1 list-disc list-inside">
                                          {result.aiResult.suggestions.map((suggestion, idx) => (
                                            <li key={idx}>{suggestion}</li>
                                          ))}
                                        </ul>
                                      </div>
                                    )}
                                    
                                    {/* Issues */}
                                    {result.aiResult.details?.issues && result.aiResult.details.issues.length > 0 && (
                                      <div className="bg-red-50 border border-red-200 rounded-lg p-3">
                                        <div className="flex items-center gap-2 font-medium mb-2 text-red-800">
                                          <AlertCircle className="w-4 h-4" />
                                          <span>Issues to Fix</span>
                                        </div>
                                        <ul className="text-sm text-red-700 space-y-1 list-disc list-inside">
                                          {result.aiResult.details.issues.map((issue, idx) => (
                                            <li key={idx}>{issue}</li>
                                          ))}
                                        </ul>
                                      </div>
                                    )}
                                  </div>
                                ) : (
                                  <>
                                    {/* Match Analysis / Validation Result */}
                                    {result.matchDetails && (
                                      <div className="bg-amber-50 border border-amber-200 rounded-lg p-2.5 text-amber-800 text-xs">
                                        <div className="flex items-center gap-2 font-medium mb-1">
                                          <AlertCircle className="w-3.5 h-3.5" />
                                          <span>{result.expected ? 'Output Analysis' : 'Validation Result'}</span>
                                        </div>
                                        <p>{result.matchDetails.diffDescription}</p>
                                        {result.expected && (
                                          <div className="flex gap-4 mt-1.5 text-amber-700">
                                            <span>Expected: {result.matchDetails.expectedLength} chars</span>
                                            <span>Got: {result.matchDetails.actualLength} chars</span>
                                          </div>
                                        )}
                                      </div>
                                    )}
                                    
                                    {/* Side by side comparison - only for output comparison tests */}
                                    {result.expected ? (
                                      <div className="grid grid-cols-2 gap-2">
                                        <div>
                                          <div className="flex items-center gap-1.5 text-emerald-700 font-medium text-xs mb-1.5">
                                            <CheckCircle2 className="w-3 h-3" />
                                            Expected Output
                                          </div>
                                          <pre className="font-mono text-emerald-700 bg-emerald-50 border border-emerald-200 p-2.5 rounded text-xs whitespace-pre-wrap break-all min-h-[60px]">
                                            {result.expected}
                                          </pre>
                                        </div>
                                        <div>
                                          <div className="flex items-center gap-1.5 text-red-700 font-medium text-xs mb-1.5">
                                            <XCircle className="w-3 h-3" />
                                            Your Output
                                          </div>
                                          <pre className="font-mono text-red-700 bg-red-50 border border-red-200 p-2.5 rounded text-xs whitespace-pre-wrap break-all min-h-[60px]">
                                            {result.actual || '(empty)'}
                                          </pre>
                                        </div>
                                      </div>
                                    ) : (
                                      /* Validation test - just show actual output */
                                      <div>
                                        <div className="flex items-center gap-1.5 text-slate-700 font-medium text-xs mb-1.5">
                                          <Terminal className="w-3 h-3" />
                                          Your Output
                                        </div>
                                        <pre className="font-mono text-slate-700 bg-slate-50 border border-slate-200 p-2.5 rounded text-xs whitespace-pre-wrap break-all min-h-[60px]">
                                          {result.actual || '(no output)'}
                                        </pre>
                                      </div>
                                    )}
                                    
                                    {/* Character-by-character diff highlight */}
                                    {result.matchDetails && result.matchDetails.firstDiffIndex >= 0 && result.expected && result.actual && (
                                      <div className="bg-slate-50 border border-slate-200 rounded-lg p-2.5 text-xs">
                                        <div className="font-medium text-slate-700 mb-2">Character Comparison</div>
                                        <div className="font-mono flex flex-wrap gap-0.5">
                                          {result.expected.split('').map((char, i) => {
                                            const actualChar = result.actual?.[i];
                                            const isMatch = char === actualChar;
                                            const isFirstDiff = i === result.matchDetails?.firstDiffIndex;
                                            return (
                                              <span
                                                key={i}
                                                className={`px-1 py-0.5 rounded ${
                                                  isFirstDiff
                                                    ? 'bg-red-500 text-white ring-2 ring-red-300'
                                                    : isMatch
                                                      ? 'bg-emerald-100 text-emerald-700'
                                                      : 'bg-red-100 text-red-700'
                                                }`}
                                                title={`Position ${i + 1}: expected "${char === ' ' ? 'space' : char === '\n' ? '\\n' : char}"`}
                                              >
                                                {char === ' ' ? '\u00B7' : char === '\n' ? '\u21B5' : char}
                                              </span>
                                            );
                                          })}
                                        </div>
                                        <div className="mt-2 text-slate-500">
                                          <span className="inline-block w-3 h-3 bg-emerald-100 rounded mr-1"></span> Match
                                          <span className="inline-block w-3 h-3 bg-red-100 rounded ml-3 mr-1"></span> Mismatch
                                          <span className="inline-block w-3 h-3 bg-red-500 rounded ml-3 mr-1"></span> First difference
                                        </div>
                                      </div>
                                    )}
                                  </>
                                )}
                              </div>
                            </div>
                          )}
                    </div>
                  ))}
                </div>
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      </div>
      
      {/* Hints Section - Only shown when hints are available */}
      {hints.length > 0 && (
        <div className="px-6 py-3 border-t border-[var(--border)] bg-slate-50">
          <button
            onClick={() => setShowHints(!showHints)}
            className="flex items-center gap-2 text-sm text-amber-600 hover:text-amber-700 transition-colors"
          >
            <Lightbulb className="w-4 h-4" />
            {showHints ? 'Hide Hint' : 'Need a hint?'}
          </button>
          
          {/* Hints Display */}
          {showHints && (
            <div className="mt-3 p-4 bg-amber-50 border border-amber-200 rounded-xl">
              <p className="text-sm text-amber-800">
                <strong>Hint {currentHint + 1}:</strong> {hints[currentHint]}
              </p>
              <div className="mt-2 flex items-center justify-between">
                {hints.length > 1 && (
                  <div className="flex gap-2">
                    <button
                      onClick={() => setCurrentHint(prev => Math.max(0, prev - 1))}
                      disabled={currentHint === 0}
                      className="text-xs text-amber-600 hover:text-amber-700 disabled:opacity-50"
                    >
                      Previous
                    </button>
                    <button
                      onClick={() => setCurrentHint(prev => Math.min(hints.length - 1, prev + 1))}
                      disabled={currentHint >= hints.length - 1}
                      className="text-xs text-amber-600 hover:text-amber-700 disabled:opacity-50"
                    >
                      Next Hint
                    </button>
                  </div>
                )}
                
                {/* P3: Progressive hints - Ask Bob for more help after exhausting built-in hints */}
                {currentHint >= hints.length - 1 && (
                  <button
                    onClick={() => chatContext.triggerPopup(
                      "I can help explain this concept in more detail. Want to chat?",
                      "help"
                    )}
                    className="flex items-center gap-1.5 px-3 py-1.5 text-xs bg-violet-100 text-violet-700 rounded-full hover:bg-violet-200 transition-colors"
                  >
                    <Bot className="w-3.5 h-3.5" />
                    Still stuck? Ask Bob
                  </button>
                )}
              </div>
            </div>
          )}
        </div>
      )}
    </div>
    </>
  );
}

