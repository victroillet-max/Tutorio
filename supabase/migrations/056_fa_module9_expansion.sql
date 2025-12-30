-- ============================================
-- FA Course Content Expansion - Phase 1
-- Module 9: CFS Investing and Financing Activities
-- Adds 10 new activities for under-covered CFS skills
-- ============================================

-- ============================================
-- NEW ACTIVITIES FOR MODULE 9
-- Following existing UUID pattern: fa900000-0000-0000-0009-00000000XXXX
-- Existing activities: 0001-0005, new start at 0006
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 9.6: Cash Flow Categories Sorting
-- Primary Skill: cfs-categories
-- ============================================
(
  'fa900000-0000-0000-0009-000000000006',
  'fa000000-0000-0000-0000-000000000009',
  '9.6',
  6,
  'Cash Flow Categories Sorting Exercise',
  'cash-flow-categories-sorting',
  'interactive',
  15,
  40,
  'basic',
  '{
    "title": "Classify Cash Flows: Swiss Manufacturing",
    "description": "Sort 15 cash transactions into Operating, Investing, or Financing categories.",
    "company_background": "Swiss Manufacturing AG had numerous cash transactions during the year. Classify each into the correct CFS category.",
    "transactions": [
      {"description": "Collected cash from customers", "amount": 2500000, "category": "operating"},
      {"description": "Paid wages to employees", "amount": 800000, "category": "operating"},
      {"description": "Purchased new machinery", "amount": 450000, "category": "investing"},
      {"description": "Paid dividends to shareholders", "amount": 200000, "category": "financing"},
      {"description": "Received loan from bank", "amount": 500000, "category": "financing"},
      {"description": "Sold old delivery truck", "amount": 35000, "category": "investing"},
      {"description": "Paid suppliers for inventory", "amount": 1200000, "category": "operating"},
      {"description": "Repaid principal on bank loan", "amount": 100000, "category": "financing"},
      {"description": "Purchased investment securities", "amount": 150000, "category": "investing"},
      {"description": "Paid interest on loans", "amount": 40000, "category": "operating"},
      {"description": "Issued new shares", "amount": 300000, "category": "financing"},
      {"description": "Paid income taxes", "amount": 180000, "category": "operating"},
      {"description": "Purchased land for expansion", "amount": 600000, "category": "investing"},
      {"description": "Received dividends from investments", "amount": 25000, "category": "operating"},
      {"description": "Repurchased company shares (treasury stock)", "amount": 75000, "category": "financing"}
    ],
    "questions": [
      {
        "id": "cc1",
        "question": "Purchasing new machinery is classified as:",
        "answer_type": "choice",
        "options": ["Operating", "Investing", "Financing"],
        "correct_answer": "Investing",
        "explanation": "Purchasing long-term assets like machinery is an investing activity."
      },
      {
        "id": "cc2",
        "question": "Paying dividends to shareholders is classified as:",
        "answer_type": "choice",
        "options": ["Operating", "Investing", "Financing"],
        "correct_answer": "Financing",
        "explanation": "Dividends paid to shareholders are financing activities (transactions with owners)."
      },
      {
        "id": "cc3",
        "question": "Paying interest on loans is classified as:",
        "answer_type": "choice",
        "options": ["Operating", "Investing", "Financing"],
        "correct_answer": "Operating",
        "explanation": "Interest paid is generally classified as operating under IFRS (can also be financing). Exam default: Operating."
      },
      {
        "id": "cc4",
        "question": "Calculate total Cash from Investing Activities.",
        "answer_type": "numeric",
        "correct_answer": -1165000,
        "tolerance": 1000,
        "hint": "Machinery purchase + Truck sale + Securities purchase + Land purchase",
        "explanation": "CFI = -450,000 + 35,000 - 150,000 - 600,000 = -1,165,000"
      },
      {
        "id": "cc5",
        "question": "Calculate total Cash from Financing Activities.",
        "answer_type": "numeric",
        "correct_answer": 425000,
        "tolerance": 1000,
        "hint": "Bank loan + Share issue - Dividends - Loan repayment - Treasury stock",
        "explanation": "CFF = 500,000 + 300,000 - 200,000 - 100,000 - 75,000 = 425,000"
      }
    ],
    "passing_score": 80
  }'::jsonb,
  'cfs-classifier',
  false,
  true
),

-- ============================================
-- Activity 9.7: Classification Practice Quiz
-- Primary Skill: cfs-categories
-- ============================================
(
  'fa900000-0000-0000-0009-000000000007',
  'fa000000-0000-0000-0000-000000000009',
  '9.7',
  7,
  'Cash Flow Classification Quiz',
  'cash-flow-classification-quiz',
  'quiz',
  10,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which is an INVESTING activity?",
        "options": [
          "Collecting cash from customers",
          "Issuing bonds",
          "Purchasing equipment",
          "Paying employee wages"
        ],
        "correct": 2,
        "explanation": "Purchasing equipment (a long-term asset) is an investing activity. Customer collections and wages are operating; bonds are financing."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which is a FINANCING activity?",
        "options": [
          "Selling a building",
          "Paying dividends",
          "Paying suppliers",
          "Receiving interest income"
        ],
        "correct": 1,
        "explanation": "Dividends paid to shareholders is a financing activity. Selling a building is investing; paying suppliers and interest received are operating."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Repaying the principal portion of a loan is:",
        "options": [
          "Operating Activity",
          "Investing Activity",
          "Financing Activity",
          "Not reported on CFS"
        ],
        "correct": 2,
        "explanation": "Repaying loan principal is a financing activity (transaction with lenders). Interest payments are typically operating."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company sells equipment with book value CHF 50,000 for CHF 65,000. In the CFS:",
        "options": [
          "CHF 50,000 appears in investing",
          "CHF 65,000 appears in investing; gain removed from operating",
          "CHF 15,000 gain appears in investing",
          "No entry is needed"
        ],
        "correct": 1,
        "explanation": "The full cash proceeds (CHF 65,000) appear in investing. The CHF 15,000 gain is SUBTRACTED from operating (indirect method) to avoid double-counting."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Under the indirect method, purchasing inventory on credit affects the operating activities section.",
        "correct": true,
        "explanation": "TRUE. Even though no cash changed hands at purchase, the change in accounts payable affects operating activities when reconciling net income to cash."
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
-- Activity 9.8: Operating Activities Calculator
-- Primary Skill: cfs-operating
-- ============================================
(
  'fa900000-0000-0000-0009-000000000008',
  'fa000000-0000-0000-0000-000000000009',
  '9.8',
  8,
  'Operating Activities Calculator',
  'operating-activities-calculator',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Calculate CFO: Horizon Technologies",
    "description": "Build the operating activities section using the indirect method for Horizon Technologies.",
    "company_background": "Horizon Technologies reported Net Income of CHF 350,000. Use the additional information to calculate Cash from Operating Activities.",
    "financial_data": {
      "net_income": 350000,
      "depreciation": 85000,
      "amortization": 15000,
      "gain_on_sale": 12000,
      "loss_on_disposal": 8000,
      "change_ar": 45000,
      "change_inventory": -30000,
      "change_prepaid": 5000,
      "change_ap": 25000,
      "change_accrued": -15000
    },
    "questions": [
      {
        "id": "cfo1",
        "question": "What is the adjustment for depreciation and amortization?",
        "answer_type": "numeric",
        "correct_answer": 100000,
        "tolerance": 100,
        "hint": "Both are non-cash expenses that are added back",
        "explanation": "Depreciation (85,000) + Amortization (15,000) = +100,000 (add back)"
      },
      {
        "id": "cfo2",
        "question": "What is the adjustment for gains and losses on asset sales?",
        "answer_type": "numeric",
        "correct_answer": -4000,
        "tolerance": 100,
        "hint": "Subtract gains, add losses",
        "explanation": "Gain (-12,000) + Loss (+8,000) = -4,000 net adjustment"
      },
      {
        "id": "cfo3",
        "question": "What is the adjustment for the increase in Accounts Receivable?",
        "answer_type": "numeric",
        "correct_answer": -45000,
        "tolerance": 100,
        "hint": "Current asset increase = SUBTRACT",
        "explanation": "A/R increased 45,000 means sales recorded but cash not collected = SUBTRACT"
      },
      {
        "id": "cfo4",
        "question": "What is the adjustment for the decrease in Inventory?",
        "answer_type": "numeric",
        "correct_answer": 30000,
        "tolerance": 100,
        "hint": "Current asset decrease = ADD",
        "explanation": "Inventory decreased 30,000 means more was sold than purchased = ADD"
      },
      {
        "id": "cfo5",
        "question": "What is the total adjustment for working capital changes?",
        "answer_type": "numeric",
        "correct_answer": -10000,
        "tolerance": 100,
        "hint": "A/R change + Inventory change + Prepaid change + A/P change + Accrued change",
        "explanation": "(-45,000) + (+30,000) + (-5,000) + (+25,000) + (-15,000) = -10,000"
      },
      {
        "id": "cfo6",
        "question": "Calculate total Cash from Operating Activities.",
        "answer_type": "numeric",
        "correct_answer": 436000,
        "tolerance": 1000,
        "hint": "Net Income + Non-cash + Gains/Losses adjustment + Working Capital changes",
        "explanation": "CFO = 350,000 + 100,000 - 4,000 - 10,000 = 436,000"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'cfo-calculator',
  false,
  true
),

-- ============================================
-- Activity 9.9: Investing Activities Analysis
-- Primary Skill: cfs-investing
-- ============================================
(
  'fa900000-0000-0000-0009-000000000009',
  'fa000000-0000-0000-0000-000000000009',
  '9.9',
  9,
  'Investing Activities Analysis',
  'investing-activities-analysis',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# Investing Activities Analysis\n\n## Why This Matters\n\nThe investing section reveals how a company is deploying capital for future growth. Is it expanding capacity? Selling off assets? Making acquisitions? The answers are here.\n\n---\n\n## What Are Investing Activities?\n\n> **Investing Activities** involve the purchase and sale of long-term assets and investments.\n\n### Key Question\n\n**What is the company doing with its long-term assets and investments?**\n\n---\n\n## Common Investing Cash Flows\n\n### Cash Outflows (Uses)\n\n| Activity | Description |\n|----------|-------------|\n| **Capital Expenditures (CapEx)** | Buying PP&E |\n| **Acquisitions** | Buying other companies |\n| **Investment Purchases** | Buying stocks, bonds |\n| **Loans Made** | Lending money to others |\n\n### Cash Inflows (Sources)\n\n| Activity | Description |\n|----------|-------------|\n| **Asset Sales** | Selling PP&E |\n| **Investment Sales** | Selling securities |\n| **Loan Collections** | Receiving loan repayments |\n| **Divestitures** | Selling business units |\n\n---\n\n## Capital Expenditures (CapEx)\n\n### What It Includes\n\n- Purchasing land\n- Buying buildings\n- Acquiring machinery and equipment\n- Purchasing vehicles\n- Construction costs\n- Major improvements to existing assets\n\n### CapEx vs Maintenance\n\n| Type | Treatment |\n|------|----------|\n| **Growth CapEx** | New capacity, expansion |\n| **Maintenance CapEx** | Replacing worn equipment |\n\nBoth appear in investing activities, but analysts distinguish them for valuation.\n\n---\n\n## Calculating Asset Purchases\n\n### The PP&E Equation\n\n```\nEnding PP&E = Beginning PP&E + Purchases - Depreciation - Disposals\n```\n\n### Solving for Purchases\n\n```\nPurchases = Ending PP&E - Beginning PP&E + Depreciation + Disposals\n```\n\n### Example: Alpine Manufacturing\n\n| Item | Amount |\n|------|--------|\n| Beginning PPE (net) | CHF 500,000 |\n| Ending PPE (net) | CHF 580,000 |\n| Depreciation Expense | CHF 70,000 |\n| Equipment Sold (cost CHF 40,000, acc. dep. CHF 30,000) | Book value CHF 10,000 |\n\n**Calculation:**\n```\nPurchases = 580,000 - 500,000 + 70,000 + 10,000\n         = CHF 160,000\n```\n\n---\n\n## Proceeds from Asset Sales\n\n### Calculating Sale Proceeds\n\n```\nProceeds = Book Value + Gain (or - Loss)\n```\n\n### Example\n\n- Equipment cost: CHF 100,000\n- Accumulated depreciation: CHF 75,000\n- Book value: CHF 25,000\n- Gain on sale: CHF 8,000\n\n**Proceeds = 25,000 + 8,000 = CHF 33,000**\n\n### CFS Treatment\n\n- Investing: Show full proceeds (CHF 33,000)\n- Operating: Subtract gain (CHF 8,000) to avoid double-counting\n\n---\n\n## Investment Securities\n\n### Types of Investments\n\n| Type | Treatment |\n|------|----------|\n| Trading Securities | Operating (some standards) |\n| Available-for-Sale | Investing |\n| Held-to-Maturity | Investing |\n\n### Typical Presentation\n\n```\nInvesting Activities:\n  Purchases of investment securities    (200,000)\n  Proceeds from sale of securities        75,000\n  Net investing in securities           (125,000)\n```\n\n---\n\n## Interpretation\n\n### Healthy vs Concerning Patterns\n\n| Pattern | Interpretation |\n|---------|----------------|\n| Negative CFI | Typically healthy - investing in growth |\n| Large negative CFI | Expansion phase or acquisition |\n| Positive CFI | May be selling assets - check if strategic |\n| Consistently positive CFI | Could indicate decline or distress |\n\n### Free Cash Flow Connection\n\n```\nFree Cash Flow = CFO - CapEx\n```\n\nFCF shows cash available after maintaining/growing the business.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Investing = long-term assets and investments\n> - CapEx is the biggest outflow for most companies\n> - Full sale proceeds go to investing (not just gain/loss)\n> - Subtract gains / Add losses in operating section\n> - Negative CFI typically signals growth investment\n> - Use PP&E equation to calculate purchases"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 9.10: Investing Activities Practice
-- Primary Skill: cfs-investing
-- ============================================
(
  'fa900000-0000-0000-0009-000000000010',
  'fa000000-0000-0000-0000-000000000009',
  '9.10',
  10,
  'Investing Activities Practice',
  'investing-activities-practice',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Calculate CFI: Glacier Industries",
    "description": "Determine the investing activities section for Glacier Industries using balance sheet and transaction data.",
    "company_background": "Glacier Industries is a manufacturing company that made several capital investment decisions during the year.",
    "financial_data": {
      "ppe_beginning": 2800000,
      "ppe_ending": 3100000,
      "depreciation_expense": 280000,
      "equipment_sold_cost": 150000,
      "equipment_sold_accum_dep": 120000,
      "equipment_sold_proceeds": 45000,
      "investment_securities_purchased": 200000,
      "investment_securities_sold_proceeds": 80000,
      "land_purchased": 350000
    },
    "questions": [
      {
        "id": "cfi1",
        "question": "What was the book value of equipment sold?",
        "answer_type": "numeric",
        "correct_answer": 30000,
        "tolerance": 100,
        "hint": "Book Value = Cost - Accumulated Depreciation",
        "explanation": "Book Value = 150,000 - 120,000 = CHF 30,000"
      },
      {
        "id": "cfi2",
        "question": "Was there a gain or loss on the equipment sale, and how much?",
        "answer_type": "choice",
        "options": ["Gain of CHF 15,000", "Loss of CHF 15,000", "Gain of CHF 45,000", "No gain or loss"],
        "correct_answer": "Gain of CHF 15,000",
        "explanation": "Proceeds (45,000) - Book Value (30,000) = Gain of CHF 15,000"
      },
      {
        "id": "cfi3",
        "question": "Calculate total equipment purchases during the year.",
        "answer_type": "numeric",
        "correct_answer": 730000,
        "tolerance": 1000,
        "hint": "Ending PPE = Beginning + Purchases - Depreciation - Disposed Book Value",
        "explanation": "3,100,000 = 2,800,000 + Purchases - 280,000 - 30,000. Purchases = 610,000. Plus Land 350,000 = 960,000 total. Wait, let me recalculate without land: Equipment only: 3,100,000 - 350,000 = 2,750,000 ending. Actually, use: Purchases = 3,100,000 - 2,800,000 + 280,000 + 30,000 = 610,000 for equipment. Land is separate at 350,000."
      },
      {
        "id": "cfi4",
        "question": "Calculate net cash used for investment securities.",
        "answer_type": "numeric",
        "correct_answer": -120000,
        "tolerance": 100,
        "hint": "Purchases - Proceeds from sales",
        "explanation": "Net = -200,000 + 80,000 = -120,000 (net outflow)"
      },
      {
        "id": "cfi5",
        "question": "Calculate total Cash from Investing Activities.",
        "answer_type": "numeric",
        "correct_answer": -1035000,
        "tolerance": 5000,
        "hint": "Equipment purchases + Land + Securities net + Equipment sale proceeds",
        "explanation": "CFI = -610,000 (equipment) - 350,000 (land) - 120,000 (securities net) + 45,000 (sale proceeds) = -1,035,000"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'cfi-calculator',
  false,
  true
),

-- ============================================
-- Activity 9.11: Investing Activities Quiz
-- Primary Skill: cfs-investing
-- ============================================
(
  'fa900000-0000-0000-0009-000000000011',
  'fa000000-0000-0000-0000-000000000009',
  '9.11',
  11,
  'Investing Activities Quiz',
  'investing-activities-quiz',
  'quiz',
  10,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Capital expenditures (CapEx) are reported in which CFS section?",
        "options": [
          "Operating Activities",
          "Investing Activities",
          "Financing Activities",
          "Supplemental Disclosures"
        ],
        "correct": 1,
        "explanation": "CapEx (purchasing PP&E) is an investing activity because it involves long-term assets."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Equipment with book value CHF 40,000 is sold for CHF 55,000. The CFS shows:",
        "options": [
          "CHF 40,000 in investing, CHF 15,000 in operating",
          "CHF 55,000 in investing, gain removed from operating",
          "CHF 15,000 in investing",
          "CHF 55,000 in operating"
        ],
        "correct": 1,
        "explanation": "The full CHF 55,000 proceeds appear in investing. The CHF 15,000 gain is subtracted from operating (indirect method) to avoid double-counting."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Beginning PPE CHF 500,000; Ending PPE CHF 600,000; Depreciation CHF 80,000; No disposals. What were purchases?",
        "options": [
          "CHF 100,000",
          "CHF 180,000",
          "CHF 80,000",
          "CHF 20,000"
        ],
        "correct": 1,
        "explanation": "Purchases = Ending - Beginning + Depreciation = 600,000 - 500,000 + 80,000 = CHF 180,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company consistently shows positive Cash from Investing Activities. This likely indicates:",
        "options": [
          "Strong growth and expansion",
          "The company is selling assets, possibly to raise cash",
          "High profitability",
          "Excellent operating efficiency"
        ],
        "correct": 1,
        "explanation": "Positive CFI means more cash coming IN from asset sales than going OUT for purchases. This may indicate distress or strategic divestiture."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Free Cash Flow equals Cash from Operating Activities minus Capital Expenditures.",
        "correct": true,
        "explanation": "TRUE. Free Cash Flow (FCF) = CFO - CapEx. This represents cash available after maintaining and growing the business."
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
-- Activity 9.12: Financing Activities Analysis
-- Primary Skill: cfs-financing
-- ============================================
(
  'fa900000-0000-0000-0009-000000000012',
  'fa000000-0000-0000-0000-000000000009',
  '9.12',
  12,
  'Financing Activities Analysis',
  'financing-activities-analysis',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# Financing Activities Analysis\n\n## Why This Matters\n\nThe financing section reveals how a company raises capital and returns it to stakeholders. Understanding financing activities helps assess capital structure decisions and sustainability of dividends.\n\n---\n\n## What Are Financing Activities?\n\n> **Financing Activities** involve transactions with owners (equity) and lenders (debt).\n\n### Key Question\n\n**How is the company financed, and how does it return capital to providers?**\n\n---\n\n## Common Financing Cash Flows\n\n### Cash Inflows (Sources)\n\n| Activity | Description |\n|----------|-------------|\n| **Issuing Shares** | Selling common/preferred stock |\n| **Borrowing** | Loans, bonds, notes payable |\n\n### Cash Outflows (Uses)\n\n| Activity | Description |\n|----------|-------------|\n| **Dividends Paid** | Cash to shareholders |\n| **Debt Repayment** | Paying back principal |\n| **Share Repurchases** | Buying back treasury stock |\n\n---\n\n## Equity Transactions\n\n### Issuing New Shares\n\n**Entry:**\n- Dr Cash\n- Cr Share Capital\n- Cr Share Premium (if issued above par)\n\n**CFS:** Cash inflow in financing\n\n### Share Repurchases (Treasury Stock)\n\n**Why Companies Buy Back:**\n- Return excess cash to shareholders\n- Support stock price\n- Offset dilution from stock options\n- Signal undervaluation\n\n**CFS:** Cash outflow in financing\n\n---\n\n## Debt Transactions\n\n### Borrowing Money\n\n| Type | Description |\n|------|-------------|\n| **Bank Loans** | Direct borrowing |\n| **Bonds Issued** | Public debt securities |\n| **Notes Payable** | Promissory notes |\n\n**CFS:** Proceeds = inflow in financing\n\n### Repaying Debt\n\n| Component | CFS Section |\n|-----------|-------------|\n| **Principal** | Financing |\n| **Interest** | Operating (typically) |\n\n---\n\n## Dividends\n\n### Types of Dividends\n\n| Type | CFS Treatment |\n|------|---------------|\n| **Cash Dividends** | Outflow in financing |\n| **Stock Dividends** | No cash effect |\n| **Property Dividends** | Non-cash, disclosed |\n\n### Dividend Timeline\n\n```\nDeclaration Date      Record Date      Payment Date\n      |                   |                  |\n   Liability           Who gets it      Cash paid\n   recorded            determined       CFS impact\n```\n\n**Key:** CFS shows dividends PAID, not declared.\n\n---\n\n## Calculating Debt Changes\n\n### Long-Term Debt Equation\n\n```\nEnding Debt = Beginning Debt + New Borrowings - Repayments\n```\n\n### Solving for Borrowings/Repayments\n\nIf only one is unknown, solve algebraically.\n\n### Example\n\n- Beginning Debt: CHF 500,000\n- Ending Debt: CHF 650,000\n- New Bond Issue: CHF 200,000\n\n**Repayments = 500,000 + 200,000 - 650,000 = CHF 50,000**\n\n---\n\n## Interpretation\n\n### What Financing Patterns Reveal\n\n| Pattern | Interpretation |\n|---------|----------------|\n| Positive CFF | Raising capital (growth or need) |\n| Negative CFF | Returning capital (mature, confident) |\n| High dividends + debt repayment | Strong cash generation |\n| Borrowing to pay dividends | Warning sign |\n\n### Life Cycle Perspective\n\n| Stage | Typical CFF |\n|-------|-------------|\n| **Startup** | Positive (equity raises) |\n| **Growth** | Positive (borrowing for expansion) |\n| **Mature** | Negative (dividends, buybacks) |\n| **Decline** | Variable (restructuring) |\n\n---\n\n## Important Distinctions\n\n### Principal vs Interest\n\n| Payment | CFS Section |\n|---------|-------------|\n| Loan Principal | Financing |\n| Interest | Operating (generally) |\n\n### Stock Issuance vs Operating Income\n\nShare issuance is financing, NOT operating income. Common error!\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Financing = transactions with owners and lenders\n> - Principal repayment is financing; interest is operating\n> - Dividends PAID appear in financing (not declared)\n> - Positive CFF often means raising capital\n> - Negative CFF often means returning capital\n> - Stock dividends have no cash effect"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 9.13: Financing Activities Practice
-- Primary Skill: cfs-financing
-- ============================================
(
  'fa900000-0000-0000-0009-000000000013',
  'fa000000-0000-0000-0000-000000000009',
  '9.13',
  13,
  'Financing Activities Practice',
  'financing-activities-practice',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Calculate CFF: Summit Capital Group",
    "description": "Prepare the financing activities section for Summit Capital Group using balance sheet and transaction data.",
    "company_background": "Summit Capital Group made several financing decisions during the year to optimize their capital structure.",
    "financial_data": {
      "beginning_lt_debt": 800000,
      "ending_lt_debt": 950000,
      "bonds_issued": 300000,
      "beginning_share_capital": 500000,
      "ending_share_capital": 600000,
      "shares_issued_proceeds": 150000,
      "treasury_stock_purchased": 50000,
      "dividends_declared": 120000,
      "dividends_paid": 100000
    },
    "questions": [
      {
        "id": "cff1",
        "question": "Calculate debt repayments during the year.",
        "answer_type": "numeric",
        "correct_answer": 150000,
        "tolerance": 100,
        "hint": "Ending = Beginning + Borrowings - Repayments",
        "explanation": "Repayments = 800,000 + 300,000 - 950,000 = CHF 150,000"
      },
      {
        "id": "cff2",
        "question": "What amount appears in CFF for debt-related activities (net)?",
        "answer_type": "numeric",
        "correct_answer": 150000,
        "tolerance": 100,
        "hint": "Bonds issued - Debt repaid",
        "explanation": "Net debt = 300,000 - 150,000 = CHF 150,000 inflow"
      },
      {
        "id": "cff3",
        "question": "What amount appears in CFF for share transactions (net)?",
        "answer_type": "numeric",
        "correct_answer": 100000,
        "tolerance": 100,
        "hint": "Shares issued - Treasury stock purchased",
        "explanation": "Net equity = 150,000 - 50,000 = CHF 100,000 inflow"
      },
      {
        "id": "cff4",
        "question": "What dividend amount appears on the CFS?",
        "answer_type": "numeric",
        "correct_answer": 100000,
        "tolerance": 100,
        "hint": "CFS shows cash PAID, not declared",
        "explanation": "Dividends PAID = CHF 100,000 (not 120,000 declared)"
      },
      {
        "id": "cff5",
        "question": "Calculate total Cash from Financing Activities.",
        "answer_type": "numeric",
        "correct_answer": 150000,
        "tolerance": 1000,
        "hint": "Net debt + Net equity - Dividends paid",
        "explanation": "CFF = 150,000 + 100,000 - 100,000 = CHF 150,000"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'cff-calculator',
  false,
  true
),

-- ============================================
-- Activity 9.14: Financing Activities Quiz
-- Primary Skill: cfs-financing
-- ============================================
(
  'fa900000-0000-0000-0009-000000000014',
  'fa000000-0000-0000-0000-000000000009',
  '9.14',
  14,
  'Financing Activities Quiz',
  'financing-activities-quiz',
  'quiz',
  10,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which is a Financing Activity?",
        "options": [
          "Purchasing equipment",
          "Collecting from customers",
          "Issuing new shares",
          "Paying income taxes"
        ],
        "correct": 2,
        "explanation": "Issuing shares is a financing activity (transaction with owners). Equipment is investing; collections and taxes are operating."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Dividends paid to shareholders are classified as:",
        "options": [
          "Operating Activity",
          "Investing Activity",
          "Financing Activity",
          "Not on the CFS"
        ],
        "correct": 2,
        "explanation": "Dividends paid are financing activities (return of capital to owners)."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Beginning debt CHF 400,000; Ending debt CHF 350,000; New borrowing CHF 100,000. Debt repayments were:",
        "options": [
          "CHF 50,000",
          "CHF 100,000",
          "CHF 150,000",
          "CHF 450,000"
        ],
        "correct": 2,
        "explanation": "Repayments = Beginning + Borrowings - Ending = 400,000 + 100,000 - 350,000 = CHF 150,000"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company pays CHF 50,000 interest and CHF 100,000 principal on a loan. On the CFS:",
        "options": [
          "CHF 150,000 appears in financing",
          "CHF 100,000 in financing; CHF 50,000 in operating",
          "CHF 150,000 appears in operating",
          "CHF 50,000 in financing; CHF 100,000 in operating"
        ],
        "correct": 1,
        "explanation": "Principal (CHF 100,000) is financing; Interest (CHF 50,000) is typically operating."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Stock dividends (distributing shares instead of cash) appear as an outflow in financing activities.",
        "correct": false,
        "explanation": "FALSE. Stock dividends have no cash impact and do not appear on the Cash Flow Statement. Only cash dividends appear."
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
-- Activity 9.15: Complete CFS Builder Challenge
-- Primary Skill: cfs-interpretation
-- ============================================
(
  'fa900000-0000-0000-0009-000000000015',
  'fa000000-0000-0000-0000-000000000009',
  '9.15',
  15,
  'Complete CFS Builder Challenge',
  'complete-cfs-builder-challenge',
  'interactive',
  30,
  75,
  'basic',
  '{
    "title": "Build the Complete CFS: Nordic Retail Group",
    "description": "Prepare a complete Cash Flow Statement for Nordic Retail Group using all available data.",
    "company_background": "Nordic Retail Group is a Scandinavian fashion retailer. Prepare their complete Cash Flow Statement using the indirect method.",
    "financial_data": {
      "net_income": 480000,
      "depreciation": 95000,
      "amortization": 25000,
      "gain_on_sale_equipment": 18000,
      "ar_increase": 65000,
      "inventory_decrease": 40000,
      "prepaid_increase": 8000,
      "ap_increase": 35000,
      "accrued_decrease": 12000,
      "equipment_purchases": 280000,
      "equipment_sale_proceeds": 45000,
      "investment_purchases": 100000,
      "bonds_issued": 200000,
      "notes_repaid": 80000,
      "shares_issued": 150000,
      "dividends_paid": 120000,
      "treasury_stock_purchased": 60000,
      "beginning_cash": 185000
    },
    "questions": [
      {
        "id": "cfs1",
        "question": "Calculate Cash from Operating Activities.",
        "answer_type": "numeric",
        "correct_answer": 572000,
        "tolerance": 2000,
        "hint": "NI + D&A - Gain + Working Capital changes",
        "explanation": "CFO = 480,000 + 95,000 + 25,000 - 18,000 - 65,000 + 40,000 - 8,000 + 35,000 - 12,000 = 572,000"
      },
      {
        "id": "cfs2",
        "question": "Calculate Cash from Investing Activities.",
        "answer_type": "numeric",
        "correct_answer": -335000,
        "tolerance": 1000,
        "hint": "Equipment purchases + Sale proceeds + Investment purchases",
        "explanation": "CFI = -280,000 + 45,000 - 100,000 = -335,000"
      },
      {
        "id": "cfs3",
        "question": "Calculate Cash from Financing Activities.",
        "answer_type": "numeric",
        "correct_answer": 90000,
        "tolerance": 1000,
        "hint": "Bonds + Shares - Notes repaid - Dividends - Treasury stock",
        "explanation": "CFF = 200,000 + 150,000 - 80,000 - 120,000 - 60,000 = 90,000"
      },
      {
        "id": "cfs4",
        "question": "Calculate the Net Change in Cash.",
        "answer_type": "numeric",
        "correct_answer": 327000,
        "tolerance": 1000,
        "explanation": "Net Change = 572,000 - 335,000 + 90,000 = 327,000"
      },
      {
        "id": "cfs5",
        "question": "Calculate Ending Cash.",
        "answer_type": "numeric",
        "correct_answer": 512000,
        "tolerance": 1000,
        "explanation": "Ending Cash = 185,000 + 327,000 = 512,000"
      },
      {
        "id": "cfs6",
        "question": "Calculate Free Cash Flow (CFO - CapEx).",
        "answer_type": "numeric",
        "correct_answer": 292000,
        "tolerance": 1000,
        "explanation": "FCF = 572,000 - 280,000 = 292,000"
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'cfs-builder',
  false,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;

-- ============================================
-- ADD SKILL TAGS FOR NEW MODULE 9 ACTIVITIES
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 9.6 Cash Flow Categories Sorting (cfs-categories)
('fa900000-0000-0000-0009-000000000006', 'b0000000-0000-0000-0006-000000000001', 1.0, true),

-- 9.7 Classification Quiz (cfs-categories)
('fa900000-0000-0000-0009-000000000007', 'b0000000-0000-0000-0006-000000000001', 1.0, true),

-- 9.8 Operating Activities Calculator (cfs-operating)
('fa900000-0000-0000-0009-000000000008', 'b0000000-0000-0000-0006-000000000002', 1.0, true),

-- 9.9 Investing Activities Analysis (cfs-investing)
('fa900000-0000-0000-0009-000000000009', 'b0000000-0000-0000-0006-000000000003', 1.0, true),

-- 9.10 Investing Activities Practice (cfs-investing)
('fa900000-0000-0000-0009-000000000010', 'b0000000-0000-0000-0006-000000000003', 1.0, true),

-- 9.11 Investing Activities Quiz (cfs-investing)
('fa900000-0000-0000-0009-000000000011', 'b0000000-0000-0000-0006-000000000003', 1.0, true),

-- 9.12 Financing Activities Analysis (cfs-financing)
('fa900000-0000-0000-0009-000000000012', 'b0000000-0000-0000-0006-000000000004', 1.0, true),

-- 9.13 Financing Activities Practice (cfs-financing)
('fa900000-0000-0000-0009-000000000013', 'b0000000-0000-0000-0006-000000000004', 1.0, true),

-- 9.14 Financing Activities Quiz (cfs-financing)
('fa900000-0000-0000-0009-000000000014', 'b0000000-0000-0000-0006-000000000004', 1.0, true),

-- 9.15 Complete CFS Builder (cfs-interpretation + all CFS skills)
('fa900000-0000-0000-0009-000000000015', 'b0000000-0000-0000-0006-000000000005', 1.0, true),
('fa900000-0000-0000-0009-000000000015', 'b0000000-0000-0000-0006-000000000002', 0.3, false),
('fa900000-0000-0000-0009-000000000015', 'b0000000-0000-0000-0006-000000000003', 0.3, false),
('fa900000-0000-0000-0009-000000000015', 'b0000000-0000-0000-0006-000000000004', 0.3, false)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

