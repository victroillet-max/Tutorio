"use client";

import { useState, useEffect } from "react";
import { CheckCircle2, XCircle, HelpCircle, ChevronRight } from "lucide-react";
import type { Activity, QuizQuestion } from "@/lib/database.types";
import { markActivityComplete, trackActivityView } from "@/lib/activities/actions";

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

  // Track activity view when component mounts
  useEffect(() => {
    trackActivityView(activity.id).catch(console.error);
  }, [activity.id]);
  
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [answers, setAnswers] = useState<Record<string, number | boolean | string>>({});
  const [showResults, setShowResults] = useState(isCompleted);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [score, setScore] = useState<number | null>(null);
  const [showExplanation, setShowExplanation] = useState<string | null>(null);

  const question = questions[currentQuestion];
  const totalQuestions = questions.length;
  const answeredCount = Object.keys(answers).length;

  const handleAnswer = (questionId: string, answer: number | boolean | string) => {
    setAnswers(prev => ({ ...prev, [questionId]: answer }));
    setShowExplanation(questionId);
  };

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
        <h2 className="text-lg font-medium mb-6">{question.question}</h2>
        
        {/* Answer Options */}
        <div className="space-y-3">
          {question.type === 'mcq' && question.options?.map((option, index) => {
            const isSelected = answers[question.id] === index;
            const isCorrect = showExplanation === question.id && question.correct === index;
            const isWrong = showExplanation === question.id && isSelected && question.correct !== index;
            
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
                  <span className="flex-1">{option}</span>
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

