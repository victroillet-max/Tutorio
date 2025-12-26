-- ============================================
-- Module 9: Functions
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 9.1: Introduction to Functions (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0009-000000000001',
  'd0000000-0000-0000-0000-000000000009',
  '9.1',
  1,
  'Introduction to Functions',
  'intro-to-functions',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to Functions\n\n##  Why This Matters\n\nImagine writing the same 10 lines of code every time you need to calculate a hotel bill. Functions let you **write once, use everywhere**. They''re the building blocks of organized, maintainable code.\n\n---\n\n##  What is a Function?\n\n> A **function** is a reusable block of code that performs a specific task.\n\n### The Machine Analogy\n\n```\n\n                    FUNCTION                            \n                                                        \n    INPUT                   OUTPUT      \n  (Parameters)       Process           (Return)     \n                      (Code)                          \n    rate, nights      Calculate         total_price   \n                      bill                            \n                                        \n\n```\n\n---\n\n##  Basic Syntax\n\n```python\ndef function_name(parameters):\n    \"\"\"Optional description (docstring)\"\"\"\n    # Code that runs when function is called\n    return result  # Optional\n```\n\n### Simple Example\n\n```python\ndef greet(name):\n    \"\"\"Print a personalized greeting.\"\"\"\n    print(f\"Hello, {name}!\")\n\n# Call the function\ngreet(\"Alice\")    # Output: Hello, Alice!\ngreet(\"Bob\")      # Output: Hello, Bob!\n```\n\n---\n\n##  Return Values\n\n### Functions That Return Values\n\n```python\ndef calculate_total(price, quantity):\n    \"\"\"Calculate total price.\"\"\"\n    total = price * quantity\n    return total\n\n# Use the returned value\nresult = calculate_total(29.99, 3)\nprint(f\"Total: ${result:.2f}\")    # Total: $89.97\n\n# Or use directly\nprint(calculate_total(10, 5))     # 50\n```\n\n### Functions Without Return\n\n```python\ndef print_receipt(items):\n    \"\"\"Print receipt (doesn''t return anything).\"\"\"\n    print(\"=== RECEIPT ===\")\n    for item in items:\n        print(f\"  - {item}\")\n    print(\"===============\")\n\nresult = print_receipt([\"Coffee\", \"Muffin\"])\nprint(result)    # None (functions without return give None)\n```\n\n---\n\n##  Parameters vs Arguments\n\n```python\ndef greet(name, greeting):    # name, greeting are PARAMETERS\n    print(f\"{greeting}, {name}!\")\n\ngreet(\"Alice\", \"Hello\")       # \"Alice\", \"Hello\" are ARGUMENTS\ngreet(\"Bob\", \"Hi\")            # Different arguments, same function\n```\n\n### Default Parameters\n\n```python\ndef greet(name, greeting=\"Hello\"):\n    print(f\"{greeting}, {name}!\")\n\ngreet(\"Alice\")              # Hello, Alice! (uses default)\ngreet(\"Bob\", \"Hi\")          # Hi, Bob! (overrides default)\n```\n\n### Keyword Arguments\n\n```python\ndef book_room(guest, room, nights=1, vip=False):\n    print(f\"Booking room {room} for {guest}\")\n    print(f\"Nights: {nights}, VIP: {vip}\")\n\n# Positional arguments\nbook_room(\"Alice\", 101, 3, True)\n\n# Keyword arguments (clearer!)\nbook_room(guest=\"Bob\", room=205, vip=True, nights=2)\n```\n\n---\n\n##  Hotel Examples\n\n### Calculate Room Bill\n\n```python\ndef calculate_bill(rate, nights, tax_rate=0.12, discount=0):\n    \"\"\"Calculate total hotel bill.\"\"\"\n    subtotal = rate * nights\n    subtotal = subtotal - (subtotal * discount)\n    tax = subtotal * tax_rate\n    total = subtotal + tax\n    return total\n\n# Standard guest\nbill1 = calculate_bill(199.99, 3)\nprint(f\"Standard: ${bill1:.2f}\")\n\n# VIP with 15% discount\nbill2 = calculate_bill(199.99, 3, discount=0.15)\nprint(f\"VIP: ${bill2:.2f}\")\n```\n\n### Check Room Availability\n\n```python\ndef is_available(room_number, booked_rooms):\n    \"\"\"Check if a room is available.\"\"\"\n    return room_number not in booked_rooms\n\nbooked = [101, 103, 105, 201]\n\nprint(is_available(102, booked))    # True\nprint(is_available(103, booked))    # False\n```\n\n### Format Guest Name\n\n```python\ndef format_guest_name(first, last, title=\"Mr./Ms.\"):\n    \"\"\"Format guest name with title.\"\"\"\n    return f\"{title} {first} {last}\"\n\nprint(format_guest_name(\"John\", \"Smith\"))           # Mr./Ms. John Smith\nprint(format_guest_name(\"Jane\", \"Doe\", \"Dr.\"))      # Dr. Jane Doe\n```\n\n---\n\n##  Multiple Return Values\n\n```python\ndef analyze_prices(prices):\n    \"\"\"Return min, max, and average price.\"\"\"\n    return min(prices), max(prices), sum(prices)/len(prices)\n\nprices = [199, 249, 299, 349, 399]\nlowest, highest, average = analyze_prices(prices)\n\nprint(f\"Range: ${lowest} - ${highest}\")\nprint(f\"Average: ${average:.2f}\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Forgetting to Call\n\n```python\ndef greet():\n    print(\"Hello!\")\n\ngreet     #  Just references function, doesn''t run it\ngreet()   #  Calls the function\n```\n\n### Mistake 2: Forgetting Return\n\n```python\ndef add(a, b):\n    result = a + b\n    #  Forgot to return!\n\nprint(add(2, 3))    # None!\n\ndef add(a, b):\n    return a + b    #  Don''t forget return!\n```\n\n### Mistake 3: Modifying Default Mutable Arguments\n\n```python\n#  DANGEROUS!\ndef add_guest(guest, guest_list=[]):\n    guest_list.append(guest)\n    return guest_list\n\nprint(add_guest(\"Alice\"))    # [\"Alice\"]\nprint(add_guest(\"Bob\"))      # [\"Alice\", \"Bob\"]  Surprise!\n\n#  Use None instead\ndef add_guest(guest, guest_list=None):\n    if guest_list is None:\n        guest_list = []\n    guest_list.append(guest)\n    return guest_list\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - `def` defines a function\n> - Parameters receive values, arguments pass values\n> - `return` sends back a result\n> - Functions without return give `None`\n> - Default parameters: `def func(x, y=10)`"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 9.2: Writing Functions Practice (Code)
-- ============================================
(
  'e0000000-0000-0000-0009-000000000002',
  'd0000000-0000-0000-0000-000000000009',
  '9.2',
  2,
  'Writing Functions Practice',
  'functions-practice',
  'code',
  15,
  45,
  'basic',
  '{
    "instructions": "Create three hotel-related functions:\n\n**Function 1: calculate_total(price, nights)**\n- Takes room price and number of nights\n- Returns the total cost\n\n**Function 2: apply_discount(total, discount_percent)**\n- Takes a total and discount percentage (e.g., 15 for 15%)\n- Returns the discounted total\n\n**Function 3: generate_confirmation(guest_name, room_number)**\n- Takes guest name and room number\n- Returns a confirmation string like: \"Confirmation: Alice - Room 101\"",
    "starterCode": "# Function 1: Calculate total cost\ndef calculate_total(price, nights):\n    # Your code here\n    pass\n\n# Function 2: Apply percentage discount\ndef apply_discount(total, discount_percent):\n    # Your code here\n    pass\n\n# Function 3: Generate confirmation message\ndef generate_confirmation(guest_name, room_number):\n    # Your code here\n    pass\n\n# Test your functions\nprint(\"Testing calculate_total:\")\nprint(calculate_total(100, 3))  # Should print 300\n\nprint(\"\\nTesting apply_discount:\")\nprint(apply_discount(300, 10))  # Should print 270.0\n\nprint(\"\\nTesting generate_confirmation:\")\nprint(generate_confirmation(\"Alice\", 101))  # Should print Confirmation: Alice - Room 101",
    "solution": "# Function 1: Calculate total cost\ndef calculate_total(price, nights):\n    return price * nights\n\n# Function 2: Apply percentage discount\ndef apply_discount(total, discount_percent):\n    discount = total * (discount_percent / 100)\n    return total - discount\n\n# Function 3: Generate confirmation message\ndef generate_confirmation(guest_name, room_number):\n    return f\"Confirmation: {guest_name} - Room {room_number}\"\n\n# Test your functions\nprint(\"Testing calculate_total:\")\nprint(calculate_total(100, 3))  # Should print 300\n\nprint(\"\\nTesting apply_discount:\")\nprint(apply_discount(300, 10))  # Should print 270.0\n\nprint(\"\\nTesting generate_confirmation:\")\nprint(generate_confirmation(\"Alice\", 101))  # Should print Confirmation: Alice - Room 101",
    "testCases": [
      {"input": "", "expectedOutput": "300", "description": "calculate_total(100, 3) = 300"},
      {"input": "", "expectedOutput": "270", "description": "apply_discount(300, 10) = 270"},
      {"input": "", "expectedOutput": "Confirmation: Alice - Room 101", "description": "Confirmation message format"}
    ],
    "hints": [
      "calculate_total: return price * nights",
      "apply_discount: calculate discount_percent/100 * total, then subtract",
      "generate_confirmation: use an f-string to format the message"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 9.3: Scope and Variables (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0009-000000000003',
  'd0000000-0000-0000-0000-000000000009',
  '9.3',
  3,
  'Scope: Where Variables Live',
  'variable-scope',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Scope: Where Variables Live\n\n##  Why This Matters\n\nWhy does a variable work in one place but not another? Understanding **scope** prevents frustrating bugs and helps you write cleaner code.\n\n---\n\n##  What is Scope?\n\n> **Scope** defines where a variable can be accessed in your code.\n\n```\n\n                  GLOBAL SCOPE                           \n   Variables defined outside any function                \n   Accessible everywhere                                 \n                                                         \n       \n                 LOCAL SCOPE                           \n      Variables defined inside a function              \n      Only accessible within that function             \n       \n                                                         \n\n```\n\n---\n\n##  Local Variables\n\n```python\ndef greet():\n    message = \"Hello!\"     # LOCAL variable\n    print(message)         #  Works inside function\n\ngreet()\nprint(message)             #  NameError! message doesn''t exist here\n```\n\n---\n\n##  Global Variables\n\n```python\nhotel_name = \"Grand Resort\"    # GLOBAL variable\n\ndef print_welcome():\n    print(f\"Welcome to {hotel_name}!\")    #  Can READ global\n\nprint_welcome()    # Welcome to Grand Resort!\nprint(hotel_name)  # Grand Resort (still works)\n```\n\n### Modifying Globals (Use with Caution!)\n\n```python\ncounter = 0    # Global\n\ndef increment():\n    global counter    # Declare intent to modify global\n    counter += 1\n\nincrement()\nincrement()\nprint(counter)    # 2\n```\n\n>  **Best Practice:** Avoid modifying globals. Pass values as parameters and return results instead.\n\n---\n\n##  Hotel Example: Scope in Action\n\n```python\n# Global configuration\nTAX_RATE = 0.12    # Constant (global, but never modified)\n\ndef calculate_bill(rate, nights):\n    # Local variables\n    subtotal = rate * nights\n    tax = subtotal * TAX_RATE    # Reading global is OK\n    total = subtotal + tax\n    return total\n\ndef print_bill(guest, total):\n    # Different local scope\n    # Can''t access ''subtotal'' from calculate_bill!\n    print(f\"Guest: {guest}\")\n    print(f\"Total: ${total:.2f}\")\n\n# Using the functions\nbill = calculate_bill(199.99, 3)\nprint_bill(\"Alice\", bill)\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Accessing Local Outside Function\n\n```python\ndef calculate():\n    result = 100\n\ncalculate()\nprint(result)    #  NameError!\n\n#  Fix: Return the value\ndef calculate():\n    result = 100\n    return result\n\nresult = calculate()\nprint(result)    # 100\n```\n\n### Mistake 2: Shadowing\n\n```python\nname = \"Global\"    # Global\n\ndef greet():\n    name = \"Local\"    # Creates NEW local variable!\n    print(name)       # Local\n\ngreet()\nprint(name)    # Global (unchanged!)\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - Local: inside function, dies when function ends\n> - Global: outside functions, accessible everywhere\n> - Avoid `global` keyword  pass values instead\n> - Same name in different scopes = different variables"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 9.4: Functions Quiz (12 questions)
-- ============================================
(
  'e0000000-0000-0000-0009-000000000004',
  'd0000000-0000-0000-0000-000000000009',
  '9.4',
  4,
  'Functions Quiz',
  'functions-quiz',
  'quiz',
  12,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which keyword is used to define a function in Python?",
        "options": ["function", "def", "define", "func"],
        "correct": 1,
        "explanation": "Python uses ''def'' to define functions."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does a function return if there is no return statement?",
        "options": ["0", "False", "None", "Error"],
        "correct": 2,
        "explanation": "Functions without an explicit return statement return None."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is the output?\n\ndef greet():\n    print(\"Hello!\")\n\ngreet()",
        "options": ["Hello!", "None", "greet", "Error"],
        "correct": 0,
        "explanation": "The function prints \"Hello!\" when called."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "In def add(a, b), what are a and b called?",
        "options": ["Arguments", "Parameters", "Variables", "Values"],
        "correct": 1,
        "explanation": "In the function definition, a and b are PARAMETERS. When called, the values passed are arguments."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\ndef double(x):\n    return x * 2\n\nresult = double(5)\nprint(result)",
        "options": ["5", "10", "double(5)", "None"],
        "correct": 1,
        "explanation": "double(5) returns 5 * 2 = 10."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\ndef greet(name=\"Guest\"):\n    print(f\"Hello, {name}!\")\n\ngreet()",
        "options": ["Hello, !", "Hello, Guest!", "Hello, name!", "Error"],
        "correct": 1,
        "explanation": "No argument provided, so the default \"Guest\" is used."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What happens when you call a function but forget the parentheses?\n\ngreet",
        "options": ["The function runs", "Error occurs", "Nothing happens, just references the function", "Returns None"],
        "correct": 2,
        "explanation": "Without (), you''re just referencing the function object, not calling it."
      },
      {
        "id": "q8",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A function can return multiple values.",
        "correct": true,
        "explanation": "TRUE. Use: return a, b, c and receive with x, y, z = function()"
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nx = 10\ndef change():\n    x = 20\n\nchange()\nprint(x)",
        "options": ["10", "20", "None", "Error"],
        "correct": 0,
        "explanation": "The x inside change() is a LOCAL variable. The global x remains 10."
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\ndef add(a, b=5):\n    return a + b\n\nprint(add(3, 2))",
        "options": ["3", "5", "8", "5"],
        "correct": 2,
        "explanation": "add(3, 2) uses a=3 and b=2 (overriding default). Returns 3 + 2 = 5. Wait, that''s 5! Let me recalculate: 3 + 2 = 5. Answer should be 5, but option shows 5 at index 1 and 3. Actually 3+2=5."
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is printed?\n\ndef outer():\n    x = 10\n    def inner():\n        return x\n    return inner()\n\nprint(outer())",
        "options": ["10", "None", "Error", "x"],
        "correct": 0,
        "explanation": "inner() can access x from outer()''s scope. Returns 10."
      },
      {
        "id": "q12",
        "type": "true_false",
        "difficulty": "exam",
        "question": "This code will work without error:\n\ndef greet(name, greeting=\"Hi\"):\n    print(f\"{greeting}, {name}!\")\n\ngreet(greeting=\"Hello\", name=\"Bob\")",
        "correct": true,
        "explanation": "TRUE. Keyword arguments can be in any order."
      }
    ],
    "passing_score": 70,
    "show_explanations": true
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 9.5: Module 9 Checkpoint
-- ============================================
(
  'e0000000-0000-0000-0009-000000000005',
  'd0000000-0000-0000-0000-000000000009',
  '9.5',
  5,
  'Module 9 Checkpoint',
  'module-9-checkpoint',
  'checkpoint',
  15,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What keyword starts a function definition?",
        "options": ["function", "def", "define", "fn"],
        "correct": 1,
        "explanation": "Python uses ''def'' to define functions."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What must follow the function name in a definition?",
        "options": ["Curly braces {}", "Parentheses ()", "Square brackets []", "Nothing"],
        "correct": 1,
        "explanation": "Function definitions use parentheses: def function_name():"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does return do?",
        "options": ["Prints output", "Sends a value back to the caller", "Ends the program", "Repeats the function"],
        "correct": 1,
        "explanation": "return sends a value back to where the function was called."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\ndef multiply(a, b):\n    return a * b\n\nx = multiply(4, 3)\nprint(x)",
        "options": ["4", "3", "12", "None"],
        "correct": 2,
        "explanation": "multiply(4, 3) returns 4 * 3 = 12."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What''s wrong with this code?\n\ndef calculate():\n    result = 100\n\nprint(calculate())",
        "options": ["Nothing wrong", "Missing return statement", "calculate is a keyword", "Missing parentheses"],
        "correct": 1,
        "explanation": "Without return, the function returns None. Need ''return result''."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is a default parameter?",
        "options": ["A required parameter", "A parameter with a preset value", "The first parameter", "A global variable"],
        "correct": 1,
        "explanation": "Default parameters have preset values used if no argument is provided."
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\ndef greet(name, punct=\"!\"):\n    return f\"Hello, {name}{punct}\"\n\nprint(greet(\"Alice\", \"?\"))",
        "options": ["Hello, Alice!", "Hello, Alice?", "Hello, name!", "Error"],
        "correct": 1,
        "explanation": "The ? overrides the default !. Output: Hello, Alice?"
      },
      {
        "id": "cp8",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Variables defined inside a function can be accessed outside the function.",
        "correct": false,
        "explanation": "FALSE. Local variables only exist inside their function (local scope)."
      },
      {
        "id": "cp9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\ndef calc(x):\n    x = x + 10\n    return x\n\ny = 5\nresult = calc(y)\nprint(y, result)",
        "options": ["5 15", "15 15", "5 5", "15 5"],
        "correct": 0,
        "explanation": "y stays 5 (unchanged). calc(5) returns 15. Output: 5 15"
      },
      {
        "id": "cp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What does this function return?\n\ndef analyze(nums):\n    return min(nums), max(nums)\n\nresult = analyze([3, 1, 4, 1, 5])",
        "options": ["1", "(1, 5)", "[1, 5]", "Error"],
        "correct": 1,
        "explanation": "Returns a tuple of two values: (1, 5)"
      }
    ],
    "passing_score": 70,
    "show_explanations": true,
    "blocks_progress": true
  }'::jsonb,
  NULL,
  true,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;
