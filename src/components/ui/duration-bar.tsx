interface DurationBarProps {
  /** Current duration in hours */
  duration: number;
  /** Maximum duration for calculating the percentage (optional, defaults to 20h) */
  maxDuration?: number;
  /** Whether to show the label (e.g., "12h") */
  showLabel?: boolean;
  /** Size variant */
  size?: "sm" | "md" | "lg";
}

export function DurationBar({ 
  duration, 
  maxDuration = 20, 
  showLabel = true,
  size = "md" 
}: DurationBarProps) {
  const percentage = Math.min((duration / maxDuration) * 100, 100);
  
  const sizeClasses = {
    sm: {
      track: "h-1",
      label: "text-xs",
    },
    md: {
      track: "h-1.5",
      label: "text-sm",
    },
    lg: {
      track: "h-2",
      label: "text-base",
    },
  };

  const classes = sizeClasses[size];

  return (
    <div className="flex items-center gap-3">
      <div className={`flex-1 ${classes.track} bg-[var(--progress-bg)] rounded-full overflow-hidden`}>
        <div 
          className="h-full bg-[var(--primary)] rounded-full transition-all duration-500 ease-out"
          style={{ width: `${percentage}%` }}
        />
      </div>
      {showLabel && (
        <span className={`${classes.label} font-medium text-[var(--foreground)] whitespace-nowrap min-w-[3rem] text-right`}>
          {duration}h
        </span>
      )}
    </div>
  );
}

interface ProgressBarProps {
  /** Current progress percentage (0-100) */
  progress: number;
  /** Whether to show the percentage label */
  showLabel?: boolean;
  /** Size variant */
  size?: "sm" | "md" | "lg";
}

export function ProgressBar({ 
  progress, 
  showLabel = true,
  size = "md" 
}: ProgressBarProps) {
  const clampedProgress = Math.min(Math.max(progress, 0), 100);
  
  const sizeClasses = {
    sm: {
      track: "h-1",
      label: "text-xs",
    },
    md: {
      track: "h-2",
      label: "text-sm",
    },
    lg: {
      track: "h-3",
      label: "text-base",
    },
  };

  const classes = sizeClasses[size];

  return (
    <div className="w-full">
      {showLabel && (
        <div className="flex justify-between text-xs text-[var(--foreground-muted)] mb-1">
          <span>Progress</span>
          <span>{Math.round(clampedProgress)}%</span>
        </div>
      )}
      <div className={`w-full ${classes.track} bg-[var(--progress-bg)] rounded-full overflow-hidden`}>
        <div 
          className="h-full bg-gradient-to-r from-[var(--primary)] to-[var(--primary-light)] rounded-full transition-all duration-500 ease-out"
          style={{ width: `${clampedProgress}%` }}
        />
      </div>
    </div>
  );
}

