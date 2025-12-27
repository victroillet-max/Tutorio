-- ============================================
-- Module 14: Data Analysis Basics - EXPANDED VERSION
-- Adds expanded lessons, quiz questions, and interactive activities
-- ============================================

-- First, delete old Module 14 activities to replace with expanded versions
DELETE FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000014';

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- Activity 14.1: Introduction to Data Analysis (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0014-000000000001',
  'd0000000-0000-0000-0000-000000000014',
  '14.1',
  1,
  'Introduction to Data Analysis',
  'intro-to-data-analysis',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Introduction to Data Analysis\n\n##  Why This Matters\n\nHotels generate massive amounts of data: bookings, revenue, guest preferences, occupancy rates, reviews. **Python excels at analyzing data to find insights that drive business decisions.** From identifying your most profitable room type to predicting busy seasons, data analysis is a hospitality superpower.\n\n---\n\n##  What is Data Analysis?\n\n> **Data Analysis** is the process of inspecting, cleaning, transforming, and modeling data to discover useful information and support decision-making.\n\n### The Data Analysis Pipeline\n\n```\n\n  COLLECT        CLEAN          ANALYZE        VISUALIZE      ACT\n                                                        \n                                                       \n  Gather data    Fix errors     Calculate      Create charts  Make\n  from sources   & format       statistics     & graphs       decisions\n\n```\n\n---\n\n##  Basic Statistics with Python\n\n### Built-in Functions\n\n```python\nrevenue = [12500, 15800, 14200, 18900, 16500, 21000, 19800]\n\n# Basic statistics\ntotal = sum(revenue)                    # Sum of all values\naverage = sum(revenue) / len(revenue)   # Mean\nhighest = max(revenue)                  # Maximum value\nlowest = min(revenue)                   # Minimum value\ncount = len(revenue)                    # Number of items\n\nprint(f\"Total Revenue: ${total:,}\")\nprint(f\"Average: ${average:,.2f}\")\nprint(f\"Range: ${lowest:,} - ${highest:,}\")\nprint(f\"Days: {count}\")\n```\n\n**Output:**\n```\nTotal Revenue: $118,700\nAverage: $16,957.14\nRange: $12,500 - $21,000\nDays: 7\n```\n\n---\n\n##  Sorting Data\n\n```python\nrooms = [405, 102, 301, 208, 501]\n\n# Sort ascending (default)\nsorted_asc = sorted(rooms)\nprint(sorted_asc)  # [102, 208, 301, 405, 501]\n\n# Sort descending\nsorted_desc = sorted(rooms, reverse=True)\nprint(sorted_desc)  # [501, 405, 301, 208, 102]\n\n# Sort in place (modifies original)\nrooms.sort()\nprint(rooms)  # [102, 208, 301, 405, 501]\n```\n\n### Sorting Complex Data\n\n```python\nguests = [\n    {\"name\": \"Alice\", \"nights\": 3, \"spent\": 750},\n    {\"name\": \"Bob\", \"nights\": 5, \"spent\": 1200},\n    {\"name\": \"Charlie\", \"nights\": 2, \"spent\": 400}\n]\n\n# Sort by amount spent (highest first)\nby_spent = sorted(guests, key=lambda g: g[\"spent\"], reverse=True)\n\nfor guest in by_spent:\n    print(f\"{guest[''name'']}: ${guest[''spent'']}\")\n```\n\n**Output:**\n```\nBob: $1200\nAlice: $750\nCharlie: $400\n```\n\n---\n\n##  Filtering Data\n\n```python\noccupancy = [78, 82, 65, 91, 88, 95, 72]\ndays = [\"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\", \"Sun\"]\n\n# Find high occupancy days (above 85%)\nhigh_days = [day for day, occ in zip(days, occupancy) if occ >= 85]\nprint(f\"High occupancy: {high_days}\")  # [''Thu'', ''Fri'', ''Sat'']\n\n# Find low occupancy days\nlow_days = [day for day, occ in zip(days, occupancy) if occ < 75]\nprint(f\"Low occupancy: {low_days}\")    # [''Wed'', ''Sun'']\n```\n\n---\n\n##  Aggregating by Category\n\n```python\nbookings = [\n    {\"type\": \"standard\", \"revenue\": 150},\n    {\"type\": \"deluxe\", \"revenue\": 250},\n    {\"type\": \"standard\", \"revenue\": 150},\n    {\"type\": \"suite\", \"revenue\": 400},\n    {\"type\": \"deluxe\", \"revenue\": 250},\n]\n\n# Sum revenue by room type\nrevenue_by_type = {}\nfor booking in bookings:\n    room_type = booking[\"type\"]\n    if room_type in revenue_by_type:\n        revenue_by_type[room_type] += booking[\"revenue\"]\n    else:\n        revenue_by_type[room_type] = booking[\"revenue\"]\n\nprint(revenue_by_type)\n# {''standard'': 300, ''deluxe'': 500, ''suite'': 400}\n```\n\n---\n\n##  Hotel Analysis Example\n\n### Weekly Revenue Analysis\n\n```python\nweekly_revenue = {\n    \"Mon\": 12500,\n    \"Tue\": 15800,\n    \"Wed\": 14200,\n    \"Thu\": 18900,\n    \"Fri\": 21000,\n    \"Sat\": 23500,\n    \"Sun\": 16100\n}\n\n# Total and average\ntotal = sum(weekly_revenue.values())\naverage = total / len(weekly_revenue)\n\n# Best and worst days\nbest_day = max(weekly_revenue, key=weekly_revenue.get)\nworst_day = min(weekly_revenue, key=weekly_revenue.get)\n\n# Days above average\nabove_avg = [day for day, rev in weekly_revenue.items() if rev > average]\n\nprint(f\"Weekly Total: ${total:,}\")\nprint(f\"Daily Average: ${average:,.2f}\")\nprint(f\"Best Day: {best_day} (${weekly_revenue[best_day]:,})\")\nprint(f\"Worst Day: {worst_day} (${weekly_revenue[worst_day]:,})\")\nprint(f\"Above Average: {above_avg}\")\n```\n\n**Output:**\n```\nWeekly Total: $122,000\nDaily Average: $17,428.57\nBest Day: Sat ($23,500)\nWorst Day: Mon ($12,500)\nAbove Average: [''Thu'', ''Fri'', ''Sat'']\n```\n\n---\n\n##  Summary: Key Takeaways\n\n> **Remember for the exam:**\n> - `sum()`, `min()`, `max()`, `len()` for basic stats\n> - `sorted()` with `key=` for custom sorting\n> - List comprehensions for filtering\n> - Dictionaries for grouping and aggregating"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 14.2: Working with CSV Files (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0014-000000000002',
  'd0000000-0000-0000-0000-000000000014',
  '14.2',
  2,
  'Working with CSV Files',
  'working-with-csv',
  'lesson',
  15,
  30,
  'basic',
  '{"markdown": "# Working with CSV Files\n\n##  Why This Matters\n\nCSV (Comma-Separated Values) is the universal format for spreadsheet data. Your booking system, PMS, and financial software all export CSV. **Python''s csv module lets you automate data processing that would take hours in Excel.**\n\n---\n\n##  What is a CSV File?\n\nA CSV file stores tabular data as plain text:\n\n```\nname,room,nights,total\nAlice Smith,405,3,597\nBob Jones,302,5,995\nCharlie Brown,501,2,598\n```\n\nFirst row = headers, subsequent rows = data, commas = separators.\n\n---\n\n##  Reading CSV Files\n\n### Method 1: csv.reader (List of Lists)\n\n```python\nimport csv\n\nwith open(\"bookings.csv\", \"r\") as f:\n    reader = csv.reader(f)\n    headers = next(reader)  # Skip header row\n    \n    for row in reader:\n        print(row)  # [''Alice Smith'', ''405'', ''3'', ''597'']\n        print(f\"Guest: {row[0]}, Room: {row[1]}\")\n```\n\n### Method 2: csv.DictReader (List of Dictionaries)\n\n```python\nimport csv\n\nwith open(\"bookings.csv\", \"r\") as f:\n    reader = csv.DictReader(f)\n    \n    for row in reader:\n        # row is a dictionary!\n        print(f\"{row[''name'']}: Room {row[''room'']}\")\n        print(f\"  {row[''nights'']} nights = ${row[''total'']}\")\n```\n\n**DictReader is usually better** - you access columns by name, not index!\n\n---\n\n##  Writing CSV Files\n\n### Method 1: csv.writer\n\n```python\nimport csv\n\nbookings = [\n    [\"Alice\", 405, 3, 597],\n    [\"Bob\", 302, 5, 995],\n    [\"Charlie\", 501, 2, 598]\n]\n\nwith open(\"output.csv\", \"w\", newline=\"\") as f:\n    writer = csv.writer(f)\n    writer.writerow([\"name\", \"room\", \"nights\", \"total\"])  # Header\n    writer.writerows(bookings)  # All data rows\n```\n\n### Method 2: csv.DictWriter\n\n```python\nimport csv\n\nbookings = [\n    {\"name\": \"Alice\", \"room\": 405, \"nights\": 3, \"total\": 597},\n    {\"name\": \"Bob\", \"room\": 302, \"nights\": 5, \"total\": 995},\n]\n\nwith open(\"output.csv\", \"w\", newline=\"\") as f:\n    fieldnames = [\"name\", \"room\", \"nights\", \"total\"]\n    writer = csv.DictWriter(f, fieldnames=fieldnames)\n    \n    writer.writeheader()  # Writes header row\n    writer.writerows(bookings)  # Writes all data\n```\n\n---\n\n##  Important: newline=\"\"\n\n```python\n#  Without newline=\"\" - may create blank rows on Windows\nwith open(\"data.csv\", \"w\") as f:\n    writer = csv.writer(f)\n\n#  With newline=\"\" - works correctly everywhere\nwith open(\"data.csv\", \"w\", newline=\"\") as f:\n    writer = csv.writer(f)\n```\n\nAlways use `newline=\"\"` when writing CSV files!\n\n---\n\n##  Hotel Example: Revenue Report\n\n### Reading and Analyzing Booking Data\n\n```python\nimport csv\n\n# Read bookings\nwith open(\"bookings.csv\", \"r\") as f:\n    reader = csv.DictReader(f)\n    bookings = list(reader)\n\n# Calculate statistics\ntotal_revenue = sum(int(b[\"total\"]) for b in bookings)\ntotal_nights = sum(int(b[\"nights\"]) for b in bookings)\navg_per_night = total_revenue / total_nights if total_nights else 0\n\nprint(f\"Total Bookings: {len(bookings)}\")\nprint(f\"Total Revenue: ${total_revenue:,}\")\nprint(f\"Total Nights: {total_nights}\")\nprint(f\"Avg Revenue/Night: ${avg_per_night:.2f}\")\n```\n\n### Generating a Summary Report\n\n```python\nimport csv\n\n# Read data\nwith open(\"bookings.csv\", \"r\") as f:\n    bookings = list(csv.DictReader(f))\n\n# Group by room type\nrevenue_by_type = {}\nfor booking in bookings:\n    room_type = booking[\"type\"]\n    revenue = int(booking[\"total\"])\n    \n    if room_type in revenue_by_type:\n        revenue_by_type[room_type] += revenue\n    else:\n        revenue_by_type[room_type] = revenue\n\n# Write summary\nwith open(\"summary.csv\", \"w\", newline=\"\") as f:\n    writer = csv.writer(f)\n    writer.writerow([\"Room Type\", \"Total Revenue\"])\n    \n    for room_type, revenue in revenue_by_type.items():\n        writer.writerow([room_type, revenue])\n\nprint(\"Summary report generated!\")\n```\n\n---\n\n##  Common Mistakes\n\n### Mistake 1: Treating Numbers as Strings\n\n```python\nimport csv\n\nwith open(\"data.csv\", \"r\") as f:\n    reader = csv.DictReader(f)\n    for row in reader:\n        # CSV values are always strings!\n        total = row[\"total\"]  # \"597\" (string)\n        total = int(row[\"total\"])  # 597 (integer)\n```\n\n### Mistake 2: Forgetting to Close Files\n\n```python\n#  Bad - file may not close properly\nf = open(\"data.csv\")\nreader = csv.reader(f)\n# ... forgot to close!\n\n#  Good - with statement auto-closes\nwith open(\"data.csv\") as f:\n    reader = csv.reader(f)\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - `csv.DictReader` for reading (access by column name)\n> - `csv.DictWriter` for writing dictionaries\n> - Always use `newline=\"\"` when writing\n> - CSV values are strings - convert as needed\n> - Use `with` statement for file handling"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 14.3: Analyzing Collections (Expanded)
-- ============================================
(
  'e0000000-0000-0000-0014-000000000003',
  'd0000000-0000-0000-0000-000000000014',
  '14.3',
  3,
  'Analyzing Collections',
  'analyzing-collections',
  'lesson',
  12,
  25,
  'basic',
  '{"markdown": "# Analyzing Collections\n\n##  Why This Matters\n\nWhether it''s a list of room prices, a dictionary of guest preferences, or booking data, **knowing how to analyze collections efficiently is essential** for any data-driven decision in hospitality.\n\n---\n\n##  List Analysis Techniques\n\n### Finding Extremes\n\n```python\noccupancy_rates = [78, 82, 65, 91, 88, 95, 72]\n\n# Maximum and minimum\nhighest = max(occupancy_rates)  # 95\nlowest = min(occupancy_rates)   # 65\n\n# Index of extremes\nhighest_index = occupancy_rates.index(max(occupancy_rates))  # 5\nlowest_index = occupancy_rates.index(min(occupancy_rates))   # 2\n\ndays = [\"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\", \"Sun\"]\nprint(f\"Best day: {days[highest_index]} ({highest}%)\")\nprint(f\"Worst day: {days[lowest_index]} ({lowest}%)\")\n```\n\n### Counting Occurrences\n\n```python\nroom_types = [\"standard\", \"deluxe\", \"standard\", \"suite\", \n              \"standard\", \"deluxe\", \"standard\"]\n\n# Count specific value\nstandard_count = room_types.count(\"standard\")  # 4\n\n# Count all values\nfrom collections import Counter\ncounts = Counter(room_types)\nprint(counts)  # Counter({''standard'': 4, ''deluxe'': 2, ''suite'': 1})\nprint(counts[\"deluxe\"])  # 2\n```\n\n---\n\n##  Dictionary Analysis Techniques\n\n### Finding Keys by Values\n\n```python\nroom_rates = {\n    \"standard\": 150,\n    \"deluxe\": 250,\n    \"suite\": 400,\n    \"penthouse\": 800\n}\n\n# Find cheapest room type\ncheapest_type = min(room_rates, key=room_rates.get)\nprint(f\"Cheapest: {cheapest_type}\")  # standard\n\n# Find most expensive\nexpensive_type = max(room_rates, key=room_rates.get)\nprint(f\"Most expensive: {expensive_type}\")  # penthouse\n\n# All rooms under $300\naffordable = {k: v for k, v in room_rates.items() if v < 300}\nprint(affordable)  # {''standard'': 150, ''deluxe'': 250}\n```\n\n### Aggregating Dictionary Values\n\n```python\nmonthly_revenue = {\n    \"Jan\": 125000,\n    \"Feb\": 118000,\n    \"Mar\": 142000,\n    \"Apr\": 135000\n}\n\n# Total revenue\ntotal = sum(monthly_revenue.values())  # 520000\n\n# Average monthly revenue\naverage = total / len(monthly_revenue)  # 130000\n\n# Months above average\nabove_avg = [m for m, r in monthly_revenue.items() if r > average]\nprint(f\"Above average: {above_avg}\")  # [''Mar'', ''Apr'']\n```\n\n---\n\n##  Working with Nested Data\n\n### List of Dictionaries\n\n```python\nguests = [\n    {\"name\": \"Alice\", \"room\": 405, \"vip\": True, \"spent\": 1250},\n    {\"name\": \"Bob\", \"room\": 302, \"vip\": False, \"spent\": 450},\n    {\"name\": \"Charlie\", \"room\": 501, \"vip\": True, \"spent\": 2100},\n    {\"name\": \"Diana\", \"room\": 201, \"vip\": False, \"spent\": 380}\n]\n\n# Filter VIP guests\nvips = [g for g in guests if g[\"vip\"]]\nprint(f\"VIP count: {len(vips)}\")  # 2\n\n# Total VIP spending\nvip_spending = sum(g[\"spent\"] for g in vips)\nprint(f\"VIP spending: ${vip_spending:,}\")  # $3,350\n\n# Sort by spending (highest first)\nby_spending = sorted(guests, key=lambda g: g[\"spent\"], reverse=True)\nfor g in by_spending:\n    print(f\"{g[''name'']}: ${g[''spent'']}\")\n\n# Find top spender\ntop_spender = max(guests, key=lambda g: g[\"spent\"])\nprint(f\"Top spender: {top_spender[''name'']} (${top_spender[''spent'']})\")\n```\n\n---\n\n##  Percentage Calculations\n\n```python\nrevenue = {\n    \"rooms\": 125000,\n    \"restaurant\": 45000,\n    \"spa\": 18000,\n    \"other\": 12000\n}\n\ntotal = sum(revenue.values())\n\nprint(\"Revenue Breakdown:\")\nprint(\"-\" * 30)\nfor category, amount in revenue.items():\n    percent = (amount / total) * 100\n    bar = \"#\" * int(percent / 2)  # Visual bar\n    print(f\"{category.title():12} ${amount:>8,} ({percent:5.1f}%) {bar}\")\nprint(\"-\" * 30)\nprint(f\"Total        ${total:>8,}\")\n```\n\n**Output:**\n```\nRevenue Breakdown:\n------------------------------\nRooms         $125,000 (62.5%) ###############################\nRestaurant     $45,000 (22.5%) ###########\nSpa            $18,000 ( 9.0%) ####\nOther          $12,000 ( 6.0%) ###\n------------------------------\nTotal         $200,000\n```\n\n---\n\n##  Summary\n\n> **Key Points:**\n> - `max()`, `min()` with `key=` for custom comparisons\n> - `Counter` for counting occurrences\n> - List comprehensions for filtering\n> - `sorted()` with `key=lambda` for complex sorting\n> - Dictionary comprehensions for filtering dicts"}'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 14.4: Data Analysis Practice
-- ============================================
(
  'e0000000-0000-0000-0014-000000000004',
  'd0000000-0000-0000-0000-000000000014',
  '14.4',
  4,
  'Data Analysis Practice',
  'data-analysis-practice',
  'code',
  15,
  45,
  'basic',
  '{
    "instructions": "Analyze hotel booking data and generate insights!\n\n**Given Data:** A list of bookings with guest name, room type, nights, and total spent.\n\n**Tasks:**\n1. Calculate total revenue from all bookings\n2. Find the average spend per booking\n3. Count how many of each room type was booked\n4. Find the guest who spent the most\n5. List all guests who stayed 3+ nights",
    "starterCode": "# Hotel Booking Data\nbookings = [\n    {\"guest\": \"Alice\", \"type\": \"deluxe\", \"nights\": 3, \"spent\": 750},\n    {\"guest\": \"Bob\", \"type\": \"standard\", \"nights\": 2, \"spent\": 300},\n    {\"guest\": \"Charlie\", \"type\": \"suite\", \"nights\": 5, \"spent\": 2000},\n    {\"guest\": \"Diana\", \"type\": \"standard\", \"nights\": 1, \"spent\": 150},\n    {\"guest\": \"Eve\", \"type\": \"deluxe\", \"nights\": 4, \"spent\": 1000},\n    {\"guest\": \"Frank\", \"type\": \"standard\", \"nights\": 3, \"spent\": 450}\n]\n\n# Task 1: Calculate total revenue\n\n\n# Task 2: Calculate average spend per booking\n\n\n# Task 3: Count room types (hint: create a dictionary)\n\n\n# Task 4: Find top spender\n\n\n# Task 5: List guests with 3+ nights stay\n",
    "solution": "# Hotel Booking Data\nbookings = [\n    {\"guest\": \"Alice\", \"type\": \"deluxe\", \"nights\": 3, \"spent\": 750},\n    {\"guest\": \"Bob\", \"type\": \"standard\", \"nights\": 2, \"spent\": 300},\n    {\"guest\": \"Charlie\", \"type\": \"suite\", \"nights\": 5, \"spent\": 2000},\n    {\"guest\": \"Diana\", \"type\": \"standard\", \"nights\": 1, \"spent\": 150},\n    {\"guest\": \"Eve\", \"type\": \"deluxe\", \"nights\": 4, \"spent\": 1000},\n    {\"guest\": \"Frank\", \"type\": \"standard\", \"nights\": 3, \"spent\": 450}\n]\n\n# Task 1: Calculate total revenue\ntotal_revenue = sum(b[\"spent\"] for b in bookings)\nprint(\"Total Revenue: $\" + str(total_revenue))\n\n# Task 2: Calculate average spend per booking\naverage = total_revenue / len(bookings)\nprint(\"Average Spend: $\" + str(round(average, 2)))\n\n# Task 3: Count room types\ntype_counts = {}\nfor b in bookings:\n    room_type = b[\"type\"]\n    type_counts[room_type] = type_counts.get(room_type, 0) + 1\nprint(\"Room Types:\", type_counts)\n\n# Task 4: Find top spender\ntop_spender = max(bookings, key=lambda b: b[\"spent\"])\nname = top_spender[\"guest\"]\nspent = top_spender[\"spent\"]\nprint(\"Top Spender:\", name, \"($\" + str(spent) + \")\")\n\n# Task 5: List guests with 3+ nights stay\nlong_stays = [b[\"guest\"] for b in bookings if b[\"nights\"] >= 3]\nprint(\"Long Stays (3+ nights):\", long_stays)",
    "testCases": [
      {"input": "", "expectedOutput": "Total Revenue: $4,650", "description": "Total revenue calculated"},
      {"input": "", "expectedOutput": "Average Spend:", "description": "Average calculated"},
      {"input": "", "expectedOutput": "Top Spender: Charlie", "description": "Top spender found"},
      {"input": "", "expectedOutput": "Long Stays", "description": "Long stays filtered"}
    ],
    "hints": [
      "Use sum() with a generator: sum(b[\"spent\"] for b in bookings)",
      "dict.get(key, 0) returns 0 if key doesn''t exist",
      "max() with key=lambda finds the item with highest value",
      "List comprehension: [b[\"guest\"] for b in bookings if b[\"nights\"] >= 3]"
    ]
  }'::jsonb,
  NULL,
  false,
  true
),

-- ============================================
-- Activity 14.5: Data Analysis Quiz (12 questions)
-- ============================================
(
  'e0000000-0000-0000-0014-000000000005',
  'd0000000-0000-0000-0000-000000000014',
  '14.5',
  5,
  'Data Analysis Quiz',
  'data-analysis-quiz',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "How do you find the average of a list of numbers?",
        "options": ["average(list)", "list.avg()", "sum(list) / len(list)", "mean(list)"],
        "correct": 2,
        "explanation": "Python doesn''t have a built-in average function. Use sum(list) / len(list)."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What module is used to read CSV files?",
        "options": ["file", "csv", "data", "excel"],
        "correct": 1,
        "explanation": "The csv module handles CSV file reading and writing."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does sorted(data, reverse=True) do?",
        "options": ["Sorts ascending", "Sorts descending", "Reverses without sorting", "Returns the original list"],
        "correct": 1,
        "explanation": "reverse=True sorts in descending order (highest to lowest)."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What type of values does csv.DictReader return for each row?",
        "options": ["Lists", "Tuples", "Dictionaries", "Strings"],
        "correct": 2,
        "explanation": "DictReader returns each row as a dictionary with column headers as keys."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "How do you find the key with the maximum value in a dictionary?\n\nprices = {\"a\": 100, \"b\": 200, \"c\": 150}",
        "options": [
          "max(prices)",
          "max(prices.values())",
          "max(prices, key=prices.get)",
          "prices.max()"
        ],
        "correct": 2,
        "explanation": "max(prices, key=prices.get) returns the KEY with the highest value. max(prices.values()) returns only the value."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What does sorted(data, key=lambda x: x[\"price\"]) do?",
        "options": ["Filters by price", "Sorts by price ascending", "Groups by price", "Sums prices"],
        "correct": 1,
        "explanation": "sorted() with key sorts by the specified attribute. Default is ascending order."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the output?\n\nitems = [\"a\", \"b\", \"a\", \"c\", \"a\"]\nprint(items.count(\"a\"))",
        "options": ["1", "2", "3", "Error"],
        "correct": 2,
        "explanation": "count() returns how many times the value appears in the list. \"a\" appears 3 times."
      },
      {
        "id": "q8",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Why should you use newline=\"\" when writing CSV files?",
        "options": [
          "It''s faster",
          "To prevent extra blank rows on some systems",
          "It''s required by Python",
          "To add line numbers"
        ],
        "correct": 1,
        "explanation": "Without newline=\"\", CSV writers may add extra blank rows on Windows systems."
      },
      {
        "id": "q9",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\ndata = [{\"n\": 3}, {\"n\": 1}, {\"n\": 2}]\nresult = sorted(data, key=lambda x: x[\"n\"])\nprint([d[\"n\"] for d in result])",
        "options": ["[3, 1, 2]", "[1, 2, 3]", "[3, 2, 1]", "Error"],
        "correct": 1,
        "explanation": "sorted() with key sorts by the specified field. Default is ascending: [1, 2, 3]."
      },
      {
        "id": "q10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is printed?\n\nfrom collections import Counter\nitems = [\"a\", \"b\", \"a\", \"a\", \"b\", \"c\"]\nc = Counter(items)\nprint(c.most_common(1))",
        "options": [
          "a",
          "[\"a\"]",
          "[(\"a\", 3)]",
          "3"
        ],
        "correct": 2,
        "explanation": "most_common(1) returns a list of tuples with the most common element and its count."
      },
      {
        "id": "q11",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which correctly reads a CSV and calculates total from the \"amount\" column?\n\nAssume amounts are integers.",
        "options": [
          "sum(row[\"amount\"] for row in reader)",
          "sum(int(row[\"amount\"]) for row in reader)",
          "total(reader[\"amount\"])",
          "reader.sum(\"amount\")"
        ],
        "correct": 1,
        "explanation": "CSV values are strings! You must convert to int: int(row[\"amount\"])"
      },
      {
        "id": "q12",
        "type": "true_false",
        "difficulty": "exam",
        "question": "csv.DictReader automatically converts numeric strings to integers.",
        "correct": false,
        "explanation": "FALSE. All CSV values are read as strings. You must convert them yourself: int(row[\"column\"])"
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
-- Activity 14.6: Data Analysis Challenge
-- ============================================
(
  'e0000000-0000-0000-0014-000000000006',
  'd0000000-0000-0000-0000-000000000014',
  '14.6',
  6,
  'Challenge: Revenue Report Generator',
  'revenue-report-challenge',
  'challenge',
  20,
  60,
  'basic',
  '{
    "type": "coding-challenge",
    "title": "Revenue Report Generator",
    "instructions": "Create a comprehensive revenue analysis report for a hotel!\n\n**Scenario:**\nYou''re the data analyst for Grand Hotel. Management wants a weekly revenue report with key insights.\n\n**Given Data:**\nDaily revenue data for one week, broken down by department.\n\n**Requirements:**\n1. Calculate total revenue for each department\n2. Calculate total weekly revenue\n3. Find the best and worst performing days\n4. Calculate percentage contribution of each department\n5. Identify which departments exceed the daily average\n\n**Expected Output Format:**\n```\n=== GRAND HOTEL WEEKLY REVENUE REPORT ===\n\nDepartment Totals:\n  Rooms: $XX,XXX (XX.X%)\n  Restaurant: $XX,XXX (XX.X%)\n  Spa: $XX,XXX (XX.X%)\n\nTotal Weekly Revenue: $XX,XXX\n\nBest Day: [Day] ($XX,XXX)\nWorst Day: [Day] ($XX,XXX)\n\nAbove Average Days: [list]\n```",
    "starterCode": "# Weekly Revenue Data (by day, by department)\nweekly_data = {\n    \"Monday\": {\"rooms\": 12500, \"restaurant\": 3200, \"spa\": 1800},\n    \"Tuesday\": {\"rooms\": 14200, \"restaurant\": 2800, \"spa\": 2100},\n    \"Wednesday\": {\"rooms\": 13800, \"restaurant\": 3100, \"spa\": 1500},\n    \"Thursday\": {\"rooms\": 15600, \"restaurant\": 3800, \"spa\": 2400},\n    \"Friday\": {\"rooms\": 18900, \"restaurant\": 4500, \"spa\": 3200},\n    \"Saturday\": {\"rooms\": 21500, \"restaurant\": 5200, \"spa\": 4100},\n    \"Sunday\": {\"rooms\": 16800, \"restaurant\": 4100, \"spa\": 2800}\n}\n\n# Your code here - Generate the revenue report!\n\nprint(\"=== GRAND HOTEL WEEKLY REVENUE REPORT ===\")\nprint()\n\n# Step 1: Calculate department totals\n\n\n# Step 2: Calculate total weekly revenue and percentages\n\n\n# Step 3: Find best and worst days\n\n\n# Step 4: Calculate daily average and find above-average days\n",
    "solution": "# Weekly Revenue Data\nweekly_data = {\n    \"Monday\": {\"rooms\": 12500, \"restaurant\": 3200, \"spa\": 1800},\n    \"Tuesday\": {\"rooms\": 14200, \"restaurant\": 2800, \"spa\": 2100},\n    \"Wednesday\": {\"rooms\": 13800, \"restaurant\": 3100, \"spa\": 1500},\n    \"Thursday\": {\"rooms\": 15600, \"restaurant\": 3800, \"spa\": 2400},\n    \"Friday\": {\"rooms\": 18900, \"restaurant\": 4500, \"spa\": 3200},\n    \"Saturday\": {\"rooms\": 21500, \"restaurant\": 5200, \"spa\": 4100},\n    \"Sunday\": {\"rooms\": 16800, \"restaurant\": 4100, \"spa\": 2800}\n}\n\nprint(\"=== GRAND HOTEL WEEKLY REVENUE REPORT ===\")\nprint()\n\n# Step 1: Calculate department totals\ndept_totals = {\"rooms\": 0, \"restaurant\": 0, \"spa\": 0}\nfor day, depts in weekly_data.items():\n    for dept, amount in depts.items():\n        dept_totals[dept] += amount\n\n# Step 2: Calculate total and percentages\ntotal_revenue = sum(dept_totals.values())\n\nprint(\"Department Totals:\")\nfor dept, amount in dept_totals.items():\n    pct = (amount / total_revenue) * 100\n    print(f\"  {dept.title()}: ${amount:,} ({pct:.1f}%)\")\nprint()\n\nprint(f\"Total Weekly Revenue: ${total_revenue:,}\")\nprint()\n\n# Step 3: Daily totals for best/worst\ndaily_totals = {}\nfor day, depts in weekly_data.items():\n    daily_totals[day] = sum(depts.values())\n\nbest_day = max(daily_totals, key=daily_totals.get)\nworst_day = min(daily_totals, key=daily_totals.get)\n\nprint(f\"Best Day: {best_day} (${daily_totals[best_day]:,})\")\nprint(f\"Worst Day: {worst_day} (${daily_totals[worst_day]:,})\")\nprint()\n\n# Step 4: Above average days\navg_daily = total_revenue / len(weekly_data)\nabove_avg = [day for day, total in daily_totals.items() if total > avg_daily]\nprint(f\"Above Average Days: {above_avg}\")",
    "rubric": [
      {"criterion": "Department totals calculated correctly", "points": 15},
      {"criterion": "Percentages calculated correctly", "points": 15},
      {"criterion": "Best and worst days identified", "points": 15},
      {"criterion": "Above average days found", "points": 10},
      {"criterion": "Clean, formatted output", "points": 5}
    ],
    "hints": [
      "Initialize department totals as a dictionary with 0 values",
      "Use nested loops: for day, depts in weekly_data.items()",
      "max(dict, key=dict.get) finds key with maximum value",
      "Daily average = total / len(weekly_data)"
    ]
  }'::jsonb,
  'coding-challenge',
  false,
  true
),

-- ============================================
-- Activity 14.7: Data Analysis Visualizer (Interactive)
-- ============================================
(
  'e0000000-0000-0000-0014-000000000007',
  'd0000000-0000-0000-0000-000000000014',
  '14.7',
  7,
  'Data Analysis Visualizer',
  'data-analysis-visualizer',
  'interactive',
  10,
  35,
  'basic',
  '{
    "instructions": "Match each data analysis task with the correct Python approach!",
    "type": "drag-drop-match",
    "pairs": [
      {"left": "Find the maximum value in a list", "right": "max(list)", "explanation": "max() returns the largest value in a sequence."},
      {"left": "Count occurrences of an item", "right": "list.count(item)", "explanation": "count() returns how many times an item appears."},
      {"left": "Sort a list of dictionaries by a key", "right": "sorted(list, key=lambda x: x[\"key\"])", "explanation": "Use key=lambda to specify the sort criterion."},
      {"left": "Filter items meeting a condition", "right": "List comprehension with if", "explanation": "[x for x in list if condition] filters items."},
      {"left": "Find key with max value in dict", "right": "max(dict, key=dict.get)", "explanation": "key=dict.get compares by dictionary values."},
      {"left": "Read CSV as dictionaries", "right": "csv.DictReader(file)", "explanation": "DictReader returns each row as a dictionary."},
      {"left": "Calculate percentage", "right": "(part / total) * 100", "explanation": "Divide part by total and multiply by 100."},
      {"left": "Group and sum by category", "right": "Dictionary accumulation loop", "explanation": "Loop through items, adding to dict values."}
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
-- Activity 14.8: Module 14 Checkpoint (10 questions)
-- ============================================
(
  'e0000000-0000-0000-0014-000000000008',
  'd0000000-0000-0000-0000-000000000014',
  '14.8',
  8,
  'Module 14 Checkpoint',
  'module-14-checkpoint',
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
        "question": "What is data analysis?",
        "options": [
          "Writing code",
          "Inspecting, cleaning, and transforming data to find insights",
          "Designing databases",
          "Creating user interfaces"
        ],
        "correct": 1,
        "explanation": "Data analysis is the process of inspecting, cleaning, transforming, and modeling data to discover useful information."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does sum([10, 20, 30]) / len([10, 20, 30]) calculate?",
        "options": ["Median", "Mode", "Average (mean)", "Range"],
        "correct": 2,
        "explanation": "sum() / len() calculates the arithmetic mean (average)."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "difficulty": "basic",
        "question": "What does csv.DictReader do?",
        "options": [
          "Reads CSV as a single string",
          "Reads each row as a dictionary",
          "Writes dictionaries to CSV",
          "Converts CSV to JSON"
        ],
        "correct": 1,
        "explanation": "DictReader reads each row as a dictionary with column headers as keys."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "How do you sort a list of dictionaries by the \"price\" key in descending order?",
        "options": [
          "sorted(list, key=\"price\")",
          "sorted(list, key=lambda x: x[\"price\"], reverse=True)",
          "list.sort(\"price\", desc=True)",
          "sort(list, by=\"price\", order=\"desc\")"
        ],
        "correct": 1,
        "explanation": "Use sorted() with key=lambda and reverse=True for descending order."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which correctly filters a list to items where amount > 100?\n\ndata = [{\"amount\": 50}, {\"amount\": 150}, {\"amount\": 200}]",
        "options": [
          "data.filter(amount > 100)",
          "[d for d in data if d[\"amount\"] > 100]",
          "filter(data, \"amount > 100\")",
          "data[\"amount\"] > 100"
        ],
        "correct": 1,
        "explanation": "Use list comprehension with condition: [d for d in data if d[\"amount\"] > 100]"
      },
      {
        "id": "cp6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "What is the issue with this code?\n\nwith open(\"data.csv\", \"r\") as f:\n    reader = csv.DictReader(f)\n    for row in reader:\n        total += row[\"amount\"]",
        "options": [
          "Wrong file mode",
          "CSV values are strings, need int(row[\"amount\"])",
          "DictReader doesn''t work with for loops",
          "Missing import csv"
        ],
        "correct": 1,
        "explanation": "CSV values are always strings. You must convert: int(row[\"amount\"])"
      },
      {
        "id": "cp7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What is the output?\n\nscores = {\"A\": 85, \"B\": 92, \"C\": 78}\ntop = max(scores, key=scores.get)\nprint(top)",
        "options": ["92", "B", "{\"B\": 92}", "Error"],
        "correct": 1,
        "explanation": "max() with key=scores.get returns the KEY with the maximum value, not the value itself."
      },
      {
        "id": "cp8",
        "type": "mcq",
        "difficulty": "exam",
        "question": "What does this list comprehension produce?\n\n[x[\"name\"] for x in guests if x[\"vip\"]]",
        "options": [
          "All guest names",
          "Names of VIP guests only",
          "True/False list",
          "Error"
        ],
        "correct": 1,
        "explanation": "This extracts the \"name\" field only from items where \"vip\" is True."
      },
      {
        "id": "cp9",
        "type": "true_false",
        "difficulty": "exam",
        "question": "sorted() modifies the original list in place.",
        "correct": false,
        "explanation": "FALSE. sorted() returns a NEW sorted list. The original list is unchanged. Use list.sort() to sort in place."
      },
      {
        "id": "cp10",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel manager wants to find which day had the highest occupancy.\n\noccupancy = {\"Mon\": 75, \"Tue\": 82, \"Wed\": 68, \"Thu\": 91, \"Fri\": 95}\n\nWhich code finds the answer?",
        "options": [
          "max(occupancy)",
          "max(occupancy.values())",
          "max(occupancy, key=occupancy.get)",
          "occupancy.max()"
        ],
        "correct": 2,
        "explanation": "max(occupancy, key=occupancy.get) returns \"Fri\" (the key with max value). max(occupancy.values()) would only return 95 (the value)."
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

