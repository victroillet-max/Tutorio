"use client";

import { ReactNode, useMemo } from "react";
import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";
import { ContentBlock, QuickCheck, KeyTakeaways, type BlockType } from "./content-blocks";

interface EnhancedMarkdownProps {
  content: string;
}

interface ParsedBlock {
  type: "markdown" | "block" | "quickcheck" | "takeaways";
  content: string;
  blockType?: BlockType;
  title?: string;
  collapsible?: boolean;
  // Quick check specific
  question?: string;
  options?: string[];
  correctIndex?: number;
  explanation?: string;
  // Takeaways specific
  takeaways?: string[];
}

/**
 * Enhanced Markdown parser that recognizes custom block syntax:
 * 
 * :::concept{title="Custom Title"}
 * Content here
 * :::
 * 
 * Supported block types:
 * - concept, example, tip, warning, definition, practice, remember, code
 * 
 * Quick check syntax:
 * :::quickcheck
 * Q: What is the answer?
 * - [ ] Option A
 * - [x] Option B (correct)
 * - [ ] Option C
 * ---
 * Explanation here
 * :::
 * 
 * Key takeaways syntax:
 * :::takeaways
 * - First takeaway
 * - Second takeaway
 * :::
 */
function parseEnhancedMarkdown(content: string): ParsedBlock[] {
  const blocks: ParsedBlock[] = [];
  
  // Regex to match custom blocks: :::type{options} ... :::
  const blockRegex = /:::(\w+)(?:\{([^}]*)\})?\n([\s\S]*?):::/g;
  
  let lastIndex = 0;
  let match;
  
  while ((match = blockRegex.exec(content)) !== null) {
    // Add any markdown content before this block
    if (match.index > lastIndex) {
      const markdownContent = content.slice(lastIndex, match.index).trim();
      if (markdownContent) {
        blocks.push({ type: "markdown", content: markdownContent });
      }
    }
    
    const blockType = match[1].toLowerCase();
    const options = match[2] || "";
    const blockContent = match[3].trim();
    
    // Parse options (e.g., title="My Title" collapsible)
    const titleMatch = options.match(/title="([^"]*)"/);
    const title = titleMatch ? titleMatch[1] : undefined;
    const collapsible = options.includes("collapsible");
    
    if (blockType === "quickcheck") {
      // Parse quick check format
      const parsed = parseQuickCheck(blockContent);
      blocks.push({
        type: "quickcheck",
        content: blockContent,
        ...parsed,
      });
    } else if (blockType === "takeaways") {
      // Parse takeaways list
      const takeaways = blockContent
        .split("\n")
        .filter(line => line.trim().startsWith("-"))
        .map(line => line.replace(/^-\s*/, "").trim());
      blocks.push({
        type: "takeaways",
        content: blockContent,
        takeaways,
      });
    } else if (isValidBlockType(blockType)) {
      blocks.push({
        type: "block",
        content: blockContent,
        blockType: blockType as BlockType,
        title,
        collapsible,
      });
    } else {
      // Unknown block type, treat as regular markdown
      blocks.push({ type: "markdown", content: match[0] });
    }
    
    lastIndex = match.index + match[0].length;
  }
  
  // Add any remaining markdown content
  if (lastIndex < content.length) {
    const markdownContent = content.slice(lastIndex).trim();
    if (markdownContent) {
      blocks.push({ type: "markdown", content: markdownContent });
    }
  }
  
  return blocks;
}

function isValidBlockType(type: string): type is BlockType {
  return ["concept", "example", "tip", "warning", "definition", "practice", "remember", "code", "quiz"].includes(type);
}

function parseQuickCheck(content: string): {
  question: string;
  options: string[];
  correctIndex: number;
  explanation: string;
} {
  const lines = content.split("\n");
  let question = "";
  const options: string[] = [];
  let correctIndex = 0;
  let explanation = "";
  
  let inExplanation = false;
  
  for (const line of lines) {
    const trimmed = line.trim();
    
    if (trimmed === "---") {
      inExplanation = true;
      continue;
    }
    
    if (inExplanation) {
      explanation += (explanation ? "\n" : "") + trimmed;
    } else if (trimmed.startsWith("Q:")) {
      question = trimmed.replace(/^Q:\s*/, "");
    } else if (trimmed.startsWith("- [x]") || trimmed.startsWith("- [X]")) {
      options.push(trimmed.replace(/^- \[[xX]\]\s*/, ""));
      correctIndex = options.length - 1;
    } else if (trimmed.startsWith("- [ ]")) {
      options.push(trimmed.replace(/^- \[ \]\s*/, ""));
    }
  }
  
  return { question, options, correctIndex, explanation };
}

// Markdown article container class - using markdown-body for custom styling
const proseClasses = "markdown-body";

export function EnhancedMarkdown({ content }: EnhancedMarkdownProps) {
  const blocks = useMemo(() => parseEnhancedMarkdown(content), [content]);
  
  return (
    <div className="space-y-0">
      {blocks.map((block, index) => {
        switch (block.type) {
          case "markdown":
            return (
              <article key={index} className={proseClasses}>
                <ReactMarkdown remarkPlugins={[remarkGfm]}>
                  {block.content}
                </ReactMarkdown>
              </article>
            );
          
          case "block":
            return (
              <ContentBlock
                key={index}
                type={block.blockType!}
                title={block.title}
                collapsible={block.collapsible}
              >
                <article className={proseClasses}>
                  <ReactMarkdown remarkPlugins={[remarkGfm]}>
                    {block.content}
                  </ReactMarkdown>
                </article>
              </ContentBlock>
            );
          
          case "quickcheck":
            return (
              <QuickCheck
                key={index}
                question={block.question || ""}
                options={block.options || []}
                correctIndex={block.correctIndex || 0}
                explanation={block.explanation || ""}
              />
            );
          
          case "takeaways":
            return (
              <KeyTakeaways
                key={index}
                takeaways={block.takeaways || []}
              />
            );
          
          default:
            return null;
        }
      })}
    </div>
  );
}

export { parseEnhancedMarkdown };

