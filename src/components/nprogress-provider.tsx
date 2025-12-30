"use client";

import { useEffect, Suspense } from "react";
import { usePathname, useSearchParams } from "next/navigation";

/**
 * NProgress-style loading bar for page transitions
 * Uses CSS-only implementation to avoid adding a dependency
 */
function NProgressBar() {
  const pathname = usePathname();
  const searchParams = useSearchParams();

  useEffect(() => {
    // Hide the progress bar when navigation completes
    const progressBar = document.getElementById("nprogress-bar");
    if (progressBar) {
      progressBar.classList.remove("loading");
      progressBar.classList.add("complete");
      
      // Reset after animation
      setTimeout(() => {
        progressBar.classList.remove("complete");
      }, 300);
    }
  }, [pathname, searchParams]);

  return null;
}

export function NProgressProvider() {
  useEffect(() => {
    // Create progress bar element
    const progressBar = document.createElement("div");
    progressBar.id = "nprogress-bar";
    
    // Create style element properly (avoiding innerHTML for security)
    const style = document.createElement("style");
    style.textContent = `
      #nprogress-bar {
        position: fixed;
        top: 0;
        left: 0;
        width: 0;
        height: 3px;
        background: linear-gradient(90deg, var(--primary) 0%, var(--primary-light) 100%);
        z-index: 9999;
        pointer-events: none;
        transition: width 0.2s ease, opacity 0.3s ease;
        opacity: 0;
      }
      #nprogress-bar.loading {
        width: 80%;
        opacity: 1;
        animation: nprogress-loading 2s ease-out forwards;
      }
      #nprogress-bar.complete {
        width: 100%;
        opacity: 0;
      }
      @keyframes nprogress-loading {
        0% { width: 0%; }
        10% { width: 20%; }
        50% { width: 60%; }
        100% { width: 80%; }
      }
    `;
    document.head.appendChild(style);
    document.body.appendChild(progressBar);

    // Intercept link clicks to show progress bar
    const handleClick = (e: MouseEvent) => {
      const target = e.target as HTMLElement;
      const anchor = target.closest("a");
      
      if (
        anchor &&
        anchor.href &&
        !anchor.target &&
        !anchor.href.startsWith("#") &&
        !anchor.href.startsWith("mailto:") &&
        !anchor.href.startsWith("tel:") &&
        anchor.hostname === window.location.hostname &&
        !e.ctrlKey &&
        !e.metaKey &&
        !e.shiftKey
      ) {
        // Check if it's a different path
        const url = new URL(anchor.href);
        if (url.pathname !== window.location.pathname) {
          progressBar.classList.add("loading");
        }
      }
    };

    document.addEventListener("click", handleClick);

    return () => {
      document.removeEventListener("click", handleClick);
      style.remove();
      progressBar.remove();
    };
  }, []);

  return (
    <Suspense fallback={null}>
      <NProgressBar />
    </Suspense>
  );
}
