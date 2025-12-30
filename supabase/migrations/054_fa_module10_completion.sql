-- ============================================
-- FA Course Content Expansion - Phase 1 (continued)
-- Module 10: Comparative Analysis and Integration Skills
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 10.17: Comparative Analysis Case Study
-- Primary Skill: rat-comparative
-- ============================================
(
  'faa00000-0000-0000-000a-000000000017',
  'fa000000-0000-0000-0000-000000000010',
  '10.17',
  17,
  'Comparative Analysis: Industry Comparison',
  'comparative-analysis-industry',
  'interactive',
  22,
  55,
  'basic',
  '{
    "title": "Comparative Analysis: Swiss Retail Sector",
    "description": "Compare three Swiss retailers to identify the strongest performer using financial ratios.",
    "company_background": "You are an analyst comparing three Swiss retailers: Premium Foods (grocery), Urban Style (fashion), and Tech World (electronics). Each operates in different segments with unique characteristics.",
    "financial_data": {
      "premium_foods": {
        "name": "Premium Foods AG",
        "sector": "Grocery",
        "revenue": 1200000,
        "net_income": 36000,
        "total_assets": 480000,
        "shareholders_equity": 240000,
        "current_assets": 180000,
        "inventory": 120000,
        "current_liabilities": 200000
      },
      "urban_style": {
        "name": "Urban Style SA",
        "sector": "Fashion Retail",
        "revenue": 800000,
        "net_income": 64000,
        "total_assets": 640000,
        "shareholders_equity": 400000,
        "current_assets": 300000,
        "inventory": 180000,
        "current_liabilities": 150000
      },
      "tech_world": {
        "name": "Tech World GmbH",
        "sector": "Electronics",
        "revenue": 1000000,
        "net_income": 40000,
        "total_assets": 500000,
        "shareholders_equity": 200000,
        "current_assets": 280000,
        "inventory": 200000,
        "current_liabilities": 220000
      }
    },
    "questions": [
      {
        "id": "ca1",
        "question": "Which company has the highest Net Profit Margin?",
        "answer_type": "choice",
        "options": ["Premium Foods (3.0%)", "Urban Style (8.0%)", "Tech World (4.0%)"],
        "correct_answer": "Urban Style (8.0%)",
        "explanation": "Premium Foods: 36,000/1,200,000 = 3.0%; Urban Style: 64,000/800,000 = 8.0%; Tech World: 40,000/1,000,000 = 4.0%"
      },
      {
        "id": "ca2",
        "question": "Which company has the highest Asset Turnover?",
        "answer_type": "choice",
        "options": ["Premium Foods (2.5x)", "Urban Style (1.25x)", "Tech World (2.0x)"],
        "correct_answer": "Premium Foods (2.5x)",
        "explanation": "Premium Foods: 1,200,000/480,000 = 2.5x; Urban Style: 800,000/640,000 = 1.25x; Tech World: 1,000,000/500,000 = 2.0x"
      },
      {
        "id": "ca3",
        "question": "Which company has the highest Return on Equity (ROE)?",
        "answer_type": "choice",
        "options": ["Premium Foods (15.0%)", "Urban Style (16.0%)", "Tech World (20.0%)"],
        "correct_answer": "Tech World (20.0%)",
        "explanation": "Premium Foods: 36,000/240,000 = 15.0%; Urban Style: 64,000/400,000 = 16.0%; Tech World: 40,000/200,000 = 20.0%"
      },
      {
        "id": "ca4",
        "question": "Which company has the lowest Current Ratio (potential liquidity concern)?",
        "answer_type": "choice",
        "options": ["Premium Foods (0.90)", "Urban Style (2.00)", "Tech World (1.27)"],
        "correct_answer": "Premium Foods (0.90)",
        "explanation": "Premium Foods: 180,000/200,000 = 0.90; Urban Style: 300,000/150,000 = 2.00; Tech World: 280,000/220,000 = 1.27"
      },
      {
        "id": "ca5",
        "question": "Which company has the highest Debt-to-Equity ratio (highest leverage)?",
        "answer_type": "choice",
        "options": ["Premium Foods (1.0)", "Urban Style (0.6)", "Tech World (1.5)"],
        "correct_answer": "Tech World (1.5)",
        "explanation": "Premium Foods: 240,000/240,000 = 1.0; Urban Style: 240,000/400,000 = 0.6; Tech World: 300,000/200,000 = 1.5"
      },
      {
        "id": "ca6",
        "question": "Based on the analysis, which company appears to be the overall strongest performer?",
        "answer_type": "choice",
        "options": [
          "Premium Foods - Best efficiency but liquidity concerns",
          "Urban Style - Best profitability and liquidity balance",
          "Tech World - Highest ROE but highest leverage risk"
        ],
        "correct_answer": "Urban Style - Best profitability and liquidity balance",
        "explanation": "Urban Style has the highest profit margin (8%), best current ratio (2.0), lowest leverage (0.6 D/E), and competitive ROE (16%). It offers the best risk-adjusted performance."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  'ratio-calculator',
  false,
  true
),

-- ============================================
-- Activity 10.18: Year-over-Year Trend Analysis
-- Primary Skill: rat-comparative
-- ============================================
(
  'faa00000-0000-0000-000a-000000000018',
  'fa000000-0000-0000-0000-000000000010',
  '10.18',
  18,
  'Year-over-Year Trend Analysis',
  'yoy-trend-analysis',
  'interactive',
  20,
  50,
  'basic',
  '{
    "title": "Trend Analysis: Horizon Electronics",
    "description": "Analyze 3-year trends to identify improving or deteriorating performance at Horizon Electronics.",
    "company_background": "Horizon Electronics has grown rapidly but management is concerned about profitability trends. Analyze 3 years of data to identify patterns.",
    "financial_data": {
      "year_2022": {
        "revenue": 2000000,
        "gross_profit": 800000,
        "operating_income": 300000,
        "net_income": 210000,
        "total_assets": 1600000,
        "shareholders_equity": 1000000,
        "current_assets": 600000,
        "current_liabilities": 300000
      },
      "year_2023": {
        "revenue": 2400000,
        "gross_profit": 888000,
        "operating_income": 312000,
        "net_income": 218400,
        "total_assets": 2000000,
        "shareholders_equity": 1100000,
        "current_assets": 700000,
        "current_liabilities": 400000
      },
      "year_2024": {
        "revenue": 2880000,
        "gross_profit": 979200,
        "operating_income": 316800,
        "net_income": 221760,
        "total_assets": 2600000,
        "shareholders_equity": 1200000,
        "current_assets": 780000,
        "current_liabilities": 550000
      }
    },
    "questions": [
      {
        "id": "tr1",
        "question": "What is the revenue growth rate from 2022 to 2024 (total, not annual)?",
        "answer_type": "numeric",
        "correct_answer": 44.0,
        "tolerance": 0.5,
        "hint": "(2024 Revenue - 2022 Revenue) / 2022 Revenue x 100",
        "explanation": "Growth = (2,880,000 - 2,000,000) / 2,000,000 x 100 = 44.0%"
      },
      {
        "id": "tr2",
        "question": "Calculate the Gross Profit Margin for 2024 (as percentage, 1 decimal).",
        "answer_type": "numeric",
        "correct_answer": 34.0,
        "tolerance": 0.2,
        "explanation": "Gross Profit Margin 2024 = 979,200 / 2,880,000 = 34.0%"
      },
      {
        "id": "tr3",
        "question": "Calculate the Gross Profit Margin for 2022 (as percentage, 1 decimal).",
        "answer_type": "numeric",
        "correct_answer": 40.0,
        "tolerance": 0.2,
        "explanation": "Gross Profit Margin 2022 = 800,000 / 2,000,000 = 40.0%"
      },
      {
        "id": "tr4",
        "question": "What is the trend in Gross Profit Margin from 2022 to 2024?",
        "answer_type": "choice",
        "options": ["Improving", "Stable", "Deteriorating"],
        "correct_answer": "Deteriorating",
        "explanation": "Gross margin declined from 40.0% (2022) to 37.0% (2023) to 34.0% (2024) - a concerning downward trend despite revenue growth."
      },
      {
        "id": "tr5",
        "question": "What is the Current Ratio for 2024 (rounded to 2 decimals)?",
        "answer_type": "numeric",
        "correct_answer": 1.42,
        "tolerance": 0.02,
        "explanation": "Current Ratio 2024 = 780,000 / 550,000 = 1.42"
      },
      {
        "id": "tr6",
        "question": "What is the trend in Current Ratio from 2022 to 2024?",
        "answer_type": "choice",
        "options": ["Improving (higher)", "Stable", "Deteriorating (lower)"],
        "correct_answer": "Deteriorating (lower)",
        "explanation": "Current ratio: 2022 = 2.0, 2023 = 1.75, 2024 = 1.42. Liquidity is declining."
      }
    ],
    "analysis_summary": "While Horizon Electronics shows strong revenue growth (44% over 2 years), profitability margins are declining and liquidity is deteriorating. This pattern often indicates aggressive growth at the expense of operational efficiency.",
    "passing_score": 70
  }'::jsonb,
  'ratio-calculator',
  false,
  true
),

-- ============================================
-- Activity 10.19: Financial Statement Integration
-- Primary Skill: rat-integration
-- ============================================
(
  'faa00000-0000-0000-000a-000000000019',
  'fa000000-0000-0000-0000-000000000010',
  '10.19',
  19,
  'Three Statement Integration Exercise',
  'three-statement-integration',
  'interactive',
  25,
  60,
  'basic',
  '{
    "title": "Financial Statement Integration: Alpine Holdings",
    "description": "Understand how the three financial statements connect and validate relationships between them.",
    "company_background": "Alpine Holdings is a diversified company. You have partial financial statements and need to identify how they link together.",
    "financial_data": {
      "income_statement": {
        "revenue": 5000000,
        "cogs": 2500000,
        "operating_expenses": 1200000,
        "depreciation": 300000,
        "interest_expense": 150000,
        "tax_expense": 212500,
        "net_income": 637500
      },
      "balance_sheet_beginning": {
        "cash": 200000,
        "accounts_receivable": 400000,
        "inventory": 600000,
        "ppe_net": 2400000,
        "total_assets": 3600000,
        "accounts_payable": 350000,
        "notes_payable": 1000000,
        "shareholders_equity": 2250000
      },
      "balance_sheet_ending": {
        "cash": 325000,
        "accounts_receivable": 480000,
        "inventory": 550000,
        "ppe_net": 2200000,
        "total_assets": 3555000,
        "accounts_payable": 380000,
        "notes_payable": 800000,
        "shareholders_equity": 2375000,
        "retained_earnings_change": 125000
      },
      "cash_flow_statement": {
        "cfo": 775000,
        "cfi": -100000,
        "cff": -550000,
        "net_change": 125000
      },
      "additional_info": {
        "dividends_paid": 512500,
        "equipment_purchased": 100000,
        "debt_repaid": 200000
      }
    },
    "questions": [
      {
        "id": "int1",
        "question": "Does the change in cash tie between Balance Sheet and Cash Flow Statement? Calculate the change in cash.",
        "answer_type": "numeric",
        "correct_answer": 125000,
        "tolerance": 100,
        "hint": "Ending Cash - Beginning Cash should equal Net Change in CFS",
        "explanation": "325,000 - 200,000 = 125,000 = CFO (775,000) + CFI (-100,000) + CFF (-550,000)"
      },
      {
        "id": "int2",
        "question": "Net Income flows to Retained Earnings. Given Net Income of 637,500 and dividends of 512,500, what is the change in Retained Earnings?",
        "answer_type": "numeric",
        "correct_answer": 125000,
        "tolerance": 100,
        "explanation": "Change in RE = Net Income - Dividends = 637,500 - 512,500 = 125,000"
      },
      {
        "id": "int3",
        "question": "Depreciation expense reduces PPE on balance sheet. If beginning PPE was 2,400,000, depreciation was 300,000, and purchases were 100,000, what is ending PPE?",
        "answer_type": "numeric",
        "correct_answer": 2200000,
        "tolerance": 100,
        "explanation": "Ending PPE = 2,400,000 - 300,000 + 100,000 = 2,200,000"
      },
      {
        "id": "int4",
        "question": "What percentage of Net Income was paid as dividends (dividend payout ratio)?",
        "answer_type": "numeric",
        "correct_answer": 80.4,
        "tolerance": 0.5,
        "explanation": "Dividend Payout = 512,500 / 637,500 = 80.4%"
      },
      {
        "id": "int5",
        "question": "Verify: Does the Balance Sheet still balance? Total Assets - Total Liabilities = Equity. What are Total Liabilities at year end?",
        "answer_type": "numeric",
        "correct_answer": 1180000,
        "tolerance": 100,
        "hint": "Total Liabilities = Total Assets - Shareholders Equity",
        "explanation": "Total Liabilities = 3,555,000 - 2,375,000 = 1,180,000 (A/P 380,000 + Notes 800,000)"
      }
    ],
    "passing_score": 80
  }'::jsonb,
  'financial-linkage',
  false,
  true
),

-- ============================================
-- Activity 10.20: Financial Statement Linkage Quiz
-- Primary Skill: rat-integration
-- ============================================
(
  'faa00000-0000-0000-000a-000000000020',
  'fa000000-0000-0000-0000-000000000010',
  '10.20',
  20,
  'Financial Statement Linkage Quiz',
  'financial-statement-linkage-quiz',
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
        "question": "Net Income from the Income Statement flows to which Balance Sheet account?",
        "options": [
          "Cash",
          "Accounts Receivable",
          "Retained Earnings",
          "Accounts Payable"
        ],
        "correct": 2,
        "explanation": "Net Income increases Retained Earnings (part of shareholders equity). It does NOT directly increase cash."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The ending Cash balance on the Balance Sheet should equal:",
        "options": [
          "Net Income on the Income Statement",
          "Operating Cash Flow on the CFS",
          "Beginning Cash plus Net Change in Cash from CFS",
          "Total Assets minus Total Liabilities"
        ],
        "correct": 2,
        "explanation": "Ending Cash = Beginning Cash + CFO + CFI + CFF. This is the key link between Balance Sheet and Cash Flow Statement."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Depreciation expense appears on the Income Statement but is added back in CFO because:",
        "options": [
          "It is a cash expense that was already paid",
          "It is a non-cash expense that reduced Net Income",
          "It belongs in investing activities",
          "It is not a real expense"
        ],
        "correct": 1,
        "explanation": "Depreciation reduces Net Income but no cash was actually spent. In the indirect method, we add it back to convert from accrual net income to cash-basis operating cash flow."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Beginning Retained Earnings CHF 500,000; Net Income CHF 100,000; Dividends Declared CHF 30,000. What is Ending Retained Earnings?",
        "options": [
          "CHF 630,000",
          "CHF 600,000",
          "CHF 570,000",
          "CHF 530,000"
        ],
        "correct": 2,
        "explanation": "Ending RE = Beginning RE + Net Income - Dividends = 500,000 + 100,000 - 30,000 = CHF 570,000"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "exam",
        "question": "If a company has positive Net Income, it must also have positive Operating Cash Flow.",
        "correct": false,
        "explanation": "FALSE. A company can be profitable but have negative operating cash flow if, for example, accounts receivable increased significantly (sales not yet collected) or inventory built up."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "PPE on Balance Sheet decreased by CHF 50,000 despite no sales. If purchases were CHF 30,000, what was Depreciation Expense?",
        "options": [
          "CHF 20,000",
          "CHF 50,000",
          "CHF 80,000",
          "CHF 30,000"
        ],
        "correct": 2,
        "explanation": "Change in PPE = Purchases - Depreciation. If PPE decreased by 50,000: -50,000 = 30,000 - Depreciation. Depreciation = 30,000 + 50,000 = CHF 80,000."
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
-- ADD SKILL TAGS FOR REMAINING MODULE 10 ACTIVITIES
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary) VALUES

-- 10.17 Comparative Analysis Case
('faa00000-0000-0000-000a-000000000017', 'b0000000-0000-0000-0007-000000000006', 1.0, true),
-- Also tags profitability and liquidity as secondary
('faa00000-0000-0000-000a-000000000017', 'b0000000-0000-0000-0007-000000000001', 0.3, false),
('faa00000-0000-0000-000a-000000000017', 'b0000000-0000-0000-0007-000000000002', 0.3, false),

-- 10.18 Year-over-Year Trend Analysis
('faa00000-0000-0000-000a-000000000018', 'b0000000-0000-0000-0007-000000000006', 1.0, true),

-- 10.19 Three Statement Integration
('faa00000-0000-0000-000a-000000000019', 'b0000000-0000-0000-0007-000000000007', 1.0, true),
-- Also links to CFS interpretation
('faa00000-0000-0000-000a-000000000019', 'b0000000-0000-0000-0006-000000000005', 0.5, false),

-- 10.20 Financial Statement Linkage Quiz
('faa00000-0000-0000-000a-000000000020', 'b0000000-0000-0000-0007-000000000007', 1.0, true)

ON CONFLICT (activity_id, skill_id) DO UPDATE SET
  weight = EXCLUDED.weight,
  is_primary = EXCLUDED.is_primary;

