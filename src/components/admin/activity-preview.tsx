"use client";

import { useState } from "react";
import type { Activity } from "@/lib/database.types";
import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";
import { 
  CheckCircle2, 
  Circle, 
  ChevronRight, 
  ChevronLeft,
  RotateCcw,
  Shuffle
} from "lucide-react";

interface ActivityPreviewProps {
  activity: Activity;
}

export function ActivityPreview({ activity }: ActivityPreviewProps) {
  switch (activity.type) {
    case "lesson":
      return <LessonPreview content={activity.content as { markdown?: string } | null} />;
    case "quiz":
    case "checkpoint":
    case "mock_exam":
      return <QuizPreview content={activity.content as Record<string, unknown> | null} />;
    case "interactive":
      return <InteractivePreview content={activity.content} interactiveType={activity.interactive_type} />;
    default:
      return (
        <div className="p-6 text-center text-[var(--foreground-muted)]">
          <p>Preview not available for activity type: {activity.type}</p>
        </div>
      );
  }
}

// ============================================
// Lesson Preview with Markdown Rendering
// ============================================

function LessonPreview({ content }: { content: { markdown?: string } | null }) {
  const markdown = content?.markdown || "";
  const slides = markdown.split(/\n---\n/).filter(s => s.trim());
  const [currentSlide, setCurrentSlide] = useState(0);

  if (slides.length === 0) {
    return (
      <div className="p-6 text-center text-[var(--foreground-muted)]">
        <p>No content to preview</p>
      </div>
    );
  }

  return (
    <div className="flex flex-col h-full">
      {/* Slide Navigation */}
      {slides.length > 1 && (
        <div className="px-4 py-2 border-b border-[var(--border)] bg-slate-50 flex items-center justify-between">
          <button
            onClick={() => setCurrentSlide(Math.max(0, currentSlide - 1))}
            disabled={currentSlide === 0}
            className="p-1 rounded hover:bg-slate-200 disabled:opacity-30"
          >
            <ChevronLeft className="w-4 h-4" />
          </button>
          <span className="text-xs text-[var(--foreground-muted)]">
            Slide {currentSlide + 1} of {slides.length}
          </span>
          <button
            onClick={() => setCurrentSlide(Math.min(slides.length - 1, currentSlide + 1))}
            disabled={currentSlide === slides.length - 1}
            className="p-1 rounded hover:bg-slate-200 disabled:opacity-30"
          >
            <ChevronRight className="w-4 h-4" />
          </button>
        </div>
      )}

      {/* Markdown Content */}
      <div className="flex-1 overflow-y-auto p-6 prose prose-sm max-w-none">
        <ReactMarkdown
          remarkPlugins={[remarkGfm]}
          components={{
            // Custom renderers for special blocks
            blockquote: ({ children }) => {
              const text = String(children);
              if (text.includes(":::takeaways")) {
                return (
                  <div className="bg-emerald-50 border-l-4 border-emerald-500 p-4 rounded-r-lg my-4">
                    <p className="font-semibold text-emerald-700 mb-2">Key Takeaways</p>
                    {children}
                  </div>
                );
              }
              if (text.includes(":::warning")) {
                return (
                  <div className="bg-amber-50 border-l-4 border-amber-500 p-4 rounded-r-lg my-4">
                    <p className="font-semibold text-amber-700 mb-2">Warning</p>
                    {children}
                  </div>
                );
              }
              return <blockquote className="border-l-4 border-slate-300 pl-4 italic">{children}</blockquote>;
            },
            table: ({ children }) => (
              <div className="overflow-x-auto my-4">
                <table className="min-w-full divide-y divide-slate-200 border border-slate-200 rounded-lg">
                  {children}
                </table>
              </div>
            ),
            th: ({ children }) => (
              <th className="px-4 py-2 bg-slate-50 text-left text-xs font-semibold text-slate-600 uppercase tracking-wider">
                {children}
              </th>
            ),
            td: ({ children }) => (
              <td className="px-4 py-2 text-sm text-slate-700 border-t border-slate-100">
                {children}
              </td>
            ),
            code: ({ className, children }) => {
              const isInline = !className;
              if (isInline) {
                return (
                  <code className="px-1.5 py-0.5 bg-slate-100 text-slate-800 rounded text-sm font-mono">
                    {children}
                  </code>
                );
              }
              return (
                <pre className="bg-slate-900 text-slate-100 p-4 rounded-lg overflow-x-auto">
                  <code>{children}</code>
                </pre>
              );
            },
          }}
        >
          {slides[currentSlide]}
        </ReactMarkdown>
      </div>
    </div>
  );
}

// ============================================
// Quiz Preview
// ============================================

interface QuizQuestion {
  id: string;
  type: "mcq" | "true_false" | "fill_blank";
  question: string;
  options?: string[];
  correct: number | string | boolean;
  explanation?: string;
}

function QuizPreview({ content }: { content: Record<string, unknown> | null }) {
  const questions = (content?.questions || []) as QuizQuestion[];
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<number | string | boolean | null>(null);
  const [showExplanation, setShowExplanation] = useState(false);

  if (questions.length === 0) {
    return (
      <div className="p-6 text-center text-[var(--foreground-muted)]">
        <p>No questions to preview</p>
      </div>
    );
  }

  const question = questions[currentQuestion];
  const isCorrect = selectedAnswer === question.correct;

  const handleNext = () => {
    setSelectedAnswer(null);
    setShowExplanation(false);
    setCurrentQuestion(Math.min(questions.length - 1, currentQuestion + 1));
  };

  const handlePrev = () => {
    setSelectedAnswer(null);
    setShowExplanation(false);
    setCurrentQuestion(Math.max(0, currentQuestion - 1));
  };

  return (
    <div className="flex flex-col h-full">
      {/* Progress */}
      <div className="px-4 py-3 border-b border-[var(--border)] bg-slate-50">
        <div className="flex items-center justify-between mb-2">
          <span className="text-xs text-[var(--foreground-muted)]">
            Question {currentQuestion + 1} of {questions.length}
          </span>
          <div className="flex gap-1">
            {questions.map((_, idx) => (
              <button
                key={idx}
                onClick={() => {
                  setSelectedAnswer(null);
                  setShowExplanation(false);
                  setCurrentQuestion(idx);
                }}
                className={`w-2 h-2 rounded-full transition-colors ${
                  idx === currentQuestion ? "bg-[var(--primary)]" : "bg-slate-200"
                }`}
              />
            ))}
          </div>
        </div>
      </div>

      {/* Question */}
      <div className="flex-1 overflow-y-auto p-6">
        <p className="text-lg font-medium text-[var(--foreground)] mb-6">
          {question.question}
        </p>

        {/* MCQ Options */}
        {question.type === "mcq" && question.options && (
          <div className="space-y-3">
            {question.options.map((option, idx) => (
              <button
                key={idx}
                onClick={() => {
                  setSelectedAnswer(idx);
                  setShowExplanation(true);
                }}
                disabled={selectedAnswer !== null}
                className={`w-full p-4 rounded-lg border-2 text-left transition-all ${
                  selectedAnswer === null
                    ? "border-slate-200 hover:border-[var(--primary)] hover:bg-[var(--progress-bg)]"
                    : idx === question.correct
                      ? "border-emerald-500 bg-emerald-50"
                      : selectedAnswer === idx
                        ? "border-red-500 bg-red-50"
                        : "border-slate-200 opacity-50"
                }`}
              >
                <div className="flex items-center gap-3">
                  <span className={`w-6 h-6 rounded-full border-2 flex items-center justify-center text-xs font-medium ${
                    selectedAnswer !== null && idx === question.correct
                      ? "border-emerald-500 bg-emerald-500 text-white"
                      : selectedAnswer === idx && idx !== question.correct
                        ? "border-red-500 bg-red-500 text-white"
                        : "border-slate-300"
                  }`}>
                    {String.fromCharCode(65 + idx)}
                  </span>
                  <span className="text-[var(--foreground)]">{option}</span>
                </div>
              </button>
            ))}
          </div>
        )}

        {/* True/False */}
        {question.type === "true_false" && (
          <div className="flex gap-4">
            <button
              onClick={() => {
                setSelectedAnswer(true);
                setShowExplanation(true);
              }}
              disabled={selectedAnswer !== null}
              className={`flex-1 p-4 rounded-lg border-2 transition-all ${
                selectedAnswer === null
                  ? "border-slate-200 hover:border-emerald-400"
                  : question.correct === true
                    ? "border-emerald-500 bg-emerald-50"
                    : selectedAnswer === true
                      ? "border-red-500 bg-red-50"
                      : "border-slate-200 opacity-50"
              }`}
            >
              <CheckCircle2 className="w-6 h-6 mx-auto mb-2" />
              True
            </button>
            <button
              onClick={() => {
                setSelectedAnswer(false);
                setShowExplanation(true);
              }}
              disabled={selectedAnswer !== null}
              className={`flex-1 p-4 rounded-lg border-2 transition-all ${
                selectedAnswer === null
                  ? "border-slate-200 hover:border-red-400"
                  : question.correct === false
                    ? "border-emerald-500 bg-emerald-50"
                    : selectedAnswer === false
                      ? "border-red-500 bg-red-50"
                      : "border-slate-200 opacity-50"
              }`}
            >
              <Circle className="w-6 h-6 mx-auto mb-2" />
              False
            </button>
          </div>
        )}

        {/* Explanation */}
        {showExplanation && question.explanation && (
          <div className={`mt-6 p-4 rounded-lg ${
            isCorrect ? "bg-emerald-50 border border-emerald-200" : "bg-amber-50 border border-amber-200"
          }`}>
            <p className={`text-sm font-medium mb-1 ${isCorrect ? "text-emerald-700" : "text-amber-700"}`}>
              {isCorrect ? "Correct!" : "Not quite..."}
            </p>
            <p className="text-sm text-slate-700">{question.explanation}</p>
          </div>
        )}
      </div>

      {/* Navigation */}
      <div className="px-4 py-3 border-t border-[var(--border)] bg-slate-50 flex items-center justify-between">
        <button
          onClick={handlePrev}
          disabled={currentQuestion === 0}
          className="px-3 py-1.5 text-sm text-[var(--foreground-muted)] hover:text-[var(--foreground)] disabled:opacity-30"
        >
          Previous
        </button>
        <button
          onClick={() => {
            setSelectedAnswer(null);
            setShowExplanation(false);
          }}
          className="p-1.5 text-slate-400 hover:text-slate-600"
        >
          <RotateCcw className="w-4 h-4" />
        </button>
        <button
          onClick={handleNext}
          disabled={currentQuestion === questions.length - 1}
          className="px-3 py-1.5 text-sm text-[var(--primary)] font-medium hover:underline disabled:opacity-30"
        >
          Next
        </button>
      </div>
    </div>
  );
}

// ============================================
// Interactive Preview
// ============================================

function InteractivePreview({ 
  content, 
  interactiveType 
}: { 
  content: Record<string, unknown> | null;
  interactiveType: string | null;
}) {
  const instructions = (content?.instructions || "") as string;

  const renderPreview = () => {
    switch (interactiveType) {
      case "drag-drop-match":
        return <DragDropMatchPreview content={content} />;
      case "flashcards":
        return <FlashcardsPreview content={content} />;
      case "sort-steps":
        return <SortStepsPreview content={content} />;
      default:
        return (
          <div className="p-6 text-center text-[var(--foreground-muted)]">
            <p>Interactive preview for "{interactiveType}" type</p>
            <p className="text-xs mt-2">Full preview not available in editor.</p>
          </div>
        );
    }
  };

  return (
    <div className="flex flex-col h-full">
      {instructions && (
        <div className="px-4 py-3 border-b border-[var(--border)] bg-blue-50">
          <p className="text-sm text-blue-800">{instructions}</p>
        </div>
      )}
      <div className="flex-1 overflow-y-auto">
        {renderPreview()}
      </div>
    </div>
  );
}

function DragDropMatchPreview({ content }: { content: Record<string, unknown> | null }) {
  const pairs = (content?.pairs || []) as Array<{ left: string; right: string }>;
  
  return (
    <div className="p-6">
      <div className="grid grid-cols-2 gap-6">
        <div className="space-y-2">
          <p className="text-xs font-medium text-[var(--foreground-muted)] mb-3">Match these...</p>
          {pairs.map((pair, idx) => (
            <div key={idx} className="p-3 bg-blue-50 border border-blue-200 rounded-lg text-sm">
              {pair.left}
            </div>
          ))}
        </div>
        <div className="space-y-2">
          <p className="text-xs font-medium text-[var(--foreground-muted)] mb-3">...with these</p>
          {pairs.map((pair, idx) => (
            <div key={idx} className="p-3 bg-purple-50 border border-purple-200 rounded-lg text-sm">
              {pair.right}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

function FlashcardsPreview({ content }: { content: Record<string, unknown> | null }) {
  const cards = (content?.cards || []) as Array<{ term: string; definition: string }>;
  const [currentCard, setCurrentCard] = useState(0);
  const [flipped, setFlipped] = useState(false);
  
  if (cards.length === 0) {
    return <div className="p-6 text-center text-[var(--foreground-muted)]">No flashcards</div>;
  }
  
  const card = cards[currentCard];
  
  return (
    <div className="p-6 flex flex-col items-center">
      <div
        onClick={() => setFlipped(!flipped)}
        className="w-full max-w-sm aspect-[4/3] cursor-pointer perspective-1000"
      >
        <div className={`relative w-full h-full transition-transform duration-500 transform-style-preserve-3d ${
          flipped ? "rotate-y-180" : ""
        }`}>
          <div className="absolute inset-0 backface-hidden bg-white border-2 border-[var(--primary)] rounded-xl p-6 flex items-center justify-center">
            <p className="text-xl font-medium text-center">{card.term}</p>
          </div>
          <div className="absolute inset-0 backface-hidden rotate-y-180 bg-[var(--primary)] text-white rounded-xl p-6 flex items-center justify-center">
            <p className="text-lg text-center">{card.definition}</p>
          </div>
        </div>
      </div>
      
      <div className="flex items-center gap-4 mt-6">
        <button
          onClick={() => {
            setFlipped(false);
            setCurrentCard(Math.max(0, currentCard - 1));
          }}
          disabled={currentCard === 0}
          className="p-2 rounded-full bg-slate-100 hover:bg-slate-200 disabled:opacity-30"
        >
          <ChevronLeft className="w-4 h-4" />
        </button>
        <span className="text-sm text-[var(--foreground-muted)]">
          {currentCard + 1} / {cards.length}
        </span>
        <button
          onClick={() => {
            setFlipped(false);
            setCurrentCard(Math.min(cards.length - 1, currentCard + 1));
          }}
          disabled={currentCard === cards.length - 1}
          className="p-2 rounded-full bg-slate-100 hover:bg-slate-200 disabled:opacity-30"
        >
          <ChevronRight className="w-4 h-4" />
        </button>
      </div>
      
      <p className="text-xs text-[var(--foreground-muted)] mt-4">Click card to flip</p>
    </div>
  );
}

function SortStepsPreview({ content }: { content: Record<string, unknown> | null }) {
  const steps = (content?.steps || []) as string[];
  const [shuffled, setShuffled] = useState<string[]>([]);
  
  const handleShuffle = () => {
    const arr = [...steps];
    for (let i = arr.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [arr[i], arr[j]] = [arr[j], arr[i]];
    }
    setShuffled(arr);
  };
  
  const displaySteps = shuffled.length > 0 ? shuffled : steps;
  
  return (
    <div className="p-6">
      <div className="flex items-center justify-between mb-4">
        <p className="text-sm text-[var(--foreground-muted)]">Drag to reorder</p>
        <button
          onClick={handleShuffle}
          className="inline-flex items-center gap-1 text-xs text-[var(--primary)] hover:underline"
        >
          <Shuffle className="w-3 h-3" />
          Shuffle
        </button>
      </div>
      <div className="space-y-2">
        {displaySteps.map((step, idx) => (
          <div
            key={idx}
            className="flex items-center gap-3 p-3 bg-white border border-[var(--border)] rounded-lg cursor-move hover:shadow-sm transition-shadow"
          >
            <span className="w-6 h-6 rounded-full bg-slate-100 text-slate-600 text-xs flex items-center justify-center font-medium">
              {idx + 1}
            </span>
            <span className="text-sm">{step}</span>
          </div>
        ))}
      </div>
    </div>
  );
}

