/**
 * Structured Logging Module
 * 
 * Provides consistent, structured logging across the application.
 * In development, logs are formatted for readability.
 * In production, logs are JSON for easy parsing.
 */

type LogLevel = "debug" | "info" | "warn" | "error";

interface LogContext {
  [key: string]: unknown;
}

interface LogEntry {
  level: LogLevel;
  message: string;
  timestamp: string;
  context?: LogContext;
  error?: {
    name: string;
    message: string;
    stack?: string;
  };
}

/**
 * Current log level - configurable via environment
 */
const LOG_LEVEL: LogLevel = (process.env.LOG_LEVEL as LogLevel) || "info";

/**
 * Log level hierarchy for filtering
 */
const LOG_LEVELS: Record<LogLevel, number> = {
  debug: 0,
  info: 1,
  warn: 2,
  error: 3,
};

/**
 * Sensitive keys that should be redacted from logs
 */
const SENSITIVE_KEYS = [
  "password",
  "token",
  "secret",
  "authorization",
  "cookie",
  "apikey",
  "api_key",
  "access_token",
  "refresh_token",
  "private_key",
  "credit_card",
  "card_number",
  "cvv",
  "ssn",
  "social_security",
];

/**
 * Sanitize context to redact sensitive data
 */
function sanitizeContext(context: LogContext): LogContext {
  const sanitized: LogContext = {};
  
  for (const [key, value] of Object.entries(context)) {
    const lowerKey = key.toLowerCase();
    
    // Check if key contains any sensitive keywords
    if (SENSITIVE_KEYS.some((sensitive) => lowerKey.includes(sensitive))) {
      sanitized[key] = "[REDACTED]";
    } else if (typeof value === "object" && value !== null && !Array.isArray(value)) {
      // Recursively sanitize nested objects
      sanitized[key] = sanitizeContext(value as LogContext);
    } else if (Array.isArray(value)) {
      // Handle arrays
      sanitized[key] = value.map((item) =>
        typeof item === "object" && item !== null
          ? sanitizeContext(item as LogContext)
          : item
      );
    } else {
      sanitized[key] = value;
    }
  }
  
  return sanitized;
}

/**
 * Check if a log level should be output
 */
function shouldLog(level: LogLevel): boolean {
  return LOG_LEVELS[level] >= LOG_LEVELS[LOG_LEVEL];
}

/**
 * Format log entry for output
 */
function formatLogEntry(entry: LogEntry): string {
  if (process.env.NODE_ENV === "production") {
    // JSON format for production (easier to parse)
    return JSON.stringify(entry);
  }
  
  // Human-readable format for development
  const { level, message, timestamp, context, error } = entry;
  const levelColors: Record<LogLevel, string> = {
    debug: "\x1b[90m", // Gray
    info: "\x1b[36m",  // Cyan
    warn: "\x1b[33m",  // Yellow
    error: "\x1b[31m", // Red
  };
  const reset = "\x1b[0m";
  const color = levelColors[level];
  
  let output = `${color}[${level.toUpperCase()}]${reset} ${timestamp} - ${message}`;
  
  if (context && Object.keys(context).length > 0) {
    output += `\n  Context: ${JSON.stringify(context, null, 2).split('\n').join('\n  ')}`;
  }
  
  if (error) {
    output += `\n  Error: ${error.name}: ${error.message}`;
    if (error.stack) {
      output += `\n  Stack: ${error.stack.split('\n').slice(1, 4).join('\n        ')}`;
    }
  }
  
  return output;
}

/**
 * Output a log entry
 */
function log(level: LogLevel, message: string, context?: LogContext, error?: Error): void {
  if (!shouldLog(level)) return;
  
  const entry: LogEntry = {
    level,
    message,
    timestamp: new Date().toISOString(),
  };
  
  if (context && Object.keys(context).length > 0) {
    // Sanitize context to prevent sensitive data exposure
    entry.context = sanitizeContext(context);
  }
  
  if (error) {
    entry.error = {
      name: error.name,
      message: error.message,
      stack: error.stack,
    };
  }
  
  const formatted = formatLogEntry(entry);
  
  switch (level) {
    case "error":
      console.error(formatted);
      break;
    case "warn":
      console.warn(formatted);
      break;
    default:
      console.log(formatted);
  }
}

/**
 * Logger interface
 */
export const logger = {
  /**
   * Debug level - verbose information for debugging
   */
  debug(message: string, context?: LogContext): void {
    log("debug", message, context);
  },
  
  /**
   * Info level - general information about application flow
   */
  info(message: string, context?: LogContext): void {
    log("info", message, context);
  },
  
  /**
   * Warn level - potential issues that don't stop execution
   */
  warn(message: string, context?: LogContext): void {
    log("warn", message, context);
  },
  
  /**
   * Error level - errors that need attention
   */
  error(message: string, error?: Error | unknown, context?: LogContext): void {
    const err = error instanceof Error ? error : undefined;
    if (error && !(error instanceof Error)) {
      context = { ...context, errorValue: error };
    }
    log("error", message, context, err);
  },
  
  /**
   * Create a child logger with preset context
   */
  child(defaultContext: LogContext) {
    return {
      debug: (message: string, context?: LogContext) => 
        log("debug", message, { ...defaultContext, ...context }),
      info: (message: string, context?: LogContext) => 
        log("info", message, { ...defaultContext, ...context }),
      warn: (message: string, context?: LogContext) => 
        log("warn", message, { ...defaultContext, ...context }),
      error: (message: string, error?: Error | unknown, context?: LogContext) => {
        const err = error instanceof Error ? error : undefined;
        if (error && !(error instanceof Error)) {
          context = { ...context, errorValue: error };
        }
        log("error", message, { ...defaultContext, ...context }, err);
      },
    };
  },
};

/**
 * Create a request-scoped logger
 */
export function createRequestLogger(requestId?: string) {
  return logger.child({
    requestId: requestId || crypto.randomUUID(),
  });
}

/**
 * Log performance timing
 */
export function logTiming(
  operation: string,
  startTime: number,
  context?: LogContext
): void {
  const duration = Date.now() - startTime;
  logger.info(`${operation} completed`, { ...context, durationMs: duration });
}

/**
 * Performance timer helper
 */
export function startTimer() {
  const startTime = Date.now();
  return {
    elapsed: () => Date.now() - startTime,
    log: (operation: string, context?: LogContext) => 
      logTiming(operation, startTime, context),
  };
}

/**
 * Log an API request
 */
export function logRequest(
  method: string,
  path: string,
  userId?: string,
  context?: LogContext
): void {
  logger.info(`${method} ${path}`, {
    ...context,
    method,
    path,
    userId: userId || "anonymous",
  });
}

/**
 * Log an API response
 */
export function logResponse(
  method: string,
  path: string,
  statusCode: number,
  durationMs: number,
  context?: LogContext
): void {
  const level: LogLevel = statusCode >= 500 ? "error" : statusCode >= 400 ? "warn" : "info";
  log(level, `${method} ${path} -> ${statusCode}`, {
    ...context,
    method,
    path,
    statusCode,
    durationMs,
  });
}

export default logger;
