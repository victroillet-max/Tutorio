-- ============================================
-- Activities for Module 4: Introduction to Python
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0004-000000000001',
    'd0000000-0000-0000-0000-000000000004',
    '4.1',
    1,
    'Why Python?',
    'why-python',
    'lesson',
    5,
    10,
    'free',
    '{"markdown": "# Why Python?\n\nPython is one of the most popular programming languages in the world, and for good reason!\n\n## What Makes Python Special?\n\n### 1. Easy to Read and Write\nPython code looks almost like English. Compare:\n\n**Python:**\n```python\nif age >= 18:\n    print(\"You can vote!\")\n```\n\n**Other languages might look like:**\n```\nif (age >= 18) {\n    System.out.println(\"You can vote!\");\n}\n```\n\n### 2. Versatile\nPython is used for:\n- Web development (Instagram, Spotify)\n- Data science and AI (Netflix recommendations)\n- Automation (repetitive tasks)\n- Game development\n- Scientific computing\n\n### 3. Huge Community\n- Millions of developers worldwide\n- Thousands of free libraries\n- Extensive documentation\n- Active forums for help\n\n### 4. In-Demand Skill\nPython developers are highly sought after in the job market.\n\n## Fun Fact\nPython was named after Monty Python, not the snake!"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0004-000000000002',
    'd0000000-0000-0000-0000-000000000004',
    '4.3',
    2,
    'Hello World!',
    'hello-world',
    'code',
    5,
    20,
    'free',
    '{
      "instructions": "Write your first Python program! Use the print() function to display \"Hello, World!\" on the screen.",
      "starterCode": "# Write your first Python program\nprint()",
      "solution": "print(\"Hello, World!\")",
      "testCases": [
        {
          "input": "",
          "expectedOutput": "Hello, World!",
          "description": "Should print Hello, World!"
        }
      ],
      "hints": [
        "The print() function displays text on the screen",
        "Text must be wrapped in quotes: \"like this\"",
        "Put your text inside the parentheses of print()"
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0004-000000000003',
    'd0000000-0000-0000-0000-000000000004',
    '4.4',
    3,
    'print() Explained',
    'print-explained',
    'lesson',
    6,
    15,
    'free',
    '{"markdown": "# The print() Function\n\nThe `print()` function is your first tool for communicating with users.\n\n## Basic Syntax\n\n```python\nprint(\"Your message here\")\n```\n\n## Key Points\n\n### 1. Quotes are Required for Text\n```python\nprint(\"Hello\")  # Correct\nprint(Hello)    # Error! Python thinks Hello is a variable\n```\n\n### 2. Single or Double Quotes\n```python\nprint(\"Hello\")  # Double quotes\nprint(''Hello'')  # Single quotes - both work!\n```\n\n### 3. Printing Numbers\n```python\nprint(42)       # No quotes needed for numbers\nprint(3.14)     # Works with decimals too\n```\n\n### 4. Printing Multiple Items\n```python\nprint(\"Age:\", 25)           # Separated by comma\nprint(\"Hello\", \"World\")     # Output: Hello World\n```\n\n### 5. Empty Lines\n```python\nprint()  # Prints an empty line\n```\n\n## Common Mistakes\n\n```python\nprint \"Hello\"     # Missing parentheses\nprint(Hello)      # Missing quotes\nprint(\"Hello)     # Mismatched quotes\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0004-000000000004',
    'd0000000-0000-0000-0000-000000000004',
    '4.5',
    4,
    'Print Practice',
    'print-practice',
    'code',
    8,
    25,
    'basic',
    '{
      "instructions": "Practice using print() with different types of content.\n\n1. Print your name\n2. Print your age (as a number)\n3. Print a sentence that includes both text and a number",
      "starterCode": "# Task 1: Print your name\n\n# Task 2: Print your age (just the number)\n\n# Task 3: Print a sentence with text and number\n# Example: \"I am X years old\"",
      "solution": "# Task 1: Print your name\nprint(\"Alex\")\n\n# Task 2: Print your age (just the number)\nprint(25)\n\n# Task 3: Print a sentence with text and number\nprint(\"I am\", 25, \"years old\")",
      "testCases": [
        {
          "input": "",
          "expectedOutput": null,
          "description": "Check all requirements",
          "validation": "ai",
          "aiPrompt": "Verify the student completed all 3 tasks:\n1. First print statement should display a name (any text/string)\n2. Second print statement should display just a number (their age)\n3. Third print statement should combine text AND a number together in a sentence"
        }
      ],
      "hints": [
        "Use print(\"Your Name\") for text",
        "Use print(25) for numbers without quotes",
        "Use commas to separate items: print(\"text\", number)"
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0004-000000000005',
    'd0000000-0000-0000-0000-000000000004',
    '4.6',
    5,
    'Code Reading Quiz',
    'code-reading-quiz',
    'quiz',
    5,
    15,
    'free',
    '{
      "questions": [
        {
          "id": "q1",
          "type": "mcq",
          "question": "What will this code output?\n\nprint(\"Hello\")\nprint(\"World\")",
          "options": [
            "HelloWorld",
            "Hello World",
            "Hello\nWorld",
            "Error"
          ],
          "correct": 2,
          "explanation": "Each print() statement outputs on a new line by default."
        },
        {
          "id": "q2",
          "type": "mcq",
          "question": "Which line will cause an error?",
          "options": [
            "print(\"42\")",
            "print(42)",
            "print(Hello)",
            "print(\"Hello\", \"World\")"
          ],
          "correct": 2,
          "explanation": "print(Hello) will cause an error because Hello without quotes is treated as an undefined variable."
        },
        {
          "id": "q3",
          "type": "mcq",
          "question": "What will print(\"Age:\", 25) output?",
          "options": [
            "Age:25",
            "Age: 25",
            "\"Age:\", 25",
            "Error"
          ],
          "correct": 1,
          "explanation": "When using commas in print(), Python automatically adds a space between items."
        }
      ],
      "passing_score": 70
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0004-000000000006',
    'd0000000-0000-0000-0000-000000000004',
    '4.7',
    6,
    'Python Building Blocks',
    'python-building-blocks',
    'lesson',
    8,
    15,
    'free',
    '{"markdown": "# Python Building Blocks\n\nBefore diving deeper, let''s understand the fundamental elements of Python code.\n\n## 1. Statements\nA statement is a single instruction that Python executes.\n\n```python\nprint(\"Hello\")  # This is one statement\nx = 5           # This is another statement\n```\n\n## 2. Expressions\nAn expression is anything that produces a value.\n\n```python\n5 + 3           # Expression that equals 8\n\"Hello\"         # Expression that equals \"Hello\"\nlen(\"Python\")   # Expression that equals 6\n```\n\n## 3. Keywords\nReserved words with special meaning in Python.\n\n```python\nif, else, for, while, def, return, True, False, None, and, or, not\n```\n\n## 4. Identifiers (Names)\nNames you give to variables, functions, etc.\n\n**Rules:**\n- Can contain letters, numbers, underscores\n- Cannot start with a number\n- Cannot be a keyword\n- Case-sensitive (age ≠ Age)\n\n```python\nmy_name = \"Alex\"    # Valid\n_private = 42       # Valid\n2fast = \"error\"     # Invalid - starts with number\n```\n\n## 5. Indentation\nPython uses indentation (spaces) to define code blocks.\n\n```python\nif True:\n    print(\"Indented\")  # 4 spaces\n    print(\"Also indented\")\nprint(\"Not indented\")\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0004-000000000007',
    'd0000000-0000-0000-0000-000000000004',
    '4.8',
    7,
    'Comments & Style',
    'comments-and-style',
    'lesson',
    5,
    10,
    'free',
    '{"markdown": "# Comments & Code Style\n\n## Comments\nComments are notes for humans - Python ignores them.\n\n### Single-line Comments\n```python\n# This is a comment\nprint(\"Hello\")  # This is also a comment\n```\n\n### Multi-line Comments\n```python\n\"\"\"\nThis is a multi-line comment.\nIt can span several lines.\nUseful for longer explanations.\n\"\"\"\n```\n\n## Why Comment Your Code?\n\n1. **Explain complex logic**\n2. **Leave notes for yourself**\n3. **Help others understand your code**\n4. **Temporarily disable code**\n\n## Python Style Guide (PEP 8)\n\n### Naming Conventions\n```python\n# Variables and functions: snake_case\nuser_name = \"Alex\"\ndef calculate_total():\n    pass\n\n# Constants: UPPER_CASE\nMAX_SIZE = 100\n```\n\n### Spacing\n```python\n# Good\nx = 5\ny = x + 10\n\n# Avoid\nx=5\ny=x +10\n```\n\n### Line Length\nKeep lines under 79 characters for readability.\n\n## Pro Tip\nWrite comments that explain *why*, not *what*.\n\n```python\n# Bad: Add 1 to x\nx = x + 1\n\n# Good: Account for zero-based indexing\nx = x + 1\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0004-000000000008',
    'd0000000-0000-0000-0000-000000000004',
    '4.9',
    8,
    'First Coding Challenge',
    'first-coding-challenge',
    'code',
    10,
    35,
    'basic',
    '{
      "instructions": "Create a program that displays your personal profile:\n\n1. Print a greeting line\n2. Print your name\n3. Print your favorite hobby\n4. Print why you want to learn Python\n\nMake it look nice with proper formatting!",
      "starterCode": "# My Personal Profile\n# -------------------\n\n# Greeting\n\n# Your name\n\n# Your favorite hobby\n\n# Why you want to learn Python\n",
      "solution": "# My Personal Profile\n# -------------------\n\n# Greeting\nprint(\"Welcome to my profile!\")\nprint()\n\n# Your name\nprint(\"Name: Alex Johnson\")\n\n# Your favorite hobby\nprint(\"Hobby: Playing guitar\")\n\n# Why you want to learn Python\nprint(\"Goal: I want to build cool apps and automate tasks!\")",
      "testCases": [
        {
          "input": "",
          "expectedOutput": null,
          "description": "Should have at least 4 print statements",
          "validation": "print_count >= 4"
        }
      ],
      "hints": [
        "Use print() without arguments for empty lines",
        "You can use print(\"Label:\", \"Value\") format",
        "Add comments to organize your code"
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0004-000000000009',
    'd0000000-0000-0000-0000-000000000004',
    '4.10',
    9,
    'Module 4 Checkpoint',
    'module-4-checkpoint',
    'checkpoint',
    12,
    40,
    'free',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "Why is Python considered easy to learn?",
          "options": [
            "It only works on Windows",
            "Its syntax is similar to English",
            "It has no rules",
            "It is the oldest language"
          ],
          "correct": 1
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "What does print(\"5\" + \"3\") output?",
          "options": [
            "8",
            "53",
            "5 + 3",
            "Error"
          ],
          "correct": 1,
          "explanation": "When you use + with strings, Python concatenates them. \"5\" + \"3\" = \"53\""
        },
        {
          "id": "cp3",
          "type": "true_false",
          "question": "In Python, variable names can start with a number.",
          "correct": false,
          "explanation": "Variable names must start with a letter or underscore, not a number."
        },
        {
          "id": "cp4",
          "type": "mcq",
          "question": "Which is a valid comment in Python?",
          "options": [
            "// This is a comment",
            "/* This is a comment */",
            "# This is a comment",
            "-- This is a comment"
          ],
          "correct": 2
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "What will happen if you run: print(Hello)?",
          "options": [
            "It prints Hello",
            "It prints \"Hello\"",
            "Error - Hello is not defined",
            "It prints nothing"
          ],
          "correct": 2
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

