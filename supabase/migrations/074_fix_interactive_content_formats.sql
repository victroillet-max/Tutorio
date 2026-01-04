-- ============================================
-- Fix Interactive Activity Content Formats
-- ============================================
-- This migration fixes content format mismatches in interactive activities
-- so that components can properly render them.
--
-- Issues fixed:
-- 1. transaction-impact-practice: Has 'items' array instead of 'scenarios' or 'questions'
-- 2. journal-entry-practice: Missing 'account_options', has quiz-style content
-- 3. cash-flow-classification-challenge: Has 'transactions' instead of 'scenarios'
-- ============================================

-- ============================================
-- Fix 1: transaction-impact-practice
-- Direct update with proper scenarios format for equation-analyzer component
-- ============================================

UPDATE activities
SET content = '{
  "title": "Analyze Transaction Impacts",
  "description": "For each transaction, identify how it affects the accounting equation.",
  "instructions": "Determine whether each element (Assets, Liabilities, Equity) increases (+1), decreases (-1), or stays the same (0).",
  "company_background": "Phantom Studios Inc. is a new entertainment company. Analyze how each transaction affects the accounting equation.",
  "passing_score": 80,
  "scenarios": [
    {
      "description": "Owners invest CHF 100,000 cash to start the business",
      "effects": {"assets": 1, "liabilities": 0, "equity": 1},
      "explanation": "Cash (Asset) +100,000. Share Capital (Equity) +100,000. The equation remains balanced."
    },
    {
      "description": "Borrow CHF 50,000 from the bank",
      "effects": {"assets": 1, "liabilities": 1, "equity": 0},
      "explanation": "Cash (Asset) +50,000. Bank Loan (Liability) +50,000. Equity is unchanged."
    },
    {
      "description": "Purchase film equipment for CHF 80,000 cash",
      "effects": {"assets": 0, "liabilities": 0, "equity": 0},
      "explanation": "Cash -80,000, Equipment +80,000. Total Assets unchanged. This is an exchange of assets."
    },
    {
      "description": "Receive CHF 25,000 cash for film production services",
      "effects": {"assets": 1, "liabilities": 0, "equity": 1},
      "explanation": "Cash (Asset) +25,000. Revenue increases Retained Earnings (Equity) +25,000."
    },
    {
      "description": "Pay CHF 10,000 cash for office rent",
      "effects": {"assets": -1, "liabilities": 0, "equity": -1},
      "explanation": "Cash (Asset) -10,000. Rent Expense reduces Retained Earnings (Equity) -10,000."
    },
    {
      "description": "Purchase supplies on credit for CHF 5,000",
      "effects": {"assets": 1, "liabilities": 1, "equity": 0},
      "explanation": "Supplies (Asset) +5,000. Accounts Payable (Liability) +5,000. Equity unchanged."
    }
  ]
}'::jsonb
WHERE slug = 'transaction-impact-practice';

-- ============================================
-- Fix 2: journal-entry-practice
-- Add account_options for completeness (quiz mode doesn't require it but full mode does)
-- ============================================

UPDATE activities
SET content = content || '{
  "account_options": [
    "Cash",
    "Accounts Receivable",
    "Prepaid Insurance",
    "Supplies",
    "Office Equipment",
    "Accumulated Depreciation",
    "Accounts Payable",
    "Unearned Revenue",
    "Notes Payable",
    "Common Stock",
    "Retained Earnings",
    "Service Revenue",
    "Salaries Expense",
    "Rent Expense",
    "Insurance Expense",
    "Depreciation Expense",
    "Supplies Expense",
    "Utilities Expense"
  ]
}'::jsonb
WHERE slug = 'journal-entry-practice'
  AND NOT (content ? 'account_options');

-- ============================================
-- Fix 3: cash-flow-classification-challenge
-- Convert 'transactions' to 'scenarios' format for timed-classification
-- ============================================

UPDATE activities
SET content = '{
  "instructions": "Classify each transaction into the correct cash flow category. Select the correct category for each item.",
  "passing_score": 70,
  "timePerQuestion": 15,
  "scenarios": [
    {
      "text": "Collected payment from customers for goods sold",
      "correctPillar": "operating",
      "explanation": "Collections from customers relate to the core business of selling goods - an operating activity."
    },
    {
      "text": "Purchased manufacturing equipment for cash",
      "correctPillar": "investing",
      "explanation": "Buying long-term assets like equipment is an investing activity."
    },
    {
      "text": "Paid dividends to shareholders",
      "correctPillar": "financing",
      "explanation": "Dividend payments are returns to owners and classified as financing activities."
    },
    {
      "text": "Paid salaries and wages to employees",
      "correctPillar": "operating",
      "explanation": "Employee compensation is a regular business expense - an operating activity."
    },
    {
      "text": "Received proceeds from bank loan",
      "correctPillar": "financing",
      "explanation": "Borrowing from banks involves raising capital through debt - a financing activity."
    },
    {
      "text": "Sold an old delivery truck for cash",
      "correctPillar": "investing",
      "explanation": "Selling long-term assets is an investing activity, regardless of gain or loss."
    },
    {
      "text": "Paid interest on bank loan",
      "correctPillar": "operating",
      "explanation": "Under IFRS, interest paid can be operating or financing; commonly treated as operating since it relates to ongoing business costs."
    },
    {
      "text": "Repurchased company shares from the market",
      "correctPillar": "financing",
      "explanation": "Treasury stock transactions involve company''s own equity - a financing activity."
    },
    {
      "text": "Paid utility bills for the office",
      "correctPillar": "operating",
      "explanation": "Utility payments are regular operating expenses of the business."
    },
    {
      "text": "Issued new common shares for cash",
      "correctPillar": "financing",
      "explanation": "Issuing equity is a financing activity - raising capital from owners."
    }
  ]
}'::jsonb
WHERE slug = 'cash-flow-classification-challenge';

-- ============================================
-- Verification
-- ============================================

DO $$
DECLARE
  v_tip_fixed BOOLEAN;
  v_jep_fixed BOOLEAN;
  v_cfc_fixed BOOLEAN;
BEGIN
  -- Check transaction-impact-practice
  SELECT content ? 'scenarios' INTO v_tip_fixed
  FROM activities 
  WHERE slug = 'transaction-impact-practice';
  
  -- Check journal-entry-practice
  SELECT content ? 'account_options' INTO v_jep_fixed
  FROM activities 
  WHERE slug = 'journal-entry-practice';
  
  -- Check cash-flow-classification-challenge
  SELECT content ? 'scenarios' INTO v_cfc_fixed
  FROM activities 
  WHERE slug = 'cash-flow-classification-challenge';
  
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'Interactive Content Format Fix Results';
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  RAISE NOTICE 'transaction-impact-practice: Has scenarios = %', COALESCE(v_tip_fixed, false);
  RAISE NOTICE 'journal-entry-practice: Has account_options = %', COALESCE(v_jep_fixed, false);
  RAISE NOTICE 'cash-flow-classification-challenge: Has scenarios = %', COALESCE(v_cfc_fixed, false);
  RAISE NOTICE '═══════════════════════════════════════════════════════════';
  
  IF NOT COALESCE(v_tip_fixed, false) THEN
    RAISE WARNING 'transaction-impact-practice may need manual update';
  END IF;
  IF NOT COALESCE(v_jep_fixed, false) THEN
    RAISE WARNING 'journal-entry-practice may need manual update';
  END IF;
  IF NOT COALESCE(v_cfc_fixed, false) THEN
    RAISE WARNING 'cash-flow-classification-challenge may need manual update';
  END IF;
END $$;
