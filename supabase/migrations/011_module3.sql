-- ============================================
-- Module 3: Algorithms, Flowcharts & Pseudocode
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 3.1: What is an Algorithm? (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0003-000000000001',
  'd0000000-0000-0000-0000-000000000003',
  '3.1',
  1,
  'What is an Algorithm?',
  'what-is-algorithm',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# What is an Algorithm?\n\n##  Why This Matters\n\nEvery time you follow a recipe, give directions, or explain a process to someone, you''re using an algorithm. In programming, algorithms are the heart of every application  they tell the computer exactly what to do. **Mastering algorithm design is what separates okay programmers from great ones.**\n\n---\n\n##  The Definition\n\n> **Algorithm** = A step-by-step procedure or set of instructions designed to perform a specific task or solve a particular problem.\n\n### Key Characteristics\n\n1. **Finite**  Must eventually end\n2. **Well-defined**  Each step is clear and unambiguous\n3. **Ordered**  Steps must be in the correct sequence\n4. **Effective**  Each step must be doable\n\n---\n\n##  The Recipe Analogy\n\nA recipe is a perfect example of an algorithm:\n\n```\n\n          PANCAKE ALGORITHM              \n\n INPUTS:                                 \n   - 2 cups flour                        \n   - 2 eggs                              \n   - 1 cup milk                          \n   - Butter for pan                      \n\n STEPS:                                  \n   1. Mix flour, eggs, and milk          \n   2. Heat pan with butter               \n   3. Pour batter (1/4 cup per pancake)  \n   4. Wait until bubbles form            \n   5. Flip pancake                       \n   6. Cook 2 more minutes                \n   7. Repeat steps 3-6 until batter gone \n\n OUTPUT:                                 \n   - 8 delicious pancakes!               \n\n```\n\n---\n\n##  Algorithms in Hospitality\n\n### Example 1: Guest Check-In Algorithm\n\n```\n1. START\n2. Greet the guest warmly\n3. Ask for reservation name or confirmation number\n4. Search reservation in system\n5. IF reservation found:\n     a. Verify guest ID\n     b. Confirm room type and dates\n     c. Process payment or pre-authorization\n     d. Assign room number\n     e. Program key cards\n     f. Explain hotel amenities\n     g. Offer luggage assistance\n   ELSE:\n     a. Check for walk-in availability\n     b. IF rooms available:\n          - Create new reservation\n          - Continue with check-in\n        ELSE:\n          - Apologize\n          - Suggest nearby hotels\n6. Wish guest a pleasant stay\n7. END\n```\n\n### Example 2: Room Service Algorithm\n\n```\n1. START\n2. Receive order call\n3. Verify room number and guest name\n4. Record order details\n5. Transmit to kitchen\n6. Kitchen prepares order\n7. WHILE order not ready:\n     - Wait\n8. Prepare tray with utensils\n9. Deliver to room\n10. Knock and announce \"Room Service\"\n11. IF guest answers:\n      - Present food and bill\n      - Get signature\n    ELSE:\n      - Wait 2 minutes, knock again\n      - IF still no answer, call room\n12. Return to station\n13. END\n```\n\n---\n\n##  Three Building Blocks of Algorithms\n\nEvery algorithm consists of three fundamental components:\n\n### 1. Sequence (Step-by-Step)\n**Do this, then this, then this.**\n\n```\nStep 1: Wake up\nStep 2: Shower\nStep 3: Get dressed\nStep 4: Eat breakfast\n```\n\n### 2. Selection (Decisions)\n**IF something is true, do this; ELSE do that.**\n\n```\nIF it''s raining:\n    Take an umbrella\nELSE:\n    Leave umbrella at home\n```\n\n### 3. Iteration (Loops)\n**REPEAT this until a condition is met.**\n\n```\nWHILE dishes remain:\n    Wash a dish\n    Dry the dish\n    Put it away\n```\n\n---\n\n##  Worked Example: ATM Withdrawal\n\n**Problem:** Design an algorithm for ATM cash withdrawal.\n\n**Algorithm:**\n\n```\n1. START\n2. INSERT card\n3. PROMPT for PIN\n4. IF PIN incorrect:\n     a. INCREMENT attempts counter\n     b. IF attempts >= 3:\n          - Retain card\n          - Display \"Card retained\" message\n          - END\n        ELSE:\n          - GO TO step 3\n5. DISPLAY menu options\n6. SELECT \"Withdraw Cash\"\n7. PROMPT for amount\n8. IF amount > balance:\n     a. DISPLAY \"Insufficient funds\"\n     b. GO TO step 7\n9. IF amount > daily limit:\n     a. DISPLAY \"Exceeds daily limit\"\n     b. GO TO step 7\n10. DISPENSE cash\n11. UPDATE balance\n12. PRINT receipt\n13. RETURN card\n14. END\n```\n\n---\n\n##  Common Mistakes\n\n###  Mistake 1: Vague Steps\n**Bad:** \"Make the guest happy\"\n**Good:** \"Greet guest by name, offer welcome drink, escort to room\"\n\n###  Mistake 2: Missing Edge Cases\n**Bad:** Algorithm only handles successful scenarios\n**Good:** Include what happens when things go wrong\n\n###  Mistake 3: Infinite Loops\n**Bad:** `WHILE true: do something` (never ends!)\n**Good:** `WHILE items remain: process item` (will eventually end)\n\n###  Mistake 4: Wrong Order\n**Bad:** Flip pancake  Pour batter\n**Good:** Pour batter  Wait for bubbles  Flip pancake\n\n---\n\n##  Pro Tips\n\n1. **Start with the happy path**  Design for success first, then add error handling\n\n2. **Test with examples**  Walk through your algorithm with specific inputs\n\n3. **Ask \"What if...?\"**  Consider edge cases (empty input, maximum values, errors)\n\n4. **Keep steps atomic**  Each step should do ONE thing\n\n5. **Name steps clearly**  Future you (or someone else) needs to understand\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Algorithm = Step-by-step instructions to solve a problem\n> - Three building blocks: Sequence, Selection (IF), Iteration (loops)\n> - Good algorithms are finite, clear, ordered, and effective\n> - Always consider edge cases and error handling\n\n**Memory Hook:** Algorithms are like **GPS directions**  they tell you exactly where to go, when to turn, and what to do if you miss a turn!"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 3.2: Flowcharts Explained (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0003-000000000002',
  'd0000000-0000-0000-0000-000000000003',
  '3.2',
  2,
  'Flowcharts: Visualizing Algorithms',
  'flowcharts-explained',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Flowcharts: Visualizing Algorithms\n\n##  Why This Matters\n\nImagine trying to explain a complex process using only words. Confusing, right? **Flowcharts turn abstract algorithms into visual maps** that anyone can follow. They''re used everywhere: software development, business processes, emergency procedures, and more.\n\n---\n\n##  What is a Flowchart?\n\n> **Flowchart** = A diagram that represents a process, showing steps as boxes of various types connected by arrows.\n\n### Why Use Flowcharts?\n\n1. **Visual clarity**  See the whole process at a glance\n2. **Communication**  Share logic with non-technical people\n3. **Bug finding**  Spot logical errors before coding\n4. **Documentation**  Create permanent process records\n\n---\n\n##  Standard Flowchart Shapes\n\n```\n\n                  FLOWCHART SHAPE GUIDE                      \n\n                                                             \n                                                  \n    START /    OVAL (Terminator)                          \n      END      Shows beginning or end of process          \n                                                  \n                                                             \n                                                  \n    Process    RECTANGLE (Process)                        \n               An action or operation                     \n                                                  \n                                                             \n                                                           \n                                                           \n  ??         DIAMOND (Decision)                            \n             A yes/no question or condition               \n             Has 2+ exits (Yes/No or multiple options)    \n                                                           \n                                                             \n                                                  \n     INPUT     PARALLELOGRAM (Input/Output)               \n               Data entering or leaving the system        \n                                                  \n                                                             \n                                                            \n                ARROWS (Flow Lines)                         \n                Show direction of process flow              \n                                                             \n                CONNECTOR                                   \n                 Links parts of flowchart (on different     \n                 pages or to avoid crossing lines)          \n\n```\n\n---\n\n##  Worked Example 1: Hotel Room Assignment\n\n```\n            \n              START  \n            \n                 \n                 \n        \n        Guest''s room    \n        preference?     \n        \n                 \n         \n                      \n                      \n       \n    High        Low      \n    Floor       Floor    \n       \n                      \n                      \n                    \n                     \n      High        Low \n      avail       avail\n                     \n                    \n      YesNo        YesNo\n                       \n                       \n   \n   AssignWaitAssignWait\n   high  listlow   list\n   \n                        \n      \n                 \n                 \n        \n             END       \n        \n```\n\n---\n\n##  Worked Example 2: Restaurant Reservation\n\n```\n              \n                 START   \n              \n                    \n                    \n           \n           Party size and  \n           date requested  \n           \n                    \n                    \n               \n               Table    \n               available?\n               \n              YES      NO\n             \n                             \n          \n     Book            Offer        \n     table           alternative  \n           times        \n                     \n                             \n                             \n                        \n                        Guest    \n                        accepts? \n                        \n                       YES    NO\n                      \n                                    \n                   \n              Book           Add to   \n              alt time       waitlist \n                   \n                                   \n         \n                          \n                          \n               \n                 Send         \n                 confirmation \n               \n                       \n                       \n               \n                     END      \n               \n```\n\n---\n\n##  Common Mistakes\n\n###  Mistake 1: Missing Start/End\nEvery flowchart MUST have exactly one START and at least one END.\n\n###  Mistake 2: Decision Without Both Paths\nEvery diamond MUST have at least 2 exit paths (Yes/No or options).\n\n###  Mistake 3: Dead Ends\nEvery path must eventually lead to END. No floating boxes!\n\n###  Mistake 4: Unclear Flow Direction\nArrows should clearly show the flow. Avoid confusing crossings.\n\n###  Mistake 5: Too Complex\nIf your flowchart needs a magnifying glass, break it into sub-processes.\n\n---\n\n##  Pro Tips\n\n1. **Sketch first**  Draw rough flowcharts before making them pretty\n\n2. **Top to bottom**  Main flow should go downward\n\n3. **Left to right for branches**  Keeps things organized\n\n4. **Label decision exits**  \"Yes/No\" or \"True/False\" on arrows\n\n5. **Use connectors for complex charts**  Avoid arrow spaghetti\n\n6. **Test your flowchart**  Walk through with sample scenarios\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Oval = Start/End | Rectangle = Process | Diamond = Decision | Parallelogram = Input/Output\n> - Every decision must have multiple exit paths\n> - All paths must lead to END\n> - Flowcharts visualize algorithms before coding\n\n**Memory Hook:** Flowcharts are like **road maps for logic**  shapes are landmarks, arrows are roads!"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 3.3: Flowchart Builder (Interactive)
-- ============================================
(
  'e0000000-0000-0000-0003-000000000003',
  'd0000000-0000-0000-0000-000000000003',
  '3.3',
  3,
  'Flowchart Builder Exercise',
  'flowchart-builder',
  'interactive',
  15,
  45,
  'basic',
  '{
    "instructions": "Build a flowchart for the following scenario:\n\nA hotel needs a process for handling late checkout requests.\n\n**Requirements:**\n1. Guest requests late checkout\n2. Check if the room is needed for another guest that day\n3. If room is available: grant late checkout (free if loyalty member, $50 fee otherwise)\n4. If room is not available: deny request but offer luggage storage\n5. Update the reservation system\n\nDrag and drop the shapes to build your flowchart.",
    "type": "flowchart-builder",
    "availableShapes": ["start", "end", "process", "decision", "input-output"],
    "expectedElements": [
      {"type": "start", "label": "Start"},
      {"type": "input-output", "label": "Guest requests late checkout"},
      {"type": "decision", "label": "Room needed today?"},
      {"type": "decision", "label": "Loyalty member?"},
      {"type": "process", "label": "Grant free late checkout"},
      {"type": "process", "label": "Grant late checkout with $50 fee"},
      {"type": "process", "label": "Deny request, offer luggage storage"},
      {"type": "process", "label": "Update reservation system"},
      {"type": "end", "label": "End"}
    ],
    "hints": [
      "Start with the guest request as an input",
      "The first decision should check room availability",
      "If room is available, then check loyalty status",
      "All paths should update the system before ending"
    ]
  }'::jsonb,
  'flowchart-builder',
  false,
  true
),

-- ============================================
-- Activity 3.4: Pseudocode Explained (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0003-000000000004',
  'd0000000-0000-0000-0000-000000000003',
  '3.4',
  4,
  'Pseudocode: Planning Before Coding',
  'pseudocode-explained',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Pseudocode: Planning Before Coding\n\n##  Why This Matters\n\nJumping straight into code is like building a house without blueprints. **Pseudocode is your blueprint**  it lets you plan your logic in plain language before wrestling with syntax. Professional developers use pseudocode to avoid costly mistakes.\n\n---\n\n##  What is Pseudocode?\n\n> **Pseudocode** = An informal, high-level description of an algorithm using structured natural language.\n\n### Key Characteristics\n\n- **Not actual code**  Won''t run on any computer\n- **Language-agnostic**  Not tied to Python, Java, etc.\n- **Readable**  Anyone can understand it\n- **Structured**  Uses consistent patterns for logic\n\n---\n\n##  Pseudocode Conventions\n\n### Basic Structure\n\n```\nALGORITHM Name\n    INPUT: What data comes in\n    OUTPUT: What result comes out\n    \n    Step 1\n    Step 2\n    ...\nEND ALGORITHM\n```\n\n### Common Keywords\n\n| Keyword | Meaning | Example |\n|---------|---------|----------|\n| **SET** / **** | Assign value | `SET total  0` |\n| **INPUT** | Get user data | `INPUT guest_name` |\n| **OUTPUT** / **PRINT** | Display result | `OUTPUT \"Welcome!\"` |\n| **IF...THEN...ELSE** | Decision | `IF age >= 18 THEN...` |\n| **WHILE** | Loop with condition | `WHILE items > 0` |\n| **FOR** | Counting loop | `FOR i = 1 TO 10` |\n| **END** | End a block | `END IF`, `END WHILE` |\n\n---\n\n##  Worked Example 1: Calculate Hotel Bill\n\n**Problem:** Calculate total bill including room, F&B, and tax.\n\n```\nALGORITHM CalculateHotelBill\n    INPUT: room_rate, nights, food_total, tax_rate\n    OUTPUT: final_bill\n    \n    SET room_charge  room_rate  nights\n    SET subtotal  room_charge + food_total\n    SET tax  subtotal  tax_rate\n    SET final_bill  subtotal + tax\n    \n    OUTPUT \"Room charges: \" + room_charge\n    OUTPUT \"F&B charges: \" + food_total\n    OUTPUT \"Tax: \" + tax\n    OUTPUT \"Total: \" + final_bill\n    \n    RETURN final_bill\nEND ALGORITHM\n```\n\n---\n\n##  Worked Example 2: Check Room Availability\n\n**Problem:** Check if a room is available for given dates.\n\n```\nALGORITHM CheckAvailability\n    INPUT: room_type, check_in, check_out\n    OUTPUT: is_available (True/False), available_rooms list\n    \n    SET available_rooms  empty list\n    \n    FOR EACH room IN hotel_rooms\n        IF room.type = room_type THEN\n            SET is_free  True\n            \n            FOR EACH booking IN room.bookings\n                IF dates_overlap(booking, check_in, check_out) THEN\n                    SET is_free  False\n                    BREAK\n                END IF\n            END FOR\n            \n            IF is_free = True THEN\n                ADD room TO available_rooms\n            END IF\n        END IF\n    END FOR\n    \n    IF LENGTH(available_rooms) > 0 THEN\n        OUTPUT \"Found \" + LENGTH(available_rooms) + \" rooms\"\n        SET is_available  True\n    ELSE\n        OUTPUT \"No rooms available\"\n        SET is_available  False\n    END IF\n    \n    RETURN is_available, available_rooms\nEND ALGORITHM\n```\n\n---\n\n##  Worked Example 3: VIP Guest Check-In\n\n```\nALGORITHM VIPCheckIn\n    INPUT: guest_name, reservation_number\n    OUTPUT: room_key, welcome_package\n    \n    SET guest  LOOKUP(reservation_number)\n    \n    IF guest IS NULL THEN\n        OUTPUT \"Reservation not found\"\n        RETURN NULL\n    END IF\n    \n    IF guest.vip_status = True THEN\n        SET room  AssignBestAvailable(\"suite\")\n        SET welcome_package  PrepareVIPPackage()\n        CALL NotifyManager(guest_name)\n    ELSE\n        SET room  AssignBestAvailable(guest.room_type)\n        SET welcome_package  PrepareStandardPackage()\n    END IF\n    \n    SET room_key  GenerateKey(room)\n    \n    OUTPUT \"Welcome, \" + guest_name\n    OUTPUT \"Your room: \" + room.number\n    \n    RETURN room_key, welcome_package\nEND ALGORITHM\n```\n\n---\n\n##  From Pseudocode to Python\n\n### Pseudocode:\n```\nALGORITHM CalculateDiscount\n    INPUT: price, is_member\n    OUTPUT: final_price\n    \n    IF is_member = True THEN\n        SET discount  price  0.15\n    ELSE\n        SET discount  0\n    END IF\n    \n    SET final_price  price - discount\n    RETURN final_price\nEND ALGORITHM\n```\n\n### Python:\n```python\ndef calculate_discount(price, is_member):\n    if is_member:\n        discount = price * 0.15\n    else:\n        discount = 0\n    \n    final_price = price - discount\n    return final_price\n```\n\n---\n\n##  Common Mistakes\n\n###  Mistake 1: Too Detailed\n**Bad:** `MOVE cursor right 5 pixels, click mouse button 1`\n**Good:** `CLICK on submit button`\n\n###  Mistake 2: Too Vague\n**Bad:** `Process the data somehow`\n**Good:** `CALCULATE average of all values in list`\n\n###  Mistake 3: Using Language-Specific Syntax\n**Bad:** `print(f\"Hello {name}\")`\n**Good:** `OUTPUT \"Hello \" + name`\n\n---\n\n##  Pro Tips\n\n1. **Write for humans**  Your colleague should understand it instantly\n\n2. **Use consistent formatting**  Pick a style and stick to it\n\n3. **Indent blocks**  Show structure visually\n\n4. **Comment complex logic**  Add notes where needed\n\n5. **Test on paper**  Walk through with sample data\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Pseudocode = Plain-language algorithm description\n> - Uses keywords: SET, INPUT, OUTPUT, IF, WHILE, FOR\n> - Language-independent  not Python, Java, etc.\n> - Bridge between flowcharts and actual code"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 3.5: Algorithm Quiz (15 questions)
-- ============================================
(
  'e0000000-0000-0000-0003-000000000005',
  'd0000000-0000-0000-0000-000000000003',
  '3.5',
  5,
  'Algorithms & Flowcharts Quiz',
  'algorithms-flowcharts-quiz',
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
        "question": "What are the THREE building blocks of algorithms?",
        "options": [
          "Input, Output, Process",
          "Sequence, Selection, Iteration",
          "Start, Middle, End",
          "Variables, Functions, Classes"
        ],
        "correct": 1,
        "explanation": "The three building blocks are SEQUENCE (step-by-step), SELECTION (if/else decisions), and ITERATION (loops)."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "In a flowchart, what shape represents a DECISION?",
        "options": ["Rectangle", "Oval", "Diamond", "Parallelogram"],
        "correct": 2,
        "explanation": "A DIAMOND shape represents a decision point (yes/no question) in a flowchart."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does a RECTANGLE represent in a flowchart?",
        "options": ["Start/End", "Decision", "Process/Action", "Input/Output"],
        "correct": 2,
        "explanation": "A RECTANGLE represents a PROCESS or ACTION step in a flowchart."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Pseudocode can be run directly on a computer.",
        "correct": false,
        "explanation": "FALSE. Pseudocode is for human planning only. It must be translated into actual programming code to run."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which pseudocode correctly represents: ''If the guest is a VIP, give a 20% discount''?",
        "options": [
          "IF guest = VIP: discount 20%",
          "IF guest.is_vip = True THEN SET discount  0.20 END IF",
          "WHEN VIP DISCOUNT 20",
          "guest.vip  discount(20)"
        ],
        "correct": 1,
        "explanation": "Option B uses proper pseudocode structure: IF condition THEN action END IF"
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A flowchart diamond has only ONE exit arrow. What is wrong?",
        "options": [
          "Nothing - this is correct",
          "Diamonds must have at least 2 exits (Yes/No)",
          "Diamonds should have 4 exits",
          "Diamonds don''t need exit arrows"
        ],
        "correct": 1,
        "explanation": "Decision diamonds MUST have at least 2 exits (e.g., Yes and No) to represent different paths."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does WHILE in pseudocode represent?",
        "options": [
          "A one-time decision",
          "A loop that repeats while a condition is true",
          "The end of an algorithm",
          "A variable assignment"
        ],
        "correct": 1,
        "explanation": "WHILE creates a loop that continues repeating while a specified condition remains true."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "applied",
        "question": "In a flowchart, what shape shows where the process STARTS and ENDS?",
        "options": ["Rectangle", "Diamond", "Oval/Rounded rectangle", "Arrow"],
        "correct": 2,
        "explanation": "OVAL (or rounded rectangle) shapes indicate the START and END of a flowchart."
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Examine this pseudocode:\n\nSET count  0\nWHILE count < 5\n    OUTPUT count\n    SET count  count + 1\nEND WHILE\n\nWhat will be output?",
        "options": [
          "1, 2, 3, 4, 5",
          "0, 1, 2, 3, 4",
          "0, 1, 2, 3, 4, 5",
          "Nothing - infinite loop"
        ],
        "correct": 1,
        "explanation": "The loop starts at 0, outputs each value, then increments. It stops when count = 5, so outputs are: 0, 1, 2, 3, 4"
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel check-in algorithm is missing error handling. What is the MOST important case to add?",
        "options": [
          "Guest requests extra pillows",
          "Reservation not found in system",
          "Guest is a loyalty member",
          "Guest prefers high floor"
        ],
        "correct": 1,
        "explanation": "''Reservation not found'' is a CRITICAL error case. The algorithm must handle this scenario to avoid crashes or confusion."
      },
      {
        "id": "q11",
        "type": "true_false",
        "difficulty": "exam",
        "question": "An algorithm that never ends (infinite loop) is valid as long as each step is clearly defined.",
        "correct": false,
        "explanation": "FALSE. Algorithms must be FINITE - they must eventually terminate. An infinite loop is a design error."
      },
      {
        "id": "q12",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which flowchart error would cause the biggest problem?",
        "options": [
          "Using a circle instead of oval for Start",
          "Having a path that never reaches End",
          "Using blue instead of black lines",
          "Having too few decision diamonds"
        ],
        "correct": 1,
        "explanation": "A path that never reaches END is a DEAD END - a logical error that means the process can get stuck."
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
-- Activity 3.6: Common Algorithm Types
-- ============================================
(
  'e0000000-0000-0000-0003-000000000006',
  'd0000000-0000-0000-0000-000000000003',
  '3.6',
  6,
  'Common Algorithm Types',
  'common-algorithm-types',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Common Algorithm Types\n\n##  Why This Matters\n\nYou don''t need to reinvent the wheel! Many problems have well-known algorithm types that solve them efficiently. Learning these patterns saves time and improves your solutions.\n\n---\n\n##  Search Algorithms\n\n### Linear Search\n**Check each item one by one until you find what you''re looking for.**\n\n```\n\n     Looking for \"SMITH\" in guest list     \n                                           \n   [JONES] [LEE] [PATEL] [SMITH] [WILSON] \n                                       \n     Not    Not    Not    FOUND!           \n     it     it     it                      \n                                           \n   Checked 4 items to find SMITH           \n\n```\n\n**Best for:** Small lists, unsorted data\n\n### Binary Search\n**For SORTED data: Start in middle, eliminate half each time.**\n\n```\n\n     Looking for \"PATEL\" in sorted list    \n                                           \n   [JONES] [LEE] [PATEL] [SMITH] [WILSON] \n                                          \n               Start middle                \n               LEE < PATEL                 \n               Search RIGHT half           \n                                           \n   [PATEL] [SMITH] [WILSON]               \n                                          \n    FOUND in 2 steps!                     \n\n```\n\n**Best for:** Large sorted lists (much faster than linear!)\n\n---\n\n##  Optimization Algorithms\n\n### Brute Force\n**Try ALL possible solutions, pick the best one.**\n\n**Example:** Finding the cheapest combination of flights\n- Try every route combination\n- Calculate cost of each\n- Return the cheapest\n\n**Pros:** Always finds the best answer\n**Cons:** Very slow for large problems\n\n### Greedy Algorithm\n**At each step, make the locally optimal choice.**\n\n**Example:** Making change with fewest coins\n```\nGive change for $0.67:\n  - Use 2 quarters ($0.50)  biggest that fits\n  - Use 1 dime ($0.10)  biggest that fits\n  - Use 1 nickel ($0.05)  biggest that fits\n  - Use 2 pennies ($0.02)  biggest that fits\n  Total: 6 coins\n```\n\n**Pros:** Fast!\n**Cons:** Might not find the best global solution\n\n---\n\n##  Hospitality Examples\n\n### Room Assignment (Greedy)\n```\nFOR EACH reservation (in check-in order):\n    Assign FIRST available matching room\n    Mark room as occupied\nEND FOR\n```\n\n### Optimal Staffing (Brute Force)\n```\nFOR EACH possible staff schedule combination:\n    Calculate coverage score\n    Calculate total labor cost\n    IF (coverage  required AND cost < best_cost):\n        UPDATE best_schedule\nEND FOR\n```\n\n### Guest Lookup (Binary Search)\n```\nALGORITHM FindGuest(sorted_guest_list, target_name)\n    SET low  0\n    SET high  LENGTH(list) - 1\n    \n    WHILE low  high:\n        SET mid  (low + high) / 2\n        IF list[mid] = target_name THEN\n            RETURN mid\n        ELSE IF list[mid] < target_name THEN\n            SET low  mid + 1\n        ELSE\n            SET high  mid - 1\n        END IF\n    END WHILE\n    \n    RETURN \"Not found\"\nEND ALGORITHM\n```\n\n---\n\n##  Summary\n\n| Algorithm | When to Use | Speed |\n|-----------|-------------|-------|\n| **Linear Search** | Small/unsorted data | Slow |\n| **Binary Search** | Large sorted data | Fast |\n| **Brute Force** | Need best answer, small data | Very slow |\n| **Greedy** | Need quick good-enough answer | Fast |"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 3.7: Module 3 Checkpoint (10 questions)
-- ============================================
(
  'e0000000-0000-0000-0003-000000000007',
  'd0000000-0000-0000-0000-000000000003',
  '3.7',
  7,
  'Module 3 Checkpoint',
  'module-3-checkpoint',
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
        "question": "An algorithm must be:",
        "options": [
          "Written in Python",
          "Finite, well-defined, ordered, and effective",
          "Faster than any other solution",
          "At least 100 lines long"
        ],
        "correct": 1,
        "explanation": "Algorithms must be FINITE (end eventually), WELL-DEFINED (clear steps), ORDERED (correct sequence), and EFFECTIVE (each step doable)."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "In a flowchart, what does a parallelogram represent?",
        "options": ["Start/End", "Decision", "Process", "Input/Output"],
        "correct": 3,
        "explanation": "A PARALLELOGRAM represents INPUT (data coming in) or OUTPUT (data going out)."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Pseudocode is:",
        "options": [
          "A programming language like Python",
          "An informal algorithm description in structured natural language",
          "A type of flowchart",
          "Only used by expert programmers"
        ],
        "correct": 1,
        "explanation": "Pseudocode is an INFORMAL, STRUCTURED description of an algorithm using natural language, not a programming language."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Every path in a flowchart must eventually reach an END symbol.",
        "correct": true,
        "explanation": "TRUE. Dead ends (paths that don''t reach END) are errors  they mean the process can get stuck."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What will this pseudocode output?\n\nSET x  5\nIF x > 3 THEN\n    OUTPUT \"Big\"\nELSE\n    OUTPUT \"Small\"\nEND IF",
        "options": ["Big", "Small", "5", "Nothing"],
        "correct": 0,
        "explanation": "Since x (5) is greater than 3, the condition is TRUE, so \"Big\" is output."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which algorithm type tries ALL possible solutions?",
        "options": ["Linear Search", "Binary Search", "Greedy", "Brute Force"],
        "correct": 3,
        "explanation": "BRUTE FORCE tries every possible solution to find the optimal one (but can be slow)."
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "To search a SORTED list of 1000 hotel guests, which is fastest?",
        "options": ["Linear Search", "Binary Search", "Random Search", "No difference"],
        "correct": 1,
        "explanation": "BINARY SEARCH is much faster for sorted data  it eliminates half the remaining items each step."
      },
      {
        "id": "cp8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "This pseudocode has an error:\n\nSET count  1\nWHILE count > 0\n    OUTPUT count\n    SET count  count + 1\nEND WHILE\n\nWhat is the error?",
        "options": [
          "Wrong variable name",
          "Infinite loop  count always stays > 0",
          "Missing OUTPUT statement",
          "There is no error"
        ],
        "correct": 1,
        "explanation": "This is an INFINITE LOOP. Count starts at 1 and keeps increasing, so count > 0 is ALWAYS true."
      },
      {
        "id": "cp9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel booking algorithm handles: successful bookings, no availability, and invalid dates. What case is MISSING?",
        "options": [
          "Guest preference",
          "Payment failure",
          "Room type selection",
          "Check-in time"
        ],
        "correct": 1,
        "explanation": "PAYMENT FAILURE is a critical error case. If payment fails, the booking shouldn''t complete."
      },
      {
        "id": "cp10",
        "type": "true_false",
        "difficulty": "exam",
        "question": "A greedy algorithm always finds the best possible solution to a problem.",
        "correct": false,
        "explanation": "FALSE. Greedy algorithms find LOCALLY optimal solutions at each step, but may miss the GLOBAL optimum."
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
