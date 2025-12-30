"use client";

import { useChatContext } from "./chat-context";
import { ChatWidget } from "./chat-widget";

/**
 * ChatWidget wrapper that automatically reads context from ChatContextProvider
 * Only renders the widget when in an activity/lesson context
 */
export function ChatWidgetWithContext() {
  const { context, isVisible } = useChatContext();

  // Don't render the chat widget unless we're in an activity context
  if (!isVisible) {
    return null;
  }

  return (
    <ChatWidget
      activityId={context.activityId}
      skillId={context.skillId}
      studentCode={context.studentCode}
      errorMessage={context.errorMessage}
      currentQuestionText={context.currentQuestionText}
      currentQuestionNumber={context.currentQuestionNumber}
      courseName={context.courseName}
      courseId={context.courseId}
    />
  );
}

