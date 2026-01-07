/**
 * Email utility functions
 */

/**
 * Format a currency amount for display in emails
 */
export function formatCurrency(amountInCents: number, currency: string = "usd"): string {
  const amount = amountInCents / 100;
  
  const formatter = new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: currency.toUpperCase(),
    minimumFractionDigits: 0,
    maximumFractionDigits: 2,
  });
  
  return formatter.format(amount);
}

/**
 * Format a date for display in emails
 */
export function formatEmailDate(date: Date | string | number): string {
  const d = typeof date === "string" || typeof date === "number" 
    ? new Date(typeof date === "number" && date < 10000000000 ? date * 1000 : date)
    : date;
  
  return d.toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}

