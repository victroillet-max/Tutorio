"use client";

import { useState } from "react";
import { 
  Bold, 
  Italic, 
  Heading1, 
  Heading2, 
  Heading3,
  List,
  ListOrdered,
  Code,
  Table,
  Quote,
  Link as LinkIcon,
  Image,
  Minus
} from "lucide-react";

interface LessonEditorProps {
  content: { markdown?: string } | null;
  onChange: (content: { markdown: string }) => void;
}

export function LessonEditor({ content, onChange }: LessonEditorProps) {
  const [markdown, setMarkdown] = useState(content?.markdown || "");

  const handleChange = (value: string) => {
    setMarkdown(value);
    onChange({ markdown: value });
  };

  const insertAtCursor = (before: string, after: string = "") => {
    const textarea = document.getElementById("markdown-editor") as HTMLTextAreaElement;
    if (!textarea) return;

    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const selectedText = markdown.substring(start, end);
    
    const newText = 
      markdown.substring(0, start) + 
      before + 
      selectedText + 
      after + 
      markdown.substring(end);
    
    handleChange(newText);
    
    // Restore cursor position
    setTimeout(() => {
      textarea.focus();
      textarea.selectionStart = start + before.length;
      textarea.selectionEnd = start + before.length + selectedText.length;
    }, 0);
  };

  const toolbarButtons = [
    { icon: Bold, action: () => insertAtCursor("**", "**"), title: "Bold" },
    { icon: Italic, action: () => insertAtCursor("*", "*"), title: "Italic" },
    { icon: Code, action: () => insertAtCursor("`", "`"), title: "Inline Code" },
    { type: "divider" },
    { icon: Heading1, action: () => insertAtCursor("# ", ""), title: "Heading 1" },
    { icon: Heading2, action: () => insertAtCursor("## ", ""), title: "Heading 2" },
    { icon: Heading3, action: () => insertAtCursor("### ", ""), title: "Heading 3" },
    { type: "divider" },
    { icon: List, action: () => insertAtCursor("- ", ""), title: "Bullet List" },
    { icon: ListOrdered, action: () => insertAtCursor("1. ", ""), title: "Numbered List" },
    { icon: Quote, action: () => insertAtCursor("> ", ""), title: "Quote" },
    { type: "divider" },
    { icon: LinkIcon, action: () => insertAtCursor("[", "](url)"), title: "Link" },
    { icon: Image, action: () => insertAtCursor("![alt](", ")"), title: "Image" },
    { icon: Table, action: () => insertAtCursor("\n| Header | Header |\n|--------|--------|\n| Cell | Cell |\n", ""), title: "Table" },
    { icon: Minus, action: () => insertAtCursor("\n---\n", ""), title: "Horizontal Rule" },
  ];

  return (
    <div className="flex flex-col h-full">
      {/* Toolbar */}
      <div className="flex items-center gap-1 p-2 border-b border-[var(--border)] bg-slate-50 flex-wrap">
        {toolbarButtons.map((btn, idx) => 
          btn.type === "divider" ? (
            <div key={idx} className="w-px h-6 bg-slate-200 mx-1" />
          ) : (
            <button
              key={idx}
              onClick={btn.action}
              title={btn.title}
              className="p-1.5 rounded hover:bg-slate-200 transition-colors text-slate-600 hover:text-slate-900"
            >
              {btn.icon && <btn.icon className="w-4 h-4" />}
            </button>
          )
        )}
      </div>

      {/* Editor */}
      <div className="flex-1 relative">
        <textarea
          id="markdown-editor"
          value={markdown}
          onChange={(e) => handleChange(e.target.value)}
          placeholder="Write your lesson content in Markdown..."
          className="w-full h-full min-h-[400px] p-4 font-mono text-sm resize-none focus:outline-none"
          style={{ 
            lineHeight: "1.6",
            tabSize: 2
          }}
        />
      </div>

      {/* Footer hints */}
      <div className="px-4 py-2 border-t border-[var(--border)] bg-slate-50 text-xs text-[var(--foreground-muted)]">
        <p>
          <strong>Tips:</strong> Use <code className="px-1 bg-slate-200 rounded">---</code> for slide breaks, 
          <code className="px-1 bg-slate-200 rounded ml-1">:::</code> for callout blocks (:::takeaways, :::warning)
        </p>
      </div>
    </div>
  );
}

