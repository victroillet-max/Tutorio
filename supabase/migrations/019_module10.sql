-- ============================================
-- Module 10: Dictionaries - FULLY EXPANDED
-- Gold Standard Lesson Structure
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 10.1: Introduction to Dictionaries
-- ============================================
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
  '{"markdown": "# Introduction to Dictionaries\n\n##  Why This Matters\n\nImagine trying to find a guest''s information in a list of 500 guests  you''d have to search through each one! **Dictionaries let you look up information instantly by name or ID**, just like a real dictionary lets you look up a word.\n\n---\n\n##  What is a Dictionary?\n\n> A **dictionary** is an unordered collection of **key-value pairs**.\n\nThink of it like a real dictionary:\n- **Key** = the word you look up\n- **Value** = the definition you find\n\n```python\n# Real dictionary analogy\nword_definitions = {\n    \"algorithm\": \"A step-by-step procedure\",\n    \"variable\": \"A named storage location\",\n    \"loop\": \"Code that repeats\"\n}\n\n# Hotel guest database\nguest = {\n    \"name\": \"Alice Smith\",\n    \"room\": 405,\n    \"vip\": True,\n    \"nights\": 3,\n    \"balance\": 599.97\n}\n```\n\n---\n\n##  Dictionary vs List\n\n```\n\n                  LIST vs DICTIONARY                         \n\n            LIST                       DICTIONARY           \n\n Access by INDEX (position)    Access by KEY (name)         \n guests[0]                     guest[\"name\"]                \n\n Order matters                 Order preserved (Python 3.7+)\n\n [\"Alice\", \"Bob\", \"Charlie\"]   {\"name\": \"Alice\", \"age\": 30} \n\n Good for: sequences           Good for: structured data    \n\n```\n\n### When to Use Which?\n\n| Use Case | Best Choice |\n|----------|-------------|\n| List of room numbers | List |\n| Guest profile with multiple attributes | Dictionary |\n| Waiting queue (first in, first out) | List |\n| Room rates by room type | Dictionary |\n| Daily revenue figures | List |\n| Lookup table (ID  info) | Dictionary |\n\n---\n\n##  Creating Dictionaries\n\n```python\n# Method 1: Curly braces (most common)\nguest = {\n    \"name\": \"Alice\",\n    \"room\": 405\n}\n\n# Method 2: dict() constructor\nguest = dict(name=\"Alice\", room=405)\n\n# Method 3: Empty dictionary, add later\nguest = {}\nguest[\"name\"] = \"Alice\"\nguest[\"room\"] = 405\n\n# Method 4: From list of tuples\nguest = dict([(\"name\", \"Alice\"), (\"room\", 405)])\n```\n\n---\n\n##  Accessing Values\n\n### Using Brackets [ ]\n\n```python\nguest = {\"name\": \"Alice\", \"room\": 405, \"vip\": True}\n\nprint(guest[\"name\"])     # Alice\nprint(guest[\"room\"])     # 405\nprint(guest[\"email\"])    #  KeyError! Key doesn''t exist\n```\n\n### Using .get() (Safer!)\n\n```python\nguest = {\"name\": \"Alice\", \"room\": 405}\n\n# Returns None if key missing (no error)\nprint(guest.get(\"name\"))         # Alice\nprint(guest.get(\"email\"))        # None\n\n# Provide a default value\nprint(guest.get(\"email\", \"N/A\"))           # N/A\nprint(guest.get(\"vip\", False))             # False\nprint(guest.get(\"loyalty_points\", 0))      # 0\n```\n\n---\n\n##  Modifying Dictionaries\n\n### Add or Update Values\n\n```python\nguest = {\"name\": \"Alice\", \"room\": 405}\n\n# Add new key-value pair\nguest[\"email\"] = \"alice@email.com\"\nguest[\"vip\"] = True\n\n# Update existing value\nguest[\"room\"] = 501    # Changed rooms!\n\nprint(guest)\n# {\"name\": \"Alice\", \"room\": 501, \"email\": \"alice@email.com\", \"vip\": True}\n```\n\n### Remove Values\n\n```python\nguest = {\"name\": \"Alice\", \"room\": 405, \"vip\": True}\n\n# Delete a key\ndel guest[\"vip\"]\n\n# Remove and return value\nroom = guest.pop(\"room\")      # Returns 405, removes key\nprint(room)                    # 405\nprint(guest)                   # {\"name\": \"Alice\"}\n\n# Remove and return with default\nemail = guest.pop(\"email\", \"none\")   # Returns \"none\", no error\n```\n\n---\n\n##  Iterating Over Dictionaries\n\n```python\nguest = {\"name\": \"Alice\", \"room\": 405, \"nights\": 3}\n\n# Iterate over KEYS (default)\nfor key in guest:\n    print(key)\n# name, room, nights\n\n# Iterate over VALUES\nfor value in guest.values():\n    print(value)\n# Alice, 405, 3\n\n# Iterate over BOTH (most useful!)\nfor key, value in guest.items():\n    print(f\"{key}: {value}\")\n# name: Alice\n# room: 405\n# nights: 3\n```\n\n---\n\n##  Hotel Examples\n\n### Guest Database by Room Number\n\n```python\nguests = {\n    101: {\"name\": \"Alice Smith\", \"vip\": True, \"checkout\": \"2024-03-20\"},\n    102: {\"name\": \"Bob Jones\", \"vip\": False, \"checkout\": \"2024-03-18\"},\n    103: {\"name\": \"Charlie Brown\", \"vip\": True, \"checkout\": \"2024-03-22\"}\n}\n\n# Quick lookup by room number\nroom_num = 102\nif room_num in guests:\n    info = guests[room_num]\n    print(f\"Room {room_num}: {info[''name'']}\")\n    if info[\"vip\"]:\n        print(\"   VIP Guest\")\n```\n\n### Room Rates System\n\n```python\nroom_rates = {\n    \"standard\": 150,\n    \"deluxe\": 250,\n    \"suite\": 400,\n    \"penthouse\": 800\n}\n\ndef calculate_stay(room_type, nights):\n    rate = room_rates.get(room_type, 150)  # Default to standard\n    return rate * nights\n\nprint(calculate_stay(\"deluxe\", 3))     # 750\nprint(calculate_stay(\"economy\", 2))    # 300 (used default)\n```\n\n### Counting Occurrences\n\n```python\nbookings = [\"standard\", \"deluxe\", \"standard\", \"suite\", \n            \"standard\", \"deluxe\", \"penthouse\", \"standard\"]\n\n# Count each room type\ncounts = {}\nfor room_type in bookings:\n    counts[room_type] = counts.get(room_type, 0) + 1\n\nprint(counts)\n# {\"standard\": 4, \"deluxe\": 2, \"suite\": 1, \"penthouse\": 1}\n```\n\n---\n\n##  Dictionary Methods Reference\n\n```python\nd = {\"a\": 1, \"b\": 2, \"c\": 3}\n\n# Get all keys, values, items\nd.keys()        # dict_keys([''a'', ''b'', ''c''])\nd.values()      # dict_values([1, 2, 3])\nd.items()       # dict_items([(''a'', 1), (''b'', 2), (''c'', 3)])\n\n# Check membership\n\"a\" in d        # True (checks KEYS only)\n\"x\" in d        # False\n\n# Length\nlen(d)          # 3\n\n# Update with another dict\nd.update({\"d\": 4, \"a\": 10})   # Adds d, updates a\n\n# Clear all items\nd.clear()       # {}\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: KeyError When Accessing Missing Key\n\n```python\nguest = {\"name\": \"Alice\"}\nprint(guest[\"email\"])    #  KeyError!\n\n#  Use .get() or check first\nprint(guest.get(\"email\", \"No email\"))   # Safe!\n\nif \"email\" in guest:\n    print(guest[\"email\"])\n```\n\n### Mistake 2: Using Mutable Objects as Keys\n\n```python\n#  Lists can''t be keys (mutable)\ndata = {[1, 2]: \"value\"}    # TypeError!\n\n#  Tuples can be keys (immutable)\ndata = {(1, 2): \"value\"}    # Works!\n```\n\n### Mistake 3: Confusing in Behavior\n\n```python\nd = {\"name\": \"Alice\", \"age\": 30}\n\n# ''in'' checks KEYS, not values\nprint(\"name\" in d)     # True\nprint(\"Alice\" in d)    # False! (Alice is a value)\n\n# To check values:\nprint(\"Alice\" in d.values())   # True\n```\n\n---\n\n##  Pro Tips\n\n> **Tip 1:** Use `.get()` with defaults to avoid KeyError and simplify code.\n\n> **Tip 2:** Dictionary comprehensions work like list comprehensions:\n> ```python\n> squares = {x: x**2 for x in range(5)}\n> # {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}\n> ```\n\n> **Tip 3:** Nested dictionaries are great for complex data:\n> ```python\n> hotel = {\n>     \"rooms\": {101: \"occupied\", 102: \"vacant\"},\n>     \"rates\": {\"standard\": 150, \"deluxe\": 250}\n> }\n> ```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Dictionaries: `{key: value}` pairs\n> - Create: `{}` or `dict()`\n> - Access: `dict[key]` or `dict.get(key, default)`\n> - Add/Update: `dict[key] = value`\n> - Delete: `del dict[key]` or `dict.pop(key)`\n> - Check: `key in dict` (checks keys only!)\n> - Iterate: `.keys()`, `.values()`, `.items()`"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 10.2: Dictionary Practice (Code)
-- ============================================
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
    "instructions": "Build a hotel room inventory management system!\n\n**Tasks:**\n\n1. Create a dictionary called `room_rates` with these room types and prices:\n   - standard: 150\n   - deluxe: 250\n   - suite: 400\n   - penthouse: 800\n\n2. Add a new room type \"presidential\" with rate 1500\n\n3. The deluxe rate increased - update it to 275\n\n4. Print all room types and their rates in a formatted way\n\n5. Calculate and print the average room rate\n\n6. Create a function `get_total(room_type, nights)` that returns the total cost (use .get() with standard as default)\n\n**Expected output format:**\n```\nRoom Rates:\n  Standard: $150/night\n  Deluxe: $275/night\n  ...\n\nAverage rate: $XXX.XX\n\nTotal for 3 nights in deluxe: $825\n```",
    "starterCode": "# Hotel Room Inventory System\n\n# Task 1: Create room_rates dictionary\n\n\n# Task 2: Add presidential suite\n\n\n# Task 3: Update deluxe rate\n\n\n# Task 4: Print all room types\nprint(\"Room Rates:\")\n\n\n# Task 5: Calculate average rate\n\n\n# Task 6: Create get_total function\ndef get_total(room_type, nights):\n    pass\n\n# Test get_total\nprint(f\"\\nTotal for 3 nights in deluxe: ${get_total(''deluxe'', 3)}\")\nprint(f\"Total for 2 nights in economy: ${get_total(''economy'', 2)}\")",
    "solution": "# Hotel Room Inventory System\n\n# Task 1: Create room_rates dictionary\nroom_rates = {\n    \"standard\": 150,\n    \"deluxe\": 250,\n    \"suite\": 400,\n    \"penthouse\": 800\n}\n\n# Task 2: Add presidential suite\nroom_rates[\"presidential\"] = 1500\n\n# Task 3: Update deluxe rate\nroom_rates[\"deluxe\"] = 275\n\n# Task 4: Print all room types\nprint(\"Room Rates:\")\nfor room_type, rate in room_rates.items():\n    print(f\"  {room_type.title()}: ${rate}/night\")\n\n# Task 5: Calculate average rate\naverage = sum(room_rates.values()) / len(room_rates)\nprint(f\"\\nAverage rate: ${average:.2f}\")\n\n# Task 6: Create get_total function\ndef get_total(room_type, nights):\n    rate = room_rates.get(room_type, room_rates[\"standard\"])\n    return rate * nights\n\n# Test get_total\nprint(f\"\\nTotal for 3 nights in deluxe: ${get_total(''deluxe'', 3)}\")\nprint(f\"Total for 2 nights in economy: ${get_total(''economy'', 2)}\")",
    "testCases": [
      {"input": "", "expectedOutput": "Presidential: $1500", "description": "Presidential added correctly"},
      {"input": "", "expectedOutput": "Deluxe: $275", "description": "Deluxe updated correctly"},
      {"input": "", "expectedOutput": "Average rate:", "description": "Average calculated"},
      {"input": "", "expectedOutput": "825", "description": "get_total works for deluxe"},
      {"input": "", "expectedOutput": "300", "description": "get_total defaults to standard for unknown type"}
    ],
    "hints": [
      "Add new key: dict[\"key\"] = value",
      "Update uses same syntax: dict[\"key\"] = new_value",
      "Use .items() to get both key and value in loop",
      "sum(dict.values()) adds all values",
      "Use .get(key, default) for safe access with fallback"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 10.3: Nested Dictionaries
-- ============================================
(
  'e0000000-0000-0000-0010-000000000003',
  'd0000000-0000-0000-0000-000000000010',
  '10.3',
  3,
  'Nested Dictionaries',
  'nested-dictionaries',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Nested Dictionaries\n\n##  Why This Matters\n\nReal data is complex! A guest has a name, contact info, payment details, and preferences. **Nested dictionaries let you organize hierarchical data**  dictionaries within dictionaries.\n\n---\n\n##  What is Nesting?\n\n```python\n# Simple dictionary\nguest = {\"name\": \"Alice\", \"room\": 405}\n\n# Nested dictionary (dictionary inside dictionary)\nguest = {\n    \"name\": \"Alice Smith\",\n    \"room\": 405,\n    \"contact\": {\n        \"email\": \"alice@email.com\",\n        \"phone\": \"555-1234\"\n    },\n    \"preferences\": {\n        \"floor\": \"high\",\n        \"bed\": \"king\",\n        \"smoking\": False\n    }\n}\n```\n\n---\n\n##  Accessing Nested Data\n\n```python\nguest = {\n    \"name\": \"Alice\",\n    \"contact\": {\n        \"email\": \"alice@email.com\",\n        \"phone\": \"555-1234\"\n    }\n}\n\n# Chain the brackets\nprint(guest[\"contact\"][\"email\"])    # alice@email.com\nprint(guest[\"contact\"][\"phone\"])    # 555-1234\n\n# Safer with .get()\nemail = guest.get(\"contact\", {}).get(\"email\", \"N/A\")\n```\n\n---\n\n##  Hotel Database Example\n\n```python\nhotel_database = {\n    101: {\n        \"guest\": \"Alice Smith\",\n        \"status\": \"occupied\",\n        \"check_in\": \"2024-03-15\",\n        \"check_out\": \"2024-03-18\",\n        \"charges\": {\n            \"room\": 450.00,\n            \"minibar\": 35.50,\n            \"room_service\": 89.00\n        }\n    },\n    102: {\n        \"guest\": \"Bob Jones\",\n        \"status\": \"occupied\",\n        \"check_in\": \"2024-03-16\",\n        \"check_out\": \"2024-03-17\",\n        \"charges\": {\n            \"room\": 150.00,\n            \"minibar\": 0,\n            \"room_service\": 0\n        }\n    }\n}\n\n# Access specific data\nroom_101_guest = hotel_database[101][\"guest\"]\nroom_101_minibar = hotel_database[101][\"charges\"][\"minibar\"]\n\n# Calculate total charges for a room\ndef get_total_charges(room_num):\n    charges = hotel_database[room_num][\"charges\"]\n    return sum(charges.values())\n\nprint(f\"Room 101 total: ${get_total_charges(101):.2f}\")  # $574.50\n```\n\n---\n\n##  Modifying Nested Data\n\n```python\nhotel = {\n    101: {\"guest\": \"Alice\", \"charges\": {\"room\": 300}}\n}\n\n# Add nested value\nhotel[101][\"charges\"][\"spa\"] = 150\n\n# Update nested value\nhotel[101][\"charges\"][\"room\"] = 350\n\n# Add new nested dictionary\nhotel[102] = {\n    \"guest\": \"Bob\",\n    \"charges\": {\"room\": 200}\n}\n```\n\n---\n\n##  Pro Tip: List of Dictionaries\n\n```python\n# Common pattern: list of guest dictionaries\nguests = [\n    {\"name\": \"Alice\", \"room\": 101, \"vip\": True},\n    {\"name\": \"Bob\", \"room\": 102, \"vip\": False},\n    {\"name\": \"Charlie\", \"room\": 103, \"vip\": True}\n]\n\n# Find all VIP guests\nvips = [g[\"name\"] for g in guests if g[\"vip\"]]\nprint(vips)  # [\"Alice\", \"Charlie\"]\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - Nest dictionaries for hierarchical data\n> - Chain brackets: `dict[\"outer\"][\"inner\"]`\n> - Use `.get()` chains for safety\n> - Lists of dictionaries are very common"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 10.4: Dictionaries Quiz
-- ============================================
(
  'e0000000-0000-0000-0010-000000000004',
  'd0000000-0000-0000-0000-000000000010',
  '10.4',
  4,
  'Dictionaries Quiz',
  'dictionaries-quiz',
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
        "question": "What symbols are used to create a dictionary?",
        "options": ["[] square brackets", "{} curly braces", "() parentheses", "<> angle brackets"],
        "correct": 1,
        "explanation": "Dictionaries use curly braces: {\"key\": \"value\"}"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "In a dictionary, what do you use to look up a value?",
        "options": ["Index number", "Key", "Position", "Value"],
        "correct": 1,
        "explanation": "Dictionaries use keys to access values: dict[\"key\"]"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does dict.get(\"x\", 0) return if \"x\" doesn''t exist?",
        "options": ["None", "Error", "0", "\"x\""],
        "correct": 2,
        "explanation": ".get() returns the default value (0) if the key doesn''t exist."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\nd = {\"a\": 1, \"b\": 2}\nprint(\"c\" in d)",
        "options": ["True", "False", "Error", "None"],
        "correct": 1,
        "explanation": "\"c\" is not a key in d, so \"c\" in d returns False."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\nd = {\"name\": \"Alice\"}\nd[\"age\"] = 30\nprint(len(d))",
        "options": ["1", "2", "30", "Error"],
        "correct": 1,
        "explanation": "Started with 1 key, added 1 more. len(d) = 2"
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which method returns both keys AND values?",
        "options": [".keys()", ".values()", ".items()", ".all()"],
        "correct": 2,
        "explanation": ".items() returns key-value pairs as tuples."
      },
      {
        "id": "q7",
        "type": "true_false",
        "difficulty": "applied",
        "question": "\"Alice\" in {\"name\": \"Alice\"} returns True.",
        "correct": false,
        "explanation": "FALSE. ''in'' checks KEYS, not values. \"name\" in d would be True."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nd = {\"x\": 10}\nd[\"x\"] = 20\nd[\"y\"] = 30\nprint(d[\"x\"] + d[\"y\"])",
        "options": ["10", "30", "50", "Error"],
        "correct": 2,
        "explanation": "d[\"x\"] was updated to 20, d[\"y\"] is 30. 20 + 30 = 50"
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is printed?\n\ndata = {\"a\": {\"b\": 5}}\nprint(data[\"a\"][\"b\"])",
        "options": ["5", "{\"b\": 5}", "Error", "None"],
        "correct": 0,
        "explanation": "Nested access: data[\"a\"] gives {\"b\": 5}, then [\"b\"] gives 5."
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What does {x: x**2 for x in range(3)} produce?",
        "options": ["{0: 0, 1: 1, 2: 4}", "[0, 1, 4]", "{1: 1, 2: 4, 3: 9}", "Error"],
        "correct": 0,
        "explanation": "Dictionary comprehension: 00, 11, 24. Result: {0: 0, 1: 1, 2: 4}"
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
-- Activity 10.5: Guest Lookup Challenge
-- ============================================
(
  'e0000000-0000-0000-0010-000000000005',
  'd0000000-0000-0000-0000-000000000010',
  '10.5',
  5,
  'Challenge: Guest Lookup System',
  'guest-lookup-challenge',
  'code',
  15,
  50,
  'basic',
  '{
    "instructions": "Build a complete guest lookup system!\n\n**Given:** A nested dictionary of hotel guests\n\n**Implement these functions:**\n\n1. `find_guest(room_number)` - Returns guest name or \"Room not found\"\n\n2. `get_total_bill(room_number)` - Returns sum of all charges or 0 if not found\n\n3. `list_vip_guests()` - Returns a list of names of all VIP guests\n\n4. `checkout(room_number)` - Removes guest from database, returns their total bill or \"Room not found\"",
    "starterCode": "# Hotel Guest Database\nguests = {\n    101: {\n        \"name\": \"Alice Smith\",\n        \"vip\": True,\n        \"charges\": {\"room\": 450, \"minibar\": 35, \"spa\": 120}\n    },\n    102: {\n        \"name\": \"Bob Jones\",\n        \"vip\": False,\n        \"charges\": {\"room\": 300, \"minibar\": 0}\n    },\n    201: {\n        \"name\": \"Charlie Brown\",\n        \"vip\": True,\n        \"charges\": {\"room\": 600, \"restaurant\": 85}\n    }\n}\n\n# Function 1: Find guest by room number\ndef find_guest(room_number):\n    pass\n\n# Function 2: Get total bill for a room\ndef get_total_bill(room_number):\n    pass\n\n# Function 3: List all VIP guests\ndef list_vip_guests():\n    pass\n\n# Function 4: Checkout a guest\ndef checkout(room_number):\n    pass\n\n# Test your functions\nprint(\"Guest in 101:\", find_guest(101))\nprint(\"Guest in 999:\", find_guest(999))\nprint(\"Bill for 101:\", get_total_bill(101))\nprint(\"VIP guests:\", list_vip_guests())\nprint(\"Checkout 102:\", checkout(102))\nprint(\"Remaining rooms:\", list(guests.keys()))",
    "solution": "# Hotel Guest Database\nguests = {\n    101: {\n        \"name\": \"Alice Smith\",\n        \"vip\": True,\n        \"charges\": {\"room\": 450, \"minibar\": 35, \"spa\": 120}\n    },\n    102: {\n        \"name\": \"Bob Jones\",\n        \"vip\": False,\n        \"charges\": {\"room\": 300, \"minibar\": 0}\n    },\n    201: {\n        \"name\": \"Charlie Brown\",\n        \"vip\": True,\n        \"charges\": {\"room\": 600, \"restaurant\": 85}\n    }\n}\n\n# Function 1: Find guest by room number\ndef find_guest(room_number):\n    if room_number in guests:\n        return guests[room_number][\"name\"]\n    return \"Room not found\"\n\n# Function 2: Get total bill for a room\ndef get_total_bill(room_number):\n    if room_number in guests:\n        return sum(guests[room_number][\"charges\"].values())\n    return 0\n\n# Function 3: List all VIP guests\ndef list_vip_guests():\n    return [info[\"name\"] for room, info in guests.items() if info[\"vip\"]]\n\n# Function 4: Checkout a guest\ndef checkout(room_number):\n    if room_number in guests:\n        total = get_total_bill(room_number)\n        del guests[room_number]\n        return total\n    return \"Room not found\"\n\n# Test your functions\nprint(\"Guest in 101:\", find_guest(101))\nprint(\"Guest in 999:\", find_guest(999))\nprint(\"Bill for 101:\", get_total_bill(101))\nprint(\"VIP guests:\", list_vip_guests())\nprint(\"Checkout 102:\", checkout(102))\nprint(\"Remaining rooms:\", list(guests.keys()))",
    "testCases": [
      {"input": "", "expectedOutput": "Alice Smith", "description": "find_guest(101) returns Alice Smith"},
      {"input": "", "expectedOutput": "Room not found", "description": "find_guest(999) returns Room not found"},
      {"input": "", "expectedOutput": "605", "description": "get_total_bill(101) returns 605"},
      {"input": "", "expectedOutput": "Alice Smith", "description": "VIP list includes Alice"},
      {"input": "", "expectedOutput": "Charlie Brown", "description": "VIP list includes Charlie"}
    ],
    "hints": [
      "Check if room_number in guests before accessing",
      "sum(dict.values()) adds all values in a dictionary",
      "Use list comprehension to filter VIP guests",
      "del dict[key] removes a key-value pair"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 10.6: Module 10 Checkpoint
-- ============================================
(
  'e0000000-0000-0000-0010-000000000006',
  'd0000000-0000-0000-0000-000000000010',
  '10.6',
  6,
  'Module 10 Checkpoint',
  'module-10-checkpoint',
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
        "question": "What type of brackets create a dictionary?",
        "options": ["[] square", "{} curly", "() parentheses", "<> angle"],
        "correct": 1,
        "explanation": "Dictionaries use curly braces: {\"key\": value}"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Can a Python list be used as a dictionary key?",
        "options": ["Yes", "No", "Only if empty", "Only with numbers"],
        "correct": 1,
        "explanation": "Lists are mutable, so they cannot be dictionary keys. Use tuples instead."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does .get() return if the key doesn''t exist and no default is given?",
        "options": ["0", "False", "None", "Error"],
        "correct": 2,
        "explanation": ".get() returns None by default if the key is missing."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\nd = {\"a\": 1, \"b\": 2}\nfor k in d:\n    print(k, end=\" \")",
        "options": ["1 2", "a b", "a 1 b 2", "(a, 1) (b, 2)"],
        "correct": 1,
        "explanation": "Iterating over a dict iterates over its KEYS: a b"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "How do you safely access d[\"x\"] with default 0?",
        "options": ["d[\"x\", 0]", "d.get(\"x\", 0)", "d.default(\"x\", 0)", "d[\"x\"] or 0"],
        "correct": 1,
        "explanation": "dict.get(key, default) returns default if key missing."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does d.pop(\"x\") do?",
        "options": ["Returns value, keeps key", "Returns value, removes key", "Just removes key", "Returns True/False"],
        "correct": 1,
        "explanation": "pop() removes the key AND returns its value."
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is printed?\n\nd = {\"outer\": {\"inner\": 42}}\nprint(d[\"outer\"][\"inner\"])",
        "options": ["{\"inner\": 42}", "42", "outer.inner", "Error"],
        "correct": 1,
        "explanation": "Chain access: d[\"outer\"] = {\"inner\": 42}, then [\"inner\"] = 42"
      },
      {
        "id": "cp8",
        "type": "true_false",
        "difficulty": "exam",
        "question": "d.values() returns a list of all values.",
        "correct": false,
        "explanation": "FALSE. It returns a dict_values object. Use list(d.values()) for a list."
      },
      {
        "id": "cp9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the result?\n\ncounts = {}\nfor x in [\"a\", \"b\", \"a\", \"a\", \"b\"]:\n    counts[x] = counts.get(x, 0) + 1\nprint(counts[\"a\"])",
        "options": ["1", "2", "3", "Error"],
        "correct": 2,
        "explanation": "\"a\" appears 3 times. The pattern counts.get(x, 0) + 1 counts occurrences."
      },
      {
        "id": "cp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which creates a dictionary comprehension?",
        "options": ["[k: v for k, v in items]", "{k: v for k, v in items}", "(k: v for k, v in items)", "<k: v for k, v in items>"],
        "correct": 1,
        "explanation": "Dictionary comprehensions use curly braces: {key: value for ...}"
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
