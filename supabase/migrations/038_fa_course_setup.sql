-- ============================================
-- Financial Accounting Course Setup
-- Course, Category, and Module Structure
-- ============================================

-- ============================================
-- 1. Category for Business/Accounting Courses
-- ============================================

INSERT INTO categories (id, name, slug, description, icon, color, sort_order) VALUES
  (
    'b0000000-0000-0000-0000-000000000002',
    'Business & Accounting',
    'business-accounting',
    'Financial accounting, analysis, and business fundamentals',
    'calculator',
    'emerald',
    2
  )
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- 2. Course: Financial Accounting
-- ============================================

INSERT INTO courses (id, category_id, title, slug, description, short_description, difficulty, duration_hours, is_published, is_featured, sort_order) VALUES
  (
    'c0000000-0000-0000-0000-000000000002',
    'b0000000-0000-0000-0000-000000000002',
    'Financial Accounting Fundamentals',
    'financial-accounting',
    'Master financial accounting from the ground up. This comprehensive course covers the complete accounting cycle, financial statement preparation, analysis techniques, and real-world case studies. Designed for business school students, this skill-based curriculum takes you from understanding the accounting equation to performing sophisticated financial analysis using Du Pont decomposition and ratio analysis. Learn through interactive exercises, journal entry builders, and hands-on case studies with fictional companies inspired by real industry scenarios.',
    'Master financial statements, accounting principles, and analysis techniques',
    'beginner',
    45,
    true,
    true,
    2
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

-- ============================================
-- 3. Modules
-- ============================================

INSERT INTO modules (id, course_id, external_id, order_index, title, slug, description, estimated_minutes, total_xp, required_plan, is_mock_exam, is_midterm_boundary, is_published) VALUES
  -- Module 1: Accounting Foundations (FREE)
  (
    'fa000000-0000-0000-0000-000000000001',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mod-01',
    1,
    'Welcome to Financial Accounting',
    'welcome-to-financial-accounting',
    'Discover the purpose of financial statements, understand who uses them, and master the fundamental accounting equation that underlies all of accounting',
    90,
    300,
    'free',
    false,
    false,
    true
  ),
  -- Module 2: Building the Balance Sheet (FREE)
  (
    'fa000000-0000-0000-0000-000000000002',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mod-02',
    2,
    'Building the Balance Sheet',
    'building-the-balance-sheet',
    'Learn double-entry bookkeeping and construct a complete balance sheet through transaction analysis and journal entries',
    120,
    400,
    'free',
    false,
    false,
    true
  ),
  -- Module 3: Understanding Profitability (BASIC)
  (
    'fa000000-0000-0000-0000-000000000003',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mod-03',
    3,
    'Understanding Profitability',
    'understanding-profitability',
    'Master the income statement, understand revenue recognition, and analyze the components of profitability',
    100,
    350,
    'basic',
    false,
    false,
    true
  ),
  -- Module 4: Period-End Adjustments (BASIC)
  (
    'fa000000-0000-0000-0000-000000000004',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mod-04',
    4,
    'Period-End Adjustments',
    'period-end-adjustments',
    'Learn the critical adjusting entries that ensure accurate financial statements: prepaids, accruals, deferrals, and depreciation',
    130,
    450,
    'basic',
    false,
    false,
    true
  ),
  -- Module 5: Revenue & Receivables (BASIC)
  (
    'fa000000-0000-0000-0000-000000000005',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mod-05',
    5,
    'Revenue & Receivables',
    'revenue-and-receivables',
    'Deep dive into accounts receivable management, credit policies, and accounting for uncollectible accounts',
    90,
    350,
    'basic',
    false,
    false,
    true
  ),
  -- Module 6: Inventory Deep Dive (BASIC)
  (
    'fa000000-0000-0000-0000-000000000006',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mod-06',
    6,
    'Inventory Deep Dive',
    'inventory-deep-dive',
    'Compare FIFO, LIFO, and Weighted Average inventory methods and understand their impact on financial statements',
    110,
    400,
    'basic',
    false,
    true,
    true
  ),
  -- Mock Midterm Exam
  (
    'fa000000-0000-0000-0000-000000000099',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mock-midterm',
    7,
    'Mock Midterm Exam',
    'mock-midterm-exam',
    'Practice exam covering Modules 1-6: Foundations, Balance Sheet, Income Statement, Adjustments, Receivables, and Inventory',
    60,
    200,
    'basic',
    true,
    false,
    true
  ),
  -- Module 7: Long-Lived Assets (BASIC)
  (
    'fa000000-0000-0000-0000-000000000007',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mod-07',
    8,
    'Long-Lived Assets',
    'long-lived-assets',
    'Master depreciation methods, intangible assets, and accounting for asset acquisitions and disposals',
    100,
    400,
    'basic',
    false,
    false,
    true
  ),
  -- Module 8: Liabilities & Equity (BASIC)
  (
    'fa000000-0000-0000-0000-000000000008',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mod-08',
    9,
    'Liabilities & Equity',
    'liabilities-and-equity',
    'Understand current and long-term liabilities, bonds, and the components of shareholders'' equity',
    110,
    400,
    'basic',
    false,
    false,
    true
  ),
  -- Module 9: Cash Flow Statement (BASIC)
  (
    'fa000000-0000-0000-0000-000000000009',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mod-09',
    10,
    'Cash Flow Statement',
    'cash-flow-statement',
    'Build complete cash flow statements using the indirect method and understand the relationship between all three statements',
    140,
    500,
    'basic',
    false,
    false,
    true
  ),
  -- Module 10: Financial Analysis & Ratios (BASIC)
  (
    'fa000000-0000-0000-0000-000000000010',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mod-10',
    11,
    'Financial Analysis & Ratios',
    'financial-analysis-ratios',
    'Apply ratio analysis, Du Pont decomposition, and comparative analysis to evaluate company performance',
    130,
    450,
    'basic',
    false,
    false,
    true
  ),
  -- Mock Final Exam
  (
    'fa000000-0000-0000-0000-000000000100',
    'c0000000-0000-0000-0000-000000000002',
    'fa-mock-final',
    12,
    'Mock Final Exam',
    'mock-final-exam',
    'Comprehensive practice exam covering all course material with emphasis on Cash Flow Statement and Financial Analysis',
    120,
    300,
    'basic',
    true,
    false,
    true
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  estimated_minutes = EXCLUDED.estimated_minutes,
  total_xp = EXCLUDED.total_xp,
  required_plan = EXCLUDED.required_plan;

-- ============================================
-- 4. FA-Specific Badges
-- ============================================

INSERT INTO badges (id, name, description, icon, required_plan, unlock_criteria, sort_order) VALUES
  ('fa-first-entry', 'First Entry', 'Complete your first journal entry exercise', 'pencil', 'free', '{"type": "activity_type_complete", "course": "fa", "activityType": "interactive", "count": 1}'::jsonb, 20),
  ('fa-equation-master', 'Equation Master', 'Complete Module 1 with perfect accounting equation understanding', 'scale', 'free', '{"type": "modules_complete", "modules": ["fa-mod-01"]}'::jsonb, 21),
  ('fa-balance-builder', 'Balance Builder', 'Build your first complete balance sheet', 'layout', 'basic', '{"type": "modules_complete", "modules": ["fa-mod-02"]}'::jsonb, 22),
  ('fa-adjustment-ace', 'Adjustment Ace', 'Master all types of adjusting entries', 'settings', 'basic', '{"type": "modules_complete", "modules": ["fa-mod-04"]}'::jsonb, 23),
  ('fa-inventory-expert', 'Inventory Expert', 'Complete all inventory method comparisons', 'package', 'basic', '{"type": "modules_complete", "modules": ["fa-mod-06"]}'::jsonb, 24),
  ('fa-cfs-constructor', 'CFS Constructor', 'Build a complete Cash Flow Statement', 'git-branch', 'basic', '{"type": "modules_complete", "modules": ["fa-mod-09"]}'::jsonb, 25),
  ('fa-ratio-analyst', 'Ratio Analyst', 'Calculate and interpret all major financial ratios', 'bar-chart', 'basic', '{"type": "modules_complete", "modules": ["fa-mod-10"]}'::jsonb, 26),
  ('fa-midterm-master', 'FA Midterm Master', 'Score 90%+ on the FA Mock Midterm', 'award', 'basic', '{"type": "mock_exam_score", "exam": "fa-mock-midterm", "min_score": 90}'::jsonb, 27),
  ('fa-final-champion', 'FA Final Champion', 'Score 90%+ on the FA Mock Final', 'trophy', 'basic', '{"type": "mock_exam_score", "exam": "fa-mock-final", "min_score": 90}'::jsonb, 28),
  ('fa-course-complete', 'FA Complete', 'Complete all Financial Accounting modules', 'graduation-cap', 'basic', '{"type": "course_complete", "course": "financial-accounting"}'::jsonb, 29)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;


