"use client";

import { useEffect, useRef } from "react";
import { useChatContext } from "@/components/chat";
import { hasUserChatHistory, getSkillCourseInfo } from "@/lib/ai/actions";

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
    triggerPopup,
    context 
  } = useChatContext();
  
  // Track if we've already checked for new user this mount
  const hasCheckedNewUser = useRef(false);
  // Track if we've already fetched course info this mount
  const hasFetchedCourseInfo = useRef(false);

  useEffect(() => {
    // Set the basic activity context when the component mounts
    setActivityContext({ activityId, skillId });

    // Clear the context when leaving the activity page
    return () => {
      clearContext();
    };
  }, [activityId, skillId, setActivityContext, clearContext]);

  // Fetch course info when skillId changes
  useEffect(() => {
    if (!skillId || hasFetchedCourseInfo.current) return;
    hasFetchedCourseInfo.current = true;

    async function fetchCourseInfo() {
      try {
        const courseInfo = await getSkillCourseInfo(skillId!);
        if (courseInfo) {
          setActivityContext({ 
            courseName: courseInfo.courseName,
            courseId: courseInfo.courseId 
          });
        }
      } catch (error) {
        console.error("Failed to fetch course info:", error);
      }
    }

    fetchCourseInfo();
  }, [skillId, setActivityContext]);

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
            const courseMessage = context.courseName 
              ? `Hi! I'm Bob, your AI Tutor for ${context.courseName}. Click here if you ever need help!`
              : "Hi! I'm Bob, your AI Tutor. Click here if you ever need help!";
            triggerPopup(courseMessage, "welcome");
          }, 1500);
        }
      } catch (error) {
        console.error("Failed to check chat history:", error);
      }
    }

    checkNewUser();
  }, [hasSeenWelcome, triggerPopup, context.courseName]);

  // This component doesn't render anything visible
  return null;
}

