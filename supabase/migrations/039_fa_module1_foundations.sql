-- ============================================
-- Module 1: Welcome to Financial Accounting
-- GOLD STANDARD Content - Accounting Foundations
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 1.1: Welcome to Financial Accounting
-- ============================================
(
  'fa100000-0000-0000-0001-000000000001',
  'fa000000-0000-0000-0000-000000000001',
  '1.1',
  1,
  'Welcome to Financial Accounting',
  'welcome-to-financial-accounting',
  'lesson',
  12,
  20,
  'free',
  '{"markdown": "# Welcome to Financial Accounting\n\n## Why This Matters\n\nImagine you''re considering investing your savings in a company. How do you know if it''s financially healthy? Or suppose you''re a manager making a budget decision. How do you measure success?\n\n**Financial accounting provides the language and tools to answer these questions.** It''s the universal language of business, understood across industries and countries.\n\n> \"Accounting is the language of business.\" - Warren Buffett\n\n---\n\n## What is Financial Accounting?\n\n**Financial Accounting** is the process of recording, summarizing, and reporting a company''s business transactions to provide useful information for decision-makers.\n\n### The Core Purpose\n\nFinancial accounting answers three fundamental questions:\n\n| Question | Financial Statement | What It Shows |\n|----------|--------------------|--------------|\n| What does the company **own and owe**? | Balance Sheet | Financial position at a point in time |\n| Did the company **make money**? | Income Statement | Profitability over a period |\n| Where did the **cash go**? | Cash Flow Statement | Cash movements over a period |\n\n---\n\n## The Three Financial Statements\n\n```\n              THE THREE FINANCIAL STATEMENTS\n              \n    BALANCE SHEET         INCOME STATEMENT       CASH FLOW STATEMENT\n                                                 \n     ASSETS                 REVENUE                OPERATING\n        -                      -                   INVESTING\n   LIABILITIES              EXPENSES              FINANCING\n        =                      =                      =\n      EQUITY               NET INCOME            NET CASH CHANGE\n     \n    [A point in time]      [Over a period]       [Over a period]\n\n```\n\n### Balance Sheet\nA snapshot of what the company owns (assets), owes (liabilities), and the owners'' stake (equity) at a specific date.\n\n### Income Statement\nShows revenues earned and expenses incurred over a period (month, quarter, year), resulting in net income or loss.\n\n### Cash Flow Statement\nTracks actual cash movements: where cash came from and where it went.\n\n---\n\n## Who Uses Financial Statements?\n\n### External Users\n\n| User | What They Want to Know |\n|------|------------------------|\n| **Investors** | Is this company a good investment? Will it grow? |\n| **Creditors/Banks** | Can this company repay loans? Is it creditworthy? |\n| **Regulators** | Is the company following the rules? |\n| **Suppliers** | Will I get paid if I extend credit? |\n| **Customers** | Is this company stable enough to honor warranties? |\n\n### Internal Users\n\n| User | What They Want to Know |\n|------|------------------------|\n| **Managers** | How are we performing? Where should we invest? |\n| **Employees** | Is my job secure? Can I negotiate a raise? |\n| **Board of Directors** | Is management doing a good job? |\n\n---\n\n## Real-World Analogy: Your Personal Finances\n\nThink about your own finances:\n\n**Your Personal Balance Sheet:**\n- **Assets:** Cash in bank, car, laptop, investments\n- **Liabilities:** Student loans, credit card balance\n- **Equity:** Your net worth = Assets - Liabilities\n\n**Your Personal Income Statement:**\n- **Revenue:** Salary, side income\n- **Expenses:** Rent, food, entertainment\n- **Net Income:** What''s left over (or deficit if overspent)\n\n**Your Personal Cash Flow:**\n- Money coming in (paychecks)\n- Money going out (bills, purchases)\n- Net change in your bank balance\n\nCompany accounting works exactly the same way, just at a larger scale!\n\n---\n\n## What You''ll Learn in This Course\n\n### Course Roadmap\n\n| Module | Topic | Key Skills |\n|--------|-------|------------|\n| 1-2 | Foundations & Balance Sheet | Accounting equation, journal entries |\n| 3 | Income Statement | Revenue recognition, expenses |\n| 4 | Adjustments | Accruals, deferrals, depreciation |\n| 5-6 | Receivables & Inventory | A/R management, FIFO/LIFO |\n| 7-8 | Assets & Liabilities | Depreciation, bonds, equity |\n| 9 | Cash Flow Statement | Building CFS from scratch |\n| 10 | Financial Analysis | Ratios, Du Pont, interpretation |\n\n---\n\n## Common Misconceptions\n\n| Myth | Reality |\n|------|--------|\n| \"Accounting is just math\" | It''s about judgment, interpretation, and communication |\n| \"Accountants just record numbers\" | They analyze, advise, and help make strategic decisions |\n| \"Financial statements are exact\" | They involve estimates and professional judgment |\n| \"Profit = Cash\" | A company can be profitable but run out of cash |\n\n---\n\n## Pro Tips for Success\n\n1. **Master the accounting equation first** - Everything else builds on it\n2. **Think in debits and credits** - It becomes second nature\n3. **Always ask: What accounts are affected?** - Every transaction touches at least two accounts\n4. **Practice with real examples** - The more transactions you analyze, the better\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Financial accounting provides information for decision-makers\n> - Three main statements: Balance Sheet, Income Statement, Cash Flow Statement\n> - Users include investors, creditors, managers, and regulators\n> - Profit does NOT equal cash\n\nReady to discover the accounting equation? Let''s continue!"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 1.2: The Accounting Equation
-- ============================================
(
  'fa100000-0000-0000-0001-000000000002',
  'fa000000-0000-0000-0000-000000000001',
  '1.2',
  2,
  'The Accounting Equation',
  'the-accounting-equation',
  'lesson',
  15,
  25,
  'free',
  '{"markdown": "# The Accounting Equation\n\n## Why This Matters\n\nEvery single transaction in accounting - from buying paperclips to acquiring a billion-dollar company - follows one fundamental rule. Master this equation, and everything else in accounting makes sense.\n\n> **The Accounting Equation:** Assets = Liabilities + Equity\n\nOr rearranged: **A = L + E**\n\nThis equation must ALWAYS balance. Always. No exceptions.\n\n---\n\n## Understanding the Components\n\n### Assets (A)\n\n**Definition:** Resources owned by the company that provide future economic benefits.\n\n| Asset Type | Examples |\n|------------|----------|\n| **Current Assets** | Cash, Accounts Receivable, Inventory, Prepaid Expenses |\n| **Non-Current Assets** | Property, Plant & Equipment, Intangible Assets, Long-term Investments |\n\n**Key Test:** Does the company control it? Will it provide future benefit?\n\n### Liabilities (L)\n\n**Definition:** Obligations to pay others in the future.\n\n| Liability Type | Examples |\n|----------------|----------|\n| **Current Liabilities** | Accounts Payable, Wages Payable, Unearned Revenue |\n| **Non-Current Liabilities** | Bank Loans, Bonds Payable, Long-term Lease Obligations |\n\n**Key Test:** Does the company owe it to someone else?\n\n### Equity (E)\n\n**Definition:** The owners'' residual interest after liabilities are paid. Also called Shareholders'' Equity or Net Worth.\n\n| Equity Component | Description |\n|------------------|-------------|\n| **Contributed Capital** | Money invested by owners (share capital) |\n| **Retained Earnings** | Accumulated profits not distributed as dividends |\n\n**Key Formula:** Equity = Assets - Liabilities\n\n---\n\n## The Balance Sheet Visualization\n\n```\n           THE BALANCE SHEET EQUATION\n           \n    =================================\n    |         |          |          |\n    | ASSETS  |  LIAB-   |  EQUITY  |\n    |         |  ILITIES |          |\n    |         |          |          |\n    | What    |  What    |  What    |\n    | the     |  the     |  owners  |\n    | company |  company |  are     |\n    | OWNS    |  OWES    |  owed    |\n    |         |          |          |\n    =================================\n    \n    ASSETS  =  LIABILITIES + EQUITY\n    \n```\n\n### Think of it as Sources and Uses\n\n- **Left side (Assets):** How resources are USED\n- **Right side (L + E):** Where resources come FROM\n  - Liabilities = Borrowed from creditors\n  - Equity = Invested by owners + Earned profits\n\n---\n\n## Worked Example 1: Starting a Business\n\nMaria starts a catering company called Gourmet Delights:\n\n**Step 1:** Maria invests CHF 50,000 of her own money\n\n| Assets | = | Liabilities | + | Equity |\n|--------|---|-------------|---|--------|\n| +50,000 Cash | = | 0 | + | +50,000 (Share Capital) |\n| **50,000** | = | **0** | + | **50,000** |\n\nThe equation balances!\n\n**Step 2:** Borrows CHF 20,000 from a bank\n\n| Assets | = | Liabilities | + | Equity |\n|--------|---|-------------|---|--------|\n| +20,000 Cash | = | +20,000 Bank Loan | + | 0 |\n| **70,000** | = | **20,000** | + | **50,000** |\n\nStill balanced! Assets increased, but so did liabilities.\n\n**Step 3:** Buys kitchen equipment for CHF 30,000 cash\n\n| Assets | = | Liabilities | + | Equity |\n|--------|---|-------------|---|--------|\n| -30,000 Cash | | | | |\n| +30,000 Equipment | = | 0 | + | 0 |\n| **70,000** | = | **20,000** | + | **50,000** |\n\nAssets change form (cash to equipment) but total stays the same.\n\n---\n\n## Worked Example 2: Transactions Analysis\n\nLet''s trace through a week at Gourmet Delights:\n\n### Transaction A: Buy supplies on credit (CHF 5,000)\n\n| Change | Account | Effect |\n|--------|---------|--------|\n| Assets | +Supplies | +5,000 |\n| Liabilities | +Accounts Payable | +5,000 |\n\nResult: A = L + E still balances\n\n### Transaction B: Provide catering services for CHF 8,000 cash\n\n| Change | Account | Effect |\n|--------|---------|--------|\n| Assets | +Cash | +8,000 |\n| Equity | +Revenue (Retained Earnings) | +8,000 |\n\nResult: Assets increased, Equity increased (from earning revenue)\n\n### Transaction C: Pay employees CHF 3,000\n\n| Change | Account | Effect |\n|--------|---------|--------|\n| Assets | -Cash | -3,000 |\n| Equity | -Expense (Retained Earnings) | -3,000 |\n\nResult: Assets decreased, Equity decreased (from paying expenses)\n\n---\n\n## The Expanded Equation\n\nFor more detail, we can expand Equity:\n\n```\nAssets = Liabilities + Share Capital + Retained Earnings\n\n       = Liabilities + Share Capital + (Revenues - Expenses - Dividends)\n```\n\nThis shows how the Income Statement connects to the Balance Sheet!\n\n---\n\n## Common Mistakes\n\n### Mistake 1: Thinking Cash = Profit\nA company can have CHF 1,000,000 in cash but still be losing money. Or be profitable but have no cash.\n\n### Mistake 2: Confusing Equity with Cash\nEquity is a claim, not a pool of money. A company might have CHF 500,000 equity but only CHF 10,000 in the bank (the rest is in inventory, equipment, etc.).\n\n### Mistake 3: One-Sided Entries\nEvery transaction affects at least TWO things. If cash goes up, something else must change too.\n\n---\n\n## Pro Tips\n\n1. **Always check the equation** - If it doesn''t balance, something''s wrong\n2. **Assets answer: What do we have?** - Think resources\n3. **L + E answers: Where did it come from?** - Think sources\n4. **Revenue increases equity** - It''s added to Retained Earnings\n5. **Expenses decrease equity** - Subtracted from Retained Earnings\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - A = L + E must ALWAYS balance\n> - Assets = Resources owned with future economic benefit\n> - Liabilities = Obligations to pay others\n> - Equity = Residual claim (Assets - Liabilities)\n> - Every transaction affects at least two items\n> - Revenue increases equity; Expenses decrease equity"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 1.3: Accounting Equation Quiz
-- ============================================
(
  'fa100000-0000-0000-0001-000000000003',
  'fa000000-0000-0000-0000-000000000001',
  '1.3',
  3,
  'Accounting Equation Quiz',
  'accounting-equation-quiz',
  'quiz',
  10,
  30,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is the fundamental accounting equation?",
        "options": [
          "Assets = Liabilities - Equity",
          "Assets = Liabilities + Equity",
          "Assets + Liabilities = Equity",
          "Equity = Assets + Liabilities"
        ],
        "correct": 1,
        "explanation": "The fundamental accounting equation is Assets = Liabilities + Equity. This equation must always balance and forms the foundation of the entire double-entry bookkeeping system."
      },
      {
        "id": "q2",
        "type": "true_false",
        "difficulty": "basic",
        "question": "The accounting equation can temporarily be out of balance during normal business operations.",
        "correct": false,
        "explanation": "FALSE. The accounting equation must ALWAYS balance. If it doesn''t, an error has been made. Every valid transaction maintains the balance of the equation."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which of the following is an example of an ASSET?",
        "options": [
          "Wages owed to employees",
          "Bank loan",
          "Inventory",
          "Share capital"
        ],
        "correct": 2,
        "explanation": "Inventory is an asset because it''s a resource owned by the company that will provide future economic benefit (when sold). Wages owed and bank loans are liabilities. Share capital is part of equity."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "If a company has Assets of CHF 500,000 and Liabilities of CHF 300,000, what is the Equity?",
        "options": [
          "CHF 800,000",
          "CHF 300,000",
          "CHF 200,000",
          "CHF 500,000"
        ],
        "correct": 2,
        "explanation": "Using the equation A = L + E, we rearrange to E = A - L. So Equity = 500,000 - 300,000 = CHF 200,000."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A company buys a delivery truck for CHF 40,000 cash. How does this affect the accounting equation?",
        "options": [
          "Assets increase by CHF 40,000",
          "Assets decrease by CHF 40,000",
          "Assets stay the same (one asset replaced by another)",
          "Liabilities increase by CHF 40,000"
        ],
        "correct": 2,
        "explanation": "When buying an asset with cash, one asset (Cash) decreases while another asset (Vehicle) increases by the same amount. Total assets remain unchanged. This is called an exchange of assets."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A company receives CHF 15,000 cash from customers for services performed. How does this affect the equation?",
        "options": [
          "Assets increase, Liabilities increase",
          "Assets increase, Equity increases",
          "Assets decrease, Equity decreases",
          "Assets increase, Liabilities decrease"
        ],
        "correct": 1,
        "explanation": "When a company earns revenue, Cash (asset) increases, and Revenue (which flows into Retained Earnings/Equity) increases. Both sides of the equation increase by the same amount."
      },
      {
        "id": "q7",
        "type": "true_false",
        "difficulty": "applied",
        "question": "When a company borrows money from a bank, both Assets and Liabilities increase.",
        "correct": true,
        "explanation": "TRUE. When borrowing money, Cash (an asset) increases, and Bank Loan (a liability) increases by the same amount. The equation remains balanced: A + X = L + X + E."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A company pays CHF 2,000 cash for rent expense. How does this affect equity?",
        "options": [
          "Equity increases",
          "Equity decreases",
          "Equity stays the same",
          "Cannot determine from this information"
        ],
        "correct": 1,
        "explanation": "Expenses decrease equity. When paying rent, Cash (asset) decreases and Rent Expense reduces Retained Earnings (equity). Both sides of the equation decrease by CHF 2,000."
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Metro Properties Inc. starts with Assets of CHF 100,000, Liabilities of CHF 40,000, and Equity of CHF 60,000. During the month: (1) Earned revenue of CHF 25,000 on account, (2) Paid expenses of CHF 15,000 cash. What is the ending Equity?",
        "options": [
          "CHF 60,000",
          "CHF 70,000",
          "CHF 85,000",
          "CHF 45,000"
        ],
        "correct": 1,
        "explanation": "Starting Equity = 60,000. Revenue increases equity by 25,000. Expenses decrease equity by 15,000. Ending Equity = 60,000 + 25,000 - 15,000 = CHF 70,000."
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which statement is TRUE about the relationship between the Balance Sheet and Income Statement?",
        "options": [
          "They are completely independent statements",
          "Net income from the Income Statement flows into Retained Earnings on the Balance Sheet",
          "Total assets must equal total revenues",
          "Liabilities equal expenses"
        ],
        "correct": 1,
        "explanation": "The Income Statement and Balance Sheet are connected through Retained Earnings. Net Income (Revenues - Expenses) increases Retained Earnings, which is part of Equity on the Balance Sheet."
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Alpine Foods International declares and pays a dividend of CHF 10,000 to shareholders. How does this affect the accounting equation?",
        "options": [
          "Assets decrease, Liabilities decrease",
          "Assets decrease, Equity decreases",
          "Assets stay the same, Equity decreases",
          "No effect on the equation"
        ],
        "correct": 1,
        "explanation": "Dividends are distributions to owners, not expenses. When paid: Cash (asset) decreases and Retained Earnings (equity) decreases. The equation remains balanced: A - X = L + E - X."
      },
      {
        "id": "q12",
        "type": "true_false",
        "difficulty": "exam",
        "question": "If a company has positive equity, it means the company has cash available to pay dividends.",
        "correct": false,
        "explanation": "FALSE. Equity is a claim, not cash. A company can have large positive equity but very little cash (with assets tied up in inventory, equipment, etc.). Cash availability depends on the composition of assets, not just total equity."
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
-- Activity 1.4: Transaction Impact Interactive
-- ============================================
(
  'fa100000-0000-0000-0001-000000000004',
  'fa000000-0000-0000-0000-000000000001',
  '1.4',
  4,
  'Transaction Impact Practice',
  'transaction-impact-practice',
  'interactive',
  12,
  35,
  'free',
  '{
    "title": "Analyze Transaction Impacts",
    "description": "For each transaction, identify how it affects the accounting equation. Drag the correct impact to each element.",
    "instructions": "Match each transaction with its effect on Assets, Liabilities, and Equity. Some elements may have no change.",
    "scenario": "Phantom Studios Inc. is a new entertainment company. Analyze how each transaction affects the accounting equation.",
    "items": [
      {
        "id": "t1",
        "transaction": "Owners invest CHF 100,000 cash to start the business",
        "asset_effect": "increase",
        "asset_account": "Cash +100,000",
        "liability_effect": "no_change",
        "liability_account": "",
        "equity_effect": "increase",
        "equity_account": "Share Capital +100,000"
      },
      {
        "id": "t2",
        "transaction": "Borrow CHF 50,000 from the bank",
        "asset_effect": "increase",
        "asset_account": "Cash +50,000",
        "liability_effect": "increase",
        "liability_account": "Bank Loan +50,000",
        "equity_effect": "no_change",
        "equity_account": ""
      },
      {
        "id": "t3",
        "transaction": "Purchase film equipment for CHF 80,000 cash",
        "asset_effect": "no_change",
        "asset_account": "Cash -80,000, Equipment +80,000",
        "liability_effect": "no_change",
        "liability_account": "",
        "equity_effect": "no_change",
        "equity_account": ""
      },
      {
        "id": "t4",
        "transaction": "Receive CHF 25,000 cash for film production services",
        "asset_effect": "increase",
        "asset_account": "Cash +25,000",
        "liability_effect": "no_change",
        "liability_account": "",
        "equity_effect": "increase",
        "equity_account": "Revenue +25,000"
      },
      {
        "id": "t5",
        "transaction": "Pay CHF 10,000 cash for office rent",
        "asset_effect": "decrease",
        "asset_account": "Cash -10,000",
        "liability_effect": "no_change",
        "liability_account": "",
        "equity_effect": "decrease",
        "equity_account": "Expense -10,000"
      },
      {
        "id": "t6",
        "transaction": "Purchase supplies on credit for CHF 5,000",
        "asset_effect": "increase",
        "asset_account": "Supplies +5,000",
        "liability_effect": "increase",
        "liability_account": "Accounts Payable +5,000",
        "equity_effect": "no_change",
        "equity_account": ""
      }
    ],
    "passing_score": 80
  }'::jsonb,
  'equation-analyzer',
  false,
  true
),

-- ============================================
-- Activity 1.5: Accrual vs Cash Basis
-- ============================================
(
  'fa100000-0000-0000-0001-000000000005',
  'fa000000-0000-0000-0000-000000000001',
  '1.5',
  5,
  'Accrual vs Cash Basis Accounting',
  'accrual-vs-cash-basis',
  'lesson',
  12,
  25,
  'free',
  '{"markdown": "# Accrual vs Cash Basis Accounting\n\n## Why This Matters\n\nImagine you run a consulting business. In December, you complete a CHF 50,000 project for a client, but they won''t pay until February. When did you \"earn\" that money?\n\nThis question is at the heart of accounting. The answer determines when you report revenue - and it can make a huge difference to your financial statements.\n\n---\n\n## Two Approaches to Timing\n\n### Cash Basis Accounting\n\n**Rule:** Record revenue when cash is received, and expenses when cash is paid.\n\n**Like:** Your personal bank statement - transactions appear when money moves.\n\n### Accrual Basis Accounting\n\n**Rule:** Record revenue when EARNED (regardless of cash), and expenses when INCURRED (regardless of payment).\n\n**Like:** Tracking what you''ve truly earned and owed, even if cash hasn''t moved yet.\n\n---\n\n## Visual Comparison\n\n```\nDECEMBER: Complete project for client (CHF 50,000)\nFEBRUARY: Receive payment from client\n\nCASH BASIS:                    ACCRUAL BASIS:\n          \nDec: No revenue recorded       Dec: Revenue = CHF 50,000\nFeb: Revenue = CHF 50,000      Feb: No revenue (already recorded)\n          \n```\n\n---\n\n## Why GAAP/IFRS Requires Accrual Basis\n\nPublic companies must use accrual accounting because it:\n\n| Benefit | Explanation |\n|---------|-------------|\n| **Matches revenues and expenses** | Shows true profitability of each period |\n| **Provides better information** | Reflects economic reality, not just cash flow |\n| **Enables comparability** | Investors can compare companies fairly |\n| **Reduces manipulation** | Harder to game by timing payments |\n\n---\n\n## The Matching Principle\n\n> **Matching Principle:** Expenses should be recorded in the same period as the revenues they helped generate.\n\n### Example: Advertising Campaign\n\nSwiss Confections Co. pays CHF 30,000 in January for a 3-month advertising campaign (Jan-Mar).\n\n**Cash Basis:** CHF 30,000 expense in January only.\n\n**Accrual Basis:** CHF 10,000 expense each month (January, February, March).\n\nThe accrual method matches the expense to the periods that benefit from the advertising.\n\n---\n\n## Revenue Recognition Principle\n\n> **Revenue Recognition:** Record revenue when:\n> 1. It is EARNED (goods delivered or services performed), AND\n> 2. Collection is REASONABLY ASSURED\n\n### Example Scenarios\n\n| Scenario | When to Record Revenue |\n|----------|------------------------|\n| Sell product, receive cash immediately | At point of sale |\n| Perform service in December, collect in February | December (when service performed) |\n| Receive deposit for future work | When work is completed (not at deposit) |\n| Sell 12-month magazine subscription | Each month (1/12 of total) |\n\n---\n\n## Worked Example: Luxe Maison Hotel\n\nLuxe Maison Hotel has these transactions in December:\n\n1. Guest pays CHF 1,000 for a room in December - stays in December\n2. Guest pays CHF 1,000 in December for a January reservation\n3. Corporate client stays in December - billed CHF 5,000, pays in January\n\n### Cash Basis (What accountants call \"wrong\" for most businesses)\n\n| Transaction | December Revenue |\n|-------------|------------------|\n| 1. Pay & stay in Dec | CHF 1,000 |\n| 2. Pay Dec for Jan | CHF 1,000 |\n| 3. Stay Dec, pay Jan | CHF 0 |\n| **Total** | **CHF 2,000** |\n\n### Accrual Basis (Required by GAAP/IFRS)\n\n| Transaction | December Revenue | Explanation |\n|-------------|------------------|-------------|\n| 1. Pay & stay in Dec | CHF 1,000 | Earned and received |\n| 2. Pay Dec for Jan | CHF 0 | Not yet earned - this is Unearned Revenue (liability) |\n| 3. Stay Dec, pay Jan | CHF 5,000 | Earned - this is Accounts Receivable (asset) |\n| **Total** | **CHF 6,000** |\n\n---\n\n## Key Concepts: Deferrals and Accruals\n\n### Deferrals\n\n**Definition:** Cash moves BEFORE the revenue/expense is recognized.\n\n| Type | Example |\n|------|--------|\n| **Deferred Revenue** (Unearned) | Customer pays in advance for future service |\n| **Deferred Expense** (Prepaid) | Company pays rent for next 6 months upfront |\n\n### Accruals\n\n**Definition:** Revenue/expense is recognized BEFORE cash moves.\n\n| Type | Example |\n|------|--------|\n| **Accrued Revenue** | Service performed, customer will pay later |\n| **Accrued Expense** | Employees worked this month, payday is next month |\n\n---\n\n## Common Mistakes\n\n### Mistake 1: Recording revenue when cash is received\n\"We got paid, so it''s revenue!\" - Not if you haven''t earned it yet.\n\n### Mistake 2: Recording expense only when paid\n\"We haven''t paid yet, so no expense!\" - If you''ve incurred the obligation, it''s an expense.\n\n### Mistake 3: Ignoring timing differences\nUnder accrual accounting, WHEN cash moves is often irrelevant to WHEN you record the revenue or expense.\n\n---\n\n## Pro Tips\n\n1. **Revenue question:** Has the company done what it promised? Then it''s earned.\n2. **Expense question:** Has the company benefited from this cost? Then it''s incurred.\n3. **Cash is not the trigger** - Performance is.\n4. **Prepaid = Asset** - You paid but haven''t used the benefit yet.\n5. **Unearned = Liability** - You received cash but owe a future service.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Accrual basis records revenue when EARNED, expenses when INCURRED\n> - Cash basis records when cash moves (only for small businesses)\n> - GAAP/IFRS require accrual accounting for public companies\n> - Matching principle: Match expenses to the revenues they generate\n> - Deferrals: Cash first, recognition later\n> - Accruals: Recognition first, cash later"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 1.6: GAAP and IFRS Overview
-- ============================================
(
  'fa100000-0000-0000-0001-000000000006',
  'fa000000-0000-0000-0000-000000000001',
  '1.6',
  6,
  'GAAP and IFRS Overview',
  'gaap-ifrs-overview',
  'lesson',
  10,
  20,
  'free',
  '{"markdown": "# GAAP and IFRS: The Rules of Accounting\n\n## Why This Matters\n\nImagine if every company could make up its own accounting rules. How would investors compare a Swiss company to an American one? How would banks assess creditworthiness?\n\n**Accounting standards** create a common language so financial statements are consistent, comparable, and reliable.\n\n---\n\n## Two Major Frameworks\n\n### IFRS (International Financial Reporting Standards)\n\n- **Who uses it:** Over 140 countries including Switzerland, the EU, and most of the world\n- **Who sets it:** IASB (International Accounting Standards Board)\n- **Approach:** Principles-based (more judgment required)\n\n### GAAP (Generally Accepted Accounting Principles)\n\n- **Who uses it:** Primarily the United States\n- **Who sets it:** FASB (Financial Accounting Standards Board)\n- **Approach:** Rules-based (more specific guidance)\n\n---\n\n## Key Differences\n\n| Topic | IFRS | US GAAP |\n|-------|------|----------|\n| **Inventory** | LIFO not allowed | LIFO allowed |\n| **Development costs** | Can capitalize if criteria met | Usually expensed |\n| **Impairment** | Can reverse impairment | Generally cannot reverse |\n| **Format** | More flexibility in statement format | More prescriptive |\n\n*Note: For this course, we focus on IFRS as it''s used in Switzerland and most of Europe.*\n\n---\n\n## Fundamental Accounting Principles\n\nBoth IFRS and GAAP are built on these core principles:\n\n| Principle | Meaning | Example |\n|-----------|---------|--------|\n| **Going Concern** | Assume the business will continue operating | Don''t liquidate assets prematurely |\n| **Monetary Unit** | Use a stable currency to measure | Report in CHF, not \"units of value\" |\n| **Time Period** | Divide business life into periods | Monthly, quarterly, annual reports |\n| **Historical Cost** | Record assets at purchase price | A building bought for CHF 1M stays at CHF 1M |\n| **Revenue Recognition** | Record revenue when earned | Not when cash is received |\n| **Matching** | Match expenses to related revenues | Depreciate equipment over its useful life |\n| **Full Disclosure** | Reveal all relevant information | Include notes explaining accounting choices |\n| **Materiality** | Focus on significant items | Don''t track individual pencils |\n\n---\n\n## Qualitative Characteristics of Financial Information\n\nGood financial information should be:\n\n### Fundamental Characteristics\n\n1. **Relevance** - Helps users make decisions\n2. **Faithful Representation** - Complete, neutral, and free from error\n\n### Enhancing Characteristics\n\n1. **Comparability** - Can compare across companies and time periods\n2. **Verifiability** - Independent parties would reach the same conclusion\n3. **Timeliness** - Information available when needed\n4. **Understandability** - Clear to reasonably informed users\n\n---\n\n## The Regulatory Environment\n\n### In Switzerland\n\n- **Listed companies:** Must follow IFRS (or US GAAP for US listings)\n- **SMEs:** May use Swiss GAAP FER or other standards\n- **Regulated by:** SIX Swiss Exchange, FINMA\n\n### Auditing\n\nPublic companies must have their financial statements audited by independent auditors who verify compliance with accounting standards.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - IFRS is used in Switzerland and 140+ countries\n> - US GAAP is used in the United States\n> - Both frameworks share core principles\n> - Key principles: Going Concern, Revenue Recognition, Matching, Materiality\n> - Financial information should be relevant, faithfully represented, comparable, and timely"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 1.7: Module 1 Checkpoint
-- ============================================
(
  'fa100000-0000-0000-0001-000000000007',
  'fa000000-0000-0000-0000-000000000001',
  '1.7',
  7,
  'Module 1 Checkpoint',
  'module-1-checkpoint',
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
        "question": "Which financial statement answers the question: What does the company own and owe at a specific point in time?",
        "options": [
          "Income Statement",
          "Cash Flow Statement",
          "Balance Sheet",
          "Statement of Changes in Equity"
        ],
        "correct": 2,
        "explanation": "The Balance Sheet (also called Statement of Financial Position) shows assets, liabilities, and equity at a specific point in time. The Income Statement shows profitability over a period."
      },
      {
        "id": "c2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Nova Energy Corp has total assets of CHF 2,500,000 and total liabilities of CHF 1,800,000. If the company earns net income of CHF 150,000 during the year, what is the ending equity?",
        "options": [
          "CHF 550,000",
          "CHF 700,000",
          "CHF 850,000",
          "CHF 1,950,000"
        ],
        "correct": 2,
        "explanation": "Starting Equity = Assets - Liabilities = 2,500,000 - 1,800,000 = CHF 700,000. Add Net Income: 700,000 + 150,000 = CHF 850,000 ending equity (assuming no dividends)."
      },
      {
        "id": "c3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Under accrual accounting, when should revenue be recognized?",
        "options": [
          "When cash is received from the customer",
          "When the sale is agreed upon in a contract",
          "When the goods are delivered or services are performed",
          "At the end of the fiscal year"
        ],
        "correct": 2,
        "explanation": "Under accrual accounting, revenue is recognized when it is EARNED - meaning goods have been delivered or services have been performed - regardless of when cash is received."
      },
      {
        "id": "c4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Alpine Foods pays CHF 24,000 on January 1 for a 12-month insurance policy. Under accrual accounting, what is the expense recognized in January?",
        "options": [
          "CHF 24,000",
          "CHF 12,000",
          "CHF 2,000",
          "CHF 0"
        ],
        "correct": 2,
        "explanation": "Under accrual accounting and the matching principle, the CHF 24,000 is spread over 12 months. January expense = 24,000 / 12 = CHF 2,000. The remaining CHF 22,000 is a prepaid expense (asset)."
      },
      {
        "id": "c5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which of the following correctly describes the relationship between Assets, Liabilities, and Equity?",
        "options": [
          "Assets = Liabilities - Equity represents what the company owes after paying owners",
          "Assets represent sources of funds; Liabilities + Equity represent uses of funds",
          "Equity = Assets - Liabilities represents the residual claim of owners",
          "Liabilities = Assets + Equity represents total claims against the company"
        ],
        "correct": 2,
        "explanation": "Equity = Assets - Liabilities. This shows that equity is the residual claim - what''s left for owners after all liabilities are paid. It''s derived from A = L + E."
      },
      {
        "id": "c6",
        "type": "true_false",
        "difficulty": "exam",
        "question": "A company that is profitable will always have enough cash to pay its obligations.",
        "correct": false,
        "explanation": "FALSE. Profitability and cash availability are different. A company can be profitable but have poor cash flow (e.g., if customers don''t pay on time, or inventory is high). Conversely, a company can have cash but be unprofitable."
      },
      {
        "id": "c7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A customer pays Metro Properties CHF 6,000 in December for rent covering January through March. How should Metro record this in December under IFRS?",
        "options": [
          "Revenue of CHF 6,000",
          "Unearned Revenue (liability) of CHF 6,000",
          "Prepaid Rent (asset) of CHF 6,000",
          "Accounts Receivable of CHF 6,000"
        ],
        "correct": 1,
        "explanation": "When a company receives cash BEFORE earning it, the amount is recorded as Unearned Revenue (a liability). Metro owes the customer the service (rent) for January-March. The revenue will be recognized as it is earned each month."
      },
      {
        "id": "c8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which accounting framework is used by Swiss publicly listed companies?",
        "options": [
          "US GAAP only",
          "Swiss Code of Obligations only",
          "IFRS (or US GAAP for US listings)",
          "Any framework chosen by management"
        ],
        "correct": 2,
        "explanation": "Swiss publicly listed companies on the SIX Swiss Exchange must use IFRS (International Financial Reporting Standards). Companies listed only on US exchanges may use US GAAP."
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


