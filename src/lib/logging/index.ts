/**
 * Logging Module Exports
 */

export {
  logger,
  createRequestLogger,
  logTiming,
  startTimer,
  logRequest,
  logResponse,
} from "./logger";

// Re-export default
import { logger as defaultLogger } from "./logger";
export default defaultLogger;

