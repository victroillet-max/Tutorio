-- ============================================
-- Skill-First Architecture Data Migration
-- Phase 1.3: Migrate activities to skill ownership
-- ============================================

-- ============================================
-- Strategy:
-- 1. For each activity with is_primary=true in activity_skills,
--    set is_owner=true for exactly ONE skill (the first primary)
-- 2. Calculate order_index based on the original module's order_index
--    and the activity's order_index within that module
-- ============================================

-- ============================================
-- Step 1: Set is_owner=true for CT Foundations skills
-- These map to Modules 1-3
-- ============================================

-- Problem Solving Mindset (ct-problem-solving)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0001-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0001-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0001-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0001-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0001-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000007' AND is_primary = true;

-- Decomposition (ct-decomposition)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0001-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0001-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0001-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0001-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0001-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 6
WHERE skill_id = 'a0000000-0000-0000-0001-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 7
WHERE skill_id = 'a0000000-0000-0000-0001-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000007' AND is_primary = true;

-- Pattern Recognition (ct-pattern-recognition)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0001-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0001-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0001-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0001-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0001-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 6
WHERE skill_id = 'a0000000-0000-0000-0001-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000007' AND is_primary = true;

-- Abstraction (ct-abstraction)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0001-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0001-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0001-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000007' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0001-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0001-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 6
WHERE skill_id = 'a0000000-0000-0000-0001-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0002-000000000007' AND is_primary = true;

-- Algorithm Design (ct-algorithm-design)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0001-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0001-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0001-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0003-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0001-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0003-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0001-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0003-000000000006' AND is_primary = true;

-- Flowcharts (ct-flowcharts)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0001-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0003-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0001-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0003-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0001-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0003-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0001-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0003-000000000006' AND is_primary = true;

-- Pseudocode (ct-pseudocode)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0001-000000000007' 
  AND activity_id = 'e0000000-0000-0000-0003-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0001-000000000007' 
  AND activity_id = 'e0000000-0000-0000-0003-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0001-000000000007' 
  AND activity_id = 'e0000000-0000-0000-0003-000000000006' AND is_primary = true;

-- ============================================
-- Step 2: Set is_owner=true for Python Basics skills
-- Module 4-5
-- ============================================

-- Python Environment (py-environment)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0002-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0002-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000007' AND is_primary = true;

-- Print & Output (py-print-output)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0002-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0002-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0002-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0002-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000007' AND is_primary = true;

-- Variables (py-variables)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0002-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0002-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0002-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000007' AND is_primary = true;

-- Data Types (py-data-types)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0002-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0002-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0002-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0004-000000000007' AND is_primary = true;

-- Operators (py-operators)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0002-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0002-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0002-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0002-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000007' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0002-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000008' AND is_primary = true;

-- User Input (py-user-input)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0002-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0002-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0002-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000007' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0002-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000008' AND is_primary = true;

-- String Methods (py-string-methods)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0002-000000000007' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0002-000000000007' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000008' AND is_primary = true;

-- F-Strings (py-f-strings)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0002-000000000008' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0002-000000000008' 
  AND activity_id = 'e0000000-0000-0000-0005-000000000008' AND is_primary = true;

-- ============================================
-- Step 3: Set is_owner=true for Control Flow skills
-- Modules 6-8
-- ============================================

-- Boolean Logic (cf-boolean-logic)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0003-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0006-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0003-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0006-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0003-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0006-000000000007' AND is_primary = true;

-- Conditionals (cf-conditionals)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0003-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0006-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0003-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0006-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0003-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0006-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0003-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0006-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0003-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0006-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 6
WHERE skill_id = 'a0000000-0000-0000-0003-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0006-000000000007' AND is_primary = true;

-- While Loops (cf-while-loops)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0003-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0007-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0003-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0007-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0003-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0007-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0003-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0007-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0003-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0007-000000000006' AND is_primary = true;

-- For Loops (cf-for-loops)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0003-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0008-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0003-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0008-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0003-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0008-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0003-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0008-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0003-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0008-000000000006' AND is_primary = true;

-- Loop Control (cf-loop-control)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0003-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0007-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0003-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0007-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0003-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0007-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0003-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0007-000000000006' AND is_primary = true;

-- Nested Control Structures (cf-nested-control)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0003-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0006-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0003-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0008-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0003-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0008-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0003-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0008-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0003-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0008-000000000006' AND is_primary = true;

-- ============================================
-- Step 4: Set is_owner=true for Data Structures skills
-- Modules 9-10
-- ============================================

-- Lists Basics (ds-lists-basics)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0004-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0004-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0004-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0004-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000007' AND is_primary = true;

-- List Methods (ds-list-methods)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0004-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0004-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0004-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0004-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000007' AND is_primary = true;

-- List Slicing (ds-list-slicing)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0004-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0004-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0004-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000007' AND is_primary = true;

-- List Comprehensions (ds-list-comprehensions)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0004-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0004-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0009-000000000007' AND is_primary = true;

-- Dictionaries (ds-dictionaries)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0004-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0010-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0004-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0010-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0004-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0010-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0004-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0010-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0004-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0010-000000000006' AND is_primary = true;

-- Nested Structures (ds-nested-structures)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0004-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0010-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0004-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0010-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0004-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0010-000000000006' AND is_primary = true;

-- ============================================
-- Step 5: Set is_owner=true for Functions skills
-- Module 11
-- ============================================

-- Defining Functions (fn-defining-functions)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0005-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0005-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0005-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0005-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000007' AND is_primary = true;

-- Parameters & Arguments (fn-parameters-arguments)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0005-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0005-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0005-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0005-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000007' AND is_primary = true;

-- Return Values (fn-return-values)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0005-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0005-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0005-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0005-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000007' AND is_primary = true;

-- Variable Scope (fn-scope)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0005-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0005-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0011-000000000007' AND is_primary = true;

-- Built-in Functions (fn-built-in) - Map from range() activities in For Loops
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0005-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0008-000000000002';

-- ============================================
-- Step 6: Set is_owner=true for Advanced Topics skills
-- Modules 12-14
-- ============================================

-- File Handling (adv-file-handling)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0006-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0012-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0006-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0012-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0006-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0012-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0006-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0012-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0006-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0012-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 6
WHERE skill_id = 'a0000000-0000-0000-0006-000000000001' 
  AND activity_id = 'e0000000-0000-0000-0012-000000000007' AND is_primary = true;

-- Exception Handling (adv-exception-handling)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0006-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0012-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0006-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0012-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0006-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0012-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0006-000000000002' 
  AND activity_id = 'e0000000-0000-0000-0012-000000000007' AND is_primary = true;

-- Python Libraries (adv-libraries)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0006-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0006-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0006-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0006-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0006-000000000003' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000007' AND is_primary = true;

-- Math Library (adv-math-library)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0006-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0006-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0006-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0006-000000000004' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000007' AND is_primary = true;

-- Random Library (adv-random-library)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0006-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0006-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0006-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0006-000000000005' 
  AND activity_id = 'e0000000-0000-0000-0013-000000000007' AND is_primary = true;

-- Data Analysis (adv-data-analysis)
UPDATE activity_skills SET is_owner = true, order_index = 1
WHERE skill_id = 'a0000000-0000-0000-0006-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0014-000000000001' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 2
WHERE skill_id = 'a0000000-0000-0000-0006-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0014-000000000002' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 3
WHERE skill_id = 'a0000000-0000-0000-0006-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0014-000000000003' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 4
WHERE skill_id = 'a0000000-0000-0000-0006-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0014-000000000004' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 5
WHERE skill_id = 'a0000000-0000-0000-0006-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0014-000000000005' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 6
WHERE skill_id = 'a0000000-0000-0000-0006-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0014-000000000006' AND is_primary = true;

UPDATE activity_skills SET is_owner = true, order_index = 7
WHERE skill_id = 'a0000000-0000-0000-0006-000000000006' 
  AND activity_id = 'e0000000-0000-0000-0014-000000000007' AND is_primary = true;

