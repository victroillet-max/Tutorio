-- Migration: Receivables and Bad Debt Exercises
-- Creates exercises for accounts receivable, allowance method, and aging analysis
-- Note: All company names and scenarios are original

-- Receivables Exercise 1: Comprehensive Bad Debt Practice
-- Added to Module 8 (Specialized Topics - Receivables)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0008-000000000030',
  'fa000000-0000-0000-0000-000000000008',
  '8.30',
  30,
  'Practice: Accounts Receivable and Bad Debt',
  'practice-accounts-receivable-bad-debt',
  'interactive',
  30,
  100,
  'basic',
  '{
    "exam_title": "Accounts Receivable & Bad Debt Practice",
    "instructions": "Sterling Electronics sells electronic components on credit. Practice recording transactions related to accounts receivable and estimating bad debt expense.",
    "time_limit_minutes": 30,
    "passing_score": 70,
    "sections": [
      {
        "id": "ar-basics",
        "title": "Accounts Receivable Basics",
        "questions": [
          {
            "id": "ar-1",
            "type": "mcq",
            "topic": "Credit Sales",
            "question": "Sterling Electronics sells $50,000 of merchandise on credit. Which accounts are debited and credited?",
            "options": [
              "Debit Cash $50,000; Credit Sales Revenue $50,000",
              "Debit Accounts Receivable $50,000; Credit Sales Revenue $50,000",
              "Debit Sales Revenue $50,000; Credit Accounts Receivable $50,000",
              "Debit Inventory $50,000; Credit Cash $50,000"
            ],
            "correctAnswer": "Debit Accounts Receivable $50,000; Credit Sales Revenue $50,000",
            "points": 2,
            "explanation": "Credit sales increase Accounts Receivable (asset, debit) and increase Sales Revenue (credit). Cash is not involved until payment is received."
          },
          {
            "id": "ar-2",
            "type": "mcq",
            "topic": "Collections",
            "question": "A customer pays $30,000 to settle their account. Which entry is correct?",
            "options": [
              "Debit Accounts Receivable $30,000; Credit Cash $30,000",
              "Debit Cash $30,000; Credit Accounts Receivable $30,000",
              "Debit Cash $30,000; Credit Sales Revenue $30,000",
              "Debit Sales Revenue $30,000; Credit Cash $30,000"
            ],
            "correctAnswer": "Debit Cash $30,000; Credit Accounts Receivable $30,000",
            "points": 2,
            "explanation": "Collecting cash increases Cash (debit) and decreases Accounts Receivable (credit) as the customer no longer owes the amount."
          },
          {
            "id": "ar-3",
            "type": "calculation",
            "topic": "Net Realizable Value",
            "question": "Accounts Receivable has a balance of $200,000. The Allowance for Doubtful Accounts has a credit balance of $6,000. What is the Net Realizable Value of receivables?",
            "correctAnswer": 194000,
            "points": 3,
            "explanation": "NRV = Gross A/R - Allowance = $200,000 - $6,000 = $194,000. This is the amount expected to be collected.",
            "hint": "Net Realizable Value = Accounts Receivable - Allowance for Doubtful Accounts"
          }
        ]
      },
      {
        "id": "percentage-sales",
        "title": "Percentage of Sales Method",
        "questions": [
          {
            "id": "ps-1",
            "type": "mcq",
            "topic": "Method Overview",
            "question": "The percentage of sales method focuses on:",
            "options": [
              "The balance sheet - what the allowance should be",
              "The income statement - matching bad debt expense to sales",
              "The cash flow statement - when cash is lost",
              "The statement of changes in equity"
            ],
            "correctAnswer": "The income statement - matching bad debt expense to sales",
            "points": 2,
            "explanation": "The percentage of sales method is income statement focused, estimating bad debt expense as a percentage of credit sales to match expenses with revenues."
          },
          {
            "id": "ps-2",
            "type": "calculation",
            "topic": "Bad Debt Calculation",
            "question": "Credit sales for the year are CHF 800,000. Historical data suggests 2% of credit sales become uncollectible. What is the bad debt expense?",
            "correctAnswer": 16000,
            "points": 3,
            "explanation": "Bad Debt Expense = Credit Sales x Estimated % = CHF 800,000 x 2% = CHF 16,000"
          },
          {
            "id": "ps-3",
            "type": "mcq",
            "topic": "Journal Entry",
            "question": "To record bad debt expense of CHF 16,000 using the allowance method, the entry is:",
            "options": [
              "Debit Bad Debt Expense CHF 16,000; Credit Cash CHF 16,000",
              "Debit Bad Debt Expense CHF 16,000; Credit Accounts Receivable CHF 16,000",
              "Debit Bad Debt Expense CHF 16,000; Credit Allowance for Doubtful Accounts CHF 16,000",
              "Debit Allowance for Doubtful Accounts CHF 16,000; Credit Bad Debt Expense CHF 16,000"
            ],
            "correctAnswer": "Debit Bad Debt Expense CHF 16,000; Credit Allowance for Doubtful Accounts CHF 16,000",
            "points": 2,
            "explanation": "The allowance method credits the contra-asset account (Allowance for Doubtful Accounts) rather than directly reducing A/R."
          }
        ]
      },
      {
        "id": "aging-method",
        "title": "Aging of Receivables Method",
        "questions": [
          {
            "id": "age-1",
            "type": "mcq",
            "topic": "Method Overview",
            "question": "The aging of receivables method focuses on:",
            "options": [
              "The income statement - estimating expense",
              "The balance sheet - what the allowance balance should be",
              "The cash flow statement",
              "Forecasting future sales"
            ],
            "correctAnswer": "The balance sheet - what the allowance balance should be",
            "points": 2,
            "explanation": "The aging method is balance sheet focused, calculating what the Allowance for Doubtful Accounts balance SHOULD be based on receivable age categories."
          },
          {
            "id": "age-2",
            "type": "calculation",
            "topic": "Aging Schedule",
            "question": "AGING SCHEDULE:\n- 0-30 days: CHF 120,000 x 1% = CHF 1,200\n- 31-60 days: CHF 50,000 x 3% = CHF 1,500\n- 61-90 days: CHF 20,000 x 10% = CHF 2,000\n- Over 90 days: CHF 10,000 x 40% = CHF 4,000\n\nWhat should be the ending balance in Allowance for Doubtful Accounts?",
            "correctAnswer": 8700,
            "points": 4,
            "explanation": "Total allowance needed = 1,200 + 1,500 + 2,000 + 4,000 = CHF 8,700",
            "hint": "Add up the estimated uncollectible amounts from each age category"
          },
          {
            "id": "age-3",
            "type": "calculation",
            "topic": "Required Adjustment",
            "question": "The aging analysis shows the allowance should be CHF 8,700. The current Allowance for Doubtful Accounts has a credit balance of CHF 2,200. What bad debt expense should be recorded?",
            "correctAnswer": 6500,
            "points": 4,
            "explanation": "Bad Debt Expense = Required Balance - Current Balance = CHF 8,700 - CHF 2,200 = CHF 6,500. This brings the allowance to the required level.",
            "hint": "Calculate the difference between required balance and current balance"
          },
          {
            "id": "age-4",
            "type": "mcq",
            "topic": "Debit Balance Scenario",
            "question": "After writing off bad accounts, the Allowance has a DEBIT balance of CHF 1,000. The aging analysis shows CHF 8,700 is needed. What adjustment is required?",
            "options": [
              "Credit the Allowance for CHF 8,700",
              "Credit the Allowance for CHF 7,700",
              "Credit the Allowance for CHF 9,700",
              "Debit the Allowance for CHF 9,700"
            ],
            "correctAnswer": "Credit the Allowance for CHF 9,700",
            "points": 3,
            "explanation": "With a debit balance of CHF 1,000, you need CHF 9,700 to reach the required credit balance of CHF 8,700. (Current -1,000 + Adjustment = 8,700 Required)"
          }
        ]
      },
      {
        "id": "write-offs",
        "title": "Write-Offs and Recoveries",
        "questions": [
          {
            "id": "wo-1",
            "type": "mcq",
            "topic": "Writing Off",
            "question": "A customer owing CHF 5,000 declares bankruptcy. Using the allowance method, the write-off entry is:",
            "options": [
              "Debit Bad Debt Expense CHF 5,000; Credit Accounts Receivable CHF 5,000",
              "Debit Allowance for Doubtful Accounts CHF 5,000; Credit Accounts Receivable CHF 5,000",
              "Debit Accounts Receivable CHF 5,000; Credit Allowance for Doubtful Accounts CHF 5,000",
              "Debit Cash CHF 5,000; Credit Bad Debt Expense CHF 5,000"
            ],
            "correctAnswer": "Debit Allowance for Doubtful Accounts CHF 5,000; Credit Accounts Receivable CHF 5,000",
            "points": 3,
            "explanation": "Writing off reduces both the Allowance (debit the contra-asset) and A/R (credit). No expense is recorded because the expense was already estimated."
          },
          {
            "id": "wo-2",
            "type": "mcq",
            "topic": "Effect on NRV",
            "question": "When an account is written off using the allowance method, Net Realizable Value:",
            "options": [
              "Increases",
              "Decreases",
              "Stays the same",
              "Becomes zero"
            ],
            "correctAnswer": "Stays the same",
            "points": 2,
            "explanation": "NRV = A/R - Allowance. Both decrease by the same amount during write-off, so NRV remains unchanged."
          },
          {
            "id": "wo-3",
            "type": "mcq",
            "topic": "Recovery",
            "question": "If a previously written-off account of CHF 2,000 is recovered, the two entries are: (1) reverse the write-off, then (2):",
            "options": [
              "Debit Bad Debt Expense CHF 2,000; Credit Cash CHF 2,000",
              "Debit Cash CHF 2,000; Credit Accounts Receivable CHF 2,000",
              "Debit Cash CHF 2,000; Credit Bad Debt Expense CHF 2,000",
              "Debit Allowance CHF 2,000; Credit A/R CHF 2,000"
            ],
            "correctAnswer": "Debit Cash CHF 2,000; Credit Accounts Receivable CHF 2,000",
            "points": 3,
            "explanation": "First, reinstate the receivable (Dr A/R, Cr Allowance). Then, record the cash collection (Dr Cash, Cr A/R)."
          }
        ]
      }
    ]
  }',
  'mock-exam',
  70,
  false,
  true
);

-- Receivables Exercise 2: Aging Analysis Interactive
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0008-000000000031',
  'fa000000-0000-0000-0000-000000000008',
  '8.31',
  31,
  'Practice: Accounts Receivable Aging Analysis',
  'practice-ar-aging-analysis',
  'interactive',
  25,
  85,
  'basic',
  '{
    "exam_title": "A/R Aging Analysis: Riverside Trading Co.",
    "instructions": "Riverside Trading Co. has provided you with their accounts receivable detail. Perform an aging analysis and determine the appropriate allowance for doubtful accounts.",
    "time_limit_minutes": 25,
    "passing_score": 70,
    "sections": [
      {
        "id": "aging-data",
        "title": "Aging Schedule Preparation",
        "questions": [
          {
            "id": "ag-intro",
            "type": "mcq",
            "topic": "Data Review",
            "question": "RIVERSIDE TRADING CO. - RECEIVABLES DATA:\n\nCustomer A: CHF 45,000 (Invoice Date: Current month)\nCustomer B: CHF 28,000 (Invoice Date: 45 days ago)\nCustomer C: CHF 15,000 (Invoice Date: 75 days ago)\nCustomer D: CHF 8,000 (Invoice Date: 120 days ago)\nCustomer E: CHF 35,000 (Invoice Date: 20 days ago)\nCustomer F: CHF 12,000 (Invoice Date: 95 days ago)\n\nUNCOLLECTIBLE RATES BY AGE:\n- 0-30 days: 1%\n- 31-60 days: 3%\n- 61-90 days: 8%\n- Over 90 days: 25%\n\nHow would you categorize Customer C (75 days)?",
            "options": ["0-30 days", "31-60 days", "61-90 days", "Over 90 days"],
            "correctAnswer": "61-90 days",
            "points": 2,
            "explanation": "At 75 days since invoice, Customer C falls into the 61-90 days category."
          },
          {
            "id": "ag-cat1",
            "type": "calculation",
            "topic": "0-30 Days Category",
            "question": "Calculate the total receivables in the 0-30 days category (Customer A: 45K current, Customer E: 35K at 20 days)",
            "correctAnswer": 80000,
            "points": 3,
            "explanation": "0-30 days total = Customer A (45,000) + Customer E (35,000) = CHF 80,000"
          },
          {
            "id": "ag-cat2",
            "type": "calculation",
            "topic": "31-60 Days Category",
            "question": "What is the total for the 31-60 days category? (Customer B is 45 days)",
            "correctAnswer": 28000,
            "points": 2,
            "explanation": "Only Customer B (CHF 28,000) at 45 days falls in this category."
          },
          {
            "id": "ag-cat3",
            "type": "calculation",
            "topic": "61-90 Days Category",
            "question": "What is the total for 61-90 days? (Customer C is 75 days)",
            "correctAnswer": 15000,
            "points": 2,
            "explanation": "Only Customer C (CHF 15,000) at 75 days falls in this category."
          },
          {
            "id": "ag-cat4",
            "type": "calculation",
            "topic": "Over 90 Days Category",
            "question": "What is the total for over 90 days? (Customer D: 120 days, Customer F: 95 days)",
            "correctAnswer": 20000,
            "points": 3,
            "explanation": "Over 90 days = Customer D (8,000) + Customer F (12,000) = CHF 20,000"
          }
        ]
      },
      {
        "id": "allowance-calc",
        "title": "Allowance Calculation",
        "questions": [
          {
            "id": "allow-1",
            "type": "calculation",
            "topic": "0-30 Days Estimate",
            "question": "CHF 80,000 in 0-30 days at 1% uncollectible rate equals:",
            "correctAnswer": 800,
            "points": 2,
            "explanation": "CHF 80,000 x 1% = CHF 800"
          },
          {
            "id": "allow-2",
            "type": "calculation",
            "topic": "31-60 Days Estimate",
            "question": "CHF 28,000 in 31-60 days at 3% uncollectible rate equals:",
            "correctAnswer": 840,
            "points": 2,
            "explanation": "CHF 28,000 x 3% = CHF 840"
          },
          {
            "id": "allow-3",
            "type": "calculation",
            "topic": "61-90 Days Estimate",
            "question": "CHF 15,000 in 61-90 days at 8% uncollectible rate equals:",
            "correctAnswer": 1200,
            "points": 2,
            "explanation": "CHF 15,000 x 8% = CHF 1,200"
          },
          {
            "id": "allow-4",
            "type": "calculation",
            "topic": "Over 90 Days Estimate",
            "question": "CHF 20,000 over 90 days at 25% uncollectible rate equals:",
            "correctAnswer": 5000,
            "points": 2,
            "explanation": "CHF 20,000 x 25% = CHF 5,000"
          },
          {
            "id": "allow-total",
            "type": "calculation",
            "topic": "Total Allowance Required",
            "question": "Calculate the total required Allowance for Doubtful Accounts (sum of all categories):",
            "correctAnswer": 7840,
            "points": 4,
            "explanation": "Total = 800 + 840 + 1,200 + 5,000 = CHF 7,840"
          }
        ]
      },
      {
        "id": "journal-entry",
        "title": "Adjusting Entry",
        "questions": [
          {
            "id": "je-1",
            "type": "calculation",
            "topic": "Bad Debt Expense",
            "question": "The Allowance currently has a credit balance of CHF 2,340. Required balance is CHF 7,840. What Bad Debt Expense should be recorded?",
            "correctAnswer": 5500,
            "points": 4,
            "explanation": "Adjustment needed = Required - Current = CHF 7,840 - CHF 2,340 = CHF 5,500"
          },
          {
            "id": "je-2",
            "type": "calculation",
            "topic": "Net Realizable Value",
            "question": "Total A/R is CHF 143,000 (80K + 28K + 15K + 20K). After the adjustment, what is the Net Realizable Value?",
            "correctAnswer": 135160,
            "points": 4,
            "explanation": "NRV = Total A/R - Allowance = CHF 143,000 - CHF 7,840 = CHF 135,160"
          }
        ]
      }
    ]
  }',
  'mock-exam',
  70,
  false,
  true
);

-- Create a quick timed quiz for receivables review
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0008-000000000032',
  'fa000000-0000-0000-0000-000000000008',
  '8.32',
  32,
  'Quick Quiz: Receivables Review',
  'quick-quiz-receivables-review',
  'quiz',
  5,
  30,
  'basic',
  '{
    "passing_score": 70,
    "timed_mode": true,
    "time_limit_seconds": 180,
    "shuffle_questions": true,
    "shuffle_options": true,
    "questions": [
      {
        "id": "rq-1",
        "type": "mcq",
        "question": "Which method focuses on the income statement when estimating bad debt?",
        "options": ["Aging of receivables", "Percentage of sales", "Direct write-off", "Allowance method"],
        "correct": 1,
        "explanation": "The percentage of sales method focuses on matching bad debt expense with revenue (income statement focus)."
      },
      {
        "id": "rq-2",
        "type": "true_false",
        "question": "Writing off an account under the allowance method affects net income.",
        "correct": false,
        "explanation": "No effect on net income. The expense was already recorded when the allowance was created."
      },
      {
        "id": "rq-3",
        "type": "mcq",
        "question": "Allowance for Doubtful Accounts is a:",
        "options": ["Revenue account", "Contra-asset account", "Liability account", "Expense account"],
        "correct": 1,
        "explanation": "It''s a contra-asset that reduces Accounts Receivable on the balance sheet."
      },
      {
        "id": "rq-4",
        "type": "true_false",
        "question": "The direct write-off method is preferred under GAAP/IFRS.",
        "correct": false,
        "explanation": "The allowance method is required because it better matches expenses with revenues."
      },
      {
        "id": "rq-5",
        "type": "mcq",
        "question": "When an account previously written off is recovered, the first entry is to:",
        "options": [
          "Debit Cash, Credit A/R",
          "Debit A/R, Credit Allowance for Doubtful Accounts",
          "Debit Bad Debt Expense, Credit A/R",
          "Debit Cash, Credit Bad Debt Expense"
        ],
        "correct": 1,
        "explanation": "First reinstate the receivable by reversing the write-off, then record the cash collection."
      }
    ]
  }',
  70,
  false,
  true
);

-- Link activities to skills
INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0008-000000000030', id, true, true
FROM skills WHERE slug = 'sa-accounts-receivable'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0008-000000000031', id, true, true
FROM skills WHERE slug = 'sa-accounts-receivable'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0008-000000000032', id, true, true
FROM skills WHERE slug = 'sa-accounts-receivable'
ON CONFLICT DO NOTHING;
