-- ============================================
-- Module 8: Lists and Collections
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 8.1: Introduction to Lists (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0008-000000000001',
  'd0000000-0000-0000-0000-000000000008',
  '8.1',
  1,
  'Introduction to Lists',
  'intro-to-lists',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to Lists\n\n##  Why This Matters\n\nHotels have lists of rooms, guests, reservations, and prices. **Lists let you store multiple values in a single variable**  essential for managing collections of data.\n\n---\n\n##  What is a List?\n\n> A **list** is an ordered, mutable collection of items.\n\n```python\n# Creating lists\nrooms = [101, 102, 103, 104, 105]\nguests = [\"Alice\", \"Bob\", \"Charlie\"]\nprices = [199.99, 249.99, 349.99]\nmixed = [\"Room\", 101, 199.99, True]  # Different types OK!\nempty = []  # Empty list\n```\n\n### List Characteristics\n\n```\n\n                    LIST FEATURES                        \n\n  ORDERED      - Items have positions (index)          \n  MUTABLE      - Can change after creation             \n  ALLOWS DUPLICATES - Same value can appear twice      \n  MIXED TYPES  - Can contain different data types      \n\n```\n\n---\n\n##  Indexing: Accessing Items\n\n> Lists are **zero-indexed**  the first item is at position 0.\n\n```\n          guests = [\"Alice\", \"Bob\", \"Charlie\", \"Diana\"]\n                                               \n   Positive index:    0        1        2         3\n   Negative index:   -4       -3       -2        -1\n```\n\n```python\nguests = [\"Alice\", \"Bob\", \"Charlie\", \"Diana\"]\n\nprint(guests[0])     # Alice (first)\nprint(guests[1])     # Bob (second)\nprint(guests[-1])    # Diana (last)\nprint(guests[-2])    # Charlie (second to last)\n```\n\n---\n\n##  Slicing: Getting Multiple Items\n\n```python\n# list[start:stop]  - from start to stop-1\n# list[start:stop:step]  - with step\n\nnumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]\n\nprint(numbers[2:5])     # [2, 3, 4]\nprint(numbers[:3])      # [0, 1, 2] (first 3)\nprint(numbers[7:])      # [7, 8, 9] (from index 7)\nprint(numbers[::2])     # [0, 2, 4, 6, 8] (every 2nd)\nprint(numbers[::-1])    # [9, 8, 7, ...] (reversed)\n```\n\n---\n\n##  Modifying Lists\n\n### Change an Item\n\n```python\nrooms = [101, 102, 103]\nrooms[1] = 202           # Change second item\nprint(rooms)             # [101, 202, 103]\n```\n\n### Add Items\n\n```python\nguests = [\"Alice\", \"Bob\"]\n\nguests.append(\"Charlie\")      # Add to end\nprint(guests)                  # [\"Alice\", \"Bob\", \"Charlie\"]\n\nguests.insert(1, \"Zara\")      # Insert at position 1\nprint(guests)                  # [\"Alice\", \"Zara\", \"Bob\", \"Charlie\"]\n\nguests.extend([\"Diana\", \"Eve\"])  # Add multiple\nprint(guests)                     # [..., \"Diana\", \"Eve\"]\n```\n\n### Remove Items\n\n```python\nguests = [\"Alice\", \"Bob\", \"Charlie\", \"Diana\"]\n\nguests.remove(\"Bob\")          # Remove by value\nprint(guests)                  # [\"Alice\", \"Charlie\", \"Diana\"]\n\nremoved = guests.pop()        # Remove & return last\nprint(removed)                 # Diana\nprint(guests)                  # [\"Alice\", \"Charlie\"]\n\nremoved = guests.pop(0)       # Remove & return at index\nprint(removed)                 # Alice\n```\n\n---\n\n##  List Operations\n\n```python\nnumbers = [3, 1, 4, 1, 5, 9, 2, 6]\n\n# Length\nprint(len(numbers))          # 8\n\n# Check membership\nprint(4 in numbers)          # True\nprint(10 in numbers)         # False\n\n# Aggregations\nprint(sum(numbers))          # 31\nprint(min(numbers))          # 1\nprint(max(numbers))          # 9\n\n# Count occurrences\nprint(numbers.count(1))      # 2\n\n# Find position\nprint(numbers.index(5))      # 4 (first occurrence)\n```\n\n---\n\n##  Sorting\n\n```python\nnumbers = [3, 1, 4, 1, 5]\n\n# Sort in place (modifies original)\nnumbers.sort()\nprint(numbers)               # [1, 1, 3, 4, 5]\n\nnumbers.sort(reverse=True)\nprint(numbers)               # [5, 4, 3, 1, 1]\n\n# Create sorted copy (original unchanged)\noriginal = [3, 1, 4]\nsorted_copy = sorted(original)\nprint(original)              # [3, 1, 4] (unchanged)\nprint(sorted_copy)           # [1, 3, 4]\n```\n\n---\n\n##  Hotel Examples\n\n### Room Availability\n\n```python\navailable_rooms = [101, 102, 103, 104, 105]\nbooked_rooms = []\n\n# Book a room\nroom = available_rooms.pop(0)\nbooked_rooms.append(room)\nprint(f\"Booked room {room}\")\nprint(f\"Available: {available_rooms}\")\nprint(f\"Booked: {booked_rooms}\")\n```\n\n### Guest Check-In List\n\n```python\nwaiting_list = []\n\n# Add guests as they arrive\nwaiting_list.append(\"Alice\")\nwaiting_list.append(\"Bob\")\nwaiting_list.append(\"Charlie\")\n\n# Process in order (FIFO)\nwhile waiting_list:\n    next_guest = waiting_list.pop(0)\n    print(f\"Now serving: {next_guest}\")\n```\n\n### Price Analysis\n\n```python\nroom_prices = [199, 249, 199, 349, 299, 199, 449]\n\nprint(f\"Rooms: {len(room_prices)}\")\nprint(f\"Cheapest: ${min(room_prices)}\")\nprint(f\"Most expensive: ${max(room_prices)}\")\nprint(f\"Average: ${sum(room_prices)/len(room_prices):.2f}\")\nprint(f\"$199 rooms: {room_prices.count(199)}\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Index Out of Range\n\n```python\nguests = [\"Alice\", \"Bob\"]\nprint(guests[2])    #  IndexError! (only 0 and 1 exist)\nprint(guests[1])    #  Bob\n```\n\n### Mistake 2: Confusing append vs extend\n\n```python\na = [1, 2]\na.append([3, 4])    # Adds list as ONE item\nprint(a)            # [1, 2, [3, 4]]\n\nb = [1, 2]\nb.extend([3, 4])    # Adds EACH item\nprint(b)            # [1, 2, 3, 4]\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Lists are ordered, mutable, zero-indexed\n> - `list[0]` = first, `list[-1]` = last\n> - `append()` adds one, `extend()` adds many\n> - `pop()` removes and returns\n> - `in` checks membership"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 8.2: List Methods Practice (Code)
-- ============================================
(
  'e0000000-0000-0000-0008-000000000002',
  'd0000000-0000-0000-0000-000000000008',
  '8.2',
  2,
  'List Methods Practice',
  'list-methods-practice',
  'code',
  12,
  40,
  'basic',
  '{
    "instructions": "Practice essential list operations!\n\n**Given:** A list of room numbers\n\n**Tasks:**\n1. Print the first and last room numbers\n2. Add room 106 to the end\n3. Insert room 100 at the beginning\n4. Remove room 103\n5. Sort the list and print it\n6. Print how many rooms are in the list",
    "starterCode": "# Hotel room management\nrooms = [101, 102, 103, 104, 105]\n\n# Task 1: Print first and last room\nprint(\"First room:\", )\nprint(\"Last room:\", )\n\n# Task 2: Add room 106 to end\n\n\n# Task 3: Insert room 100 at beginning\n\n\n# Task 4: Remove room 103\n\n\n# Task 5: Sort and print\n\n\n# Task 6: Print count\nprint(\"Total rooms:\", )",
    "solution": "# Hotel room management\nrooms = [101, 102, 103, 104, 105]\n\n# Task 1: Print first and last room\nprint(\"First room:\", rooms[0])\nprint(\"Last room:\", rooms[-1])\n\n# Task 2: Add room 106 to end\nrooms.append(106)\n\n# Task 3: Insert room 100 at beginning\nrooms.insert(0, 100)\n\n# Task 4: Remove room 103\nrooms.remove(103)\n\n# Task 5: Sort and print\nrooms.sort()\nprint(\"Sorted rooms:\", rooms)\n\n# Task 6: Print count\nprint(\"Total rooms:\", len(rooms))",
    "testCases": [
      {"input": "", "expectedOutput": "First room: 101", "description": "First room"},
      {"input": "", "expectedOutput": "Last room: 105", "description": "Last room"},
      {"input": "", "expectedOutput": "Total rooms: 6", "description": "Should have 6 rooms after operations"}
    ],
    "hints": [
      "First item: list[0], Last item: list[-1]",
      "append() adds to end",
      "insert(0, value) adds at beginning",
      "remove(value) removes first occurrence"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 8.3: List Comprehensions (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0008-000000000003',
  'd0000000-0000-0000-0000-000000000008',
  '8.3',
  3,
  'List Comprehensions',
  'list-comprehensions',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# List Comprehensions\n\n##  Why This Matters\n\nList comprehensions are Python''s elegant way to create lists from other lists. They''re **concise, readable, and very Pythonic**  you''ll see them everywhere in professional code.\n\n---\n\n##  Basic Syntax\n\n```python\n[expression for item in iterable]\n```\n\n### Traditional Loop vs Comprehension\n\n```python\n# Traditional way\nsquares = []\nfor x in range(5):\n    squares.append(x ** 2)\n\n# List comprehension (same result!)\nsquares = [x ** 2 for x in range(5)]\n\nprint(squares)    # [0, 1, 4, 9, 16]\n```\n\n---\n\n##  With Conditions\n\n```python\n[expression for item in iterable if condition]\n```\n\n### Filter Example\n\n```python\nnumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]\n\n# Only even numbers\nevens = [n for n in numbers if n % 2 == 0]\nprint(evens)    # [2, 4, 6, 8, 10]\n\n# Numbers greater than 5\nbig = [n for n in numbers if n > 5]\nprint(big)      # [6, 7, 8, 9, 10]\n```\n\n---\n\n##  Hotel Examples\n\n### Generate Room Numbers\n\n```python\n# Rooms 101-110\nfirst_floor = [100 + i for i in range(1, 11)]\nprint(first_floor)    # [101, 102, ..., 110]\n\n# All rooms on floors 1-3\nall_rooms = [f * 100 + r for f in range(1, 4) for r in range(1, 11)]\n```\n\n### Extract VIP Guests\n\n```python\nguests = [\n    {\"name\": \"Alice\", \"vip\": True},\n    {\"name\": \"Bob\", \"vip\": False},\n    {\"name\": \"Charlie\", \"vip\": True}\n]\n\nvip_names = [g[\"name\"] for g in guests if g[\"vip\"]]\nprint(vip_names)    # [\"Alice\", \"Charlie\"]\n```\n\n### Price Calculations\n\n```python\nprices = [100, 150, 200, 250, 300]\n\n# Apply 10% discount\ndiscounted = [p * 0.9 for p in prices]\nprint(discounted)    # [90.0, 135.0, 180.0, 225.0, 270.0]\n\n# Prices under $200\naffordable = [p for p in prices if p < 200]\nprint(affordable)    # [100, 150]\n```\n\n---\n\n##  When NOT to Use\n\n```python\n#  Too complex - hard to read\nresult = [x*y for x in range(10) if x%2==0 for y in range(10) if y%3==0 and x+y<15]\n\n#  Use regular loops for complex logic\nresult = []\nfor x in range(10):\n    if x % 2 == 0:\n        for y in range(10):\n            if y % 3 == 0 and x + y < 15:\n                result.append(x * y)\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - `[expr for x in list]`  transform each item\n> - `[expr for x in list if cond]`  filter items\n> - Keep it simple and readable!"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 8.4: Lists Quiz (12 questions)
-- ============================================
(
  'e0000000-0000-0000-0008-000000000004',
  'd0000000-0000-0000-0000-000000000008',
  '8.4',
  4,
  'Lists Quiz',
  'lists-quiz',
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
        "question": "What is the index of the FIRST item in a Python list?",
        "options": ["1", "0", "-1", "First"],
        "correct": 1,
        "explanation": "Python lists are ZERO-INDEXED. The first item is at index 0."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does list[-1] return?",
        "options": ["The first item", "The last item", "An error", "The list length"],
        "correct": 1,
        "explanation": "Negative indices count from the end. -1 is the LAST item."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which method adds an item to the END of a list?",
        "options": ["add()", "append()", "insert()", "extend()"],
        "correct": 1,
        "explanation": "append() adds a single item to the end of the list."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does len([1, 2, 3, 4, 5]) return?",
        "options": ["4", "5", "6", "[5]"],
        "correct": 1,
        "explanation": "len() returns the number of items. This list has 5 items."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the result?\n\nx = [1, 2, 3]\nx.append([4, 5])\nprint(len(x))",
        "options": ["3", "4", "5", "Error"],
        "correct": 1,
        "explanation": "append() adds [4,5] as ONE item. List becomes [1, 2, 3, [4, 5]]  length 4."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the result?\n\nx = [1, 2, 3]\nx.extend([4, 5])\nprint(len(x))",
        "options": ["3", "4", "5", "Error"],
        "correct": 2,
        "explanation": "extend() adds EACH item. List becomes [1, 2, 3, 4, 5]  length 5."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does [1, 2, 3][1:3] return?",
        "options": ["[1, 2]", "[2, 3]", "[1, 2, 3]", "[2]"],
        "correct": 1,
        "explanation": "Slice [1:3] means index 1 to index 2 (stop is exclusive): [2, 3]"
      },
      {
        "id": "q8",
        "type": "true_false",
        "difficulty": "applied",
        "question": "3 in [1, 2, 3, 4, 5] returns True",
        "correct": true,
        "explanation": "TRUE. The ''in'' operator checks if a value exists in the list. 3 is in the list."
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nnums = [3, 1, 4, 1, 5]\nnums.sort()\nprint(nums[0])",
        "options": ["3", "1", "5", "Error"],
        "correct": 1,
        "explanation": "sort() sorts in place. Sorted: [1, 1, 3, 4, 5]. First item (index 0): 1"
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What does this list comprehension produce?\n\n[x*2 for x in range(3)]",
        "options": ["[0, 1, 2]", "[0, 2, 4]", "[2, 4, 6]", "[1, 2, 3]"],
        "correct": 1,
        "explanation": "range(3)=0,1,2. Each multiplied by 2: [0, 2, 4]"
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the result?\n\nx = [1, 2, 3]\ny = x\ny.append(4)\nprint(x)",
        "options": ["[1, 2, 3]", "[1, 2, 3, 4]", "[4]", "Error"],
        "correct": 1,
        "explanation": "y = x creates a REFERENCE, not a copy. Both point to same list. x is also [1,2,3,4]."
      },
      {
        "id": "q12",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What does [n for n in range(10) if n % 2 == 0] produce?",
        "options": ["[1, 3, 5, 7, 9]", "[0, 2, 4, 6, 8]", "[2, 4, 6, 8, 10]", "[0, 1, 2, 3, 4]"],
        "correct": 1,
        "explanation": "Filters even numbers (n % 2 == 0) from range(10): [0, 2, 4, 6, 8]"
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
-- Activity 8.5: Module 8 Checkpoint
-- ============================================
(
  'e0000000-0000-0000-0008-000000000005',
  'd0000000-0000-0000-0000-000000000008',
  '8.5',
  5,
  'Module 8 Checkpoint',
  'module-8-checkpoint',
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
        "question": "What type of brackets are used to create a list in Python?",
        "options": ["() parentheses", "[] square brackets", "{} curly braces", "<> angle brackets"],
        "correct": 1,
        "explanation": "Lists use square brackets: [1, 2, 3]"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Can a Python list contain items of different data types?",
        "options": ["Yes", "No", "Only numbers and strings", "Only with special syntax"],
        "correct": 0,
        "explanation": "Yes! Lists can mix types: [\"text\", 42, 3.14, True]"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does pop() return?",
        "options": ["Nothing", "True or False", "The removed item", "The list length"],
        "correct": 2,
        "explanation": "pop() removes AND returns the item."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\ncolors = [\"red\", \"green\", \"blue\"]\nprint(colors[1])",
        "options": ["red", "green", "blue", "Error"],
        "correct": 1,
        "explanation": "Index 1 is the SECOND item (zero-indexed): green"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does this produce?\n\n[x**2 for x in [1, 2, 3]]",
        "options": ["[1, 2, 3]", "[2, 4, 6]", "[1, 4, 9]", "[1, 2, 9]"],
        "correct": 2,
        "explanation": "Squares each number: 1=1, 2=4, 3=9  [1, 4, 9]"
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "After this code, what is nums?\n\nnums = [1, 2, 3]\nnums.insert(1, 9)",
        "options": ["[9, 1, 2, 3]", "[1, 9, 2, 3]", "[1, 2, 9, 3]", "[1, 2, 3, 9]"],
        "correct": 1,
        "explanation": "insert(1, 9) inserts 9 at index 1: [1, 9, 2, 3]"
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\ndata = [5, 2, 8, 1, 9]\nprint(max(data), min(data))",
        "options": ["9 1", "1 9", "5 5", "Error"],
        "correct": 0,
        "explanation": "max() returns 9, min() returns 1. Output: 9 1"
      },
      {
        "id": "cp8",
        "type": "true_false",
        "difficulty": "exam",
        "question": "list.sort() returns a new sorted list.",
        "correct": false,
        "explanation": "FALSE. sort() modifies in place and returns None. Use sorted() for a new list."
      },
      {
        "id": "cp9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What does [1, 2, 3][::-1] return?",
        "options": ["[1, 2, 3]", "[3, 2, 1]", "[1, 3]", "Error"],
        "correct": 1,
        "explanation": "[::-1] reverses the list: [3, 2, 1]"
      },
      {
        "id": "cp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nx = [1, 2, 3]\nx.remove(2)\nx.append(4)\nprint(x)",
        "options": ["[1, 3, 4]", "[1, 2, 4]", "[1, 2, 3, 4]", "[2, 3, 4]"],
        "correct": 0,
        "explanation": "remove(2) deletes 2: [1, 3]. append(4) adds 4: [1, 3, 4]"
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
