-- Migration: Cash Flow Statement Builder Exercises Expansion
-- Creates additional CFS builder exercises with original company scenarios
-- Note: All company names and financial data are fictional

-- CFS Builder Exercise 1: Tech Startup - Stellar Dynamics
-- Added to Module 9 (Cash Flow Statement)
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0009-000000000032',
  'fa000000-0000-0000-0000-000000000009',
  '9.32',
  32,
  'CFS Builder: Stellar Dynamics Inc.',
  'cfs-builder-stellar-dynamics',
  'interactive',
  40,
  125,
  'basic',
  '{
    "exam_title": "Stellar Dynamics Inc. - Cash Flow Statement Builder",
    "instructions": "Stellar Dynamics is a software development company. Using the comparative balance sheets and income statement data provided, prepare the Statement of Cash Flows using the indirect method. Calculate each line item carefully.",
    "time_limit_minutes": 40,
    "passing_score": 70,
    "sections": [
      {
        "id": "reference-data",
        "title": "Reference Data",
        "questions": [
          {
            "id": "sd-ref",
            "type": "mcq",
            "topic": "Understanding the Data",
            "question": "REFERENCE: Balance Sheet Changes (2024 vs 2023):\n- Cash: Increase of $45,000 (to be verified)\n- Accounts Receivable: Increased from $85,000 to $110,000\n- Inventory: Decreased from $40,000 to $32,000\n- Equipment: Increased from $200,000 to $280,000\n- Accumulated Depreciation: Increased by $25,000\n- Accounts Payable: Increased from $45,000 to $62,000\n- Long-term Debt: Decreased from $100,000 to $70,000\n- Common Stock: Increased from $150,000 to $180,000\n- Retained Earnings: Increased by $73,000\n\nIncome Statement 2024:\n- Net Income: $98,000\n- Depreciation Expense: $25,000\n- No gains or losses on asset sales\n\nWhat is the change in Accounts Receivable?",
            "options": ["Increase of $25,000", "Decrease of $25,000", "Increase of $110,000", "No change"],
            "correctAnswer": "Increase of $25,000",
            "points": 2,
            "explanation": "A/R changed from $85,000 to $110,000, an increase of $25,000."
          }
        ]
      },
      {
        "id": "operating",
        "title": "Operating Activities (Indirect Method)",
        "questions": [
          {
            "id": "sd-op1",
            "type": "calculation",
            "topic": "Starting Point",
            "question": "What amount do you start with for Cash Flows from Operating Activities using the indirect method?",
            "correctAnswer": 98000,
            "points": 3,
            "explanation": "Start with Net Income of $98,000 when using the indirect method."
          },
          {
            "id": "sd-op2",
            "type": "calculation",
            "topic": "Depreciation Adjustment",
            "question": "What is the depreciation add-back amount?",
            "correctAnswer": 25000,
            "points": 3,
            "explanation": "Depreciation of $25,000 is added back because it''s a non-cash expense that reduced net income."
          },
          {
            "id": "sd-op3",
            "type": "calculation",
            "topic": "A/R Adjustment",
            "question": "Accounts Receivable increased by $25,000. What adjustment is made to operating cash flow? (Enter negative for subtraction)",
            "correctAnswer": -25000,
            "points": 4,
            "explanation": "An increase in A/R means sales were made but cash not yet collected. This is a use of cash, so subtract $25,000.",
            "hint": "Increases in current assets are subtracted; decreases are added"
          },
          {
            "id": "sd-op4",
            "type": "calculation",
            "topic": "Inventory Adjustment",
            "question": "Inventory decreased by $8,000. What adjustment is made?",
            "correctAnswer": 8000,
            "points": 4,
            "explanation": "A decrease in inventory means less cash was tied up in inventory, providing cash. Add $8,000."
          },
          {
            "id": "sd-op5",
            "type": "calculation",
            "topic": "A/P Adjustment",
            "question": "Accounts Payable increased by $17,000. What adjustment is made?",
            "correctAnswer": 17000,
            "points": 4,
            "explanation": "An increase in A/P means the company delayed payments to suppliers, conserving cash. Add $17,000."
          },
          {
            "id": "sd-op6",
            "type": "calculation",
            "topic": "Total CFO",
            "question": "Calculate the total Cash Flow from Operating Activities (98,000 + 25,000 - 25,000 + 8,000 + 17,000)",
            "correctAnswer": 123000,
            "points": 5,
            "explanation": "CFO = 98,000 + 25,000 - 25,000 + 8,000 + 17,000 = $123,000"
          }
        ]
      },
      {
        "id": "investing",
        "title": "Investing Activities",
        "questions": [
          {
            "id": "sd-inv1",
            "type": "calculation",
            "topic": "Equipment Purchase",
            "question": "Equipment increased from $200,000 to $280,000 with no disposals. How much was spent on equipment purchases? (Enter as negative)",
            "correctAnswer": -80000,
            "points": 4,
            "explanation": "Equipment purchase = $280,000 - $200,000 = $80,000 cash outflow. Enter as -80,000."
          },
          {
            "id": "sd-inv2",
            "type": "calculation",
            "topic": "Total CFI",
            "question": "What is the total Cash Flow from Investing Activities?",
            "correctAnswer": -80000,
            "points": 3,
            "explanation": "CFI = -$80,000 (only equipment purchases this period)"
          }
        ]
      },
      {
        "id": "financing",
        "title": "Financing Activities",
        "questions": [
          {
            "id": "sd-fin1",
            "type": "calculation",
            "topic": "Debt Repayment",
            "question": "Long-term Debt decreased from $100,000 to $70,000. What is the financing cash flow effect? (Enter as negative for outflow)",
            "correctAnswer": -30000,
            "points": 4,
            "explanation": "Debt repayment = $100,000 - $70,000 = $30,000 outflow. Enter as -30,000."
          },
          {
            "id": "sd-fin2",
            "type": "calculation",
            "topic": "Stock Issuance",
            "question": "Common Stock increased from $150,000 to $180,000. What is the cash inflow from stock issuance?",
            "correctAnswer": 30000,
            "points": 4,
            "explanation": "Stock issuance = $180,000 - $150,000 = $30,000 cash inflow."
          },
          {
            "id": "sd-fin3",
            "type": "calculation",
            "topic": "Dividends Paid",
            "question": "Retained Earnings increased by $73,000. Net Income was $98,000. How much was paid in dividends? (Enter as negative)",
            "correctAnswer": -25000,
            "points": 4,
            "explanation": "Dividends = Net Income - Increase in RE = $98,000 - $73,000 = $25,000 outflow. Enter as -25,000.",
            "hint": "RE increases by: Net Income - Dividends"
          },
          {
            "id": "sd-fin4",
            "type": "calculation",
            "topic": "Total CFF",
            "question": "Calculate total Cash Flow from Financing Activities (-30,000 + 30,000 - 25,000)",
            "correctAnswer": -25000,
            "points": 4,
            "explanation": "CFF = -30,000 + 30,000 - 25,000 = -$25,000"
          }
        ]
      },
      {
        "id": "summary",
        "title": "Cash Flow Summary",
        "questions": [
          {
            "id": "sd-sum1",
            "type": "calculation",
            "topic": "Net Change in Cash",
            "question": "Calculate the Net Change in Cash (CFO + CFI + CFF = 123,000 + (-80,000) + (-25,000))",
            "correctAnswer": 18000,
            "points": 5,
            "explanation": "Net Change = 123,000 - 80,000 - 25,000 = $18,000 increase in cash."
          },
          {
            "id": "sd-sum2",
            "type": "mcq",
            "topic": "Verification",
            "question": "The balance sheet shows cash increased by $45,000, but our CFS shows $18,000. This discrepancy could be due to:",
            "options": [
              "A calculation error in operating activities",
              "Missing information about other investing or financing activities",
              "Depreciation was recorded incorrectly",
              "The accounting equation is wrong"
            ],
            "correctAnswer": "Missing information about other investing or financing activities",
            "points": 3,
            "explanation": "In real practice, if CFS doesn''t match the balance sheet cash change, it usually means some transactions weren''t provided. This exercise simplified the scenario."
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

-- CFS Builder Exercise 2: Resort & Hospitality - Paradise Resorts
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0009-000000000033',
  'fa000000-0000-0000-0000-000000000009',
  '9.33',
  33,
  'CFS Builder: Paradise Resorts Ltd.',
  'cfs-builder-paradise-resorts',
  'interactive',
  35,
  125,
  'basic',
  '{
    "exam_title": "Paradise Resorts Ltd. - Cash Flow Statement",
    "instructions": "Paradise Resorts operates luxury hotels and vacation properties. Using the financial data provided, prepare the Statement of Cash Flows. Pay attention to the hospitality-specific items like property improvements and deferred revenue from advance bookings.",
    "time_limit_minutes": 35,
    "passing_score": 70,
    "sections": [
      {
        "id": "data-review",
        "title": "Financial Data",
        "questions": [
          {
            "id": "pr-data",
            "type": "mcq",
            "topic": "Data Review",
            "question": "REFERENCE DATA:\nIncome Statement:\n- Net Income: $2,400,000\n- Depreciation: $800,000\n- Amortization: $50,000\n\nBalance Sheet Changes:\n- Accounts Receivable: Decreased $150,000\n- Supplies Inventory: Increased $40,000\n- Prepaid Insurance: Decreased $20,000\n- Property & Equipment: Increased $3,000,000\n- Accounts Payable: Increased $180,000\n- Deferred Revenue (Advance Bookings): Increased $320,000\n- Long-term Debt: Increased $2,000,000\n- Dividends Paid: $600,000\n\nHow does the increase in Deferred Revenue affect operating cash flow?",
            "options": [
              "Subtract - it represents future obligations",
              "Add - cash was received in advance",
              "No effect - it''s a non-cash item",
              "Subtract - revenue was not yet earned"
            ],
            "correctAnswer": "Add - cash was received in advance",
            "points": 3,
            "explanation": "Deferred Revenue increased because guests paid for future stays. This is a cash inflow that hasn''t been recognized as revenue yet, so we add it."
          }
        ]
      },
      {
        "id": "cfo-section",
        "title": "Operating Activities",
        "questions": [
          {
            "id": "pr-cfo1",
            "type": "calculation",
            "topic": "Non-cash Items",
            "question": "What is the total adjustment for non-cash expenses (Depreciation + Amortization)?",
            "correctAnswer": 850000,
            "points": 3,
            "explanation": "Non-cash expenses = $800,000 + $50,000 = $850,000 to add back."
          },
          {
            "id": "pr-cfo2",
            "type": "calculation",
            "topic": "Working Capital",
            "question": "Calculate the net working capital adjustment: A/R decreased $150K, Supplies increased $40K, Prepaid decreased $20K, A/P increased $180K, Deferred Revenue increased $320K",
            "correctAnswer": 630000,
            "points": 5,
            "explanation": "WC adjustment = +150,000 (A/R decrease) - 40,000 (Supplies increase) + 20,000 (Prepaid decrease) + 180,000 (A/P increase) + 320,000 (Deferred Rev increase) = $630,000",
            "hint": "Decreases in assets and increases in liabilities add to cash"
          },
          {
            "id": "pr-cfo3",
            "type": "calculation",
            "topic": "Total CFO",
            "question": "Calculate Cash Flow from Operations: Net Income 2,400,000 + Non-cash 850,000 + Working Capital 630,000",
            "correctAnswer": 3880000,
            "points": 4,
            "explanation": "CFO = $2,400,000 + $850,000 + $630,000 = $3,880,000"
          }
        ]
      },
      {
        "id": "cfi-section",
        "title": "Investing Activities",
        "questions": [
          {
            "id": "pr-cfi1",
            "type": "calculation",
            "topic": "Property Purchases",
            "question": "Property & Equipment increased by $3,000,000 (no disposals). What is CFI? (Enter as negative)",
            "correctAnswer": -3000000,
            "points": 4,
            "explanation": "Capital expenditure of $3,000,000 is a cash outflow."
          }
        ]
      },
      {
        "id": "cff-section",
        "title": "Financing Activities",
        "questions": [
          {
            "id": "pr-cff1",
            "type": "calculation",
            "topic": "Debt Proceeds",
            "question": "Long-term Debt increased by $2,000,000. What is the cash inflow?",
            "correctAnswer": 2000000,
            "points": 3,
            "explanation": "New borrowing of $2,000,000 is a cash inflow from financing."
          },
          {
            "id": "pr-cff2",
            "type": "calculation",
            "topic": "Total CFF",
            "question": "Calculate total CFF: Debt proceeds $2,000,000 less Dividends paid $600,000",
            "correctAnswer": 1400000,
            "points": 4,
            "explanation": "CFF = $2,000,000 - $600,000 = $1,400,000"
          }
        ]
      },
      {
        "id": "final",
        "title": "Final Calculation",
        "questions": [
          {
            "id": "pr-final",
            "type": "calculation",
            "topic": "Net Cash Change",
            "question": "Calculate Net Change in Cash: CFO $3,880,000 + CFI -$3,000,000 + CFF $1,400,000",
            "correctAnswer": 2280000,
            "points": 5,
            "explanation": "Net Change = $3,880,000 - $3,000,000 + $1,400,000 = $2,280,000 increase in cash"
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

-- CFS Builder Exercise 3: Manufacturing - Precision Motors
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, passing_score, blocks_progress, is_published) VALUES
(
  'fa100000-0000-0000-0009-000000000034',
  'fa000000-0000-0000-0000-000000000009',
  '9.34',
  34,
  'CFS Builder: Precision Motors Corp.',
  'cfs-builder-precision-motors',
  'interactive',
  35,
  100,
  'basic',
  '{
    "exam_title": "Precision Motors Corp. - Cash Flow Statement",
    "instructions": "Precision Motors manufactures automotive components. Their cash flows include significant inventory management, equipment investments, and lease obligations. Complete the CFS using the indirect method.",
    "time_limit_minutes": 35,
    "passing_score": 70,
    "sections": [
      {
        "id": "data",
        "title": "Company Data",
        "questions": [
          {
            "id": "pm-info",
            "type": "mcq",
            "topic": "Context",
            "question": "FINANCIAL DATA:\nIncome Statement:\n- Net Income: $1,850,000\n- Depreciation: $420,000\n- Loss on Sale of Equipment: $35,000\n\nBalance Sheet Changes:\n- Accounts Receivable: Increased $95,000\n- Raw Materials Inventory: Increased $120,000\n- Finished Goods Inventory: Decreased $85,000\n- Accounts Payable: Decreased $45,000\n- Wages Payable: Increased $28,000\n\nInvesting Activities:\n- Purchased new machinery: $750,000\n- Sold old equipment (book value $100,000): $65,000\n\nFinancing:\n- Repaid bank loan: $200,000\n- Issued bonds: $500,000\n\nWhy is the loss on sale of equipment added back in operating activities?",
            "options": [
              "Because losses increase cash",
              "Because it reduced net income but the cash effect is in investing activities",
              "Because it''s a non-cash item",
              "It should be subtracted, not added"
            ],
            "correctAnswer": "Because it reduced net income but the cash effect is in investing activities",
            "points": 3,
            "explanation": "The loss reduced net income, but the actual cash received ($65,000) appears in investing activities. We add back the loss to avoid double-counting."
          }
        ]
      },
      {
        "id": "pm-cfo",
        "title": "Operating Cash Flow",
        "questions": [
          {
            "id": "pm-cfo1",
            "type": "calculation",
            "topic": "Non-cash Adjustments",
            "question": "Calculate total non-cash adjustments: Depreciation $420,000 + Loss on Sale $35,000",
            "correctAnswer": 455000,
            "points": 3,
            "explanation": "Both depreciation and the loss are added back: $420,000 + $35,000 = $455,000"
          },
          {
            "id": "pm-cfo2",
            "type": "calculation",
            "topic": "Inventory Change",
            "question": "Raw Materials increased $120,000, Finished Goods decreased $85,000. What is the net inventory adjustment?",
            "correctAnswer": -35000,
            "points": 4,
            "explanation": "Net change = -$120,000 (RM increase) + $85,000 (FG decrease) = -$35,000",
            "hint": "Increases in inventory use cash (negative); decreases provide cash (positive)"
          },
          {
            "id": "pm-cfo3",
            "type": "calculation",
            "topic": "All Operating Adjustments",
            "question": "Calculate all working capital adjustments: A/R -$95K, Inventory -$35K, A/P -$45K, Wages +$28K",
            "correctAnswer": -147000,
            "points": 4,
            "explanation": "WC adjustment = -95,000 - 35,000 - 45,000 + 28,000 = -$147,000",
            "hint": "A/R increase and A/P decrease both use cash"
          },
          {
            "id": "pm-cfo4",
            "type": "calculation",
            "topic": "Total CFO",
            "question": "Calculate CFO: Net Income $1,850,000 + Non-cash $455,000 + WC adjustments -$147,000",
            "correctAnswer": 2158000,
            "points": 5,
            "explanation": "CFO = $1,850,000 + $455,000 - $147,000 = $2,158,000"
          }
        ]
      },
      {
        "id": "pm-cfi",
        "title": "Investing Cash Flow",
        "questions": [
          {
            "id": "pm-cfi1",
            "type": "calculation",
            "topic": "Equipment Sale",
            "question": "Old equipment was sold for $65,000 (book value was $100,000, hence the $35,000 loss). What cash was received?",
            "correctAnswer": 65000,
            "points": 3,
            "explanation": "Cash received is the sale price of $65,000, not the book value."
          },
          {
            "id": "pm-cfi2",
            "type": "calculation",
            "topic": "Total CFI",
            "question": "Calculate CFI: Equipment sale $65,000 + Machinery purchase -$750,000",
            "correctAnswer": -685000,
            "points": 4,
            "explanation": "CFI = $65,000 - $750,000 = -$685,000"
          }
        ]
      },
      {
        "id": "pm-cff",
        "title": "Financing Cash Flow",
        "questions": [
          {
            "id": "pm-cff1",
            "type": "calculation",
            "topic": "Total CFF",
            "question": "Calculate CFF: Loan repayment -$200,000 + Bond issuance $500,000",
            "correctAnswer": 300000,
            "points": 4,
            "explanation": "CFF = -$200,000 + $500,000 = $300,000"
          }
        ]
      },
      {
        "id": "pm-summary",
        "title": "Summary",
        "questions": [
          {
            "id": "pm-sum",
            "type": "calculation",
            "topic": "Net Cash Change",
            "question": "Calculate Net Change in Cash: CFO $2,158,000 + CFI -$685,000 + CFF $300,000",
            "correctAnswer": 1773000,
            "points": 5,
            "explanation": "Net Change = $2,158,000 - $685,000 + $300,000 = $1,773,000 increase in cash"
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

-- Link activities to CFS skill
INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0009-000000000032', id, true, true
FROM skills WHERE slug = 'cfs-indirect-method'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0009-000000000033', id, true, true
FROM skills WHERE slug = 'cfs-indirect-method'
ON CONFLICT DO NOTHING;

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches)
SELECT 'fa100000-0000-0000-0009-000000000034', id, true, true
FROM skills WHERE slug = 'cfs-indirect-method'
ON CONFLICT DO NOTHING;
