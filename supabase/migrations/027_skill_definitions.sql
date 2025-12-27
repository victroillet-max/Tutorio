-- ============================================
-- Skill Definitions
-- All 30+ skills with prerequisites and categories
-- ============================================

-- ============================================
-- CT Foundations Skills (7 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- CT-01: Problem Solving Mindset
(
  'a0000000-0000-0000-0001-000000000001',
  'ct-problem-solving',
  'Problem Solving Mindset',
  'Understanding the approach to breaking down and solving complex problems systematically. The foundation of computational thinking.',
  'ct_foundations',
  1,
  30,
  1
),
-- CT-02: Decomposition
(
  'a0000000-0000-0000-0001-000000000002',
  'ct-decomposition',
  'Decomposition',
  'Breaking down complex problems into smaller, more manageable sub-problems. Essential for tackling any programming challenge.',
  'ct_foundations',
  1,
  30,
  2
),
-- CT-03: Pattern Recognition
(
  'a0000000-0000-0000-0001-000000000003',
  'ct-pattern-recognition',
  'Pattern Recognition',
  'Identifying similarities, trends, and regularities in data or problems. Helps in creating efficient solutions.',
  'ct_foundations',
  1,
  30,
  3
),
-- CT-04: Abstraction
(
  'a0000000-0000-0000-0001-000000000004',
  'ct-abstraction',
  'Abstraction',
  'Focusing on essential information while ignoring irrelevant details. Key to simplifying complex systems.',
  'ct_foundations',
  2,
  30,
  4
),
-- CT-05: Algorithm Design
(
  'a0000000-0000-0000-0001-000000000005',
  'ct-algorithm-design',
  'Algorithm Design',
  'Creating step-by-step procedures to solve problems. The blueprint for any program.',
  'ct_foundations',
  2,
  35,
  5
),
-- CT-06: Flowcharts
(
  'a0000000-0000-0000-0001-000000000006',
  'ct-flowcharts',
  'Flowcharts',
  'Visual representations of algorithms using standard symbols. Helps in planning and communicating solutions.',
  'ct_foundations',
  2,
  25,
  6
),
-- CT-07: Pseudocode
(
  'a0000000-0000-0000-0001-000000000007',
  'ct-pseudocode',
  'Pseudocode',
  'Writing algorithms in human-readable form before coding. Bridges the gap between planning and implementation.',
  'ct_foundations',
  2,
  25,
  7
);

-- ============================================
-- Python Basics Skills (8 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- PY-01: Python Environment
(
  'a0000000-0000-0000-0002-000000000001',
  'py-environment',
  'Python Environment',
  'Setting up and using Python development environment. Understanding how to run Python code.',
  'python_basics',
  1,
  20,
  10
),
-- PY-02: Print & Output
(
  'a0000000-0000-0000-0002-000000000002',
  'py-print-output',
  'Print & Output',
  'Using print() to display information. The first step in making your programs communicate.',
  'python_basics',
  1,
  20,
  11
),
-- PY-03: Variables
(
  'a0000000-0000-0000-0002-000000000003',
  'py-variables',
  'Variables',
  'Storing and manipulating data using named containers. Fundamental to all programming.',
  'python_basics',
  1,
  25,
  12
),
-- PY-04: Data Types
(
  'a0000000-0000-0000-0002-000000000004',
  'py-data-types',
  'Data Types',
  'Understanding integers, floats, strings, and booleans. Knowing how to work with different kinds of data.',
  'python_basics',
  1,
  30,
  13
),
-- PY-05: Operators
(
  'a0000000-0000-0000-0002-000000000005',
  'py-operators',
  'Operators',
  'Arithmetic, comparison, and logical operators. The tools for calculations and decisions.',
  'python_basics',
  1,
  25,
  14
),
-- PY-06: User Input
(
  'a0000000-0000-0000-0002-000000000006',
  'py-user-input',
  'User Input',
  'Getting data from users with input(). Making interactive programs.',
  'python_basics',
  1,
  20,
  15
),
-- PY-07: String Methods
(
  'a0000000-0000-0000-0002-000000000007',
  'py-string-methods',
  'String Methods',
  'Manipulating text with upper(), lower(), split(), strip(), and more. Essential for data processing.',
  'python_basics',
  2,
  30,
  16
),
-- PY-08: F-Strings
(
  'a0000000-0000-0000-0002-000000000008',
  'py-f-strings',
  'F-Strings',
  'Modern string formatting with f-strings. Creating readable, dynamic output.',
  'python_basics',
  2,
  25,
  17
);

-- ============================================
-- Control Flow Skills (6 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- CF-01: Boolean Logic
(
  'a0000000-0000-0000-0003-000000000001',
  'cf-boolean-logic',
  'Boolean Logic',
  'Understanding True/False, and, or, not operators. The foundation of all decision-making in code.',
  'control_flow',
  2,
  25,
  20
),
-- CF-02: Conditionals
(
  'a0000000-0000-0000-0003-000000000002',
  'cf-conditionals',
  'Conditionals',
  'Using if, elif, else for decision making. Making your programs respond to different situations.',
  'control_flow',
  2,
  35,
  21
),
-- CF-03: While Loops
(
  'a0000000-0000-0000-0003-000000000003',
  'cf-while-loops',
  'While Loops',
  'Repeating code while a condition is true. For indefinite iteration.',
  'control_flow',
  2,
  30,
  22
),
-- CF-04: For Loops
(
  'a0000000-0000-0000-0003-000000000004',
  'cf-for-loops',
  'For Loops',
  'Iterating over sequences with for loops. The most common loop pattern in Python.',
  'control_flow',
  2,
  35,
  23
),
-- CF-05: Loop Control
(
  'a0000000-0000-0000-0003-000000000005',
  'cf-loop-control',
  'Loop Control',
  'Using break, continue, and else with loops. Fine-tuning loop behavior.',
  'control_flow',
  3,
  25,
  24
),
-- CF-06: Nested Control
(
  'a0000000-0000-0000-0003-000000000006',
  'cf-nested-control',
  'Nested Control Structures',
  'Combining loops and conditionals. Solving complex multi-layered problems.',
  'control_flow',
  3,
  30,
  25
);

-- ============================================
-- Data Structures Skills (6 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- DS-01: Lists Basics
(
  'a0000000-0000-0000-0004-000000000001',
  'ds-lists-basics',
  'Lists Basics',
  'Creating, accessing, and modifying lists. Python''s most versatile data structure.',
  'data_structures',
  2,
  30,
  30
),
-- DS-02: List Methods
(
  'a0000000-0000-0000-0004-000000000002',
  'ds-list-methods',
  'List Methods',
  'Using append(), insert(), remove(), pop(), sort(), and more. Powerful list manipulation.',
  'data_structures',
  2,
  30,
  31
),
-- DS-03: List Slicing
(
  'a0000000-0000-0000-0004-000000000003',
  'ds-list-slicing',
  'List Slicing',
  'Extracting portions of lists with slice notation. Efficient data extraction.',
  'data_structures',
  3,
  25,
  32
),
-- DS-04: List Comprehensions
(
  'a0000000-0000-0000-0004-000000000004',
  'ds-list-comprehensions',
  'List Comprehensions',
  'Creating lists with concise syntax. Pythonic and efficient.',
  'data_structures',
  3,
  35,
  33
),
-- DS-05: Dictionaries
(
  'a0000000-0000-0000-0004-000000000005',
  'ds-dictionaries',
  'Dictionaries',
  'Key-value pairs for structured data. Essential for real-world applications.',
  'data_structures',
  3,
  35,
  34
),
-- DS-06: Nested Structures
(
  'a0000000-0000-0000-0004-000000000006',
  'ds-nested-structures',
  'Nested Structures',
  'Lists within lists, dicts within dicts. Representing complex data.',
  'data_structures',
  3,
  30,
  35
);

-- ============================================
-- Functions Skills (5 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- FN-01: Defining Functions
(
  'a0000000-0000-0000-0005-000000000001',
  'fn-defining-functions',
  'Defining Functions',
  'Creating reusable code blocks with def. The key to organized, maintainable code.',
  'functions',
  3,
  35,
  40
),
-- FN-02: Parameters & Arguments
(
  'a0000000-0000-0000-0005-000000000002',
  'fn-parameters-arguments',
  'Parameters & Arguments',
  'Passing data to functions. Making functions flexible and reusable.',
  'functions',
  3,
  30,
  41
),
-- FN-03: Return Values
(
  'a0000000-0000-0000-0005-000000000003',
  'fn-return-values',
  'Return Values',
  'Getting data back from functions. Making functions that produce results.',
  'functions',
  3,
  30,
  42
),
-- FN-04: Scope
(
  'a0000000-0000-0000-0005-000000000004',
  'fn-scope',
  'Variable Scope',
  'Understanding local vs global variables. Avoiding common bugs.',
  'functions',
  3,
  25,
  43
),
-- FN-05: Built-in Functions
(
  'a0000000-0000-0000-0005-000000000005',
  'fn-built-in',
  'Built-in Functions',
  'Using len(), range(), sum(), max(), min(), and more. Python''s toolkit.',
  'functions',
  2,
  25,
  44
);

-- ============================================
-- Advanced Topics Skills (6 skills)
-- ============================================

INSERT INTO skills (id, slug, name, description, category, difficulty_level, estimated_minutes, sort_order) VALUES
-- ADV-01: File Handling
(
  'a0000000-0000-0000-0006-000000000001',
  'adv-file-handling',
  'File Handling',
  'Reading from and writing to files. Working with persistent data.',
  'advanced_topics',
  3,
  35,
  50
),
-- ADV-02: Exception Handling
(
  'a0000000-0000-0000-0006-000000000002',
  'adv-exception-handling',
  'Exception Handling',
  'Using try/except to handle errors gracefully. Building robust programs.',
  'advanced_topics',
  3,
  30,
  51
),
-- ADV-03: Python Libraries
(
  'a0000000-0000-0000-0006-000000000003',
  'adv-libraries',
  'Python Libraries',
  'Importing and using math, random, datetime. Extending Python''s capabilities.',
  'advanced_topics',
  3,
  35,
  52
),
-- ADV-04: Math Library
(
  'a0000000-0000-0000-0006-000000000004',
  'adv-math-library',
  'Math Library',
  'Using sqrt(), ceil(), floor(), pi, and more. Mathematical operations.',
  'advanced_topics',
  3,
  25,
  53
),
-- ADV-05: Random Library
(
  'a0000000-0000-0000-0006-000000000005',
  'adv-random-library',
  'Random Library',
  'Generating random numbers and selections. For simulations and games.',
  'advanced_topics',
  3,
  25,
  54
),
-- ADV-06: Data Analysis
(
  'a0000000-0000-0000-0006-000000000006',
  'adv-data-analysis',
  'Data Analysis',
  'Processing, filtering, and analyzing data. Practical Python applications.',
  'advanced_topics',
  4,
  40,
  55
);

-- ============================================
-- Skill Prerequisites
-- ============================================

INSERT INTO skill_prerequisites (skill_id, prerequisite_skill_id, is_required) VALUES
-- CT Foundations prerequisites
('a0000000-0000-0000-0001-000000000002', 'a0000000-0000-0000-0001-000000000001', true),  -- Decomposition requires Problem Solving
('a0000000-0000-0000-0001-000000000003', 'a0000000-0000-0000-0001-000000000001', true),  -- Pattern Recognition requires Problem Solving
('a0000000-0000-0000-0001-000000000004', 'a0000000-0000-0000-0001-000000000001', true),  -- Abstraction requires Problem Solving
('a0000000-0000-0000-0001-000000000005', 'a0000000-0000-0000-0001-000000000002', true),  -- Algorithm Design requires Decomposition
('a0000000-0000-0000-0001-000000000005', 'a0000000-0000-0000-0001-000000000003', true),  -- Algorithm Design requires Pattern Recognition
('a0000000-0000-0000-0001-000000000005', 'a0000000-0000-0000-0001-000000000004', true),  -- Algorithm Design requires Abstraction
('a0000000-0000-0000-0001-000000000006', 'a0000000-0000-0000-0001-000000000005', true),  -- Flowcharts requires Algorithm Design
('a0000000-0000-0000-0001-000000000007', 'a0000000-0000-0000-0001-000000000005', true),  -- Pseudocode requires Algorithm Design

-- Python Basics prerequisites
('a0000000-0000-0000-0002-000000000001', 'a0000000-0000-0000-0001-000000000007', false), -- Python Environment benefits from Pseudocode (recommended)
('a0000000-0000-0000-0002-000000000002', 'a0000000-0000-0000-0002-000000000001', true),  -- Print requires Python Environment
('a0000000-0000-0000-0002-000000000003', 'a0000000-0000-0000-0002-000000000002', true),  -- Variables requires Print
('a0000000-0000-0000-0002-000000000004', 'a0000000-0000-0000-0002-000000000003', true),  -- Data Types requires Variables
('a0000000-0000-0000-0002-000000000005', 'a0000000-0000-0000-0002-000000000004', true),  -- Operators requires Data Types
('a0000000-0000-0000-0002-000000000006', 'a0000000-0000-0000-0002-000000000004', true),  -- User Input requires Data Types
('a0000000-0000-0000-0002-000000000007', 'a0000000-0000-0000-0002-000000000004', true),  -- String Methods requires Data Types
('a0000000-0000-0000-0002-000000000008', 'a0000000-0000-0000-0002-000000000005', true),  -- F-Strings requires Operators
('a0000000-0000-0000-0002-000000000008', 'a0000000-0000-0000-0002-000000000006', true),  -- F-Strings requires User Input

-- Control Flow prerequisites
('a0000000-0000-0000-0003-000000000001', 'a0000000-0000-0000-0002-000000000005', true),  -- Boolean Logic requires Operators
('a0000000-0000-0000-0003-000000000002', 'a0000000-0000-0000-0003-000000000001', true),  -- Conditionals requires Boolean Logic
('a0000000-0000-0000-0003-000000000003', 'a0000000-0000-0000-0003-000000000002', true),  -- While Loops requires Conditionals
('a0000000-0000-0000-0003-000000000004', 'a0000000-0000-0000-0003-000000000002', true),  -- For Loops requires Conditionals
('a0000000-0000-0000-0003-000000000005', 'a0000000-0000-0000-0003-000000000003', true),  -- Loop Control requires While Loops
('a0000000-0000-0000-0003-000000000005', 'a0000000-0000-0000-0003-000000000004', true),  -- Loop Control requires For Loops
('a0000000-0000-0000-0003-000000000006', 'a0000000-0000-0000-0003-000000000005', true),  -- Nested Control requires Loop Control

-- Data Structures prerequisites
('a0000000-0000-0000-0004-000000000001', 'a0000000-0000-0000-0003-000000000004', true),  -- Lists Basics requires For Loops
('a0000000-0000-0000-0004-000000000002', 'a0000000-0000-0000-0004-000000000001', true),  -- List Methods requires Lists Basics
('a0000000-0000-0000-0004-000000000003', 'a0000000-0000-0000-0004-000000000001', true),  -- List Slicing requires Lists Basics
('a0000000-0000-0000-0004-000000000004', 'a0000000-0000-0000-0004-000000000002', true),  -- List Comprehensions requires List Methods
('a0000000-0000-0000-0004-000000000004', 'a0000000-0000-0000-0003-000000000004', true),  -- List Comprehensions requires For Loops
('a0000000-0000-0000-0004-000000000005', 'a0000000-0000-0000-0004-000000000002', true),  -- Dictionaries requires List Methods
('a0000000-0000-0000-0004-000000000006', 'a0000000-0000-0000-0004-000000000005', true),  -- Nested Structures requires Dictionaries
('a0000000-0000-0000-0004-000000000006', 'a0000000-0000-0000-0004-000000000003', true),  -- Nested Structures requires List Slicing

-- Functions prerequisites
('a0000000-0000-0000-0005-000000000001', 'a0000000-0000-0000-0002-000000000008', true),  -- Defining Functions requires F-Strings
('a0000000-0000-0000-0005-000000000001', 'a0000000-0000-0000-0003-000000000005', true),  -- Defining Functions requires Loop Control
('a0000000-0000-0000-0005-000000000002', 'a0000000-0000-0000-0005-000000000001', true),  -- Parameters requires Defining Functions
('a0000000-0000-0000-0005-000000000003', 'a0000000-0000-0000-0005-000000000002', true),  -- Return Values requires Parameters
('a0000000-0000-0000-0005-000000000004', 'a0000000-0000-0000-0005-000000000003', true),  -- Scope requires Return Values
('a0000000-0000-0000-0005-000000000005', 'a0000000-0000-0000-0002-000000000004', true),  -- Built-in Functions requires Data Types

-- Advanced Topics prerequisites
('a0000000-0000-0000-0006-000000000001', 'a0000000-0000-0000-0004-000000000006', true),  -- File Handling requires Nested Structures
('a0000000-0000-0000-0006-000000000001', 'a0000000-0000-0000-0005-000000000004', true),  -- File Handling requires Scope
('a0000000-0000-0000-0006-000000000002', 'a0000000-0000-0000-0006-000000000001', true),  -- Exception Handling requires File Handling
('a0000000-0000-0000-0006-000000000003', 'a0000000-0000-0000-0006-000000000002', true),  -- Libraries requires Exception Handling
('a0000000-0000-0000-0006-000000000004', 'a0000000-0000-0000-0006-000000000003', true),  -- Math Library requires Libraries
('a0000000-0000-0000-0006-000000000005', 'a0000000-0000-0000-0006-000000000003', true),  -- Random Library requires Libraries
('a0000000-0000-0000-0006-000000000006', 'a0000000-0000-0000-0006-000000000004', true),  -- Data Analysis requires Math Library
('a0000000-0000-0000-0006-000000000006', 'a0000000-0000-0000-0006-000000000005', true);  -- Data Analysis requires Random Library

