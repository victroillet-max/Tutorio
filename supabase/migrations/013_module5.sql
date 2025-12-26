-- ============================================
-- Module 5: Variables & Data Types
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 5.1: Variables Explained (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0005-000000000001',
  'd0000000-0000-0000-0000-000000000005',
  '5.1',
  1,
  'Variables: Your Data Containers',
  'variables-explained',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Variables: Your Data Containers\n\n##  Why This Matters\n\nEvery program needs to remember information: guest names, room numbers, prices, dates. **Variables are how programs store and retrieve data.** Without variables, every calculation would start from zero!\n\n---\n\n##  What is a Variable?\n\n> A **variable** is a named container that stores data in your program''s memory.\n\n### The Box Analogy\n\n```\n\n                    MEMORY (Your closet)                 \n                                                         \n           \n    guest_name      room_number       price       \n           \n      \"Smith\"           405           199.99      \n           \n       (Box 1)           (Box 2)           (Box 3)      \n                                                         \n   Each box has:                                        \n    A LABEL (variable name)                            \n    CONTENTS (the value)                               \n\n```\n\n---\n\n##  Creating Variables\n\n### The Assignment Operator (=)\n\n```python\nvariable_name = value\n```\n\nThe `=` sign **assigns** a value to a variable. Read it as \"is set to\" or \"gets\":\n\n```python\nguest_name = \"Alice\"     # guest_name IS SET TO \"Alice\"\nroom_number = 405        # room_number GETS 405\nprice = 199.99           # price IS SET TO 199.99\nis_vip = True            # is_vip GETS True\n```\n\n>  **Important:** `=` is NOT mathematical equality! It''s an assignment.\n\n---\n\n##  Variable Naming Rules\n\n### Must Follow\n\n| Rule | Valid  | Invalid  |\n|------|----------|------------|\n| Start with letter or `_` | `name`, `_id` | `1name` |\n| Only letters, numbers, `_` | `room_405` | `room-405`, `room 405` |\n| No Python keywords | `my_class` | `class`, `if`, `for` |\n| Case-sensitive | `age`  `Age`  `AGE` | |\n\n### Should Follow (Best Practices)\n\n```python\n#  Good: Descriptive, snake_case\nguest_name = \"Smith\"\ntotal_price = 599.99\nis_checked_in = True\nmax_occupancy = 4\n\n#  Bad: Unclear, hard to read\nx = \"Smith\"\ntp = 599.99\nflag = True\nn = 4\n```\n\n---\n\n##  Variables Can Change\n\nThat''s why they''re called \"variables\"  their values can **vary**!\n\n```python\nscore = 0           # Initial value\nprint(score)        # Output: 0\n\nscore = 100         # Changed!\nprint(score)        # Output: 100\n\nscore = score + 50  # Add 50 to current value\nprint(score)        # Output: 150\n```\n\n### Visualizing Changes\n\n```\nStep 1: score = 0\n\n score   \n\n    0    \n\n\nStep 2: score = 100\n\n score   \n\n   100      Value replaced!\n\n\nStep 3: score = score + 50\n\n score   \n\n   150      100 + 50\n\n```\n\n---\n\n##  Multiple Assignment\n\n### Same Value to Multiple Variables\n\n```python\nx = y = z = 0        # All three are 0\nprint(x, y, z)       # Output: 0 0 0\n```\n\n### Different Values in One Line\n\n```python\nname, age, city = \"Alice\", 25, \"Lausanne\"\nprint(name)          # Alice\nprint(age)           # 25\nprint(city)          # Lausanne\n```\n\n### Swapping Values\n\n```python\na = 1\nb = 2\n\n# Python magic: swap in one line!\na, b = b, a\n\nprint(a)             # 2\nprint(b)             # 1\n```\n\n---\n\n##  Hotel Examples\n\n### Guest Check-In\n\n```python\n# Guest information\nguest_name = \"Sarah Johnson\"\nguest_email = \"sarah@email.com\"\nloyalty_points = 15000\nis_vip = True\n\n# Booking details\nroom_number = 508\nroom_type = \"Deluxe Suite\"\nrate_per_night = 299.99\nnights = 3\n\n# Calculate total\ntotal = rate_per_night * nights\n\n# Apply VIP discount\nif is_vip:\n    discount = total * 0.15    # 15% off\n    total = total - discount\n\nprint(f\"Guest: {guest_name}\")\nprint(f\"Room: {room_number} ({room_type})\")\nprint(f\"Total: ${total:.2f}\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Using Before Defining\n\n```python\nprint(price)         #  NameError: ''price'' not defined\nprice = 99.99\nprint(price)         #  Works now\n```\n\n### Mistake 2: Wrong Order in Assignment\n\n```python\n10 = x               #  SyntaxError\nx = 10               #  Variable on LEFT, value on RIGHT\n```\n\n### Mistake 3: Confusing = and ==\n\n```python\nx = 5                #  ASSIGNMENT: x gets value 5\nx == 5               # Comparison: \"is x equal to 5?\" (returns True)\n```\n\n### Mistake 4: Spaces in Names\n\n```python\nguest name = \"Smith\"   #  SyntaxError\nguest_name = \"Smith\"   #  Use underscore\n```\n\n---\n\n##  Pro Tips\n\n1. **Name for readability**  `nights_stayed` beats `n` every time\n\n2. **Be consistent**  Pick a style and stick to it\n\n3. **Update, don''t recreate**  `x = x + 1` rather than complex reassignment\n\n4. **Use meaningful prefixes**  `is_`, `has_`, `can_` for booleans\n\n5. **Comment complex variables**  Explain units or constraints\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Variables store data with a name and value\n> - `=` is assignment, not equality\n> - Names: start with letter/underscore, no spaces, case-sensitive\n> - Use `snake_case` for variable names\n> - Variables can change (that''s why they''re \"variable\"!)\n\n**Memory Hook:** Variables are like **labeled boxes**  the label is the name, the contents are the value!"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 5.2: Variable Visualizer (Interactive)
-- ============================================
(
  'e0000000-0000-0000-0005-000000000002',
  'd0000000-0000-0000-0000-000000000005',
  '5.2',
  2,
  'Variable Memory Visualizer',
  'variable-visualizer',
  'interactive',
  8,
  30,
  'basic',
  '{
    "instructions": "Watch how variables are stored and changed in memory as you execute each line of code. Click ''Next'' to step through the program.",
    "type": "memory-visualizer",
    "codeSteps": [
      {"code": "x = 5", "memory": {"x": 5}, "explanation": "Variable x is created and stores the value 5"},
      {"code": "y = 10", "memory": {"x": 5, "y": 10}, "explanation": "Variable y is created and stores 10. x still exists."},
      {"code": "x = x + y", "memory": {"x": 15, "y": 10}, "explanation": "x is UPDATED to its old value (5) plus y (10). New x = 15."},
      {"code": "z = x * 2", "memory": {"x": 15, "y": 10, "z": 30}, "explanation": "New variable z is created. z = 15  2 = 30."},
      {"code": "y = z", "memory": {"x": 15, "y": 30, "z": 30}, "explanation": "y is updated to the current value of z (30). Now y and z are both 30."},
      {"code": "x = 0", "memory": {"x": 0, "y": 30, "z": 30}, "explanation": "x is reset to 0. Previous value (15) is lost."}
    ],
    "finalQuestion": {
      "question": "After all steps, what is the value of x + y + z?",
      "options": ["55", "60", "45", "0"],
      "correct": 1,
      "explanation": "x=0, y=30, z=30. So 0 + 30 + 30 = 60"
    }
  }'::jsonb,
  'memory-visualizer',
  false,
  true
),

-- ============================================
-- Activity 5.3: Data Types Overview (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0005-000000000003',
  'd0000000-0000-0000-0000-000000000005',
  '5.3',
  3,
  'Data Types: The Four Fundamentals',
  'data-types-overview',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Data Types: The Four Fundamentals\n\n##  Why This Matters\n\nNot all data is the same: a guest''s name is text, their room number is a whole number, and their bill is a decimal. **Python needs to know what TYPE of data it''s working with** to handle it correctly.\n\n---\n\n##  The Four Basic Types\n\n```\n\n              PYTHON''S BASIC DATA TYPES                  \n\n                                                         \n                              \n      int            float                          \n                              \n    42, -17,       3.14,                            \n    0, 1000        -0.5, 2.0                        \n    (Integers)     (Decimals)                       \n                              \n                                                         \n                              \n      str            bool                           \n                              \n    \"Hello\",       True,                            \n    ''Python''      False                            \n    (Text)         (Yes/No)                         \n                              \n                                                         \n\n```\n\n---\n\n##  Integer (int)\n\n> Whole numbers, positive or negative, without decimals.\n\n```python\nroom_number = 405\nfloor = 4\nmax_occupancy = 2\ntemperature = -5        # Negative integers work too\npopulation = 1_000_000  # Underscores for readability\n```\n\n### When to Use Integers\n- Counting (guests, rooms, nights)\n- IDs and codes (room 405, order #1234)\n- Quantities (3 towels, 5 pillows)\n- Whole measurements (42 floors)\n\n---\n\n##  Float (float)\n\n> Decimal numbers (\"floating-point\").\n\n```python\nprice = 199.99\ntax_rate = 0.08\nrating = 4.7\npi = 3.14159\ntemperature = 98.6\n```\n\n### When to Use Floats\n- Money (prices, taxes, totals)\n- Measurements (weight, height, temperature)\n- Ratings and scores (4.5 stars)\n- Percentages (0.15 = 15%)\n\n###  Float Precision Warning\n\n```python\nprint(0.1 + 0.2)    # Output: 0.30000000000000004 (not 0.3!)\n```\n\n*Floats have tiny rounding errors. For precise money calculations, use the `decimal` module.*\n\n---\n\n##  String (str)\n\n> Text data  sequences of characters in quotes.\n\n```python\nguest_name = \"Sarah Johnson\"     # Double quotes\nroom_type = ''Deluxe Suite''       # Single quotes\nemail = \"sarah@email.com\"\n\n# Long text with triple quotes\nwelcome = \"\"\"Welcome to our hotel!\nWe hope you enjoy your stay.\nCheckout is at 11:00 AM.\"\"\"\n```\n\n### When to Use Strings\n- Names and text (guest_name, address)\n- Identifiers that look like numbers (\"Room 405\", \"Order #123\")\n- Messages and labels\n- Any data you won''t do math with\n\n### Strings with Numbers Inside\n\n```python\nroom_code = \"405\"      # String - for display/lookup\nroom_number = 405      # Integer - for calculations\n\n# These are DIFFERENT!\nprint(\"405\" + \"1\")     # Output: \"4051\" (concatenation)\nprint(405 + 1)         # Output: 406 (addition)\n```\n\n---\n\n##  Boolean (bool)\n\n> True or False  only two possible values.\n\n```python\nis_vip = True\nhas_paid = False\nroom_available = True\nneeds_cleaning = False\n```\n\n### When to Use Booleans\n- Yes/No questions (is_member, has_reservation)\n- Status flags (is_active, is_complete)\n- Conditions (room_available, payment_received)\n- Feature toggles (show_discount, enable_notifications)\n\n### Boolean Naming Convention\n\n```python\n#  Good: Reads like a question\nis_vip = True          # \"Is VIP?\"  True\nhas_paid = False       # \"Has paid?\"  False\ncan_upgrade = True     # \"Can upgrade?\"  True\n\n#  Bad: Unclear\nvip = True             # Is this VIP status or VIP name?\npaid = False           # Past tense, but means \"has paid\"?\n```\n\n---\n\n##  Checking Types with type()\n\n```python\nx = 42\ny = 3.14\nz = \"Hello\"\nw = True\n\nprint(type(x))    # <class ''int''>\nprint(type(y))    # <class ''float''>\nprint(type(z))    # <class ''str''>\nprint(type(w))    # <class ''bool''>\n```\n\n---\n\n##  Hotel Example: Type Matters!\n\n```python\n# Guest Booking System\n\n# Strings - text data\nguest_name = \"Maria Garcia\"      # str\nemail = \"maria@email.com\"        # str\nconfirmation = \"HGL-2024-0315\"   # str (not a number!)\n\n# Integers - whole numbers\nroom_number = 712                # int\nnights = 3                       # int\nadults = 2                       # int\nchildren = 1                     # int\n\n# Floats - decimals\nrate_per_night = 249.99          # float\ntax_rate = 0.12                  # float (12%)\n\n# Booleans - yes/no\nis_loyalty_member = True         # bool\nlate_checkout_requested = False  # bool\n\n# Calculations use the right types!\nsubtotal = rate_per_night * nights     # float  int = float\ntax = subtotal * tax_rate              # float  float = float\ntotal = subtotal + tax                 # float + float = float\n\nif is_loyalty_member:                  # bool in condition\n    total = total * 0.90               # 10% discount\n\nprint(f\"Guest: {guest_name}\")\nprint(f\"Room: {room_number}\")\nprint(f\"Total: ${total:.2f}\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Wrong Type for Numbers\n\n```python\nroom = \"405\"           # String\nnext_room = room + 1   #  TypeError!\n\nroom = 405             # Integer\nnext_room = room + 1   #  = 406\n```\n\n### Mistake 2: Forgetting Quotes for Strings\n\n```python\nname = John            #  NameError: John not defined\nname = \"John\"          #  Correct\n```\n\n### Mistake 3: Mixing String and Number\n\n```python\nprice = \"100\"\ntax = 10\ntotal = price + tax    #  TypeError!\n\ntotal = int(price) + tax   #  Convert first: 110\n```\n\n---\n\n##  Summary: Key Takeaways\n\n| Type | Example | Use For |\n|------|---------|----------|\n| **int** | `42`, `-5`, `0` | Counting, IDs, whole numbers |\n| **float** | `3.14`, `99.99` | Prices, measurements, decimals |\n| **str** | `\"Hello\"`, `''Python''` | Text, names, identifiers |\n| **bool** | `True`, `False` | Yes/no, conditions, flags |\n\n> **Memory Hook:** Think of types like **categories in a filing cabinet**  numbers in one drawer, text in another!"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 5.4: Type Detective Game (Interactive)
-- ============================================
(
  'e0000000-0000-0000-0005-000000000004',
  'd0000000-0000-0000-0000-000000000005',
  '5.4',
  4,
  'Type Detective Challenge',
  'type-detective-game',
  'interactive',
  10,
  35,
  'basic',
  '{
    "instructions": "Identify the data type of each value. Some are tricky  pay attention to quotes and decimal points!",
    "type": "type-game",
    "challenges": [
      {"value": "42", "correctType": "int", "display": "42", "explanation": "No quotes, no decimal = integer"},
      {"value": "\"42\"", "correctType": "str", "display": "\"42\"", "explanation": "Quotes make it a STRING, even if it looks like a number"},
      {"value": "3.14", "correctType": "float", "display": "3.14", "explanation": "Has decimal point = float"},
      {"value": "3.0", "correctType": "float", "display": "3.0", "explanation": "3.0 is a float (has decimal) even though it''s a whole number"},
      {"value": "True", "correctType": "bool", "display": "True", "explanation": "True and False are boolean values"},
      {"value": "\"True\"", "correctType": "str", "display": "\"True\"", "explanation": "With quotes, it''s a STRING that contains the text ''True''"},
      {"value": "\"Hello World\"", "correctType": "str", "display": "\"Hello World\"", "explanation": "Text in quotes = string"},
      {"value": "-5", "correctType": "int", "display": "-5", "explanation": "Negative whole number = integer"},
      {"value": "-5.0", "correctType": "float", "display": "-5.0", "explanation": "Has decimal point = float"},
      {"value": "False", "correctType": "bool", "display": "False", "explanation": "False is a boolean value"},
      {"value": "0", "correctType": "int", "display": "0", "explanation": "Zero is an integer"},
      {"value": "\"\"", "correctType": "str", "display": "\"\" (empty quotes)", "explanation": "Empty quotes = empty string (still a string!)"}
    ],
    "scoring": {
      "correct": 8,
      "incorrect": -2,
      "passingScore": 70
    }
  }'::jsonb,
  'type-game',
  false,
  true
),

-- ============================================
-- Activity 5.5: Arithmetic Operators (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0005-000000000005',
  'd0000000-0000-0000-0000-000000000005',
  '5.5',
  5,
  'Arithmetic Operators',
  'arithmetic-operators',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Arithmetic Operators\n\n##  Why This Matters\n\nCalculating totals, applying discounts, splitting bills  programming is full of math. **Python''s arithmetic operators let you perform calculations just like a calculator, but with the power of automation.**\n\n---\n\n##  The Seven Operators\n\n```\n\n Operator    Name              Example      Result  \n\n     +       Addition          5 + 3           8    \n     -       Subtraction       5 - 3           2    \n     *       Multiplication    5 * 3          15    \n     /       Division          5 / 2          2.5   \n    //       Floor Division    5 // 2          2    \n     %       Modulus           5 % 2           1    \n    **       Exponentiation    5 ** 2         25    \n\n```\n\n---\n\n##  Division: Regular vs Floor\n\n### Regular Division (/)  Always Returns Float\n\n```python\nprint(10 / 3)     # 3.3333...\nprint(10 / 2)     # 5.0 (float, not int!)\nprint(7 / 2)      # 3.5\n```\n\n### Floor Division (//)  Rounds DOWN to Integer\n\n```python\nprint(10 // 3)    # 3 (not 3.33)\nprint(10 // 2)    # 5\nprint(7 // 2)     # 3 (rounds down, not 4)\nprint(-7 // 2)    # -4 (rounds toward negative infinity)\n```\n\n---\n\n##  Modulus (%)  The Remainder\n\n```python\nprint(10 % 3)     # 1 (10 = 33 + 1)\nprint(10 % 2)     # 0 (10 = 52 + 0)\nprint(17 % 5)     # 2 (17 = 35 + 2)\n```\n\n### Practical Uses\n\n```python\n# Check if a number is even or odd\nnumber = 42\nif number % 2 == 0:\n    print(\"Even\")\nelse:\n    print(\"Odd\")\n\n# Cycle through options (0, 1, 2, 0, 1, 2, ...)\nday_index = 7 % 3    # = 1 (7 = 23 + 1)\n```\n\n---\n\n##  Exponentiation (**)\n\n```python\nprint(2 ** 3)     # 8 (2  2  2)\nprint(5 ** 2)     # 25 (5  5)\nprint(10 ** 0)    # 1 (anything to power 0 = 1)\nprint(9 ** 0.5)   # 3.0 (square root!)\n```\n\n---\n\n##  Order of Operations (PEMDAS)\n\n```\n\n           ORDER OF OPERATIONS               \n                                             \n   P    Parentheses         ( )            \n   E    Exponents           **             \n   MD   Multiply/Divide     * / // %       \n   AS   Add/Subtract        + -            \n                                             \n   (Left to right for same level)           \n\n```\n\n### Examples\n\n```python\nprint(2 + 3 * 4)       # 14 (multiply first: 3*4=12, then 2+12=14)\nprint((2 + 3) * 4)     # 20 (parentheses first: 5*4=20)\nprint(10 - 3 - 2)      # 5 (left to right: 7-2=5)\nprint(2 ** 3 ** 2)     # 512 (right to left for **: 2^9=512)\n```\n\n---\n\n##  Hotel Calculations\n\n### Calculate Total Bill\n\n```python\nrate_per_night = 199.99\nnights = 3\ntax_rate = 0.12          # 12%\n\nsubtotal = rate_per_night * nights    # 599.97\ntax = subtotal * tax_rate             # 71.9964\ntotal = subtotal + tax                # 671.9664\n\nprint(f\"Total: ${total:.2f}\")         # Total: $671.97\n```\n\n### Split Bill Evenly\n\n```python\ntotal_bill = 150\nnum_guests = 4\n\nper_person = total_bill / num_guests  # 37.5\nprint(f\"Each pays: ${per_person:.2f}\")\n\n# Check if split is even\nremainder = total_bill % num_guests   # 150 % 4 = 2\nif remainder == 0:\n    print(\"Splits evenly!\")\nelse:\n    print(f\"${remainder} left over\")\n```\n\n### Apply Percentage Discount\n\n```python\noriginal_price = 299.99\ndiscount_percent = 15\n\n# Calculate discount\ndiscount_amount = original_price * (discount_percent / 100)  # 44.9985\nfinal_price = original_price - discount_amount               # 255.00\n\nprint(f\"Original: ${original_price:.2f}\")\nprint(f\"Discount: -${discount_amount:.2f}\")\nprint(f\"Final: ${final_price:.2f}\")\n```\n\n---\n\n##  Compound Assignment Operators\n\n```python\n# Instead of: x = x + 5\nx += 5      # Add and assign\n\nx -= 3      # x = x - 3\nx *= 2      # x = x * 2\nx /= 4      # x = x / 4\nx //= 2     # x = x // 2\nx %= 3      # x = x % 3\nx **= 2     # x = x ** 2\n```\n\n### Example: Points System\n\n```python\npoints = 100\n\npoints += 50     # Earned 50 points  150\npoints -= 25     # Redeemed 25 points  125\npoints *= 2      # Double points promotion  250\npoints //= 3     # Some weird rule  83\n\nprint(f\"Final points: {points}\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Integer Division Surprise\n\n```python\n# In Python 3, / always returns float\nprint(10 / 2)     # 5.0 (not 5)\n\n# Use // for integer result\nprint(10 // 2)    # 5\n```\n\n### Mistake 2: Forgetting Order of Operations\n\n```python\ndiscount = 100 + 50 * 0.1    # = 105 (not 15!)\ndiscount = (100 + 50) * 0.1  # = 15 (parentheses!)\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - `/` = regular division (returns float)\n> - `//` = floor division (rounds down)\n> - `%` = modulus (remainder)\n> - `**` = exponentiation (power)\n> - PEMDAS order of operations\n> - Compound operators: `+=`, `-=`, `*=`, etc."}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 5.6: Calculator Exercise (Code)
-- ============================================
(
  'e0000000-0000-0000-0005-000000000006',
  'd0000000-0000-0000-0000-000000000005',
  '5.6',
  6,
  'Hotel Bill Calculator',
  'calculator-exercise',
  'code',
  12,
  40,
  'basic',
  '{
    "instructions": "Create a hotel bill calculator!\n\n**Given:**\n- Room rate: $199.99 per night\n- Number of nights: 3\n- Room service charges: $45.50\n- Tax rate: 12% (0.12)\n\n**Calculate and print:**\n1. Room charges (rate  nights)\n2. Subtotal (room + room service)\n3. Tax amount (subtotal  tax rate)\n4. Final total (subtotal + tax)\n\n**Expected output format:**\nRoom charges: $XXX.XX\nSubtotal: $XXX.XX\nTax (12%): $XX.XX\nTotal: $XXX.XX",
    "starterCode": "# Hotel Bill Calculator\n\n# Given values\nroom_rate = 199.99\nnights = 3\nroom_service = 45.50\ntax_rate = 0.12\n\n# Calculate room charges\n\n\n# Calculate subtotal\n\n\n# Calculate tax\n\n\n# Calculate total\n\n\n# Print the bill (use f-strings with :.2f for money)\nprint(\"========== HOTEL BILL ==========\")\n",
    "solution": "# Hotel Bill Calculator\n\n# Given values\nroom_rate = 199.99\nnights = 3\nroom_service = 45.50\ntax_rate = 0.12\n\n# Calculate room charges\nroom_charges = room_rate * nights\n\n# Calculate subtotal\nsubtotal = room_charges + room_service\n\n# Calculate tax\ntax = subtotal * tax_rate\n\n# Calculate total\ntotal = subtotal + tax\n\n# Print the bill\nprint(\"========== HOTEL BILL ==========\")\nprint(f\"Room charges: ${room_charges:.2f}\")\nprint(f\"Room service: ${room_service:.2f}\")\nprint(f\"Subtotal: ${subtotal:.2f}\")\nprint(f\"Tax (12%): ${tax:.2f}\")\nprint(f\"Total: ${total:.2f}\")\nprint(\"=================================\")",
    "testCases": [
      {"input": "", "expectedOutput": "Room charges: $599.97", "description": "Room charges should be 199.99  3"},
      {"input": "", "expectedOutput": "Total:", "description": "Should include total"}
    ],
    "hints": [
      "room_charges = room_rate * nights",
      "subtotal = room_charges + room_service",
      "tax = subtotal * tax_rate",
      "Use f-strings: f\"${variable:.2f}\" for money formatting"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 5.7: Strings & f-strings (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0005-000000000007',
  'd0000000-0000-0000-0000-000000000005',
  '5.7',
  7,
  'Strings & f-strings',
  'strings-and-fstrings',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Strings & f-strings\n\n##  Why This Matters\n\nText is everywhere in programs: names, messages, addresses, confirmation numbers. **Mastering strings means you can manipulate and format text like a pro.**\n\n---\n\n##  String Basics\n\n### Creating Strings\n\n```python\n# Single or double quotes (both work!)\nname = \"Alice\"\ngreeting = ''Hello''\n\n# Triple quotes for multi-line\nwelcome = \"\"\"Welcome to our hotel!\nWe hope you enjoy your stay.\nCheckout is at 11:00 AM.\"\"\"\n```\n\n### Escape Characters\n\n```python\nprint(\"She said \\\"Hello\\\"\")   # She said \"Hello\"\nprint(''It\\''s sunny'')          # It''s sunny\nprint(\"Line 1\\nLine 2\")        # Newline\nprint(\"Tab:\\tHere\")            # Tab\n```\n\n---\n\n##  String Concatenation\n\n### Using + Operator\n\n```python\nfirst = \"Hello\"\nsecond = \"World\"\nmessage = first + \" \" + second\nprint(message)    # Hello World\n```\n\n###  Can''t Mix Strings and Numbers!\n\n```python\nage = 25\nprint(\"Age: \" + age)         #  TypeError!\nprint(\"Age: \" + str(age))    #  \"Age: 25\"\n```\n\n---\n\n##  f-strings (Formatted String Literals)\n\n> The modern, clean way to include variables in strings!\n\n### Basic Syntax\n\n```python\nname = \"Alice\"\nage = 25\n\n# f-string: put f before the quotes, variables in {}\nprint(f\"My name is {name} and I am {age} years old.\")\n# Output: My name is Alice and I am 25 years old.\n```\n\n### Expressions Inside Braces\n\n```python\nx = 10\ny = 5\n\nprint(f\"Sum: {x + y}\")           # Sum: 15\nprint(f\"Product: {x * y}\")       # Product: 50\nprint(f\"x squared: {x ** 2}\")    # x squared: 100\n```\n\n---\n\n##  Number Formatting\n\n### Decimal Places\n\n```python\nprice = 19.99999\nprint(f\"Price: ${price:.2f}\")    # Price: $19.99 (2 decimals)\nprint(f\"Price: ${price:.0f}\")    # Price: $20 (0 decimals, rounds)\n```\n\n### Thousands Separator\n\n```python\nrevenue = 1500000\nprint(f\"Revenue: ${revenue:,}\")        # Revenue: $1,500,000\nprint(f\"Revenue: ${revenue:,.2f}\")     # Revenue: $1,500,000.00\n```\n\n### Percentage\n\n```python\nrate = 0.156\nprint(f\"Rate: {rate:.1%}\")       # Rate: 15.6%\nprint(f\"Rate: {rate:.0%}\")       # Rate: 16%\n```\n\n### Alignment and Padding\n\n```python\nitem = \"Room\"\nprint(f\"{item:<20}\")    # ''Room                '' (left align)\nprint(f\"{item:>20}\")    # ''                Room'' (right align)\nprint(f\"{item:^20}\")    # ''        Room        '' (center)\n```\n\n---\n\n##  Hotel Examples\n\n### Guest Welcome Message\n\n```python\nguest_name = \"Maria Garcia\"\nroom_number = 508\ncheck_in = \"March 15, 2024\"\ncheck_out = \"March 18, 2024\"\n\nmessage = f\"\"\"\n\n     Welcome, {guest_name}!             \n\n  Room: {room_number}                   \n  Check-in: {check_in}                  \n  Check-out: {check_out}                \n\n\"\"\"\n\nprint(message)\n```\n\n### Formatted Receipt\n\n```python\nroom_charge = 599.97\nroom_service = 45.50\ntax = 77.46\ntotal = 722.93\n\nprint(\"\\n\" + \"=\" * 35)\nprint(f\"{'HOTEL RECEIPT':^35}\")\nprint(\"=\" * 35)\nprint(f\"{'Room (3 nights)':<25} ${room_charge:>7.2f}\")\nprint(f\"{'Room Service':<25} ${room_service:>7.2f}\")\nprint(f\"{'Tax (12%)':<25} ${tax:>7.2f}\")\nprint(\"-\" * 35)\nprint(f\"{'TOTAL':<25} ${total:>7.2f}\")\nprint(\"=\" * 35)\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Forgetting the f\n\n```python\nname = \"Alice\"\nprint(\"Hello {name}\")    #  Output: Hello {name}\nprint(f\"Hello {name}\")   #  Output: Hello Alice\n```\n\n### Mistake 2: Mismatched Braces\n\n```python\nprint(f\"Value: {x\")      #  SyntaxError\nprint(f\"Value: {x}\")     #  Correct\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - f-strings: `f\"text {variable} more text\"`\n> - Decimals: `{price:.2f}` = 2 decimal places\n> - Thousands: `{num:,}` = comma separator\n> - Percentage: `{rate:.1%}` = show as %\n> - Alignment: `{text:<20}` left, `{text:>20}` right"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 5.8: f-string Practice (Code)
-- ============================================
(
  'e0000000-0000-0000-0005-000000000008',
  'd0000000-0000-0000-0000-000000000005',
  '5.8',
  8,
  'f-string Practice',
  'fstring-practice',
  'code',
  10,
  35,
  'basic',
  '{
    "instructions": "Practice using f-strings to create formatted output!\n\nGiven the product information below, create a single formatted message using an f-string.\n\n**Required output format:**\nProduct: Laptop, Price: $999.99, In Stock: True\n\nThen create a second line showing the price with a 15% discount (calculate it!):\nAfter 15% discount: $XXX.XX",
    "starterCode": "# Product information\nproduct = \"Laptop\"\nprice = 999.99\nin_stock = True\n\n# Create f-string with product info\n\n\n# Calculate 15% discount and print discounted price\n",
    "solution": "# Product information\nproduct = \"Laptop\"\nprice = 999.99\nin_stock = True\n\n# Create f-string with product info\nprint(f\"Product: {product}, Price: ${price}, In Stock: {in_stock}\")\n\n# Calculate 15% discount and print discounted price\ndiscount = price * 0.15\ndiscounted_price = price - discount\nprint(f\"After 15% discount: ${discounted_price:.2f}\")",
    "testCases": [
      {"input": "", "expectedOutput": "Product: Laptop, Price: $999.99, In Stock: True", "description": "Product info line"},
      {"input": "", "expectedOutput": "$849.99", "description": "Discounted price should be 849.99"}
    ],
    "hints": [
      "Start with f\" and include variables in {}",
      "discount = price * 0.15",
      "Use :.2f for 2 decimal places"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 5.9: User Input (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0005-000000000009',
  'd0000000-0000-0000-0000-000000000005',
  '5.9',
  9,
  'User Input with input()',
  'user-input',
  'lesson',
  10,
  25,
  'basic',
  '{"markdown": "# User Input with input()\n\n##  Why This Matters\n\nPrograms become truly useful when they can interact with users. **The input() function lets you get data from the person running your program.**\n\n---\n\n##  Basic Input\n\n```python\nname = input(\"What is your name? \")\nprint(f\"Hello, {name}!\")\n```\n\n**When run:**\n```\nWhat is your name? Alice\nHello, Alice!\n```\n\n---\n\n##  Critical: input() Always Returns a STRING!\n\n```python\nage = input(\"Enter your age: \")  # User types 25\nprint(type(age))                  # <class ''str''>  NOT int!\n\n# This won''t work!\nnext_year = age + 1               #  TypeError!\n```\n\n---\n\n##  Converting Input\n\n### String to Integer\n\n```python\nage = input(\"Enter your age: \")        # \"25\" (string)\nage = int(age)                          # 25 (integer)\n\n# Or in one line:\nage = int(input(\"Enter your age: \"))    # Directly convert\n```\n\n### String to Float\n\n```python\nprice = float(input(\"Enter price: \"))   # 19.99 (float)\n```\n\n---\n\n##  Hotel Example: Guest Check-In\n\n```python\nprint(\"=== Hotel Check-In ===\")\nprint()\n\n# Get guest information\nname = input(\"Guest name: \")\nroom_type = input(\"Room type (Standard/Deluxe/Suite): \")\nnights = int(input(\"Number of nights: \"))\n\n# Room rates\nrates = {\"Standard\": 150, \"Deluxe\": 225, \"Suite\": 350}\nrate = rates.get(room_type, 150)  # Default to Standard if not found\n\n# Calculate total\ntotal = rate * nights\n\n# Display confirmation\nprint()\nprint(f\"Guest: {name}\")\nprint(f\"Room: {room_type}\")\nprint(f\"Rate: ${rate}/night  {nights} nights\")\nprint(f\"Total: ${total}\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Doing Math on String Input\n\n```python\nx = input(\"Number: \")    # \"5\"\ny = x + 1                 #  TypeError!\n\nx = int(input(\"Number: \"))  # 5\ny = x + 1                   #  6\n```\n\n### Mistake 2: Forgetting Space in Prompt\n\n```python\nname = input(\"Name:\")     # Looks like: Name:Alice (cramped)\nname = input(\"Name: \")    # Looks like: Name: Alice (better!)\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - `input()` ALWAYS returns a string\n> - Use `int()` to convert to integer\n> - Use `float()` to convert to decimal\n> - Add a space at the end of your prompt"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 5.10: Module 5 Checkpoint (10 questions)
-- ============================================
(
  'e0000000-0000-0000-0005-000000000010',
  'd0000000-0000-0000-0000-000000000005',
  '5.10',
  10,
  'Module 5 Checkpoint',
  'module-5-checkpoint',
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
        "question": "What is the data type of: x = \"42\"",
        "options": ["int", "float", "str", "bool"],
        "correct": 2,
        "explanation": "The quotes make it a STRING (str), not a number. \"42\" is text, not the integer 42."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is the result of: 17 // 5",
        "options": ["3.4", "3", "4", "2"],
        "correct": 1,
        "explanation": "// is FLOOR DIVISION, which rounds down. 17  5 = 3.4, rounded down = 3."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is the result of: 17 % 5",
        "options": ["3.4", "3", "2", "0"],
        "correct": 2,
        "explanation": "% gives the REMAINDER. 17 = 53 + 2, so the remainder is 2."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which correctly creates an f-string?",
        "options": ["print(\"Hello {name}\")", "print(f\"Hello {name}\")", "print(\"Hello\" + {name})", "print(f Hello {name})"],
        "correct": 1,
        "explanation": "f-strings require an f before the quotes: f\"text {variable}\""
      },
      {
        "id": "cp5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "input() always returns a string, even if the user enters a number.",
        "correct": true,
        "explanation": "TRUE. input() ALWAYS returns a string. You must use int() or float() to convert it."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is int(3.9)?",
        "options": ["3", "4", "3.9", "Error"],
        "correct": 0,
        "explanation": "int() TRUNCATES (cuts off) the decimal part. 3.9  3. It does NOT round!"
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does this output?\n\nx = 10\nx += 5\nprint(x)",
        "options": ["10", "5", "15", "105"],
        "correct": 2,
        "explanation": "x += 5 means x = x + 5. So x becomes 10 + 5 = 15."
      },
      {
        "id": "cp8",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What''s the output of: print(f\"Price: ${19.999:.2f}\")",
        "options": ["Price: $19.999", "Price: $19.99", "Price: $20.00", "Error"],
        "correct": 2,
        "explanation": ":.2f rounds to 2 decimal places. 19.999 rounded to 2 decimals is 20.00."
      },
      {
        "id": "cp9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What will this code output?\n\na = \"5\"\nb = \"3\"\nprint(a + b)",
        "options": ["8", "53", "5 + 3", "Error"],
        "correct": 1,
        "explanation": "Both a and b are STRINGS. The + operator CONCATENATES strings: \"5\" + \"3\" = \"53\""
      },
      {
        "id": "cp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the result of: 2 + 3 * 4 ** 2",
        "options": ["50", "80", "200", "24"],
        "correct": 0,
        "explanation": "Order: ** first (4=16), then * (316=48), then + (2+48=50). Answer: 50"
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
