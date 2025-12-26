-- ============================================
-- Module 1: Introduction to Computational Thinking
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 1.1: Welcome to CT (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000001',
  'd0000000-0000-0000-0000-000000000001',
  '1.1',
  1,
  'Welcome to Computational Thinking',
  'welcome-to-ct',
  'lesson',
  12,
  20,
  'free',
  '{"markdown": "# Welcome to Computational Thinking\n\n##  Why This Matters\n\nImagine you''re the general manager of a luxury hotel. A guest complains that their room wasn''t ready on time, breakfast was cold, and the spa appointment was double-booked. How do you solve all these problems efficiently?\n\nThis is exactly what computational thinking teaches you: **a systematic way to break down complex problems into manageable pieces and solve them effectively.**\n\n> \"Computational thinking is a fundamental skill for everyone, not just for computer scientists.\"  Jeannette M. Wing, Columbia University\n\n---\n\n##  What is Computational Thinking?\n\nComputational thinking (CT) is **a problem-solving approach** that uses concepts from computer science to tackle challenges in any field. It''s not about thinking like a computerit''s about thinking in a way that even a computer could follow.\n\n### The Core Idea\n\nThink of CT as a **mental toolkit**. Just like a chef has knives, pans, and techniques, computational thinkers have strategies for:\n- Breaking problems apart\n- Finding patterns\n- Focusing on what matters\n- Creating step-by-step solutions\n\n---\n\n##  Real-World Analogy: Running a Hotel\n\nImagine you need to plan the opening of a new hotel:\n\n```\n\n                    HOTEL OPENING                        \n\n                                                         \n        \n   STAFFING    MARKETING   SUPPLIES    TRAINING \n        \n                                                     \n                                                     \n  Hire staff    Launch ads    Order items   Train team  \n                                                         \n\n```\n\nYou naturally **decompose** the big task into smaller ones. That''s computational thinking!\n\n---\n\n##  What You''ll Learn in This Course\n\n### Module Overview\n\n| Module | Topic | What You''ll Master |\n|--------|-------|--------------------|\n| 1-2 | CT Foundations | The four pillars of problem-solving |\n| 3 | Algorithms | Designing step-by-step solutions |\n| 4-6 | Python Basics | Variables, data types, decisions |\n| 7-9 | Data & Loops | Collections and repetition |\n| 10-12 | Functions & OOP | Reusable, organized code |\n| 13-15 | Debugging & Review | Writing robust code |\n\n### Skills You''ll Develop\n\n1. **Analytical Thinking**  Break complex problems into parts\n2. **Pattern Recognition**  Spot similarities and reuse solutions\n3. **Systematic Planning**  Create clear, executable plans\n4. **Python Programming**  Bring your solutions to life with code\n\n---\n\n##  Why Hospitality Professionals Need CT\n\n### Example 1: Revenue Management\nA hotel manager uses patterns (weekends vs. weekdays, seasons, events) to set optimal room prices. This is **pattern recognition**.\n\n### Example 2: Guest Experience\nWhen a VIP guest arrives, the front desk follows a checklist: greet by name, escort to room, offer amenities. This is an **algorithm**.\n\n### Example 3: Operations Planning\nPlanning a wedding event means breaking it into catering, decorations, timing, and staff. This is **decomposition**.\n\n---\n\n##  Common Misconceptions\n\n| Myth | Reality |\n|------|--------|\n| \"CT is only for programmers\" | CT is used in medicine, law, business, arts |\n| \"You need math skills\" | CT is about logical thinking, not calculations |\n| \"Computers do the thinking\" | YOU do the thinking; computers execute |\n| \"It''s too abstract\" | CT solves everyday problems like planning trips |\n\n---\n\n##  Pro Tips\n\n1. **Start simple**  Even experts break problems into tiny pieces\n2. **Write things down**  Visualizing helps clarify your thinking\n3. **Look for patterns**  Most problems resemble ones you''ve seen before\n4. **Practice daily**  CT improves with regular use\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Computational thinking = systematic problem-solving\n> - It works in ANY field, not just tech\n> - Four pillars: Decomposition, Pattern Recognition, Abstraction, Algorithms\n> - This course builds from concepts to Python programming\n\nReady to discover the four pillars? Let''s continue! "}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 1.2: What is Computational Thinking? (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000002',
  'd0000000-0000-0000-0000-000000000001',
  '1.2',
  2,
  'What is Computational Thinking?',
  'what-is-computational-thinking',
  'lesson',
  15,
  25,
  'free',
  '{"markdown": "# What is Computational Thinking?\n\n##  Why This Matters\n\nEvery day, you solve dozens of problems without realizing it: choosing the fastest route to class, deciding what to order for lunch, or figuring out how to fit all your activities into your schedule. **Computational thinking gives you a structured approach to tackle even the trickiest problems.**\n\n---\n\n##  The Definition\n\n> **Computational Thinking (CT)** is a set of problem-solving methods that involve expressing problems and their solutions in ways that a computeror a human following precise instructionscould execute.\n\n### Breaking Down the Definition\n\n1. **Problem-solving methods**  It''s a toolkit, not a single technique\n2. **Expressing problems**  You learn to describe problems clearly\n3. **Solutions that can be executed**  Your solutions are actionable, not vague\n\n---\n\n##  The Hotel Check-In Analogy\n\nImagine you''re training a new front desk employee. You can''t just say \"check guests in.\" You need to explain:\n\n```\n\n                  GUEST CHECK-IN PROCESS                 \n\n  1. Greet the guest warmly                              \n  2. Ask for reservation name or confirmation number     \n  3. Verify ID matches reservation                       \n  4. IF room is ready:                                   \n         Assign room, provide key cards                 \n     ELSE:                                               \n         Offer luggage storage, suggest amenities       \n  5. Explain breakfast hours and WiFi password           \n  6. Offer to assist with luggage                        \n  7. Wish guest a pleasant stay                          \n\n```\n\nThis is computational thinking: a clear, step-by-step process anyone can follow.\n\n---\n\n##  The Four Pillars of CT\n\nComputational thinking rests on **four foundational strategies**:\n\n```\n              \n               COMPUTATIONAL       \n               THINKING            \n              \n                        \n    \n                                         \n                                         \n   \nDECOMP-  PATTERN  ABSTRACTION ALGORITHMS\nOSITION   RECOG                         \n   \n                                         \n                                         \n Break it   Find what''s   Focus on    Create\n  apart      similar      essentials   steps\n```\n\n### Quick Overview\n\n| Pillar | What It Does | Hotel Example |\n|--------|--------------|---------------|\n| **Decomposition** | Breaks big problems into small ones | Planning a conference = venue + catering + AV + registration |\n| **Pattern Recognition** | Finds similarities | \"VIP guests always request early check-in\" |\n| **Abstraction** | Hides unnecessary details | A reservation system only shows available rooms, not plumbing details |\n| **Algorithms** | Creates step-by-step solutions | The exact check-in procedure |\n\n---\n\n##  Worked Example 1: Planning a Trip\n\n**Problem:** You need to plan a weekend trip to Paris.\n\n### Using the Four Pillars:\n\n**1. Decomposition**\n- Transportation (flights, trains)\n- Accommodation (hotel, Airbnb)\n- Activities (museums, restaurants)\n- Budget (costs, payments)\n\n**2. Pattern Recognition**\n- \"Last time I traveled, booking early saved 30%\"\n- \"Museums are less crowded in the morning\"\n\n**3. Abstraction**\n- Focus on: dates, prices, locations\n- Ignore: airline fuel costs, hotel staff schedules\n\n**4. Algorithm**\n- Step 1: Set dates  Step 2: Book transport  Step 3: Book hotel  Step 4: Plan activities\n\n---\n\n##  Worked Example 2: Restaurant Seating\n\n**Problem:** A restaurant needs to seat 200 guests for a wedding dinner.\n\n**Decomposition:**\n- How many tables?  25 tables of 8 guests each\n- Where do VIPs sit?\n- Dietary requirements?\n- Table assignments?\n\n**Pattern Recognition:**\n- \"Families with children prefer tables near the exit\"\n- \"Elderly guests avoid tables near speakers\"\n\n**Abstraction:**\n- Essential: guest names, relationships, dietary needs\n- Not essential: guests'' favorite colors, shoe sizes\n\n**Algorithm:**\n1. List all guests and group by family/relationship\n2. Identify VIPs and special needs\n3. Assign VIPs to head table\n4. Fill remaining tables avoiding conflicts\n5. Verify dietary needs are accommodated\n\n---\n\n##  Worked Example 3: Social Media Strategy\n\n**Problem:** Increase hotel bookings through Instagram.\n\n| Pillar | Application |\n|--------|-------------|\n| Decomposition | Content creation, posting schedule, engagement, analytics |\n| Pattern Recognition | Posts with room photos get 40% more likes |\n| Abstraction | Focus on conversion rate, not individual likes |\n| Algorithm | Post room photo Mon/Wed/Fri at 9am, respond to comments within 2 hours |\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Jumping to Solutions\n \"I''ll just figure it out as I go\"\n Take time to decompose and plan first\n\n### Mistake 2: Over-Complicating\n Creating 50-step processes for simple tasks\n Keep it as simple as possible (abstraction!)\n\n### Mistake 3: Ignoring Patterns\n Treating every problem as completely new\n Look for similarities to problems you''ve solved before\n\n### Mistake 4: Thinking CT = Coding\n \"I can''t use CT because I don''t know how to code\"\n CT is a thinking process; coding is just one application\n\n---\n\n##  Pro Tips\n\n1. **Start with the end goal**  Know what success looks like before decomposing\n2. **Use visual aids**  Diagrams and flowcharts clarify thinking\n3. **Question assumptions**  \"Do I really need all this information?\"\n4. **Iterate**  Your first solution often isn''t the best\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - CT = Problem-solving methods that produce executable solutions\n> - Four pillars: Decomposition, Pattern Recognition, Abstraction, Algorithms\n> - CT applies to ALL fields, not just technology\n> - The pillars work together, not in isolation\n\n**Memory Hook:** Think of CT as a **recipe for problem-solving**:\n- **Decomposition** = List the ingredients\n- **Pattern Recognition** = Use techniques that worked before\n- **Abstraction** = Focus on key steps, skip minor details\n- **Algorithm** = Follow the recipe steps in order"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 1.3: CT Concept Check Quiz (Expanded - 12 questions, 3 tiers)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000003',
  'd0000000-0000-0000-0000-000000000001',
  '1.3',
  3,
  'CT Concept Check Quiz',
  'ct-concept-check',
  'quiz',
  10,
  30,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What is computational thinking primarily about?",
        "options": [
          "Only writing computer code",
          "A problem-solving process using computer science concepts",
          "Building computers and hardware",
          "Mathematical calculations only"
        ],
        "correct": 1,
        "explanation": "Computational thinking is a problem-solving process that uses concepts from computer science. It applies to many fields beyond just coding, including business, medicine, and hospitality."
      },
      {
        "id": "q2",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Computational thinking can only be used by professional programmers.",
        "correct": false,
        "explanation": "FALSE. Computational thinking is a universal skill used in many fields including medicine, law, business, education, and everyday life. You don''t need to be a programmer to use it."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "How many pillars does computational thinking have?",
        "options": [
          "Two",
          "Three",
          "Four",
          "Five"
        ],
        "correct": 2,
        "explanation": "Computational thinking has FOUR pillars: Decomposition, Pattern Recognition, Abstraction, and Algorithms."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which of the following is NOT one of the four pillars of CT?",
        "options": [
          "Decomposition",
          "Pattern Recognition",
          "Memorization",
          "Abstraction"
        ],
        "correct": 2,
        "explanation": "Memorization is NOT a pillar of CT. The four pillars are: Decomposition, Pattern Recognition, Abstraction, and Algorithms."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel manager breaks down ''planning a conference'' into venue, catering, speakers, and registration. Which CT pillar is this?",
        "options": [
          "Pattern Recognition",
          "Abstraction",
          "Decomposition",
          "Algorithm"
        ],
        "correct": 2,
        "explanation": "This is DECOMPOSITION - breaking a complex problem (conference planning) into smaller, manageable parts."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A restaurant notices that customers order more desserts when the waiter describes them enthusiastically. Using this insight to train all waiters is an example of:",
        "options": [
          "Decomposition",
          "Pattern Recognition",
          "Abstraction",
          "Random chance"
        ],
        "correct": 1,
        "explanation": "This is PATTERN RECOGNITION - identifying a recurring trend (enthusiastic descriptions = more dessert sales) and applying it broadly."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "When creating a subway map, designers show station connections but hide the actual distances between stations. This is an example of:",
        "options": [
          "Decomposition",
          "Pattern Recognition",
          "Abstraction",
          "Algorithm"
        ],
        "correct": 2,
        "explanation": "This is ABSTRACTION - focusing on essential information (connections) while hiding unnecessary details (exact distances)."
      },
      {
        "id": "q8",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A recipe for baking a cake is an example of an algorithm.",
        "correct": true,
        "explanation": "TRUE. An algorithm is a step-by-step procedure to accomplish a task. A recipe provides exactly that: ordered steps to produce a specific result."
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel wants to predict which guests will become loyalty program members. They analyze data from past guests and find that guests who book spa treatments and order room service are 80% more likely to join. The hotel then focuses marketing on these guests. Which CT pillars were used?",
        "options": [
          "Only Pattern Recognition",
          "Pattern Recognition and Abstraction",
          "Decomposition and Algorithm",
          "All four pillars"
        ],
        "correct": 1,
        "explanation": "This uses PATTERN RECOGNITION (finding the trend in guest behavior) and ABSTRACTION (focusing only on spa and room service data, ignoring other factors)."
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which statement BEST describes the relationship between the four pillars?",
        "options": [
          "They must always be used in the exact order: Decomposition  Pattern Recognition  Abstraction  Algorithm",
          "They are independent tools that never overlap",
          "They are interconnected strategies that can be used iteratively and in different combinations",
          "Algorithms must always be created before decomposition"
        ],
        "correct": 2,
        "explanation": "The pillars are INTERCONNECTED and ITERATIVE. You might decompose a problem, recognize patterns, then decompose further. The order is flexible depending on the problem."
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A cruise ship needs to create an emergency evacuation plan. Which approach demonstrates the BEST use of computational thinking?",
        "options": [
          "Copy another ship''s plan exactly without changes",
          "Break the problem into sections of the ship, identify similar cabin layouts, focus on passenger flow (not decor), and create step-by-step procedures",
          "Ask the captain to figure it out during an actual emergency",
          "Only focus on first-class passengers since they paid more"
        ],
        "correct": 1,
        "explanation": "Option B demonstrates all four pillars: Decomposition (sections), Pattern Recognition (similar layouts), Abstraction (focus on flow), and Algorithm (procedures)."
      },
      {
        "id": "q12",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Computational thinking requires access to a computer to be useful.",
        "correct": false,
        "explanation": "FALSE. Computational thinking is a MENTAL process that can be applied with pen and paper, in conversations, or in any planning context. Computers are just one tool for executing solutions."
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
-- Activity 1.4: The Four Pillars (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0001-000000000004',
  'd0000000-0000-0000-0000-000000000001',
  '1.4',
  4,
  'The Four Pillars of CT',
  'the-four-pillars',
  'lesson',
  18,
  35,
  'free',
  '{"markdown": "# The Four Pillars of Computational Thinking\n\n##  Why This Matters\n\nImagine trying to build a house with just a hammer. You''d struggle! Computational thinking gives you **four essential tools** that, when combined, can solve virtually any problem. Understanding these pillars is the foundation of everything else in this course.\n\n---\n\n##  Pillar 1: DECOMPOSITION\n\n### What is Decomposition?\n\n> **Decomposition** means breaking down a complex problem or system into smaller, more manageable parts.\n\n### The \"Divide and Conquer\" Strategy\n\n```\n    \n          COMPLEX PROBLEM        \n         (Overwhelming )       \n    \n                  \n         DECOMPOSITION\n                  \n    \n                                \n                                \n           \nPart 1     Part 2        Part 3 \n(Easy)     (Easy)        (Easy) \n           \n```\n\n###  Hotel Example: Planning a Wedding Reception\n\n**Original Problem:** \"Plan a 200-person wedding reception\"\n\n**Decomposed:**\n\n| Main Area | Sub-tasks |\n|-----------|----------|\n| **Catering** | Menu selection, dietary requirements, serving staff, timing |\n| **Venue Setup** | Table arrangement, decorations, lighting, sound system |\n| **Guest Management** | Seating chart, name cards, welcome drinks, coat check |\n| **Entertainment** | DJ/band, first dance, speeches, photo booth |\n| **Logistics** | Parking, accessibility, backup plans, timeline |\n\n### Types of Decomposition\n\n1. **Functional**  By what each part does\n2. **Sequential**  By the order things happen\n3. **Hierarchical**  By levels of detail (tree structure)\n\n---\n\n##  Pillar 2: PATTERN RECOGNITION\n\n### What is Pattern Recognition?\n\n> **Pattern Recognition** means finding similarities, trends, or regularities in data or problems.\n\n### Why Patterns Matter\n\n```\nSeen Before?    Reuse Solution!\n     \n      New patterns?\n     \nAnalyze & Learn    Create New Solution\n     \n      Document it!\n     \nFuture Reference    Solve Faster Next Time\n```\n\n###  Hotel Examples\n\n| Pattern Observed | Action Taken |\n|-----------------|---------------|\n| \"Business travelers check in Sunday night\" | Add express check-in staff on Sundays |\n| \"Complaints spike when lobby is understaffed\" | Minimum 2 staff during peak hours |\n| \"Guests who book spa also order room service\" | Bundle these in a package deal |\n| \"Repeat guests request same room type\" | Pre-assign their preferred room |\n\n### Types of Patterns\n\n- **Repeating patterns:** 2, 4, 6, 8... (adding 2 each time)\n- **Structural patterns:** All HTML pages have `<html>`, `<head>`, `<body>`\n- **Behavioral patterns:** Customers who buy X often buy Y\n- **Temporal patterns:** Sales increase in December every year\n\n---\n\n##  Pillar 3: ABSTRACTION\n\n### What is Abstraction?\n\n> **Abstraction** means focusing on essential information while hiding or ignoring irrelevant details.\n\n### The \"Zoom Out\" Principle\n\n```\nDETAILED VIEW                    ABSTRACT VIEW\n              \n  Room 401                                     \n  2 beds                         HOTEL       \n  City view                 150 rooms      \n  35 sqm          ABSTRACTION   4 stars        \n  Oak furniture                 City center    \n  Blue curtains                                \n  LED lights                  \n\n```\n\n###  Hotel Examples\n\n| Context | Essential Information | Abstracted Away |\n|---------|----------------------|------------------|\n| **Booking website** | Room type, price, dates | Carpet color, mattress brand |\n| **Fire evacuation** | Exit routes, assembly points | Room amenities, minibar contents |\n| **Revenue report** | Total revenue, occupancy % | Individual transaction details |\n| **Guest survey** | Satisfaction scores | Exact timestamps of responses |\n\n### Levels of Abstraction\n\n```\n        HIGH LEVEL (More Abstract)\n              \n                 \"We run hotels\"\n              \n                 \"We have 500 rooms across 3 properties\"\n              \n                 \"Room 401 has 2 beds, city view, 35 sqm\"\n              \n                 \"The left bedside lamp has a 60W LED bulb\"\n              \n        LOW LEVEL (More Detailed)\n```\n\n---\n\n##  Pillar 4: ALGORITHMS\n\n### What is an Algorithm?\n\n> **Algorithm** means developing step-by-step instructions to solve a problem or complete a task.\n\n### The \"Recipe\" Analogy\n\nJust like a recipe tells you exactly how to bake a cake, an algorithm tells you exactly how to solve a problem.\n\n###  Hotel Check-In Algorithm\n\n```\nSTART\n   \n   \n\n 1. Greet guest warmly   \n\n            \n            \n\n 2. Ask for reservation  \n    name or number       \n\n            \n            \n\n 3. Verify ID            \n\n            \n            \n      \n       Room Ready? \n      \n         \n        YES      NO\n                \n                \n     \n    Assign   Offer lounge\n    room key access      \n     \n                    \n        \n              \n\n 4. Explain amenities    \n\n            \n            \n          END\n```\n\n### Three Components of Algorithms\n\n1. **Sequential steps**  Do this, then that, then the other\n2. **Conditional logic**  IF this, THEN do that, ELSE do something else\n3. **Loops**  REPEAT this until a condition is met\n\n---\n\n##  How the Pillars Work Together\n\n### Example: Solving a Customer Complaint\n\n**Situation:** A guest says their stay was \"disappointing.\"\n\n| Pillar | Application |\n|--------|-------------|\n| **Decomposition** | Break down their stay: check-in, room, dining, amenities, check-out |\n| **Pattern Recognition** | \"This is the 3rd complaint about slow room service this week\" |\n| **Abstraction** | Focus on room service issue, ignore unrelated positive feedback |\n| **Algorithm** | 1. Apologize  2. Offer compensation  3. Report to F&B manager  4. Follow up |\n\n---\n\n##  Common Mistakes\n\n###  Mistake 1: Skipping Decomposition\n\"I''ll tackle the whole project at once!\"  Leads to overwhelm and missed details.\n\n###  Mistake 2: Ignoring Existing Patterns\n\"Every problem is unique!\"  Wastes time reinventing solutions.\n\n###  Mistake 3: Too Much or Too Little Abstraction\n- Too much: Missing critical details\n- Too little: Drowning in irrelevant information\n\n###  Mistake 4: Vague Algorithms\n\"Handle the complaint appropriately\"  Not specific enough to execute.\n\n---\n\n##  Pro Tips\n\n1. **Decompose first**  It''s usually the best starting point\n2. **Document patterns**  Keep a \"lessons learned\" log\n3. **Ask: \"What can I ignore?\"**  Abstraction saves time\n4. **Test algorithms**  Walk through them step by step\n5. **The pillars overlap**  Don''t force rigid boundaries\n\n---\n\n##  Summary: Key Takeaways\n\n```\n\n                    THE FOUR PILLARS                        \n\n DECOMPOSITION   PATTERN     ABSTRACTION    ALGORITHM   \n               RECOGNITION                              \n\n Break it      Find what''s   Focus on      Create       \n into parts    similar       essentials    step-by-step \n\n \"Divide\"      \"Recognize\"   \"Simplify\"    \"Execute\"    \n\n```\n\n> **Memory Hook:** Think **DPAA** = **D**ivide, **P**attern, **A**bstract, **A**lgorithm\n>\n> Or remember: \"**D**etectives **P**ay **A**ttention to **A**nswers\""}'::jsonb,
  NULL,
  false,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;
