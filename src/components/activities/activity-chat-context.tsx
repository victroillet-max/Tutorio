"use client";

import { useEffect, useRef } from "react";
import { useChatContext } from "@/components/chat";
import { hasUserChatHistory } from "@/lib/ai/actions";

interface ActivityChatContextProps {
  activityId: string;
  skillId?: string;
}

/**
 * Component that sets the chat context when mounted on an activity page
 * This allows the AI tutor to know which activity the user is working on
 * Also handles showing the welcome popup for new users
 */
export function ActivityChatContext({ activityId, skillId }: ActivityChatContextProps) {
  const { 
    setActivityContext, 
    clearContext, 
    hasSeenWelcome, 
    triggerPopup 
  } = useChatContext();
  
  // Track if we've already checked for new user this mount
  const hasCheckedNewUser = useRef(false);

  useEffect(() => {
    // Set the activity context when the component mounts
    setActivityContext({ activityId, skillId });

    // Clear the context when leaving the activity page
    return () => {
      clearContext();
    };
  }, [activityId, skillId, setActivityContext, clearContext]);

  // Check if user is new (never chatted before) and show welcome popup
  useEffect(() => {
    if (hasSeenWelcome || hasCheckedNewUser.current) return;
    hasCheckedNewUser.current = true;

    async function checkNewUser() {
      try {
        const hasChatted = await hasUserChatHistory();
        if (!hasChatted) {
          // Small delay to let the page render first
          setTimeout(() => {
            triggerPopup(
              "Hi! I'm Bob, your AI Tutor. Click here if you ever need help!",
              "welcome"
            );
          }, 1500);
        }
      } catch (error) {
        console.error("Failed to check chat history:", error);
      }
    }

    checkNewUser();
  }, [hasSeenWelcome, triggerPopup]);

  // This component doesn't render anything visible
  return null;
}

