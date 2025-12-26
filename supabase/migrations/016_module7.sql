-- ============================================
-- Module 7: Loops (while and for)
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 7.1: Introduction to Loops (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0007-000000000001',
  'd0000000-0000-0000-0000-000000000007',
  '7.1',
  1,
  'Introduction to Loops',
  'intro-to-loops',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Introduction to Loops\n\n##  Why This Matters\n\nImagine printing welcome messages for 500 hotel guests, or checking availability for every room on every floor. Without loops, you''d write the same code hundreds of times. **Loops let you repeat actions automatically  the core of programming power.**\n\n---\n\n##  What is a Loop?\n\n> A **loop** is a programming construct that repeats a block of code multiple times.\n\n### Without Loops (Tedious!)\n\n```python\nprint(\"Welcome, Guest 1!\")\nprint(\"Welcome, Guest 2!\")\nprint(\"Welcome, Guest 3!\")\nprint(\"Welcome, Guest 4!\")\nprint(\"Welcome, Guest 5!\")\n# ... imagine 500 more lines!\n```\n\n### With Loops (Elegant!)\n\n```python\nfor guest in range(1, 501):\n    print(f\"Welcome, Guest {guest}!\")\n```\n\n**Same result, 2 lines instead of 500!**\n\n---\n\n##  Two Types of Loops\n\n```\n\n                    PYTHON LOOPS                         \n\n       while                      for                   \n\n Repeats WHILE a        Repeats FOR EACH item           \n condition is True      in a sequence                   \n\n Use when you don''t     Use when you know how           \n know how many times    many times to repeat            \n\n while balance > 0:     for room in rooms:              \n     make_payment()         check_availability()        \n\n```\n\n---\n\n##  Real-World Loop Examples\n\n### Hotel Operations\n\n| Task | Loop Type | Why |\n|------|-----------|-----|\n| Process 50 check-ins | for | Known quantity |\n| Wait for payment | while | Unknown duration |\n| Send emails to guests | for | Known list |\n| Monitor room temperature | while | Continuous until threshold |\n| Generate room keys | for | Known count |\n| Accept reservations until full | while | Unknown when full |\n\n---\n\n##  Loop Anatomy\n\n```\n\n              LOOP STRUCTURE             \n\n                                         \n   1. INITIALIZATION                     \n      (Set up before loop)               \n                                        \n   2. CONDITION CHECK                    \n      (Should we continue?)              \n                                        \n   3. LOOP BODY                          \n      (Code that repeats)                \n                                        \n   4. UPDATE                             \n      (Change something)                 \n                                        \n      Back to step 2...                  \n                                         \n\n```\n\n---\n\n##  The Infinite Loop Danger\n\n> An **infinite loop** runs forever because its condition never becomes False.\n\n```python\n#  DANGER: Infinite loop!\ncount = 1\nwhile count <= 5:\n    print(count)\n    # Forgot to increment count!\n\n#  CORRECT: Loop terminates\ncount = 1\nwhile count <= 5:\n    print(count)\n    count += 1    # This makes it stop eventually!\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember:**\n> - Loops repeat code automatically\n> - `while` = repeat while condition is True\n> - `for` = repeat for each item in sequence\n> - Always ensure loops can terminate!\n\n**Coming up:** Deep dives into while loops and for loops!"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 7.2: while Loops Deep Dive (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0007-000000000002',
  'd0000000-0000-0000-0000-000000000007',
  '7.2',
  2,
  'while Loops Deep Dive',
  'while-loops',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# while Loops Deep Dive\n\n##  Why This Matters\n\nSome tasks need to repeat until a condition changes: keep accepting reservations until the hotel is full, keep asking for a password until it''s correct. **while loops handle situations where you don''t know in advance how many repetitions you need.**\n\n---\n\n##  Basic Syntax\n\n```python\nwhile condition:\n    # Code to repeat\n    # (must be indented)\n```\n\n### How It Works\n\n```\n\n         while LOOP FLOW                 \n                                         \n                         \n     Check                             \n     Condition                         \n                         \n                                        \n     True?   False?                     \n                                      \n      EXIT                   \n     Run Body   LOOP                   \n                             \n                                        \n          Back to Check          \n                                         \n\n```\n\n---\n\n##  Counting with while\n\n### Count Up\n\n```python\ncount = 1\nwhile count <= 5:\n    print(f\"Count: {count}\")\n    count += 1    # Increment!\n\nprint(\"Done!\")\n```\n\n**Output:**\n```\nCount: 1\nCount: 2\nCount: 3\nCount: 4\nCount: 5\nDone!\n```\n\n### Count Down\n\n```python\ncountdown = 5\nwhile countdown > 0:\n    print(countdown)\n    countdown -= 1    # Decrement!\n\nprint(\"Liftoff!\")\n```\n\n---\n\n##  Input Validation\n\n```python\npassword = \"\"\n\nwhile password != \"secret123\":\n    password = input(\"Enter password: \")\n    if password != \"secret123\":\n        print(\"Incorrect, try again.\")\n\nprint(\"Access granted!\")\n```\n\n### With Attempt Limit\n\n```python\nmax_attempts = 3\nattempts = 0\npassword = \"\"\n\nwhile password != \"secret123\" and attempts < max_attempts:\n    password = input(\"Enter password: \")\n    attempts += 1\n    \n    if password != \"secret123\" and attempts < max_attempts:\n        print(f\"Incorrect. {max_attempts - attempts} attempts remaining.\")\n\nif password == \"secret123\":\n    print(\"Access granted!\")\nelse:\n    print(\"Account locked.\")\n```\n\n---\n\n##  Hotel Examples\n\n### Room Booking Until Full\n\n```python\ntotal_rooms = 10\nbooked_rooms = 0\n\nwhile booked_rooms < total_rooms:\n    guest = input(\"Guest name (or ''stop'' to end): \")\n    \n    if guest.lower() == \"stop\":\n        break    # Exit loop early\n    \n    booked_rooms += 1\n    remaining = total_rooms - booked_rooms\n    print(f\"Booked! {remaining} rooms remaining.\")\n\nif booked_rooms == total_rooms:\n    print(\"HOTEL FULLY BOOKED!\")\nelse:\n    print(f\"Booking ended. {booked_rooms} rooms booked.\")\n```\n\n### Payment Processing\n\n```python\nbalance_due = 500.00\n\nprint(f\"Total due: ${balance_due:.2f}\")\n\nwhile balance_due > 0:\n    payment = float(input(\"Enter payment amount: $\"))\n    balance_due -= payment\n    \n    if balance_due > 0:\n        print(f\"Remaining balance: ${balance_due:.2f}\")\n    elif balance_due < 0:\n        print(f\"Change due: ${-balance_due:.2f}\")\n    else:\n        print(\"Exact payment. Thank you!\")\n\nprint(\"Payment complete!\")\n```\n\n---\n\n##  Loop Control: break and continue\n\n### break  Exit Loop Immediately\n\n```python\nwhile True:    # Infinite loop!\n    command = input(\"Enter command (quit to exit): \")\n    \n    if command == \"quit\":\n        break    # Escape the infinite loop\n    \n    print(f\"Processing: {command}\")\n\nprint(\"Goodbye!\")\n```\n\n### continue  Skip to Next Iteration\n\n```python\ncount = 0\nwhile count < 10:\n    count += 1\n    \n    if count % 2 == 0:    # Skip even numbers\n        continue\n    \n    print(count)    # Only prints odd: 1, 3, 5, 7, 9\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Infinite Loop\n\n```python\nx = 1\nwhile x < 5:\n    print(x)\n    #  Forgot x += 1  runs forever!\n```\n\n### Mistake 2: Off-by-One\n\n```python\ncount = 1\nwhile count < 5:    # Stops at 4, not 5!\n    print(count)\n    count += 1\n\n# Use <= if you want to include 5\nwhile count <= 5:    # Includes 5\n```\n\n### Mistake 3: Wrong Condition Update\n\n```python\nbalance = 100\nwhile balance > 0:\n    balance += 10    #  Getting bigger, never stops!\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - while loops repeat while condition is True\n> - ALWAYS update something to eventually exit\n> - `break` = exit loop immediately\n> - `continue` = skip to next iteration\n> - Check: will this loop ever end?"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 7.3: for Loops Deep Dive (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0007-000000000003',
  'd0000000-0000-0000-0000-000000000007',
  '7.3',
  3,
  'for Loops Deep Dive',
  'for-loops',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# for Loops Deep Dive\n\n##  Why This Matters\n\nWhen you need to process every guest in a list, every room on a floor, or repeat something exactly N times, **for loops are your go-to tool**. They''re cleaner and safer than while loops for known iterations.\n\n---\n\n##  Basic Syntax\n\n```python\nfor variable in sequence:\n    # Code using variable\n    # (must be indented)\n```\n\n### Simple Example\n\n```python\nfor name in [\"Alice\", \"Bob\", \"Charlie\"]:\n    print(f\"Hello, {name}!\")\n```\n\n**Output:**\n```\nHello, Alice!\nHello, Bob!\nHello, Charlie!\n```\n\n---\n\n##  range() Function\n\n> `range()` generates a sequence of numbers.\n\n### range(stop)\n\n```python\nfor i in range(5):    # 0, 1, 2, 3, 4\n    print(i)\n```\n\n### range(start, stop)\n\n```python\nfor i in range(1, 6):    # 1, 2, 3, 4, 5\n    print(i)\n```\n\n### range(start, stop, step)\n\n```python\nfor i in range(0, 10, 2):    # 0, 2, 4, 6, 8 (evens)\n    print(i)\n\nfor i in range(10, 0, -1):   # 10, 9, 8, ... 1 (countdown)\n    print(i)\n```\n\n---\n\n##  range() Cheat Sheet\n\n```\n\n                   range() PATTERNS                      \n\n range(5)                  0, 1, 2, 3, 4                \n range(1, 6)               1, 2, 3, 4, 5                \n range(0, 10, 2)           0, 2, 4, 6, 8                \n range(5, 0, -1)           5, 4, 3, 2, 1                \n range(10, 0, -2)          10, 8, 6, 4, 2               \n\n  Stop value is NEVER included!                        \n\n```\n\n---\n\n##  Iterating Over Sequences\n\n### Strings\n\n```python\nfor char in \"HOTEL\":\n    print(char)\n# H, O, T, E, L (each on new line)\n```\n\n### Lists\n\n```python\nrooms = [101, 102, 103, 104, 105]\n\nfor room in rooms:\n    print(f\"Checking room {room}...\")\n```\n\n### With Index: enumerate()\n\n```python\nguests = [\"Alice\", \"Bob\", \"Charlie\"]\n\nfor index, guest in enumerate(guests):\n    print(f\"{index + 1}. {guest}\")\n\n# Output:\n# 1. Alice\n# 2. Bob\n# 3. Charlie\n```\n\n---\n\n##  Hotel Examples\n\n### Generate Room Numbers\n\n```python\nprint(\"Available Rooms:\")\nfor floor in range(1, 5):        # Floors 1-4\n    for room in range(1, 11):    # Rooms 1-10\n        room_number = floor * 100 + room\n        print(room_number, end=\" \")\n    print()    # New line after each floor\n```\n\n### Process Guest List\n\n```python\nguests = [\n    {\"name\": \"Alice\", \"room\": 201, \"vip\": True},\n    {\"name\": \"Bob\", \"room\": 305, \"vip\": False},\n    {\"name\": \"Charlie\", \"room\": 412, \"vip\": True}\n]\n\nfor guest in guests:\n    status = \"VIP\" if guest[\"vip\"] else \"Standard\"\n    print(f\"{guest[''name'']} - Room {guest[''room'']} ({status})\")\n```\n\n### Calculate Total Revenue\n\n```python\nbookings = [199.99, 249.99, 349.99, 199.99, 449.99]\n\ntotal = 0\nfor booking in bookings:\n    total += booking\n\nprint(f\"Total revenue: ${total:.2f}\")\n\n# Or use sum():\ntotal = sum(bookings)\n```\n\n---\n\n##  Nested Loops\n\n```python\n# Multiplication table\nfor i in range(1, 4):\n    for j in range(1, 4):\n        print(f\"{i}  {j} = {i*j}\")\n    print(\"---\")\n```\n\n**Output:**\n```\n1  1 = 1\n1  2 = 2\n1  3 = 3\n---\n2  1 = 2\n2  2 = 4\n2  3 = 6\n---\n3  1 = 3\n3  2 = 6\n3  3 = 9\n---\n```\n\n---\n\n##  break and continue in for Loops\n\n### Find First VIP\n\n```python\nguests = [\"Alice\", \"Bob\", \"Charlie\", \"Diana\"]\nvip_list = [\"Charlie\", \"Eve\"]\n\nfor guest in guests:\n    if guest in vip_list:\n        print(f\"VIP found: {guest}\")\n        break    # Stop searching\nelse:    # Runs if loop completes without break\n    print(\"No VIP found\")\n```\n\n### Skip Certain Items\n\n```python\nrooms = [101, 102, 103, 104, 105]\nunder_maintenance = [103]\n\nfor room in rooms:\n    if room in under_maintenance:\n        continue    # Skip this room\n    print(f\"Room {room} is available\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Modifying List While Iterating\n\n```python\nnumbers = [1, 2, 3, 4, 5]\nfor n in numbers:\n    if n % 2 == 0:\n        numbers.remove(n)    #  Dangerous!\n\n# Instead, create new list:\nevens_removed = [n for n in numbers if n % 2 != 0]\n```\n\n### Mistake 2: Off-by-One with range()\n\n```python\n# Want 1 to 10?\nfor i in range(10):      #  Gives 0-9\n    print(i)\n\nfor i in range(1, 11):   #  Gives 1-10\n    print(i)\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - for loops iterate over sequences\n> - `range(n)` = 0 to n-1\n> - `range(a, b)` = a to b-1\n> - Stop value is NEVER included\n> - Use `enumerate()` for index + value\n> - `break` exits, `continue` skips"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 7.4: Loop Practice Exercise (Code)
-- ============================================
(
  'e0000000-0000-0000-0007-000000000004',
  'd0000000-0000-0000-0000-000000000007',
  '7.4',
  4,
  'Loop Practice Exercise',
  'loop-practice',
  'code',
  12,
  40,
  'basic',
  '{
    "instructions": "Practice both while and for loops!\n\n**Task 1:** Use a for loop to print numbers 1 through 5\n\n**Task 2:** Use a while loop to count down from 5 to 1, then print \"Blastoff!\"\n\n**Task 3:** Use a for loop to calculate the sum of numbers 1-10\n\n**Expected Output:**\n1\n2\n3\n4\n5\n---\n5\n4\n3\n2\n1\nBlastoff!\n---\nSum of 1-10: 55",
    "starterCode": "# Task 1: for loop - print 1 through 5\nprint(\"Task 1:\")\n\n\nprint(\"---\")\n\n# Task 2: while loop - countdown from 5\nprint(\"Task 2:\")\n\n\nprint(\"---\")\n\n# Task 3: for loop - sum of 1-10\nprint(\"Task 3:\")\n",
    "solution": "# Task 1: for loop - print 1 through 5\nprint(\"Task 1:\")\nfor i in range(1, 6):\n    print(i)\n\nprint(\"---\")\n\n# Task 2: while loop - countdown from 5\nprint(\"Task 2:\")\ncount = 5\nwhile count >= 1:\n    print(count)\n    count -= 1\nprint(\"Blastoff!\")\n\nprint(\"---\")\n\n# Task 3: for loop - sum of 1-10\nprint(\"Task 3:\")\ntotal = 0\nfor num in range(1, 11):\n    total += num\nprint(f\"Sum of 1-10: {total}\")",
    "testCases": [
      {"input": "", "expectedOutput": "1\n2\n3\n4\n5", "description": "Task 1: Numbers 1-5"},
      {"input": "", "expectedOutput": "Blastoff!", "description": "Task 2: Countdown ends with Blastoff"},
      {"input": "", "expectedOutput": "Sum of 1-10: 55", "description": "Task 3: Sum should be 55"}
    ],
    "hints": [
      "range(1, 6) gives 1, 2, 3, 4, 5",
      "For countdown: start at 5, decrease while >= 1",
      "For sum: start total at 0, add each number"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 7.5: Loops Quiz (12 questions)
-- ============================================
(
  'e0000000-0000-0000-0007-000000000005',
  'd0000000-0000-0000-0000-000000000007',
  '7.5',
  5,
  'Loops Quiz',
  'loops-quiz',
  'quiz',
  15,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "How many times will this loop run?\n\nfor i in range(5):\n    print(i)",
        "options": ["4", "5", "6", "0"],
        "correct": 1,
        "explanation": "range(5) produces 0, 1, 2, 3, 4  that''s 5 numbers, so 5 iterations."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does range(2, 5) produce?",
        "options": ["2, 3, 4, 5", "2, 3, 4", "1, 2, 3, 4, 5", "2, 3"],
        "correct": 1,
        "explanation": "range(2, 5) starts at 2 and stops BEFORE 5: 2, 3, 4"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which loop is best when you don''t know how many iterations needed?",
        "options": ["for loop", "while loop", "Both are equal", "Neither"],
        "correct": 1,
        "explanation": "while loops are ideal for unknown iterations (keep going until condition changes)."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does the break statement do?",
        "options": ["Pauses the loop", "Exits the loop immediately", "Skips to next iteration", "Restarts the loop"],
        "correct": 1,
        "explanation": "break immediately exits the current loop."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What will this print?\n\nfor i in range(3):\n    print(i, end=\" \")",
        "options": ["1 2 3", "0 1 2", "0 1 2 3", "1 2"],
        "correct": 1,
        "explanation": "range(3) = 0, 1, 2. With end=\" \", they print on same line: 0 1 2"
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "How many times does this while loop run?\n\nx = 10\nwhile x > 5:\n    x -= 2",
        "options": ["2", "3", "4", "5"],
        "correct": 1,
        "explanation": "x starts at 10. Loop runs: x=10864. When x=4, x>5 is False. Ran 3 times."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does continue do?",
        "options": ["Exits the loop", "Skips to next iteration", "Restarts from beginning", "Pauses execution"],
        "correct": 1,
        "explanation": "continue skips the rest of the current iteration and starts the next one."
      },
      {
        "id": "q8",
        "type": "true_false",
        "difficulty": "applied",
        "question": "range(5, 0, -1) produces: 5, 4, 3, 2, 1",
        "correct": true,
        "explanation": "TRUE. Step -1 counts down. Starts at 5, stops before 0."
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\ntotal = 0\nfor i in range(1, 4):\n    total += i\nprint(total)",
        "options": ["3", "6", "10", "4"],
        "correct": 1,
        "explanation": "range(1, 4) = 1, 2, 3. Total = 1 + 2 + 3 = 6"
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What will print?\n\nfor i in range(3):\n    if i == 1:\n        continue\n    print(i)",
        "options": ["0 1 2", "0 2", "1 2", "0 1"],
        "correct": 1,
        "explanation": "When i=1, continue skips the print. Output: 0, 2"
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\ncount = 0\nwhile count < 3:\n    count += 1\n    if count == 2:\n        break\nprint(count)",
        "options": ["1", "2", "3", "0"],
        "correct": 1,
        "explanation": "count=01 (not 2, continue), count=12 (is 2, break!). Final count: 2"
      },
      {
        "id": "q12",
        "type": "true_false",
        "difficulty": "exam",
        "question": "This loop will run forever:\n\nx = 1\nwhile x > 0:\n    x += 1",
        "correct": true,
        "explanation": "TRUE. x starts at 1 and keeps increasing. x > 0 is always True  infinite loop!"
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
-- Activity 7.6: Guest Check-In System Challenge
-- ============================================
(
  'e0000000-0000-0000-0007-000000000006',
  'd0000000-0000-0000-0000-000000000007',
  '7.6',
  6,
  'Challenge: Guest Check-In System',
  'checkin-challenge',
  'code',
  15,
  50,
  'basic',
  '{
    "instructions": "Build a guest check-in system using loops!\n\n**Requirements:**\n1. Start with 5 available rooms (101, 102, 103, 104, 105)\n2. Use a while loop to keep checking in guests until all rooms are full OR user types \"stop\"\n3. For each guest, print which room they''re assigned to\n4. After the loop, print a summary: how many rooms booked and how many available\n\n**Example interaction:**\n```\nAvailable rooms: 5\nGuest name (or stop): Alice\nAlice assigned to room 101\nAvailable rooms: 4\nGuest name (or stop): Bob\nBob assigned to room 102\nAvailable rooms: 3\nGuest name (or stop): stop\n---\nSummary: 2 rooms booked, 3 rooms available\n```",
    "starterCode": "# Guest Check-In System\n\n# Available rooms\nrooms = [101, 102, 103, 104, 105]\nbooked = []\n\n# Check-in loop\n\n\n# Print summary\n",
    "solution": "# Guest Check-In System\n\n# Available rooms\nrooms = [101, 102, 103, 104, 105]\nbooked = []\n\n# Check-in loop\nwhile len(rooms) > 0:\n    print(f\"Available rooms: {len(rooms)}\")\n    guest = input(\"Guest name (or stop): \")\n    \n    if guest.lower() == \"stop\":\n        break\n    \n    room = rooms.pop(0)  # Take first available room\n    booked.append((guest, room))\n    print(f\"{guest} assigned to room {room}\")\n\nprint(\"---\")\n\n# Print summary\nprint(f\"Summary: {len(booked)} rooms booked, {len(rooms)} rooms available\")\n\nif booked:\n    print(\"\\nGuests:\")\n    for guest, room in booked:\n        print(f\"  {guest} - Room {room}\")",
    "testCases": [
      {"input": "", "expectedOutput": "Summary:", "description": "Should show summary"},
      {"input": "", "expectedOutput": "rooms", "description": "Should mention rooms"}
    ],
    "hints": [
      "Use while len(rooms) > 0 to check if rooms available",
      "rooms.pop(0) removes and returns first room",
      "Check for ''stop'' input to break early",
      "Track booked rooms in a separate list"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 7.7: Module 7 Checkpoint
-- ============================================
(
  'e0000000-0000-0000-0007-000000000007',
  'd0000000-0000-0000-0000-000000000007',
  '7.7',
  7,
  'Module 7 Checkpoint',
  'module-7-checkpoint',
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
        "question": "What are the two main types of loops in Python?",
        "options": ["if and else", "for and while", "break and continue", "start and stop"],
        "correct": 1,
        "explanation": "Python has for loops (iterate over sequences) and while loops (repeat while condition is true)."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does range(1, 5) produce?",
        "options": ["1, 2, 3, 4, 5", "1, 2, 3, 4", "0, 1, 2, 3, 4", "0, 1, 2, 3, 4, 5"],
        "correct": 1,
        "explanation": "range(1, 5) starts at 1 and stops BEFORE 5: 1, 2, 3, 4"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which keyword immediately exits a loop?",
        "options": ["stop", "exit", "break", "end"],
        "correct": 2,
        "explanation": "break immediately exits the current loop."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\nfor i in range(3, 6):\n    print(i, end=\"-\")",
        "options": ["3-4-5-", "3-4-5-6-", "0-1-2-", "1-2-3-"],
        "correct": 0,
        "explanation": "range(3, 6) = 3, 4, 5. With end=\"-\", output is: 3-4-5-"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "How many times will ''Hello'' print?\n\ni = 0\nwhile i < 3:\n    print(\"Hello\")\n    i += 1",
        "options": ["2", "3", "4", "Infinite"],
        "correct": 1,
        "explanation": "i goes 0123. When i=3, i<3 is False. Printed 3 times (i=0,1,2)."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does continue do in a loop?",
        "options": ["Exits the loop", "Skips to next iteration", "Repeats current iteration", "Pauses the loop"],
        "correct": 1,
        "explanation": "continue skips remaining code in current iteration and moves to the next."
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the final value of sum?\n\nsum = 0\nfor n in range(1, 5):\n    if n == 3:\n        continue\n    sum += n",
        "options": ["10", "7", "6", "3"],
        "correct": 1,
        "explanation": "n=1,2,3,4. Skip n=3. Sum = 1+2+4 = 7"
      },
      {
        "id": "cp8",
        "type": "true_false",
        "difficulty": "exam",
        "question": "This code will cause an infinite loop:\n\ncount = 5\nwhile count > 0:\n    print(count)",
        "correct": true,
        "explanation": "TRUE. count stays at 5 forever (never decremented). count > 0 is always True."
      },
      {
        "id": "cp9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What will print?\n\nfor i in range(5):\n    if i == 2:\n        break\n    print(i)",
        "options": ["0 1", "0 1 2", "0 1 2 3 4", "2"],
        "correct": 0,
        "explanation": "i=0 prints, i=1 prints, i=2 hits break. Output: 0, 1"
      },
      {
        "id": "cp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nfor i in range(2):\n    for j in range(2):\n        print(f\"{i},{j}\", end=\" \")",
        "options": ["0,0 0,1 1,0 1,1", "0,0 1,1", "0,1 1,0", "1,1 1,2 2,1 2,2"],
        "correct": 0,
        "explanation": "Nested loops: outer i=0,1 and inner j=0,1 for each. Output: 0,0 0,1 1,0 1,1"
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
