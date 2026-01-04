"use client";

import { ReactNode, useState } from "react";
import { 
  Lightbulb, 
  Code2, 
  AlertTriangle, 
  BookOpen,
  CheckCircle2,
  ChevronDown,
  ChevronUp,
  Sparkles,
  Zap,
  Brain,
  Target,
  HelpCircle,
  FileCode
} from "lucide-react";

// Content block types for enhanced lesson rendering
type BlockType = 
  | "concept" 
  | "example" 
  | "tip" 
  | "warning" 
  | "definition" 
  | "practice"
  | "remember"
  | "code"
  | "quiz";

interface ContentBlockProps {
  type: BlockType;
  title?: string;
  children: ReactNode;
  collapsible?: boolean;
  defaultExpanded?: boolean;
}

const blockConfig: Record<BlockType, { 
  icon: React.ComponentType<{ className?: string }>;
  bgGradient: string;
  borderColor: string;
  iconBg: string;
  iconColor: string;
  titleColor: string;
  defaultTitle: string;
}> = {
  concept: {
    icon: Brain,
    bgGradient: "from-violet-50 to-purple-50",
    borderColor: "border-violet-200",
    iconBg: "bg-violet-100",
    iconColor: "text-violet-600",
    titleColor: "text-violet-900",
    defaultTitle: "Key Concept",
  },
  example: {
    icon: FileCode,
    bgGradient: "from-blue-50 to-indigo-50",
    borderColor: "border-blue-200",
    iconBg: "bg-blue-100",
    iconColor: "text-blue-600",
    titleColor: "text-blue-900",
    defaultTitle: "Example",
  },
  tip: {
    icon: Lightbulb,
    bgGradient: "from-amber-50 to-yellow-50",
    borderColor: "border-amber-200",
    iconBg: "bg-amber-100",
    iconColor: "text-amber-600",
    titleColor: "text-amber-900",
    defaultTitle: "Pro Tip",
  },
  warning: {
    icon: AlertTriangle,
    bgGradient: "from-red-50 to-orange-50",
    borderColor: "border-red-200",
    iconBg: "bg-red-100",
    iconColor: "text-red-600",
    titleColor: "text-red-900",
    defaultTitle: "Watch Out",
  },
  definition: {
    icon: BookOpen,
    bgGradient: "from-emerald-50 to-teal-50",
    borderColor: "border-emerald-200",
    iconBg: "bg-emerald-100",
    iconColor: "text-emerald-600",
    titleColor: "text-emerald-900",
    defaultTitle: "Definition",
  },
  practice: {
    icon: Target,
    bgGradient: "from-rose-50 to-pink-50",
    borderColor: "border-rose-200",
    iconBg: "bg-rose-100",
    iconColor: "text-rose-600",
    titleColor: "text-rose-900",
    defaultTitle: "Practice This",
  },
  remember: {
    icon: Sparkles,
    bgGradient: "from-cyan-50 to-sky-50",
    borderColor: "border-cyan-200",
    iconBg: "bg-cyan-100",
    iconColor: "text-cyan-600",
    titleColor: "text-cyan-900",
    defaultTitle: "Remember",
  },
  code: {
    icon: Code2,
    bgGradient: "from-slate-800 to-slate-900",
    borderColor: "border-slate-700",
    iconBg: "bg-slate-700",
    iconColor: "text-emerald-400",
    titleColor: "text-slate-100",
    defaultTitle: "Code",
  },
  quiz: {
    icon: HelpCircle,
    bgGradient: "from-indigo-50 to-violet-50",
    borderColor: "border-indigo-200",
    iconBg: "bg-indigo-100",
    iconColor: "text-indigo-600",
    titleColor: "text-indigo-900",
    defaultTitle: "Quick Check",
  },
};

export function ContentBlock({ 
  type, 
  title, 
  children, 
  collapsible = false,
  defaultExpanded = true 
}: ContentBlockProps) {
  const [isExpanded, setIsExpanded] = useState(defaultExpanded);
  const config = blockConfig[type];
  const Icon = config.icon;
  const displayTitle = title || config.defaultTitle;
  const isCodeBlock = type === "code";

  return (
    <div 
      className={`
        rounded-xl border ${config.borderColor} overflow-hidden my-6
        ${isCodeBlock ? 'bg-slate-900' : `bg-gradient-to-br ${config.bgGradient}`}
      `}
    >
      {/* Header */}
      <div 
        className={`
          flex items-center gap-3 px-4 py-3
          ${collapsible ? 'cursor-pointer hover:opacity-90 transition-opacity' : ''}
          ${isCodeBlock ? 'border-b border-slate-700' : 'border-b border-inherit/50'}
        `}
        onClick={collapsible ? () => setIsExpanded(!isExpanded) : undefined}
      >
        <div className={`w-8 h-8 rounded-lg ${config.iconBg} flex items-center justify-center flex-shrink-0`}>
          <Icon className={`w-4 h-4 ${config.iconColor}`} />
        </div>
        <span 
          className={`font-semibold ${config.titleColor}`}
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          {displayTitle}
        </span>
        {collapsible && (
          <div className="ml-auto">
            {isExpanded ? (
              <ChevronUp className={`w-5 h-5 ${isCodeBlock ? 'text-slate-400' : 'text-slate-500'}`} />
            ) : (
              <ChevronDown className={`w-5 h-5 ${isCodeBlock ? 'text-slate-400' : 'text-slate-500'}`} />
            )}
          </div>
        )}
      </div>

      {/* Content */}
      {(!collapsible || isExpanded) && (
        <div className={`px-4 py-4 ${isCodeBlock ? 'text-slate-100' : 'text-slate-700'}`}>
          {children}
        </div>
      )}
    </div>
  );
}

// Inline quick check component for embedded mini-quizzes
interface QuickCheckProps {
  question: string;
  options: string[];
  correctIndex: number;
  explanation: string;
}

export function QuickCheck({ question, options, correctIndex, explanation }: QuickCheckProps) {
  const [selectedIndex, setSelectedIndex] = useState<number | null>(null);
  const [showExplanation, setShowExplanation] = useState(false);

  const handleSelect = (index: number) => {
    if (selectedIndex !== null) return; // Already answered
    setSelectedIndex(index);
    setShowExplanation(true);
  };

  const isCorrect = selectedIndex === correctIndex;

  return (
    <div className="my-6 rounded-xl border border-indigo-200 bg-gradient-to-br from-indigo-50 to-violet-50 overflow-hidden">
      <div className="flex items-center gap-3 px-4 py-3 border-b border-indigo-200/50">
        <div className="w-8 h-8 rounded-lg bg-indigo-100 flex items-center justify-center">
          <HelpCircle className="w-4 h-4 text-indigo-600" />
        </div>
        <span 
          className="font-semibold text-indigo-900"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Quick Check
        </span>
      </div>

      <div className="p-4">
        <p className="font-medium text-slate-900 mb-4">{question}</p>

        <div className="space-y-2">
          {options.map((option, index) => {
            const isSelected = selectedIndex === index;
            const isCorrectOption = index === correctIndex;
            
            let optionClass = "border-slate-200 bg-white hover:border-indigo-300 hover:bg-indigo-50";
            if (selectedIndex !== null) {
              if (isCorrectOption) {
                optionClass = "border-emerald-300 bg-emerald-50";
              } else if (isSelected && !isCorrectOption) {
                optionClass = "border-red-300 bg-red-50";
              } else {
                optionClass = "border-slate-200 bg-white opacity-60";
              }
            }

            return (
              <button
                key={index}
                onClick={() => handleSelect(index)}
                disabled={selectedIndex !== null}
                className={`
                  w-full text-left px-4 py-3 rounded-lg border transition-all
                  ${optionClass}
                  ${selectedIndex === null ? 'cursor-pointer' : 'cursor-default'}
                `}
              >
                <div className="flex items-center gap-3">
                  <div className={`
                    w-6 h-6 rounded-full border-2 flex items-center justify-center flex-shrink-0
                    ${selectedIndex !== null && isCorrectOption ? 'border-emerald-500 bg-emerald-500' : ''}
                    ${selectedIndex !== null && isSelected && !isCorrectOption ? 'border-red-500 bg-red-500' : ''}
                    ${selectedIndex === null || (!isSelected && !isCorrectOption) ? 'border-slate-300' : ''}
                  `}>
                    {selectedIndex !== null && isCorrectOption && (
                      <CheckCircle2 className="w-4 h-4 text-white" />
                    )}
                    {selectedIndex !== null && isSelected && !isCorrectOption && (
                      <span className="text-white text-xs font-bold">X</span>
                    )}
                  </div>
                  <span className={`
                    ${selectedIndex !== null && isCorrectOption ? 'text-emerald-900 font-medium' : ''}
                    ${selectedIndex !== null && isSelected && !isCorrectOption ? 'text-red-900' : ''}
                    ${selectedIndex === null ? 'text-slate-700' : ''}
                  `}>
                    {option}
                  </span>
                </div>
              </button>
            );
          })}
        </div>

        {/* Explanation */}
        {showExplanation && (
          <div className={`
            mt-4 p-4 rounded-lg 
            ${isCorrect ? 'bg-emerald-100 border border-emerald-200' : 'bg-amber-100 border border-amber-200'}
          `}>
            <div className="flex items-start gap-2">
              {isCorrect ? (
                <Zap className="w-5 h-5 text-emerald-600 flex-shrink-0 mt-0.5" />
              ) : (
                <Lightbulb className="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" />
              )}
              <div>
                <p className={`font-medium ${isCorrect ? 'text-emerald-800' : 'text-amber-800'}`}>
                  {isCorrect ? "Correct!" : "Not quite..."}
                </p>
                <p className={`text-sm mt-1 ${isCorrect ? 'text-emerald-700' : 'text-amber-700'}`}>
                  {explanation}
                </p>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

// Progress indicator for multi-part lessons
interface LessonProgressProps {
  currentPart: number;
  totalParts: number;
  partTitles?: string[];
}

export function LessonProgress({ currentPart, totalParts, partTitles }: LessonProgressProps) {
  return (
    <div className="mb-8">
      <div className="flex items-center justify-between mb-2">
        <span className="text-sm font-medium text-slate-600">
          Part {currentPart} of {totalParts}
        </span>
        <span className="text-sm text-slate-500">
          {Math.round((currentPart / totalParts) * 100)}% complete
        </span>
      </div>
      <div className="h-2 bg-slate-200 rounded-full overflow-hidden">
        <div 
          className="h-full bg-gradient-to-r from-violet-500 to-purple-500 transition-all duration-500"
          style={{ width: `${(currentPart / totalParts) * 100}%` }}
        />
      </div>
      {partTitles && partTitles[currentPart - 1] && (
        <p className="mt-2 text-sm text-slate-600">
          <span className="font-medium">Current:</span> {partTitles[currentPart - 1]}
        </p>
      )}
    </div>
  );
}

// Helper function to parse inline markdown (bold, italic, code)
function parseInlineMarkdown(text: string): ReactNode[] {
  const parts: ReactNode[] = [];
  let remaining = text;
  let key = 0;
  
  // Pattern to match **bold**, *italic*, and `code`
  const pattern = /(\*\*(.+?)\*\*)|(\*(.+?)\*)|(`(.+?)`)/g;
  let lastIndex = 0;
  let match;
  
  while ((match = pattern.exec(text)) !== null) {
    // Add text before the match
    if (match.index > lastIndex) {
      parts.push(text.slice(lastIndex, match.index));
    }
    
    if (match[1]) {
      // Bold text **...**
      parts.push(<strong key={key++} className="font-semibold text-slate-900">{match[2]}</strong>);
    } else if (match[3]) {
      // Italic text *...*
      parts.push(<em key={key++} className="italic">{match[4]}</em>);
    } else if (match[5]) {
      // Code text `...`
      parts.push(<code key={key++} className="px-1.5 py-0.5 bg-slate-100 text-slate-800 rounded text-sm font-mono">{match[6]}</code>);
    }
    
    lastIndex = pattern.lastIndex;
  }
  
  // Add remaining text
  if (lastIndex < text.length) {
    parts.push(text.slice(lastIndex));
  }
  
  return parts.length > 0 ? parts : [text];
}

// Key takeaways summary component
interface KeyTakeawaysProps {
  takeaways: string[];
}

export function KeyTakeaways({ takeaways }: KeyTakeawaysProps) {
  return (
    <div className="my-8 rounded-xl border border-emerald-200 bg-gradient-to-br from-emerald-50 to-teal-50 overflow-hidden">
      <div className="flex items-center gap-3 px-4 py-3 border-b border-emerald-200/50">
        <div className="w-8 h-8 rounded-lg bg-emerald-100 flex items-center justify-center">
          <Sparkles className="w-4 h-4 text-emerald-600" />
        </div>
        <span 
          className="font-semibold text-emerald-900"
          style={{ fontFamily: 'var(--font-heading)' }}
        >
          Key Takeaways
        </span>
      </div>
      <div className="p-4">
        <ul className="space-y-3">
          {takeaways.map((takeaway, index) => (
            <li key={index} className="flex items-start gap-3">
              <div className="w-6 h-6 rounded-full bg-emerald-200 flex items-center justify-center flex-shrink-0 mt-0.5">
                <CheckCircle2 className="w-4 h-4 text-emerald-700" />
              </div>
              <span className="text-slate-700">{parseInlineMarkdown(takeaway)}</span>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

// Export block types for external use
export type { BlockType, ContentBlockProps, QuickCheckProps };

