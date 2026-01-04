"use client";

import React, { Component, ErrorInfo, ReactNode } from "react";
import { AlertTriangle, RefreshCcw, Bug, ChevronDown, ChevronUp } from "lucide-react";

interface Props {
  children: ReactNode;
  interactiveType?: string | null;
  fallbackTitle?: string;
}

interface State {
  hasError: boolean;
  error: Error | null;
  errorInfo: ErrorInfo | null;
  showDetails: boolean;
}

/**
 * Error Boundary for Interactive Components
 * 
 * Catches JavaScript errors in interactive components and displays
 * a user-friendly fallback UI instead of crashing the whole page.
 */
export class InteractiveErrorBoundary extends Component<Props, State> {
  public state: State = {
    hasError: false,
    error: null,
    errorInfo: null,
    showDetails: false,
  };

  public static getDerivedStateFromError(error: Error): Partial<State> {
    return { hasError: true, error };
  }

  public componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error("Interactive component error:", error, errorInfo);
    this.setState({ errorInfo });
    
    // Log to external service in production
    if (process.env.NODE_ENV === "production") {
      // Could integrate with error tracking service here
      console.error("[InteractiveError]", {
        interactiveType: this.props.interactiveType,
        error: error.message,
        stack: error.stack,
        componentStack: errorInfo.componentStack,
      });
    }
  }

  private handleRetry = () => {
    this.setState({
      hasError: false,
      error: null,
      errorInfo: null,
      showDetails: false,
    });
  };

  private toggleDetails = () => {
    this.setState(prev => ({ showDetails: !prev.showDetails }));
  };

  public render() {
    if (this.state.hasError) {
      const { interactiveType, fallbackTitle } = this.props;
      const { error, errorInfo, showDetails } = this.state;

      return (
        <div className="bg-amber-50 border border-amber-200 rounded-xl p-6">
          <div className="flex items-start gap-4">
            <div className="w-12 h-12 bg-amber-100 rounded-full flex items-center justify-center flex-shrink-0">
              <AlertTriangle className="w-6 h-6 text-amber-600" />
            </div>
            
            <div className="flex-1">
              <h3 className="text-lg font-semibold text-amber-800 mb-1">
                {fallbackTitle || "Something went wrong"}
              </h3>
              <p className="text-amber-700 text-sm mb-4">
                We encountered an issue loading this interactive exercise
                {interactiveType && ` (${interactiveType})`}.
                This might be due to a content format issue.
              </p>
              
              <div className="flex flex-wrap gap-3 mb-4">
                <button
                  onClick={this.handleRetry}
                  className="flex items-center gap-2 px-4 py-2 bg-amber-600 text-white text-sm font-medium rounded-lg hover:bg-amber-700 transition-colors"
                >
                  <RefreshCcw className="w-4 h-4" />
                  Try Again
                </button>
                
                <button
                  onClick={this.toggleDetails}
                  className="flex items-center gap-2 px-4 py-2 bg-amber-100 text-amber-800 text-sm font-medium rounded-lg hover:bg-amber-200 transition-colors"
                >
                  <Bug className="w-4 h-4" />
                  {showDetails ? "Hide" : "Show"} Details
                  {showDetails ? (
                    <ChevronUp className="w-4 h-4" />
                  ) : (
                    <ChevronDown className="w-4 h-4" />
                  )}
                </button>
              </div>
              
              {showDetails && (
                <div className="bg-amber-100/50 rounded-lg p-4 text-xs font-mono overflow-auto max-h-48">
                  <p className="text-amber-800 font-semibold mb-2">
                    Error: {error?.message || "Unknown error"}
                  </p>
                  {error?.stack && (
                    <pre className="text-amber-700 whitespace-pre-wrap break-words">
                      {error.stack.split("\n").slice(0, 5).join("\n")}
                    </pre>
                  )}
                  {errorInfo?.componentStack && (
                    <details className="mt-2">
                      <summary className="text-amber-600 cursor-pointer">Component Stack</summary>
                      <pre className="text-amber-700 whitespace-pre-wrap break-words mt-1">
                        {errorInfo.componentStack.split("\n").slice(0, 5).join("\n")}
                      </pre>
                    </details>
                  )}
                </div>
              )}
              
              <p className="text-amber-600 text-xs mt-3">
                You can still mark this exercise as complete using the button below.
              </p>
            </div>
          </div>
        </div>
      );
    }

    return this.props.children;
  }
}

/**
 * Hook-based wrapper for functional component error catching
 * (uses the class-based ErrorBoundary internally)
 */
export function withInteractiveErrorBoundary<P extends object>(
  WrappedComponent: React.ComponentType<P>,
  interactiveType?: string
) {
  const ComponentWithErrorBoundary = (props: P) => (
    <InteractiveErrorBoundary interactiveType={interactiveType}>
      <WrappedComponent {...props} />
    </InteractiveErrorBoundary>
  );
  
  ComponentWithErrorBoundary.displayName = `WithErrorBoundary(${WrappedComponent.displayName || WrappedComponent.name || "Component"})`;
  
  return ComponentWithErrorBoundary;
}


