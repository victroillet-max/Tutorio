"use client";

import { useState } from "react";
import { 
  Plus, 
  Trash2, 
  GripVertical,
  CheckCircle2,
  Circle,
  HelpCircle
} from "lucide-react";

interface QuizQuestion {
  id: string;
  type: "mcq" | "true_false" | "fill_blank";
  difficulty?: string;
  question: string;
  options?: string[];
  correct: number | string | boolean;
  explanation?: string;
}

interface QuizContent {
  questions: QuizQuestion[];
  passing_score?: number;
}

interface QuizEditorProps {
  content: Record<string, unknown> | null;
  onChange: (content: Record<string, unknown>) => void;
}

export function QuizEditor({ content, onChange }: QuizEditorProps) {
  const quizContent = content as unknown as QuizContent | null;
  const [questions, setQuestions] = useState<QuizQuestion[]>(
    quizContent?.questions || []
  );
  const [passingScore, setPassingScore] = useState(
    quizContent?.passing_score || 70
  );
  const [expandedQuestion, setExpandedQuestion] = useState<string | null>(null);

  const updateContent = (newQuestions: QuizQuestion[], newPassingScore?: number) => {
    onChange({
      questions: newQuestions,
      passing_score: newPassingScore ?? passingScore
    });
  };

  const addQuestion = () => {
    const newQuestion: QuizQuestion = {
      id: `q${Date.now()}`,
      type: "mcq",
      question: "",
      options: ["", "", "", ""],
      correct: 0,
      explanation: ""
    };
    const newQuestions = [...questions, newQuestion];
    setQuestions(newQuestions);
    setExpandedQuestion(newQuestion.id);
    updateContent(newQuestions);
  };

  const updateQuestion = (id: string, updates: Partial<QuizQuestion>) => {
    const newQuestions = questions.map(q => 
      q.id === id ? { ...q, ...updates } : q
    );
    setQuestions(newQuestions);
    updateContent(newQuestions);
  };

  const deleteQuestion = (id: string) => {
    const newQuestions = questions.filter(q => q.id !== id);
    setQuestions(newQuestions);
    updateContent(newQuestions);
  };

  const moveQuestion = (index: number, direction: "up" | "down") => {
    const newIndex = direction === "up" ? index - 1 : index + 1;
    if (newIndex < 0 || newIndex >= questions.length) return;
    
    const newQuestions = [...questions];
    [newQuestions[index], newQuestions[newIndex]] = [newQuestions[newIndex], newQuestions[index]];
    setQuestions(newQuestions);
    updateContent(newQuestions);
  };

  return (
    <div className="flex flex-col h-full">
      {/* Header */}
      <div className="p-4 border-b border-[var(--border)] bg-slate-50 flex items-center justify-between">
        <div className="flex items-center gap-4">
          <span className="text-sm text-[var(--foreground)]">
            {questions.length} question{questions.length !== 1 ? "s" : ""}
          </span>
          <div className="flex items-center gap-2">
            <label className="text-sm text-[var(--foreground-muted)]">Passing Score:</label>
            <input
              type="number"
              value={passingScore}
              onChange={(e) => {
                const val = parseInt(e.target.value) || 70;
                setPassingScore(val);
                updateContent(questions, val);
              }}
              min={0}
              max={100}
              className="w-16 px-2 py-1 text-sm rounded border border-[var(--border)] focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
            />
            <span className="text-sm text-[var(--foreground-muted)]">%</span>
          </div>
        </div>
        <button
          onClick={addQuestion}
          className="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg bg-[var(--primary)] text-white text-sm font-medium hover:bg-[var(--primary-dark)] transition-colors"
        >
          <Plus className="w-4 h-4" />
          Add Question
        </button>
      </div>

      {/* Questions List */}
      <div className="flex-1 overflow-y-auto p-4 space-y-3">
        {questions.map((question, index) => (
          <div
            key={question.id}
            className="border border-[var(--border)] rounded-xl overflow-hidden bg-white"
          >
            {/* Question Header */}
            <div
              onClick={() => setExpandedQuestion(
                expandedQuestion === question.id ? null : question.id
              )}
              className="flex items-center gap-3 p-4 cursor-pointer hover:bg-slate-50 transition-colors"
            >
              <GripVertical className="w-4 h-4 text-slate-300" />
              <span className="w-6 h-6 rounded-full bg-[var(--primary)] text-white text-xs flex items-center justify-center font-medium">
                {index + 1}
              </span>
              <div className="flex-1 min-w-0">
                <p className="text-sm font-medium text-[var(--foreground)] truncate">
                  {question.question || "Untitled question"}
                </p>
                <p className="text-xs text-[var(--foreground-muted)]">
                  {question.type === "mcq" ? "Multiple Choice" : 
                   question.type === "true_false" ? "True/False" : "Fill in the Blank"}
                </p>
              </div>
              <div className="flex items-center gap-2">
                <button
                  onClick={(e) => {
                    e.stopPropagation();
                    moveQuestion(index, "up");
                  }}
                  disabled={index === 0}
                  className="p-1 text-slate-400 hover:text-slate-600 disabled:opacity-30"
                >
                  ↑
                </button>
                <button
                  onClick={(e) => {
                    e.stopPropagation();
                    moveQuestion(index, "down");
                  }}
                  disabled={index === questions.length - 1}
                  className="p-1 text-slate-400 hover:text-slate-600 disabled:opacity-30"
                >
                  ↓
                </button>
                <button
                  onClick={(e) => {
                    e.stopPropagation();
                    deleteQuestion(question.id);
                  }}
                  className="p-1 text-red-400 hover:text-red-600"
                >
                  <Trash2 className="w-4 h-4" />
                </button>
              </div>
            </div>

            {/* Expanded Editor */}
            {expandedQuestion === question.id && (
              <div className="p-4 border-t border-[var(--border)] bg-slate-50 space-y-4">
                {/* Question Type */}
                <div className="grid grid-cols-3 gap-4">
                  <div>
                    <label className="block text-xs text-[var(--foreground-muted)] mb-1">Type</label>
                    <select
                      value={question.type}
                      onChange={(e) => {
                        const type = e.target.value as QuizQuestion["type"];
                        const updates: Partial<QuizQuestion> = { type };
                        if (type === "true_false") {
                          updates.options = undefined;
                          updates.correct = true;
                        } else if (type === "mcq") {
                          updates.options = ["", "", "", ""];
                          updates.correct = 0;
                        } else {
                          updates.options = undefined;
                          updates.correct = "";
                        }
                        updateQuestion(question.id, updates);
                      }}
                      className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
                    >
                      <option value="mcq">Multiple Choice</option>
                      <option value="true_false">True/False</option>
                      <option value="fill_blank">Fill in the Blank</option>
                    </select>
                  </div>
                  <div>
                    <label className="block text-xs text-[var(--foreground-muted)] mb-1">Difficulty</label>
                    <select
                      value={question.difficulty || "basic"}
                      onChange={(e) => updateQuestion(question.id, { difficulty: e.target.value })}
                      className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
                    >
                      <option value="basic">Basic</option>
                      <option value="applied">Applied</option>
                      <option value="exam">Exam</option>
                    </select>
                  </div>
                </div>

                {/* Question Text */}
                <div>
                  <label className="block text-xs text-[var(--foreground-muted)] mb-1">Question</label>
                  <textarea
                    value={question.question}
                    onChange={(e) => updateQuestion(question.id, { question: e.target.value })}
                    rows={2}
                    className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] resize-none"
                    placeholder="Enter your question..."
                  />
                </div>

                {/* Options (for MCQ) */}
                {question.type === "mcq" && question.options && (
                  <div>
                    <label className="block text-xs text-[var(--foreground-muted)] mb-1">Options</label>
                    <div className="space-y-2">
                      {question.options.map((option, optIdx) => (
                        <div key={optIdx} className="flex items-center gap-2">
                          <button
                            onClick={() => updateQuestion(question.id, { correct: optIdx })}
                            className={`w-6 h-6 rounded-full border-2 flex items-center justify-center transition-colors ${
                              question.correct === optIdx
                                ? "border-emerald-500 bg-emerald-500 text-white"
                                : "border-slate-300 hover:border-emerald-400"
                            }`}
                          >
                            {question.correct === optIdx && <CheckCircle2 className="w-4 h-4" />}
                          </button>
                          <input
                            type="text"
                            value={option}
                            onChange={(e) => {
                              const newOptions = [...question.options!];
                              newOptions[optIdx] = e.target.value;
                              updateQuestion(question.id, { options: newOptions });
                            }}
                            className="flex-1 px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
                            placeholder={`Option ${optIdx + 1}`}
                          />
                          {question.options!.length > 2 && (
                            <button
                              onClick={() => {
                                const newOptions = question.options!.filter((_, i) => i !== optIdx);
                                const newCorrect = typeof question.correct === "number" && question.correct >= optIdx 
                                  ? Math.max(0, question.correct - 1) 
                                  : question.correct;
                                updateQuestion(question.id, { options: newOptions, correct: newCorrect });
                              }}
                              className="p-1 text-slate-400 hover:text-red-500"
                            >
                              <Trash2 className="w-4 h-4" />
                            </button>
                          )}
                        </div>
                      ))}
                      <button
                        onClick={() => {
                          updateQuestion(question.id, { 
                            options: [...question.options!, ""] 
                          });
                        }}
                        className="text-xs text-[var(--primary)] hover:underline"
                      >
                        + Add option
                      </button>
                    </div>
                  </div>
                )}

                {/* True/False */}
                {question.type === "true_false" && (
                  <div>
                    <label className="block text-xs text-[var(--foreground-muted)] mb-1">Correct Answer</label>
                    <div className="flex gap-4">
                      <button
                        onClick={() => updateQuestion(question.id, { correct: true })}
                        className={`flex items-center gap-2 px-4 py-2 rounded-lg border-2 transition-colors ${
                          question.correct === true
                            ? "border-emerald-500 bg-emerald-50 text-emerald-700"
                            : "border-slate-200 hover:border-emerald-300"
                        }`}
                      >
                        <CheckCircle2 className="w-4 h-4" />
                        True
                      </button>
                      <button
                        onClick={() => updateQuestion(question.id, { correct: false })}
                        className={`flex items-center gap-2 px-4 py-2 rounded-lg border-2 transition-colors ${
                          question.correct === false
                            ? "border-red-500 bg-red-50 text-red-700"
                            : "border-slate-200 hover:border-red-300"
                        }`}
                      >
                        <Circle className="w-4 h-4" />
                        False
                      </button>
                    </div>
                  </div>
                )}

                {/* Fill in the Blank */}
                {question.type === "fill_blank" && (
                  <div>
                    <label className="block text-xs text-[var(--foreground-muted)] mb-1">Correct Answer</label>
                    <input
                      type="text"
                      value={String(question.correct)}
                      onChange={(e) => updateQuestion(question.id, { correct: e.target.value })}
                      className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
                      placeholder="Enter the correct answer..."
                    />
                  </div>
                )}

                {/* Explanation */}
                <div>
                  <label className="block text-xs text-[var(--foreground-muted)] mb-1">Explanation</label>
                  <textarea
                    value={question.explanation || ""}
                    onChange={(e) => updateQuestion(question.id, { explanation: e.target.value })}
                    rows={2}
                    className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] resize-none"
                    placeholder="Explain the correct answer..."
                  />
                </div>
              </div>
            )}
          </div>
        ))}

        {questions.length === 0 && (
          <div className="text-center py-12">
            <HelpCircle className="w-12 h-12 text-slate-300 mx-auto mb-4" />
            <p className="text-[var(--foreground-muted)]">No questions yet</p>
            <button
              onClick={addQuestion}
              className="mt-4 inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-[var(--primary)] text-white text-sm font-medium hover:bg-[var(--primary-dark)] transition-colors"
            >
              <Plus className="w-4 h-4" />
              Add Your First Question
            </button>
          </div>
        )}
      </div>
    </div>
  );
}

