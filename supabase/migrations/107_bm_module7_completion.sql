-- ============================================
-- Phase 3: Module 7 Completion
-- Limits and Continuity, Product/Quotient Rules, Higher-Order Derivatives, Constrained Optimization
-- 20 Activities (5 per skill)
-- ============================================

-- Limits and Continuity Activities
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
('b0700000-0000-0000-0002-000000000001', NULL, '7.2.1', 201, 'Understanding Limits', 'understanding-limits', 'lesson', 15, 30, 'basic', '{"markdown": "# Understanding Limits\n\nA limit describes what value a function approaches as x approaches a specific value.\n\n$$\\lim_{x \\to a} f(x) = L$$\n\nThis means f(x) gets closer to L as x gets closer to a."}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0002-000000000002', NULL, '7.2.2', 202, 'Continuity of Functions', 'continuity-of-functions', 'lesson', 12, 25, 'basic', '{"markdown": "# Continuity of Functions\n\nA function is continuous at a if:\n1. f(a) is defined\n2. The limit exists\n3. The limit equals f(a)"}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0002-000000000003', NULL, '7.2.3', 203, 'Limits and Continuity Practice', 'limits-continuity-practice', 'quiz', 10, 30, 'basic', '{"questions": [{"id": "q1", "type": "mcq", "difficulty": "basic", "question": "Evaluate: lim(x to 3) (2x + 1)", "options": ["7", "6", "9", "5"], "correct": 0, "explanation": "Direct substitution: 2(3) + 1 = 7"}], "passing_score": 70}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0002-000000000004', NULL, '7.2.4', 204, 'Limit Concepts Matcher', 'limit-concepts-matcher', 'interactive', 8, 25, 'basic', '{"instructions": "Match each limit concept with its description.", "pairs": [{"left": "lim(x to a-)", "right": "Left-hand limit"}, {"left": "0/0", "right": "Indeterminate form"}]}'::jsonb, 'drag-drop-match', false, true),
('b0700000-0000-0000-0002-000000000005', NULL, '7.2.5', 205, 'Limits and Continuity Checkpoint', 'limits-continuity-checkpoint', 'checkpoint', 10, 35, 'basic', '{"questions": [{"id": "cp1", "type": "mcq", "question": "Evaluate: lim(x to 0) (x^2 + 3x)/x", "options": ["3", "0", "Undefined", "DNE"], "correct": 0, "explanation": "Factor: x(x + 3)/x = x + 3 at 0 = 3"}], "passing_score": 70}'::jsonb, NULL, true, true)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, content = EXCLUDED.content;

-- Product/Quotient Rules Activities
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
('b0700000-0000-0000-0004-000000000001', NULL, '7.4.1', 211, 'The Product Rule', 'the-product-rule', 'lesson', 15, 30, 'basic', '{"markdown": "# The Product Rule\n\n$$(fg)'' = f''g + fg''$$\n\nThe derivative of a product is the first times derivative of second plus second times derivative of first."}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0004-000000000002', NULL, '7.4.2', 212, 'The Quotient Rule', 'the-quotient-rule', 'lesson', 15, 30, 'basic', '{"markdown": "# The Quotient Rule\n\n$$\\left(\\frac{f}{g}\\right)'' = \\frac{f''g - fg''}{g^2}$$\n\nLow d-high minus high d-low, all over low squared."}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0004-000000000003', NULL, '7.4.3', 213, 'Product and Quotient Rules Practice', 'product-quotient-rules-practice', 'quiz', 12, 35, 'basic', '{"questions": [{"id": "q1", "type": "mcq", "difficulty": "basic", "question": "Find d/dx [x * e^x]:", "options": ["e^x + xe^x", "xe^x", "e^x", "x + e^x"], "correct": 0, "explanation": "Product rule: 1*e^x + x*e^x"}], "passing_score": 70}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0004-000000000004', NULL, '7.4.4', 214, 'Derivative Rules Matcher', 'derivative-rules-matcher', 'interactive', 8, 25, 'basic', '{"instructions": "Match function type with differentiation approach.", "pairs": [{"left": "y = f(x) * g(x)", "right": "Product Rule"}, {"left": "y = f(x) / g(x)", "right": "Quotient Rule"}]}'::jsonb, 'drag-drop-match', false, true),
('b0700000-0000-0000-0004-000000000005', NULL, '7.4.5', 215, 'Product and Quotient Rules Checkpoint', 'product-quotient-rules-checkpoint', 'checkpoint', 12, 40, 'basic', '{"questions": [{"id": "cp1", "type": "mcq", "question": "Find d/dx [x^3 * (x + 2)]:", "options": ["4x^3 + 6x^2", "3x^2(x + 2)", "x^3 + 3x^2", "4x^4"], "correct": 0, "explanation": "3x^2(x+2) + x^3(1) = 4x^3 + 6x^2"}], "passing_score": 70}'::jsonb, NULL, true, true)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, content = EXCLUDED.content;

-- Higher-Order Derivatives Activities
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
('b0700000-0000-0000-0006-000000000001', NULL, '7.6.1', 221, 'Higher-Order Derivatives', 'higher-order-derivatives', 'lesson', 15, 30, 'basic', '{"markdown": "# Higher-Order Derivatives\n\nThe second derivative f''''(x) measures how the first derivative changes. It indicates concavity:\n- f''''(x) > 0: Concave up\n- f''''(x) < 0: Concave down"}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0006-000000000002', NULL, '7.6.2', 222, 'Concavity and Inflection Points', 'concavity-inflection-points', 'lesson', 12, 25, 'basic', '{"markdown": "# Concavity and Inflection Points\n\nAn inflection point is where concavity changes. Find where f''''(x) = 0 and check if sign changes."}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0006-000000000003', NULL, '7.6.3', 223, 'Higher-Order Derivatives Practice', 'higher-order-derivatives-practice', 'quiz', 10, 30, 'basic', '{"questions": [{"id": "q1", "type": "mcq", "difficulty": "basic", "question": "If f(x) = x^4, find f''''(x):", "options": ["12x^2", "4x^3", "24x", "x^4"], "correct": 0, "explanation": "f''(x) = 4x^3, f''''(x) = 12x^2"}], "passing_score": 70}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0006-000000000004', NULL, '7.6.4', 224, 'Concavity Concepts Matcher', 'concavity-concepts-matcher', 'interactive', 8, 25, 'basic', '{"instructions": "Match each concept with its description.", "pairs": [{"left": "f''''(x) > 0", "right": "Concave up"}, {"left": "f''''(x) < 0", "right": "Concave down"}]}'::jsonb, 'drag-drop-match', false, true),
('b0700000-0000-0000-0006-000000000005', NULL, '7.6.5', 225, 'Higher-Order Derivatives Checkpoint', 'higher-order-derivatives-checkpoint', 'checkpoint', 10, 35, 'basic', '{"questions": [{"id": "cp1", "type": "mcq", "question": "For f(x) = x^3 - 3x, find f''''(x):", "options": ["6x", "3x^2 - 3", "6", "x^3"], "correct": 0, "explanation": "f''(x) = 3x^2 - 3, f''''(x) = 6x"}], "passing_score": 70}'::jsonb, NULL, true, true)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, content = EXCLUDED.content;

-- Constrained Optimization Activities
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
('b0700000-0000-0000-0009-000000000001', NULL, '7.9.1', 231, 'Constrained Optimization', 'constrained-optimization', 'lesson', 15, 35, 'basic', '{"markdown": "# Constrained Optimization\n\nOptimize f(x,y) subject to constraint g(x,y) = c. Use substitution method: solve constraint for one variable, substitute into objective function."}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0009-000000000002', NULL, '7.9.2', 232, 'Lagrange Multipliers Overview', 'lagrange-multipliers-overview', 'lesson', 15, 35, 'basic', '{"markdown": "# Lagrange Multipliers\n\nFor complex constraints, use Lagrangian:\n$$L(x,y,\\lambda) = f(x,y) - \\lambda(g(x,y) - c)$$\n\nSet partial derivatives to zero and solve."}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0009-000000000003', NULL, '7.9.3', 233, 'Constrained Optimization Practice', 'constrained-optimization-practice', 'quiz', 10, 30, 'basic', '{"questions": [{"id": "q1", "type": "mcq", "difficulty": "basic", "question": "Maximize xy subject to x + y = 16. Maximum value?", "options": ["64", "32", "16", "256"], "correct": 0, "explanation": "y = 16 - x, f = x(16-x). f'' = 16 - 2x = 0 at x = 8. Max = 64"}], "passing_score": 70}'::jsonb, NULL, false, true),
('b0700000-0000-0000-0009-000000000004', NULL, '7.9.4', 234, 'Constrained Optimization Matcher', 'constrained-optimization-matcher', 'interactive', 8, 25, 'basic', '{"instructions": "Match each concept with its description.", "pairs": [{"left": "Objective function", "right": "What to maximize or minimize"}, {"left": "Constraint", "right": "Limitation on variables"}]}'::jsonb, 'drag-drop-match', false, true),
('b0700000-0000-0000-0009-000000000005', NULL, '7.9.5', 235, 'Constrained Optimization Checkpoint', 'constrained-optimization-checkpoint', 'checkpoint', 12, 40, 'basic', '{"questions": [{"id": "cp1", "type": "mcq", "question": "Minimize x^2 + y^2 subject to x + y = 6. Minimum value?", "options": ["18", "36", "9", "12"], "correct": 0, "explanation": "y = 6 - x. f = 2x^2 - 12x + 36. f'' = 4x - 12 = 0, x = 3. Min = 18"}], "passing_score": 70}'::jsonb, NULL, true, true)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, content = EXCLUDED.content;

-- Link Activities to Skills
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0700000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0007-000000000002', true, 1, true, true, 1.0),
('b0700000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0007-000000000002', true, 2, true, true, 1.0),
('b0700000-0000-0000-0002-000000000003', 'c0000000-0000-0000-0007-000000000002', true, 3, true, true, 1.0),
('b0700000-0000-0000-0002-000000000004', 'c0000000-0000-0000-0007-000000000002', true, 4, true, true, 1.0),
('b0700000-0000-0000-0002-000000000005', 'c0000000-0000-0000-0007-000000000002', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0700000-0000-0000-0004-000000000001', 'c0000000-0000-0000-0007-000000000004', true, 1, true, true, 1.0),
('b0700000-0000-0000-0004-000000000002', 'c0000000-0000-0000-0007-000000000004', true, 2, true, true, 1.0),
('b0700000-0000-0000-0004-000000000003', 'c0000000-0000-0000-0007-000000000004', true, 3, true, true, 1.0),
('b0700000-0000-0000-0004-000000000004', 'c0000000-0000-0000-0007-000000000004', true, 4, true, true, 1.0),
('b0700000-0000-0000-0004-000000000005', 'c0000000-0000-0000-0007-000000000004', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0700000-0000-0000-0006-000000000001', 'c0000000-0000-0000-0007-000000000006', true, 1, true, true, 1.0),
('b0700000-0000-0000-0006-000000000002', 'c0000000-0000-0000-0007-000000000006', true, 2, true, true, 1.0),
('b0700000-0000-0000-0006-000000000003', 'c0000000-0000-0000-0007-000000000006', true, 3, true, true, 1.0),
('b0700000-0000-0000-0006-000000000004', 'c0000000-0000-0000-0007-000000000006', true, 4, true, true, 1.0),
('b0700000-0000-0000-0006-000000000005', 'c0000000-0000-0000-0007-000000000006', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;

INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0700000-0000-0000-0009-000000000001', 'c0000000-0000-0000-0007-000000000009', true, 1, true, true, 1.0),
('b0700000-0000-0000-0009-000000000002', 'c0000000-0000-0000-0007-000000000009', true, 2, true, true, 1.0),
('b0700000-0000-0000-0009-000000000003', 'c0000000-0000-0000-0007-000000000009', true, 3, true, true, 1.0),
('b0700000-0000-0000-0009-000000000004', 'c0000000-0000-0000-0007-000000000009', true, 4, true, true, 1.0),
('b0700000-0000-0000-0009-000000000005', 'c0000000-0000-0000-0007-000000000009', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;
