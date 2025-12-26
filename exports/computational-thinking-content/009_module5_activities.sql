-- ============================================
-- Activities for Module 5: Variables & Data Types
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0005-000000000001',
    'd0000000-0000-0000-0000-000000000005',
    '5.1',
    1,
    'Variables Explained',
    'variables-explained',
    'lesson',
    7,
    15,
    'free',
    '{"markdown": "# Variables Explained\n\nA variable is a named container that stores data in your program.\n\n## Creating Variables\n\n```python\nname = \"Alice\"      # String variable\nage = 25            # Integer variable\nheight = 1.65       # Float variable\nis_student = True   # Boolean variable\n```\n\n## The Assignment Operator (=)\n\nThe `=` sign assigns a value to a variable:\n```python\nx = 10  # \"x is assigned the value 10\"\n```\n\n**Note:** This is NOT the same as mathematical equality!\n\n## Variable Names\n\n### Good Names (Descriptive)\n```python\nuser_age = 25\ntotal_price = 99.99\nis_logged_in = True\n```\n\n### Bad Names (Unclear)\n```python\nx = 25\na = 99.99\nflag = True\n```\n\n## Variables Can Change\n\n```python\nscore = 0\nprint(score)    # Output: 0\n\nscore = 100\nprint(score)    # Output: 100\n\nscore = score + 50\nprint(score)    # Output: 150\n```\n\n## Multiple Assignment\n\n```python\n# Assign same value to multiple variables\nx = y = z = 0\n\n# Assign different values in one line\nname, age = \"Alice\", 25\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000002',
    'd0000000-0000-0000-0000-000000000005',
    '5.2',
    2,
    'Variable Visualizer',
    'variable-visualizer',
    'interactive',
    5,
    25,
    'basic',
    '{
      "instructions": "Watch how variables are stored in memory as you execute each line of code.",
      "type": "memory-visualizer",
      "codeSteps": [
        {"code": "x = 5", "memory": {"x": 5}},
        {"code": "y = 10", "memory": {"x": 5, "y": 10}},
        {"code": "x = x + y", "memory": {"x": 15, "y": 10}},
        {"code": "y = x", "memory": {"x": 15, "y": 15}}
      ]
    }'::jsonb,
    'memory-visualizer',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000003',
    'd0000000-0000-0000-0000-000000000005',
    '5.3',
    3,
    'Data Types Overview',
    'data-types-overview',
    'lesson',
    8,
    15,
    'free',
    '{"markdown": "# Data Types Overview\n\nPython has several built-in data types to represent different kinds of information.\n\n## Numeric Types\n\n### Integer (int)\nWhole numbers, positive or negative.\n```python\nage = 25\ntemperature = -10\npopulation = 1000000\n```\n\n### Float (float)\nDecimal numbers.\n```python\nprice = 19.99\npi = 3.14159\npercentage = 0.75\n```\n\n## Text Type\n\n### String (str)\nText enclosed in quotes.\n```python\nname = \"Alice\"\nmessage = ''Hello, World!''\naddress = \"123 Main St\"\n```\n\n## Boolean Type\n\n### Boolean (bool)\nTrue or False values.\n```python\nis_active = True\nhas_permission = False\n```\n\n## Checking Types\n\nUse `type()` to check a variable''s type:\n```python\nx = 42\nprint(type(x))  # <class ''int''>\n\ny = \"Hello\"\nprint(type(y))  # <class ''str''>\n```\n\n## Type Matters!\n\n```python\n# These are different!\nx = 5       # Integer\ny = \"5\"     # String\n\nprint(x + x)    # 10 (addition)\nprint(y + y)    # \"55\" (concatenation)\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000004',
    'd0000000-0000-0000-0000-000000000005',
    '5.4',
    4,
    'Type Detective Game',
    'type-detective-game',
    'interactive',
    6,
    25,
    'basic',
    '{
      "instructions": "Identify the data type of each value shown.",
      "type": "type-game",
      "challenges": [
        {"value": "42", "correctType": "int", "display": "42"},
        {"value": "\"42\"", "correctType": "str", "display": "\"42\""},
        {"value": "3.14", "correctType": "float", "display": "3.14"},
        {"value": "True", "correctType": "bool", "display": "True"},
        {"value": "\"Hello\"", "correctType": "str", "display": "\"Hello\""},
        {"value": "-5", "correctType": "int", "display": "-5"},
        {"value": "0.0", "correctType": "float", "display": "0.0"},
        {"value": "False", "correctType": "bool", "display": "False"}
      ]
    }'::jsonb,
    'type-game',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000005',
    'd0000000-0000-0000-0000-000000000005',
    '5.5',
    5,
    'Arithmetic Operators',
    'arithmetic-operators',
    'lesson',
    7,
    15,
    'free',
    '{"markdown": "# Arithmetic Operators\n\nPython can perform mathematical calculations using these operators:\n\n## Basic Operators\n\n| Operator | Name | Example | Result |\n|----------|------|---------|--------|\n| + | Addition | 5 + 3 | 8 |\n| - | Subtraction | 5 - 3 | 2 |\n| * | Multiplication | 5 * 3 | 15 |\n| / | Division | 5 / 2 | 2.5 |\n| // | Floor Division | 5 // 2 | 2 |\n| % | Modulus (Remainder) | 5 % 2 | 1 |\n| ** | Exponentiation | 5 ** 2 | 25 |\n\n## Division Types\n\n```python\n# Regular division (always returns float)\n10 / 3      # 3.3333...\n10 / 2      # 5.0\n\n# Floor division (rounds down to integer)\n10 // 3     # 3\n10 // 2     # 5\n\n# Modulus (remainder)\n10 % 3      # 1 (10 = 3*3 + 1)\n```\n\n## Order of Operations (PEMDAS)\n\n1. **P**arentheses\n2. **E**xponents\n3. **M**ultiplication / **D**ivision\n4. **A**ddition / **S**ubtraction\n\n```python\nresult = 2 + 3 * 4      # 14 (not 20)\nresult = (2 + 3) * 4    # 20\n```\n\n## Compound Assignment\n\n```python\nx = 10\nx += 5      # Same as: x = x + 5\nx -= 3      # Same as: x = x - 3\nx *= 2      # Same as: x = x * 2\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000006',
    'd0000000-0000-0000-0000-000000000005',
    '5.6',
    6,
    'Calculator Exercise',
    'calculator-exercise',
    'code',
    8,
    30,
    'basic',
    '{
      "instructions": "Create a simple calculator that:\n1. Stores two numbers in variables\n2. Calculates and prints their sum\n3. Calculates and prints their difference\n4. Calculates and prints their product\n5. Calculates and prints their quotient",
      "starterCode": "# Define two numbers\nnum1 = 15\nnum2 = 4\n\n# Calculate and print the sum\n\n# Calculate and print the difference\n\n# Calculate and print the product\n\n# Calculate and print the quotient\n",
      "solution": "# Define two numbers\nnum1 = 15\nnum2 = 4\n\n# Calculate and print the sum\nprint(\"Sum:\", num1 + num2)\n\n# Calculate and print the difference\nprint(\"Difference:\", num1 - num2)\n\n# Calculate and print the product\nprint(\"Product:\", num1 * num2)\n\n# Calculate and print the quotient\nprint(\"Quotient:\", num1 / num2)",
      "testCases": [
        {"input": "", "expectedOutput": "Sum: 19", "description": "Sum should be 19"},
        {"input": "", "expectedOutput": "Difference: 11", "description": "Difference should be 11"},
        {"input": "", "expectedOutput": "Product: 60", "description": "Product should be 60"},
        {"input": "", "expectedOutput": "Quotient: 3.75", "description": "Quotient should be 3.75"}
      ],
      "hints": [
        "Use print(\"Label:\", calculation) format",
        "For sum: num1 + num2",
        "For quotient, use / for regular division"
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000007',
    'd0000000-0000-0000-0000-000000000005',
    '5.7',
    7,
    'Strings & f-strings',
    'strings-and-fstrings',
    'lesson',
    8,
    15,
    'free',
    '{"markdown": "# Strings & f-strings\n\n## String Basics\n\nStrings are sequences of characters enclosed in quotes.\n\n```python\nname = \"Alice\"\ngreeting = ''Hello''\nmultiline = \"\"\"This is a\nmulti-line string\"\"\"\n```\n\n## String Concatenation\n\n```python\nfirst = \"Hello\"\nsecond = \"World\"\nmessage = first + \" \" + second\nprint(message)  # Hello World\n```\n\n## f-strings (Formatted String Literals)\n\nThe modern way to include variables in strings:\n\n```python\nname = \"Alice\"\nage = 25\n\n# f-string (recommended)\nprint(f\"My name is {name} and I am {age} years old.\")\n# Output: My name is Alice and I am 25 years old.\n```\n\n## f-string Features\n\n### Expressions Inside Braces\n```python\nx = 10\ny = 5\nprint(f\"Sum: {x + y}\")       # Sum: 15\nprint(f\"Product: {x * y}\")   # Product: 50\n```\n\n### Formatting Numbers\n```python\nprice = 19.99\nprint(f\"Price: ${price:.2f}\")  # Price: $19.99\n\npercentage = 0.756\nprint(f\"Score: {percentage:.1%}\")  # Score: 75.6%\n```\n\n## String Methods\n\n```python\ntext = \"Hello World\"\nprint(text.upper())       # HELLO WORLD\nprint(text.lower())       # hello world\nprint(text.replace(\"World\", \"Python\"))  # Hello Python\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000008',
    'd0000000-0000-0000-0000-000000000005',
    '5.8',
    8,
    'String Practice',
    'string-practice',
    'code',
    8,
    25,
    'basic',
    '{
      "instructions": "Practice using f-strings to create formatted output.\n\nGiven the variables below, create an f-string that outputs:\n\"Product: Laptop, Price: $999.99, In Stock: True\"",
      "starterCode": "product = \"Laptop\"\nprice = 999.99\nin_stock = True\n\n# Create an f-string and print the formatted message\n",
      "solution": "product = \"Laptop\"\nprice = 999.99\nin_stock = True\n\n# Create an f-string and print the formatted message\nprint(f\"Product: {product}, Price: ${price}, In Stock: {in_stock}\")",
      "testCases": [
        {"input": "", "expectedOutput": "Product: Laptop, Price: $999.99, In Stock: True", "description": "Should output formatted product info"}
      ],
      "hints": [
        "Start with f\" and end with \"",
        "Put variables inside curly braces: {variable}",
        "You can include $ directly in the string"
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000009',
    'd0000000-0000-0000-0000-000000000005',
    '5.9',
    9,
    'User Input',
    'user-input',
    'lesson',
    5,
    10,
    'free',
    '{"markdown": "# User Input\n\nThe `input()` function allows users to enter data into your program.\n\n## Basic Input\n\n```python\nname = input(\"What is your name? \")\nprint(f\"Hello, {name}!\")\n```\n\n**When run:**\n```\nWhat is your name? Alice\nHello, Alice!\n```\n\n## Important: input() Returns a String!\n\n```python\nage = input(\"Enter your age: \")\nprint(type(age))  # <class ''str''>\n\n# This won''t work as expected:\nage = input(\"Enter your age: \")  # User enters 25\nnext_year = age + 1  # Error! Can''t add string and int\n```\n\n## Converting Input\n\n```python\n# Convert to integer\nage = int(input(\"Enter your age: \"))\nnext_year = age + 1  # Now this works!\n\n# Convert to float\nprice = float(input(\"Enter price: \"))\n```\n\n## Complete Example\n\n```python\n# Get user information\nname = input(\"Name: \")\nage = int(input(\"Age: \"))\nheight = float(input(\"Height in meters: \"))\n\n# Display formatted output\nprint(f\"\\n{name} is {age} years old and {height}m tall.\")\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000010',
    'd0000000-0000-0000-0000-000000000005',
    '5.10',
    10,
    'Input Challenge',
    'input-challenge',
    'code',
    10,
    35,
    'basic',
    '{
      "instructions": "Create a program that:\n1. Asks for the user''s name\n2. Asks for their birth year (as a number)\n3. Calculates their approximate age (use 2024 as current year)\n4. Prints a greeting with their name and age",
      "starterCode": "# Get user''s name\n\n# Get user''s birth year (convert to int)\n\n# Calculate age\ncurrent_year = 2024\n\n# Print greeting with name and age\n",
      "solution": "# Get user''s name\nname = input(\"What is your name? \")\n\n# Get user''s birth year (convert to int)\nbirth_year = int(input(\"What year were you born? \"))\n\n# Calculate age\ncurrent_year = 2024\nage = current_year - birth_year\n\n# Print greeting with name and age\nprint(f\"Hello {name}! You are approximately {age} years old.\")",
      "testCases": [
        {"input": "Alice\\n1999", "expectedOutput": "Hello Alice! You are approximately 25 years old.", "description": "Should calculate age correctly"}
      ],
      "hints": [
        "Use input() to get the name",
        "Use int(input()) to get the birth year as a number",
        "Age = current_year - birth_year",
        "Use an f-string for the final output"
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000011',
    'd0000000-0000-0000-0000-000000000005',
    '5.11',
    11,
    'Type Conversion',
    'type-conversion',
    'lesson',
    5,
    15,
    'free',
    '{"markdown": "# Type Conversion\n\nConverting between data types is essential in Python.\n\n## Conversion Functions\n\n| Function | Converts to | Example |\n|----------|-------------|----------|\n| int() | Integer | int(\"42\") → 42 |\n| float() | Float | float(\"3.14\") → 3.14 |\n| str() | String | str(42) → \"42\" |\n| bool() | Boolean | bool(1) → True |\n\n## String to Number\n\n```python\n# String to int\nage = int(\"25\")      # 25\n\n# String to float\nprice = float(\"19.99\")  # 19.99\n\n# Watch out for errors!\nint(\"hello\")  # ValueError!\nint(\"25.5\")   # ValueError! (use float first)\n```\n\n## Number to String\n\n```python\nage = 25\nage_str = str(age)     # \"25\"\n\n# Useful for concatenation\nprint(\"Age: \" + str(age))  # Age: 25\n```\n\n## Float and Int Conversion\n\n```python\n# Float to int (truncates decimal)\nx = int(3.9)     # 3 (not 4!)\n\n# Int to float\ny = float(5)     # 5.0\n```\n\n## Boolean Conversions\n\n```python\n# To boolean\nbool(1)        # True\nbool(0)        # False\nbool(\"\")       # False (empty string)\nbool(\"hello\")  # True (non-empty string)\nbool([])       # False (empty list)\nbool([1,2,3])  # True (non-empty list)\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0005-000000000012',
    'd0000000-0000-0000-0000-000000000005',
    '5.12',
    12,
    'Module 5 Checkpoint',
    'module-5-checkpoint',
    'checkpoint',
    15,
    50,
    'free',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "What is the data type of: x = \"42\"",
          "options": ["int", "float", "str", "bool"],
          "correct": 2
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "What is the result of: 17 // 5",
          "options": ["3.4", "3", "4", "2"],
          "correct": 1,
          "explanation": "// is floor division, which rounds down to the nearest integer."
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "What is the result of: 17 % 5",
          "options": ["3.4", "3", "2", "0"],
          "correct": 2,
          "explanation": "% gives the remainder. 17 = 5*3 + 2, so remainder is 2."
        },
        {
          "id": "cp4",
          "type": "mcq",
          "question": "Which correctly creates an f-string?",
          "options": [
            "print(\"Hello {name}\")",
            "print(f\"Hello {name}\")",
            "print(\"Hello\" + {name})",
            "print(f Hello {name})"
          ],
          "correct": 1
        },
        {
          "id": "cp5",
          "type": "true_false",
          "question": "input() always returns a string, even if the user enters a number.",
          "correct": true
        },
        {
          "id": "cp6",
          "type": "mcq",
          "question": "What is int(3.9)?",
          "options": ["3", "4", "3.9", "Error"],
          "correct": 0,
          "explanation": "int() truncates the decimal part, it does not round."
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

