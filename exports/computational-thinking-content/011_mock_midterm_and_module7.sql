-- ============================================
-- Mock Midterm Exam Module and Activity
-- ============================================

-- First, add the mock midterm module
INSERT INTO modules (id, course_id, external_id, order_index, title, slug, description, estimated_minutes, total_xp, required_plan, is_mock_exam, is_midterm_boundary, is_published) VALUES
  (
    'd0000000-0000-0000-0000-000000000100',
    'c0000000-0000-0000-0000-000000000001',
    'mock-midterm',
    6.5,
    'Midterm Mock Exam',
    'midterm-mock-exam',
    'Simulates university midterm exam - Test your knowledge from Modules 1-6',
    40,
    100,
    'advanced',
    true,
    false,
    true
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description;

-- Mock Midterm Activity
INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0100-000000000001',
    'd0000000-0000-0000-0000-000000000100',
    'M1',
    1,
    'Midterm Mock Exam',
    'midterm-mock-exam',
    'quiz',
    40,
    100,
    'advanced',
    '{
      "examType": "midterm",
      "timeLimit": 40,
      "instructions": "This mock exam simulates the university midterm. You have 40 minutes to complete all questions. The exam covers Modules 1-6.",
      "questions": [
        {
          "id": "m1",
          "type": "mcq",
          "question": "Which of the following is NOT one of the four pillars of computational thinking?",
          "options": ["Decomposition", "Pattern Recognition", "Optimization", "Abstraction"],
          "correct": 2,
          "points": 2
        },
        {
          "id": "m2",
          "type": "mcq",
          "question": "What data type does input() return in Python?",
          "options": ["int", "float", "str", "bool"],
          "correct": 2,
          "points": 2
        },
        {
          "id": "m3",
          "type": "mcq",
          "question": "What is the result of: 15 // 4",
          "options": ["3.75", "3", "4", "3.0"],
          "correct": 1,
          "points": 2
        },
        {
          "id": "m4",
          "type": "mcq",
          "question": "In a flowchart, which symbol represents a decision?",
          "options": ["Rectangle", "Oval", "Diamond", "Parallelogram"],
          "correct": 2,
          "points": 2
        },
        {
          "id": "m5",
          "type": "code_output",
          "question": "What is the output of this code?\n\nx = 5\ny = 3\nif x > y:\n    print(\"A\")\n    if x > 10:\n        print(\"B\")\nelse:\n    print(\"C\")",
          "correctAnswer": "A",
          "points": 3
        },
        {
          "id": "m6",
          "type": "mcq",
          "question": "What is: not (True and False)",
          "options": ["True", "False", "None", "Error"],
          "correct": 0,
          "points": 2
        },
        {
          "id": "m7",
          "type": "mcq",
          "question": "Which is the correct way to create an f-string?",
          "options": [
            "print(f\"Hello {name}\")",
            "print(\"Hello {name}\".format())",
            "print(\"Hello \" + name)",
            "All of the above"
          ],
          "correct": 0,
          "points": 2
        },
        {
          "id": "m8",
          "type": "true_false",
          "question": "In Python, variable names are case-sensitive.",
          "correct": true,
          "points": 1
        },
        {
          "id": "m9",
          "type": "mcq",
          "question": "What is the modulus operator in Python?",
          "options": ["/", "//", "%", "**"],
          "correct": 2,
          "points": 2
        },
        {
          "id": "m10",
          "type": "code_output",
          "question": "What does this code print?\n\nfor i in range(3):\n    print(i, end=\" \")",
          "correctAnswer": "0 1 2 ",
          "points": 3
        }
      ],
      "passing_score": 60,
      "totalPoints": 21
    }'::jsonb,
    NULL,
    false,
    true
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content;

-- ============================================
-- Activities for Module 7: Collections Part 1 - Lists
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0007-000000000001',
    'd0000000-0000-0000-0000-000000000007',
    '7.1',
    1,
    'Lists Introduction',
    'lists-introduction',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Lists Introduction\n\nA list is an ordered collection of items that can be changed.\n\n## Creating Lists\n\n```python\n# Empty list\nempty_list = []\n\n# List with items\nfruits = [\"apple\", \"banana\", \"cherry\"]\nnumbers = [1, 2, 3, 4, 5]\nmixed = [1, \"hello\", 3.14, True]\n```\n\n## Why Use Lists?\n\n- Store multiple values in one variable\n- Keep items in a specific order\n- Add, remove, or change items\n- Process items one by one\n\n## List Properties\n\n1. **Ordered** - Items maintain their position\n2. **Mutable** - Can be changed after creation\n3. **Allow duplicates** - Same value can appear multiple times\n4. **Mixed types** - Can contain different data types\n\n## Basic Operations\n\n```python\nfruits = [\"apple\", \"banana\", \"cherry\"]\n\n# Length\nprint(len(fruits))      # 3\n\n# Check if item exists\nprint(\"apple\" in fruits)    # True\nprint(\"mango\" in fruits)    # False\n\n# Access by index\nprint(fruits[0])        # apple\nprint(fruits[-1])       # cherry (last item)\n```\n\n## Real-World Examples\n\n- Shopping cart items\n- Student names in a class\n- Scores in a game\n- Steps in a recipe"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0007-000000000002',
    'd0000000-0000-0000-0000-000000000007',
    '7.2',
    2,
    'Indexing & Slicing',
    'indexing-and-slicing',
    'lesson',
    8,
    15,
    'basic',
    '{"markdown": "# Indexing & Slicing\n\n## Indexing - Access Single Items\n\nList indices start at 0!\n\n```python\nfruits = [\"apple\", \"banana\", \"cherry\", \"date\", \"elderberry\"]\n#          0         1         2        3         4\n#         -5        -4        -3       -2        -1\n\n# Positive indexing (from start)\nprint(fruits[0])    # apple\nprint(fruits[2])    # cherry\n\n# Negative indexing (from end)\nprint(fruits[-1])   # elderberry\nprint(fruits[-2])   # date\n```\n\n## Slicing - Access Multiple Items\n\nSyntax: `list[start:end:step]`\n\n```python\nnumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]\n\n# Basic slicing [start:end] (end not included)\nprint(numbers[2:5])     # [2, 3, 4]\nprint(numbers[:4])      # [0, 1, 2, 3] (from start)\nprint(numbers[6:])      # [6, 7, 8, 9] (to end)\nprint(numbers[:])       # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] (copy)\n\n# With step\nprint(numbers[::2])     # [0, 2, 4, 6, 8] (every 2nd)\nprint(numbers[1::2])    # [1, 3, 5, 7, 9] (odd indices)\n\n# Reverse a list\nprint(numbers[::-1])    # [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]\n```\n\n## Modifying with Indexing\n\n```python\nfruits = [\"apple\", \"banana\", \"cherry\"]\nfruits[1] = \"blueberry\"\nprint(fruits)   # [\"apple\", \"blueberry\", \"cherry\"]\n```\n\n## Common Error\n\n```python\nfruits = [\"apple\", \"banana\"]\nprint(fruits[5])    # IndexError: list index out of range\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0007-000000000003',
    'd0000000-0000-0000-0000-000000000007',
    '7.3',
    3,
    'List Visualizer',
    'list-visualizer',
    'interactive',
    8,
    30,
    'basic',
    '{
      "instructions": "Visualize how lists work in memory and practice indexing operations.",
      "type": "list-visualizer",
      "exercises": [
        {
          "list": ["a", "b", "c", "d", "e"],
          "question": "What is the value at index 2?",
          "answer": "c"
        },
        {
          "list": ["a", "b", "c", "d", "e"],
          "question": "What is the value at index -1?",
          "answer": "e"
        },
        {
          "list": [10, 20, 30, 40, 50],
          "question": "What is the result of list[1:4]?",
          "answer": "[20, 30, 40]"
        },
        {
          "list": [10, 20, 30, 40, 50],
          "question": "What is the result of list[::2]?",
          "answer": "[10, 30, 50]"
        }
      ]
    }'::jsonb,
    'list-visualizer',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0007-000000000004',
    'd0000000-0000-0000-0000-000000000007',
    '7.4',
    4,
    'List Methods',
    'list-methods',
    'lesson',
    8,
    15,
    'basic',
    '{"markdown": "# List Methods\n\nLists come with powerful built-in methods.\n\n## Adding Items\n\n```python\nfruits = [\"apple\", \"banana\"]\n\n# append() - Add to end\nfruits.append(\"cherry\")\nprint(fruits)   # [\"apple\", \"banana\", \"cherry\"]\n\n# insert() - Add at specific position\nfruits.insert(1, \"blueberry\")\nprint(fruits)   # [\"apple\", \"blueberry\", \"banana\", \"cherry\"]\n\n# extend() - Add multiple items\nfruits.extend([\"date\", \"elderberry\"])\nprint(fruits)   # [\"apple\", \"blueberry\", \"banana\", \"cherry\", \"date\", \"elderberry\"]\n```\n\n## Removing Items\n\n```python\nfruits = [\"apple\", \"banana\", \"cherry\", \"banana\"]\n\n# remove() - Remove first occurrence\nfruits.remove(\"banana\")\nprint(fruits)   # [\"apple\", \"cherry\", \"banana\"]\n\n# pop() - Remove and return by index\nitem = fruits.pop(1)    # Removes \"cherry\"\nprint(item)     # cherry\nprint(fruits)   # [\"apple\", \"banana\"]\n\n# pop() - Remove last item (no index)\nlast = fruits.pop()\nprint(last)     # banana\n\n# clear() - Remove all items\nfruits.clear()\nprint(fruits)   # []\n```\n\n## Other Useful Methods\n\n```python\nnumbers = [3, 1, 4, 1, 5, 9, 2, 6]\n\n# sort() - Sort in place\nnumbers.sort()\nprint(numbers)  # [1, 1, 2, 3, 4, 5, 6, 9]\n\n# reverse() - Reverse in place\nnumbers.reverse()\nprint(numbers)  # [9, 6, 5, 4, 3, 2, 1, 1]\n\n# count() - Count occurrences\nprint(numbers.count(1))     # 2\n\n# index() - Find position\nprint(numbers.index(5))     # 2\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0007-000000000005',
    'd0000000-0000-0000-0000-000000000007',
    '7.5',
    5,
    'Method Practice',
    'method-practice',
    'code',
    10,
    30,
    'basic',
    '{
      "instructions": "Practice using list methods:\n1. Start with the given list of numbers\n2. Add 100 to the end\n3. Insert 50 at index 2\n4. Remove the value 30\n5. Sort the list\n6. Print the final result",
      "starterCode": "numbers = [10, 20, 30, 40]\n\n# 1. Add 100 to the end\n\n# 2. Insert 50 at index 2\n\n# 3. Remove the value 30\n\n# 4. Sort the list\n\n# 5. Print the final result\nprint(numbers)",
      "solution": "numbers = [10, 20, 30, 40]\n\n# 1. Add 100 to the end\nnumbers.append(100)\n\n# 2. Insert 50 at index 2\nnumbers.insert(2, 50)\n\n# 3. Remove the value 30\nnumbers.remove(30)\n\n# 4. Sort the list\nnumbers.sort()\n\n# 5. Print the final result\nprint(numbers)",
      "testCases": [
        {"input": "", "expectedOutput": "[10, 20, 40, 50, 100]", "description": "Final list should be sorted correctly"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0007-000000000006',
    'd0000000-0000-0000-0000-000000000007',
    '7.6',
    6,
    'The in Operator',
    'the-in-operator',
    'lesson',
    5,
    10,
    'basic',
    '{"markdown": "# The ''in'' Operator\n\nThe `in` operator checks if an item exists in a list.\n\n## Basic Usage\n\n```python\nfruits = [\"apple\", \"banana\", \"cherry\"]\n\n# Check if item exists\nprint(\"apple\" in fruits)      # True\nprint(\"mango\" in fruits)      # False\n\n# Check if item does NOT exist\nprint(\"mango\" not in fruits)  # True\n```\n\n## Using in Conditionals\n\n```python\nguest_list = [\"Alice\", \"Bob\", \"Charlie\"]\nname = \"Bob\"\n\nif name in guest_list:\n    print(f\"Welcome, {name}!\")\nelse:\n    print(\"Sorry, you''re not on the list.\")\n```\n\n## Practical Examples\n\n### Password Validation\n```python\nweak_passwords = [\"123456\", \"password\", \"qwerty\"]\nuser_password = input(\"Create password: \")\n\nif user_password in weak_passwords:\n    print(\"Please choose a stronger password!\")\n```\n\n### Menu Selection\n```python\nvalid_options = [\"1\", \"2\", \"3\", \"quit\"]\nuser_choice = input(\"Select option: \")\n\nif user_choice not in valid_options:\n    print(\"Invalid option!\")\n```\n\n## Works with Strings Too\n\n```python\nmessage = \"Hello, World!\"\n\nprint(\"Hello\" in message)    # True\nprint(\"Python\" in message)   # False\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0007-000000000007',
    'd0000000-0000-0000-0000-000000000007',
    '7.7',
    7,
    'Guest List Manager',
    'guest-list-manager',
    'code',
    12,
    40,
    'basic',
    '{
      "instructions": "Create a guest list manager that:\n1. Starts with an initial guest list\n2. Adds two new guests\n3. Checks if \"Charlie\" is on the list\n4. Removes \"Bob\" from the list\n5. Prints the final guest count and list",
      "starterCode": "# Initial guest list\nguests = [\"Alice\", \"Bob\", \"Diana\"]\n\n# Add \"Charlie\" and \"Eve\" to the list\n\n# Check if \"Charlie\" is on the list and print result\n\n# Remove \"Bob\" from the list\n\n# Print final guest count and the list\n",
      "solution": "# Initial guest list\nguests = [\"Alice\", \"Bob\", \"Diana\"]\n\n# Add \"Charlie\" and \"Eve\" to the list\nguests.append(\"Charlie\")\nguests.append(\"Eve\")\n\n# Check if \"Charlie\" is on the list and print result\nif \"Charlie\" in guests:\n    print(\"Charlie is on the guest list!\")\nelse:\n    print(\"Charlie is not on the list.\")\n\n# Remove \"Bob\" from the list\nguests.remove(\"Bob\")\n\n# Print final guest count and the list\nprint(f\"Total guests: {len(guests)}\")\nprint(f\"Guest list: {guests}\")",
      "testCases": [
        {"input": "", "expectedOutput": "Charlie is on the guest list!", "description": "Should confirm Charlie is on list"},
        {"input": "", "expectedOutput": "Total guests: 4", "description": "Should have 4 guests after changes"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0007-000000000008',
    'd0000000-0000-0000-0000-000000000007',
    '7.8',
    8,
    'len, min, max, sum',
    'len-min-max-sum',
    'lesson',
    5,
    10,
    'basic',
    '{"markdown": "# Built-in Functions: len, min, max, sum\n\nPython provides useful functions for working with lists.\n\n## len() - Length\n\nReturns the number of items.\n\n```python\nnumbers = [10, 20, 30, 40, 50]\nprint(len(numbers))     # 5\n\nempty = []\nprint(len(empty))       # 0\n```\n\n## min() and max()\n\nFind the smallest and largest values.\n\n```python\nscores = [85, 92, 78, 96, 88]\n\nprint(min(scores))      # 78\nprint(max(scores))      # 96\n\n# Works with strings too (alphabetical)\nnames = [\"Charlie\", \"Alice\", \"Bob\"]\nprint(min(names))       # Alice\nprint(max(names))       # Charlie\n```\n\n## sum() - Total\n\nAdd up all numbers.\n\n```python\nprices = [19.99, 29.99, 9.99]\nprint(sum(prices))      # 59.97\n\n# Calculate average\nnumbers = [10, 20, 30, 40]\naverage = sum(numbers) / len(numbers)\nprint(average)          # 25.0\n```\n\n## Practical Example\n\n```python\ntest_scores = [85, 92, 78, 96, 88]\n\nprint(f\"Number of tests: {len(test_scores)}\")\nprint(f\"Lowest score: {min(test_scores)}\")\nprint(f\"Highest score: {max(test_scores)}\")\nprint(f\"Total points: {sum(test_scores)}\")\nprint(f\"Average: {sum(test_scores) / len(test_scores):.1f}\")\n```\n\n**Output:**\n```\nNumber of tests: 5\nLowest score: 78\nHighest score: 96\nTotal points: 439\nAverage: 87.8\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0007-000000000009',
    'd0000000-0000-0000-0000-000000000007',
    '7.9',
    9,
    'Slicing Puzzle',
    'slicing-puzzle',
    'interactive',
    8,
    30,
    'basic',
    '{
      "instructions": "Solve each slicing puzzle by predicting the output.",
      "type": "slicing-puzzle",
      "puzzles": [
        {
          "list": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
          "slice": "[2:7]",
          "answer": [2, 3, 4, 5, 6]
        },
        {
          "list": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
          "slice": "[:5]",
          "answer": [0, 1, 2, 3, 4]
        },
        {
          "list": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
          "slice": "[5:]",
          "answer": [5, 6, 7, 8, 9]
        },
        {
          "list": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
          "slice": "[::3]",
          "answer": [0, 3, 6, 9]
        },
        {
          "list": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
          "slice": "[-3:]",
          "answer": [7, 8, 9]
        },
        {
          "list": [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
          "slice": "[::-1]",
          "answer": [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
        }
      ]
    }'::jsonb,
    'slicing-puzzle',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0007-000000000010',
    'd0000000-0000-0000-0000-000000000007',
    '7.10',
    10,
    'Module 7 Checkpoint',
    'module-7-checkpoint',
    'checkpoint',
    12,
    50,
    'basic',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "What is fruits[1] if fruits = [\"apple\", \"banana\", \"cherry\"]?",
          "options": ["apple", "banana", "cherry", "Error"],
          "correct": 1
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "Which method adds an item to the end of a list?",
          "options": ["add()", "append()", "insert()", "extend()"],
          "correct": 1
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "What is the result of [1, 2, 3][1:3]?",
          "options": ["[1, 2]", "[2, 3]", "[1, 2, 3]", "[2]"],
          "correct": 1
        },
        {
          "id": "cp4",
          "type": "true_false",
          "question": "List indices in Python start at 1.",
          "correct": false,
          "explanation": "List indices start at 0 in Python."
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "What does pop() return?",
          "options": [
            "Nothing (None)",
            "The removed item",
            "The new list length",
            "True or False"
          ],
          "correct": 1
        },
        {
          "id": "cp6",
          "type": "mcq",
          "question": "How do you get the last item of a list?",
          "options": [
            "list[last]",
            "list[-1]",
            "list[len(list)]",
            "list.last()"
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

