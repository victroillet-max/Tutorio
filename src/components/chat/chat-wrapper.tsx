"use client";

import { ChatContextProvider } from "./chat-context";
import { ChatWidgetWithContext } from "./chat-widget-with-context";

interface ChatWrapperProps {
  children: React.ReactNode;
}

/**
 * Client-side wrapper that provides chat context and renders the chat widget
 * This is used in the protected layout to enable context-aware AI tutoring
 */
export function ChatWrapper({ children }: ChatWrapperProps) {
  return (
    <ChatContextProvider>
      {children}
      <ChatWidgetWithContext />
    </ChatContextProvider>
  );
}

