/**
 * Create a pre-confirmed test user for E2E testing
 * 
 * Usage:
 *   npx tsx scripts/create-test-user.ts
 * 
 * This script creates a user with email_confirm set to true,
 * bypassing the email confirmation requirement.
 * 
 * Requires SUPABASE_SERVICE_ROLE_KEY environment variable.
 */

import { config } from "dotenv";
import { createClient } from "@supabase/supabase-js";

// Load environment variables from .env.local
config({ path: ".env.local" });

async function createTestUser() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!supabaseUrl || !serviceRoleKey) {
    console.error("Missing required environment variables:");
    console.error("- NEXT_PUBLIC_SUPABASE_URL:", supabaseUrl ? "OK" : "MISSING");
    console.error("- SUPABASE_SERVICE_ROLE_KEY:", serviceRoleKey ? "OK" : "MISSING");
    console.error("\nMake sure these are set in your .env.local file");
    process.exit(1);
  }

  // Create admin client with service role key
  const supabase = createClient(supabaseUrl, serviceRoleKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
  });

  // Generate unique test user credentials
  const timestamp = Date.now();
  const email = `e2e-test-${timestamp}@test.tutorio.ch`;
  const password = "E2ETestPass123!";
  const fullName = "E2E Test User";

  console.log("\n🧪 Creating E2E Test User...\n");

  try {
    // Create user with admin API (email_confirm: true skips email verification)
    const { data: userData, error: createError } = await supabase.auth.admin.createUser({
      email,
      password,
      email_confirm: true, // Skip email confirmation
      user_metadata: {
        full_name: fullName,
      },
    });

    if (createError) {
      console.error("❌ Failed to create user:", createError.message);
      process.exit(1);
    }

    console.log("✅ Test user created successfully!\n");
    console.log("═".repeat(50));
    console.log("📧 Email:    ", email);
    console.log("🔑 Password: ", password);
    console.log("👤 Name:     ", fullName);
    console.log("🆔 User ID:  ", userData.user?.id);
    console.log("═".repeat(50));
    console.log("\n📋 Copy these credentials for your E2E testing.\n");
    console.log("🌐 Login at: http://localhost:3000/login\n");

    // Verify the user was created with a confirmed email
    if (userData.user?.email_confirmed_at) {
      console.log("✅ Email confirmed at:", userData.user.email_confirmed_at);
    } else {
      console.log("⚠️  Note: Email may need manual confirmation in Supabase dashboard");
    }

  } catch (err) {
    console.error("❌ Unexpected error:", err);
    process.exit(1);
  }
}

createTestUser();

