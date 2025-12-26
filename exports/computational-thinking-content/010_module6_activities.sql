-- ============================================
-- Activities for Module 6: Conditionals & Boolean Logic
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0006-000000000001',
    'd0000000-0000-0000-0000-000000000006',
    '6.1',
    1,
    'Booleans: True & False',
    'booleans-true-false',
    'lesson',
    6,
    15,
    'free',
    '{"markdown": "# Booleans: True & False\n\nBooleans are the simplest data type - they can only be one of two values.\n\n## The Two Boolean Values\n\n```python\nis_active = True\nis_deleted = False\n```\n\n**Important:** True and False are capitalized in Python!\n\n## Booleans in Real Life\n\n- Is the door open? True/False\n- Is the user logged in? True/False\n- Is the file saved? True/False\n- Is the light on? True/False\n\n## Creating Booleans\n\n### Direct Assignment\n```python\nhas_permission = True\nis_complete = False\n```\n\n### From Comparisons\n```python\nx = 10\ny = 5\n\nresult = x > y      # True\nresult = x == y     # False\nresult = x != y     # True\n```\n\n### From Functions\n```python\ntext = \"Hello\"\nresult = text.startswith(\"H\")  # True\nresult = text.isdigit()         # False\n```\n\n## Boolean Context\n\nPython can interpret other values as booleans:\n\n```python\n# These are \"falsy\" (treated as False)\nbool(0)       # False\nbool(\"\")      # False\nbool(None)    # False\nbool([])      # False\n\n# These are \"truthy\" (treated as True)\nbool(1)       # True\nbool(\"text\")  # True\nbool([1,2,3]) # True\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000002',
    'd0000000-0000-0000-0000-000000000006',
    '6.2',
    2,
    'Comparison Operators',
    'comparison-operators',
    'lesson',
    7,
    15,
    'free',
    '{"markdown": "# Comparison Operators\n\nComparison operators compare two values and return a boolean.\n\n## The Operators\n\n| Operator | Meaning | Example | Result |\n|----------|---------|---------|--------|\n| == | Equal to | 5 == 5 | True |\n| != | Not equal to | 5 != 3 | True |\n| > | Greater than | 5 > 3 | True |\n| < | Less than | 5 < 3 | False |\n| >= | Greater or equal | 5 >= 5 | True |\n| <= | Less or equal | 5 <= 3 | False |\n\n## Common Mistake: = vs ==\n\n```python\nx = 5      # Assignment (sets x to 5)\nx == 5     # Comparison (checks if x equals 5)\n```\n\n## Comparing Strings\n\n```python\n\"apple\" == \"apple\"    # True\n\"Apple\" == \"apple\"    # False (case-sensitive!)\n\"apple\" < \"banana\"    # True (alphabetical order)\n\"a\" < \"b\"             # True\n```\n\n## Chaining Comparisons\n\nPython allows elegant chaining:\n\n```python\nage = 25\n\n# Traditional way\nage >= 18 and age <= 65    # True\n\n# Pythonic way\n18 <= age <= 65            # True\n```\n\n## Examples\n\n```python\nscore = 85\npassing = 70\n\npassed = score >= passing    # True\nperfect = score == 100       # False\nfailed = score < passing     # False\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000003',
    'd0000000-0000-0000-0000-000000000006',
    '6.3',
    3,
    'Comparison Practice',
    'comparison-practice',
    'code',
    6,
    25,
    'basic',
    '{
      "instructions": "Given the variables below, write comparison expressions to check:\n1. Is the temperature above freezing (0 degrees)?\n2. Is the score a passing grade (>= 60)?\n3. Is the age exactly 18?\n4. Is the price different from 100?",
      "starterCode": "temperature = 15\nscore = 75\nage = 18\nprice = 99.99\n\n# Check if temperature is above freezing\nabove_freezing = \n\n# Check if score is passing (>= 60)\nis_passing = \n\n# Check if age is exactly 18\nis_eighteen = \n\n# Check if price is different from 100\nnot_hundred = \n\n# Print all results\nprint(f\"Above freezing: {above_freezing}\")\nprint(f\"Is passing: {is_passing}\")\nprint(f\"Is eighteen: {is_eighteen}\")\nprint(f\"Not hundred: {not_hundred}\")",
      "solution": "temperature = 15\nscore = 75\nage = 18\nprice = 99.99\n\n# Check if temperature is above freezing\nabove_freezing = temperature > 0\n\n# Check if score is passing (>= 60)\nis_passing = score >= 60\n\n# Check if age is exactly 18\nis_eighteen = age == 18\n\n# Check if price is different from 100\nnot_hundred = price != 100\n\n# Print all results\nprint(f\"Above freezing: {above_freezing}\")\nprint(f\"Is passing: {is_passing}\")\nprint(f\"Is eighteen: {is_eighteen}\")\nprint(f\"Not hundred: {not_hundred}\")",
      "testCases": [
        {"input": "", "expectedOutput": "Above freezing: True", "description": "Temperature check"},
        {"input": "", "expectedOutput": "Is passing: True", "description": "Score check"},
        {"input": "", "expectedOutput": "Is eighteen: True", "description": "Age check"},
        {"input": "", "expectedOutput": "Not hundred: True", "description": "Price check"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000004',
    'd0000000-0000-0000-0000-000000000006',
    '6.4',
    4,
    'Logical Operators',
    'logical-operators',
    'lesson',
    7,
    15,
    'free',
    '{"markdown": "# Logical Operators\n\nLogical operators combine or modify boolean values.\n\n## The Three Operators\n\n### and - Both Must Be True\n```python\nTrue and True     # True\nTrue and False    # False\nFalse and True    # False\nFalse and False   # False\n```\n\n### or - At Least One Must Be True\n```python\nTrue or True      # True\nTrue or False     # True\nFalse or True     # True\nFalse or False    # False\n```\n\n### not - Reverses the Value\n```python\nnot True          # False\nnot False         # True\n```\n\n## Practical Examples\n\n```python\nage = 25\nhas_license = True\n\n# Can they rent a car? (must be 21+ AND have license)\ncan_rent = age >= 21 and has_license    # True\n\n# Can they get a discount? (senior 65+ OR student)\nis_senior = age >= 65\nis_student = False\ngets_discount = is_senior or is_student  # False\n\n# Is the museum closed? (opposite of open)\nis_open = True\nis_closed = not is_open                   # False\n```\n\n## Operator Precedence\n\n1. `not` (highest priority)\n2. `and`\n3. `or` (lowest priority)\n\n```python\n# This:\nTrue or False and False\n# Is evaluated as:\nTrue or (False and False)   # True\n\n# Use parentheses for clarity!\n(True or False) and False   # False\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000005',
    'd0000000-0000-0000-0000-000000000006',
    '6.5',
    5,
    'Truth Table Game',
    'truth-table-game',
    'interactive',
    8,
    30,
    'basic',
    '{
      "instructions": "Evaluate each logical expression and select the correct result.",
      "type": "truth-table",
      "challenges": [
        {"expression": "True and True", "answer": true},
        {"expression": "True and False", "answer": false},
        {"expression": "True or False", "answer": true},
        {"expression": "False or False", "answer": false},
        {"expression": "not True", "answer": false},
        {"expression": "not False", "answer": true},
        {"expression": "True and not False", "answer": true},
        {"expression": "(True or False) and False", "answer": false},
        {"expression": "True or (False and False)", "answer": true},
        {"expression": "not (True and False)", "answer": true}
      ]
    }'::jsonb,
    'truth-table',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000006',
    'd0000000-0000-0000-0000-000000000006',
    '6.6',
    6,
    'if Statements',
    'if-statements',
    'lesson',
    8,
    20,
    'free',
    '{"markdown": "# if Statements\n\nThe `if` statement lets your program make decisions.\n\n## Basic Syntax\n\n```python\nif condition:\n    # Code to run if condition is True\n    print(\"Condition was true!\")\n```\n\n**Important:** The indented code only runs if the condition is True.\n\n## Simple Examples\n\n```python\ntemperature = 35\n\nif temperature > 30:\n    print(\"It''s hot outside!\")\n\nif temperature < 0:\n    print(\"It''s freezing!\")\n```\n\n## Multiple Statements\n\n```python\nscore = 95\n\nif score >= 90:\n    print(\"Excellent work!\")\n    print(\"You got an A!\")\n    print(\"Keep it up!\")\n```\n\n## With Variables\n\n```python\nage = 20\nis_member = True\n\nif age >= 18:\n    print(\"You are an adult.\")\n\nif is_member:\n    print(\"Welcome back, member!\")\n```\n\n## Common Patterns\n\n```python\nuser_input = input(\"Enter password: \")\n\nif user_input == \"secret123\":\n    print(\"Access granted!\")\n\nif len(user_input) < 8:\n    print(\"Warning: Password is too short.\")\n```\n\n## Remember\n\n1. Condition must be a boolean (or evaluate to one)\n2. Colon `:` after the condition\n3. Indented code block (4 spaces)"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000007',
    'd0000000-0000-0000-0000-000000000006',
    '6.7',
    7,
    'elif & else',
    'elif-and-else',
    'lesson',
    7,
    15,
    'free',
    '{"markdown": "# elif & else\n\nHandle multiple conditions and fallback cases.\n\n## if-else\n\n```python\nage = 15\n\nif age >= 18:\n    print(\"You can vote.\")\nelse:\n    print(\"You cannot vote yet.\")\n```\n\n## if-elif-else\n\n```python\nscore = 85\n\nif score >= 90:\n    grade = \"A\"\nelif score >= 80:\n    grade = \"B\"\nelif score >= 70:\n    grade = \"C\"\nelif score >= 60:\n    grade = \"D\"\nelse:\n    grade = \"F\"\n\nprint(f\"Your grade: {grade}\")  # Your grade: B\n```\n\n## How It Works\n\n1. Python checks conditions from top to bottom\n2. First true condition''s code block runs\n3. Remaining conditions are skipped\n4. `else` runs only if NO conditions were true\n\n## Multiple elif\n\n```python\nday = \"Saturday\"\n\nif day == \"Monday\":\n    print(\"Start of work week\")\nelif day == \"Wednesday\":\n    print(\"Midweek\")\nelif day == \"Friday\":\n    print(\"TGIF!\")\nelif day in [\"Saturday\", \"Sunday\"]:\n    print(\"Weekend!\")\nelse:\n    print(\"Regular day\")\n```\n\n## else is Optional\n\n```python\n# This is fine - no else needed\ntemperature = 25\n\nif temperature > 30:\n    print(\"Turn on AC\")\nelif temperature < 10:\n    print(\"Turn on heater\")\n# If neither, nothing happens\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000008',
    'd0000000-0000-0000-0000-000000000006',
    '6.8',
    8,
    'Decision Tree Builder',
    'decision-tree-builder',
    'interactive',
    10,
    35,
    'basic',
    '{
      "instructions": "Build a decision tree that determines what activity to suggest based on weather conditions.",
      "type": "decision-tree",
      "scenario": "Activity Suggester",
      "inputs": ["is_raining", "temperature", "is_weekend"],
      "expectedNodes": [
        {"condition": "is_raining", "true": "Indoor activity", "false": "check_temperature"},
        {"condition": "temperature > 25", "true": "Go swimming", "false": "check_weekend"},
        {"condition": "is_weekend", "true": "Go hiking", "false": "Take a walk"}
      ]
    }'::jsonb,
    'decision-tree',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000009',
    'd0000000-0000-0000-0000-000000000006',
    '6.9',
    9,
    'Booking Checker Challenge',
    'booking-checker-challenge',
    'code',
    12,
    40,
    'basic',
    '{
      "instructions": "Create a hotel room booking checker that:\n1. Takes the number of guests and their age\n2. Checks if booking is valid (max 4 guests)\n3. Determines room type (single: 1, double: 2, family: 3-4)\n4. Applies discount if guest is senior (65+) or child (under 12)",
      "starterCode": "# Hotel Booking Checker\nguests = 3\nage = 70\n\n# Check if booking is valid (max 4 guests)\n\n# Determine room type\n\n# Check for discount eligibility\n\n# Print booking summary\n",
      "solution": "# Hotel Booking Checker\nguests = 3\nage = 70\n\n# Check if booking is valid (max 4 guests)\nif guests > 4:\n    print(\"Sorry, maximum 4 guests per booking.\")\nelse:\n    # Determine room type\n    if guests == 1:\n        room_type = \"Single Room\"\n    elif guests == 2:\n        room_type = \"Double Room\"\n    else:\n        room_type = \"Family Room\"\n    \n    # Check for discount eligibility\n    if age >= 65:\n        discount = \"Senior discount applied!\"\n    elif age < 12:\n        discount = \"Child discount applied!\"\n    else:\n        discount = \"No discount\"\n    \n    # Print booking summary\n    print(f\"Room Type: {room_type}\")\n    print(f\"Guests: {guests}\")\n    print(f\"Discount: {discount}\")",
      "testCases": [
        {"input": "", "expectedOutput": "Room Type: Family Room", "description": "Should assign family room for 3 guests"},
        {"input": "", "expectedOutput": "Senior discount applied!", "description": "Should apply senior discount for age 70"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000010',
    'd0000000-0000-0000-0000-000000000006',
    '6.10',
    10,
    'Nested Conditionals',
    'nested-conditionals',
    'lesson',
    6,
    15,
    'free',
    '{"markdown": "# Nested Conditionals\n\nYou can put if statements inside other if statements.\n\n## Basic Nesting\n\n```python\nage = 25\nhas_ticket = True\n\nif age >= 18:\n    if has_ticket:\n        print(\"Welcome to the concert!\")\n    else:\n        print(\"You need a ticket.\")\nelse:\n    print(\"Must be 18+ to enter.\")\n```\n\n## Multiple Levels\n\n```python\nis_member = True\naccount_age = 5\npurchase_amount = 150\n\nif is_member:\n    if account_age >= 2:\n        if purchase_amount >= 100:\n            print(\"You get 20% off!\")\n        else:\n            print(\"You get 10% off!\")\n    else:\n        print(\"You get 5% off!\")\nelse:\n    print(\"Join our membership for discounts!\")\n```\n\n## When to Use Nesting vs and\n\n### Using Nested If (More Specific Messages)\n```python\nif has_account:\n    if is_verified:\n        print(\"Welcome back!\")\n    else:\n        print(\"Please verify your email.\")\nelse:\n    print(\"Please create an account.\")\n```\n\n### Using and (Single Outcome)\n```python\nif has_account and is_verified:\n    print(\"Welcome back!\")\n```\n\n## Avoid Deep Nesting\n\nToo many levels become hard to read:\n```python\n# Hard to follow\nif a:\n    if b:\n        if c:\n            if d:\n                print(\"Too deep!\")\n```\n\n**Tip:** Consider using `and`/`or` or restructuring your logic."}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000011',
    'd0000000-0000-0000-0000-000000000006',
    '6.11',
    11,
    'Midterm Prep Quiz',
    'midterm-prep-quiz',
    'quiz',
    10,
    20,
    'free',
    '{
      "questions": [
        {
          "id": "q1",
          "type": "mcq",
          "question": "What is the output?\n\nx = 10\nif x > 5:\n    print(\"A\")\nelif x > 8:\n    print(\"B\")\nelse:\n    print(\"C\")",
          "options": ["A", "B", "C", "A and B"],
          "correct": 0,
          "explanation": "Only the first matching condition runs. x > 5 is True, so \"A\" prints and the rest is skipped."
        },
        {
          "id": "q2",
          "type": "mcq",
          "question": "What is: True and False or True",
          "options": ["True", "False", "Error", "None"],
          "correct": 0,
          "explanation": "and has higher precedence: (True and False) or True = False or True = True"
        },
        {
          "id": "q3",
          "type": "mcq",
          "question": "Which is the correct way to check if x is between 1 and 10 (inclusive)?",
          "options": [
            "if 1 <= x <= 10:",
            "if x >= 1 and <= 10:",
            "if x between 1 and 10:",
            "if (1-10).contains(x):"
          ],
          "correct": 0
        },
        {
          "id": "q4",
          "type": "true_false",
          "question": "not (True and True) equals False",
          "correct": true,
          "explanation": "True and True = True, not True = False"
        },
        {
          "id": "q5",
          "type": "mcq",
          "question": "What makes this code incorrect?\n\nif score >= 90\n    print(\"A\")",
          "options": [
            "Missing parentheses around condition",
            "Missing colon after condition",
            "Wrong indentation",
            "print should be Print"
          ],
          "correct": 1
        }
      ],
      "passing_score": 70
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0006-000000000012',
    'd0000000-0000-0000-0000-000000000006',
    '6.12',
    12,
    'Module 6 Checkpoint',
    'module-6-checkpoint',
    'checkpoint',
    15,
    55,
    'free',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "What is the result of: 5 == 5.0",
          "options": ["True", "False", "Error", "5"],
          "correct": 0,
          "explanation": "Python considers 5 and 5.0 equal in value comparison."
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "What is: not (False or True)",
          "options": ["True", "False", "Error", "None"],
          "correct": 1,
          "explanation": "False or True = True, not True = False"
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "Which value is considered \"falsy\" in Python?",
          "options": ["1", "\"False\"", "[]", "[0]"],
          "correct": 2,
          "explanation": "Empty list [] is falsy. \"False\" is a non-empty string (truthy), and [0] is a non-empty list (truthy)."
        },
        {
          "id": "cp4",
          "type": "mcq",
          "question": "What prints?\n\nage = 17\nif age >= 18:\n    print(\"Adult\")\nprint(\"Done\")",
          "options": ["Adult\\nDone", "Done", "Adult", "Nothing"],
          "correct": 1,
          "explanation": "The if block is skipped (17 < 18), but \"Done\" is not indented so it always prints."
        },
        {
          "id": "cp5",
          "type": "true_false",
          "question": "In Python, elif is short for \"else if\"",
          "correct": true
        },
        {
          "id": "cp6",
          "type": "mcq",
          "question": "How many times can elif appear in an if statement?",
          "options": ["Only once", "Maximum twice", "As many times as needed", "Zero times"],
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

