-- ============================================
-- Tutorio Seed Data - Computational Thinking Course
-- Based on Expanded Course Content
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
  ),
  (
    'a0000000-0000-0000-0000-000000000003',
    'Advanced',
    'advanced',
    'Premium experience with video content and AI tutoring',
    19.90,
    199.00,
    '{
      "moduleAccess": "all",
      "textLessons": true,
      "basicQuizzes": true,
      "codeEditorLimit": "unlimited",
      "codingChallenges": true,
      "interactiveVisualizers": true,
      "progressDashboard": "full",
      "badges": "all",
      "adFree": true,
      "streakFreeze": true,
      "videoLessons": true,
      "aiTutor": true,
      "mockExams": true
    }'::jsonb,
    true,
    2
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
    'Master problem-solving and Python programming through interactive learning. This comprehensive course covers the four pillars of computational thinking, Python fundamentals, data structures, object-oriented programming, and debugging techniques. Designed for hospitality and business students at EHL, this course transforms you from a complete beginner to a confident programmer.',
    'Master problem-solving and Python programming through interactive learning',
    'beginner',
    40,
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
    'Discover the four pillars of computational thinking and learn why these problem-solving skills are essential for success in any field',
    90,
    300,
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
    'Master the three solution-finding strategies that form the foundation of systematic problem-solving',
    100,
    350,
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
    'Learn to design, visualize, and plan solutions before writing code',
    120,
    400,
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
    'Write your first Python programs and understand the fundamentals of this powerful language',
    90,
    350,
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
    'Store, manipulate, and transform data using Python variables and data types',
    110,
    400,
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
    'Make decisions in your code using if statements, boolean logic, and comparison operators',
    120,
    450,
    'basic',
    false,
    true,
    true
  ),
  -- Mock Midterm Exam
  (
    'd0000000-0000-0000-0000-000000000099',
    'c0000000-0000-0000-0000-000000000001',
    'mock-midterm',
    7,
    'Mock Midterm Exam',
    'mock-midterm-exam',
    'Practice exam covering Modules 1-6 - test your knowledge before the real exam',
    60,
    200,
    'basic',
    true,
    false,
    true
  ),
  -- Module 7: Loops (BASIC)
  (
    'd0000000-0000-0000-0000-000000000007',
    'c0000000-0000-0000-0000-000000000001',
    'mod-07',
    8,
    'Loops - For & While',
    'loops-for-while',
    'Repeat actions efficiently using for and while loops',
    100,
    400,
    'basic',
    false,
    false,
    true
  ),
  -- Module 8: Lists and Collections (BASIC)
  (
    'd0000000-0000-0000-0000-000000000008',
    'c0000000-0000-0000-0000-000000000001',
    'mod-08',
    9,
    'Lists and Collections',
    'lists-and-collections',
    'Work with ordered sequences of data using Python lists',
    120,
    450,
    'basic',
    false,
    false,
    true
  ),
  -- Module 9: Functions (BASIC)
  (
    'd0000000-0000-0000-0000-000000000009',
    'c0000000-0000-0000-0000-000000000001',
    'mod-09',
    10,
    'Functions',
    'functions',
    'Create reusable code blocks and understand the power of modular programming',
    130,
    500,
    'basic',
    false,
    false,
    true
  ),
  -- Module 10: Dictionaries (BASIC)
  (
    'd0000000-0000-0000-0000-000000000010',
    'c0000000-0000-0000-0000-000000000001',
    'mod-10',
    11,
    'Dictionaries',
    'dictionaries',
    'Store and retrieve data using key-value pairs',
    120,
    450,
    'basic',
    false,
    false,
    true
  ),
  -- Module 11: File Handling (BASIC)
  (
    'd0000000-0000-0000-0000-000000000011',
    'c0000000-0000-0000-0000-000000000001',
    'mod-11',
    12,
    'File Handling',
    'file-handling',
    'Read and write data to files for persistent storage',
    90,
    350,
    'basic',
    false,
    false,
    true
  ),
  -- Module 12: Error Handling (BASIC)
  (
    'd0000000-0000-0000-0000-000000000012',
    'c0000000-0000-0000-0000-000000000001',
    'mod-12',
    13,
    'Error Handling',
    'error-handling',
    'Write robust, error-free code and learn to find and fix bugs',
    110,
    400,
    'basic',
    false,
    false,
    true
  ),
  -- Module 13: Python Libraries (BASIC)
  (
    'd0000000-0000-0000-0000-000000000013',
    'c0000000-0000-0000-0000-000000000001',
    'mod-13',
    14,
    'Python Libraries',
    'python-libraries',
    'Extend Python capabilities with built-in and external libraries',
    100,
    400,
    'basic',
    false,
    false,
    true
  ),
  -- Module 14: Data Analysis Basics (BASIC)
  (
    'd0000000-0000-0000-0000-000000000014',
    'c0000000-0000-0000-0000-000000000001',
    'mod-14',
    15,
    'Data Analysis Basics',
    'data-analysis-basics',
    'Analyze data using Python for business insights',
    100,
    400,
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
    16,
    'Course Review & Final Prep',
    'course-review-final-prep',
    'Get ready for exam success with comprehensive review and practice',
    90,
    350,
    'basic',
    false,
    false,
    true
  ),
  -- Mock Final Exam
  (
    'd0000000-0000-0000-0000-000000000100',
    'c0000000-0000-0000-0000-000000000001',
    'mock-final',
    17,
    'Mock Final Exam',
    'mock-final-exam',
    'Full practice exam covering all course material',
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
-- 5. Badges
-- ============================================

INSERT INTO badges (id, name, description, icon, required_plan, unlock_criteria, sort_order) VALUES
  ('first-steps', 'First Steps', 'Complete your first activity', 'footprints', 'free', '{"type": "activity_count", "count": 1}'::jsonb, 1),
  ('ct-thinker', 'CT Thinker', 'Complete Modules 1 and 2', 'brain', 'free', '{"type": "modules_complete", "modules": ["mod-01", "mod-02"]}'::jsonb, 2),
  ('code-newbie', 'Code Newbie', 'Run your first Python code', 'baby', 'free', '{"type": "activity_type_complete", "type": "code", "count": 1}'::jsonb, 3),
  ('pythonista', 'Pythonista', 'Complete all coding exercises', 'code', 'basic', '{"type": "activity_type_complete", "type": "code", "all": true}'::jsonb, 4),
  ('loop-master', 'Loop Master', 'Score 100% on Module 7 checkpoint', 'refresh-cw', 'basic', '{"type": "checkpoint_perfect", "module": "mod-07"}'::jsonb, 5),
  ('bug-squasher', 'Bug Squasher', 'Fix 25 bugs in debugging exercises', 'bug', 'basic', '{"type": "bugs_fixed", "count": 25}'::jsonb, 6),
  ('streak-champion', 'Streak Champion', 'Maintain a 30-day streak', 'flame', 'basic', '{"type": "streak", "days": 30}'::jsonb, 7),
  ('quiz-ace', 'Quiz Ace', 'Score 100% on 5 quizzes', 'award', 'basic', '{"type": "perfect_quizzes", "count": 5}'::jsonb, 8),
  ('challenge-conqueror', 'Challenge Conqueror', 'Complete 10 coding challenges', 'trophy', 'basic', '{"type": "challenges_complete", "count": 10}'::jsonb, 9),
  ('course-complete', 'Course Complete', 'Complete all 15 modules', 'graduation-cap', 'basic', '{"type": "course_complete", "course": "ct-001"}'::jsonb, 10),
  ('midterm-master', 'Midterm Master', 'Score 90%+ on the Mock Midterm', 'medal', 'basic', '{"type": "mock_exam_score", "exam": "mock-midterm", "min_score": 90}'::jsonb, 11),
  ('final-champion', 'Final Champion', 'Score 90%+ on the Mock Final', 'crown', 'basic', '{"type": "mock_exam_score", "exam": "mock-final", "min_score": 90}'::jsonb, 12)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

