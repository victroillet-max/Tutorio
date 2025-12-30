"use client";

import { useState, useEffect } from "react";
import { CheckCircle2, Sparkles, RotateCcw, ChevronRight, GripVertical, MousePointerClick, BookOpen, Lightbulb, ArrowRight, X, Plus, Trash2 } from "lucide-react";
import type { Activity } from "@/lib/database.types";
import { markActivityComplete, trackActivityView } from "@/lib/activities/actions";
import { SpreadsheetExerciseViewer } from "./spreadsheet-exercise-viewer";

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
      case 'google-sheets':
      case 'spreadsheet':
      case 'cfs-builder':
      case 'statement-builder':
        return <SpreadsheetExerciseViewer activity={activity} userId={userId} isCompleted={completed} onComplete={handleComplete} />;
      default:
        return <PlaceholderInteractive type={interactiveType} onComplete={handleComplete} completed={completed} />;
    }
  };

  return (
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
        {renderInteractive()}
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
    return <div className="text-center text-[var(--foreground-muted)]">No scenarios available.</div>;
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
  const scenarios = (content?.scenarios as ClassificationScenario[]) || [];
  const instructions = (content?.instructions as string) || "Identify the correct CT pillar for each scenario.";
  const timePerQuestion = (content?.timePerQuestion as number) || 15;
  
  const pillars = ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"];
  
  const [currentIndex, setCurrentIndex] = useState(0);
  const [score, setScore] = useState(0);
  const [timeLeft, setTimeLeft] = useState(timePerQuestion);
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [showFeedback, setShowFeedback] = useState(false);
  const [isFinished, setIsFinished] = useState(false);
  const [answers, setAnswers] = useState<{ correct: boolean; selected: string | null; expected: string }[]>([]);
  
  const currentScenario = scenarios[currentIndex];
  
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
  }, [timeLeft, showFeedback, isFinished, completed, currentScenario]);
  
  const handleTimeout = () => {
    // Time ran out - count as wrong
    setAnswers(prev => [...prev, { correct: false, selected: null, expected: currentScenario.correctPillar }]);
    setShowFeedback(true);
    
    setTimeout(() => {
      moveToNext();
    }, 2000);
  };
  
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
      moveToNext();
    }, 2000);
  };
  
  const moveToNext = () => {
    if (currentIndex >= scenarios.length - 1) {
      setIsFinished(true);
      // Check if passed (60% or more)
      const finalScore = answers.length > 0 
        ? Math.round((answers.filter(a => a.correct).length / scenarios.length) * 100)
        : Math.round((score / scenarios.length) * 100);
      if (finalScore >= 60) {
        onComplete();
      }
    } else {
      setCurrentIndex(prev => prev + 1);
      setSelectedAnswer(null);
      setShowFeedback(false);
      setTimeLeft(timePerQuestion);
    }
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
    return <div className="text-center text-[var(--foreground-muted)]">No scenarios available.</div>;
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
// ============================================
interface JournalEntryBuilderProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface JournalTransaction {
  id: string;
  date: string;
  description: string;
  solution: { account: string; type: string; debit: number; credit: number }[];
  hint?: string;
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
  const scenario = (content?.scenario as string) || "Build journal entries for the following transactions.";
  const companyName = (content?.company_name as string) || "Company";
  const transactions = (content?.transactions as JournalTransaction[]) || [];
  const accountOptions = (content?.account_options as AccountOption[]) || [];
  const passingScore = (content?.passing_score as number) || 80;

  const [currentTxIndex, setCurrentTxIndex] = useState(0);
  const [entries, setEntries] = useState<JournalEntry[]>([
    { account: "", debit: 0, credit: 0 },
    { account: "", debit: 0, credit: 0 },
  ]);
  const [showHint, setShowHint] = useState(false);
  const [showFeedback, setShowFeedback] = useState(false);
  const [txResults, setTxResults] = useState<{ correct: boolean; feedback: string }[]>([]);
  const [isFinished, setIsFinished] = useState(false);

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
      // Clear credit if entering debit
      if (Number(value) > 0) updated[index].credit = 0;
    } else if (field === 'credit') {
      updated[index].credit = Number(value) || 0;
      // Clear debit if entering credit
      if (Number(value) > 0) updated[index].debit = 0;
    }
    setEntries(updated);
  };

  const checkAnswer = () => {
    if (!currentTx) return;

    const solution = currentTx.solution;
    let isCorrect = true;
    let feedback = "";

    // Check if debits = credits
    const totalDebits = entries.reduce((sum, e) => sum + e.debit, 0);
    const totalCredits = entries.reduce((sum, e) => sum + e.credit, 0);

    if (totalDebits !== totalCredits) {
      isCorrect = false;
      feedback = `Debits (${totalDebits.toLocaleString()}) must equal Credits (${totalCredits.toLocaleString()}).`;
    } else {
      // Check each solution entry is present
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
        // Extra entries that shouldn't be there
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
      // Calculate final score
      setIsFinished(true);
      const correctCount = txResults.filter(r => r.correct).length + (txResults.length < transactions.length ? 0 : 0);
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

  if (transactions.length === 0) {
    return <div className="text-center text-[var(--foreground-muted)]">No transactions available.</div>;
  }

  const correctCount = txResults.filter(r => r.correct).length;
  const finalScore = Math.round((correctCount / transactions.length) * 100);

  // Finished state
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

        {/* Results summary */}
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
      {/* Scenario context */}
      <div className="bg-blue-50 border border-blue-200 rounded-xl p-4 mb-6">
        <div className="flex items-start gap-3">
          <BookOpen className="w-5 h-5 text-blue-600 flex-shrink-0 mt-0.5" />
          <div>
            <h3 className="font-semibold text-blue-800">{companyName}</h3>
            <p className="text-sm text-blue-700 mt-1">{scenario}</p>
          </div>
        </div>
      </div>

      {/* Progress */}
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

      {/* Current Transaction */}
      <div className="bg-slate-50 border border-slate-200 rounded-xl p-4 mb-6">
        <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)] mb-2">
          <span className="font-semibold text-violet-600">{currentTx.date}</span>
        </div>
        <p className="text-slate-800">{currentTx.description}</p>
      </div>

      {/* Journal Entry Builder */}
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

        {/* Totals row */}
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

      {/* Add entry button */}
      {!showFeedback && (
        <button
          onClick={addEntry}
          className="flex items-center gap-2 text-sm text-violet-600 hover:text-violet-700 mb-6"
        >
          <Plus className="w-4 h-4" />
          Add another line
        </button>
      )}

      {/* Hint */}
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

      {/* Feedback */}
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
          
          {/* Show correct answer if wrong */}
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

      {/* Actions */}
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

// ============================================
// Equation Analyzer Component (FA Course)
// ============================================
interface EquationAnalyzerProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

function EquationAnalyzer({ content, onComplete, completed }: EquationAnalyzerProps) {
  const instructions = (content?.instructions as string) || "Analyze how each transaction affects the accounting equation.";
  const scenarios = (content?.scenarios as { description: string; effects: { assets: number; liabilities: number; equity: number }; explanation: string }[]) || [];
  
  const [currentIndex, setCurrentIndex] = useState(0);
  const [userAnswer, setUserAnswer] = useState({ assets: '', liabilities: '', equity: '' });
  const [showFeedback, setShowFeedback] = useState(false);
  const [score, setScore] = useState(0);
  const [isFinished, setIsFinished] = useState(false);

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
      if (Math.round((score / scenarios.length) * 100) >= 60) {
        onComplete();
      }
    } else {
      setCurrentIndex(i => i + 1);
      setUserAnswer({ assets: '', liabilities: '', equity: '' });
      setShowFeedback(false);
    }
  };

  if (scenarios.length === 0) {
    return <div className="text-center text-[var(--foreground-muted)]">No scenarios available.</div>;
  }

  const finalScore = Math.round((score / scenarios.length) * 100);

  if (isFinished) {
    return (
      <div className="text-center">
        <div className={`w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4 ${finalScore >= 60 ? 'bg-emerald-100' : 'bg-amber-100'}`}>
          <span className={`text-2xl font-bold ${finalScore >= 60 ? 'text-emerald-700' : 'text-amber-700'}`}>{finalScore}%</span>
        </div>
        <h3 className="text-xl font-bold mb-2">{finalScore >= 60 ? 'Great Job!' : 'Keep Practicing!'}</h3>
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
  const adjustments = (content?.adjustments as JournalTransaction[]) || [];
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

