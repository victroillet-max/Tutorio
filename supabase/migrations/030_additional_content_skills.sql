-- ============================================
-- Additional Content Skill Tags & Quiz Questions
-- Tags new challenges with skills and adds Module 13-14 quiz questions
-- ============================================

-- ============================================
-- Skill Tags for New Challenges (from 024_new_challenges.sql)
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches, weight) VALUES
-- Module 5 Challenge: Guest Calculator
('e0000000-0000-0000-0005-000000000099', 'a0000000-0000-0000-0002-000000000003', true, false, 0.9),   -- Variables
('e0000000-0000-0000-0005-000000000099', 'a0000000-0000-0000-0002-000000000004', true, false, 0.8),   -- Data Types
('e0000000-0000-0000-0005-000000000099', 'a0000000-0000-0000-0002-000000000005', true, false, 0.8),   -- Operators
('e0000000-0000-0000-0005-000000000099', 'a0000000-0000-0000-0002-000000000008', true, false, 0.7),   -- F-Strings

-- Module 6 Challenge: Room Upgrade Decider
('e0000000-0000-0000-0006-000000000099', 'a0000000-0000-0000-0003-000000000001', true, false, 0.8),   -- Boolean Logic
('e0000000-0000-0000-0006-000000000099', 'a0000000-0000-0000-0003-000000000002', true, false, 0.9),   -- Conditionals

-- Module 7 Challenge: Occupancy Analyzer
('e0000000-0000-0000-0007-000000000099', 'a0000000-0000-0000-0003-000000000003', true, false, 0.8),   -- While Loops
('e0000000-0000-0000-0007-000000000099', 'a0000000-0000-0000-0003-000000000004', true, false, 0.9),   -- For Loops
('e0000000-0000-0000-0007-000000000099', 'a0000000-0000-0000-0004-000000000001', true, false, 0.6),   -- Lists Basics

-- Module 8 Challenge: Reservation Manager  
('e0000000-0000-0000-0008-000000000099', 'a0000000-0000-0000-0004-000000000001', true, false, 0.9),   -- Lists Basics
('e0000000-0000-0000-0008-000000000099', 'a0000000-0000-0000-0004-000000000002', true, false, 0.9),   -- List Methods
('e0000000-0000-0000-0008-000000000099', 'a0000000-0000-0000-0005-000000000001', true, false, 0.6),   -- Defining Functions

-- Module 9 Challenge: Guest Database
('e0000000-0000-0000-0009-000000000099', 'a0000000-0000-0000-0004-000000000005', true, false, 0.9),   -- Dictionaries
('e0000000-0000-0000-0009-000000000099', 'a0000000-0000-0000-0004-000000000006', true, false, 0.7),   -- Nested Structures

-- Module 10 Challenge: Booking Analytics
('e0000000-0000-0000-0010-000000000099', 'a0000000-0000-0000-0004-000000000005', true, false, 0.9),   -- Dictionaries
('e0000000-0000-0000-0010-000000000099', 'a0000000-0000-0000-0004-000000000004', true, false, 0.7),   -- List Comprehensions
('e0000000-0000-0000-0010-000000000099', 'a0000000-0000-0000-0005-000000000001', true, false, 0.6),   -- Functions

-- Module 11 Challenge: Billing System
('e0000000-0000-0000-0011-000000000099', 'a0000000-0000-0000-0005-000000000001', true, false, 0.9),   -- Defining Functions
('e0000000-0000-0000-0011-000000000099', 'a0000000-0000-0000-0005-000000000002', true, false, 0.9),   -- Parameters
('e0000000-0000-0000-0011-000000000099', 'a0000000-0000-0000-0005-000000000003', true, false, 0.9),   -- Return Values

-- Module 12 Challenge: Error Logger
('e0000000-0000-0000-0012-000000000099', 'a0000000-0000-0000-0006-000000000001', true, false, 0.9),   -- File Handling
('e0000000-0000-0000-0012-000000000099', 'a0000000-0000-0000-0006-000000000002', true, false, 0.9);   -- Exception Handling

-- ============================================
-- Module 13 Expanded Quiz Questions
-- Add 7+ new questions tagged with skills
-- ============================================

-- Get the Module 13 checkpoint activity and update it with more questions
UPDATE activities 
SET content = '{
  "questions": [
    {
      "id": "q1",
      "type": "mcq",
      "difficulty": "basic",
      "question": "Which statement correctly imports the sqrt function from the math library?",
      "options": [
        "import sqrt from math",
        "from math import sqrt",
        "math.import(sqrt)",
        "include math.sqrt"
      ],
      "correct": 1,
      "explanation": "The correct syntax is ''from math import sqrt''. This allows you to use sqrt() directly without the math. prefix."
    },
    {
      "id": "q2",
      "type": "mcq",
      "difficulty": "basic",
      "question": "What does random.randint(1, 10) return?",
      "options": [
        "A random float between 1 and 10",
        "A random integer between 1 and 9",
        "A random integer between 1 and 10 (inclusive)",
        "Always returns 10"
      ],
      "correct": 2,
      "explanation": "random.randint(a, b) returns a random integer N such that a <= N <= b. Both endpoints are INCLUDED."
    },
    {
      "id": "q3",
      "type": "true_false",
      "difficulty": "basic",
      "question": "import math as m allows you to use m.sqrt(16) instead of math.sqrt(16).",
      "correct": true,
      "explanation": "TRUE. Using ''as'' creates an alias, so you can use the shorter name ''m'' to access all math functions."
    },
    {
      "id": "q4",
      "type": "mcq",
      "difficulty": "applied",
      "question": "You need to round 4.7 UP to the nearest integer. Which function should you use?",
      "options": [
        "round(4.7)",
        "math.floor(4.7)",
        "math.ceil(4.7)",
        "int(4.7)"
      ],
      "correct": 2,
      "explanation": "math.ceil() always rounds UP. round() uses banker''s rounding, floor() rounds DOWN, and int() truncates toward zero."
    },
    {
      "id": "q5",
      "type": "mcq",
      "difficulty": "applied",
      "question": "What is the difference between random.choice() and random.sample()?",
      "options": [
        "choice() returns a list, sample() returns a single item",
        "choice() picks one item, sample() picks multiple without replacement",
        "They are exactly the same",
        "sample() only works with numbers"
      ],
      "correct": 1,
      "explanation": "random.choice(list) picks one random item. random.sample(list, k) picks k items without replacement (each item picked only once)."
    },
    {
      "id": "q6",
      "type": "mcq",
      "difficulty": "applied",
      "question": "How do you get today''s date using the datetime library?",
      "options": [
        "datetime.now()",
        "date.today()",
        "datetime.today.date()",
        "Both A and B return today''s date"
      ],
      "correct": 3,
      "explanation": "datetime.now() returns current date AND time, date.today() returns just the date. Both can give you today''s date, but in different formats."
    },
    {
      "id": "q7",
      "type": "mcq",
      "difficulty": "applied",
      "question": "Which code correctly calculates the check-out date (5 days after check-in)?",
      "options": [
        "check_out = check_in + 5",
        "check_out = check_in + timedelta(days=5)",
        "check_out = check_in.add_days(5)",
        "check_out = date.add(check_in, 5)"
      ],
      "correct": 1,
      "explanation": "timedelta is used for date arithmetic. You must import it from datetime and use timedelta(days=5) to add 5 days."
    },
    {
      "id": "q8",
      "type": "mcq",
      "difficulty": "advanced",
      "question": "What does random.shuffle(my_list) return?",
      "options": [
        "A new shuffled list",
        "The same list, now shuffled",
        "None (it shuffles in place)",
        "The number of elements shuffled"
      ],
      "correct": 2,
      "explanation": "shuffle() modifies the list IN PLACE and returns None. A common mistake is writing ''shuffled = random.shuffle(list)'' which sets shuffled to None!"
    },
    {
      "id": "q9",
      "type": "mcq",
      "difficulty": "advanced",
      "question": "What is the purpose of random.seed()?",
      "options": [
        "To generate a random number",
        "To reset the random number generator",
        "To make random results reproducible",
        "To import the random library"
      ],
      "correct": 2,
      "explanation": "Setting a seed makes the sequence of random numbers predictable. This is useful for testing and debugging."
    },
    {
      "id": "q10",
      "type": "mcq",
      "difficulty": "advanced",
      "question": "How do you format a datetime object as ''March 15, 2024''?",
      "options": [
        "date.format(''%B %d, %Y'')",
        "date.strftime(''%B %d, %Y'')",
        "str(date, ''%B %d, %Y'')",
        "format(date, ''month day, year'')"
      ],
      "correct": 1,
      "explanation": "strftime() (string format time) converts a datetime to a string using format codes. %B is full month name, %d is day, %Y is 4-digit year."
    }
  ],
  "passing_score": 70,
  "shuffle_questions": true,
  "shuffle_options": true
}'::jsonb
WHERE id = 'e0000000-0000-0000-0013-000000000007';

-- ============================================
-- Module 14 Expanded Quiz Questions
-- Add 7+ new questions tagged with skills
-- ============================================

UPDATE activities 
SET content = '{
  "questions": [
    {
      "id": "q1",
      "type": "mcq",
      "difficulty": "basic",
      "question": "Which module is used to read and write CSV files in Python?",
      "options": [
        "csv",
        "pandas",
        "excel",
        "spreadsheet"
      ],
      "correct": 0,
      "explanation": "The csv module is built into Python and provides functions to read and write CSV files."
    },
    {
      "id": "q2",
      "type": "mcq",
      "difficulty": "basic",
      "question": "What does csv.reader() return?",
      "options": [
        "A list of all rows",
        "An iterator that yields rows as lists",
        "A single string",
        "A dictionary"
      ],
      "correct": 1,
      "explanation": "csv.reader() returns an iterator. You typically loop over it or convert it to a list with list()."
    },
    {
      "id": "q3",
      "type": "true_false",
      "difficulty": "basic",
      "question": "When opening a CSV file for writing, you should use mode ''wb'' (write binary).",
      "correct": false,
      "explanation": "FALSE. Use ''w'' for writing text files. In Python 3, you should also add newline='''' parameter: open(''file.csv'', ''w'', newline='''')"
    },
    {
      "id": "q4",
      "type": "mcq",
      "difficulty": "applied",
      "question": "How do you sort a list of dictionaries by the ''price'' key?",
      "options": [
        "data.sort(''price'')",
        "sorted(data, key=lambda x: x[''price''])",
        "data.sortby(''price'')",
        "sort(data, ''price'')"
      ],
      "correct": 1,
      "explanation": "Use sorted() with a key function. The lambda x: x[''price''] extracts the price value for comparison."
    },
    {
      "id": "q5",
      "type": "mcq",
      "difficulty": "applied",
      "question": "What is the list comprehension to filter guests with bookings > 3?",
      "options": [
        "[g for g in guests if g.bookings > 3]",
        "[g for g in guests where g[''bookings''] > 3]",
        "[g if g[''bookings''] > 3 for g in guests]",
        "[g for g in guests if g[''bookings''] > 3]"
      ],
      "correct": 3,
      "explanation": "The correct syntax is [expression for item in iterable if condition]. The condition comes at the END."
    },
    {
      "id": "q6",
      "type": "mcq",
      "difficulty": "applied",
      "question": "Given data = [100, 200, 150, 300], which calculates the average?",
      "options": [
        "avg(data)",
        "sum(data) / len(data)",
        "data.average()",
        "mean(data)"
      ],
      "correct": 1,
      "explanation": "Python has no built-in avg() function. Use sum(data) / len(data). For advanced statistics, use the statistics module."
    },
    {
      "id": "q7",
      "type": "mcq",
      "difficulty": "applied",
      "question": "How do you count occurrences of each room type in a list?",
      "options": [
        "list.count_all()",
        "Counter(room_types)",
        "room_types.unique_count()",
        "count(room_types)"
      ],
      "correct": 1,
      "explanation": "Use Counter from the collections module: from collections import Counter; counts = Counter(room_types)"
    },
    {
      "id": "q8",
      "type": "mcq",
      "difficulty": "advanced",
      "question": "What does csv.DictReader() do differently from csv.reader()?",
      "options": [
        "It reads the file faster",
        "It returns rows as dictionaries using the header row as keys",
        "It writes instead of reads",
        "It only reads numeric data"
      ],
      "correct": 1,
      "explanation": "DictReader uses the first row as dictionary keys, making it easier to access columns by name like row[''guest_name'']."
    },
    {
      "id": "q9",
      "type": "mcq",
      "difficulty": "advanced",
      "question": "To find the maximum revenue month from monthly_revenue = {''Jan'': 50000, ''Feb'': 62000, ...}, use:",
      "options": [
        "max(monthly_revenue)",
        "monthly_revenue.max()",
        "max(monthly_revenue, key=monthly_revenue.get)",
        "max(monthly_revenue.values())"
      ],
      "correct": 2,
      "explanation": "max(dict) returns the max key. Use key=dict.get to find the key with the maximum value."
    },
    {
      "id": "q10",
      "type": "mcq",
      "difficulty": "advanced",
      "question": "Which approach efficiently groups bookings by month?",
      "options": [
        "Use a loop with if statements for each month",
        "Use a dictionary with months as keys and lists as values",
        "Create 12 separate lists",
        "Use the groupby module"
      ],
      "correct": 1,
      "explanation": "A dictionary with lists is efficient: groups = {}; for booking in bookings: groups.setdefault(booking[''month''], []).append(booking)"
    }
  ],
  "passing_score": 70,
  "shuffle_questions": true,
  "shuffle_options": true
}'::jsonb
WHERE id = 'e0000000-0000-0000-0014-000000000007';

-- ============================================
-- Question Skill Tags for Module 13 Quiz
-- ============================================

INSERT INTO question_skills (activity_id, question_id, skill_id, weight) VALUES
-- Module 13 Checkpoint Questions
('e0000000-0000-0000-0013-000000000007', 'q1', 'a0000000-0000-0000-0006-000000000003', 1.0),  -- Libraries
('e0000000-0000-0000-0013-000000000007', 'q2', 'a0000000-0000-0000-0006-000000000005', 1.0),  -- Random Library
('e0000000-0000-0000-0013-000000000007', 'q3', 'a0000000-0000-0000-0006-000000000003', 1.0),  -- Libraries
('e0000000-0000-0000-0013-000000000007', 'q4', 'a0000000-0000-0000-0006-000000000004', 1.0),  -- Math Library
('e0000000-0000-0000-0013-000000000007', 'q5', 'a0000000-0000-0000-0006-000000000005', 1.0),  -- Random Library
('e0000000-0000-0000-0013-000000000007', 'q6', 'a0000000-0000-0000-0006-000000000003', 1.0),  -- Libraries (datetime)
('e0000000-0000-0000-0013-000000000007', 'q7', 'a0000000-0000-0000-0006-000000000003', 1.0),  -- Libraries (datetime)
('e0000000-0000-0000-0013-000000000007', 'q8', 'a0000000-0000-0000-0006-000000000005', 1.0),  -- Random Library
('e0000000-0000-0000-0013-000000000007', 'q9', 'a0000000-0000-0000-0006-000000000005', 1.0),  -- Random Library
('e0000000-0000-0000-0013-000000000007', 'q10', 'a0000000-0000-0000-0006-000000000003', 1.0); -- Libraries (datetime)

-- ============================================
-- Question Skill Tags for Module 14 Quiz
-- ============================================

INSERT INTO question_skills (activity_id, question_id, skill_id, weight) VALUES
-- Module 14 Checkpoint Questions
('e0000000-0000-0000-0014-000000000007', 'q1', 'a0000000-0000-0000-0006-000000000006', 1.0),  -- Data Analysis
('e0000000-0000-0000-0014-000000000007', 'q2', 'a0000000-0000-0000-0006-000000000006', 1.0),  -- Data Analysis
('e0000000-0000-0000-0014-000000000007', 'q3', 'a0000000-0000-0000-0006-000000000001', 1.0),  -- File Handling
('e0000000-0000-0000-0014-000000000007', 'q4', 'a0000000-0000-0000-0006-000000000006', 1.0),  -- Data Analysis
('e0000000-0000-0000-0014-000000000007', 'q5', 'a0000000-0000-0000-0004-000000000004', 1.0),  -- List Comprehensions
('e0000000-0000-0000-0014-000000000007', 'q6', 'a0000000-0000-0000-0006-000000000006', 1.0),  -- Data Analysis
('e0000000-0000-0000-0014-000000000007', 'q7', 'a0000000-0000-0000-0006-000000000006', 1.0),  -- Data Analysis
('e0000000-0000-0000-0014-000000000007', 'q8', 'a0000000-0000-0000-0006-000000000006', 1.0),  -- Data Analysis
('e0000000-0000-0000-0014-000000000007', 'q9', 'a0000000-0000-0000-0004-000000000005', 1.0),  -- Dictionaries
('e0000000-0000-0000-0014-000000000007', 'q10', 'a0000000-0000-0000-0004-000000000005', 1.0); -- Dictionaries

-- ============================================
-- Skill Tags for New Interactive Activities (from 025_new_interactives.sql)
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, is_primary, teaches, weight) 
SELECT 
  a.id,
  CASE 
    WHEN a.title ILIKE '%variable%' THEN 'a0000000-0000-0000-0002-000000000003'::uuid
    WHEN a.title ILIKE '%type%' THEN 'a0000000-0000-0000-0002-000000000004'::uuid
    WHEN a.title ILIKE '%loop%' THEN 'a0000000-0000-0000-0003-000000000004'::uuid
    WHEN a.title ILIKE '%condition%' THEN 'a0000000-0000-0000-0003-000000000002'::uuid
    WHEN a.title ILIKE '%list%' THEN 'a0000000-0000-0000-0004-000000000001'::uuid
    WHEN a.title ILIKE '%dict%' THEN 'a0000000-0000-0000-0004-000000000005'::uuid
    WHEN a.title ILIKE '%function%' THEN 'a0000000-0000-0000-0005-000000000001'::uuid
    WHEN a.title ILIKE '%file%' THEN 'a0000000-0000-0000-0006-000000000001'::uuid
    WHEN a.title ILIKE '%error%' OR a.title ILIKE '%exception%' THEN 'a0000000-0000-0000-0006-000000000002'::uuid
    ELSE 'a0000000-0000-0000-0001-000000000001'::uuid -- Default to Problem Solving
  END,
  true,
  false,
  0.7
FROM activities a
WHERE a.type = 'interactive'
  AND NOT EXISTS (
    SELECT 1 FROM activity_skills asks 
    WHERE asks.activity_id = a.id
  )
ON CONFLICT (activity_id, skill_id) DO NOTHING;

