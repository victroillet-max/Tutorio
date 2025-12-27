-- ============================================
-- Module 13: Python Libraries - EXPANDED VERSION
-- Adds expanded lessons, quiz questions, and interactive activities
-- ============================================

-- First, delete old Module 13 activities to replace with expanded versions
DELETE FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000013';

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 13.1: Introduction to Libraries (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0013-000000000001',
  'd0000000-0000-0000-0000-000000000013',
  '13.1',
  1,
  'Introduction to Python Libraries',
  'intro-to-libraries',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to Python Libraries\n\n##  Why This Matters\n\nImagine building a house from scratch—mining ore, smelting steel, growing trees for lumber. Exhausting, right? **Libraries are pre-built tools that save you from reinventing the wheel.** Need random numbers? There''s a library. Need to work with dates? There''s a library. Need AI? There''s a library for that too!\n\n---\n\n##  What is a Library?\n\n> A **library** (also called a module) is a collection of pre-written code that extends Python''s capabilities.\n\n### The Building Blocks Analogy\n\n```\n\n        YOUR PROGRAM                                 \n     \n                                               \n                                               \n     math      random     datetime            \n     library   library    library             \n                                               \n                                               \n              PYTHON CORE                      \n                                               \n\n```\n\nPython comes with a **Standard Library**—hundreds of modules included by default. You just need to import them!\n\n---\n\n##  Three Ways to Import\n\n### Method 1: Import Entire Library\n\n```python\nimport math\n\nprint(math.sqrt(16))    # 4.0\nprint(math.pi)          # 3.14159...\nprint(math.ceil(4.2))   # 5\n```\n\n**Pros:** Clear where functions come from  \n**Cons:** More typing (`math.` every time)\n\n### Method 2: Import Specific Functions\n\n```python\nfrom math import sqrt, pi, ceil\n\nprint(sqrt(16))    # 4.0 (no prefix needed!)\nprint(pi)          # 3.14159...\nprint(ceil(4.2))   # 5\n```\n\n**Pros:** Less typing  \n**Cons:** Less clear where functions originate\n\n### Method 3: Import with Alias\n\n```python\nimport datetime as dt\nimport pandas as pd    # Common convention\n\ntoday = dt.date.today()\nprint(today)  # 2024-03-15\n```\n\n**Pros:** Shorter names, still clear  \n**Cons:** Team needs to know aliases\n\n---\n\n##  Common Mistake: Import All\n\n```python\n#  BAD PRACTICE\nfrom math import *\n\n# Now you don''t know where functions come from!\nprint(sqrt(16))    # Where''s sqrt from?\nprint(floor(3.7))  # Where''s floor from?\n```\n\n**Why it''s bad:** If two libraries have the same function name, one overwrites the other. Debugging nightmare!\n\n---\n\n##  Essential Built-in Libraries\n\n### Overview\n\n| Library | Purpose | Example Use |\n|---------|---------|-------------|\n| `math` | Mathematical functions | Square roots, trigonometry |\n| `random` | Random number generation | Shuffling, random selection |\n| `datetime` | Dates and times | Booking dates, durations |\n| `os` | Operating system interaction | File paths, directories |\n| `json` | JSON data handling | API responses, config files |\n| `csv` | CSV file handling | Spreadsheet data |\n\n---\n\n##  Hotel Industry Examples\n\n### Random Room Assignment\n\n```python\nimport random\n\navailable_rooms = [101, 102, 103, 201, 202, 203, 301, 302]\npreferred_floor = 2  # Guest prefers 2nd floor\n\n# Filter rooms on preferred floor\nfloor_rooms = [r for r in available_rooms if str(r).startswith(''2'')]\n\nif floor_rooms:\n    assigned = random.choice(floor_rooms)\nelse:\n    assigned = random.choice(available_rooms)\n\nprint(f\"Assigned room: {assigned}\")\n```\n\n### Check-out Date Calculator\n\n```python\nfrom datetime import date, timedelta\n\ncheck_in = date(2024, 3, 15)\nnights = 5\n\ncheck_out = check_in + timedelta(days=nights)\n\nprint(f\"Check-in:  {check_in}\")\nprint(f\"Check-out: {check_out}\")\nprint(f\"Duration:  {nights} nights\")\n```\n\n### Revenue Rounding\n\n```python\nimport math\n\nrevenue = 12567.89\n\n# Round to nearest hundred\nrounded = round(revenue, -2)  # 12600.0\n\n# Always round up (for billing)\nceiled = math.ceil(revenue)   # 12568\n\n# Always round down (conservative estimate)\nfloored = math.floor(revenue) # 12567\n\nprint(f\"Exact:   ${revenue:,.2f}\")\nprint(f\"Rounded: ${rounded:,.2f}\")\nprint(f\"Ceiling: ${ceiled:,}\")\nprint(f\"Floor:   ${floored:,}\")\n```\n\n---\n\n##  Finding the Right Library\n\n### Built-in vs External\n\n```\n\n  BUILT-IN LIBRARIES              EXTERNAL LIBRARIES    \n  (Come with Python)              (Install separately)  \n\n  - math, random, datetime        - pandas (data)       \n  - os, sys, json, csv            - numpy (arrays)      \n  - collections, itertools        - requests (web)      \n  - re (regex), urllib            - flask (web apps)    \n\n  import math                     pip install pandas    \n\n```\n\n---\n\n##  Pro Tips\n\n1. **Import at the top** of your file, not scattered throughout\n2. **Use specific imports** when you only need 1-2 functions\n3. **Use aliases** for commonly used libraries (dt, pd, np)\n4. **Read the documentation** — Python docs are excellent\n5. **Don''t use import *** — it causes confusion\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - `import library` — imports entire library\n> - `from library import function` — imports specific items\n> - `import library as alias` — creates shortcut name\n> - Python''s Standard Library is huge and free!\n> - Common libraries: math, random, datetime, os, json, csv"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 13.2: The math Library (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0013-000000000002',
  'd0000000-0000-0000-0000-000000000013',
  '13.2',
  2,
  'The math Library',
  'math-library',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# The math Library\n\n##  Why This Matters\n\nFrom calculating room areas to determining compound interest on deposits, **math operations go beyond basic arithmetic**. The math library provides precise mathematical functions used in real business calculations.\n\n---\n\n##  Importing math\n\n```python\nimport math\n\n# Or import specific functions\nfrom math import sqrt, ceil, floor, pi\n```\n\n---\n\n##  Rounding Functions\n\n```python\nimport math\n\n# ceil() - Always rounds UP\nprint(math.ceil(4.1))    # 5\nprint(math.ceil(4.9))    # 5\nprint(math.ceil(-4.1))   # -4 (towards zero)\n\n# floor() - Always rounds DOWN\nprint(math.floor(4.1))   # 4\nprint(math.floor(4.9))   # 4\nprint(math.floor(-4.1))  # -5 (away from zero)\n\n# trunc() - Truncates towards zero\nprint(math.trunc(4.9))   # 4\nprint(math.trunc(-4.9))  # -4\n```\n\n### Comparison Table\n\n| Value | ceil() | floor() | round() | trunc() |\n|-------|--------|---------|---------|----------|\n| 4.1 | 5 | 4 | 4 | 4 |\n| 4.9 | 5 | 4 | 5 | 4 |\n| -4.1 | -4 | -5 | -4 | -4 |\n| -4.9 | -4 | -5 | -5 | -4 |\n\n---\n\n##  Power and Root Functions\n\n```python\nimport math\n\n# Square root\nprint(math.sqrt(16))     # 4.0\nprint(math.sqrt(2))      # 1.4142...\n\n# Power\nprint(math.pow(2, 3))    # 8.0 (2^3)\nprint(math.pow(10, 2))   # 100.0\n\n# Note: ** operator also works\nprint(2 ** 3)            # 8\nprint(10 ** 2)           # 100\n```\n\n---\n\n##  Constants\n\n```python\nimport math\n\nprint(math.pi)      # 3.141592653589793\nprint(math.e)       # 2.718281828459045\nprint(math.inf)     # Infinity\nprint(math.nan)     # Not a Number\n```\n\n---\n\n##  Logarithms\n\n```python\nimport math\n\n# Natural log (base e)\nprint(math.log(10))       # 2.302...\n\n# Log base 10\nprint(math.log10(100))    # 2.0\nprint(math.log10(1000))   # 3.0\n\n# Log with custom base\nprint(math.log(8, 2))     # 3.0 (2^3 = 8)\n```\n\n---\n\n##  Hotel Examples\n\n### Room Area Calculation\n\n```python\nimport math\n\n# Circular conference room\nradius = 10  # meters\narea = math.pi * radius ** 2\n\nprint(f\"Conference room area: {area:.2f} sq meters\")\n# Output: Conference room area: 314.16 sq meters\n```\n\n### Staffing Requirements\n\n```python\nimport math\n\nguests = 247\nstaff_ratio = 15  # 1 staff per 15 guests\n\n# Always round UP for staffing (can''t have partial staff!)\nstaff_needed = math.ceil(guests / staff_ratio)\n\nprint(f\"Staff needed: {staff_needed}\")\n# Output: Staff needed: 17\n```\n\n### Compound Interest on Deposits\n\n```python\nimport math\n\n# Compound interest formula: A = P * e^(rt)\nprincipal = 10000  # Initial deposit\nrate = 0.05        # 5% annual rate\ntime = 3           # 3 years\n\n# Continuous compounding\nfinal_amount = principal * math.exp(rate * time)\n\nprint(f\"Initial:  ${principal:,.2f}\")\nprint(f\"After {time} years: ${final_amount:,.2f}\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Forgetting to Import\n\n```python\nprint(sqrt(16))  #  NameError: sqrt is not defined\n\nimport math\nprint(math.sqrt(16))  #  Works!\n```\n\n### Mistake 2: Using math with Complex Numbers\n\n```python\nimport math\n\nmath.sqrt(-1)  #  ValueError: math domain error\n\n# For complex numbers, use cmath\nimport cmath\nprint(cmath.sqrt(-1))  #  1j\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - `math.ceil()` rounds UP, `math.floor()` rounds DOWN\n> - `math.sqrt()` for square roots\n> - `math.pow(x, y)` or `x ** y` for powers\n> - `math.pi` and `math.e` for constants\n> - Use math for real numbers, cmath for complex"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 13.3: The random Library (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0013-000000000003',
  'd0000000-0000-0000-0000-000000000013',
  '13.3',
  3,
  'The random Library',
  'random-library',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# The random Library\n\n##  Why This Matters\n\nFrom randomly assigning rooms to running fair prize drawings at hotel events, **randomness is essential in many applications**. The random library provides tools for generating random numbers and making random selections.\n\n---\n\n##  Basic Random Functions\n\n```python\nimport random\n\n# random() - Float between 0.0 and 1.0\nprint(random.random())         # 0.7423... (varies)\n\n# randint(a, b) - Integer from a to b (inclusive!)\nprint(random.randint(1, 10))   # 7 (any integer 1-10)\n\n# uniform(a, b) - Float from a to b\nprint(random.uniform(1.0, 10.0))  # 5.834... (any float)\n\n# randrange(start, stop, step) - Like range() but random\nprint(random.randrange(0, 100, 10))  # 30 (0, 10, 20...90)\n```\n\n---\n\n##  Working with Sequences\n\n```python\nimport random\n\ncolors = [\"red\", \"green\", \"blue\", \"yellow\"]\n\n# choice() - Pick one random item\nprint(random.choice(colors))   # \"blue\" (random)\n\n# choices() - Pick multiple (with replacement)\nprint(random.choices(colors, k=3))  # [\"red\", \"red\", \"green\"]\n\n# sample() - Pick multiple (without replacement)\nprint(random.sample(colors, k=2))   # [\"yellow\", \"blue\"]\n\n# shuffle() - Randomize list IN PLACE\nrandom.shuffle(colors)\nprint(colors)  # [\"yellow\", \"blue\", \"red\", \"green\"]\n```\n\n### Key Difference: choices vs sample\n\n```\nchoices(k=3):  Can pick same item multiple times\n               [\"red\", \"red\", \"blue\"]\n\nsample(k=3):   Each item picked only once\n               [\"red\", \"blue\", \"yellow\"]\n```\n\n---\n\n##  Setting a Seed (Reproducibility)\n\n```python\nimport random\n\n# Without seed - different results each run\nprint(random.randint(1, 100))  # 42\nprint(random.randint(1, 100))  # 87\n\n# With seed - SAME results each run\nrandom.seed(42)\nprint(random.randint(1, 100))  # 82 (always!)\nprint(random.randint(1, 100))  # 15 (always!)\n\n# Reset seed for same sequence\nrandom.seed(42)\nprint(random.randint(1, 100))  # 82 again!\n```\n\n**Use seeds for:**\n- Testing (reproducible results)\n- Debugging (recreate issues)\n- Games (shareable random maps)\n\n---\n\n##  Hotel Examples\n\n### Random Room Assignment\n\n```python\nimport random\n\navailable_rooms = [101, 102, 105, 201, 203, 205, 301, 302]\n\n# Assign a random room\nassigned_room = random.choice(available_rooms)\nprint(f\"Your room: {assigned_room}\")\n\n# Remove from available\navailable_rooms.remove(assigned_room)\n```\n\n### Prize Drawing (Without Replacement)\n\n```python\nimport random\n\nparticipants = [\"Alice\", \"Bob\", \"Charlie\", \"Diana\", \"Eve\"]\n\n# Select 3 unique winners\nwinners = random.sample(participants, k=3)\n\nprint(\"Prize Drawing Winners:\")\nfor i, winner in enumerate(winners, 1):\n    print(f\"  {i}. {winner}\")\n```\n\n### Random Discount Code\n\n```python\nimport random\nimport string\n\ndef generate_promo_code(length=8):\n    characters = string.ascii_uppercase + string.digits\n    return ''''.join(random.choices(characters, k=length))\n\n# Generate 5 promo codes\nfor _ in range(5):\n    print(f\"HOTEL-{generate_promo_code()}\")\n\n# Output:\n# HOTEL-X7KM2P9Q\n# HOTEL-AB3TY8WN\n# ...\n```\n\n### Weighted Random Selection\n\n```python\nimport random\n\nroom_types = [\"Standard\", \"Deluxe\", \"Suite\"]\nweights = [0.6, 0.3, 0.1]  # 60%, 30%, 10% probability\n\n# 100 random upgrades based on weights\nselections = random.choices(room_types, weights=weights, k=100)\n\nprint(\"Upgrade distribution:\")\nfor room in room_types:\n    count = selections.count(room)\n    print(f\"  {room}: {count}%\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: randint vs randrange\n\n```python\nimport random\n\nrandom.randint(1, 10)    # Includes 10!\nrandom.randrange(1, 10)  # Excludes 10 (like range)\n```\n\n### Mistake 2: shuffle Returns None\n\n```python\nimport random\n\nitems = [1, 2, 3, 4, 5]\n\n#  shuffle() modifies in place, returns None\nshuffled = random.shuffle(items)  # shuffled is None!\n\n#  Correct way\nrandom.shuffle(items)\nprint(items)  # [3, 1, 5, 2, 4]\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - `randint(a, b)` includes both endpoints\n> - `choice()` picks one, `choices()` picks many (with replacement)\n> - `sample()` picks many (without replacement)\n> - `shuffle()` modifies list in place\n> - Use `seed()` for reproducible results"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 13.4: The datetime Library (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0013-000000000004',
  'd0000000-0000-0000-0000-000000000013',
  '13.4',
  4,
  'The datetime Library',
  'datetime-library',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# The datetime Library\n\n##  Why This Matters\n\nHotels live and breathe dates: check-in dates, check-out dates, booking windows, cancellation deadlines. **The datetime library makes working with dates and times straightforward and reliable.**\n\n---\n\n##  Key Classes in datetime\n\n```python\nfrom datetime import date, time, datetime, timedelta\n\n# date - Just the date (year, month, day)\n# time - Just the time (hour, minute, second)\n# datetime - Both date and time\n# timedelta - A duration (difference between dates/times)\n```\n\n---\n\n##  Working with Dates\n\n```python\nfrom datetime import date\n\n# Today''s date\ntoday = date.today()\nprint(today)  # 2024-03-15\n\n# Create specific date\ncheck_in = date(2024, 6, 15)  # June 15, 2024\nprint(check_in)  # 2024-06-15\n\n# Access components\nprint(check_in.year)   # 2024\nprint(check_in.month)  # 6\nprint(check_in.day)    # 15\n\n# Day of week (Monday=0, Sunday=6)\nprint(check_in.weekday())  # 5 (Saturday)\n```\n\n---\n\n##  Working with Times\n\n```python\nfrom datetime import time\n\n# Create time\ncheck_in_time = time(15, 0)   # 3:00 PM\ncheck_out_time = time(11, 0)  # 11:00 AM\n\nprint(check_in_time)   # 15:00:00\nprint(check_out_time)  # 11:00:00\n\n# With seconds and microseconds\nprecise_time = time(15, 30, 45, 123456)\nprint(precise_time)  # 15:30:45.123456\n```\n\n---\n\n##  Working with Datetime\n\n```python\nfrom datetime import datetime\n\n# Current date and time\nnow = datetime.now()\nprint(now)  # 2024-03-15 14:30:00.123456\n\n# Create specific datetime\nreservation = datetime(2024, 6, 15, 15, 0, 0)\nprint(reservation)  # 2024-06-15 15:00:00\n\n# Access components\nprint(reservation.year)    # 2024\nprint(reservation.hour)    # 15\nprint(reservation.minute)  # 0\n\n# Get just date or time\nprint(reservation.date())  # 2024-06-15\nprint(reservation.time())  # 15:00:00\n```\n\n---\n\n##  Timedelta: Date Arithmetic\n\n```python\nfrom datetime import date, timedelta\n\ncheck_in = date(2024, 3, 15)\nnights = 5\n\n# Add days\ncheck_out = check_in + timedelta(days=nights)\nprint(f\"Check-out: {check_out}\")  # 2024-03-20\n\n# Subtract days\nbooking_deadline = check_in - timedelta(days=7)\nprint(f\"Book by: {booking_deadline}\")  # 2024-03-08\n\n# Calculate duration\nstart = date(2024, 1, 1)\nend = date(2024, 12, 31)\nduration = end - start\nprint(f\"Days in year: {duration.days}\")  # 365\n```\n\n### timedelta Parameters\n\n```python\nfrom datetime import timedelta\n\n# Various time units\ndelta = timedelta(\n    weeks=1,\n    days=2,\n    hours=3,\n    minutes=4,\n    seconds=5\n)\n\nprint(delta)  # 9 days, 3:04:05\nprint(delta.total_seconds())  # 788645.0\n```\n\n---\n\n##  Formatting Dates\n\n```python\nfrom datetime import datetime\n\nnow = datetime.now()\n\n# strftime - Convert TO string\nprint(now.strftime(\"%Y-%m-%d\"))       # 2024-03-15\nprint(now.strftime(\"%B %d, %Y\"))      # March 15, 2024\nprint(now.strftime(\"%I:%M %p\"))       # 02:30 PM\nprint(now.strftime(\"%A, %B %d\"))      # Friday, March 15\n```\n\n### Common Format Codes\n\n| Code | Meaning | Example |\n|------|---------|----------|\n| `%Y` | Year (4 digits) | 2024 |\n| `%m` | Month (01-12) | 03 |\n| `%d` | Day (01-31) | 15 |\n| `%H` | Hour 24h (00-23) | 14 |\n| `%I` | Hour 12h (01-12) | 02 |\n| `%M` | Minute (00-59) | 30 |\n| `%p` | AM/PM | PM |\n| `%A` | Weekday name | Friday |\n| `%B` | Month name | March |\n\n---\n\n##  Parsing Dates\n\n```python\nfrom datetime import datetime\n\n# strptime - Convert FROM string\ndate_str = \"2024-06-15\"\ncheck_in = datetime.strptime(date_str, \"%Y-%m-%d\")\nprint(check_in)  # 2024-06-15 00:00:00\n\n# Different format\ndate_str2 = \"March 15, 2024\"\ncheck_in2 = datetime.strptime(date_str2, \"%B %d, %Y\")\nprint(check_in2)  # 2024-03-15 00:00:00\n```\n\n---\n\n##  Hotel Examples\n\n### Stay Duration Calculator\n\n```python\nfrom datetime import date\n\ncheck_in = date(2024, 3, 15)\ncheck_out = date(2024, 3, 20)\n\nnights = (check_out - check_in).days\nrate = 199.99\n\nprint(f\"Check-in:  {check_in}\")\nprint(f\"Check-out: {check_out}\")\nprint(f\"Nights:    {nights}\")\nprint(f\"Total:     ${nights * rate:,.2f}\")\n```\n\n### Booking Confirmation\n\n```python\nfrom datetime import datetime, timedelta\n\nbooking = datetime.now()\ncheck_in = datetime(2024, 6, 15, 15, 0)\n\n# Format for confirmation email\nconfirmation = f\"\"\"\nBooking Confirmation\n--------------------\nBooked: {booking.strftime(\"%B %d, %Y at %I:%M %p\")}\nCheck-in: {check_in.strftime(\"%A, %B %d, %Y at %I:%M %p\")}\n\nDays until arrival: {(check_in.date() - booking.date()).days}\n\"\"\"\n\nprint(confirmation)\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - `date.today()` gets current date\n> - `datetime.now()` gets current date and time\n> - `timedelta` for date arithmetic\n> - `strftime()` formats date TO string\n> - `strptime()` parses date FROM string"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 13.5: Library Practice Code Exercise
-- ============================================
(
  'e0000000-0000-0000-0013-000000000005',
  'd0000000-0000-0000-0000-000000000013',
  '13.5',
  5,
  'Library Practice',
  'library-practice',
  'code',
  15,
  40,
  'basic',
  '{
    "instructions": "Practice using Python libraries to solve hotel problems!\n\n**Tasks:**\n1. Calculate the check-out date for a 5-night stay starting today\n2. Generate 3 random room numbers between 100 and 500\n3. Calculate the staff needed for 127 guests (1 staff per 12 guests, round UP)\n4. Format today''s date as \"March 15, 2024\"\n\nUse the appropriate libraries for each task!",
    "starterCode": "# Import the libraries you need\nfrom datetime import date, timedelta\nimport random\nimport math\n\n# Task 1: Check-out date (5 nights from today)\ncheck_in = date.today()\n# Your code here\n\n\n# Task 2: Generate 3 random room numbers (100-500)\n# Your code here\n\n\n# Task 3: Staff needed for 127 guests (1:12 ratio, round UP)\nguests = 127\nstaff_ratio = 12\n# Your code here\n\n\n# Task 4: Format today as \"Month Day, Year\"\n# Your code here\n",
    "solution": "# Import the libraries you need\nfrom datetime import date, timedelta\nimport random\nimport math\n\n# Task 1: Check-out date (5 nights from today)\ncheck_in = date.today()\ncheck_out = check_in + timedelta(days=5)\nprint(f\"Check-out: {check_out}\")\n\n# Task 2: Generate 3 random room numbers (100-500)\nrooms = [random.randint(100, 500) for _ in range(3)]\nprint(f\"Random rooms: {rooms}\")\n\n# Task 3: Staff needed for 127 guests (1:12 ratio, round UP)\nguests = 127\nstaff_ratio = 12\nstaff_needed = math.ceil(guests / staff_ratio)\nprint(f\"Staff needed: {staff_needed}\")\n\n# Task 4: Format today as \"Month Day, Year\"\nformatted = check_in.strftime(\"%B %d, %Y\")\nprint(f\"Today: {formatted}\")",
    "testCases": [
      {"input": "", "expectedOutput": "Check-out:", "description": "Check-out date calculated"},
      {"input": "", "expectedOutput": "Random rooms:", "description": "Random rooms generated"},
      {"input": "", "expectedOutput": "Staff needed: 11", "description": "Staff calculation correct"},
      {"input": "", "expectedOutput": "Today:", "description": "Date formatted"}
    ],
    "hints": [
      "Use timedelta(days=5) for date arithmetic",
      "random.randint(100, 500) gives integers in range",
      "math.ceil() rounds UP",
      "strftime(\"%B %d, %Y\") formats as \"March 15, 2024\""
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 13.6: Library Quiz (12 questions)
-- ============================================
(
  'e0000000-0000-0000-0013-000000000006',
  'd0000000-0000-0000-0000-000000000013',
  '13.6',
  6,
  'Library Concepts Quiz',
  'library-concepts-quiz',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "How do you import the math library?",
        "options": ["use math", "include math", "import math", "require math"],
        "correct": 2,
        "explanation": "Python uses ''import'' to bring in libraries: import math"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does random.randint(1, 10) return?",
        "options": ["Always 1", "Always 10", "Random float 1-10", "Random integer 1-10 inclusive"],
        "correct": 3,
        "explanation": "randint returns a random integer including both endpoints (1 and 10)."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "How do you import only sqrt from math?",
        "options": ["import sqrt from math", "from math import sqrt", "import math.sqrt", "use math.sqrt"],
        "correct": 1,
        "explanation": "Syntax: from library import function"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does math.ceil(4.1) return?",
        "options": ["4", "4.1", "5", "Error"],
        "correct": 2,
        "explanation": "ceil() always rounds UP to the nearest integer. 4.1 becomes 5."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does random.choice([''a'', ''b'', ''c'']) return?",
        "options": ["Always ''a''", "The list itself", "One random item from the list", "All items shuffled"],
        "correct": 2,
        "explanation": "choice() returns one randomly selected item from the sequence."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the difference between random.choices() and random.sample()?",
        "options": [
          "No difference",
          "choices() allows duplicates, sample() doesn''t",
          "sample() is faster",
          "choices() only works with numbers"
        ],
        "correct": 1,
        "explanation": "choices() can pick the same item multiple times (with replacement), sample() picks each item at most once (without replacement)."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "How do you add 7 days to a date object?",
        "options": [
          "date + 7",
          "date.add(days=7)",
          "date + timedelta(days=7)",
          "date.days += 7"
        ],
        "correct": 2,
        "explanation": "Use timedelta for date arithmetic: date + timedelta(days=7)"
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does date.today().strftime(\"%B %d, %Y\") produce?",
        "options": [
          "2024-03-15",
          "March 15, 2024",
          "15/03/2024",
          "03-15-2024"
        ],
        "correct": 1,
        "explanation": "%B = full month name, %d = day, %Y = 4-digit year. Result: March 15, 2024"
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nimport random\nrandom.seed(42)\nprint(random.randint(1, 100))\nrandom.seed(42)\nprint(random.randint(1, 100))",
        "options": [
          "Two different numbers",
          "Two identical numbers",
          "Error - can''t reset seed",
          "Always 42 and 42"
        ],
        "correct": 1,
        "explanation": "Setting the same seed produces the same sequence. Both calls will print the same number."
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nimport random\nitems = [1, 2, 3]\nresult = random.shuffle(items)\nprint(result)",
        "options": [
          "A shuffled list like [2, 1, 3]",
          "None",
          "The original list [1, 2, 3]",
          "Error"
        ],
        "correct": 1,
        "explanation": "shuffle() modifies the list IN PLACE and returns None. The list is shuffled, but the return value is None."
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the result?\n\nfrom datetime import date\ncheck_in = date(2024, 3, 28)\ncheck_out = date(2024, 4, 2)\nprint((check_out - check_in).days)",
        "options": ["4", "5", "6", "Error"],
        "correct": 1,
        "explanation": "March 28 to April 2 = 5 days (28, 29, 30, 31, 1, but counting nights = 5)"
      },
      {
        "id": "q12",
        "type": "true_false",
        "difficulty": "exam",
        "question": "from math import * is recommended because it imports all useful functions.",
        "correct": false,
        "explanation": "FALSE. Using import * is bad practice because it can cause name conflicts and makes it unclear where functions come from."
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
-- Activity 13.7: Library Explorer (Interactive)
-- ============================================
(
  'e0000000-0000-0000-0013-000000000007',
  'd0000000-0000-0000-0000-000000000013',
  '13.7',
  7,
  'Library Explorer',
  'library-explorer',
  'interactive',
  10,
  35,
  'basic',
  '{
    "instructions": "Match each function to its correct library and output!",
    "type": "drag-drop-match",
    "pairs": [
      {"left": "sqrt(16)", "right": "math → 4.0", "explanation": "math.sqrt() returns the square root as a float."},
      {"left": "ceil(4.1)", "right": "math → 5", "explanation": "math.ceil() rounds UP to the nearest integer."},
      {"left": "floor(4.9)", "right": "math → 4", "explanation": "math.floor() rounds DOWN to the nearest integer."},
      {"left": "randint(1, 6)", "right": "random → 1 to 6", "explanation": "random.randint() returns an integer in the inclusive range."},
      {"left": "choice([''a'', ''b''])", "right": "random → ''a'' or ''b''", "explanation": "random.choice() picks one random item from a sequence."},
      {"left": "date.today()", "right": "datetime → current date", "explanation": "date.today() returns today''s date as a date object."},
      {"left": "timedelta(days=7)", "right": "datetime → 7 days duration", "explanation": "timedelta represents a duration of time."},
      {"left": "pi", "right": "math → 3.14159...", "explanation": "math.pi is the mathematical constant π."}
    ],
    "scoring": {
      "correct": 10,
      "incorrect": 0,
      "passing_score": 60
    }
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- ============================================
-- Activity 13.8: Module 13 Checkpoint (10 questions)
-- ============================================
(
  'e0000000-0000-0000-0013-000000000008',
  'd0000000-0000-0000-0000-000000000013',
  '13.8',
  8,
  'Module 13 Checkpoint',
  'module-13-checkpoint',
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
        "question": "What is a Python library?",
        "options": [
          "A place to store books",
          "A collection of pre-written code you can use",
          "A type of variable",
          "A debugging tool"
        ],
        "correct": 1,
        "explanation": "A library (module) is a collection of pre-written code that extends Python''s capabilities."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which import statement is correct?",
        "options": [
          "import from math sqrt",
          "from math import sqrt",
          "include math.sqrt",
          "use math::sqrt"
        ],
        "correct": 1,
        "explanation": "The correct syntax is: from library import function"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does math.floor(7.9) return?",
        "options": ["7", "7.9", "8", "Error"],
        "correct": 0,
        "explanation": "floor() always rounds DOWN. 7.9 becomes 7."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "How do you get today''s date using datetime?",
        "options": [
          "datetime.today()",
          "date.now()",
          "date.today()",
          "datetime.date()"
        ],
        "correct": 2,
        "explanation": "Use date.today() to get the current date as a date object."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does random.sample([1,2,3,4,5], k=3) guarantee?",
        "options": [
          "May return duplicates like [2, 2, 4]",
          "Always returns [1, 2, 3]",
          "Returns 3 unique items",
          "Shuffles the entire list"
        ],
        "correct": 2,
        "explanation": "sample() picks k unique items - no duplicates possible."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the result of: date(2024, 3, 1) + timedelta(days=31)?",
        "options": [
          "2024-03-32 (Error)",
          "2024-04-01",
          "2024-04-02",
          "2024-03-31"
        ],
        "correct": 1,
        "explanation": "timedelta handles month boundaries. March 1 + 31 days = April 1."
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nimport math\nprint(math.ceil(-4.3))",
        "options": ["-5", "-4", "-3", "4"],
        "correct": 1,
        "explanation": "ceil() rounds toward positive infinity. -4.3 rounds UP to -4 (closer to zero)."
      },
      {
        "id": "cp8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Why is ''from math import *'' considered bad practice?",
        "options": [
          "It''s slower",
          "It can cause name conflicts and unclear code",
          "It doesn''t work in Python 3",
          "It uses more memory"
        ],
        "correct": 1,
        "explanation": "import * can cause name conflicts if two libraries have the same function name, and makes it unclear where functions come from."
      },
      {
        "id": "cp9",
        "type": "true_false",
        "difficulty": "exam",
        "question": "random.shuffle() returns a new shuffled list.",
        "correct": false,
        "explanation": "FALSE. shuffle() modifies the list IN PLACE and returns None. The original list is changed."
      },
      {
        "id": "cp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel has 234 guests and needs 1 staff per 15 guests. How do you calculate the minimum staff needed?\n\nWhich code is correct?",
        "options": [
          "234 / 15",
          "234 // 15",
          "math.ceil(234 / 15)",
          "round(234 / 15)"
        ],
        "correct": 2,
        "explanation": "Use math.ceil() to round UP. You can''t have partial staff, so 234/15=15.6 means you need 16 staff."
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

