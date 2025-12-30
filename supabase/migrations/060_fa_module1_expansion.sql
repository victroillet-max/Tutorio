-- ============================================
-- FA Course Content Expansion - Phase 3
-- Module 1: Foundations of Accounting Expansion
-- Adds 6 new activities for foundational concepts
-- ============================================

-- ============================================
-- NEW ACTIVITIES FOR MODULE 1
-- Following existing UUID pattern: fa100000-0000-0000-0001-00000000XXXX
-- Existing activities: 0001-0008, new start at 0009
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 1.9: Transaction Analysis Mastery
-- Primary Skill: fa-accounting-equation
-- ============================================
(
  'fa100000-0000-0000-0001-000000000009',
  'fa000000-0000-0000-0000-000000000001',
  '1.9',
  9,
  'Transaction Analysis Mastery',
  'transaction-analysis-mastery',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Transaction Effects: Alpine Trading Co",
    "description": "Analyze how business transactions affect the accounting equation for Alpine Trading Co.",
    "company_background": "Alpine Trading Co is a new retail business. Analyze how each transaction affects Assets, Liabilities, and Equity.",
    "accounting_equation": "Assets = Liabilities + Stockholders'' Equity",
    "transactions": [
      {"id": "T1", "description": "Owners invest CHF 100,000 cash to start the business"},
      {"id": "T2", "description": "Purchase equipment for CHF 35,000 on account"},
      {"id": "T3", "description": "Purchase inventory for CHF 20,000 cash"},
      {"id": "T4", "description": "Sell inventory for CHF 15,000 cash (cost was CHF 8,000)"},
      {"id": "T5", "description": "Pay CHF 10,000 on accounts payable"},
      {"id": "T6", "description": "Receive CHF 5,000 deposit from customer for future order"},
      {"id": "T7", "description": "Pay CHF 3,000 for one year of insurance in advance"}
    ],
    "questions": [
      {
        "id": "ta1",
        "question": "T1: Which element increases?",
        "answer_type": "choice",
        "options": ["Assets only", "Liabilities only", "Assets and Equity", "Assets and Liabilities"],
        "correct_answer": "Assets and Equity",
        "explanation": "Cash (Asset) increases CHF 100,000. Common Stock (Equity) increases CHF 100,000."
      },
      {
        "id": "ta2",
        "question": "T2: What is the effect on Total Assets?",
        "answer_type": "choice",
        "options": ["Increase CHF 35,000", "Decrease CHF 35,000", "No change", "Increase CHF 70,000"],
        "correct_answer": "Increase CHF 35,000",
        "explanation": "Equipment (Asset) increases, and A/P (Liability) increases. Net effect: Assets +35,000."
      },
      {
        "id": "ta3",
        "question": "T3: Total Assets after T3 (starting from CHF 135,000):",
        "answer_type": "numeric",
        "correct_answer": 135000,
        "tolerance": 100,
        "hint": "Cash decreases, Inventory increases",
        "explanation": "Cash -20,000, Inventory +20,000. No change to total assets. Still CHF 135,000."
      },
      {
        "id": "ta4",
        "question": "T4: What is the gross profit from this sale?",
        "answer_type": "numeric",
        "correct_answer": 7000,
        "tolerance": 50,
        "hint": "Revenue - Cost of Goods Sold",
        "explanation": "Gross Profit = 15,000 revenue - 8,000 COGS = CHF 7,000"
      },
      {
        "id": "ta5",
        "question": "T5: Effect on the accounting equation:",
        "answer_type": "choice",
        "options": [
          "Assets decrease, Liabilities decrease",
          "Assets decrease, Equity decreases",
          "Assets increase, Liabilities increase",
          "No effect on equation"
        ],
        "correct_answer": "Assets decrease, Liabilities decrease",
        "explanation": "Cash (Asset) -10,000, A/P (Liability) -10,000. Equation stays balanced."
      },
      {
        "id": "ta6",
        "question": "T6: The CHF 5,000 deposit is recorded as:",
        "answer_type": "choice",
        "options": ["Revenue", "Asset", "Liability", "Equity"],
        "correct_answer": "Liability",
        "explanation": "Cash received before earning = Unearned Revenue (a liability)."
      },
      {
        "id": "ta7",
        "question": "T7: Prepaid Insurance is classified as:",
        "answer_type": "choice",
        "options": ["Expense", "Asset", "Liability", "Equity"],
        "correct_answer": "Asset",
        "explanation": "Prepaid Insurance is an asset until the coverage period expires."
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'equation-analyzer',
  false,
  true
),

-- ============================================
-- Activity 1.10: Journal Entry Fundamentals
-- Primary Skill: fa-journal-entries
-- ============================================
(
  'fa100000-0000-0000-0001-000000000010',
  'fa000000-0000-0000-0000-000000000001',
  '1.10',
  10,
  'Journal Entry Fundamentals',
  'journal-entry-fundamentals',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# Journal Entry Fundamentals\n\n## Why This Matters\n\nJournal entries are the building blocks of accounting. Every business transaction is first recorded as a journal entry before appearing in financial statements.\n\n---\n\n## The Golden Rules\n\n### For Every Transaction:\n\n1. **Debits must equal Credits**\n2. **At least two accounts** are affected\n3. **Record in chronological order**\n\n---\n\n## Normal Balances\n\n| Account Type | Normal Balance | To Increase | To Decrease |\n|--------------|---------------|-------------|-------------|\n| Assets | Debit | Debit | Credit |\n| Liabilities | Credit | Credit | Debit |\n| Equity | Credit | Credit | Debit |\n| Revenue | Credit | Credit | Debit |\n| Expenses | Debit | Debit | Credit |\n\n---\n\n## Journal Entry Format\n\n```\nDate        Account Title          Debit    Credit\n-------------------------------------------------\nJan 1      Cash                   50,000\n             Common Stock                   50,000\n           (Owner investment)\n```\n\n### Components:\n\n1. **Date** of transaction\n2. **Debit account(s)** listed first\n3. **Credit account(s)** indented\n4. **Brief description** in parentheses\n\n---\n\n## Common Transaction Examples\n\n### 1. Owner Investment\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 50,000 | |\n| Common Stock | | 50,000 |\n\n### 2. Purchase Equipment (Cash)\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Equipment | 25,000 | |\n| Cash | | 25,000 |\n\n### 3. Purchase on Account\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Inventory | 10,000 | |\n| Accounts Payable | | 10,000 |\n\n### 4. Cash Sale\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 5,000 | |\n| Sales Revenue | | 5,000 |\n| Cost of Goods Sold | 3,000 | |\n| Inventory | | 3,000 |\n\n### 5. Credit Sale\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Accounts Receivable | 8,000 | |\n| Sales Revenue | | 8,000 |\n\n### 6. Pay Supplier\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Accounts Payable | 10,000 | |\n| Cash | | 10,000 |\n\n### 7. Record Expense\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Rent Expense | 2,000 | |\n| Cash | | 2,000 |\n\n---\n\n## Common Mistakes to Avoid\n\n### Mistake 1: Debits Not Equal Credits\n\n**Wrong:**\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 5,000 | |\n| Revenue | | 4,500 |\n\n### Mistake 2: Wrong Account Type\n\nRemember: Expenses INCREASE with debits!\n\n### Mistake 3: Reversed Entry\n\nDouble-check which account increases/decreases.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Assets and Expenses have debit normal balances\n> - Liabilities, Equity, Revenue have credit normal balances\n> - Debits always equal Credits\n> - Debit accounts are listed first\n> - Always include a brief description"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 1.11: Journal Entry Practice
-- Primary Skill: fa-journal-entries
-- ============================================
(
  'fa100000-0000-0000-0001-000000000011',
  'fa000000-0000-0000-0000-000000000001',
  '1.11',
  11,
  'Journal Entry Practice',
  'journal-entry-practice',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Journal Entries: Sunrise Consulting",
    "description": "Record journal entries for Sunrise Consulting''s March transactions.",
    "company_background": "Sunrise Consulting is a new consulting firm. Record the journal entries for their first month of operations.",
    "transactions": [
      {"date": "Mar 1", "description": "Owner invested CHF 80,000 cash"},
      {"date": "Mar 3", "description": "Paid CHF 3,600 for 12-month insurance policy"},
      {"date": "Mar 5", "description": "Purchased office equipment CHF 15,000 on account"},
      {"date": "Mar 10", "description": "Performed services for client, received CHF 6,000 cash"},
      {"date": "Mar 15", "description": "Performed services on credit CHF 4,500"},
      {"date": "Mar 20", "description": "Paid CHF 8,000 on accounts payable"},
      {"date": "Mar 25", "description": "Received CHF 2,500 from client on account"},
      {"date": "Mar 31", "description": "Paid salaries CHF 5,000"}
    ],
    "questions": [
      {
        "id": "je1",
        "question": "Mar 1: Which account is debited?",
        "answer_type": "choice",
        "options": ["Common Stock", "Cash", "Retained Earnings", "Revenue"],
        "correct_answer": "Cash",
        "explanation": "Cash (Asset) increases, so it is debited."
      },
      {
        "id": "je2",
        "question": "Mar 3: Is Prepaid Insurance debited or credited?",
        "answer_type": "choice",
        "options": ["Debited", "Credited"],
        "correct_answer": "Debited",
        "explanation": "Prepaid Insurance (Asset) increases, so it is debited."
      },
      {
        "id": "je3",
        "question": "Mar 5: Total debits in this entry:",
        "answer_type": "numeric",
        "correct_answer": 15000,
        "tolerance": 50,
        "explanation": "Debit: Office Equipment CHF 15,000"
      },
      {
        "id": "je4",
        "question": "Mar 10: Which account is credited for CHF 6,000?",
        "answer_type": "choice",
        "options": ["Cash", "Service Revenue", "Accounts Receivable", "Common Stock"],
        "correct_answer": "Service Revenue",
        "explanation": "Service Revenue (Revenue) increases with a credit."
      },
      {
        "id": "je5",
        "question": "Mar 15: Which account is debited?",
        "answer_type": "choice",
        "options": ["Cash", "Accounts Receivable", "Service Revenue", "Accounts Payable"],
        "correct_answer": "Accounts Receivable",
        "explanation": "Credit sale: Debit A/R (Asset increases), Credit Revenue."
      },
      {
        "id": "je6",
        "question": "Mar 20: Which accounts are affected?",
        "answer_type": "choice",
        "options": [
          "Cash (Dr) and Revenue (Cr)",
          "Accounts Payable (Dr) and Cash (Cr)",
          "Equipment (Dr) and Cash (Cr)",
          "Accounts Receivable (Dr) and Cash (Cr)"
        ],
        "correct_answer": "Accounts Payable (Dr) and Cash (Cr)",
        "explanation": "Pay supplier: Debit A/P (decrease liability), Credit Cash (decrease asset)."
      },
      {
        "id": "je7",
        "question": "Mar 25: Accounts Receivable is:",
        "answer_type": "choice",
        "options": ["Debited CHF 2,500", "Credited CHF 2,500", "No change"],
        "correct_answer": "Credited CHF 2,500",
        "explanation": "Collection from customer: Debit Cash, Credit A/R (decrease)."
      },
      {
        "id": "je8",
        "question": "Mar 31: Which account is debited?",
        "answer_type": "choice",
        "options": ["Cash", "Salaries Payable", "Salaries Expense", "Accounts Payable"],
        "correct_answer": "Salaries Expense",
        "explanation": "Pay salaries: Debit Salaries Expense (increase expense), Credit Cash."
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'journal-entry-builder',
  false,
  true
),

-- ============================================
-- Activity 1.12: T-Account Analysis
-- Primary Skill: fa-t-accounts
-- ============================================
(
  'fa100000-0000-0000-0001-000000000012',
  'fa000000-0000-0000-0000-000000000001',
  '1.12',
  12,
  'T-Account Analysis',
  't-account-analysis',
  'lesson',
  12,
  24,
  'basic',
  '{"markdown": "# T-Account Analysis\n\n## Why This Matters\n\nT-accounts are a visual tool for tracking account balances and understanding how transactions flow through the accounting system.\n\n---\n\n## What Is a T-Account?\n\n```\n       Account Name\n    ┌────────┬────────┐\n    │ Debit  │ Credit │\n    │  side  │  side  │\n    │        │        │\n    └────────┴────────┘\n```\n\n---\n\n## Normal Balances Refresher\n\n| Account Type | Normal Balance |\n|--------------|---------------|\n| Assets | Left (Debit) |\n| Liabilities | Right (Credit) |\n| Equity | Right (Credit) |\n| Revenue | Right (Credit) |\n| Expenses | Left (Debit) |\n\n---\n\n## Example: Cash T-Account\n\n```\n          Cash\n    ┌────────┬────────┐\n    │(1)50,000│(3)15,000│\n    │(4)12,000│(5) 8,000│\n    │         │(6) 3,000│\n    ├────────┼────────┤\n    │Bal 36,000│        │\n    └────────┴────────┘\n```\n\n**Calculation:**\n- Total Debits: 50,000 + 12,000 = 62,000\n- Total Credits: 15,000 + 8,000 + 3,000 = 26,000\n- Balance: 62,000 - 26,000 = 36,000 (Debit)\n\n---\n\n## Example: Accounts Payable\n\n```\n     Accounts Payable\n    ┌────────┬────────┐\n    │(3)10,000│(2)25,000│\n    │         │         │\n    ├────────┼────────┤\n    │        │Bal 15,000│\n    └────────┴────────┘\n```\n\n**Calculation:**\n- Credits (increase): 25,000\n- Debits (decrease): 10,000\n- Balance: 25,000 - 10,000 = 15,000 (Credit)\n\n---\n\n## Posting from Journal to T-Account\n\n### Step 1: Journal Entry\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 8,000 | |\n| Service Revenue | | 8,000 |\n\n### Step 2: Post to T-Accounts\n\n```\n          Cash                    Service Revenue\n    ┌────────┬────────┐      ┌────────┬────────┐\n    │  8,000 │        │      │        │  8,000 │\n    └────────┴────────┘      └────────┴────────┘\n```\n\n---\n\n## Calculating Ending Balances\n\n### For Debit-Balance Accounts (Assets, Expenses)\n\n```\nEnding Balance = Beginning + Debits - Credits\n```\n\n### For Credit-Balance Accounts (Liabilities, Equity, Revenue)\n\n```\nEnding Balance = Beginning + Credits - Debits\n```\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - T-accounts show increases on the normal balance side\n> - Assets and Expenses: increases on left (debit)\n> - Liabilities, Equity, Revenue: increases on right (credit)\n> - Balance = Sum of normal side - Sum of opposite side"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 1.13: T-Account Practice
-- Primary Skill: fa-t-accounts
-- ============================================
(
  'fa100000-0000-0000-0001-000000000013',
  'fa000000-0000-0000-0000-000000000001',
  '1.13',
  13,
  'T-Account Practice',
  't-account-practice',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "T-Account Balances: Valley Retail",
    "description": "Calculate T-account balances for Valley Retail after posting transactions.",
    "company_background": "Valley Retail had the following transactions in June. Post to T-accounts and calculate balances.",
    "beginning_balances": {
      "cash": 25000,
      "accounts_receivable": 12000,
      "inventory": 35000,
      "accounts_payable": 18000,
      "common_stock": 54000
    },
    "transactions": [
      {"ref": "1", "description": "Cash sales CHF 15,000 (cost of goods CHF 9,000)"},
      {"ref": "2", "description": "Credit sales CHF 8,000 (cost of goods CHF 5,000)"},
      {"ref": "3", "description": "Collected CHF 10,000 from customers"},
      {"ref": "4", "description": "Purchased inventory CHF 12,000 on account"},
      {"ref": "5", "description": "Paid suppliers CHF 15,000"},
      {"ref": "6", "description": "Paid rent CHF 4,000"}
    ],
    "questions": [
      {
        "id": "ta1",
        "question": "Calculate ending Cash balance.",
        "answer_type": "numeric",
        "correct_answer": 31000,
        "tolerance": 100,
        "hint": "Beginning + Cash received - Cash paid",
        "explanation": "Cash = 25,000 + 15,000 + 10,000 - 15,000 - 4,000 = CHF 31,000"
      },
      {
        "id": "ta2",
        "question": "Calculate ending Accounts Receivable balance.",
        "answer_type": "numeric",
        "correct_answer": 10000,
        "tolerance": 100,
        "explanation": "A/R = 12,000 + 8,000 - 10,000 = CHF 10,000"
      },
      {
        "id": "ta3",
        "question": "Calculate ending Inventory balance.",
        "answer_type": "numeric",
        "correct_answer": 33000,
        "tolerance": 100,
        "hint": "Beginning + Purchases - COGS",
        "explanation": "Inventory = 35,000 + 12,000 - 9,000 - 5,000 = CHF 33,000"
      },
      {
        "id": "ta4",
        "question": "Calculate ending Accounts Payable balance.",
        "answer_type": "numeric",
        "correct_answer": 15000,
        "tolerance": 100,
        "explanation": "A/P = 18,000 + 12,000 - 15,000 = CHF 15,000"
      },
      {
        "id": "ta5",
        "question": "Calculate total Sales Revenue for June.",
        "answer_type": "numeric",
        "correct_answer": 23000,
        "tolerance": 100,
        "explanation": "Revenue = 15,000 + 8,000 = CHF 23,000"
      },
      {
        "id": "ta6",
        "question": "Calculate total Cost of Goods Sold for June.",
        "answer_type": "numeric",
        "correct_answer": 14000,
        "tolerance": 100,
        "explanation": "COGS = 9,000 + 5,000 = CHF 14,000"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  't-account-calculator',
  false,
  true
),

-- ============================================
-- Activity 1.14: Foundations Quiz
-- Primary Skill: fa-accounting-equation, fa-journal-entries, fa-t-accounts
-- ============================================
(
  'fa100000-0000-0000-0001-000000000014',
  'fa000000-0000-0000-0000-000000000001',
  '1.14',
  14,
  'Foundations Comprehensive Quiz',
  'foundations-comprehensive-quiz',
  'quiz',
  14,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "The accounting equation is:",
        "options": [
          "Assets = Liabilities + Revenue",
          "Assets = Liabilities + Stockholders'' Equity",
          "Assets + Liabilities = Equity",
          "Revenue - Expenses = Net Income"
        ],
        "correct": 1,
        "explanation": "The fundamental equation: Assets = Liabilities + Stockholders'' Equity"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "When equipment is purchased with cash:",
        "options": [
          "Total assets increase",
          "Total assets decrease",
          "Total assets stay the same",
          "Total liabilities increase"
        ],
        "correct": 2,
        "explanation": "Cash decreases, Equipment increases. Total assets unchanged - just composition changes."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which has a normal debit balance?",
        "options": [
          "Accounts Payable",
          "Common Stock",
          "Accounts Receivable",
          "Service Revenue"
        ],
        "correct": 2,
        "explanation": "Accounts Receivable is an asset with a normal debit balance."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Company pays CHF 2,400 for 6-month rent in advance. The entry is:",
        "options": [
          "Dr Rent Expense, Cr Cash",
          "Dr Prepaid Rent, Cr Cash",
          "Dr Cash, Cr Rent Revenue",
          "Dr Rent Payable, Cr Cash"
        ],
        "correct": 1,
        "explanation": "Prepaid rent is an asset until used. Dr Prepaid Rent (asset increase), Cr Cash (asset decrease)."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A T-account for Accounts Payable shows: Debits CHF 8,000, Credits CHF 22,000. The balance is:",
        "options": [
          "CHF 14,000 debit",
          "CHF 14,000 credit",
          "CHF 30,000 credit",
          "CHF 30,000 debit"
        ],
        "correct": 1,
        "explanation": "A/P has credit normal balance. 22,000 - 8,000 = CHF 14,000 credit balance."
      },
      {
        "id": "q6",
        "type": "true_false",
        "difficulty": "basic",
        "question": "In a journal entry, credits are listed before debits.",
        "correct": false,
        "explanation": "FALSE. Debits are always listed first, with credits indented below."
      },
      {
        "id": "q7",
        "type": "true_false",
        "difficulty": "applied",
        "question": "An increase in expenses decreases stockholders'' equity.",
        "correct": true,
        "explanation": "TRUE. Expenses reduce net income, which reduces retained earnings (part of equity)."
      }
    ],
    "passing_score": 70,
    "show_explanations": true
  }'::jsonb,
  NULL,
  false,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;

-- ============================================
-- ADD SKILL TAGS FOR NEW MODULE 1 ACTIVITIES
-- Using correct skill IDs:
-- fa-accounting-equation = b0000000-0000-0000-0001-000000000002
-- fa-transaction-analysis = b0000000-0000-0000-0001-000000000003
-- fa-double-entry = b0000000-0000-0000-0001-000000000006
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 1.9 Transaction Analysis Mastery (fa-accounting-equation)
('fa100000-0000-0000-0001-000000000009', 'b0000000-0000-0000-0001-000000000002', 1.0, true),

-- 1.10 Journal Entry Fundamentals (fa-double-entry)
('fa100000-0000-0000-0001-000000000010', 'b0000000-0000-0000-0001-000000000006', 1.0, true),

-- 1.11 Journal Entry Practice (fa-double-entry)
('fa100000-0000-0000-0001-000000000011', 'b0000000-0000-0000-0001-000000000006', 1.0, true),

-- 1.12 T-Account Analysis (fa-double-entry)
('fa100000-0000-0000-0001-000000000012', 'b0000000-0000-0000-0001-000000000006', 1.0, true),

-- 1.13 T-Account Practice (fa-double-entry)
('fa100000-0000-0000-0001-000000000013', 'b0000000-0000-0000-0001-000000000006', 1.0, true),

-- 1.14 Foundations Quiz (multiple skills)
('fa100000-0000-0000-0001-000000000014', 'b0000000-0000-0000-0001-000000000002', 0.5, true),
('fa100000-0000-0000-0001-000000000014', 'b0000000-0000-0000-0001-000000000006', 0.5, false)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

