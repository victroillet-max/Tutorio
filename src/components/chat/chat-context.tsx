"use client";

import React, { createContext, useContext, useState, useCallback } from "react";

interface ChatActivityContext {
  activityId?: string;
  skillId?: string;
  studentCode?: string;
  errorMessage?: string;
  currentQuestionText?: string;
  currentQuestionNumber?: number;
}

export type PopupType = 'welcome' | 'help' | 'struggling';

interface PopupState {
  show: boolean;
  message: string;
  type: PopupType;
}

interface ChatContextValue {
  context: ChatActivityContext;
  setActivityContext: (ctx: Partial<ChatActivityContext>) => void;
  updateStudentCode: (code: string) => void;
  updateErrorMessage: (error: string | undefined) => void;
  updateCurrentQuestion: (questionText: string, questionNumber: number) => void;
  clearContext: () => void;
  // Popup state and functions
  popup: PopupState;
  hasSeenWelcome: boolean;
  hasDismissedHelp: boolean;
  triggerPopup: (message: string, type: PopupType) => void;
  dismissPopup: () => void;
  markWelcomeSeen: () => void;
}

const ChatContext = createContext<ChatContextValue | undefined>(undefined);

export function ChatContextProvider({ children }: { children: React.ReactNode }) {
  const [context, setContext] = useState<ChatActivityContext>({});
  
  // Popup state
  const [popup, setPopup] = useState<PopupState>({
    show: false,
    message: "",
    type: "welcome",
  });
  const [hasSeenWelcome, setHasSeenWelcome] = useState(false);
  const [hasDismissedHelp, setHasDismissedHelp] = useState(false);

  const setActivityContext = useCallback((ctx: Partial<ChatActivityContext>) => {
    setContext(prev => ({ ...prev, ...ctx }));
  }, []);

  const updateStudentCode = useCallback((code: string) => {
    setContext(prev => ({ ...prev, studentCode: code }));
  }, []);

  const updateErrorMessage = useCallback((error: string | undefined) => {
    setContext(prev => ({ ...prev, errorMessage: error }));
  }, []);

  const updateCurrentQuestion = useCallback((questionText: string, questionNumber: number) => {
    setContext(prev => ({ ...prev, currentQuestionText: questionText, currentQuestionNumber: questionNumber }));
  }, []);

  const clearContext = useCallback(() => {
    setContext({});
  }, []);

  // Popup functions
  const triggerPopup = useCallback((message: string, type: PopupType) => {
    // Don't show welcome popup if already seen
    if (type === 'welcome' && hasSeenWelcome) return;
    // Don't show help popup if already dismissed this session
    if (type === 'help' && hasDismissedHelp) return;
    
    setPopup({ show: true, message, type });
  }, [hasSeenWelcome, hasDismissedHelp]);

  const dismissPopup = useCallback(() => {
    if (popup.type === 'welcome') {
      setHasSeenWelcome(true);
    } else if (popup.type === 'help') {
      setHasDismissedHelp(true);
    }
    setPopup(prev => ({ ...prev, show: false }));
  }, [popup.type]);

  const markWelcomeSeen = useCallback(() => {
    setHasSeenWelcome(true);
  }, []);

  return (
    <ChatContext.Provider
      value={{
        context,
        setActivityContext,
        updateStudentCode,
        updateErrorMessage,
        updateCurrentQuestion,
        clearContext,
        popup,
        hasSeenWelcome,
        hasDismissedHelp,
        triggerPopup,
        dismissPopup,
        markWelcomeSeen,
      }}
    >
      {children}
    </ChatContext.Provider>
  );
}

export function useChatContext() {
  const context = useContext(ChatContext);
  if (!context) {
    throw new Error("useChatContext must be used within a ChatContextProvider");
  }
  return context;
}

/**
 * Hook to set activity context when entering an activity page
 */
export function useSetActivityContext(activityId: string, skillId?: string) {
  const { setActivityContext, clearContext } = useChatContext();

  React.useEffect(() => {
    setActivityContext({ activityId, skillId });
    
    // Clear context when leaving the activity page
    return () => {
      clearContext();
    };
  }, [activityId, skillId, setActivityContext, clearContext]);
}

