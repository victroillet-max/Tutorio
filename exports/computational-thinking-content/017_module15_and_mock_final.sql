-- ============================================
-- Activities for Module 15: Final Exam Preparation
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0015-000000000001',
    'd0000000-0000-0000-0000-000000000015',
    '15.1',
    1,
    'Course Summary',
    'course-summary',
    'lesson',
    10,
    20,
    'basic',
    '{"markdown": "# Course Summary\n\n## Part 1: Computational Thinking (Modules 1-3)\n\n### The Four Pillars\n1. **Decomposition** - Break problems into smaller parts\n2. **Pattern Recognition** - Find similarities and trends\n3. **Abstraction** - Focus on essentials, hide details\n4. **Algorithms** - Step-by-step solutions\n\n### Representing Algorithms\n- **Flowcharts**: Visual representation with symbols\n- **Pseudocode**: Structured natural language\n\n## Part 2: Python Fundamentals (Modules 4-6)\n\n### Core Concepts\n- Variables and data types (int, float, str, bool)\n- Operators (arithmetic, comparison, logical)\n- Input/output (print, input)\n- Conditionals (if, elif, else)\n\n## Part 3: Data Structures (Modules 7-8)\n\n| Type | Syntax | Properties |\n|------|--------|------------|\n| List | [1,2,3] | Ordered, mutable |\n| Tuple | (1,2,3) | Ordered, immutable |\n| Set | {1,2,3} | Unordered, unique |\n| Dict | {\"a\":1} | Key-value pairs |\n\n## Part 4: Control Flow (Module 9)\n\n- **While loops**: Repeat while condition true\n- **For loops**: Iterate over sequences\n- **Control**: break, continue, enumerate\n\n## Part 5: Functions (Module 10)\n\n- def keyword, parameters, return\n- Scope (local vs global)\n- Default parameters\n\n## Part 6: OOP & Testing (Modules 12-13)\n\n- Classes and objects\n- __init__, __str__, methods\n- Defensive programming\n- Testing strategies"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0015-000000000002',
    'd0000000-0000-0000-0000-000000000015',
    '15.2',
    2,
    'Exam Strategy Tips',
    'exam-strategy-tips',
    'lesson',
    8,
    15,
    'basic',
    '{"markdown": "# Exam Strategy Tips\n\n## Before the Exam\n\n### 1. Review Key Concepts\n- Skim through all module summaries\n- Focus on areas where you scored lower\n- Review your notes from checkpoints\n\n### 2. Practice Coding\n- Write code without IDE help\n- Practice tracing code by hand\n- Time yourself on practice problems\n\n### 3. Prepare Physically\n- Get good sleep\n- Eat well before the exam\n- Arrive early\n\n## During the Exam\n\n### 1. Read Carefully\n- Read the entire question before answering\n- Underline key requirements\n- Watch for \"NOT\" or \"EXCEPT\" in questions\n\n### 2. Manage Time\n- Quick scan of all questions first\n- Answer easy questions first\n- Allocate time per section\n\n### 3. Code Tracing Strategy\n- Draw a table for variables\n- Step through line by line\n- Track loop iterations\n\n### 4. Writing Code\n- Plan before writing\n- Start with function signature\n- Write comments first\n- Check edge cases\n\n## Common Pitfalls\n\n- Forgetting colons after if/for/def\n- Off-by-one errors in ranges\n- Confusing = and ==\n- Not handling empty inputs\n- Forgetting to return values\n\n## Quick Reference\n\n```\nrange(5)      # 0,1,2,3,4\nrange(1,5)    # 1,2,3,4\nlist[-1]      # Last item\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0015-000000000003',
    'd0000000-0000-0000-0000-000000000015',
    '15.3',
    3,
    'Quick Review Quiz',
    'quick-review-quiz',
    'quiz',
    10,
    25,
    'basic',
    '{
      "questions": [
        {
          "id": "q1",
          "type": "mcq",
          "question": "What is the output of: print(list(range(2, 8, 2)))",
          "options": ["[2, 4, 6, 8]", "[2, 4, 6]", "[2, 3, 4, 5, 6, 7]", "[8, 6, 4, 2]"],
          "correct": 1
        },
        {
          "id": "q2",
          "type": "mcq",
          "question": "Which method adds an item to a list without modifying the original?",
          "options": ["append()", "insert()", "Neither - both modify", "+ operator creates new list"],
          "correct": 3
        },
        {
          "id": "q3",
          "type": "mcq",
          "question": "What symbol is used for decision in flowcharts?",
          "options": ["Rectangle", "Diamond", "Oval", "Parallelogram"],
          "correct": 1
        },
        {
          "id": "q4",
          "type": "true_false",
          "question": "A set can contain duplicate values.",
          "correct": false
        },
        {
          "id": "q5",
          "type": "mcq",
          "question": "What is returned by a function with no return statement?",
          "options": ["0", "\"\"", "None", "False"],
          "correct": 2
        },
        {
          "id": "q6",
          "type": "mcq",
          "question": "Which is mutable?",
          "options": ["String", "Tuple", "Integer", "List"],
          "correct": 3
        },
        {
          "id": "q7",
          "type": "mcq",
          "question": "What does __init__ do?",
          "options": ["Deletes object", "Initializes object", "Prints object", "Compares objects"],
          "correct": 1
        },
        {
          "id": "q8",
          "type": "mcq",
          "question": "What is abstraction in computational thinking?",
          "options": [
            "Breaking problems into parts",
            "Finding patterns",
            "Hiding unnecessary details",
            "Writing step-by-step solutions"
          ],
          "correct": 2
        }
      ],
      "passing_score": 70
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0015-000000000004',
    'd0000000-0000-0000-0000-000000000015',
    '15.4',
    4,
    'Weak Areas Practice',
    'weak-areas-practice',
    'code',
    15,
    40,
    'basic',
    '{
      "instructions": "Complete these mixed practice problems covering key concepts:\n\n1. Write a function that returns True if a number is prime\n2. Write a function that reverses a string without using [::-1]\n3. Write a function that finds the most common element in a list",
      "starterCode": "# Problem 1: Check if number is prime\ndef is_prime(n):\n    \"\"\"Return True if n is prime, False otherwise\"\"\"\n    pass\n\n# Problem 2: Reverse a string\ndef reverse_string(s):\n    \"\"\"Reverse without using [::-1]\"\"\"\n    pass\n\n# Problem 3: Find most common element\ndef most_common(items):\n    \"\"\"Return the most frequent element\"\"\"\n    pass\n\n# Tests\nprint(\"Testing is_prime:\")\nprint(f\"  is_prime(7) = {is_prime(7)}\")   # True\nprint(f\"  is_prime(4) = {is_prime(4)}\")   # False\nprint(f\"  is_prime(1) = {is_prime(1)}\")   # False\n\nprint(\"\\nTesting reverse_string:\")\nprint(f\"  reverse_string(''hello'') = {reverse_string(''hello'')}\")  # olleh\n\nprint(\"\\nTesting most_common:\")\nprint(f\"  most_common([1,2,2,3,2,1]) = {most_common([1,2,2,3,2,1])}\")  # 2",
      "solution": "# Problem 1: Check if number is prime\ndef is_prime(n):\n    \"\"\"Return True if n is prime, False otherwise\"\"\"\n    if n < 2:\n        return False\n    for i in range(2, int(n ** 0.5) + 1):\n        if n % i == 0:\n            return False\n    return True\n\n# Problem 2: Reverse a string\ndef reverse_string(s):\n    \"\"\"Reverse without using [::-1]\"\"\"\n    result = \"\"\n    for char in s:\n        result = char + result\n    return result\n\n# Problem 3: Find most common element\ndef most_common(items):\n    \"\"\"Return the most frequent element\"\"\"\n    if not items:\n        return None\n    counts = {}\n    for item in items:\n        counts[item] = counts.get(item, 0) + 1\n    max_item = items[0]\n    max_count = 0\n    for item, count in counts.items():\n        if count > max_count:\n            max_count = count\n            max_item = item\n    return max_item\n\n# Tests\nprint(\"Testing is_prime:\")\nprint(f\"  is_prime(7) = {is_prime(7)}\")   # True\nprint(f\"  is_prime(4) = {is_prime(4)}\")   # False\nprint(f\"  is_prime(1) = {is_prime(1)}\")   # False\n\nprint(\"\\nTesting reverse_string:\")\nprint(f\"  reverse_string(''hello'') = {reverse_string(''hello'')}\")  # olleh\n\nprint(\"\\nTesting most_common:\")\nprint(f\"  most_common([1,2,2,3,2,1]) = {most_common([1,2,2,3,2,1])}\")  # 2",
      "testCases": [
        {"input": "", "expectedOutput": "is_prime(7) = True", "description": "7 is prime"},
        {"input": "", "expectedOutput": "reverse_string(''hello'') = olleh", "description": "String reversed"},
        {"input": "", "expectedOutput": "most_common([1,2,2,3,2,1]) = 2", "description": "2 is most common"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0015-000000000005',
    'd0000000-0000-0000-0000-000000000015',
    '15.6',
    5,
    'Module 15 Checkpoint',
    'module-15-checkpoint',
    'checkpoint',
    12,
    35,
    'basic',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "What is the output?\n\nx = [1, 2, 3]\ny = x\ny.append(4)\nprint(len(x))",
          "options": ["3", "4", "Error", "None"],
          "correct": 1,
          "explanation": "Lists are passed by reference. x and y point to the same list."
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "Which represents decomposition?",
          "options": [
            "Finding that all loop patterns use similar structure",
            "Breaking \"make breakfast\" into: cook eggs, toast bread, pour juice",
            "Ignoring the color of buttons when designing a calculator",
            "Writing step-by-step instructions for a recipe"
          ],
          "correct": 1
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "What does dict.get(key, default) do if key doesn''t exist?",
          "options": [
            "Raises KeyError",
            "Returns None",
            "Returns the default value",
            "Adds the key with default value"
          ],
          "correct": 2
        },
        {
          "id": "cp4",
          "type": "mcq",
          "question": "In OOP, what is encapsulation?",
          "options": [
            "Creating multiple classes",
            "Bundling data and methods, controlling access",
            "Inheriting from parent class",
            "Using multiple objects"
          ],
          "correct": 1
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "What is the time complexity concern with nested loops?",
          "options": [
            "They use more memory",
            "Iterations multiply (e.g., 100 x 100 = 10000)",
            "They cause syntax errors",
            "They cannot access outer variables"
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
-- Mock Final Exam Module and Activity
-- ============================================

-- Add the mock final module
INSERT INTO modules (id, course_id, external_id, order_index, title, slug, description, estimated_minutes, total_xp, required_plan, is_mock_exam, is_midterm_boundary, is_published) VALUES
  (
    'd0000000-0000-0000-0000-000000000200',
    'c0000000-0000-0000-0000-000000000001',
    'mock-final',
    16,
    'Final Mock Exam',
    'final-mock-exam',
    'Full exam simulation - 2 hours covering all course content',
    120,
    150,
    'advanced',
    true,
    false,
    true
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

-- Mock Final Exam Activity
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0200-000000000001',
    'd0000000-0000-0000-0000-000000000200',
    'F1',
    1,
    'Final Mock Exam',
    'final-mock-exam',
    'quiz',
    120,
    150,
    'advanced',
    '{
      "examType": "final",
      "timeLimit": 120,
      "instructions": "This mock exam simulates the university final exam. You have 2 hours to complete all questions. The exam covers all course content from Modules 1-15.",
      "sections": [
        {
          "name": "Part A: Multiple Choice",
          "points": 30,
          "questions": [
            {
              "id": "f1",
              "type": "mcq",
              "question": "Which pillar of CT involves finding similarities between problems?",
              "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
              "correct": 1,
              "points": 2
            },
            {
              "id": "f2",
              "type": "mcq",
              "question": "What is the output of: print(type(3.14))",
              "options": ["<class ''int''>", "<class ''float''>", "<class ''str''>", "<class ''number''>"],
              "correct": 1,
              "points": 2
            },
            {
              "id": "f3",
              "type": "mcq",
              "question": "Which collection type should you use for unique items with fast lookup?",
              "options": ["List", "Tuple", "Set", "Dictionary"],
              "correct": 2,
              "points": 2
            },
            {
              "id": "f4",
              "type": "mcq",
              "question": "What does enumerate() return?",
              "options": ["Just indices", "Just values", "Tuples of (index, value)", "A count"],
              "correct": 2,
              "points": 2
            },
            {
              "id": "f5",
              "type": "mcq",
              "question": "In a flowchart, what does a parallelogram represent?",
              "options": ["Process", "Decision", "Input/Output", "Start/End"],
              "correct": 2,
              "points": 2
            },
            {
              "id": "f6",
              "type": "mcq",
              "question": "What is 17 % 5?",
              "options": ["2", "3", "3.4", "17"],
              "correct": 0,
              "points": 2
            },
            {
              "id": "f7",
              "type": "mcq",
              "question": "Which is NOT a valid variable name?",
              "options": ["_private", "myVar2", "2ndPlace", "camelCase"],
              "correct": 2,
              "points": 2
            },
            {
              "id": "f8",
              "type": "mcq",
              "question": "What does break do in a loop?",
              "options": ["Skips current iteration", "Exits loop immediately", "Restarts loop", "Pauses execution"],
              "correct": 1,
              "points": 2
            },
            {
              "id": "f9",
              "type": "mcq",
              "question": "What is the purpose of __init__ in a class?",
              "options": ["Delete object", "Initialize object", "Print object", "Compare objects"],
              "correct": 1,
              "points": 2
            },
            {
              "id": "f10",
              "type": "mcq",
              "question": "What does self refer to in a method?",
              "options": ["The class", "The current instance", "All instances", "The parent class"],
              "correct": 1,
              "points": 2
            }
          ]
        },
        {
          "name": "Part B: True/False",
          "points": 10,
          "questions": [
            {
              "id": "f11",
              "type": "true_false",
              "question": "A tuple can be used as a dictionary key.",
              "correct": true,
              "points": 2
            },
            {
              "id": "f12",
              "type": "true_false",
              "question": "The expression 5 == 5.0 evaluates to True.",
              "correct": true,
              "points": 2
            },
            {
              "id": "f13",
              "type": "true_false",
              "question": "Lists in Python are immutable.",
              "correct": false,
              "points": 2
            },
            {
              "id": "f14",
              "type": "true_false",
              "question": "A function can return multiple values.",
              "correct": true,
              "points": 2
            },
            {
              "id": "f15",
              "type": "true_false",
              "question": "range(5) includes the number 5.",
              "correct": false,
              "points": 2
            }
          ]
        },
        {
          "name": "Part C: Code Tracing",
          "points": 20,
          "questions": [
            {
              "id": "f16",
              "type": "code_output",
              "question": "What is printed?\n\nfor i in range(3):\n    for j in range(2):\n        print(i + j, end=\" \")",
              "correctAnswer": "0 1 1 2 2 3 ",
              "points": 5
            },
            {
              "id": "f17",
              "type": "code_output",
              "question": "What is printed?\n\ndef mystery(lst):\n    return [x * 2 for x in lst if x > 0]\n\nprint(mystery([-1, 2, -3, 4]))",
              "correctAnswer": "[4, 8]",
              "points": 5
            },
            {
              "id": "f18",
              "type": "code_output",
              "question": "What is printed?\n\nclass Counter:\n    def __init__(self):\n        self.count = 0\n    def add(self, n=1):\n        self.count += n\n\nc = Counter()\nc.add()\nc.add(5)\nprint(c.count)",
              "correctAnswer": "6",
              "points": 5
            },
            {
              "id": "f19",
              "type": "code_output",
              "question": "What is printed?\n\nd = {\"a\": 1, \"b\": 2}\nd[\"c\"] = d.get(\"a\", 0) + d.get(\"c\", 0)\nprint(d[\"c\"])",
              "correctAnswer": "1",
              "points": 5
            }
          ]
        },
        {
          "name": "Part D: Short Answer",
          "points": 20,
          "questions": [
            {
              "id": "f20",
              "type": "short_answer",
              "question": "Write a function is_palindrome(s) that returns True if string s reads the same forwards and backwards.",
              "sampleAnswer": "def is_palindrome(s):\n    return s == s[::-1]",
              "points": 10
            },
            {
              "id": "f21",
              "type": "short_answer",
              "question": "Write a function count_vowels(s) that returns the count of vowels (a, e, i, o, u) in string s.",
              "sampleAnswer": "def count_vowels(s):\n    vowels = ''aeiouAEIOU''\n    count = 0\n    for char in s:\n        if char in vowels:\n            count += 1\n    return count",
              "points": 10
            }
          ]
        }
      ],
      "passing_score": 60,
      "totalPoints": 80
    }'::jsonb,
    NULL,
    false,
    true
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content;

