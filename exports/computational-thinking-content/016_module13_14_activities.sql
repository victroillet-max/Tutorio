-- ============================================
-- Activities for Module 13: Code Evaluation & Debugging
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0013-000000000001',
    'd0000000-0000-0000-0000-000000000013',
    '13.1',
    1,
    'Defensive Programming',
    'defensive-programming',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Defensive Programming\n\nWrite code that anticipates and handles problems.\n\n## Key Principles\n\n### 1. Validate Input\n\n```python\ndef divide(a, b):\n    if b == 0:\n        return None  # Or raise an error\n    return a / b\n\ndef get_age():\n    age = input(\"Enter age: \")\n    if not age.isdigit():\n        return None\n    age = int(age)\n    if age < 0 or age > 150:\n        return None\n    return age\n```\n\n### 2. Handle Edge Cases\n\n```python\ndef get_average(numbers):\n    if not numbers:  # Empty list\n        return 0\n    return sum(numbers) / len(numbers)\n\ndef get_first(items):\n    if len(items) == 0:\n        return None\n    return items[0]\n```\n\n### 3. Use Default Values\n\n```python\ndef greet(name=None):\n    if name is None:\n        name = \"Guest\"\n    return f\"Hello, {name}!\"\n\ndef get_config(key, default=None):\n    config = {\"debug\": True}\n    return config.get(key, default)\n```\n\n### 4. Fail Fast\n\n```python\ndef process_user(user):\n    if user is None:\n        raise ValueError(\"User cannot be None\")\n    if not user.get(\"email\"):\n        raise ValueError(\"User must have email\")\n    # Continue with valid user...\n```\n\n## Benefits\n\n- Prevents crashes\n- Makes debugging easier\n- Produces reliable code\n- Improves user experience"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0013-000000000002',
    'd0000000-0000-0000-0000-000000000013',
    '13.2',
    2,
    'Testing Types',
    'testing-types',
    'lesson',
    8,
    15,
    'basic',
    '{"markdown": "# Testing Types\n\n## Why Test?\n\n- Catch bugs early\n- Ensure code works as expected\n- Prevent regressions\n- Document behavior\n\n## Types of Testing\n\n### 1. Unit Testing\nTest individual functions/methods.\n\n```python\ndef add(a, b):\n    return a + b\n\n# Unit tests\nassert add(2, 3) == 5\nassert add(-1, 1) == 0\nassert add(0, 0) == 0\n```\n\n### 2. Integration Testing\nTest how components work together.\n\n```python\ndef create_user(name):\n    return {\"name\": name, \"id\": 1}\n\ndef send_welcome(user):\n    name = user.get(\"name\")\n    return f\"Welcome, {name}!\"\n\n# Integration test\nuser = create_user(\"Alice\")\nmessage = send_welcome(user)\nassert \"Alice\" in message\n```\n\n### 3. Edge Case Testing\nTest boundary conditions.\n\n```python\ndef get_grade(score):\n    if score >= 90: return \"A\"\n    if score >= 80: return \"B\"\n    # ...\n\n# Edge case tests\nassert get_grade(90) == \"A\"   # Boundary\nassert get_grade(89) == \"B\"   # Just below\nassert get_grade(100) == \"A\"  # Maximum\nassert get_grade(0) == \"F\"    # Minimum\n```\n\n### 4. Negative Testing\nTest with invalid input.\n\n```python\ndef divide(a, b):\n    if b == 0:\n        return None\n    return a / b\n\n# Negative tests\nassert divide(10, 0) is None\nassert divide(10, 2) == 5\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0013-000000000003',
    'd0000000-0000-0000-0000-000000000013',
    '13.3',
    3,
    'Test Case Development',
    'test-case-development',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Test Case Development\n\n## What Makes a Good Test?\n\n1. **Independent**: Doesn''t depend on other tests\n2. **Repeatable**: Same result every time\n3. **Clear**: Easy to understand what it tests\n4. **Complete**: Covers important scenarios\n\n## Test Case Template\n\n```python\n# Function to test\ndef calculate_discount(price, discount_percent):\n    return price * (1 - discount_percent / 100)\n\n# Test cases\ndef test_calculate_discount():\n    # Normal case\n    assert calculate_discount(100, 10) == 90\n    \n    # Zero discount\n    assert calculate_discount(100, 0) == 100\n    \n    # Full discount\n    assert calculate_discount(100, 100) == 0\n    \n    # Decimal values\n    assert calculate_discount(99.99, 50) == 49.995\n    \n    print(\"All tests passed!\")\n```\n\n## Testing Categories\n\n### Happy Path\nTypical, expected usage.\n\n```python\nassert login(\"valid_user\", \"correct_pass\") == True\n```\n\n### Edge Cases\nBoundary conditions.\n\n```python\nassert process([]) == []  # Empty input\nassert process([1]) == [1]  # Single item\n```\n\n### Error Cases\nInvalid input.\n\n```python\nassert login(\"\", \"\") == False\nassert login(None, \"pass\") == False\n```\n\n## Testing Tip\n\nThink: \"What could go wrong?\""}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0013-000000000004',
    'd0000000-0000-0000-0000-000000000013',
    '13.4',
    4,
    'Bug Hunt Game',
    'bug-hunt-game',
    'interactive',
    10,
    35,
    'basic',
    '{
      "instructions": "Find and identify the bug in each code snippet.",
      "type": "bug-hunt",
      "bugs": [
        {
          "code": "def is_even(n):\n    return n % 2 = 0",
          "bugType": "SyntaxError",
          "line": 2,
          "hint": "Check the comparison operator",
          "fix": "return n % 2 == 0"
        },
        {
          "code": "numbers = [1, 2, 3]\nfor i in range(len(numbers)):\n    print(numbers[i + 1])",
          "bugType": "IndexError",
          "line": 3,
          "hint": "What happens when i is the last index?",
          "fix": "print(numbers[i])"
        },
        {
          "code": "def greet(name):\n    return \"Hello, \" + name\n\ngreet(42)",
          "bugType": "TypeError",
          "line": 4,
          "hint": "Can you concatenate string and int?",
          "fix": "greet(str(42)) or greet(\"42\")"
        },
        {
          "code": "def factorial(n):\n    result = 0\n    for i in range(1, n+1):\n        result *= i\n    return result",
          "bugType": "LogicError",
          "line": 2,
          "hint": "What is 0 multiplied by anything?",
          "fix": "result = 1"
        }
      ]
    }'::jsonb,
    'bug-hunt',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0013-000000000005',
    'd0000000-0000-0000-0000-000000000013',
    '13.5',
    5,
    'Common Errors',
    'common-errors',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Common Python Errors\n\n## SyntaxError\n\nCode violates Python''s grammar rules.\n\n```python\n# Missing colon\nif x > 5\n    print(\"big\")\n\n# Mismatched brackets\nprint(\"hello\"\n\n# Invalid assignment\n5 = x\n```\n\n## NameError\n\nUsing a variable that doesn''t exist.\n\n```python\nprint(undefined_variable)\n\n# Typos\nusername = \"Alice\"\nprint(user_name)  # Wrong name!\n```\n\n## TypeError\n\nOperation on wrong type.\n\n```python\n\"hello\" + 5       # Can''t add str and int\nlen(42)           # int has no length\n\"hello\"[1.5]      # Index must be int\n```\n\n## IndexError\n\nAccessing invalid index.\n\n```python\nlist = [1, 2, 3]\nprint(list[5])    # Only 0, 1, 2 exist\nprint(list[-10])  # Out of range\n```\n\n## KeyError\n\nAccessing missing dictionary key.\n\n```python\ndata = {\"name\": \"Alice\"}\nprint(data[\"age\"])  # Key doesn''t exist\n\n# Fix: use .get()\nprint(data.get(\"age\", \"Unknown\"))\n```\n\n## ValueError\n\nCorrect type, wrong value.\n\n```python\nint(\"hello\")      # Can''t convert to int\nint(\"3.14\")       # Use float() first\n```\n\n## Logic Errors\n\nNo error message, but wrong result!\n\n```python\n# Off-by-one error\nfor i in range(10):  # 0-9, not 1-10\n    print(i)\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0013-000000000006',
    'd0000000-0000-0000-0000-000000000013',
    '13.6',
    6,
    'Error Decoder',
    'error-decoder',
    'interactive',
    8,
    30,
    'basic',
    '{
      "instructions": "Match each error message to its cause and solution.",
      "type": "error-decoder",
      "errors": [
        {
          "message": "TypeError: can only concatenate str (not \"int\") to str",
          "cause": "Trying to add a string and integer with +",
          "solution": "Convert int to str: str(number) or use f-string"
        },
        {
          "message": "IndexError: list index out of range",
          "cause": "Accessing an index that doesn''t exist in the list",
          "solution": "Check list length before accessing or use valid index"
        },
        {
          "message": "KeyError: ''username''",
          "cause": "Dictionary doesn''t have the key ''username''",
          "solution": "Use .get() method or check if key exists first"
        },
        {
          "message": "NameError: name ''x'' is not defined",
          "cause": "Variable ''x'' was never created or is misspelled",
          "solution": "Define the variable or check spelling"
        }
      ]
    }'::jsonb,
    'error-decoder',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0013-000000000007',
    'd0000000-0000-0000-0000-000000000013',
    '13.7',
    7,
    'Assert Statements',
    'assert-statements',
    'lesson',
    5,
    10,
    'basic',
    '{"markdown": "# Assert Statements\n\nAssert checks if a condition is true; raises error if false.\n\n## Basic Syntax\n\n```python\nassert condition, \"Error message\"\n```\n\n## Simple Examples\n\n```python\nx = 5\nassert x == 5          # Passes silently\nassert x > 0           # Passes silently\nassert x == 10         # AssertionError!\n```\n\n## With Error Messages\n\n```python\nage = -5\nassert age >= 0, f\"Age must be positive, got {age}\"\n# AssertionError: Age must be positive, got -5\n```\n\n## Using for Testing\n\n```python\ndef add(a, b):\n    return a + b\n\n# Test suite\nassert add(2, 3) == 5, \"Failed: 2 + 3\"\nassert add(0, 0) == 0, \"Failed: 0 + 0\"\nassert add(-1, 1) == 0, \"Failed: -1 + 1\"\nprint(\"All tests passed!\")\n```\n\n## Validating Input\n\n```python\ndef calculate_discount(price, percent):\n    assert price > 0, \"Price must be positive\"\n    assert 0 <= percent <= 100, \"Percent must be 0-100\"\n    return price * (1 - percent / 100)\n```\n\n## When to Use Assert\n\n- During development and testing\n- To verify assumptions\n- To catch programming errors\n\n## When NOT to Use Assert\n\n- For user input validation (use if statements)\n- In production for critical checks\n- Assert can be disabled with -O flag"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0013-000000000008',
    'd0000000-0000-0000-0000-000000000013',
    '13.8',
    8,
    'Debugging Challenge',
    'debugging-challenge',
    'code',
    12,
    45,
    'basic',
    '{
      "instructions": "This shopping cart has multiple bugs. Find and fix them all:\n1. The add_item function has a syntax error\n2. The remove_item function has a logic error\n3. The calculate_total has a wrong calculation\n4. The apply_discount has a validation issue",
      "starterCode": "class ShoppingCart:\n    def __init__(self):\n        self.items = []\n    \n    def add_item(self, name, price, quantity)\n        item = {\"name\": name, \"price\": price, \"quantity\": quantity}\n        self.items.append(item)\n    \n    def remove_item(self, name):\n        for item in self.items:\n            if item[\"name\"] = name:\n                self.items.remove(item)\n    \n    def calculate_total(self):\n        total = 0\n        for item in self.items:\n            total += item[\"price\"]\n        return total\n    \n    def apply_discount(self, percent):\n        total = self.calculate_total()\n        return total * percent / 100\n\n# Test\ncart = ShoppingCart()\ncart.add_item(\"Apple\", 1.50, 3)\ncart.add_item(\"Bread\", 2.00, 2)\nprint(f\"Total: ${cart.calculate_total():.2f}\")\nprint(f\"After 10% discount: ${cart.apply_discount(10):.2f}\")",
      "solution": "class ShoppingCart:\n    def __init__(self):\n        self.items = []\n    \n    def add_item(self, name, price, quantity):  # Bug 1: Missing colon\n        item = {\"name\": name, \"price\": price, \"quantity\": quantity}\n        self.items.append(item)\n    \n    def remove_item(self, name):\n        for item in self.items:\n            if item[\"name\"] == name:  # Bug 2: = should be ==\n                self.items.remove(item)\n                break  # Also good to break after removing\n    \n    def calculate_total(self):\n        total = 0\n        for item in self.items:\n            total += item[\"price\"] * item[\"quantity\"]  # Bug 3: Missing quantity\n        return total\n    \n    def apply_discount(self, percent):\n        total = self.calculate_total()\n        return total * (1 - percent / 100)  # Bug 4: Wrong formula\n\n# Test\ncart = ShoppingCart()\ncart.add_item(\"Apple\", 1.50, 3)\ncart.add_item(\"Bread\", 2.00, 2)\nprint(f\"Total: ${cart.calculate_total():.2f}\")\nprint(f\"After 10% discount: ${cart.apply_discount(10):.2f}\")",
      "testCases": [
        {"input": "", "expectedOutput": "Total: $8.50", "description": "Total should include quantities"},
        {"input": "", "expectedOutput": "After 10% discount: $7.65", "description": "Discount should reduce price"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0013-000000000009',
    'd0000000-0000-0000-0000-000000000013',
    '13.9',
    9,
    'Module 13 Checkpoint',
    'module-13-checkpoint',
    'checkpoint',
    15,
    55,
    'basic',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "What is defensive programming?",
          "options": [
            "Programming that is hard to hack",
            "Writing code that anticipates and handles problems",
            "Using assert statements everywhere",
            "Avoiding all user input"
          ],
          "correct": 1
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "What type of error is: print(x) when x is not defined?",
          "options": ["SyntaxError", "TypeError", "NameError", "ValueError"],
          "correct": 2
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "What does assert x > 0 do if x = -5?",
          "options": [
            "Returns False",
            "Prints an error",
            "Raises AssertionError",
            "Sets x to 0"
          ],
          "correct": 2
        },
        {
          "id": "cp4",
          "type": "true_false",
          "question": "A logic error will always produce an error message.",
          "correct": false,
          "explanation": "Logic errors produce wrong results but no error messages."
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "Which is the best way to handle a missing dictionary key?",
          "options": [
            "dict[key]",
            "dict.get(key, default)",
            "dict.find(key)",
            "try dict[key]"
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
-- Activities for Module 14: Recap & Practice 2
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0014-000000000001',
    'd0000000-0000-0000-0000-000000000014',
    '14.1',
    1,
    'OOP Review',
    'oop-review',
    'lesson',
    8,
    15,
    'basic',
    '{"markdown": "# OOP Review\n\n## Core Concepts\n\n### Classes and Objects\n```python\nclass Person:            # Class definition\n    def __init__(self, name):\n        self.name = name # Instance attribute\n\nperson = Person(\"Alice\") # Object creation\n```\n\n### Key Methods\n- `__init__`: Constructor, runs on creation\n- `__str__`: String representation for print()\n- Regular methods: Take self as first parameter\n\n### Encapsulation\n- Bundle data and methods together\n- Control access with naming conventions\n- `_private` for internal use\n\n## Class Design Checklist\n\n1. What data does the class store? (attributes)\n2. What actions can it perform? (methods)\n3. How should it be created? (__init__)\n4. How should it display? (__str__)\n\n## Common Patterns\n\n### Getter/Setter\n```python\nclass Account:\n    def __init__(self):\n        self._balance = 0\n    \n    def get_balance(self):\n        return self._balance\n    \n    def deposit(self, amount):\n        if amount > 0:\n            self._balance += amount\n```\n\n### Collection Class\n```python\nclass Inventory:\n    def __init__(self):\n        self.items = []\n    \n    def add(self, item):\n        self.items.append(item)\n    \n    def find(self, name):\n        for item in self.items:\n            if item.name == name:\n                return item\n        return None\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0014-000000000002',
    'd0000000-0000-0000-0000-000000000014',
    '14.2',
    2,
    'Testing Review',
    'testing-review',
    'lesson',
    8,
    15,
    'basic',
    '{"markdown": "# Testing Review\n\n## Testing Strategy\n\n### 1. Identify Test Cases\n- Normal cases (happy path)\n- Edge cases (boundaries)\n- Error cases (invalid input)\n\n### 2. Write Tests\n```python\ndef test_function():\n    # Arrange\n    input_value = 5\n    expected = 25\n    \n    # Act\n    result = square(input_value)\n    \n    # Assert\n    assert result == expected\n```\n\n### 3. Run and Verify\n\n## Testing Checklist\n\n- Empty input ([], \"\", {})\n- Single item ([1], \"a\")\n- Many items\n- Negative numbers\n- Zero\n- Maximum values\n- Invalid types\n- None values\n\n## Testing Classes\n\n```python\nclass TestBankAccount:\n    def test_initial_balance(self):\n        account = BankAccount()\n        assert account.get_balance() == 0\n    \n    def test_deposit(self):\n        account = BankAccount()\n        account.deposit(100)\n        assert account.get_balance() == 100\n    \n    def test_withdraw(self):\n        account = BankAccount(100)\n        assert account.withdraw(50) == True\n        assert account.get_balance() == 50\n    \n    def test_overdraft(self):\n        account = BankAccount(100)\n        assert account.withdraw(200) == False\n```\n\n## Debugging Process\n\n1. Reproduce the bug\n2. Isolate the problem\n3. Identify the cause\n4. Fix and verify\n5. Add test to prevent regression"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0014-000000000003',
    'd0000000-0000-0000-0000-000000000014',
    '14.3',
    3,
    'Comprehensive Project',
    'comprehensive-project',
    'code',
    20,
    60,
    'basic',
    '{
      "instructions": "Build a complete Library Management System with:\n1. A Book class with title, author, isbn, and is_available\n2. A Library class that can:\n   - Add books\n   - Remove books by ISBN\n   - Check out a book (mark unavailable)\n   - Return a book (mark available)\n   - Search by title or author\n   - List all available books",
      "starterCode": "class Book:\n    def __init__(self, title, author, isbn):\n        pass\n    \n    def __str__(self):\n        pass\n\nclass Library:\n    def __init__(self, name):\n        pass\n    \n    def add_book(self, book):\n        pass\n    \n    def remove_book(self, isbn):\n        pass\n    \n    def checkout(self, isbn):\n        pass\n    \n    def return_book(self, isbn):\n        pass\n    \n    def search(self, query):\n        pass\n    \n    def list_available(self):\n        pass\n\n# Test your system\nlibrary = Library(\"City Library\")\nlibrary.add_book(Book(\"1984\", \"George Orwell\", \"001\"))\nlibrary.add_book(Book(\"Python Guide\", \"Expert Author\", \"002\"))\n\nprint(\"Available books:\")\nlibrary.list_available()\n\nprint(\"\\nChecking out 1984...\")\nlibrary.checkout(\"001\")\n\nprint(\"\\nAvailable after checkout:\")\nlibrary.list_available()",
      "solution": "class Book:\n    def __init__(self, title, author, isbn):\n        self.title = title\n        self.author = author\n        self.isbn = isbn\n        self.is_available = True\n    \n    def __str__(self):\n        status = \"Available\" if self.is_available else \"Checked Out\"\n        return f\"{self.title} by {self.author} (ISBN: {self.isbn}) - {status}\"\n\nclass Library:\n    def __init__(self, name):\n        self.name = name\n        self.books = []\n    \n    def add_book(self, book):\n        self.books.append(book)\n        print(f\"Added: {book.title}\")\n    \n    def remove_book(self, isbn):\n        for book in self.books:\n            if book.isbn == isbn:\n                self.books.remove(book)\n                print(f\"Removed: {book.title}\")\n                return True\n        print(\"Book not found\")\n        return False\n    \n    def checkout(self, isbn):\n        for book in self.books:\n            if book.isbn == isbn:\n                if book.is_available:\n                    book.is_available = False\n                    print(f\"Checked out: {book.title}\")\n                    return True\n                else:\n                    print(\"Book already checked out\")\n                    return False\n        print(\"Book not found\")\n        return False\n    \n    def return_book(self, isbn):\n        for book in self.books:\n            if book.isbn == isbn:\n                book.is_available = True\n                print(f\"Returned: {book.title}\")\n                return True\n        print(\"Book not found\")\n        return False\n    \n    def search(self, query):\n        results = []\n        query = query.lower()\n        for book in self.books:\n            if query in book.title.lower() or query in book.author.lower():\n                results.append(book)\n        return results\n    \n    def list_available(self):\n        available = [b for b in self.books if b.is_available]\n        for book in available:\n            print(f\"  - {book}\")\n        return available\n\n# Test your system\nlibrary = Library(\"City Library\")\nlibrary.add_book(Book(\"1984\", \"George Orwell\", \"001\"))\nlibrary.add_book(Book(\"Python Guide\", \"Expert Author\", \"002\"))\n\nprint(\"\\nAvailable books:\")\nlibrary.list_available()\n\nprint(\"\\nChecking out 1984...\")\nlibrary.checkout(\"001\")\n\nprint(\"\\nAvailable after checkout:\")\nlibrary.list_available()",
      "testCases": [
        {"input": "", "expectedOutput": "Added: 1984", "description": "Should add books"},
        {"input": "", "expectedOutput": "Checked out: 1984", "description": "Should check out book"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0014-000000000004',
    'd0000000-0000-0000-0000-000000000014',
    '14.4',
    4,
    'Code Review Simulation',
    'code-review-simulation',
    'interactive',
    12,
    40,
    'basic',
    '{
      "instructions": "Review this code and identify issues related to: naming, efficiency, error handling, and style.",
      "type": "code-review",
      "code": "def f(l):\n    r = []\n    for i in range(len(l)):\n        if l[i] > 0:\n            r.append(l[i] * 2)\n    return r\n\nx = f([1, -2, 3, -4, 5])",
      "issues": [
        {
          "type": "naming",
          "line": 1,
          "description": "Function name ''f'' is not descriptive",
          "suggestion": "Use a name like ''double_positives''"
        },
        {
          "type": "naming",
          "line": 1,
          "description": "Parameter ''l'' looks like number 1",
          "suggestion": "Use ''numbers'' or ''values''"
        },
        {
          "type": "efficiency",
          "line": 3,
          "description": "Using range(len(l)) instead of direct iteration",
          "suggestion": "Use ''for item in l:'' directly"
        },
        {
          "type": "style",
          "line": 1,
          "description": "Missing docstring",
          "suggestion": "Add description of what function does"
        }
      ],
      "improvedCode": "def double_positives(numbers):\n    \"\"\"Return a list of doubled positive numbers.\"\"\"\n    return [num * 2 for num in numbers if num > 0]\n\nresult = double_positives([1, -2, 3, -4, 5])"
    }'::jsonb,
    'code-review',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0014-000000000005',
    'd0000000-0000-0000-0000-000000000014',
    '14.5',
    5,
    'Advanced Challenge',
    'advanced-challenge',
    'code',
    15,
    50,
    'basic',
    '{
      "instructions": "Create a complete Contact Manager that:\n1. Stores contacts with name, email, and phone\n2. Can add, remove, update contacts\n3. Search by any field\n4. Validates email format (must contain @)\n5. Prevents duplicate emails\n6. Exports contacts as formatted string",
      "starterCode": "class Contact:\n    def __init__(self, name, email, phone):\n        pass\n\nclass ContactManager:\n    def __init__(self):\n        pass\n    \n    def add_contact(self, name, email, phone):\n        \"\"\"Add contact if email is valid and unique\"\"\"\n        pass\n    \n    def remove_contact(self, email):\n        pass\n    \n    def update_contact(self, email, **kwargs):\n        \"\"\"Update contact fields (name, phone, new_email)\"\"\"\n        pass\n    \n    def search(self, query):\n        \"\"\"Search by name, email, or phone\"\"\"\n        pass\n    \n    def export_all(self):\n        \"\"\"Return formatted string of all contacts\"\"\"\n        pass\n\n# Test\nmanager = ContactManager()\nmanager.add_contact(\"Alice\", \"alice@email.com\", \"123-456\")\nmanager.add_contact(\"Bob\", \"bob@email.com\", \"789-012\")\nprint(manager.export_all())",
      "solution": "class Contact:\n    def __init__(self, name, email, phone):\n        self.name = name\n        self.email = email\n        self.phone = phone\n    \n    def __str__(self):\n        return f\"{self.name} | {self.email} | {self.phone}\"\n\nclass ContactManager:\n    def __init__(self):\n        self.contacts = []\n    \n    def _is_valid_email(self, email):\n        return \"@\" in email\n    \n    def _email_exists(self, email):\n        return any(c.email == email for c in self.contacts)\n    \n    def add_contact(self, name, email, phone):\n        if not self._is_valid_email(email):\n            print(f\"Invalid email: {email}\")\n            return False\n        if self._email_exists(email):\n            print(f\"Email already exists: {email}\")\n            return False\n        self.contacts.append(Contact(name, email, phone))\n        print(f\"Added: {name}\")\n        return True\n    \n    def remove_contact(self, email):\n        for contact in self.contacts:\n            if contact.email == email:\n                self.contacts.remove(contact)\n                print(f\"Removed: {contact.name}\")\n                return True\n        print(\"Contact not found\")\n        return False\n    \n    def update_contact(self, email, **kwargs):\n        for contact in self.contacts:\n            if contact.email == email:\n                if \"name\" in kwargs:\n                    contact.name = kwargs[\"name\"]\n                if \"phone\" in kwargs:\n                    contact.phone = kwargs[\"phone\"]\n                if \"new_email\" in kwargs:\n                    if self._is_valid_email(kwargs[\"new_email\"]):\n                        contact.email = kwargs[\"new_email\"]\n                print(f\"Updated: {contact.name}\")\n                return True\n        print(\"Contact not found\")\n        return False\n    \n    def search(self, query):\n        query = query.lower()\n        results = []\n        for c in self.contacts:\n            if query in c.name.lower() or query in c.email.lower() or query in c.phone:\n                results.append(c)\n        return results\n    \n    def export_all(self):\n        lines = [\"=== CONTACTS ===\"]\n        for c in self.contacts:\n            lines.append(str(c))\n        lines.append(f\"Total: {len(self.contacts)}\")\n        return \"\\n\".join(lines)\n\n# Test\nmanager = ContactManager()\nmanager.add_contact(\"Alice\", \"alice@email.com\", \"123-456\")\nmanager.add_contact(\"Bob\", \"bob@email.com\", \"789-012\")\nprint(manager.export_all())",
      "testCases": [
        {"input": "", "expectedOutput": "Added: Alice", "description": "Should add valid contact"},
        {"input": "", "expectedOutput": "Alice | alice@email.com", "description": "Should export contacts"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0014-000000000006',
    'd0000000-0000-0000-0000-000000000014',
    '14.6',
    6,
    'Module 14 Checkpoint',
    'module-14-checkpoint',
    'checkpoint',
    15,
    60,
    'basic',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "What is the purpose of the self parameter in methods?",
          "options": [
            "It''s optional and can be removed",
            "It refers to the class itself",
            "It refers to the current instance",
            "It is used for inheritance"
          ],
          "correct": 2
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "Which testing approach tests individual functions in isolation?",
          "options": [
            "Integration testing",
            "System testing",
            "Unit testing",
            "Acceptance testing"
          ],
          "correct": 2
        },
        {
          "id": "cp3",
          "type": "true_false",
          "question": "A class method can modify instance attributes.",
          "correct": true
        },
        {
          "id": "cp4",
          "type": "mcq",
          "question": "What is the best way to handle a function that might receive invalid input?",
          "options": [
            "Assume input is always valid",
            "Let the program crash",
            "Validate input and handle gracefully",
            "Use global variables"
          ],
          "correct": 2
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "When reviewing code, which is NOT a typical concern?",
          "options": [
            "Variable naming",
            "Error handling",
            "Computer hardware",
            "Code efficiency"
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

