-- ============================================
-- Modules 7-8: Long-Lived Assets & Liabilities/Equity
-- ============================================

-- ============================================
-- MODULE 7: Long-Lived Assets
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 7.1: Depreciation Methods
(
  'fa700000-0000-0000-0007-000000000001',
  'fa000000-0000-0000-0000-000000000007',
  '7.1',
  1,
  'Depreciation Methods Compared',
  'depreciation-methods-compared',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Depreciation Methods Compared\n\n## Why This Matters\n\nDifferent depreciation methods allocate costs differently over an asset''s life. The method chosen affects reported income and asset values every year the asset is used.\n\n---\n\n## Three Primary Methods\n\n### 1. Straight-Line Method\n\nEqual amount each year.\n\n```\nDepreciation = (Cost - Residual Value) / Useful Life\n```\n\n**Best for:** Assets that provide equal benefit each year.\n\n### 2. Declining Balance Method\n\nHigher depreciation in early years, declining over time.\n\n```\nDepreciation = Book Value x Depreciation Rate\nWhere Rate = (1/Life) x Multiplier (often 2 for double-declining)\n```\n\n**Best for:** Assets that lose value quickly (technology, vehicles).\n\n### 3. Units of Production Method\n\nBased on actual usage.\n\n```\nDepreciation = (Cost - Residual) / Total Estimated Units x Units This Period\n```\n\n**Best for:** Assets whose wear depends on usage (machinery, vehicles).\n\n---\n\n## Worked Example: Metro Properties Delivery Van\n\nMetro Properties purchases a delivery van:\n- Cost: CHF 60,000\n- Residual Value: CHF 12,000\n- Useful Life: 4 years\n- Estimated mileage: 200,000 km\n- Year 1 usage: 65,000 km\n\n### Straight-Line\n\n```\nAnnual Depreciation = (60,000 - 12,000) / 4 = CHF 12,000/year\n```\n\n### Double-Declining Balance\n\nRate = 2 x (1/4) = 50%\n\n| Year | Beginning Book Value | Depreciation (50%) | Ending Book Value |\n|------|---------------------|-------------------|-------------------|\n| 1 | 60,000 | 30,000 | 30,000 |\n| 2 | 30,000 | 15,000 | 15,000 |\n| 3 | 15,000 | 3,000* | 12,000 |\n| 4 | 12,000 | 0 | 12,000 |\n\n*Limited to bring book value to residual value.\n\n### Units of Production\n\n```\nRate = (60,000 - 12,000) / 200,000 = CHF 0.24/km\nYear 1 = 65,000 x 0.24 = CHF 15,600\n```\n\n---\n\n## Comparison Table\n\n| Year | Straight-Line | Double-Declining | Units (if 65k km/yr) |\n|------|--------------|------------------|---------------------|\n| 1 | 12,000 | 30,000 | 15,600 |\n| 2 | 12,000 | 15,000 | 15,600 |\n| 3 | 12,000 | 3,000 | 15,600 |\n| 4 | 12,000 | 0 | 1,200* |\n| **Total** | **48,000** | **48,000** | **48,000** |\n\n*Adjusted for actual usage.\n\nNote: Total depreciation is always the same regardless of method!\n\n---\n\n## Impact on Financial Statements\n\n### Year 1 Comparison (Higher Asset Usage Early)\n\n| Method | Depreciation | Net Income Effect | Book Value |\n|--------|-------------|-------------------|------------|\n| Straight-Line | 12,000 | -12,000 | 48,000 |\n| Double-Declining | 30,000 | -30,000 | 30,000 |\n\n**Double-declining:** Lower profit early, higher profit later.\n\n---\n\n## Choosing a Method\n\n| Method | When to Use |\n|--------|-------------|\n| Straight-Line | Even benefit over time, simple to calculate |\n| Declining Balance | Technology, assets losing value quickly |\n| Units of Production | Usage varies significantly year to year |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - All methods depreciate the same total amount\n> - Straight-line: Simple and even\n> - Declining balance: More depreciation early\n> - Units of production: Based on actual usage\n> - Method choice affects timing of expense, not total expense"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 7.2: Asset Disposal
(
  'fa700000-0000-0000-0007-000000000002',
  'fa000000-0000-0000-0000-000000000007',
  '7.2',
  2,
  'Asset Disposal',
  'asset-disposal',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Asset Disposal\n\n## Why This Matters\n\nAssets don''t last forever. When a company sells, retires, or trades an asset, the accounting treatment depends on whether the proceeds exceed the book value.\n\n---\n\n## The Disposal Process\n\n### Step 1: Update Depreciation\n\nRecord depreciation up to the date of disposal.\n\n### Step 2: Calculate Book Value\n\n```\nBook Value = Cost - Accumulated Depreciation\n```\n\n### Step 3: Record the Disposal\n\nCompare proceeds to book value:\n\n| Scenario | Result |\n|----------|--------|\n| Proceeds > Book Value | Gain on Disposal |\n| Proceeds < Book Value | Loss on Disposal |\n| Proceeds = Book Value | No gain or loss |\n\n---\n\n## Example 1: Sale at a Gain\n\nPhantom Studios sells camera equipment:\n- Original cost: CHF 50,000\n- Accumulated depreciation: CHF 35,000\n- Sale price: CHF 20,000\n\n**Book Value = 50,000 - 35,000 = CHF 15,000**\n\n**Gain = 20,000 - 15,000 = CHF 5,000**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 20,000 | |\n| Accumulated Depreciation | 35,000 | |\n| Equipment | | 50,000 |\n| Gain on Disposal | | 5,000 |\n\n---\n\n## Example 2: Sale at a Loss\n\nNova Energy sells old machinery:\n- Original cost: CHF 80,000\n- Accumulated depreciation: CHF 55,000\n- Sale price: CHF 20,000\n\n**Book Value = 80,000 - 55,000 = CHF 25,000**\n\n**Loss = 25,000 - 20,000 = CHF 5,000**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 20,000 | |\n| Accumulated Depreciation | 55,000 | |\n| Loss on Disposal | 5,000 | |\n| Machinery | | 80,000 |\n\n---\n\n## Example 3: Retirement (No Proceeds)\n\nSwiss Confections scraps fully depreciated equipment:\n- Original cost: CHF 30,000\n- Accumulated depreciation: CHF 30,000\n- Proceeds: CHF 0\n\n**Book Value = 30,000 - 30,000 = CHF 0**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Accumulated Depreciation | 30,000 | |\n| Equipment | | 30,000 |\n\nNo gain or loss since book value equals proceeds.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Always update depreciation before disposal\n> - Book Value = Cost - Accumulated Depreciation\n> - Gain: Proceeds > Book Value\n> - Loss: Proceeds < Book Value\n> - Remove BOTH the asset AND its accumulated depreciation"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 7.3: Module 7 Checkpoint
(
  'fa700000-0000-0000-0007-000000000003',
  'fa000000-0000-0000-0000-000000000007',
  '7.3',
  3,
  'Module 7 Checkpoint',
  'module-7-checkpoint',
  'checkpoint',
  15,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "c1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Equipment costs CHF 100,000 with CHF 10,000 residual value and 5-year life. Using double-declining balance, what is Year 1 depreciation?",
        "options": [
          "CHF 18,000",
          "CHF 36,000",
          "CHF 40,000",
          "CHF 20,000"
        ],
        "correct": 2,
        "explanation": "Double-declining rate = 2 x (1/5) = 40%. Year 1 = 100,000 x 40% = CHF 40,000. (Note: Residual value not used in calculation, only as floor.)"
      },
      {
        "id": "c2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A machine with cost CHF 80,000, accumulated depreciation CHF 50,000, is sold for CHF 35,000. The result is:",
        "options": [
          "Gain of CHF 5,000",
          "Loss of CHF 5,000",
          "Gain of CHF 35,000",
          "No gain or loss"
        ],
        "correct": 0,
        "explanation": "Book Value = 80,000 - 50,000 = 30,000. Proceeds = 35,000. Gain = 35,000 - 30,000 = CHF 5,000."
      },
      {
        "id": "c3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which depreciation method best matches expense to usage for equipment that runs varying amounts each year?",
        "options": [
          "Straight-line",
          "Double-declining balance",
          "Units of production",
          "Sum-of-years-digits"
        ],
        "correct": 2,
        "explanation": "Units of production directly ties depreciation expense to actual usage, making it ideal for assets with variable usage patterns."
      },
      {
        "id": "c4",
        "type": "true_false",
        "difficulty": "exam",
        "question": "The total amount of depreciation expense over an asset''s life is the same regardless of which depreciation method is used.",
        "correct": true,
        "explanation": "TRUE. All methods depreciate the same total amount (Cost - Residual Value). Only the timing of when that expense is recognized differs."
      }
    ],
    "passing_score": 75,
    "show_explanations": true
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- MODULE 8: Liabilities & Equity
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 8.1: Understanding Liabilities
(
  'fa800000-0000-0000-0008-000000000001',
  'fa000000-0000-0000-0000-000000000008',
  '8.1',
  1,
  'Understanding Liabilities',
  'understanding-liabilities',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Understanding Liabilities\n\n## Why This Matters\n\nLiabilities represent a company''s obligations - what it owes to others. Understanding liabilities is crucial for assessing a company''s financial health and solvency.\n\n---\n\n## What is a Liability?\n\n> A **liability** is a present obligation arising from past events, the settlement of which is expected to result in an outflow of economic benefits.\n\n---\n\n## Current Liabilities\n\nDue within one year:\n\n| Liability | Description |\n|-----------|-------------|\n| Accounts Payable | Owed to suppliers for goods/services |\n| Wages Payable | Owed to employees |\n| Interest Payable | Accrued interest on loans |\n| Unearned Revenue | Received but not yet earned |\n| Short-term Loans | Bank loans due within 1 year |\n| Current Portion of Long-term Debt | Long-term debt due in next 12 months |\n\n---\n\n## Non-Current Liabilities\n\nDue after one year:\n\n| Liability | Description |\n|-----------|-------------|\n| Bonds Payable | Corporate bonds issued to investors |\n| Notes Payable (long-term) | Bank loans due after 1 year |\n| Lease Liabilities | Obligations under lease agreements |\n| Pension Obligations | Future retirement benefits |\n| Deferred Tax Liabilities | Taxes payable in future periods |\n\n---\n\n## Bonds Payable Basics\n\n### Key Terms\n\n- **Face Value (Par):** Amount repaid at maturity\n- **Coupon Rate:** Stated interest rate on bond\n- **Market Rate:** Current interest rate in market\n- **Issue Price:** What investors pay for the bond\n\n### Issued at Par, Discount, or Premium\n\n| Scenario | Coupon vs Market | Issue Price |\n|----------|------------------|-------------|\n| At Par | Coupon = Market | Face Value |\n| At Discount | Coupon < Market | Below Face |\n| At Premium | Coupon > Market | Above Face |\n\n---\n\n## Example: Bond Interest\n\nNova Energy issues a CHF 1,000,000 bond at par:\n- 5% coupon rate\n- Interest paid semi-annually\n\n**Each payment = 1,000,000 x 5% x 6/12 = CHF 25,000**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Interest Expense | 25,000 | |\n| Cash | | 25,000 |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Current liabilities due within 1 year\n> - Non-current liabilities due after 1 year\n> - Bonds issued at discount when coupon < market rate\n> - Bonds issued at premium when coupon > market rate\n> - Current portion of long-term debt is classified as current"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 8.2: Shareholders'' Equity
(
  'fa800000-0000-0000-0008-000000000002',
  'fa000000-0000-0000-0000-000000000008',
  '8.2',
  2,
  'Shareholders'' Equity',
  'shareholders-equity',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Shareholders'' Equity\n\n## Why This Matters\n\nShareholders'' equity represents the owners'' claim on a company''s assets after liabilities are paid. Understanding equity is essential for investors and analysts.\n\n---\n\n## Components of Equity\n\n### 1. Share Capital (Common Stock)\n\nAmount received from issuing shares.\n\n```\nShare Capital = Number of Shares x Par Value\n```\n\n### 2. Share Premium (Additional Paid-in Capital)\n\nAmount received above par value.\n\n```\nShare Premium = Issue Price - Par Value (per share) x Shares\n```\n\n### 3. Retained Earnings\n\nAccumulated profits not distributed as dividends.\n\n```\nEnding RE = Beginning RE + Net Income - Dividends\n```\n\n### 4. Treasury Stock\n\nCompany''s own shares repurchased. **Reduces equity.**\n\n---\n\n## Example: Share Issuance\n\nAlpine Foods issues 10,000 shares with CHF 1 par value for CHF 25 each:\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Cash | 250,000 | |\n| Share Capital (10,000 x 1) | | 10,000 |\n| Share Premium | | 240,000 |\n\n---\n\n## Dividends\n\n### Cash Dividends\n\n**Declaration Date:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Retained Earnings | X | |\n| Dividends Payable | | X |\n\n**Payment Date:**\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Dividends Payable | X | |\n| Cash | | X |\n\n### Stock Dividends\n\nDistribute additional shares instead of cash. Reclassifies within equity.\n\n---\n\n## Treasury Stock\n\nWhen a company buys back its own shares:\n\n| Account | Debit | Credit |\n|---------|-------|--------|\n| Treasury Stock | X | |\n| Cash | | X |\n\nTreasury stock is shown as a reduction of total equity.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Equity = Assets - Liabilities\n> - Share Capital + Share Premium = Contributed Capital\n> - Retained Earnings = Accumulated profits - Dividends\n> - Treasury Stock reduces total equity\n> - Dividends reduce Retained Earnings when declared"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 8.3: Module 8 Checkpoint
(
  'fa800000-0000-0000-0008-000000000003',
  'fa000000-0000-0000-0000-000000000008',
  '8.3',
  3,
  'Module 8 Checkpoint',
  'module-8-checkpoint',
  'checkpoint',
  15,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "c1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company issues 5,000 shares with CHF 2 par value for CHF 30 each. What is credited to Share Premium?",
        "options": [
          "CHF 10,000",
          "CHF 140,000",
          "CHF 150,000",
          "CHF 160,000"
        ],
        "correct": 1,
        "explanation": "Share Premium = (Issue price - Par) x Shares = (30 - 2) x 5,000 = CHF 140,000."
      },
      {
        "id": "c2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Beginning Retained Earnings: CHF 500,000. Net Income: CHF 120,000. Dividends declared: CHF 40,000. Ending Retained Earnings is:",
        "options": [
          "CHF 620,000",
          "CHF 580,000",
          "CHF 460,000",
          "CHF 540,000"
        ],
        "correct": 1,
        "explanation": "Ending RE = Beginning + Net Income - Dividends = 500,000 + 120,000 - 40,000 = CHF 580,000."
      },
      {
        "id": "c3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A bond is issued at a discount when:",
        "options": [
          "The coupon rate is higher than the market rate",
          "The coupon rate equals the market rate",
          "The coupon rate is lower than the market rate",
          "The bond matures in less than one year"
        ],
        "correct": 2,
        "explanation": "When the coupon rate < market rate, investors pay less than face value (discount) to achieve the market return."
      },
      {
        "id": "c4",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Treasury stock is an asset representing shares the company owns in other corporations.",
        "correct": false,
        "explanation": "FALSE. Treasury stock represents a company''s OWN shares that it has repurchased. It is a contra-equity account, reducing total shareholders'' equity."
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


