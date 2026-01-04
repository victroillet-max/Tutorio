-- ============================================
-- Business Mathematics Activity-Skill Tags
-- Links activities to skills with ownership
-- ============================================

-- ============================================
-- Module 1: Math Foundations Activity Tags
-- ============================================

-- Skill: Arithmetic Fundamentals (MF-01)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0100000-0000-0000-0001-000000000001', 'c0000000-0000-0000-0001-000000000001', true, 1, true, true, 1.0),
('b0100000-0000-0000-0001-000000000002', 'c0000000-0000-0000-0001-000000000001', true, 2, true, true, 1.0),
('b0100000-0000-0000-0001-000000000003', 'c0000000-0000-0000-0001-000000000001', true, 3, true, true, 1.0),
('b0100000-0000-0000-0001-000000000004', 'c0000000-0000-0000-0001-000000000001', true, 4, true, true, 1.0),
('b0100000-0000-0000-0001-000000000005', 'c0000000-0000-0000-0001-000000000001', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Order of Operations (MF-02)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0100000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0001-000000000002', true, 1, true, true, 1.0),
('b0100000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0001-000000000002', true, 2, true, true, 1.0),
('b0100000-0000-0000-0002-000000000003', 'c0000000-0000-0000-0001-000000000002', true, 3, true, true, 1.0),
('b0100000-0000-0000-0002-000000000004', 'c0000000-0000-0000-0001-000000000002', true, 4, true, true, 1.0),
('b0100000-0000-0000-0002-000000000005', 'c0000000-0000-0000-0001-000000000002', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Number Types (MF-03)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0100000-0000-0000-0003-000000000001', 'c0000000-0000-0000-0001-000000000003', true, 1, true, true, 1.0),
('b0100000-0000-0000-0003-000000000002', 'c0000000-0000-0000-0001-000000000003', true, 2, true, true, 1.0),
('b0100000-0000-0000-0003-000000000003', 'c0000000-0000-0000-0001-000000000003', true, 3, true, true, 1.0),
('b0100000-0000-0000-0003-000000000004', 'c0000000-0000-0000-0001-000000000003', true, 4, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Calculator Proficiency (MF-04)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0100000-0000-0000-0004-000000000001', 'c0000000-0000-0000-0001-000000000004', true, 1, true, true, 1.0),
('b0100000-0000-0000-0004-000000000002', 'c0000000-0000-0000-0001-000000000004', true, 2, true, true, 1.0),
('b0100000-0000-0000-0004-000000000003', 'c0000000-0000-0000-0001-000000000004', true, 3, true, true, 1.0),
('b0100000-0000-0000-0004-000000000004', 'c0000000-0000-0000-0001-000000000004', true, 4, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- ============================================
-- Module 2: Basic Statistics Activity Tags
-- ============================================

-- Skill: Arithmetic Mean (ST-01)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0200000-0000-0000-0001-000000000001', 'c0000000-0000-0000-0002-000000000001', true, 1, true, true, 1.0),
('b0200000-0000-0000-0001-000000000002', 'c0000000-0000-0000-0002-000000000001', true, 2, true, true, 1.0),
('b0200000-0000-0000-0001-000000000003', 'c0000000-0000-0000-0002-000000000001', true, 3, true, true, 1.0),
('b0200000-0000-0000-0001-000000000004', 'c0000000-0000-0000-0002-000000000001', true, 4, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Weighted Averages (ST-02)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0200000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0002-000000000002', true, 1, true, true, 1.0),
('b0200000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0002-000000000002', true, 2, true, true, 1.0),
('b0200000-0000-0000-0002-000000000003', 'c0000000-0000-0000-0002-000000000002', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Summation Notation (ST-03)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0200000-0000-0000-0003-000000000001', 'c0000000-0000-0000-0002-000000000003', true, 1, true, true, 1.0),
('b0200000-0000-0000-0003-000000000002', 'c0000000-0000-0000-0002-000000000003', true, 2, true, true, 1.0),
('b0200000-0000-0000-0003-000000000003', 'c0000000-0000-0000-0002-000000000003', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Central Tendency Measures (ST-04)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0200000-0000-0000-0004-000000000001', 'c0000000-0000-0000-0002-000000000004', true, 1, true, true, 1.0),
('b0200000-0000-0000-0004-000000000002', 'c0000000-0000-0000-0002-000000000004', true, 2, true, true, 1.0),
('b0200000-0000-0000-0004-000000000003', 'c0000000-0000-0000-0002-000000000004', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- ============================================
-- Module 3: Ratios and Percentages Activity Tags
-- ============================================

-- Skill: Fraction Operations (RP-01)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0300000-0000-0000-0001-000000000001', 'c0000000-0000-0000-0003-000000000001', true, 1, true, true, 1.0),
('b0300000-0000-0000-0001-000000000002', 'c0000000-0000-0000-0003-000000000001', true, 2, true, true, 1.0),
('b0300000-0000-0000-0001-000000000003', 'c0000000-0000-0000-0003-000000000001', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Percentage Calculations (RP-03)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0300000-0000-0000-0003-000000000001', 'c0000000-0000-0000-0003-000000000003', true, 1, true, true, 1.0),
('b0300000-0000-0000-0003-000000000002', 'c0000000-0000-0000-0003-000000000003', true, 2, true, true, 1.0),
('b0300000-0000-0000-0003-000000000003', 'c0000000-0000-0000-0003-000000000003', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Percentage Change (RP-04)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0300000-0000-0000-0004-000000000001', 'c0000000-0000-0000-0003-000000000004', true, 1, true, true, 1.0),
('b0300000-0000-0000-0004-000000000002', 'c0000000-0000-0000-0003-000000000004', true, 2, true, true, 1.0),
('b0300000-0000-0000-0004-000000000003', 'c0000000-0000-0000-0003-000000000004', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Markup and Margin (RP-05)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0300000-0000-0000-0005-000000000001', 'c0000000-0000-0000-0003-000000000005', true, 1, true, true, 1.0),
('b0300000-0000-0000-0005-000000000002', 'c0000000-0000-0000-0003-000000000005', true, 2, true, true, 1.0),
('b0300000-0000-0000-0005-000000000003', 'c0000000-0000-0000-0003-000000000005', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- ============================================
-- Module 4: Exponents and Logarithms Activity Tags
-- ============================================

-- Skill: Exponent Rules (EL-01)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0400000-0000-0000-0001-000000000001', 'c0000000-0000-0000-0004-000000000001', true, 1, true, true, 1.0),
('b0400000-0000-0000-0001-000000000002', 'c0000000-0000-0000-0004-000000000001', true, 2, true, true, 1.0),
('b0400000-0000-0000-0001-000000000003', 'c0000000-0000-0000-0004-000000000001', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Compound Interest (EL-06)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0400000-0000-0000-0006-000000000001', 'c0000000-0000-0000-0004-000000000006', true, 1, true, true, 1.0),
('b0400000-0000-0000-0006-000000000002', 'c0000000-0000-0000-0004-000000000006', true, 2, true, true, 1.0),
('b0400000-0000-0000-0006-000000000003', 'c0000000-0000-0000-0004-000000000006', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

-- Skill: Time Value of Money (EL-08)
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0400000-0000-0000-0008-000000000001', 'c0000000-0000-0000-0004-000000000008', true, 1, true, true, 1.0),
('b0400000-0000-0000-0008-000000000002', 'c0000000-0000-0000-0004-000000000008', true, 2, true, true, 1.0),
('b0400000-0000-0000-0008-000000000003', 'c0000000-0000-0000-0004-000000000008', true, 3, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

