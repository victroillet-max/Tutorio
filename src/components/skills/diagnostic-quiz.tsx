"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";

interface DiagnosticQuestion {
  id: string;
  question: string;
  options: string[];
  correct: number;
  skillId: string;
  skillName: string;
}

interface DiagnosticQuizProps {
  skillCluster: string;
  questions: DiagnosticQuestion[];
  onComplete: (results: {
    score: number;
    correctAnswers: number;
    totalQuestions: number;
    gapsIdentified: string[];
  }) => void;
  onClose?: () => void;
}

export function DiagnosticQuiz({
  skillCluster,
  questions,
  onComplete,
  onClose,
}: DiagnosticQuizProps) {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null);
  const [answers, setAnswers] = useState<Record<string, boolean>>({});
  const [showResult, setShowResult] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const currentQuestion = questions[currentIndex];
  const isLastQuestion = currentIndex === questions.length - 1;

  const handleSelectAnswer = (index: number) => {
    if (selectedAnswer !== null) return; // Already answered
    setSelectedAnswer(index);
  };

  const handleNext = () => {
    if (selectedAnswer === null) return;

    const isCorrect = selectedAnswer === currentQuestion.correct;
    setAnswers(prev => ({
      ...prev,
      [currentQuestion.id]: isCorrect,
    }));

    if (isLastQuestion) {
      // Calculate final results
      const allAnswers = { ...answers, [currentQuestion.id]: isCorrect };
      const correctCount = Object.values(allAnswers).filter(Boolean).length;
      const score = Math.round((correctCount / questions.length) * 100);
      
      // Identify gaps (skills where questions were answered incorrectly)
      const gaps = questions
        .filter(q => !allAnswers[q.id])
        .map(q => q.skillId)
        .filter((id, index, arr) => arr.indexOf(id) === index);

      onComplete({
        score,
        correctAnswers: correctCount,
        totalQuestions: questions.length,
        gapsIdentified: gaps,
      });
      setShowResult(true);
    } else {
      setCurrentIndex(prev => prev + 1);
      setSelectedAnswer(null);
    }
  };

  const getResultMessage = () => {
    const correctCount = Object.values(answers).filter(Boolean).length;
    const score = Math.round((correctCount / questions.length) * 100);
    
    if (score >= 80) {
      return {
        title: "Excellent!",
        message: "You have a strong foundation. Ready to move forward!",
        color: "text-emerald-400",
      };
    }
    if (score >= 60) {
      return {
        title: "Good Progress!",
        message: "You're on the right track. A quick review might help.",
        color: "text-amber-400",
      };
    }
    return {
      title: "Keep Learning!",
      message: "Some concepts need more practice. Let's review them.",
      color: "text-violet-400",
    };
  };

  if (showResult) {
    const correctCount = Object.values(answers).filter(Boolean).length;
    const score = Math.round((correctCount / questions.length) * 100);
    const result = getResultMessage();
    const gaps = questions
      .filter(q => !answers[q.id])
      .map(q => q.skillName)
      .filter((name, index, arr) => arr.indexOf(name) === index);

    return (
      <div className="bg-zinc-900 border border-zinc-800 rounded-2xl p-6 max-w-lg mx-auto">
        <div className="text-center mb-6">
          <div className={cn(
            "w-20 h-20 mx-auto mb-4 rounded-full flex items-center justify-center",
            score >= 80 ? "bg-emerald-500/20" : score >= 60 ? "bg-amber-500/20" : "bg-violet-500/20"
          )}>
            <span className={cn("text-3xl font-bold", result.color)}>
              {score}%
            </span>
          </div>
          <h3 className={cn("text-xl font-bold", result.color)}>{result.title}</h3>
          <p className="text-zinc-400 mt-2">{result.message}</p>
        </div>

        <div className="bg-zinc-800/50 rounded-xl p-4 mb-6">
          <div className="flex items-center justify-between text-sm mb-3">
            <span className="text-zinc-400">Questions Correct</span>
            <span className="text-white font-medium">{correctCount}/{questions.length}</span>
          </div>
          <div className="h-2 bg-zinc-700 rounded-full overflow-hidden">
            <div
              className={cn(
                "h-full rounded-full",
                score >= 80 ? "bg-emerald-500" : score >= 60 ? "bg-amber-500" : "bg-violet-500"
              )}
              style={{ width: `${score}%` }}
            />
          </div>
        </div>

        {gaps.length > 0 && (
          <div className="mb-6">
            <h4 className="text-sm font-medium text-white mb-3">Areas to Review</h4>
            <div className="space-y-2">
              {gaps.map((gap, index) => (
                <div
                  key={index}
                  className="flex items-center gap-2 bg-zinc-800/50 rounded-lg p-3"
                >
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="text-amber-400">
                    <circle cx="12" cy="12" r="10" />
                    <line x1="12" y1="8" x2="12" y2="12" />
                    <line x1="12" y1="16" x2="12.01" y2="16" />
                  </svg>
                  <span className="text-sm text-zinc-300">{gap}</span>
                </div>
              ))}
            </div>
          </div>
        )}

        <div className="flex gap-3">
          <Button
            onClick={onClose}
            variant="outline"
            className="flex-1 border-zinc-700 text-zinc-300 hover:bg-zinc-800"
          >
            Close
          </Button>
          <Button
            onClick={() => window.location.href = "/courses/computational-thinking"}
            className="flex-1 bg-violet-600 hover:bg-violet-500"
          >
            Review Lessons
          </Button>
        </div>
      </div>
    );
  }

  return (
    <div className="bg-zinc-900 border border-zinc-800 rounded-2xl p-6 max-w-lg mx-auto">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <p className="text-xs text-violet-400 font-medium uppercase tracking-wider">
            Diagnostic Quiz
          </p>
          <h3 className="text-lg font-semibold text-white mt-1">
            {skillCluster}
          </h3>
        </div>
        <div className="text-right">
          <p className="text-sm text-zinc-400">
            Question {currentIndex + 1} of {questions.length}
          </p>
        </div>
      </div>

      {/* Progress */}
      <div className="h-1.5 bg-zinc-800 rounded-full overflow-hidden mb-6">
        <div
          className="h-full bg-violet-500 rounded-full transition-all duration-300"
          style={{ width: `${((currentIndex + 1) / questions.length) * 100}%` }}
        />
      </div>

      {/* Question */}
      <div className="mb-6">
        <p className="text-white text-lg leading-relaxed">
          {currentQuestion.question}
        </p>
        <p className="text-xs text-zinc-500 mt-2">
          Testing: {currentQuestion.skillName}
        </p>
      </div>

      {/* Options */}
      <div className="space-y-3 mb-6">
        {currentQuestion.options.map((option, index) => {
          const isSelected = selectedAnswer === index;
          const isCorrect = index === currentQuestion.correct;
          const showCorrectness = selectedAnswer !== null;

          return (
            <button
              key={index}
              onClick={() => handleSelectAnswer(index)}
              disabled={selectedAnswer !== null}
              className={cn(
                "w-full p-4 rounded-xl border text-left transition-all",
                "disabled:cursor-default",
                !showCorrectness && "border-zinc-700 hover:border-zinc-600 hover:bg-zinc-800/50",
                isSelected && !showCorrectness && "border-violet-500 bg-violet-500/10",
                showCorrectness && isCorrect && "border-emerald-500 bg-emerald-500/10",
                showCorrectness && isSelected && !isCorrect && "border-rose-500 bg-rose-500/10",
                showCorrectness && !isSelected && !isCorrect && "border-zinc-700 opacity-50"
              )}
            >
              <div className="flex items-center gap-3">
                <div className={cn(
                  "w-6 h-6 rounded-full flex items-center justify-center text-xs font-medium",
                  !showCorrectness && "bg-zinc-700 text-zinc-300",
                  showCorrectness && isCorrect && "bg-emerald-500 text-white",
                  showCorrectness && isSelected && !isCorrect && "bg-rose-500 text-white",
                  showCorrectness && !isSelected && !isCorrect && "bg-zinc-700 text-zinc-500"
                )}>
                  {showCorrectness && isCorrect ? (
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round">
                      <polyline points="20 6 9 17 4 12" />
                    </svg>
                  ) : showCorrectness && isSelected && !isCorrect ? (
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round">
                      <line x1="18" y1="6" x2="6" y2="18" />
                      <line x1="6" y1="6" x2="18" y2="18" />
                    </svg>
                  ) : (
                    String.fromCharCode(65 + index)
                  )}
                </div>
                <span className={cn(
                  "text-sm",
                  showCorrectness && isCorrect ? "text-emerald-300" : "text-zinc-300"
                )}>
                  {option}
                </span>
              </div>
            </button>
          );
        })}
      </div>

      {/* Actions */}
      <div className="flex gap-3">
        {onClose && (
          <Button
            onClick={onClose}
            variant="outline"
            className="border-zinc-700 text-zinc-300 hover:bg-zinc-800"
          >
            Cancel
          </Button>
        )}
        <Button
          onClick={handleNext}
          disabled={selectedAnswer === null}
          className="flex-1 bg-violet-600 hover:bg-violet-500 disabled:opacity-50"
        >
          {isLastQuestion ? "See Results" : "Next Question"}
        </Button>
      </div>
    </div>
  );
}

