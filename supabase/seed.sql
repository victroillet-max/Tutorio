-- ============================================
-- Tutorio Seed Data
-- Run after all migrations
-- ============================================

-- ============================================
-- 1. Subscription Tiers
-- ============================================

INSERT INTO subscription_tiers (id, name, slug, description, price_monthly, price_yearly, features, is_active, sort_order) VALUES
  (
    'a0000000-0000-0000-0000-000000000001',
    'Free',
    'free',
    'Get started with core computational thinking concepts',
    0,
    0,
    '{
      "moduleAccess": [1, 2],
      "textLessons": true,
      "basicQuizzes": true,
      "codeEditorLimit": 5,
      "codingChallenges": false,
      "interactiveVisualizers": false,
      "progressDashboard": "basic",
      "badges": 3,
      "adFree": false,
      "streakFreeze": false
    }'::jsonb,
    true,
    0
  ),
  (
    'a0000000-0000-0000-0000-000000000002',
    'Basic',
    'basic',
    'Full access to all modules and interactive content',
    9.90,
    99.00,
    '{
      "moduleAccess": "all",
      "textLessons": true,
      "basicQuizzes": true,
      "codeEditorLimit": "unlimited",
      "codingChallenges": true,
      "interactiveVisualizers": true,
      "progressDashboard": "full",
      "badges": 15,
      "adFree": true,
      "streakFreeze": true
    }'::jsonb,
    true,
    1
  )
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  price_monthly = EXCLUDED.price_monthly,
  features = EXCLUDED.features;

-- ============================================
-- 2. Categories
-- ============================================

INSERT INTO categories (id, name, slug, description, icon, color, sort_order) VALUES
  (
    'b0000000-0000-0000-0000-000000000001',
    'Computer Science',
    'computer-science',
    'Programming, algorithms, and computational thinking',
    'code',
    'blue',
    1
  )
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- 3. Course: Computational Thinking
-- ============================================

INSERT INTO courses (id, category_id, title, slug, description, short_description, difficulty, duration_hours, is_published, is_featured, sort_order) VALUES
  (
    'c0000000-0000-0000-0000-000000000001',
    'b0000000-0000-0000-0000-000000000001',
    'Computational Thinking',
    'computational-thinking',
    'Master problem-solving and Python programming through interactive learning. This comprehensive course covers the four pillars of computational thinking, Python fundamentals, data structures, object-oriented programming, and debugging techniques.',
    'Master problem-solving and Python programming through interactive learning',
    'beginner',
    25,
    true,
    true,
    1
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

-- ============================================
-- 4. Modules
-- ============================================

INSERT INTO modules (id, course_id, external_id, order_index, title, slug, description, estimated_minutes, total_xp, required_plan, is_mock_exam, is_midterm_boundary, is_published) VALUES
  -- Module 1: Introduction to CT (FREE)
  (
    'd0000000-0000-0000-0000-000000000001',
    'c0000000-0000-0000-0000-000000000001',
    'mod-01',
    1,
    'Introduction to Computational Thinking',
    'introduction-to-computational-thinking',
    'Discover the four pillars of computational thinking',
    45,
    150,
    'free',
    false,
    false,
    true
  ),
  -- Module 2: Decomposition, Pattern Recognition & Abstraction (FREE)
  (
    'd0000000-0000-0000-0000-000000000002',
    'c0000000-0000-0000-0000-000000000001',
    'mod-02',
    2,
    'Decomposition, Pattern Recognition & Abstraction',
    'decomposition-pattern-recognition-abstraction',
    'Master the three solution-finding strategies',
    55,
    200,
    'free',
    false,
    false,
    true
  ),
  -- Module 3: Algorithms, Flowcharts & Pseudocode (BASIC)
  (
    'd0000000-0000-0000-0000-000000000003',
    'c0000000-0000-0000-0000-000000000001',
    'mod-03',
    3,
    'Algorithms, Flowcharts & Pseudocode',
    'algorithms-flowcharts-pseudocode',
    'Learn to design and visualize solutions',
    70,
    280,
    'basic',
    false,
    false,
    true
  ),
  -- Module 4: Introduction to Python (BASIC)
  (
    'd0000000-0000-0000-0000-000000000004',
    'c0000000-0000-0000-0000-000000000001',
    'mod-04',
    4,
    'Introduction to Python',
    'introduction-to-python',
    'Write your first Python programs',
    50,
    220,
    'basic',
    false,
    false,
    true
  ),
  -- Module 5: Variables & Data Types (BASIC)
  (
    'd0000000-0000-0000-0000-000000000005',
    'c0000000-0000-0000-0000-000000000001',
    'mod-05',
    5,
    'Variables & Data Types',
    'variables-data-types',
    'Store and manipulate data in Python',
    65,
    300,
    'basic',
    false,
    false,
    true
  ),
  -- Module 6: Conditionals & Boolean Logic (BASIC)
  (
    'd0000000-0000-0000-0000-000000000006',
    'c0000000-0000-0000-0000-000000000001',
    'mod-06',
    6,
    'Conditionals & Boolean Logic',
    'conditionals-boolean-logic',
    'Make decisions in your code',
    70,
    320,
    'basic',
    false,
    true,
    true
  ),
  -- Module 7: Collections Part 1 - Lists (BASIC)
  (
    'd0000000-0000-0000-0000-000000000007',
    'c0000000-0000-0000-0000-000000000001',
    'mod-07',
    7,
    'Collections Part 1 - Lists',
    'collections-lists',
    'Work with ordered sequences of data',
    65,
    310,
    'basic',
    false,
    false,
    true
  ),
  -- Module 8: Collections Part 2 - Tuples, Sets & Dictionaries (BASIC)
  (
    'd0000000-0000-0000-0000-000000000008',
    'c0000000-0000-0000-0000-000000000001',
    'mod-08',
    8,
    'Collections Part 2 - Tuples, Sets & Dictionaries',
    'collections-tuples-sets-dictionaries',
    'Choose the right data structure',
    75,
    350,
    'basic',
    false,
    false,
    true
  ),
  -- Module 9: Loops - For & While (BASIC)
  (
    'd0000000-0000-0000-0000-000000000009',
    'c0000000-0000-0000-0000-000000000001',
    'mod-09',
    9,
    'Loops - For & While',
    'loops-for-while',
    'Repeat actions efficiently',
    80,
    380,
    'basic',
    false,
    false,
    true
  ),
  -- Module 10: Functions (BASIC)
  (
    'd0000000-0000-0000-0000-000000000010',
    'c0000000-0000-0000-0000-000000000001',
    'mod-10',
    10,
    'Functions',
    'functions',
    'Create reusable code blocks',
    70,
    340,
    'basic',
    false,
    false,
    true
  ),
  -- Module 11: Recap & Practice 1 (BASIC)
  (
    'd0000000-0000-0000-0000-000000000011',
    'c0000000-0000-0000-0000-000000000001',
    'mod-11',
    11,
    'Recap & Practice 1',
    'recap-practice-1',
    'Review and consolidate your learning',
    60,
    250,
    'basic',
    false,
    false,
    true
  ),
  -- Module 12: Object-Oriented Programming (BASIC)
  (
    'd0000000-0000-0000-0000-000000000012',
    'c0000000-0000-0000-0000-000000000001',
    'mod-12',
    12,
    'Object-Oriented Programming',
    'object-oriented-programming',
    'Model real-world objects in code',
    70,
    320,
    'basic',
    false,
    false,
    true
  ),
  -- Module 13: Code Evaluation & Debugging (BASIC)
  (
    'd0000000-0000-0000-0000-000000000013',
    'c0000000-0000-0000-0000-000000000001',
    'mod-13',
    13,
    'Code Evaluation & Debugging',
    'code-evaluation-debugging',
    'Write robust, error-free code',
    65,
    290,
    'basic',
    false,
    false,
    true
  ),
  -- Module 14: Recap & Practice 2 (BASIC)
  (
    'd0000000-0000-0000-0000-000000000014',
    'c0000000-0000-0000-0000-000000000001',
    'mod-14',
    14,
    'Recap & Practice 2',
    'recap-practice-2',
    'Advanced integration and review',
    65,
    280,
    'basic',
    false,
    false,
    true
  ),
  -- Module 15: Final Exam Preparation (BASIC)
  (
    'd0000000-0000-0000-0000-000000000015',
    'c0000000-0000-0000-0000-000000000001',
    'mod-15',
    15,
    'Final Exam Preparation',
    'final-exam-preparation',
    'Get ready for exam success',
    60,
    250,
    'basic',
    false,
    false,
    true
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  required_plan = EXCLUDED.required_plan;

-- ============================================
-- 5. Activities for Module 1
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0001-000000000001',
    'd0000000-0000-0000-0000-000000000001',
    '1.1',
    1,
    'Welcome to CT',
    'welcome-to-ct',
    'lesson',
    5,
    10,
    'free',
    '{"markdown": "# Welcome to Computational Thinking\n\nComputational thinking is a way of solving problems, designing systems, and understanding human behavior that draws on concepts fundamental to computer science.\n\nIn this course, you will learn:\n- The four pillars of computational thinking\n- How to break down complex problems\n- Python programming fundamentals\n- Problem-solving strategies used by professionals\n\nLet''s get started!"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0001-000000000002',
    'd0000000-0000-0000-0000-000000000001',
    '1.2',
    2,
    'What is Computational Thinking?',
    'what-is-computational-thinking',
    'lesson',
    8,
    15,
    'free',
    '{"markdown": "# What is Computational Thinking?\n\nComputational thinking (CT) is a problem-solving process that includes:\n\n## Definition\nA set of mental tools that help us solve complex problems systematically.\n\n## Why It Matters\n- Used in every field, not just computer science\n- Helps organize and analyze information\n- Makes complex problems manageable\n- Foundation for programming and automation\n\n## Real-World Applications\n- Planning a trip (route optimization)\n- Cooking a meal (following algorithms)\n- Organizing a project (decomposition)\n- Finding patterns in data (pattern recognition)"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0001-000000000003',
    'd0000000-0000-0000-0000-000000000001',
    '1.3',
    3,
    'CT Concept Check',
    'ct-concept-check',
    'quiz',
    3,
    10,
    'free',
    '{
      "questions": [
        {
          "id": "q1",
          "type": "mcq",
          "question": "What is computational thinking primarily about?",
          "options": [
            "Only writing computer code",
            "A problem-solving process using computer science concepts",
            "Building computers",
            "Mathematical calculations only"
          ],
          "correct": 1,
          "explanation": "Computational thinking is a problem-solving process that uses concepts from computer science, but applies to many fields beyond just coding."
        },
        {
          "id": "q2",
          "type": "true_false",
          "question": "Computational thinking can only be used by programmers.",
          "correct": false,
          "explanation": "Computational thinking is used in many fields including medicine, business, art, and everyday life."
        }
      ],
      "passing_score": 70
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0001-000000000004',
    'd0000000-0000-0000-0000-000000000001',
    '1.4',
    4,
    'The Four Pillars',
    'the-four-pillars',
    'lesson',
    10,
    20,
    'free',
    '{"markdown": "# The Four Pillars of Computational Thinking\n\n## 1. Decomposition\nBreaking down a complex problem into smaller, manageable parts.\n\n**Example:** Planning a birthday party\n- Guest list\n- Venue\n- Food and drinks\n- Entertainment\n- Invitations\n\n## 2. Pattern Recognition\nFinding similarities or patterns among problems or data.\n\n**Example:** Recognizing that all even numbers end in 0, 2, 4, 6, or 8.\n\n## 3. Abstraction\nFocusing on important information only, ignoring irrelevant details.\n\n**Example:** A map shows roads but not every tree or building.\n\n## 4. Algorithms\nDeveloping step-by-step instructions to solve a problem.\n\n**Example:** A recipe is an algorithm for cooking a dish."}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0001-000000000005',
    'd0000000-0000-0000-0000-000000000001',
    '1.5',
    5,
    'Pillar Matching Game',
    'pillar-matching-game',
    'interactive',
    5,
    25,
    'basic',
    '{
      "instructions": "Match each scenario with the correct computational thinking pillar.",
      "pairs": [
        {"left": "Breaking a recipe into steps", "right": "Decomposition"},
        {"left": "Noticing all prime numbers > 2 are odd", "right": "Pattern Recognition"},
        {"left": "Using a simple diagram instead of detailed blueprints", "right": "Abstraction"},
        {"left": "Writing step-by-step directions", "right": "Algorithm"}
      ]
    }'::jsonb,
    'drag-drop-match',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0001-000000000006',
    'd0000000-0000-0000-0000-000000000001',
    '1.7',
    6,
    'Plan Your Event',
    'plan-your-event',
    'interactive',
    10,
    30,
    'basic',
    '{
      "instructions": "Use decomposition to break down planning a school event into smaller tasks.",
      "rootTask": "Plan School Event",
      "expectedBranches": ["Venue", "Budget", "Promotion", "Activities", "Logistics"]
    }'::jsonb,
    'decomposition-builder',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0001-000000000007',
    'd0000000-0000-0000-0000-000000000001',
    '1.8',
    7,
    'Module 1 Checkpoint',
    'module-1-checkpoint',
    'checkpoint',
    10,
    25,
    'free',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "Which pillar involves breaking a problem into smaller parts?",
          "options": ["Abstraction", "Decomposition", "Algorithm", "Pattern Recognition"],
          "correct": 1
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "Ignoring irrelevant details to focus on what matters is called:",
          "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
          "correct": 2
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "A step-by-step solution to a problem is called:",
          "options": ["Pattern", "Decomposition", "Abstraction", "Algorithm"],
          "correct": 3
        },
        {
          "id": "cp4",
          "type": "true_false",
          "question": "Pattern recognition helps us find similarities between problems.",
          "correct": true
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "Which is an example of decomposition?",
          "options": [
            "Noticing all squares have 4 sides",
            "Breaking essay writing into outline, draft, and edit",
            "Creating a simplified map",
            "Following a recipe step by step"
          ],
          "correct": 1
        }
      ],
      "passing_score": 70
    }'::jsonb,
    NULL,
    true,
    true
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content;

-- ============================================
-- 6. Activities for Module 2
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0002-000000000001',
    'd0000000-0000-0000-0000-000000000002',
    '2.1',
    1,
    'Deep Dive: Decomposition',
    'deep-dive-decomposition',
    'lesson',
    8,
    15,
    'free',
    '{"markdown": "# Deep Dive: Decomposition\n\n## What is Decomposition?\nDecomposition means breaking a complex problem or system into smaller, more manageable parts.\n\n## Why Use Decomposition?\n- Makes problems less overwhelming\n- Allows team collaboration\n- Easier to test and debug\n- Reveals hidden complexity\n\n## Decomposition Strategies\n\n### 1. Functional Decomposition\nBreak by what each part does.\n\n### 2. Sequential Decomposition\nBreak by the order things happen.\n\n### 3. Hierarchical Decomposition\nBreak into levels of detail (tree structure).\n\n## Example: Building a Website\n- Design (colors, layout, fonts)\n- Content (text, images, videos)\n- Development (HTML, CSS, JavaScript)\n- Testing (browser compatibility, mobile)\n- Deployment (hosting, domain)"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0002-000000000002',
    'd0000000-0000-0000-0000-000000000002',
    '2.2',
    2,
    'Revenue Tree Builder',
    'revenue-tree-builder',
    'interactive',
    10,
    30,
    'basic',
    '{
      "instructions": "Build a decomposition tree showing how a company generates revenue.",
      "rootNode": "Company Revenue",
      "hints": ["Think about different product lines", "Consider services vs products", "Break down by customer segments"]
    }'::jsonb,
    'tree-builder',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0002-000000000003',
    'd0000000-0000-0000-0000-000000000002',
    '2.3',
    3,
    'Pattern Recognition',
    'pattern-recognition',
    'lesson',
    8,
    15,
    'free',
    '{"markdown": "# Pattern Recognition\n\n## What is Pattern Recognition?\nFinding similarities, trends, or regularities in data or problems.\n\n## Types of Patterns\n\n### 1. Repeating Patterns\n2, 4, 6, 8, 10... (adding 2 each time)\n\n### 2. Structural Patterns\nAll HTML pages have <html>, <head>, and <body> tags.\n\n### 3. Behavioral Patterns\nCustomers who buy X often also buy Y.\n\n## Why Patterns Matter\n- Predict future outcomes\n- Simplify solutions\n- Reuse existing solutions\n- Identify anomalies\n\n## Pattern Recognition in Action\n- Spam filters recognize patterns in spam emails\n- Weather prediction uses historical patterns\n- Medical diagnosis matches symptom patterns"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0002-000000000004',
    'd0000000-0000-0000-0000-000000000002',
    '2.4',
    4,
    'Pattern Finder Game',
    'pattern-finder-game',
    'interactive',
    8,
    30,
    'basic',
    '{
      "instructions": "Identify the pattern and predict the next element in each sequence.",
      "sequences": [
        {"items": [1, 4, 9, 16, 25], "answer": 36, "hint": "Think about square numbers"},
        {"items": ["A", "C", "E", "G"], "answer": "I", "hint": "Skip one letter"},
        {"items": [2, 6, 18, 54], "answer": 162, "hint": "Multiply by 3"}
      ]
    }'::jsonb,
    'pattern-game',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0002-000000000005',
    'd0000000-0000-0000-0000-000000000002',
    '2.5',
    5,
    'Abstraction Explained',
    'abstraction-explained',
    'lesson',
    7,
    15,
    'free',
    '{"markdown": "# Abstraction\n\n## What is Abstraction?\nFocusing on essential information while hiding unnecessary details.\n\n## Levels of Abstraction\n\n### High Level (Most Abstract)\n- What the system does\n- User interface\n- Business logic\n\n### Low Level (Most Detailed)\n- How it works internally\n- Implementation details\n- Binary code\n\n## Examples of Abstraction\n\n### Driving a Car\n- **Abstract view:** Steering wheel, pedals, dashboard\n- **Hidden details:** Engine mechanics, fuel injection, electrical systems\n\n### Using a Phone\n- **Abstract view:** Apps, touchscreen, buttons\n- **Hidden details:** Radio waves, processors, operating system code\n\n## Benefits\n- Simplifies complex systems\n- Allows focus on what matters\n- Enables communication across expertise levels"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0002-000000000006',
    'd0000000-0000-0000-0000-000000000002',
    '2.6',
    6,
    'Abstraction Challenge',
    'abstraction-challenge',
    'interactive',
    8,
    25,
    'basic',
    '{
      "instructions": "For each scenario, identify which details are essential and which can be abstracted away.",
      "scenarios": [
        {
          "context": "Creating a subway map",
          "essential": ["Station names", "Line connections", "Transfer points"],
          "abstract_away": ["Exact distances", "Street names above", "Building locations"]
        }
      ]
    }'::jsonb,
    'filter-essential',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0002-000000000007',
    'd0000000-0000-0000-0000-000000000002',
    '2.7',
    7,
    'Concept Application Quiz',
    'concept-application-quiz',
    'quiz',
    5,
    15,
    'free',
    '{
      "questions": [
        {
          "id": "q1",
          "type": "mcq",
          "question": "Which decomposition strategy breaks a problem by the order things happen?",
          "options": ["Functional", "Sequential", "Hierarchical", "Random"],
          "correct": 1
        },
        {
          "id": "q2",
          "type": "mcq",
          "question": "Recognizing that all email addresses contain @ is an example of:",
          "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
          "correct": 1
        },
        {
          "id": "q3",
          "type": "true_false",
          "question": "Abstraction means including as many details as possible.",
          "correct": false,
          "explanation": "Abstraction means hiding unnecessary details, not including them all."
        }
      ],
      "passing_score": 70
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0002-000000000008',
    'd0000000-0000-0000-0000-000000000002',
    '2.9',
    8,
    'Module 2 Checkpoint',
    'module-2-checkpoint',
    'checkpoint',
    12,
    35,
    'free',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "Breaking website development into design, content, and coding is:",
          "options": ["Pattern Recognition", "Abstraction", "Decomposition", "Algorithm"],
          "correct": 2
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "A subway map that shows connections but not exact distances uses:",
          "options": ["Decomposition", "Pattern Recognition", "Abstraction", "None of these"],
          "correct": 2
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "Noticing that sales increase every December is:",
          "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
          "correct": 1
        },
        {
          "id": "cp4",
          "type": "true_false",
          "question": "Hierarchical decomposition creates a tree-like structure.",
          "correct": true
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "Which helps us reuse solutions from similar problems?",
          "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Debugging"],
          "correct": 1
        }
      ],
      "passing_score": 70
    }'::jsonb,
    NULL,
    true,
    true
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content;

-- ============================================
-- 7. Badges
-- ============================================

INSERT INTO badges (id, name, description, icon, required_plan, unlock_criteria, sort_order) VALUES
  ('first-steps', 'First Steps', 'Complete your first activity', 'footprints', 'free', '{"type": "activity_count", "count": 1}'::jsonb, 1),
  ('ct-thinker', 'CT Thinker', 'Complete Modules 1 and 2', 'brain', 'free', '{"type": "modules_complete", "modules": ["mod-01", "mod-02"]}'::jsonb, 2),
  ('code-newbie', 'Code Newbie', 'Run your first Python code', 'baby', 'free', '{"type": "activity_type_complete", "type": "code", "count": 1}'::jsonb, 3),
  ('pythonista', 'Pythonista', 'Complete all coding exercises', 'code', 'basic', '{"type": "activity_type_complete", "type": "code", "all": true}'::jsonb, 4),
  ('loop-master', 'Loop Master', 'Score 100% on Module 9 checkpoint', 'refresh-cw', 'basic', '{"type": "checkpoint_perfect", "module": "mod-09"}'::jsonb, 5),
  ('bug-squasher', 'Bug Squasher', 'Fix 25 bugs in debugging exercises', 'bug', 'basic', '{"type": "bugs_fixed", "count": 25}'::jsonb, 6),
  ('streak-champion', 'Streak Champion', 'Maintain a 30-day streak', 'flame', 'basic', '{"type": "streak", "days": 30}'::jsonb, 7),
  ('course-complete', 'Course Complete', 'Complete all 15 modules', 'graduation-cap', 'basic', '{"type": "course_complete", "course": "ct-001"}'::jsonb, 10)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
