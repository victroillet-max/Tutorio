"use client";

import { useState, useEffect } from "react";
import { CheckCircle2, Sparkles, RotateCcw, ChevronRight } from "lucide-react";
import type { Activity } from "@/lib/database.types";
import { markActivityComplete, trackActivityView } from "@/lib/activities/actions";

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

function DragDropMatch({ content, onComplete, completed }: DragDropMatchProps) {
  const pairs = (content?.pairs as { left: string; right: string }[]) || [];
  const instructions = (content?.instructions as string) || "Match the items on the left with their corresponding items on the right.";
  
  const [matches, setMatches] = useState<Record<number, number | null>>({});
  const [draggedIndex, setDraggedIndex] = useState<number | null>(null);
  
  const shuffledRight = [...pairs].sort(() => Math.random() - 0.5);
  
  const handleDrop = (rightIndex: number) => {
    if (draggedIndex !== null) {
      setMatches(prev => ({ ...prev, [draggedIndex]: rightIndex }));
      setDraggedIndex(null);
      
      // Check if all matched correctly
      const newMatches = { ...matches, [draggedIndex]: rightIndex };
      if (Object.keys(newMatches).length === pairs.length) {
        const allCorrect = pairs.every((pair, i) => {
          const matchedRightIndex = newMatches[i];
          return matchedRightIndex !== null && shuffledRight[matchedRightIndex].right === pair.right;
        });
        if (allCorrect) {
          onComplete();
        }
      }
    }
  };
  
  return (
    <div>
      <p className="text-[var(--foreground-muted)] mb-6">{instructions}</p>
      
      <div className="grid md:grid-cols-2 gap-8">
        {/* Left items */}
        <div className="space-y-3">
          <p className="text-sm font-medium text-[var(--foreground-muted)] mb-2">Items</p>
          {pairs.map((pair, index) => (
            <div
              key={index}
              draggable={!completed}
              onDragStart={() => setDraggedIndex(index)}
              className={`
                p-4 rounded-xl border-2 cursor-grab active:cursor-grabbing transition-all
                ${draggedIndex === index ? 'border-violet-500 bg-violet-50' : 'border-[var(--border)] hover:border-violet-300'}
                ${completed ? 'cursor-default' : ''}
              `}
            >
              {pair.left}
            </div>
          ))}
        </div>
        
        {/* Right items (drop zones) */}
        <div className="space-y-3">
          <p className="text-sm font-medium text-[var(--foreground-muted)] mb-2">Matches</p>
          {shuffledRight.map((pair, index) => (
            <div
              key={index}
              onDragOver={(e) => e.preventDefault()}
              onDrop={() => handleDrop(index)}
              className={`
                p-4 rounded-xl border-2 border-dashed transition-all
                ${matches[index] !== undefined ? 'border-emerald-500 bg-emerald-50' : 'border-slate-300 hover:border-violet-300'}
              `}
            >
              {pair.right}
            </div>
          ))}
        </div>
      </div>
      
      {completed && (
        <div className="mt-6 p-4 bg-emerald-50 border border-emerald-200 rounded-xl text-center">
          <p className="text-emerald-700 font-medium">All matches correct!</p>
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
  
  const [branches, setBranches] = useState<string[]>([]);
  const [newBranch, setNewBranch] = useState("");
  
  const addBranch = () => {
    if (newBranch.trim()) {
      setBranches(prev => [...prev, newBranch.trim()]);
      setNewBranch("");
      
      if (branches.length >= 4 && !completed) {
        onComplete();
      }
    }
  };
  
  const removeBranch = (index: number) => {
    setBranches(prev => prev.filter((_, i) => i !== index));
  };
  
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
          <div className="mt-8 flex gap-2">
            <input
              type="text"
              value={newBranch}
              onChange={(e) => setNewBranch(e.target.value)}
              onKeyDown={(e) => e.key === 'Enter' && addBranch()}
              placeholder="Add a sub-task..."
              className="px-4 py-2 border border-[var(--border)] rounded-lg focus:outline-none focus:ring-2 focus:ring-violet-500"
            />
            <button
              onClick={addBranch}
              className="px-4 py-2 bg-violet-600 text-white rounded-lg hover:bg-violet-700 transition-colors"
            >
              Add
            </button>
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

function FilterEssential({ content, onComplete, completed }: FilterEssentialProps) {
  const scenarios = (content?.scenarios as { context: string; essential: string[]; abstract_away: string[] }[]) || [];
  const instructions = (content?.instructions as string) || "Identify which details are essential and which can be abstracted away.";
  
  const [currentScenario] = useState(0);
  const scenario = scenarios[currentScenario];
  
  const [selectedEssential, setSelectedEssential] = useState<Set<string>>(new Set());
  const [showResult, setShowResult] = useState(false);
  
  if (!scenario) {
    return <div>No scenarios available.</div>;
  }
  
  const allItems = [...scenario.essential, ...scenario.abstract_away].sort(() => Math.random() - 0.5);
  
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
    
    const correct = scenario.essential.every(item => selectedEssential.has(item)) &&
      scenario.abstract_away.every(item => !selectedEssential.has(item));
    
    if (correct) {
      onComplete();
    }
  };
  
  return (
    <div>
      <p className="text-[var(--foreground-muted)] mb-4">{instructions}</p>
      
      <div className="p-4 bg-blue-50 border border-blue-200 rounded-xl mb-6">
        <p className="font-medium text-blue-800">{scenario.context}</p>
      </div>
      
      <p className="text-sm text-[var(--foreground-muted)] mb-4">
        Click on items that are <strong>essential</strong>:
      </p>
      
      <div className="flex flex-wrap gap-3 mb-6">
        {allItems.map((item) => {
          const isSelected = selectedEssential.has(item);
          const isEssential = scenario.essential.includes(item);
          
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
              key={item}
              onClick={() => toggleItem(item)}
              disabled={showResult}
              className={`px-4 py-2 rounded-lg border-2 transition-all ${bgClass} ${showResult ? '' : 'cursor-pointer'}`}
            >
              {item}
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
        <div className="p-4 bg-slate-50 rounded-xl">
          <p className="font-medium mb-2">Results:</p>
          <p className="text-sm text-[var(--foreground-muted)]">
            <span className="text-emerald-600">Green</span> = Correctly identified as essential |{' '}
            <span className="text-amber-600">Yellow</span> = Missed essential |{' '}
            <span className="text-red-600">Red</span> = Incorrectly selected
          </p>
        </div>
      )}
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

