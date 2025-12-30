"use client";

import { useState, useEffect, useCallback, useRef } from "react";
import { CheckCircle2, XCircle, Flag, Clock, AlertTriangle, ChevronRight } from "lucide-react";
import type { Activity, QuizQuestion } from "@/lib/database.types";
import { markActivityComplete, trackActivityView, updateActivityProgress } from "@/lib/activities/actions";
import { useChatContext } from "@/components/chat";

interface CheckpointViewerProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
}

interface CheckpointContent {
  questions: QuizQuestion[];
  passing_score: number;
}

export function CheckpointViewer({ activity, userId, isCompleted }: CheckpointViewerProps) {
  const content = activity.content as CheckpointContent | null;
  const questions = content?.questions || [];
  const passingScore = content?.passing_score || activity.passing_score || 70;
  const timeLimit = activity.time_limit; // In minutes

  // Chat context for struggling detection and current question tracking
  // Extract specific methods to avoid dependency on entire context object (prevents infinite re-renders)
  const { updateCurrentQuestion, triggerPopup, hasDismissedHelp } = useChatContext();

  // Track activity view and set up time tracking
  useEffect(() => {
    trackActivityView(activity.id).catch(console.error);
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
  
  const [started, setStarted] = useState(false);
  const [currentQuestion, setCurrentQuestion] = useState(0);
  
  // Update chat context with current question whenever it changes
  useEffect(() => {
    if (!started) return; // Only track when exam has started
    const question = questions[currentQuestion];
    if (question?.question) {
      updateCurrentQuestion(question.question, currentQuestion + 1);
    }
  }, [currentQuestion, questions, updateCurrentQuestion, started]);
  
  const [answers, setAnswers] = useState<Record<string, number | boolean | string>>({});
  const [showResults, setShowResults] = useState(isCompleted);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [score, setScore] = useState<number | null>(null);
  const [timeRemaining, setTimeRemaining] = useState(timeLimit ? timeLimit * 60 : null);
  const [timerStarted, setTimerStarted] = useState(false);
  
  // Struggling detection - track questions answered (will check on submit)
  const [hasShownHelpPopup, setHasShownHelpPopup] = useState(false);
  
  // B8: Track time spent on activity for "Hours Learned" stat
  const lastSavedTimeRef = useRef<number>(Date.now());
  
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

  const question = questions[currentQuestion];
  const totalQuestions = questions.length;
  const answeredCount = Object.keys(answers).length;
  
  // Ref for submit handler to avoid stale closure in timer
  const handleSubmitRef = useRef<() => Promise<void>>();

  // Timer effect - Fixed: was incorrectly using useState instead of useEffect
  useEffect(() => {
    if (!timerStarted || timeRemaining === null) return;
    
    if (timeRemaining <= 0) {
      handleSubmitRef.current?.();
      return;
    }
    
    const interval = setInterval(() => {
      setTimeRemaining(prev => {
        if (prev === null || prev <= 1) {
          clearInterval(interval);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
    
    return () => clearInterval(interval);
  }, [timerStarted, timeRemaining]);

  const formatTime = (seconds: number): string => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const handleStart = () => {
    setStarted(true);
    if (timeLimit) {
      setTimerStarted(true);
    }
  };

  // Track question navigation for struggling detection
  const [questionVisits, setQuestionVisits] = useState<Record<number, number>>({});
  
  const handleQuestionChange = useCallback((newQuestion: number) => {
    setCurrentQuestion(newQuestion);
    
    // Track visits to each question
    setQuestionVisits(prev => {
      const newVisits = {
        ...prev,
        [newQuestion]: (prev[newQuestion] || 0) + 1
      };
      
      // Check if user is revisiting questions multiple times (sign of uncertainty)
      const totalRevisits = Object.values(newVisits).filter(v => v > 1).length;
      if (totalRevisits >= 2 && !hasShownHelpPopup && !hasDismissedHelp) {
        setHasShownHelpPopup(true);
        triggerPopup(
          "Need help understanding this concept? I'm here for you!",
          "help"
        );
      }
      
      return newVisits;
    });
  }, [hasShownHelpPopup, hasDismissedHelp, triggerPopup]);

  const handleAnswer = useCallback((questionId: string, answer: number | boolean | string) => {
    setAnswers(prev => ({ ...prev, [questionId]: answer }));
  }, []);

  const calculateScore = useCallback((): number => {
    let correct = 0;
    questions.forEach(q => {
      const userAnswer = answers[q.id];
      if (userAnswer === q.correct) {
        correct++;
      }
    });
    return Math.round((correct / questions.length) * 100);
  }, [questions, answers]);

  const handleSubmit = useCallback(async () => {
    setIsSubmitting(true);
    const finalScore = calculateScore();
    setScore(finalScore);
    setShowResults(true);
    
    try {
      // B8: Save time spent before marking complete
      await saveTimeSpent();
      
      await markActivityComplete(activity.id, finalScore);
    } catch (error) {
      console.error("Failed to save checkpoint result:", error);
    } finally {
      setIsSubmitting(false);
    }
  }, [activity.id, calculateScore, saveTimeSpent]);
  
  // Update ref for timer to access
  useEffect(() => {
    handleSubmitRef.current = handleSubmit;
  }, [handleSubmit]);

  const handleRetry = () => {
    setAnswers({});
    setCurrentQuestion(0);
    setShowResults(false);
    setScore(null);
    setStarted(false);
    setTimerStarted(false);
    setTimeRemaining(timeLimit ? timeLimit * 60 : null);
  };

  // Start screen
  if (!started && !showResults) {
    return (
      <div className="bg-white rounded-2xl shadow-sm border border-[var(--border)] overflow-hidden">
        <div className="p-8 text-center">
          <div className="w-20 h-20 bg-amber-100 rounded-full flex items-center justify-center mx-auto mb-6">
            <Flag className="w-10 h-10 text-amber-600" />
          </div>
          
          <h1 
            className="text-2xl font-bold mb-2"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            {activity.title}
          </h1>
          
          <p className="text-[var(--foreground-muted)] mb-6 max-w-md mx-auto">
            This is a checkpoint assessment. You need to score at least {passingScore}% to pass and unlock the next module.
          </p>
          
          <div className="flex justify-center gap-6 mb-8 text-sm">
            <div className="flex items-center gap-2">
              <Flag className="w-4 h-4 text-[var(--foreground-muted)]" />
              <span>{totalQuestions} questions</span>
            </div>
            {timeLimit && (
              <div className="flex items-center gap-2">
                <Clock className="w-4 h-4 text-[var(--foreground-muted)]" />
                <span>{timeLimit} minutes</span>
              </div>
            )}
            <div className="flex items-center gap-2">
              <AlertTriangle className="w-4 h-4 text-amber-500" />
              <span>{passingScore}% to pass</span>
            </div>
          </div>
          
          <button
            onClick={handleStart}
            className="px-8 py-4 bg-amber-600 text-white font-semibold rounded-xl hover:bg-amber-700 transition-colors"
          >
            Start Checkpoint
          </button>
        </div>
      </div>
    );
  }

  // Results screen
  if (showResults && score !== null) {
    const passed = score >= passingScore;
    
    return (
      <div className="bg-white rounded-2xl shadow-sm border border-[var(--border)] overflow-hidden">
        <div className={`p-8 text-center ${passed ? 'bg-emerald-50' : 'bg-red-50'}`}>
          <div className={`w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4 ${passed ? 'bg-emerald-100' : 'bg-red-100'}`}>
            {passed ? (
              <CheckCircle2 className="w-10 h-10 text-emerald-600" />
            ) : (
              <XCircle className="w-10 h-10 text-red-600" />
            )}
          </div>
          
          <h2 className="text-2xl font-bold mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
            {passed ? "Checkpoint Passed!" : "Checkpoint Failed"}
          </h2>
          
          <p className="text-lg mb-2">
            Your Score: <span className={`font-bold ${passed ? 'text-emerald-600' : 'text-red-600'}`}>{score}%</span>
          </p>
          
          <p className="text-[var(--foreground-muted)] mb-6">
            {passed 
              ? `Congratulations! You've unlocked the next module and earned ${activity.xp} XP.`
              : `You need ${passingScore}% to pass. Review the material and try again.`
            }
          </p>
          
          {!passed && (
            <button
              onClick={handleRetry}
              className="px-6 py-3 bg-amber-600 text-white font-semibold rounded-xl hover:bg-amber-700 transition-colors"
            >
              Try Again
            </button>
          )}
        </div>
        
        {/* Review Answers */}
        <div className="p-6 border-t border-[var(--border)]">
          <h3 className="font-semibold mb-4">Review Your Answers</h3>
          <div className="space-y-4">
            {questions.map((q, index) => {
              const userAnswer = answers[q.id];
              const isCorrect = userAnswer === q.correct;
              
              return (
                <div key={q.id} className={`p-4 rounded-lg ${isCorrect ? 'bg-emerald-50' : 'bg-red-50'}`}>
                  <div className="flex items-start gap-3">
                    <span className={`flex-shrink-0 w-6 h-6 rounded-full flex items-center justify-center text-sm font-medium ${isCorrect ? 'bg-emerald-200 text-emerald-700' : 'bg-red-200 text-red-700'}`}>
                      {index + 1}
                    </span>
                    <div className="flex-1">
                      <p className="font-medium mb-1">{q.question}</p>
                      {q.explanation && (
                        <p className="text-sm text-[var(--foreground-muted)]">{q.explanation}</p>
                      )}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    );
  }

  // Question screen
  if (!question) {
    return (
      <div className="bg-white rounded-2xl p-8 text-center">
        <p className="text-[var(--foreground-muted)]">No questions available.</p>
      </div>
    );
  }

  return (
    <div className="bg-white rounded-2xl shadow-sm border border-[var(--border)] overflow-hidden">
      {/* Header with timer */}
      <div className="flex items-center justify-between px-6 py-4 border-b border-[var(--border)] bg-amber-50">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-lg bg-amber-100 flex items-center justify-center">
            <Flag className="w-5 h-5 text-amber-600" />
          </div>
          <div>
            <h1 className="font-bold text-[var(--foreground)]">
              Checkpoint
            </h1>
            <p className="text-sm text-[var(--foreground-muted)]">
              Question {currentQuestion + 1} of {totalQuestions}
            </p>
          </div>
        </div>
        
        <div className="flex items-center gap-4">
          {timeRemaining !== null && (
            <div className={`flex items-center gap-2 px-3 py-1.5 rounded-full ${timeRemaining < 60 ? 'bg-red-100 text-red-700' : 'bg-amber-100 text-amber-700'}`}>
              <Clock className="w-4 h-4" />
              <span className="font-mono font-medium">{formatTime(timeRemaining)}</span>
            </div>
          )}
          
          <div className="text-sm text-[var(--foreground-muted)]">
            {answeredCount}/{totalQuestions} answered
          </div>
        </div>
      </div>
      
      {/* Progress Bar */}
      <div className="h-1 bg-slate-100">
        <div 
          className="h-full bg-amber-500 transition-all duration-300"
          style={{ width: `${((currentQuestion + 1) / totalQuestions) * 100}%` }}
        />
      </div>
      
      {/* Question */}
      <div className="p-6 sm:p-8">
        <h2 className="text-lg font-medium mb-6">{question.question}</h2>
        
        {/* Answer Options */}
        <div className="space-y-3">
          {question.type === 'mcq' && question.options?.map((option, index) => {
            const isSelected = answers[question.id] === index;
            
            return (
              <button
                key={index}
                onClick={() => handleAnswer(question.id, index)}
                className={`
                  w-full p-4 text-left rounded-xl border-2 transition-all
                  ${isSelected 
                    ? 'border-amber-500 bg-amber-50' 
                    : 'border-[var(--border)] hover:border-amber-300'
                  }
                `}
              >
                <div className="flex items-center gap-3">
                  <span className={`
                    flex-shrink-0 w-8 h-8 rounded-lg flex items-center justify-center font-medium
                    ${isSelected 
                      ? 'bg-amber-500 text-white' 
                      : 'bg-slate-100 text-[var(--foreground)]'
                    }
                  `}>
                    {String.fromCharCode(65 + index)}
                  </span>
                  <span className="flex-1">{option}</span>
                </div>
              </button>
            );
          })}
          
          {question.type === 'true_false' && (
            <>
              {[true, false].map((value) => {
                const isSelected = answers[question.id] === value;
                
                return (
                  <button
                    key={String(value)}
                    onClick={() => handleAnswer(question.id, value)}
                    className={`
                      w-full p-4 text-left rounded-xl border-2 transition-all
                      ${isSelected 
                        ? 'border-amber-500 bg-amber-50' 
                        : 'border-[var(--border)] hover:border-amber-300'
                      }
                    `}
                  >
                    <div className="flex items-center gap-3">
                      <span className={`
                        flex-shrink-0 w-8 h-8 rounded-lg flex items-center justify-center font-medium
                        ${isSelected 
                          ? 'bg-amber-500 text-white' 
                          : 'bg-slate-100 text-[var(--foreground)]'
                        }
                      `}>
                        {value ? 'T' : 'F'}
                      </span>
                      <span className="flex-1">{value ? 'True' : 'False'}</span>
                    </div>
                  </button>
                );
              })}
            </>
          )}
        </div>
      </div>
      
      {/* Footer - Single action button */}
      <div className="px-6 py-4 border-t border-[var(--border)] bg-slate-50">
        <div className="flex items-center justify-between">
          {/* Progress dots */}
          <div className="flex items-center gap-1.5">
            {questions.map((q, index) => (
              <button
                key={q.id}
                onClick={() => handleQuestionChange(index)}
                className={`w-2.5 h-2.5 rounded-full transition-all ${
                  index === currentQuestion 
                    ? 'bg-amber-500 scale-125' 
                    : answers[q.id] !== undefined 
                      ? 'bg-amber-300' 
                      : 'bg-slate-300 hover:bg-slate-400'
                }`}
              />
            ))}
          </div>
          
          {/* Single action button */}
          {currentQuestion < totalQuestions - 1 ? (
            <button
              onClick={() => handleQuestionChange(currentQuestion + 1)}
              className="flex items-center gap-2 px-6 py-3 bg-amber-600 text-white font-semibold rounded-xl hover:bg-amber-700 transition-colors"
            >
              Next Question
              <ChevronRight className="w-4 h-4" />
            </button>
          ) : (
            <button
              onClick={handleSubmit}
              disabled={answeredCount < totalQuestions || isSubmitting}
              className="flex items-center gap-2 px-6 py-3 bg-emerald-600 text-white font-semibold rounded-xl hover:bg-emerald-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {isSubmitting ? "Submitting..." : "Submit Checkpoint"}
              <ChevronRight className="w-4 h-4" />
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

