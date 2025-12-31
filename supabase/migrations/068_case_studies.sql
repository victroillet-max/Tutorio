-- Migration: Case Studies for Financial Accounting Course
-- Creates comprehensive case study activities for income statement, balance sheet, and CFS analysis
-- Note: All content is original and not derived from any copyrighted course materials

-- Case Study 1: Luxury Goods Company - Income Statement Analysis (inspired by luxury sector)
-- Added to Module 3 (Income Statement)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0003-000000000030',
  'fa000000-0000-0000-0000-000000000003',
  '3.30',
  30,
  'Case Study: Prestige Brands Income Analysis',
  'case-study-prestige-brands-income',
  'interactive',
  25,
  75,
  'basic',
  '{
    "exam_title": "Prestige Brands Co. - Income Statement Analysis",
    "instructions": "Prestige Brands Co. is a luxury fashion and accessories company. Analyze their income statement data and answer the following questions about their financial performance.",
    "time_limit_minutes": 25,
    "passing_score": 70,
    "sections": [
      {
        "id": "case-intro",
        "title": "Company Background & Analysis",
        "questions": [
          {
            "id": "pb-1",
            "type": "mcq",
            "topic": "Revenue Analysis",
            "question": "Prestige Brands reports: Revenue 2024: EUR 8,500M, Revenue 2023: EUR 7,650M. What is the year-over-year revenue growth rate?",
            "options": ["10.0%", "11.1%", "8.5%", "12.5%"],
            "correctAnswer": "11.1%",
            "points": 3,
            "explanation": "Growth rate = (8,500 - 7,650) / 7,650 = 850 / 7,650 = 11.1%. This indicates strong organic growth for the luxury sector."
          },
          {
            "id": "pb-2",
            "type": "calculation",
            "topic": "Gross Profit",
            "question": "If Prestige Brands has Revenue of EUR 8,500M and Cost of Sales of EUR 2,550M, what is their gross profit margin percentage (round to nearest whole number)?",
            "correctAnswer": 70,
            "points": 4,
            "explanation": "Gross Profit = 8,500 - 2,550 = 5,950M. Gross Margin = 5,950 / 8,500 = 70%. Luxury brands typically have high gross margins due to brand premium.",
            "hint": "Gross Profit Margin = (Revenue - COGS) / Revenue x 100"
          },
          {
            "id": "pb-3",
            "type": "mcq",
            "topic": "Operating Expenses",
            "question": "Prestige Brands spends EUR 2,125M on Selling & Marketing (25% of revenue). For a luxury brand, this level of marketing spend is:",
            "options": [
              "Unusually low - luxury brands typically spend 35-40%",
              "Typical for the industry - brand building is essential",
              "Too high - should be below 10%",
              "Irrelevant to profitability"
            ],
            "correctAnswer": "Typical for the industry - brand building is essential",
            "points": 2,
            "explanation": "Luxury brands invest heavily in marketing (20-30% of revenue) to maintain brand prestige and desirability."
          },
          {
            "id": "pb-4",
            "type": "calculation",
            "topic": "Operating Income",
            "question": "With Gross Profit of EUR 5,950M, Selling & Marketing of EUR 2,125M, and General & Admin of EUR 850M, what is Operating Income (in millions)?",
            "correctAnswer": 2975,
            "points": 3,
            "explanation": "Operating Income = Gross Profit - Operating Expenses = 5,950 - 2,125 - 850 = 2,975M",
            "hint": "Subtract all operating expenses from gross profit"
          },
          {
            "id": "pb-5",
            "type": "calculation",
            "topic": "Net Profit Margin",
            "question": "If Net Income is EUR 2,040M and Revenue is EUR 8,500M, what is the net profit margin (round to nearest whole number)?",
            "correctAnswer": 24,
            "points": 3,
            "explanation": "Net Profit Margin = 2,040 / 8,500 = 24%. This is an excellent margin, typical of successful luxury brands."
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

-- Case Study 2: Confectionery Company - Balance Sheet Focus (inspired by food industry)
-- Added to Module 2 (Balance Sheet)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0002-000000000030',
  'fa000000-0000-0000-0000-000000000002',
  '2.30',
  30,
  'Case Study: Sweet Delights Balance Sheet Analysis',
  'case-study-sweet-delights-balance-sheet',
  'interactive',
  25,
  75,
  'basic',
  '{
    "exam_title": "Sweet Delights Inc. - Balance Sheet Analysis",
    "instructions": "Sweet Delights Inc. is a premium chocolate and confectionery manufacturer. Analyze their balance sheet to understand their financial position, liquidity, and capital structure.",
    "time_limit_minutes": 25,
    "passing_score": 70,
    "sections": [
      {
        "id": "balance-analysis",
        "title": "Balance Sheet Components",
        "questions": [
          {
            "id": "sd-1",
            "type": "mcq",
            "topic": "Current Assets",
            "question": "Sweet Delights reports: Cash CHF 180M, Accounts Receivable CHF 320M, Inventory CHF 450M, Prepaid Expenses CHF 50M. What are total current assets?",
            "options": ["CHF 950M", "CHF 1,000M", "CHF 500M", "CHF 770M"],
            "correctAnswer": "CHF 1,000M",
            "points": 2,
            "explanation": "Total Current Assets = 180 + 320 + 450 + 50 = CHF 1,000M"
          },
          {
            "id": "sd-2",
            "type": "calculation",
            "topic": "Working Capital",
            "question": "Current Assets are CHF 1,000M and Current Liabilities are CHF 400M. What is the working capital (in millions)?",
            "correctAnswer": 600,
            "points": 3,
            "explanation": "Working Capital = Current Assets - Current Liabilities = 1,000 - 400 = CHF 600M. Positive working capital indicates good short-term liquidity.",
            "hint": "Working Capital = Current Assets - Current Liabilities"
          },
          {
            "id": "sd-3",
            "type": "calculation",
            "topic": "Current Ratio",
            "question": "With Current Assets of CHF 1,000M and Current Liabilities of CHF 400M, what is the current ratio (to one decimal)?",
            "correctAnswer": 2.5,
            "points": 3,
            "explanation": "Current Ratio = 1,000 / 400 = 2.5. A ratio above 2.0 indicates strong liquidity, though excess liquidity might mean underutilized capital."
          },
          {
            "id": "sd-4",
            "type": "mcq",
            "topic": "Capital Structure",
            "question": "Total Assets are CHF 3,000M, Total Liabilities are CHF 1,200M. What percentage of assets are financed by equity?",
            "options": ["40%", "60%", "120%", "80%"],
            "correctAnswer": "60%",
            "points": 3,
            "explanation": "Equity = Assets - Liabilities = 3,000 - 1,200 = 1,800M. Equity % = 1,800 / 3,000 = 60%. This indicates conservative financing."
          },
          {
            "id": "sd-5",
            "type": "calculation",
            "topic": "Debt-to-Equity",
            "question": "With Total Liabilities of CHF 1,200M and Shareholders'' Equity of CHF 1,800M, what is the debt-to-equity ratio (to two decimals)?",
            "correctAnswer": 0.67,
            "points": 3,
            "explanation": "D/E Ratio = 1,200 / 1,800 = 0.67. This relatively low ratio indicates the company is not heavily leveraged.",
            "hint": "D/E = Total Liabilities / Total Equity"
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

-- Case Study 3: Auto Parts Company - Cash Flow Statement (inspired by manufacturing)
-- Added to Module 9 (Cash Flow Statement)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0009-000000000031',
  'fa000000-0000-0000-0000-000000000009',
  '9.31',
  31,
  'Case Study: AutoParts Global Cash Flow Analysis',
  'case-study-autoparts-cash-flow',
  'interactive',
  30,
  85,
  'basic',
  '{
    "exam_title": "AutoParts Global - Cash Flow Statement Analysis",
    "instructions": "AutoParts Global manufactures components for the automotive industry. Their cash flow statement reveals important insights about operational efficiency and capital allocation. Analyze the data provided.",
    "time_limit_minutes": 30,
    "passing_score": 70,
    "sections": [
      {
        "id": "cfs-analysis",
        "title": "Cash Flow Analysis",
        "questions": [
          {
            "id": "ap-1",
            "type": "calculation",
            "topic": "Operating Cash Flow",
            "question": "Net Income is USD 85M. Depreciation is USD 45M. Accounts Receivable increased by USD 15M. Inventory decreased by USD 8M. Accounts Payable increased by USD 12M. Calculate Cash Flow from Operations (in millions).",
            "correctAnswer": 135,
            "points": 5,
            "explanation": "CFO = 85 + 45 (add depreciation) - 15 (A/R increase = cash outflow) + 8 (Inventory decrease = cash inflow) + 12 (A/P increase = cash inflow) = 135M",
            "hint": "Start with net income, add back non-cash items, then adjust for working capital changes"
          },
          {
            "id": "ap-2",
            "type": "mcq",
            "topic": "Cash Flow Quality",
            "question": "Net Income is USD 85M and Cash Flow from Operations is USD 135M. This indicates:",
            "options": [
              "Poor earnings quality - cash lower than income",
              "Strong earnings quality - cash exceeds income",
              "Accounting irregularities",
              "Declining business performance"
            ],
            "correctAnswer": "Strong earnings quality - cash exceeds income",
            "points": 2,
            "explanation": "When CFO exceeds Net Income, it typically indicates high earnings quality since the company is generating more cash than reported profit."
          },
          {
            "id": "ap-3",
            "type": "calculation",
            "topic": "Free Cash Flow",
            "question": "Cash Flow from Operations is USD 135M. Capital Expenditures (equipment purchases) are USD 60M. What is the Free Cash Flow (in millions)?",
            "correctAnswer": 75,
            "points": 3,
            "explanation": "Free Cash Flow = CFO - CapEx = 135 - 60 = 75M. This represents cash available for debt repayment, dividends, or reinvestment."
          },
          {
            "id": "ap-4",
            "type": "mcq",
            "topic": "Cash Flow Classification",
            "question": "AutoParts repaid USD 30M of long-term debt and paid USD 20M in dividends. Both transactions are classified as:",
            "options": [
              "Operating activities",
              "Investing activities",
              "Financing activities",
              "Debt repayment is financing; dividends are operating"
            ],
            "correctAnswer": "Financing activities",
            "points": 2,
            "explanation": "Both debt repayment (creditor transactions) and dividend payments (owner transactions) are financing activities."
          },
          {
            "id": "ap-5",
            "type": "calculation",
            "topic": "Net Cash Change",
            "question": "CFO is USD 135M, CFI is USD -60M (capital expenditures), CFF is USD -50M (debt + dividends). What is the net change in cash (in millions)?",
            "correctAnswer": 25,
            "points": 3,
            "explanation": "Net Change = 135 + (-60) + (-50) = 25M. The company increased its cash position by 25M during the period."
          },
          {
            "id": "ap-6",
            "type": "mcq",
            "topic": "Strategic Analysis",
            "question": "AutoParts has positive CFO (135M), negative CFI (-60M), and negative CFF (-50M). This cash flow pattern suggests:",
            "options": [
              "A distressed company selling assets",
              "A mature company funding investments and returning value to stakeholders",
              "A growing company raising external capital",
              "A startup burning cash"
            ],
            "correctAnswer": "A mature company funding investments and returning value to stakeholders",
            "points": 3,
            "explanation": "Positive CFO funding both investments (negative CFI) and stakeholder returns (negative CFF) is typical of mature, healthy companies."
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

-- Case Study 4: Food & Beverage Company - Comprehensive Analysis (inspired by consumer goods)
-- Added to Module 10 (Financial Analysis)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0010-000000000032',
  'fa000000-0000-0000-0000-000000000010',
  '10.32',
  32,
  'Case Study: Global Foods Comprehensive Analysis',
  'case-study-global-foods-comprehensive',
  'interactive',
  35,
  100,
  'basic',
  '{
    "exam_title": "Global Foods Corp. - Comprehensive Financial Analysis",
    "instructions": "Global Foods Corp. is a multinational food and beverage company. You will analyze data from their annual report to assess profitability, efficiency, and financial health.",
    "time_limit_minutes": 35,
    "passing_score": 65,
    "sections": [
      {
        "id": "profitability",
        "title": "Profitability Analysis",
        "questions": [
          {
            "id": "gf-1",
            "type": "calculation",
            "topic": "Return on Equity",
            "question": "Net Income is CHF 12,500M and Average Shareholders'' Equity is CHF 50,000M. Calculate ROE as a percentage.",
            "correctAnswer": 25,
            "points": 3,
            "explanation": "ROE = Net Income / Average Equity = 12,500 / 50,000 = 25%. This indicates strong returns for shareholders."
          },
          {
            "id": "gf-2",
            "type": "calculation",
            "topic": "Return on Assets",
            "question": "Net Income is CHF 12,500M and Average Total Assets are CHF 100,000M. Calculate ROA as a percentage.",
            "correctAnswer": 12.5,
            "points": 3,
            "explanation": "ROA = Net Income / Average Assets = 12,500 / 100,000 = 12.5%. This shows efficient use of company assets.",
            "hint": "ROA = Net Income / Average Total Assets"
          }
        ]
      },
      {
        "id": "efficiency",
        "title": "Efficiency Ratios",
        "questions": [
          {
            "id": "gf-3",
            "type": "calculation",
            "topic": "Asset Turnover",
            "question": "Revenue is CHF 95,000M and Average Total Assets are CHF 100,000M. What is the asset turnover ratio (to two decimals)?",
            "correctAnswer": 0.95,
            "points": 3,
            "explanation": "Asset Turnover = Revenue / Average Assets = 95,000 / 100,000 = 0.95. This measures how efficiently the company uses assets to generate sales."
          },
          {
            "id": "gf-4",
            "type": "calculation",
            "topic": "Inventory Days",
            "question": "Cost of Goods Sold is CHF 57,000M and Average Inventory is CHF 9,500M. How many days on average does inventory stay before being sold (round to nearest whole number)?",
            "correctAnswer": 61,
            "points": 4,
            "explanation": "Inventory Turnover = 57,000 / 9,500 = 6.0. Days Inventory = 365 / 6.0 = 61 days. Food companies typically have faster inventory turnover.",
            "hint": "First calculate inventory turnover, then divide 365 by the turnover"
          }
        ]
      },
      {
        "id": "dupont",
        "title": "DuPont Analysis",
        "questions": [
          {
            "id": "gf-5",
            "type": "mcq",
            "topic": "DuPont Framework",
            "question": "The DuPont formula decomposes ROE into three components. Which are they?",
            "options": [
              "Profit Margin x Asset Turnover x Equity Multiplier",
              "Gross Margin x Operating Margin x Net Margin",
              "Current Ratio x Quick Ratio x Cash Ratio",
              "Revenue Growth x Margin Growth x Asset Growth"
            ],
            "correctAnswer": "Profit Margin x Asset Turnover x Equity Multiplier",
            "points": 2,
            "explanation": "DuPont: ROE = Net Profit Margin (profitability) x Asset Turnover (efficiency) x Equity Multiplier (leverage)"
          },
          {
            "id": "gf-6",
            "type": "calculation",
            "topic": "Equity Multiplier",
            "question": "Average Total Assets are CHF 100,000M and Average Equity is CHF 50,000M. What is the equity multiplier?",
            "correctAnswer": 2,
            "points": 3,
            "explanation": "Equity Multiplier = Assets / Equity = 100,000 / 50,000 = 2.0. This means assets are twice the equity, with half financed by debt."
          },
          {
            "id": "gf-7",
            "type": "mcq",
            "topic": "DuPont Interpretation",
            "question": "If Net Profit Margin is 13.2%, Asset Turnover is 0.95, and Equity Multiplier is 2.0, what is ROE?",
            "options": ["25.1%", "12.5%", "26.4%", "15.2%"],
            "correctAnswer": "25.1%",
            "points": 3,
            "explanation": "ROE = 13.2% x 0.95 x 2.0 = 25.1%. This confirms our earlier ROE calculation through the DuPont decomposition."
          }
        ]
      }
    ]
  }',
  'mock-exam',
  65,
  false,
  true
);

-- Link activities to skills
INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0003-000000000030', id, true, true
FROM skills WHERE slug = 'is-profitability-analysis'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0002-000000000030', id, true, true
FROM skills WHERE slug = 'bs-liquidity-solvency'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0009-000000000031', id, true, true
FROM skills WHERE slug = 'cfs-indirect-method'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0010-000000000032', id, true, true
FROM skills WHERE slug = 'fa-financial-ratios'
ON CONFLICT DO NOTHING;
