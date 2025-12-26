-- ============================================
-- Activities for Module 10: Functions
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0010-000000000001',
    'd0000000-0000-0000-0000-000000000010',
    '10.1',
    1,
    'Why Functions?',
    'why-functions',
    'lesson',
    6,
    15,
    'basic',
    '{"markdown": "# Why Functions?\n\nFunctions are reusable blocks of code that perform specific tasks.\n\n## The Problem\n\n```python\n# Without functions - lots of repetition!\nprint(\"=\"*20)\nprint(\"Welcome, Alice!\")\nprint(\"=\"*20)\n\n# Later in the code...\nprint(\"=\"*20)\nprint(\"Welcome, Bob!\")\nprint(\"=\"*20)\n\n# And again...\nprint(\"=\"*20)\nprint(\"Welcome, Charlie!\")\nprint(\"=\"*20)\n```\n\n## The Solution\n\n```python\ndef welcome(name):\n    print(\"=\"*20)\n    print(f\"Welcome, {name}!\")\n    print(\"=\"*20)\n\n# Much cleaner!\nwelcome(\"Alice\")\nwelcome(\"Bob\")\nwelcome(\"Charlie\")\n```\n\n## Benefits of Functions\n\n1. **Reusability** - Write once, use many times\n2. **Readability** - Code is easier to understand\n3. **Maintainability** - Change in one place affects all uses\n4. **Modularity** - Break complex problems into smaller pieces\n5. **Testing** - Test individual pieces of code\n\n## Functions You Already Know\n\n```python\nprint(\"Hello\")      # Built-in function\nlen([1, 2, 3])      # Built-in function\ninput(\"Name: \")     # Built-in function\nrange(5)            # Built-in function\n```\n\nNow it''s time to create your own!"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000002',
    'd0000000-0000-0000-0000-000000000010',
    '10.2',
    2,
    'Defining Functions',
    'defining-functions',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Defining Functions\n\n## Basic Syntax\n\n```python\ndef function_name():\n    # Function body\n    # Code to execute\n    pass\n```\n\n## Key Elements\n\n1. **def** keyword - starts the function definition\n2. **function_name** - what you call the function\n3. **()** - parentheses for parameters\n4. **:** - colon to start the body\n5. **Indented code** - the function body\n\n## Simple Function\n\n```python\ndef greet():\n    print(\"Hello, World!\")\n\n# Call the function\ngreet()  # Output: Hello, World!\ngreet()  # Output: Hello, World!\n```\n\n## Function Naming Rules\n\n- Use lowercase letters\n- Use underscores for multiple words\n- Be descriptive\n- Use verbs (they do something!)\n\n```python\n# Good names\ndef calculate_total():\n    pass\n\ndef get_user_input():\n    pass\n\ndef validate_email():\n    pass\n\n# Bad names\ndef f():           # Not descriptive\ndef MyFunction():  # Wrong case\ndef do_stuff():    # Too vague\n```\n\n## Defining vs Calling\n\n```python\n# Definition - creates the function\ndef say_hello():\n    print(\"Hello!\")\n\n# Nothing happens yet!\n\n# Calling - executes the function\nsay_hello()  # Now it runs!\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000003',
    'd0000000-0000-0000-0000-000000000010',
    '10.3',
    3,
    'Parameters & Arguments',
    'parameters-and-arguments',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Parameters & Arguments\n\n## What''s the Difference?\n\n- **Parameter**: Variable in function definition\n- **Argument**: Value passed when calling\n\n```python\ndef greet(name):       # name is a PARAMETER\n    print(f\"Hi, {name}!\")\n\ngreet(\"Alice\")          # \"Alice\" is an ARGUMENT\n```\n\n## Single Parameter\n\n```python\ndef square(number):\n    print(number * number)\n\nsquare(5)   # Output: 25\nsquare(3)   # Output: 9\n```\n\n## Multiple Parameters\n\n```python\ndef add(a, b):\n    print(a + b)\n\nadd(3, 5)       # Output: 8\nadd(10, 20)     # Output: 30\n```\n\n## Order Matters!\n\n```python\ndef introduce(name, age):\n    print(f\"{name} is {age} years old\")\n\nintroduce(\"Alice\", 25)  # Alice is 25 years old\nintroduce(25, \"Alice\")  # 25 is Alice years old (wrong!)\n```\n\n## Keyword Arguments\n\n```python\ndef introduce(name, age):\n    print(f\"{name} is {age} years old\")\n\n# Using keyword arguments (order doesn''t matter)\nintroduce(age=25, name=\"Alice\")  # Alice is 25 years old\n```\n\n## Mixed Arguments\n\n```python\ndef describe(name, age, city):\n    print(f\"{name}, {age}, from {city}\")\n\n# Positional first, then keyword\ndescribe(\"Alice\", city=\"Zurich\", age=25)\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000004',
    'd0000000-0000-0000-0000-000000000010',
    '10.4',
    4,
    'Function Practice',
    'function-practice',
    'code',
    10,
    30,
    'basic',
    '{
      "instructions": "Create the following functions:\n1. greet(name) - prints \"Hello, {name}!\"\n2. add_numbers(a, b) - prints the sum of a and b\n3. describe_person(name, age, city) - prints \"{name} is {age} and lives in {city}\"\n\nThen call each function to test it.",
      "starterCode": "# 1. Create greet function\n\n# 2. Create add_numbers function\n\n# 3. Create describe_person function\n\n# Test your functions\nprint(\"Testing greet:\")\n\nprint(\"\\nTesting add_numbers:\")\n\nprint(\"\\nTesting describe_person:\")\n",
      "solution": "# 1. Create greet function\ndef greet(name):\n    print(f\"Hello, {name}!\")\n\n# 2. Create add_numbers function\ndef add_numbers(a, b):\n    print(a + b)\n\n# 3. Create describe_person function\ndef describe_person(name, age, city):\n    print(f\"{name} is {age} and lives in {city}\")\n\n# Test your functions\nprint(\"Testing greet:\")\ngreet(\"Alice\")\n\nprint(\"\\nTesting add_numbers:\")\nadd_numbers(5, 3)\n\nprint(\"\\nTesting describe_person:\")\ndescribe_person(\"Bob\", 25, \"Zurich\")",
      "testCases": [
        {"input": "", "expectedOutput": "Hello, Alice!", "description": "greet function works"},
        {"input": "", "expectedOutput": "8", "description": "add_numbers function works"},
        {"input": "", "expectedOutput": "Bob is 25 and lives in Zurich", "description": "describe_person function works"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000005',
    'd0000000-0000-0000-0000-000000000010',
    '10.5',
    5,
    'Return Values',
    'return-values',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Return Values\n\nFunctions can send values back using `return`.\n\n## Print vs Return\n\n```python\n# Print - displays but doesn''t give back\ndef add_print(a, b):\n    print(a + b)\n\nresult = add_print(3, 5)  # Prints: 8\nprint(result)              # Prints: None\n\n# Return - gives back the value\ndef add_return(a, b):\n    return a + b\n\nresult = add_return(3, 5)  # Nothing printed\nprint(result)               # Prints: 8\n```\n\n## Why Use Return?\n\n```python\ndef calculate_tax(price, rate):\n    return price * rate\n\n# Can use the result!\ntax = calculate_tax(100, 0.08)\ntotal = 100 + tax\nprint(f\"Total: ${total}\")  # Total: $108.0\n```\n\n## Return Ends the Function\n\n```python\ndef check_age(age):\n    if age < 0:\n        return \"Invalid age\"\n    if age < 18:\n        return \"Minor\"\n    return \"Adult\"\n\nprint(check_age(25))   # Adult\nprint(check_age(-5))   # Invalid age\n```\n\n## Returning Multiple Values\n\n```python\ndef get_min_max(numbers):\n    return min(numbers), max(numbers)\n\nlowest, highest = get_min_max([3, 1, 4, 1, 5])\nprint(f\"Min: {lowest}, Max: {highest}\")\n```\n\n## Return None\n\nFunctions without return (or with just `return`) return None.\n\n```python\ndef greet(name):\n    print(f\"Hi, {name}\")\n    # No return statement\n\nresult = greet(\"Alice\")  # Prints: Hi, Alice\nprint(result)             # Prints: None\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000006',
    'd0000000-0000-0000-0000-000000000010',
    '10.6',
    6,
    'Function Flow Visualizer',
    'function-flow-visualizer',
    'interactive',
    8,
    30,
    'basic',
    '{
      "instructions": "Trace the flow of function calls and returns.",
      "type": "function-flow",
      "examples": [
        {
          "code": "def double(x):\n    return x * 2\n\ndef add_five(x):\n    return x + 5\n\nresult = add_five(double(3))",
          "steps": [
            {"action": "call", "function": "double", "args": {"x": 3}},
            {"action": "return", "function": "double", "value": 6},
            {"action": "call", "function": "add_five", "args": {"x": 6}},
            {"action": "return", "function": "add_five", "value": 11},
            {"action": "assign", "variable": "result", "value": 11}
          ]
        },
        {
          "code": "def greet(name):\n    message = create_greeting(name)\n    return message\n\ndef create_greeting(n):\n    return f\"Hello, {n}!\"\n\noutput = greet(\"Alice\")",
          "steps": [
            {"action": "call", "function": "greet", "args": {"name": "Alice"}},
            {"action": "call", "function": "create_greeting", "args": {"n": "Alice"}},
            {"action": "return", "function": "create_greeting", "value": "Hello, Alice!"},
            {"action": "assign", "variable": "message", "value": "Hello, Alice!"},
            {"action": "return", "function": "greet", "value": "Hello, Alice!"},
            {"action": "assign", "variable": "output", "value": "Hello, Alice!"}
          ]
        }
      ]
    }'::jsonb,
    'function-flow',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000007',
    'd0000000-0000-0000-0000-000000000010',
    '10.7',
    7,
    'Default Parameters',
    'default-parameters',
    'lesson',
    5,
    10,
    'basic',
    '{"markdown": "# Default Parameters\n\nProvide default values for parameters.\n\n## Basic Syntax\n\n```python\ndef greet(name, greeting=\"Hello\"):\n    print(f\"{greeting}, {name}!\")\n\ngreet(\"Alice\")              # Hello, Alice!\ngreet(\"Bob\", \"Hi\")          # Hi, Bob!\ngreet(\"Charlie\", \"Hey\")     # Hey, Charlie!\n```\n\n## Multiple Defaults\n\n```python\ndef create_profile(name, age=18, city=\"Unknown\"):\n    return f\"{name}, {age}, from {city}\"\n\nprint(create_profile(\"Alice\"))            # Alice, 18, from Unknown\nprint(create_profile(\"Bob\", 25))          # Bob, 25, from Unknown\nprint(create_profile(\"Charlie\", 30, \"Zurich\"))  # Charlie, 30, from Zurich\n```\n\n## Rule: Defaults Must Come Last!\n\n```python\n# WRONG - default before non-default\ndef bad_func(a=1, b):\n    pass\n\n# CORRECT - defaults at the end\ndef good_func(b, a=1):\n    pass\n```\n\n## Practical Examples\n\n```python\ndef calculate_price(base, tax_rate=0.08, discount=0):\n    subtotal = base * (1 + tax_rate)\n    final = subtotal * (1 - discount)\n    return round(final, 2)\n\nprint(calculate_price(100))                    # 108.0\nprint(calculate_price(100, discount=0.1))      # 97.2\nprint(calculate_price(100, 0.1, 0.2))          # 88.0\n```\n\n## Common Use Cases\n\n- Optional formatting options\n- Configuration with sensible defaults\n- API functions with optional parameters"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000008',
    'd0000000-0000-0000-0000-000000000010',
    '10.8',
    8,
    'Scope: Local vs Global',
    'scope-local-vs-global',
    'lesson',
    6,
    15,
    'basic',
    '{"markdown": "# Scope: Local vs Global\n\nScope determines where variables can be accessed.\n\n## Local Variables\n\nVariables created inside a function only exist there.\n\n```python\ndef my_function():\n    x = 10  # Local variable\n    print(x)\n\nmy_function()   # Prints: 10\nprint(x)        # Error! x doesn''t exist here\n```\n\n## Global Variables\n\nVariables created outside functions are accessible everywhere.\n\n```python\nname = \"Alice\"  # Global variable\n\ndef greet():\n    print(f\"Hello, {name}!\")  # Can read global\n\ngreet()  # Hello, Alice!\n```\n\n## Local Shadows Global\n\n```python\nx = 10  # Global\n\ndef my_function():\n    x = 5  # Local (different variable!)\n    print(x)\n\nmy_function()   # Prints: 5\nprint(x)        # Prints: 10 (unchanged)\n```\n\n## The global Keyword\n\nTo modify a global variable inside a function:\n\n```python\ncounter = 0\n\ndef increment():\n    global counter\n    counter += 1\n\nincrement()\nincrement()\nprint(counter)  # 2\n```\n\n## Best Practice\n\n**Avoid using global!** Instead, use parameters and returns:\n\n```python\n# Better approach\ndef increment(counter):\n    return counter + 1\n\ncount = 0\ncount = increment(count)\ncount = increment(count)\nprint(count)  # 2\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000009',
    'd0000000-0000-0000-0000-000000000010',
    '10.9',
    9,
    'Price Calculator',
    'price-calculator',
    'code',
    12,
    45,
    'basic',
    '{
      "instructions": "Create a price calculator with these functions:\n1. calculate_subtotal(price, quantity) - returns price * quantity\n2. apply_discount(subtotal, discount_percent=0) - returns discounted price\n3. add_tax(amount, tax_rate=0.08) - returns amount with tax\n4. calculate_final_price(price, quantity, discount=0, tax=0.08) - uses all above functions\n\nTest with: 3 items at $25 each, 10% discount, 8% tax",
      "starterCode": "# 1. Calculate subtotal\ndef calculate_subtotal(price, quantity):\n    pass\n\n# 2. Apply discount\ndef apply_discount(subtotal, discount_percent=0):\n    pass\n\n# 3. Add tax\ndef add_tax(amount, tax_rate=0.08):\n    pass\n\n# 4. Calculate final price (use all functions above)\ndef calculate_final_price(price, quantity, discount=0, tax=0.08):\n    pass\n\n# Test\nfinal = calculate_final_price(25, 3, 0.10, 0.08)\nprint(f\"Final price: ${final:.2f}\")",
      "solution": "# 1. Calculate subtotal\ndef calculate_subtotal(price, quantity):\n    return price * quantity\n\n# 2. Apply discount\ndef apply_discount(subtotal, discount_percent=0):\n    return subtotal * (1 - discount_percent)\n\n# 3. Add tax\ndef add_tax(amount, tax_rate=0.08):\n    return amount * (1 + tax_rate)\n\n# 4. Calculate final price (use all functions above)\ndef calculate_final_price(price, quantity, discount=0, tax=0.08):\n    subtotal = calculate_subtotal(price, quantity)\n    discounted = apply_discount(subtotal, discount)\n    final = add_tax(discounted, tax)\n    return final\n\n# Test\nfinal = calculate_final_price(25, 3, 0.10, 0.08)\nprint(f\"Final price: ${final:.2f}\")",
      "testCases": [
        {"input": "", "expectedOutput": "Final price: $72.90", "description": "Should calculate correct final price"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000010',
    'd0000000-0000-0000-0000-000000000010',
    '10.10',
    10,
    'Importing Libraries',
    'importing-libraries',
    'lesson',
    6,
    15,
    'basic',
    '{"markdown": "# Importing Libraries\n\nLibraries (modules) provide pre-built functions.\n\n## Basic Import\n\n```python\nimport math\n\nprint(math.sqrt(16))    # 4.0\nprint(math.pi)          # 3.14159...\nprint(math.floor(3.7))  # 3\n```\n\n## Import Specific Items\n\n```python\nfrom math import sqrt, pi\n\nprint(sqrt(16))  # 4.0\nprint(pi)        # 3.14159...\n```\n\n## Import with Alias\n\n```python\nimport math as m\n\nprint(m.sqrt(16))  # 4.0\n```\n\n## Common Built-in Modules\n\n### random - Random numbers\n```python\nimport random\n\nprint(random.randint(1, 10))    # Random 1-10\nprint(random.choice([\"a\", \"b\"]))  # Random pick\nprint(random.shuffle([1,2,3]))   # Shuffle list\n```\n\n### datetime - Date and time\n```python\nfrom datetime import datetime, date\n\ntoday = date.today()\nnow = datetime.now()\nprint(today)  # 2024-03-15\n```\n\n### os - Operating system\n```python\nimport os\n\nprint(os.getcwd())      # Current directory\nprint(os.listdir(\".\"))  # List files\n```\n\n## Install External Packages\n\n```bash\npip install requests\n```\n\n```python\nimport requests\n\nresponse = requests.get(\"https://api.example.com\")\ndata = response.json()\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000011',
    'd0000000-0000-0000-0000-000000000010',
    '10.11',
    11,
    'Refactoring Challenge',
    'refactoring-challenge',
    'code',
    10,
    40,
    'basic',
    '{
      "instructions": "Refactor the messy code below into well-organized functions:\n1. Create a function to validate if score is in valid range (0-100)\n2. Create a function to determine grade letter (A, B, C, D, F)\n3. Create a function to print the result\n4. Create a main function that ties everything together",
      "starterCode": "# Messy code to refactor\nscore = 85\n\nif score < 0 or score > 100:\n    print(\"Invalid score\")\nelse:\n    if score >= 90:\n        grade = \"A\"\n    elif score >= 80:\n        grade = \"B\"\n    elif score >= 70:\n        grade = \"C\"\n    elif score >= 60:\n        grade = \"D\"\n    else:\n        grade = \"F\"\n    print(f\"Score: {score}\")\n    print(f\"Grade: {grade}\")\n\n# Refactor into functions below:\n\n",
      "solution": "# Refactored code with functions\n\ndef is_valid_score(score):\n    \"\"\"Check if score is in valid range 0-100\"\"\"\n    return 0 <= score <= 100\n\ndef get_grade(score):\n    \"\"\"Return grade letter based on score\"\"\"\n    if score >= 90:\n        return \"A\"\n    elif score >= 80:\n        return \"B\"\n    elif score >= 70:\n        return \"C\"\n    elif score >= 60:\n        return \"D\"\n    else:\n        return \"F\"\n\ndef print_result(score, grade):\n    \"\"\"Print the score and grade\"\"\"\n    print(f\"Score: {score}\")\n    print(f\"Grade: {grade}\")\n\ndef process_score(score):\n    \"\"\"Main function to process a score\"\"\"\n    if not is_valid_score(score):\n        print(\"Invalid score\")\n        return\n    \n    grade = get_grade(score)\n    print_result(score, grade)\n\n# Test\nprocess_score(85)\nprint()\nprocess_score(150)",
      "testCases": [
        {"input": "", "expectedOutput": "Score: 85\nGrade: B", "description": "Should show correct grade for 85"},
        {"input": "", "expectedOutput": "Invalid score", "description": "Should reject invalid score"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0010-000000000012',
    'd0000000-0000-0000-0000-000000000010',
    '10.12',
    12,
    'Module 10 Checkpoint',
    'module-10-checkpoint',
    'checkpoint',
    15,
    55,
    'basic',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "What keyword is used to define a function?",
          "options": ["function", "def", "func", "define"],
          "correct": 1
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "What does a function return if there is no return statement?",
          "options": ["0", "\"\"", "None", "False"],
          "correct": 2
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "What is the difference between a parameter and an argument?",
          "options": [
            "They are the same thing",
            "Parameter is in definition, argument is when calling",
            "Argument is in definition, parameter is when calling",
            "Parameters are optional, arguments are required"
          ],
          "correct": 1
        },
        {
          "id": "cp4",
          "type": "true_false",
          "question": "A function can return multiple values.",
          "correct": true
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "Where must parameters with default values be placed?",
          "options": [
            "At the beginning",
            "In the middle",
            "At the end",
            "Anywhere"
          ],
          "correct": 2
        },
        {
          "id": "cp6",
          "type": "mcq",
          "question": "What is scope in Python?",
          "options": [
            "The size of a function",
            "Where variables can be accessed",
            "The return type of a function",
            "The number of parameters"
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

