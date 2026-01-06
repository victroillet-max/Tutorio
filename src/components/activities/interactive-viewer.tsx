"use client";

import { useState, useEffect, useCallback } from "react";
import { CheckCircle2, Sparkles, RotateCcw, ChevronRight, GripVertical, MousePointerClick, BookOpen, Lightbulb, ArrowRight, X, Plus, Trash2, Calculator, HelpCircle, Check, AlertCircle } from "lucide-react";
import type { Activity } from "@/lib/database.types";
import { markActivityComplete, trackActivityView } from "@/lib/activities/actions";
import { SpreadsheetExerciseViewer } from "./spreadsheet-exercise-viewer";
import { InteractiveErrorBoundary } from "./interactive-error-boundary";
import { InterestCalculator, PercentageCalculator, EquationSolver, GraphInterpretation } from "./math-interactives";

interface InteractiveViewerProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
}

export function InteractiveViewer({ activity, userId, isCompleted }: InteractiveViewerProps) {
  const [completed, setCompleted] = useState(isCompleted);
  const [isMarking, setIsMarking] = useState(false);

  // Track activity view when component mounts
  useEffect(() => {
    trackActivityView(activity.id).catch(console.error);
  }, [activity.id]);

  const interactiveType = activity.interactive_type;
  const content = activity.content as Record<string, unknown> | null;

  async function handleComplete() {
    if (completed || isMarking) return;
    setIsMarking(true);
    
    try {
      await markActivityComplete(activity.id, 100);
      setCompleted(true);
    } catch (error) {
      console.error("Failed to mark activity complete:", error);
    } finally {
      setIsMarking(false);
    }
  }

  // Render specific interactive component based on type
  const renderInteractive = () => {
    switch (interactiveType) {
      case 'drag-drop-match':
        return <DragDropMatch content={content} onComplete={handleComplete} completed={completed} />;
      case 'decomposition-builder':
      case 'tree-builder':
        return <TreeBuilder content={content} onComplete={handleComplete} completed={completed} />;
      case 'pattern-game':
        return <PatternGame content={content} onComplete={handleComplete} completed={completed} />;
      case 'filter-essential':
        return <FilterEssential content={content} onComplete={handleComplete} completed={completed} />;
      case 'timed-classification':
        return <TimedClassification content={content} onComplete={handleComplete} completed={completed} />;
      case 'journal-entry-builder':
        return <JournalEntryBuilder content={content} onComplete={handleComplete} completed={completed} />;
      case 'equation-analyzer':
        return <EquationAnalyzer content={content} onComplete={handleComplete} completed={completed} />;
      case 'trial-balance-builder':
        return <TrialBalanceBuilder content={content} onComplete={handleComplete} completed={completed} />;
      case 'adjusting-entries-builder':
        return <AdjustingEntriesBuilder content={content} onComplete={handleComplete} completed={completed} />;
      case 'cfs-classifier':
        return <CFSClassifier content={content} onComplete={handleComplete} completed={completed} />;
      case 'inventory-calculator':
        return <InventoryCalculator content={content} onComplete={handleComplete} completed={completed} />;
      case 'mock-exam':
        return <MockExamViewer content={content} onComplete={handleComplete} completed={completed} />;
      case 'review-calculator':
        return <ReviewCalculator content={content} onComplete={handleComplete} completed={completed} />;
      case 'google-sheets':
      case 'spreadsheet':
      case 'cfs-builder':
      case 'statement-builder':
        return <SpreadsheetExerciseViewer activity={activity} userId={userId} isCompleted={completed} onComplete={handleComplete} />;
      // Math-specific interactives
      case 'interest-calculator':
        return <InterestCalculator content={content} onComplete={handleComplete} completed={completed} />;
      case 'percentage-calculator':
        return <PercentageCalculator content={content} onComplete={handleComplete} completed={completed} />;
      case 'equation-solver':
        return <EquationSolver content={content} onComplete={handleComplete} completed={completed} />;
      case 'graph-interpretation':
        return <GraphInterpretation content={content} onComplete={handleComplete} completed={completed} />;
      default:
        return <PlaceholderInteractive type={interactiveType} onComplete={handleComplete} completed={completed} />;
    }
  };

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
            <p className="text-sm text-emerald-600">You&apos;ve already completed this exercise. Feel free to practice again.</p>
          </div>
        </div>
      )}
    
    <div className="bg-white rounded-2xl shadow-sm border border-[var(--border)] overflow-hidden">
      {/* Header */}
      <div className="flex items-center justify-between px-6 py-4 border-b border-[var(--border)] bg-slate-50">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-lg bg-violet-100 flex items-center justify-center">
            <Sparkles className="w-5 h-5 text-violet-600" />
          </div>
          <div>
            <h1 className="text-xl font-bold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
              {activity.title}
            </h1>
            <p className="text-sm text-[var(--foreground-muted)]">
              Interactive Exercise
            </p>
          </div>
        </div>
        
        {completed && (
          <div className="flex items-center gap-2 px-3 py-1.5 bg-emerald-100 text-emerald-700 rounded-full">
            <CheckCircle2 className="w-4 h-4" />
            <span className="text-sm font-medium">Completed</span>
          </div>
        )}
      </div>
      
      {/* Content */}
      <div className="p-6 sm:p-8">
        <InteractiveErrorBoundary interactiveType={interactiveType}>
          {renderInteractive()}
        </InteractiveErrorBoundary>
      </div>
      
      {/* Footer - Single action button */}
      <div className="px-6 py-4 border-t border-[var(--border)] bg-slate-50">
        <div className="flex justify-end">
          {completed ? (
            <div className="flex items-center gap-2 text-emerald-600">
              <CheckCircle2 className="w-5 h-5" />
              <span className="font-medium">Exercise Complete</span>
            </div>
          ) : (
            <button
              onClick={handleComplete}
              disabled={isMarking}
              className="flex items-center gap-2 px-6 py-3 bg-violet-600 text-white font-semibold rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50"
            >
              {isMarking ? "Saving..." : "Complete Exercise"}
              <ChevronRight className="w-4 h-4" />
            </button>
          )}
        </div>
      </div>
    </div>
    </>
  );
}

// Drag and Drop Match Component
interface DragDropMatchProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface MatchPair {
  left: string;
  right: string;
  explanation?: string;
}

function DragDropMatch({ content, onComplete, completed }: DragDropMatchProps) {
  const pairs = (content?.pairs as MatchPair[]) || [];
  const instructions = (content?.instructions as string) || "Match the items on the left with their corresponding items on the right.";
  
  // Create a stable shuffled version of right items - only shuffle on client after mount
  const [shuffledRightItems, setShuffledRightItems] = useState<{ text: string; originalIndex: number }[]>([]);
  const [isClient, setIsClient] = useState(false);
  
  // Shuffle on client side only to avoid hydration mismatch
  useEffect(() => {
    setIsClient(true);
    if (pairs.length > 0) {
      const shuffled = pairs
        .map((pair, index) => ({ text: pair.right, originalIndex: index }))
        .sort(() => Math.random() - 0.5);
      setShuffledRightItems(shuffled);
    }
  }, [pairs]);
  
  // Track which left item is matched to which shuffled right index
  // Key: left index, Value: shuffled right index
  const [matches, setMatches] = useState<Record<number, number>>({});
  const [draggedLeftIndex, setDraggedLeftIndex] = useState<number | null>(null);
  const [showResults, setShowResults] = useState(false);
  const [score, setScore] = useState<number | null>(null);
  
  // Find which left item is matched to a given shuffled right index
  const getMatchedLeftIndex = (shuffledRightIndex: number): number | null => {
    for (const [leftIdx, rightIdx] of Object.entries(matches)) {
      if (rightIdx === shuffledRightIndex) {
        return parseInt(leftIdx);
      }
    }
    return null;
  };
  
  const handleDragStart = (leftIndex: number) => {
    if (completed || showResults) return;
    setDraggedLeftIndex(leftIndex);
  };
  
  const handleDrop = (shuffledRightIndex: number) => {
    if (draggedLeftIndex === null || completed || showResults) return;
    
    // Remove any existing match for this left item
    const newMatches = { ...matches };
    
    // Also remove any other left item that was matched to this right slot
    for (const [leftIdx, rightIdx] of Object.entries(newMatches)) {
      if (rightIdx === shuffledRightIndex) {
        delete newMatches[parseInt(leftIdx)];
      }
    }
    
    // Add the new match
    newMatches[draggedLeftIndex] = shuffledRightIndex;
    setMatches(newMatches);
    setDraggedLeftIndex(null);
  };
  
  const handleCheckAnswers = () => {
    if (Object.keys(matches).length !== pairs.length) return;
    
    let correctCount = 0;
    pairs.forEach((pair, leftIndex) => {
      const matchedShuffledIndex = matches[leftIndex];
      if (matchedShuffledIndex !== undefined) {
        const matchedRightItem = shuffledRightItems[matchedShuffledIndex];
        // Check if the right answer matches the expected right for this left
        if (matchedRightItem.text === pair.right) {
          correctCount++;
        }
      }
    });
    
    const scorePercent = Math.round((correctCount / pairs.length) * 100);
    setScore(scorePercent);
    setShowResults(true);
    
    if (scorePercent >= 60) {
      onComplete();
    }
  };
  
  const handleReset = () => {
    setMatches({});
    setShowResults(false);
    setScore(null);
  };
  
  // Check if a match is correct (for showing results)
  const isMatchCorrect = (leftIndex: number): boolean | null => {
    if (!showResults) return null;
    const matchedShuffledIndex = matches[leftIndex];
    if (matchedShuffledIndex === undefined) return false;
    const matchedRightItem = shuffledRightItems[matchedShuffledIndex];
    return matchedRightItem.text === pairs[leftIndex].right;
  };
  
  const allMatched = Object.keys(matches).length === pairs.length;
  
  // Show loading state until client-side shuffle is complete
  if (!isClient || shuffledRightItems.length === 0) {
    return (
      <div className="text-center py-8">
        <div className="animate-pulse">
          <div className="h-4 bg-slate-200 rounded w-3/4 mx-auto mb-4"></div>
          <div className="h-32 bg-slate-100 rounded mb-4"></div>
          <div className="h-32 bg-slate-100 rounded"></div>
        </div>
      </div>
    );
  }
  
  return (
    <div>
      <p className="text-[var(--foreground-muted)] mb-6">{instructions}</p>
      
      {/* U5: Add interaction hint at the top */}
      {!showResults && !completed && (
        <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)] mb-4 p-3 bg-violet-50 border border-violet-100 rounded-lg">
          <GripVertical className="w-4 h-4 text-violet-500" />
          <span>Drag items from the left and drop them onto matching items on the right</span>
        </div>
      )}
      
      <div className="grid md:grid-cols-2 gap-8">
        {/* Left items (draggable) */}
        <div className="space-y-3">
          <p className="text-sm font-medium text-[var(--foreground-muted)] mb-2">Scenarios</p>
          {pairs.map((pair, leftIndex) => {
            const isMatched = matches[leftIndex] !== undefined;
            const matchResult = isMatchCorrect(leftIndex);
            
            let borderClass = 'border-[var(--border)] hover:border-violet-300';
            if (draggedLeftIndex === leftIndex) {
              borderClass = 'border-violet-500 bg-violet-50';
            } else if (showResults && matchResult === true) {
              borderClass = 'border-emerald-500 bg-emerald-50';
            } else if (showResults && matchResult === false) {
              borderClass = 'border-red-500 bg-red-50';
            } else if (isMatched) {
              borderClass = 'border-violet-400 bg-violet-50';
            }
            
            return (
              <div
                key={leftIndex}
                draggable={!completed && !showResults}
                onDragStart={() => handleDragStart(leftIndex)}
                onDragEnd={() => setDraggedLeftIndex(null)}
                className={`
                  p-4 rounded-xl border-2 transition-all text-sm
                  ${!completed && !showResults ? 'cursor-grab active:cursor-grabbing' : 'cursor-default'}
                  ${borderClass}
                `}
              >
                <div className="flex items-start gap-2">
                  {/* U5: Add drag handle icon as visual cue */}
                  {!completed && !showResults && (
                    <GripVertical className="w-4 h-4 text-slate-400 flex-shrink-0 mt-0.5" />
                  )}
                  <span className="flex-1">{pair.left}</span>
                  {showResults && matchResult !== null && (
                    <span className={matchResult ? 'text-emerald-600' : 'text-red-600'}>
                      {matchResult ? <CheckCircle2 className="w-5 h-5" /> : 'X'}
                    </span>
                  )}
                </div>
                {showResults && !matchResult && (
                  <p className="text-xs text-[var(--foreground-muted)] mt-2 italic">
                    Correct: {pair.right}
                  </p>
                )}
              </div>
            );
          })}
        </div>
        
        {/* Right items (drop zones) */}
        <div className="space-y-3">
          <p className="text-sm font-medium text-[var(--foreground-muted)] mb-2">CT Pillars</p>
          {shuffledRightItems.map((item, shuffledIndex) => {
            const matchedLeftIndex = getMatchedLeftIndex(shuffledIndex);
            const hasMatch = matchedLeftIndex !== null;
            
            return (
              <div
                key={shuffledIndex}
                onDragOver={(e) => {
                  if (!completed && !showResults) {
                    e.preventDefault();
                  }
                }}
                onDrop={() => handleDrop(shuffledIndex)}
                className={`
                  p-4 rounded-xl border-2 border-dashed transition-all
                  ${hasMatch ? 'border-violet-400 bg-violet-50' : 'border-slate-300'}
                  ${!completed && !showResults && draggedLeftIndex !== null ? 'hover:border-violet-500 hover:bg-violet-50' : ''}
                `}
              >
                <div className="flex items-center gap-2">
                  <span className="font-medium text-violet-700">{item.text}</span>
                  {/* U5: Show drop target indicator when dragging */}
                  {!hasMatch && !completed && !showResults && draggedLeftIndex !== null && (
                    <MousePointerClick className="w-4 h-4 text-violet-400 animate-pulse" />
                  )}
                </div>
                {hasMatch && (
                  <p className="text-xs text-[var(--foreground-muted)] mt-1 truncate">
                    Matched with scenario {matchedLeftIndex + 1}
                  </p>
                )}
              </div>
            );
          })}
        </div>
      </div>
      
      {/* Actions */}
      {!completed && !showResults && (
        <div className="mt-6 flex items-center justify-between">
          <p className="text-sm text-[var(--foreground-muted)]">
            {Object.keys(matches).length} / {pairs.length} matched
          </p>
          <button
            onClick={handleCheckAnswers}
            disabled={!allMatched}
            className="px-6 py-2.5 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Check Answers
          </button>
        </div>
      )}
      
      {/* Results */}
      {showResults && (
        <div className={`mt-6 p-4 rounded-xl border ${score !== null && score >= 60 ? 'bg-emerald-50 border-emerald-200' : 'bg-amber-50 border-amber-200'}`}>
          <div className="flex items-center justify-between">
            <div>
              <p className={`font-medium ${score !== null && score >= 60 ? 'text-emerald-700' : 'text-amber-700'}`}>
                Score: {score}%
              </p>
              <p className="text-sm text-[var(--foreground-muted)]">
                {score !== null && score >= 60 ? 'Great job! You passed!' : 'Keep practicing! You need 60% to pass.'}
              </p>
            </div>
            {score !== null && score < 60 && (
              <button
                onClick={handleReset}
                className="flex items-center gap-2 px-4 py-2 text-amber-700 hover:bg-amber-100 rounded-lg transition-colors"
              >
                <RotateCcw className="w-4 h-4" />
                Try Again
              </button>
            )}
          </div>
        </div>
      )}
      
      {completed && !showResults && (
        <div className="mt-6 p-4 bg-emerald-50 border border-emerald-200 rounded-xl text-center">
          <p className="text-emerald-700 font-medium">Exercise completed!</p>
        </div>
      )}
    </div>
  );
}

// Tree Builder Component
interface TreeBuilderProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

function TreeBuilder({ content, onComplete, completed }: TreeBuilderProps) {
  const instructions = (content?.instructions as string) || "Build a decomposition tree by adding branches.";
  const rootTask = (content?.rootTask as string) || "Main Task";
  // U4: Get expected branches for validation (if provided in content)
  const expectedBranches = (content?.expectedBranches as string[]) || [];
  const suggestedBranches = (content?.suggestedBranches as string[]) || [];
  const minBranches = (content?.minBranches as number) || 4;
  
  const [branches, setBranches] = useState<string[]>([]);
  const [newBranch, setNewBranch] = useState("");
  const [showSuggestions, setShowSuggestions] = useState(false);
  
  const addBranch = (branchText?: string) => {
    const text = branchText || newBranch;
    if (text.trim()) {
      // Don't add duplicates
      if (branches.some(b => b.toLowerCase() === text.trim().toLowerCase())) {
        return;
      }
      const newBranches = [...branches, text.trim()];
      setBranches(newBranches);
      setNewBranch("");
      
      // U4: Validate against expected branches if provided, otherwise check count
      if (expectedBranches.length > 0) {
        // Check if enough expected branches are included
        const matchedCount = newBranches.filter(b => 
          expectedBranches.some(exp => 
            exp.toLowerCase().includes(b.toLowerCase()) || 
            b.toLowerCase().includes(exp.toLowerCase())
          )
        ).length;
        if (matchedCount >= Math.min(expectedBranches.length, minBranches) && !completed) {
          onComplete();
        }
      } else if (newBranches.length >= minBranches && !completed) {
        onComplete();
      }
    }
  };
  
  const removeBranch = (index: number) => {
    setBranches(prev => prev.filter((_, i) => i !== index));
  };
  
  // Filter suggestions to show only unused ones
  const availableSuggestions = suggestedBranches.filter(s => 
    !branches.some(b => b.toLowerCase() === s.toLowerCase())
  );
  
  return (
    <div>
      <p className="text-[var(--foreground-muted)] mb-6">{instructions}</p>
      
      {/* Tree visualization */}
      <div className="flex flex-col items-center">
        {/* Root */}
        <div className="px-6 py-3 bg-violet-600 text-white font-medium rounded-xl shadow-lg">
          {rootTask}
        </div>
        
        {/* Connector */}
        {branches.length > 0 && (
          <div className="w-0.5 h-8 bg-slate-300" />
        )}
        
        {/* Branches */}
        {branches.length > 0 && (
          <div className="flex flex-wrap justify-center gap-4 max-w-2xl">
            {branches.map((branch, index) => (
              <div key={index} className="flex flex-col items-center">
                <div className="w-0.5 h-4 bg-slate-300" />
                <div className="relative px-4 py-2 bg-violet-100 text-violet-800 rounded-lg">
                  {branch}
                  {!completed && (
                    <button
                      onClick={() => removeBranch(index)}
                      className="absolute -top-1 -right-1 w-5 h-5 bg-red-500 text-white rounded-full text-xs hover:bg-red-600"
                    >
                      x
                    </button>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}
        
        {/* Add branch input */}
        {!completed && (
          <div className="mt-8 space-y-3">
            <div className="flex gap-2">
              <input
                type="text"
                value={newBranch}
                onChange={(e) => setNewBranch(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && addBranch()}
                placeholder="Add a sub-task..."
                className="px-4 py-2 border border-[var(--border)] rounded-lg focus:outline-none focus:ring-2 focus:ring-violet-500"
              />
              <button
                onClick={() => addBranch()}
                className="px-4 py-2 bg-violet-600 text-white rounded-lg hover:bg-violet-700 transition-colors"
              >
                Add
              </button>
            </div>
            
            {/* U4: Suggestion chips for guidance */}
            {availableSuggestions.length > 0 && (
              <div className="text-center">
                <button 
                  onClick={() => setShowSuggestions(!showSuggestions)}
                  className="text-sm text-violet-600 hover:text-violet-700 underline"
                >
                  {showSuggestions ? 'Hide suggestions' : 'Need ideas? Click for suggestions'}
                </button>
                {showSuggestions && (
                  <div className="flex flex-wrap justify-center gap-2 mt-2">
                    {availableSuggestions.map((suggestion, idx) => (
                      <button
                        key={idx}
                        onClick={() => addBranch(suggestion)}
                        className="px-3 py-1 text-sm bg-violet-50 text-violet-700 border border-violet-200 rounded-full hover:bg-violet-100 transition-colors"
                      >
                        + {suggestion}
                      </button>
                    ))}
                  </div>
                )}
              </div>
            )}
          </div>
        )}
        
        <p className="mt-4 text-sm text-[var(--foreground-muted)]">
          {branches.length}/5 branches added
        </p>
      </div>
    </div>
  );
}

// Pattern Game Component
interface PatternGameProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

function PatternGame({ content, onComplete, completed }: PatternGameProps) {
  const sequences = (content?.sequences as { items: (number | string)[]; answer: number | string; hint?: string }[]) || [];
  const instructions = (content?.instructions as string) || "Find the pattern and predict the next element.";
  
  const [currentSeq, setCurrentSeq] = useState(0);
  const [userAnswer, setUserAnswer] = useState("");
  const [feedback, setFeedback] = useState<"correct" | "wrong" | null>(null);
  const [showHint, setShowHint] = useState(false);
  
  const sequence = sequences[currentSeq];
  
  const checkAnswer = () => {
    if (!sequence) return;
    
    const correct = String(sequence.answer) === userAnswer.trim();
    setFeedback(correct ? "correct" : "wrong");
    
    if (correct) {
      setTimeout(() => {
        if (currentSeq < sequences.length - 1) {
          setCurrentSeq(prev => prev + 1);
          setUserAnswer("");
          setFeedback(null);
          setShowHint(false);
        } else {
          onComplete();
        }
      }, 1000);
    }
  };
  
  if (!sequence) {
    return <div>No sequences available.</div>;
  }
  
  return (
    <div>
      <p className="text-[var(--foreground-muted)] mb-6">{instructions}</p>
      
      <div className="text-center">
        <p className="text-sm text-[var(--foreground-muted)] mb-4">
          Sequence {currentSeq + 1} of {sequences.length}
        </p>
        
        {/* Sequence display */}
        <div className="flex items-center justify-center gap-3 mb-8">
          {sequence.items.map((item, index) => (
            <div
              key={index}
              className="w-14 h-14 flex items-center justify-center bg-violet-100 text-violet-800 font-bold text-xl rounded-lg"
            >
              {item}
            </div>
          ))}
          <div className="w-14 h-14 flex items-center justify-center border-2 border-dashed border-violet-300 rounded-lg">
            <span className="text-2xl text-violet-300">?</span>
          </div>
        </div>
        
        {/* Input */}
        <div className="flex items-center justify-center gap-3">
          <input
            type="text"
            value={userAnswer}
            onChange={(e) => setUserAnswer(e.target.value)}
            onKeyDown={(e) => e.key === 'Enter' && checkAnswer()}
            placeholder="Your answer"
            className={`
              w-32 px-4 py-3 text-center text-xl font-bold border-2 rounded-lg focus:outline-none
              ${feedback === 'correct' ? 'border-emerald-500 bg-emerald-50' : ''}
              ${feedback === 'wrong' ? 'border-red-500 bg-red-50' : ''}
              ${!feedback ? 'border-[var(--border)] focus:border-violet-500' : ''}
            `}
            disabled={feedback === 'correct'}
          />
          <button
            onClick={checkAnswer}
            disabled={!userAnswer.trim() || feedback === 'correct'}
            className="px-6 py-3 bg-violet-600 text-white font-medium rounded-lg hover:bg-violet-700 transition-colors disabled:opacity-50"
          >
            Check
          </button>
        </div>
        
        {/* Hint */}
        {sequence.hint && (
          <button
            onClick={() => setShowHint(true)}
            className="mt-4 text-sm text-violet-600 hover:underline"
          >
            Need a hint?
          </button>
        )}
        
        {showHint && sequence.hint && (
          <p className="mt-2 text-sm text-amber-600">{sequence.hint}</p>
        )}
        
        {/* Feedback */}
        {feedback === 'wrong' && (
          <p className="mt-4 text-red-600">Not quite. Try again!</p>
        )}
      </div>
    </div>
  );
}

// Filter Essential Component
interface FilterEssentialProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface FilterScenarioItem {
  text: string;
  category: 'essential' | 'abstract';
  explanation: string;
}

interface FilterScenario {
  context: string;
  items: FilterScenarioItem[];
}

function FilterEssential({ content, onComplete, completed }: FilterEssentialProps) {
  const scenarios = (content?.scenarios as FilterScenario[]) || [];
  const instructions = (content?.instructions as string) || "Identify which details are essential and which can be abstracted away.";
  
  const [currentScenarioIndex, setCurrentScenarioIndex] = useState(0);
  const scenario = scenarios[currentScenarioIndex];
  
  // Shuffle items on client side only to avoid hydration mismatch
  const [shuffledItems, setShuffledItems] = useState<FilterScenarioItem[]>([]);
  const [isClient, setIsClient] = useState(false);
  
  useEffect(() => {
    setIsClient(true);
    if (scenario?.items) {
      const shuffled = [...scenario.items].sort(() => Math.random() - 0.5);
      setShuffledItems(shuffled);
    }
  }, [currentScenarioIndex, scenario?.items]);
  
  const [selectedEssential, setSelectedEssential] = useState<Set<string>>(new Set());
  const [showResult, setShowResult] = useState(false);
  const [score, setScore] = useState<number | null>(null);
  
  if (!scenario) {
    return (
      <div className="text-center p-6">
        <AlertCircle className="w-12 h-12 text-amber-500 mx-auto mb-4" />
        <p className="text-[var(--foreground-muted)] mb-2">No scenarios available for this activity.</p>
        <p className="text-xs text-slate-400">
          Content keys: {content ? Object.keys(content).join(', ') : 'none'}
        </p>
      </div>
    );
  }
  
  // Show loading state until client shuffle is complete
  if (!isClient || shuffledItems.length === 0) {
    return (
      <div className="text-center py-8">
        <div className="animate-pulse">
          <div className="h-4 bg-slate-200 rounded w-3/4 mx-auto mb-4"></div>
          <div className="h-20 bg-slate-100 rounded mb-4"></div>
          <div className="flex flex-wrap gap-3 justify-center">
            {[1,2,3,4,5].map(i => (
              <div key={i} className="h-10 w-24 bg-slate-100 rounded-lg"></div>
            ))}
          </div>
        </div>
      </div>
    );
  }
  
  // Use shuffled items
  const items = shuffledItems;
  
  const toggleItem = (item: string) => {
    if (showResult) return;
    
    setSelectedEssential(prev => {
      const newSet = new Set(prev);
      if (newSet.has(item)) {
        newSet.delete(item);
      } else {
        newSet.add(item);
      }
      return newSet;
    });
  };
  
  const checkAnswers = () => {
    setShowResult(true);
    
    // Calculate score
    let correctCount = 0;
    items.forEach(item => {
      const isSelected = selectedEssential.has(item.text);
      const shouldBeSelected = item.category === 'essential';
      if (isSelected === shouldBeSelected) {
        correctCount++;
      }
    });
    
    const scorePercent = Math.round((correctCount / items.length) * 100);
    setScore(scorePercent);
    
    if (scorePercent >= 60) {
      onComplete();
    }
  };
  
  const handleNextScenario = () => {
    if (currentScenarioIndex < scenarios.length - 1) {
      setCurrentScenarioIndex(prev => prev + 1);
      setSelectedEssential(new Set());
      setShowResult(false);
      setScore(null);
    }
  };
  
  const handleReset = () => {
    setSelectedEssential(new Set());
    setShowResult(false);
    setScore(null);
  };
  
  return (
    <div>
      <p className="text-[var(--foreground-muted)] mb-4">{instructions}</p>
      
      {/* Progress indicator */}
      {scenarios.length > 1 && (
        <p className="text-sm text-[var(--foreground-muted)] mb-4">
          Scenario {currentScenarioIndex + 1} of {scenarios.length}
        </p>
      )}
      
      <div className="p-4 bg-blue-50 border border-blue-200 rounded-xl mb-6">
        <p className="font-medium text-blue-800">{scenario.context}</p>
      </div>
      
      <p className="text-sm text-[var(--foreground-muted)] mb-4">
        Click on items that are <strong>essential</strong>:
      </p>
      
      <div className="flex flex-wrap gap-3 mb-6">
        {items.map((item) => {
          const isSelected = selectedEssential.has(item.text);
          const isEssential = item.category === 'essential';
          
          let bgClass = 'bg-slate-100 hover:bg-slate-200';
          if (showResult) {
            if (isEssential && isSelected) bgClass = 'bg-emerald-100 border-emerald-500';
            else if (isEssential && !isSelected) bgClass = 'bg-amber-100 border-amber-500';
            else if (!isEssential && isSelected) bgClass = 'bg-red-100 border-red-500';
            else bgClass = 'bg-slate-100';
          } else if (isSelected) {
            bgClass = 'bg-violet-100 border-violet-500';
          }
          
          return (
            <button
              key={item.text}
              onClick={() => toggleItem(item.text)}
              disabled={showResult}
              className={`px-4 py-2 rounded-lg border-2 transition-all ${bgClass} ${showResult ? '' : 'cursor-pointer'}`}
            >
              {item.text}
            </button>
          );
        })}
      </div>
      
      {!showResult ? (
        <button
          onClick={checkAnswers}
          disabled={selectedEssential.size === 0}
          className="px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50"
        >
          Check Answers
        </button>
      ) : (
        <div className={`p-4 rounded-xl ${score !== null && score >= 60 ? 'bg-emerald-50 border border-emerald-200' : 'bg-amber-50 border border-amber-200'}`}>
          <div className="flex items-center justify-between mb-3">
            <div>
              <p className={`font-medium ${score !== null && score >= 60 ? 'text-emerald-700' : 'text-amber-700'}`}>
                Score: {score}%
              </p>
              <p className="text-sm text-[var(--foreground-muted)]">
                {score !== null && score >= 60 ? 'Great job!' : 'You need 60% to pass.'}
              </p>
            </div>
            {score !== null && score < 60 && (
              <button
                onClick={handleReset}
                className="flex items-center gap-2 px-4 py-2 text-amber-700 hover:bg-amber-100 rounded-lg transition-colors"
              >
                <RotateCcw className="w-4 h-4" />
                Try Again
              </button>
            )}
          </div>
          
          <div className="text-sm text-[var(--foreground-muted)]">
            <span className="text-emerald-600">Green</span> = Correctly identified as essential |{' '}
            <span className="text-amber-600">Yellow</span> = Missed essential |{' '}
            <span className="text-red-600">Red</span> = Incorrectly selected
          </div>
          
          {/* Show explanations */}
          {showResult && (
            <div className="mt-4 space-y-2">
              <p className="font-medium text-sm">Explanations:</p>
              {items.map((item) => {
                const isSelected = selectedEssential.has(item.text);
                const isCorrect = (item.category === 'essential') === isSelected;
                if (!isCorrect && item.explanation) {
                  return (
                    <p key={item.text} className="text-xs text-[var(--foreground-muted)]">
                      <strong>{item.text}</strong>: {item.explanation}
                    </p>
                  );
                }
                return null;
              })}
            </div>
          )}
        </div>
      )}
    </div>
  );
}

// Timed Classification Component (Exercise 1.9)
interface TimedClassificationProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface ClassificationScenario {
  scenario: string;
  correctPillar: string;
  explanation: string;
}

function TimedClassification({ content, onComplete, completed }: TimedClassificationProps) {
  // Parse scenarios - handle both array formats and different key names
  const rawScenarios = content?.scenarios || content?.transactions || content?.questions;
  const scenarios: ClassificationScenario[] = Array.isArray(rawScenarios) ? rawScenarios : [];
  const instructions = (content?.instructions as string) || (content?.description as string) || "Identify the correct CT pillar for each scenario.";
  const timePerQuestion = (content?.timePerQuestion as number) || (content?.time_per_question as number) || 15;
  
  const pillars = ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"];
  
  const [currentIndex, setCurrentIndex] = useState(0);
  const [score, setScore] = useState(0);
  const [timeLeft, setTimeLeft] = useState(timePerQuestion);
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [showFeedback, setShowFeedback] = useState(false);
  const [isFinished, setIsFinished] = useState(false);
  const [answers, setAnswers] = useState<{ correct: boolean; selected: string | null; expected: string }[]>([]);
  
  const currentScenario = scenarios[currentIndex];
  
  const moveToNextRef = useCallback(() => {
    if (currentIndex >= scenarios.length - 1) {
      setIsFinished(true);
      // Timeout means this answer was wrong, so just count existing correct answers
      setAnswers(prev => {
        const correctCount = prev.filter(a => a.correct).length;
        const finalScore = Math.round((correctCount / scenarios.length) * 100);
        if (finalScore >= 60) {
          onComplete();
        }
        return prev;
      });
    } else {
      setCurrentIndex(prev => prev + 1);
      setTimeLeft(timePerQuestion);
      setSelectedAnswer(null);
      setShowFeedback(false);
    }
  }, [currentIndex, scenarios.length, timePerQuestion, onComplete]);
  
  const handleTimeout = useCallback(() => {
    // Time ran out - count as wrong
    if (!currentScenario) return;
    setAnswers(prev => [...prev, { correct: false, selected: null, expected: currentScenario.correctPillar }]);
    setShowFeedback(true);
    
    setTimeout(() => {
      moveToNextRef();
    }, 2000);
  }, [currentScenario, moveToNextRef]);
  
  // Timer effect
  useEffect(() => {
    if (completed || isFinished || showFeedback || !currentScenario) return;
    
    if (timeLeft <= 0) {
      handleTimeout();
      return;
    }
    
    const timer = setInterval(() => {
      setTimeLeft(prev => prev - 1);
    }, 1000);
    
    return () => clearInterval(timer);
  }, [timeLeft, showFeedback, isFinished, completed, currentScenario, handleTimeout]);
  
  const handleAnswer = (pillar: string) => {
    if (showFeedback || isFinished) return;
    
    setSelectedAnswer(pillar);
    const isCorrect = pillar === currentScenario.correctPillar;
    
    if (isCorrect) {
      setScore(prev => prev + 1);
    }
    
    setAnswers(prev => [...prev, { correct: isCorrect, selected: pillar, expected: currentScenario.correctPillar }]);
    setShowFeedback(true);
    
    setTimeout(() => {
      // Move to next question or finish
      if (currentIndex >= scenarios.length - 1) {
        setIsFinished(true);
        // Check if passed (60% or more) - need to include current answer
        const correctCount = answers.filter(a => a.correct).length + (isCorrect ? 1 : 0);
        const finalScore = Math.round((correctCount / scenarios.length) * 100);
        if (finalScore >= 60) {
          onComplete();
        }
      } else {
        setCurrentIndex(prev => prev + 1);
        setSelectedAnswer(null);
        setShowFeedback(false);
        setTimeLeft(timePerQuestion);
      }
    }, 2000);
  };
  
  const handleRestart = () => {
    setCurrentIndex(0);
    setScore(0);
    setTimeLeft(timePerQuestion);
    setSelectedAnswer(null);
    setShowFeedback(false);
    setIsFinished(false);
    setAnswers([]);
  };
  
  if (scenarios.length === 0) {
    return (
      <div className="text-center p-6">
        <AlertCircle className="w-12 h-12 text-amber-500 mx-auto mb-4" />
        <p className="text-[var(--foreground-muted)] mb-2">No scenarios available for this activity.</p>
        <p className="text-xs text-slate-400">
          Content keys: {content ? Object.keys(content).join(', ') : 'none'}
        </p>
      </div>
    );
  }
  
  const finalScorePercent = Math.round((score / scenarios.length) * 100);
  
  if (isFinished) {
    return (
      <div className="text-center">
        <div className={`w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4 ${finalScorePercent >= 60 ? 'bg-emerald-100' : 'bg-amber-100'}`}>
          <span className={`text-2xl font-bold ${finalScorePercent >= 60 ? 'text-emerald-700' : 'text-amber-700'}`}>
            {finalScorePercent}%
          </span>
        </div>
        
        <h3 className="text-xl font-bold mb-2">
          {finalScorePercent >= 60 ? 'Great Job!' : 'Keep Practicing!'}
        </h3>
        <p className="text-[var(--foreground-muted)] mb-6">
          You got {score} out of {scenarios.length} correct.
          {finalScorePercent < 60 && ' You need 60% to pass.'}
        </p>
        
        {/* Summary of answers */}
        <div className="text-left max-w-lg mx-auto mb-6 space-y-3">
          {scenarios.map((scenario, idx) => {
            const answer = answers[idx];
            return (
              <div
                key={idx}
                className={`p-3 rounded-lg border ${answer?.correct ? 'bg-emerald-50 border-emerald-200' : 'bg-red-50 border-red-200'}`}
              >
                <p className="text-sm font-medium mb-1">{scenario.scenario.substring(0, 80)}...</p>
                <p className="text-xs">
                  {answer?.correct ? (
                    <span className="text-emerald-700">Correct: {scenario.correctPillar}</span>
                  ) : (
                    <span className="text-red-700">
                      Your answer: {answer?.selected || 'Time out'} | Correct: {scenario.correctPillar}
                    </span>
                  )}
                </p>
              </div>
            );
          })}
        </div>
        
        {finalScorePercent < 60 && (
          <button
            onClick={handleRestart}
            className="flex items-center gap-2 px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors mx-auto"
          >
            <RotateCcw className="w-4 h-4" />
            Try Again
          </button>
        )}
      </div>
    );
  }
  
  return (
    <div>
      <p className="text-[var(--foreground-muted)] mb-6">{instructions}</p>
      
      {/* Progress and Timer */}
      <div className="flex items-center justify-between mb-6">
        <p className="text-sm text-[var(--foreground-muted)]">
          Question {currentIndex + 1} of {scenarios.length}
        </p>
        <div className={`flex items-center gap-2 px-3 py-1.5 rounded-full ${timeLeft <= 5 ? 'bg-red-100 text-red-700' : 'bg-slate-100 text-slate-700'}`}>
          <span className="font-mono font-bold">{timeLeft}s</span>
        </div>
      </div>
      
      {/* Timer bar */}
      <div className="h-2 bg-slate-100 rounded-full mb-6 overflow-hidden">
        <div
          className={`h-full transition-all duration-1000 ease-linear ${timeLeft <= 5 ? 'bg-red-500' : 'bg-violet-500'}`}
          style={{ width: `${(timeLeft / timePerQuestion) * 100}%` }}
        />
      </div>
      
      {/* Scenario */}
      <div className="p-6 bg-slate-50 border border-[var(--border)] rounded-xl mb-6">
        <p className="text-lg">{currentScenario.scenario}</p>
      </div>
      
      {/* Answer options */}
      <div className="grid grid-cols-2 gap-3">
        {pillars.map((pillar) => {
          const isSelected = selectedAnswer === pillar;
          const isCorrect = pillar === currentScenario.correctPillar;
          
          let btnClass = 'bg-white border-[var(--border)] hover:border-violet-400 hover:bg-violet-50';
          if (showFeedback) {
            if (isCorrect) {
              btnClass = 'bg-emerald-100 border-emerald-500 text-emerald-800';
            } else if (isSelected && !isCorrect) {
              btnClass = 'bg-red-100 border-red-500 text-red-800';
            }
          } else if (isSelected) {
            btnClass = 'bg-violet-100 border-violet-500';
          }
          
          return (
            <button
              key={pillar}
              onClick={() => handleAnswer(pillar)}
              disabled={showFeedback}
              className={`p-4 rounded-xl border-2 font-medium transition-all ${btnClass}`}
            >
              {pillar}
            </button>
          );
        })}
      </div>
      
      {/* Feedback */}
      {showFeedback && (
        <div className={`mt-6 p-4 rounded-xl ${selectedAnswer === currentScenario.correctPillar ? 'bg-emerald-50 border border-emerald-200' : 'bg-amber-50 border border-amber-200'}`}>
          <p className={`font-medium mb-1 ${selectedAnswer === currentScenario.correctPillar ? 'text-emerald-700' : 'text-amber-700'}`}>
            {selectedAnswer === currentScenario.correctPillar ? 'Correct!' : (selectedAnswer ? 'Not quite!' : 'Time\'s up!')}
          </p>
          <p className="text-sm text-[var(--foreground-muted)]">{currentScenario.explanation}</p>
        </div>
      )}
      
      {/* Score display */}
      <div className="mt-6 text-center text-sm text-[var(--foreground-muted)]">
        Current score: {score} / {currentIndex + (showFeedback ? 1 : 0)}
      </div>
    </div>
  );
}

// ============================================
// Journal Entry Builder Component (FA Course)
// Supports both full journal entry format and quiz-style format
// ============================================
interface JournalEntryBuilderProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface JournalTransactionWithSolution {
  id: string;
  date: string;
  description: string;
  solution: { account: string; type: string; debit: number; credit: number }[];
  hint?: string;
}

interface SimpleTransaction {
  date: string;
  description: string;
}

interface JournalQuizQuestion {
  id: string;
  question: string;
  answer_type: 'choice' | 'numeric';
  options?: string[];
  correct_answer: string | number;
  tolerance?: number;
  hint?: string;
  explanation: string;
}

interface AccountOption {
  name: string;
  type: string;
}

interface JournalEntry {
  account: string;
  debit: number;
  credit: number;
}

function JournalEntryBuilder({ content, onComplete, completed }: JournalEntryBuilderProps) {
  const scenario = (content?.scenario as string) || (content?.description as string) || "Build journal entries for the following transactions.";
  const companyName = (content?.company_name as string) || (content?.title as string) || "Company";
  const companyBackground = (content?.company_background as string) || "";
  const rawTransactions = (content?.transactions as (JournalTransactionWithSolution | SimpleTransaction)[]) || [];
  const accountOptions = (content?.account_options as AccountOption[]) || [];
  const questions = (content?.questions as JournalQuizQuestion[]) || [];
  const passingScore = (content?.passing_score as number) || 80;

  // Determine if we have the full format (with solutions) or quiz format
  const hasFullFormat = rawTransactions.length > 0 && 
    rawTransactions.some(tx => 'solution' in tx && Array.isArray((tx as JournalTransactionWithSolution).solution));
  const hasQuizFormat = questions.length > 0;
  
  // Cast transactions to the appropriate type
  const transactions = hasFullFormat ? (rawTransactions as JournalTransactionWithSolution[]) : [];
  const simpleTransactions = !hasFullFormat ? (rawTransactions as SimpleTransaction[]) : [];

  // State for full journal entry builder mode
  const [currentTxIndex, setCurrentTxIndex] = useState(0);
  const [entries, setEntries] = useState<JournalEntry[]>([
    { account: "", debit: 0, credit: 0 },
    { account: "", debit: 0, credit: 0 },
  ]);
  const [showHint, setShowHint] = useState(false);
  const [showFeedback, setShowFeedback] = useState(false);
  const [txResults, setTxResults] = useState<{ correct: boolean; feedback: string }[]>([]);
  const [isFinished, setIsFinished] = useState(false);
  
  // State for quiz-style mode
  const [selectedAnswer, setSelectedAnswer] = useState<string | number | null>(null);
  const [numericAnswer, setNumericAnswer] = useState('');
  const [quizScore, setQuizScore] = useState(0);

  // Reset state when switching questions
  useEffect(() => {
    setSelectedAnswer(null);
    setNumericAnswer('');
    setShowFeedback(false);
    setShowHint(false);
  }, [currentTxIndex]);

  // FULL JOURNAL ENTRY BUILDER MODE
  if (hasFullFormat && accountOptions.length > 0) {
    const currentTx = transactions[currentTxIndex];

    const addEntry = () => {
      setEntries([...entries, { account: "", debit: 0, credit: 0 }]);
    };

    const removeEntry = (index: number) => {
      if (entries.length <= 2) return;
      setEntries(entries.filter((_, i) => i !== index));
    };

    const updateEntry = (index: number, field: keyof JournalEntry, value: string | number) => {
      const updated = [...entries];
      if (field === 'account') {
        updated[index].account = value as string;
      } else if (field === 'debit') {
        updated[index].debit = Number(value) || 0;
        if (Number(value) > 0) updated[index].credit = 0;
      } else if (field === 'credit') {
        updated[index].credit = Number(value) || 0;
        if (Number(value) > 0) updated[index].debit = 0;
      }
      setEntries(updated);
    };

    const checkAnswer = () => {
      if (!currentTx) return;

      const solution = currentTx.solution;
      let isCorrect = true;
      let feedback = "";

      const totalDebits = entries.reduce((sum, e) => sum + e.debit, 0);
      const totalCredits = entries.reduce((sum, e) => sum + e.credit, 0);

      if (totalDebits !== totalCredits) {
        isCorrect = false;
        feedback = `Debits (${totalDebits.toLocaleString()}) must equal Credits (${totalCredits.toLocaleString()}).`;
      } else {
        const matchedEntries = new Set<number>();
        
        for (const sol of solution) {
          const matchIndex = entries.findIndex((e, idx) => 
            !matchedEntries.has(idx) &&
            e.account === sol.account &&
            e.debit === sol.debit &&
            e.credit === sol.credit
          );
          
          if (matchIndex === -1) {
            isCorrect = false;
          } else {
            matchedEntries.add(matchIndex);
          }
        }

        if (!isCorrect) {
          feedback = "Some entries don't match. Check your accounts and amounts.";
        } else if (entries.filter(e => e.account).length > solution.length) {
          isCorrect = false;
          feedback = "You have extra entries that aren't needed.";
        } else {
          feedback = "Correct! Great job!";
        }
      }

      setTxResults([...txResults, { correct: isCorrect, feedback }]);
      setShowFeedback(true);
    };

    const nextTransaction = () => {
      if (currentTxIndex >= transactions.length - 1) {
        setIsFinished(true);
        const correctCount = txResults.filter(r => r.correct).length;
        const scorePercent = Math.round((correctCount / transactions.length) * 100);
        if (scorePercent >= passingScore) {
          onComplete();
        }
      } else {
        setCurrentTxIndex(currentTxIndex + 1);
        setEntries([
          { account: "", debit: 0, credit: 0 },
          { account: "", debit: 0, credit: 0 },
        ]);
        setShowFeedback(false);
        setShowHint(false);
      }
    };

    const handleReset = () => {
      setCurrentTxIndex(0);
      setEntries([
        { account: "", debit: 0, credit: 0 },
        { account: "", debit: 0, credit: 0 },
      ]);
      setTxResults([]);
      setShowFeedback(false);
      setShowHint(false);
      setIsFinished(false);
    };

    const correctCount = txResults.filter(r => r.correct).length;
    const finalScore = Math.round((correctCount / transactions.length) * 100);

    // Finished state for full format
    if (isFinished) {
      return (
        <div className="text-center">
          <div className={`w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-4 ${finalScore >= passingScore ? 'bg-emerald-100' : 'bg-amber-100'}`}>
            <span className={`text-3xl font-bold ${finalScore >= passingScore ? 'text-emerald-700' : 'text-amber-700'}`}>
              {finalScore}%
            </span>
          </div>
          
          <h3 className="text-xl font-bold mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
            {finalScore >= passingScore ? 'Excellent Work!' : 'Keep Practicing!'}
          </h3>
          <p className="text-[var(--foreground-muted)] mb-6">
            You got {correctCount} of {transactions.length} transactions correct.
            {finalScore < passingScore && ` You need ${passingScore}% to pass.`}
          </p>

          <div className="text-left max-w-xl mx-auto mb-6 space-y-2">
            {transactions.map((tx, idx) => {
              const result = txResults[idx];
              return (
                <div
                  key={tx.id}
                  className={`p-3 rounded-lg border ${result?.correct ? 'bg-emerald-50 border-emerald-200' : 'bg-red-50 border-red-200'}`}
                >
                  <p className="text-sm font-medium text-slate-700">{tx.date}: {tx.description.substring(0, 60)}...</p>
                  <p className="text-xs mt-1">
                    {result?.correct ? (
                      <span className="text-emerald-700 flex items-center gap-1">
                        <CheckCircle2 className="w-3 h-3" /> Correct
                      </span>
                    ) : (
                      <span className="text-red-700">{result?.feedback || 'Incorrect'}</span>
                    )}
                  </p>
                </div>
              );
            })}
          </div>

          {finalScore < passingScore && (
            <button
              onClick={handleReset}
              className="flex items-center gap-2 px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors mx-auto"
            >
              <RotateCcw className="w-4 h-4" />
              Try Again
            </button>
          )}
        </div>
      );
    }

    return (
      <div>
        <div className="bg-blue-50 border border-blue-200 rounded-xl p-4 mb-6">
          <div className="flex items-start gap-3">
            <BookOpen className="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" />
            <div>
              <h3 className="font-semibold text-blue-800">{companyName}</h3>
              <p className="text-sm text-blue-700 mt-1">{scenario}</p>
            </div>
          </div>
        </div>

        <div className="flex items-center justify-between mb-6">
          <p className="text-sm text-[var(--foreground-muted)]">
            Transaction {currentTxIndex + 1} of {transactions.length}
          </p>
          <div className="flex gap-1">
            {transactions.map((_, idx) => (
              <div
                key={idx}
                className={`w-3 h-3 rounded-full ${
                  idx < currentTxIndex ? (txResults[idx]?.correct ? 'bg-emerald-500' : 'bg-red-400') :
                  idx === currentTxIndex ? 'bg-violet-500' : 'bg-slate-200'
                }`}
              />
            ))}
          </div>
        </div>

        <div className="bg-slate-50 border border-slate-200 rounded-xl p-4 mb-6">
          <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)] mb-2">
            <span className="font-semibold text-violet-600">{currentTx.date}</span>
          </div>
          <p className="text-slate-800">{currentTx.description}</p>
        </div>

        <div className="bg-white border border-slate-200 rounded-xl overflow-hidden mb-4">
          <div className="bg-slate-100 px-4 py-2 border-b border-slate-200">
            <div className="grid grid-cols-12 gap-2 text-xs font-semibold text-slate-600 uppercase">
              <div className="col-span-5">Account</div>
              <div className="col-span-3 text-right">Debit (CHF)</div>
              <div className="col-span-3 text-right">Credit (CHF)</div>
              <div className="col-span-1"></div>
            </div>
          </div>
          
          <div className="p-4 space-y-3">
            {entries.map((entry, idx) => (
              <div key={idx} className="grid grid-cols-12 gap-2 items-center">
                <div className="col-span-5">
                  <select
                    value={entry.account}
                    onChange={(e) => updateEntry(idx, 'account', e.target.value)}
                    disabled={showFeedback}
                    className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-violet-500 disabled:bg-slate-100"
                  >
                    <option value="">Select account...</option>
                    {accountOptions.map((opt) => (
                      <option key={opt.name} value={opt.name}>
                        {opt.name} ({opt.type})
                      </option>
                    ))}
                  </select>
                </div>
                <div className="col-span-3">
                  <input
                    type="number"
                    value={entry.debit || ''}
                    onChange={(e) => updateEntry(idx, 'debit', e.target.value)}
                    disabled={showFeedback}
                    placeholder="0"
                    className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm text-right focus:outline-none focus:ring-2 focus:ring-violet-500 disabled:bg-slate-100"
                  />
                </div>
                <div className="col-span-3">
                  <input
                    type="number"
                    value={entry.credit || ''}
                    onChange={(e) => updateEntry(idx, 'credit', e.target.value)}
                    disabled={showFeedback}
                    placeholder="0"
                    className="w-full px-3 py-2 border border-slate-200 rounded-lg text-sm text-right focus:outline-none focus:ring-2 focus:ring-violet-500 disabled:bg-slate-100"
                  />
                </div>
                <div className="col-span-1 flex justify-center">
                  {entries.length > 2 && !showFeedback && (
                    <button
                      onClick={() => removeEntry(idx)}
                      className="p-1 text-slate-400 hover:text-red-500 transition-colors"
                    >
                      <Trash2 className="w-4 h-4" />
                    </button>
                  )}
                </div>
              </div>
            ))}
          </div>

          <div className="bg-slate-50 px-4 py-3 border-t border-slate-200">
            <div className="grid grid-cols-12 gap-2 items-center">
              <div className="col-span-5 text-sm font-semibold text-slate-600">Totals</div>
              <div className="col-span-3 text-right font-mono font-semibold text-slate-800">
                {entries.reduce((sum, e) => sum + e.debit, 0).toLocaleString()}
              </div>
              <div className="col-span-3 text-right font-mono font-semibold text-slate-800">
                {entries.reduce((sum, e) => sum + e.credit, 0).toLocaleString()}
              </div>
              <div className="col-span-1"></div>
            </div>
          </div>
        </div>

        {!showFeedback && (
          <button
            onClick={addEntry}
            className="flex items-center gap-2 text-sm text-violet-600 hover:text-violet-700 mb-6"
          >
            <Plus className="w-4 h-4" />
            Add another line
          </button>
        )}

        {currentTx.hint && !showFeedback && (
          <div className="mb-6">
            {showHint ? (
              <div className="bg-amber-50 border border-amber-200 rounded-xl p-4">
                <div className="flex items-start gap-3">
                  <Lightbulb className="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" />
                  <p className="text-sm text-amber-800">{currentTx.hint}</p>
                </div>
              </div>
            ) : (
              <button
                onClick={() => setShowHint(true)}
                className="text-sm text-amber-600 hover:text-amber-700 flex items-center gap-1"
              >
                <Lightbulb className="w-4 h-4" />
                Need a hint?
              </button>
            )}
          </div>
        )}

        {showFeedback && txResults[currentTxIndex] && (
          <div className={`mb-6 p-4 rounded-xl border ${txResults[currentTxIndex].correct ? 'bg-emerald-50 border-emerald-200' : 'bg-red-50 border-red-200'}`}>
            <div className="flex items-center gap-2 mb-2">
              {txResults[currentTxIndex].correct ? (
                <CheckCircle2 className="w-5 h-5 text-emerald-600" />
              ) : (
                <X className="w-5 h-5 text-red-600" />
              )}
              <span className={`font-semibold ${txResults[currentTxIndex].correct ? 'text-emerald-700' : 'text-red-700'}`}>
                {txResults[currentTxIndex].correct ? 'Correct!' : 'Not quite right'}
              </span>
            </div>
            <p className="text-sm text-slate-600">{txResults[currentTxIndex].feedback}</p>
            
            {!txResults[currentTxIndex].correct && (
              <div className="mt-3 pt-3 border-t border-red-200">
                <p className="text-xs font-semibold text-slate-600 mb-2">Correct entry:</p>
                <div className="space-y-1">
                  {currentTx.solution.map((sol, idx) => (
                    <div key={idx} className="text-xs text-slate-700 font-mono">
                      {sol.account}: {sol.debit > 0 ? `Dr ${sol.debit.toLocaleString()}` : `Cr ${sol.credit.toLocaleString()}`}
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        )}

        <div className="flex justify-end gap-3">
          {!showFeedback ? (
            <button
              onClick={checkAnswer}
              disabled={entries.every(e => !e.account) || entries.reduce((sum, e) => sum + e.debit + e.credit, 0) === 0}
              className="flex items-center gap-2 px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Check Entry
              <ArrowRight className="w-4 h-4" />
            </button>
          ) : (
            <button
              onClick={nextTransaction}
              className="flex items-center gap-2 px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors"
            >
              {currentTxIndex >= transactions.length - 1 ? 'See Results' : 'Next Transaction'}
              <ArrowRight className="w-4 h-4" />
            </button>
          )}
        </div>
      </div>
    );
  }

  // QUIZ-STYLE MODE (for content with questions array)
  if (hasQuizFormat) {
    const currentQuestion = questions[currentTxIndex];
    
    // Find corresponding transaction description if available
    const relatedTransaction = simpleTransactions.find((_, idx) => 
      currentQuestion.id.includes(`${idx + 1}`) || currentQuestion.question.includes(simpleTransactions[idx]?.date || '')
    ) || simpleTransactions[currentTxIndex];

    const checkQuizAnswer = () => {
      if (!currentQuestion) return;
      
      let isCorrect = false;
      
      if (currentQuestion.answer_type === 'choice') {
        isCorrect = selectedAnswer === currentQuestion.correct_answer;
      } else if (currentQuestion.answer_type === 'numeric') {
        const userNum = Number(numericAnswer);
        const correctNum = Number(currentQuestion.correct_answer);
        const tolerance = currentQuestion.tolerance || 0;
        isCorrect = Math.abs(userNum - correctNum) <= tolerance;
      }
      
      if (isCorrect) setQuizScore(s => s + 1);
      setShowFeedback(true);
    };

    const nextQuestion = () => {
      if (currentTxIndex >= questions.length - 1) {
        setIsFinished(true);
        const finalScore = Math.round((quizScore / questions.length) * 100);
        if (finalScore >= passingScore) {
          onComplete();
        }
      } else {
        setCurrentTxIndex(i => i + 1);
      }
    };
    
    const isCurrentCorrect = () => {
      if (!currentQuestion) return false;
      if (currentQuestion.answer_type === 'choice') {
        return selectedAnswer === currentQuestion.correct_answer;
      } else if (currentQuestion.answer_type === 'numeric') {
        const userNum = Number(numericAnswer);
        const correctNum = Number(currentQuestion.correct_answer);
        const tolerance = currentQuestion.tolerance || 0;
        return Math.abs(userNum - correctNum) <= tolerance;
      }
      return false;
    };

    const handleReset = () => {
      setCurrentTxIndex(0);
      setQuizScore(0);
      setIsFinished(false);
      setShowFeedback(false);
      setSelectedAnswer(null);
      setNumericAnswer('');
    };

    const finalScore = Math.round((quizScore / questions.length) * 100);

    if (isFinished) {
      return (
        <div className="text-center">
          <div className={`w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-4 ${finalScore >= passingScore ? 'bg-emerald-100' : 'bg-amber-100'}`}>
            <span className={`text-3xl font-bold ${finalScore >= passingScore ? 'text-emerald-700' : 'text-amber-700'}`}>
              {finalScore}%
            </span>
          </div>
          <h3 className="text-xl font-bold mb-2">{finalScore >= passingScore ? 'Excellent Work!' : 'Keep Practicing!'}</h3>
          <p className="text-[var(--foreground-muted)] mb-6">
            You got {quizScore} of {questions.length} questions correct.
            {finalScore < passingScore && ` You need ${passingScore}% to pass.`}
          </p>
          {finalScore < passingScore && (
            <button
              onClick={handleReset}
              className="flex items-center gap-2 mx-auto px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors"
            >
              <RotateCcw className="w-4 h-4" />
              Try Again
            </button>
          )}
        </div>
      );
    }

    return (
      <div>
        {/* Company Background */}
        {companyBackground && (
          <div className="bg-blue-50 border border-blue-200 rounded-xl p-4 mb-6">
            <div className="flex items-start gap-3">
              <BookOpen className="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" />
              <div>
                <h3 className="font-semibold text-blue-800">{companyName}</h3>
                <p className="text-sm text-blue-700 mt-1">{companyBackground}</p>
              </div>
            </div>
          </div>
        )}

        {/* Normal Balance Reference */}
        <div className="bg-violet-50 border border-violet-200 rounded-xl p-4 mb-6">
          <p className="text-xs text-violet-600 font-semibold mb-2">Quick Reference:</p>
          <div className="grid grid-cols-2 gap-2 text-xs text-violet-800">
            <div>Assets, Expenses: Debit to increase</div>
            <div>Liabilities, Equity, Revenue: Credit to increase</div>
          </div>
        </div>

        <p className="text-sm text-[var(--foreground-muted)] mb-4">Question {currentTxIndex + 1} of {questions.length}</p>
        
        {/* Related Transaction */}
        {relatedTransaction && (
          <div className="bg-slate-50 border border-slate-200 rounded-xl p-4 mb-4">
            <p className="text-sm text-slate-600 mb-1">Transaction:</p>
            <p className="text-slate-800">{relatedTransaction.date && `${relatedTransaction.date}: `}{relatedTransaction.description}</p>
          </div>
        )}
        
        {/* Question */}
        <div className="bg-slate-50 border border-slate-200 rounded-xl p-4 mb-6">
          <p className="text-slate-800 font-medium">{currentQuestion.question}</p>
        </div>

        {/* Answer Input */}
        {currentQuestion.answer_type === 'choice' && currentQuestion.options ? (
          <div className="space-y-3 mb-6">
            {currentQuestion.options.map((option, idx) => (
              <button
                key={idx}
                onClick={() => !showFeedback && setSelectedAnswer(option)}
                disabled={showFeedback}
                className={`w-full text-left px-4 py-3 rounded-xl border transition-all ${
                  showFeedback
                    ? option === currentQuestion.correct_answer
                      ? 'bg-emerald-50 border-emerald-300 text-emerald-800'
                      : selectedAnswer === option
                        ? 'bg-red-50 border-red-300 text-red-800'
                        : 'bg-slate-50 border-slate-200 text-slate-600'
                    : selectedAnswer === option
                      ? 'bg-violet-100 border-violet-300 text-violet-800'
                      : 'bg-white border-slate-200 hover:border-violet-300'
                }`}
              >
                {option}
              </button>
            ))}
          </div>
        ) : (
          <div className="mb-6">
            <input
              type="number"
              value={numericAnswer}
              onChange={(e) => setNumericAnswer(e.target.value)}
              disabled={showFeedback}
              placeholder="Enter your answer"
              className={`w-full px-4 py-3 text-lg font-mono border rounded-xl focus:outline-none focus:ring-2 focus:ring-violet-500 disabled:bg-slate-100 ${
                showFeedback
                  ? isCurrentCorrect()
                    ? 'border-emerald-300 bg-emerald-50'
                    : 'border-red-300 bg-red-50'
                  : 'border-slate-200'
              }`}
            />
            {showFeedback && !isCurrentCorrect() && (
              <p className="text-sm text-slate-600 mt-2">
                Correct answer: {currentQuestion.correct_answer.toLocaleString()}
              </p>
            )}
          </div>
        )}

        {/* Hint */}
        {currentQuestion.hint && !showFeedback && (
          <button
            onClick={() => setShowHint(!showHint)}
            className="text-sm text-violet-600 hover:text-violet-700 mb-4 flex items-center gap-1"
          >
            <Lightbulb className="w-4 h-4" />
            {showHint ? 'Hide Hint' : 'Show Hint'}
          </button>
        )}
        
        {showHint && currentQuestion.hint && (
          <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 mb-6">
            <p className="text-sm text-amber-800">{currentQuestion.hint}</p>
          </div>
        )}

        {/* Feedback */}
        {showFeedback && (
          <div className={`mb-6 p-4 rounded-xl ${isCurrentCorrect() ? 'bg-emerald-50 border border-emerald-200' : 'bg-amber-50 border border-amber-200'}`}>
            <div className="flex items-center gap-2 mb-2">
              {isCurrentCorrect() ? (
                <CheckCircle2 className="w-5 h-5 text-emerald-600" />
              ) : (
                <X className="w-5 h-5 text-amber-600" />
              )}
              <span className={`font-semibold ${isCurrentCorrect() ? 'text-emerald-700' : 'text-amber-700'}`}>
                {isCurrentCorrect() ? 'Correct!' : 'Not quite'}
              </span>
            </div>
            <p className="text-sm text-slate-700">{currentQuestion.explanation}</p>
          </div>
        )}

        <div className="flex justify-end">
          {!showFeedback ? (
            <button 
              onClick={checkQuizAnswer} 
              disabled={currentQuestion.answer_type === 'choice' ? !selectedAnswer : !numericAnswer}
              className="px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Check Answer
            </button>
          ) : (
            <button onClick={nextQuestion} className="px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors flex items-center gap-2">
              {currentTxIndex >= questions.length - 1 ? 'See Results' : 'Next Question'}
              <ArrowRight className="w-4 h-4" />
            </button>
          )}
        </div>
      </div>
    );
  }

  // No valid content
  return <div className="text-center text-[var(--foreground-muted)]">No journal entry exercises or questions available for this activity.</div>;
}

// ============================================
// Equation Analyzer Component (FA Course)
// Supports both scenario-based format and quiz-based format
// ============================================
interface EquationAnalyzerProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

// Quiz question format from database
interface QuizQuestion {
  id: string;
  question: string;
  answer_type: 'choice' | 'numeric';
  options?: string[];
  correct_answer: string | number;
  tolerance?: number;
  hint?: string;
  explanation: string;
}

// Scenario-based format (original)
interface EquationScenario {
  description: string;
  effects: { assets: number; liabilities: number; equity: number };
  explanation: string;
}

function EquationAnalyzer({ content, onComplete, completed }: EquationAnalyzerProps) {
  const instructions = (content?.instructions as string) || (content?.description as string) || "Analyze how each transaction affects the accounting equation.";
  
  // Parse scenarios - handle both array and object formats
  const rawScenarios = content?.scenarios;
  const scenarios: EquationScenario[] = Array.isArray(rawScenarios) ? rawScenarios : [];
  
  // Parse questions - handle both array and object formats, and check nested content
  const rawQuestions = content?.questions;
  const questions: QuizQuestion[] = Array.isArray(rawQuestions) ? rawQuestions : [];
  
  const transactions = (content?.transactions as { id: string; description: string }[]) || [];
  const companyBackground = (content?.company_background as string) || (content?.companyBackground as string) || "";
  const passingScore = (content?.passing_score as number) || (content?.passingScore as number) || 60;
  
  // Determine which format we have
  const hasScenarios = scenarios.length > 0;
  const hasQuestions = questions.length > 0;
  
  // Debug logging for troubleshooting content issues
  useEffect(() => {
    if (!hasScenarios && !hasQuestions && content) {
      console.warn('[EquationAnalyzer] No scenarios or questions found. Content keys:', Object.keys(content));
    }
  }, [hasScenarios, hasQuestions, content]);
  
  // State for scenario-based mode
  const [currentIndex, setCurrentIndex] = useState(0);
  const [userAnswer, setUserAnswer] = useState({ assets: '', liabilities: '', equity: '' });
  const [showFeedback, setShowFeedback] = useState(false);
  const [score, setScore] = useState(0);
  const [isFinished, setIsFinished] = useState(false);
  
  // State for quiz-based mode
  const [selectedAnswer, setSelectedAnswer] = useState<string | number | null>(null);
  const [numericAnswer, setNumericAnswer] = useState('');
  const [showHint, setShowHint] = useState(false);

  // Reset state when switching questions
  useEffect(() => {
    setSelectedAnswer(null);
    setNumericAnswer('');
    setShowFeedback(false);
    setShowHint(false);
  }, [currentIndex]);

  // SCENARIO-BASED MODE
  if (hasScenarios) {
    const scenario = scenarios[currentIndex];

    const checkAnswer = () => {
      if (!scenario) return;
      
      const correct = 
        Number(userAnswer.assets) === scenario.effects.assets &&
        Number(userAnswer.liabilities) === scenario.effects.liabilities &&
        Number(userAnswer.equity) === scenario.effects.equity;
      
      if (correct) setScore(s => s + 1);
      setShowFeedback(true);
    };

    const nextScenario = () => {
      if (currentIndex >= scenarios.length - 1) {
        setIsFinished(true);
        if (Math.round((score / scenarios.length) * 100) >= passingScore) {
          onComplete();
        }
      } else {
        setCurrentIndex(i => i + 1);
        setUserAnswer({ assets: '', liabilities: '', equity: '' });
        setShowFeedback(false);
      }
    };

    const finalScore = Math.round((score / scenarios.length) * 100);

    if (isFinished) {
      return (
        <div className="text-center">
          <div className={`w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4 ${finalScore >= passingScore ? 'bg-emerald-100' : 'bg-amber-100'}`}>
            <span className={`text-2xl font-bold ${finalScore >= passingScore ? 'text-emerald-700' : 'text-amber-700'}`}>{finalScore}%</span>
          </div>
          <h3 className="text-xl font-bold mb-2">{finalScore >= passingScore ? 'Great Job!' : 'Keep Practicing!'}</h3>
          <p className="text-[var(--foreground-muted)]">You got {score} of {scenarios.length} correct.</p>
        </div>
      );
    }

    return (
      <div>
        <p className="text-[var(--foreground-muted)] mb-6">{instructions}</p>
        
        <div className="bg-violet-50 border border-violet-200 rounded-xl p-4 mb-6 text-center">
          <p className="text-lg font-semibold text-violet-800 font-mono">
            Assets = Liabilities + Equity
          </p>
        </div>

        <p className="text-sm text-[var(--foreground-muted)] mb-4">Scenario {currentIndex + 1} of {scenarios.length}</p>
        
        <div className="bg-slate-50 border border-slate-200 rounded-xl p-4 mb-6">
          <p className="text-slate-800">{scenario.description}</p>
        </div>

        <p className="text-sm font-medium text-slate-600 mb-3">Enter the change for each element (+, -, or 0):</p>
        
        <div className="grid grid-cols-3 gap-4 mb-6">
          {(['assets', 'liabilities', 'equity'] as const).map((field) => (
            <div key={field} className="text-center">
              <label className="block text-sm font-medium text-slate-600 mb-2 capitalize">{field}</label>
              <input
                type="number"
                value={userAnswer[field]}
                onChange={(e) => setUserAnswer({ ...userAnswer, [field]: e.target.value })}
                disabled={showFeedback}
                placeholder="0"
                className="w-full px-4 py-3 text-center text-lg font-mono border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-violet-500 disabled:bg-slate-100"
              />
            </div>
          ))}
        </div>

        {showFeedback && (
          <div className={`mb-6 p-4 rounded-xl ${
            Number(userAnswer.assets) === scenario.effects.assets &&
            Number(userAnswer.liabilities) === scenario.effects.liabilities &&
            Number(userAnswer.equity) === scenario.effects.equity
              ? 'bg-emerald-50 border border-emerald-200'
              : 'bg-amber-50 border border-amber-200'
          }`}>
            <p className="text-sm text-slate-700">{scenario.explanation}</p>
            <p className="text-xs text-slate-500 mt-2 font-mono">
              A: {scenario.effects.assets > 0 ? '+' : ''}{scenario.effects.assets} | 
              L: {scenario.effects.liabilities > 0 ? '+' : ''}{scenario.effects.liabilities} | 
              E: {scenario.effects.equity > 0 ? '+' : ''}{scenario.effects.equity}
            </p>
          </div>
        )}

        <div className="flex justify-end">
          {!showFeedback ? (
            <button onClick={checkAnswer} className="px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors">
              Check Answer
            </button>
          ) : (
            <button onClick={nextScenario} className="px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors">
              {currentIndex >= scenarios.length - 1 ? 'See Results' : 'Next'}
            </button>
          )}
        </div>
      </div>
    );
  }
  
  // QUIZ-BASED MODE (handles questions array format)
  if (hasQuestions) {
    const currentQuestion = questions[currentIndex];
    
    // Find corresponding transaction description if available
    const relatedTransaction = transactions.find(t => 
      currentQuestion.question.includes(t.id) || currentQuestion.id.includes(t.id.toLowerCase())
    );

    const checkQuizAnswer = () => {
      if (!currentQuestion) return;
      
      let isCorrect = false;
      
      if (currentQuestion.answer_type === 'choice') {
        isCorrect = selectedAnswer === currentQuestion.correct_answer;
      } else if (currentQuestion.answer_type === 'numeric') {
        const userNum = Number(numericAnswer);
        const correctNum = Number(currentQuestion.correct_answer);
        const tolerance = currentQuestion.tolerance || 0;
        isCorrect = Math.abs(userNum - correctNum) <= tolerance;
      }
      
      if (isCorrect) setScore(s => s + 1);
      setShowFeedback(true);
    };

    const nextQuestion = () => {
      if (currentIndex >= questions.length - 1) {
        setIsFinished(true);
        const finalScore = Math.round(((score + (showFeedback && isCurrentCorrect() ? 0 : 0)) / questions.length) * 100);
        if (finalScore >= passingScore) {
          onComplete();
        }
      } else {
        setCurrentIndex(i => i + 1);
      }
    };
    
    const isCurrentCorrect = () => {
      if (!currentQuestion) return false;
      if (currentQuestion.answer_type === 'choice') {
        return selectedAnswer === currentQuestion.correct_answer;
      } else if (currentQuestion.answer_type === 'numeric') {
        const userNum = Number(numericAnswer);
        const correctNum = Number(currentQuestion.correct_answer);
        const tolerance = currentQuestion.tolerance || 0;
        return Math.abs(userNum - correctNum) <= tolerance;
      }
      return false;
    };

    const finalScore = Math.round((score / questions.length) * 100);

    if (isFinished) {
      return (
        <div className="text-center">
          <div className={`w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4 ${finalScore >= passingScore ? 'bg-emerald-100' : 'bg-amber-100'}`}>
            <span className={`text-2xl font-bold ${finalScore >= passingScore ? 'text-emerald-700' : 'text-amber-700'}`}>{finalScore}%</span>
          </div>
          <h3 className="text-xl font-bold mb-2">{finalScore >= passingScore ? 'Great Job!' : 'Keep Practicing!'}</h3>
          <p className="text-[var(--foreground-muted)]">You got {score} of {questions.length} correct.</p>
          {finalScore < passingScore && (
            <button
              onClick={() => {
                setCurrentIndex(0);
                setScore(0);
                setIsFinished(false);
                setShowFeedback(false);
                setSelectedAnswer(null);
                setNumericAnswer('');
              }}
              className="mt-4 flex items-center gap-2 mx-auto px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors"
            >
              <RotateCcw className="w-4 h-4" />
              Try Again
            </button>
          )}
        </div>
      );
    }

    return (
      <div>
        {/* Company Background */}
        {companyBackground && (
          <div className="bg-blue-50 border border-blue-200 rounded-xl p-4 mb-6">
            <p className="text-sm text-blue-800">{companyBackground}</p>
          </div>
        )}
        
        {/* Accounting Equation Reference */}
        <div className="bg-violet-50 border border-violet-200 rounded-xl p-4 mb-6 text-center">
          <p className="text-lg font-semibold text-violet-800 font-mono">
            Assets = Liabilities + Equity
          </p>
        </div>

        <p className="text-sm text-[var(--foreground-muted)] mb-4">Question {currentIndex + 1} of {questions.length}</p>
        
        {/* Related Transaction Description */}
        {relatedTransaction && (
          <div className="bg-slate-50 border border-slate-200 rounded-xl p-4 mb-4">
            <p className="text-sm text-slate-600 mb-1">Transaction:</p>
            <p className="text-slate-800">{relatedTransaction.description}</p>
          </div>
        )}
        
        {/* Question */}
        <div className="bg-slate-50 border border-slate-200 rounded-xl p-4 mb-6">
          <p className="text-slate-800 font-medium">{currentQuestion.question}</p>
        </div>

        {/* Answer Input - Choice or Numeric */}
        {currentQuestion.answer_type === 'choice' && currentQuestion.options ? (
          <div className="space-y-3 mb-6">
            {currentQuestion.options.map((option, idx) => (
              <button
                key={idx}
                onClick={() => !showFeedback && setSelectedAnswer(option)}
                disabled={showFeedback}
                className={`w-full text-left px-4 py-3 rounded-xl border transition-all ${
                  showFeedback
                    ? option === currentQuestion.correct_answer
                      ? 'bg-emerald-50 border-emerald-300 text-emerald-800'
                      : selectedAnswer === option
                        ? 'bg-red-50 border-red-300 text-red-800'
                        : 'bg-slate-50 border-slate-200 text-slate-600'
                    : selectedAnswer === option
                      ? 'bg-violet-100 border-violet-300 text-violet-800'
                      : 'bg-white border-slate-200 hover:border-violet-300'
                }`}
              >
                {option}
              </button>
            ))}
          </div>
        ) : (
          <div className="mb-6">
            <input
              type="number"
              value={numericAnswer}
              onChange={(e) => setNumericAnswer(e.target.value)}
              disabled={showFeedback}
              placeholder="Enter your answer"
              className={`w-full px-4 py-3 text-lg font-mono border rounded-xl focus:outline-none focus:ring-2 focus:ring-violet-500 disabled:bg-slate-100 ${
                showFeedback
                  ? isCurrentCorrect()
                    ? 'border-emerald-300 bg-emerald-50'
                    : 'border-red-300 bg-red-50'
                  : 'border-slate-200'
              }`}
            />
            {showFeedback && !isCurrentCorrect() && (
              <p className="text-sm text-slate-600 mt-2">
                Correct answer: {currentQuestion.correct_answer.toLocaleString()}
              </p>
            )}
          </div>
        )}

        {/* Hint Button */}
        {currentQuestion.hint && !showFeedback && (
          <button
            onClick={() => setShowHint(!showHint)}
            className="text-sm text-violet-600 hover:text-violet-700 mb-4 flex items-center gap-1"
          >
            <Lightbulb className="w-4 h-4" />
            {showHint ? 'Hide Hint' : 'Show Hint'}
          </button>
        )}
        
        {showHint && currentQuestion.hint && (
          <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 mb-6">
            <p className="text-sm text-amber-800">{currentQuestion.hint}</p>
          </div>
        )}

        {/* Feedback */}
        {showFeedback && (
          <div className={`mb-6 p-4 rounded-xl ${isCurrentCorrect() ? 'bg-emerald-50 border border-emerald-200' : 'bg-amber-50 border border-amber-200'}`}>
            <p className="text-sm text-slate-700">{currentQuestion.explanation}</p>
          </div>
        )}

        <div className="flex justify-end">
          {!showFeedback ? (
            <button 
              onClick={checkQuizAnswer} 
              disabled={currentQuestion.answer_type === 'choice' ? !selectedAnswer : !numericAnswer}
              className="px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Check Answer
            </button>
          ) : (
            <button onClick={nextQuestion} className="px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors flex items-center gap-2">
              {currentIndex >= questions.length - 1 ? 'See Results' : 'Next Question'}
              <ArrowRight className="w-4 h-4" />
            </button>
          )}
        </div>
      </div>
    );
  }

  // No valid content - show helpful error with content structure hint
  return (
    <div className="text-center p-6">
      <AlertCircle className="w-12 h-12 text-amber-500 mx-auto mb-4" />
      <p className="text-[var(--foreground-muted)] mb-2">No scenarios or questions available for this activity.</p>
      <p className="text-xs text-slate-400">
        Content received: {content ? Object.keys(content).join(', ') : 'none'}
      </p>
    </div>
  );
}

// ============================================
// Trial Balance Builder Component (FA Course)
// ============================================
interface TrialBalanceBuilderProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

function TrialBalanceBuilder({ content, onComplete, completed }: TrialBalanceBuilderProps) {
  const instructions = (content?.instructions as string) || "Create a trial balance from the given account balances.";
  const accounts = (content?.accounts as { name: string; balance: number; normalBalance: 'debit' | 'credit' }[]) || [];
  const passingScore = (content?.passing_score as number) || 80;

  const [userBalances, setUserBalances] = useState<Record<string, { debit: number; credit: number }>>({});
  const [showResults, setShowResults] = useState(false);
  const [score, setScore] = useState(0);

  useEffect(() => {
    // Initialize user balances
    const initial: Record<string, { debit: number; credit: number }> = {};
    accounts.forEach(acc => {
      initial[acc.name] = { debit: 0, credit: 0 };
    });
    setUserBalances(initial);
  }, [accounts]);

  const updateBalance = (accountName: string, column: 'debit' | 'credit', value: number) => {
    setUserBalances(prev => ({
      ...prev,
      [accountName]: { ...prev[accountName], [column]: value }
    }));
  };

  const checkAnswers = () => {
    let correct = 0;
    accounts.forEach(acc => {
      const user = userBalances[acc.name];
      if (acc.normalBalance === 'debit') {
        if (user?.debit === Math.abs(acc.balance) && user?.credit === 0) correct++;
      } else {
        if (user?.credit === Math.abs(acc.balance) && user?.debit === 0) correct++;
      }
    });
    
    const scorePercent = Math.round((correct / accounts.length) * 100);
    setScore(scorePercent);
    setShowResults(true);
    
    if (scorePercent >= passingScore) {
      onComplete();
    }
  };

  const totalDebits = Object.values(userBalances).reduce((sum, b) => sum + (b.debit || 0), 0);
  const totalCredits = Object.values(userBalances).reduce((sum, b) => sum + (b.credit || 0), 0);

  if (accounts.length === 0) {
    return <div className="text-center text-[var(--foreground-muted)]">No accounts available.</div>;
  }

  return (
    <div>
      <p className="text-[var(--foreground-muted)] mb-6">{instructions}</p>

      <div className="bg-white border border-slate-200 rounded-xl overflow-hidden mb-6">
        <div className="bg-slate-100 px-4 py-3 border-b border-slate-200">
          <div className="grid grid-cols-3 gap-4 text-sm font-semibold text-slate-600">
            <div>Account</div>
            <div className="text-right">Debit (CHF)</div>
            <div className="text-right">Credit (CHF)</div>
          </div>
        </div>
        
        <div className="divide-y divide-slate-100">
          {accounts.map((acc) => (
            <div key={acc.name} className="px-4 py-3 grid grid-cols-3 gap-4 items-center">
              <div className="text-sm font-medium text-slate-700">{acc.name}</div>
              <div>
                <input
                  type="number"
                  value={userBalances[acc.name]?.debit || ''}
                  onChange={(e) => updateBalance(acc.name, 'debit', Number(e.target.value) || 0)}
                  disabled={showResults}
                  placeholder="0"
                  className="w-full px-3 py-2 text-right border border-slate-200 rounded-lg text-sm disabled:bg-slate-100"
                />
              </div>
              <div>
                <input
                  type="number"
                  value={userBalances[acc.name]?.credit || ''}
                  onChange={(e) => updateBalance(acc.name, 'credit', Number(e.target.value) || 0)}
                  disabled={showResults}
                  placeholder="0"
                  className="w-full px-3 py-2 text-right border border-slate-200 rounded-lg text-sm disabled:bg-slate-100"
                />
              </div>
            </div>
          ))}
        </div>

        <div className="bg-slate-50 px-4 py-3 border-t border-slate-200">
          <div className="grid grid-cols-3 gap-4 items-center font-semibold">
            <div className="text-slate-700">Totals</div>
            <div className={`text-right font-mono ${totalDebits !== totalCredits ? 'text-red-600' : 'text-slate-800'}`}>
              {totalDebits.toLocaleString()}
            </div>
            <div className={`text-right font-mono ${totalDebits !== totalCredits ? 'text-red-600' : 'text-slate-800'}`}>
              {totalCredits.toLocaleString()}
            </div>
          </div>
        </div>
      </div>

      {totalDebits !== totalCredits && !showResults && (
        <p className="text-sm text-red-600 mb-4">⚠️ Debits and Credits must be equal</p>
      )}

      {showResults && (
        <div className={`mb-6 p-4 rounded-xl ${score >= passingScore ? 'bg-emerald-50 border border-emerald-200' : 'bg-amber-50 border border-amber-200'}`}>
          <p className={`font-semibold ${score >= passingScore ? 'text-emerald-700' : 'text-amber-700'}`}>
            Score: {score}%
          </p>
          <p className="text-sm text-slate-600">
            {score >= passingScore ? 'Excellent work!' : `You need ${passingScore}% to pass.`}
          </p>
        </div>
      )}

      {!showResults && (
        <button
          onClick={checkAnswers}
          disabled={totalDebits !== totalCredits || totalDebits === 0}
          className="px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50"
        >
          Check Trial Balance
        </button>
      )}
    </div>
  );
}

// ============================================
// Adjusting Entries Builder Component (FA Course)
// ============================================
interface AdjustingEntriesBuilderProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

function AdjustingEntriesBuilder({ content, onComplete, completed }: AdjustingEntriesBuilderProps) {
  // This is similar to JournalEntryBuilder but with adjusting entries context
  const scenario = (content?.scenario as string) || "Prepare adjusting entries for the following period-end adjustments.";
  const companyName = (content?.company_name as string) || "Company";
  const adjustments = (content?.adjustments as JournalTransactionWithSolution[]) || [];
  const accountOptions = (content?.account_options as AccountOption[]) || [];
  const passingScore = (content?.passing_score as number) || 80;

  // Reuse the journal entry builder logic
  return (
    <JournalEntryBuilder 
      content={{ 
        scenario, 
        company_name: companyName, 
        transactions: adjustments, 
        account_options: accountOptions, 
        passing_score: passingScore 
      }} 
      onComplete={onComplete} 
      completed={completed} 
    />
  );
}

// ============================================
// CFS Classifier Component (FA Course)
// ============================================
interface CFSClassifierProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface CFSTransaction {
  id: string;
  description: string;
  correctCategory: 'operating' | 'investing' | 'financing';
  explanation: string;
}

type CFSCategory = 'operating' | 'investing' | 'financing';

function CFSClassifier({ content, onComplete, completed }: CFSClassifierProps) {
  const instructions = (content?.instructions as string) || 
    "Classify each transaction into the correct cash flow category: Operating, Investing, or Financing Activities.";
  const transactions = (content?.transactions as CFSTransaction[]) || [];
  const passingScore = (content?.passing_score as number) || 70;

  // Shuffle transactions on client side only
  const [shuffledTransactions, setShuffledTransactions] = useState<CFSTransaction[]>([]);
  const [isClient, setIsClient] = useState(false);
  
  useEffect(() => {
    setIsClient(true);
    if (transactions.length > 0) {
      const shuffled = [...transactions].sort(() => Math.random() - 0.5);
      setShuffledTransactions(shuffled);
    }
  }, [transactions]);

  // Track classifications: transaction id -> user's selected category
  const [classifications, setClassifications] = useState<Record<string, CFSCategory | null>>({});
  const [draggedId, setDraggedId] = useState<string | null>(null);
  const [showResults, setShowResults] = useState(false);
  const [score, setScore] = useState<number | null>(null);

  const categories: { id: CFSCategory; label: string; description: string; color: string }[] = [
    { 
      id: 'operating', 
      label: 'Operating Activities', 
      description: 'Day-to-day business operations',
      color: 'emerald'
    },
    { 
      id: 'investing', 
      label: 'Investing Activities', 
      description: 'Long-term asset transactions',
      color: 'blue'
    },
    { 
      id: 'financing', 
      label: 'Financing Activities', 
      description: 'Debt and equity transactions',
      color: 'violet'
    },
  ];

  const handleDragStart = (transactionId: string) => {
    if (completed || showResults) return;
    setDraggedId(transactionId);
  };

  const handleDrop = (category: CFSCategory) => {
    if (!draggedId || completed || showResults) return;
    
    setClassifications(prev => ({
      ...prev,
      [draggedId]: category
    }));
    setDraggedId(null);
  };

  const handleClickClassify = (transactionId: string, category: CFSCategory) => {
    if (completed || showResults) return;
    
    // Toggle: if already in this category, remove it
    setClassifications(prev => {
      if (prev[transactionId] === category) {
        const updated = { ...prev };
        delete updated[transactionId];
        return updated;
      }
      return { ...prev, [transactionId]: category };
    });
  };

  const handleCheckAnswers = () => {
    const totalTransactions = shuffledTransactions.length;
    const classifiedCount = Object.keys(classifications).length;
    
    if (classifiedCount < totalTransactions) return;

    let correctCount = 0;
    shuffledTransactions.forEach(tx => {
      if (classifications[tx.id] === tx.correctCategory) {
        correctCount++;
      }
    });

    const scorePercent = Math.round((correctCount / totalTransactions) * 100);
    setScore(scorePercent);
    setShowResults(true);

    if (scorePercent >= passingScore) {
      onComplete();
    }
  };

  const handleReset = () => {
    setClassifications({});
    setShowResults(false);
    setScore(null);
  };

  const getTransactionsForCategory = (category: CFSCategory) => {
    return shuffledTransactions.filter(tx => classifications[tx.id] === category);
  };

  const getUnclassifiedTransactions = () => {
    return shuffledTransactions.filter(tx => !classifications[tx.id]);
  };

  const isTransactionCorrect = (tx: CFSTransaction): boolean | null => {
    if (!showResults) return null;
    return classifications[tx.id] === tx.correctCategory;
  };

  // Loading state
  if (!isClient || shuffledTransactions.length === 0) {
    return (
      <div className="text-center py-8">
        <div className="animate-pulse">
          <div className="h-4 bg-slate-200 rounded w-3/4 mx-auto mb-4"></div>
          <div className="grid grid-cols-3 gap-4 mb-6">
            {[1, 2, 3].map(i => (
              <div key={i} className="h-32 bg-slate-100 rounded-xl"></div>
            ))}
          </div>
          <div className="space-y-2">
            {[1, 2, 3, 4].map(i => (
              <div key={i} className="h-12 bg-slate-100 rounded-lg"></div>
            ))}
          </div>
        </div>
      </div>
    );
  }

  const unclassified = getUnclassifiedTransactions();
  const allClassified = unclassified.length === 0;

  return (
    <div>
      <p className="text-[var(--foreground-muted)] mb-6">{instructions}</p>

      {/* Interaction hint */}
      {!showResults && !completed && (
        <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)] mb-4 p-3 bg-blue-50 border border-blue-100 rounded-lg">
          <GripVertical className="w-4 h-4 text-blue-500" />
          <span>Drag transactions to categories, or click a transaction then click a category</span>
        </div>
      )}

      {/* Category drop zones */}
      <div className="grid md:grid-cols-3 gap-4 mb-6">
        {categories.map(cat => {
          const transactionsInCategory = getTransactionsForCategory(cat.id);
          const colorMap = {
            emerald: { bg: 'bg-emerald-50', border: 'border-emerald-200', text: 'text-emerald-700', header: 'bg-emerald-100' },
            blue: { bg: 'bg-blue-50', border: 'border-blue-200', text: 'text-blue-700', header: 'bg-blue-100' },
            violet: { bg: 'bg-violet-50', border: 'border-violet-200', text: 'text-violet-700', header: 'bg-violet-100' },
          };
          const colorClasses = colorMap[cat.color as keyof typeof colorMap] || colorMap.blue;

          return (
            <div
              key={cat.id}
              onDragOver={(e) => {
                if (!completed && !showResults) e.preventDefault();
              }}
              onDrop={() => handleDrop(cat.id)}
              className={`
                rounded-xl border-2 transition-all min-h-[180px]
                ${colorClasses.border} ${colorClasses.bg}
                ${!completed && !showResults && draggedId ? 'ring-2 ring-offset-2 ring-' + cat.color + '-300' : ''}
              `}
            >
              <div className={`px-4 py-3 ${colorClasses.header} rounded-t-lg border-b ${colorClasses.border}`}>
                <h4 className={`font-semibold ${colorClasses.text}`}>{cat.label}</h4>
                <p className="text-xs text-slate-500">{cat.description}</p>
              </div>
              
              <div className="p-3 space-y-2">
                {transactionsInCategory.length === 0 && !showResults && (
                  <div className="text-center py-6 text-sm text-slate-400 border-2 border-dashed border-slate-200 rounded-lg">
                    Drop transactions here
                  </div>
                )}
                
                {transactionsInCategory.map(tx => {
                  const isCorrect = isTransactionCorrect(tx);
                  
                  return (
                    <div
                      key={tx.id}
                      className={`
                        px-3 py-2 rounded-lg text-sm transition-all
                        ${showResults 
                          ? isCorrect 
                            ? 'bg-emerald-100 border border-emerald-300' 
                            : 'bg-red-100 border border-red-300'
                          : 'bg-white border border-slate-200 shadow-sm'
                        }
                      `}
                    >
                      <div className="flex items-start gap-2">
                        <span className="flex-1">{tx.description}</span>
                        {showResults && (
                          <span className={isCorrect ? 'text-emerald-600' : 'text-red-600'}>
                            {isCorrect ? <CheckCircle2 className="w-4 h-4" /> : <X className="w-4 h-4" />}
                          </span>
                        )}
                      </div>
                      {showResults && !isCorrect && (
                        <div className="mt-2 pt-2 border-t border-red-200">
                          <p className="text-xs text-red-700">
                            Correct: <strong>{categories.find(c => c.id === tx.correctCategory)?.label}</strong>
                          </p>
                          <p className="text-xs text-slate-600 mt-1">{tx.explanation}</p>
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            </div>
          );
        })}
      </div>

      {/* Unclassified transactions */}
      {!showResults && unclassified.length > 0 && (
        <div className="mb-6">
          <h4 className="text-sm font-medium text-slate-600 mb-3">
            Transactions to classify ({unclassified.length} remaining)
          </h4>
          <div className="space-y-2">
            {unclassified.map(tx => (
              <div
                key={tx.id}
                draggable={!completed && !showResults}
                onDragStart={() => handleDragStart(tx.id)}
                onDragEnd={() => setDraggedId(null)}
                className={`
                  p-4 rounded-xl border-2 transition-all text-sm
                  ${!completed && !showResults ? 'cursor-grab active:cursor-grabbing hover:border-violet-300' : 'cursor-default'}
                  ${draggedId === tx.id ? 'border-violet-500 bg-violet-50 opacity-50' : 'border-slate-200 bg-white'}
                `}
              >
                <div className="flex items-center gap-3">
                  {!completed && !showResults && (
                    <GripVertical className="w-4 h-4 text-slate-400 flex-shrink-0" />
                  )}
                  <span className="flex-1">{tx.description}</span>
                  
                  {/* Quick classify buttons */}
                  {!completed && !showResults && (
                    <div className="flex gap-1">
                      {categories.map(cat => (
                        <button
                          key={cat.id}
                          onClick={() => handleClickClassify(tx.id, cat.id)}
                          className={`
                            px-2 py-1 text-xs rounded font-medium transition-colors
                            ${cat.color === 'emerald' ? 'bg-emerald-100 text-emerald-700 hover:bg-emerald-200' : ''}
                            ${cat.color === 'blue' ? 'bg-blue-100 text-blue-700 hover:bg-blue-200' : ''}
                            ${cat.color === 'violet' ? 'bg-violet-100 text-violet-700 hover:bg-violet-200' : ''}
                          `}
                          title={cat.label}
                        >
                          {cat.label.charAt(0)}
                        </button>
                      ))}
                    </div>
                  )}
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Actions */}
      {!completed && !showResults && (
        <div className="flex items-center justify-between">
          <p className="text-sm text-[var(--foreground-muted)]">
            {shuffledTransactions.length - unclassified.length} / {shuffledTransactions.length} classified
          </p>
          <button
            onClick={handleCheckAnswers}
            disabled={!allClassified}
            className="px-6 py-2.5 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Check Answers
          </button>
        </div>
      )}

      {/* Results */}
      {showResults && (
        <div className={`p-4 rounded-xl border ${score !== null && score >= passingScore ? 'bg-emerald-50 border-emerald-200' : 'bg-amber-50 border-amber-200'}`}>
          <div className="flex items-center justify-between">
            <div>
              <p className={`font-medium ${score !== null && score >= passingScore ? 'text-emerald-700' : 'text-amber-700'}`}>
                Score: {score}%
              </p>
              <p className="text-sm text-[var(--foreground-muted)]">
                {score !== null && score >= passingScore 
                  ? 'Excellent! You understand cash flow classification.' 
                  : `You need ${passingScore}% to pass. Review the categories and try again.`}
              </p>
            </div>
            {score !== null && score < passingScore && (
              <button
                onClick={handleReset}
                className="flex items-center gap-2 px-4 py-2 text-amber-700 hover:bg-amber-100 rounded-lg transition-colors"
              >
                <RotateCcw className="w-4 h-4" />
                Try Again
              </button>
            )}
          </div>
        </div>
      )}

      {completed && !showResults && (
        <div className="p-4 bg-emerald-50 border border-emerald-200 rounded-xl text-center">
          <p className="text-emerald-700 font-medium">Exercise completed!</p>
        </div>
      )}
    </div>
  );
}

// ============================================
// Mock Exam Viewer Component (FA Course)
// ============================================
interface MockExamViewerProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface ExamQuestion {
  id: string;
  type: 'mcq' | 'calculation' | 'short-answer';
  topic: string;
  question: string;
  options?: string[];
  correctAnswer: string | number;
  points: number;
  explanation: string;
  hint?: string;
}

interface ExamSection {
  id: string;
  title: string;
  questions: ExamQuestion[];
}

function MockExamViewer({ content, onComplete, completed }: MockExamViewerProps) {
  const examTitle = (content?.exam_title as string) || "Practice Exam";
  const instructions = (content?.instructions as string) || 
    "Complete all sections within the time limit. You can navigate between questions and review your answers before submitting.";
  const sections = (content?.sections as ExamSection[]) || [];
  const timeLimitMinutes = (content?.time_limit_minutes as number) || 90;
  const passingScore = (content?.passing_score as number) || 60;

  const [examStarted, setExamStarted] = useState(false);
  const [examFinished, setExamFinished] = useState(false);
  const [timeRemaining, setTimeRemaining] = useState(timeLimitMinutes * 60); // seconds
  const [currentSectionIndex, setCurrentSectionIndex] = useState(0);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState<Record<string, string | number>>({});
  const [showReview, setShowReview] = useState(false);
  const [results, setResults] = useState<{
    totalPoints: number;
    earnedPoints: number;
    scorePercent: number;
    questionResults: { questionId: string; isCorrect: boolean; userAnswer: string | number; correctAnswer: string | number }[];
    topicBreakdown: Record<string, { correct: number; total: number }>;
  } | null>(null);

  // Get all questions flat
  const allQuestions = sections.flatMap(s => s.questions);
  const totalQuestions = allQuestions.length;
  const totalPoints = allQuestions.reduce((sum, q) => sum + q.points, 0);

  const currentSection = sections[currentSectionIndex];
  const currentQuestion = currentSection?.questions[currentQuestionIndex];

  // Calculate global question index
  const getGlobalIndex = (sectionIdx: number, questionIdx: number) => {
    let idx = 0;
    for (let i = 0; i < sectionIdx; i++) {
      idx += sections[i].questions.length;
    }
    return idx + questionIdx;
  };

  const globalQuestionIndex = getGlobalIndex(currentSectionIndex, currentQuestionIndex);

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const handleSubmitExam = useCallback(() => {
    // Grade the exam
    const questionResults: { questionId: string; isCorrect: boolean; userAnswer: string | number; correctAnswer: string | number }[] = [];
    const topicBreakdown: Record<string, { correct: number; total: number }> = {};
    let earnedPoints = 0;

    allQuestions.forEach(q => {
      const userAnswer = answers[q.id];
      let isCorrect = false;

      if (q.type === 'calculation') {
        const userNum = parseFloat(String(userAnswer || '').replace(/,/g, ''));
        const correctNum = typeof q.correctAnswer === 'number' ? q.correctAnswer : parseFloat(String(q.correctAnswer));
        isCorrect = !isNaN(userNum) && Math.abs(userNum - correctNum) < 0.01;
      } else {
        isCorrect = String(userAnswer || '').toLowerCase().trim() === String(q.correctAnswer).toLowerCase().trim();
      }

      if (isCorrect) {
        earnedPoints += q.points;
      }

      questionResults.push({
        questionId: q.id,
        isCorrect,
        userAnswer: userAnswer ?? '',
        correctAnswer: q.correctAnswer
      });

      // Topic breakdown
      if (!topicBreakdown[q.topic]) {
        topicBreakdown[q.topic] = { correct: 0, total: 0 };
      }
      topicBreakdown[q.topic].total++;
      if (isCorrect) topicBreakdown[q.topic].correct++;
    });

    const scorePercent = Math.round((earnedPoints / totalPoints) * 100);

    setResults({
      totalPoints,
      earnedPoints,
      scorePercent,
      questionResults,
      topicBreakdown
    });
    setExamFinished(true);

    if (scorePercent >= passingScore) {
      onComplete();
    }
  }, [allQuestions, answers, totalPoints, passingScore, onComplete]);

  // Timer effect
  useEffect(() => {
    if (!examStarted || examFinished || completed) return;

    if (timeRemaining <= 0) {
      handleSubmitExam();
      return;
    }

    const timer = setInterval(() => {
      setTimeRemaining(prev => prev - 1);
    }, 1000);

    return () => clearInterval(timer);
  }, [examStarted, examFinished, timeRemaining, completed, handleSubmitExam]);

  const handleStartExam = () => {
    setExamStarted(true);
    setTimeRemaining(timeLimitMinutes * 60);
  };

  const handleAnswerChange = (questionId: string, answer: string | number) => {
    setAnswers(prev => ({ ...prev, [questionId]: answer }));
  };

  const navigateToQuestion = (sectionIdx: number, questionIdx: number) => {
    setCurrentSectionIndex(sectionIdx);
    setCurrentQuestionIndex(questionIdx);
    setShowReview(false);
  };

  const handleNext = () => {
    if (currentQuestionIndex < currentSection.questions.length - 1) {
      setCurrentQuestionIndex(prev => prev + 1);
    } else if (currentSectionIndex < sections.length - 1) {
      setCurrentSectionIndex(prev => prev + 1);
      setCurrentQuestionIndex(0);
    } else {
      setShowReview(true);
    }
  };

  const handlePrevious = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(prev => prev - 1);
    } else if (currentSectionIndex > 0) {
      setCurrentSectionIndex(prev => prev - 1);
      setCurrentQuestionIndex(sections[currentSectionIndex - 1].questions.length - 1);
    }
  };

  const answeredCount = Object.keys(answers).length;
  const isQuestionAnswered = (questionId: string) => answers[questionId] !== undefined && answers[questionId] !== '';

  // Not started state
  if (!examStarted && !completed) {
    return (
      <div className="text-center py-8">
        <div className="w-20 h-20 bg-violet-100 rounded-full flex items-center justify-center mx-auto mb-6">
          <BookOpen className="w-10 h-10 text-violet-600" />
        </div>
        
        <h3 className="text-2xl font-bold mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
          {examTitle}
        </h3>
        
        <p className="text-[var(--foreground-muted)] mb-6 max-w-lg mx-auto">
          {instructions}
        </p>

        <div className="bg-slate-50 border border-slate-200 rounded-xl p-6 max-w-md mx-auto mb-6">
          <div className="grid grid-cols-2 gap-4 text-sm">
            <div>
              <p className="text-slate-500">Time Limit</p>
              <p className="font-semibold text-slate-800">{timeLimitMinutes} minutes</p>
            </div>
            <div>
              <p className="text-slate-500">Questions</p>
              <p className="font-semibold text-slate-800">{totalQuestions} questions</p>
            </div>
            <div>
              <p className="text-slate-500">Total Points</p>
              <p className="font-semibold text-slate-800">{totalPoints} points</p>
            </div>
            <div>
              <p className="text-slate-500">Passing Score</p>
              <p className="font-semibold text-slate-800">{passingScore}%</p>
            </div>
          </div>
        </div>

        <div className="bg-amber-50 border border-amber-200 rounded-xl p-4 max-w-md mx-auto mb-6">
          <div className="flex items-start gap-3">
            <Lightbulb className="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" />
            <div className="text-sm text-amber-800 text-left">
              <p className="font-medium mb-1">Before you begin:</p>
              <ul className="list-disc list-inside space-y-1 text-amber-700">
                <li>Find a quiet place without distractions</li>
                <li>Have a calculator ready if needed</li>
                <li>The timer starts when you click Start</li>
              </ul>
            </div>
          </div>
        </div>

        <button
          onClick={handleStartExam}
          className="px-8 py-4 bg-violet-600 text-white font-semibold rounded-xl hover:bg-violet-700 transition-colors text-lg"
        >
          Start Exam
        </button>
      </div>
    );
  }

  // Results state
  if (examFinished && results) {
    return (
      <div>
        {/* Score header */}
        <div className={`text-center p-8 rounded-xl mb-6 ${results.scorePercent >= passingScore ? 'bg-emerald-50 border border-emerald-200' : 'bg-amber-50 border border-amber-200'}`}>
          <div className={`w-24 h-24 rounded-full flex items-center justify-center mx-auto mb-4 ${results.scorePercent >= passingScore ? 'bg-emerald-100' : 'bg-amber-100'}`}>
            <span className={`text-3xl font-bold ${results.scorePercent >= passingScore ? 'text-emerald-700' : 'text-amber-700'}`}>
              {results.scorePercent}%
            </span>
          </div>
          
          <h3 className="text-xl font-bold mb-2">
            {results.scorePercent >= passingScore ? 'Congratulations!' : 'Keep Practicing!'}
          </h3>
          <p className="text-[var(--foreground-muted)]">
            You scored {results.earnedPoints} out of {results.totalPoints} points.
            {results.scorePercent < passingScore && ` You need ${passingScore}% to pass.`}
          </p>
        </div>

        {/* Topic breakdown */}
        <div className="bg-white border border-slate-200 rounded-xl p-6 mb-6">
          <h4 className="font-semibold text-slate-800 mb-4">Performance by Topic</h4>
          <div className="space-y-3">
            {Object.entries(results.topicBreakdown).map(([topic, stats]) => {
              const percent = Math.round((stats.correct / stats.total) * 100);
              return (
                <div key={topic}>
                  <div className="flex items-center justify-between text-sm mb-1">
                    <span className="text-slate-700">{topic}</span>
                    <span className={`font-medium ${percent >= 70 ? 'text-emerald-600' : percent >= 50 ? 'text-amber-600' : 'text-red-600'}`}>
                      {stats.correct}/{stats.total} ({percent}%)
                    </span>
                  </div>
                  <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
                    <div
                      className={`h-full transition-all ${percent >= 70 ? 'bg-emerald-500' : percent >= 50 ? 'bg-amber-500' : 'bg-red-500'}`}
                      style={{ width: `${percent}%` }}
                    />
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* Question review */}
        <div className="bg-white border border-slate-200 rounded-xl p-6">
          <h4 className="font-semibold text-slate-800 mb-4">Question Review</h4>
          <div className="space-y-4">
            {sections.map((section, sIdx) => (
              <div key={section.id}>
                <h5 className="text-sm font-medium text-slate-500 mb-2">{section.title}</h5>
                <div className="space-y-3">
                  {section.questions.map((q, qIdx) => {
                    const result = results.questionResults.find(r => r.questionId === q.id);
                    return (
                      <div
                        key={q.id}
                        className={`p-4 rounded-lg border ${result?.isCorrect ? 'bg-emerald-50 border-emerald-200' : 'bg-red-50 border-red-200'}`}
                      >
                        <div className="flex items-start gap-3">
                          <span className={`flex-shrink-0 w-6 h-6 rounded-full flex items-center justify-center text-xs font-medium ${result?.isCorrect ? 'bg-emerald-100 text-emerald-700' : 'bg-red-100 text-red-700'}`}>
                            {getGlobalIndex(sIdx, qIdx) + 1}
                          </span>
                          <div className="flex-1">
                            <p className="text-sm text-slate-800 mb-2">{q.question}</p>
                            <div className="text-xs space-y-1">
                              <p className={result?.isCorrect ? 'text-emerald-700' : 'text-red-700'}>
                                Your answer: {String(result?.userAnswer) || '(no answer)'}
                              </p>
                              {!result?.isCorrect && (
                                <p className="text-emerald-700">
                                  Correct answer: {String(q.correctAnswer)}
                                </p>
                              )}
                              <p className="text-slate-600 mt-2">{q.explanation}</p>
                            </div>
                          </div>
                          <span className="text-xs text-slate-500">{q.points} pts</span>
                        </div>
                      </div>
                    );
                  })}
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  }

  // Review state before submit
  if (showReview) {
    return (
      <div>
        {/* Timer */}
        <div className={`flex items-center justify-between mb-6 p-4 rounded-xl ${timeRemaining <= 300 ? 'bg-red-50 border border-red-200' : 'bg-slate-50 border border-slate-200'}`}>
          <span className="text-sm text-slate-600">Time Remaining</span>
          <span className={`text-2xl font-mono font-bold ${timeRemaining <= 300 ? 'text-red-600' : 'text-slate-800'}`}>
            {formatTime(timeRemaining)}
          </span>
        </div>

        <h3 className="text-xl font-bold mb-4">Review Your Answers</h3>
        <p className="text-[var(--foreground-muted)] mb-6">
          Review your answers before submitting. Click on any question to go back and change your answer.
        </p>

        <div className="space-y-4 mb-6">
          {sections.map((section, sIdx) => (
            <div key={section.id} className="bg-white border border-slate-200 rounded-xl p-4">
              <h4 className="font-medium text-slate-700 mb-3">{section.title}</h4>
              <div className="grid grid-cols-5 gap-2">
                {section.questions.map((q, qIdx) => {
                  const answered = isQuestionAnswered(q.id);
                  return (
                    <button
                      key={q.id}
                      onClick={() => navigateToQuestion(sIdx, qIdx)}
                      className={`
                        w-10 h-10 rounded-lg font-medium text-sm transition-colors
                        ${answered 
                          ? 'bg-emerald-100 text-emerald-700 hover:bg-emerald-200' 
                          : 'bg-amber-100 text-amber-700 hover:bg-amber-200'
                        }
                      `}
                    >
                      {getGlobalIndex(sIdx, qIdx) + 1}
                    </button>
                  );
                })}
              </div>
            </div>
          ))}
        </div>

        <div className="flex items-center justify-between">
          <div className="text-sm text-slate-600">
            <span className="inline-flex items-center gap-1">
              <span className="w-3 h-3 rounded bg-emerald-100"></span> Answered
            </span>
            <span className="inline-flex items-center gap-1 ml-4">
              <span className="w-3 h-3 rounded bg-amber-100"></span> Unanswered
            </span>
          </div>
          
          <div className="flex gap-3">
            <button
              onClick={() => setShowReview(false)}
              className="px-6 py-3 border border-slate-300 text-slate-700 font-medium rounded-xl hover:bg-slate-50 transition-colors"
            >
              Back to Questions
            </button>
            <button
              onClick={handleSubmitExam}
              className="px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors"
            >
              Submit Exam
            </button>
          </div>
        </div>
      </div>
    );
  }

  // Active exam state
  if (!currentQuestion) {
    return <div className="text-center py-8 text-slate-500">No questions available.</div>;
  }

  return (
    <div>
      {/* Timer and progress */}
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-4">
          <span className="text-sm text-slate-600">
            Question {globalQuestionIndex + 1} of {totalQuestions}
          </span>
          <span className="text-xs px-2 py-1 bg-slate-100 rounded-full text-slate-600">
            {currentSection.title}
          </span>
        </div>
        <div className={`flex items-center gap-2 px-4 py-2 rounded-xl ${timeRemaining <= 300 ? 'bg-red-100 text-red-700' : 'bg-slate-100 text-slate-700'}`}>
          <span className="text-sm">Time:</span>
          <span className="font-mono font-bold">{formatTime(timeRemaining)}</span>
        </div>
      </div>

      {/* Progress bar */}
      <div className="h-2 bg-slate-100 rounded-full mb-6 overflow-hidden">
        <div
          className="h-full bg-violet-500 transition-all"
          style={{ width: `${((globalQuestionIndex + 1) / totalQuestions) * 100}%` }}
        />
      </div>

      {/* Question */}
      <div className="bg-white border border-slate-200 rounded-xl p-6 mb-6">
        <div className="flex items-start justify-between mb-4">
          <span className="text-xs px-2 py-1 bg-violet-100 text-violet-700 rounded-full">
            {currentQuestion.topic}
          </span>
          <span className="text-sm text-slate-500">{currentQuestion.points} points</span>
        </div>

        <p className="text-lg text-slate-800 mb-6">{currentQuestion.question}</p>

        {/* MCQ options */}
        {currentQuestion.type === 'mcq' && currentQuestion.options && (
          <div className="space-y-3">
            {currentQuestion.options.map((option, idx) => (
              <button
                key={idx}
                onClick={() => handleAnswerChange(currentQuestion.id, option)}
                className={`
                  w-full text-left p-4 rounded-xl border-2 transition-all
                  ${answers[currentQuestion.id] === option 
                    ? 'border-violet-500 bg-violet-50' 
                    : 'border-slate-200 hover:border-violet-300'
                  }
                `}
              >
                <span className="flex items-center gap-3">
                  <span className={`
                    w-6 h-6 rounded-full border-2 flex items-center justify-center text-xs font-medium
                    ${answers[currentQuestion.id] === option 
                      ? 'border-violet-500 bg-violet-500 text-white' 
                      : 'border-slate-300'
                    }
                  `}>
                    {String.fromCharCode(65 + idx)}
                  </span>
                  <span className="text-slate-700">{option}</span>
                </span>
              </button>
            ))}
          </div>
        )}

        {/* Calculation/short answer input */}
        {(currentQuestion.type === 'calculation' || currentQuestion.type === 'short-answer') && (
          <div>
            <input
              type={currentQuestion.type === 'calculation' ? 'number' : 'text'}
              value={answers[currentQuestion.id] || ''}
              onChange={(e) => handleAnswerChange(currentQuestion.id, e.target.value)}
              placeholder={currentQuestion.type === 'calculation' ? 'Enter your calculated answer...' : 'Enter your answer...'}
              className="w-full px-4 py-3 border-2 border-slate-200 rounded-xl focus:outline-none focus:border-violet-500"
            />
            {currentQuestion.hint && (
              <p className="text-sm text-slate-500 mt-2">Hint: {currentQuestion.hint}</p>
            )}
          </div>
        )}
      </div>

      {/* Navigation */}
      <div className="flex items-center justify-between">
        <button
          onClick={handlePrevious}
          disabled={globalQuestionIndex === 0}
          className="px-6 py-3 border border-slate-300 text-slate-700 font-medium rounded-xl hover:bg-slate-50 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Previous
        </button>

        <div className="text-sm text-slate-500">
          {answeredCount}/{totalQuestions} answered
        </div>

        <button
          onClick={handleNext}
          className="flex items-center gap-2 px-6 py-3 bg-violet-600 text-white font-medium rounded-xl hover:bg-violet-700 transition-colors"
        >
          {globalQuestionIndex === totalQuestions - 1 ? 'Review Answers' : 'Next'}
          <ArrowRight className="w-4 h-4" />
        </button>
      </div>

      {/* Quick navigation */}
      <div className="mt-6 pt-6 border-t border-slate-200">
        <p className="text-xs text-slate-500 mb-2">Quick Navigation</p>
        <div className="flex flex-wrap gap-1">
          {sections.map((section, sIdx) => 
            section.questions.map((q, qIdx) => {
              const gIdx = getGlobalIndex(sIdx, qIdx);
              const answered = isQuestionAnswered(q.id);
              const isCurrent = gIdx === globalQuestionIndex;
              
              return (
                <button
                  key={q.id}
                  onClick={() => navigateToQuestion(sIdx, qIdx)}
                  className={`
                    w-8 h-8 rounded text-xs font-medium transition-colors
                    ${isCurrent 
                      ? 'bg-violet-600 text-white' 
                      : answered 
                        ? 'bg-emerald-100 text-emerald-700 hover:bg-emerald-200' 
                        : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                    }
                  `}
                >
                  {gIdx + 1}
                </button>
              );
            })
          )}
        </div>
      </div>
    </div>
  );
}

// Inventory Calculator Component
interface InventoryCalculatorProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface InventoryTransaction {
  transaction: string;
  date: string;
  units: number;
  unit_cost: number;
}

interface InventoryQuestion {
  id: string;
  question: string;
  answer_type: string;
  correct_answer: number;
  tolerance?: number;
  hint?: string;
  explanation: string;
}

function InventoryCalculator({ content, onComplete, completed }: InventoryCalculatorProps) {
  const title = (content?.title as string) || "Inventory Costing Exercise";
  const description = (content?.description as string) || "";
  const companyBackground = (content?.company_background as string) || "";
  const inventoryData = (content?.inventory_data as InventoryTransaction[]) || [];
  const unitsSold = (content?.units_sold as number) || 0;
  const questions = (content?.questions as InventoryQuestion[]) || [];
  const passingScore = (content?.passing_score as number) || 70;
  
  const [userAnswers, setUserAnswers] = useState<Record<string, string>>({});
  const [showResults, setShowResults] = useState(false);
  const [score, setScore] = useState(0);
  
  // Calculate totals for reference
  const totalUnits = inventoryData.reduce((sum, t) => sum + t.units, 0);
  const totalCost = inventoryData.reduce((sum, t) => sum + (t.units * t.unit_cost), 0);
  const endingUnits = totalUnits - unitsSold;
  
  const handleAnswerChange = (questionId: string, value: string) => {
    if (showResults || completed) return;
    setUserAnswers(prev => ({ ...prev, [questionId]: value }));
  };
  
  const checkAnswers = () => {
    let correctCount = 0;
    questions.forEach(q => {
      const userValue = parseFloat(userAnswers[q.id] || '0');
      const tolerance = q.tolerance || 0;
      if (Math.abs(userValue - q.correct_answer) <= tolerance) {
        correctCount++;
      }
    });
    
    const scorePercent = Math.round((correctCount / questions.length) * 100);
    setScore(scorePercent);
    setShowResults(true);
    
    if (scorePercent >= passingScore) {
      onComplete();
    }
  };
  
  const isCorrect = (q: InventoryQuestion): boolean => {
    const userValue = parseFloat(userAnswers[q.id] || '0');
    const tolerance = q.tolerance || 0;
    return Math.abs(userValue - q.correct_answer) <= tolerance;
  };
  
  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('de-CH', { minimumFractionDigits: 0, maximumFractionDigits: 2 }).format(amount);
  };

  if (questions.length === 0) {
    return <div className="text-center text-[var(--foreground-muted)]">No questions available.</div>;
  }

  return (
    <div className="space-y-6">
      {/* Title and Description */}
      <div>
        <h2 className="text-xl font-bold text-slate-800 mb-2">{title}</h2>
        {description && <p className="text-slate-600">{description}</p>}
        {companyBackground && (
          <p className="text-sm text-slate-500 mt-2 italic">{companyBackground}</p>
        )}
      </div>

      {/* Inventory Data Table */}
      {inventoryData.length > 0 && (
        <div className="bg-slate-50 border border-slate-200 rounded-xl p-4">
          <h3 className="font-semibold text-slate-700 mb-3">Inventory Transactions</h3>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b border-slate-300">
                  <th className="text-left py-2 px-3 font-semibold text-slate-600">Transaction</th>
                  <th className="text-left py-2 px-3 font-semibold text-slate-600">Date</th>
                  <th className="text-right py-2 px-3 font-semibold text-slate-600">Units</th>
                  <th className="text-right py-2 px-3 font-semibold text-slate-600">Unit Cost</th>
                  <th className="text-right py-2 px-3 font-semibold text-slate-600">Total Cost</th>
                </tr>
              </thead>
              <tbody>
                {inventoryData.map((t, idx) => (
                  <tr key={idx} className="border-b border-slate-200">
                    <td className="py-2 px-3 text-slate-700">{t.transaction}</td>
                    <td className="py-2 px-3 text-slate-500">{t.date}</td>
                    <td className="py-2 px-3 text-right font-mono text-slate-700">{t.units}</td>
                    <td className="py-2 px-3 text-right font-mono text-slate-700">CHF {formatCurrency(t.unit_cost)}</td>
                    <td className="py-2 px-3 text-right font-mono text-slate-700">CHF {formatCurrency(t.units * t.unit_cost)}</td>
                  </tr>
                ))}
              </tbody>
              <tfoot>
                <tr className="bg-slate-100 font-semibold">
                  <td className="py-2 px-3 text-slate-800" colSpan={2}>Total Available</td>
                  <td className="py-2 px-3 text-right font-mono text-slate-800">{totalUnits}</td>
                  <td className="py-2 px-3"></td>
                  <td className="py-2 px-3 text-right font-mono text-slate-800">CHF {formatCurrency(totalCost)}</td>
                </tr>
              </tfoot>
            </table>
          </div>
          
          {unitsSold > 0 && (
            <div className="mt-3 pt-3 border-t border-slate-200 flex gap-6 text-sm">
              <div>
                <span className="text-slate-500">Units Sold:</span>
                <span className="font-semibold text-slate-700 ml-2">{unitsSold}</span>
              </div>
              <div>
                <span className="text-slate-500">Ending Units:</span>
                <span className="font-semibold text-slate-700 ml-2">{endingUnits}</span>
              </div>
            </div>
          )}
        </div>
      )}

      {/* Questions */}
      <div className="space-y-4">
        <h3 className="font-semibold text-slate-700">Questions</h3>
        {questions.map((q, idx) => (
          <div 
            key={q.id} 
            className={`border rounded-xl p-4 transition-colors ${
              showResults 
                ? isCorrect(q) 
                  ? 'bg-emerald-50 border-emerald-200' 
                  : 'bg-red-50 border-red-200'
                : 'bg-white border-slate-200'
            }`}
          >
            <div className="flex items-start gap-3">
              <span className="flex-shrink-0 w-7 h-7 rounded-full bg-violet-100 text-violet-700 flex items-center justify-center text-sm font-medium">
                {idx + 1}
              </span>
              <div className="flex-1">
                <p className="text-slate-700 mb-3">{q.question}</p>
                
                {q.hint && !showResults && (
                  <p className="text-xs text-slate-500 mb-2 flex items-center gap-1">
                    <Lightbulb className="w-3 h-3" />
                    {q.hint}
                  </p>
                )}
                
                <div className="flex items-center gap-3">
                  <input
                    type="number"
                    value={userAnswers[q.id] || ''}
                    onChange={(e) => handleAnswerChange(q.id, e.target.value)}
                    disabled={showResults || completed}
                    placeholder="Enter your answer"
                    className="w-48 px-4 py-2 text-right font-mono border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-violet-500 disabled:bg-slate-100"
                    step="any"
                  />
                  {showResults && (
                    <span className={`text-sm font-medium ${isCorrect(q) ? 'text-emerald-600' : 'text-red-600'}`}>
                      {isCorrect(q) ? 'Correct' : `Correct: ${formatCurrency(q.correct_answer)}`}
                    </span>
                  )}
                </div>
                
                {showResults && q.explanation && (
                  <p className="mt-3 text-sm text-slate-600 bg-white/60 rounded-lg p-2">
                    {q.explanation}
                  </p>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Submit / Results */}
      {!showResults ? (
        <div className="flex justify-center">
          <button
            onClick={checkAnswers}
            disabled={Object.keys(userAnswers).length === 0}
            className="px-8 py-3 bg-violet-600 text-white font-semibold rounded-xl hover:bg-violet-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Check Answers
          </button>
        </div>
      ) : (
        <div className={`text-center p-6 rounded-xl ${score >= passingScore ? 'bg-emerald-50' : 'bg-amber-50'}`}>
          <div className={`w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4 ${score >= passingScore ? 'bg-emerald-100' : 'bg-amber-100'}`}>
            <span className={`text-2xl font-bold ${score >= passingScore ? 'text-emerald-700' : 'text-amber-700'}`}>{score}%</span>
          </div>
          <h3 className="text-xl font-bold mb-2">
            {score >= passingScore ? 'Great Job!' : 'Keep Practicing!'}
          </h3>
          <p className="text-slate-600">
            You got {Math.round((score / 100) * questions.length)} of {questions.length} correct.
            {score < passingScore && ` You need ${passingScore}% to pass.`}
          </p>
        </div>
      )}
    </div>
  );
}

// ============================================
// Review Calculator Component
// Handles question-based review exercises with numeric, choice, and text inputs
// ============================================
interface ReviewCalculatorProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface ReviewQuestion {
  id: string;
  question: string;
  answer_type: 'numeric' | 'choice' | 'text';
  correct_answer: string | number;
  tolerance?: number;
  options?: string[];
  hint?: string;
  explanation: string;
}

function ReviewCalculator({ content, onComplete, completed }: ReviewCalculatorProps) {
  const title = (content?.title as string) || "Review Practice";
  const description = (content?.description as string) || "Practice and review key concepts.";
  const topicsCovered = (content?.topics_covered as string[]) || [];
  const questions = (content?.questions as ReviewQuestion[]) || [];
  const passingScore = (content?.passing_score as number) || 70;

  const [currentIndex, setCurrentIndex] = useState(0);
  const [answers, setAnswers] = useState<Record<string, string | number>>({});
  const [showResults, setShowResults] = useState(false);
  const [showHint, setShowHint] = useState(false);
  const [questionResults, setQuestionResults] = useState<Record<string, boolean>>({});
  const [showExplanation, setShowExplanation] = useState<Record<string, boolean>>({});

  const currentQuestion = questions[currentIndex];
  const answeredCount = Object.keys(answers).length;
  const totalQuestions = questions.length;

  if (questions.length === 0) {
    return (
      <div className="text-center py-12">
        <div className="w-16 h-16 bg-amber-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <Calculator className="w-8 h-8 text-amber-600" />
        </div>
        <h3 className="text-lg font-semibold mb-2">{title}</h3>
        <p className="text-[var(--foreground-muted)]">{description}</p>
        <p className="text-sm text-amber-600 mt-4">
          No questions available for this review exercise.
        </p>
      </div>
    );
  }

  const checkAnswer = (questionId: string): boolean => {
    const question = questions.find(q => q.id === questionId);
    if (!question) return false;
    
    const userAnswer = answers[questionId];
    if (userAnswer === undefined || userAnswer === '') return false;

    switch (question.answer_type) {
      case 'numeric': {
        const numAnswer = typeof userAnswer === 'string' ? parseFloat(userAnswer.replace(/,/g, '')) : userAnswer;
        const correctNum = typeof question.correct_answer === 'string' 
          ? parseFloat(question.correct_answer) 
          : question.correct_answer;
        const tolerance = question.tolerance || 0;
        return Math.abs(numAnswer - correctNum) <= tolerance;
      }
      case 'choice':
      case 'text':
        return String(userAnswer).toLowerCase().trim() === String(question.correct_answer).toLowerCase().trim();
      default:
        return false;
    }
  };

  const handleSubmitQuestion = () => {
    if (!currentQuestion || answers[currentQuestion.id] === undefined) return;
    
    const isCorrect = checkAnswer(currentQuestion.id);
    setQuestionResults(prev => ({ ...prev, [currentQuestion.id]: isCorrect }));
    setShowExplanation(prev => ({ ...prev, [currentQuestion.id]: true }));
  };

  const handleNext = () => {
    setShowHint(false);
    if (currentIndex < questions.length - 1) {
      setCurrentIndex(prev => prev + 1);
    } else {
      // Calculate final results
      const results: Record<string, boolean> = {};
      questions.forEach(q => {
        results[q.id] = checkAnswer(q.id);
      });
      setQuestionResults(results);
      setShowResults(true);
      
      // Auto-complete if passing
      const correctCount = Object.values(results).filter(Boolean).length;
      const scorePercent = (correctCount / questions.length) * 100;
      if (scorePercent >= passingScore && !completed) {
        onComplete();
      }
    }
  };

  const handlePrevious = () => {
    setShowHint(false);
    if (currentIndex > 0) {
      setCurrentIndex(prev => prev - 1);
    }
  };

  const handleAnswerChange = (value: string | number) => {
    if (!currentQuestion) return;
    setAnswers(prev => ({ ...prev, [currentQuestion.id]: value }));
  };

  const handleRetry = () => {
    setAnswers({});
    setQuestionResults({});
    setShowExplanation({});
    setShowResults(false);
    setShowHint(false);
    setCurrentIndex(0);
  };

  // Results view
  if (showResults) {
    const correctCount = Object.values(questionResults).filter(Boolean).length;
    const scorePercent = Math.round((correctCount / totalQuestions) * 100);
    const passed = scorePercent >= passingScore;

    return (
      <div className="space-y-6">
        {/* Score Summary */}
        <div className={`p-6 rounded-xl text-center ${passed ? 'bg-emerald-50 border border-emerald-200' : 'bg-amber-50 border border-amber-200'}`}>
          <div className={`text-4xl font-bold mb-2 ${passed ? 'text-emerald-600' : 'text-amber-600'}`}>
            {scorePercent}%
          </div>
          <p className={`font-medium ${passed ? 'text-emerald-700' : 'text-amber-700'}`}>
            {correctCount} of {totalQuestions} correct
          </p>
          <p className={`text-sm mt-1 ${passed ? 'text-emerald-600' : 'text-amber-600'}`}>
            {passed ? 'Great job! You passed this review.' : `You need ${passingScore}% to pass.`}
          </p>
        </div>

        {/* Question Review */}
        <div className="space-y-4">
          <h4 className="font-semibold text-[var(--foreground)]">Question Review</h4>
          {questions.map((q, idx) => {
            const isCorrect = questionResults[q.id];
            const userAnswer = answers[q.id];
            
            return (
              <div key={q.id} className={`p-4 rounded-lg border ${isCorrect ? 'bg-emerald-50 border-emerald-200' : 'bg-red-50 border-red-200'}`}>
                <div className="flex items-start gap-3">
                  <div className={`w-6 h-6 rounded-full flex items-center justify-center flex-shrink-0 ${isCorrect ? 'bg-emerald-500' : 'bg-red-500'}`}>
                    {isCorrect ? (
                      <Check className="w-4 h-4 text-white" />
                    ) : (
                      <X className="w-4 h-4 text-white" />
                    )}
                  </div>
                  <div className="flex-1">
                    <p className="text-sm font-medium text-[var(--foreground)] mb-1">
                      {idx + 1}. {q.question}
                    </p>
                    <p className={`text-sm ${isCorrect ? 'text-emerald-700' : 'text-red-700'}`}>
                      Your answer: {userAnswer !== undefined ? String(userAnswer) : 'No answer'}
                      {!isCorrect && (
                        <span className="block text-emerald-700 mt-1">
                          Correct answer: {String(q.correct_answer)}
                        </span>
                      )}
                    </p>
                    <p className="text-sm text-[var(--foreground-muted)] mt-2 italic">
                      {q.explanation}
                    </p>
                  </div>
                </div>
              </div>
            );
          })}
        </div>

        {/* Retry Button */}
        {!passed && (
          <button
            onClick={handleRetry}
            className="flex items-center gap-2 px-4 py-2 bg-violet-600 text-white font-medium rounded-lg hover:bg-violet-700 transition-colors mx-auto"
          >
            <RotateCcw className="w-4 h-4" />
            Try Again
          </button>
        )}
      </div>
    );
  }

  const hasAnswered = currentQuestion && answers[currentQuestion.id] !== undefined && answers[currentQuestion.id] !== '';
  const questionSubmitted = currentQuestion && showExplanation[currentQuestion.id];

  return (
    <div className="space-y-6">
      {/* Header with Topics */}
      {topicsCovered.length > 0 && (
        <div className="flex flex-wrap gap-2">
          {topicsCovered.map((topic, idx) => (
            <span key={idx} className="px-3 py-1 bg-violet-100 text-violet-700 text-sm font-medium rounded-full">
              {topic}
            </span>
          ))}
        </div>
      )}

      {/* Progress */}
      <div className="flex items-center justify-between text-sm text-[var(--foreground-muted)]">
        <span>Question {currentIndex + 1} of {totalQuestions}</span>
        <span>{answeredCount} answered</span>
      </div>
      <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
        <div 
          className="h-full bg-violet-500 transition-all duration-300"
          style={{ width: `${((currentIndex + 1) / totalQuestions) * 100}%` }}
        />
      </div>

      {/* Question Card */}
      {currentQuestion && (
        <div className="bg-slate-50 rounded-xl p-6">
          <p className="text-lg font-medium text-[var(--foreground)] mb-6">
            {currentQuestion.question}
          </p>

          {/* Answer Input */}
          {currentQuestion.answer_type === 'choice' && currentQuestion.options ? (
            <div className="space-y-3">
              {currentQuestion.options.map((option, idx) => (
                <button
                  key={idx}
                  onClick={() => !questionSubmitted && handleAnswerChange(option)}
                  disabled={questionSubmitted}
                  className={`w-full p-4 rounded-lg border text-left transition-all ${
                    answers[currentQuestion.id] === option
                      ? questionSubmitted
                        ? checkAnswer(currentQuestion.id)
                          ? 'border-emerald-500 bg-emerald-50'
                          : 'border-red-500 bg-red-50'
                        : 'border-violet-500 bg-violet-50'
                      : 'border-slate-200 hover:border-slate-300 bg-white'
                  } ${questionSubmitted ? 'cursor-default' : ''}`}
                >
                  <span className="font-medium">{option}</span>
                  {questionSubmitted && option === String(currentQuestion.correct_answer) && (
                    <span className="ml-2 text-emerald-600">(Correct)</span>
                  )}
                </button>
              ))}
            </div>
          ) : currentQuestion.answer_type === 'numeric' ? (
            <div className="flex items-center gap-4">
              <input
                type="text"
                value={answers[currentQuestion.id] ?? ''}
                onChange={(e) => !questionSubmitted && handleAnswerChange(e.target.value)}
                disabled={questionSubmitted}
                placeholder="Enter your answer..."
                className={`flex-1 px-4 py-3 rounded-lg border text-lg font-mono focus:outline-none focus:ring-2 focus:ring-violet-500 ${
                  questionSubmitted
                    ? questionResults[currentQuestion.id]
                      ? 'border-emerald-500 bg-emerald-50'
                      : 'border-red-500 bg-red-50'
                    : 'border-slate-200'
                }`}
              />
              {questionSubmitted && !questionResults[currentQuestion.id] && (
                <span className="text-emerald-600 font-medium">
                  = {currentQuestion.correct_answer}
                </span>
              )}
            </div>
          ) : (
            <input
              type="text"
              value={answers[currentQuestion.id] ?? ''}
              onChange={(e) => !questionSubmitted && handleAnswerChange(e.target.value)}
              disabled={questionSubmitted}
              placeholder="Type your answer..."
              className={`w-full px-4 py-3 rounded-lg border focus:outline-none focus:ring-2 focus:ring-violet-500 ${
                questionSubmitted
                  ? questionResults[currentQuestion.id]
                    ? 'border-emerald-500 bg-emerald-50'
                    : 'border-red-500 bg-red-50'
                  : 'border-slate-200'
              }`}
            />
          )}

          {/* Hint */}
          {currentQuestion.hint && !questionSubmitted && (
            <div className="mt-4">
              {showHint ? (
                <div className="p-3 bg-blue-50 border border-blue-200 rounded-lg text-sm text-blue-700">
                  <strong>Hint:</strong> {currentQuestion.hint}
                </div>
              ) : (
                <button
                  onClick={() => setShowHint(true)}
                  className="flex items-center gap-2 text-sm text-blue-600 hover:text-blue-700"
                >
                  <HelpCircle className="w-4 h-4" />
                  Show Hint
                </button>
              )}
            </div>
          )}

          {/* Explanation (after submit) */}
          {questionSubmitted && (
            <div className={`mt-4 p-4 rounded-lg ${
              questionResults[currentQuestion.id] 
                ? 'bg-emerald-50 border border-emerald-200' 
                : 'bg-amber-50 border border-amber-200'
            }`}>
              <div className="flex items-start gap-2">
                {questionResults[currentQuestion.id] ? (
                  <CheckCircle2 className="w-5 h-5 text-emerald-600 flex-shrink-0 mt-0.5" />
                ) : (
                  <AlertCircle className="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" />
                )}
                <p className={`text-sm ${
                  questionResults[currentQuestion.id] ? 'text-emerald-700' : 'text-amber-700'
                }`}>
                  {currentQuestion.explanation}
                </p>
              </div>
            </div>
          )}
        </div>
      )}

      {/* Navigation */}
      <div className="flex items-center justify-between">
        <button
          onClick={handlePrevious}
          disabled={currentIndex === 0}
          className="px-4 py-2 text-[var(--foreground-muted)] hover:text-[var(--foreground)] disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
        >
          Previous
        </button>
        
        <div className="flex items-center gap-3">
          {!questionSubmitted && hasAnswered && (
            <button
              onClick={handleSubmitQuestion}
              className="px-4 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition-colors"
            >
              Check Answer
            </button>
          )}
          
          <button
            onClick={handleNext}
            disabled={!hasAnswered}
            className="flex items-center gap-2 px-6 py-2 bg-violet-600 text-white font-medium rounded-lg hover:bg-violet-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          >
            {currentIndex === totalQuestions - 1 ? 'Finish' : 'Next'}
            <ChevronRight className="w-4 h-4" />
          </button>
        </div>
      </div>
    </div>
  );
}

// Placeholder for unimplemented interactive types
interface PlaceholderInteractiveProps {
  type: string | null;
  onComplete: () => void;
  completed: boolean;
}

function PlaceholderInteractive({ type, onComplete, completed }: PlaceholderInteractiveProps) {
  return (
    <div className="text-center py-12">
      <div className="w-16 h-16 bg-violet-100 rounded-full flex items-center justify-center mx-auto mb-4">
        <Sparkles className="w-8 h-8 text-violet-600" />
      </div>
      
      <h3 className="text-lg font-semibold mb-2">Interactive: {type}</h3>
      <p className="text-[var(--foreground-muted)]">
        This interactive component is coming soon.
      </p>
      <p className="text-sm text-[var(--foreground-muted)] mt-2">
        {completed ? "You've completed this exercise." : "Complete this exercise using the button below."}
      </p>
    </div>
  );
}

