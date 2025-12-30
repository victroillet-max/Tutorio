"use client";

import { useState, useEffect, useCallback } from "react";
import { createPortal } from "react-dom";
import { ChevronRight, ChevronLeft, X, Sparkles, BookOpen, Target, MessageCircle } from "lucide-react";

interface TourStep {
  id: string;
  title: string;
  content: string;
  targetSelector?: string;
  position?: "top" | "bottom" | "left" | "right" | "center";
  icon?: React.ComponentType<{ className?: string }>;
}

const TOUR_STEPS: TourStep[] = [
  {
    id: "welcome",
    title: "Welcome to Tutorio!",
    content: "Let's take a quick tour to help you get started with your learning journey.",
    position: "center",
    icon: Sparkles,
  },
  {
    id: "dashboard",
    title: "Your Dashboard",
    content: "This is your home base. Here you can see your progress, enrolled courses, and continue where you left off.",
    targetSelector: '[data-tour="dashboard-welcome"]',
    position: "bottom",
    icon: BookOpen,
  },
  {
    id: "quick-actions",
    title: "Quick Actions",
    content: "Access your courses and track your progress from here. Use the Quick Start button to jump right into learning!",
    targetSelector: '[data-tour="quick-actions"]',
    position: "left",
    icon: Target,
  },
  {
    id: "ai-tutor",
    title: "Meet Bob - Your AI Tutor",
    content: "Stuck on a problem? Click the chat button in the bottom right corner to ask Bob for help. He can explain concepts, review your code, and answer questions!",
    targetSelector: '[data-tour="chat-widget"]',
    position: "top",
    icon: MessageCircle,
  },
  {
    id: "finish",
    title: "You're All Set!",
    content: "Start learning by clicking 'Start Learning Now' or browse our course library. Good luck on your learning journey!",
    position: "center",
    icon: Sparkles,
  },
];

const STORAGE_KEY = "tutorio-onboarding-completed";

export function OnboardingTour() {
  const [isActive, setIsActive] = useState(false);
  const [currentStep, setCurrentStep] = useState(0);
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
    
    // Check if tour was already completed
    const completed = localStorage.getItem(STORAGE_KEY);
    if (!completed) {
      // Small delay to let page render
      const timer = setTimeout(() => {
        setIsActive(true);
      }, 1000);
      return () => clearTimeout(timer);
    }
  }, []);

  const completeTour = useCallback(() => {
    localStorage.setItem(STORAGE_KEY, "true");
    setIsActive(false);
  }, []);

  const nextStep = useCallback(() => {
    if (currentStep < TOUR_STEPS.length - 1) {
      setCurrentStep(prev => prev + 1);
    } else {
      completeTour();
    }
  }, [currentStep, completeTour]);

  const prevStep = useCallback(() => {
    if (currentStep > 0) {
      setCurrentStep(prev => prev - 1);
    }
  }, [currentStep]);

  const skipTour = useCallback(() => {
    completeTour();
  }, [completeTour]);

  // Handle keyboard navigation
  useEffect(() => {
    if (!isActive) return;

    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") {
        skipTour();
      } else if (e.key === "ArrowRight" || e.key === "Enter") {
        nextStep();
      } else if (e.key === "ArrowLeft") {
        prevStep();
      }
    };

    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [isActive, nextStep, prevStep, skipTour]);

  if (!mounted || !isActive) return null;

  const step = TOUR_STEPS[currentStep];
  const StepIcon = step.icon;
  const isCenter = step.position === "center" || !step.targetSelector;
  const isLastStep = currentStep === TOUR_STEPS.length - 1;
  const isFirstStep = currentStep === 0;

  return createPortal(
    <>
      {/* Backdrop */}
      <div 
        className="fixed inset-0 bg-black/60 z-[9998] transition-opacity duration-300"
        onClick={skipTour}
      />
      
      {/* Tooltip */}
      <div 
        className={`fixed z-[9999] ${
          isCenter 
            ? "top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2" 
            : "bottom-32 right-8"
        }`}
      >
        <div className="bg-white rounded-2xl shadow-2xl p-6 max-w-sm animate-in fade-in slide-in-from-bottom-4 duration-300">
          {/* Header */}
          <div className="flex items-start justify-between mb-4">
            <div className="flex items-center gap-3">
              {StepIcon && (
                <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-violet-500/20 to-indigo-500/20 flex items-center justify-center">
                  <StepIcon className="w-5 h-5 text-violet-600" />
                </div>
              )}
              <h3 
                className="text-lg font-bold text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {step.title}
              </h3>
            </div>
            <button
              onClick={skipTour}
              className="text-[var(--foreground-muted)] hover:text-[var(--foreground)] transition-colors"
              aria-label="Skip tour"
            >
              <X className="w-5 h-5" />
            </button>
          </div>

          {/* Content */}
          <p className="text-[var(--foreground-muted)] mb-6">
            {step.content}
          </p>

          {/* Progress */}
          <div className="flex items-center gap-1 mb-4">
            {TOUR_STEPS.map((_, index) => (
              <div
                key={index}
                className={`h-1 flex-1 rounded-full transition-colors ${
                  index === currentStep 
                    ? 'bg-violet-500' 
                    : index < currentStep 
                      ? 'bg-violet-200'
                      : 'bg-slate-200'
                }`}
              />
            ))}
          </div>

          {/* Actions */}
          <div className="flex items-center justify-between">
            <div>
              {!isFirstStep && (
                <button
                  onClick={prevStep}
                  className="flex items-center gap-1 text-sm text-[var(--foreground-muted)] hover:text-[var(--foreground)] transition-colors"
                >
                  <ChevronLeft className="w-4 h-4" />
                  Back
                </button>
              )}
            </div>
            <div className="flex items-center gap-3">
              {!isLastStep && (
                <button
                  onClick={skipTour}
                  className="text-sm text-[var(--foreground-muted)] hover:text-[var(--foreground)] transition-colors"
                >
                  Skip tour
                </button>
              )}
              <button
                onClick={nextStep}
                className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-violet-600 to-indigo-600 text-white text-sm font-semibold rounded-lg hover:from-violet-500 hover:to-indigo-500 transition-colors"
              >
                {isLastStep ? "Get Started" : "Next"}
                <ChevronRight className="w-4 h-4" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </>,
    document.body
  );
}

/**
 * Hook to reset the onboarding tour (for testing)
 */
export function useResetOnboarding() {
  return useCallback(() => {
    localStorage.removeItem(STORAGE_KEY);
    window.location.reload();
  }, []);
}

