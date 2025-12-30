"use client";

import { useState, useEffect, useCallback, useRef } from "react";
import { CheckCircle2, XCircle, HelpCircle, ChevronRight, BookOpen, Lightbulb, MessageCircle } from "lucide-react";
import type { Activity, QuizQuestion } from "@/lib/database.types";
import { markActivityComplete, trackActivityView, updateActivityProgress } from "@/lib/activities/actions";
import { useChatContext } from "@/components/chat";

interface QuizViewerProps {
  activity: Activity;
  userId: string;
  isCompleted: boolean;
}

interface QuizContent {
  questions: QuizQuestion[];
  passing_score: number;
  shuffle_questions?: boolean;
}

export function QuizViewer({ activity, userId, isCompleted }: QuizViewerProps) {
  const content = activity.content as QuizContent | null;
  const questions = content?.questions || [];
  const passingScore = content?.passing_score || activity.passing_score || 70;

  // Chat context for struggling detection and current question tracking
  // Extract specific methods to avoid dependency on entire context object (prevents infinite re-renders)
  const { updateCurrentQuestion, triggerPopup, hasDismissedHelp } = useChatContext();
  
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
      updateCurrentQuestion(question.question, currentQuestion + 1);
    }
  }, [currentQuestion, questions, updateCurrentQuestion]);
  
  const [answers, setAnswers] = useState<Record<string, number | boolean | string>>({});
  const [showResults, setShowResults] = useState(isCompleted);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [score, setScore] = useState<number | null>(null);
  const [showExplanation, setShowExplanation] = useState<string | null>(null);
  
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
  };

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
          
          {!passed && (
            <button
              onClick={handleRetry}
              className="px-6 py-3 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-hover)] transition-colors"
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

  if (!question) {
    return (
      <div className="bg-white rounded-2xl p-8 text-center">
        <p className="text-[var(--foreground-muted)]">No questions available.</p>
      </div>
    );
  }

  return (
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
        
        <div className="text-sm text-[var(--foreground-muted)]">
          {answeredCount}/{totalQuestions} answered
        </div>
      </div>
      
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
                    onClick={() => triggerPopup(
                      `I got this question wrong and need help understanding: "${question.question}"`,
                      'struggling'
                    )}
                    className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-amber-600 text-white text-sm font-medium rounded-lg hover:bg-amber-700 transition-colors"
                  >
                    <MessageCircle className="w-4 h-4" />
                    Ask AI Tutor
                  </button>
                  <button
                    onClick={() => {
                      // Find previous lesson in this module (simplified approach)
                      const relatedLessonLink = document.querySelector('a[href*="lesson"]');
                      if (relatedLessonLink) {
                        (relatedLessonLink as HTMLAnchorElement).click();
                      }
                    }}
                    className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-white text-amber-700 text-sm font-medium rounded-lg border border-amber-300 hover:bg-amber-50 transition-colors"
                  >
                    <BookOpen className="w-4 h-4" />
                    Review Related Lesson
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
  );
}

