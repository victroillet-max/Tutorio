"use client";

import { useState, useEffect } from "react";
import { 
  Plus, 
  Trash2, 
  GripVertical,
  Settings,
  AlertCircle
} from "lucide-react";

interface InteractiveEditorProps {
  content: Record<string, unknown> | null;
  interactiveType: string | null;
  onChange: (content: Record<string, unknown>) => void;
}

export function InteractiveEditor({ content, interactiveType, onChange }: InteractiveEditorProps) {
  const [editedContent, setEditedContent] = useState<Record<string, unknown>>(content || {});
  const [jsonMode, setJsonMode] = useState(false);
  const [jsonError, setJsonError] = useState<string | null>(null);
  const [rawJson, setRawJson] = useState(JSON.stringify(content, null, 2));

  useEffect(() => {
    setEditedContent(content || {});
    setRawJson(JSON.stringify(content, null, 2));
  }, [content]);

  const updateContent = (updates: Record<string, unknown>) => {
    const newContent = { ...editedContent, ...updates };
    setEditedContent(newContent);
    onChange(newContent);
  };

  const handleJsonChange = (value: string) => {
    setRawJson(value);
    try {
      const parsed = JSON.parse(value);
      setJsonError(null);
      setEditedContent(parsed);
      onChange(parsed);
    } catch {
      setJsonError("Invalid JSON");
    }
  };

  // Render specialized editor based on interactive type
  const renderTypeEditor = () => {
    switch (interactiveType) {
      case "drag-drop-match":
        return <DragDropMatchEditor content={editedContent} onChange={updateContent} />;
      case "flashcards":
        return <FlashcardsEditor content={editedContent} onChange={updateContent} />;
      case "fill-table":
        return <FillTableEditor content={editedContent} onChange={updateContent} />;
      case "sort-steps":
        return <SortStepsEditor content={editedContent} onChange={updateContent} />;
      case "formula-builder":
        return <FormulaBuilderEditor content={editedContent} onChange={updateContent} />;
      default:
        return (
          <div className="p-6 text-center text-[var(--foreground-muted)]">
            <Settings className="w-12 h-12 text-slate-300 mx-auto mb-4" />
            <p className="font-medium">Interactive Type: {interactiveType || "Unknown"}</p>
            <p className="text-sm mt-2">
              Use JSON mode to edit this interactive content.
            </p>
          </div>
        );
    }
  };

  return (
    <div className="flex flex-col h-full">
      {/* Header */}
      <div className="p-4 border-b border-[var(--border)] bg-slate-50 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <span className="px-2 py-1 text-xs font-medium rounded-full bg-purple-100 text-purple-700">
            {interactiveType || "interactive"}
          </span>
        </div>
        <div className="flex items-center gap-2">
          <button
            onClick={() => setJsonMode(!jsonMode)}
            className={`px-3 py-1.5 rounded-lg text-xs font-medium transition-colors ${
              jsonMode 
                ? "bg-slate-800 text-white" 
                : "bg-slate-200 text-slate-700 hover:bg-slate-300"
            }`}
          >
            {jsonMode ? "Visual Editor" : "JSON Mode"}
          </button>
        </div>
      </div>

      {/* Editor */}
      <div className="flex-1 overflow-y-auto">
        {jsonMode ? (
          <div className="p-4">
            {jsonError && (
              <div className="mb-4 p-3 rounded-lg bg-red-50 border border-red-100 flex items-center gap-2 text-sm text-red-700">
                <AlertCircle className="w-4 h-4" />
                {jsonError}
              </div>
            )}
            <textarea
              value={rawJson}
              onChange={(e) => handleJsonChange(e.target.value)}
              className="w-full h-[400px] p-4 font-mono text-sm rounded-lg border border-[var(--border)] focus:outline-none focus:ring-2 focus:ring-[var(--primary)] resize-none"
              placeholder="Enter JSON configuration..."
            />
          </div>
        ) : (
          renderTypeEditor()
        )}
      </div>
    </div>
  );
}

// ============================================
// Drag & Drop Match Editor
// ============================================

function DragDropMatchEditor({ 
  content, 
  onChange 
}: { 
  content: Record<string, unknown>; 
  onChange: (updates: Record<string, unknown>) => void;
}) {
  const pairs = (content.pairs || []) as Array<{ left: string; right: string }>;
  const instructions = (content.instructions || "") as string;

  const updatePairs = (newPairs: Array<{ left: string; right: string }>) => {
    onChange({ ...content, pairs: newPairs });
  };

  const addPair = () => {
    updatePairs([...pairs, { left: "", right: "" }]);
  };

  const updatePair = (index: number, field: "left" | "right", value: string) => {
    const newPairs = pairs.map((p, i) => 
      i === index ? { ...p, [field]: value } : p
    );
    updatePairs(newPairs);
  };

  const removePair = (index: number) => {
    updatePairs(pairs.filter((_, i) => i !== index));
  };

  return (
    <div className="p-4 space-y-4">
      <div>
        <label className="block text-xs text-[var(--foreground-muted)] mb-1">Instructions</label>
        <input
          type="text"
          value={instructions}
          onChange={(e) => onChange({ ...content, instructions: e.target.value })}
          className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
          placeholder="Match the items on the left with their corresponding items on the right..."
        />
      </div>

      <div>
        <div className="flex items-center justify-between mb-2">
          <label className="text-xs text-[var(--foreground-muted)]">Match Pairs ({pairs.length})</label>
          <button
            onClick={addPair}
            className="inline-flex items-center gap-1 text-xs text-[var(--primary)] hover:underline"
          >
            <Plus className="w-3 h-3" />
            Add Pair
          </button>
        </div>

        <div className="space-y-2">
          {pairs.map((pair, index) => (
            <div key={index} className="flex items-center gap-2">
              <GripVertical className="w-4 h-4 text-slate-300" />
              <input
                type="text"
                value={pair.left}
                onChange={(e) => updatePair(index, "left", e.target.value)}
                className="flex-1 px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
                placeholder="Left item"
              />
              <span className="text-slate-400">→</span>
              <input
                type="text"
                value={pair.right}
                onChange={(e) => updatePair(index, "right", e.target.value)}
                className="flex-1 px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
                placeholder="Right item"
              />
              <button
                onClick={() => removePair(index)}
                className="p-1 text-slate-400 hover:text-red-500"
              >
                <Trash2 className="w-4 h-4" />
              </button>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

// ============================================
// Flashcards Editor
// ============================================

function FlashcardsEditor({ 
  content, 
  onChange 
}: { 
  content: Record<string, unknown>; 
  onChange: (updates: Record<string, unknown>) => void;
}) {
  const cards = (content.cards || []) as Array<{ term: string; definition: string }>;
  const instructions = (content.instructions || "") as string;

  const updateCards = (newCards: Array<{ term: string; definition: string }>) => {
    onChange({ ...content, cards: newCards });
  };

  const addCard = () => {
    updateCards([...cards, { term: "", definition: "" }]);
  };

  const updateCard = (index: number, field: "term" | "definition", value: string) => {
    const newCards = cards.map((c, i) => 
      i === index ? { ...c, [field]: value } : c
    );
    updateCards(newCards);
  };

  const removeCard = (index: number) => {
    updateCards(cards.filter((_, i) => i !== index));
  };

  return (
    <div className="p-4 space-y-4">
      <div>
        <label className="block text-xs text-[var(--foreground-muted)] mb-1">Instructions</label>
        <input
          type="text"
          value={instructions}
          onChange={(e) => onChange({ ...content, instructions: e.target.value })}
          className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
          placeholder="Click cards to flip and reveal the definition..."
        />
      </div>

      <div>
        <div className="flex items-center justify-between mb-2">
          <label className="text-xs text-[var(--foreground-muted)]">Flashcards ({cards.length})</label>
          <button
            onClick={addCard}
            className="inline-flex items-center gap-1 text-xs text-[var(--primary)] hover:underline"
          >
            <Plus className="w-3 h-3" />
            Add Card
          </button>
        </div>

        <div className="grid gap-3">
          {cards.map((card, index) => (
            <div key={index} className="border border-[var(--border)] rounded-lg p-3 bg-white">
              <div className="flex items-start gap-2">
                <span className="w-6 h-6 rounded-full bg-slate-100 text-slate-600 text-xs flex items-center justify-center font-medium">
                  {index + 1}
                </span>
                <div className="flex-1 space-y-2">
                  <input
                    type="text"
                    value={card.term}
                    onChange={(e) => updateCard(index, "term", e.target.value)}
                    className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm font-medium focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
                    placeholder="Term"
                  />
                  <textarea
                    value={card.definition}
                    onChange={(e) => updateCard(index, "definition", e.target.value)}
                    rows={2}
                    className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)] resize-none"
                    placeholder="Definition"
                  />
                </div>
                <button
                  onClick={() => removeCard(index)}
                  className="p-1 text-slate-400 hover:text-red-500"
                >
                  <Trash2 className="w-4 h-4" />
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

// ============================================
// Fill Table Editor
// ============================================

function FillTableEditor({ 
  content, 
  onChange 
}: { 
  content: Record<string, unknown>; 
  onChange: (updates: Record<string, unknown>) => void;
}) {
  const headers = (content.headers || []) as string[];
  const rows = (content.rows || []) as Array<{ cells: Array<{ value: string; editable?: boolean }> }>;
  const instructions = (content.instructions || "") as string;

  return (
    <div className="p-4 space-y-4">
      <div>
        <label className="block text-xs text-[var(--foreground-muted)] mb-1">Instructions</label>
        <input
          type="text"
          value={instructions}
          onChange={(e) => onChange({ ...content, instructions: e.target.value })}
          className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
          placeholder="Fill in the missing values in the table..."
        />
      </div>

      <div className="border border-[var(--border)] rounded-lg overflow-hidden">
        <div className="p-4 bg-slate-50 text-sm text-[var(--foreground-muted)]">
          <p>Table with {headers.length} columns and {rows.length} rows</p>
          <p className="text-xs mt-1">Use JSON mode for detailed table configuration.</p>
        </div>
      </div>
    </div>
  );
}

// ============================================
// Sort Steps Editor
// ============================================

function SortStepsEditor({ 
  content, 
  onChange 
}: { 
  content: Record<string, unknown>; 
  onChange: (updates: Record<string, unknown>) => void;
}) {
  const steps = (content.steps || []) as string[];
  const instructions = (content.instructions || "") as string;

  const updateSteps = (newSteps: string[]) => {
    onChange({ ...content, steps: newSteps });
  };

  const addStep = () => {
    updateSteps([...steps, ""]);
  };

  const updateStep = (index: number, value: string) => {
    const newSteps = steps.map((s, i) => i === index ? value : s);
    updateSteps(newSteps);
  };

  const removeStep = (index: number) => {
    updateSteps(steps.filter((_, i) => i !== index));
  };

  return (
    <div className="p-4 space-y-4">
      <div>
        <label className="block text-xs text-[var(--foreground-muted)] mb-1">Instructions</label>
        <input
          type="text"
          value={instructions}
          onChange={(e) => onChange({ ...content, instructions: e.target.value })}
          className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
          placeholder="Drag and drop to arrange the steps in correct order..."
        />
      </div>

      <div>
        <div className="flex items-center justify-between mb-2">
          <label className="text-xs text-[var(--foreground-muted)]">Steps ({steps.length})</label>
          <button
            onClick={addStep}
            className="inline-flex items-center gap-1 text-xs text-[var(--primary)] hover:underline"
          >
            <Plus className="w-3 h-3" />
            Add Step
          </button>
        </div>

        <div className="space-y-2">
          {steps.map((step, index) => (
            <div key={index} className="flex items-center gap-2">
              <GripVertical className="w-4 h-4 text-slate-300" />
              <span className="w-6 h-6 rounded-full bg-[var(--primary)] text-white text-xs flex items-center justify-center font-medium">
                {index + 1}
              </span>
              <input
                type="text"
                value={step}
                onChange={(e) => updateStep(index, e.target.value)}
                className="flex-1 px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
                placeholder={`Step ${index + 1}`}
              />
              <button
                onClick={() => removeStep(index)}
                className="p-1 text-slate-400 hover:text-red-500"
              >
                <Trash2 className="w-4 h-4" />
              </button>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

// ============================================
// Formula Builder Editor
// ============================================

function FormulaBuilderEditor({ 
  content, 
  onChange 
}: { 
  content: Record<string, unknown>; 
  onChange: (updates: Record<string, unknown>) => void;
}) {
  const components = (content.components || []) as string[];
  const targetFormula = (content.target_formula || "") as string;
  const instructions = (content.instructions || "") as string;

  return (
    <div className="p-4 space-y-4">
      <div>
        <label className="block text-xs text-[var(--foreground-muted)] mb-1">Instructions</label>
        <input
          type="text"
          value={instructions}
          onChange={(e) => onChange({ ...content, instructions: e.target.value })}
          className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
          placeholder="Drag the components to build the correct formula..."
        />
      </div>

      <div>
        <label className="block text-xs text-[var(--foreground-muted)] mb-1">Target Formula</label>
        <input
          type="text"
          value={targetFormula}
          onChange={(e) => onChange({ ...content, target_formula: e.target.value })}
          className="w-full px-3 py-2 rounded-lg border border-[var(--border)] text-sm font-mono focus:outline-none focus:ring-2 focus:ring-[var(--primary)]"
          placeholder="e.g., Revenue - Cost = Profit"
        />
      </div>

      <div>
        <label className="block text-xs text-[var(--foreground-muted)] mb-1">
          Components ({components.length})
        </label>
        <div className="flex flex-wrap gap-2">
          {components.map((comp, index) => (
            <span 
              key={index}
              className="px-3 py-1 bg-slate-100 rounded-full text-sm"
            >
              {comp}
            </span>
          ))}
        </div>
        <p className="text-xs text-[var(--foreground-muted)] mt-2">
          Use JSON mode to edit formula components.
        </p>
      </div>
    </div>
  );
}

