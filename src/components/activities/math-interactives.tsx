"use client";

import { useState, useEffect, useCallback } from "react";
import { 
  CheckCircle2, 
  X, 
  Calculator, 
  TrendingUp, 
  TrendingDown, 
  ArrowRight,
  RefreshCw,
  Lightbulb,
  Target,
  DollarSign
} from "lucide-react";

// ============================================
// Interest Calculator Interactive
// For Compound Interest skill (EL-06)
// ============================================

interface InterestCalculatorProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface InterestProblem {
  principal: number;
  rate: number;
  time: number;
  compounding: 'simple' | 'annually' | 'semi-annually' | 'quarterly' | 'monthly';
  question: string;
  correctAnswer: number;
  tolerance?: number;
}

export function InterestCalculator({ content, onComplete, completed }: InterestCalculatorProps) {
  const problems = (content?.problems as InterestProblem[]) || getDefaultInterestProblems();
  const instructions = (content?.instructions as string) || "Calculate the interest or final amount for each scenario.";
  
  const [currentProblem, setCurrentProblem] = useState(0);
  const [userAnswer, setUserAnswer] = useState("");
  const [showResult, setShowResult] = useState(false);
  const [isCorrect, setIsCorrect] = useState(false);
  const [correctCount, setCorrectCount] = useState(0);
  const [showHint, setShowHint] = useState(false);
  
  const problem = problems[currentProblem];
  const tolerance = problem?.tolerance || 0.01;
  
  const getCompoundingLabel = (comp: string) => {
    switch (comp) {
      case 'simple': return 'Simple Interest';
      case 'annually': return 'Compounded Annually';
      case 'semi-annually': return 'Compounded Semi-Annually';
      case 'quarterly': return 'Compounded Quarterly';
      case 'monthly': return 'Compounded Monthly';
      default: return comp;
    }
  };
  
  const getCompoundingN = (comp: string) => {
    switch (comp) {
      case 'simple': return 0;
      case 'annually': return 1;
      case 'semi-annually': return 2;
      case 'quarterly': return 4;
      case 'monthly': return 12;
      default: return 1;
    }
  };
  
  const handleSubmit = () => {
    const answer = parseFloat(userAnswer.replace(/,/g, ''));
    const correct = Math.abs(answer - problem.correctAnswer) <= Math.abs(problem.correctAnswer * tolerance);
    setIsCorrect(correct);
    setShowResult(true);
    if (correct) {
      setCorrectCount(prev => prev + 1);
    }
  };
  
  const handleNext = () => {
    if (currentProblem < problems.length - 1) {
      setCurrentProblem(prev => prev + 1);
      setUserAnswer("");
      setShowResult(false);
      setShowHint(false);
    } else if (correctCount >= Math.ceil(problems.length * 0.7)) {
      onComplete();
    }
  };
  
  const handleReset = () => {
    setCurrentProblem(0);
    setUserAnswer("");
    setShowResult(false);
    setCorrectCount(0);
    setShowHint(false);
  };
  
  if (!problem) return null;
  
  const isLastProblem = currentProblem === problems.length - 1;
  const passedThreshold = correctCount >= Math.ceil(problems.length * 0.7);
  
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-start gap-3 p-4 bg-indigo-50 rounded-xl">
        <Calculator className="w-6 h-6 text-indigo-600 mt-0.5 flex-shrink-0" />
        <div>
          <p className="text-slate-700">{instructions}</p>
          <p className="text-sm text-slate-500 mt-1">
            Problem {currentProblem + 1} of {problems.length} | 
            Score: {correctCount}/{currentProblem + (showResult ? 1 : 0)}
          </p>
        </div>
      </div>
      
      {/* Problem Display */}
      <div className="bg-white border border-slate-200 rounded-xl p-6 space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div className="p-3 bg-slate-50 rounded-lg">
            <p className="text-sm text-slate-500">Principal</p>
            <p className="text-xl font-bold text-slate-800">CHF {problem.principal.toLocaleString()}</p>
          </div>
          <div className="p-3 bg-slate-50 rounded-lg">
            <p className="text-sm text-slate-500">Interest Rate</p>
            <p className="text-xl font-bold text-slate-800">{problem.rate}%</p>
          </div>
          <div className="p-3 bg-slate-50 rounded-lg">
            <p className="text-sm text-slate-500">Time Period</p>
            <p className="text-xl font-bold text-slate-800">{problem.time} {problem.time === 1 ? 'year' : 'years'}</p>
          </div>
          <div className="p-3 bg-slate-50 rounded-lg">
            <p className="text-sm text-slate-500">Type</p>
            <p className="text-lg font-bold text-slate-800">{getCompoundingLabel(problem.compounding)}</p>
          </div>
        </div>
        
        <div className="pt-4 border-t border-slate-200">
          <p className="font-medium text-slate-800">{problem.question}</p>
        </div>
        
        {/* Hint Toggle */}
        {!showResult && (
          <button
            onClick={() => setShowHint(!showHint)}
            className="flex items-center gap-2 text-sm text-indigo-600 hover:text-indigo-700"
          >
            <Lightbulb className="w-4 h-4" />
            {showHint ? "Hide hint" : "Show hint"}
          </button>
        )}
        
        {showHint && !showResult && (
          <div className="p-3 bg-amber-50 border border-amber-200 rounded-lg text-sm text-amber-800">
            {problem.compounding === 'simple' ? (
              <p>Simple Interest Formula: I = P × r × t, where P = Principal, r = rate (as decimal), t = time</p>
            ) : (
              <p>Compound Interest Formula: A = P(1 + r/n)^(nt), where n = {getCompoundingN(problem.compounding)} for {getCompoundingLabel(problem.compounding)}</p>
            )}
          </div>
        )}
      </div>
      
      {/* Answer Input */}
      <div className="space-y-3">
        <div className="flex gap-3">
          <div className="relative flex-1">
            <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">CHF</span>
            <input
              type="text"
              value={userAnswer}
              onChange={(e) => setUserAnswer(e.target.value)}
              disabled={showResult}
              placeholder="Enter your answer"
              className="w-full pl-12 pr-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 disabled:bg-slate-100"
            />
          </div>
          {!showResult && (
            <button
              onClick={handleSubmit}
              disabled={!userAnswer}
              className="px-6 py-3 bg-indigo-600 text-white font-medium rounded-lg hover:bg-indigo-700 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Check
            </button>
          )}
        </div>
        
        {/* Result */}
        {showResult && (
          <div className={`p-4 rounded-lg ${isCorrect ? 'bg-emerald-50 border border-emerald-200' : 'bg-red-50 border border-red-200'}`}>
            <div className="flex items-center gap-2 mb-2">
              {isCorrect ? (
                <>
                  <CheckCircle2 className="w-5 h-5 text-emerald-600" />
                  <span className="font-medium text-emerald-700">Correct!</span>
                </>
              ) : (
                <>
                  <X className="w-5 h-5 text-red-600" />
                  <span className="font-medium text-red-700">Not quite right</span>
                </>
              )}
            </div>
            <p className={isCorrect ? 'text-emerald-700' : 'text-red-700'}>
              The correct answer is <strong>CHF {problem.correctAnswer.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}</strong>
            </p>
          </div>
        )}
      </div>
      
      {/* Navigation */}
      {showResult && (
        <div className="flex justify-between items-center">
          <button
            onClick={handleReset}
            className="flex items-center gap-2 text-slate-600 hover:text-slate-800"
          >
            <RefreshCw className="w-4 h-4" />
            Start Over
          </button>
          
          {isLastProblem ? (
            <div className="text-right">
              <p className="text-sm text-slate-600 mb-2">
                Final Score: {correctCount}/{problems.length}
                {passedThreshold ? " - Passed!" : " - Try again to improve"}
              </p>
              {passedThreshold ? (
                <button
                  onClick={onComplete}
                  className="px-6 py-3 bg-emerald-600 text-white font-medium rounded-lg hover:bg-emerald-700"
                >
                  Complete Exercise
                </button>
              ) : (
                <button
                  onClick={handleReset}
                  className="px-6 py-3 bg-indigo-600 text-white font-medium rounded-lg hover:bg-indigo-700"
                >
                  Try Again
                </button>
              )}
            </div>
          ) : (
            <button
              onClick={handleNext}
              className="flex items-center gap-2 px-6 py-3 bg-indigo-600 text-white font-medium rounded-lg hover:bg-indigo-700"
            >
              Next Problem
              <ArrowRight className="w-4 h-4" />
            </button>
          )}
        </div>
      )}
    </div>
  );
}

function getDefaultInterestProblems(): InterestProblem[] {
  return [
    {
      principal: 5000,
      rate: 6,
      time: 3,
      compounding: 'simple',
      question: "What is the total interest earned?",
      correctAnswer: 900,
      tolerance: 0.01
    },
    {
      principal: 10000,
      rate: 5,
      time: 2,
      compounding: 'annually',
      question: "What is the final amount?",
      correctAnswer: 11025,
      tolerance: 0.01
    },
    {
      principal: 8000,
      rate: 4,
      time: 5,
      compounding: 'quarterly',
      question: "What is the final amount?",
      correctAnswer: 9751.71,
      tolerance: 0.01
    }
  ];
}

// ============================================
// Percentage Calculator Interactive
// For Markup and Margin skill (RP-05)
// ============================================

interface PercentageCalculatorProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface PercentageProblem {
  type: 'markup' | 'margin' | 'find_cost' | 'find_price';
  cost?: number;
  sellingPrice?: number;
  percentage?: number;
  question: string;
  correctAnswer: number;
  tolerance?: number;
}

export function PercentageCalculator({ content, onComplete, completed }: PercentageCalculatorProps) {
  const problems = (content?.problems as PercentageProblem[]) || getDefaultPercentageProblems();
  const instructions = (content?.instructions as string) || "Calculate the markup, margin, or price for each business scenario.";
  
  const [currentProblem, setCurrentProblem] = useState(0);
  const [userAnswer, setUserAnswer] = useState("");
  const [showResult, setShowResult] = useState(false);
  const [isCorrect, setIsCorrect] = useState(false);
  const [correctCount, setCorrectCount] = useState(0);
  
  const problem = problems[currentProblem];
  const tolerance = problem?.tolerance || 0.01;
  
  const handleSubmit = () => {
    const answer = parseFloat(userAnswer.replace(/,/g, '').replace('%', ''));
    const correct = Math.abs(answer - problem.correctAnswer) <= Math.abs(problem.correctAnswer * tolerance);
    setIsCorrect(correct);
    setShowResult(true);
    if (correct) {
      setCorrectCount(prev => prev + 1);
    }
  };
  
  const handleNext = () => {
    if (currentProblem < problems.length - 1) {
      setCurrentProblem(prev => prev + 1);
      setUserAnswer("");
      setShowResult(false);
    } else if (correctCount >= Math.ceil(problems.length * 0.7)) {
      onComplete();
    }
  };
  
  const handleReset = () => {
    setCurrentProblem(0);
    setUserAnswer("");
    setShowResult(false);
    setCorrectCount(0);
  };
  
  if (!problem) return null;
  
  const isLastProblem = currentProblem === problems.length - 1;
  const passedThreshold = correctCount >= Math.ceil(problems.length * 0.7);
  
  const isPercentageAnswer = problem.type === 'markup' || problem.type === 'margin';
  
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-start gap-3 p-4 bg-emerald-50 rounded-xl">
        <DollarSign className="w-6 h-6 text-emerald-600 mt-0.5 flex-shrink-0" />
        <div>
          <p className="text-slate-700">{instructions}</p>
          <p className="text-sm text-slate-500 mt-1">
            Problem {currentProblem + 1} of {problems.length} | 
            Score: {correctCount}/{currentProblem + (showResult ? 1 : 0)}
          </p>
        </div>
      </div>
      
      {/* Problem Display */}
      <div className="bg-white border border-slate-200 rounded-xl p-6 space-y-4">
        <div className="grid grid-cols-2 gap-4">
          {problem.cost !== undefined && (
            <div className="p-3 bg-slate-50 rounded-lg">
              <p className="text-sm text-slate-500">Cost</p>
              <p className="text-xl font-bold text-slate-800">CHF {problem.cost.toLocaleString()}</p>
            </div>
          )}
          {problem.sellingPrice !== undefined && (
            <div className="p-3 bg-slate-50 rounded-lg">
              <p className="text-sm text-slate-500">Selling Price</p>
              <p className="text-xl font-bold text-slate-800">CHF {problem.sellingPrice.toLocaleString()}</p>
            </div>
          )}
          {problem.percentage !== undefined && (
            <div className="p-3 bg-slate-50 rounded-lg">
              <p className="text-sm text-slate-500">{problem.type === 'find_cost' ? 'Margin' : 'Markup'}</p>
              <p className="text-xl font-bold text-slate-800">{problem.percentage}%</p>
            </div>
          )}
        </div>
        
        <div className="pt-4 border-t border-slate-200">
          <p className="font-medium text-slate-800">{problem.question}</p>
        </div>
        
        {/* Reminder */}
        <div className="p-3 bg-blue-50 border border-blue-200 rounded-lg text-sm text-blue-800">
          <p><strong>Remember:</strong></p>
          <p>Markup = (Price - Cost) / Cost</p>
          <p>Margin = (Price - Cost) / Price</p>
        </div>
      </div>
      
      {/* Answer Input */}
      <div className="space-y-3">
        <div className="flex gap-3">
          <div className="relative flex-1">
            <span className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">
              {isPercentageAnswer ? '%' : 'CHF'}
            </span>
            <input
              type="text"
              value={userAnswer}
              onChange={(e) => setUserAnswer(e.target.value)}
              disabled={showResult}
              placeholder="Enter your answer"
              className="w-full pl-12 pr-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 disabled:bg-slate-100"
            />
          </div>
          {!showResult && (
            <button
              onClick={handleSubmit}
              disabled={!userAnswer}
              className="px-6 py-3 bg-emerald-600 text-white font-medium rounded-lg hover:bg-emerald-700 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Check
            </button>
          )}
        </div>
        
        {/* Result */}
        {showResult && (
          <div className={`p-4 rounded-lg ${isCorrect ? 'bg-emerald-50 border border-emerald-200' : 'bg-red-50 border border-red-200'}`}>
            <div className="flex items-center gap-2 mb-2">
              {isCorrect ? (
                <>
                  <CheckCircle2 className="w-5 h-5 text-emerald-600" />
                  <span className="font-medium text-emerald-700">Correct!</span>
                </>
              ) : (
                <>
                  <X className="w-5 h-5 text-red-600" />
                  <span className="font-medium text-red-700">Not quite right</span>
                </>
              )}
            </div>
            <p className={isCorrect ? 'text-emerald-700' : 'text-red-700'}>
              The correct answer is <strong>
                {isPercentageAnswer 
                  ? `${problem.correctAnswer.toFixed(1)}%`
                  : `CHF ${problem.correctAnswer.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2})}`
                }
              </strong>
            </p>
          </div>
        )}
      </div>
      
      {/* Navigation */}
      {showResult && (
        <div className="flex justify-between items-center">
          <button
            onClick={handleReset}
            className="flex items-center gap-2 text-slate-600 hover:text-slate-800"
          >
            <RefreshCw className="w-4 h-4" />
            Start Over
          </button>
          
          {isLastProblem ? (
            <div className="text-right">
              <p className="text-sm text-slate-600 mb-2">
                Final Score: {correctCount}/{problems.length}
              </p>
              {passedThreshold && !completed && (
                <button
                  onClick={onComplete}
                  className="px-6 py-3 bg-emerald-600 text-white font-medium rounded-lg hover:bg-emerald-700"
                >
                  Complete Exercise
                </button>
              )}
            </div>
          ) : (
            <button
              onClick={handleNext}
              className="flex items-center gap-2 px-6 py-3 bg-emerald-600 text-white font-medium rounded-lg hover:bg-emerald-700"
            >
              Next Problem
              <ArrowRight className="w-4 h-4" />
            </button>
          )}
        </div>
      )}
    </div>
  );
}

function getDefaultPercentageProblems(): PercentageProblem[] {
  return [
    {
      type: 'markup',
      cost: 80,
      sellingPrice: 100,
      question: "What is the markup percentage?",
      correctAnswer: 25,
      tolerance: 0.01
    },
    {
      type: 'margin',
      cost: 80,
      sellingPrice: 100,
      question: "What is the margin percentage?",
      correctAnswer: 20,
      tolerance: 0.01
    },
    {
      type: 'find_price',
      cost: 60,
      percentage: 25,
      question: "What selling price gives a 25% margin?",
      correctAnswer: 80,
      tolerance: 0.01
    }
  ];
}

// ============================================
// Equation Solver Step-by-Step Interactive
// For Linear Equations skill (EQ-01)
// ============================================

interface EquationSolverProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface EquationStep {
  instruction: string;
  correctOperation: string;
  resultingEquation: string;
}

interface EquationProblem {
  equation: string;
  variable: string;
  steps: EquationStep[];
  finalAnswer: number;
}

export function EquationSolver({ content, onComplete, completed }: EquationSolverProps) {
  const problems = (content?.problems as EquationProblem[]) || getDefaultEquationProblems();
  const instructions = (content?.instructions as string) || "Solve each equation step by step.";
  
  const [currentProblem, setCurrentProblem] = useState(0);
  const [currentStep, setCurrentStep] = useState(0);
  const [userAnswer, setUserAnswer] = useState("");
  const [showResult, setShowResult] = useState(false);
  const [isCorrect, setIsCorrect] = useState(false);
  const [correctCount, setCorrectCount] = useState(0);
  // Initialize with first problem's equation
  const [showEquations, setShowEquations] = useState<string[]>(() => 
    problems[0] ? [problems[0].equation] : []
  );
  const [lastProblemIndex, setLastProblemIndex] = useState(0);
  
  const problem = problems[currentProblem];
  
  // Reset showEquations when switching problems
  if (currentProblem !== lastProblemIndex && problem) {
    setLastProblemIndex(currentProblem);
    setShowEquations([problem.equation]);
  }
  
  const handleSubmit = () => {
    if (currentStep < problem.steps.length) {
      // Check step answer
      const step = problem.steps[currentStep];
      const userLower = userAnswer.toLowerCase().trim();
      const correctLower = step.correctOperation.toLowerCase().trim();
      const correct = userLower === correctLower || 
                     userLower.includes(correctLower) || 
                     correctLower.includes(userLower);
      
      setIsCorrect(correct);
      setShowResult(true);
      
      if (correct) {
        setShowEquations(prev => [...prev, step.resultingEquation]);
      }
    } else {
      // Check final answer
      const answer = parseFloat(userAnswer);
      const correct = Math.abs(answer - problem.finalAnswer) < 0.01;
      setIsCorrect(correct);
      setShowResult(true);
      if (correct) {
        setCorrectCount(prev => prev + 1);
      }
    }
  };
  
  const handleNextStep = () => {
    if (currentStep < problem.steps.length) {
      setCurrentStep(prev => prev + 1);
      setUserAnswer("");
      setShowResult(false);
    } else if (currentProblem < problems.length - 1) {
      setCurrentProblem(prev => prev + 1);
      setCurrentStep(0);
      setUserAnswer("");
      setShowResult(false);
      setShowEquations([]);
    } else if (correctCount >= Math.ceil(problems.length * 0.7)) {
      onComplete();
    }
  };
  
  if (!problem) return null;
  
  const isFinalStep = currentStep >= problem.steps.length;
  const step = !isFinalStep ? problem.steps[currentStep] : null;
  
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-start gap-3 p-4 bg-violet-50 rounded-xl">
        <Target className="w-6 h-6 text-violet-600 mt-0.5 flex-shrink-0" />
        <div>
          <p className="text-slate-700">{instructions}</p>
          <p className="text-sm text-slate-500 mt-1">
            Problem {currentProblem + 1} of {problems.length}
          </p>
        </div>
      </div>
      
      {/* Equation Display */}
      <div className="bg-white border border-slate-200 rounded-xl p-6">
        <h3 className="font-medium text-slate-800 mb-4">Solve for {problem.variable}:</h3>
        <div className="space-y-2">
          {showEquations.map((eq, idx) => (
            <div 
              key={idx} 
              className={`p-3 rounded-lg font-mono text-lg ${
                idx === showEquations.length - 1 
                  ? 'bg-violet-100 border-2 border-violet-300' 
                  : 'bg-slate-50'
              }`}
            >
              {eq}
            </div>
          ))}
        </div>
      </div>
      
      {/* Current Step */}
      <div className="bg-slate-50 border border-slate-200 rounded-xl p-6">
        {isFinalStep ? (
          <div>
            <p className="font-medium text-slate-800 mb-3">
              What is the final value of {problem.variable}?
            </p>
          </div>
        ) : (
          <div>
            <p className="font-medium text-slate-800 mb-3">
              Step {currentStep + 1}: {step?.instruction}
            </p>
            <p className="text-sm text-slate-600">
              What operation should you perform?
            </p>
          </div>
        )}
        
        <div className="mt-4 flex gap-3">
          <input
            type="text"
            value={userAnswer}
            onChange={(e) => setUserAnswer(e.target.value)}
            disabled={showResult}
            placeholder={isFinalStep ? `${problem.variable} = ?` : "Enter the operation"}
            className="flex-1 px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-violet-500 focus:border-violet-500 disabled:bg-slate-100"
          />
          {!showResult && (
            <button
              onClick={handleSubmit}
              disabled={!userAnswer}
              className="px-6 py-3 bg-violet-600 text-white font-medium rounded-lg hover:bg-violet-700 disabled:opacity-50"
            >
              Check
            </button>
          )}
        </div>
        
        {showResult && (
          <div className={`mt-4 p-4 rounded-lg ${isCorrect ? 'bg-emerald-50 border border-emerald-200' : 'bg-red-50 border border-red-200'}`}>
            <div className="flex items-center gap-2">
              {isCorrect ? (
                <>
                  <CheckCircle2 className="w-5 h-5 text-emerald-600" />
                  <span className="font-medium text-emerald-700">Correct!</span>
                </>
              ) : (
                <>
                  <X className="w-5 h-5 text-red-600" />
                  <span className="font-medium text-red-700">
                    The answer is: {isFinalStep ? problem.finalAnswer : step?.correctOperation}
                  </span>
                </>
              )}
            </div>
          </div>
        )}
        
        {showResult && (
          <button
            onClick={handleNextStep}
            className="mt-4 flex items-center gap-2 px-6 py-3 bg-violet-600 text-white font-medium rounded-lg hover:bg-violet-700"
          >
            {isFinalStep && currentProblem === problems.length - 1 
              ? (correctCount >= Math.ceil(problems.length * 0.7) ? "Complete Exercise" : "Review")
              : "Continue"
            }
            <ArrowRight className="w-4 h-4" />
          </button>
        )}
      </div>
    </div>
  );
}

function getDefaultEquationProblems(): EquationProblem[] {
  return [
    {
      equation: "2x + 5 = 11",
      variable: "x",
      steps: [
        {
          instruction: "Isolate the term with x",
          correctOperation: "subtract 5",
          resultingEquation: "2x = 6"
        },
        {
          instruction: "Solve for x",
          correctOperation: "divide by 2",
          resultingEquation: "x = 3"
        }
      ],
      finalAnswer: 3
    }
  ];
}

// ============================================
// Graph Interpretation Interactive
// For Graph Interpretation skill (FG-06)
// ============================================

interface GraphInterpretationProps {
  content: Record<string, unknown> | null;
  onComplete: () => void;
  completed: boolean;
}

interface GraphPoint {
  x: number;
  y: number;
  label?: string;
}

interface GraphQuestion {
  graphData: {
    points: GraphPoint[];
    xLabel: string;
    yLabel: string;
    title: string;
  };
  question: string;
  options: string[];
  correctIndex: number;
  explanation: string;
}

export function GraphInterpretation({ content, onComplete, completed }: GraphInterpretationProps) {
  const questions = (content?.questions as GraphQuestion[]) || getDefaultGraphQuestions();
  const instructions = (content?.instructions as string) || "Analyze the graph and answer the questions.";
  
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [showResult, setShowResult] = useState(false);
  const [correctCount, setCorrectCount] = useState(0);
  
  const question = questions[currentQuestion];
  
  const handleSubmit = () => {
    if (selectedOption === question.correctIndex) {
      setCorrectCount(prev => prev + 1);
    }
    setShowResult(true);
  };
  
  const handleNext = () => {
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion(prev => prev + 1);
      setSelectedOption(null);
      setShowResult(false);
    } else if (correctCount >= Math.ceil(questions.length * 0.7)) {
      onComplete();
    }
  };
  
  if (!question) return null;
  
  const { graphData } = question;
  
  // Simple SVG graph rendering
  const width = 400;
  const height = 250;
  const padding = 40;
  const xMax = Math.max(...graphData.points.map(p => p.x));
  const yMax = Math.max(...graphData.points.map(p => p.y));
  
  const scaleX = (x: number) => padding + (x / xMax) * (width - 2 * padding);
  const scaleY = (y: number) => height - padding - (y / yMax) * (height - 2 * padding);
  
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-start gap-3 p-4 bg-blue-50 rounded-xl">
        <TrendingUp className="w-6 h-6 text-blue-600 mt-0.5 flex-shrink-0" />
        <div>
          <p className="text-slate-700">{instructions}</p>
          <p className="text-sm text-slate-500 mt-1">
            Question {currentQuestion + 1} of {questions.length}
          </p>
        </div>
      </div>
      
      {/* Graph */}
      <div className="bg-white border border-slate-200 rounded-xl p-6">
        <h3 className="font-medium text-slate-800 mb-4 text-center">{graphData.title}</h3>
        <div className="flex justify-center">
          <svg width={width} height={height} className="bg-slate-50 rounded-lg">
            {/* Axes */}
            <line x1={padding} y1={height - padding} x2={width - padding} y2={height - padding} stroke="#94a3b8" strokeWidth="2" />
            <line x1={padding} y1={padding} x2={padding} y2={height - padding} stroke="#94a3b8" strokeWidth="2" />
            
            {/* Line connecting points */}
            <polyline
              fill="none"
              stroke="#3b82f6"
              strokeWidth="3"
              points={graphData.points.map(p => `${scaleX(p.x)},${scaleY(p.y)}`).join(' ')}
            />
            
            {/* Points */}
            {graphData.points.map((point, idx) => (
              <g key={idx}>
                <circle
                  cx={scaleX(point.x)}
                  cy={scaleY(point.y)}
                  r="6"
                  fill="#3b82f6"
                />
                {point.label && (
                  <text
                    x={scaleX(point.x)}
                    y={scaleY(point.y) - 10}
                    textAnchor="middle"
                    className="text-xs fill-slate-600"
                  >
                    {point.label}
                  </text>
                )}
              </g>
            ))}
            
            {/* Axis labels */}
            <text x={width / 2} y={height - 5} textAnchor="middle" className="text-sm fill-slate-600">
              {graphData.xLabel}
            </text>
            <text x={15} y={height / 2} textAnchor="middle" className="text-sm fill-slate-600" transform={`rotate(-90, 15, ${height / 2})`}>
              {graphData.yLabel}
            </text>
          </svg>
        </div>
      </div>
      
      {/* Question */}
      <div className="bg-slate-50 border border-slate-200 rounded-xl p-6 space-y-4">
        <p className="font-medium text-slate-800">{question.question}</p>
        
        <div className="space-y-2">
          {question.options.map((option, idx) => (
            <button
              key={idx}
              onClick={() => !showResult && setSelectedOption(idx)}
              disabled={showResult}
              className={`w-full text-left p-4 rounded-lg border-2 transition-colors ${
                showResult
                  ? idx === question.correctIndex
                    ? 'border-emerald-500 bg-emerald-50'
                    : idx === selectedOption
                      ? 'border-red-500 bg-red-50'
                      : 'border-slate-200 bg-white'
                  : selectedOption === idx
                    ? 'border-blue-500 bg-blue-50'
                    : 'border-slate-200 bg-white hover:border-slate-300'
              }`}
            >
              {option}
            </button>
          ))}
        </div>
        
        {showResult && (
          <div className={`p-4 rounded-lg ${selectedOption === question.correctIndex ? 'bg-emerald-50 border border-emerald-200' : 'bg-amber-50 border border-amber-200'}`}>
            <p className={selectedOption === question.correctIndex ? 'text-emerald-700' : 'text-amber-700'}>
              {question.explanation}
            </p>
          </div>
        )}
        
        <div className="flex justify-end gap-3">
          {!showResult ? (
            <button
              onClick={handleSubmit}
              disabled={selectedOption === null}
              className="px-6 py-3 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 disabled:opacity-50"
            >
              Check Answer
            </button>
          ) : (
            <button
              onClick={handleNext}
              className="flex items-center gap-2 px-6 py-3 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700"
            >
              {currentQuestion === questions.length - 1 ? "Complete" : "Next"}
              <ArrowRight className="w-4 h-4" />
            </button>
          )}
        </div>
      </div>
    </div>
  );
}

function getDefaultGraphQuestions(): GraphQuestion[] {
  return [
    {
      graphData: {
        points: [
          { x: 0, y: 100 },
          { x: 1, y: 150 },
          { x: 2, y: 200 },
          { x: 3, y: 280 },
          { x: 4, y: 350 }
        ],
        xLabel: "Years",
        yLabel: "Revenue (CHF 000)",
        title: "Company Revenue Growth"
      },
      question: "What is the trend shown in this graph?",
      options: [
        "Revenue is increasing each year",
        "Revenue is decreasing each year",
        "Revenue stays constant",
        "Revenue fluctuates randomly"
      ],
      correctIndex: 0,
      explanation: "The graph shows a clear upward trend - revenue increases from CHF 100,000 to CHF 350,000 over 4 years."
    }
  ];
}

