-- ============================================
-- Module 6: Decision Making Activities
-- 4 Skills: Relevant Costs, Make or Buy, Special Order, Keep or Drop
-- ~21 Activities with comprehensive content
-- ============================================

-- Clean up existing data to avoid conflicts
DELETE FROM activity_skills WHERE activity_id IN (
  SELECT id FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000006'
);
DELETE FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000006';

-- ============================================
-- SKILL: Relevant vs Irrelevant Costs (MA-20)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

-- Activity 6.1.1: Identifying Relevant Costs
(
  'd0600000-0000-0000-0001-000000000001',
  'd0000000-0000-0000-0000-000000000006',
  '6.1.1',
  1,
  'Identifying Relevant Costs',
  'identifying-relevant-costs',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Identifying Relevant Costs\n\n## The Decision-Making Focus\n\nWhen making business decisions, not all costs matter. **Relevant costs** are those that:\n1. Will be incurred **in the future**\n2. **Differ between alternatives**\n\n---\n\n## Types of Costs in Decision Making\n\n### Relevant Costs (Include in Analysis)\n\n| Term | Definition | Example |\n|------|------------|----------|\n| **Differential** | Costs that differ between options | Additional ingredients for new menu |\n| **Avoidable** | Costs that can be eliminated | Fired employee salary |\n| **Incremental** | Additional costs of choosing an option | Extra labor for special order |\n| **Opportunity** | Benefit forgone from next best alternative | Revenue lost by closing for renovation |\n\n### Irrelevant Costs (Exclude from Analysis)\n\n| Term | Definition | Example |\n|------|------------|----------|\n| **Sunk** | Already incurred, cannot be recovered | Equipment already purchased |\n| **Committed** | Contractually obligated regardless of decision | Existing lease payments |\n| **Unavoidable** | Will occur regardless of choice | Property taxes |\n\n---\n\n## The Sunk Cost Trap\n\n:::concept{title=\"Sunk Cost Fallacy\"}\nDon''t let past costs influence future decisions!\n\n\"We''ve already spent CHF 50,000 on this project, so we should continue.\"\n\n**Wrong!** The CHF 50,000 is gone. Only future costs and benefits matter.\n:::\n\n---\n\n## Example: Restaurant Renovation Decision\n\n**Should we renovate the dining room?**\n\nCosts to consider:\n\n| Cost | Relevant? | Why |\n|------|-----------|-----|\n| Renovation costs CHF 80,000 | YES | Future, differs between options |\n| Lost revenue during closure | YES | Opportunity cost |\n| Original dining room cost | NO | Sunk cost |\n| Current mortgage payments | NO | Unavoidable either way |\n| New furniture CHF 20,000 | YES | Future, avoidable if no renovation |\n| Existing furniture book value | NO | Sunk cost |\n\n---\n\n## Opportunity Cost\n\nThe value of the **best alternative forgone**.\n\n**Example**: \n- Hotel ballroom can host wedding (CHF 8,000 revenue)\n- OR corporate meeting (CHF 6,000 revenue)\n\nIf wedding is chosen, opportunity cost = CHF 6,000\n(The meeting revenue we gave up)\n\n---\n\n## Decision Framework\n\n1. Identify the alternatives\n2. List all costs and revenues\n3. Eliminate irrelevant items (sunk, unavoidable)\n4. Compare relevant costs only\n5. Include opportunity costs\n6. Choose option with best net benefit\n\n---\n\n:::takeaways\n- Relevant costs are future costs that differ between options\n- Sunk costs are never relevant - they''re already spent\n- Include opportunity costs in analysis\n- Ignore book values of existing assets\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.1.2: Relevant Cost Quiz
(
  'd0600000-0000-0000-0001-000000000002',
  'd0000000-0000-0000-0000-000000000006',
  '6.1.2',
  2,
  'Relevant Cost Identification',
  'relevant-cost-identification',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A relevant cost is one that:",
        "options": ["Has already been incurred", "Is the same for all alternatives", "Will occur in the future and differs between options", "Cannot be avoided"],
        "correct": 2,
        "explanation": "Relevant costs are future costs that differ between alternatives being considered."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A sunk cost is:",
        "options": ["Always relevant", "Never relevant", "Sometimes relevant", "Equal to opportunity cost"],
        "correct": 1,
        "explanation": "Sunk costs are never relevant because they have already been incurred."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Equipment purchased last year for CHF 100,000 is now worth CHF 60,000. Which is the sunk cost?",
        "options": ["CHF 60,000", "CHF 100,000", "CHF 40,000", "CHF 160,000"],
        "correct": 1,
        "explanation": "The original purchase price CHF 100,000 is sunk - it was spent in the past."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel can rent its empty ballroom for CHF 5,000 or use it for storage. If used for storage, the opportunity cost is:",
        "options": ["CHF 0", "CHF 5,000", "The storage value", "Cannot determine"],
        "correct": 1,
        "explanation": "Opportunity cost is the forgone benefit of the next best alternative - the CHF 5,000 rental."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Book value of an asset is always relevant to a replacement decision.",
        "correct": false,
        "explanation": "False. Book value is a historical, sunk cost. Only future cash flows matter."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which cost is RELEVANT when deciding to close a restaurant for renovation?",
        "options": ["Original construction cost", "Last year''s losses", "Lost sales during closure", "Depreciation expense"],
        "correct": 2,
        "explanation": "Lost sales during closure is a future differential cost (opportunity cost)."
      },
      {
        "id": "q7",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Avoidable costs are relevant because they:",
        "options": ["Cannot be changed", "Will differ between alternatives", "Have already occurred", "Are always fixed"],
        "correct": 1,
        "explanation": "Avoidable costs can be eliminated by choosing one option, so they differ between alternatives."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.1.3: Sunk Cost Identifier Interactive
(
  'd0600000-0000-0000-0001-000000000003',
  'd0000000-0000-0000-0000-000000000006',
  '6.1.3',
  3,
  'Sunk Cost Identifier',
  'sunk-cost-identifier',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Sort each cost as Relevant or Irrelevant for a hotel deciding whether to replace old lobby furniture.",
    "categories": ["Relevant Costs", "Irrelevant Costs (Sunk/Unavoidable)"],
    "items": [
      {"text": "Cost of new furniture CHF 40,000", "category": "Relevant Costs"},
      {"text": "Original cost of old furniture CHF 25,000", "category": "Irrelevant Costs (Sunk/Unavoidable)"},
      {"text": "Disposal fee for old furniture CHF 500", "category": "Relevant Costs"},
      {"text": "Book value of old furniture CHF 8,000", "category": "Irrelevant Costs (Sunk/Unavoidable)"},
      {"text": "Lost revenue during installation", "category": "Relevant Costs"},
      {"text": "Depreciation on old furniture", "category": "Irrelevant Costs (Sunk/Unavoidable)"},
      {"text": "Annual maintenance savings CHF 2,000", "category": "Relevant Costs"},
      {"text": "Previous repair costs on old furniture", "category": "Irrelevant Costs (Sunk/Unavoidable)"}
    ]
  }'::jsonb,
  'category-sort',
  false,
  true
),

-- Activity 6.1.4: Hotel Renovation Decision Practice
(
  'd0600000-0000-0000-0001-000000000004',
  'd0000000-0000-0000-0000-000000000006',
  '6.1.4',
  4,
  'Hotel Renovation Decision',
  'hotel-renovation-decision',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel spent CHF 500,000 on renovation plans. The renovation will cost CHF 2M more but increase revenue CHF 300K/year. The CHF 500,000 is:",
        "options": ["Relevant - it affects the decision", "Irrelevant - it is a sunk cost", "An opportunity cost", "A differential cost"],
        "correct": 1,
        "explanation": "The CHF 500,000 already spent on plans is a sunk cost - irrelevant to the go/no-go decision."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If a renovation closes the hotel for 2 months during which revenue would be CHF 400,000, this is:",
        "options": ["A sunk cost", "An avoidable cost", "An opportunity cost", "A committed cost"],
        "correct": 2,
        "explanation": "The lost revenue is an opportunity cost - benefit forgone by choosing renovation."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Old equipment book value CHF 50,000, can sell for CHF 15,000. Which is relevant to a replacement decision?",
        "options": ["CHF 50,000 book value", "CHF 15,000 sale proceeds", "CHF 35,000 loss on sale", "All are relevant"],
        "correct": 1,
        "explanation": "Only the CHF 15,000 future cash flow (sale proceeds) is relevant. Book value is sunk."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "applied",
        "question": "If a cost will be the same regardless of which option is chosen, it is irrelevant.",
        "correct": true,
        "explanation": "True. Costs that don''t differ between alternatives don''t affect the decision."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Which is the correct approach to decision analysis?",
        "options": ["Include all costs for accuracy", "Only include relevant costs", "Ignore all overhead", "Use historical costs"],
        "correct": 1,
        "explanation": "Decision analysis should focus only on relevant costs - future differential costs."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.1.5: Relevant Costs Checkpoint
(
  'd0600000-0000-0000-0001-000000000005',
  'd0000000-0000-0000-0000-000000000006',
  '6.1.5',
  5,
  'Relevant vs Irrelevant Checkpoint',
  'relevant-costs-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The two criteria for a relevant cost are: (1) future cost and (2):",
        "options": ["Fixed cost", "Variable cost", "Differs between alternatives", "Sunk cost"],
        "correct": 2,
        "explanation": "Relevant costs are future costs that differ between the alternatives being considered."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Opportunity cost represents:",
        "options": ["Money already spent", "The benefit of the best forgone alternative", "Fixed costs", "Unavoidable costs"],
        "correct": 1,
        "explanation": "Opportunity cost is the benefit given up by not choosing the next best option."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Last year''s marketing expense is _____ for this year''s budget decisions.",
        "options": ["Relevant", "Irrelevant (sunk)", "An opportunity cost", "Avoidable"],
        "correct": 1,
        "explanation": "Past expenses are sunk costs - they cannot be changed by current decisions."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Depreciation on existing equipment is a relevant cost for replacement decisions.",
        "correct": false,
        "explanation": "False. Depreciation is an allocation of past costs (sunk) and is irrelevant."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "A differential cost is another name for:",
        "options": ["Sunk cost", "Irrelevant cost", "Relevant cost", "Historical cost"],
        "correct": 2,
        "explanation": "Differential costs differ between alternatives, making them relevant."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- Activity 6.2.1: Make or Buy Analysis
(
  'd0600000-0000-0000-0002-000000000001',
  'd0000000-0000-0000-0000-000000000006',
  '6.2.1',
  6,
  'Make or Buy Analysis',
  'make-or-buy-analysis',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Make or Buy Analysis\n\n## The Outsourcing Decision\n\nShould we produce in-house or purchase from outside? This applies to:\n- Products (ingredients, supplies)\n- Services (laundry, maintenance, security)\n- Activities (reservations, payroll processing)\n\n---\n\n## Decision Framework\n\n### Compare:\n1. **Relevant costs to make** (avoidable costs)\n2. **Cost to buy** (purchase price + any additional costs)\n\n### Also consider:\n- Quality control\n- Reliability of supply\n- Use of freed capacity\n- Strategic implications\n\n---\n\n## Which Costs Are Relevant?\n\n### Relevant (Include):\n- Variable manufacturing costs\n- Avoidable fixed costs\n- Opportunity costs of capacity\n\n### Irrelevant (Exclude):\n- Unavoidable fixed costs (common, allocated)\n- Sunk costs\n\n---\n\n## Example: Hotel Laundry Decision\n\n**Should the hotel do laundry in-house or outsource?**\n\n**Current In-House Costs (Monthly)**\n\n| Cost | Amount | Avoidable? |\n|------|--------|------------|\n| Direct materials | CHF 3,000 | Yes |\n| Direct labor | CHF 8,000 | Yes |\n| Variable overhead | CHF 2,000 | Yes |\n| Equipment depreciation | CHF 1,500 | No |\n| Supervisor salary | CHF 4,000 | Yes (if outsource) |\n| Allocated building costs | CHF 2,500 | No |\n| **Total** | **CHF 21,000** | |\n| **Avoidable only** | **CHF 17,000** | |\n\n**Outsource Quote**: CHF 15,000/month\n\n---\n\n## Analysis\n\n| | Make | Buy |\n|-|------|-----|\n| Avoidable costs | CHF 17,000 | - |\n| Purchase price | - | CHF 15,000 |\n| **Total relevant cost** | **CHF 17,000** | **CHF 15,000** |\n\n**Savings from buying**: CHF 2,000/month\n\n---\n\n## Opportunity Cost Consideration\n\nWhat if the laundry space could be used for something else?\n\n- Rent out space: CHF 1,500/month\n- This is an opportunity cost of making\n\n| | Make | Buy |\n|-|------|-----|\n| Avoidable costs | CHF 17,000 | - |\n| Purchase price | - | CHF 15,000 |\n| Opportunity cost | CHF 1,500 | - |\n| **Total** | **CHF 18,500** | **CHF 15,000** |\n\n**Buy** is even more favorable.\n\n---\n\n## Qualitative Factors\n\n| Factor | Consider |\n|--------|----------|\n| Quality | Can supplier match our standards? |\n| Reliability | Will they deliver on time? |\n| Confidentiality | Guest privacy concerns? |\n| Flexibility | Can they handle peak demand? |\n| Long-term costs | Will prices increase? |\n| Employee impact | Layoffs, morale? |\n\n---\n\n:::takeaways\n- Compare avoidable costs to make vs cost to buy\n- Allocated overhead is usually unavoidable (irrelevant)\n- Include opportunity costs of freed capacity\n- Consider qualitative factors beyond cost\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.2.2: Make or Buy Quiz
(
  'd0600000-0000-0000-0002-000000000002',
  'd0000000-0000-0000-0000-000000000006',
  '6.2.2',
  7,
  'Make or Buy Concepts',
  'make-or-buy-concepts',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "In a make-or-buy decision, which costs are relevant?",
        "options": ["All manufacturing costs", "Only variable costs", "Avoidable costs", "Only direct costs"],
        "correct": 2,
        "explanation": "Avoidable costs (those that would be eliminated by buying) are the relevant costs."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Avoidable costs to make CHF 25,000, Purchase price CHF 22,000. The company should:",
        "options": ["Make - saves CHF 3,000", "Buy - saves CHF 3,000", "Make - same cost", "Cannot determine"],
        "correct": 1,
        "explanation": "Buying saves CHF 3,000 (CHF 25,000 - CHF 22,000)."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Allocated corporate overhead is typically:",
        "options": ["Relevant and avoidable", "Irrelevant and unavoidable", "An opportunity cost", "A differential cost"],
        "correct": 1,
        "explanation": "Allocated overhead continues regardless of the decision - it''s unavoidable."
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Freed capacity can be rented for CHF 5,000. This is _____ if we decide to make.",
        "options": ["A sunk cost", "An opportunity cost of making", "Not relevant", "An avoidable cost of buying"],
        "correct": 1,
        "explanation": "If we make, we give up CHF 5,000 rental income - an opportunity cost."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A make-or-buy decision should consider only quantitative factors.",
        "correct": false,
        "explanation": "False. Qualitative factors like quality, reliability, and strategy matter too."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which is NOT a qualitative factor in make-or-buy?",
        "options": ["Supplier reliability", "Variable cost per unit", "Quality control", "Employee morale"],
        "correct": 1,
        "explanation": "Variable cost per unit is a quantitative factor, not qualitative."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.2.3: Decision Framework Interactive
(
  'd0600000-0000-0000-0002-000000000003',
  'd0000000-0000-0000-0000-000000000006',
  '6.2.3',
  8,
  'Make or Buy Framework',
  'make-or-buy-framework',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Put the make-or-buy analysis steps in order.",
    "sequence": [
      "Identify all current costs of making",
      "Separate avoidable from unavoidable costs",
      "Calculate total avoidable cost if we buy",
      "Get the purchase price from supplier",
      "Add any additional costs of buying",
      "Consider opportunity cost of freed capacity",
      "Compare total relevant costs",
      "Evaluate qualitative factors",
      "Make the decision"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

-- Activity 6.2.4: Hotel Laundry Decision Practice
(
  'd0600000-0000-0000-0002-000000000004',
  'd0000000-0000-0000-0000-000000000006',
  '6.2.4',
  9,
  'Hotel Laundry Decision',
  'hotel-laundry-decision',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "In-house laundry: DM CHF 4K, DL CHF 12K, VOH CHF 3K, FOH (avoidable) CHF 5K, Allocated CHF 4K. Avoidable cost:",
        "options": ["CHF 19,000", "CHF 24,000", "CHF 28,000", "CHF 23,000"],
        "correct": 1,
        "explanation": "Avoidable = DM + DL + VOH + Avoidable FOH = 4 + 12 + 3 + 5 = CHF 24,000"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Using avoidable cost CHF 24,000, if outsource quote is CHF 22,000, the hotel should:",
        "options": ["Keep in-house", "Outsource - saves CHF 2,000", "Neither - same cost", "Outsource - saves CHF 6,000"],
        "correct": 1,
        "explanation": "Outsourcing saves CHF 24,000 - CHF 22,000 = CHF 2,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If laundry space could generate CHF 3,000/month rent, total cost to keep in-house becomes:",
        "options": ["CHF 24,000", "CHF 27,000", "CHF 21,000", "CHF 25,000"],
        "correct": 1,
        "explanation": "Total = Avoidable CHF 24,000 + Opportunity CHF 3,000 = CHF 27,000"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "applied",
        "question": "If quality is a concern with the outsource supplier, the hotel might keep laundry in-house despite higher cost.",
        "correct": true,
        "explanation": "True. Qualitative factors can override quantitative cost analysis."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The allocated corporate overhead CHF 4,000 is:",
        "options": ["Relevant - include in analysis", "Irrelevant - exclude from analysis", "An opportunity cost", "A variable cost"],
        "correct": 1,
        "explanation": "Allocated overhead continues regardless of the laundry decision - irrelevant."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.2.5: Restaurant Bread Production
(
  'd0600000-0000-0000-0002-000000000005',
  'd0000000-0000-0000-0000-000000000006',
  '6.2.5',
  10,
  'Restaurant Bread Production',
  'restaurant-bread-production',
  'lesson',
  10,
  30,
  'basic',
  '{"markdown": "# Restaurant Bread Production Decision\n\n## Chez Pierre Bakery Analysis\n\n**Should the restaurant bake bread in-house or buy from bakery?**\n\n---\n\n## Current In-House Costs (Monthly, 3,000 loaves)\n\n| Cost | Total | Per Loaf | Avoidable? |\n|------|-------|----------|------------|\n| Flour, yeast, etc. | CHF 1,200 | CHF 0.40 | Yes |\n| Baker labor (part-time) | CHF 2,400 | CHF 0.80 | Yes |\n| Utilities (oven) | CHF 450 | CHF 0.15 | Yes |\n| Oven depreciation | CHF 300 | CHF 0.10 | No |\n| Supervisor (allocated) | CHF 600 | CHF 0.20 | No |\n| **Total** | **CHF 4,950** | **CHF 1.65** | |\n| **Avoidable** | **CHF 4,050** | **CHF 1.35** | |\n\n---\n\n## Bakery Quote\n\n- Price: CHF 1.50 per loaf\n- Monthly cost: 3,000 x CHF 1.50 = CHF 4,500\n\n---\n\n## Cost Comparison\n\n| | Make | Buy |\n|-|------|-----|\n| Monthly cost | CHF 4,050 | CHF 4,500 |\n| Per loaf | CHF 1.35 | CHF 1.50 |\n\n**Making saves CHF 450/month**\n\n---\n\n## But Wait - Opportunity Cost!\n\nIf baker is freed, she could work on pastries that earn CHF 800/month profit.\n\n| | Make | Buy |\n|-|------|-----|\n| Direct costs | CHF 4,050 | CHF 4,500 |\n| Opportunity cost | CHF 800 | CHF 0 |\n| **Total** | **CHF 4,850** | **CHF 4,500** |\n\nWith opportunity cost, **buying saves CHF 350/month**\n\n---\n\n## Qualitative Considerations\n\n| Factor | In-House | Outsource |\n|--------|----------|----------|\n| Quality | Controlled | Depends on supplier |\n| Freshness | Maximum | Delivery schedule |\n| Customization | High | Limited |\n| Consistency | May vary | Standardized |\n| Menu flexibility | High | Constrained |\n\n---\n\n:::takeaways\n- Include only avoidable costs in analysis\n- Opportunity costs can change the decision\n- A purely cost-based decision may overlook important factors\n- Consider what else freed resources could do\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.2.6: Make or Buy Checkpoint
(
  'd0600000-0000-0000-0002-000000000006',
  'd0000000-0000-0000-0000-000000000006',
  '6.2.6',
  11,
  'Make or Buy Checkpoint',
  'make-or-buy-checkpoint',
  'checkpoint',
  12,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "In make-or-buy, which cost type is typically irrelevant?",
        "options": ["Direct materials", "Direct labor", "Allocated fixed overhead", "Variable overhead"],
        "correct": 2,
        "explanation": "Allocated fixed overhead usually continues regardless of the decision."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Avoidable costs CHF 30,000, Buy price CHF 28,000, Opportunity cost if make CHF 4,000. Total relevant cost to make:",
        "options": ["CHF 30,000", "CHF 34,000", "CHF 28,000", "CHF 32,000"],
        "correct": 1,
        "explanation": "Make cost = Avoidable + Opportunity = 30,000 + 4,000 = CHF 34,000"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Using previous data, the company should:",
        "options": ["Make - CHF 6,000 cheaper", "Buy - CHF 6,000 cheaper", "Make - CHF 2,000 cheaper", "Buy - CHF 2,000 cheaper"],
        "correct": 1,
        "explanation": "Buy CHF 28,000 vs Make CHF 34,000 = Buy saves CHF 6,000"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Depreciation on existing manufacturing equipment is relevant to a make-or-buy decision.",
        "correct": false,
        "explanation": "False. Depreciation is a sunk cost - the equipment is already owned."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "A hotel worries about supplier reliability for outsourced services. This is a:",
        "options": ["Quantitative factor", "Qualitative factor", "Sunk cost", "Variable cost"],
        "correct": 1,
        "explanation": "Reliability concerns are qualitative factors that may influence the decision."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- Activity 6.3.1: Evaluating Special Orders
(
  'd0600000-0000-0000-0003-000000000001',
  'd0000000-0000-0000-0000-000000000006',
  '6.3.1',
  12,
  'Evaluating Special Orders',
  'evaluating-special-orders',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Evaluating Special Orders\n\n## What is a Special Order?\n\nA one-time order at a price different from the regular price, often from:\n- Group bookings at discounted rates\n- Off-peak period offers\n- Volume discounts to new customers\n- Contract negotiations\n\n---\n\n## The Key Question\n\n> **Will accepting the order increase overall profit?**\n\nAccept if: **Incremental Revenue > Incremental Costs**\n\n---\n\n## Relevant Costs for Special Orders\n\n### Include:\n- Variable costs of the order\n- Any additional costs specifically for this order\n- Opportunity costs if capacity is constrained\n\n### Exclude:\n- Fixed costs (if they don''t change)\n- Allocated overhead (unavoidable)\n\n---\n\n## Assumptions for Special Order Analysis\n\n1. **Excess capacity exists** - can fill order without affecting regular sales\n2. **One-time order** - won''t affect regular pricing\n3. **No cannibalization** - won''t take away regular customers\n4. **Fixed costs unchanged** - no capacity expansion needed\n\n---\n\n## Example: Hotel Group Booking\n\n**Regular pricing:**\n- Room rate: CHF 200/night\n- Variable cost: CHF 50/room\n- CM per room: CHF 150\n\n**Special offer from tour group:**\n- 50 rooms for 3 nights\n- Offered rate: CHF 120/night\n- Currently only 60% occupied (excess capacity exists)\n\n---\n\n## Analysis\n\n| Per Room Night | Regular | Special Order |\n|---------------|---------|---------------|\n| Revenue | CHF 200 | CHF 120 |\n| Variable costs | CHF 50 | CHF 50 |\n| Contribution margin | CHF 150 | CHF 70 |\n\n### Total Contribution from Special Order:\n$$50 \\text{ rooms} \\times 3 \\text{ nights} \\times \\text{CHF 70} = \\text{CHF 10,500}$$\n\n**Decision: Accept!** The order adds CHF 10,500 to profit.\n\n---\n\n## When to Reject Special Orders\n\n| Scenario | Concern |\n|----------|----------|\n| Price below variable cost | Loses money on each unit |\n| No excess capacity | Displaces regular customers |\n| Price erosion risk | Sets precedent for lower prices |\n| Quality/brand concerns | Damages reputation |\n\n---\n\n:::takeaways\n- Accept if incremental revenue exceeds incremental cost\n- Fixed costs are usually irrelevant (unchanged)\n- Must have excess capacity\n- Consider long-term implications\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.3.2: Special Order Quiz
(
  'd0600000-0000-0000-0003-000000000002',
  'd0000000-0000-0000-0000-000000000006',
  '6.3.2',
  13,
  'Special Order Concepts',
  'special-order-concepts',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A special order should be accepted if:",
        "options": ["Price exceeds full cost", "Incremental revenue exceeds incremental cost", "Price exceeds regular price", "All customers get the same price"],
        "correct": 1,
        "explanation": "Accept if incremental (additional) revenue exceeds incremental costs."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Special order: 100 units @ CHF 80. Variable cost CHF 60/unit. Fixed costs CHF 30/unit. Incremental profit:",
        "options": ["CHF 2,000", "CHF 5,000", "CHF (1,000)", "CHF 8,000"],
        "correct": 0,
        "explanation": "Incremental CM = (80 - 60) x 100 = CHF 2,000. Fixed costs don''t change."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If the company is at full capacity, a special order would:",
        "options": ["Always be accepted", "Require considering lost regular sales", "Never be profitable", "Reduce fixed costs"],
        "correct": 1,
        "explanation": "At full capacity, accepting the special order means losing regular sales (opportunity cost)."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "A special order priced below full cost can still be profitable.",
        "correct": true,
        "explanation": "True. If price exceeds variable cost, it contributes to fixed costs and profit."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Regular price CHF 150, VC CHF 80, offered special price CHF 100. Per-unit contribution:",
        "options": ["CHF 70", "CHF 20", "CHF 50", "CHF (50)"],
        "correct": 1,
        "explanation": "Special CM = 100 - 80 = CHF 20 (still positive)."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "exam",
        "question": "A hotel fears accepting a tour group discount will encourage other groups to demand the same rate. This is:",
        "options": ["A sunk cost", "An opportunity cost", "A qualitative concern", "A variable cost"],
        "correct": 2,
        "explanation": "Price erosion is a qualitative long-term concern beyond the numbers."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.3.3: Special Order Calculator Interactive
(
  'd0600000-0000-0000-0003-000000000003',
  'd0000000-0000-0000-0000-000000000006',
  '6.3.3',
  14,
  'Special Order Calculator',
  'special-order-calculator',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Match each special order scenario to the correct decision.",
    "pairs": [
      {"left": "Price CHF 75, VC CHF 50, excess capacity", "right": "Accept (CHF 25 CM)"},
      {"left": "Price CHF 40, VC CHF 50, excess capacity", "right": "Reject (negative CM)"},
      {"left": "Price CHF 60, VC CHF 40, at full capacity, regular CM CHF 35", "right": "Reject (special CM CHF 20 < regular CHF 35)"},
      {"left": "Price CHF 90, VC CHF 55, excess capacity", "right": "Accept (CHF 35 CM)"},
      {"left": "Price CHF 100, VC CHF 80, full capacity, regular CM CHF 25", "right": "Accept (special CM CHF 20 needs comparison but regular is only CHF 25 so may need more info)"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

-- Activity 6.3.4: Group Booking Offer Practice
(
  'd0600000-0000-0000-0003-000000000004',
  'd0000000-0000-0000-0000-000000000006',
  '6.3.4',
  15,
  'Group Booking Offer',
  'group-booking-offer',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Hotel: 200 rooms, 70% occupied. VC CHF 45/room. Group offers CHF 100/night for 40 rooms x 2 nights. Incremental profit:",
        "options": ["CHF 4,400", "CHF 8,000", "CHF 3,600", "Cannot accept"],
        "correct": 0,
        "explanation": "Available: 60 rooms (30% of 200). CM = (100-45) x 40 x 2 = CHF 4,400"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If the same hotel were 95% occupied, accepting the group would:",
        "options": ["Still generate CHF 4,400", "Displace regular guests", "Be impossible", "Reduce variable costs"],
        "correct": 1,
        "explanation": "At 95%, only 10 rooms available. Accepting 40 displaces 30 regular guests."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Regular rate CHF 180, VC CHF 45. Group needs 30 rooms, only 20 available. If 10 regular guests displaced, opportunity cost:",
        "options": ["CHF 1,350", "CHF 1,800", "CHF 4,050", "CHF 550"],
        "correct": 0,
        "explanation": "Lost regular CM = 10 x (180-45) = 10 x 135 = CHF 1,350"
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A special order that covers variable costs always improves profitability when there is excess capacity.",
        "correct": true,
        "explanation": "True. Any CM above CHF 0 contributes to covering fixed costs and profit."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "The restaurant receives a request for 100 meals at CHF 35 (regular CHF 50, VC CHF 28). With excess capacity, incremental profit:",
        "options": ["CHF 700", "CHF 2,200", "CHF 3,500", "CHF 2,800"],
        "correct": 0,
        "explanation": "CM = (35 - 28) x 100 = CHF 700"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.3.5: Special Order Checkpoint
(
  'd0600000-0000-0000-0003-000000000005',
  'd0000000-0000-0000-0000-000000000006',
  '6.3.5',
  16,
  'Special Order Checkpoint',
  'special-order-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "The minimum acceptable special order price (with excess capacity) is:",
        "options": ["Full cost", "Variable cost", "Regular price", "Average cost"],
        "correct": 1,
        "explanation": "Any price above variable cost contributes to profit with excess capacity."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Special order: 200 units @ CHF 45, VC CHF 30. Accept if there is:",
        "options": ["Full capacity", "Excess capacity", "No opportunity cost", "Both B and C"],
        "correct": 3,
        "explanation": "Need excess capacity and should have no better use for that capacity."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Incremental profit from accepting the order above is:",
        "options": ["CHF 3,000", "CHF 6,000", "CHF 9,000", "CHF 15,000"],
        "correct": 0,
        "explanation": "Incremental profit = (45 - 30) x 200 = CHF 3,000"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Fixed costs should be ignored in special order analysis if they do not change.",
        "correct": true,
        "explanation": "True. Only costs that change with the decision are relevant."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "A key assumption in special order analysis is that:",
        "options": ["The order will be repeated", "Regular customers will get the same price", "Regular sales are not affected", "Fixed costs will increase"],
        "correct": 2,
        "explanation": "We assume the special order doesn''t cannibalize regular business."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- Activity 6.4.1: Keep or Drop Segment Analysis
(
  'd0600000-0000-0000-0004-000000000001',
  'd0000000-0000-0000-0000-000000000006',
  '6.4.1',
  17,
  'Keep or Drop Segment Analysis',
  'keep-or-drop-analysis',
  'lesson',
  12,
  30,
  'basic',
  '{"markdown": "# Keep or Drop Segment Analysis\n\n## The Elimination Decision\n\nShould we discontinue a product line, close a department, or drop a service that appears to be losing money?\n\n---\n\n## The Key Insight\n\n:::concept{title=\"Segment Losses Can Be Deceiving\"}\nA segment may show a \"loss\" due to allocated fixed costs but still contribute positively to overall profit!\n\n**Drop only if avoidable costs exceed the segment''s revenue.**\n:::\n\n---\n\n## Relevant Analysis\n\nCompare:\n1. **Contribution lost** if segment is dropped (revenue - variable costs)\n2. **Fixed costs avoided** if segment is dropped\n\n| | Keep | Drop |\n|-|------|------|\n| Revenue | Revenue | 0 |\n| Variable costs | (VC) | 0 |\n| Contribution margin | CM | 0 |\n| Fixed costs | (FC) | (Unavoidable FC) |\n| Segment profit | Result | Result |\n\n---\n\n## Example: Hotel Restaurant Division\n\n**Restaurant Department P&L:**\n\n| | Amount |\n|-|--------|\n| Revenue | CHF 400,000 |\n| Variable costs | (240,000) |\n| Contribution margin | 160,000 |\n| Direct fixed costs (avoidable) | (100,000) |\n| Allocated fixed costs (unavoidable) | (80,000) |\n| **Segment Loss** | **(CHF 20,000)** |\n\n---\n\n## Should We Close the Restaurant?\n\n**If closed:**\n- Lose: Revenue CHF 400,000\n- Save: Variable costs CHF 240,000\n- Save: Avoidable fixed costs CHF 100,000\n- **Still pay**: Allocated fixed CHF 80,000 (unavoidable)\n\n### Analysis:\n\n| | Keep | Drop |\n|-|------|------|\n| Contribution margin | CHF 160,000 | 0 |\n| Avoidable fixed costs | (100,000) | 0 |\n| **Segment margin** | **CHF 60,000** | **0** |\n\nDropping the restaurant loses CHF 60,000 contribution to fixed costs!\n\n---\n\n## Decision Rule\n\n**Keep the segment if:**\n$$\\text{Contribution Margin} > \\text{Avoidable Fixed Costs}$$\n\n**Drop the segment if:**\n$$\\text{Contribution Margin} < \\text{Avoidable Fixed Costs}$$\n\n---\n\n## Impact on Total Company\n\n| | With Restaurant | Without |\n|-|-----------------|----------|\n| Hotel profit | CHF X | CHF X |\n| Restaurant segment margin | CHF 60,000 | 0 |\n| Unallocated fixed costs | (80,000) | (80,000) |\n| **Change** | | **CHF (60,000)** |\n\nTotal company profit decreases by CHF 60,000 if restaurant is dropped.\n\n---\n\n:::takeaways\n- Segment \"losses\" may include allocated unavoidable costs\n- Focus on segment margin (CM - Avoidable FC)\n- If segment margin is positive, keep the segment\n- Dropping a positive-margin segment hurts total profit\n:::"}'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.4.2: Keep or Drop Quiz
(
  'd0600000-0000-0000-0004-000000000002',
  'd0000000-0000-0000-0000-000000000006',
  '6.4.2',
  18,
  'Keep or Drop Concepts',
  'keep-or-drop-concepts',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A segment should be dropped if:",
        "options": ["It shows any loss", "Its contribution margin is negative", "Avoidable costs exceed revenue", "It has high allocated costs"],
        "correct": 2,
        "explanation": "Drop only if the segment cannot cover its avoidable costs."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Segment: Revenue CHF 200K, VC CHF 130K, Avoidable FC CHF 50K, Allocated FC CHF 40K. Segment margin:",
        "options": ["CHF 20,000", "CHF 70,000", "CHF (20,000)", "CHF 30,000"],
        "correct": 0,
        "explanation": "CM = 200 - 130 = 70. Segment margin = 70 - 50 = CHF 20,000"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "With CHF 20,000 positive segment margin, should the segment be kept?",
        "options": ["No - it shows a loss after allocation", "Yes - it contributes to fixed costs", "Indifferent", "Need more data"],
        "correct": 1,
        "explanation": "Positive segment margin means the segment helps cover unavoidable costs."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "Allocated common costs are usually avoidable if a segment is dropped.",
        "correct": false,
        "explanation": "False. Allocated common costs typically continue regardless of segment elimination."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Dropping a segment with CHF 30,000 positive segment margin would _____ total company profit.",
        "options": ["Increase by CHF 30,000", "Decrease by CHF 30,000", "Not affect", "Decrease by the segment loss"],
        "correct": 1,
        "explanation": "Losing CHF 30,000 segment margin decreases total profit by that amount."
      },
      {
        "id": "q6",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Which cost would most likely be avoidable if a hotel spa is closed?",
        "options": ["Hotel insurance", "Corporate allocation", "Spa manager salary", "Building depreciation"],
        "correct": 2,
        "explanation": "The spa manager would not be needed if the spa closes."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.4.3: Segment Analysis Interactive
(
  'd0600000-0000-0000-0004-000000000003',
  'd0000000-0000-0000-0000-000000000006',
  '6.4.3',
  19,
  'Segment Analysis Tool',
  'segment-analysis-tool',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Sort each cost as Avoidable or Unavoidable if the restaurant segment is closed.",
    "categories": ["Avoidable (Saved if Closed)", "Unavoidable (Continues)"],
    "items": [
      {"text": "Restaurant manager salary", "category": "Avoidable (Saved if Closed)"},
      {"text": "Food ingredients", "category": "Avoidable (Saved if Closed)"},
      {"text": "Hotel general manager salary", "category": "Unavoidable (Continues)"},
      {"text": "Restaurant equipment maintenance", "category": "Avoidable (Saved if Closed)"},
      {"text": "Corporate headquarters allocation", "category": "Unavoidable (Continues)"},
      {"text": "Restaurant server wages", "category": "Avoidable (Saved if Closed)"},
      {"text": "Hotel property taxes", "category": "Unavoidable (Continues)"},
      {"text": "Restaurant advertising", "category": "Avoidable (Saved if Closed)"}
    ]
  }'::jsonb,
  'category-sort',
  false,
  true
),

-- Activity 6.4.4: Hotel Restaurant Division Practice
(
  'd0600000-0000-0000-0004-000000000004',
  'd0000000-0000-0000-0000-000000000006',
  '6.4.4',
  20,
  'Hotel Restaurant Division',
  'hotel-restaurant-division',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Restaurant: Revenue CHF 500K, VC CHF 300K, Avoidable FC CHF 180K, Allocated FC CHF 50K. Segment shows loss of CHF 30K. Should it close?",
        "options": ["Yes - it is losing money", "No - segment margin is positive CHF 20K", "Need more information", "Yes - allocated costs are too high"],
        "correct": 1,
        "explanation": "Segment margin = CM 200K - Avoidable 180K = CHF 20K positive. Keep it."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If restaurant closes, total company profit changes by:",
        "options": ["Increases CHF 30,000", "Decreases CHF 20,000", "Increases CHF 20,000", "No change"],
        "correct": 1,
        "explanation": "Losing the CHF 20,000 segment margin reduces total profit."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "At what CM would we be indifferent to closing?",
        "options": ["CHF 230,000", "CHF 200,000", "CHF 180,000", "CHF 150,000"],
        "correct": 2,
        "explanation": "Indifferent when CM = Avoidable FC = CHF 180,000 (segment margin = 0)."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "applied",
        "question": "If a segment has a negative segment margin, it should definitely be dropped.",
        "correct": false,
        "explanation": "Usually yes, but consider qualitative factors like customer traffic it brings."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "A hotel restaurant draws guests who book rooms. Closing the restaurant might affect:",
        "options": ["Only restaurant revenue", "Room revenue too", "Fixed costs only", "Nothing else"],
        "correct": 1,
        "explanation": "Complementary effects: some guests choose the hotel because of the restaurant."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

-- Activity 6.4.5: Keep or Drop Checkpoint
(
  'd0600000-0000-0000-0004-000000000005',
  'd0000000-0000-0000-0000-000000000006',
  '6.4.5',
  21,
  'Keep or Drop Checkpoint',
  'keep-or-drop-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Segment margin equals contribution margin minus:",
        "options": ["All fixed costs", "Avoidable fixed costs only", "Variable costs", "Allocated costs only"],
        "correct": 1,
        "explanation": "Segment margin = CM - Avoidable (traceable) fixed costs"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Spa: CM CHF 80,000, Avoidable FC CHF 90,000, Allocated CHF 30,000. Segment margin:",
        "options": ["CHF (10,000)", "CHF (40,000)", "CHF 50,000", "CHF 80,000"],
        "correct": 0,
        "explanation": "Segment margin = 80,000 - 90,000 = CHF (10,000)"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "With negative segment margin, the spa should likely be:",
        "options": ["Kept - it covers some costs", "Dropped - costs exceed contribution", "Expanded", "Given more allocation"],
        "correct": 1,
        "explanation": "Negative segment margin means the segment does not cover its avoidable costs."
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Dropping a segment with negative segment margin will improve total company profit.",
        "correct": true,
        "explanation": "True. Eliminating the negative margin stops the drain on company profit."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "The key to keep-or-drop decisions is identifying:",
        "options": ["Total costs", "Avoidable vs unavoidable costs", "Revenue growth", "Market share"],
        "correct": 1,
        "explanation": "Separating avoidable from unavoidable costs determines the relevant analysis."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
);

-- ============================================
-- Link Activities to Skills
-- ============================================

INSERT INTO activity_skills (activity_id, skill_id, is_primary, weight) VALUES
-- Skill MA-20: Relevant vs Irrelevant Costs
('d0600000-0000-0000-0001-000000000001', 'd0000000-0000-0000-0006-000000000001', true, 1.0),
('d0600000-0000-0000-0001-000000000002', 'd0000000-0000-0000-0006-000000000001', true, 1.0),
('d0600000-0000-0000-0001-000000000003', 'd0000000-0000-0000-0006-000000000001', true, 1.0),
('d0600000-0000-0000-0001-000000000004', 'd0000000-0000-0000-0006-000000000001', true, 1.0),
('d0600000-0000-0000-0001-000000000005', 'd0000000-0000-0000-0006-000000000001', true, 1.0),

-- Skill MA-21: Make or Buy Decisions
('d0600000-0000-0000-0002-000000000001', 'd0000000-0000-0000-0006-000000000002', true, 1.0),
('d0600000-0000-0000-0002-000000000002', 'd0000000-0000-0000-0006-000000000002', true, 1.0),
('d0600000-0000-0000-0002-000000000003', 'd0000000-0000-0000-0006-000000000002', true, 1.0),
('d0600000-0000-0000-0002-000000000004', 'd0000000-0000-0000-0006-000000000002', true, 1.0),
('d0600000-0000-0000-0002-000000000005', 'd0000000-0000-0000-0006-000000000002', true, 1.0),
('d0600000-0000-0000-0002-000000000006', 'd0000000-0000-0000-0006-000000000002', true, 1.0),

-- Skill MA-22: Special Order Decisions
('d0600000-0000-0000-0003-000000000001', 'd0000000-0000-0000-0006-000000000003', true, 1.0),
('d0600000-0000-0000-0003-000000000002', 'd0000000-0000-0000-0006-000000000003', true, 1.0),
('d0600000-0000-0000-0003-000000000003', 'd0000000-0000-0000-0006-000000000003', true, 1.0),
('d0600000-0000-0000-0003-000000000004', 'd0000000-0000-0000-0006-000000000003', true, 1.0),
('d0600000-0000-0000-0003-000000000005', 'd0000000-0000-0000-0006-000000000003', true, 1.0),

-- Skill MA-23: Keep or Drop Decisions
('d0600000-0000-0000-0004-000000000001', 'd0000000-0000-0000-0006-000000000004', true, 1.0),
('d0600000-0000-0000-0004-000000000002', 'd0000000-0000-0000-0006-000000000004', true, 1.0),
('d0600000-0000-0000-0004-000000000003', 'd0000000-0000-0000-0006-000000000004', true, 1.0),
('d0600000-0000-0000-0004-000000000004', 'd0000000-0000-0000-0006-000000000004', true, 1.0),
('d0600000-0000-0000-0004-000000000005', 'd0000000-0000-0000-0006-000000000004', true, 1.0);

