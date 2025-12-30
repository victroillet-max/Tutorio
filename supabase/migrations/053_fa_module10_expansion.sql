-- ============================================
-- FA Course Content Expansion - Phase 1
-- Module 10: Financial Analysis & Ratios
-- Adds 12 new dedicated activities for ratio skills
-- ============================================

-- ============================================
-- NEW ACTIVITIES FOR MODULE 10
-- Following existing UUID pattern: faa00000-0000-0000-000a-00000000XXXX
-- Existing activities: 0001-0004, new start at 0005
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 10.5: Profitability Ratios Calculator
-- Primary Skill: rat-profitability
-- ============================================
(
  'faa00000-0000-0000-000a-000000000005',
  'fa000000-0000-0000-0000-000000000010',
  '10.5',
  5,
  'Profitability Ratios Calculator',
  'profitability-ratios-calculator',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Profitability Ratios Calculator: Swiss Watches AG",
    "description": "Calculate and interpret profitability ratios for Swiss Watches AG, a premium watchmaker.",
    "company_background": "Swiss Watches AG manufactures luxury timepieces sold through exclusive boutiques worldwide. They compete on brand prestige and craftsmanship rather than volume.",
    "financial_data": {
      "income_statement": {
        "net_sales": 850000,
        "cogs": 340000,
        "gross_profit": 510000,
        "operating_expenses": 280000,
        "operating_income": 230000,
        "interest_expense": 15000,
        "income_before_tax": 215000,
        "income_tax": 53750,
        "net_income": 161250
      },
      "balance_sheet": {
        "total_assets": 1200000,
        "average_total_assets": 1150000,
        "shareholders_equity": 720000,
        "average_equity": 680000
      }
    },
    "questions": [
      {
        "id": "pr1",
        "question": "Calculate the Gross Profit Margin (as a percentage, rounded to 1 decimal).",
        "answer_type": "numeric",
        "correct_answer": 60.0,
        "tolerance": 0.2,
        "hint": "Gross Profit Margin = Gross Profit / Net Sales x 100",
        "explanation": "Gross Profit Margin = 510,000 / 850,000 x 100 = 60.0%"
      },
      {
        "id": "pr2",
        "question": "Calculate the Operating Profit Margin (as a percentage, rounded to 1 decimal).",
        "answer_type": "numeric",
        "correct_answer": 27.1,
        "tolerance": 0.2,
        "hint": "Operating Profit Margin = Operating Income / Net Sales x 100",
        "explanation": "Operating Margin = 230,000 / 850,000 x 100 = 27.1%"
      },
      {
        "id": "pr3",
        "question": "Calculate the Net Profit Margin (as a percentage, rounded to 1 decimal).",
        "answer_type": "numeric",
        "correct_answer": 19.0,
        "tolerance": 0.2,
        "hint": "Net Profit Margin = Net Income / Net Sales x 100",
        "explanation": "Net Profit Margin = 161,250 / 850,000 x 100 = 19.0%"
      },
      {
        "id": "pr4",
        "question": "Calculate Return on Assets (ROA) using average total assets (as a percentage, rounded to 1 decimal).",
        "answer_type": "numeric",
        "correct_answer": 14.0,
        "tolerance": 0.2,
        "hint": "ROA = Net Income / Average Total Assets x 100",
        "explanation": "ROA = 161,250 / 1,150,000 x 100 = 14.0%"
      },
      {
        "id": "pr5",
        "question": "Calculate Return on Equity (ROE) using average equity (as a percentage, rounded to 1 decimal).",
        "answer_type": "numeric",
        "correct_answer": 23.7,
        "tolerance": 0.2,
        "hint": "ROE = Net Income / Average Shareholders Equity x 100",
        "explanation": "ROE = 161,250 / 680,000 x 100 = 23.7%"
      }
    ],
    "passing_score": 80
  }'::jsonb,
  'ratio-calculator',
  false,
  true
),

-- ============================================
-- Activity 10.6: ROA and ROE Deep Dive
-- Primary Skill: rat-profitability
-- ============================================
(
  'faa00000-0000-0000-000a-000000000006',
  'fa000000-0000-0000-0000-000000000010',
  '10.6',
  6,
  'ROA and ROE Deep Dive',
  'roa-roe-deep-dive',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# ROA and ROE Deep Dive\n\n## Why This Matters\n\nROA and ROE are the two most important profitability ratios for investors and analysts. They reveal how efficiently a company uses its resources to generate returns.\n\n---\n\n## Return on Assets (ROA)\n\n### Formula\n\n```\nROA = Net Income / Average Total Assets\n```\n\n### What It Measures\n\nHow effectively management uses ALL assets (regardless of how they are financed) to generate profit.\n\n### Interpretation\n\n| ROA Range | Interpretation |\n|-----------|---------------|\n| > 15% | Excellent |\n| 10-15% | Good |\n| 5-10% | Average |\n| < 5% | Poor |\n\n**Note:** Industry comparison is essential. Capital-intensive industries (utilities, manufacturing) typically have lower ROA.\n\n---\n\n## Return on Equity (ROE)\n\n### Formula\n\n```\nROE = Net Income / Average Shareholders'' Equity\n```\n\n### What It Measures\n\nThe return generated specifically for shareholders on their investment.\n\n### Interpretation\n\n| ROE Range | Interpretation |\n|-----------|---------------|\n| > 20% | Excellent |\n| 15-20% | Good |\n| 10-15% | Average |\n| < 10% | Below average |\n\n---\n\n## The ROE-ROA Relationship\n\n### Key Insight\n\n```\nROE is almost always higher than ROA\n```\n\n**Why?** Because equity is only a portion of total assets. The difference comes from leverage (debt).\n\n### The Equity Multiplier Connection\n\n```\nEquity Multiplier = Total Assets / Shareholders'' Equity\n\nROE = ROA x Equity Multiplier\n```\n\n### Example: Alpine Holdings\n\n| Metric | Value |\n|--------|-------|\n| Net Income | CHF 100,000 |\n| Total Assets | CHF 1,000,000 |\n| Shareholders'' Equity | CHF 400,000 |\n\n**Calculations:**\n- ROA = 100,000 / 1,000,000 = **10%**\n- ROE = 100,000 / 400,000 = **25%**\n- Equity Multiplier = 1,000,000 / 400,000 = **2.5x**\n- Check: ROE = ROA x EM = 10% x 2.5 = **25%**\n\n---\n\n## Impact of Leverage on ROE\n\n### Scenario Analysis: Two Companies, Same ROA\n\n| Company | Assets | Equity | Debt | ROA | Equity Multiplier | ROE |\n|---------|--------|--------|------|-----|-------------------|-----|\n| Conservative Co. | 1,000 | 800 | 200 | 10% | 1.25x | 12.5% |\n| Leveraged Co. | 1,000 | 300 | 700 | 10% | 3.33x | 33.3% |\n\n**Key Insight:** Same ROA, but vastly different ROE due to leverage!\n\n### Warning: Leverage Amplifies Both Ways\n\n- **Good times:** Leverage boosts ROE\n- **Bad times:** Losses are magnified for shareholders\n- **Risk:** High leverage increases bankruptcy risk\n\n---\n\n## Using Average vs. Ending Balances\n\n### Why Use Averages?\n\nAssets and equity can change significantly during the year. Using the average provides a more accurate picture of the resources that generated the income.\n\n```\nAverage = (Beginning Balance + Ending Balance) / 2\n```\n\n### When to Use Ending Balance?\n\n- If beginning balance is not available\n- For quick estimates\n- When balances are relatively stable\n\n---\n\n## Industry Comparisons\n\n### Typical ROA by Industry\n\n| Industry | Typical ROA |\n|----------|------------|\n| Software | 15-25% |\n| Consumer Goods | 10-15% |\n| Retail | 5-10% |\n| Utilities | 3-6% |\n| Banking | 1-2% |\n\n### Typical ROE by Industry\n\n| Industry | Typical ROE |\n|----------|------------|\n| Technology | 20-35% |\n| Consumer Staples | 15-25% |\n| Industrials | 12-18% |\n| Utilities | 8-12% |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - ROA measures efficiency of ALL assets\n> - ROE measures return to shareholders\n> - ROE = ROA x Equity Multiplier\n> - Leverage increases ROE but also increases risk\n> - Use average balances when available\n> - Always compare to industry benchmarks"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 10.7: Profitability Ratios Quiz
-- Primary Skill: rat-profitability
-- ============================================
(
  'faa00000-0000-0000-000a-000000000007',
  'fa000000-0000-0000-0000-000000000010',
  '10.7',
  7,
  'Profitability Ratios Quiz',
  'profitability-ratios-quiz',
  'quiz',
  12,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which ratio measures the return generated for shareholders on their investment?",
        "options": [
          "Return on Assets (ROA)",
          "Return on Equity (ROE)",
          "Gross Profit Margin",
          "Current Ratio"
        ],
        "correct": 1,
        "explanation": "ROE measures the return generated specifically for shareholders by comparing net income to shareholders'' equity."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A company has Net Income of CHF 50,000 and Average Total Assets of CHF 400,000. What is the ROA?",
        "options": [
          "8.0%",
          "12.5%",
          "20.0%",
          "125.0%"
        ],
        "correct": 1,
        "explanation": "ROA = Net Income / Average Total Assets = 50,000 / 400,000 = 12.5%"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Company A has ROA of 8% and Equity Multiplier of 2.5. What is the ROE?",
        "options": [
          "3.2%",
          "10.5%",
          "20.0%",
          "5.0%"
        ],
        "correct": 2,
        "explanation": "ROE = ROA x Equity Multiplier = 8% x 2.5 = 20%"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Two companies have identical ROA of 10%. Company X has no debt; Company Y is 60% debt-financed. Which statement is TRUE?",
        "options": [
          "Company X will have higher ROE",
          "Company Y will have higher ROE",
          "Both will have identical ROE",
          "Cannot determine without more information"
        ],
        "correct": 1,
        "explanation": "Company Y has more leverage (higher debt), which amplifies ROE. With 60% debt, equity is 40% of assets, giving equity multiplier of 2.5x. Company Y ROE = 10% x 2.5 = 25%, while Company X ROE = 10% (no leverage)."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "A higher equity multiplier always indicates better company performance.",
        "correct": false,
        "explanation": "FALSE. A higher equity multiplier means more leverage (debt relative to equity). While this can boost ROE in good times, it also increases financial risk and can magnify losses during downturns."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Net Sales CHF 2,000,000; COGS CHF 1,200,000; Operating Expenses CHF 400,000; Interest CHF 50,000; Tax Rate 25%. What is the Net Profit Margin?",
        "options": [
          "13.1%",
          "17.5%",
          "20.0%",
          "40.0%"
        ],
        "correct": 0,
        "explanation": "Gross Profit = 800,000. Operating Income = 400,000. Income Before Tax = 350,000. Tax = 87,500. Net Income = 262,500. Net Profit Margin = 262,500 / 2,000,000 = 13.1%."
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
-- Activity 10.8: Liquidity Ratios Practice
-- Primary Skill: rat-liquidity
-- ============================================
(
  'faa00000-0000-0000-000a-000000000008',
  'fa000000-0000-0000-0000-000000000010',
  '10.8',
  8,
  'Liquidity Ratios Practice',
  'liquidity-ratios-practice',
  'interactive',
  15,
  40,
  'basic',
  '{
    "title": "Liquidity Analysis: Glacier Retail Group",
    "description": "Analyze the short-term solvency of Glacier Retail Group using liquidity ratios.",
    "company_background": "Glacier Retail Group operates 45 grocery stores across Switzerland. They need to maintain adequate liquidity to pay suppliers and employees.",
    "financial_data": {
      "current_assets": {
        "cash": 85000,
        "marketable_securities": 45000,
        "accounts_receivable": 120000,
        "inventory": 380000,
        "prepaid_expenses": 25000,
        "total": 655000
      },
      "current_liabilities": {
        "accounts_payable": 290000,
        "wages_payable": 65000,
        "short_term_debt": 80000,
        "total": 435000
      }
    },
    "questions": [
      {
        "id": "lq1",
        "question": "Calculate the Current Ratio (rounded to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 1.51,
        "tolerance": 0.02,
        "hint": "Current Ratio = Current Assets / Current Liabilities",
        "explanation": "Current Ratio = 655,000 / 435,000 = 1.51"
      },
      {
        "id": "lq2",
        "question": "Calculate the Quick Ratio (Acid-Test Ratio), excluding inventory and prepaids (rounded to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 0.57,
        "tolerance": 0.02,
        "hint": "Quick Ratio = (Cash + Marketable Securities + A/R) / Current Liabilities",
        "explanation": "Quick Assets = 85,000 + 45,000 + 120,000 = 250,000. Quick Ratio = 250,000 / 435,000 = 0.57"
      },
      {
        "id": "lq3",
        "question": "Calculate the Cash Ratio (rounded to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 0.30,
        "tolerance": 0.02,
        "hint": "Cash Ratio = (Cash + Marketable Securities) / Current Liabilities",
        "explanation": "Cash Ratio = (85,000 + 45,000) / 435,000 = 130,000 / 435,000 = 0.30"
      },
      {
        "id": "lq4",
        "question": "Based on these ratios, which best describes Glacier''s liquidity position?",
        "answer_type": "choice",
        "options": [
          "Excellent liquidity with significant buffer",
          "Adequate current ratio but tight quick ratio due to inventory reliance",
          "Critically low liquidity requiring immediate action",
          "Over-liquid with too much cash sitting idle"
        ],
        "correct_answer": "Adequate current ratio but tight quick ratio due to inventory reliance",
        "explanation": "Current ratio of 1.51 is acceptable, but quick ratio of 0.57 is below 1.0, indicating heavy reliance on inventory (typical for grocery retail)."
      }
    ],
    "passing_score": 75
  }'::jsonb,
  'ratio-calculator',
  false,
  true
),

-- ============================================
-- Activity 10.9: Current vs Quick Ratio Analysis
-- Primary Skill: rat-liquidity
-- ============================================
(
  'faa00000-0000-0000-000a-000000000009',
  'fa000000-0000-0000-0000-000000000010',
  '10.9',
  9,
  'Current vs Quick Ratio Analysis',
  'current-quick-ratio-analysis',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Current vs Quick Ratio Analysis\n\n## Why This Matters\n\nLiquidity ratios reveal whether a company can meet its short-term obligations. A company might be profitable but still face a cash crisis if it cannot pay bills when they come due.\n\n---\n\n## Current Ratio\n\n### Formula\n\n```\nCurrent Ratio = Current Assets / Current Liabilities\n```\n\n### What It Measures\n\nThe ability to pay short-term obligations using all current assets.\n\n### Interpretation\n\n| Ratio | Interpretation |\n|-------|---------------|\n| > 2.0 | Strong liquidity |\n| 1.5 - 2.0 | Healthy |\n| 1.0 - 1.5 | Adequate but tight |\n| < 1.0 | Potential liquidity problems |\n\n---\n\n## Quick Ratio (Acid-Test)\n\n### Formula\n\n```\nQuick Ratio = (Cash + Marketable Securities + A/R) / Current Liabilities\n```\n\n**Or equivalently:**\n```\nQuick Ratio = (Current Assets - Inventory - Prepaids) / Current Liabilities\n```\n\n### What It Measures\n\nAbility to pay short-term obligations WITHOUT selling inventory.\n\n### Why Exclude Inventory?\n\n- Inventory may not sell quickly\n- May need to be discounted to liquidate\n- Some inventory may be obsolete\n\n### Interpretation\n\n| Ratio | Interpretation |\n|-------|---------------|\n| > 1.0 | Can cover all current liabilities without selling inventory |\n| 0.5 - 1.0 | May need to convert some inventory to cash |\n| < 0.5 | Heavy reliance on inventory liquidation |\n\n---\n\n## Comparing the Two Ratios\n\n### What the Gap Reveals\n\n```\nGap = Current Ratio - Quick Ratio\n```\n\n**Large gap** = Heavy inventory reliance (common in retail, manufacturing)\n**Small gap** = Low inventory levels (common in services, software)\n\n### Industry Examples\n\n| Industry | Current Ratio | Quick Ratio | Gap |\n|----------|---------------|-------------|-----|\n| Software | 2.5 | 2.3 | 0.2 |\n| Consulting | 1.8 | 1.6 | 0.2 |\n| Grocery Retail | 1.4 | 0.5 | 0.9 |\n| Auto Manufacturing | 1.3 | 0.4 | 0.9 |\n\n---\n\n## Case Study: Two Retailers\n\n### Premium Fashion Boutique\n\n| Item | Amount |\n|------|--------|\n| Cash | CHF 50,000 |\n| A/R | 30,000 |\n| Inventory | 120,000 |\n| Current Liabilities | 100,000 |\n\n- Current Ratio = 200,000 / 100,000 = **2.0**\n- Quick Ratio = 80,000 / 100,000 = **0.8**\n\n### Electronics Discounter\n\n| Item | Amount |\n|------|--------|\n| Cash | CHF 80,000 |\n| A/R | 20,000 |\n| Inventory | 300,000 |\n| Current Liabilities | 200,000 |\n\n- Current Ratio = 400,000 / 200,000 = **2.0**\n- Quick Ratio = 100,000 / 200,000 = **0.5**\n\n### Analysis\n\nBoth have the same current ratio, but:\n- Fashion Boutique has better quick ratio (less inventory risk)\n- Electronics Discounter is more exposed to inventory obsolescence\n\n---\n\n## Working Capital\n\n### Formula\n\n```\nWorking Capital = Current Assets - Current Liabilities\n```\n\n### Relationship to Current Ratio\n\n- Working Capital > 0 = Current Ratio > 1.0\n- Working Capital < 0 = Current Ratio < 1.0\n\n---\n\n## Warning Signs\n\n### Declining Trend\n\n| Year | Current Ratio |\n|------|---------------|\n| 2022 | 2.1 |\n| 2023 | 1.6 |\n| 2024 | 1.2 |\n\nThis declining trend suggests potential liquidity problems ahead.\n\n### Unusual Inventory Buildup\n\nIf Current Ratio stays stable but Quick Ratio drops, inventory may be building up unsold.\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Current Ratio includes all current assets\n> - Quick Ratio excludes inventory and prepaids\n> - Large gap between ratios = high inventory reliance\n> - Quick Ratio < 1.0 may be normal for inventory-heavy businesses\n> - Trends matter more than single point readings\n> - Always compare to industry benchmarks"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 10.10: Liquidity Ratios Quiz
-- Primary Skill: rat-liquidity
-- ============================================
(
  'faa00000-0000-0000-000a-000000000010',
  'fa000000-0000-0000-0000-000000000010',
  '10.10',
  10,
  'Liquidity Ratios Quiz',
  'liquidity-ratios-quiz',
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
        "question": "Which asset is EXCLUDED from the Quick Ratio calculation?",
        "options": [
          "Cash",
          "Accounts Receivable",
          "Inventory",
          "Marketable Securities"
        ],
        "correct": 2,
        "explanation": "The Quick Ratio excludes inventory (and prepaid expenses) because they may not be quickly convertible to cash."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Current Assets CHF 500,000 including Inventory CHF 200,000. Current Liabilities CHF 400,000. What is the Quick Ratio?",
        "options": [
          "1.25",
          "0.75",
          "0.50",
          "1.00"
        ],
        "correct": 1,
        "explanation": "Quick Ratio = (Current Assets - Inventory) / Current Liabilities = (500,000 - 200,000) / 400,000 = 0.75"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A company has Current Ratio of 2.0 and Quick Ratio of 0.8. This suggests:",
        "options": [
          "Low reliance on inventory",
          "High reliance on inventory",
          "Negative working capital",
          "High accounts receivable"
        ],
        "correct": 1,
        "explanation": "A large gap between Current Ratio (2.0) and Quick Ratio (0.8) indicates that a significant portion of current assets is tied up in inventory."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Cash CHF 40,000; Marketable Securities CHF 20,000; A/R CHF 60,000; Inventory CHF 180,000; Current Liabilities CHF 150,000. What is the Cash Ratio?",
        "options": [
          "0.40",
          "0.80",
          "2.00",
          "0.27"
        ],
        "correct": 0,
        "explanation": "Cash Ratio = (Cash + Marketable Securities) / Current Liabilities = (40,000 + 20,000) / 150,000 = 0.40"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "A Current Ratio below 1.0 always indicates a company is in financial distress.",
        "correct": false,
        "explanation": "FALSE. Some industries (like grocery retailers) commonly operate with Current Ratios below 1.0 due to high inventory turnover and quick cash collection. Context and industry norms matter."
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
-- Activity 10.11: Solvency Ratios Calculator
-- Primary Skill: rat-solvency
-- ============================================
(
  'faa00000-0000-0000-000a-000000000011',
  'fa000000-0000-0000-0000-000000000010',
  '10.11',
  11,
  'Solvency Ratios Calculator',
  'solvency-ratios-calculator',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Solvency Analysis: Alpine Manufacturing SA",
    "description": "Evaluate the long-term financial health of Alpine Manufacturing SA using solvency ratios.",
    "company_background": "Alpine Manufacturing SA produces precision machinery for export. They have significant long-term debt from facility expansions.",
    "financial_data": {
      "balance_sheet": {
        "total_assets": 2500000,
        "total_liabilities": 1500000,
        "current_liabilities": 400000,
        "long_term_debt": 1100000,
        "shareholders_equity": 1000000
      },
      "income_statement": {
        "operating_income": 380000,
        "interest_expense": 85000,
        "net_income": 221250
      }
    },
    "questions": [
      {
        "id": "sv1",
        "question": "Calculate the Debt-to-Equity Ratio (rounded to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 1.50,
        "tolerance": 0.02,
        "hint": "D/E Ratio = Total Liabilities / Shareholders Equity",
        "explanation": "D/E = 1,500,000 / 1,000,000 = 1.50"
      },
      {
        "id": "sv2",
        "question": "Calculate the Debt Ratio (Total Liabilities to Total Assets) as a percentage.",
        "answer_type": "numeric",
        "correct_answer": 60.0,
        "tolerance": 0.5,
        "hint": "Debt Ratio = Total Liabilities / Total Assets x 100",
        "explanation": "Debt Ratio = 1,500,000 / 2,500,000 x 100 = 60%"
      },
      {
        "id": "sv3",
        "question": "Calculate the Interest Coverage Ratio (Times Interest Earned) rounded to 2 decimals.",
        "answer_type": "numeric",
        "correct_answer": 4.47,
        "tolerance": 0.05,
        "hint": "Interest Coverage = Operating Income (EBIT) / Interest Expense",
        "explanation": "Interest Coverage = 380,000 / 85,000 = 4.47x"
      },
      {
        "id": "sv4",
        "question": "What percentage of assets is financed by equity?",
        "answer_type": "numeric",
        "correct_answer": 40.0,
        "tolerance": 0.5,
        "hint": "Equity Ratio = Shareholders Equity / Total Assets x 100",
        "explanation": "Equity Ratio = 1,000,000 / 2,500,000 x 100 = 40%"
      },
      {
        "id": "sv5",
        "question": "Calculate the Equity Multiplier (rounded to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 2.50,
        "tolerance": 0.02,
        "hint": "Equity Multiplier = Total Assets / Shareholders Equity",
        "explanation": "Equity Multiplier = 2,500,000 / 1,000,000 = 2.50x"
      }
    ],
    "passing_score": 80
  }'::jsonb,
  'ratio-calculator',
  false,
  true
),

-- ============================================
-- Activity 10.12: Debt Analysis Lesson
-- Primary Skill: rat-solvency
-- ============================================
(
  'faa00000-0000-0000-000a-000000000012',
  'fa000000-0000-0000-0000-000000000010',
  '10.12',
  12,
  'Debt Analysis and Leverage',
  'debt-analysis-leverage',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Debt Analysis and Leverage\n\n## Why This Matters\n\nDebt (leverage) can amplify returns but also magnifies risk. Understanding solvency ratios helps assess whether a company can meet its long-term obligations and survive economic downturns.\n\n---\n\n## Key Solvency Ratios\n\n### 1. Debt-to-Equity Ratio (D/E)\n\n```\nD/E = Total Liabilities / Shareholders'' Equity\n```\n\n| D/E Ratio | Interpretation |\n|-----------|---------------|\n| < 0.5 | Conservative, low leverage |\n| 0.5 - 1.0 | Moderate leverage |\n| 1.0 - 2.0 | Significant leverage |\n| > 2.0 | Highly leveraged |\n\n### 2. Debt Ratio\n\n```\nDebt Ratio = Total Liabilities / Total Assets\n```\n\n- Shows the percentage of assets financed by debt\n- 60% debt ratio = 60% of assets funded by creditors\n\n### 3. Interest Coverage Ratio\n\n```\nInterest Coverage = EBIT / Interest Expense\n```\n\n| Coverage | Interpretation |\n|----------|---------------|\n| > 5x | Strong, can easily cover interest |\n| 3x - 5x | Adequate coverage |\n| 1.5x - 3x | Thin margin |\n| < 1.5x | Risk of default |\n\n---\n\n## The Double-Edged Sword of Debt\n\n### Benefits of Debt\n\n1. **Tax Shield:** Interest is tax-deductible\n2. **Amplified Returns:** Higher ROE when returns exceed cost of debt\n3. **Retained Control:** No equity dilution\n4. **Lower Cost:** Debt is typically cheaper than equity\n\n### Risks of Debt\n\n1. **Fixed Obligations:** Must pay regardless of performance\n2. **Bankruptcy Risk:** Unable to pay = potential default\n3. **Amplified Losses:** Works both ways in downturns\n4. **Covenants:** Restrictions from lenders\n\n---\n\n## Leverage Impact Example\n\n### Scenario: CHF 1,000,000 in Assets, 10% Return on Assets\n\n| Financing Mix | Net Income | ROE |\n|---------------|------------|-----|\n| 100% Equity | CHF 100,000 | 10% |\n| 50% Equity / 50% Debt (6% interest) | CHF 70,000 | 14% |\n| 25% Equity / 75% Debt (6% interest) | CHF 55,000 | 22% |\n\n**Math for 50/50:**\n- Assets = 1,000,000\n- Equity = 500,000, Debt = 500,000\n- EBIT = 100,000 (10% of assets)\n- Interest = 30,000 (6% of 500,000)\n- Net Income = 70,000\n- ROE = 70,000 / 500,000 = **14%**\n\n---\n\n## Industry Variations\n\n### Capital-Intensive Industries (Higher Leverage OK)\n\n| Industry | Typical D/E |\n|----------|-------------|\n| Utilities | 1.5 - 2.5 |\n| Telecommunications | 1.0 - 2.0 |\n| Real Estate | 1.5 - 3.0 |\n\n### Asset-Light Industries (Lower Leverage Expected)\n\n| Industry | Typical D/E |\n|----------|-------------|\n| Technology | 0.2 - 0.5 |\n| Healthcare | 0.3 - 0.8 |\n| Consulting | 0.2 - 0.6 |\n\n---\n\n## Warning Signs\n\n### Red Flags in Solvency Analysis\n\n1. **Interest Coverage < 2x:** Struggling to pay interest\n2. **Increasing D/E Trend:** Taking on more debt over time\n3. **D/E significantly above industry average:** Potential distress\n4. **High short-term debt portion:** Refinancing risk\n\n---\n\n## Relationship Between Ratios\n\n### The Equivalence\n\n```\nIf D/E = 1.5, then:\n- Debt Ratio = 60% (Liabilities are 60% of assets)\n- Equity Ratio = 40% (Equity is 40% of assets)\n- Equity Multiplier = 2.5 (Assets are 2.5x equity)\n```\n\n### Quick Conversions\n\n```\nDebt Ratio = D/E / (1 + D/E)\nEquity Multiplier = 1 + D/E\n```\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - D/E measures leverage: Higher = more debt relative to equity\n> - Interest Coverage: Can the company pay its interest?\n> - Leverage amplifies both gains and losses\n> - Industry context is essential for interpretation\n> - Watch for deteriorating trends over time"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 10.13: Solvency Ratios Quiz
-- Primary Skill: rat-solvency
-- ============================================
(
  'faa00000-0000-0000-000a-000000000013',
  'fa000000-0000-0000-0000-000000000010',
  '10.13',
  13,
  'Solvency Ratios Quiz',
  'solvency-ratios-quiz',
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
        "question": "What does a Debt-to-Equity ratio of 2.0 mean?",
        "options": [
          "The company has twice as much equity as debt",
          "The company has twice as much debt as equity",
          "The company has no debt",
          "The company is insolvent"
        ],
        "correct": 1,
        "explanation": "D/E of 2.0 means Total Liabilities are 2 times Shareholders Equity, indicating significant leverage."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Total Assets CHF 800,000; Total Liabilities CHF 500,000. What is the Debt Ratio?",
        "options": [
          "62.5%",
          "37.5%",
          "160.0%",
          "60.0%"
        ],
        "correct": 0,
        "explanation": "Debt Ratio = Total Liabilities / Total Assets = 500,000 / 800,000 = 62.5%"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Operating Income CHF 200,000; Interest Expense CHF 50,000. What is the Interest Coverage Ratio?",
        "options": [
          "0.25x",
          "4.0x",
          "25.0%",
          "250,000"
        ],
        "correct": 1,
        "explanation": "Interest Coverage = EBIT / Interest = 200,000 / 50,000 = 4.0x (times)"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which Interest Coverage Ratio indicates the HIGHEST risk of default?",
        "options": [
          "5.5x",
          "3.0x",
          "1.2x",
          "8.0x"
        ],
        "correct": 2,
        "explanation": "1.2x means operating income barely covers interest payments, indicating high default risk. The higher the ratio, the safer."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "A company with D/E of 1.0 has 50% of its assets financed by debt and 50% by equity.",
        "correct": true,
        "explanation": "TRUE. If D/E = 1.0, then Liabilities = Equity. Total Assets = Liabilities + Equity = 2 x Equity. So Debt Ratio = 50% and Equity Ratio = 50%."
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
-- Activity 10.14: Efficiency Ratios Calculator
-- Primary Skill: rat-efficiency
-- ============================================
(
  'faa00000-0000-0000-000a-000000000014',
  'fa000000-0000-0000-0000-000000000010',
  '10.14',
  14,
  'Efficiency Ratios Calculator',
  'efficiency-ratios-calculator',
  'interactive',
  18,
  45,
  'basic',
  '{
    "title": "Efficiency Analysis: Urban Fashion Group",
    "description": "Analyze how efficiently Urban Fashion Group uses its assets to generate revenue.",
    "company_background": "Urban Fashion Group operates a chain of trendy clothing stores targeting young professionals. Understanding their efficiency ratios helps assess operational performance.",
    "financial_data": {
      "income_statement": {
        "net_sales": 4800000,
        "cogs": 2880000
      },
      "balance_sheet": {
        "average_accounts_receivable": 240000,
        "average_inventory": 480000,
        "average_total_assets": 2400000
      }
    },
    "questions": [
      {
        "id": "ef1",
        "question": "Calculate the Inventory Turnover Ratio (rounded to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 6.00,
        "tolerance": 0.05,
        "hint": "Inventory Turnover = COGS / Average Inventory",
        "explanation": "Inventory Turnover = 2,880,000 / 480,000 = 6.00x per year"
      },
      {
        "id": "ef2",
        "question": "Calculate Days Inventory Outstanding (DIO) rounded to nearest whole number.",
        "answer_type": "numeric",
        "correct_answer": 61,
        "tolerance": 1,
        "hint": "DIO = 365 / Inventory Turnover",
        "explanation": "DIO = 365 / 6.00 = 60.8 = 61 days"
      },
      {
        "id": "ef3",
        "question": "Calculate the Receivables Turnover Ratio (rounded to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 20.00,
        "tolerance": 0.05,
        "hint": "Receivables Turnover = Net Credit Sales / Average A/R",
        "explanation": "Receivables Turnover = 4,800,000 / 240,000 = 20.00x per year"
      },
      {
        "id": "ef4",
        "question": "Calculate Days Sales Outstanding (DSO) rounded to nearest whole number.",
        "answer_type": "numeric",
        "correct_answer": 18,
        "tolerance": 1,
        "hint": "DSO = 365 / Receivables Turnover",
        "explanation": "DSO = 365 / 20.00 = 18.3 = 18 days"
      },
      {
        "id": "ef5",
        "question": "Calculate Total Asset Turnover (rounded to 2 decimals).",
        "answer_type": "numeric",
        "correct_answer": 2.00,
        "tolerance": 0.02,
        "hint": "Asset Turnover = Net Sales / Average Total Assets",
        "explanation": "Asset Turnover = 4,800,000 / 2,400,000 = 2.00x"
      }
    ],
    "passing_score": 80
  }'::jsonb,
  'ratio-calculator',
  false,
  true
),

-- ============================================
-- Activity 10.15: Turnover Ratios Lesson
-- Primary Skill: rat-efficiency
-- ============================================
(
  'faa00000-0000-0000-000a-000000000015',
  'fa000000-0000-0000-0000-000000000010',
  '10.15',
  15,
  'Turnover Ratios and Efficiency',
  'turnover-ratios-efficiency',
  'lesson',
  14,
  28,
  'basic',
  '{"markdown": "# Turnover Ratios and Efficiency\n\n## Why This Matters\n\nEfficiency ratios show how well a company uses its assets to generate revenue. Higher turnover generally means better asset utilization and faster cash conversion.\n\n---\n\n## Inventory Turnover\n\n### Formula\n\n```\nInventory Turnover = Cost of Goods Sold / Average Inventory\n\nDays Inventory Outstanding (DIO) = 365 / Inventory Turnover\n```\n\n### Interpretation\n\n| Turnover | DIO | Interpretation |\n|----------|-----|---------------|\n| 12x | 30 days | Fast-moving inventory |\n| 6x | 61 days | Moderate turnover |\n| 4x | 91 days | Slow-moving inventory |\n| 2x | 183 days | Potential obsolescence risk |\n\n### Industry Benchmarks\n\n| Industry | Typical Turnover |\n|----------|------------------|\n| Grocery | 15-20x |\n| Clothing Retail | 4-8x |\n| Electronics | 6-10x |\n| Auto Dealers | 8-12x |\n| Jewelry | 1-2x |\n\n---\n\n## Receivables Turnover\n\n### Formula\n\n```\nReceivables Turnover = Net Credit Sales / Average Accounts Receivable\n\nDays Sales Outstanding (DSO) = 365 / Receivables Turnover\n```\n\n### Interpretation\n\n| Turnover | DSO | Interpretation |\n|----------|-----|---------------|\n| 24x | 15 days | Excellent collection |\n| 12x | 30 days | Good (Net 30 terms) |\n| 8x | 46 days | Slow collection |\n| 4x | 91 days | Collection problems |\n\n### What Affects DSO?\n\n- Credit terms offered to customers\n- Customer creditworthiness\n- Collection practices\n- Industry norms\n\n---\n\n## Asset Turnover\n\n### Formula\n\n```\nAsset Turnover = Net Sales / Average Total Assets\n```\n\n### What It Measures\n\nHow many CHF of sales are generated per CHF of assets.\n\n### Industry Examples\n\n| Industry | Asset Turnover |\n|----------|---------------|\n| Grocery Retail | 3.0 - 4.0x |\n| Department Stores | 1.5 - 2.5x |\n| Manufacturing | 1.0 - 2.0x |\n| Utilities | 0.3 - 0.5x |\n| Software | 0.5 - 1.0x |\n\n---\n\n## The Cash Conversion Cycle\n\n### Formula\n\n```\nCash Conversion Cycle (CCC) = DIO + DSO - DPO\n\nWhere:\n- DIO = Days Inventory Outstanding\n- DSO = Days Sales Outstanding  \n- DPO = Days Payables Outstanding\n```\n\n### What It Measures\n\nThe number of days it takes to convert inventory investment into cash from sales.\n\n### Example: Alpine Retail\n\n| Metric | Value |\n|--------|-------|\n| DIO | 45 days |\n| DSO | 20 days |\n| DPO | 30 days |\n| **CCC** | **35 days** |\n\nAlpine needs to finance 35 days of working capital.\n\n---\n\n## Improving Efficiency\n\n### Strategies to Improve Inventory Turnover\n\n1. Better demand forecasting\n2. Just-in-time inventory management\n3. Faster identification of slow-moving items\n4. Promotional pricing to clear excess stock\n\n### Strategies to Improve Receivables Turnover\n\n1. Tighter credit approval process\n2. Early payment discounts (2/10, Net 30)\n3. Aggressive collection follow-up\n4. Electronic invoicing and payment\n\n---\n\n## Trade-offs to Consider\n\n### Inventory Turnover Trade-offs\n\n| Higher Turnover | Lower Turnover |\n|----------------|----------------|\n| Less capital tied up | Fewer stockouts |\n| Lower storage costs | Volume discounts |\n| Reduced obsolescence | Customer availability |\n\n### Receivables Turnover Trade-offs\n\n| Higher Turnover | Lower Turnover |\n|----------------|----------------|\n| Faster cash collection | More sales on credit |\n| Lower bad debt risk | Customer convenience |\n| Less financing needed | Competitive advantage |\n\n---\n\n## Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Higher turnover = more efficient use of assets\n> - Inventory Turnover uses COGS (not sales)\n> - Receivables Turnover uses credit sales\n> - Asset Turnover uses total sales\n> - Days Outstanding = 365 / Turnover\n> - CCC = DIO + DSO - DPO\n> - Always compare to industry benchmarks"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 10.16: Efficiency Ratios Quiz
-- Primary Skill: rat-efficiency
-- ============================================
(
  'faa00000-0000-0000-000a-000000000016',
  'fa000000-0000-0000-0000-000000000010',
  '10.16',
  16,
  'Efficiency Ratios Quiz',
  'efficiency-ratios-quiz',
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
        "question": "Which ratio measures how many times inventory is sold and replaced during a period?",
        "options": [
          "Current Ratio",
          "Inventory Turnover",
          "Asset Turnover",
          "Quick Ratio"
        ],
        "correct": 1,
        "explanation": "Inventory Turnover measures how many times inventory is sold and replaced during a period (typically a year)."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "COGS is CHF 600,000 and Average Inventory is CHF 100,000. What is Inventory Turnover?",
        "options": [
          "0.17x",
          "6.0x",
          "60x",
          "500,000"
        ],
        "correct": 1,
        "explanation": "Inventory Turnover = COGS / Average Inventory = 600,000 / 100,000 = 6.0x"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Receivables Turnover is 12x. What is Days Sales Outstanding (DSO)?",
        "options": [
          "12 days",
          "30 days",
          "365 days",
          "4,380 days"
        ],
        "correct": 1,
        "explanation": "DSO = 365 / Receivables Turnover = 365 / 12 = 30.4 = approximately 30 days"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "DIO is 60 days, DSO is 25 days, DPO is 40 days. What is the Cash Conversion Cycle?",
        "options": [
          "125 days",
          "45 days",
          "85 days",
          "35 days"
        ],
        "correct": 1,
        "explanation": "CCC = DIO + DSO - DPO = 60 + 25 - 40 = 45 days"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "A negative Cash Conversion Cycle means the company receives payment from customers before paying its suppliers.",
        "correct": true,
        "explanation": "TRUE. A negative CCC (common in retail) means the company collects from customers faster than it pays suppliers, essentially getting free financing from suppliers."
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
-- ADD SKILL TAGS FOR NEW MODULE 10 ACTIVITIES
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 10.5 Profitability Ratios Calculator
('faa00000-0000-0000-000a-000000000005', 'b0000000-0000-0000-0007-000000000001', 1.0, true),

-- 10.6 ROA and ROE Deep Dive
('faa00000-0000-0000-000a-000000000006', 'b0000000-0000-0000-0007-000000000001', 1.0, true),

-- 10.7 Profitability Ratios Quiz
('faa00000-0000-0000-000a-000000000007', 'b0000000-0000-0000-0007-000000000001', 1.0, true),

-- 10.8 Liquidity Ratios Practice
('faa00000-0000-0000-000a-000000000008', 'b0000000-0000-0000-0007-000000000002', 1.0, true),

-- 10.9 Current vs Quick Ratio Analysis
('faa00000-0000-0000-000a-000000000009', 'b0000000-0000-0000-0007-000000000002', 1.0, true),

-- 10.10 Liquidity Ratios Quiz
('faa00000-0000-0000-000a-000000000010', 'b0000000-0000-0000-0007-000000000002', 1.0, true),

-- 10.11 Solvency Ratios Calculator
('faa00000-0000-0000-000a-000000000011', 'b0000000-0000-0000-0007-000000000003', 1.0, true),

-- 10.12 Debt Analysis Lesson
('faa00000-0000-0000-000a-000000000012', 'b0000000-0000-0000-0007-000000000003', 1.0, true),

-- 10.13 Solvency Ratios Quiz
('faa00000-0000-0000-000a-000000000013', 'b0000000-0000-0000-0007-000000000003', 1.0, true),

-- 10.14 Efficiency Ratios Calculator
('faa00000-0000-0000-000a-000000000014', 'b0000000-0000-0000-0007-000000000004', 1.0, true),

-- 10.15 Turnover Ratios Lesson
('faa00000-0000-0000-000a-000000000015', 'b0000000-0000-0000-0007-000000000004', 1.0, true),

-- 10.16 Efficiency Ratios Quiz
('faa00000-0000-0000-000a-000000000016', 'b0000000-0000-0000-0007-000000000004', 1.0, true)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

