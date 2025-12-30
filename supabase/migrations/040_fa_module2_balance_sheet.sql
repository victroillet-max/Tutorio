-- ============================================
-- Module 2: Building the Balance Sheet
-- GOLD STANDARD Content - Double-Entry & Journal Entries
-- Inspired by Venkman exercise structure
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 2.1: Double-Entry Bookkeeping
-- ============================================
(
  'fa200000-0000-0000-0002-000000000001',
  'fa000000-0000-0000-0000-000000000002',
  '2.1',
  1,
  'Double-Entry Bookkeeping',
  'double-entry-bookkeeping',
  'lesson',
  15,
  25,
  'free',
  '{"markdown": "# Double-Entry Bookkeeping\n\n## Why This Matters\n\nSingle-entry bookkeeping is like checking your bank balance - you see one number change. But businesses need to know WHERE money comes from and WHERE it goes simultaneously.\n\nDouble-entry bookkeeping, invented in 15th century Italy, revolutionized commerce and is still the foundation of all modern accounting.\n\n> Every transaction is recorded twice: once as a DEBIT and once as a CREDIT.\n\n---\n\n## The Basic Rule\n\n### For Every Transaction:\n\n**DEBITS = CREDITS**\n\nThis isn''t just good practice - it''s a mathematical requirement that keeps the accounting equation balanced.\n\n---\n\n## Understanding Debits and Credits\n\n### Common Misconceptions\n\nForget what \"debit\" and \"credit\" mean in everyday language. In accounting:\n\n- **Debit (Dr)** = Left side of an account\n- **Credit (Cr)** = Right side of an account\n\nThey''re simply directional terms, like \"left\" and \"right.\"\n\n### The Rules\n\n| Account Type | To Increase | To Decrease | Normal Balance |\n|--------------|-------------|-------------|----------------|\n| **Assets** | Debit | Credit | Debit |\n| **Liabilities** | Credit | Debit | Credit |\n| **Equity** | Credit | Debit | Credit |\n| **Revenue** | Credit | Debit | Credit |\n| **Expenses** | Debit | Credit | Debit |\n\n### Memory Aid: DEA-LCR\n\n```\nDEBIT increases:       CREDIT increases:\n- D - Dividends        - L - Liabilities\n- E - Expenses         - C - Capital (Equity)\n- A - Assets           - R - Revenue\n```\n\n---\n\n## The T-Account\n\nA visual way to track debits and credits for each account:\n\n```\n          CASH\n    \n     Debit  |  Credit\n    --------|--------\n     10,000 |   3,000\n      5,000 |   1,000\n    --------|--------\n Balance:   |  11,000\n```\n\nBalance = Total Debits - Total Credits = 15,000 - 4,000 = 11,000 (Debit balance)\n\n---\n\n## Worked Example 1: Owner Investment\n\nMaria invests CHF 50,000 cash in her new business.\n\n**Analysis:**\n- Cash (Asset) increases - Debit +50,000\n- Share Capital (Equity) increases - Credit +50,000\n\n**Journal Entry:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 50,000 | |\n| Share Capital | | 50,000 |\n\n**Check:** Debits (50,000) = Credits (50,000)\n\n---\n\n## Worked Example 2: Buying Equipment with Cash\n\nPurchase equipment for CHF 20,000 cash.\n\n**Analysis:**\n- Equipment (Asset) increases - Debit +20,000\n- Cash (Asset) decreases - Credit -20,000\n\n**Journal Entry:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Equipment | 20,000 | |\n| Cash | | 20,000 |\n\n**Check:** Debits (20,000) = Credits (20,000)\n\n---\n\n## Worked Example 3: Buying Supplies on Credit\n\nPurchase supplies for CHF 3,000 on account (will pay later).\n\n**Analysis:**\n- Supplies (Asset) increases - Debit +3,000\n- Accounts Payable (Liability) increases - Credit +3,000\n\n**Journal Entry:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Supplies | 3,000 | |\n| Accounts Payable | | 3,000 |\n\n---\n\n## Worked Example 4: Earning Revenue\n\nPerform services and receive CHF 8,000 cash from client.\n\n**Analysis:**\n- Cash (Asset) increases - Debit +8,000\n- Service Revenue (Equity) increases - Credit +8,000\n\n**Journal Entry:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 8,000 | |\n| Service Revenue | | 8,000 |\n\n---\n\n## Worked Example 5: Paying an Expense\n\nPay rent of CHF 2,000 cash.\n\n**Analysis:**\n- Rent Expense (Equity decreases) - Debit +2,000\n- Cash (Asset) decreases - Credit -2,000\n\n**Journal Entry:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Rent Expense | 2,000 | |\n| Cash | | 2,000 |\n\n---\n\n## The Accounting Cycle\n\n```\n1. Identify Transaction\n        |\n        v\n2. Analyze (What accounts? Increase or decrease?)\n        |\n        v\n3. Record Journal Entry (Dr = Cr)\n        |\n        v\n4. Post to T-Accounts/Ledger\n        |\n        v\n5. Prepare Trial Balance\n        |\n        v\n6. Make Adjustments\n        |\n        v\n7. Prepare Financial Statements\n```\n\n---\n\n## Common Mistakes\n\n### Mistake 1: Getting debits and credits backwards\n**Remember:** Assets and Expenses increase with DEBITS. Everything else increases with CREDITS.\n\n### Mistake 2: Unequal debits and credits\n**Always check:** Total Debits MUST equal Total Credits for every entry.\n\n### Mistake 3: Confusing cash movement with debit/credit\n**Remember:** \"Debit\" doesn''t mean \"money out\" - it means \"left side.\"\n\n---\n\n## Pro Tips\n\n1. **Memorize the normal balances** - Assets/Expenses = Debit, everything else = Credit\n2. **Start with what you know** - If cash increased, start with a debit to Cash\n3. **Always balance** - Count debits and credits before moving on\n4. **Practice T-accounts** - Visual representation helps understanding\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Every transaction has at least one debit AND one credit\n> - Debits ALWAYS equal Credits\n> - Assets and Expenses have debit (left) normal balances\n> - Liabilities, Equity, and Revenue have credit (right) normal balances\n> - Think DEA-LCR: Debits increase (D)ividends, (E)xpenses, (A)ssets"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.2: Journal Entry Practice - Phantom Studios
-- ============================================
(
  'fa200000-0000-0000-0002-000000000002',
  'fa000000-0000-0000-0000-000000000002',
  '2.2',
  2,
  'Journal Entry Practice: Phantom Studios',
  'journal-entry-practice-phantom-studios',
  'interactive',
  18,
  40,
  'free',
  '{
    "title": "Journal Entry Builder: Phantom Studios Inc.",
    "description": "Phantom Studios Inc. is a new entertainment production company. Record the journal entries for its first month of operations.",
    "instructions": "For each transaction, select the accounts affected and enter the debit and credit amounts. Debits must equal credits for each entry.",
    "company_background": "Phantom Studios Inc. was founded by Alex Thompson in January to produce independent films and video content. The company is based in Zurich and operates under IFRS.",
    "transactions": [
      {
        "id": "ps1",
        "date": "Jan 1",
        "description": "Alex Thompson invests CHF 100,000 cash to start the business in exchange for common shares.",
        "solution": [
          {"account": "Cash", "type": "asset", "debit": 100000, "credit": 0},
          {"account": "Share Capital", "type": "equity", "debit": 0, "credit": 100000}
        ],
        "hint": "When owners invest cash, Cash (asset) increases and Share Capital (equity) increases."
      },
      {
        "id": "ps2",
        "date": "Jan 5",
        "description": "Phantom Studios borrows CHF 50,000 from Zurich Community Bank, signing a 2-year note payable.",
        "solution": [
          {"account": "Cash", "type": "asset", "debit": 50000, "credit": 0},
          {"account": "Notes Payable", "type": "liability", "debit": 0, "credit": 50000}
        ],
        "hint": "When borrowing money, Cash increases (debit) and a liability is created (credit)."
      },
      {
        "id": "ps3",
        "date": "Jan 10",
        "description": "Purchases camera and lighting equipment for CHF 60,000, paying cash.",
        "solution": [
          {"account": "Equipment", "type": "asset", "debit": 60000, "credit": 0},
          {"account": "Cash", "type": "asset", "debit": 0, "credit": 60000}
        ],
        "hint": "Buying equipment is an exchange of assets: Equipment increases, Cash decreases."
      },
      {
        "id": "ps4",
        "date": "Jan 15",
        "description": "Purchases office supplies on account for CHF 2,500. Payment due in 30 days.",
        "solution": [
          {"account": "Supplies", "type": "asset", "debit": 2500, "credit": 0},
          {"account": "Accounts Payable", "type": "liability", "debit": 0, "credit": 2500}
        ],
        "hint": "Buying on account means you receive the asset now and create a liability to pay later."
      },
      {
        "id": "ps5",
        "date": "Jan 20",
        "description": "Completes a commercial video project for Urban Apparel Co. and receives CHF 15,000 cash.",
        "solution": [
          {"account": "Cash", "type": "asset", "debit": 15000, "credit": 0},
          {"account": "Service Revenue", "type": "revenue", "debit": 0, "credit": 15000}
        ],
        "hint": "When earning revenue, Cash increases and Revenue is credited (increases equity)."
      },
      {
        "id": "ps6",
        "date": "Jan 25",
        "description": "Pays employees salaries of CHF 8,000 cash for work performed in January.",
        "solution": [
          {"account": "Salaries Expense", "type": "expense", "debit": 8000, "credit": 0},
          {"account": "Cash", "type": "asset", "debit": 0, "credit": 8000}
        ],
        "hint": "Paying an expense: Expense is debited (decreases equity) and Cash is credited (decreases)."
      },
      {
        "id": "ps7",
        "date": "Jan 28",
        "description": "Pays the full amount owed to the supplier from the Jan 15 purchase.",
        "solution": [
          {"account": "Accounts Payable", "type": "liability", "debit": 2500, "credit": 0},
          {"account": "Cash", "type": "asset", "debit": 0, "credit": 2500}
        ],
        "hint": "Paying off a liability: Accounts Payable is debited (decreases) and Cash is credited (decreases)."
      },
      {
        "id": "ps8",
        "date": "Jan 30",
        "description": "Completes a video project for Golden Bear Candy worth CHF 12,000. The customer will pay in February.",
        "solution": [
          {"account": "Accounts Receivable", "type": "asset", "debit": 12000, "credit": 0},
          {"account": "Service Revenue", "type": "revenue", "debit": 0, "credit": 12000}
        ],
        "hint": "Under accrual accounting, revenue is recorded when earned (work completed), even if cash comes later."
      }
    ],
    "account_options": [
      {"name": "Cash", "type": "asset"},
      {"name": "Accounts Receivable", "type": "asset"},
      {"name": "Supplies", "type": "asset"},
      {"name": "Equipment", "type": "asset"},
      {"name": "Accounts Payable", "type": "liability"},
      {"name": "Notes Payable", "type": "liability"},
      {"name": "Share Capital", "type": "equity"},
      {"name": "Service Revenue", "type": "revenue"},
      {"name": "Salaries Expense", "type": "expense"},
      {"name": "Rent Expense", "type": "expense"}
    ],
    "passing_score": 80
  }'::jsonb,
  'journal-entry-builder',
  false,
  true
),

-- ============================================
-- Activity 2.3: Understanding Current Assets
-- ============================================
(
  'fa200000-0000-0000-0002-000000000003',
  'fa000000-0000-0000-0000-000000000002',
  '2.3',
  3,
  'Understanding Current Assets',
  'understanding-current-assets',
  'lesson',
  12,
  25,
  'free',
  '{"markdown": "# Understanding Current Assets\n\n## Why This Matters\n\nCurrent assets are the lifeblood of a business - they fund day-to-day operations. Understanding them helps you assess whether a company can pay its bills and continue operating.\n\n---\n\n## What Are Current Assets?\n\n> **Current Assets** are resources expected to be converted to cash or consumed within one year (or the operating cycle, if longer).\n\n### The Key Current Assets\n\n| Asset | Description | Example |\n|-------|-------------|---------|\n| **Cash & Cash Equivalents** | Money immediately available | Bank accounts, money market funds |\n| **Accounts Receivable** | Amounts owed by customers | Sales on credit awaiting payment |\n| **Inventory** | Goods held for sale | Products in warehouse |\n| **Prepaid Expenses** | Payments made for future benefits | Prepaid insurance, prepaid rent |\n| **Short-term Investments** | Investments maturing within 1 year | Treasury bills, short-term bonds |\n\n---\n\n## Cash and Cash Equivalents\n\n### What Counts as Cash?\n\n- Currency on hand\n- Checking accounts\n- Savings accounts\n- Money market accounts\n\n### What Are Cash Equivalents?\n\nShort-term, highly liquid investments that can be converted to cash within 90 days:\n- Treasury bills\n- Commercial paper\n- Money market funds\n\n**Note:** Long-term investments and restricted cash are NOT cash equivalents.\n\n---\n\n## Accounts Receivable\n\n### The Revenue-to-Cash Cycle\n\n```\n1. Perform service or deliver goods\n           |\n           v\n2. Issue invoice to customer\n           |\n           v\n3. Record as Accounts Receivable\n           |\n           v\n4. Customer pays (30-60-90 days)\n           |\n           v\n5. Convert A/R to Cash\n```\n\n### Key Concepts\n\n- **Trade Receivables:** Amounts owed from regular business customers\n- **Non-trade Receivables:** Other amounts owed (tax refunds, employee advances)\n- **Allowance for Doubtful Accounts:** Estimated amounts that won''t be collected\n\n**Net Accounts Receivable = Gross A/R - Allowance for Doubtful Accounts**\n\n---\n\n## Inventory\n\n### Types of Inventory\n\n| Type | Description | Example |\n|------|-------------|---------|\n| **Raw Materials** | Components waiting to be used | Wood for furniture maker |\n| **Work in Progress (WIP)** | Partially completed goods | Partially assembled cars |\n| **Finished Goods** | Ready for sale | Completed products in warehouse |\n| **Merchandise** | Goods purchased for resale | Retail store stock |\n\n### Inventory Valuation\n\nInventory is recorded at the **lower of cost or net realizable value** (IFRS).\n\n---\n\n## Prepaid Expenses\n\n### The Concept\n\nWhen you pay for something in advance, you have an asset (the right to future benefit) until you use it.\n\n### Examples\n\n| Prepaid Item | What Happens |\n|--------------|---------------|\n| **Prepaid Rent** | Asset at payment; becomes expense each month |\n| **Prepaid Insurance** | Asset at payment; expense recognized over policy period |\n| **Prepaid Advertising** | Asset at payment; expense when ads run |\n\n---\n\n## Balance Sheet Presentation\n\nCurrent assets are typically listed in order of **liquidity** (how quickly they convert to cash):\n\n```\nASSETS\nCurrent Assets:\n  Cash and cash equivalents      CHF  45,000\n  Short-term investments              15,000\n  Accounts receivable, net            82,000\n  Inventory                          120,000\n  Prepaid expenses                    18,000\n  -------------------------------------------\n  Total Current Assets           CHF 280,000\n```\n\n---\n\n## Worked Example: Alpine Foods Balance Sheet\n\nAlpine Foods International has the following at December 31:\n\n| Item | Amount | Classification |\n|------|--------|----------------|\n| Cash in bank | CHF 125,000 | Current Asset |\n| Equipment | CHF 450,000 | Non-Current Asset |\n| Accounts Receivable | CHF 85,000 | Current Asset |\n| Prepaid Insurance (6 months remaining) | CHF 6,000 | Current Asset |\n| Inventory | CHF 230,000 | Current Asset |\n| Land | CHF 800,000 | Non-Current Asset |\n\n**Total Current Assets = 125,000 + 85,000 + 6,000 + 230,000 = CHF 446,000**\n\n---\n\n## Why Current Assets Matter\n\n### Liquidity Assessment\n\nCurrent assets help answer: Can the company pay its short-term obligations?\n\n**Working Capital = Current Assets - Current Liabilities**\n\nPositive working capital = Company can meet short-term obligations\nNegative working capital = Potential liquidity problems\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Current assets convert to cash within 1 year\n> - Listed in order of liquidity: Cash, Receivables, Inventory, Prepaids\n> - A/R represents sales on credit not yet collected\n> - Prepaid expenses are assets until the benefit is used\n> - Net A/R = Gross A/R - Allowance for Doubtful Accounts"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.4: Non-Current Assets & Liabilities
-- ============================================
(
  'fa200000-0000-0000-0002-000000000004',
  'fa000000-0000-0000-0000-000000000002',
  '2.4',
  4,
  'Non-Current Assets, Liabilities & Equity',
  'non-current-assets-liabilities-equity',
  'lesson',
  15,
  30,
  'free',
  '{"markdown": "# Non-Current Assets, Liabilities & Equity\n\n## Why This Matters\n\nWhile current assets fund day-to-day operations, non-current assets represent a company''s long-term investments in its future. Similarly, non-current liabilities show how the company finances these investments.\n\n---\n\n## Non-Current Assets\n\n> **Non-Current Assets** (also called Long-term Assets or Fixed Assets) are resources that will benefit the company for more than one year.\n\n### Categories of Non-Current Assets\n\n| Category | Examples | Characteristics |\n|----------|----------|------------------|\n| **Property, Plant & Equipment (PP&E)** | Buildings, machinery, vehicles, furniture | Tangible, used in operations |\n| **Intangible Assets** | Patents, trademarks, goodwill | No physical form, provide rights |\n| **Long-term Investments** | Shares in other companies, bonds | Financial assets held >1 year |\n| **Right-of-Use Assets** | Leased buildings, equipment | Assets from lease contracts (IFRS 16) |\n\n---\n\n## Property, Plant & Equipment\n\n### Recording PP&E\n\nPP&E is recorded at **cost**, which includes:\n- Purchase price\n- Transportation costs\n- Installation costs\n- Any costs necessary to prepare the asset for use\n\n### Example: Equipment Purchase\n\nPurchased manufacturing equipment:\n- List price: CHF 100,000\n- Delivery: CHF 2,000\n- Installation: CHF 8,000\n- Training for operators: CHF 5,000\n\n**Capitalized Cost = 100,000 + 2,000 + 8,000 = CHF 110,000**\n\n*Note: Training cost is expensed, not capitalized, because it doesn''t enhance the asset itself.*\n\n---\n\n## Depreciation Preview\n\nPP&E (except land) loses value over time. **Depreciation** allocates the cost over the asset''s useful life.\n\n```\n           ASSET COST\n                |\n                v\n     DEPRECIATION EXPENSE\n     (allocated over useful life)\n                |\n                v\n       ACCUMULATED DEPRECIATION\n       (total depreciation to date)\n```\n\n**Book Value = Cost - Accumulated Depreciation**\n\n*We''ll cover depreciation methods in Module 7.*\n\n---\n\n## Intangible Assets\n\n### Types of Intangibles\n\n| Type | Description | Amortization |\n|------|-------------|---------------|\n| **Patents** | Exclusive right to an invention | Amortized over useful life |\n| **Trademarks** | Brand names, logos | Indefinite life - tested for impairment |\n| **Copyrights** | Exclusive right to creative works | Amortized over useful life |\n| **Goodwill** | Premium paid in acquisitions | Indefinite life - tested for impairment |\n| **Software** | Purchased or developed software | Amortized over useful life |\n\n---\n\n## Current Liabilities\n\n> **Current Liabilities** are obligations due within one year.\n\n### Common Current Liabilities\n\n| Liability | Description |\n|-----------|-------------|\n| **Accounts Payable** | Amounts owed to suppliers |\n| **Accrued Expenses** | Expenses incurred but not yet paid (wages, utilities) |\n| **Unearned Revenue** | Cash received before service is provided |\n| **Short-term Loans** | Bank loans due within 1 year |\n| **Current Portion of Long-term Debt** | The part of long-term debt due this year |\n| **Income Tax Payable** | Taxes owed to the government |\n\n---\n\n## Non-Current Liabilities\n\n> **Non-Current Liabilities** are obligations due after one year.\n\n### Common Non-Current Liabilities\n\n| Liability | Description |\n|-----------|-------------|\n| **Notes Payable** | Bank loans due after 1 year |\n| **Bonds Payable** | Corporate bonds issued to investors |\n| **Lease Liabilities** | Obligations under lease contracts (IFRS 16) |\n| **Deferred Tax Liabilities** | Taxes payable in future periods |\n| **Pension Obligations** | Future retirement benefits owed to employees |\n\n---\n\n## Shareholders'' Equity\n\n> **Equity** represents the owners'' residual claim on assets after liabilities are paid.\n\n### Components of Equity\n\n| Component | Description |\n|-----------|-------------|\n| **Share Capital** | Amount invested by shareholders for shares |\n| **Share Premium** | Amount received above par value of shares |\n| **Retained Earnings** | Accumulated profits not distributed as dividends |\n| **Other Reserves** | Revaluation reserves, translation reserves |\n| **Treasury Shares** | Company''s own shares repurchased (reduces equity) |\n\n### The Retained Earnings Equation\n\n```\nEnding Retained Earnings = Beginning Retained Earnings\n                          + Net Income\n                          - Dividends Declared\n```\n\n---\n\n## Complete Balance Sheet Format\n\n```\n                    ALPINE FOODS INTERNATIONAL\n                         BALANCE SHEET\n                     As at December 31, 2024\n\nASSETS\n  Current Assets:\n    Cash and cash equivalents              CHF   450,000\n    Accounts receivable, net                     380,000\n    Inventory                                    520,000\n    Prepaid expenses                              50,000\n    Total Current Assets                       1,400,000\n\n  Non-Current Assets:\n    Property, plant & equipment, net           2,800,000\n    Intangible assets                            400,000\n    Long-term investments                        200,000\n    Total Non-Current Assets                   3,400,000\n\n  TOTAL ASSETS                             CHF 4,800,000\n\nLIABILITIES AND EQUITY\n  Current Liabilities:\n    Accounts payable                       CHF   290,000\n    Accrued expenses                             110,000\n    Unearned revenue                              80,000\n    Current portion of long-term debt            120,000\n    Total Current Liabilities                    600,000\n\n  Non-Current Liabilities:\n    Long-term debt                             1,200,000\n    Deferred tax liabilities                     150,000\n    Total Non-Current Liabilities              1,350,000\n\n  Total Liabilities                            1,950,000\n\n  Shareholders'' Equity:\n    Share capital                              1,000,000\n    Share premium                                350,000\n    Retained earnings                          1,500,000\n    Total Shareholders'' Equity                2,850,000\n\n  TOTAL LIABILITIES AND EQUITY             CHF 4,800,000\n```\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Non-current assets benefit the company for >1 year\n> - PP&E is recorded at cost (purchase + delivery + installation)\n> - Book Value = Cost - Accumulated Depreciation\n> - Intangibles with definite lives are amortized; indefinite lives are tested for impairment\n> - Current Liabilities are due within 1 year\n> - Retained Earnings = Accumulated Profits - Dividends"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.5: Balance Sheet Quiz
-- ============================================
(
  'fa200000-0000-0000-0002-000000000005',
  'fa000000-0000-0000-0000-000000000002',
  '2.5',
  5,
  'Balance Sheet Concepts Quiz',
  'balance-sheet-concepts-quiz',
  'quiz',
  12,
  35,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which of the following accounts has a normal DEBIT balance?",
        "options": [
          "Accounts Payable",
          "Revenue",
          "Inventory",
          "Share Capital"
        ],
        "correct": 2,
        "explanation": "Inventory is an asset, and assets have normal debit balances. Accounts Payable and Share Capital have credit balances. Revenue also has a credit balance."
      },
      {
        "id": "q2",
        "type": "true_false",
        "difficulty": "basic",
        "question": "When a company receives cash from customers for services already performed, the journal entry includes a debit to Cash and a credit to Service Revenue.",
        "correct": true,
        "explanation": "TRUE. Cash (asset) increases with a debit, and Service Revenue (which increases equity) is credited. This properly records earned revenue."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A company pays CHF 5,000 cash for rent. Which journal entry is correct?",
        "options": [
          "Debit Cash, Credit Rent Expense",
          "Debit Rent Expense, Credit Cash",
          "Debit Cash, Credit Accounts Payable",
          "Debit Prepaid Rent, Credit Cash"
        ],
        "correct": 1,
        "explanation": "Rent Expense is debited (expenses increase with debits) and Cash is credited (assets decrease with credits). Option D would be correct only if paying for future rent."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Metro Properties Inc. purchases office furniture for CHF 15,000, paying CHF 5,000 cash and signing a note for the remainder. How does this affect total assets?",
        "options": [
          "Increase by CHF 15,000",
          "Increase by CHF 10,000",
          "Increase by CHF 5,000",
          "No change to total assets"
        ],
        "correct": 1,
        "explanation": "Furniture increases by +15,000, Cash decreases by -5,000. Net effect on assets = +10,000. Note that the Note Payable (liability) also increases by 10,000, keeping the equation balanced."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which item would NOT be classified as a current asset?",
        "options": [
          "Accounts Receivable",
          "Prepaid Insurance (12-month policy)",
          "Land held for future expansion",
          "Inventory"
        ],
        "correct": 2,
        "explanation": "Land is a non-current asset because it is not held for sale and is expected to be held long-term. Even though the prepaid insurance is for 12 months, it is consumed within one year and classified as current."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A company receives CHF 3,000 from a customer for services to be performed next month. The correct entry is:",
        "options": [
          "Debit Cash, Credit Service Revenue",
          "Debit Accounts Receivable, Credit Service Revenue",
          "Debit Cash, Credit Unearned Revenue",
          "Debit Service Revenue, Credit Cash"
        ],
        "correct": 2,
        "explanation": "Since the service hasn''t been performed yet, revenue cannot be recognized. Cash increases (debit) and Unearned Revenue (a liability) is credited. The liability represents the obligation to perform the service."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Nova Energy Corp begins the year with Retained Earnings of CHF 500,000. During the year, it earns Net Income of CHF 150,000 and declares dividends of CHF 40,000. What is ending Retained Earnings?",
        "options": [
          "CHF 690,000",
          "CHF 650,000",
          "CHF 610,000",
          "CHF 550,000"
        ],
        "correct": 2,
        "explanation": "Ending RE = Beginning RE + Net Income - Dividends = 500,000 + 150,000 - 40,000 = CHF 610,000."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Equipment is purchased for CHF 80,000 (list price CHF 75,000, delivery CHF 3,000, installation CHF 2,000). What is the capitalized cost?",
        "options": [
          "CHF 75,000",
          "CHF 78,000",
          "CHF 80,000",
          "CHF 82,000"
        ],
        "correct": 2,
        "explanation": "The capitalized cost includes all costs necessary to get the asset ready for use: 75,000 + 3,000 + 2,000 = CHF 80,000."
      },
      {
        "id": "q9",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Goodwill is an intangible asset that arises when a company is acquired for more than the fair value of its identifiable net assets.",
        "correct": true,
        "explanation": "TRUE. Goodwill represents the premium paid in an acquisition above the fair value of identifiable assets less liabilities. It captures value from factors like reputation, customer relationships, and synergies."
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Alpine Foods has Total Assets of CHF 5,000,000 and Total Liabilities of CHF 2,000,000. If the company issues CHF 500,000 in new shares for cash, what are the new totals?",
        "options": [
          "Assets: CHF 5,000,000; Equity: CHF 3,500,000",
          "Assets: CHF 5,500,000; Equity: CHF 3,500,000",
          "Assets: CHF 5,500,000; Equity: CHF 3,000,000",
          "Assets: CHF 5,000,000; Equity: CHF 3,000,000"
        ],
        "correct": 1,
        "explanation": "Cash (asset) increases by 500,000, so Total Assets = 5,500,000. Share Capital (equity) increases by 500,000, so Equity = (5,000,000 - 2,000,000) + 500,000 = 3,500,000. Liabilities unchanged at 2,000,000."
      }
    ],
    "passing_score": 70,
    "show_explanations": true
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.6: Trial Balance Exercise
-- ============================================
(
  'fa200000-0000-0000-0002-000000000006',
  'fa000000-0000-0000-0000-000000000002',
  '2.6',
  6,
  'Preparing a Trial Balance',
  'preparing-trial-balance',
  'interactive',
  15,
  40,
  'free',
  '{
    "title": "Build the Trial Balance: Phantom Studios",
    "description": "Using the transactions from the Phantom Studios journal entry exercise, prepare a trial balance as of January 31.",
    "instructions": "List all accounts with their debit or credit balances. Total debits must equal total credits.",
    "starting_balances": [],
    "transactions_summary": [
      "Jan 1: Owner investment CHF 100,000",
      "Jan 5: Bank loan CHF 50,000",
      "Jan 10: Equipment purchase CHF 60,000",
      "Jan 15: Supplies on account CHF 2,500",
      "Jan 20: Service revenue (cash) CHF 15,000",
      "Jan 25: Salaries expense CHF 8,000",
      "Jan 28: Paid accounts payable CHF 2,500",
      "Jan 30: Service revenue (on account) CHF 12,000"
    ],
    "solution": {
      "accounts": [
        {"name": "Cash", "debit": 94500, "credit": 0},
        {"name": "Accounts Receivable", "debit": 12000, "credit": 0},
        {"name": "Supplies", "debit": 2500, "credit": 0},
        {"name": "Equipment", "debit": 60000, "credit": 0},
        {"name": "Accounts Payable", "debit": 0, "credit": 0},
        {"name": "Notes Payable", "debit": 0, "credit": 50000},
        {"name": "Share Capital", "debit": 0, "credit": 100000},
        {"name": "Service Revenue", "debit": 0, "credit": 27000},
        {"name": "Salaries Expense", "debit": 8000, "credit": 0}
      ],
      "total_debits": 177000,
      "total_credits": 177000
    },
    "hints": [
      "Cash: Start with 100,000 (investment) + 50,000 (loan) + 15,000 (revenue) - 60,000 (equipment) - 8,000 (salaries) - 2,500 (payable payment) = 94,500",
      "Service Revenue: 15,000 (cash) + 12,000 (on account) = 27,000",
      "Accounts Payable: 2,500 added, then 2,500 paid = 0 balance"
    ],
    "passing_score": 100
  }'::jsonb,
  'trial-balance-builder',
  false,
  true
),

-- ============================================
-- Activity 2.7: Module 2 Checkpoint
-- ============================================
(
  'fa200000-0000-0000-0002-000000000007',
  'fa000000-0000-0000-0000-000000000002',
  '2.7',
  7,
  'Module 2 Checkpoint',
  'module-2-checkpoint',
  'checkpoint',
  15,
  50,
  'free',
  '{
    "questions": [
      {
        "id": "c1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which of the following journal entries correctly records a cash purchase of equipment for CHF 25,000?",
        "options": [
          "Debit Equipment CHF 25,000; Credit Accounts Payable CHF 25,000",
          "Debit Cash CHF 25,000; Credit Equipment CHF 25,000",
          "Debit Equipment CHF 25,000; Credit Cash CHF 25,000",
          "Debit Accounts Payable CHF 25,000; Credit Equipment CHF 25,000"
        ],
        "correct": 2,
        "explanation": "When purchasing equipment with cash: Equipment (asset) increases with a debit, and Cash (asset) decreases with a credit."
      },
      {
        "id": "c2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Golden Bear Candy Company has the following trial balance totals: Total Debits = CHF 450,000; Total Credits = CHF 445,000. What does this indicate?",
        "options": [
          "The company is profitable",
          "There is an error in the accounting records",
          "Assets exceed liabilities",
          "The trial balance is correct"
        ],
        "correct": 1,
        "explanation": "In a trial balance, total debits MUST equal total credits. A difference of CHF 5,000 indicates an error in recording or posting transactions."
      },
      {
        "id": "c3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Swiss Confections receives CHF 10,000 from a customer for chocolate boxes to be delivered next month. The correct journal entry is:",
        "options": [
          "Debit Cash; Credit Sales Revenue",
          "Debit Accounts Receivable; Credit Sales Revenue",
          "Debit Cash; Credit Unearned Revenue",
          "Debit Unearned Revenue; Credit Cash"
        ],
        "correct": 2,
        "explanation": "Cash received for future delivery creates a liability (Unearned Revenue) until the goods are delivered. Debit Cash (increases), Credit Unearned Revenue (liability increases)."
      },
      {
        "id": "c4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Metro Properties purchases land for CHF 200,000 with CHF 50,000 cash and a CHF 150,000 mortgage. How is total equity affected?",
        "options": [
          "Increases by CHF 200,000",
          "Increases by CHF 50,000",
          "Decreases by CHF 50,000",
          "No change"
        ],
        "correct": 3,
        "explanation": "This transaction only affects assets (Land +200,000, Cash -50,000) and liabilities (Mortgage +150,000). Assets: +200,000 - 50,000 = +150,000 = Liabilities: +150,000. Equity is unchanged."
      },
      {
        "id": "c5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which of the following is classified as a current liability?",
        "options": [
          "Mortgage payable (20-year term)",
          "Bonds payable (due in 5 years)",
          "Accounts payable",
          "Pension obligations"
        ],
        "correct": 2,
        "explanation": "Accounts payable is typically due within 30-90 days, making it a current liability. The mortgage, bonds, and pension obligations are long-term (non-current) liabilities."
      },
      {
        "id": "c6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Phantom Studios has the following account balances: Cash CHF 50,000; Accounts Receivable CHF 30,000; Equipment CHF 100,000; Accounts Payable CHF 25,000; Notes Payable CHF 75,000; Share Capital CHF 80,000. What is Retained Earnings?",
        "options": [
          "CHF 0",
          "CHF 80,000",
          "CHF 100,000",
          "Cannot be determined"
        ],
        "correct": 0,
        "explanation": "Assets = 50,000 + 30,000 + 100,000 = 180,000. Liabilities = 25,000 + 75,000 = 100,000. Equity = 180,000 - 100,000 = 80,000. Since Share Capital = 80,000, Retained Earnings = 0."
      },
      {
        "id": "c7",
        "type": "true_false",
        "difficulty": "exam",
        "question": "A company that pays cash to reduce its accounts payable will see a decrease in both assets and liabilities.",
        "correct": true,
        "explanation": "TRUE. Cash (asset) decreases with a credit, and Accounts Payable (liability) decreases with a debit. Both sides decrease by the same amount, keeping the equation balanced."
      },
      {
        "id": "c8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Luxe Maison Group acquires a building for CHF 500,000. Related costs include: legal fees CHF 15,000, property taxes prepaid for next year CHF 8,000, and repairs to roof CHF 12,000 to make it usable. What is the capitalized cost of the building?",
        "options": [
          "CHF 500,000",
          "CHF 515,000",
          "CHF 527,000",
          "CHF 535,000"
        ],
        "correct": 2,
        "explanation": "Capitalize purchase price (500,000) + legal fees (15,000) + necessary repairs (12,000) = 527,000. Prepaid property taxes are recorded as a prepaid expense, not part of building cost."
      }
    ],
    "passing_score": 75,
    "show_explanations": true
  }'::jsonb,
  NULL,
  true,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;


