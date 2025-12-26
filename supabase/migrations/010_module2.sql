-- ============================================
-- Module 2: Decomposition, Pattern Recognition & Abstraction
-- EXPANDED VERSION - Gold Standard Lesson Structure
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 2.1: Deep Dive: Decomposition (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0002-000000000001',
  'd0000000-0000-0000-0000-000000000002',
  '2.1',
  1,
  'Deep Dive: Decomposition',
  'deep-dive-decomposition',
  'lesson',
  15,
  30,
  'free',
  '{"markdown": "# Deep Dive: Decomposition\n\n##  Why This Matters\n\nImagine being asked to \"create a successful hotel.\" Where would you even start? The task is so overwhelming that most people would freeze. But what if you broke it down into: \"Find a location,\" \"Design the building,\" \"Hire staff,\" \"Create a marketing plan\"? Suddenly, it''s manageable!\n\n> **Decomposition is the superpower of turning impossible tasks into possible ones.**\n\n---\n\n##  What is Decomposition?\n\n> **Decomposition** means breaking a complex problem or system into smaller, more manageable parts that can be solved independently or in sequence.\n\n### The Core Principle\n\n```\n\n         OVERWHELMING PROBLEM            \n              \"Build a hotel\"            \n                                       \n\n                     DECOMPOSE\n        \n                              \n                              \n     \n   Location   Design     Staff     (Still big)\n     \n                              \n                              \n     \n    Market     Rooms     Hire   \n    Research  Layout   Managers    (Manageable!)\n     \n                    \n              Keep going until\n               tasks are small\n                   enough!\n```\n\n---\n\n##  Three Types of Decomposition\n\n### 1. Functional Decomposition\n**Break by WHAT each part does**\n\nExample: A restaurant\n- Kitchen (prepares food)\n- Service (serves customers)\n- Bar (makes drinks)\n- Host (seats guests)\n\n### 2. Sequential Decomposition\n**Break by the ORDER things happen**\n\nExample: Guest stay\n1. Booking\n2. Check-in\n3. Stay\n4. Check-out\n5. Follow-up\n\n### 3. Hierarchical Decomposition\n**Break by LEVELS of detail (tree structure)**\n\nExample: Hotel organization\n```\n              HOTEL\n                \n    \n                          \n Operations   Sales    Finance\n                          \n      \nFront  House Corpor. Events Budget Audit\nDesk   keep   Sales\n```\n\n---\n\n##  Worked Example 1: Wedding Planning\n\n**Problem:** Plan a 150-person wedding at a 5-star hotel.\n\n**Level 1 Decomposition:**\n\n| Category | Description |\n|----------|-------------|\n| Ceremony | The wedding vows and rituals |\n| Reception | The party and dinner |\n| Logistics | Transportation, timing, coordination |\n| Documentation | Photos, videos, legal papers |\n\n**Level 2 Decomposition (Reception only):**\n\n```\n                RECEPTION\n                    \n    \n                                \nVenue   Catering  Music  Decor  Schedule\n                                \n                                \nTables  Menu     DJ/Band  Flowers Timeline\nSeating Drinks   Sound   Lights  Speeches\nLayout  Staff    Dance   Theme   Toasts\n                 Floor\n```\n\n---\n\n##  Worked Example 2: Hotel Website Redesign\n\n**Problem:** The hotel''s website needs to be completely redesigned.\n\n**Functional Decomposition:**\n\n| Function | Tasks |\n|----------|-------|\n| **Design** | Colors, fonts, images, layout, mobile responsiveness |\n| **Content** | Room descriptions, pricing, policies, about us, blog |\n| **Technical** | Booking engine, payment processing, load speed, security |\n| **Marketing** | SEO, analytics, social media integration, email signup |\n| **Testing** | Browser compatibility, user testing, bug fixes |\n\n**Sequential Decomposition:**\n1. Research competitors\n2. Define requirements\n3. Create wireframes\n4. Design mockups\n5. Develop frontend\n6. Integrate backend\n7. Test thoroughly\n8. Launch\n9. Monitor and iterate\n\n---\n\n##  Worked Example 3: Opening a New Restaurant\n\n**Problem:** Open a fine dining restaurant in the hotel.\n\n**Hierarchical Decomposition:**\n\n```\n          NEW RESTAURANT\n                \n    \n                          \n CONCEPT     PHYSICAL    OPERATIONS\n                          \n          \nMenu  Brand  Space  Equip  Staff  Systems\n                               \nCuisine Logo  Layout Kitchen Hiring  POS\nPricing Colors Decor  Tables  Training Inventory\nDietary Theme  Light  Tech    Schedule Reservations\n```\n\n---\n\n##  When to Use Each Type\n\n| Type | Best For | Example |\n|------|----------|----------|\n| **Functional** | Organizations, systems with distinct roles | Company departments |\n| **Sequential** | Processes, workflows, time-based tasks | Event planning |\n| **Hierarchical** | Complex systems, nested structures | Project breakdown |\n\n---\n\n##  Common Mistakes\n\n###  Mistake 1: Stopping Too Early\n**Wrong:** \"Plan the conference\"  \"Book venue, manage catering\"\n**Right:** \"Plan the conference\"  \"Book venue\"  \"Research options, compare prices, check availability, negotiate contract, confirm booking\"\n\n###  Mistake 2: Making Parts Too Small\n**Wrong:** Breaking \"write email\" into \"press K, press E, press Y...\"\n**Right:** Keep tasks at a meaningful level of abstraction\n\n###  Mistake 3: Overlapping Parts\n**Wrong:** \"Marketing\" AND \"Social Media\" AND \"Advertising\" (overlapping!)\n**Right:** \"Marketing\"  \"Social Media, Traditional Ads, PR\"\n\n###  Mistake 4: Missing Dependencies\n**Wrong:** Treating all parts as independent when they''re connected\n**Right:** Note which parts must be done before others\n\n---\n\n##  Pro Tips\n\n1. **Ask \"Can this be smaller?\"**  Keep decomposing until tasks are truly manageable (1-2 hours of work)\n\n2. **Use visual tools**  Draw trees, mind maps, or lists to see the structure\n\n3. **Identify dependencies**  Some tasks must wait for others; note these!\n\n4. **Assign owners**  Each small task should have a clear responsible person\n\n5. **Combine types**  Use functional for structure, sequential for timeline\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Decomposition = Breaking complex problems into smaller parts\n> - Three types: Functional, Sequential, Hierarchical\n> - Keep breaking down until tasks are manageable\n> - Watch for overlapping or dependent tasks\n\n**Memory Hook:** Think of decomposition like **unpacking a suitcase**  you can''t find your socks until you''ve separated clothes, toiletries, and electronics!"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.2: Decomposition Tree Builder (Interactive)
-- ============================================
(
  'e0000000-0000-0000-0002-000000000002',
  'd0000000-0000-0000-0000-000000000002',
  '2.2',
  2,
  'Revenue Tree Builder',
  'revenue-tree-builder',
  'interactive',
  12,
  40,
  'basic',
  '{
    "instructions": "Build a decomposition tree showing how a luxury hotel generates revenue. Start with the root node and add branches to break down each revenue stream into its components.\n\nGoal: Create at least 3 levels of depth with comprehensive coverage of hotel revenue sources.",
    "type": "tree-builder",
    "rootNode": "Hotel Revenue",
    "suggestedBranches": {
      "Rooms": {
        "Standard Rooms": ["Weekday rates", "Weekend rates", "Seasonal rates"],
        "Suites": ["Junior suites", "Executive suites", "Presidential suite"],
        "Packages": ["Romance package", "Business package", "Family package"]
      },
      "Food & Beverage": {
        "Restaurants": ["Fine dining", "Casual dining", "Room service"],
        "Bars": ["Lobby bar", "Pool bar", "Rooftop bar"],
        "Events": ["Weddings", "Conferences", "Private parties"]
      },
      "Spa & Wellness": {
        "Treatments": ["Massages", "Facials", "Body treatments"],
        "Memberships": ["Gym access", "Pool access", "Annual packages"],
        "Products": ["Skincare", "Merchandise"]
      },
      "Other": {
        "Parking": ["Valet", "Self-park"],
        "Retail": ["Gift shop", "Boutiques"],
        "Services": ["Laundry", "Concierge bookings", "Transportation"]
      }
    },
    "hints": [
      "Think about where guests spend money during their stay",
      "Consider both major revenue streams and ancillary services",
      "Don''t forget about corporate clients vs leisure travelers"
    ],
    "scoring": {
      "minBranches": 4,
      "minDepth": 3,
      "minNodes": 15,
      "bonusForCompleteness": true
    }
  }'::jsonb,
  'tree-builder',
  false,
  true
),

-- ============================================
-- Activity 2.3: Pattern Recognition Deep Dive (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0002-000000000003',
  'd0000000-0000-0000-0000-000000000002',
  '2.3',
  3,
  'Deep Dive: Pattern Recognition',
  'deep-dive-pattern-recognition',
  'lesson',
  15,
  30,
  'free',
  '{"markdown": "# Deep Dive: Pattern Recognition\n\n##  Why This Matters\n\nEvery successful business runs on patterns. Amazon knows you''ll buy more if they show \"frequently bought together\" items. Netflix keeps you watching with \"because you watched...\" recommendations. Hotels predict occupancy months in advance. **Recognizing patterns is how you turn data into decisions.**\n\n---\n\n##  What is Pattern Recognition?\n\n> **Pattern Recognition** means finding similarities, trends, regularities, or rules in data, problems, or processes.\n\n### Why Patterns Are Powerful\n\n```\n\n           RAW OBSERVATIONS              \n Guest A: Booked spa on Saturday         \n Guest B: Booked spa on Saturday         \n Guest C: Booked spa on Sunday           \n Guest D: Booked spa on Saturday         \n Guest E: Booked spa on Saturday         \n\n                     PATTERN RECOGNITION\n                    \n\n           INSIGHT DISCOVERED            \n    \"80% of spa bookings are on          \n     Saturday  need more staff!\"        \n\n                     TAKE ACTION\n                    \n\n              BETTER OUTCOME             \n    Schedule extra therapists Sat.       \n    Offer weekday discounts.             \n    Reduce Saturday wait times.          \n\n```\n\n---\n\n##  Types of Patterns\n\n### 1. Repeating Patterns\n**The same thing happens at regular intervals**\n\n- Number sequence: 2, 4, 6, 8, 10... (add 2)\n- Sales cycle: Revenue peaks every December\n- Behavior: Guests always request extra towels\n\n### 2. Structural Patterns\n**Things share common structure or format**\n\n- All email addresses contain @\n- All phone numbers follow a format\n- All hotel rooms have bed, bathroom, desk\n\n### 3. Behavioral Patterns\n**Actions tend to go together**\n\n- Customers who buy X often buy Y\n- Guests who complain about one thing often complain about another\n- Employees who are late also miss deadlines\n\n### 4. Temporal Patterns\n**Things change predictably over time**\n\n- Rush hour is 8-9am and 5-6pm\n- Summer is busiest for beach resorts\n- Mondays have highest employee absences\n\n---\n\n##  Worked Example 1: Guest Preferences\n\n**Data Observed:**\n\n| Guest | Booking | Request | Complaint |\n|-------|---------|---------|------------|\n| Guest 1 | Suite | Early check-in | Slow wifi |\n| Guest 2 | Suite | Early check-in | Slow wifi |\n| Guest 3 | Standard | Late checkout | None |\n| Guest 4 | Suite | Early check-in | Slow wifi |\n| Guest 5 | Standard | Late checkout | None |\n\n**Patterns Identified:**\n1. **Suite guests**  Request early check-in (100%)\n2. **Suite guests**  Complain about wifi (100%)\n3. **Standard guests**  Request late checkout (100%)\n\n**Actions Taken:**\n- Upgrade wifi in suites\n- Pre-approve early check-in for suite bookings\n- Offer late checkout option at standard booking\n\n---\n\n##  Worked Example 2: Restaurant Sales\n\n**Data Observed (Weekly Sales):**\n\n```\n         MON   TUE   WED   THU   FRI   SAT   SUN\nBreakfast: 80    75    82    78   120   180   200\nLunch:     50    55    60    58   100   150   140\nDinner:    40    45    50    90   160   200   180\n```\n\n**Patterns Identified:**\n1. **Weekend spike:** Sat/Sun have 2-3x weekday volume\n2. **Thursday dinner surge:** +80% vs other weekdays\n3. **Breakfast grows Fri-Sun:** Travel and leisure guests\n\n**Actions Taken:**\n- Staff 3x on weekends\n- Thursday dinner special event/promotion\n- Extended breakfast hours Fri-Sun\n\n---\n\n##  Worked Example 3: Booking Behavior\n\n**Data from 1,000 bookings:**\n\n| Pattern | Finding | Business Action |\n|---------|---------|------------------|\n| **Timing** | 60% book 2-3 weeks ahead | Send promotions 4 weeks before |\n| **Device** | 70% browse on mobile, 60% book on desktop | Optimize mobile for browsing |\n| **Abandonment** | Cart abandonment spikes at payment | Simplify payment, offer multiple options |\n| **Upsells** | Breakfast add-on converts at 45% | Always offer at booking |\n\n---\n\n##  How to Find Patterns\n\n### Step-by-Step Process\n\n1. **Collect Data**  What information do you have?\n2. **Organize Data**  Group similar items together\n3. **Look for Repetition**  What happens more than once?\n4. **Quantify**  How often does it happen? (%, frequency)\n5. **Validate**  Is it coincidence or real pattern?\n6. **Act**  How can you use this insight?\n\n### Questions That Reveal Patterns\n\n- \"What happens every [time period]?\"\n- \"What do successful [X] have in common?\"\n- \"When does [problem] usually occur?\"\n- \"Which [customers] do [action] most often?\"\n\n---\n\n##  Common Mistakes\n\n###  Mistake 1: Seeing Patterns That Don''t Exist\n**Correlation  Causation**\n\n\"Ice cream sales and drowning deaths both rise in summer\"\n They''re not connected; both just happen in hot weather!\n\n###  Mistake 2: Sample Too Small\n\"2 guests complained about the beds, so we need new mattresses!\"\n Wait for more data before major decisions.\n\n###  Mistake 3: Ignoring Exceptions\n\"All our VIP guests are over 50\"\n What about the younger VIPs? Why are they different?\n\n###  Mistake 4: Not Acting on Patterns\nFinding patterns is only valuable if you DO something about them!\n\n---\n\n##  Pro Tips\n\n1. **Track systematically**  Keep logs, use spreadsheets, analyze regularly\n\n2. **Look for \"always\" and \"never\"**  These strong patterns are most actionable\n\n3. **Compare groups**  Business vs leisure, weekday vs weekend, new vs repeat\n\n4. **Ask \"why?\"**  Understanding causes makes patterns more useful\n\n5. **Document discoveries**  Build an organizational knowledge base\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Pattern recognition = Finding similarities and trends\n> - Four types: Repeating, Structural, Behavioral, Temporal\n> - Patterns enable prediction and optimization\n> - Beware false patterns (correlation  causation)\n\n**Memory Hook:** Patterns are like **footprints in the sand**  if you see where people walked before, you can predict where they''ll walk next!"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.4: Pattern Finder Game (Interactive)
-- ============================================
(
  'e0000000-0000-0000-0002-000000000004',
  'd0000000-0000-0000-0000-000000000002',
  '2.4',
  4,
  'Pattern Finder Challenge',
  'pattern-finder-game',
  'interactive',
  10,
  35,
  'basic',
  '{
    "instructions": "Identify the pattern and predict the next element in each sequence. Some are numbers, some are letters, and some are business scenarios!",
    "type": "pattern-game",
    "sequences": [
      {"items": [1, 4, 9, 16, 25], "answer": "36", "hint": "Think about square numbers (1, 2, 3...)", "pattern": "Square numbers (n)"},
      {"items": ["A", "C", "E", "G"], "answer": "I", "hint": "Count the letters in the alphabet", "pattern": "Every other letter"},
      {"items": [2, 6, 18, 54], "answer": "162", "hint": "Look at the multiplier between numbers", "pattern": "Multiply by 3"},
      {"items": [1, 1, 2, 3, 5, 8], "answer": "13", "hint": "Add the previous two numbers", "pattern": "Fibonacci sequence"},
      {"items": ["100 guests", "200 guests", "400 guests", "800 guests"], "answer": "1600 guests", "hint": "What''s happening to the number each time?", "pattern": "Doubling"},
      {"items": ["Monday: 5 complaints", "Tuesday: 4 complaints", "Wednesday: 3 complaints", "Thursday: 2 complaints"], "answer": "Friday: 1 complaint", "hint": "Complaints decrease by...", "pattern": "Decrease by 1"},
      {"items": ["Q1: $100k", "Q2: $110k", "Q3: $121k", "Q4: $133.1k"], "answer": "Q5: ~$146.4k", "hint": "Calculate the percentage growth", "pattern": "10% growth each quarter"},
      {"items": ["Sun 10 rooms", "Mon 50 rooms", "Tue 50 rooms", "Wed 50 rooms", "Thu 50 rooms", "Fri 80 rooms", "Sat 10 rooms"], "answer": "Sun 10 rooms (cycle repeats)", "hint": "This is a weekly pattern", "pattern": "Weekly occupancy cycle"}
    ],
    "scoring": {
      "correct": 12,
      "partialCredit": true,
      "bonusForSpeed": true
    }
  }'::jsonb,
  'pattern-game',
  false,
  true
),

-- ============================================
-- Activity 2.5: Abstraction Deep Dive (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0002-000000000005',
  'd0000000-0000-0000-0000-000000000002',
  '2.5',
  5,
  'Deep Dive: Abstraction',
  'deep-dive-abstraction',
  'lesson',
  15,
  30,
  'free',
  '{"markdown": "# Deep Dive: Abstraction\n\n##  Why This Matters\n\nEvery day, you drive a car without knowing how the engine works. You use a smartphone without understanding its circuits. You book hotels without knowing their reservation systems. **Abstraction is what makes complex systems usable**  and what will make YOUR solutions elegant and effective.\n\n---\n\n##  What is Abstraction?\n\n> **Abstraction** means focusing on essential information while hiding or ignoring irrelevant details.\n\n### The Core Principle\n\n```\n\n           REALITY (Complex)             \n  A hotel room has: 2 beds, 1 bathroom,  \n  mini-fridge (brand: Samsung, model:    \n  RF18A5101SR, serial: ABC123456),       \n  window (facing: east, size: 120x80cm,  \n  glass type: double-pane thermal),      \n  carpet (color: beige, brand: Shaw,     \n  installed: 2019), WiFi router...       \n\n                     ABSTRACTION\n                    \n\n          BOOKING WEBSITE VIEW           \n   2 beds |  Free WiFi |  City view \n           $199/night                     \n\n```\n\n---\n\n##  Levels of Abstraction\n\nAbstraction works in layers, from very detailed to very simple:\n\n```\n    HIGH LEVEL (Simple)\n         \n           \"We run hospitality businesses\"\n                     Very Abstract\n         \n           \"We operate 50 hotels globally\"\n         \n           \"The Paris hotel has 200 rooms\"\n         \n           \"Room 401 is a deluxe king with city view\"\n         \n           \"Room 401 has a Sealy Posturepedic mattress,\n            800-thread-count sheets, blackout curtains...\"\n                     Very Detailed\n         \n    LOW LEVEL (Complex)\n```\n\n### Choosing the Right Level\n\n| Audience | Right Level | Example |\n|----------|-------------|----------|\n| CEO | Very high | \"Occupancy is 85%\" |\n| Manager | Medium | \"Revenue by property and segment\" |\n| Staff | Detailed | \"Room 401 needs extra pillows\" |\n| Technician | Very low | \"AC unit model X needs filter Y\" |\n\n---\n\n##  Worked Example 1: Hotel Booking Website\n\n**What Guests NEED to See (Essential):**\n- Room type and bed configuration\n- Price per night\n- Dates available\n- Photos of room\n- Key amenities (WiFi, parking, breakfast)\n- Cancellation policy\n\n**What Guests DON''T Need (Abstracted Away):**\n- Inventory management system\n- Staff schedules\n- Supplier contracts\n- Revenue management algorithms\n- Maintenance logs\n- Internal room codes\n\n---\n\n##  Worked Example 2: Emergency Evacuation Plan\n\n**Essential Information:**\n```\n\n          FLOOR 4 - EVACUATION           \n                                         \n    [401] [402] [403] [404] [405]       \n                                        \n         \n                   HALL                 \n         \n                                        \n    [410] [409] [408] [407] [406]       \n                                        \n        [EXIT A]        [EXIT B]         \n                                       \n      STAIRWELL        STAIRWELL         \n      (North)          (South)           \n\n```\n\n**Abstracted Away:**\n- Furniture placement inside rooms\n- Carpet patterns\n- Art on walls\n- Mini-fridge locations\n- Electrical outlets\n\n---\n\n##  Worked Example 3: Revenue Dashboard\n\n**For Daily Management (Medium Abstraction):**\n\n| Metric | Today | MTD | YTD |\n|--------|-------|-----|-----|\n| Occupancy | 87% | 82% | 79% |\n| ADR | $215 | $198 | $185 |\n| RevPAR | $187 | $162 | $146 |\n| F&B Revenue | $12.4k | $298k | $3.2M |\n\n**Abstracted Away:**\n- Individual transaction records\n- Guest names\n- Room-by-room breakdown\n- Hourly fluctuations\n- Credit card processing details\n\n---\n\n##  When to Abstract More vs Less\n\n| Abstract MORE when... | Abstract LESS when... |\n|-----------------------|------------------------|\n| Communicating to leadership | Debugging a problem |\n| Designing systems | Training new staff |\n| Making quick decisions | Investigating complaints |\n| Creating overviews | Ensuring compliance |\n| Building interfaces | Troubleshooting issues |\n\n---\n\n##  Common Mistakes\n\n###  Mistake 1: Over-Abstraction\n**Hiding TOO MUCH essential information**\n\n- Doctor: \"Take some medicine for a while\" (Which medicine? What dose? How long?)\n- This is dangerous over-abstraction!\n\n###  Mistake 2: Under-Abstraction\n**Including TOO MUCH unnecessary detail**\n\n- Booking website showing: \"This room was last painted on March 15, 2023 with Sherwin-Williams Duration Semi-Gloss in Agreeable Gray (SW 7029)...\"\n- No guest needs this!\n\n###  Mistake 3: Wrong Audience\n**Showing technical details to non-technical people**\n\n- CEO: \"Why is revenue down?\"\n- Bad: \"The API latency on our booking engine increased by 340ms...\"\n- Good: \"Website slowness is causing booking abandonment. We''re fixing it.\"\n\n###  Mistake 4: Inconsistent Levels\n**Mixing abstraction levels confusingly**\n\n- \"Our global revenue is $500M, and Room 401 needs a new lamp.\"\n\n---\n\n##  Pro Tips\n\n1. **Ask: \"Who needs this?\"**  Match detail level to audience\n\n2. **Ask: \"What decision does this enable?\"**  Include only what''s needed for that decision\n\n3. **Start abstract, add detail on request**  Let people \"drill down\" as needed\n\n4. **Use visual hierarchy**  Important info first, details in expandable sections\n\n5. **Document what you hide**  Abstracted details should still exist somewhere\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - Abstraction = Focusing on essentials, hiding details\n> - Different audiences need different abstraction levels\n> - Too much AND too little abstraction are both problems\n> - Good abstraction enables faster, clearer decision-making\n\n**Memory Hook:** Abstraction is like a **zoom lens**   zoom out to see the big picture, zoom in only when you need the details!"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 2.6: Abstraction Challenge (Interactive)
-- ============================================
(
  'e0000000-0000-0000-0002-000000000006',
  'd0000000-0000-0000-0000-000000000002',
  '2.6',
  6,
  'Abstraction Challenge',
  'abstraction-challenge',
  'interactive',
  10,
  35,
  'basic',
  '{
    "instructions": "For each scenario, sort the details into two categories: ESSENTIAL (must show) and ABSTRACT AWAY (can hide). Drag each item to the correct category.",
    "type": "filter-essential",
    "scenarios": [
      {
        "context": "Creating a SUBWAY MAP for tourists",
        "items": [
          {"text": "Station names", "category": "essential", "explanation": "Tourists need to know station names to navigate."},
          {"text": "Line connections", "category": "essential", "explanation": "Showing which lines connect is critical for planning routes."},
          {"text": "Transfer points", "category": "essential", "explanation": "Tourists need to know where to change lines."},
          {"text": "Exact geographic distances", "category": "abstract", "explanation": "Precise distances aren''t needed for navigation decisions."},
          {"text": "Street names above ground", "category": "abstract", "explanation": "Underground subway maps don''t need above-ground details."},
          {"text": "Building locations", "category": "abstract", "explanation": "Irrelevant for subway navigation."},
          {"text": "Train frequency", "category": "essential", "explanation": "Helpful for planning but could be abstracted in simple maps."}
        ]
      },
      {
        "context": "Creating a HOTEL BOOKING CONFIRMATION email",
        "items": [
          {"text": "Guest name", "category": "essential", "explanation": "Guest needs to verify their name is correct."},
          {"text": "Check-in/out dates", "category": "essential", "explanation": "Critical for the guest to confirm their stay."},
          {"text": "Room type booked", "category": "essential", "explanation": "Guest should know what room they''re getting."},
          {"text": "Total price", "category": "essential", "explanation": "Guests need to know what they''re paying."},
          {"text": "Confirmation number", "category": "essential", "explanation": "Needed for check-in and any changes."},
          {"text": "Internal booking system ID", "category": "abstract", "explanation": "Only relevant to hotel systems, not guests."},
          {"text": "Revenue category code", "category": "abstract", "explanation": "Internal accounting, not for guests."},
          {"text": "Housekeeping schedule", "category": "abstract", "explanation": "Operational detail, not needed in confirmation."}
        ]
      },
      {
        "context": "Creating a FIRE EVACUATION PLAN for a floor",
        "items": [
          {"text": "Exit locations", "category": "essential", "explanation": "Primary information for evacuation."},
          {"text": "Escape routes", "category": "essential", "explanation": "People need to know which way to go."},
          {"text": "Assembly point outside", "category": "essential", "explanation": "People need to know where to gather."},
          {"text": "Fire extinguisher locations", "category": "essential", "explanation": "May be needed during evacuation."},
          {"text": "Room furniture layout", "category": "abstract", "explanation": "Doesn''t affect evacuation decisions."},
          {"text": "Electrical outlet positions", "category": "abstract", "explanation": "Irrelevant during fire evacuation."},
          {"text": "WiFi router locations", "category": "abstract", "explanation": "Completely irrelevant to safety."},
          {"text": "Stairwell door codes", "category": "essential", "explanation": "May be needed to access stairs."}
        ]
      }
    ],
    "scoring": {
      "correctPlacement": 5,
      "incorrectPlacement": -2,
      "passingScore": 60
    }
  }'::jsonb,
  'filter-essential',
  false,
  true
),

-- ============================================
-- Activity 2.7: Module 2 Quiz (Expanded - 15 questions)
-- ============================================
(
  'e0000000-0000-0000-0002-000000000007',
  'd0000000-0000-0000-0000-000000000002',
  '2.7',
  7,
  'Concept Application Quiz',
  'concept-application-quiz',
  'quiz',
  15,
  40,
  'free',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Which decomposition strategy breaks a problem by the ORDER things happen?",
        "options": ["Functional", "Sequential", "Hierarchical", "Random"],
        "correct": 1,
        "explanation": "SEQUENTIAL decomposition breaks problems by the order or sequence in which things happen (first, then, finally)."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Recognizing that all email addresses contain @ is an example of:",
        "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
        "correct": 1,
        "explanation": "This is PATTERN RECOGNITION - identifying a structural pattern that all emails share (the @ symbol)."
      },
      {
        "id": "q3",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Abstraction means including as many details as possible.",
        "correct": false,
        "explanation": "FALSE. Abstraction means HIDING unnecessary details, not including them all."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Breaking a hotel into Front Desk, Housekeeping, and F&B departments is which type of decomposition?",
        "options": ["Sequential", "Hierarchical", "Functional", "Temporal"],
        "correct": 2,
        "explanation": "This is FUNCTIONAL decomposition - breaking by what each department DOES or its function."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel analyzes data and finds: ''Guests who book spa treatments are 70% more likely to return.'' What should they do with this pattern?",
        "options": [
          "Ignore it  it''s just a coincidence",
          "Close the spa to save costs",
          "Promote spa services to all guests to increase return visits",
          "Only allow repeat guests to use the spa"
        ],
        "correct": 2,
        "explanation": "The pattern suggests spa bookings correlate with loyalty. PROMOTING spa services could increase return visits."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A fire escape plan shows exit routes but not the color of the carpet. This is an example of:",
        "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
        "correct": 2,
        "explanation": "This is ABSTRACTION - showing only essential information (exits) while hiding irrelevant details (carpet color)."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Noticing that sales increase every December and hiring extra staff for December is using:",
        "options": ["Only Decomposition", "Only Pattern Recognition", "Pattern Recognition and Abstraction", "Pattern Recognition and Algorithm"],
        "correct": 3,
        "explanation": "This uses PATTERN RECOGNITION (December sales spike) and ALGORITHM (the hiring procedure to respond to it)."
      },
      {
        "id": "q8",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Hierarchical decomposition creates a tree-like structure with levels of detail.",
        "correct": true,
        "explanation": "TRUE. Hierarchical decomposition creates nested levels like a family tree or organization chart."
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which approach helps us reuse solutions from similar problems?",
        "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Debugging"],
        "correct": 1,
        "explanation": "PATTERN RECOGNITION helps identify when current problems are similar to past ones, allowing solution reuse."
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A resort manager notices these patterns: (1) Pool is busiest 2-4pm, (2) Restaurant is busiest 7-9pm, (3) Spa is busiest on rainy days. Which action shows BEST use of these patterns?",
        "options": [
          "Close the pool after 4pm",
          "Only open restaurant at 7pm",
          "Schedule more pool lifeguards 2-4pm, restaurant staff 7-9pm, and spa therapists when rain is forecast",
          "Ignore the patterns since they might change"
        ],
        "correct": 2,
        "explanation": "Option C uses ALL THREE patterns to optimize staffing  this is the best application of pattern recognition."
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "When creating a dashboard for the CEO showing hotel performance, which level of abstraction is MOST appropriate?",
        "options": [
          "Every individual transaction from the past year",
          "High-level KPIs: occupancy %, RevPAR, and guest satisfaction score",
          "Detailed staff schedules and room-by-room status",
          "Raw data from the point-of-sale system"
        ],
        "correct": 1,
        "explanation": "CEOs need HIGH-LEVEL KPIs for strategic decisions. Detailed data would overwhelm and distract from key insights."
      },
      {
        "id": "q12",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel wants to reduce check-in time from 5 minutes to 2 minutes. Which decomposition would be MOST useful?",
        "options": [
          "Functional: Break staff into roles",
          "Sequential: Break check-in into steps (greet, verify, assign room, issue key, explain)",
          "Hierarchical: Break hotel into departments",
          "Any of these would work equally well"
        ],
        "correct": 1,
        "explanation": "SEQUENTIAL decomposition is best here  breaking the check-in PROCESS into steps helps identify which steps take longest and can be optimized."
      },
      {
        "id": "q13",
        "type": "true_false",
        "difficulty": "exam",
        "question": "If two events happen at the same time, they must be causally related (one causes the other).",
        "correct": false,
        "explanation": "FALSE. Correlation does not equal causation. Two things happening together doesn''t mean one causes the other (e.g., ice cream sales and drowning both increase in summer, but neither causes the other)."
      },
      {
        "id": "q14",
        "type": "mcq",
        "difficulty": "exam",
        "question": "When is OVER-abstraction dangerous?",
        "options": [
          "When presenting to executives",
          "When creating simple overviews",
          "When essential details for safety or decisions are hidden",
          "When communicating with customers"
        ],
        "correct": 2,
        "explanation": "Over-abstraction is dangerous when you HIDE ESSENTIAL information  like a doctor saying \"take some medicine\" without specifying which, how much, or for how long."
      },
      {
        "id": "q15",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel found that 95% of guests who complained about slow service ALSO complained about room cleanliness. What is the BEST interpretation?",
        "options": [
          "Slow service causes dirty rooms",
          "Dirty rooms cause slow service",
          "Guests who complain about one thing tend to complain about multiple things (or both issues share a common cause)",
          "This pattern is meaningless"
        ],
        "correct": 2,
        "explanation": "The BEST interpretation is that these are CORRELATED, not causal. Perhaps dissatisfied guests complain about multiple issues, or understaffing causes both problems."
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
-- Activity 2.8: Module 2 Checkpoint (10 questions)
-- ============================================
(
  'e0000000-0000-0000-0002-000000000008',
  'd0000000-0000-0000-0000-000000000002',
  '2.8',
  8,
  'Module 2 Checkpoint',
  'module-2-checkpoint',
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
        "question": "Breaking website development into design, content, and coding is an example of:",
        "options": ["Pattern Recognition", "Abstraction", "Decomposition", "Algorithm"],
        "correct": 2,
        "explanation": "This is DECOMPOSITION - breaking a complex project into smaller, distinct parts."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A subway map that shows connections but not exact distances uses:",
        "options": ["Decomposition", "Pattern Recognition", "Abstraction", "None of these"],
        "correct": 2,
        "explanation": "This is ABSTRACTION - showing essential info (connections) while hiding less relevant details (exact distances)."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Noticing that sales increase every December is an example of:",
        "options": ["Decomposition", "Pattern Recognition", "Abstraction", "Algorithm"],
        "correct": 1,
        "explanation": "Identifying a recurring seasonal trend is PATTERN RECOGNITION."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Functional decomposition breaks a problem by the order things happen.",
        "correct": false,
        "explanation": "FALSE. FUNCTIONAL decomposition breaks by what each part DOES. SEQUENTIAL decomposition breaks by order."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel notices that guests who use the gym are 40% more likely to book again. To use this pattern, they should:",
        "options": [
          "Close the gym to save money",
          "Promote gym access and highlight it in marketing",
          "Charge extra for gym use",
          "Ignore this pattern"
        ],
        "correct": 1,
        "explanation": "If gym usage correlates with repeat bookings, PROMOTING it could increase customer retention."
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "When creating an emergency evacuation plan, you should abstract away:",
        "options": [
          "Exit locations",
          "Escape routes",
          "Room furniture positions",
          "Assembly points"
        ],
        "correct": 2,
        "explanation": "Room furniture is IRRELEVANT to evacuation and should be abstracted away. Exits, routes, and assembly points are essential."
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which type of decomposition would BEST help improve a slow restaurant service?",
        "options": [
          "Hierarchical - organize by management levels",
          "Functional - divide by kitchen, service, host roles",
          "Sequential - break service into order, prepare, serve, pay steps",
          "None - decomposition won''t help"
        ],
        "correct": 2,
        "explanation": "SEQUENTIAL decomposition breaks the service into time-ordered steps, making it easier to identify bottlenecks."
      },
      {
        "id": "cp8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A coffee shop owner notices: Morning customers buy pastries 80% of the time, but afternoon customers rarely do. Using this pattern with abstraction, the BEST action is:",
        "options": [
          "Bake all pastries fresh every hour all day",
          "Bake most pastries for morning rush and reduce afternoon inventory",
          "Stop selling pastries entirely",
          "Focus only on morning customers"
        ],
        "correct": 1,
        "explanation": "This combines PATTERN (morning = pastries) with ABSTRACTION (focus on what matters: timing). Reducing afternoon pastry inventory saves waste while meeting demand."
      },
      {
        "id": "cp9",
        "type": "true_false",
        "difficulty": "exam",
        "question": "Over-abstraction (hiding too many details) can be just as problematic as under-abstraction (showing too many details).",
        "correct": true,
        "explanation": "TRUE. Over-abstraction can hide critical information needed for decisions or safety, while under-abstraction creates information overload."
      },
      {
        "id": "cp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A resort collects 50 data points about each guest. To create a useful \"guest profile\" for front desk staff, they should:",
        "options": [
          "Show all 50 data points to be complete",
          "Show only the 5-8 most relevant points (name, preferences, VIP status, allergies)",
          "Show no information to protect privacy",
          "Show different random data points each time"
        ],
        "correct": 1,
        "explanation": "Good abstraction means showing only RELEVANT information (5-8 points) that staff need for their task. 50 points is overwhelming; 0 points is useless."
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
