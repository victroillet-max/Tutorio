-- ============================================
-- Mock Midterm Exam
-- Covers Modules 1-6 (CT Foundations through Conditionals)
-- Format matches the real EHL midterm: 40 minutes, open book
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

(
  'e0000000-0000-0000-0099-000000000001',
  'd0000000-0000-0000-0000-000000000099',
  'mock-midterm-exam',
  1,
  'Mock Midterm Exam',
  'mock-midterm-exam',
  'exam',
  40,
  200,
  'basic',
  '{
    "title": "Mock Midterm Exam",
    "description": "This practice exam covers all material from Modules 1-6. It mirrors the format and difficulty of the real midterm exam.",
    "duration_minutes": 40,
    "passing_score": 70,
    "allow_review": true,
    "randomize_questions": true,
    "randomize_options": true,
    "sections": [
      {
        "name": "Section A: Computational Thinking Concepts",
        "points": 25,
        "questions": [
          {
            "id": "m1",
            "type": "mcq",
            "points": 3,
            "question": "A hotel manager breaks down ''guest experience'' into: booking, arrival, stay, and departure. This is an example of:",
            "options": ["Pattern Recognition", "Decomposition", "Abstraction", "Algorithm"],
            "correct": 1,
            "explanation": "Breaking a complex concept into smaller parts is DECOMPOSITION."
          },
          {
            "id": "m2",
            "type": "mcq",
            "points": 3,
            "question": "A resort notices that spa bookings increase 40% on rainy days. Using this insight to schedule extra staff when rain is forecast demonstrates:",
            "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Pseudocode"],
            "correct": 1,
            "explanation": "Identifying trends in data and acting on them is PATTERN RECOGNITION."
          },
          {
            "id": "m3",
            "type": "mcq",
            "points": 3,
            "question": "A hotel booking website shows room types and prices but hides the complex reservation system behind the scenes. This is:",
            "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
            "correct": 2,
            "explanation": "Hiding complexity while showing essential information is ABSTRACTION."
          },
          {
            "id": "m4",
            "type": "mcq",
            "points": 3,
            "question": "Which shape represents a DECISION in a flowchart?",
            "options": ["Rectangle", "Oval", "Diamond", "Parallelogram"],
            "correct": 2,
            "explanation": "A DIAMOND represents decisions (yes/no questions) in flowcharts."
          },
          {
            "id": "m5",
            "type": "mcq",
            "points": 3,
            "question": "Pseudocode is:",
            "options": ["Actual Python code", "A type of flowchart", "An informal algorithm description in structured natural language", "Binary code"],
            "correct": 2,
            "explanation": "Pseudocode describes algorithms in structured human language, not machine language."
          },
          {
            "id": "m6",
            "type": "mcq",
            "points": 3,
            "question": "The three building blocks of algorithms are:",
            "options": ["Input, Output, Process", "Sequence, Selection, Iteration", "Variables, Functions, Classes", "Start, Middle, End"],
            "correct": 1,
            "explanation": "Algorithms use Sequence (steps), Selection (if/else), and Iteration (loops)."
          },
          {
            "id": "m7",
            "type": "true_false",
            "points": 2,
            "question": "In a flowchart, every path must eventually reach an END symbol.",
            "correct": true,
            "explanation": "TRUE. Paths that don''t reach END are ''dead ends''  logical errors."
          },
          {
            "id": "m8",
            "type": "true_false",
            "points": 2,
            "question": "Binary search can only be used on sorted data.",
            "correct": true,
            "explanation": "TRUE. Binary search requires sorted data to work correctly."
          }
        ]
      },
      {
        "name": "Section B: Python Basics",
        "points": 25,
        "questions": [
          {
            "id": "m9",
            "type": "mcq",
            "points": 3,
            "question": "What will print(\"5\" + \"3\") output?",
            "options": ["8", "53", "5 + 3", "Error"],
            "correct": 1,
            "explanation": "With strings, + concatenates. \"5\" + \"3\" = \"53\""
          },
          {
            "id": "m10",
            "type": "mcq",
            "points": 3,
            "question": "Which is a valid Python variable name?",
            "options": ["2fast", "my-var", "my_var", "class"],
            "correct": 2,
            "explanation": "my_var is valid. 2fast starts with number, my-var has hyphen, class is a keyword."
          },
          {
            "id": "m11",
            "type": "mcq",
            "points": 3,
            "question": "What is the data type of: x = 3.14",
            "options": ["int", "float", "str", "bool"],
            "correct": 1,
            "explanation": "3.14 has a decimal point, making it a float."
          },
          {
            "id": "m12",
            "type": "mcq",
            "points": 3,
            "question": "What is 17 % 5?",
            "options": ["3.4", "3", "2", "0"],
            "correct": 2,
            "explanation": "% gives remainder. 17 = 53 + 2, so remainder is 2."
          },
          {
            "id": "m13",
            "type": "mcq",
            "points": 3,
            "question": "What is 17 // 5?",
            "options": ["3.4", "3", "4", "2"],
            "correct": 1,
            "explanation": "// is floor division (rounds down). 17  5 = 3.4  3"
          },
          {
            "id": "m14",
            "type": "mcq",
            "points": 3,
            "question": "What does f\"Price: ${100.5:.2f}\" output?",
            "options": ["Price: $100.5", "Price: $100.50", "Price: ${100.5:.2f}", "Error"],
            "correct": 1,
            "explanation": ":.2f formats to 2 decimal places. Output: Price: $100.50"
          },
          {
            "id": "m15",
            "type": "mcq",
            "points": 3,
            "question": "What type does input() return?",
            "options": ["int", "float", "str", "bool"],
            "correct": 2,
            "explanation": "input() ALWAYS returns a string, even if user types numbers."
          },
          {
            "id": "m16",
            "type": "true_false",
            "points": 2,
            "question": "int(3.9) returns 4.",
            "correct": false,
            "explanation": "FALSE. int() truncates (cuts off) decimals. int(3.9) = 3, not 4."
          },
          {
            "id": "m17",
            "type": "true_false",
            "points": 2,
            "question": "In Python, = and == mean the same thing.",
            "correct": false,
            "explanation": "FALSE. = is assignment, == is comparison."
          }
        ]
      },
      {
        "name": "Section C: Conditionals & Boolean Logic",
        "points": 30,
        "questions": [
          {
            "id": "m18",
            "type": "mcq",
            "points": 3,
            "question": "What is True and False?",
            "options": ["True", "False", "Error", "None"],
            "correct": 1,
            "explanation": "AND requires both to be True. True and False = False."
          },
          {
            "id": "m19",
            "type": "mcq",
            "points": 3,
            "question": "What is True or False?",
            "options": ["True", "False", "Error", "None"],
            "correct": 0,
            "explanation": "OR requires at least one True. True or False = True."
          },
          {
            "id": "m20",
            "type": "mcq",
            "points": 3,
            "question": "What is not True?",
            "options": ["True", "False", "Error", "1"],
            "correct": 1,
            "explanation": "not reverses the boolean. not True = False."
          },
          {
            "id": "m21",
            "type": "mcq",
            "points": 4,
            "question": "What will this print?\n\nx = 15\nif x > 20:\n    print(\"High\")\nelif x > 10:\n    print(\"Medium\")\nelse:\n    print(\"Low\")",
            "options": ["High", "Medium", "Low", "Medium and Low"],
            "correct": 1,
            "explanation": "x=15: not > 20 (False), IS > 10 (True)  prints \"Medium\". Only one branch runs."
          },
          {
            "id": "m22",
            "type": "mcq",
            "points": 4,
            "question": "What will this print?\n\na = 5\nb = 10\nif a > 3:\n    print(\"X\")\nif b > 3:\n    print(\"Y\")",
            "options": ["X", "Y", "X and Y", "Nothing"],
            "correct": 2,
            "explanation": "These are TWO SEPARATE if statements (not if-elif). Both conditions are true, so both print."
          },
          {
            "id": "m23",
            "type": "mcq",
            "points": 4,
            "question": "Which expression is True?\n\nage = 25\nis_student = False",
            "options": ["age > 30 and is_student", "age > 30 or is_student", "age > 20 and is_student", "age > 20 or is_student"],
            "correct": 3,
            "explanation": "age > 20 is True, is_student is False. True or False = True."
          },
          {
            "id": "m24",
            "type": "mcq",
            "points": 4,
            "question": "What is bool(0)?",
            "options": ["True", "False", "0", "Error"],
            "correct": 1,
            "explanation": "0 is ''falsy'' in Python. bool(0) = False."
          },
          {
            "id": "m25",
            "type": "true_false",
            "points": 2,
            "question": "else statements can have a condition.",
            "correct": false,
            "explanation": "FALSE. else cannot have a condition. Use elif for additional conditions."
          },
          {
            "id": "m26",
            "type": "true_false",
            "points": 3,
            "question": "In if-elif-else, if multiple conditions are True, multiple branches will execute.",
            "correct": false,
            "explanation": "FALSE. Only the FIRST true branch executes in if-elif-else."
          }
        ]
      },
      {
        "name": "Section D: Code Analysis",
        "points": 20,
        "questions": [
          {
            "id": "m27",
            "type": "mcq",
            "points": 5,
            "question": "What will this code output?\n\nprice = 100\nis_member = True\nnights = 4\n\nif is_member and nights >= 3:\n    discount = 0.20\nelif is_member:\n    discount = 0.10\nelse:\n    discount = 0\n\nfinal = price * (1 - discount)\nprint(final)",
            "options": ["80.0", "90.0", "100.0", "100"],
            "correct": 0,
            "explanation": "is_member is True AND nights (4) >= 3  discount = 0.20. 100  0.80 = 80.0"
          },
          {
            "id": "m28",
            "type": "mcq",
            "points": 5,
            "question": "What is wrong with this code?\n\nif age >= 18\n    print(\"Adult\")",
            "options": ["age is not defined", "Missing colon after condition", "print needs capital P", "Nothing is wrong"],
            "correct": 1,
            "explanation": "Missing colon (:) after the if condition."
          },
          {
            "id": "m29",
            "type": "mcq",
            "points": 5,
            "question": "What will this output?\n\nx = 10\ny = 3\nprint(f\"{x} / {y} = {x/y:.1f} (remainder: {x%y})\")",
            "options": ["10 / 3 = 3.3 (remainder: 1)", "10 / 3 = 3.33 (remainder: 1)", "10 / 3 = 3.3 (remainder: 0)", "Error"],
            "correct": 0,
            "explanation": "10/3 = 3.333... formatted to 1 decimal = 3.3. 10%3 = 1 (remainder)."
          },
          {
            "id": "m30",
            "type": "mcq",
            "points": 5,
            "question": "What is the value of result after this code?\n\na = \"5\"\nb = 3\nresult = int(a) + b",
            "options": ["\"53\"", "53", "8", "Error"],
            "correct": 2,
            "explanation": "int(\"5\") converts string to integer 5. 5 + 3 = 8."
          }
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
