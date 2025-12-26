-- ============================================
-- Activities for Module 8: Collections Part 2 - Tuples, Sets & Dictionaries
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0008-000000000001',
    'd0000000-0000-0000-0000-000000000008',
    '8.1',
    1,
    'Tuples Explained',
    'tuples-explained',
    'lesson',
    6,
    15,
    'basic',
    '{"markdown": "# Tuples Explained\n\nA tuple is an ordered, immutable collection of items.\n\n## Creating Tuples\n\n```python\n# With parentheses\ncoordinates = (10, 20)\ncolors = (\"red\", \"green\", \"blue\")\n\n# Without parentheses (tuple packing)\npoint = 5, 10\n\n# Single item tuple (note the comma!)\nsingle = (42,)      # This is a tuple\nnot_tuple = (42)    # This is just an integer!\n\n# Empty tuple\nempty = ()\n```\n\n## Tuples vs Lists\n\n| Feature | List | Tuple |\n|---------|------|-------|\n| Syntax | [1, 2, 3] | (1, 2, 3) |\n| Mutable | Yes | No |\n| Use case | Changing data | Fixed data |\n\n## Accessing Items\n\n```python\ncolors = (\"red\", \"green\", \"blue\")\n\nprint(colors[0])      # red\nprint(colors[-1])     # blue\nprint(colors[0:2])    # (\"red\", \"green\")\n```\n\n## Immutability\n\n```python\ncolors = (\"red\", \"green\", \"blue\")\ncolors[0] = \"yellow\"  # TypeError! Cannot modify\n```\n\n## Tuple Unpacking\n\n```python\ncoordinates = (10, 20, 30)\nx, y, z = coordinates\n\nprint(x)  # 10\nprint(y)  # 20\nprint(z)  # 30\n\n# Swap variables elegantly\na, b = 1, 2\na, b = b, a\nprint(a, b)  # 2 1\n```\n\n## When to Use Tuples\n\n- Return multiple values from functions\n- Dictionary keys (lists cannot be keys)\n- Data that should not change"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0008-000000000002',
    'd0000000-0000-0000-0000-000000000008',
    '8.2',
    2,
    'Sets Explained',
    'sets-explained',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Sets Explained\n\nA set is an unordered collection of unique items.\n\n## Creating Sets\n\n```python\n# With curly braces\nfruits = {\"apple\", \"banana\", \"cherry\"}\n\n# From a list (removes duplicates!)\nnumbers = set([1, 2, 2, 3, 3, 3])\nprint(numbers)  # {1, 2, 3}\n\n# Empty set (NOT {} - that''s a dict!)\nempty = set()\n```\n\n## Set Properties\n\n1. **Unordered** - No index access\n2. **Unique** - No duplicates allowed\n3. **Mutable** - Can add/remove items\n\n## Basic Operations\n\n```python\ncolors = {\"red\", \"green\", \"blue\"}\n\n# Add item\ncolors.add(\"yellow\")\n\n# Remove item\ncolors.remove(\"red\")      # Error if not found\ncolors.discard(\"purple\")  # No error if not found\n\n# Check membership (very fast!)\nprint(\"green\" in colors)  # True\n\n# Length\nprint(len(colors))        # 3\n```\n\n## Removing Duplicates\n\n```python\n# Quick way to remove duplicates from a list\nnames = [\"Alice\", \"Bob\", \"Alice\", \"Charlie\", \"Bob\"]\nunique_names = list(set(names))\nprint(unique_names)  # [\"Alice\", \"Bob\", \"Charlie\"]\n```\n\n## When to Use Sets\n\n- Removing duplicates\n- Fast membership testing\n- Mathematical set operations\n- Tracking unique items"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0008-000000000003',
    'd0000000-0000-0000-0000-000000000008',
    '8.3',
    3,
    'Set Operations Visualizer',
    'set-operations-visualizer',
    'interactive',
    8,
    30,
    'basic',
    '{
      "instructions": "Visualize and practice set operations like union, intersection, and difference.",
      "type": "set-operations",
      "exercises": [
        {
          "setA": [1, 2, 3, 4, 5],
          "setB": [4, 5, 6, 7, 8],
          "operation": "union",
          "symbol": "|",
          "answer": [1, 2, 3, 4, 5, 6, 7, 8],
          "explanation": "Union combines all unique elements from both sets"
        },
        {
          "setA": [1, 2, 3, 4, 5],
          "setB": [4, 5, 6, 7, 8],
          "operation": "intersection",
          "symbol": "&",
          "answer": [4, 5],
          "explanation": "Intersection finds elements common to both sets"
        },
        {
          "setA": [1, 2, 3, 4, 5],
          "setB": [4, 5, 6, 7, 8],
          "operation": "difference",
          "symbol": "-",
          "answer": [1, 2, 3],
          "explanation": "Difference finds elements in A but not in B"
        }
      ]
    }'::jsonb,
    'set-operations',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0008-000000000004',
    'd0000000-0000-0000-0000-000000000008',
    '8.4',
    4,
    'Dictionaries Intro',
    'dictionaries-intro',
    'lesson',
    8,
    15,
    'basic',
    '{"markdown": "# Dictionaries Introduction\n\nA dictionary stores key-value pairs.\n\n## Creating Dictionaries\n\n```python\n# Basic syntax\nperson = {\n    \"name\": \"Alice\",\n    \"age\": 25,\n    \"city\": \"Zurich\"\n}\n\n# Empty dictionary\nempty = {}\nempty = dict()\n```\n\n## Accessing Values\n\n```python\nperson = {\"name\": \"Alice\", \"age\": 25}\n\n# Using brackets\nprint(person[\"name\"])       # Alice\nprint(person[\"age\"])        # 25\n\n# Using get() - safer, returns None if key missing\nprint(person.get(\"name\"))   # Alice\nprint(person.get(\"email\"))  # None\nprint(person.get(\"email\", \"N/A\"))  # N/A (default value)\n```\n\n## Adding & Modifying\n\n```python\nperson = {\"name\": \"Alice\"}\n\n# Add new key-value pair\nperson[\"age\"] = 25\n\n# Modify existing value\nperson[\"name\"] = \"Alicia\"\n\nprint(person)  # {\"name\": \"Alicia\", \"age\": 25}\n```\n\n## Dictionary Properties\n\n1. **Keys must be unique**\n2. **Keys must be immutable** (strings, numbers, tuples)\n3. **Values can be anything**\n4. **Ordered** (Python 3.7+)\n\n## Real-World Examples\n\n- User profiles\n- Configuration settings\n- API responses\n- Database records"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0008-000000000005',
    'd0000000-0000-0000-0000-000000000008',
    '8.5',
    5,
    'Dict Methods',
    'dict-methods',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Dictionary Methods\n\n## Getting Keys, Values, Items\n\n```python\nperson = {\"name\": \"Alice\", \"age\": 25, \"city\": \"Zurich\"}\n\n# All keys\nprint(person.keys())    # dict_keys([\"name\", \"age\", \"city\"])\n\n# All values\nprint(person.values())  # dict_values([\"Alice\", 25, \"Zurich\"])\n\n# All key-value pairs\nprint(person.items())   # dict_items([(\"name\", \"Alice\"), ...])\n```\n\n## Adding & Removing\n\n```python\nperson = {\"name\": \"Alice\", \"age\": 25}\n\n# Update with multiple pairs\nperson.update({\"city\": \"Zurich\", \"country\": \"Switzerland\"})\n\n# Remove and return value\nage = person.pop(\"age\")\nprint(age)          # 25\n\n# Remove last inserted item\nlast = person.popitem()\n\n# Clear all\nperson.clear()\n```\n\n## Checking Keys\n\n```python\nperson = {\"name\": \"Alice\", \"age\": 25}\n\n# Check if key exists\nif \"name\" in person:\n    print(\"Name exists!\")\n\nif \"email\" not in person:\n    print(\"No email provided\")\n```\n\n## Iterating\n\n```python\nperson = {\"name\": \"Alice\", \"age\": 25}\n\n# Loop through keys\nfor key in person:\n    print(key)\n\n# Loop through key-value pairs\nfor key, value in person.items():\n    print(f\"{key}: {value}\")\n```\n\n## setdefault()\n\n```python\ncounts = {}\n\n# Add key if it doesn''t exist\ncounts.setdefault(\"apple\", 0)\ncounts[\"apple\"] += 1\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0008-000000000006',
    'd0000000-0000-0000-0000-000000000008',
    '8.6',
    6,
    'Dict Practice',
    'dict-practice',
    'code',
    10,
    30,
    'basic',
    '{
      "instructions": "Create a student record dictionary and perform operations:\n1. Create a dictionary with name, age, and grade\n2. Add an \"email\" field\n3. Update the grade to \"A+\"\n4. Print all the keys\n5. Check if \"phone\" exists in the record",
      "starterCode": "# 1. Create student dictionary\nstudent = {\n    # Add name, age, and grade\n}\n\n# 2. Add email field\n\n# 3. Update grade to \"A+\"\n\n# 4. Print all keys\n\n# 5. Check if \"phone\" exists\n",
      "solution": "# 1. Create student dictionary\nstudent = {\n    \"name\": \"Alice\",\n    \"age\": 20,\n    \"grade\": \"A\"\n}\n\n# 2. Add email field\nstudent[\"email\"] = \"alice@example.com\"\n\n# 3. Update grade to \"A+\"\nstudent[\"grade\"] = \"A+\"\n\n# 4. Print all keys\nprint(\"Keys:\", list(student.keys()))\n\n# 5. Check if \"phone\" exists\nif \"phone\" in student:\n    print(\"Phone number exists\")\nelse:\n    print(\"No phone number on record\")",
      "testCases": [
        {"input": "", "expectedOutput": "No phone number on record", "description": "Should detect missing phone field"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0008-000000000007',
    'd0000000-0000-0000-0000-000000000008',
    '8.7',
    7,
    'Collection Chooser',
    'collection-chooser',
    'interactive',
    8,
    25,
    'basic',
    '{
      "instructions": "Choose the best collection type for each scenario.",
      "type": "collection-chooser",
      "scenarios": [
        {
          "description": "Store a user''s profile with name, email, and age",
          "answer": "dictionary",
          "explanation": "Dictionaries are perfect for key-value data like profiles"
        },
        {
          "description": "Keep track of items in a shopping cart (can have duplicates)",
          "answer": "list",
          "explanation": "Lists maintain order and allow duplicates"
        },
        {
          "description": "Store unique visitor IPs to count unique visits",
          "answer": "set",
          "explanation": "Sets automatically handle uniqueness"
        },
        {
          "description": "Store GPS coordinates that should never change",
          "answer": "tuple",
          "explanation": "Tuples are immutable, perfect for fixed data"
        },
        {
          "description": "Track which users are online (no duplicates needed)",
          "answer": "set",
          "explanation": "Sets provide fast lookup and ensure uniqueness"
        }
      ]
    }'::jsonb,
    'collection-chooser',
    false,
    true
  ),
  (
    'e0000000-0000-0000-0008-000000000008',
    'd0000000-0000-0000-0000-000000000008',
    '8.8',
    8,
    'Room Database Challenge',
    'room-database-challenge',
    'code',
    12,
    45,
    'basic',
    '{
      "instructions": "Create a hotel room database:\n1. Create a dictionary with room numbers as keys\n2. Each room should have: type, price, and is_available\n3. Add 3 rooms (101, 102, 103)\n4. Mark room 102 as unavailable\n5. Find and print all available rooms",
      "starterCode": "# Hotel Room Database\n\n# Create rooms dictionary\nrooms = {}\n\n# Add room 101 (single, $99, available)\n\n# Add room 102 (double, $149, available)\n\n# Add room 103 (suite, $299, available)\n\n# Mark room 102 as unavailable\n\n# Find and print all available rooms\nprint(\"Available rooms:\")\n",
      "solution": "# Hotel Room Database\n\n# Create rooms dictionary\nrooms = {}\n\n# Add room 101 (single, $99, available)\nrooms[101] = {\"type\": \"single\", \"price\": 99, \"is_available\": True}\n\n# Add room 102 (double, $149, available)\nrooms[102] = {\"type\": \"double\", \"price\": 149, \"is_available\": True}\n\n# Add room 103 (suite, $299, available)\nrooms[103] = {\"type\": \"suite\", \"price\": 299, \"is_available\": True}\n\n# Mark room 102 as unavailable\nrooms[102][\"is_available\"] = False\n\n# Find and print all available rooms\nprint(\"Available rooms:\")\nfor room_num, details in rooms.items():\n    if details.get(\"is_available\"):\n        rtype = details.get(\"type\")\n        rprice = details.get(\"price\")\n        print(f\"  Room {room_num}: {rtype} - ${rprice}\")",
      "testCases": [
        {"input": "", "expectedOutput": "Room 101", "description": "Should show room 101 as available"},
        {"input": "", "expectedOutput": "Room 103", "description": "Should show room 103 as available"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0008-000000000009',
    'd0000000-0000-0000-0000-000000000008',
    '8.9',
    9,
    'Nested Structures',
    'nested-structures',
    'lesson',
    7,
    15,
    'basic',
    '{"markdown": "# Nested Data Structures\n\nCollections can contain other collections!\n\n## Lists of Lists\n\n```python\n# Matrix / 2D grid\nmatrix = [\n    [1, 2, 3],\n    [4, 5, 6],\n    [7, 8, 9]\n]\n\nprint(matrix[0])      # [1, 2, 3]\nprint(matrix[0][1])   # 2\nprint(matrix[2][2])   # 9\n```\n\n## List of Dictionaries\n\n```python\nstudents = [\n    {\"name\": \"Alice\", \"grade\": 90},\n    {\"name\": \"Bob\", \"grade\": 85},\n    {\"name\": \"Charlie\", \"grade\": 92}\n]\n\n# Access\nprint(students[0][\"name\"])    # Alice\n\n# Iterate\nfor student in students:\n    name = student.get(\"name\")\n    grade = student.get(\"grade\")\n    print(f\"{name}: {grade}\")\n```\n\n## Dictionary of Lists\n\n```python\nclasses = {\n    \"math\": [\"Alice\", \"Bob\"],\n    \"science\": [\"Charlie\", \"Diana\"],\n    \"history\": [\"Eve\", \"Frank\"]\n}\n\nprint(classes[\"math\"])        # [\"Alice\", \"Bob\"]\nprint(classes[\"math\"][0])     # Alice\n\n# Add student to class\nclasses[\"math\"].append(\"Grace\")\n```\n\n## Dictionary of Dictionaries\n\n```python\nusers = {\n    \"user001\": {\n        \"name\": \"Alice\",\n        \"settings\": {\n            \"theme\": \"dark\",\n            \"notifications\": True\n        }\n    }\n}\n\nprint(users[\"user001\"][\"settings\"][\"theme\"])  # dark\n```\n\n## Real Example: API Response\n\n```python\nresponse = {\n    \"status\": \"success\",\n    \"data\": {\n        \"users\": [\n            {\"id\": 1, \"name\": \"Alice\"},\n            {\"id\": 2, \"name\": \"Bob\"}\n        ]\n    }\n}\n\nfirst_user = response[\"data\"][\"users\"][0][\"name\"]\nprint(first_user)  # Alice\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0008-000000000010',
    'd0000000-0000-0000-0000-000000000008',
    '8.10',
    10,
    'Nested Practice',
    'nested-practice',
    'code',
    10,
    30,
    'basic',
    '{
      "instructions": "Given the nested data structure below:\n1. Print the name of the first student\n2. Print the second course of \"Alice\"\n3. Add a new course \"History\" to Bob\n4. Print all students and their course count",
      "starterCode": "students = {\n    \"Alice\": {\n        \"age\": 20,\n        \"courses\": [\"Math\", \"Science\", \"English\"]\n    },\n    \"Bob\": {\n        \"age\": 22,\n        \"courses\": [\"Art\", \"Music\"]\n    }\n}\n\n# 1. Print the first student name (hint: convert keys to list)\n\n# 2. Print Alice''s second course\n\n# 3. Add \"History\" to Bob''s courses\n\n# 4. Print all students with their course count\n",
      "solution": "students = {\n    \"Alice\": {\n        \"age\": 20,\n        \"courses\": [\"Math\", \"Science\", \"English\"]\n    },\n    \"Bob\": {\n        \"age\": 22,\n        \"courses\": [\"Art\", \"Music\"]\n    }\n}\n\n# 1. Print the first student name\nfirst_student = list(students.keys())[0]\nprint(f\"First student: {first_student}\")\n\n# 2. Print Alice second course\nalice_courses = students[\"Alice\"][\"courses\"]\nprint(f\"Alice second course: {alice_courses[1]}\")\n\n# 3. Add History to Bob courses\nstudents[\"Bob\"][\"courses\"].append(\"History\")\n\n# 4. Print all students with their course count\nfor name, info in students.items():\n    course_count = len(info[\"courses\"])\n    print(f\"{name}: {course_count} courses\")",
      "testCases": [
        {"input": "", "expectedOutput": "First student: Alice", "description": "Should print Alice"},
        {"input": "", "expectedOutput": "Bob: 3 courses", "description": "Bob should have 3 courses after adding History"}
      ]
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0008-000000000011',
    'd0000000-0000-0000-0000-000000000008',
    '8.11',
    11,
    'Module 8 Checkpoint',
    'module-8-checkpoint',
    'checkpoint',
    15,
    55,
    'basic',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "Which collection type is immutable?",
          "options": ["List", "Set", "Tuple", "Dictionary"],
          "correct": 2
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "What does {1, 2, 2, 3, 3, 3} evaluate to?",
          "options": [
            "{1, 2, 2, 3, 3, 3}",
            "{1, 2, 3}",
            "[1, 2, 3]",
            "Error"
          ],
          "correct": 1,
          "explanation": "Sets automatically remove duplicates."
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "How do you safely get a value from a dict that might not exist?",
          "options": [
            "dict[key]",
            "dict.get(key)",
            "dict.find(key)",
            "dict.value(key)"
          ],
          "correct": 1
        },
        {
          "id": "cp4",
          "type": "true_false",
          "question": "A single element tuple is written as (42,) with a trailing comma.",
          "correct": true
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "Given d = {\"a\": 1, \"b\": 2}, what is list(d.keys())?",
          "options": [
            "[1, 2]",
            "[\"a\", \"b\"]",
            "[(\"a\", 1), (\"b\", 2)]",
            "{\"a\", \"b\"}"
          ],
          "correct": 1
        },
        {
          "id": "cp6",
          "type": "mcq",
          "question": "Which is used for removing duplicates from a list?",
          "options": [
            "list.unique()",
            "set(list)",
            "list.remove_duplicates()",
            "list.distinct()"
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

