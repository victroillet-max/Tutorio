-- ============================================
-- New Interactive Activities for Modules 3-10
-- Adds interactive visualizers and exercises
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- MODULE 3: Flowchart Builder Interactive
-- ============================================
(
  'e0000000-0000-0000-0003-000000000098',
  'd0000000-0000-0000-0000-000000000003',
  '3.98',
  98,
  'Algorithm Sequence Builder',
  'algorithm-sequence-builder',
  'interactive',
  10,
  40,
  'basic',
  '{

  
    "instructions": "Arrange these algorithm steps in the correct order to solve the given problem!",
    "type": "sequence-ordering",
    "scenarios": [
      {
        "problem": "Calculate total hotel bill with tax",
        "steps": [
          "Get room rate per night",
          "Get number of nights",
          "Calculate subtotal (rate x nights)",
          "Get tax percentage",
          "Calculate tax amount",
          "Add tax to subtotal",
          "Display final total"
        ],
        "correctOrder": [0, 1, 2, 3, 4, 5, 6]
      },
      {
        "problem": "Find the highest revenue day",
        "steps": [
          "Set highest to first day''s revenue",
          "Set best_day to first day",
          "Loop through remaining days",
          "If current day revenue > highest",
          "Update highest to current revenue",
          "Update best_day to current day",
          "End loop and display best_day"
        ],
        "correctOrder": [0, 1, 2, 3, 4, 5, 6]
      },
      {
        "problem": "Validate guest check-in",
        "steps": [
          "Get reservation details",
          "Check if room is ready",
          "If room not ready, offer lounge access",
          "Verify guest ID",
          "Process payment if needed",
          "Generate room key",
          "Provide welcome information"
        ],
        "correctOrder": [0, 3, 4, 1, 2, 5, 6]
      }
    ],
    "scoring": {
      "perfect": 30,
      "partial": 15,
      "passing_score": 60
    }
  }'::jsonb,
  'sequence-ordering',
  false,
  true
),

-- ============================================
-- MODULE 4: Python Syntax Matcher
-- ============================================
(
  'e0000000-0000-0000-0004-000000000098',
  'd0000000-0000-0000-0000-000000000004',
  '4.98',
  98,
  'Python Syntax Matcher',
  'python-syntax-matcher',
  'interactive',
  8,
  35,
  'basic',
  '{
    "instructions": "Match each Python concept with its correct syntax example!",
    "type": "drag-drop-match",
    "pairs": [
      {"left": "Print text to screen", "right": "print(\"Hello\")", "explanation": "print() displays output. Text needs quotes."},
      {"left": "Single-line comment", "right": "# This is a comment", "explanation": "# starts a comment that Python ignores."},
      {"left": "Multi-line string", "right": "\"\"\"Multiple\\nlines\"\"\"", "explanation": "Triple quotes allow multi-line strings."},
      {"left": "Print number without quotes", "right": "print(42)", "explanation": "Numbers don''t need quotes in print()."},
      {"left": "Print multiple items", "right": "print(\"Age:\", 25)", "explanation": "Commas separate items and add spaces."},
      {"left": "Change line ending", "right": "print(\"Hi\", end=\"\")", "explanation": "end=\"\" removes the default newline."},
      {"left": "Valid variable name", "right": "guest_name", "explanation": "snake_case is Python''s naming convention."},
      {"left": "Invalid variable name", "right": "2nd_guest", "explanation": "Variables cannot start with numbers."}
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
-- MODULE 5: Data Type Classifier
-- ============================================
(
  'e0000000-0000-0000-0005-000000000098',
  'd0000000-0000-0000-0000-000000000005',
  '5.98',
  98,
  'Data Type Classifier',
  'data-type-classifier',
  'interactive',
  10,
  40,
  'basic',
  '{
    "instructions": "Classify each value into its correct Python data type. You have 20 seconds per question!",
    "type": "timed-classification",
    "timePerQuestion": 20,
    "categories": ["int", "float", "str", "bool", "list", "dict"],
    "scenarios": [
      {"value": "42", "correctType": "int", "explanation": "42 is a whole number (integer)."},
      {"value": "3.14", "correctType": "float", "explanation": "3.14 has a decimal point (float)."},
      {"value": "\"Hello\"", "correctType": "str", "explanation": "Text in quotes is a string."},
      {"value": "True", "correctType": "bool", "explanation": "True/False are boolean values."},
      {"value": "[1, 2, 3]", "correctType": "list", "explanation": "Square brackets create a list."},
      {"value": "{\"name\": \"Alice\"}", "correctType": "dict", "explanation": "Curly braces with key:value pairs are dicts."},
      {"value": "\"42\"", "correctType": "str", "explanation": "In quotes, even numbers are strings!"},
      {"value": "0", "correctType": "int", "explanation": "0 is an integer."},
      {"value": "False", "correctType": "bool", "explanation": "False is a boolean value."},
      {"value": "[]", "correctType": "list", "explanation": "Empty brackets are an empty list."},
      {"value": "None", "correctType": "NoneType", "explanation": "None represents absence of value."},
      {"value": "-5.0", "correctType": "float", "explanation": "Has decimal point, so it''s a float."}
    ],
    "scoring": {
      "correct": 10,
      "incorrect": 0,
      "timeBonus": 5,
      "passing_score": 60
    }
  }'::jsonb,
  'timed-classification',
  false,
  true
),

-- ============================================
-- MODULE 5: Variable Assignment Visualizer
-- ============================================
(
  'e0000000-0000-0000-0005-000000000097',
  'd0000000-0000-0000-0000-000000000005',
  '5.97',
  97,
  'Variable Assignment Visualizer',
  'variable-assignment-viz',
  'interactive',
  10,
  35,
  'basic',
  '{
    "instructions": "Trace through the code and predict the final value of each variable!",
    "type": "code-trace",
    "scenarios": [
      {
        "code": "x = 10\ny = x\nx = 20\nprint(y)",
        "question": "What is the value of y?",
        "options": ["10", "20", "x", "Error"],
        "correct": 0,
        "explanation": "y gets the VALUE of x (10) at assignment time. Changing x later doesn''t affect y."
      },
      {
        "code": "price = 100\ndiscount = 0.2\nfinal = price * (1 - discount)\nprint(final)",
        "question": "What is final?",
        "options": ["0.8", "20", "80", "80.0"],
        "correct": 3,
        "explanation": "price * (1 - 0.2) = 100 * 0.8 = 80.0 (float because of 0.2)"
      },
      {
        "code": "name = \"Alice\"\ngreeting = \"Hello, \" + name\nname = \"Bob\"\nprint(greeting)",
        "question": "What is printed?",
        "options": ["Hello, Alice", "Hello, Bob", "Hello, name", "Error"],
        "correct": 0,
        "explanation": "greeting was set when name was \"Alice\". Changing name later doesn''t change greeting."
      },
      {
        "code": "a = 5\nb = 3\na = a + b\nb = a - b\na = a - b\nprint(a, b)",
        "question": "What is printed?",
        "options": ["5 3", "3 5", "8 5", "8 3"],
        "correct": 1,
        "explanation": "This is a swap! a=5+3=8, b=8-3=5, a=8-5=3. Final: a=3, b=5"
      }
    ],
    "scoring": {
      "correct": 15,
      "incorrect": 0,
      "passing_score": 60
    }
  }'::jsonb,
  'code-trace',
  false,
  true
),

-- ============================================
-- MODULE 6: Condition Builder
-- ============================================
(
  'e0000000-0000-0000-0006-000000000098',
  'd0000000-0000-0000-0000-000000000006',
  '6.98',
  98,
  'Condition Builder',
  'condition-builder',
  'interactive',
  12,
  45,
  'basic',
  '{
    "instructions": "Build the correct Python condition for each scenario!",
    "type": "condition-constructor",
    "scenarios": [
      {
        "description": "Guest qualifies for VIP upgrade if they have stayed 5 or more nights AND have spent over $1000",
        "variables": {"nights": "int", "total_spent": "float"},
        "correctCondition": "nights >= 5 and total_spent > 1000",
        "hints": ["Use ''and'' to combine two conditions", "Use >= for ''or equal to''"]
      },
      {
        "description": "Show late checkout option if guest is VIP OR is staying in a suite",
        "variables": {"is_vip": "bool", "room_type": "str"},
        "correctCondition": "is_vip or room_type == \"suite\"",
        "hints": ["Use ''or'' when either condition is enough", "Strings need quotes and =="]
      },
      {
        "description": "Block booking if guest age is under 18",
        "variables": {"age": "int"},
        "correctCondition": "age < 18",
        "hints": ["This is a simple comparison"]
      },
      {
        "description": "Apply discount if booking is NOT for a weekend (Saturday or Sunday)",
        "variables": {"day": "str"},
        "correctCondition": "day != \"Saturday\" and day != \"Sunday\"",
        "alternativeCorrect": "not (day == \"Saturday\" or day == \"Sunday\")",
        "hints": ["Use != for ''not equal''", "Need to check both weekend days"]
      }
    ],
    "scoring": {
      "correct": 20,
      "partial": 10,
      "passing_score": 60
    }
  }'::jsonb,
  'condition-constructor',
  false,
  true
),

-- ============================================
-- MODULE 6: Truth Table Explorer
-- ============================================
(
  'e0000000-0000-0000-0006-000000000097',
  'd0000000-0000-0000-0000-000000000006',
  '6.97',
  97,
  'Truth Table Explorer',
  'truth-table-explorer',
  'interactive',
  8,
  35,
  'basic',
  '{
    "instructions": "Complete the truth tables for these boolean expressions!",
    "type": "truth-table",
    "tables": [
      {
        "expression": "A and B",
        "inputs": [
          {"A": true, "B": true},
          {"A": true, "B": false},
          {"A": false, "B": true},
          {"A": false, "B": false}
        ],
        "correctOutputs": [true, false, false, false],
        "explanation": "''and'' is True only when BOTH inputs are True"
      },
      {
        "expression": "A or B",
        "inputs": [
          {"A": true, "B": true},
          {"A": true, "B": false},
          {"A": false, "B": true},
          {"A": false, "B": false}
        ],
        "correctOutputs": [true, true, true, false],
        "explanation": "''or'' is True when AT LEAST ONE input is True"
      },
      {
        "expression": "not A",
        "inputs": [
          {"A": true},
          {"A": false}
        ],
        "correctOutputs": [false, true],
        "explanation": "''not'' flips the boolean value"
      },
      {
        "expression": "A and not B",
        "inputs": [
          {"A": true, "B": true},
          {"A": true, "B": false},
          {"A": false, "B": true},
          {"A": false, "B": false}
        ],
        "correctOutputs": [false, true, false, false],
        "explanation": "True only when A is True AND B is False"
      }
    ],
    "scoring": {
      "correct": 5,
      "incorrect": 0,
      "passing_score": 70
    }
  }'::jsonb,
  'truth-table',
  false,
  true
),

-- ============================================
-- MODULE 7: Loop Trace Visualizer
-- ============================================
(
  'e0000000-0000-0000-0007-000000000098',
  'd0000000-0000-0000-0000-000000000007',
  '7.98',
  98,
  'Loop Trace Visualizer',
  'loop-trace-visualizer',
  'interactive',
  12,
  45,
  'basic',
  '{
    "instructions": "Step through each loop and track the variable values at each iteration!",
    "type": "step-debugger",
    "scenarios": [
      {
        "code": "total = 0\nfor i in range(1, 4):\n    total = total + i\nprint(total)",
        "steps": [
          {"line": 1, "variables": {"total": 0}},
          {"line": 2, "variables": {"total": 0, "i": 1}},
          {"line": 3, "variables": {"total": 1, "i": 1}},
          {"line": 2, "variables": {"total": 1, "i": 2}},
          {"line": 3, "variables": {"total": 3, "i": 2}},
          {"line": 2, "variables": {"total": 3, "i": 3}},
          {"line": 3, "variables": {"total": 6, "i": 3}},
          {"line": 4, "variables": {"total": 6}}
        ],
        "finalAnswer": 6,
        "explanation": "range(1, 4) gives 1, 2, 3. Sum: 1+2+3=6"
      },
      {
        "code": "count = 0\nfor x in [10, 20, 30]:\n    if x > 15:\n        count = count + 1\nprint(count)",
        "steps": [
          {"line": 1, "variables": {"count": 0}},
          {"line": 2, "variables": {"count": 0, "x": 10}},
          {"line": 3, "variables": {"count": 0, "x": 10}, "note": "10 > 15 is False, skip"},
          {"line": 2, "variables": {"count": 0, "x": 20}},
          {"line": 3, "variables": {"count": 0, "x": 20}, "note": "20 > 15 is True"},
          {"line": 4, "variables": {"count": 1, "x": 20}},
          {"line": 2, "variables": {"count": 1, "x": 30}},
          {"line": 3, "variables": {"count": 1, "x": 30}, "note": "30 > 15 is True"},
          {"line": 4, "variables": {"count": 2, "x": 30}},
          {"line": 5, "variables": {"count": 2}}
        ],
        "finalAnswer": 2,
        "explanation": "Only 20 and 30 are greater than 15, so count = 2"
      }
    ],
    "scoring": {
      "correct_trace": 10,
      "correct_final": 15,
      "passing_score": 60
    }
  }'::jsonb,
  'step-debugger',
  false,
  true
),

-- ============================================
-- MODULE 7: Loop Pattern Game
-- ============================================
(
  'e0000000-0000-0000-0007-000000000097',
  'd0000000-0000-0000-0000-000000000007',
  '7.97',
  97,
  'Loop Output Predictor',
  'loop-output-predictor',
  'interactive',
  10,
  40,
  'basic',
  '{
    "instructions": "Predict what each loop will output!",
    "type": "output-prediction",
    "scenarios": [
      {
        "code": "for i in range(5):\n    print(i, end=\" \")",
        "question": "What is printed?",
        "options": ["1 2 3 4 5", "0 1 2 3 4", "0 1 2 3 4 5", "1 2 3 4"],
        "correct": 1,
        "explanation": "range(5) produces 0, 1, 2, 3, 4 (starts at 0, stops before 5)"
      },
      {
        "code": "for i in range(1, 6, 2):\n    print(i, end=\" \")",
        "question": "What is printed?",
        "options": ["1 2 3 4 5", "1 3 5", "2 4 6", "1 3 5 7"],
        "correct": 1,
        "explanation": "range(1, 6, 2) starts at 1, steps by 2: 1, 3, 5"
      },
      {
        "code": "n = 3\nwhile n > 0:\n    print(n, end=\" \")\n    n = n - 1",
        "question": "What is printed?",
        "options": ["3 2 1", "3 2 1 0", "1 2 3", "2 1 0"],
        "correct": 0,
        "explanation": "Starts at 3, prints then decrements. Stops when n becomes 0."
      },
      {
        "code": "for c in \"HI!\":\n    print(c)",
        "question": "How many lines are printed?",
        "options": ["1", "2", "3", "Error"],
        "correct": 2,
        "explanation": "String \"HI!\" has 3 characters: H, I, !. Each prints on its own line."
      },
      {
        "code": "for i in range(3):\n    for j in range(2):\n        print(\"*\", end=\"\")\n    print()",
        "question": "What pattern is printed?",
        "options": ["******", "**\\n**\\n**", "***\\n***", "** ** **"],
        "correct": 1,
        "explanation": "Outer loop runs 3 times. Inner prints ** then newline. Result: 3 lines of **"
      }
    ],
    "scoring": {
      "correct": 12,
      "incorrect": 0,
      "passing_score": 60
    }
  }'::jsonb,
  'output-prediction',
  false,
  true
),

-- ============================================
-- MODULE 8: List Operation Visualizer
-- ============================================
(
  'e0000000-0000-0000-0008-000000000098',
  'd0000000-0000-0000-0000-000000000008',
  '8.98',
  98,
  'List Operation Visualizer',
  'list-operation-visualizer',
  'interactive',
  10,
  40,
  'basic',
  '{
    "instructions": "Predict the result of each list operation!",
    "type": "list-visualizer",
    "scenarios": [
      {
        "initial": "[10, 20, 30, 40, 50]",
        "operation": "items[2]",
        "question": "What is returned?",
        "options": ["20", "30", "40", "Error"],
        "correct": 1,
        "explanation": "Index 2 is the THIRD element (0, 1, 2). That''s 30."
      },
      {
        "initial": "[10, 20, 30, 40, 50]",
        "operation": "items[-1]",
        "question": "What is returned?",
        "options": ["10", "50", "-1", "Error"],
        "correct": 1,
        "explanation": "Negative index -1 means last element. That''s 50."
      },
      {
        "initial": "[10, 20, 30, 40, 50]",
        "operation": "items[1:4]",
        "question": "What is returned?",
        "options": ["[20, 30, 40]", "[10, 20, 30, 40]", "[20, 30, 40, 50]", "[10, 20, 30]"],
        "correct": 0,
        "explanation": "Slice [1:4] includes index 1, 2, 3 (not 4). That''s [20, 30, 40]."
      },
      {
        "initial": "[10, 20, 30]",
        "operation": "items.append(40)\nprint(items)",
        "question": "What is printed?",
        "options": ["[10, 20, 30]", "[40, 10, 20, 30]", "[10, 20, 30, 40]", "40"],
        "correct": 2,
        "explanation": "append() adds to the END of the list."
      },
      {
        "initial": "[10, 20, 30, 40]",
        "operation": "items.pop(1)\nprint(items)",
        "question": "What is printed?",
        "options": ["[10, 30, 40]", "[20, 30, 40]", "[10, 20, 30]", "[10, 20, 40]"],
        "correct": 0,
        "explanation": "pop(1) removes and returns item at index 1 (which is 20)."
      },
      {
        "initial": "[3, 1, 4, 1, 5]",
        "operation": "items.count(1)",
        "question": "What is returned?",
        "options": ["1", "2", "3", "0"],
        "correct": 1,
        "explanation": "count() returns how many times 1 appears. Answer: 2 times."
      }
    ],
    "scoring": {
      "correct": 10,
      "incorrect": 0,
      "passing_score": 60
    }
  }'::jsonb,
  'list-visualizer',
  false,
  true
),

-- ============================================
-- MODULE 9: Function Call Tracer
-- ============================================
(
  'e0000000-0000-0000-0009-000000000098',
  'd0000000-0000-0000-0000-000000000009',
  '9.98',
  98,
  'Function Call Tracer',
  'function-call-tracer',
  'interactive',
  12,
  45,
  'basic',
  '{
    "instructions": "Trace through function calls and predict the output!",
    "type": "function-trace",
    "scenarios": [
      {
        "code": "def double(x):\n    return x * 2\n\nresult = double(5)\nprint(result)",
        "question": "What is printed?",
        "options": ["5", "10", "25", "Error"],
        "correct": 1,
        "explanation": "double(5) returns 5 * 2 = 10"
      },
      {
        "code": "def greet(name, msg=\"Hello\"):\n    return f\"{msg}, {name}!\"\n\nprint(greet(\"Alice\"))",
        "question": "What is printed?",
        "options": ["Hello, Alice!", "Alice, Hello!", "Error - missing argument", "Hello, !"],
        "correct": 0,
        "explanation": "msg has default value \"Hello\", so only name is required."
      },
      {
        "code": "def add(a, b):\n    return a + b\n\ndef multiply(x, y):\n    return x * y\n\nresult = add(multiply(2, 3), 4)\nprint(result)",
        "question": "What is printed?",
        "options": ["9", "10", "14", "24"],
        "correct": 1,
        "explanation": "multiply(2, 3) = 6, then add(6, 4) = 10"
      },
      {
        "code": "def process(x):\n    if x > 10:\n        return x * 2\n    return x + 5\n\nprint(process(8))\nprint(process(15))",
        "question": "What is printed (2 lines)?",
        "options": ["16\\n30", "13\\n30", "13\\n20", "16\\n20"],
        "correct": 1,
        "explanation": "8 <= 10: returns 8+5=13. 15 > 10: returns 15*2=30"
      },
      {
        "code": "x = 10\n\ndef change(x):\n    x = 20\n    return x\n\nchange(x)\nprint(x)",
        "question": "What is printed?",
        "options": ["10", "20", "None", "Error"],
        "correct": 0,
        "explanation": "The function parameter x is LOCAL. Global x is unchanged. Answer: 10"
      }
    ],
    "scoring": {
      "correct": 12,
      "incorrect": 0,
      "passing_score": 60
    }
  }'::jsonb,
  'function-trace',
  false,
  true
),

-- ============================================
-- MODULE 9: Parameter Matcher
-- ============================================
(
  'e0000000-0000-0000-0009-000000000097',
  'd0000000-0000-0000-0000-000000000009',
  '9.97',
  97,
  'Parameter Matcher',
  'parameter-matcher',
  'interactive',
  8,
  35,
  'basic',
  '{
    "instructions": "Match each function call with its correct output!",
    "type": "drag-drop-match",
    "setup": "def greet(name, greeting=\"Hello\", punctuation=\"!\"):\n    return f\"{greeting}, {name}{punctuation}\"",
    "pairs": [
      {"left": "greet(\"Alice\")", "right": "Hello, Alice!", "explanation": "Uses both default values."},
      {"left": "greet(\"Bob\", \"Hi\")", "right": "Hi, Bob!", "explanation": "Custom greeting, default punctuation."},
      {"left": "greet(\"Charlie\", punctuation=\"?\")", "right": "Hello, Charlie?", "explanation": "Default greeting, keyword punctuation."},
      {"left": "greet(greeting=\"Welcome\", name=\"Diana\")", "right": "Welcome, Diana!", "explanation": "Both as keyword args, any order."},
      {"left": "greet(\"Eve\", \"Hey\", \".\")", "right": "Hey, Eve.", "explanation": "All three positional arguments."}
    ],
    "scoring": {
      "correct": 12,
      "incorrect": 0,
      "passing_score": 60
    }
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- ============================================
-- MODULE 10: Dictionary Access Visualizer
-- ============================================
(
  'e0000000-0000-0000-0010-000000000098',
  'd0000000-0000-0000-0000-000000000010',
  '10.98',
  98,
  'Dictionary Access Visualizer',
  'dict-access-visualizer',
  'interactive',
  10,
  40,
  'basic',
  '{
    "instructions": "Predict the result of each dictionary operation!",
    "type": "dict-visualizer",
    "setup": "guest = {\n    \"name\": \"Alice Smith\",\n    \"room\": 405,\n    \"vip\": True,\n    \"preferences\": {\n        \"floor\": \"high\",\n        \"pillows\": \"soft\"\n    }\n}",
    "scenarios": [
      {
        "operation": "guest[\"name\"]",
        "question": "What is returned?",
        "options": ["\"name\"", "\"Alice Smith\"", "Alice Smith", "Error"],
        "correct": 1,
        "explanation": "Returns the value for key \"name\" (with quotes in the representation)."
      },
      {
        "operation": "guest[\"room\"]",
        "question": "What is returned?",
        "options": ["\"room\"", "\"405\"", "405", "Error"],
        "correct": 2,
        "explanation": "Room is stored as integer 405, not string."
      },
      {
        "operation": "guest.get(\"email\", \"N/A\")",
        "question": "What is returned?",
        "options": ["None", "\"email\"", "\"N/A\"", "Error"],
        "correct": 2,
        "explanation": ".get() returns default \"N/A\" since \"email\" key doesn''t exist."
      },
      {
        "operation": "guest[\"preferences\"][\"floor\"]",
        "question": "What is returned?",
        "options": ["\"preferences\"", "\"floor\"", "\"high\"", "Error"],
        "correct": 2,
        "explanation": "Nested access: first get preferences dict, then get floor from it."
      },
      {
        "operation": "\"vip\" in guest",
        "question": "What is returned?",
        "options": ["True", "False", "\"vip\"", "Error"],
        "correct": 0,
        "explanation": "''in'' checks if key exists. \"vip\" is a key, so True."
      },
      {
        "operation": "len(guest)",
        "question": "What is returned?",
        "options": ["4", "5", "6", "Error"],
        "correct": 0,
        "explanation": "guest has 4 top-level keys: name, room, vip, preferences."
      }
    ],
    "scoring": {
      "correct": 10,
      "incorrect": 0,
      "passing_score": 60
    }
  }'::jsonb,
  'dict-visualizer',
  false,
  true
),

-- ============================================
-- MODULE 10: Dictionary Method Matcher
-- ============================================
(
  'e0000000-0000-0000-0010-000000000097',
  'd0000000-0000-0000-0000-000000000010',
  '10.97',
  97,
  'Dictionary Method Matcher',
  'dict-method-matcher',
  'interactive',
  8,
  35,
  'basic',
  '{
    "instructions": "Match each dictionary method with what it returns!",
    "type": "drag-drop-match",
    "setup": "d = {\"a\": 1, \"b\": 2, \"c\": 3}",
    "pairs": [
      {"left": "d.keys()", "right": "dict_keys([''a'', ''b'', ''c''])", "explanation": "Returns a view of all keys."},
      {"left": "d.values()", "right": "dict_values([1, 2, 3])", "explanation": "Returns a view of all values."},
      {"left": "d.items()", "right": "dict_items([(''a'', 1), ...])", "explanation": "Returns key-value pairs as tuples."},
      {"left": "d.get(\"x\", 0)", "right": "0", "explanation": "Key \"x\" doesn''t exist, returns default 0."},
      {"left": "d.pop(\"b\")", "right": "2", "explanation": "Removes \"b\" and returns its value (2)."},
      {"left": "len(d)", "right": "3", "explanation": "Returns count of key-value pairs."}
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
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;

