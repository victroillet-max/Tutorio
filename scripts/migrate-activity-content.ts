/**
 * Activity Content Migration Script
 * 
 * This script helps migrate activity content from one format to another.
 * It can be used to fix content format mismatches identified during testing.
 * 
 * Usage:
 *   npx ts-node scripts/migrate-activity-content.ts --analyze [--slug <activity-slug>]
 *   npx ts-node scripts/migrate-activity-content.ts --migrate --slug <activity-slug> --type <target-type>
 *   npx ts-node scripts/migrate-activity-content.ts --fix-all --dry-run
 * 
 * Options:
 *   --analyze        Analyze activities for content format issues
 *   --slug           Target a specific activity by slug
 *   --type           Target interactive type to analyze
 *   --migrate        Migrate content to correct format
 *   --fix-all        Attempt to fix all detected issues
 *   --dry-run        Show what would be changed without making changes
 */

import { createClient } from '@supabase/supabase-js';
import { 
  validateActivityContent, 
  diagnoseContentIssues,
  formatContentValidationErrors 
} from '../src/lib/validation/activity-content-schemas';

// Load environment variables
const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
  console.error('Missing required environment variables:');
  console.error('  NEXT_PUBLIC_SUPABASE_URL');
  console.error('  SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

interface Activity {
  id: string;
  slug: string;
  title: string;
  type: string;
  interactive_type: string | null;
  content: Record<string, unknown> | null;
}

interface ContentIssue {
  activity: Activity;
  issues: string[];
  suggestions: string[];
  hasQuizFormat: boolean;
  hasExpectedFormat: boolean;
}

/**
 * Analyze all activities for content format issues
 */
async function analyzeActivities(options: { 
  slug?: string; 
  interactiveType?: string;
  verbose?: boolean;
}): Promise<ContentIssue[]> {
  console.log('\n📊 Analyzing activity content...\n');
  
  let query = supabase
    .from('activities')
    .select('id, slug, title, type, interactive_type, content')
    .eq('is_published', true);
  
  if (options.slug) {
    query = query.eq('slug', options.slug);
  }
  
  if (options.interactiveType) {
    query = query.eq('interactive_type', options.interactiveType);
  }
  
  const { data: activities, error } = await query;
  
  if (error) {
    console.error('Error fetching activities:', error);
    process.exit(1);
  }
  
  if (!activities || activities.length === 0) {
    console.log('No activities found matching criteria.');
    return [];
  }
  
  console.log(`Found ${activities.length} activities to analyze.\n`);
  
  const issues: ContentIssue[] = [];
  let validCount = 0;
  let invalidCount = 0;
  
  for (const activity of activities) {
    const validation = validateActivityContent(
      activity.type,
      activity.interactive_type,
      activity.content
    );
    
    if (validation.valid) {
      validCount++;
      if (options.verbose) {
        console.log(`✅ ${activity.slug} (${activity.interactive_type || activity.type})`);
      }
    } else {
      invalidCount++;
      const diagnosis = diagnoseContentIssues(
        activity.interactive_type || '',
        activity.content as Record<string, unknown> | null
      );
      
      issues.push({
        activity: activity as Activity,
        issues: diagnosis.issues,
        suggestions: diagnosis.suggestions,
        hasQuizFormat: diagnosis.hasQuizFormat,
        hasExpectedFormat: diagnosis.hasExpectedFormat,
      });
      
      console.log(`❌ ${activity.slug} (${activity.interactive_type || activity.type})`);
      diagnosis.issues.forEach(issue => console.log(`   - ${issue}`));
    }
  }
  
  console.log(`\n📈 Summary:`);
  console.log(`   Valid: ${validCount}`);
  console.log(`   Invalid: ${invalidCount}`);
  console.log(`   Total: ${activities.length}`);
  
  return issues;
}

/**
 * Convert quiz-format content to equation-analyzer format
 */
function convertQuizToEquationAnalyzer(
  content: Record<string, unknown>
): Record<string, unknown> {
  const questions = content.questions as Array<{
    id: string;
    question: string;
    explanation?: string;
  }>;
  
  if (!questions || !Array.isArray(questions)) {
    return content;
  }
  
  // Attempt to convert questions to scenarios
  // This is a best-effort conversion - manual review recommended
  const scenarios = questions.map((q, idx) => ({
    id: q.id || `scenario-${idx + 1}`,
    description: q.question,
    effects: {
      assets: 0,
      liabilities: 0,
      equity: 0,
    },
    explanation: q.explanation || 'Please update this explanation',
  }));
  
  return {
    ...content,
    scenarios,
    _migration_note: 'Auto-converted from quiz format. Please review and update effects values.',
  };
}

/**
 * Convert quiz-format content to journal-entry-builder format
 */
function convertQuizToJournalEntryBuilder(
  content: Record<string, unknown>
): Record<string, unknown> {
  const questions = content.questions as Array<{
    id: string;
    question: string;
    explanation?: string;
  }>;
  
  if (!questions || !Array.isArray(questions)) {
    return content;
  }
  
  // Common account options for journal entries
  const defaultAccounts = [
    'Cash',
    'Accounts Receivable',
    'Inventory',
    'Prepaid Expenses',
    'Equipment',
    'Accumulated Depreciation',
    'Accounts Payable',
    'Unearned Revenue',
    'Notes Payable',
    'Common Stock',
    'Retained Earnings',
    'Revenue',
    'Cost of Goods Sold',
    'Salaries Expense',
    'Rent Expense',
    'Depreciation Expense',
  ];
  
  const transactions = questions.map((q, idx) => ({
    id: q.id || `transaction-${idx + 1}`,
    description: q.question,
    solution: [
      { account: 'Please select', debit: 0 },
      { account: 'Please select', credit: 0 },
    ],
    explanation: q.explanation || 'Please update this explanation',
  }));
  
  return {
    ...content,
    account_options: defaultAccounts,
    transactions,
    _migration_note: 'Auto-converted from quiz format. Please review and update solutions.',
  };
}

/**
 * Migrate a single activity's content
 */
async function migrateActivity(
  activity: Activity,
  dryRun: boolean = true
): Promise<boolean> {
  console.log(`\n🔄 Migrating: ${activity.slug}`);
  
  if (!activity.content) {
    console.log('   ⚠️ No content to migrate');
    return false;
  }
  
  let newContent: Record<string, unknown> | null = null;
  
  switch (activity.interactive_type) {
    case 'equation-analyzer':
      newContent = convertQuizToEquationAnalyzer(activity.content);
      break;
    case 'journal-entry-builder':
      newContent = convertQuizToJournalEntryBuilder(activity.content);
      break;
    default:
      console.log(`   ⚠️ No migration path for ${activity.interactive_type}`);
      return false;
  }
  
  if (!newContent) {
    return false;
  }
  
  console.log('   📝 New content structure:');
  console.log(JSON.stringify(newContent, null, 2).split('\n').slice(0, 10).join('\n'));
  console.log('   ...');
  
  if (dryRun) {
    console.log('   🔍 DRY RUN - No changes made');
    return true;
  }
  
  const { error } = await supabase
    .from('activities')
    .update({ content: newContent })
    .eq('id', activity.id);
  
  if (error) {
    console.error(`   ❌ Error updating activity: ${error.message}`);
    return false;
  }
  
  console.log('   ✅ Activity updated successfully');
  return true;
}

/**
 * Generate SQL migration for fixing content issues
 */
function generateSQLMigration(issues: ContentIssue[]): string {
  const lines: string[] = [
    '-- Activity Content Migration',
    `-- Generated: ${new Date().toISOString()}`,
    '-- Review each UPDATE carefully before executing',
    '',
  ];
  
  for (const issue of issues) {
    lines.push(`-- Activity: ${issue.activity.slug}`);
    lines.push(`-- Type: ${issue.activity.interactive_type}`);
    lines.push(`-- Issues: ${issue.issues.join(', ')}`);
    lines.push(`-- Suggestions: ${issue.suggestions.join(', ')}`);
    lines.push('-- TODO: Add UPDATE statement here');
    lines.push('');
  }
  
  return lines.join('\n');
}

/**
 * Main function
 */
async function main() {
  const args = process.argv.slice(2);
  
  const hasAnalyze = args.includes('--analyze');
  const hasMigrate = args.includes('--migrate');
  const hasFixAll = args.includes('--fix-all');
  const dryRun = args.includes('--dry-run');
  const verbose = args.includes('--verbose');
  
  const slugIndex = args.indexOf('--slug');
  const slug = slugIndex !== -1 ? args[slugIndex + 1] : undefined;
  
  const typeIndex = args.indexOf('--type');
  const interactiveType = typeIndex !== -1 ? args[typeIndex + 1] : undefined;
  
  if (!hasAnalyze && !hasMigrate && !hasFixAll) {
    console.log(`
Activity Content Migration Script

Usage:
  npx ts-node scripts/migrate-activity-content.ts --analyze [--slug <activity-slug>] [--type <interactive-type>]
  npx ts-node scripts/migrate-activity-content.ts --migrate --slug <activity-slug>
  npx ts-node scripts/migrate-activity-content.ts --fix-all [--dry-run]

Options:
  --analyze     Analyze activities for content format issues
  --slug        Target a specific activity by slug
  --type        Target interactive type to analyze (e.g., equation-analyzer)
  --migrate     Migrate content to correct format
  --fix-all     Attempt to fix all detected issues
  --dry-run     Show what would be changed without making changes
  --verbose     Show all activities, including valid ones
`);
    process.exit(0);
  }
  
  if (hasAnalyze) {
    const issues = await analyzeActivities({ slug, interactiveType, verbose });
    
    if (issues.length > 0) {
      console.log('\n📋 Detailed Issues:\n');
      for (const issue of issues) {
        console.log(`\n${issue.activity.title} (${issue.activity.slug})`);
        console.log(`   Type: ${issue.activity.interactive_type}`);
        console.log(`   Has Quiz Format: ${issue.hasQuizFormat ? 'Yes' : 'No'}`);
        console.log(`   Has Expected Format: ${issue.hasExpectedFormat ? 'Yes' : 'No'}`);
        
        if (issue.suggestions.length > 0) {
          console.log('   Suggestions:');
          issue.suggestions.forEach(s => console.log(`     - ${s}`));
        }
      }
      
      // Generate SQL template
      console.log('\n📄 SQL Migration Template:');
      console.log(generateSQLMigration(issues));
    }
  }
  
  if (hasMigrate && slug) {
    const issues = await analyzeActivities({ slug });
    
    if (issues.length > 0) {
      await migrateActivity(issues[0].activity, dryRun);
    } else {
      console.log('Activity content is already valid or not found.');
    }
  }
  
  if (hasFixAll) {
    const issues = await analyzeActivities({});
    
    console.log(`\n🔧 Fixing ${issues.length} activities...`);
    
    let fixed = 0;
    let failed = 0;
    
    for (const issue of issues) {
      const success = await migrateActivity(issue.activity, dryRun);
      if (success) {
        fixed++;
      } else {
        failed++;
      }
    }
    
    console.log(`\n📊 Results:`);
    console.log(`   Fixed: ${fixed}`);
    console.log(`   Failed: ${failed}`);
  }
}

main().catch(console.error);


