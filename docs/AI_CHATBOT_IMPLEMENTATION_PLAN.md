# AI Chatbot Implementation Plan for Tutorio

## Overview

This document outlines the implementation plan for an AI-powered chatbot that provides real-time support to students while they complete coding exercises. The chatbot will help with error explanations, provide hints, answer questions about concepts, and offer additional explanations.

---

## Table of Contents

1. [Core Features](#core-features)
2. [Technical Architecture](#technical-architecture)
3. [Implementation Phases](#implementation-phases)
4. [UI/UX Design](#uiux-design)
5. [Security Considerations](#security-considerations)
6. [Cost Optimization](#cost-optimization)
7. [Database Schema Updates](#database-schema-updates)
8. [API Routes](#api-routes)
9. [Component Structure](#component-structure)
10. [Integration Points](#integration-points)

---

## Core Features

### 1. Error Explanation
- Automatically detect Python errors from the code editor
- Parse error messages and provide beginner-friendly explanations
- Show common fixes and examples
- Link to relevant lesson content

### 2. Code Hints & Guidance
- Contextual hints based on the current exercise
- Progressive hint system (general → specific)
- Never give away the full solution
- Socratic method: guide through questions

### 3. Concept Clarification
- Answer questions about programming concepts
- Provide additional examples beyond the lesson
- Explain "why" not just "how"
- Connect concepts to real-world applications

### 4. Debugging Assistant
- Help students trace through their code logic
- Identify logical errors vs syntax errors
- Suggest debugging strategies
- Explain step-by-step execution

### 5. Progress Encouragement
- Celebrate small wins
- Provide motivational messages when stuck
- Track common struggle points for curriculum improvement

---

## Technical Architecture

### Option A: OpenAI API (Recommended for Start)

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│   Next.js App   │────▶│   API Route      │────▶│   OpenAI API    │
│   (Frontend)    │◀────│   /api/chat      │◀────│   (GPT-4)       │
└─────────────────┘     └──────────────────┘     └─────────────────┘
                               │
                               ▼
                        ┌──────────────────┐
                        │   Supabase       │
                        │   (Chat History) │
                        └──────────────────┘
```

### Option B: Anthropic Claude API (Alternative)

Same architecture as Option A but using Claude for potentially better code explanations.

### Option C: Self-Hosted (Future Consideration)

For cost optimization at scale, consider self-hosted open-source models like:
- Llama 3
- Mistral
- CodeLlama (specifically for code)

---

## Implementation Phases

### Phase 1: Foundation (Week 1-2)

**Tasks:**
1. Set up OpenAI/Anthropic API integration
2. Create chat API route with streaming support
3. Build basic chat UI component
4. Implement error detection hook
5. Create system prompt for educational context

**Deliverables:**
- `/api/chat/route.ts` - Streaming chat endpoint
- `ChatWidget` component - Floating chat interface
- `useCodeErrors` hook - Error detection from code editor
- Basic prompt engineering for educational context

### Phase 2: Context Integration (Week 3-4)

**Tasks:**
1. Connect chat to current activity context
2. Implement activity-aware prompting
3. Add code snippet sharing to chat
4. Create hint request system
5. Store conversation history in Supabase

**Deliverables:**
- Activity context injection
- Conversation persistence
- "Share Code" button in chat
- Hint progression system

### Phase 3: Smart Features (Week 5-6)

**Tasks:**
1. Automatic error explanation trigger
2. Proactive assistance (detect struggling)
3. Solution protection (prevent giving answers)
4. Rate limiting and usage tracking
5. Admin dashboard for chat analytics

**Deliverables:**
- Auto-error explanation modal
- Struggle detection algorithm
- Anti-spoiler prompt engineering
- Usage metrics and analytics

### Phase 4: Polish & Optimization (Week 7-8)

**Tasks:**
1. Response caching for common questions
2. Performance optimization
3. Mobile responsiveness
4. Accessibility improvements
5. User feedback collection

**Deliverables:**
- Redis caching layer (optional)
- Mobile-friendly chat UI
- ARIA labels and keyboard navigation
- Feedback/rating system

---

## UI/UX Design

### Chat Widget Placement

```
┌──────────────────────────────────────────────────────────────┐
│ Activity Page Header                                          │
├────────────────────────────┬─────────────────────────────────┤
│                            │                                  │
│   Code Editor              │   Output / Test Results          │
│                            │                                  │
│                            │                                  │
│                            │                                  │
│                            │                                  │
├────────────────────────────┴─────────────────────────────────┤
│                                                        ┌─────┐│
│                                                        │ AI  ││
│                                                        │ Help││
│                                                        └─────┘│
└──────────────────────────────────────────────────────────────┘
```

### Chat Interface States

1. **Collapsed**: Floating button in bottom-right corner
2. **Expanded**: Slide-up panel or modal with conversation
3. **Error Mode**: Auto-opens with error explanation

### Message Types

- **User**: Student messages and questions
- **Assistant**: AI responses with code formatting
- **System**: Tips, hints, and navigation suggestions
- **Error**: Highlighted error explanations with fix suggestions

---

## Security Considerations

### 1. API Key Protection
- Store OpenAI/Anthropic keys in environment variables
- Never expose keys to client-side code
- Use server-side API routes exclusively

### 2. Rate Limiting
```typescript
// Suggested rate limits
const RATE_LIMITS = {
  free: { messagesPerHour: 10, messagesPerDay: 50 },
  basic: { messagesPerHour: 30, messagesPerDay: 200 },
  advanced: { messagesPerHour: 100, messagesPerDay: 1000 },
};
```

### 3. Content Moderation
- Filter inappropriate requests
- Block attempts to use AI for non-educational purposes
- Log and monitor unusual patterns

### 4. Solution Protection
- System prompt engineering to prevent full solutions
- Keyword detection for "give me the answer"
- Redirect to hints instead of solutions

---

## Cost Optimization

### Strategies

1. **Token Optimization**
   - Limit context window size
   - Summarize long conversations
   - Use efficient prompts

2. **Caching**
   - Cache common error explanations
   - Store concept explanations
   - Use semantic similarity for cache hits

3. **Model Selection**
   - GPT-3.5 for simple questions (cheaper)
   - GPT-4 for complex debugging (better quality)
   - Route based on query complexity

4. **Usage Tiers**
   - Free users: Limited AI assistance
   - Paid users: Full AI access
   - Batch processing for non-urgent queries

### Estimated Costs (OpenAI GPT-4)

| User Tier | Messages/Month | Est. Cost/User |
|-----------|----------------|----------------|
| Free      | 50             | ~$0.50         |
| Basic     | 200            | ~$2.00         |
| Advanced  | 1000           | ~$10.00        |

---

## Database Schema Updates

### New Tables

```sql
-- Chat conversations table
CREATE TABLE chat_conversations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  activity_id UUID REFERENCES activities(id) ON DELETE SET NULL,
  title TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Chat messages table
CREATE TABLE chat_messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id UUID REFERENCES chat_conversations(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('user', 'assistant', 'system')),
  content TEXT NOT NULL,
  metadata JSONB,
  tokens_used INTEGER,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Usage tracking table
CREATE TABLE ai_usage (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  messages_count INTEGER DEFAULT 0,
  tokens_used INTEGER DEFAULT 0,
  UNIQUE(user_id, date)
);

-- Indexes
CREATE INDEX idx_chat_conversations_user ON chat_conversations(user_id);
CREATE INDEX idx_chat_messages_conversation ON chat_messages(conversation_id);
CREATE INDEX idx_ai_usage_user_date ON ai_usage(user_id, date);
```

---

## API Routes

### `/api/chat/route.ts`

```typescript
// POST /api/chat
// Request body:
{
  message: string;
  conversationId?: string;
  activityId?: string;
  codeContext?: string;
  errorContext?: string;
}

// Response: Server-Sent Events (SSE) stream
// Each chunk: { content: string, done: boolean }
```

### `/api/chat/history/route.ts`

```typescript
// GET /api/chat/history?conversationId=xxx
// Response: { messages: ChatMessage[] }

// DELETE /api/chat/history?conversationId=xxx
// Response: { success: boolean }
```

### `/api/chat/usage/route.ts`

```typescript
// GET /api/chat/usage
// Response: { 
//   messagesUsed: number,
//   messagesLimit: number,
//   tokensUsed: number,
//   resetAt: string
// }
```

---

## Component Structure

```
src/components/chat/
├── index.ts
├── chat-widget.tsx        # Main floating widget
├── chat-panel.tsx         # Expanded chat panel
├── chat-message.tsx       # Individual message component
├── chat-input.tsx         # Message input with send button
├── chat-header.tsx        # Panel header with controls
├── code-block.tsx         # Syntax-highlighted code in messages
├── error-explanation.tsx  # Formatted error explanations
├── hint-card.tsx          # Hint request/display component
└── typing-indicator.tsx   # AI typing animation
```

### Key Components

#### ChatWidget (Main Entry Point)
```typescript
interface ChatWidgetProps {
  activityId?: string;
  activityTitle?: string;
  codeContext?: string;
  errorContext?: string;
  userId: string;
  userPlan: PlanTier;
}
```

#### ChatMessage
```typescript
interface ChatMessageProps {
  role: 'user' | 'assistant' | 'system';
  content: string;
  timestamp: Date;
  isStreaming?: boolean;
}
```

---

## Integration Points

### 1. Code Editor Integration

```typescript
// In code-editor.tsx
import { ChatWidget } from '@/components/chat';

// Pass error context to chat
const errorContext = testResults
  .filter(r => !r.passed)
  .map(r => r.error || `Expected: ${r.expected}, Got: ${r.actual}`)
  .join('\n');

<ChatWidget
  activityId={activity.id}
  activityTitle={activity.title}
  codeContext={code}
  errorContext={errorContext}
  userId={userId}
  userPlan={userPlan}
/>
```

### 2. Activity Page Integration

```typescript
// In [activitySlug]/page.tsx
// Add ChatWidget to the bottom of the page for all activity types
<ChatWidget ... />
```

### 3. Lesson Viewer Integration

```typescript
// In lesson-viewer.tsx
// Add "Ask AI" button next to confusing concepts
<AskAIButton topic="variables" context={lessonContent} />
```

---

## System Prompts

### Base Educational Prompt

```
You are a friendly and patient programming tutor helping students learn Python.

Guidelines:
1. Never give complete solutions - guide students to discover answers
2. Use the Socratic method - ask questions to lead understanding
3. Explain errors in simple, beginner-friendly language
4. Provide small, incremental hints
5. Celebrate progress and encourage persistence
6. Relate concepts to real-world examples
7. If asked for the answer directly, provide hints instead
8. Format code examples using markdown code blocks

Current context:
- Activity: {activityTitle}
- Student's code: {codeContext}
- Errors (if any): {errorContext}
```

### Error Explanation Prompt

```
The student encountered the following Python error:
{errorMessage}

In their code:
```python
{codeContext}
```

Please:
1. Explain what this error means in simple terms
2. Point to the likely cause in their code
3. Suggest a fix without giving the complete solution
4. Provide an example of correct usage
```

---

## Monitoring & Analytics

### Metrics to Track

1. **Usage Metrics**
   - Messages per user per day
   - Token consumption
   - Most common questions
   - Error types explained

2. **Quality Metrics**
   - User satisfaction ratings
   - Conversation resolution rate
   - Time to resolution
   - Follow-up question rate

3. **Educational Metrics**
   - Correlation with completion rates
   - Common struggle points
   - Effective hint patterns
   - A/B test results

### Dashboard Features

- Real-time usage graphs
- Cost tracking
- Popular topics
- User feedback summary
- Flagged conversations

---

## Future Enhancements

1. **Voice Support**: Voice input for questions
2. **Code Review**: AI reviews and suggests improvements
3. **Personalization**: Learn individual student patterns
4. **Multi-language**: Support for more programming languages
5. **Peer Matching**: Connect struggling students with helpers
6. **Content Generation**: AI-assisted curriculum updates

---

## Getting Started

### Environment Variables Needed

```env
# OpenAI
OPENAI_API_KEY=sk-...

# Or Anthropic
ANTHROPIC_API_KEY=sk-ant-...

# Optional: Redis for caching
REDIS_URL=redis://...
```

### Installation Steps

1. Add OpenAI SDK:
   ```bash
   npm install openai
   ```

2. Create the API route structure

3. Implement the ChatWidget component

4. Add database migrations

5. Integrate with code editor

---

## Timeline Summary

| Phase | Duration | Key Deliverables |
|-------|----------|------------------|
| 1     | 2 weeks  | Basic chat functionality |
| 2     | 2 weeks  | Context integration |
| 3     | 2 weeks  | Smart features |
| 4     | 2 weeks  | Polish & optimization |

**Total Estimated Time: 8 weeks**

---

## Questions to Address

1. Which AI provider to use (OpenAI vs Anthropic)?
2. Should free users have access to AI chat?
3. Maximum conversation length to store?
4. Should AI responses be editable by admins?
5. How to handle AI service outages?

---

*Last Updated: December 26, 2024*

