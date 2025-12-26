-- ============================================
-- Modules 13-15 and Mock Final Exam
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- ============================================

-- ============================================
-- MODULE 13: Python Libraries
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

(
  'e0000000-0000-0000-0013-000000000001',
  'd0000000-0000-0000-0000-000000000013',
  '13.1',
  1,
  'Introduction to Libraries',
  'intro-to-libraries',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Introduction to Python Libraries\n\n##  Why This Matters\n\nDon''t reinvent the wheel! **Libraries are pre-written code that extend Python''s capabilities**. Need to work with dates? Import datetime. Need random numbers? Import random. Need data analysis? Import pandas.\n\n---\n\n##  What is a Library?\n\n> A **library** (or module) is a collection of pre-written code you can use in your programs.\n\n```python\n# Import entire library\nimport math\nprint(math.sqrt(16))    # 4.0\n\n# Import specific functions\nfrom math import sqrt, pi\nprint(sqrt(16))         # 4.0\nprint(pi)               # 3.14159...\n\n# Import with alias\nimport datetime as dt\ntoday = dt.date.today()\n```\n\n---\n\n##  Essential Built-in Libraries\n\n### math - Mathematical Functions\n\n```python\nimport math\n\nmath.sqrt(25)      # 5.0 (square root)\nmath.ceil(4.2)     # 5 (round up)\nmath.floor(4.8)    # 4 (round down)\nmath.pow(2, 3)     # 8.0 (2^3)\nmath.pi            # 3.14159...\n```\n\n### random - Random Numbers\n\n```python\nimport random\n\nrandom.random()              # 0.0 to 1.0\nrandom.randint(1, 100)       # Random int 1-100\nrandom.choice([\"a\", \"b\"])    # Random from list\nrandom.shuffle(my_list)      # Shuffle in place\n```\n\n### datetime - Dates and Times\n\n```python\nfrom datetime import date, datetime, timedelta\n\ntoday = date.today()         # 2024-03-15\nnow = datetime.now()         # With time\nfuture = today + timedelta(days=7)\n```\n\n---\n\n##  Hotel Examples\n\n### Random Room Assignment\n\n```python\nimport random\n\navailable = [101, 102, 103, 201, 202, 203]\nassigned = random.choice(available)\nprint(f\"Assigned room: {assigned}\")\n```\n\n### Check-out Date Calculator\n\n```python\nfrom datetime import date, timedelta\n\ncheck_in = date.today()\nnights = 3\ncheck_out = check_in + timedelta(days=nights)\n\nprint(f\"Check-in: {check_in}\")\nprint(f\"Check-out: {check_out}\")\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - `import library` imports entire library\n> - `from library import function` imports specific items\n> - `import library as alias` creates shortcut name\n> - Common libraries: math, random, datetime"}'::jsonb,
  NULL,
  false,
  true
),

(
  'e0000000-0000-0000-0013-000000000002',
  'd0000000-0000-0000-0000-000000000013',
  '13.2',
  2,
  'Module 13 Checkpoint',
  'module-13-checkpoint',
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
        "question": "How do you import the math library?",
        "options": ["use math", "include math", "import math", "require math"],
        "correct": 2,
        "explanation": "Python uses ''import'' to bring in libraries."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does random.randint(1, 10) return?",
        "options": ["Always 1", "Always 10", "Random float 1-10", "Random integer 1-10 inclusive"],
        "correct": 3,
        "explanation": "randint returns a random integer including both endpoints."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "How do you import only sqrt from math?",
        "options": ["import sqrt from math", "from math import sqrt", "import math.sqrt", "use math.sqrt"],
        "correct": 1,
        "explanation": "Syntax: from library import function"
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
-- MODULE 14: Data Analysis Basics
-- ============================================

(
  'e0000000-0000-0000-0014-000000000001',
  'd0000000-0000-0000-0000-000000000014',
  '14.1',
  1,
  'Data Analysis with Python',
  'data-analysis-basics',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Data Analysis with Python\n\n##  Why This Matters\n\nHotels generate massive amounts of data: bookings, revenue, guest preferences. **Python excels at analyzing data to find insights** that drive business decisions.\n\n---\n\n##  Basic Data Analysis\n\n### Analyzing a List of Numbers\n\n```python\nrevenue = [12500, 15800, 14200, 18900, 16500, 21000, 19800]\n\n# Basic statistics\ntotal = sum(revenue)\naverage = sum(revenue) / len(revenue)\nhighest = max(revenue)\nlowest = min(revenue)\n\nprint(f\"Total: ${total:,}\")\nprint(f\"Average: ${average:,.2f}\")\nprint(f\"Range: ${lowest:,} - ${highest:,}\")\n```\n\n---\n\n##  Working with CSV Data\n\n```python\nimport csv\n\n# Reading CSV\nwith open(\"bookings.csv\", \"r\") as f:\n    reader = csv.DictReader(f)\n    for row in reader:\n        print(f\"{row[''guest'']}: Room {row[''room'']}\")\n\n# Writing CSV\nwith open(\"report.csv\", \"w\", newline=\"\") as f:\n    writer = csv.writer(f)\n    writer.writerow([\"Name\", \"Revenue\"])\n    writer.writerow([\"January\", 45000])\n```\n\n---\n\n##  Hotel Analysis Examples\n\n### Occupancy Analysis\n\n```python\noccupancy = [78, 82, 65, 91, 88, 95, 72]\ndays = [\"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\", \"Sun\"]\n\navg_occupancy = sum(occupancy) / len(occupancy)\nbest_day = days[occupancy.index(max(occupancy))]\nworst_day = days[occupancy.index(min(occupancy))]\n\nprint(f\"Average occupancy: {avg_occupancy:.1f}%\")\nprint(f\"Best day: {best_day} ({max(occupancy)}%)\")\nprint(f\"Worst day: {worst_day} ({min(occupancy)}%)\")\n```\n\n### Revenue by Category\n\n```python\nrevenue = {\n    \"rooms\": 125000,\n    \"restaurant\": 45000,\n    \"spa\": 18000,\n    \"other\": 12000\n}\n\ntotal = sum(revenue.values())\nprint(\"Revenue Breakdown:\")\nfor category, amount in revenue.items():\n    percent = (amount / total) * 100\n    print(f\"  {category.title()}: ${amount:,} ({percent:.1f}%)\")\n```\n\n---\n\n##  Sorting and Filtering\n\n```python\nbookings = [\n    {\"guest\": \"Alice\", \"amount\": 450},\n    {\"guest\": \"Bob\", \"amount\": 1200},\n    {\"guest\": \"Charlie\", \"amount\": 350}\n]\n\n# Sort by amount\nsorted_bookings = sorted(bookings, key=lambda x: x[\"amount\"], reverse=True)\n\n# Filter high-value\nhigh_value = [b for b in bookings if b[\"amount\"] >= 500]\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - sum(), min(), max(), len() for basic stats\n> - csv module for reading/writing CSV files\n> - sorted() with key function for custom sorting\n> - List comprehensions for filtering"}'::jsonb,
  NULL,
  false,
  true
),

(
  'e0000000-0000-0000-0014-000000000002',
  'd0000000-0000-0000-0000-000000000014',
  '14.2',
  2,
  'Module 14 Checkpoint',
  'module-14-checkpoint',
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
        "question": "How do you find the average of a list of numbers?",
        "options": ["average(list)", "list.avg()", "sum(list) / len(list)", "mean(list)"],
        "correct": 2,
        "explanation": "Python doesn''t have a built-in average. Use sum(list) / len(list)."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What module is used to read CSV files?",
        "options": ["file", "csv", "data", "excel"],
        "correct": 1,
        "explanation": "The csv module handles CSV file reading and writing."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What does sorted(data, key=lambda x: x[\"price\"]) do?",
        "options": ["Filters by price", "Sorts by price ascending", "Groups by price", "Sums prices"],
        "correct": 1,
        "explanation": "sorted() with key sorts by the specified attribute (price)."
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
-- MODULE 15: Course Review & Final Prep
-- ============================================

(
  'e0000000-0000-0000-0015-000000000001',
  'd0000000-0000-0000-0000-000000000015',
  '15.1',
  1,
  'Course Review',
  'course-review',
  'lesson',
  20,
  30,
  'basic',
  '{"markdown": "# Course Review: Everything You''ve Learned\n\n##  Congratulations!\n\nYou''ve completed a comprehensive journey from computational thinking concepts to Python programming. Let''s review everything!\n\n---\n\n##  Module Summary\n\n### Modules 1-3: Computational Thinking\n\n| Concept | Key Idea |\n|---------|----------|\n| **Decomposition** | Break problems into smaller parts |\n| **Pattern Recognition** | Find similarities and trends |\n| **Abstraction** | Focus on essentials, hide details |\n| **Algorithms** | Step-by-step procedures |\n| **Flowcharts** | Visual algorithm representation |\n| **Pseudocode** | Human-readable algorithm description |\n\n### Modules 4-6: Python Basics\n\n| Topic | Key Points |\n|-------|------------|\n| **Variables** | Named storage, snake_case |\n| **Data Types** | int, float, str, bool |\n| **Operators** | +, -, *, /, //, %, ** |\n| **f-strings** | f\"text {variable:.2f}\" |\n| **Conditionals** | if, elif, else |\n| **Boolean Logic** | and, or, not, ==, != |\n\n### Modules 7-9: Control Flow & Functions\n\n| Topic | Key Points |\n|-------|------------|\n| **while loops** | Repeat while condition true |\n| **for loops** | Iterate over sequences |\n| **range()** | Generate number sequences |\n| **Lists** | Ordered, mutable collections |\n| **Functions** | Reusable code blocks |\n| **Scope** | Local vs global variables |\n\n### Modules 10-14: Advanced Topics\n\n| Topic | Key Points |\n|-------|------------|\n| **Dictionaries** | Key-value pairs |\n| **File Handling** | read, write, with open() |\n| **Exception Handling** | try, except, finally |\n| **Libraries** | import, from...import |\n| **Data Analysis** | sum, min, max, sorting |\n\n---\n\n##  Key Exam Tips\n\n1. **Read questions carefully** - Watch for \"NOT\" and \"EXCEPT\"\n2. **Trace code step-by-step** - Write down variable values\n3. **Remember zero-indexing** - First item is index 0\n4. **Know your operators** - // truncates, / gives float, % gives remainder\n5. **Check indentation** - It defines code blocks\n6. **Default vs required parameters** - Know the difference\n\n---\n\n##  Common Exam Traps\n\n```python\n# = vs ==\nx = 5      # Assignment\nx == 5     # Comparison (True)\n\n# range() stops BEFORE end\nrange(5)      # 0,1,2,3,4 (not 5!)\nrange(1,5)    # 1,2,3,4 (not 5!)\n\n# String concatenation vs addition\n\"5\" + \"3\"     # \"53\" (concatenation)\n5 + 3         # 8 (addition)\n\n# List append vs extend\nlist.append([1,2])  # Adds [1,2] as ONE item\nlist.extend([1,2])  # Adds 1 and 2 separately\n\n# Scope\nx = 10\ndef f():\n    x = 20  # NEW local variable!\nf()\nprint(x)    # Still 10!\n```\n\n---\n\n##  You''re Ready!\n\nGood luck on your final exam!"}'::jsonb,
  NULL,
  false,
  true
),

(
  'e0000000-0000-0000-0015-000000000002',
  'd0000000-0000-0000-0000-000000000015',
  '15.2',
  2,
  'Final Practice Quiz',
  'final-practice-quiz',
  'quiz',
  20,
  100,
  'basic',
  '{
    "questions": [
      {
        "id": "fp1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Breaking a complex problem into smaller sub-problems is called:",
        "options": ["Abstraction", "Decomposition", "Pattern Recognition", "Algorithm"],
        "correct": 1
      },
      {
        "id": "fp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is the output? print(type(3.14))",
        "options": ["<class ''int''>", "<class ''float''>", "<class ''str''>", "<class ''double''>"],
        "correct": 1
      },
      {
        "id": "fp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does range(3) produce?",
        "options": ["1, 2, 3", "0, 1, 2, 3", "0, 1, 2", "3"],
        "correct": 2
      },
      {
        "id": "fp4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is 15 % 4?",
        "options": ["3", "3.75", "4", "15"],
        "correct": 0
      },
      {
        "id": "fp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is [1,2,3][-1]?",
        "options": ["1", "2", "3", "Error"],
        "correct": 2
      },
      {
        "id": "fp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does dict.get(\"key\", \"default\") return if \"key\" doesn''t exist?",
        "options": ["None", "Error", "\"default\"", "\"key\""],
        "correct": 2
      },
      {
        "id": "fp7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is printed?\n\nfor i in range(3):\n    if i == 1:\n        continue\n    print(i, end=\" \")",
        "options": ["0 1 2", "1", "0 2", "0 1"],
        "correct": 2
      },
      {
        "id": "fp8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\ndef f(x, y=10):\n    return x + y\nprint(f(5))",
        "options": ["5", "10", "15", "Error"],
        "correct": 2
      },
      {
        "id": "fp9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is [x*2 for x in [1,2,3] if x > 1]?",
        "options": ["[2, 4, 6]", "[4, 6]", "[2, 4]", "[1, 2, 3]"],
        "correct": 1
      },
      {
        "id": "fp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What does ''finally'' do in try-except-finally?",
        "options": ["Runs only if error", "Runs only if no error", "Always runs", "Optional cleanup"],
        "correct": 2
      }
    ],
    "passing_score": 70,
    "show_explanations": true
  }'::jsonb,
  NULL,
  false,
  true
);

-- ============================================
-- MOCK FINAL EXAM
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
(
  'e0000000-0000-0000-0100-000000000001',
  'd0000000-0000-0000-0000-000000000100',
  'mock-final-exam',
  1,
  'Mock Final Exam',
  'mock-final-exam',
  'exam',
  60,
  300,
  'basic',
  '{
    "title": "Mock Final Exam",
    "description": "Comprehensive practice exam covering all course material (Modules 1-15). Format mirrors the real final exam.",
    "duration_minutes": 60,
    "passing_score": 70,
    "allow_review": true,
    "randomize_questions": true,
    "sections": [
      {
        "name": "Section A: Computational Thinking (20 points)",
        "questions": [
          {"id": "f1", "type": "mcq", "points": 4, "question": "A hotel manager creates a flowchart showing how to handle guest complaints. This is an example of:", "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm Design"], "correct": 3},
          {"id": "f2", "type": "mcq", "points": 4, "question": "Noticing that room service orders increase 50% during rainy weather demonstrates:", "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Debugging"], "correct": 1},
          {"id": "f3", "type": "mcq", "points": 4, "question": "A subway map showing only stations and lines (not streets or buildings) demonstrates:", "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Iteration"], "correct": 2},
          {"id": "f4", "type": "mcq", "points": 4, "question": "In a flowchart, what shape represents a decision?", "options": ["Rectangle", "Oval", "Diamond", "Parallelogram"], "correct": 2},
          {"id": "f5", "type": "true_false", "points": 4, "question": "Pseudocode must follow strict syntax rules like Python.", "correct": false}
        ]
      },
      {
        "name": "Section B: Python Basics (25 points)",
        "questions": [
          {"id": "f6", "type": "mcq", "points": 3, "question": "What is the data type of: x = \"42\"", "options": ["int", "float", "str", "bool"], "correct": 2},
          {"id": "f7", "type": "mcq", "points": 3, "question": "What is 23 // 5?", "options": ["4.6", "4", "5", "3"], "correct": 1},
          {"id": "f8", "type": "mcq", "points": 3, "question": "What is 23 % 5?", "options": ["4.6", "4", "3", "0"], "correct": 2},
          {"id": "f9", "type": "mcq", "points": 4, "question": "What does f\"{99.5:.0f}\" produce?", "options": ["99.5", "99.50", "100", "99"], "correct": 2},
          {"id": "f10", "type": "mcq", "points": 4, "question": "What type does input() always return?", "options": ["int", "float", "str", "Depends on input"], "correct": 2},
          {"id": "f11", "type": "mcq", "points": 4, "question": "What is True and False or True?", "options": ["True", "False", "Error", "None"], "correct": 0},
          {"id": "f12", "type": "mcq", "points": 4, "question": "What is the output?\\n\\nif False:\\n    print(\"A\")\\nelif True:\\n    print(\"B\")\\nelse:\\n    print(\"C\")", "options": ["A", "B", "C", "A B C"], "correct": 1}
        ]
      },
      {
        "name": "Section C: Loops and Lists (25 points)",
        "questions": [
          {"id": "f13", "type": "mcq", "points": 4, "question": "What does range(2, 8, 2) produce?", "options": ["2, 4, 6, 8", "2, 4, 6", "2, 3, 4, 5, 6, 7", "2, 3"], "correct": 1},
          {"id": "f14", "type": "mcq", "points": 4, "question": "What is [10, 20, 30][1]?", "options": ["10", "20", "30", "Error"], "correct": 1},
          {"id": "f15", "type": "mcq", "points": 4, "question": "What does list.pop() return?", "options": ["Nothing", "The removed item", "True/False", "The list length"], "correct": 1},
          {"id": "f16", "type": "mcq", "points": 5, "question": "What is the output?\\n\\ntotal = 0\\nfor i in range(1, 4):\\n    total += i\\nprint(total)", "options": ["3", "6", "10", "4"], "correct": 1},
          {"id": "f17", "type": "mcq", "points": 4, "question": "What does break do in a loop?", "options": ["Pauses execution", "Exits the loop immediately", "Skips to next iteration", "Restarts the loop"], "correct": 1},
          {"id": "f18", "type": "mcq", "points": 4, "question": "What does [x**2 for x in range(4)] produce?", "options": ["[0, 1, 4, 9]", "[1, 4, 9, 16]", "[0, 1, 2, 3]", "[0, 2, 4, 6]"], "correct": 0}
        ]
      },
      {
        "name": "Section D: Functions and Dictionaries (20 points)",
        "questions": [
          {"id": "f19", "type": "mcq", "points": 4, "question": "What does a function return if there''s no return statement?", "options": ["0", "False", "None", "Error"], "correct": 2},
          {"id": "f20", "type": "mcq", "points": 5, "question": "What is the output?\\n\\ndef greet(name, msg=\"Hello\"):\\n    return f\"{msg}, {name}\"\\nprint(greet(\"Alice\"))", "options": ["Hello, Alice", "Alice, Hello", "Error", "None"], "correct": 0},
          {"id": "f21", "type": "mcq", "points": 4, "question": "How do you access value for key \"room\" in dict d?", "options": ["d.room", "d(room)", "d[\"room\"]", "d->room"], "correct": 2},
          {"id": "f22", "type": "mcq", "points": 4, "question": "What does d.get(\"x\", 0) return if \"x\" is not in dictionary d?", "options": ["None", "Error", "0", "\"x\""], "correct": 2},
          {"id": "f23", "type": "true_false", "points": 3, "question": "A variable defined inside a function can be accessed outside that function.", "correct": false}
        ]
      },
      {
        "name": "Section E: Files and Exceptions (10 points)",
        "questions": [
          {"id": "f24", "type": "mcq", "points": 3, "question": "What mode opens a file for writing (overwrites existing content)?", "options": ["\"r\"", "\"w\"", "\"a\"", "\"x\""], "correct": 1},
          {"id": "f25", "type": "mcq", "points": 3, "question": "What exception is raised by int(\"hello\")?", "options": ["TypeError", "ValueError", "SyntaxError", "NameError"], "correct": 1},
          {"id": "f26", "type": "mcq", "points": 4, "question": "When does the ''finally'' block execute?", "options": ["Only if exception occurs", "Only if no exception", "Always", "Never automatically"], "correct": 2}
        ]
      }
    ]
  }'::jsonb,
  'exam',
  true,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;
