"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Loader2, Zap } from "lucide-react";
import { Button } from "@/components/ui/button";
import { quickStartLearning } from "@/lib/activities/actions";

export function QuickStartButton() {
  const [isLoading, setIsLoading] = useState(false);
  const router = useRouter();

  async function handleQuickStart() {
    setIsLoading(true);
    try {
      const result = await quickStartLearning();
      if (result.success && result.redirectUrl) {
        router.push(result.redirectUrl);
      } else if (result.error) {
        console.error("Quick start failed:", result.error);
        // Fallback to courses page
        router.push("/courses");
      }
    } catch (error) {
      console.error("Quick start failed:", error);
      router.push("/courses");
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <Button 
      onClick={handleQuickStart}
      disabled={isLoading}
      className="bg-gradient-to-r from-violet-600 to-indigo-600 text-white font-semibold hover:from-violet-500 hover:to-indigo-500 shadow-lg shadow-violet-500/25 px-6 py-3 h-auto"
    >
      {isLoading ? (
        <>
          <Loader2 className="w-4 h-4 mr-2 animate-spin" />
          Starting...
        </>
      ) : (
        <>
          <Zap className="w-4 h-4 mr-2" />
          Start Learning Now
        </>
      )}
    </Button>
  );
}

