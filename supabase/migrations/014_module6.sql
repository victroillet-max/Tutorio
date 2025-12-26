-- ============================================
-- Module 6: Conditionals & Boolean Logic
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- This is the MIDTERM BOUNDARY module
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 6.1: Boolean Logic Fundamentals (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0006-000000000001',
  'd0000000-0000-0000-0000-000000000006',
  '6.1',
  1,
  'Boolean Logic Fundamentals',
  'boolean-fundamentals',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Boolean Logic Fundamentals\n\n##  Why This Matters\n\nEvery decision your program makes  Should we give a discount? Is the room available? Can the guest check in early?  comes down to a simple **True or False** question. Understanding boolean logic is understanding how programs think.\n\n---\n\n##  What is a Boolean?\n\n> A **boolean** is a data type with only two possible values: `True` or `False`.\n\n```python\nis_vip = True\nhas_paid = False\nroom_available = True\n\nprint(type(is_vip))     # <class ''bool''>\n```\n\n### Important: Capitalization Matters!\n\n```python\nTrue      #  Correct (capital T)\nFalse     #  Correct (capital F)\ntrue      #  NameError (lowercase)\nfalse     #  NameError (lowercase)\n```\n\n---\n\n##  Comparison Operators\n\n> Comparisons **create** boolean values.\n\n```\n\n Operator  Meaning                Example      Result  \n\n    ==     Equal to               5 == 5        True   \n    !=     Not equal to           5 != 3        True   \n    <      Less than              3 < 5         True   \n    >      Greater than           5 > 3         True   \n    <=     Less than or equal     5 <= 5        True   \n    >=     Greater than or equal  5 >= 3        True   \n\n```\n\n### Examples\n\n```python\nprint(10 == 10)      # True\nprint(10 == 5)       # False\nprint(10 != 5)       # True (10 is not equal to 5)\nprint(10 < 20)       # True\nprint(10 > 20)       # False\nprint(10 <= 10)      # True (equal counts!)\nprint(10 >= 11)      # False\n```\n\n### Storing Comparisons\n\n```python\nage = 25\nis_adult = age >= 18     # True\nprint(is_adult)          # True\n\ntemperature = 15\nis_freezing = temperature < 0    # False\n```\n\n---\n\n##  Logical Operators: and, or, not\n\n### and  Both Must Be True\n\n```python\nTrue and True      # True\nTrue and False     # False\nFalse and True     # False\nFalse and False    # False\n```\n\n**Analogy:** \"I''ll go to the beach if it''s sunny AND warm.\"\n\n```python\nis_sunny = True\nis_warm = True\ngo_to_beach = is_sunny and is_warm    # True (both conditions met)\n```\n\n### or  At Least One Must Be True\n\n```python\nTrue or True       # True\nTrue or False      # True\nFalse or True      # True\nFalse or False     # False\n```\n\n**Analogy:** \"I''ll be happy if I get a raise OR a promotion.\"\n\n```python\ngot_raise = False\ngot_promotion = True\nis_happy = got_raise or got_promotion    # True (one is enough)\n```\n\n### not  Reverses the Value\n\n```python\nnot True           # False\nnot False          # True\n```\n\n**Analogy:** \"If it''s NOT raining, we go outside.\"\n\n```python\nis_raining = False\ngo_outside = not is_raining    # True\n```\n\n---\n\n##  Combining Operators\n\n### Complex Conditions\n\n```python\nage = 25\nhas_license = True\nhas_car = False\n\n# Can drive alone?\ncan_drive = age >= 18 and has_license and has_car\nprint(can_drive)    # False (missing car)\n\n# Can get to work?\ncan_commute = has_car or age >= 18    # Public transport if adult\nprint(can_commute)  # True (is adult)\n```\n\n### Order of Operations\n\n```\n1. Parentheses     ()\n2. Comparisons     == != < > <= >=\n3. not\n4. and\n5. or\n```\n\n```python\n# Use parentheses for clarity!\nresult = (age >= 18 and has_license) or is_emergency\n```\n\n---\n\n##  Hotel Examples\n\n### Check-In Eligibility\n\n```python\nhas_reservation = True\nhas_valid_id = True\nroom_ready = False\n\n# Can check in?\ncan_check_in = has_reservation and has_valid_id and room_ready\nprint(f\"Can check in: {can_check_in}\")    # False (room not ready)\n```\n\n### VIP Qualification\n\n```python\nstays_this_year = 12\ntotal_spend = 15000\n\n# VIP if 10+ stays OR $10,000+ spent\nis_vip = stays_this_year >= 10 or total_spend >= 10000\nprint(f\"VIP Status: {is_vip}\")    # True (both conditions met!)\n```\n\n### Discount Eligibility\n\n```python\nis_member = True\nis_senior = False\nis_student = True\nnights_booked = 5\n\n# Discount if (member AND 3+ nights) OR senior OR student\ngets_discount = (is_member and nights_booked >= 3) or is_senior or is_student\nprint(f\"Gets discount: {gets_discount}\")    # True\n```\n\n---\n\n##  Truthy and Falsy Values\n\n> In boolean context, Python treats some values as True and others as False.\n\n### Falsy Values (treated as False)\n\n```python\nbool(False)      # False\nbool(0)          # False (zero)\nbool(0.0)        # False\nbool(\"\")         # False (empty string)\nbool([])         # False (empty list)\nbool(None)       # False\n```\n\n### Truthy Values (treated as True)\n\n```python\nbool(True)       # True\nbool(1)          # True (non-zero)\nbool(-5)         # True (any non-zero number)\nbool(3.14)       # True\nbool(\"Hello\")    # True (non-empty string)\nbool([1,2,3])    # True (non-empty list)\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: = vs ==\n\n```python\nx = 5       # Assignment: x gets value 5\nx == 5      # Comparison: is x equal to 5? (returns True)\n\nif x = 5:   #  SyntaxError!\nif x == 5:  #  Correct comparison\n```\n\n### Mistake 2: Wrong Capitalization\n\n```python\nx = true    #  NameError\nx = True    #  Correct\n```\n\n### Mistake 3: Confusing and/or\n\n```python\n# \"at least one\"  use OR\n# \"all required\"  use AND\n\n# Wrong: \"discount if member OR senior\" but you wrote:\ndiscount = is_member and is_senior    #  Both needed!\n\n# Right:\ndiscount = is_member or is_senior     #  Either works\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Boolean values: `True` and `False` (capitalized!)\n> - Comparison operators: `==`, `!=`, `<`, `>`, `<=`, `>=`\n> - Logical operators: `and` (all), `or` (any), `not` (reverse)\n> - Falsy: `0`, `0.0`, `\"\"`, `[]`, `None`, `False`\n> - `=` is assignment, `==` is comparison"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 6.2: if Statements (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0006-000000000002',
  'd0000000-0000-0000-0000-000000000006',
  '6.2',
  2,
  'if Statements: Making Decisions',
  'if-statements',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# if Statements: Making Decisions\n\n##  Why This Matters\n\nEvery program needs to make decisions. Should we show the VIP lounge? Is the discount applicable? Can the guest check in early? **if statements are how programs choose different paths based on conditions.**\n\n---\n\n##  Basic if Statement\n\n```python\nif condition:\n    # Code to run if condition is True\n    # (must be indented)\n```\n\n### Simple Example\n\n```python\nage = 21\n\nif age >= 18:\n    print(\"You are an adult.\")\n    print(\"Welcome to the hotel bar.\")\n\nprint(\"Thank you for visiting.\")  # Always runs\n```\n\n**Output:**\n```\nYou are an adult.\nWelcome to the hotel bar.\nThank you for visiting.\n```\n\n---\n\n##  The Syntax Rules\n\n```python\nif condition:     # 1. if keyword\n                  # 2. condition (evaluates to True/False)\n                  # 3. colon (:) at the end\n    do_something  # 4. INDENTED code block (4 spaces)\n    do_more       # 5. All indented lines are in the block\n```\n\n### What Can Go Wrong\n\n```python\n#  Missing colon\nif age >= 18\n    print(\"Adult\")\n\n#  Missing indentation\nif age >= 18:\nprint(\"Adult\")\n\n#  Inconsistent indentation\nif age >= 18:\n    print(\"Adult\")\n  print(\"Welcome\")  # Wrong number of spaces!\n```\n\n---\n\n##  if-else: Two Paths\n\n```python\nif condition:\n    # Runs if True\nelse:\n    # Runs if False\n```\n\n### Example: VIP Check\n\n```python\nis_vip = False\n\nif is_vip:\n    print(\"Welcome to the VIP lounge!\")\n    print(\"Enjoy complimentary champagne.\")\nelse:\n    print(\"Welcome to our hotel.\")\n    print(\"VIP upgrades available at front desk.\")\n```\n\n**Output (since is_vip is False):**\n```\nWelcome to our hotel.\nVIP upgrades available at front desk.\n```\n\n---\n\n##  if-elif-else: Multiple Paths\n\n```python\nif condition1:\n    # Runs if condition1 is True\nelif condition2:\n    # Runs if condition1 is False BUT condition2 is True\nelif condition3:\n    # Runs if conditions 1 & 2 are False BUT condition3 is True\nelse:\n    # Runs if ALL conditions are False\n```\n\n### Example: Room Assignment\n\n```python\nbudget = 250\n\nif budget >= 500:\n    room = \"Presidential Suite\"\nelif budget >= 300:\n    room = \"Deluxe Room\"\nelif budget >= 150:\n    room = \"Standard Room\"\nelse:\n    room = \"Hostel Dorm\"\n\nprint(f\"Recommended: {room}\")\n```\n\n**Output:** `Recommended: Standard Room`\n\n---\n\n##  Hotel Examples\n\n### Loyalty Tier\n\n```python\npoints = 7500\n\nif points >= 10000:\n    tier = \"Platinum\"\n    discount = 0.20\nelif points >= 5000:\n    tier = \"Gold\"\n    discount = 0.15\nelif points >= 1000:\n    tier = \"Silver\"\n    discount = 0.10\nelse:\n    tier = \"Bronze\"\n    discount = 0.05\n\nprint(f\"Member Tier: {tier}\")\nprint(f\"Discount: {discount * 100:.0f}%\")\n```\n\n### Check-In Validation\n\n```python\nhas_reservation = True\nhas_id = True\nroom_ready = False\ncurrent_hour = 11  # 11 AM\n\nif not has_reservation:\n    print(\"No reservation found. Check walk-in availability.\")\nelif not has_id:\n    print(\"Valid ID required for check-in.\")\nelif not room_ready and current_hour < 15:\n    print(\"Room being prepared. Check-in available at 3 PM.\")\n    print(\"Luggage storage available.\")\nelse:\n    print(\"Welcome! Your room is ready.\")\n    print(\"Here are your key cards.\")\n```\n\n### Dynamic Pricing\n\n```python\nbase_rate = 200\noccupancy_percent = 85\nis_weekend = True\nis_holiday = False\n\nrate = base_rate\n\n# Apply modifiers\nif occupancy_percent >= 90:\n    rate = rate * 1.30    # 30% premium\nelif occupancy_percent >= 75:\n    rate = rate * 1.15    # 15% premium\n\nif is_weekend:\n    rate = rate * 1.10    # 10% weekend surcharge\n\nif is_holiday:\n    rate = rate * 1.25    # 25% holiday surcharge\n\nprint(f\"Tonight''s rate: ${rate:.2f}\")\n```\n\n---\n\n##  Nested if Statements\n\n```python\nis_member = True\nmembership_tier = \"Gold\"\n\nif is_member:\n    print(\"Welcome back, valued member!\")\n    \n    if membership_tier == \"Platinum\":\n        print(\"Your suite has been upgraded.\")\n    elif membership_tier == \"Gold\":\n        print(\"Enjoy 15% off at our spa.\")\n    else:\n        print(\"Thanks for your loyalty!\")\nelse:\n    print(\"Welcome! Ask about our membership program.\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Using = Instead of ==\n\n```python\nif status = \"VIP\":     #  SyntaxError! (assignment)\nif status == \"VIP\":    #  Correct (comparison)\n```\n\n### Mistake 2: Forgetting Colon\n\n```python\nif age >= 18          #  Missing colon!\nif age >= 18:         #  Correct\n```\n\n### Mistake 3: Wrong Indentation\n\n```python\nif True:\nprint(\"Hello\")        #  Must be indented!\n\nif True:\n    print(\"Hello\")    #  Correct (4 spaces)\n```\n\n### Mistake 4: Unreachable Code\n\n```python\nif score >= 90:\n    grade = \"A\"\nelif score >= 80:\n    grade = \"B\"\nelif score >= 70:\n    grade = \"C\"\nelse score >= 60:     #  else doesn''t take a condition!\n    grade = \"D\"       # This is unreachable\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - if statement syntax: `if condition:` (don''t forget the colon!)\n> - Indentation matters (4 spaces)\n> - elif = \"else if\" (multiple conditions)\n> - else = default when all conditions are False\n> - Only ONE path executes in if-elif-else chain"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 6.3: Conditional Coding Practice (Code)
-- ============================================
(
  'e0000000-0000-0000-0006-000000000003',
  'd0000000-0000-0000-0000-000000000006',
  '6.3',
  3,
  'Conditional Coding Practice',
  'conditional-practice',
  'code',
  12,
  40,
  'basic',
  '{
    "instructions": "Create a hotel discount calculator!\n\n**Rules:**\n1. Loyalty members get 15% off\n2. Seniors (65+) get 10% off\n3. Bookings of 5+ nights get 20% off\n4. Apply only the HIGHEST discount (not cumulative)\n\n**Given:**\n- base_price = 200\n- is_member = True\n- age = 45\n- nights = 7\n\n**Output format:**\nBase price: $200\nDiscount: 20% (reason)\nFinal price: $XXX.XX",
    "starterCode": "# Hotel Discount Calculator\n\n# Guest information\nbase_price = 200\nis_member = True\nage = 45\nnights = 7\n\n# Determine the highest applicable discount\ndiscount = 0\nreason = \"None\"\n\n# Check for 5+ night discount (20%)\n\n\n# Check for loyalty member discount (15%)\n\n\n# Check for senior discount (10%)\n\n\n# Calculate final price\n\n\n# Print results\nprint(f\"Base price: ${base_price}\")\n",
    "solution": "# Hotel Discount Calculator\n\n# Guest information\nbase_price = 200\nis_member = True\nage = 45\nnights = 7\n\n# Determine the highest applicable discount\ndiscount = 0\nreason = \"None\"\n\n# Check for 5+ night discount (20%) - highest priority\nif nights >= 5:\n    discount = 0.20\n    reason = \"Extended Stay (5+ nights)\"\n# Check for loyalty member discount (15%)\nelif is_member:\n    discount = 0.15\n    reason = \"Loyalty Member\"\n# Check for senior discount (10%)\nelif age >= 65:\n    discount = 0.10\n    reason = \"Senior Discount\"\n\n# Calculate final price\ndiscount_amount = base_price * discount\nfinal_price = base_price - discount_amount\n\n# Print results\nprint(f\"Base price: ${base_price}\")\nprint(f\"Discount: {discount * 100:.0f}% ({reason})\")\nprint(f\"Final price: ${final_price:.2f}\")",
    "testCases": [
      {"input": "", "expectedOutput": "20%", "description": "Should show 20% discount for 7 nights"},
      {"input": "", "expectedOutput": "$160.00", "description": "Final price should be $160.00"}
    ],
    "hints": [
      "Use if-elif-else to check conditions in order of discount size",
      "Start with the highest discount (20% for 5+ nights)",
      "discount_amount = base_price * discount",
      "final_price = base_price - discount_amount"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 6.4: Conditionals Quiz (12 questions)
-- ============================================
(
  'e0000000-0000-0000-0006-000000000004',
  'd0000000-0000-0000-0000-000000000006',
  '6.4',
  4,
  'Conditionals Quiz',
  'conditionals-quiz',
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
        "question": "What will this print?\n\nif True:\n    print(\"A\")\nelse:\n    print(\"B\")",
        "options": ["A", "B", "A and B", "Nothing"],
        "correct": 0,
        "explanation": "The condition is True, so only the if block runs. Output: A"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is the result of: True and False",
        "options": ["True", "False", "Error", "None"],
        "correct": 1,
        "explanation": "AND requires BOTH to be True. True and False = False."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is the result of: True or False",
        "options": ["True", "False", "Error", "None"],
        "correct": 0,
        "explanation": "OR requires at least ONE to be True. True or False = True."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which operator checks if two values are EQUAL?",
        "options": ["=", "==", "!=", "equals"],
        "correct": 1,
        "explanation": "== is the equality comparison operator. = is for assignment."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What will this print?\n\nx = 10\nif x > 15:\n    print(\"High\")\nelif x > 5:\n    print(\"Medium\")\nelse:\n    print(\"Low\")",
        "options": ["High", "Medium", "Low", "Medium and Low"],
        "correct": 1,
        "explanation": "x=10 is not > 15 (False), but IS > 5 (True), so \"Medium\" prints. Only one branch executes."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is: not (5 > 3)",
        "options": ["True", "False", "5", "Error"],
        "correct": 1,
        "explanation": "5 > 3 is True. not True = False."
      },
      {
        "id": "q7",
        "type": "true_false",
        "difficulty": "applied",
        "question": "In Python, bool(0) returns True.",
        "correct": false,
        "explanation": "FALSE. Zero is ''falsy''  bool(0) returns False."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\na = 5\nb = 10\nif a < b and b < 20:\n    print(\"Yes\")\nelse:\n    print(\"No\")",
        "options": ["Yes", "No", "Error", "Yes No"],
        "correct": 0,
        "explanation": "a < b (5 < 10) is True AND b < 20 (10 < 20) is True. True AND True = True  \"Yes\""
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What will this output?\n\nage = 20\nhas_id = False\n\nif age >= 18 and has_id:\n    print(\"Can enter\")\nelif age >= 18:\n    print(\"Need ID\")\nelse:\n    print(\"Too young\")",
        "options": ["Can enter", "Need ID", "Too young", "Error"],
        "correct": 1,
        "explanation": "age >= 18 is True BUT has_id is False. True AND False = False. Second condition (age >= 18) is True, so \"Need ID\""
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "How many lines will be printed?\n\nx = 5\nif x > 3:\n    print(\"A\")\nif x > 4:\n    print(\"B\")\nif x > 5:\n    print(\"C\")",
        "options": ["1", "2", "3", "0"],
        "correct": 1,
        "explanation": "These are THREE SEPARATE if statements (not if-elif). x=5: x>3? YesA. x>4? YesB. x>5? No. Output: A, B (2 lines)"
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is: (True or False) and (False or True)",
        "options": ["True", "False", "Error", "None"],
        "correct": 0,
        "explanation": "Step by step: (True or False)=True. (False or True)=True. True and True = True."
      },
      {
        "id": "q12",
        "type": "true_false",
        "difficulty": "exam",
        "question": "This code has an error:\n\nif score >= 90:\n    grade = \"A\"\nelse score >= 80:\n    grade = \"B\"",
        "correct": true,
        "explanation": "TRUE - there IS an error. ''else'' cannot have a condition. Should be ''elif score >= 80:''"
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
-- Activity 6.5: Complex Conditions Challenge (Code)
-- ============================================
(
  'e0000000-0000-0000-0006-000000000005',
  'd0000000-0000-0000-0000-000000000006',
  '6.5',
  5,
  'Challenge: Room Eligibility Checker',
  'room-eligibility-challenge',
  'code',
  15,
  50,
  'basic',
  '{
    "instructions": "Build a room eligibility checker for a luxury hotel!\n\n**Room Requirements:**\n\n1. **Standard Room**: Anyone can book\n2. **Deluxe Room**: Must be 21+ OR with adult guardian\n3. **Executive Suite**: Must be 25+ AND (have platinum status OR spend $500+/night)\n4. **Presidential Suite**: Must be 30+ AND platinum AND spend $1000+/night\n\n**Given guest info:**\n- age = 28\n- is_platinum = True\n- nightly_spend = 750\n- has_guardian = False\n\n**Print which rooms the guest is eligible for:**\nStandard Room: \nDeluxe Room:  or \nExecutive Suite:  or \nPresidential Suite:  or ",
    "starterCode": "# Room Eligibility Checker\n\n# Guest information\nage = 28\nis_platinum = True\nnightly_spend = 750\nhas_guardian = False\n\n# Check Standard Room (anyone)\nstandard_eligible = True\n\n# Check Deluxe Room (21+ OR has guardian)\n\n\n# Check Executive Suite (25+ AND (platinum OR $500+))\n\n\n# Check Presidential Suite (30+ AND platinum AND $1000+)\n\n\n# Print results\nprint(\"Room Eligibility:\")\nprint(f\"Standard Room: {'' if standard_eligible else ''}\")\n",
    "solution": "# Room Eligibility Checker\n\n# Guest information\nage = 28\nis_platinum = True\nnightly_spend = 750\nhas_guardian = False\n\n# Check Standard Room (anyone)\nstandard_eligible = True\n\n# Check Deluxe Room (21+ OR has guardian)\ndeluxe_eligible = age >= 21 or has_guardian\n\n# Check Executive Suite (25+ AND (platinum OR $500+))\nexecutive_eligible = age >= 25 and (is_platinum or nightly_spend >= 500)\n\n# Check Presidential Suite (30+ AND platinum AND $1000+)\npresidential_eligible = age >= 30 and is_platinum and nightly_spend >= 1000\n\n# Print results\nprint(\"Room Eligibility:\")\nprint(f\"Standard Room: {'''' if standard_eligible else ''''}\")\nprint(f\"Deluxe Room: {'''' if deluxe_eligible else ''''}\")\nprint(f\"Executive Suite: {'''' if executive_eligible else ''''}\")\nprint(f\"Presidential Suite: {'''' if presidential_eligible else ''''}\")",
    "testCases": [
      {"input": "", "expectedOutput": "Standard Room: ", "description": "Standard always eligible"},
      {"input": "", "expectedOutput": "Executive Suite: ", "description": "28, platinum, $750  eligible"},
      {"input": "", "expectedOutput": "Presidential Suite: ", "description": "Age 28 < 30, so not eligible"}
    ],
    "hints": [
      "For OR conditions: age >= 21 or has_guardian",
      "For complex AND/OR: age >= 25 and (is_platinum or spend >= 500)",
      "Use parentheses to group OR conditions before AND"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 6.6: Module 6 Checkpoint (10 questions)
-- ============================================
(
  'e0000000-0000-0000-0006-000000000006',
  'd0000000-0000-0000-0000-000000000006',
  '6.6',
  6,
  'Module 6 Checkpoint',
  'module-6-checkpoint',
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
        "question": "What are the two boolean values in Python?",
        "options": ["true and false", "True and False", "1 and 0", "yes and no"],
        "correct": 1,
        "explanation": "Python uses True and False (capitalized) as boolean values."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does the != operator check?",
        "options": ["Equal to", "Not equal to", "Less than", "Assignment"],
        "correct": 1,
        "explanation": "!= means ''not equal to''. It returns True if values are different."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is required at the end of an if statement line?",
        "options": ["Semicolon (;)", "Colon (:)", "Parentheses ()", "Nothing"],
        "correct": 1,
        "explanation": "A colon (:) is required after the condition in if, elif, and else statements."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\nif False:\n    print(\"A\")\nelif True:\n    print(\"B\")\nelse:\n    print(\"C\")",
        "options": ["A", "B", "C", "B and C"],
        "correct": 1,
        "explanation": "First condition (False) fails, second condition (True) succeeds  prints \"B\". Only one branch runs."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is: False or (True and True)",
        "options": ["True", "False", "Error", "None"],
        "correct": 0,
        "explanation": "Step by step: True and True = True. False or True = True."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which values are considered ''falsy'' in Python?",
        "options": ["0, \"\", [], None, False", "Only False", "0 and False only", "None only"],
        "correct": 0,
        "explanation": "Falsy values include: 0, 0.0, empty string \"\", empty list [], None, and False."
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What will print?\n\nx = 7\nif x > 10:\n    print(\"High\")\nif x > 5:\n    print(\"Medium\")\nif x > 0:\n    print(\"Low\")",
        "options": ["High", "Medium", "Low", "Medium and Low"],
        "correct": 3,
        "explanation": "These are SEPARATE if statements, not if-elif-else. x=7: not >10, IS >5 (Medium), IS >0 (Low). Both print!"
      },
      {
        "id": "cp8",
        "type": "true_false",
        "difficulty": "exam",
        "question": "In if-elif-else, multiple branches can execute if multiple conditions are True.",
        "correct": false,
        "explanation": "FALSE. In if-elif-else, only ONE branch executes  the first one whose condition is True."
      },
      {
        "id": "cp9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A guest gets a discount if they are: (VIP AND stayed 5+ nights) OR (senior AND booked directly). Which code is correct?",
        "options": [
          "is_vip and nights >= 5 or is_senior and booked_directly",
          "(is_vip and nights >= 5) or (is_senior and booked_directly)",
          "is_vip or nights >= 5 and is_senior or booked_directly",
          "Both A and B are correct"
        ],
        "correct": 3,
        "explanation": "Both A and B work! ''and'' has higher precedence than ''or'', so they''re evaluated the same way. But B is clearer."
      },
      {
        "id": "cp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nstatus = \"VIP\"\nnights = 3\n\nif status == \"VIP\":\n    if nights >= 5:\n        print(\"Gold discount\")\n    else:\n        print(\"Silver discount\")\nelse:\n    print(\"Standard rate\")",
        "options": ["Gold discount", "Silver discount", "Standard rate", "Error"],
        "correct": 1,
        "explanation": "status is ''VIP'' (True), nights is 3 (not >= 5, False). Outer if runs, inner else runs  ''Silver discount''"
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
