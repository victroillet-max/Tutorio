-- ============================================
-- Activities for Module 9: Loops - For & While
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0009-000000000001',
    'd0000000-0000-0000-0000-000000000009',
    '9.1',
    1,
    'While Loops Intro',
    'while-loops-intro',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# While Loops Introduction\n\nA while loop repeats code as long as a condition is true.\n\n## Basic Syntax\n\n```python\nwhile condition:\n    # Code to repeat\n    # Must eventually make condition False!\n```\n\n## Simple Example\n\n```python\ncount = 0\n\nwhile count < 5:\n    print(count)\n    count += 1\n\n# Output: 0, 1, 2, 3, 4\n```\n\n## How It Works\n\n1. Check the condition\n2. If True, run the code block\n3. Go back to step 1\n4. If False, exit the loop\n\n## Important: Avoid Infinite Loops!\n\n```python\n# DANGER: This will run forever!\nwhile True:\n    print(\"Help!\")\n\n# Always ensure the condition can become False\ncount = 0\nwhile count < 5:\n    print(count)\n    # count += 1  # Forgot this! Infinite loop!\n```\n\n## Common Use Cases\n\n### User Input Validation\n```python\npassword = \"\"\nwhile password != \"secret\":\n    password = input(\"Enter password: \")\nprint(\"Access granted!\")\n```\n\n### Counting Down\n```python\ncountdown = 5\nwhile countdown > 0:\n    print(countdown)\n    countdown -= 1\nprint(\"Liftoff!\")\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000002',
    'd0000000-0000-0000-0000-000000000009',
    '9.2',
    2,
    'While Loop Visualizer',
    'while-loop-visualizer',
    'interactive',
    8,
    30,
    'basic',
    '{
      "instructions": "Step through while loops to see how variables change each iteration.",
      "type": "loop-visualizer",
      "loopType": "while",
      "examples": [
        {
          "code": "count = 0\nwhile count < 3:\n    print(count)\n    count += 1",
          "iterations": [
            {"variables": {"count": 0}, "output": "0"},
            {"variables": {"count": 1}, "output": "1"},
            {"variables": {"count": 2}, "output": "2"},
            {"variables": {"count": 3}, "output": null, "note": "Loop ends: count < 3 is False"}
          ]
        },
        {
          "code": "total = 0\nn = 5\nwhile n > 0:\n    total += n\n    n -= 1\nprint(total)",
          "iterations": [
            {"variables": {"total": 0, "n": 5}},
            {"variables": {"total": 5, "n": 4}},
            {"variables": {"total": 9, "n": 3}},
            {"variables": {"total": 12, "n": 2}},
            {"variables": {"total": 14, "n": 1}},
            {"variables": {"total": 15, "n": 0}, "output": "15"}
          ]
        }
      ]
    }'::jsonb,
    'loop-visualizer',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000003',
    'd0000000-0000-0000-0000-000000000009',
    '9.3',
    3,
    'While Practice',
    'while-practice',
    'code',
    8,
    25,
    'basic',
    '{
      "instructions": "Write a while loop that:\n1. Starts with a number (n = 10)\n2. Prints each number while it''s greater than 0\n3. Decrements by 2 each iteration\n4. Prints \"Done!\" at the end",
      "starterCode": "n = 10\n\n# Write your while loop here\n\nprint(\"Done!\")",
      "solution": "n = 10\n\n# Write your while loop here\nwhile n > 0:\n    print(n)\n    n -= 2\n\nprint(\"Done!\")",
      "testCases": [
        {"input": "", "expectedOutput": "10\n8\n6\n4\n2\nDone!", "description": "Should count down by 2s"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000004',
    'd0000000-0000-0000-0000-000000000009',
    '9.4',
    4,
    'For Loops Intro',
    'for-loops-intro',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# For Loops Introduction\n\nA for loop iterates over a sequence (list, string, range, etc.).\n\n## Basic Syntax\n\n```python\nfor item in sequence:\n    # Do something with item\n```\n\n## Looping Through Lists\n\n```python\nfruits = [\"apple\", \"banana\", \"cherry\"]\n\nfor fruit in fruits:\n    print(fruit)\n\n# Output:\n# apple\n# banana\n# cherry\n```\n\n## Looping Through Strings\n\n```python\nfor char in \"Hello\":\n    print(char)\n\n# Output: H, e, l, l, o (each on new line)\n```\n\n## For vs While\n\n| For Loop | While Loop |\n|----------|------------|\n| Known iterations | Unknown iterations |\n| Iterate over sequence | Repeat while condition |\n| Less error-prone | Can cause infinite loops |\n\n## Examples\n\n### Calculate Sum\n```python\nnumbers = [10, 20, 30, 40]\ntotal = 0\n\nfor num in numbers:\n    total += num\n\nprint(total)  # 100\n```\n\n### Find Maximum\n```python\nscores = [85, 92, 78, 96, 88]\nmax_score = scores[0]\n\nfor score in scores:\n    if score > max_score:\n        max_score = score\n\nprint(max_score)  # 96\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000005',
    'd0000000-0000-0000-0000-000000000009',
    '9.5',
    5,
    'range() Function',
    'range-function',
    'lesson',
    5,
    10,
    'basic',
    '{"markdown": "# The range() Function\n\nGenerate sequences of numbers for loops.\n\n## Basic Usage\n\n```python\n# range(stop) - 0 to stop-1\nfor i in range(5):\n    print(i)  # 0, 1, 2, 3, 4\n\n# range(start, stop) - start to stop-1\nfor i in range(2, 6):\n    print(i)  # 2, 3, 4, 5\n\n# range(start, stop, step)\nfor i in range(0, 10, 2):\n    print(i)  # 0, 2, 4, 6, 8\n```\n\n## Counting Backwards\n\n```python\nfor i in range(5, 0, -1):\n    print(i)  # 5, 4, 3, 2, 1\n```\n\n## Common Patterns\n\n### Repeat N Times\n```python\nfor _ in range(3):  # _ means we don''t need the variable\n    print(\"Hello!\")\n```\n\n### Index-Based Loop\n```python\nfruits = [\"apple\", \"banana\", \"cherry\"]\n\nfor i in range(len(fruits)):\n    print(f\"{i}: {fruits[i]}\")\n\n# 0: apple\n# 1: banana\n# 2: cherry\n```\n\n### Generate List from Range\n```python\nnumbers = list(range(5))      # [0, 1, 2, 3, 4]\nevens = list(range(0, 10, 2)) # [0, 2, 4, 6, 8]\n```\n\n## Memory Efficiency\n\nrange() doesn''t create all numbers at once - it generates them as needed!"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000006',
    'd0000000-0000-0000-0000-000000000009',
    '9.6',
    6,
    'For Loop Visualizer',
    'for-loop-visualizer',
    'interactive',
    8,
    30,
    'basic',
    '{
      "instructions": "Step through for loops to understand how iteration works.",
      "type": "loop-visualizer",
      "loopType": "for",
      "examples": [
        {
          "code": "for i in range(4):\n    print(i * 2)",
          "iterations": [
            {"variables": {"i": 0}, "output": "0"},
            {"variables": {"i": 1}, "output": "2"},
            {"variables": {"i": 2}, "output": "4"},
            {"variables": {"i": 3}, "output": "6"}
          ]
        },
        {
          "code": "fruits = [\"a\", \"b\", \"c\"]\nfor fruit in fruits:\n    print(fruit.upper())",
          "iterations": [
            {"variables": {"fruit": "a"}, "output": "A"},
            {"variables": {"fruit": "b"}, "output": "B"},
            {"variables": {"fruit": "c"}, "output": "C"}
          ]
        }
      ]
    }'::jsonb,
    'loop-visualizer',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000007',
    'd0000000-0000-0000-0000-000000000009',
    '9.7',
    7,
    'For Practice',
    'for-practice',
    'code',
    10,
    30,
    'basic',
    '{
      "instructions": "Write a program that:\n1. Creates a list of 5 numbers\n2. Uses a for loop to calculate the sum\n3. Uses a for loop to find the average\n4. Prints both results",
      "starterCode": "numbers = [10, 20, 30, 40, 50]\n\n# Calculate sum using a for loop\ntotal = 0\n\n# Calculate average\n\n# Print results\n",
      "solution": "numbers = [10, 20, 30, 40, 50]\n\n# Calculate sum using a for loop\ntotal = 0\nfor num in numbers:\n    total += num\n\n# Calculate average\naverage = total / len(numbers)\n\n# Print results\nprint(f\"Sum: {total}\")\nprint(f\"Average: {average}\")",
      "testCases": [
        {"input": "", "expectedOutput": "Sum: 150", "description": "Sum should be 150"},
        {"input": "", "expectedOutput": "Average: 30.0", "description": "Average should be 30.0"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000008',
    'd0000000-0000-0000-0000-000000000009',
    '9.8',
    8,
    'break & continue',
    'break-and-continue',
    'lesson',
    6,
    15,
    'basic',
    '{"markdown": "# break & continue\n\nControl loop execution with these statements.\n\n## break - Exit Loop Immediately\n\n```python\nfor i in range(10):\n    if i == 5:\n        break\n    print(i)\n\n# Output: 0, 1, 2, 3, 4\n# Loop stops when i equals 5\n```\n\n## continue - Skip Current Iteration\n\n```python\nfor i in range(5):\n    if i == 2:\n        continue\n    print(i)\n\n# Output: 0, 1, 3, 4\n# Skips printing when i equals 2\n```\n\n## Practical Examples\n\n### Find First Match (break)\n```python\nnumbers = [3, 7, 2, 8, 5, 9]\n\nfor num in numbers:\n    if num > 5:\n        print(f\"Found: {num}\")\n        break\n\n# Output: Found: 7\n```\n\n### Skip Invalid Data (continue)\n```python\nscores = [85, -1, 92, 78, -1, 96]\n\ntotal = 0\ncount = 0\n\nfor score in scores:\n    if score < 0:  # Skip invalid scores\n        continue\n    total += score\n    count += 1\n\nprint(f\"Average: {total / count}\")\n```\n\n### While Loop with break\n```python\nwhile True:\n    command = input(\"Enter command (q to quit): \")\n    if command == \"q\":\n        break\n    print(f\"Processing: {command}\")\n```\n\n## break vs return\n\n- `break` exits the loop\n- `return` exits the entire function"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000009',
    'd0000000-0000-0000-0000-000000000009',
    '9.9',
    9,
    'Password Checker',
    'password-checker',
    'code',
    12,
    45,
    'basic',
    '{
      "instructions": "Create a password validation loop that:\n1. Asks user for password (max 3 attempts)\n2. Checks if password is \"secret123\"\n3. Uses break when correct password entered\n4. Prints appropriate messages for success/failure",
      "starterCode": "correct_password = \"secret123\"\nmax_attempts = 3\nattempts = 0\n\n# Write your loop here\n",
      "solution": "correct_password = \"secret123\"\nmax_attempts = 3\nattempts = 0\n\nwhile attempts < max_attempts:\n    password = input(\"Enter password: \")\n    attempts += 1\n    \n    if password == correct_password:\n        print(\"Access granted!\")\n        break\n    else:\n        remaining = max_attempts - attempts\n        if remaining > 0:\n            print(f\"Wrong password. {remaining} attempts remaining.\")\nelse:\n    print(\"Account locked. Too many failed attempts.\")",
      "testCases": [
        {"input": "secret123", "expectedOutput": "Access granted!", "description": "Correct password grants access"},
        {"input": "wrong\\nwrong\\nwrong", "expectedOutput": "Account locked", "description": "3 wrong attempts locks account"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000010',
    'd0000000-0000-0000-0000-000000000009',
    '9.10',
    10,
    'enumerate()',
    'enumerate-function',
    'lesson',
    5,
    10,
    'basic',
    '{"markdown": "# The enumerate() Function\n\nGet both index and value while looping.\n\n## The Problem\n\n```python\nfruits = [\"apple\", \"banana\", \"cherry\"]\n\n# Awkward way to get index:\nfor i in range(len(fruits)):\n    print(f\"{i}: {fruits[i]}\")\n```\n\n## The Solution: enumerate()\n\n```python\nfruits = [\"apple\", \"banana\", \"cherry\"]\n\nfor index, fruit in fruits:  # Wrong!\nfor index, fruit in enumerate(fruits):  # Right!\n    print(f\"{index}: {fruit}\")\n\n# Output:\n# 0: apple\n# 1: banana\n# 2: cherry\n```\n\n## Custom Start Index\n\n```python\nfor index, fruit in enumerate(fruits, start=1):\n    print(f\"{index}: {fruit}\")\n\n# Output:\n# 1: apple\n# 2: banana\n# 3: cherry\n```\n\n## Practical Examples\n\n### Numbered Menu\n```python\noptions = [\"New Game\", \"Load Game\", \"Settings\", \"Quit\"]\n\nprint(\"Main Menu:\")\nfor i, option in enumerate(options, 1):\n    print(f\"  {i}. {option}\")\n```\n\n### Find Index of Value\n```python\nscores = [85, 92, 78, 96, 88]\n\nfor i, score in enumerate(scores):\n    if score > 90:\n        print(f\"High score at position {i}: {score}\")\n```\n\n### Process with Position\n```python\nwords = [\"Hello\", \"World\", \"Python\"]\n\nfor i, word in enumerate(words):\n    if i == 0:\n        print(word.upper())  # First word uppercase\n    else:\n        print(word.lower())\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000011',
    'd0000000-0000-0000-0000-000000000009',
    '9.11',
    11,
    'Nested Loops',
    'nested-loops',
    'lesson',
    6,
    15,
    'basic',
    '{"markdown": "# Nested Loops\n\nLoops inside loops for multi-dimensional iteration.\n\n## Basic Concept\n\n```python\nfor outer in range(3):\n    for inner in range(3):\n        print(f\"({outer}, {inner})\", end=\" \")\n    print()  # New line after inner loop\n\n# Output:\n# (0, 0) (0, 1) (0, 2)\n# (1, 0) (1, 1) (1, 2)\n# (2, 0) (2, 1) (2, 2)\n```\n\n## How It Works\n\n1. Outer loop starts first iteration\n2. Inner loop runs completely\n3. Outer loop moves to next iteration\n4. Inner loop runs completely again\n5. Repeat until outer loop finishes\n\n## Practical Examples\n\n### Multiplication Table\n```python\nfor i in range(1, 4):\n    for j in range(1, 4):\n        print(f\"{i} x {j} = {i*j}\")\n    print()  # Separator between groups\n```\n\n### 2D List (Matrix)\n```python\nmatrix = [\n    [1, 2, 3],\n    [4, 5, 6],\n    [7, 8, 9]\n]\n\nfor row in matrix:\n    for cell in row:\n        print(cell, end=\" \")\n    print()\n```\n\n### Finding Pairs\n```python\nnumbers = [1, 2, 3]\n\nfor i in range(len(numbers)):\n    for j in range(i + 1, len(numbers)):\n        print(f\"Pair: ({numbers[i]}, {numbers[j]})\")\n\n# Pair: (1, 2)\n# Pair: (1, 3)\n# Pair: (2, 3)\n```\n\n## Warning: Performance\n\nNested loops multiply iterations:\n- Outer loop 100 times\n- Inner loop 100 times\n- Total: 10,000 iterations!"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000012',
    'd0000000-0000-0000-0000-000000000009',
    '9.12',
    12,
    'Pattern Printing',
    'pattern-printing',
    'code',
    10,
    40,
    'basic',
    '{
      "instructions": "Use nested loops to print this pattern:\n*\n**\n***\n****\n*****\n\nThen print an inverted version:\n*****\n****\n***\n**\n*",
      "starterCode": "# Pattern 1: Growing triangle\nprint(\"Pattern 1:\")\n\n# Pattern 2: Shrinking triangle\nprint(\"\\nPattern 2:\")\n",
      "solution": "# Pattern 1: Growing triangle\nprint(\"Pattern 1:\")\nfor i in range(1, 6):\n    for j in range(i):\n        print(\"*\", end=\"\")\n    print()\n\n# Pattern 2: Shrinking triangle\nprint(\"\\nPattern 2:\")\nfor i in range(5, 0, -1):\n    for j in range(i):\n        print(\"*\", end=\"\")\n    print()",
      "testCases": [
        {"input": "", "expectedOutput": "*\n**\n***\n****\n*****", "description": "Growing triangle pattern"},
        {"input": "", "expectedOutput": "*****\n****\n***\n**\n*", "description": "Shrinking triangle pattern"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0009-000000000013',
    'd0000000-0000-0000-0000-000000000009',
    '9.13',
    13,
    'Module 9 Checkpoint',
    'module-9-checkpoint',
    'checkpoint',
    15,
    60,
    'basic',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "How many times does this loop run?\nfor i in range(5):\n    print(i)",
          "options": ["4", "5", "6", "Infinite"],
          "correct": 1
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "What is the output of range(2, 8, 2)?",
          "options": [
            "[2, 4, 6, 8]",
            "[2, 4, 6]",
            "[2, 3, 4, 5, 6, 7]",
            "[8, 6, 4, 2]"
          ],
          "correct": 1,
          "explanation": "range(2, 8, 2) gives 2, 4, 6 - it stops before 8."
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "What does break do in a loop?",
          "options": [
            "Skips to next iteration",
            "Exits the loop immediately",
            "Pauses the loop",
            "Restarts the loop"
          ],
          "correct": 1
        },
        {
          "id": "cp4",
          "type": "mcq",
          "question": "What does continue do?",
          "options": [
            "Exits the loop",
            "Skips remaining code and goes to next iteration",
            "Continues to the next loop",
            "Continues running forever"
          ],
          "correct": 1
        },
        {
          "id": "cp5",
          "type": "true_false",
          "question": "enumerate() returns both index and value during iteration.",
          "correct": true
        },
        {
          "id": "cp6",
          "type": "mcq",
          "question": "Which loop type is better when you know the exact number of iterations?",
          "options": ["while", "for", "Both are equal", "Neither"],
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

