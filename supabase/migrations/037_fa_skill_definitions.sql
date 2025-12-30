-- ============================================
-- Financial Accounting Skill Definitions
-- 40 skills across 7 categories with prerequisites
-- ============================================

-- ============================================
-- Add FA Skill Categories to Enum
-- Must be done outside transaction, so we use a workaround
-- ============================================

-- First, drop the NOT NULL constraint temporarily
ALTER TABLE skills ALTER COLUMN category DROP NOT NULL;

-- Drop ALL dependent functions that use skill_category in return type or parameters
DROP FUNCTION IF EXISTS get_course_skills(UUID, UUID, skill_category) CASCADE;
DROP FUNCTION IF EXISTS get_user_skill_progress(UUID, skill_category) CASCADE;
DROP FUNCTION IF EXISTS get_user_skill_mastery(UUID) CASCADE;
DROP FUNCTION IF EXISTS get_struggling_skills(UUID) CASCADE;
DROP FUNCTION IF EXISTS search_skills(TEXT) CASCADE;
DROP FUNCTION IF EXISTS get_coding_skill_tree(UUID) CASCADE;
DROP FUNCTION IF EXISTS get_course_coding_skills(UUID, UUID) CASCADE;

-- Create new enum with all values
DROP TYPE IF EXISTS skill_category_new CASCADE;
CREATE TYPE skill_category_new AS ENUM (
  'ct_foundations',
  'python_basics',
  'control_flow',
  'data_structures',
  'functions',
  'advanced_topics',
  'fa_foundations',
  'balance_sheet',
  'income_statement',
  'adjustments',
  'specialized_assets',
  'cash_flow',
  'financial_analysis'
);

-- Update the skills table to use the new enum
ALTER TABLE skills 
  ALTER COLUMN category TYPE skill_category_new 
  USING category::text::skill_category_new;

-- Drop old enum and rename new one
DROP TYPE skill_category;
ALTER TYPE skill_category_new RENAME TO skill_category;

-- Restore the NOT NULL constraint
ALTER TABLE skills ALTER COLUMN category SET NOT NULL;

-- ============================================
-- FA Foundations Skills (6 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- FA-01: Financial Statements Overview
(
  'b0000000-0000-0000-0001-000000000001',
  'fa-statements-overview',
  'Financial Statements Overview',
  'Understanding the purpose, users, and types of financial statements. The starting point for all financial analysis.',
  'fa_foundations',
  1,
  30,
  100
),
-- FA-02: Accounting Equation
(
  'b0000000-0000-0000-0001-000000000002',
  'fa-accounting-equation',
  'Accounting Equation',
  'Assets = Liabilities + Equity - the fundamental identity that underlies all of accounting.',
  'fa_foundations',
  1,
  25,
  101
),
-- FA-03: Transaction Analysis
(
  'b0000000-0000-0000-0001-000000000003',
  'fa-transaction-analysis',
  'Transaction Analysis',
  'How business events affect the accounting equation. Essential for understanding how entries are recorded.',
  'fa_foundations',
  2,
  35,
  102
),
-- FA-04: Accrual vs Cash Basis
(
  'b0000000-0000-0000-0001-000000000004',
  'fa-accrual-cash',
  'Accrual vs Cash Basis',
  'Understanding when revenue and expenses are recognized under different accounting methods.',
  'fa_foundations',
  2,
  30,
  103
),
-- FA-05: GAAP/IFRS Basics
(
  'b0000000-0000-0000-0001-000000000005',
  'fa-gaap-ifrs',
  'GAAP/IFRS Basics',
  'Key accounting principles and standards that govern financial reporting worldwide.',
  'fa_foundations',
  2,
  25,
  104
),
-- FA-06: Double-Entry Bookkeeping
(
  'b0000000-0000-0000-0001-000000000006',
  'fa-double-entry',
  'Double-Entry Bookkeeping',
  'Debits, credits, and journal entries - the mechanics of recording transactions.',
  'fa_foundations',
  2,
  40,
  105
);

-- ============================================
-- Balance Sheet Mastery Skills (6 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- BS-01: Current Assets
(
  'b0000000-0000-0000-0002-000000000001',
  'bs-current-assets',
  'Current Assets',
  'Cash, accounts receivable, inventory, and prepaid expenses - assets converted to cash within one year.',
  'balance_sheet',
  2,
  30,
  110
),
-- BS-02: Non-Current Assets
(
  'b0000000-0000-0000-0002-000000000002',
  'bs-noncurrent-assets',
  'Non-Current Assets',
  'Property, Plant & Equipment, intangible assets, and long-term investments.',
  'balance_sheet',
  2,
  35,
  111
),
-- BS-03: Current Liabilities
(
  'b0000000-0000-0000-0002-000000000003',
  'bs-current-liabilities',
  'Current Liabilities',
  'Accounts payable, accrued expenses, and unearned revenue - obligations due within one year.',
  'balance_sheet',
  2,
  30,
  112
),
-- BS-04: Non-Current Liabilities
(
  'b0000000-0000-0000-0002-000000000004',
  'bs-noncurrent-liabilities',
  'Non-Current Liabilities',
  'Bonds payable, notes payable, and other long-term debt instruments.',
  'balance_sheet',
  3,
  35,
  113
),
-- BS-05: Owners'' Equity
(
  'b0000000-0000-0000-0002-000000000005',
  'bs-owners-equity',
  'Owners'' Equity',
  'Common stock, retained earnings, and dividends - understanding the ownership claims on assets.',
  'balance_sheet',
  2,
  30,
  114
),
-- BS-06: Balance Sheet Interpretation
(
  'b0000000-0000-0000-0002-000000000006',
  'bs-interpretation',
  'Balance Sheet Interpretation',
  'Reading and analyzing a complete balance sheet for financial position assessment.',
  'balance_sheet',
  3,
  40,
  115
);

-- ============================================
-- Income Statement Mastery Skills (5 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- IS-01: Revenue Recognition
(
  'b0000000-0000-0000-0003-000000000001',
  'is-revenue-recognition',
  'Revenue Recognition',
  'When and how to record revenue according to accounting standards.',
  'income_statement',
  2,
  30,
  120
),
-- IS-02: Cost of Goods Sold
(
  'b0000000-0000-0000-0003-000000000002',
  'is-cogs',
  'Cost of Goods Sold',
  'Calculating COGS and gross profit - the direct costs of generating revenue.',
  'income_statement',
  2,
  35,
  121
),
-- IS-03: Operating Expenses
(
  'b0000000-0000-0000-0003-000000000003',
  'is-operating-expenses',
  'Operating Expenses',
  'SG&A, depreciation, and other expenses incurred in normal business operations.',
  'income_statement',
  2,
  30,
  122
),
-- IS-04: Income Taxes & Net Income
(
  'b0000000-0000-0000-0003-000000000004',
  'is-net-income',
  'Income Taxes & Net Income',
  'Tax expense calculation and arriving at the bottom-line profit.',
  'income_statement',
  2,
  25,
  123
),
-- IS-05: Income Statement Interpretation
(
  'b0000000-0000-0000-0003-000000000005',
  'is-interpretation',
  'Income Statement Interpretation',
  'Reading multi-step income statements and understanding profitability drivers.',
  'income_statement',
  3,
  35,
  124
);

-- ============================================
-- Adjustments & Accruals Skills (6 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- ADJ-01: Prepaid Expenses
(
  'b0000000-0000-0000-0004-000000000001',
  'adj-prepaid-expenses',
  'Prepaid Expenses',
  'Adjusting for expenses paid in advance - matching expenses to the correct period.',
  'adjustments',
  2,
  25,
  130
),
-- ADJ-02: Accrued Expenses
(
  'b0000000-0000-0000-0004-000000000002',
  'adj-accrued-expenses',
  'Accrued Expenses',
  'Recording expenses incurred but not yet paid - wages, interest, utilities.',
  'adjustments',
  2,
  25,
  131
),
-- ADJ-03: Unearned Revenue
(
  'b0000000-0000-0000-0004-000000000003',
  'adj-unearned-revenue',
  'Unearned Revenue',
  'Adjusting for revenue received in advance - recognizing earned portions.',
  'adjustments',
  2,
  25,
  132
),
-- ADJ-04: Accrued Revenue
(
  'b0000000-0000-0000-0004-000000000004',
  'adj-accrued-revenue',
  'Accrued Revenue',
  'Recording revenue earned but not yet received - services performed on account.',
  'adjustments',
  2,
  25,
  133
),
-- ADJ-05: Depreciation
(
  'b0000000-0000-0000-0004-000000000005',
  'adj-depreciation',
  'Depreciation',
  'Allocating the cost of long-lived assets over their useful life.',
  'adjustments',
  3,
  35,
  134
),
-- ADJ-06: Adjusted Trial Balance
(
  'b0000000-0000-0000-0004-000000000006',
  'adj-trial-balance',
  'Adjusted Trial Balance',
  'Creating financial statements from adjusted account balances.',
  'adjustments',
  3,
  40,
  135
);

-- ============================================
-- Specialized Asset Accounting Skills (5 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- SPEC-01: Accounts Receivable
(
  'b0000000-0000-0000-0005-000000000001',
  'spec-accounts-receivable',
  'Accounts Receivable',
  'Managing receivables, credit policies, and collections.',
  'specialized_assets',
  2,
  30,
  140
),
-- SPEC-02: Bad Debt & Allowances
(
  'b0000000-0000-0000-0005-000000000002',
  'spec-bad-debt',
  'Bad Debt & Allowances',
  'Estimating and recording uncollectible accounts using allowance method.',
  'specialized_assets',
  3,
  35,
  141
),
-- SPEC-03: Inventory Methods
(
  'b0000000-0000-0000-0005-000000000003',
  'spec-inventory-methods',
  'Inventory Methods',
  'FIFO, LIFO, and Weighted Average comparison and application.',
  'specialized_assets',
  3,
  40,
  142
),
-- SPEC-04: Depreciation Methods
(
  'b0000000-0000-0000-0005-000000000004',
  'spec-depreciation-methods',
  'Depreciation Methods',
  'Straight-line, declining balance, and units of production methods.',
  'specialized_assets',
  3,
  35,
  143
),
-- SPEC-05: Asset Disposal
(
  'b0000000-0000-0000-0005-000000000005',
  'spec-asset-disposal',
  'Asset Disposal',
  'Recording sales, retirements, and impairments of long-lived assets.',
  'specialized_assets',
  3,
  30,
  144
);

-- ============================================
-- Cash Flow Statement Skills (5 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- CFS-01: Cash Flow Categories
(
  'b0000000-0000-0000-0006-000000000001',
  'cfs-categories',
  'Cash Flow Categories',
  'Operating, investing, and financing activities - classifying cash flows correctly.',
  'cash_flow',
  3,
  30,
  150
),
-- CFS-02: Operating Activities
(
  'b0000000-0000-0000-0006-000000000002',
  'cfs-operating',
  'Operating Activities',
  'Indirect method adjustments - converting net income to cash from operations.',
  'cash_flow',
  3,
  40,
  151
),
-- CFS-03: Investing Activities
(
  'b0000000-0000-0000-0006-000000000003',
  'cfs-investing',
  'Investing Activities',
  'Capital expenditures, asset purchases and sales, investment transactions.',
  'cash_flow',
  3,
  30,
  152
),
-- CFS-04: Financing Activities
(
  'b0000000-0000-0000-0006-000000000004',
  'cfs-financing',
  'Financing Activities',
  'Debt and equity transactions - borrowings, repayments, dividends.',
  'cash_flow',
  3,
  30,
  153
),
-- CFS-05: Cash Flow Statement Interpretation
(
  'b0000000-0000-0000-0006-000000000005',
  'cfs-interpretation',
  'Cash Flow Statement Interpretation',
  'Complete CFS analysis, preparation, and linking to other statements.',
  'cash_flow',
  4,
  45,
  154
);

-- ============================================
-- Financial Analysis & Ratios Skills (7 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- RAT-01: Profitability Ratios
(
  'b0000000-0000-0000-0007-000000000001',
  'rat-profitability',
  'Profitability Ratios',
  'ROE, ROA, profit margins - measuring how efficiently a company generates profit.',
  'financial_analysis',
  3,
  35,
  160
),
-- RAT-02: Liquidity Ratios
(
  'b0000000-0000-0000-0007-000000000002',
  'rat-liquidity',
  'Liquidity Ratios',
  'Current ratio, quick ratio, cash ratio - assessing short-term solvency.',
  'financial_analysis',
  3,
  30,
  161
),
-- RAT-03: Solvency Ratios
(
  'b0000000-0000-0000-0007-000000000003',
  'rat-solvency',
  'Solvency Ratios',
  'Debt-to-equity, interest coverage - evaluating long-term financial health.',
  'financial_analysis',
  3,
  30,
  162
),
-- RAT-04: Efficiency Ratios
(
  'b0000000-0000-0000-0007-000000000004',
  'rat-efficiency',
  'Efficiency Ratios',
  'Inventory turnover, receivables turnover, asset turnover - operational efficiency.',
  'financial_analysis',
  3,
  35,
  163
),
-- RAT-05: Du Pont Analysis
(
  'b0000000-0000-0000-0007-000000000005',
  'rat-dupont',
  'Du Pont Analysis',
  'Decomposing ROE into its three drivers: profitability, efficiency, and leverage.',
  'financial_analysis',
  4,
  40,
  164
),
-- RAT-06: Comparative Analysis
(
  'b0000000-0000-0000-0007-000000000006',
  'rat-comparative',
  'Comparative Analysis',
  'Year-over-year analysis, peer comparisons, and trend identification.',
  'financial_analysis',
  4,
  35,
  165
),
-- RAT-07: Financial Statement Integration
(
  'b0000000-0000-0000-0007-000000000007',
  'rat-integration',
  'Financial Statement Integration',
  'Understanding how all three financial statements connect and inform each other.',
  'financial_analysis',
  4,
  45,
  166
);

-- ============================================
-- Skill Prerequisites
-- ============================================

INSERT INTO skill_prerequisites (skill_id, prerequisite_skill_id, is_required) VALUES
-- FA Foundations prerequisites
('b0000000-0000-0000-0001-000000000002', 'b0000000-0000-0000-0001-000000000001', true),  -- Accounting Equation requires Statements Overview
('b0000000-0000-0000-0001-000000000003', 'b0000000-0000-0000-0001-000000000002', true),  -- Transaction Analysis requires Accounting Equation
('b0000000-0000-0000-0001-000000000004', 'b0000000-0000-0000-0001-000000000003', true),  -- Accrual vs Cash requires Transaction Analysis
('b0000000-0000-0000-0001-000000000005', 'b0000000-0000-0000-0001-000000000001', true),  -- GAAP/IFRS requires Statements Overview
('b0000000-0000-0000-0001-000000000006', 'b0000000-0000-0000-0001-000000000003', true),  -- Double-Entry requires Transaction Analysis

-- Balance Sheet prerequisites
('b0000000-0000-0000-0002-000000000001', 'b0000000-0000-0000-0001-000000000006', true),  -- Current Assets requires Double-Entry
('b0000000-0000-0000-0002-000000000002', 'b0000000-0000-0000-0002-000000000001', true),  -- Non-Current Assets requires Current Assets
('b0000000-0000-0000-0002-000000000003', 'b0000000-0000-0000-0001-000000000006', true),  -- Current Liabilities requires Double-Entry
('b0000000-0000-0000-0002-000000000004', 'b0000000-0000-0000-0002-000000000003', true),  -- Non-Current Liabilities requires Current Liabilities
('b0000000-0000-0000-0002-000000000005', 'b0000000-0000-0000-0001-000000000002', true),  -- Owners Equity requires Accounting Equation
('b0000000-0000-0000-0002-000000000006', 'b0000000-0000-0000-0002-000000000001', true),  -- BS Interpretation requires Current Assets
('b0000000-0000-0000-0002-000000000006', 'b0000000-0000-0000-0002-000000000002', true),  -- BS Interpretation requires Non-Current Assets
('b0000000-0000-0000-0002-000000000006', 'b0000000-0000-0000-0002-000000000003', true),  -- BS Interpretation requires Current Liabilities
('b0000000-0000-0000-0002-000000000006', 'b0000000-0000-0000-0002-000000000004', true),  -- BS Interpretation requires Non-Current Liabilities
('b0000000-0000-0000-0002-000000000006', 'b0000000-0000-0000-0002-000000000005', true),  -- BS Interpretation requires Owners Equity

-- Income Statement prerequisites
('b0000000-0000-0000-0003-000000000001', 'b0000000-0000-0000-0001-000000000004', true),  -- Revenue Recognition requires Accrual vs Cash
('b0000000-0000-0000-0003-000000000002', 'b0000000-0000-0000-0001-000000000006', true),  -- COGS requires Double-Entry
('b0000000-0000-0000-0003-000000000003', 'b0000000-0000-0000-0001-000000000006', true),  -- Operating Expenses requires Double-Entry
('b0000000-0000-0000-0003-000000000004', 'b0000000-0000-0000-0003-000000000003', true),  -- Net Income requires Operating Expenses
('b0000000-0000-0000-0003-000000000005', 'b0000000-0000-0000-0003-000000000001', true),  -- IS Interpretation requires Revenue Recognition
('b0000000-0000-0000-0003-000000000005', 'b0000000-0000-0000-0003-000000000002', true),  -- IS Interpretation requires COGS
('b0000000-0000-0000-0003-000000000005', 'b0000000-0000-0000-0003-000000000003', true),  -- IS Interpretation requires Operating Expenses
('b0000000-0000-0000-0003-000000000005', 'b0000000-0000-0000-0003-000000000004', true),  -- IS Interpretation requires Net Income

-- Adjustments prerequisites
('b0000000-0000-0000-0004-000000000001', 'b0000000-0000-0000-0002-000000000001', true),  -- Prepaid Expenses requires Current Assets
('b0000000-0000-0000-0004-000000000002', 'b0000000-0000-0000-0002-000000000003', true),  -- Accrued Expenses requires Current Liabilities
('b0000000-0000-0000-0004-000000000003', 'b0000000-0000-0000-0003-000000000001', true),  -- Unearned Revenue requires Revenue Recognition
('b0000000-0000-0000-0004-000000000004', 'b0000000-0000-0000-0003-000000000001', true),  -- Accrued Revenue requires Revenue Recognition
('b0000000-0000-0000-0004-000000000005', 'b0000000-0000-0000-0002-000000000002', true),  -- Depreciation requires Non-Current Assets
('b0000000-0000-0000-0004-000000000006', 'b0000000-0000-0000-0004-000000000001', true),  -- Adjusted TB requires Prepaid Expenses
('b0000000-0000-0000-0004-000000000006', 'b0000000-0000-0000-0004-000000000002', true),  -- Adjusted TB requires Accrued Expenses
('b0000000-0000-0000-0004-000000000006', 'b0000000-0000-0000-0004-000000000003', true),  -- Adjusted TB requires Unearned Revenue
('b0000000-0000-0000-0004-000000000006', 'b0000000-0000-0000-0004-000000000004', true),  -- Adjusted TB requires Accrued Revenue
('b0000000-0000-0000-0004-000000000006', 'b0000000-0000-0000-0004-000000000005', true),  -- Adjusted TB requires Depreciation

-- Specialized Assets prerequisites
('b0000000-0000-0000-0005-000000000001', 'b0000000-0000-0000-0002-000000000001', true),  -- A/R requires Current Assets
('b0000000-0000-0000-0005-000000000002', 'b0000000-0000-0000-0005-000000000001', true),  -- Bad Debt requires A/R
('b0000000-0000-0000-0005-000000000003', 'b0000000-0000-0000-0003-000000000002', true),  -- Inventory Methods requires COGS
('b0000000-0000-0000-0005-000000000004', 'b0000000-0000-0000-0004-000000000005', true),  -- Depreciation Methods requires Depreciation
('b0000000-0000-0000-0005-000000000005', 'b0000000-0000-0000-0005-000000000004', true),  -- Asset Disposal requires Depreciation Methods

-- Cash Flow Statement prerequisites
('b0000000-0000-0000-0006-000000000001', 'b0000000-0000-0000-0002-000000000006', true),  -- CFS Categories requires BS Interpretation
('b0000000-0000-0000-0006-000000000001', 'b0000000-0000-0000-0003-000000000005', true),  -- CFS Categories requires IS Interpretation
('b0000000-0000-0000-0006-000000000002', 'b0000000-0000-0000-0006-000000000001', true),  -- Operating requires CFS Categories
('b0000000-0000-0000-0006-000000000003', 'b0000000-0000-0000-0006-000000000001', true),  -- Investing requires CFS Categories
('b0000000-0000-0000-0006-000000000004', 'b0000000-0000-0000-0006-000000000001', true),  -- Financing requires CFS Categories
('b0000000-0000-0000-0006-000000000005', 'b0000000-0000-0000-0006-000000000002', true),  -- CFS Interpretation requires Operating
('b0000000-0000-0000-0006-000000000005', 'b0000000-0000-0000-0006-000000000003', true),  -- CFS Interpretation requires Investing
('b0000000-0000-0000-0006-000000000005', 'b0000000-0000-0000-0006-000000000004', true),  -- CFS Interpretation requires Financing

-- Financial Analysis prerequisites
('b0000000-0000-0000-0007-000000000001', 'b0000000-0000-0000-0003-000000000005', true),  -- Profitability requires IS Interpretation
('b0000000-0000-0000-0007-000000000002', 'b0000000-0000-0000-0002-000000000006', true),  -- Liquidity requires BS Interpretation
('b0000000-0000-0000-0007-000000000003', 'b0000000-0000-0000-0002-000000000004', true),  -- Solvency requires Non-Current Liabilities
('b0000000-0000-0000-0007-000000000004', 'b0000000-0000-0000-0005-000000000001', true),  -- Efficiency requires A/R
('b0000000-0000-0000-0007-000000000004', 'b0000000-0000-0000-0005-000000000003', true),  -- Efficiency requires Inventory Methods
('b0000000-0000-0000-0007-000000000005', 'b0000000-0000-0000-0007-000000000001', true),  -- Du Pont requires Profitability
('b0000000-0000-0000-0007-000000000005', 'b0000000-0000-0000-0007-000000000004', true),  -- Du Pont requires Efficiency
('b0000000-0000-0000-0007-000000000006', 'b0000000-0000-0000-0007-000000000001', true),  -- Comparative requires Profitability
('b0000000-0000-0000-0007-000000000006', 'b0000000-0000-0000-0007-000000000002', true),  -- Comparative requires Liquidity
('b0000000-0000-0000-0007-000000000006', 'b0000000-0000-0000-0007-000000000003', true),  -- Comparative requires Solvency
('b0000000-0000-0000-0007-000000000006', 'b0000000-0000-0000-0007-000000000004', true),  -- Comparative requires Efficiency
('b0000000-0000-0000-0007-000000000007', 'b0000000-0000-0000-0006-000000000005', true),  -- Integration requires CFS Interpretation
('b0000000-0000-0000-0007-000000000007', 'b0000000-0000-0000-0007-000000000006', true);  -- Integration requires Comparative Analysis


-- ============================================
-- Recreate functions that were dropped due to enum dependency
-- ============================================

CREATE OR REPLACE FUNCTION get_course_skills(
  p_course_id UUID, 
  p_user_id UUID DEFAULT NULL,
  p_category skill_category DEFAULT NULL
)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  category skill_category,
  category_label TEXT,
  difficulty_level INT,
  estimated_minutes INT,
  sort_order INT,
  mastery_level INT,
  is_available BOOLEAN,
  prerequisite_count INT,
  prerequisites_met INT,
  total_activities INT,
  completed_activities INT
) AS $$
BEGIN
  RETURN QUERY
  WITH prereq_status AS (
    SELECT 
      s.id,
      COUNT(sp.prerequisite_skill_id)::INT AS prereq_count,
      COUNT(sp.prerequisite_skill_id) FILTER (
        WHERE NOT sp.is_required OR COALESCE(usp.mastery_level, 0) >= 70
      )::INT AS prereqs_met
    FROM skills s
    LEFT JOIN skill_prerequisites sp ON s.id = sp.skill_id
    LEFT JOIN user_skill_progress usp ON sp.prerequisite_skill_id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true
      AND (p_category IS NULL OR s.category = p_category)
    GROUP BY s.id
  ),
  activity_counts AS (
    SELECT 
      asks.skill_id,
      COUNT(a.id)::INT AS total_acts,
      COUNT(ap.id) FILTER (WHERE ap.completed = true)::INT AS completed_acts
    FROM activity_skills asks
    JOIN activities a ON asks.activity_id = a.id AND a.is_published = true
    LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
    WHERE asks.is_owner = true
    GROUP BY asks.skill_id
  )
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.description AS skill_description,
    s.category,
    s.category_label,
    s.difficulty_level,
    s.estimated_minutes,
    s.sort_order,
    COALESCE(usp.mastery_level, 0) AS mastery_level,
    COALESCE(ps.prereq_count = ps.prereqs_met, true) AS is_available,
    COALESCE(ps.prereq_count, 0) AS prerequisite_count,
    COALESCE(ps.prereqs_met, 0) AS prerequisites_met,
    COALESCE(ac.total_acts, 0) AS total_activities,
    COALESCE(ac.completed_acts, 0) AS completed_activities
  FROM skills s
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  LEFT JOIN prereq_status ps ON s.id = ps.id
  LEFT JOIN activity_counts ac ON s.id = ac.skill_id
  WHERE s.course_id = p_course_id AND s.is_active = true
    AND (p_category IS NULL OR s.category = p_category)
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION get_course_foundations(p_course_id UUID, p_user_id UUID DEFAULT NULL)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  sort_order INT,
  total_activities INT,
  completed_activities INT,
  is_available BOOLEAN,
  mastery_level INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    cs.skill_id,
    cs.skill_slug,
    cs.skill_name,
    cs.skill_description,
    cs.sort_order,
    cs.total_activities,
    cs.completed_activities,
    cs.is_available,
    cs.mastery_level
  FROM get_course_skills(p_course_id, p_user_id, 'ct_foundations'::skill_category) cs;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION get_course_coding_skills(p_course_id UUID, p_user_id UUID DEFAULT NULL)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  category skill_category,
  category_label TEXT,
  difficulty_level INT,
  estimated_minutes INT,
  sort_order INT,
  mastery_level INT,
  is_available BOOLEAN,
  prerequisite_count INT,
  prerequisites_met INT,
  total_activities INT,
  completed_activities INT
) AS $$
BEGIN
  RETURN QUERY
  WITH prereq_status AS (
    SELECT 
      s.id,
      COUNT(sp.prerequisite_skill_id)::INT AS prereq_count,
      COUNT(sp.prerequisite_skill_id) FILTER (
        WHERE NOT sp.is_required OR COALESCE(usp.mastery_level, 0) >= 70
      )::INT AS prereqs_met
    FROM skills s
    LEFT JOIN skill_prerequisites sp ON s.id = sp.skill_id
    LEFT JOIN user_skill_progress usp ON sp.prerequisite_skill_id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true AND s.category != 'ct_foundations'
    GROUP BY s.id
  ),
  activity_counts AS (
    SELECT 
      asks.skill_id,
      COUNT(a.id)::INT AS total_acts,
      COUNT(ap.id) FILTER (WHERE ap.completed = true)::INT AS completed_acts
    FROM activity_skills asks
    JOIN activities a ON asks.activity_id = a.id AND a.is_published = true
    LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
    WHERE asks.is_owner = true
    GROUP BY asks.skill_id
  )
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.description AS skill_description,
    s.category,
    s.category_label,
    s.difficulty_level,
    s.estimated_minutes,
    s.sort_order,
    COALESCE(usp.mastery_level, 0) AS mastery_level,
    COALESCE(ps.prereq_count = ps.prereqs_met, true) AS is_available,
    COALESCE(ps.prereq_count, 0) AS prerequisite_count,
    COALESCE(ps.prereqs_met, 0) AS prerequisites_met,
    COALESCE(ac.total_acts, 0) AS total_activities,
    COALESCE(ac.completed_acts, 0) AS completed_activities
  FROM skills s
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  LEFT JOIN prereq_status ps ON s.id = ps.id
  LEFT JOIN activity_counts ac ON s.id = ac.skill_id
  WHERE s.course_id = p_course_id AND s.is_active = true AND s.category != 'ct_foundations'
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION get_course_skill_progress(p_course_id UUID, p_user_id UUID)
RETURNS TABLE (
  foundations_total INT,
  foundations_mastered INT,
  foundations_in_progress INT,
  skills_total INT,
  skills_mastered INT,
  skills_in_progress INT,
  overall_progress_percent INT
) AS $$
BEGIN
  RETURN QUERY
  WITH skill_stats AS (
    SELECT 
      s.category = 'ct_foundations' AS is_foundation,
      COUNT(*)::INT AS total,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) >= 70)::INT AS mastered,
      COUNT(*) FILTER (WHERE COALESCE(usp.mastery_level, 0) > 0 AND COALESCE(usp.mastery_level, 0) < 70)::INT AS in_progress
    FROM skills s
    LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.course_id = p_course_id AND s.is_active = true
    GROUP BY s.category = 'ct_foundations'
  )
  SELECT 
    COALESCE((SELECT total FROM skill_stats WHERE is_foundation = true), 0),
    COALESCE((SELECT mastered FROM skill_stats WHERE is_foundation = true), 0),
    COALESCE((SELECT in_progress FROM skill_stats WHERE is_foundation = true), 0),
    COALESCE((SELECT total FROM skill_stats WHERE is_foundation = false), 0),
    COALESCE((SELECT mastered FROM skill_stats WHERE is_foundation = false), 0),
    COALESCE((SELECT in_progress FROM skill_stats WHERE is_foundation = false), 0),
    CASE 
      WHEN COALESCE(SUM(total), 0) = 0 THEN 0
      ELSE (COALESCE(SUM(mastered), 0) * 100 / COALESCE(SUM(total), 1))::INT
    END
  FROM skill_stats;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate get_user_skill_mastery
CREATE OR REPLACE FUNCTION get_user_skill_mastery(p_user_id UUID)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  category skill_category,
  mastery_level INT,
  times_practiced INT,
  last_practiced_at TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.category,
    COALESCE(usp.mastery_level, 0) AS mastery_level,
    COALESCE(usp.times_practiced, 0) AS times_practiced,
    usp.last_practiced_at
  FROM skills s
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  WHERE s.is_active = true
  ORDER BY s.category, s.sort_order;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate get_struggling_skills
CREATE OR REPLACE FUNCTION get_struggling_skills(p_user_id UUID)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  category skill_category,
  mastery_level INT,
  prerequisite_gaps UUID[]
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.category,
    usp.mastery_level,
    ARRAY(
      SELECT sp.prerequisite_skill_id 
      FROM skill_prerequisites sp
      LEFT JOIN user_skill_progress prereq_usp ON sp.prerequisite_skill_id = prereq_usp.skill_id AND prereq_usp.user_id = p_user_id
      WHERE sp.skill_id = s.id 
        AND sp.is_required = true
        AND COALESCE(prereq_usp.mastery_level, 0) < 70
    ) AS prerequisite_gaps
  FROM skills s
  JOIN user_skill_progress usp ON s.id = usp.skill_id
  WHERE usp.user_id = p_user_id
    AND usp.mastery_level < 70
    AND s.is_active = true
  ORDER BY usp.mastery_level ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate search_skills
CREATE OR REPLACE FUNCTION search_skills(p_query TEXT)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  description TEXT,
  category skill_category,
  relevance REAL
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.description,
    s.category,
    ts_rank(
      to_tsvector('english', COALESCE(s.name, '') || ' ' || COALESCE(s.description, '')),
      plainto_tsquery('english', p_query)
    ) AS relevance
  FROM skills s
  WHERE s.is_active = true
    AND (
      s.name ILIKE '%' || p_query || '%'
      OR s.description ILIKE '%' || p_query || '%'
      OR s.slug ILIKE '%' || p_query || '%'
    )
  ORDER BY relevance DESC, s.sort_order
  LIMIT 20;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Recreate get_coding_skill_tree
CREATE OR REPLACE FUNCTION get_coding_skill_tree(p_user_id UUID DEFAULT NULL)
RETURNS TABLE (
  skill_id UUID,
  skill_slug TEXT,
  skill_name TEXT,
  skill_description TEXT,
  category skill_category,
  difficulty_level INT,
  estimated_minutes INT,
  sort_order INT,
  mastery_level INT,
  is_available BOOLEAN,
  prerequisite_count INT,
  prerequisites_met INT
) AS $$
BEGIN
  RETURN QUERY
  WITH prereq_status AS (
    SELECT 
      s.id,
      COUNT(sp.prerequisite_skill_id)::INT AS prereq_count,
      COUNT(sp.prerequisite_skill_id) FILTER (
        WHERE NOT sp.is_required OR COALESCE(usp.mastery_level, 0) >= 70
      )::INT AS prereqs_met
    FROM skills s
    LEFT JOIN skill_prerequisites sp ON s.id = sp.skill_id
    LEFT JOIN user_skill_progress usp ON sp.prerequisite_skill_id = usp.skill_id AND usp.user_id = p_user_id
    WHERE s.category != 'ct_foundations' AND s.is_active = true
    GROUP BY s.id
  )
  SELECT 
    s.id AS skill_id,
    s.slug AS skill_slug,
    s.name AS skill_name,
    s.description AS skill_description,
    s.category,
    s.difficulty_level,
    s.estimated_minutes,
    s.sort_order,
    COALESCE(usp.mastery_level, 0) AS mastery_level,
    COALESCE(ps.prereq_count = ps.prereqs_met, true) AS is_available,
    COALESCE(ps.prereq_count, 0) AS prerequisite_count,
    COALESCE(ps.prereqs_met, 0) AS prerequisites_met
  FROM skills s
  LEFT JOIN user_skill_progress usp ON s.id = usp.skill_id AND usp.user_id = p_user_id
  LEFT JOIN prereq_status ps ON s.id = ps.id
  WHERE s.category != 'ct_foundations' AND s.is_active = true
  ORDER BY s.category, s.sort_order ASC;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
