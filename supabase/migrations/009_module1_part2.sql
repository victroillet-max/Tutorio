-- ============================================
-- Module 1: Activities Part 2
-- Interactive exercises and expanded checkpoint
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 1.5: Pillar Matching Game (Interactive)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000005',
  'd0000000-0000-0000-0000-000000000001',
  '1.5',
  5,
  'Pillar Matching Challenge',
  'pillar-matching-game',
  'interactive',
  8,
  35,
  'basic',
  '{
    "instructions": "Match each real-world scenario with the correct computational thinking pillar. Drag and drop to make your matches!",
    "type": "drag-drop-match",
    "pairs": [
      {"left": "Breaking a wedding plan into catering, decorations, and music", "right": "Decomposition", "explanation": "This is decomposition because you are breaking a large task into smaller, manageable parts."},
      {"left": "Noticing that all prime numbers greater than 2 are odd", "right": "Pattern Recognition", "explanation": "This is pattern recognition because you are identifying a consistent rule across multiple examples."},
      {"left": "A subway map showing connections but not real distances", "right": "Abstraction", "explanation": "This is abstraction because the map focuses on essential info (connections) while hiding details (distances)."},
      {"left": "A step-by-step recipe for making pancakes", "right": "Algorithm", "explanation": "This is an algorithm because it provides sequential instructions to achieve a specific result."},
      {"left": "Dividing a hotel into departments: front desk, housekeeping, F&B", "right": "Decomposition", "explanation": "Breaking an organization into departments is decomposition - dividing into smaller parts."},
      {"left": "Realizing that weekend guests usually request late checkout", "right": "Pattern Recognition", "explanation": "Identifying this recurring guest behavior is pattern recognition."},
      {"left": "A fire escape route that shows exits but not room furniture", "right": "Abstraction", "explanation": "The escape route abstracts away unnecessary details to focus on what matters: getting out safely."},
      {"left": "The exact procedure for processing a refund", "right": "Algorithm", "explanation": "A defined step-by-step procedure is an algorithm."}
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
-- Activity 1.6: CT in Daily Life (Video placeholder)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000006',
  'd0000000-0000-0000-0000-000000000001',
  '1.6',
  6,
  'CT in Your Daily Life',
  'ct-daily-life-video',
  'video',
  10,
  25,
  'advanced',
  '{
    "videoPlaceholder": true,
    "title": "Computational Thinking in Your Daily Life",
    "duration": "8-10 minutes",
    "description": "See how you already use computational thinking every day without realizing it!",
    "outline": [
      "0:00 - Introduction: You are already a computational thinker",
      "1:00 - Morning routine decomposition example",
      "2:30 - Pattern recognition: Your commute optimization",
      "4:00 - Abstraction: How you read maps and schedules",
      "5:30 - Algorithms: Following and creating recipes",
      "7:00 - Hospitality industry examples",
      "8:30 - Wrap-up and key takeaways"
    ],
    "keyPoints": [
      "You use CT every day without knowing it",
      "The four pillars appear in cooking, travel, shopping, and work",
      "CT becomes more powerful when used consciously"
    ],
    "transcript": "COMING SOON - This video will demonstrate real-world applications of computational thinking."
  }'::jsonb,
  'video-player',
  false,
  true
),

-- ============================================
-- Activity 1.7: Plan Your Event (Interactive Decomposition)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000007',
  'd0000000-0000-0000-0000-000000000001',
  '1.7',
  7,
  'Plan Your Event: Decomposition Practice',
  'plan-your-event',
  'interactive',
  12,
  40,
  'basic',
  '{
    "instructions": "You have been asked to organize a corporate retreat for 50 employees at a mountain resort. Use decomposition to break this complex task into smaller, manageable parts.\n\nBuild a decomposition tree by adding branches to each main category.",
    "type": "decomposition-builder",
    "rootTask": "Corporate Retreat for 50 Employees",
    "expectedBranches": {
      "Transportation": ["Book vehicles", "Plan pickup schedule", "Arrange parking", "Consider accessibility"],
      "Accommodation": ["Reserve rooms", "Room assignments", "Special requests", "Check-in process"],
      "Activities": ["Team building exercises", "Free time options", "Evening entertainment", "Awards ceremony"],
      "Catering": ["Breakfast", "Lunch", "Dinner", "Snacks & beverages", "Dietary requirements"],
      "Logistics": ["Budget tracking", "Emergency contacts", "Weather backup plans", "Equipment needs"]
    },
    "hints": [
      "Think about what happens before, during, and after the retreat",
      "Consider different stakeholder needs (executives, new employees, etc.)",
      "Don''t forget about potential problems that might arise"
    ],
    "scoring": {
      "minBranches": 4,
      "minSubBranches": 12,
      "bonusForCreativity": true
    }
  }'::jsonb,
  'decomposition-builder',
  false,
  true
),

-- ============================================
-- Activity 1.8: Four Pillars Applied Quiz (12 questions)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000008',
  'd0000000-0000-0000-0000-000000000001',
  '1.8',
  8,
  'Four Pillars Applied Quiz',
  'four-pillars-quiz',
  'quiz',
  12,
  35,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which pillar involves breaking a problem into smaller parts?",
        "options": ["Abstraction", "Decomposition", "Algorithm", "Pattern Recognition"],
        "correct": 1,
        "explanation": "DECOMPOSITION is the pillar that involves breaking a complex problem into smaller, more manageable parts."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Ignoring irrelevant details to focus on what matters is called:",
        "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
        "correct": 2,
        "explanation": "ABSTRACTION is about focusing on essential information while hiding or ignoring irrelevant details."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A step-by-step solution to a problem is called:",
        "options": ["Pattern", "Decomposition", "Abstraction", "Algorithm"],
        "correct": 3,
        "explanation": "An ALGORITHM is a step-by-step procedure or set of instructions designed to solve a problem or accomplish a task."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Pattern recognition helps us find similarities between problems.",
        "correct": true,
        "explanation": "TRUE. Pattern recognition is specifically about finding similarities, trends, and regularities across different problems or data sets."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which is the BEST example of decomposition?",
        "options": [
          "Noticing all squares have 4 sides",
          "Breaking essay writing into outline, draft, and edit",
          "Creating a simplified map",
          "Following a recipe step by step"
        ],
        "correct": 1,
        "explanation": "Breaking essay writing into phases (outline, draft, edit) is DECOMPOSITION - dividing a complex task into smaller parts. Option A is pattern recognition, C is abstraction, D is following an algorithm."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel notices that guests who order breakfast are 60% more likely to leave positive reviews. This insight is an example of:",
        "options": [
          "Decomposition",
          "Pattern Recognition",
          "Abstraction",
          "Algorithm"
        ],
        "correct": 1,
        "explanation": "This is PATTERN RECOGNITION - identifying a correlation (breakfast orders  positive reviews) from data analysis."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "When a GPS shows you the fastest route without explaining traffic light timing and road conditions, it is using:",
        "options": [
          "Decomposition",
          "Pattern Recognition",
          "Abstraction",
          "Algorithm"
        ],
        "correct": 2,
        "explanation": "This is ABSTRACTION - the GPS hides complex details (traffic light timing, road conditions) and shows only what you need (the route)."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The specific steps a barista follows to make a latte (grind beans, extract espresso, steam milk, combine) is an example of:",
        "options": [
          "Decomposition",
          "Pattern Recognition",
          "Abstraction",
          "Algorithm"
        ],
        "correct": 3,
        "explanation": "This is an ALGORITHM - a specific sequence of steps that must be followed in order to produce a desired result."
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A restaurant manager wants to reduce customer wait times. She breaks the dining experience into: arrival, seating, ordering, food prep, serving, and payment. She notices that food prep is slowest on Fridays. She focuses only on kitchen efficiency (ignoring decor and music). She creates a new workflow: prep popular items in advance on Fridays.\n\nWhich pillars did she use and in what order?",
        "options": [
          "Decomposition  Pattern Recognition  Abstraction  Algorithm",
          "Pattern Recognition  Decomposition  Algorithm  Abstraction",
          "Abstraction  Algorithm  Pattern Recognition  Decomposition",
          "Algorithm  Abstraction  Decomposition  Pattern Recognition"
        ],
        "correct": 0,
        "explanation": "She used: DECOMPOSITION (breaking dining into phases), PATTERN RECOGNITION (Friday is slowest), ABSTRACTION (focusing only on kitchen), and ALGORITHM (the prep-in-advance workflow)."
      },
      {
        "id": "q10",
        "type": "true_false",
        "difficulty": "exam",
        "question": "The four pillars of computational thinking must always be applied in the order: Decomposition, Pattern Recognition, Abstraction, Algorithm.",
        "correct": false,
        "explanation": "FALSE. The pillars can be used in any order and often overlap. You might start with pattern recognition, then decompose, then abstract. The process is flexible and iterative."
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel chain is designing a new booking system. They break the project into frontend, backend, and database (decomposition). They notice that all their hotels have similar booking flows (pattern). They focus on core features first, ignoring advanced features (abstraction). They define the exact steps for processing a booking (algorithm). Which statement is TRUE?",
        "options": [
          "They only used three pillars",
          "Pattern recognition was unnecessary",
          "They used all four pillars effectively",
          "Abstraction should have come first"
        ],
        "correct": 2,
        "explanation": "They used ALL FOUR PILLARS effectively: decomposition (breaking into parts), pattern recognition (similar flows), abstraction (focusing on core features), and algorithm (booking steps)."
      },
      {
        "id": "q12",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which of the following would be the WORST use of abstraction?",
        "options": [
          "A fire evacuation map that shows only exits and routes",
          "A budget summary that shows totals instead of every transaction",
          "A medical diagnosis that ignores the patient''s symptoms",
          "A subway map that shows connections without exact distances"
        ],
        "correct": 2,
        "explanation": "Option C is the WORST use of abstraction because symptoms are ESSENTIAL information for diagnosis. Good abstraction removes irrelevant details, not essential ones."
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
-- Activity 1.9: Identify the Pillar (Interactive Game)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000009',
  'd0000000-0000-0000-0000-000000000001',
  '1.9',
  9,
  'Identify the Pillar Game',
  'identify-pillar-game',
  'interactive',
  10,
  35,
  'basic',
  '{
    "instructions": "Read each scenario and quickly identify which CT pillar is being demonstrated. You have 15 seconds per question!",
    "type": "timed-classification",
    "timePerQuestion": 15,
    "scenarios": [
      {
        "scenario": "A chef divides making a 5-course meal into: appetizers, soup, main course, dessert, and coffee service.",
        "correctPillar": "Decomposition",
        "explanation": "Breaking the meal into 5 distinct courses is decomposition."
      },
      {
        "scenario": "A data analyst notices that sales always spike 3 days after a marketing email is sent.",
        "correctPillar": "Pattern Recognition",
        "explanation": "Identifying the 3-day sales spike pattern is pattern recognition."
      },
      {
        "scenario": "A flight booking website shows only departure time, price, and airline - not fuel consumption or crew names.",
        "correctPillar": "Abstraction",
        "explanation": "Hiding irrelevant details (fuel, crew) while showing essentials (time, price) is abstraction."
      },
      {
        "scenario": "A Standard Operating Procedure document explains exactly how to clean and prepare a hotel room.",
        "correctPillar": "Algorithm",
        "explanation": "Step-by-step procedures are algorithms."
      },
      {
        "scenario": "Breaking customer support into: receive call, identify issue, research solution, respond, follow up.",
        "correctPillar": "Decomposition",
        "explanation": "Dividing the support process into phases is decomposition."
      },
      {
        "scenario": "A coffee shop realizes most customers who order pastries also order coffee, and creates a combo deal.",
        "correctPillar": "Pattern Recognition",
        "explanation": "Identifying the pastry-coffee purchasing pattern is pattern recognition."
      },
      {
        "scenario": "A hotel loyalty program shows members only their points balance and tier, not the complex calculation behind it.",
        "correctPillar": "Abstraction",
        "explanation": "Hiding the calculation complexity is abstraction."
      },
      {
        "scenario": "The exact sequence a concierge follows when booking a restaurant reservation for a guest.",
        "correctPillar": "Algorithm",
        "explanation": "A defined sequence of steps is an algorithm."
      }
    ],
    "scoring": {
      "correct": 15,
      "incorrect": 0,
      "timeBonus": 5
    }
  }'::jsonb,
  'timed-classification',
  false,
  true
),

-- ============================================
-- Activity 1.10: Module 1 Checkpoint (Expanded to 10 questions)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000010',
  'd0000000-0000-0000-0000-000000000001',
  '1.10',
  10,
  'Module 1 Checkpoint',
  'module-1-checkpoint',
  'checkpoint',
  15,
  50,
  'free',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is computational thinking?",
        "options": [
          "A type of computer programming language",
          "A problem-solving approach using computer science concepts",
          "A way to think like a computer",
          "A method for building computers"
        ],
        "correct": 1,
        "explanation": "Computational thinking is a PROBLEM-SOLVING APPROACH that uses concepts from computer science. It''s about solving problems systematically, not about programming or building hardware."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which pillar involves breaking a problem into smaller parts?",
        "options": ["Abstraction", "Decomposition", "Algorithm", "Pattern Recognition"],
        "correct": 1,
        "explanation": "DECOMPOSITION is the pillar focused on breaking complex problems into smaller, manageable pieces."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Finding similarities between different problems is called:",
        "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
        "correct": 1,
        "explanation": "PATTERN RECOGNITION is about finding similarities, trends, and regularities across different problems or data."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Abstraction means including as many details as possible.",
        "correct": false,
        "explanation": "FALSE. Abstraction means HIDING unnecessary details and focusing only on what''s essential. It''s the opposite of including all details."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A restaurant creates a checklist for closing procedures: clean tables, count cash, lock doors, set alarm. This is an example of:",
        "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
        "correct": 3,
        "explanation": "A step-by-step checklist of procedures is an ALGORITHM - a defined sequence of actions to complete a task."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel manager notices that complaints are highest on Mondays and creates extra training for Monday staff. This uses:",
        "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
        "correct": 1,
        "explanation": "Identifying the Monday complaint pattern is PATTERN RECOGNITION - noticing a trend and acting on it."
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "When creating a floor plan for guests, an architect shows only room locations and not the electrical wiring behind walls. This is:",
        "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
        "correct": 2,
        "explanation": "Hiding technical details (wiring) to focus on relevant information (room locations) is ABSTRACTION."
      },
      {
        "id": "cp8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A company breaks a product launch into: marketing, manufacturing, distribution, and support. Each team notices that product launches follow similar 6-week cycles. They create streamlined processes focusing on key milestones. Finally, they document the exact steps for each department.\n\nIn which order were the CT pillars applied?",
        "options": [
          "Decomposition  Pattern Recognition  Abstraction  Algorithm",
          "Pattern Recognition  Abstraction  Algorithm  Decomposition",
          "Abstraction  Decomposition  Pattern Recognition  Algorithm",
          "Algorithm  Pattern Recognition  Decomposition  Abstraction"
        ],
        "correct": 0,
        "explanation": "The order was: DECOMPOSITION (breaking into departments), PATTERN RECOGNITION (6-week cycles), ABSTRACTION (key milestones only), ALGORITHM (documented steps)."
      },
      {
        "id": "cp9",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Computational thinking is only useful for people who work in technology or computer science.",
        "correct": false,
        "explanation": "FALSE. Computational thinking is useful in EVERY field: medicine, law, business, hospitality, arts, and everyday life. It''s a universal problem-solving approach."
      },
      {
        "id": "cp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which combination of pillars would be MOST useful for a hotel trying to reduce energy costs?",
        "options": [
          "Only use algorithms to create energy-saving procedures",
          "Only use abstraction to ignore the problem",
          "Use decomposition to break down energy usage by area, pattern recognition to find high-usage times, abstraction to focus on biggest costs, and algorithms to create automated controls",
          "Only use pattern recognition to notice when energy is used"
        ],
        "correct": 2,
        "explanation": "Complex problems like energy reduction benefit from using ALL FOUR PILLARS together. Decomposition identifies areas, patterns reveal when energy is wasted, abstraction prioritizes big costs, and algorithms automate solutions."
      }
    ],
    "passing_score": 70,
    "show_explanations": true,
    "blocks_progress": true
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- Activity 1.11: Coding Challenge - CT Planning (First Challenge)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000011',
  'd0000000-0000-0000-0000-000000000001',
  '1.11',
  11,
  'Challenge: Plan Before You Code',
  'ct-planning-challenge',
  'challenge',
  15,
  50,
  'basic',
  '{
    "type": "planning-challenge",
    "title": "CT Planning Challenge",
    "instructions": "Before writing any code, good programmers use computational thinking to plan their solution.\n\nYour Task: You need to create a simple hotel check-in program. Before coding (which we''ll do later!), apply CT principles.\n\n1. DECOMPOSE: What are the main steps of hotel check-in?\n2. PATTERNS: What information is always needed? What''s optional?\n3. ABSTRACTION: What details can we ignore for a basic check-in?\n4. ALGORITHM: Write the steps in plain English (pseudocode).\n\nSubmit your planning document below.",
    "templateText": "# Hotel Check-In Planning Document\n\n## 1. DECOMPOSITION\nBreak the check-in process into smaller steps:\n- Step 1: \n- Step 2: \n- Step 3: \n- Step 4: \n- Step 5: \n\n## 2. PATTERN RECOGNITION\nWhat information is ALWAYS needed?\n- \n- \n- \n\nWhat information is SOMETIMES needed?\n- \n- \n\n## 3. ABSTRACTION\nWhat details can we IGNORE for a basic check-in system?\n- \n- \n- \n\n## 4. ALGORITHM (Pseudocode)\nWrite the steps in plain English:\n\n1. START\n2. \n3. \n4. \n5. END",
    "rubric": [
      {"criterion": "Decomposition has at least 5 clear steps", "points": 15},
      {"criterion": "Pattern section identifies required vs optional info", "points": 15},
      {"criterion": "Abstraction correctly identifies ignorable details", "points": 10},
      {"criterion": "Algorithm is sequential and logical", "points": 10}
    ],
    "hints": [
      "Think about what happens when YOU check into a hotel",
      "Consider: greeting, identification, payment, room assignment, key cards",
      "What if the room isn''t ready? Include a decision point!"
    ]
  }'::jsonb,
  'planning-challenge',
  false,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;
