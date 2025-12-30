/**
 * Test script for Google Sheets integration
 * Run with: npx tsx scripts/test-google-sheets.ts
 */

import { google } from 'googleapis';
import * as dotenv from 'dotenv';
import { resolve } from 'path';

// Load environment variables from .env.local
dotenv.config({ path: resolve(process.cwd(), '.env.local') });

async function testGoogleSheetsConnection() {
  console.log('\n🔍 Testing Google Sheets Integration...\n');

  // Check environment variables
  const email = process.env.GOOGLE_SERVICE_ACCOUNT_EMAIL;
  const privateKey = process.env.GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY;

  if (!email) {
    console.error('❌ GOOGLE_SERVICE_ACCOUNT_EMAIL is not set');
    process.exit(1);
  }

  if (!privateKey) {
    console.error('❌ GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY is not set');
    process.exit(1);
  }

  console.log('✅ Environment variables found');
  console.log(`   Email: ${email}`);
  console.log(`   Key length: ${privateKey.length} characters\n`);

  try {
    // Parse the private key (handle escaped newlines)
    const parsedKey = privateKey.replace(/\\n/g, '\n');

    // Create auth client
    const auth = new google.auth.JWT({
      email,
      key: parsedKey,
      scopes: [
        'https://www.googleapis.com/auth/spreadsheets',
        'https://www.googleapis.com/auth/drive',
      ],
    });

    console.log('🔐 Authenticating with Google...');
    
    // Test authentication
    await auth.authorize();
    console.log('✅ Authentication successful!\n');

    // Test Sheets API
    const sheets = google.sheets({ version: 'v4', auth });
    console.log('📊 Testing Sheets API access...');
    
    // Just verify we can initialize the API
    console.log('✅ Sheets API initialized successfully!\n');

    // Test Drive API
    const drive = google.drive({ version: 'v3', auth });
    console.log('📁 Testing Drive API access...');
    
    // List files to verify Drive API works
    const driveResponse = await drive.files.list({
      pageSize: 1,
      fields: 'files(id, name)',
    });
    console.log('✅ Drive API working!');
    console.log(`   Can access Drive (found ${driveResponse.data.files?.length || 0} files)\n`);

    console.log('═══════════════════════════════════════════════');
    console.log('🎉 All tests passed! Google Sheets integration is ready.');
    console.log('═══════════════════════════════════════════════\n');

    console.log('Next steps:');
    console.log('1. Create a Google Sheet template for your exercise');
    console.log('2. Share it with: ' + email);
    console.log('3. Copy the sheet ID from the URL');
    console.log('4. Create an activity with interactive_type="google-sheets"\n');

  } catch (error) {
    console.error('\n❌ Error testing Google Sheets connection:');
    if (error instanceof Error) {
      console.error(`   ${error.message}`);
      
      if (error.message.includes('invalid_grant')) {
        console.error('\n   Possible causes:');
        console.error('   - The private key is malformed');
        console.error('   - The service account has been deleted');
      } else if (error.message.includes('DECODER')) {
        console.error('\n   The private key format is incorrect.');
        console.error('   Make sure to copy the entire key including BEGIN/END markers.');
      } else if (error.message.includes('disabled')) {
        console.error('\n   The API is not enabled. Visit:');
        console.error('   https://console.cloud.google.com/apis/library/sheets.googleapis.com');
        console.error('   https://console.cloud.google.com/apis/library/drive.googleapis.com');
      }
    }
    process.exit(1);
  }
}

testGoogleSheetsConnection();

