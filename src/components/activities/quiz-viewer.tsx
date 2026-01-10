"use client";

import { useState, useEffect, useCallback, useRef, useMemo } from "react";
import { useRouter } from "next/navigation";
import { CheckCircle2, XCircle, HelpCircle, ChevronRight, Lightbulb, MessageCircle, Clock, AlertTriangle } from "lucide-react";
import type { Activity, QuizQuestion } from "@/lib/database.types";
import { markActivityComplete, trackActivityView, updateActivityProgress } from "@/lib/activities/actions";
import { useChatContext } from "@/components/chat";
import { Confetti } from "@/components/ui/confetti";

interface NextActivityInfo {
  slug: string;
  title: string;
  skillSlug: string;
}

interface QuizViewerProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
  nextActivity?: NextActivityInfo;
}

interface QuizContent {
  questions: QuizQuestion[];
  passing_score: number;
  shuffle_questions?: boolean;
  shuffle_options?: boolean;
  timed_mode?: boolean;
  time_limit_seconds?: number;
}

export function QuizViewer({ activity, userId, isCompleted, nextActivity }: QuizViewerProps) {
  const router = useRouter();
  const content = activity.content as QuizContent | null;
  const originalQuestions = content?.questions || [];
  const passingScore = content?.passing_score || activity.passing_score || 70;
  const shuffleQuestions = content?.shuffle_questions ?? false;
  const shuffleOptions = content?.shuffle_options ?? false;
  const timedMode = content?.timed_mode ?? false;
  const timeLimitSeconds = content?.time_limit_seconds || 300; // Default 5 minutes

  // Shuffle questions on client mount (to avoid hydration issues)
  const [questions, setQuestions] = useState<QuizQuestion[]>(originalQuestions);
  const [isClient, setIsClient] = useState(false);
  
  // Timer state
  const [timeRemaining, setTimeRemaining] = useState(timeLimitSeconds);
  const [timerActive, setTimerActive] = useState(false);
  const [timeExpired, setTimeExpired] = useState(false);

  // Initialize shuffled questions on client
  useEffect(() => {
    setIsClient(true);
    if (originalQuestions.length > 0) {
      let processedQuestions = [...originalQuestions];
      
      // Shuffle questions if enabled
      if (shuffleQuestions) {
        processedQuestions = processedQuestions.sort(() => Math.random() - 0.5);
      }
      
      // Shuffle options for each MCQ question if enabled
      if (shuffleOptions) {
        processedQuestions = processedQuestions.map(q => {
          if (q.type === 'mcq' && q.options) {
            // Create index mapping for shuffling
            const indices = q.options.map((_, i) => i);
            const shuffledIndices = indices.sort(() => Math.random() - 0.5);
            const shuffledOptions = shuffledIndices.map(i => q.options![i]);
            // Find new position of correct answer
            const newCorrectIndex = shuffledIndices.indexOf(q.correct as number);
            return { ...q, options: shuffledOptions, correct: newCorrectIndex };
          }
          return q;
        });
      }
      
      setQuestions(processedQuestions);
      
      // Start timer if in timed mode
      if (timedMode && !isCompleted) {
        setTimerActive(true);
      }
    }
  }, [originalQuestions, shuffleQuestions, shuffleOptions, timedMode, isCompleted, timeLimitSeconds]);

  // Timer effect
  useEffect(() => {
    if (!timerActive || isCompleted || timeExpired) return;

    if (timeRemaining <= 0) {
      setTimeExpired(true);
      setTimerActive(false);
      // Auto-submit when time expires
      handleTimeExpired();
      return;
    }

    const timer = setInterval(() => {
      setTimeRemaining(prev => prev - 1);
    }, 1000);

    return () => clearInterval(timer);
  }, [timerActive, timeRemaining, isCompleted, timeExpired]);

  const handleTimeExpired = async () => {
    // Submit with whatever answers they have
    setIsSubmitting(true);
    const finalScore = calculateScore();
    setScore(finalScore);
    setShowResults(true);
    
    try {
      await saveTimeSpent();
      await markActivityComplete(activity.id, finalScore);
    } catch (error) {
      console.error("Failed to save quiz result:", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  const formatTime = (seconds: number): string => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  // Chat context for struggling detection and current question tracking
  // Extract specific methods to avoid dependency on entire context object (prevents infinite re-renders)
  const { updateCurrentQuestion, updateEnhancedQuestion, updateActivityInfo, triggerPopup, hasDismissedHelp, openChatWithMessage } = useChatContext();
  
  // Update activity info on mount
  useEffect(() => {
    updateActivityInfo({
      title: activity.title,
      type: 'quiz',
      instructions: `Quiz with ${originalQuestions.length} questions. Passing score: ${passingScore}%`,
    });
  }, [activity.title, originalQuestions.length, passingScore, updateActivityInfo]);
  
  // B8: Track time spent on activity for "Hours Learned" stat
  const lastSavedRef = useRef<number>(Date.now());
  
  // Only saves NEW time since last save (server accumulates)
  const saveTimeSpent = useCallback(async () => {
    const now = Date.now();
    const timeSpent = Math.floor((now - lastSavedRef.current) / 1000);
    if (timeSpent > 0) {
      try {
        await updateActivityProgress(activity.id, { timeSpentSeconds: timeSpent });
        lastSavedRef.current = now; // Reset after successful save
      } catch (error) {
        console.error("Failed to save time spent:", error);
      }
    }
  }, [activity.id]);
  
  // Save time on visibility change and unmount
  useEffect(() => {
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
  }, [saveTimeSpent]);

  // Track activity view when component mounts
  useEffect(() => {
    trackActivityView(activity.id).catch(console.error);
  }, [activity.id]);
  
  const [currentQuestion, setCurrentQuestion] = useState(0);
  
  // Update chat context with current question whenever it changes
  useEffect(() => {
    const question = questions[currentQuestion];
    if (question?.question) {
      // Update legacy context
      updateCurrentQuestion(question.question, currentQuestion + 1);
      // Update enhanced context with more details
      updateEnhancedQuestion({
        number: currentQuestion + 1,
        text: question.question,
        type: question.type || 'mcq',
        options: question.options,
        hint: undefined, // Quizzes typically don't have hints per question
      });
    }
  }, [currentQuestion, questions, updateCurrentQuestion, updateEnhancedQuestion]);
  
  const [answers, setAnswers] = useState<Record<string, number | boolean | string>>({});
  const [showResults, setShowResults] = useState(isCompleted);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [score, setScore] = useState<number | null>(null);
  const [showExplanation, setShowExplanation] = useState<string | null>(null);
  const [showConfetti, setShowConfetti] = useState(false);
  
  // Struggling detection state
  const [wrongAnswerCount, setWrongAnswerCount] = useState(0);
  const [hasShownHelpPopup, setHasShownHelpPopup] = useState(false);

  const question = questions[currentQuestion];
  const totalQuestions = questions.length;
  const answeredCount = Object.keys(answers).length;

  const handleAnswer = useCallback((questionId: string, answer: number | boolean | string) => {
    setAnswers(prev => ({ ...prev, [questionId]: answer }));
    setShowExplanation(questionId);
    
    // Check if answer is wrong and track for struggling detection
    const currentQ = questions.find(q => q.id === questionId);
    if (currentQ && answer !== currentQ.correct) {
      setWrongAnswerCount(prev => {
        const newWrongCount = prev + 1;
        
        // Trigger help popup after 2+ wrong answers
        if (newWrongCount >= 2 && !hasShownHelpPopup && !hasDismissedHelp) {
          setHasShownHelpPopup(true);
          triggerPopup(
            "Need help understanding this concept? I'm here for you!",
            "help"
          );
        }
        return newWrongCount;
      });
    }
  }, [questions, hasShownHelpPopup, hasDismissedHelp, triggerPopup]);

  const calculateScore = (): number => {
    let correct = 0;
    questions.forEach(q => {
      const userAnswer = answers[q.id];
      if (userAnswer === q.correct) {
        correct++;
      }
    });
    return Math.round((correct / questions.length) * 100);
  };

  const handleSubmit = async () => {
    setIsSubmitting(true);
    const finalScore = calculateScore();
    setScore(finalScore);
    setShowResults(true);
    
    // Trigger confetti if passed
    if (finalScore >= passingScore) {
      setShowConfetti(true);
    }
    
    try {
      // B8: Save time spent before marking complete
      await saveTimeSpent();
      await markActivityComplete(activity.id, finalScore);
    } catch (error) {
      console.error("Failed to save quiz result:", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleRetry = () => {
    setAnswers({});
    setCurrentQuestion(0);
    setShowResults(false);
    setScore(null);
    setShowExplanation(null);
    // Reset timer for timed quizzes
    if (timedMode) {
      setTimeRemaining(timeLimitSeconds);
      setTimeExpired(false);
      setTimerActive(true);
    }
    // Re-shuffle questions if enabled
    if (shuffleQuestions || shuffleOptions) {
      let processedQuestions = [...originalQuestions];
      if (shuffleQuestions) {
        processedQuestions = processedQuestions.sort(() => Math.random() - 0.5);
      }
      if (shuffleOptions) {
        processedQuestions = processedQuestions.map(q => {
          if (q.type === 'mcq' && q.options) {
            const indices = q.options.map((_, i) => i);
            const shuffledIndices = indices.sort(() => Math.random() - 0.5);
            const shuffledOptions = shuffledIndices.map(i => q.options![i]);
            const newCorrectIndex = shuffledIndices.indexOf(q.correct as number);
            return { ...q, options: shuffledOptions, correct: newCorrectIndex };
          }
          return q;
        });
      }
      setQuestions(processedQuestions);
    }
  };

  if (showResults && score !== null) {
    const passed = score >= passingScore;
    
    return (
      <>
      {/* Celebration Confetti */}
      <Confetti 
        trigger={showConfetti} 
        onComplete={() => setShowConfetti(false)} 
      />
      
      <div className="bg-white rounded-2xl shadow-sm border border-[var(--border)] overflow-hidden">
        <div className={`p-8 text-center ${passed ? 'bg-emerald-50' : 'bg-red-50'}`}>
          {/* Time expired warning */}
          {timeExpired && (
            <div className="mb-4 p-3 bg-amber-100 border border-amber-200 rounded-lg inline-flex items-center gap-2 text-amber-700">
              <AlertTriangle className="w-5 h-5" />
              <span className="text-sm font-medium">Time expired - quiz was auto-submitted</span>
            </div>
          )}
          
          <div className={`w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4 ${passed ? 'bg-emerald-100' : 'bg-red-100'}`}>
            {passed ? (
              <CheckCircle2 className="w-10 h-10 text-emerald-600" />
            ) : (
              <XCircle className="w-10 h-10 text-red-600" />
            )}
          </div>
          
          <h2 className="text-2xl font-bold mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
            {passed ? "Quiz Passed!" : "Not Quite..."}
          </h2>
          
          <p className="text-lg mb-2">
            Your Score: <span className={`font-bold ${passed ? 'text-emerald-600' : 'text-red-600'}`}>{score}%</span>
          </p>
          
          <p className="text-[var(--foreground-muted)] mb-6">
            {passed 
              ? `Great job! You've earned ${activity.xp} XP.`
              : `You need ${passingScore}% to pass. Try again!`
            }
          </p>
          
          {/* Show appropriate action buttons based on pass/fail and next activity availability */}
          <div className="flex flex-col sm:flex-row items-center justify-center gap-3">
            {!passed ? (
              <button
                onClick={handleRetry}
                className="px-6 py-3 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-hover)] transition-colors"
              >
                Try Again
              </button>
            ) : (
              <>
                {nextActivity && (
                  <button
                    onClick={() => router.push(`/skills/${nextActivity.skillSlug}/${nextActivity.slug}`)}
                    className="flex items-center gap-2 px-6 py-3 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-hover)] transition-colors"
                  >
                    Continue to Next
                    <ChevronRight className="w-4 h-4" />
                  </button>
                )}
                {score < 75 && (
                  <button
                    onClick={handleRetry}
                    className="px-6 py-3 bg-slate-600 text-white font-semibold rounded-xl hover:bg-slate-700 transition-colors"
                  >
                    Practice Again
                  </button>
                )}
              </>
            )}
          </div>
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
      </>
    );
  }

  if (!question) {
    return (
      <div className="bg-white rounded-2xl p-8 text-center">
        <p className="text-[var(--foreground-muted)]">No questions available.</p>
      </div>
    );
  }

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
            <p className="text-sm text-emerald-600">You&apos;ve already completed this quiz. Feel free to practice again.</p>
          </div>
        </div>
      )}
    
    <div className="bg-white rounded-2xl shadow-sm border border-[var(--border)] overflow-hidden">
      {/* Header */}
      <div className="flex items-center justify-between px-6 py-4 border-b border-[var(--border)] bg-slate-50">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-lg bg-purple-100 flex items-center justify-center">
            <HelpCircle className="w-5 h-5 text-purple-600" />
          </div>
          <div>
            <h1 className="text-xl font-bold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
              {activity.title}
            </h1>
            <p className="text-sm text-[var(--foreground-muted)]">
              Question {currentQuestion + 1} of {totalQuestions}
            </p>
          </div>
        </div>
        
        <div className="flex items-center gap-4">
          {/* Timer display for timed quizzes */}
          {timedMode && timerActive && (
            <div className={`flex items-center gap-2 px-3 py-1.5 rounded-lg ${
              timeRemaining <= 60 
                ? 'bg-red-100 text-red-700' 
                : timeRemaining <= 120 
                  ? 'bg-amber-100 text-amber-700' 
                  : 'bg-slate-100 text-slate-700'
            }`}>
              <Clock className="w-4 h-4" />
              <span className="font-mono font-bold">{formatTime(timeRemaining)}</span>
            </div>
          )}
          
          <div className="text-sm text-[var(--foreground-muted)]">
            {answeredCount}/{totalQuestions} answered
          </div>
        </div>
      </div>
      
      {/* Timer progress bar for timed quizzes */}
      {timedMode && timerActive && (
        <div className="h-1 bg-slate-100">
          <div 
            className={`h-full transition-all duration-1000 ${
              timeRemaining <= 60 ? 'bg-red-500' : timeRemaining <= 120 ? 'bg-amber-500' : 'bg-purple-500'
            }`}
            style={{ width: `${(timeRemaining / timeLimitSeconds) * 100}%` }}
          />
        </div>
      )}
      
      {/* Progress Bar */}
      <div className="h-1 bg-slate-100">
        <div 
          className="h-full bg-purple-500 transition-all duration-300"
          style={{ width: `${((currentQuestion + 1) / totalQuestions) * 100}%` }}
        />
      </div>
      
      {/* Question */}
      <div className="p-6 sm:p-8">
        {/* Question text with whitespace preserved for code */}
        <h2 className="text-lg font-medium mb-6 whitespace-pre-wrap">{question.question}</h2>
        
        {/* Answer Options */}
        <div className="space-y-3">
          {question.type === 'mcq' && question.options?.map((option, index) => {
            const isSelected = answers[question.id] === index;
            const isCorrect = showExplanation === question.id && question.correct === index;
            const isWrong = showExplanation === question.id && isSelected && question.correct !== index;
            
            // Format option text to properly display escape sequences like \n
            // B5: Quiz options with "Hello\nWorld" were showing identically to "Hello World"
            const formatOptionText = (text: string) => {
              // Replace escaped newlines with actual visual representation
              return text.replace(/\\n/g, '\n');
            };
            
            return (
              <button
                key={index}
                onClick={() => handleAnswer(question.id, index)}
                disabled={showExplanation === question.id}
                className={`
                  w-full p-4 text-left rounded-xl border-2 transition-all
                  ${isCorrect 
                    ? 'border-emerald-500 bg-emerald-50' 
                    : isWrong 
                      ? 'border-red-500 bg-red-50' 
                      : isSelected 
                        ? 'border-[var(--primary)] bg-[var(--primary)]/5' 
                        : 'border-[var(--border)] hover:border-[var(--primary)]'
                  }
                  disabled:cursor-not-allowed
                `}
              >
                <div className="flex items-center gap-3">
                  <span className={`
                    flex-shrink-0 w-8 h-8 rounded-lg flex items-center justify-center font-medium
                    ${isCorrect 
                      ? 'bg-emerald-500 text-white' 
                      : isWrong 
                        ? 'bg-red-500 text-white' 
                        : isSelected 
                          ? 'bg-[var(--primary)] text-white' 
                          : 'bg-slate-100 text-[var(--foreground)]'
                    }
                  `}>
                    {String.fromCharCode(65 + index)}
                  </span>
                  {/* Use whitespace-pre-wrap to preserve newlines in options (B5 fix) */}
                  <span className="flex-1 whitespace-pre-wrap">{formatOptionText(option)}</span>
                  {isCorrect && <CheckCircle2 className="w-5 h-5 text-emerald-600" />}
                  {isWrong && <XCircle className="w-5 h-5 text-red-600" />}
                </div>
              </button>
            );
          })}
          
          {question.type === 'true_false' && (
            <>
              {[true, false].map((value) => {
                const isSelected = answers[question.id] === value;
                const isCorrect = showExplanation === question.id && question.correct === value;
                const isWrong = showExplanation === question.id && isSelected && question.correct !== value;
                
                return (
                  <button
                    key={String(value)}
                    onClick={() => handleAnswer(question.id, value)}
                    disabled={showExplanation === question.id}
                    className={`
                      w-full p-4 text-left rounded-xl border-2 transition-all
                      ${isCorrect 
                        ? 'border-emerald-500 bg-emerald-50' 
                        : isWrong 
                          ? 'border-red-500 bg-red-50' 
                          : isSelected 
                            ? 'border-[var(--primary)] bg-[var(--primary)]/5' 
                            : 'border-[var(--border)] hover:border-[var(--primary)]'
                      }
                      disabled:cursor-not-allowed
                    `}
                  >
                    <div className="flex items-center gap-3">
                      <span className={`
                        flex-shrink-0 w-8 h-8 rounded-lg flex items-center justify-center font-medium
                        ${isCorrect 
                          ? 'bg-emerald-500 text-white' 
                          : isWrong 
                            ? 'bg-red-500 text-white' 
                            : isSelected 
                              ? 'bg-[var(--primary)] text-white' 
                              : 'bg-slate-100 text-[var(--foreground)]'
                        }
                      `}>
                        {value ? 'T' : 'F'}
                      </span>
                      <span className="flex-1">{value ? 'True' : 'False'}</span>
                      {isCorrect && <CheckCircle2 className="w-5 h-5 text-emerald-600" />}
                      {isWrong && <XCircle className="w-5 h-5 text-red-600" />}
                    </div>
                  </button>
                );
              })}
            </>
          )}
        </div>
        
        {/* Explanation */}
        {showExplanation === question.id && question.explanation && (
          <div className="mt-4 p-4 bg-blue-50 border border-blue-200 rounded-xl">
            <p className="text-sm text-blue-800">
              <strong>Explanation:</strong> {question.explanation}
            </p>
          </div>
        )}
        
        {/* P3: Struggling? Help button - shows when user gets a question wrong */}
        {showExplanation === question.id && answers[question.id] !== question.correct && !hasDismissedHelp && (
          <div className="mt-4 p-4 bg-amber-50 border border-amber-200 rounded-xl">
            <div className="flex items-start gap-3">
              <div className="flex-shrink-0 w-10 h-10 bg-amber-100 rounded-lg flex items-center justify-center">
                <Lightbulb className="w-5 h-5 text-amber-600" />
              </div>
              <div className="flex-1">
                <p className="font-medium text-amber-900 mb-1">Need more help?</p>
                <p className="text-sm text-amber-700 mb-3">
                  Don&apos;t worry! Here are some options to help you understand better:
                </p>
                <div className="flex flex-wrap gap-2">
                  <button
                    onClick={() => openChatWithMessage(
                      `I got this question wrong and need help understanding: "${question.question}"${question.explanation ? `\n\nThe explanation says: "${question.explanation}"` : ''}`
                    )}
                    className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-amber-600 text-white text-sm font-medium rounded-lg hover:bg-amber-700 transition-colors"
                  >
                    <MessageCircle className="w-4 h-4" />
                    Ask AI Tutor
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
      
      {/* Footer - Single action button */}
      <div className="px-6 py-4 border-t border-[var(--border)] bg-slate-50">
        <div className="flex items-center justify-between">
          {/* Progress dots */}
          <div className="flex items-center gap-1.5">
            {questions.map((q, index) => (
              <button
                key={q.id}
                onClick={() => setCurrentQuestion(index)}
                className={`w-2.5 h-2.5 rounded-full transition-all ${
                  index === currentQuestion 
                    ? 'bg-purple-500 scale-125' 
                    : answers[q.id] !== undefined 
                      ? 'bg-purple-300' 
                      : 'bg-slate-300 hover:bg-slate-400'
                }`}
              />
            ))}
          </div>
          
          {/* Single action button */}
          {currentQuestion < totalQuestions - 1 ? (
            <button
              onClick={() => setCurrentQuestion(prev => prev + 1)}
              disabled={!answers[question.id]}
              className="flex items-center gap-2 px-6 py-3 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-hover)] transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
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
              {isSubmitting ? "Submitting..." : "Submit Quiz"}
              <ChevronRight className="w-4 h-4" />
            </button>
          )}
        </div>
      </div>
    </div>
    </>
  );
}

