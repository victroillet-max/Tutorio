-- ============================================
-- Phase 3: Module 8 Completion
-- Integration Techniques (IC-02)
-- 5 Activities
-- ============================================

-- Integration Techniques Activities
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
('b0800000-0000-0000-0002-000000000001', NULL, '8.2.1', 301, 'Integration Techniques Overview', 'integration-techniques-overview', 'lesson', 15, 35, 'basic', '{"markdown": "# Integration Techniques Overview\n\n## Main Techniques\n\n1. **Substitution (u-sub)**: Reverse the chain rule\n2. **Integration by Parts**: For products of functions\n\n## Substitution Example\n$$\\int 2x(x^2 + 1)^3 dx$$\nLet u = x^2 + 1, du = 2x dx\n$$= \\int u^3 du = \\frac{u^4}{4} + C$$"}'::jsonb, NULL, false, true),
('b0800000-0000-0000-0002-000000000002', NULL, '8.2.2', 302, 'Substitution Method in Detail', 'substitution-method-detail', 'lesson', 15, 35, 'basic', '{"markdown": "# Substitution Method\n\n## Steps\n1. Identify u (inside function)\n2. Find du\n3. Substitute\n4. Integrate\n5. Back-substitute\n\n## Example\n$$\\int (3x + 2)^5 dx$$\nLet u = 3x + 2, du = 3dx\n$$= \\frac{1}{3}\\int u^5 du = \\frac{u^6}{18} + C$$"}'::jsonb, NULL, false, true),
('b0800000-0000-0000-0002-000000000003', NULL, '8.2.3', 303, 'Integration Techniques Practice', 'integration-techniques-practice', 'quiz', 12, 35, 'basic', '{"questions": [{"id": "q1", "type": "mcq", "difficulty": "basic", "question": "Evaluate: integral 6x(x^2 + 1)^2 dx using u = x^2 + 1", "options": ["(x^2 + 1)^3 + C", "3(x^2 + 1)^3 + C", "2(x^2 + 1)^3 + C", "6(x^2 + 1)^3 + C"], "correct": 0, "explanation": "u = x^2 + 1, du = 2x dx. integral 3u^2 du = u^3 + C"}], "passing_score": 70}'::jsonb, NULL, false, true),
('b0800000-0000-0000-0002-000000000004', NULL, '8.2.4', 304, 'Integration Methods Matcher', 'integration-methods-matcher', 'interactive', 8, 25, 'basic', '{"instructions": "Match each integral with the best technique.", "pairs": [{"left": "integral x(x^2+1)^4 dx", "right": "Substitution"}, {"left": "integral x*e^x dx", "right": "Integration by Parts"}]}'::jsonb, 'drag-drop-match', false, true),
('b0800000-0000-0000-0002-000000000005', NULL, '8.2.5', 305, 'Integration Techniques Checkpoint', 'integration-techniques-checkpoint', 'checkpoint', 12, 40, 'basic', '{"questions": [{"id": "cp1", "type": "mcq", "question": "Evaluate: integral 4x^3(x^4 + 3)^2 dx", "options": ["(x^4 + 3)^3/3 + C", "(x^4 + 3)^3 + C", "4(x^4 + 3)^3 + C", "12x^2(x^4 + 3)^2 + C"], "correct": 0, "explanation": "u = x^4 + 3, du = 4x^3 dx. integral u^2 du = u^3/3 + C"}], "passing_score": 70}'::jsonb, NULL, true, true)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, content = EXCLUDED.content;

-- Link Activities to Skills
INSERT INTO activity_skills (activity_id, skill_id, is_owner, order_index, is_primary, teaches, weight) VALUES
('b0800000-0000-0000-0002-000000000001', 'c0000000-0000-0000-0008-000000000002', true, 1, true, true, 1.0),
('b0800000-0000-0000-0002-000000000002', 'c0000000-0000-0000-0008-000000000002', true, 2, true, true, 1.0),
('b0800000-0000-0000-0002-000000000003', 'c0000000-0000-0000-0008-000000000002', true, 3, true, true, 1.0),
('b0800000-0000-0000-0002-000000000004', 'c0000000-0000-0000-0008-000000000002', true, 4, true, true, 1.0),
('b0800000-0000-0000-0002-000000000005', 'c0000000-0000-0000-0008-000000000002', true, 5, true, true, 1.0)
ON CONFLICT (activity_id, skill_id) DO UPDATE SET is_owner = true, order_index = EXCLUDED.order_index;
