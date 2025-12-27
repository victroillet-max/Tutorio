"use client";

import { useChatContext } from "./chat-context";
import { ChatWidget } from "./chat-widget";

/**
 * ChatWidget wrapper that automatically reads context from ChatContextProvider
 */
export function ChatWidgetWithContext() {
  const { context } = useChatContext();

  return (
    <ChatWidget
      activityId={context.activityId}
      skillId={context.skillId}
      studentCode={context.studentCode}
      errorMessage={context.errorMessage}
      currentQuestionText={context.currentQuestionText}
      currentQuestionNumber={context.currentQuestionNumber}
    />
  );
}

