"use client";

import React, { createContext, useContext, useState, useCallback } from "react";

// Reference data item (e.g., financial table, formula reference)
export interface ReferenceDataItem {
  title: string;
  content: string; // Formatted text representation
}

// Current scenario/context the student is viewing
export interface CurrentScenario {
  title?: string;
  description: string;
  companyName?: string;
}

// Enhanced context for the current question
export interface CurrentQuestionContext {
  number: number;
  text: string;
  type?: string; // 'mcq', 'numeric', 'choice', etc.
  options?: string[];
  hint?: string;
}

interface ChatActivityContext {
  activityId?: string;
  skillId?: string;
  studentCode?: string;
  errorMessage?: string;
  currentQuestionText?: string;
  currentQuestionNumber?: number;
  courseName?: string;
  courseId?: string;
  // Enhanced context fields
  currentQuestion?: CurrentQuestionContext;
  currentScenario?: CurrentScenario;
  referenceData?: ReferenceDataItem[];
  activityTitle?: string;
  activityType?: string;
  activityInstructions?: string;
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
  // Enhanced context update functions
  updateEnhancedQuestion: (question: CurrentQuestionContext) => void;
  updateScenario: (scenario: CurrentScenario) => void;
  updateReferenceData: (data: ReferenceDataItem[]) => void;
  updateActivityInfo: (info: { title?: string; type?: string; instructions?: string }) => void;
  clearContext: () => void;
  // Popup state and functions
  popup: PopupState;
  hasSeenWelcome: boolean;
  hasDismissedHelp: boolean;
  triggerPopup: (message: string, type: PopupType) => void;
  dismissPopup: () => void;
  markWelcomeSeen: () => void;
  // Visibility control
  isVisible: boolean;
  // Open chat with a pending message that will be auto-sent
  pendingMessage: string | null;
  openChatWithMessage: (message: string) => void;
  clearPendingMessage: () => void;
  shouldOpenChat: boolean;
  setShouldOpenChat: (open: boolean) => void;
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
  
  // Pending message state - for opening chat with a pre-filled message
  const [pendingMessage, setPendingMessage] = useState<string | null>(null);
  const [shouldOpenChat, setShouldOpenChat] = useState(false);

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

  // Enhanced context update functions
  const updateEnhancedQuestion = useCallback((question: CurrentQuestionContext) => {
    setContext(prev => ({ 
      ...prev, 
      currentQuestion: question,
      // Also update legacy fields for backward compatibility
      currentQuestionText: question.text,
      currentQuestionNumber: question.number,
    }));
  }, []);

  const updateScenario = useCallback((scenario: CurrentScenario) => {
    setContext(prev => ({ ...prev, currentScenario: scenario }));
  }, []);

  const updateReferenceData = useCallback((data: ReferenceDataItem[]) => {
    setContext(prev => ({ ...prev, referenceData: data }));
  }, []);

  const updateActivityInfo = useCallback((info: { title?: string; type?: string; instructions?: string }) => {
    setContext(prev => ({ 
      ...prev, 
      activityTitle: info.title,
      activityType: info.type,
      activityInstructions: info.instructions,
    }));
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

  // Open chat with a message that will be auto-sent
  const openChatWithMessage = useCallback((message: string) => {
    setPendingMessage(message);
    setShouldOpenChat(true);
    setHasDismissedHelp(true); // Don't show help popup after using this
  }, []);

  const clearPendingMessage = useCallback(() => {
    setPendingMessage(null);
  }, []);

  // Chat is only visible when there's an active activity context
  const isVisible = Boolean(context.activityId || context.skillId);

  return (
    <ChatContext.Provider
      value={{
        context,
        setActivityContext,
        updateStudentCode,
        updateErrorMessage,
        updateCurrentQuestion,
        updateEnhancedQuestion,
        updateScenario,
        updateReferenceData,
        updateActivityInfo,
        clearContext,
        popup,
        hasSeenWelcome,
        hasDismissedHelp,
        triggerPopup,
        dismissPopup,
        markWelcomeSeen,
        isVisible,
        pendingMessage,
        openChatWithMessage,
        clearPendingMessage,
        shouldOpenChat,
        setShouldOpenChat,
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

