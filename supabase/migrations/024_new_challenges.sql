-- ============================================
-- New Coding Challenges Across Modules 5-12
-- Adds 12 new challenges to reach the 15-20 target
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- ============================================
-- MODULE 5: Variables & Data Types - Challenge
-- ============================================
(
  'e0000000-0000-0000-0005-000000000099',
  'd0000000-0000-0000-0000-000000000005',
  '5.99',
  99,
  'Challenge: Guest Calculator',
  'guest-calculator-challenge',
  'challenge',
  15,
  50,
  'basic',
  '{
    "type": "coding-challenge",
    "title": "Hotel Guest Bill Calculator",
    "instructions": "Create a guest bill calculator that demonstrates your understanding of variables and data types!\n\n**Scenario:**\nA guest checks out and you need to calculate their total bill.\n\n**Given Information:**\n- Room rate: $199.99 per night\n- Number of nights: 4\n- Room service charges: $85.50\n- Spa treatment: $120.00\n- Tax rate: 12%\n- Guest is a loyalty member (10% discount before tax)\n\n**Requirements:**\n1. Store each value in appropriately named variables\n2. Calculate subtotal (room + services)\n3. Apply loyalty discount to subtotal\n4. Calculate tax on discounted amount\n5. Calculate final total\n6. Print a formatted receipt with all values",
    "starterCode": "# Hotel Bill Calculator\n# Complete this challenge!\n\n# Step 1: Define all the values as variables\nroom_rate = 199.99\n# Add more variables...\n\n# Step 2: Calculate room charges\n\n\n# Step 3: Calculate subtotal (rooms + all services)\n\n\n# Step 4: Apply loyalty discount (10%)\n\n\n# Step 5: Calculate tax (12%)\n\n\n# Step 6: Calculate final total\n\n\n# Step 7: Print formatted receipt\nprint(\"=\"*40)\nprint(\"     GRAND HOTEL RECEIPT\")\nprint(\"=\"*40)\n# Add more print statements...\n",
    "solution": "# Hotel Bill Calculator\n\n# Step 1: Define all the values as variables\nroom_rate = 199.99\nnights = 4\nroom_service = 85.50\nspa = 120.00\ntax_rate = 0.12\ndiscount_rate = 0.10\n\n# Step 2: Calculate room charges\nroom_total = room_rate * nights\n\n# Step 3: Calculate subtotal (rooms + all services)\nsubtotal = room_total + room_service + spa\n\n# Step 4: Apply loyalty discount (10%)\ndiscount = subtotal * discount_rate\ndiscounted_subtotal = subtotal - discount\n\n# Step 5: Calculate tax (12%)\ntax = discounted_subtotal * tax_rate\n\n# Step 6: Calculate final total\nfinal_total = discounted_subtotal + tax\n\n# Step 7: Print formatted receipt\nprint(\"=\"*40)\nprint(\"     GRAND HOTEL RECEIPT\")\nprint(\"=\"*40)\nprint(f\"Room ({nights} nights @ ${room_rate}):  ${room_total:>10.2f}\")\nprint(f\"Room Service:                   ${room_service:>10.2f}\")\nprint(f\"Spa Treatment:                  ${spa:>10.2f}\")\nprint(\"-\"*40)\nprint(f\"Subtotal:                       ${subtotal:>10.2f}\")\nprint(f\"Loyalty Discount (10%):         -${discount:>9.2f}\")\nprint(\"-\"*40)\nprint(f\"After Discount:                 ${discounted_subtotal:>10.2f}\")\nprint(f\"Tax (12%):                      ${tax:>10.2f}\")\nprint(\"=\"*40)\nprint(f\"TOTAL DUE:                      ${final_total:>10.2f}\")\nprint(\"=\"*40)\nprint(\"Thank you for staying with us!\")",
    "rubric": [
      {"criterion": "All values stored in variables with good names", "points": 10},
      {"criterion": "Room total calculated correctly", "points": 10},
      {"criterion": "Discount applied correctly", "points": 10},
      {"criterion": "Tax calculated on discounted amount", "points": 10},
      {"criterion": "Final total is correct", "points": 10}
    ],
    "hints": [
      "Room total = rate * nights",
      "Discount is subtracted from subtotal BEFORE adding tax",
      "Use f-strings with :.2f for money formatting",
      "Expected final total should be around $1,089.19"
    ]
  }'::jsonb,
  'coding-challenge',
  false,
  true
),

-- ============================================
-- MODULE 6: Conditionals - Challenge
-- ============================================
(
  'e0000000-0000-0000-0006-000000000099',
  'd0000000-0000-0000-0000-000000000006',
  '6.99',
  99,
  'Challenge: Room Upgrade Decider',
  'room-upgrade-challenge',
  'challenge',
  15,
  50,
  'basic',
  '{
    "type": "coding-challenge",
    "title": "Automatic Room Upgrade System",
    "instructions": "Build a room upgrade decision system using conditionals!\n\n**Upgrade Rules:**\n1. VIP members ALWAYS get an upgrade\n2. Guests staying 5+ nights get an upgrade\n3. Guests on their birthday get an upgrade\n4. During low occupancy (<50%), everyone gets an upgrade\n5. Otherwise, no upgrade\n\n**Upgrade Levels:**\n- Standard  Deluxe\n- Deluxe  Suite\n- Suite  Penthouse\n- Penthouse  Penthouse (already at top)\n\n**Your Task:**\nWrite code that determines the upgrade and prints appropriate messages.",
    "starterCode": "# Room Upgrade Decision System\n\n# Guest information (change these to test different scenarios)\nguest_name = \"Sarah Johnson\"\ncurrent_room = \"standard\"  # standard, deluxe, suite, or penthouse\nis_vip = False\nnights_staying = 3\nis_birthday = True\ncurrent_occupancy = 65  # percentage\n\n# Determine if guest qualifies for upgrade\nqualifies = False\nreason = \"\"\n\n# Check upgrade conditions (complete the logic)\n\n\n# Determine new room type if upgraded\n\n\n# Print the result\n",
    "solution": "# Room Upgrade Decision System\n\n# Guest information\nguest_name = \"Sarah Johnson\"\ncurrent_room = \"standard\"\nis_vip = False\nnights_staying = 3\nis_birthday = True\ncurrent_occupancy = 65\n\n# Determine if guest qualifies for upgrade\nqualifies = False\nreason = \"\"\n\n# Check upgrade conditions\nif is_vip:\n    qualifies = True\n    reason = \"VIP member\"\nelif nights_staying >= 5:\n    qualifies = True\n    reason = f\"staying {nights_staying} nights\"\nelif is_birthday:\n    qualifies = True\n    reason = \"birthday celebration\"\nelif current_occupancy < 50:\n    qualifies = True\n    reason = \"low occupancy special\"\n\n# Determine new room type\nupgrade_map = {\n    \"standard\": \"deluxe\",\n    \"deluxe\": \"suite\",\n    \"suite\": \"penthouse\",\n    \"penthouse\": \"penthouse\"\n}\n\nprint(\"=\"*45)\nprint(\"   ROOM UPGRADE DECISION SYSTEM\")\nprint(\"=\"*45)\nprint(f\"Guest: {guest_name}\")\nprint(f\"Current Room: {current_room.title()}\")\nprint(\"-\"*45)\n\nif qualifies:\n    new_room = upgrade_map[current_room]\n    if new_room == current_room:\n        print(f\"RESULT: Already in {current_room.title()}!\")\n        print(f\"(Qualified due to: {reason})\")\n        print(\"Offering complimentary amenity instead.\")\n    else:\n        print(f\"UPGRADE APPROVED!\")\n        print(f\"Reason: {reason}\")\n        print(f\"New Room: {new_room.title()}\")\nelse:\n    print(\"No upgrade available.\")\n    print(\"Guest does not meet upgrade criteria.\")\n\nprint(\"=\"*45)",
    "rubric": [
      {"criterion": "All four upgrade conditions checked", "points": 15},
      {"criterion": "Correct use of if/elif/else", "points": 10},
      {"criterion": "Room upgrade logic works correctly", "points": 10},
      {"criterion": "Handles penthouse case (already at top)", "points": 10},
      {"criterion": "Clear output messages", "points": 5}
    ],
    "hints": [
      "Use if/elif/else chain for conditions",
      "A dictionary can map room types to their upgrades",
      "Check if new_room == current_room for penthouse case",
      "Remember: only ONE upgrade reason should be shown"
    ]
  }'::jsonb,
  'coding-challenge',
  false,
  true
),

-- ============================================
-- MODULE 7: Loops - Challenge
-- ============================================
(
  'e0000000-0000-0000-0007-000000000099',
  'd0000000-0000-0000-0000-000000000007',
  '7.99',
  99,
  'Challenge: Occupancy Analyzer',
  'occupancy-analyzer-challenge',
  'challenge',
  18,
  55,
  'basic',
  '{
    "type": "coding-challenge",
    "title": "Weekly Occupancy Analyzer",
    "instructions": "Create an occupancy analysis tool using loops!\n\n**Scenario:**\nYou have weekly occupancy data (percentage) for a hotel. Analyze it to generate insights.\n\n**Requirements:**\n1. Calculate average occupancy for the week\n2. Count how many days were above 80% (high)\n3. Count how many days were below 60% (low)\n4. Find the highest and lowest occupancy days\n5. Determine the trend (improving, declining, stable)\n6. Print a visual bar chart of the week\n\n**Trend Logic:**\n- If last 3 days average > first 3 days average: Improving\n- If last 3 days average < first 3 days average: Declining\n- Otherwise: Stable",
    "starterCode": "# Weekly Occupancy Analyzer\n\n# Daily occupancy data (percentage)\ndays = [\"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\", \"Sun\"]\noccupancy = [62, 58, 71, 78, 85, 92, 88]\n\nprint(\"=\"*50)\nprint(\"   WEEKLY OCCUPANCY REPORT\")\nprint(\"=\"*50)\n\n# Task 1: Calculate average occupancy\n\n\n# Task 2: Count high days (>80%) and low days (<60%)\n\n\n# Task 3: Find highest and lowest days\n\n\n# Task 4: Determine trend\n\n\n# Task 5: Print bar chart\nprint(\"\\nDaily Breakdown:\")\n# Use a loop to print each day with a visual bar\n# Example: Mon: 62% ######\n\n",
    "solution": "# Weekly Occupancy Analyzer\n\ndays = [\"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\", \"Sun\"]\noccupancy = [62, 58, 71, 78, 85, 92, 88]\n\nprint(\"=\"*50)\nprint(\"   WEEKLY OCCUPANCY REPORT\")\nprint(\"=\"*50)\n\n# Task 1: Calculate average occupancy\ntotal = 0\nfor occ in occupancy:\n    total += occ\naverage = total / len(occupancy)\nprint(f\"\\nAverage Occupancy: {average:.1f}%\")\n\n# Task 2: Count high and low days\nhigh_days = 0\nlow_days = 0\nfor occ in occupancy:\n    if occ > 80:\n        high_days += 1\n    elif occ < 60:\n        low_days += 1\n\nprint(f\"High Occupancy Days (>80%): {high_days}\")\nprint(f\"Low Occupancy Days (<60%): {low_days}\")\n\n# Task 3: Find highest and lowest\nhighest_occ = occupancy[0]\nlowest_occ = occupancy[0]\nhighest_day = days[0]\nlowest_day = days[0]\n\nfor i in range(len(days)):\n    if occupancy[i] > highest_occ:\n        highest_occ = occupancy[i]\n        highest_day = days[i]\n    if occupancy[i] < lowest_occ:\n        lowest_occ = occupancy[i]\n        lowest_day = days[i]\n\nprint(f\"\\nBest Day: {highest_day} ({highest_occ}%)\")\nprint(f\"Worst Day: {lowest_day} ({lowest_occ}%)\")\n\n# Task 4: Determine trend\nfirst_three_avg = sum(occupancy[:3]) / 3\nlast_three_avg = sum(occupancy[-3:]) / 3\n\nif last_three_avg > first_three_avg + 5:\n    trend = \"IMPROVING\"\nelif last_three_avg < first_three_avg - 5:\n    trend = \"DECLINING\"\nelse:\n    trend = \"STABLE\"\n\nprint(f\"\\nTrend: {trend}\")\nprint(f\"  (First 3 days avg: {first_three_avg:.1f}%, Last 3 days avg: {last_three_avg:.1f}%)\")\n\n# Task 5: Bar chart\nprint(\"\\n\" + \"-\"*50)\nprint(\"Daily Breakdown:\")\nprint(\"-\"*50)\nfor i in range(len(days)):\n    bar_length = occupancy[i] // 5  # 1 char per 5%\n    bar = \"#\" * bar_length\n    status = \"\"\n    if occupancy[i] > 80:\n        status = \" [HIGH]\"\n    elif occupancy[i] < 60:\n        status = \" [LOW]\"\n    print(f\"{days[i]}: {occupancy[i]:3}% {bar}{status}\")\n\nprint(\"=\"*50)",
    "rubric": [
      {"criterion": "Average calculated correctly using loop", "points": 10},
      {"criterion": "High/low day counting works", "points": 10},
      {"criterion": "Highest/lowest days found correctly", "points": 10},
      {"criterion": "Trend logic implemented", "points": 10},
      {"criterion": "Visual bar chart printed", "points": 10}
    ],
    "hints": [
      "Use a running total and divide by length for average",
      "Use counters that increment inside if statements",
      "Track both the value AND the day name for highest/lowest",
      "Use integer division (//) to create bar lengths"
    ]
  }'::jsonb,
  'coding-challenge',
  false,
  true
),

-- ============================================
-- MODULE 8: Lists - Challenge
-- ============================================
(
  'e0000000-0000-0000-0008-000000000099',
  'd0000000-0000-0000-0000-000000000008',
  '8.99',
  99,
  'Challenge: Reservation Manager',
  'reservation-manager-challenge',
  'challenge',
  18,
  55,
  'basic',
  '{
    "type": "coding-challenge",
    "title": "Hotel Reservation Manager",
    "instructions": "Build a reservation management system using lists!\n\n**Features to Implement:**\n1. Display all current reservations\n2. Add a new reservation to the list\n3. Cancel (remove) a reservation by guest name\n4. Find reservations for a specific date\n5. Sort reservations by check-in date\n6. Count total guests expected\n\n**Data Structure:**\nEach reservation is a list: [guest_name, room_number, check_in_date, nights, guests]",
    "starterCode": "# Hotel Reservation Manager\n\n# Current reservations: [name, room, check_in, nights, guests]\nreservations = [\n    [\"Alice Smith\", 405, \"2024-03-15\", 3, 2],\n    [\"Bob Jones\", 302, \"2024-03-16\", 2, 1],\n    [\"Charlie Brown\", 501, \"2024-03-15\", 5, 4],\n    [\"Diana Ross\", 208, \"2024-03-17\", 1, 2],\n    [\"Eve Wilson\", 105, \"2024-03-16\", 4, 3]\n]\n\ndef display_reservations(res_list):\n    \"\"\"Display all reservations nicely formatted\"\"\"\n    print(\"\\n\" + \"=\"*60)\n    print(\"CURRENT RESERVATIONS\")\n    print(\"=\"*60)\n    # Complete this function\n    pass\n\ndef add_reservation(res_list, name, room, check_in, nights, guests):\n    \"\"\"Add a new reservation\"\"\"\n    # Complete this function\n    pass\n\ndef cancel_reservation(res_list, guest_name):\n    \"\"\"Cancel reservation by guest name\"\"\"\n    # Complete this function\n    pass\n\ndef find_by_date(res_list, date):\n    \"\"\"Find all reservations for a specific date\"\"\"\n    # Complete this function\n    pass\n\ndef count_total_guests(res_list):\n    \"\"\"Count total guests across all reservations\"\"\"\n    # Complete this function\n    pass\n\n# Test your functions\ndisplay_reservations(reservations)\n\n# Add a new reservation\nadd_reservation(reservations, \"Frank Miller\", 310, \"2024-03-18\", 2, 2)\nprint(\"\\nAfter adding Frank Miller:\")\ndisplay_reservations(reservations)\n\n# Find March 15 reservations\nprint(\"\\nReservations for 2024-03-15:\")\nmarch_15 = find_by_date(reservations, \"2024-03-15\")\nfor r in march_15:\n    print(f\"  {r[0]} - Room {r[1]}\")\n\n# Count total guests\nprint(f\"\\nTotal Guests Expected: {count_total_guests(reservations)}\")\n",
    "solution": "# Hotel Reservation Manager\n\nreservations = [\n    [\"Alice Smith\", 405, \"2024-03-15\", 3, 2],\n    [\"Bob Jones\", 302, \"2024-03-16\", 2, 1],\n    [\"Charlie Brown\", 501, \"2024-03-15\", 5, 4],\n    [\"Diana Ross\", 208, \"2024-03-17\", 1, 2],\n    [\"Eve Wilson\", 105, \"2024-03-16\", 4, 3]\n]\n\ndef display_reservations(res_list):\n    \"\"\"Display all reservations nicely formatted\"\"\"\n    print(\"\\n\" + \"=\"*60)\n    print(\"CURRENT RESERVATIONS\")\n    print(\"=\"*60)\n    print(f\"Guest                Room   Check-in     Nights  Guests\")\n    print(\"-\"*60)\n    for res in res_list:\n        print(f\"{res[0]:<20} {res[1]:<6} {res[2]:<12} {res[3]:<7} {res[4]}\")\n    print(f\"\\nTotal Reservations: {len(res_list)}\")\n\ndef add_reservation(res_list, name, room, check_in, nights, guests):\n    \"\"\"Add a new reservation\"\"\"\n    new_res = [name, room, check_in, nights, guests]\n    res_list.append(new_res)\n    print(f\"Added reservation for {name}\")\n\ndef cancel_reservation(res_list, guest_name):\n    \"\"\"Cancel reservation by guest name\"\"\"\n    for i, res in enumerate(res_list):\n        if res[0] == guest_name:\n            res_list.pop(i)\n            print(f\"Cancelled reservation for {guest_name}\")\n            return True\n    print(f\"No reservation found for {guest_name}\")\n    return False\n\ndef find_by_date(res_list, date):\n    \"\"\"Find all reservations for a specific date\"\"\"\n    matches = []\n    for res in res_list:\n        if res[2] == date:\n            matches.append(res)\n    return matches\n\ndef count_total_guests(res_list):\n    \"\"\"Count total guests across all reservations\"\"\"\n    total = 0\n    for res in res_list:\n        total += res[4]\n    return total\n\n# Test functions\ndisplay_reservations(reservations)\n\nadd_reservation(reservations, \"Frank Miller\", 310, \"2024-03-18\", 2, 2)\nprint(\"\\nAfter adding Frank Miller:\")\ndisplay_reservations(reservations)\n\nprint(\"\\nReservations for 2024-03-15:\")\nmarch_15 = find_by_date(reservations, \"2024-03-15\")\nfor r in march_15:\n    print(f\"  {r[0]} - Room {r[1]}\")\n\nprint(f\"\\nTotal Guests Expected: {count_total_guests(reservations)}\")",
    "rubric": [
      {"criterion": "display_reservations shows all data", "points": 10},
      {"criterion": "add_reservation appends correctly", "points": 10},
      {"criterion": "cancel_reservation removes by name", "points": 10},
      {"criterion": "find_by_date returns matching list", "points": 10},
      {"criterion": "count_total_guests sums correctly", "points": 10}
    ],
    "hints": [
      "Use append() to add to a list",
      "Use enumerate() to track index while looping",
      "Build a new list for filtering results",
      "Access list elements by index: res[0], res[1], etc."
    ]
  }'::jsonb,
  'coding-challenge',
  false,
  true
),

-- ============================================
-- MODULE 9: Functions - Challenge
-- ============================================
(
  'e0000000-0000-0000-0009-000000000099',
  'd0000000-0000-0000-0000-000000000009',
  '9.99',
  99,
  'Challenge: Pricing Engine',
  'pricing-engine-challenge',
  'challenge',
  20,
  60,
  'basic',
  '{
    "type": "coding-challenge",
    "title": "Dynamic Pricing Engine",
    "instructions": "Build a hotel pricing engine using functions!\n\n**Pricing Rules:**\n1. Base rates: Standard=$150, Deluxe=$250, Suite=$400\n2. Weekend surcharge: +20% on Fri/Sat nights\n3. Season multiplier: Peak=1.3, Regular=1.0, Low=0.8\n4. Length of stay discount: 3+ nights=5%, 7+ nights=15%\n5. Loyalty members get 10% off final price\n\n**Required Functions:**\n- get_base_rate(room_type) -> float\n- apply_weekend_surcharge(rate, day) -> float\n- apply_season_multiplier(rate, season) -> float\n- apply_length_discount(rate, nights) -> float\n- apply_loyalty_discount(rate, is_loyalty) -> float\n- calculate_total(room_type, nights, days, season, is_loyalty) -> float",
    "starterCode": "# Hotel Dynamic Pricing Engine\n\ndef get_base_rate(room_type):\n    \"\"\"Return base rate for room type\"\"\"\n    # Complete this function\n    pass\n\ndef apply_weekend_surcharge(rate, day):\n    \"\"\"Apply 20% surcharge for Fri/Sat\"\"\"\n    # Complete this function\n    pass\n\ndef apply_season_multiplier(rate, season):\n    \"\"\"Apply season multiplier: peak=1.3, regular=1.0, low=0.8\"\"\"\n    # Complete this function\n    pass\n\ndef apply_length_discount(rate, nights):\n    \"\"\"Apply discount: 3+ nights=5%, 7+ nights=15%\"\"\"\n    # Complete this function\n    pass\n\ndef apply_loyalty_discount(rate, is_loyalty):\n    \"\"\"Apply 10% loyalty discount if member\"\"\"\n    # Complete this function\n    pass\n\ndef calculate_total(room_type, nights, days, season, is_loyalty=False):\n    \"\"\"Calculate total price for a stay\n    \n    Args:\n        room_type: \"standard\", \"deluxe\", or \"suite\"\n        nights: number of nights\n        days: list of day names [\"Fri\", \"Sat\", \"Sun\"]\n        season: \"peak\", \"regular\", or \"low\"\n        is_loyalty: True if loyalty member\n    \n    Returns:\n        Total price for the stay\n    \"\"\"\n    # Complete this function\n    pass\n\n# Test the pricing engine\nprint(\"=\"*50)\nprint(\"HOTEL PRICING ENGINE TEST\")\nprint(\"=\"*50)\n\n# Test 1: Standard room, 2 weeknights, regular season\ntest1 = calculate_total(\"standard\", 2, [\"Mon\", \"Tue\"], \"regular\", False)\nprint(f\"\\nTest 1: Standard, 2 weeknights, regular\")\nprint(f\"  Price: ${test1:.2f}\")\n\n# Test 2: Deluxe, weekend, peak season, loyalty\ntest2 = calculate_total(\"deluxe\", 2, [\"Fri\", \"Sat\"], \"peak\", True)\nprint(f\"\\nTest 2: Deluxe, weekend, peak, loyalty\")\nprint(f\"  Price: ${test2:.2f}\")\n\n# Test 3: Suite, 7 nights, mixed days, low season\ntest3 = calculate_total(\"suite\", 7, [\"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\", \"Sun\"], \"low\", False)\nprint(f\"\\nTest 3: Suite, 7 nights, low season\")\nprint(f\"  Price: ${test3:.2f}\")\n",
    "solution": "# Hotel Dynamic Pricing Engine\n\ndef get_base_rate(room_type):\n    \"\"\"Return base rate for room type\"\"\"\n    rates = {\n        \"standard\": 150,\n        \"deluxe\": 250,\n        \"suite\": 400\n    }\n    return rates.get(room_type, 150)\n\ndef apply_weekend_surcharge(rate, day):\n    \"\"\"Apply 20% surcharge for Fri/Sat\"\"\"\n    if day in [\"Fri\", \"Sat\"]:\n        return rate * 1.20\n    return rate\n\ndef apply_season_multiplier(rate, season):\n    \"\"\"Apply season multiplier\"\"\"\n    multipliers = {\n        \"peak\": 1.3,\n        \"regular\": 1.0,\n        \"low\": 0.8\n    }\n    return rate * multipliers.get(season, 1.0)\n\ndef apply_length_discount(rate, nights):\n    \"\"\"Apply length of stay discount\"\"\"\n    if nights >= 7:\n        return rate * 0.85  # 15% off\n    elif nights >= 3:\n        return rate * 0.95  # 5% off\n    return rate\n\ndef apply_loyalty_discount(rate, is_loyalty):\n    \"\"\"Apply 10% loyalty discount if member\"\"\"\n    if is_loyalty:\n        return rate * 0.90\n    return rate\n\ndef calculate_total(room_type, nights, days, season, is_loyalty=False):\n    \"\"\"Calculate total price for a stay\"\"\"\n    base_rate = get_base_rate(room_type)\n    \n    # Calculate each night\n    total = 0\n    for day in days:\n        nightly_rate = base_rate\n        nightly_rate = apply_weekend_surcharge(nightly_rate, day)\n        nightly_rate = apply_season_multiplier(nightly_rate, season)\n        total += nightly_rate\n    \n    # Apply length discount\n    total = apply_length_discount(total, nights)\n    \n    # Apply loyalty discount\n    total = apply_loyalty_discount(total, is_loyalty)\n    \n    return total\n\n# Test the pricing engine\nprint(\"=\"*50)\nprint(\"HOTEL PRICING ENGINE TEST\")\nprint(\"=\"*50)\n\ntest1 = calculate_total(\"standard\", 2, [\"Mon\", \"Tue\"], \"regular\", False)\nprint(f\"\\nTest 1: Standard, 2 weeknights, regular\")\nprint(f\"  Price: ${test1:.2f}\")\n\ntest2 = calculate_total(\"deluxe\", 2, [\"Fri\", \"Sat\"], \"peak\", True)\nprint(f\"\\nTest 2: Deluxe, weekend, peak, loyalty\")\nprint(f\"  Price: ${test2:.2f}\")\n\ntest3 = calculate_total(\"suite\", 7, [\"Mon\", \"Tue\", \"Wed\", \"Thu\", \"Fri\", \"Sat\", \"Sun\"], \"low\", False)\nprint(f\"\\nTest 3: Suite, 7 nights, low season\")\nprint(f\"  Price: ${test3:.2f}\")",
    "rubric": [
      {"criterion": "All helper functions work correctly", "points": 20},
      {"criterion": "Weekend surcharge applies to correct days", "points": 10},
      {"criterion": "Season multipliers applied correctly", "points": 10},
      {"criterion": "Length discounts applied correctly", "points": 10},
      {"criterion": "calculate_total combines all rules", "points": 10}
    ],
    "hints": [
      "Use dictionaries to map room types to rates",
      "Calculate each night separately in a loop",
      "Apply length and loyalty discounts to the total, not per night",
      "Test edge cases: exactly 3 nights, exactly 7 nights"
    ]
  }'::jsonb,
  'coding-challenge',
  false,
  true
),

-- ============================================
-- MODULE 10: Dictionaries - Challenge
-- ============================================
(
  'e0000000-0000-0000-0010-000000000099',
  'd0000000-0000-0000-0000-000000000010',
  '10.99',
  99,
  'Challenge: Guest Profile System',
  'guest-profile-challenge',
  'challenge',
  18,
  55,
  'basic',
  '{
    "type": "coding-challenge",
    "title": "Guest Profile Management System",
    "instructions": "Build a guest profile system using dictionaries!\n\n**Features:**\n1. Store guest profiles with preferences\n2. Look up guests by ID or name\n3. Update guest preferences\n4. Track visit history\n5. Find VIP guests (spent over $5000 total)\n6. Generate personalized welcome messages\n\n**Profile Structure:**\n```\n{\n    \"id\": \"G001\",\n    \"name\": \"Alice Smith\",\n    \"email\": \"alice@email.com\",\n    \"preferences\": {\n        \"room_type\": \"suite\",\n        \"floor\": \"high\",\n        \"pillows\": \"soft\",\n        \"newspaper\": True\n    },\n    \"visits\": 5,\n    \"total_spent\": 6500\n}\n```",
    "starterCode": "# Guest Profile Management System\n\nguests = {\n    \"G001\": {\n        \"name\": \"Alice Smith\",\n        \"email\": \"alice@email.com\",\n        \"preferences\": {\"room_type\": \"suite\", \"floor\": \"high\", \"pillows\": \"soft\"},\n        \"visits\": 5,\n        \"total_spent\": 6500\n    },\n    \"G002\": {\n        \"name\": \"Bob Jones\",\n        \"email\": \"bob@email.com\",\n        \"preferences\": {\"room_type\": \"standard\", \"floor\": \"low\", \"pillows\": \"firm\"},\n        \"visits\": 2,\n        \"total_spent\": 800\n    },\n    \"G003\": {\n        \"name\": \"Charlie Brown\",\n        \"email\": \"charlie@email.com\",\n        \"preferences\": {\"room_type\": \"deluxe\", \"floor\": \"any\", \"pillows\": \"soft\"},\n        \"visits\": 8,\n        \"total_spent\": 12000\n    }\n}\n\ndef get_guest_by_id(guests_db, guest_id):\n    \"\"\"Return guest profile by ID\"\"\"\n    pass\n\ndef find_guest_by_name(guests_db, name):\n    \"\"\"Find guest ID by name (partial match)\"\"\"\n    pass\n\ndef update_preference(guests_db, guest_id, pref_key, pref_value):\n    \"\"\"Update a single preference for a guest\"\"\"\n    pass\n\ndef add_visit(guests_db, guest_id, amount_spent):\n    \"\"\"Record a new visit and update total spent\"\"\"\n    pass\n\ndef get_vip_guests(guests_db, threshold=5000):\n    \"\"\"Return list of guests who spent over threshold\"\"\"\n    pass\n\ndef generate_welcome(guests_db, guest_id):\n    \"\"\"Generate personalized welcome message\"\"\"\n    pass\n\n# Test the system\nprint(\"=\"*50)\nprint(\"GUEST PROFILE SYSTEM\")\nprint(\"=\"*50)\n\n# Test each function\n",
    "solution": "# Guest Profile Management System\n\nguests = {\n    \"G001\": {\n        \"name\": \"Alice Smith\",\n        \"email\": \"alice@email.com\",\n        \"preferences\": {\"room_type\": \"suite\", \"floor\": \"high\", \"pillows\": \"soft\"},\n        \"visits\": 5,\n        \"total_spent\": 6500\n    },\n    \"G002\": {\n        \"name\": \"Bob Jones\",\n        \"email\": \"bob@email.com\",\n        \"preferences\": {\"room_type\": \"standard\", \"floor\": \"low\", \"pillows\": \"firm\"},\n        \"visits\": 2,\n        \"total_spent\": 800\n    },\n    \"G003\": {\n        \"name\": \"Charlie Brown\",\n        \"email\": \"charlie@email.com\",\n        \"preferences\": {\"room_type\": \"deluxe\", \"floor\": \"any\", \"pillows\": \"soft\"},\n        \"visits\": 8,\n        \"total_spent\": 12000\n    }\n}\n\ndef get_guest_by_id(guests_db, guest_id):\n    return guests_db.get(guest_id, None)\n\ndef find_guest_by_name(guests_db, name):\n    name_lower = name.lower()\n    for guest_id, profile in guests_db.items():\n        if name_lower in profile[\"name\"].lower():\n            return guest_id\n    return None\n\ndef update_preference(guests_db, guest_id, pref_key, pref_value):\n    if guest_id in guests_db:\n        guests_db[guest_id][\"preferences\"][pref_key] = pref_value\n        return True\n    return False\n\ndef add_visit(guests_db, guest_id, amount_spent):\n    if guest_id in guests_db:\n        guests_db[guest_id][\"visits\"] += 1\n        guests_db[guest_id][\"total_spent\"] += amount_spent\n        return True\n    return False\n\ndef get_vip_guests(guests_db, threshold=5000):\n    vips = []\n    for guest_id, profile in guests_db.items():\n        if profile[\"total_spent\"] >= threshold:\n            vips.append((guest_id, profile[\"name\"], profile[\"total_spent\"]))\n    return vips\n\ndef generate_welcome(guests_db, guest_id):\n    guest = guests_db.get(guest_id)\n    if not guest:\n        return \"Welcome to Grand Hotel!\"\n    name = guest[\"name\"]\n    visits = guest[\"visits\"]\n    prefs = guest[\"preferences\"]\n    room = prefs.get(\"room_type\", \"standard\")\n    floor = prefs.get(\"floor\", \"any\")\n    pillows = prefs.get(\"pillows\", \"standard\")\n    msg = \"Welcome back, \" + name + \"!\\n\"\n    msg += \"This is your visit #\" + str(visits + 1) + \".\\n\"\n    msg += \"Room preferences: \" + room + \", \" + floor + \" floor, \" + pillows + \" pillows\"\n    if guest[\"total_spent\"] >= 5000:\n        msg += \"\\nAs a VIP guest, enjoy complimentary breakfast!\"\n    return msg\n\n# Test the system\nprint(\"GUEST PROFILE SYSTEM\")\ng = get_guest_by_id(guests, \"G001\")\nname = g[\"name\"]\nvisits = g[\"visits\"]\nprint(\"Guest:\", name, \"-\", visits, \"visits\")\n\nfound_id = find_guest_by_name(guests, \"charlie\")\nprint(\"Found:\", found_id)\n\nvips = get_vip_guests(guests)\nprint(\"VIP Guests:\")\nfor v in vips:\n    print(\" \", v[1], \"-\", v[2])\n\nprint(generate_welcome(guests, \"G001\"))",
    "rubric": [
      {"criterion": "get_guest_by_id works correctly", "points": 10},
      {"criterion": "find_guest_by_name handles partial matches", "points": 10},
      {"criterion": "update_preference modifies nested dict", "points": 10},
      {"criterion": "add_visit increments correctly", "points": 10},
      {"criterion": "get_vip_guests filters correctly", "points": 10}
    ],
    "hints": [
      "Use dict.get() for safe access",
      "Use .lower() for case-insensitive search",
      "Nested access: guests_db[id][\"preferences\"][key]",
      "Return tuples or dicts for complex results"
    ]
  }'::jsonb,
  'coding-challenge',
  false,
  true
),

-- ============================================
-- MODULE 11: Files - Challenge
-- ============================================
(
  'e0000000-0000-0000-0011-000000000099',
  'd0000000-0000-0000-0000-000000000011',
  '11.99',
  99,
  'Challenge: Log Analyzer',
  'log-analyzer-challenge',
  'challenge',
  18,
  55,
  'basic',
  '{
    "type": "coding-challenge",
    "title": "Hotel Activity Log Analyzer",
    "instructions": "Build a log file analyzer for hotel activity tracking!\n\n**Note:** Since we can''t create actual files in this environment, we''ll simulate file content as a multi-line string.\n\n**Log Format:**\n```\n2024-03-15 08:30:00 | CHECK-IN | Room 405 | Guest: Alice Smith\n2024-03-15 09:15:00 | ROOM-SERVICE | Room 302 | Amount: $45.00\n2024-03-15 11:00:00 | CHECK-OUT | Room 208 | Guest: Bob Jones\n```\n\n**Analysis Tasks:**\n1. Count total events by type\n2. Calculate total room service revenue\n3. List all check-ins and check-outs\n4. Find busiest hour of the day\n5. Generate a summary report",
    "starterCode": "# Hotel Log Analyzer\n\n# Simulated log file content\nlog_content = \"\"\"2024-03-15 08:30:00 | CHECK-IN | Room 405 | Guest: Alice Smith\n2024-03-15 09:15:00 | ROOM-SERVICE | Room 302 | Amount: $45.00\n2024-03-15 09:45:00 | CHECK-IN | Room 301 | Guest: Charlie Brown\n2024-03-15 10:00:00 | ROOM-SERVICE | Room 405 | Amount: $28.50\n2024-03-15 11:00:00 | CHECK-OUT | Room 208 | Guest: Bob Jones\n2024-03-15 11:30:00 | CHECK-IN | Room 502 | Guest: Diana Ross\n2024-03-15 12:15:00 | ROOM-SERVICE | Room 301 | Amount: $62.00\n2024-03-15 14:00:00 | CHECK-OUT | Room 105 | Guest: Eve Wilson\n2024-03-15 14:30:00 | ROOM-SERVICE | Room 502 | Amount: $35.50\n2024-03-15 15:00:00 | CHECK-IN | Room 401 | Guest: Frank Miller\n2024-03-15 16:00:00 | CHECK-OUT | Room 302 | Guest: George Lucas\"\"\"\n\ndef parse_log_line(line):\n    \"\"\"Parse a single log line into components\"\"\"\n    # Return dict with: datetime, event_type, room, details\n    pass\n\ndef count_events_by_type(lines):\n    \"\"\"Count occurrences of each event type\"\"\"\n    pass\n\ndef calculate_room_service_total(lines):\n    \"\"\"Sum all room service amounts\"\"\"\n    pass\n\ndef get_check_ins_and_outs(lines):\n    \"\"\"Return dict with ''check_ins'' and ''check_outs'' lists\"\"\"\n    pass\n\ndef find_busiest_hour(lines):\n    \"\"\"Find the hour with most events\"\"\"\n    pass\n\ndef generate_report(log_content):\n    \"\"\"Generate full analysis report\"\"\"\n    lines = log_content.strip().split(\"\\n\")\n    \n    print(\"=\"*50)\n    print(\"HOTEL ACTIVITY LOG REPORT\")\n    print(\"=\"*50)\n    \n    # Complete the report generation\n    pass\n\n# Generate the report\ngenerate_report(log_content)\n",
    "solution": "# Hotel Log Analyzer\n\nlog_content = \"\"\"2024-03-15 08:30:00 | CHECK-IN | Room 405 | Guest: Alice Smith\n2024-03-15 09:15:00 | ROOM-SERVICE | Room 302 | Amount: $45.00\n2024-03-15 09:45:00 | CHECK-IN | Room 301 | Guest: Charlie Brown\n2024-03-15 10:00:00 | ROOM-SERVICE | Room 405 | Amount: $28.50\n2024-03-15 11:00:00 | CHECK-OUT | Room 208 | Guest: Bob Jones\n2024-03-15 11:30:00 | CHECK-IN | Room 502 | Guest: Diana Ross\n2024-03-15 12:15:00 | ROOM-SERVICE | Room 301 | Amount: $62.00\n2024-03-15 14:00:00 | CHECK-OUT | Room 105 | Guest: Eve Wilson\n2024-03-15 14:30:00 | ROOM-SERVICE | Room 502 | Amount: $35.50\n2024-03-15 15:00:00 | CHECK-IN | Room 401 | Guest: Frank Miller\n2024-03-15 16:00:00 | CHECK-OUT | Room 302 | Guest: George Lucas\"\"\"\n\ndef parse_log_line(line):\n    parts = line.split(\" | \")\n    return {\n        \"datetime\": parts[0],\n        \"hour\": int(parts[0].split(\" \")[1].split(\":\")[0]),\n        \"event_type\": parts[1],\n        \"room\": parts[2].replace(\"Room \", \"\"),\n        \"details\": parts[3]\n    }\n\ndef count_events_by_type(lines):\n    counts = {}\n    for line in lines:\n        event = parse_log_line(line)[\"event_type\"]\n        counts[event] = counts.get(event, 0) + 1\n    return counts\n\ndef calculate_room_service_total(lines):\n    total = 0\n    for line in lines:\n        parsed = parse_log_line(line)\n        if parsed[\"event_type\"] == \"ROOM-SERVICE\":\n            amount_str = parsed[\"details\"].replace(\"Amount: $\", \"\")\n            total += float(amount_str)\n    return total\n\ndef get_check_ins_and_outs(lines):\n    result = {\"check_ins\": [], \"check_outs\": []}\n    for line in lines:\n        parsed = parse_log_line(line)\n        if parsed[\"event_type\"] == \"CHECK-IN\":\n            guest = parsed[\"details\"].replace(\"Guest: \", \"\")\n            result[\"check_ins\"].append({\"room\": parsed[\"room\"], \"guest\": guest})\n        elif parsed[\"event_type\"] == \"CHECK-OUT\":\n            guest = parsed[\"details\"].replace(\"Guest: \", \"\")\n            result[\"check_outs\"].append({\"room\": parsed[\"room\"], \"guest\": guest})\n    return result\n\ndef find_busiest_hour(lines):\n    hour_counts = {}\n    for line in lines:\n        hour = parse_log_line(line)[\"hour\"]\n        hour_counts[hour] = hour_counts.get(hour, 0) + 1\n    busiest = max(hour_counts, key=hour_counts.get)\n    return busiest, hour_counts[busiest]\n\ndef generate_report(log_content):\n    lines = log_content.strip().split(\"\\n\")\n    print(\"HOTEL ACTIVITY LOG REPORT\")\n    \n    counts = count_events_by_type(lines)\n    print(\"Event Summary:\")\n    for event, count in counts.items():\n        print(\"  \" + event + \": \" + str(count))\n    \n    rs_total = calculate_room_service_total(lines)\n    print(\"Room Service Revenue: $\" + str(rs_total))\n    \n    movements = get_check_ins_and_outs(lines)\n    check_ins = movements[\"check_ins\"]\n    check_outs = movements[\"check_outs\"]\n    print(\"Check-ins: \" + str(len(check_ins)))\n    for ci in check_ins:\n        print(\"  Room \" + ci[\"room\"] + \": \" + ci[\"guest\"])\n    print(\"Check-outs: \" + str(len(check_outs)))\n    for co in check_outs:\n        print(\"  Room \" + co[\"room\"] + \": \" + co[\"guest\"])\n    \n    hour, count = find_busiest_hour(lines)\n    print(\"Busiest Hour: \" + str(hour) + \":00 (\" + str(count) + \" events)\")\n\ngenerate_report(log_content)",
    "rubric": [
      {"criterion": "parse_log_line extracts all components", "points": 10},
      {"criterion": "count_events_by_type works correctly", "points": 10},
      {"criterion": "calculate_room_service_total is accurate", "points": 10},
      {"criterion": "get_check_ins_and_outs separates correctly", "points": 10},
      {"criterion": "find_busiest_hour finds correct hour", "points": 10}
    ],
    "hints": [
      "Use split(\" | \") to separate log parts",
      "Extract amount with replace(\"Amount: $\", \"\") and float()",
      "Count hours using a dictionary",
      "Use max(dict, key=dict.get) for finding maximum"
    ]
  }'::jsonb,
  'coding-challenge',
  false,
  true
),

-- ============================================
-- MODULE 12: Error Handling - Challenge
-- ============================================
(
  'e0000000-0000-0000-0012-000000000099',
  'd0000000-0000-0000-0000-000000000012',
  '12.99',
  99,
  'Challenge: Robust Booking System',
  'robust-booking-challenge',
  'challenge',
  18,
  55,
  'basic',
  '{
    "type": "coding-challenge",
    "title": "Robust Booking System",
    "instructions": "Build a bulletproof booking system with comprehensive error handling!\n\n**Potential Errors to Handle:**\n1. Invalid room number (not 100-999)\n2. Invalid number of nights (must be 1-30)\n3. Invalid date format\n4. Room not available\n5. Invalid payment amount\n6. Guest name empty\n\n**Requirements:**\n- Create custom exception messages\n- Use try-except blocks appropriately\n- Provide helpful error messages to users\n- Log errors for staff review\n- Never crash - always recover gracefully",
    "starterCode": "# Robust Hotel Booking System\n\navailable_rooms = [101, 102, 103, 201, 202, 203, 301, 302, 303]\n\nclass BookingError(Exception):\n    \"\"\"Custom exception for booking errors\"\"\"\n    pass\n\ndef validate_room_number(room):\n    \"\"\"Validate room number is valid and available\"\"\"\n    # Should raise BookingError if invalid\n    pass\n\ndef validate_nights(nights):\n    \"\"\"Validate number of nights (1-30)\"\"\"\n    pass\n\ndef validate_guest_name(name):\n    \"\"\"Validate guest name is not empty\"\"\"\n    pass\n\ndef validate_payment(amount, expected):\n    \"\"\"Validate payment matches expected amount\"\"\"\n    pass\n\ndef process_booking(guest_name, room, nights, payment):\n    \"\"\"Process a complete booking with full validation\"\"\"\n    errors = []\n    rate = 150  # per night\n    \n    # Validate all inputs and collect errors\n    \n    # If no errors, process booking\n    # If errors, report all of them\n    pass\n\n# Test with various inputs\nprint(\"=\"*50)\nprint(\"BOOKING SYSTEM TESTS\")\nprint(\"=\"*50)\n\n# Test 1: Valid booking\nprint(\"\\nTest 1: Valid booking\")\nprocess_booking(\"Alice Smith\", 101, 3, 450)\n\n# Test 2: Invalid room\nprint(\"\\nTest 2: Invalid room number\")\nprocess_booking(\"Bob Jones\", 999, 2, 300)\n\n# Test 3: Empty name\nprint(\"\\nTest 3: Empty guest name\")\nprocess_booking(\"\", 102, 2, 300)\n\n# Test 4: Too many nights\nprint(\"\\nTest 4: Too many nights\")\nprocess_booking(\"Charlie\", 103, 50, 7500)\n\n# Test 5: Wrong payment\nprint(\"\\nTest 5: Wrong payment amount\")\nprocess_booking(\"Diana\", 201, 2, 200)\n",
    "solution": "# Robust Hotel Booking System\n\navailable_rooms = [101, 102, 103, 201, 202, 203, 301, 302, 303]\n\nclass BookingError(Exception):\n    \"\"\"Custom exception for booking errors\"\"\"\n    pass\n\ndef validate_room_number(room):\n    \"\"\"Validate room number is valid and available\"\"\"\n    try:\n        room_int = int(room)\n    except (ValueError, TypeError):\n        raise BookingError(f\"Room number must be a number, got: {room}\")\n    \n    if room_int < 100 or room_int > 999:\n        raise BookingError(f\"Room {room_int} is not a valid room number (100-999)\")\n    \n    if room_int not in available_rooms:\n        raise BookingError(f\"Room {room_int} is not available\")\n    \n    return room_int\n\ndef validate_nights(nights):\n    \"\"\"Validate number of nights (1-30)\"\"\"\n    try:\n        nights_int = int(nights)\n    except (ValueError, TypeError):\n        raise BookingError(f\"Nights must be a number, got: {nights}\")\n    \n    if nights_int < 1:\n        raise BookingError(\"Stay must be at least 1 night\")\n    if nights_int > 30:\n        raise BookingError(\"Maximum stay is 30 nights\")\n    \n    return nights_int\n\ndef validate_guest_name(name):\n    \"\"\"Validate guest name is not empty\"\"\"\n    if not name or not str(name).strip():\n        raise BookingError(\"Guest name cannot be empty\")\n    return str(name).strip()\n\ndef validate_payment(amount, expected):\n    \"\"\"Validate payment matches expected amount\"\"\"\n    try:\n        payment = float(amount)\n    except (ValueError, TypeError):\n        raise BookingError(f\"Invalid payment amount: {amount}\")\n    \n    if payment < expected:\n        raise BookingError(f\"Payment ${payment:.2f} is less than required ${expected:.2f}\")\n    \n    return payment\n\ndef process_booking(guest_name, room, nights, payment):\n    \"\"\"Process a complete booking with full validation\"\"\"\n    errors = []\n    rate = 150\n    \n    # Validate each input and collect errors\n    validated_name = None\n    validated_room = None\n    validated_nights = None\n    \n    try:\n        validated_name = validate_guest_name(guest_name)\n    except BookingError as e:\n        errors.append(str(e))\n    \n    try:\n        validated_room = validate_room_number(room)\n    except BookingError as e:\n        errors.append(str(e))\n    \n    try:\n        validated_nights = validate_nights(nights)\n    except BookingError as e:\n        errors.append(str(e))\n    \n    # Calculate expected payment if we have valid nights\n    if validated_nights:\n        expected = validated_nights * rate\n        try:\n            validate_payment(payment, expected)\n        except BookingError as e:\n            errors.append(str(e))\n    \n    # Report results\n    if errors:\n        print(\"  BOOKING FAILED\")\n        for err in errors:\n            print(f\"  - {err}\")\n        return False\n    else:\n        print(\"  BOOKING CONFIRMED!\")\n        print(f\"  Guest: {validated_name}\")\n        print(f\"  Room: {validated_room}\")\n        print(f\"  Nights: {validated_nights}\")\n        print(f\"  Total: ${validated_nights * rate:.2f}\")\n        \n        # Remove room from available\n        available_rooms.remove(validated_room)\n        return True\n\n# Test with various inputs\nprint(\"=\"*50)\nprint(\"BOOKING SYSTEM TESTS\")\nprint(\"=\"*50)\n\nprint(\"\\nTest 1: Valid booking\")\nprocess_booking(\"Alice Smith\", 101, 3, 450)\n\nprint(\"\\nTest 2: Invalid room number\")\nprocess_booking(\"Bob Jones\", 999, 2, 300)\n\nprint(\"\\nTest 3: Empty guest name\")\nprocess_booking(\"\", 102, 2, 300)\n\nprint(\"\\nTest 4: Too many nights\")\nprocess_booking(\"Charlie\", 103, 50, 7500)\n\nprint(\"\\nTest 5: Wrong payment amount\")\nprocess_booking(\"Diana\", 201, 2, 200)",
    "rubric": [
      {"criterion": "Custom BookingError exception defined", "points": 10},
      {"criterion": "All validation functions raise appropriate errors", "points": 15},
      {"criterion": "process_booking collects all errors", "points": 10},
      {"criterion": "Helpful error messages provided", "points": 10},
      {"criterion": "System never crashes on bad input", "points": 5}
    ],
    "hints": [
      "Use try-except inside validation functions",
      "Collect errors in a list, don''t stop at first error",
      "Custom exceptions help identify booking-specific errors",
      "Convert and validate types before using values"
    ]
  }'::jsonb,
  'coding-challenge',
  false,
  true
)

ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  minutes = EXCLUDED.minutes,
  xp = EXCLUDED.xp;

