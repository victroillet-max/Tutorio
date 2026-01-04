/**
 * Quick script to check activity content format
 * Run: npx ts-node scripts/check_activity.ts
 */

import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
  console.error('Missing environment variables. Run with:');
  console.error('source .env.local && npx ts-node scripts/check_activity.ts');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

async function main() {
  console.log('\n🔍 Checking FA interactive activities...\n');
  
  // Get all FA course interactive activities
  const { data: activities, error } = await supabase
    .from('activities')
    .select(`
      id,
      slug,
      title,
      type,
      interactive_type,
      content,
      modules!inner (
        course_id
      )
    `)
    .eq('type', 'interactive')
    .eq('modules.course_id', 'c0000000-0000-0000-0000-000000000002');
  
  if (error) {
    console.error('Error:', error);
    return;
  }
  
  console.log(`Found ${activities?.length || 0} interactive activities\n`);
  
  for (const activity of activities || []) {
    const content = activity.content as Record<string, unknown> | null;
    
    console.log(`\n📋 ${activity.title}`);
    console.log(`   Slug: ${activity.slug}`);
    console.log(`   Interactive Type: ${activity.interactive_type}`);
    
    if (content) {
      const keys = Object.keys(content);
      console.log(`   Content Keys: ${keys.join(', ')}`);
      
      // Check for specific arrays
      if (Array.isArray(content.scenarios)) {
        console.log(`   ✅ Has 'scenarios' array (${content.scenarios.length} items)`);
      }
      if (Array.isArray(content.questions)) {
        console.log(`   ✅ Has 'questions' array (${content.questions.length} items)`);
        // Check format of first question
        const firstQ = content.questions[0] as Record<string, unknown>;
        if (firstQ) {
          console.log(`      First Q format: ${Object.keys(firstQ).join(', ')}`);
        }
      }
      if (Array.isArray(content.transactions)) {
        console.log(`   ✅ Has 'transactions' array (${content.transactions.length} items)`);
      }
      if (Array.isArray(content.account_options)) {
        console.log(`   ✅ Has 'account_options' array (${content.account_options.length} items)`);
      }
    } else {
      console.log(`   ❌ Content is NULL`);
    }
    
    // Diagnose expected vs actual
    const interactiveType = activity.interactive_type as string;
    let isValid = false;
    let issue = '';
    
    switch (interactiveType) {
      case 'equation-analyzer':
        if (content?.scenarios || content?.questions) {
          isValid = true;
        } else {
          issue = 'Missing both scenarios and questions arrays';
        }
        break;
      case 'journal-entry-builder':
        if (content?.transactions && content?.account_options) {
          isValid = true;
        } else {
          issue = 'Missing transactions or account_options';
        }
        break;
      case 'filter-essential':
        if (content?.scenarios) {
          isValid = true;
        } else {
          issue = 'Missing scenarios array';
        }
        break;
      case 'timed-classification':
        if (content?.scenarios) {
          isValid = true;
        } else {
          issue = 'Missing scenarios array';
        }
        break;
      case 'review-calculator':
        if (content?.questions) {
          isValid = true;
        } else {
          issue = 'Missing questions array';
        }
        break;
      default:
        isValid = true; // Unknown types pass through
    }
    
    if (isValid) {
      console.log(`   ✅ Content format matches component expectations`);
    } else {
      console.log(`   ⚠️  ISSUE: ${issue}`);
    }
  }
  
  console.log('\n✨ Done!\n');
}

main().catch(console.error);
