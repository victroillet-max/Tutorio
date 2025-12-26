-- ============================================
-- Activities for Module 11: Recap & Practice 1
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0011-000000000001',
    'd0000000-0000-0000-0000-000000000011',
    '11.1',
    1,
    'Modules 1-6 Review',
    'modules-1-6-review',
    'lesson',
    10,
    20,
    'basic',
    '{"markdown": "# Modules 1-6 Review\n\n## Module 1: Computational Thinking\n- **Decomposition**: Breaking problems into smaller parts\n- **Pattern Recognition**: Finding similarities\n- **Abstraction**: Focusing on essentials\n- **Algorithms**: Step-by-step solutions\n\n## Module 2: Problem-Solving Strategies\n- Decomposition strategies (functional, sequential, hierarchical)\n- Pattern types and recognition\n- Levels of abstraction\n\n## Module 3: Algorithms & Flowcharts\n- Algorithm characteristics\n- Flowchart symbols (oval, rectangle, diamond, parallelogram)\n- Pseudocode conventions\n\n## Module 4: Python Basics\n- print() function\n- Comments (#)\n- Python building blocks\n\n## Module 5: Variables & Data Types\n- Variable assignment\n- Data types: int, float, str, bool\n- Arithmetic operators: +, -, *, /, //, %, **\n- f-strings\n- input() function\n- Type conversion\n\n## Module 6: Conditionals\n- Boolean values\n- Comparison operators: ==, !=, >, <, >=, <=\n- Logical operators: and, or, not\n- if, elif, else statements\n- Nested conditionals"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0011-000000000002',
    'd0000000-0000-0000-0000-000000000011',
    '11.2',
    2,
    'Modules 7-10 Review',
    'modules-7-10-review',
    'lesson',
    10,
    20,
    'basic',
    '{"markdown": "# Modules 7-10 Review\n\n## Module 7: Lists\n- List creation: []\n- Indexing: list[0], list[-1]\n- Slicing: list[start:end:step]\n- Methods: append(), insert(), remove(), pop(), sort(), reverse()\n- in operator\n- len(), min(), max(), sum()\n\n## Module 8: Tuples, Sets & Dictionaries\n- **Tuples**: Immutable, (1, 2, 3)\n- **Sets**: Unique values, {1, 2, 3}\n- **Dictionaries**: Key-value pairs, {\"key\": \"value\"}\n- Dict methods: keys(), values(), items(), get()\n- Nested structures\n\n## Module 9: Loops\n- **While loops**: Repeat while condition is true\n- **For loops**: Iterate over sequences\n- range() function\n- break and continue\n- enumerate()\n- Nested loops\n\n## Module 10: Functions\n- def keyword\n- Parameters vs arguments\n- return statement\n- Default parameters\n- Local vs global scope\n- Importing modules\n\n## Key Concepts\n- Mutable vs immutable\n- When to use each collection type\n- Loop selection (for vs while)\n- Function design principles"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0011-000000000003',
    'd0000000-0000-0000-0000-000000000011',
    '11.3',
    3,
    'Integrated Challenge 1',
    'integrated-challenge-1',
    'code',
    12,
    45,
    'basic',
    '{
      "instructions": "Create a grade book program that:\n1. Stores student names and their scores in a dictionary\n2. Has a function to calculate the average score\n3. Has a function to find the highest scorer\n4. Has a function to count how many students passed (score >= 60)\n5. Prints a summary of all statistics",
      "starterCode": "# Student grade book\ngrades = {\n    \"Alice\": 85,\n    \"Bob\": 72,\n    \"Charlie\": 91,\n    \"Diana\": 58,\n    \"Eve\": 79\n}\n\n# Function to calculate average\ndef calculate_average(grade_dict):\n    pass\n\n# Function to find highest scorer\ndef find_top_student(grade_dict):\n    pass\n\n# Function to count passing students\ndef count_passing(grade_dict, passing_score=60):\n    pass\n\n# Print summary\n",
      "solution": "# Student grade book\ngrades = {\n    \"Alice\": 85,\n    \"Bob\": 72,\n    \"Charlie\": 91,\n    \"Diana\": 58,\n    \"Eve\": 79\n}\n\n# Function to calculate average\ndef calculate_average(grade_dict):\n    total = sum(grade_dict.values())\n    count = len(grade_dict)\n    return total / count\n\n# Function to find highest scorer\ndef find_top_student(grade_dict):\n    top_name = \"\"\n    top_score = 0\n    for name, score in grade_dict.items():\n        if score > top_score:\n            top_score = score\n            top_name = name\n    return top_name, top_score\n\n# Function to count passing students\ndef count_passing(grade_dict, passing_score=60):\n    count = 0\n    for score in grade_dict.values():\n        if score >= passing_score:\n            count += 1\n    return count\n\n# Print summary\nprint(\"=== Grade Book Summary ===\")\nprint(f\"Number of students: {len(grades)}\")\nprint(f\"Average score: {calculate_average(grades):.1f}\")\n\ntop_name, top_score = find_top_student(grades)\nprint(f\"Top student: {top_name} ({top_score})\")\n\npassing = count_passing(grades)\nprint(f\"Students passing: {passing}/{len(grades)}\")",
      "testCases": [
        {"input": "", "expectedOutput": "Average score: 77.0", "description": "Average should be 77.0"},
        {"input": "", "expectedOutput": "Top student: Charlie (91)", "description": "Charlie has highest score"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0011-000000000004',
    'd0000000-0000-0000-0000-000000000011',
    '11.4',
    4,
    'Integrated Challenge 2',
    'integrated-challenge-2',
    'code',
    12,
    45,
    'basic',
    '{
      "instructions": "Create a shopping list manager that:\n1. Stores items with their quantities and prices\n2. Can add new items\n3. Can update quantities\n4. Calculates total cost\n5. Displays a formatted receipt",
      "starterCode": "# Shopping list manager\nshopping_list = []\n\ndef add_item(name, quantity, price):\n    \"\"\"Add item to shopping list\"\"\"\n    pass\n\ndef update_quantity(name, new_quantity):\n    \"\"\"Update quantity of existing item\"\"\"\n    pass\n\ndef calculate_total():\n    \"\"\"Calculate total cost\"\"\"\n    pass\n\ndef print_receipt():\n    \"\"\"Print formatted receipt\"\"\"\n    pass\n\n# Test your functions\nadd_item(\"Apple\", 5, 0.50)\nadd_item(\"Bread\", 2, 2.99)\nadd_item(\"Milk\", 1, 3.49)\nupdate_quantity(\"Apple\", 10)\nprint_receipt()",
      "solution": "# Shopping list manager\nshopping_list = []\n\ndef add_item(name, quantity, price):\n    item = {}\n    item[\"name\"] = name\n    item[\"quantity\"] = quantity\n    item[\"price\"] = price\n    shopping_list.append(item)\n\ndef update_quantity(name, new_quantity):\n    for item in shopping_list:\n        if item.get(\"name\") == name:\n            item[\"quantity\"] = new_quantity\n            return True\n    return False\n\ndef calculate_total():\n    total = 0\n    for item in shopping_list:\n        total += item.get(\"quantity\", 0) * item.get(\"price\", 0)\n    return total\n\ndef print_receipt():\n    print(\"=\" * 40)\n    print(\"RECEIPT\")\n    print(\"=\" * 40)\n    for item in shopping_list:\n        n = item.get(\"name\", \"\")\n        q = item.get(\"quantity\", 0)\n        p = item.get(\"price\", 0)\n        subtotal = q * p\n        print(f\"{n:15} x{q:3} @ ${p:.2f} = ${subtotal:.2f}\")\n    print(\"-\" * 40)\n    print(f\"TOTAL: ${calculate_total():.2f}\")\n    print(\"=\" * 40)\n\n# Test\nadd_item(\"Apple\", 5, 0.50)\nadd_item(\"Bread\", 2, 2.99)\nadd_item(\"Milk\", 1, 3.49)\nupdate_quantity(\"Apple\", 10)\nprint_receipt()",
      "testCases": [
        {"input": "", "expectedOutput": "TOTAL", "description": "Should print a receipt with total"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0011-000000000005',
    'd0000000-0000-0000-0000-000000000011',
    '11.5',
    5,
    'Common Mistakes Quiz',
    'common-mistakes-quiz',
    'quiz',
    8,
    25,
    'basic',
    '{
      "questions": [
        {
          "id": "q1",
          "type": "mcq",
          "question": "What is wrong with this code?\n\nfor i in range(5)\n    print(i)",
          "options": [
            "range should be range(0, 5)",
            "Missing colon after range(5)",
            "print should be Print",
            "i should be declared first"
          ],
          "correct": 1
        },
        {
          "id": "q2",
          "type": "mcq",
          "question": "What will this code print?\n\nlist = [1, 2, 3]\nlist.append(4)\nprint(list.append(5))",
          "options": [
            "[1, 2, 3, 4, 5]",
            "5",
            "None",
            "Error"
          ],
          "correct": 2,
          "explanation": "append() modifies the list in place and returns None"
        },
        {
          "id": "q3",
          "type": "mcq",
          "question": "What is the error here?\n\ndef greet(name):\n    message = f\"Hello, {name}!\"\n\nresult = greet(\"Alice\")\nprint(result)",
          "options": [
            "Missing return statement",
            "f-string syntax is wrong",
            "Function name is invalid",
            "No error"
          ],
          "correct": 0
        },
        {
          "id": "q4",
          "type": "mcq",
          "question": "Why does this cause an infinite loop?\n\ni = 0\nwhile i < 5:\n    print(i)",
          "options": [
            "i should start at 1",
            "i is never incremented",
            "while should be for",
            "print prevents incrementing"
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
    'e0000000-0000-0000-0011-000000000006',
    'd0000000-0000-0000-0000-000000000011',
    '11.6',
    6,
    'Debugging Practice',
    'debugging-practice',
    'code',
    10,
    35,
    'basic',
    '{
      "instructions": "Fix all the bugs in this code. The program should:\n1. Calculate the average of a list of numbers\n2. Find all numbers above the average\n3. Return both the average and the list of above-average numbers",
      "starterCode": "def analyze_numbers(numbers)\n    # Bug 1: Syntax error\n    total = 0\n    for num in numbers\n        total += num\n    \n    # Bug 2: Integer division\n    average = total / len(numbers)\n    \n    # Bug 3: Logic error\n    above_average = []\n    for num in numbers:\n        if num > average\n            above_average.add(num)  # Bug 4: Wrong method\n    \n    # Bug 5: Return statement\n    print(average, above_average)\n\n# Test\nnumbers = [10, 20, 30, 40, 50]\nresult = analyze_numbers(numbers)\nprint(f\"Average: {result[0]}, Above average: {result[1]}\")",
      "solution": "def analyze_numbers(numbers):\n    # Bug 1 fixed: Added colon\n    total = 0\n    for num in numbers:  # Bug 1 fixed: Added colon\n        total += num\n    \n    # Average calculation\n    average = total / len(numbers)\n    \n    # Bug 3 fixed: Logic is correct, Bug 1 fixed: Added colons\n    above_average = []\n    for num in numbers:\n        if num > average:  # Bug 1 fixed: Added colon\n            above_average.append(num)  # Bug 4 fixed: lists use append, not add\n    \n    # Bug 5 fixed: Use return instead of print\n    return average, above_average\n\n# Test\nnumbers = [10, 20, 30, 40, 50]\nresult = analyze_numbers(numbers)\nprint(f\"Average: {result[0]}, Above average: {result[1]}\")",
      "testCases": [
        {"input": "", "expectedOutput": "Average: 30.0, Above average: [40, 50]", "description": "Should calculate correctly"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0011-000000000007',
    'd0000000-0000-0000-0000-000000000011',
    '11.7',
    7,
    'Module 11 Checkpoint',
    'module-11-checkpoint',
    'checkpoint',
    15,
    60,
    'basic',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "Which collection type would you use to store unique user IDs?",
          "options": ["List", "Tuple", "Set", "Dictionary"],
          "correct": 2
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "What is the output?\n\ndef double(x):\n    x = x * 2\n\nnum = 5\ndouble(num)\nprint(num)",
          "options": ["5", "10", "None", "Error"],
          "correct": 0,
          "explanation": "The function modifies a local copy; the original num is unchanged."
        },
        {
          "id": "cp3",
          "type": "true_false",
          "question": "A function can modify a list that is passed as an argument.",
          "correct": true,
          "explanation": "Lists are mutable and passed by reference."
        },
        {
          "id": "cp4",
          "type": "mcq",
          "question": "What does enumerate() return?",
          "options": [
            "Just the values",
            "Just the indices",
            "Tuples of (index, value)",
            "A count of items"
          ],
          "correct": 2
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "Which is the correct way to check if a key exists in a dictionary?",
          "options": [
            "if key exists in dict:",
            "if key in dict:",
            "if dict.contains(key):",
            "if dict.has(key):"
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
-- Activities for Module 12: Object-Oriented Programming
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0012-000000000001',
    'd0000000-0000-0000-0000-000000000012',
    '12.1',
    1,
    'OOP vs Procedural',
    'oop-vs-procedural',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# OOP vs Procedural Programming\n\n## Procedural Programming\n\nCode organized as a sequence of steps with functions.\n\n```python\n# Procedural approach\ndef create_user(name, email):\n    return {\"name\": name, \"email\": email}\n\ndef get_user_info(user):\n    n = user.get(\"name\")\n    e = user.get(\"email\")\n    return f\"{n} ({e})\"\n\nuser = create_user(\"Alice\", \"alice@email.com\")\nprint(get_user_info(user))\n```\n\n## Object-Oriented Programming\n\nCode organized around objects that combine data and behavior.\n\n```python\n# OOP approach\nclass User:\n    def __init__(self, name, email):\n        self.name = name\n        self.email = email\n    \n    def get_info(self):\n        return f\"{self.name} ({self.email})\"\n\nuser = User(\"Alice\", \"alice@email.com\")\nprint(user.get_info())\n```\n\n## Key Differences\n\n| Procedural | OOP |\n|------------|-----|\n| Functions operate on data | Objects contain data and methods |\n| Data and functions separate | Data and behavior together |\n| Simpler for small programs | Better for complex systems |\n\n## When to Use OOP\n\n- Modeling real-world entities\n- When data and actions are closely related\n- Large, complex applications\n- Code reuse through inheritance"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0012-000000000002',
    'd0000000-0000-0000-0000-000000000012',
    '12.2',
    2,
    'Classes & Objects',
    'classes-and-objects',
    'lesson',
    8,
    15,
    'basic',
    '{"markdown": "# Classes & Objects\n\n## What is a Class?\n\nA class is a blueprint or template for creating objects.\n\n```python\nclass Dog:\n    pass  # Empty class\n```\n\n## What is an Object?\n\nAn object is an instance of a class.\n\n```python\nmy_dog = Dog()  # Create an object\nyour_dog = Dog()  # Another object\n```\n\n## Class with Attributes\n\n```python\nclass Dog:\n    species = \"Canis familiaris\"  # Class attribute\n    \n    def __init__(self, name, age):\n        self.name = name  # Instance attribute\n        self.age = age    # Instance attribute\n\n# Create dogs\nbuddy = Dog(\"Buddy\", 3)\nmax_dog = Dog(\"Max\", 5)\n\nprint(buddy.name)     # Buddy\nprint(max_dog.age)    # 5\nprint(Dog.species)    # Canis familiaris\n```\n\n## Class vs Instance Attributes\n\n- **Class attributes**: Shared by all instances\n- **Instance attributes**: Unique to each instance\n\n```python\nprint(buddy.species)      # Canis familiaris\nprint(max_dog.species)    # Canis familiaris\n\nbuddy.species = \"Wolf\"    # Creates instance attribute\nprint(buddy.species)      # Wolf\nprint(max_dog.species)    # Canis familiaris (unchanged)\n```\n\n## Real-World Analogy\n\n- **Class**: Cookie cutter (the template)\n- **Object**: A cookie (made from the template)\n- **Attributes**: Size, flavor, toppings"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0012-000000000003',
    'd0000000-0000-0000-0000-000000000012',
    '12.3',
    3,
    '__init__ Method',
    'init-method',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# The __init__ Method\n\nThe `__init__` method is the constructor - it runs when creating an object.\n\n## Basic Structure\n\n```python\nclass Person:\n    def __init__(self):\n        print(\"A new person was created!\")\n\nperson = Person()  # Prints: A new person was created!\n```\n\n## With Parameters\n\n```python\nclass Person:\n    def __init__(self, name, age):\n        self.name = name\n        self.age = age\n\nalice = Person(\"Alice\", 25)\nprint(alice.name)  # Alice\nprint(alice.age)   # 25\n```\n\n## Understanding self\n\n`self` refers to the current instance being created.\n\n```python\nclass Person:\n    def __init__(self, name):\n        # self.name creates an attribute on THIS object\n        self.name = name\n        print(f\"Created: {self}\")\n\np1 = Person(\"Alice\")\np2 = Person(\"Bob\")\n# p1 and p2 are different objects with different self references\n```\n\n## Default Values\n\n```python\nclass Person:\n    def __init__(self, name, age=0):\n        self.name = name\n        self.age = age\n\nbaby = Person(\"Baby\")       # age defaults to 0\nadult = Person(\"Adult\", 30)\n```\n\n## Validation in __init__\n\n```python\nclass Person:\n    def __init__(self, name, age):\n        if age < 0:\n            raise ValueError(\"Age cannot be negative\")\n        self.name = name\n        self.age = age\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0012-000000000004',
    'd0000000-0000-0000-0000-000000000012',
    '12.4',
    4,
    'Class Practice',
    'class-practice',
    'code',
    10,
    30,
    'basic',
    '{
      "instructions": "Create a Book class with:\n1. __init__ that takes title, author, and pages\n2. Instance attributes for all three\n3. Create two book objects\n4. Print details of each book",
      "starterCode": "# Create the Book class\n\n\n# Create two book objects\n\n\n# Print book details\n",
      "solution": "# Create the Book class\nclass Book:\n    def __init__(self, title, author, pages):\n        self.title = title\n        self.author = author\n        self.pages = pages\n\n# Create two book objects\nbook1 = Book(\"1984\", \"George Orwell\", 328)\nbook2 = Book(\"The Hobbit\", \"J.R.R. Tolkien\", 310)\n\n# Print book details\nprint(f\"{book1.title} by {book1.author} - {book1.pages} pages\")\nprint(f\"{book2.title} by {book2.author} - {book2.pages} pages\")",
      "testCases": [
        {"input": "", "expectedOutput": "1984 by George Orwell", "description": "Should print first book"},
        {"input": "", "expectedOutput": "The Hobbit by J.R.R. Tolkien", "description": "Should print second book"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0012-000000000005',
    'd0000000-0000-0000-0000-000000000012',
    '12.5',
    5,
    'Methods & self',
    'methods-and-self',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Methods & self\n\nMethods are functions that belong to a class.\n\n## Defining Methods\n\n```python\nclass Dog:\n    def __init__(self, name):\n        self.name = name\n    \n    def bark(self):  # Method\n        print(f\"{self.name} says Woof!\")\n    \n    def sit(self):   # Another method\n        print(f\"{self.name} is sitting.\")\n\nbuddy = Dog(\"Buddy\")\nbuddy.bark()  # Buddy says Woof!\nbuddy.sit()   # Buddy is sitting.\n```\n\n## self is Required\n\n`self` must be the first parameter of every method.\n\n```python\nclass Counter:\n    def __init__(self):\n        self.count = 0\n    \n    def increment(self):  # self required!\n        self.count += 1\n    \n    def get_count(self):\n        return self.count\n\nc = Counter()\nc.increment()\nc.increment()\nprint(c.get_count())  # 2\n```\n\n## Methods with Parameters\n\n```python\nclass BankAccount:\n    def __init__(self, balance=0):\n        self.balance = balance\n    \n    def deposit(self, amount):\n        self.balance += amount\n    \n    def withdraw(self, amount):\n        if amount <= self.balance:\n            self.balance -= amount\n            return True\n        return False\n\naccount = BankAccount(100)\naccount.deposit(50)\nprint(account.balance)  # 150\n```\n\n## Methods Calling Methods\n\n```python\nclass Calculator:\n    def add(self, a, b):\n        return a + b\n    \n    def add_three(self, a, b, c):\n        return self.add(self.add(a, b), c)\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0012-000000000006',
    'd0000000-0000-0000-0000-000000000012',
    '12.6',
    6,
    'Class Diagram Builder',
    'class-diagram-builder',
    'interactive',
    10,
    35,
    'basic',
    '{
      "instructions": "Build a class diagram for a Student class by identifying attributes and methods.",
      "type": "class-diagram",
      "className": "Student",
      "attributes": [
        {"name": "name", "type": "str"},
        {"name": "student_id", "type": "str"},
        {"name": "grades", "type": "list"}
      ],
      "methods": [
        {"name": "__init__", "params": ["name", "student_id"]},
        {"name": "add_grade", "params": ["grade"]},
        {"name": "get_average", "params": []},
        {"name": "is_passing", "params": []}
      ]
    }'::jsonb,
    'class-diagram',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0012-000000000007',
    'd0000000-0000-0000-0000-000000000012',
    '12.7',
    7,
    '__str__ Method',
    'str-method',
    'lesson',
    5,
    10,
    'basic',
    '{"markdown": "# The __str__ Method\n\nDefine how your object appears when printed.\n\n## Without __str__\n\n```python\nclass Person:\n    def __init__(self, name, age):\n        self.name = name\n        self.age = age\n\np = Person(\"Alice\", 25)\nprint(p)  # <__main__.Person object at 0x...>\n```\n\nNot very helpful!\n\n## With __str__\n\n```python\nclass Person:\n    def __init__(self, name, age):\n        self.name = name\n        self.age = age\n    \n    def __str__(self):\n        return f\"Person({self.name}, {self.age})\"\n\np = Person(\"Alice\", 25)\nprint(p)  # Person(Alice, 25)\n```\n\nMuch better!\n\n## Practical Example\n\n```python\nclass Product:\n    def __init__(self, name, price):\n        self.name = name\n        self.price = price\n    \n    def __str__(self):\n        return f\"{self.name}: ${self.price:.2f}\"\n\nproducts = [\n    Product(\"Apple\", 0.99),\n    Product(\"Bread\", 2.49),\n    Product(\"Milk\", 3.99)\n]\n\nfor product in products:\n    print(product)\n\n# Output:\n# Apple: $0.99\n# Bread: $2.49\n# Milk: $3.99\n```\n\n## __str__ vs __repr__\n\n- `__str__`: Human-readable (for users)\n- `__repr__`: Developer-readable (for debugging)"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0012-000000000008',
    'd0000000-0000-0000-0000-000000000012',
    '12.8',
    8,
    'Vehicle Class Project',
    'vehicle-class-project',
    'code',
    15,
    50,
    'basic',
    '{
      "instructions": "Create a Vehicle class with:\n1. __init__ that takes make, model, year, and fuel_level (default 100)\n2. A drive(distance) method that reduces fuel (1 unit per 10 km)\n3. A refuel(amount) method that adds fuel (max 100)\n4. A __str__ method for nice printing\n5. Test with multiple vehicles",
      "starterCode": "class Vehicle:\n    def __init__(self, make, model, year, fuel_level=100):\n        pass\n    \n    def drive(self, distance):\n        \"\"\"Reduce fuel based on distance (1 fuel per 10 km)\"\"\"\n        pass\n    \n    def refuel(self, amount):\n        \"\"\"Add fuel, max 100\"\"\"\n        pass\n    \n    def __str__(self):\n        pass\n\n# Test your class\ncar = Vehicle(\"Toyota\", \"Camry\", 2020)\nprint(car)\ncar.drive(50)\nprint(f\"Fuel after driving 50km: {car.fuel_level}\")\ncar.refuel(20)\nprint(f\"Fuel after refueling: {car.fuel_level}\")",
      "solution": "class Vehicle:\n    def __init__(self, make, model, year, fuel_level=100):\n        self.make = make\n        self.model = model\n        self.year = year\n        self.fuel_level = fuel_level\n    \n    def drive(self, distance):\n        \"\"\"Reduce fuel based on distance (1 fuel per 10 km)\"\"\"\n        fuel_needed = distance / 10\n        if fuel_needed <= self.fuel_level:\n            self.fuel_level -= fuel_needed\n            print(f\"Drove {distance}km\")\n        else:\n            print(\"Not enough fuel!\")\n    \n    def refuel(self, amount):\n        \"\"\"Add fuel, max 100\"\"\"\n        self.fuel_level = min(100, self.fuel_level + amount)\n        print(f\"Refueled to {self.fuel_level}\")\n    \n    def __str__(self):\n        return f\"{self.year} {self.make} {self.model} (Fuel: {self.fuel_level}%)\"\n\n# Test your class\ncar = Vehicle(\"Toyota\", \"Camry\", 2020)\nprint(car)\ncar.drive(50)\nprint(f\"Fuel after driving 50km: {car.fuel_level}\")\ncar.refuel(20)\nprint(f\"Fuel after refueling: {car.fuel_level}\")",
      "testCases": [
        {"input": "", "expectedOutput": "2020 Toyota Camry", "description": "Should print vehicle info"},
        {"input": "", "expectedOutput": "Fuel after driving 50km: 95.0", "description": "Should use 5 fuel for 50km"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0012-000000000009',
    'd0000000-0000-0000-0000-000000000012',
    '12.9',
    9,
    'Encapsulation Benefits',
    'encapsulation-benefits',
    'lesson',
    5,
    10,
    'basic',
    '{"markdown": "# Encapsulation Benefits\n\nEncapsulation bundles data and methods together, controlling access.\n\n## Without Encapsulation\n\n```python\n# Data can be modified directly\nbalance = 1000\nbalance = -999999  # Oops! Invalid balance\n```\n\n## With Encapsulation\n\n```python\nclass BankAccount:\n    def __init__(self, balance):\n        self._balance = balance  # \"Private\" by convention\n    \n    def get_balance(self):\n        return self._balance\n    \n    def deposit(self, amount):\n        if amount > 0:\n            self._balance += amount\n    \n    def withdraw(self, amount):\n        if 0 < amount <= self._balance:\n            self._balance -= amount\n            return True\n        return False\n\naccount = BankAccount(1000)\n# account._balance = -999999  # Possible but discouraged\naccount.withdraw(500)  # Controlled access\n```\n\n## Benefits\n\n1. **Data Protection**: Prevent invalid states\n2. **Flexibility**: Change internals without breaking code\n3. **Validation**: Enforce rules on data changes\n4. **Maintainability**: Clear interface for interaction\n\n## Python Convention\n\n- `_name`: \"Protected\" - internal use\n- `__name`: \"Private\" - name mangling\n- No underscore: Public\n\n```python\nclass Example:\n    def __init__(self):\n        self.public = 1      # Anyone can use\n        self._protected = 2  # Internal use\n        self.__private = 3   # Strongly discouraged to access\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0012-000000000010',
    'd0000000-0000-0000-0000-000000000012',
    '12.10',
    10,
    'Module 12 Checkpoint',
    'module-12-checkpoint',
    'checkpoint',
    15,
    60,
    'basic',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "What is the purpose of __init__?",
          "options": [
            "To delete an object",
            "To initialize an object when created",
            "To print the object",
            "To compare objects"
          ],
          "correct": 1
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "What does self refer to?",
          "options": [
            "The class definition",
            "The current instance of the class",
            "The parent class",
            "All instances of the class"
          ],
          "correct": 1
        },
        {
          "id": "cp3",
          "type": "true_false",
          "question": "A class can have multiple __init__ methods.",
          "correct": false,
          "explanation": "Python only uses the last defined __init__. For multiple constructors, use default parameters or class methods."
        },
        {
          "id": "cp4",
          "type": "mcq",
          "question": "What is the difference between a class and an object?",
          "options": [
            "They are the same thing",
            "Class is the blueprint, object is an instance",
            "Object is the blueprint, class is an instance",
            "Classes are for data, objects are for methods"
          ],
          "correct": 1
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "What does __str__ do?",
          "options": [
            "Converts object to integer",
            "Defines string representation for print()",
            "Validates string input",
            "Counts characters in object"
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

