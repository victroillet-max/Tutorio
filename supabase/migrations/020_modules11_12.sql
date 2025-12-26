-- ============================================
-- Modules 10-12: Dictionaries, File Handling, Error Handling
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- ============================================

-- ============================================
-- MODULE 10: Dictionaries
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

(
  'e0000000-0000-0000-0010-000000000001',
  'd0000000-0000-0000-0000-000000000010',
  '10.1',
  1,
  'Introduction to Dictionaries',
  'intro-to-dictionaries',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to Dictionaries\n\n##  Why This Matters\n\nA hotel needs to look up guest information by room number, not by position in a list. **Dictionaries store data as key-value pairs**, perfect for quick lookups and organized data storage.\n\n---\n\n##  What is a Dictionary?\n\n> A **dictionary** is an unordered collection of key-value pairs.\n\n```python\n# Creating a dictionary\nguest = {\n    \"name\": \"Alice Smith\",\n    \"room\": 405,\n    \"vip\": True,\n    \"nights\": 3\n}\n```\n\n### Dictionary vs List\n\n```\n\n            LIST                       DICTIONARY       \n\n  Access by INDEX (position)       Access by KEY (name) \n  guests[0]                        guest[\"name\"]        \n  Ordered                          Ordered (Python 3.7+)\n  [\"Alice\", \"Bob\"]                 {\"name\": \"Alice\"}    \n\n```\n\n---\n\n##  Accessing Values\n\n```python\nguest = {\"name\": \"Alice\", \"room\": 405, \"vip\": True}\n\n# Using brackets\nprint(guest[\"name\"])      # Alice\nprint(guest[\"room\"])      # 405\n\n# Using get() (safer - returns None if key missing)\nprint(guest.get(\"name\"))         # Alice\nprint(guest.get(\"email\"))        # None (no error)\nprint(guest.get(\"email\", \"N/A\")) # N/A (custom default)\n```\n\n---\n\n##  Modifying Dictionaries\n\n```python\nguest = {\"name\": \"Alice\", \"room\": 405}\n\n# Add new key-value\nguest[\"email\"] = \"alice@email.com\"\n\n# Update existing value\nguest[\"room\"] = 501\n\n# Delete a key\ndel guest[\"email\"]\n\n# Remove and return\nroom = guest.pop(\"room\")    # Returns 501, removes key\n\nprint(guest)    # {\"name\": \"Alice\"}\n```\n\n---\n\n##  Iterating Over Dictionaries\n\n```python\nguest = {\"name\": \"Alice\", \"room\": 405, \"nights\": 3}\n\n# Keys only\nfor key in guest:\n    print(key)\n\n# Values only\nfor value in guest.values():\n    print(value)\n\n# Both keys and values\nfor key, value in guest.items():\n    print(f\"{key}: {value}\")\n```\n\n---\n\n##  Hotel Examples\n\n### Guest Database\n\n```python\nguests = {\n    101: {\"name\": \"Alice\", \"vip\": True},\n    102: {\"name\": \"Bob\", \"vip\": False},\n    103: {\"name\": \"Charlie\", \"vip\": True}\n}\n\n# Look up guest by room\nroom_num = 102\nif room_num in guests:\n    print(f\"Room {room_num}: {guests[room_num][''name'']}\")\n```\n\n### Room Rates\n\n```python\nrates = {\n    \"standard\": 150,\n    \"deluxe\": 250,\n    \"suite\": 400,\n    \"penthouse\": 800\n}\n\nroom_type = \"deluxe\"\nprice = rates.get(room_type, 150)  # Default to standard\nprint(f\"{room_type.title()}: ${price}/night\")\n```\n\n---\n\n##  Dictionary Methods\n\n```python\nd = {\"a\": 1, \"b\": 2}\n\nd.keys()      # dict_keys([''a'', ''b''])\nd.values()    # dict_values([1, 2])\nd.items()     # dict_items([(''a'', 1), (''b'', 2)])\nlen(d)        # 2\n\"a\" in d      # True\nd.clear()     # Empties the dictionary\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - Dictionaries: `{key: value}` pairs\n> - Access: `dict[key]` or `dict.get(key)`\n> - Check membership: `key in dict`\n> - Iterate: `.keys()`, `.values()`, `.items()`"}'::jsonb,
  NULL,
  false,
  true
),

(
  'e0000000-0000-0000-0010-000000000002',
  'd0000000-0000-0000-0000-000000000010',
  '10.2',
  2,
  'Dictionary Practice',
  'dictionary-practice',
  'code',
  12,
  40,
  'basic',
  '{
    "instructions": "Create a hotel room inventory system!\n\n**Tasks:**\n1. Create a dictionary with room types and their prices\n2. Add a new room type \"presidential\" at $1200\n3. Update \"deluxe\" price to $275\n4. Print all room types and their prices\n5. Calculate average price of all rooms",
    "starterCode": "# Room inventory system\n\n# Task 1: Create dictionary\nroom_prices = {\n    \"standard\": 150,\n    \"deluxe\": 250,\n    \"suite\": 400\n}\n\n# Task 2: Add presidential suite\n\n\n# Task 3: Update deluxe price\n\n\n# Task 4: Print all rooms\nprint(\"Room Prices:\")\n\n\n# Task 5: Calculate average price\n",
    "solution": "# Room inventory system\n\n# Task 1: Create dictionary\nroom_prices = {\n    \"standard\": 150,\n    \"deluxe\": 250,\n    \"suite\": 400\n}\n\n# Task 2: Add presidential suite\nroom_prices[\"presidential\"] = 1200\n\n# Task 3: Update deluxe price\nroom_prices[\"deluxe\"] = 275\n\n# Task 4: Print all rooms\nprint(\"Room Prices:\")\nfor room_type, price in room_prices.items():\n    print(f\"  {room_type.title()}: ${price}\")\n\n# Task 5: Calculate average price\naverage = sum(room_prices.values()) / len(room_prices)\nprint(f\"\\nAverage price: ${average:.2f}\")",
    "testCases": [
      {"input": "", "expectedOutput": "Presidential: $1200", "description": "Presidential suite added"},
      {"input": "", "expectedOutput": "Deluxe: $275", "description": "Deluxe updated"},
      {"input": "", "expectedOutput": "Average price:", "description": "Average calculated"}
    ],
    "hints": [
      "Add new key: dict[\"key\"] = value",
      "Update: same syntax as adding",
      "Use .items() for key-value pairs",
      "sum(dict.values()) gets total of all values"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'e0000000-0000-0000-0010-000000000003',
  'd0000000-0000-0000-0000-000000000010',
  '10.3',
  3,
  'Module 10 Checkpoint',
  'module-10-checkpoint',
  'checkpoint',
  12,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What symbols are used to create a dictionary?",
        "options": ["[] square brackets", "{} curly braces", "() parentheses", "<> angle brackets"],
        "correct": 1,
        "explanation": "Dictionaries use curly braces: {\"key\": \"value\"}"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "How do you access a value in a dictionary?",
        "options": ["dict(key)", "dict[key]", "dict.key", "dict->key"],
        "correct": 1,
        "explanation": "Use square brackets with the key: dict[\"key\"]"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does dict.get(\"x\", 0) return if \"x\" doesn''t exist?",
        "options": ["None", "Error", "0", "\"x\""],
        "correct": 2,
        "explanation": "get() returns the default value (0) if the key doesn''t exist."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\nd = {\"a\": 1, \"b\": 2}\nprint(\"c\" in d)",
        "options": ["True", "False", "Error", "None"],
        "correct": 1,
        "explanation": "\"c\" is not a key in d, so \"c\" in d returns False."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is printed?\n\nd = {\"x\": 10}\nd[\"x\"] = 20\nd[\"y\"] = 30\nprint(len(d))",
        "options": ["1", "2", "3", "60"],
        "correct": 1,
        "explanation": "d has 2 keys: x (updated to 20) and y (added). len(d) = 2"
      }
    ],
    "passing_score": 70,
    "blocks_progress": true
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- MODULE 11: File Handling
-- ============================================

(
  'e0000000-0000-0000-0011-000000000001',
  'd0000000-0000-0000-0000-000000000011',
  '11.1',
  1,
  'Reading and Writing Files',
  'file-handling',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Reading and Writing Files\n\n##  Why This Matters\n\nHotels store guest data, reservations, and reports in files. **File handling lets your programs save data permanently and load it later.**\n\n---\n\n##  Opening Files\n\n```python\n# Basic syntax\nfile = open(\"filename.txt\", \"mode\")\n# ... do something with file\nfile.close()\n\n# Better: with statement (auto-closes)\nwith open(\"filename.txt\", \"mode\") as file:\n    # ... do something with file\n# File automatically closed here\n```\n\n### File Modes\n\n| Mode | Description |\n|------|-------------|\n| `\"r\"` | Read (default) |\n| `\"w\"` | Write (overwrites!) |\n| `\"a\"` | Append (adds to end) |\n| `\"r+\"` | Read and write |\n\n---\n\n##  Reading Files\n\n```python\n# Read entire file as string\nwith open(\"guests.txt\", \"r\") as f:\n    content = f.read()\n    print(content)\n\n# Read line by line\nwith open(\"guests.txt\", \"r\") as f:\n    for line in f:\n        print(line.strip())  # strip() removes newline\n\n# Read all lines into list\nwith open(\"guests.txt\", \"r\") as f:\n    lines = f.readlines()\n```\n\n---\n\n##  Writing Files\n\n```python\n# Write (overwrites existing content!)\nwith open(\"output.txt\", \"w\") as f:\n    f.write(\"Hello, World!\\n\")\n    f.write(\"Second line\\n\")\n\n# Append (adds to end)\nwith open(\"log.txt\", \"a\") as f:\n    f.write(\"New entry\\n\")\n```\n\n---\n\n##  Hotel Examples\n\n### Save Guest List\n\n```python\nguests = [\"Alice Smith\", \"Bob Jones\", \"Charlie Brown\"]\n\nwith open(\"guests.txt\", \"w\") as f:\n    for guest in guests:\n        f.write(guest + \"\\n\")\n\nprint(\"Guest list saved!\")\n```\n\n### Load Guest List\n\n```python\nguests = []\nwith open(\"guests.txt\", \"r\") as f:\n    for line in f:\n        guests.append(line.strip())\n\nprint(f\"Loaded {len(guests)} guests\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: File Not Found\n\n```python\ntry:\n    with open(\"data.txt\", \"r\") as f:\n        content = f.read()\nexcept FileNotFoundError:\n    print(\"File not found!\")\n```\n\n### Mistake 2: Forgetting to Close\n\n```python\n#  If error occurs, file may stay open\nf = open(\"file.txt\")\ndata = f.read()\nf.close()\n\n#  with statement handles closing\nwith open(\"file.txt\") as f:\n    data = f.read()\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - Always use `with open()` for safety\n> - `\"r\"` = read, `\"w\"` = write (overwrites!), `\"a\"` = append\n> - `.read()` = entire file, `for line in f` = line by line\n> - `.strip()` removes newlines from lines"}'::jsonb,
  NULL,
  false,
  true
),

(
  'e0000000-0000-0000-0011-000000000002',
  'd0000000-0000-0000-0000-000000000011',
  '11.2',
  2,
  'Module 11 Checkpoint',
  'module-11-checkpoint',
  'checkpoint',
  10,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which mode opens a file for reading?",
        "options": ["\"w\"", "\"r\"", "\"a\"", "\"x\""],
        "correct": 1,
        "explanation": "\"r\" is read mode (and the default)."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What happens when you open an existing file with mode \"w\"?",
        "options": ["Error", "Appends to file", "Overwrites the file", "Opens read-only"],
        "correct": 2,
        "explanation": "\"w\" mode OVERWRITES the entire file. Be careful!"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Why use ''with open()'' instead of ''open()''?",
        "options": ["It''s faster", "It auto-closes the file", "It''s required", "No difference"],
        "correct": 1,
        "explanation": "with statement automatically closes the file, even if errors occur."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What does line.strip() do when reading a file?",
        "options": ["Deletes the line", "Removes whitespace/newlines", "Splits the line", "Counts characters"],
        "correct": 1,
        "explanation": "strip() removes leading/trailing whitespace including \\n newlines."
      }
    ],
    "passing_score": 70,
    "blocks_progress": true
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- MODULE 12: Error Handling
-- ============================================

(
  'e0000000-0000-0000-0012-000000000001',
  'd0000000-0000-0000-0000-000000000012',
  '12.1',
  1,
  'Exception Handling',
  'exception-handling',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Exception Handling\n\n##  Why This Matters\n\nPrograms crash. Files go missing. Users enter invalid data. **Exception handling lets your program respond gracefully to errors** instead of crashing.\n\n---\n\n##  What is an Exception?\n\n> An **exception** is an error that occurs during program execution.\n\n```python\n# Common exceptions\nprint(1 / 0)           # ZeroDivisionError\nprint(int(\"hello\"))    # ValueError\nprint(x)               # NameError (x not defined)\nprint([1,2][5])        # IndexError\n```\n\n---\n\n##  try-except Block\n\n```python\ntry:\n    # Code that might cause an error\n    result = 10 / 0\nexcept:\n    # Code to handle the error\n    print(\"An error occurred!\")\n```\n\n### Catching Specific Exceptions\n\n```python\ntry:\n    num = int(input(\"Enter a number: \"))\n    result = 100 / num\n    print(f\"Result: {result}\")\nexcept ValueError:\n    print(\"That''s not a valid number!\")\nexcept ZeroDivisionError:\n    print(\"Cannot divide by zero!\")\n```\n\n---\n\n##  try-except-else-finally\n\n```python\ntry:\n    file = open(\"data.txt\", \"r\")\nexcept FileNotFoundError:\n    print(\"File not found!\")\nelse:\n    # Runs if NO exception occurred\n    content = file.read()\n    file.close()\nfinally:\n    # ALWAYS runs (cleanup)\n    print(\"Operation complete\")\n```\n\n---\n\n##  Hotel Examples\n\n### Safe Room Number Input\n\n```python\ndef get_room_number():\n    while True:\n        try:\n            room = int(input(\"Enter room number: \"))\n            if 100 <= room <= 999:\n                return room\n            else:\n                print(\"Room must be between 100-999\")\n        except ValueError:\n            print(\"Please enter a valid number\")\n\nroom = get_room_number()\nprint(f\"Room {room} selected\")\n```\n\n### Safe File Reading\n\n```python\ndef load_guests():\n    try:\n        with open(\"guests.txt\", \"r\") as f:\n            return f.readlines()\n    except FileNotFoundError:\n        print(\"Guest file not found, starting fresh\")\n        return []\n\nguests = load_guests()\n```\n\n---\n\n##  Common Exceptions\n\n| Exception | Cause |\n|-----------|-------|\n| `ValueError` | Wrong value type |\n| `TypeError` | Wrong data type |\n| `ZeroDivisionError` | Division by zero |\n| `IndexError` | List index out of range |\n| `KeyError` | Dictionary key not found |\n| `FileNotFoundError` | File doesn''t exist |\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - `try`: Code that might fail\n> - `except`: Handle specific errors\n> - `else`: Runs if no error\n> - `finally`: Always runs (cleanup)\n> - Catch specific exceptions when possible"}'::jsonb,
  NULL,
  false,
  true
),

(
  'e0000000-0000-0000-0012-000000000002',
  'd0000000-0000-0000-0000-000000000012',
  '12.2',
  2,
  'Module 12 Checkpoint',
  'module-12-checkpoint',
  'checkpoint',
  10,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What keyword starts an exception handling block?",
        "options": ["catch", "try", "handle", "error"],
        "correct": 1,
        "explanation": "try: begins the block that might raise an exception."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What exception is raised by int(\"hello\")?",
        "options": ["TypeError", "ValueError", "SyntaxError", "NameError"],
        "correct": 1,
        "explanation": "ValueError - \"hello\" is not a valid integer value."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "When does the ''finally'' block run?",
        "options": ["Only if error occurs", "Only if no error", "Always", "Never"],
        "correct": 2,
        "explanation": "finally ALWAYS runs, whether or not an exception occurred."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\ntry:\n    print(\"A\")\n    x = 1/0\n    print(\"B\")\nexcept:\n    print(\"C\")\nprint(\"D\")",
        "options": ["A B C D", "A C D", "A D", "C D"],
        "correct": 1,
        "explanation": "A prints, error occurs, B skipped, C prints (except), D prints after."
      }
    ],
    "passing_score": 70,
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
