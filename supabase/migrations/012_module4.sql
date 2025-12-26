-- ============================================
-- Module 4: Introduction to Python
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 4.1: Why Python? (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0004-000000000001',
  'd0000000-0000-0000-0000-000000000004',
  '4.1',
  1,
  'Why Python?',
  'why-python',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Why Python?\n\n##  Why This Matters\n\nYou''re about to learn one of the most powerful and in-demand programming languages in the world. Python powers Instagram, Spotify, Netflix, and countless business applications. **Learning Python opens doors to careers in tech, data science, automation, and beyond.**\n\n---\n\n##  What is Python?\n\n> **Python** is a high-level, general-purpose programming language known for its simplicity and readability.\n\n### Python''s Philosophy\n\n```\n\n         THE ZEN OF PYTHON               \n\n  Beautiful is better than ugly         \n  Simple is better than complex         \n  Readability counts                    \n  There should be one obvious way       \n\n```\n\n---\n\n##  Why Python is #1 for Beginners\n\n### 1. Reads Like English\n\n**Python:**\n```python\nif guest_is_vip:\n    give_room_upgrade()\n```\n\n**Other Languages:**\n```java\nif (guestIsVip == true) {\n    giveRoomUpgrade();\n}\n```\n\nPython uses simple words (`if`, `and`, `or`, `not`) instead of symbols.\n\n### 2. Less Typing, More Doing\n\n**Python - Print \"Hello\":**\n```python\nprint(\"Hello\")\n```\n\n**Java - Print \"Hello\":**\n```java\npublic class Hello {\n    public static void main(String[] args) {\n        System.out.println(\"Hello\");\n    }\n}\n```\n\n### 3. Immediate Feedback\n\nPython is *interpreted*  you can run code line by line and see results instantly. Perfect for learning!\n\n---\n\n##  Python in the Hospitality Industry\n\n### Revenue Management\n```python\n# Adjust prices based on demand\nif occupancy > 85:\n    room_price = room_price * 1.20  # Increase by 20%\n```\n\n### Guest Analytics\n```python\n# Analyze guest preferences\nvip_guests = [g for g in guests if g.total_spend > 10000]\nprint(f\"VIP count: {len(vip_guests)}\")\n```\n\n### Automation\n```python\n# Send automated check-in reminders\nfor booking in tomorrows_arrivals:\n    send_email(booking.guest_email, \"Your stay is tomorrow!\")\n```\n\n### Reporting\n```python\n# Generate occupancy report\nreport = calculate_occupancy(hotel_data)\nexport_to_excel(report, \"monthly_occupancy.xlsx\")\n```\n\n---\n\n##  Who Uses Python?\n\n| Company | Python Use |\n|---------|------------|\n| **Instagram** | Backend, image processing |\n| **Spotify** | Music recommendations, data analysis |\n| **Netflix** | Content recommendations, A/B testing |\n| **Dropbox** | Desktop client, server infrastructure |\n| **Google** | YouTube, Search algorithms |\n| **NASA** | Scientific computing, simulations |\n\n---\n\n##  Career Opportunities\n\n| Role | Average Salary | Python Use |\n|------|----------------|------------|\n| Data Analyst | $65-85k | Data processing, visualization |\n| Data Scientist | $100-150k | Machine learning, statistics |\n| Backend Developer | $80-120k | Web applications, APIs |\n| Automation Engineer | $70-100k | Scripts, testing |\n| Business Analyst | $60-90k | Reporting, analytics |\n\n---\n\n##  Common Misconceptions\n\n| Myth | Reality |\n|------|--------|\n| \"Python is only for tech people\" | Business analysts, marketers, and managers use it daily |\n| \"I need to be good at math\" | Most Python work is logic, not advanced math |\n| \"Python is slow\" | For most business tasks, speed is not an issue |\n| \"I''m too old to learn\" | Python is popular because it''s easy at any age |\n\n---\n\n##  Pro Tips for Learning Python\n\n1. **Type the code yourself**  Don''t just copy-paste!\n2. **Make mistakes**  Errors teach you more than success\n3. **Build real things**  Motivation comes from useful projects\n4. **Practice daily**  30 minutes/day beats 3 hours once a week\n5. **Use Google**  Professional developers Google constantly!\n\n---\n\n##  Fun Fact\n\n> Python was named after **Monty Python''s Flying Circus**, not the snake! The creator, Guido van Rossum, was a fan of the British comedy group.\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember:**\n> - Python is beginner-friendly yet professionally powerful\n> - It reads like English and requires less code\n> - Used by Instagram, Spotify, Netflix, and many hotels\n> - In-demand skill with excellent career prospects\n\n**Ready to write your first Python code? Let''s go!** "}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.2: Your First Python Program (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0004-000000000002',
  'd0000000-0000-0000-0000-000000000004',
  '4.2',
  2,
  'Your First Python Program',
  'first-python-program',
  'lesson',
  10,
  20,
  'basic',
  '{"markdown": "# Your First Python Program\n\n##  Why This Matters\n\nEvery programmer remembers their first \"Hello, World!\" moment. It''s a tradition dating back to 1972. **Today, you join millions of developers who started exactly where you are now.**\n\n---\n\n##  The print() Function\n\n> **print()** displays text or values on the screen.\n\n### Basic Syntax\n\n```python\nprint(\"Your message here\")\n```\n\n### Your First Program\n\n```python\nprint(\"Hello, World!\")\n```\n\n**Output:**\n```\nHello, World!\n```\n\n **Congratulations!** You''ve just written Python code!\n\n---\n\n##  Key Rules\n\n### 1. Text Must Be in Quotes\n\n```python\n#  Correct\nprint(\"Hello\")\nprint(''Hello'')\n\n#  Wrong - causes error\nprint(Hello)  # Python thinks Hello is a variable\n```\n\n### 2. Parentheses Are Required\n\n```python\n#  Correct\nprint(\"Hello\")\n\n#  Wrong - Python 3 requires parentheses\nprint \"Hello\"  # This was Python 2 syntax\n```\n\n### 3. Quotes Must Match\n\n```python\n#  Correct\nprint(\"Hello\")\nprint(''Hello'')\n\n#  Wrong - mismatched quotes\nprint(\"Hello'')\nprint(''Hello\")\n```\n\n---\n\n##  Printing Different Things\n\n### Text (Strings)\n```python\nprint(\"Welcome to the Grand Hotel!\")\nprint(''Check-out is at 11:00 AM'')\n```\n\n### Numbers\n```python\nprint(42)        # Integer\nprint(3.14)      # Decimal (float)\nprint(199.99)    # Price\n```\n\n### Multiple Items\n```python\nprint(\"Room rate:\", 199.99)  # Comma separates items\nprint(\"Guest name:\", \"Smith\", \"- Room:\", 405)\n```\n\n**Output:**\n```\nRoom rate: 199.99\nGuest name: Smith - Room: 405\n```\n\n---\n\n##  Hotel Examples\n\n```python\n# Welcome message\nprint(\"Welcome to the Lakeside Resort!\")\nprint(\"We hope you enjoy your stay.\")\nprint()\nprint(\"WiFi Password: LakeView2024\")\nprint(\"Room Service: Dial 0\")\n```\n\n**Output:**\n```\nWelcome to the Lakeside Resort!\nWe hope you enjoy your stay.\n\nWiFi Password: LakeView2024\nRoom Service: Dial 0\n```\n\n---\n\n##  Common Errors\n\n### Error 1: Forgetting Quotes\n```python\nprint(Hello)  #  NameError: name ''Hello'' is not defined\nprint(\"Hello\")  #  Correct\n```\n\n### Error 2: Forgetting Parentheses\n```python\nprint \"Hello\"  #  SyntaxError\nprint(\"Hello\")  #  Correct\n```\n\n### Error 3: Mismatched Quotes\n```python\nprint(\"Hello'')  #  SyntaxError\nprint(\"Hello\")   #  Correct\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - `print()` displays output to the screen\n> - Text must be in quotes (single or double)\n> - Numbers don''t need quotes\n> - Commas separate multiple items"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.3: Hello World Exercise (Code)
-- ============================================
(
  'e0000000-0000-0000-0004-000000000003',
  'd0000000-0000-0000-0000-000000000004',
  '4.3',
  3,
  'Hello World Exercise',
  'hello-world',
  'code',
  8,
  30,
  'basic',
  '{
    "instructions": "Write your first Python program!\n\nYour task:\n1. Use the `print()` function to display \"Hello, World!\" on the screen\n\nRemember:\n- Text must be in quotes\n- The function name is `print` (lowercase)\n- Don''t forget the parentheses!",
    "starterCode": "# Your first Python program!\n# Type your code below:\n\n",
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
      "Text must be wrapped in quotes: \"like this\" or ''like this''",
      "Put your text inside the parentheses of print()"
    ],
    "commonMistakes": [
      {"wrong": "print Hello, World!", "issue": "Missing parentheses and quotes"},
      {"wrong": "Print(\"Hello, World!\")", "issue": "print must be lowercase"},
      {"wrong": "print(Hello, World!)", "issue": "Text must be in quotes"}
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.4: The print() Function Deep Dive (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0004-000000000004',
  'd0000000-0000-0000-0000-000000000004',
  '4.4',
  4,
  'The print() Function Deep Dive',
  'print-explained',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# The print() Function Deep Dive\n\n##  Why This Matters\n\n`print()` is your window into what your program is doing. It''s essential for displaying results, debugging code, and creating user interfaces. **Mastering print() is the foundation of Python communication.**\n\n---\n\n##  Basic Syntax\n\n```python\nprint(value1, value2, ..., sep=\" \", end=\"\\n\")\n```\n\n| Parameter | Meaning | Default |\n|-----------|---------|----------|\n| `value1, value2...` | What to print | Required |\n| `sep` | Separator between values | Space `\" \"` |\n| `end` | What to add at the end | New line `\"\\n\"` |\n\n---\n\n##  Printing Text (Strings)\n\n### Single and Double Quotes\n\n```python\nprint(\"Hello\")   # Double quotes\nprint(''Hello'')   # Single quotes - same result!\n\n# Use one type when the text contains the other\nprint(\"It''s a beautiful day\")  # Apostrophe inside\nprint(''He said \"Hello\"'')       # Quotes inside\n```\n\n### Long Text (Triple Quotes)\n\n```python\nprint(\"\"\"Welcome to our hotel!\nWe hope you enjoy your stay.\nCheckout is at 11:00 AM.\"\"\")\n```\n\n**Output:**\n```\nWelcome to our hotel!\nWe hope you enjoy your stay.\nCheckout is at 11:00 AM.\n```\n\n---\n\n##  Printing Numbers\n\n```python\nprint(42)           # Integer\nprint(3.14159)      # Float (decimal)\nprint(199.99)       # Price\nprint(-10)          # Negative number\nprint(1_000_000)    # Underscores for readability (= 1000000)\n```\n\n---\n\n##  Printing Multiple Items\n\n### Using Commas\n\n```python\nprint(\"Name:\", \"John Smith\")\nprint(\"Room:\", 405)\nprint(\"Price:\", 199.99, \"per night\")\n```\n\n**Output:**\n```\nName: John Smith\nRoom: 405\nPrice: 199.99 per night\n```\n\n*Note: Commas automatically add a space between items.*\n\n### Custom Separator\n\n```python\nprint(\"2024\", \"12\", \"25\", sep=\"-\")  # Date format\nprint(\"one\", \"two\", \"three\", sep=\" | \")\nprint(\"a\", \"b\", \"c\", sep=\"\")  # No separator\n```\n\n**Output:**\n```\n2024-12-25\none | two | three\nabc\n```\n\n---\n\n##  Controlling Line Endings\n\n### Default Behavior\n\n```python\nprint(\"Line 1\")\nprint(\"Line 2\")\n```\n\n**Output:**\n```\nLine 1\nLine 2\n```\n\n### Same Line with `end`\n\n```python\nprint(\"Loading\", end=\"\")\nprint(\".\", end=\"\")\nprint(\".\", end=\"\")\nprint(\".\", end=\"\")\nprint(\" Done!\")\n```\n\n**Output:**\n```\nLoading... Done!\n```\n\n---\n\n##  Hotel Examples\n\n### Guest Welcome Message\n\n```python\nprint(\"=\" * 40)\nprint(\"   WELCOME TO THE GRAND HOTEL\")\nprint(\"=\" * 40)\nprint()\nprint(\"Guest:\", \"John Smith\")\nprint(\"Room:\", 405)\nprint(\"Check-in:\", \"2024-03-15\")\nprint(\"Check-out:\", \"2024-03-18\")\nprint()\nprint(\"WiFi:\", \"GrandHotel_Guest\")\nprint(\"Password:\", \"Welcome2024\")\nprint(\"=\" * 40)\n```\n\n### Receipt Format\n\n```python\nprint(\"Room (3 nights)\".ljust(25), \"$450.00\")\nprint(\"Room Service\".ljust(25), \"$65.00\")\nprint(\"Spa Treatment\".ljust(25), \"$120.00\")\nprint(\"-\" * 35)\nprint(\"TOTAL\".ljust(25), \"$635.00\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Mixing Quote Types\n```python\nprint(\"Hello'')  #  SyntaxError\nprint(\"Hello\")   #  Correct\n```\n\n### Mistake 2: Forgetting Quotes for Text\n```python\nprint(Hello)      #  NameError\nprint(\"Hello\")    #  Correct\n```\n\n### Mistake 3: Concatenating String and Number\n```python\nprint(\"Price: \" + 99)       #  TypeError\nprint(\"Price:\", 99)         #  Use comma\nprint(\"Price: \" + str(99))  #  Or convert to string\n```\n\n---\n\n##  Pro Tips\n\n1. **Use commas for mixed types**  `print(\"Value:\", 42)` is easier than string conversion\n\n2. **Empty print() for blank lines**  `print()` creates visual spacing\n\n3. **Use `sep` for formatted output**  Great for dates, paths, lists\n\n4. **Use `end` for progress indicators**  Show loading dots on same line\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - `print()` displays values to the screen\n> - Strings need quotes; numbers don''t\n> - Commas separate items and add spaces\n> - `sep=` customizes the separator\n> - `end=` customizes line endings"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.5: Print Practice (Code)
-- ============================================
(
  'e0000000-0000-0000-0004-000000000005',
  'd0000000-0000-0000-0000-000000000004',
  '4.5',
  5,
  'Print Practice Exercise',
  'print-practice',
  'code',
  10,
  35,
  'basic',
  '{
    "instructions": "Practice using print() with different types of content.\n\nComplete these tasks:\n1. Print your name (as text)\n2. Print your age (as a number, no quotes)\n3. Print a sentence that combines text and a number using commas\n4. Print a blank line, then print \"End of profile\"\n\nExample output:\nJohn\n25\nI am 25 years old\n\nEnd of profile",
    "starterCode": "# Task 1: Print your name (as text in quotes)\n\n\n# Task 2: Print your age (as a number, no quotes)\n\n\n# Task 3: Print a sentence combining text and number\n# Use commas: print(\"text\", number, \"more text\")\n\n\n# Task 4: Print a blank line, then \"End of profile\"\n\n",
    "solution": "# Task 1: Print your name (as text in quotes)\nprint(\"Alex\")\n\n# Task 2: Print your age (as a number, no quotes)\nprint(25)\n\n# Task 3: Print a sentence combining text and number\nprint(\"I am\", 25, \"years old\")\n\n# Task 4: Print a blank line, then \"End of profile\"\nprint()\nprint(\"End of profile\")",
    "testCases": [
      {
        "input": "",
        "expectedOutput": null,
        "description": "Check all requirements are met",
        "validation": "ai",
        "aiPrompt": "Verify the student completed all 4 tasks:\n1. First print should output a name (text/string)\n2. Second print should output just a number (age)\n3. Third print should combine text AND a number in one sentence\n4. Fourth should be a blank line followed by ''End of profile''"
      }
    ],
    "hints": [
      "For names, use quotes: print(\"Your Name\")",
      "For numbers, no quotes needed: print(25)",
      "Combine with commas: print(\"Text\", number, \"more text\")",
      "Blank line: just print() with nothing inside"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.6: Python Building Blocks (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0004-000000000006',
  'd0000000-0000-0000-0000-000000000004',
  '4.6',
  6,
  'Python Building Blocks',
  'python-building-blocks',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Python Building Blocks\n\n##  Why This Matters\n\nBefore building a house, you need to know what bricks, beams, and cement are. **Before writing Python, you need to understand its fundamental elements.** This lesson gives you the vocabulary and concepts you''ll use throughout this course.\n\n---\n\n##  Statements\n\n> A **statement** is a single instruction that Python executes.\n\n```python\nprint(\"Hello\")      # Statement 1\nx = 5               # Statement 2\ny = x + 10          # Statement 3\n```\n\nEach line is one statement. Python executes them **top to bottom**.\n\n---\n\n##  Expressions\n\n> An **expression** is anything that produces a value.\n\n```python\n5 + 3              # Expression  8\n\"Hello\"            # Expression  \"Hello\"\nlen(\"Python\")      # Expression  6\n10 > 5             # Expression  True\n```\n\n### Difference: Statement vs Expression\n\n| Statement | Expression |\n|-----------|------------|\n| Does something | Produces a value |\n| `print(\"Hi\")` | `5 + 3` |\n| `x = 10` | `x * 2` |\n| Cannot be inside another | Can be part of statements |\n\n```python\nx = 5 + 3   # The statement x = ... contains the expression 5 + 3\n```\n\n---\n\n##  Keywords\n\n> **Keywords** are reserved words with special meaning in Python.\n\n```python\n# You CANNOT use these as variable names!\nFalse    True     None\nand      or       not\nif       elif     else\nfor      while    break    continue\ndef      return   class\nimport   from     as\ntry      except   finally\nwith     lambda   pass\n```\n\n```python\n#  This will cause an error\nif = 5      # \"if\" is a keyword!\n\n#  This is fine\nif_value = 5\n```\n\n---\n\n##  Identifiers (Names)\n\n> **Identifiers** are names you give to variables, functions, etc.\n\n### Rules for Identifiers\n\n| Rule | Valid  | Invalid  |\n|------|---------|------------|\n| Can contain letters, numbers, underscores | `guest_name` | |\n| Must start with letter or underscore | `_private` | `2fast` |\n| Cannot start with number | `room405` | `405room` |\n| Cannot be a keyword | `my_class` | `class` |\n| Case-sensitive | `age`  `Age`  `AGE` | |\n\n### Good vs Bad Names\n\n```python\n#  Good (descriptive)\nguest_name = \"Smith\"\nroom_number = 405\ntotal_price = 599.99\nis_vip = True\n\n#  Bad (unclear)\nx = \"Smith\"\nn = 405\ntp = 599.99\nf = True\n```\n\n---\n\n##  Indentation\n\n> **Indentation** (spaces at the start of a line) defines code blocks in Python.\n\n```python\nif is_vip:\n    print(\"Welcome, VIP!\")      # Indented = part of if block\n    give_upgrade()              # Also part of if block\nprint(\"Check-in complete\")      # Not indented = runs always\n```\n\n### The Rule: 4 Spaces\n\n```python\n#  Standard Python style\nif True:\n    print(\"Four spaces\")    # 4 spaces\n\n#  Mixing tabs and spaces causes errors!\nif True:\n    print(\"Spaces\")\n\tprint(\"Tab\")        # This will cause IndentationError!\n```\n\n---\n\n##  Comments\n\n> **Comments** are notes for humans  Python ignores them.\n\n### Single-Line Comments\n\n```python\n# This is a comment\nprint(\"Hello\")  # This is also a comment\n```\n\n### Multi-Line Comments\n\n```python\n\"\"\"\nThis is a multi-line comment.\nUseful for longer explanations.\nPython treats it as a string that''s not assigned to anything.\n\"\"\"\n```\n\n### When to Comment\n\n```python\n#  Good: Explains WHY\n# Apply 15% VIP discount per company policy\ndiscount = price * 0.15\n\n#  Bad: States the obvious\n# Add 5 to x\nx = x + 5\n```\n\n---\n\n##  Hotel Example: Putting It Together\n\n```python\n\"\"\"\nHotel Room Rate Calculator\nCalculates the total cost for a guest stay\n\"\"\"\n\n# Guest information\nguest_name = \"Sarah Johnson\"    # Identifier storing text\nroom_number = 302               # Identifier storing number\nnights = 3                      # How long they''re staying\n\n# Room rates (in dollars)\nstandard_rate = 150             # Base rate per night\nvip_discount = 0.15             # 15% for VIP members\nis_vip = True                   # Boolean - is guest VIP?\n\n# Calculate total (expressions in statements)\nif is_vip:                      # Keyword: if\n    rate = standard_rate * (1 - vip_discount)  # Expression\nelse:                           # Keyword: else\n    rate = standard_rate\n\ntotal = rate * nights           # Expression: rate  nights\n\n# Output result\nprint(\"Guest:\", guest_name)     # Statement with function call\nprint(\"Total:\", total)\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Using Keywords as Names\n```python\nclass = \"First\"   #  class is a keyword\ngrade = \"First\"   #  Use a different name\n```\n\n### Mistake 2: Inconsistent Indentation\n```python\nif True:\n    print(\"a\")\n  print(\"b\")     #  Wrong number of spaces\n```\n\n### Mistake 3: Starting Names with Numbers\n```python\n1st_place = \"Gold\"   #  Cannot start with number\nfirst_place = \"Gold\" #  Correct\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - **Statement** = Instruction Python executes\n> - **Expression** = Code that produces a value\n> - **Keyword** = Reserved word (if, else, for, while...)\n> - **Identifier** = Name you create (variables, functions)\n> - **Indentation** = 4 spaces define code blocks\n> - **Comment** = Note for humans, ignored by Python"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.7: Comments & Style Guide (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0004-000000000007',
  'd0000000-0000-0000-0000-000000000004',
  '4.7',
  7,
  'Comments & Code Style',
  'comments-and-style',
  'lesson',
  10,
  20,
  'basic',
  '{"markdown": "# Comments & Code Style\n\n##  Why This Matters\n\nCode is read far more often than it''s written. Six months from now, will you remember what your code does? **Good comments and consistent style make code understandable, maintainable, and professional.**\n\n---\n\n##  Types of Comments\n\n### Single-Line Comments\n\n```python\n# This is a single-line comment\nprint(\"Hello\")  # This is an inline comment\n```\n\n### Multi-Line Comments (Docstrings)\n\n```python\n\"\"\"\nThis is a multi-line comment.\nIt can span several lines.\nUseful for longer explanations.\n\"\"\"\n\n''''''This also works\nwith single quotes.''''''\n```\n\n---\n\n##  Good vs  Bad Comments\n\n### Comment the WHY, Not the WHAT\n\n```python\n#  Bad: States the obvious\nx = x + 1  # Add 1 to x\n\n#  Good: Explains the reason\nx = x + 1  # Account for zero-based indexing\n```\n\n### More Examples\n\n```python\n#  Bad\nprice = price * 0.85  # Multiply price by 0.85\n\n#  Good\nprice = price * 0.85  # Apply 15% loyalty member discount\n\n#  Bad\nif age >= 18:  # Check if age is 18 or more\n\n#  Good\nif age >= 18:  # Legal adult age for room booking\n```\n\n---\n\n##  Python Style Guide (PEP 8)\n\n### Naming Conventions\n\n```python\n# Variables and functions: snake_case\nguest_name = \"Smith\"\nroom_number = 405\ndef calculate_total():\n    pass\n\n# Constants: UPPER_CASE\nMAX_OCCUPANCY = 4\nTAX_RATE = 0.08\nHOTEL_NAME = \"Grand Resort\"\n\n# Classes: PascalCase (you''ll learn this later)\nclass HotelRoom:\n    pass\n```\n\n### Spacing Around Operators\n\n```python\n#  Good\nx = 5\ny = x + 10\ntotal = price * quantity\n\n#  Bad\nx=5\ny=x +10\ntotal=price*quantity\n```\n\n### Line Length\n\n```python\n#  Good: Under 79 characters\nprint(\"Welcome to our hotel!\")\n\n#  Bad: Too long\nprint(\"Welcome to our wonderful hotel where we provide excellent service and comfortable rooms!\")\n\n#  Better: Break into multiple lines\nprint(\"Welcome to our wonderful hotel where we provide \"\n      \"excellent service and comfortable rooms!\")\n```\n\n### Blank Lines\n\n```python\n# Use blank lines to separate logical sections\n\n# Section 1: Guest Information\nguest_name = \"John Smith\"\nguest_email = \"john@email.com\"\n\n# Section 2: Booking Details\nroom_type = \"Deluxe\"\ncheck_in = \"2024-03-15\"\ncheck_out = \"2024-03-18\"\n\n# Section 3: Calculate Total\nnights = 3\nrate = 199.99\ntotal = nights * rate\n```\n\n---\n\n##  Hotel Example: Well-Styled Code\n\n```python\n\"\"\"\nHotel Booking Confirmation Generator\n\nThis module creates confirmation messages for hotel bookings.\nUsed by the front desk system.\n\nAuthor: Front Desk Team\nLast Updated: 2024-03-15\n\"\"\"\n\n# Constants\nHOTEL_NAME = \"Grand Resort & Spa\"\nCHECK_IN_TIME = \"3:00 PM\"\nCHECK_OUT_TIME = \"11:00 AM\"\n\n# Guest information\nguest_name = \"Sarah Johnson\"\nconfirmation_number = \"GRS-2024-0315\"\n\n# Booking details\nroom_type = \"Ocean View Suite\"\nroom_number = 508\nnights = 4\nrate_per_night = 299.99\n\n# Calculate total (before tax)\nsubtotal = nights * rate_per_night\n\n# Apply loyalty discount if applicable\nis_loyalty_member = True\nif is_loyalty_member:\n    discount = subtotal * 0.10  # 10% loyalty discount\n    subtotal = subtotal - discount\n\n# Print confirmation\nprint(\"=\" * 50)\nprint(f\"    {HOTEL_NAME}\")\nprint(\"=\" * 50)\nprint(f\"Confirmation: {confirmation_number}\")\nprint(f\"Guest: {guest_name}\")\nprint(f\"Room: {room_type} (#{room_number})\")\nprint(f\"Stay: {nights} nights @ ${rate_per_night}/night\")\nprint(f\"Total: ${subtotal:.2f}\")\nprint(\"=\" * 50)\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember:**\n> - Comment WHY, not WHAT\n> - Use `snake_case` for variables and functions\n> - Use `UPPER_CASE` for constants\n> - Add spaces around operators\n> - Use blank lines to separate sections"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.8: Code Reading Quiz (12 questions)
-- ============================================
(
  'e0000000-0000-0000-0004-000000000008',
  'd0000000-0000-0000-0000-000000000004',
  '4.8',
  8,
  'Code Reading Quiz',
  'code-reading-quiz',
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
        "question": "What will this code output?\n\nprint(\"Hello\")\nprint(\"World\")",
        "options": ["HelloWorld", "Hello World", "Hello\\nWorld (on separate lines)", "Error"],
        "correct": 2,
        "explanation": "Each print() outputs on a NEW LINE by default. So \"Hello\" appears on line 1, \"World\" on line 2."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which line will cause an error?",
        "options": ["print(\"42\")", "print(42)", "print(Hello)", "print(\"Hello\", \"World\")"],
        "correct": 2,
        "explanation": "print(Hello) causes a NameError because Hello without quotes is treated as an undefined variable name."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What will print(\"Age:\", 25) output?",
        "options": ["Age:25", "Age: 25", "\"Age:\", 25", "Error"],
        "correct": 1,
        "explanation": "When using commas in print(), Python automatically adds a SPACE between items. Output: Age: 25"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "In Python, print and Print are the same function.",
        "correct": false,
        "explanation": "FALSE. Python is case-sensitive. print() works, but Print() would cause a NameError."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which is a valid Python variable name?",
        "options": ["2nd_place", "second-place", "second_place", "second place"],
        "correct": 2,
        "explanation": "second_place is valid (uses underscores). Others fail: 2nd starts with number, second-place has hyphen, second place has space."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does this code print?\n\nprint(\"a\", \"b\", \"c\", sep=\"-\")",
        "options": ["a b c", "a-b-c", "abc", "a, b, c"],
        "correct": 1,
        "explanation": "The sep=\"-\" parameter changes the separator between items from space to hyphen. Output: a-b-c"
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which variable name follows Python naming conventions (PEP 8)?",
        "options": ["GuestName", "guestname", "guest_name", "GUEST_NAME"],
        "correct": 2,
        "explanation": "Python convention uses snake_case for variables: guest_name. UPPER_CASE is for constants only."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\nprint(\"Line 1\", end=\" \")\nprint(\"Line 2\")",
        "options": ["Line 1\\nLine 2", "Line 1 Line 2", "Line 1Line 2", "Error"],
        "correct": 1,
        "explanation": "end=\" \" replaces the default newline with a space, so both print on the SAME line: Line 1 Line 2"
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What will this code output?\n\n# print(\"Hello\")\nprint(\"World\")",
        "options": ["Hello\\nWorld", "World", "Hello World", "Nothing - both are commented"],
        "correct": 1,
        "explanation": "The first print is COMMENTED OUT (# makes it a comment). Only \"World\" is printed."
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which of these will cause an error?",
        "options": ["class = \"First\"", "Class = \"First\"", "my_class = \"First\"", "first_class = \"First\""],
        "correct": 0,
        "explanation": "class is a Python KEYWORD and cannot be used as a variable name. This causes a SyntaxError."
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nprint(\"Price:\", 100, \"+\", 50, \"=\", 150)",
        "options": ["Price:100+50=150", "Price: 100 + 50 = 150", "Price: 100+50=150", "Error"],
        "correct": 1,
        "explanation": "Commas add spaces between ALL items. Output: Price: 100 + 50 = 150"
      },
      {
        "id": "q12",
        "type": "true_false",
        "difficulty": "exam",
        "question": "The following code will run without errors:\n\nif True:\nprint(\"Hello\")",
        "correct": false,
        "explanation": "FALSE. The print statement must be INDENTED inside the if block. Without indentation, Python raises an IndentationError."
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
-- Activity 4.9: Create Your Profile (Coding Challenge)
-- ============================================
(
  'e0000000-0000-0000-0004-000000000009',
  'd0000000-0000-0000-0000-000000000004',
  '4.9',
  9,
  'Challenge: Create Your Profile',
  'create-profile-challenge',
  'code',
  12,
  45,
  'basic',
  '{
    "instructions": "Create a program that displays a nicely formatted personal profile!\n\n**Requirements:**\n1. Print a decorative header line (use = or - characters)\n2. Print a title: \"MY PROFILE\"\n3. Print another decorative line\n4. Print your name with a label\n5. Print your favorite hobby with a label\n6. Print your goal for learning Python with a label\n7. Print a closing decorative line\n\n**Example Output:**\n==============================\n       MY PROFILE\n==============================\nName: Alex\nHobby: Playing guitar\nGoal: Build a hotel booking app!\n==============================",
    "starterCode": "# ============================\n# My Personal Profile\n# ============================\n\n# Print decorative header\n\n# Print title\n\n# Print another decorative line\n\n# Print your name\n\n# Print your favorite hobby\n\n# Print your Python learning goal\n\n# Print closing line\n",
    "solution": "# ============================\n# My Personal Profile\n# ============================\n\n# Print decorative header\nprint(\"=\" * 30)\n\n# Print title\nprint(\"       MY PROFILE\")\n\n# Print another decorative line\nprint(\"=\" * 30)\n\n# Print your name\nprint(\"Name: Alex\")\n\n# Print your favorite hobby\nprint(\"Hobby: Playing guitar\")\n\n# Print your Python learning goal\nprint(\"Goal: Build a hotel booking app!\")\n\n# Print closing line\nprint(\"=\" * 30)",
    "testCases": [
      {
        "input": "",
        "expectedOutput": null,
        "description": "Should have formatted output with all elements",
        "validation": "print_count >= 7"
      }
    ],
    "hints": [
      "Use print(\"=\" * 30) to create a line of 30 equals signs",
      "Labels look nice with a colon: print(\"Name: Alex\")",
      "Empty print() creates a blank line if needed",
      "Center your title by adding spaces at the beginning"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 4.10: Module 4 Checkpoint (10 questions)
-- ============================================
(
  'e0000000-0000-0000-0004-000000000010',
  'd0000000-0000-0000-0000-000000000004',
  '4.10',
  10,
  'Module 4 Checkpoint',
  'module-4-checkpoint',
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
        "question": "Why is Python considered easy to learn?",
        "options": ["It only works on Windows", "Its syntax is similar to English", "It has no rules", "It is the oldest programming language"],
        "correct": 1,
        "explanation": "Python''s syntax is designed to be readable and similar to English, making it beginner-friendly."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does print(\"5\" + \"3\") output?",
        "options": ["8", "53", "5 + 3", "Error"],
        "correct": 1,
        "explanation": "When you use + with STRINGS, Python CONCATENATES (joins) them. \"5\" + \"3\" = \"53\", not 8!"
      },
      {
        "id": "cp3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "In Python, variable names can start with a number.",
        "correct": false,
        "explanation": "FALSE. Variable names must start with a letter or underscore, NOT a number. Example: 1name is invalid."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which is a valid comment in Python?",
        "options": ["// This is a comment", "/* This is a comment */", "# This is a comment", "-- This is a comment"],
        "correct": 2,
        "explanation": "Python uses # for single-line comments. The other formats are from other languages."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What will happen if you run: print(Hello)?",
        "options": ["It prints Hello", "It prints \"Hello\"", "NameError - Hello is not defined", "It prints nothing"],
        "correct": 2,
        "explanation": "Without quotes, Python thinks Hello is a variable name. Since it''s not defined, you get a NameError."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output of:\nprint(\"Room\", 405, sep=\"#\")",
        "options": ["Room 405", "Room#405", "Room, 405", "Error"],
        "correct": 1,
        "explanation": "sep=\"#\" changes the separator between print items from a space to #. Output: Room#405"
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which naming convention does Python use for regular variables?",
        "options": ["camelCase (guestName)", "PascalCase (GuestName)", "snake_case (guest_name)", "UPPER_CASE (GUEST_NAME)"],
        "correct": 2,
        "explanation": "Python uses snake_case for variables and functions. UPPER_CASE is reserved for constants."
      },
      {
        "id": "cp8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What does this code print?\n\nprint(\"A\", end=\"\")\nprint(\"B\", end=\"\")\nprint(\"C\")",
        "options": ["A\\nB\\nC", "ABC", "A B C", "Error"],
        "correct": 1,
        "explanation": "end=\"\" removes the newline, so all letters print on the SAME line: ABC"
      },
      {
        "id": "cp9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which of these lines will cause an IndentationError?",
        "options": ["print(\"Hello\")", "    print(\"Hello\")  # Indented for no reason", "if True:\\n    print(\"Hi\")", "x = 5"],
        "correct": 1,
        "explanation": "Randomly indenting code (when not in a block) causes an IndentationError. Python expects consistency."
      },
      {
        "id": "cp10",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Python was named after the snake species.",
        "correct": false,
        "explanation": "FALSE. Python was named after Monty Python''s Flying Circus, the British comedy group!"
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
