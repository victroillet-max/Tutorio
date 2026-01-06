-- ============================================
-- Swiss Motel Capstone Case Study
-- Comprehensive integration of all MA concepts
-- ============================================

-- ============================================
-- Insert the Swiss Motel Case Study as a Challenge Activity
-- This is placed in Module 8 as the final capstone
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

(
  'd0800000-0000-0000-0005-000000000001',
  'd0000000-0000-0000-0000-000000000008',
  '8.5.1',
  24,
  'Swiss Motel Case Study - Introduction',
  'swiss-motel-case-introduction',
  'lesson',
  15,
  40,
  'basic',
  '{"markdown": "# Swiss Motel Case Study\n\n## Welcome to Swiss Motel\n\nYou have been hired as the new Management Accountant for **Swiss Motel**, a 150-room boutique hotel in the Swiss Alps. The hotel offers accommodation, a restaurant, and a spa facility.\n\n---\n\n## Your Challenge\n\nThe General Manager, Ms. Elena Brunner, has asked you to apply your managerial accounting skills to help improve the hotel''s financial performance. You will work through a series of real-world scenarios covering:\n\n1. **Cost Classification** - Categorize the hotel''s costs\n2. **Cost-Volume-Profit Analysis** - Determine break-even and target profits\n3. **Costing Decisions** - Evaluate pricing and product mix\n4. **Budgeting** - Prepare operational budgets\n5. **Variance Analysis** - Analyze performance vs. plan\n\n---\n\n## Hotel Overview\n\n### Room Categories\n\n| Category | Rooms | Rack Rate | Variable Cost/Night |\n|----------|-------|-----------|--------------------|\n| Standard | 80 | CHF 180 | CHF 45 |\n| Superior | 50 | CHF 280 | CHF 65 |\n| Suite | 20 | CHF 450 | CHF 95 |\n\n### Other Revenue Centers\n\n| Department | Average Revenue | Variable Cost % |\n|------------|-----------------|----------------|\n| Restaurant | CHF 85/cover | 35% |\n| Spa | CHF 120/treatment | 25% |\n\n### Fixed Costs (Monthly)\n\n| Category | Amount |\n|----------|--------|\n| Staff salaries | CHF 180,000 |\n| Property costs | CHF 85,000 |\n| Utilities | CHF 25,000 |\n| Marketing | CHF 15,000 |\n| Administration | CHF 20,000 |\n| **Total Fixed Costs** | **CHF 325,000** |\n\n---\n\n## Historical Performance\n\n**Last Month''s Occupancy:**\n- Standard: 65% (1,612 room nights)\n- Superior: 72% (1,116 room nights)\n- Suite: 58% (348 room nights)\n\n**Restaurant:** 2,400 covers\n**Spa:** 850 treatments\n\n---\n\n## Your Task\n\nComplete each section of this case study to demonstrate your mastery of managerial accounting concepts. Each section builds on the previous one, culminating in a comprehensive variance analysis.\n\n---\n\n:::concept{title=\"Case Study Approach\"}\nWork through each scenario carefully. Use the formulas and frameworks you have learned. Show your calculations and explain your reasoning.\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0005-000000000002',
  'd0000000-0000-0000-0000-000000000008',
  '8.5.2',
  25,
  'Swiss Motel - Cost Classification',
  'swiss-motel-cost-classification',
  'challenge',
  20,
  60,
  'basic',
  '{
    "scenario": "Ms. Brunner has given you a list of costs and asked you to classify them for management decision-making.",
    "parts": [
      {
        "id": "part1",
        "question": "Classify each cost as Fixed (F) or Variable (V):\n\nA. Housekeeping supplies per room\nB. Front desk staff salaries\nC. Restaurant food ingredients\nD. Property insurance\nE. Spa therapist commissions (per treatment)\nF. Electricity for air conditioning\nG. Marketing agency retainer\nH. Laundry chemicals per room night",
        "answer_format": "letter-list",
        "correct": ["V", "F", "V", "F", "V", "M", "F", "V"],
        "explanation": "A: Variable (usage depends on occupancy)\nB: Fixed (salaries don''t change with volume)\nC: Variable (depends on covers served)\nD: Fixed (annual premium)\nE: Variable (paid per treatment)\nF: Mixed (base + usage component)\nG: Fixed (monthly retainer)\nH: Variable (per room cleaned)"
      },
      {
        "id": "part2",
        "question": "Calculate the contribution margin per room night for each room category.\n\nStandard: Rack Rate CHF 180, Variable Cost CHF 45\nSuperior: Rack Rate CHF 280, Variable Cost CHF 65\nSuite: Rack Rate CHF 450, Variable Cost CHF 95",
        "answer_format": "numeric-list",
        "correct": [135, 215, 355],
        "explanation": "CM = Revenue - Variable Costs\nStandard: 180 - 45 = CHF 135\nSuperior: 280 - 65 = CHF 215\nSuite: 450 - 95 = CHF 355"
      },
      {
        "id": "part3",
        "question": "What is the weighted average contribution margin per room night, assuming the current sales mix (1,612 Standard, 1,116 Superior, 348 Suite = 3,076 total room nights)?",
        "answer_format": "numeric",
        "correct": 175.52,
        "tolerance": 2,
        "explanation": "Total CM = (1,612 x 135) + (1,116 x 215) + (348 x 355) = 217,620 + 239,940 + 123,540 = CHF 539,700\nWACM = 539,700 / 3,076 = CHF 175.52"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0005-000000000003',
  'd0000000-0000-0000-0000-000000000008',
  '8.5.3',
  26,
  'Swiss Motel - CVP Analysis',
  'swiss-motel-cvp-analysis',
  'challenge',
  25,
  70,
  'basic',
  '{
    "scenario": "Ms. Brunner wants to understand the hotel''s break-even point and profit potential.",
    "parts": [
      {
        "id": "part1",
        "question": "Using only room revenue (ignoring restaurant and spa), calculate the break-even point in room nights.\n\nData: Fixed Costs = CHF 325,000/month, WACM = CHF 175.52 per room night",
        "answer_format": "numeric",
        "correct": 1852,
        "tolerance": 10,
        "explanation": "Break-even = Fixed Costs / WACM = 325,000 / 175.52 = 1,852 room nights"
      },
      {
        "id": "part2",
        "question": "What is the break-even occupancy rate?\n\n(Total capacity: 150 rooms x 31 days = 4,650 room nights/month)",
        "answer_format": "percentage",
        "correct": 39.8,
        "tolerance": 1,
        "explanation": "Break-even occupancy = 1,852 / 4,650 = 39.8%"
      },
      {
        "id": "part3",
        "question": "Ms. Brunner has a target profit of CHF 150,000 per month. How many room nights are needed to achieve this target?",
        "answer_format": "numeric",
        "correct": 2706,
        "tolerance": 10,
        "explanation": "Target volume = (Fixed Costs + Target Profit) / WACM\n= (325,000 + 150,000) / 175.52 = 475,000 / 175.52 = 2,706 room nights"
      },
      {
        "id": "part4",
        "question": "If the hotel sold 3,076 room nights (as in last month), what would be the operating profit from rooms only?",
        "answer_format": "numeric",
        "correct": 214700,
        "tolerance": 500,
        "explanation": "Profit = Total CM - Fixed Costs = 539,700 - 325,000 = CHF 214,700"
      },
      {
        "id": "part5",
        "question": "What is the margin of safety in room nights?\n\n(Actual sales - Break-even sales)",
        "answer_format": "numeric",
        "correct": 1224,
        "tolerance": 15,
        "explanation": "MOS = 3,076 - 1,852 = 1,224 room nights"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0005-000000000004',
  'd0000000-0000-0000-0000-000000000008',
  '8.5.4',
  27,
  'Swiss Motel - Pricing Decision',
  'swiss-motel-pricing-decision',
  'challenge',
  20,
  60,
  'basic',
  '{
    "scenario": "A corporate client wants to book 200 Standard room nights at a discounted rate of CHF 120/night.",
    "parts": [
      {
        "id": "part1",
        "question": "What is the contribution margin per room night at the discounted rate?\n\n(Variable cost per Standard room = CHF 45)",
        "answer_format": "numeric",
        "correct": 75,
        "tolerance": 0,
        "explanation": "CM = 120 - 45 = CHF 75 per room night"
      },
      {
        "id": "part2",
        "question": "Assuming these are incremental bookings (the hotel has capacity), what is the total contribution from accepting this order?",
        "answer_format": "numeric",
        "correct": 15000,
        "tolerance": 0,
        "explanation": "Total CM = 200 x 75 = CHF 15,000"
      },
      {
        "id": "part3",
        "question": "Should Swiss Motel accept this order? Select the best answer.",
        "answer_format": "mcq",
        "options": [
          "No, because the rate is below the normal price",
          "Yes, because it covers variable costs and contributes CHF 15,000 to fixed costs and profit",
          "No, because it would upset regular guests",
          "Yes, but only if occupancy is below 50%"
        ],
        "correct": 1,
        "explanation": "Accept: Price > Variable Cost, so it makes a positive contribution. This is a short-term decision assuming capacity exists."
      },
      {
        "id": "part4",
        "question": "What is the minimum price Swiss Motel should accept for a Standard room (short-term)?",
        "answer_format": "numeric",
        "correct": 45,
        "tolerance": 0,
        "explanation": "Minimum price = Variable Cost = CHF 45. Any price above this contributes to fixed costs."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0005-000000000005',
  'd0000000-0000-0000-0000-000000000008',
  '8.5.5',
  28,
  'Swiss Motel - Budgeting',
  'swiss-motel-budgeting',
  'challenge',
  25,
  70,
  'basic',
  '{
    "scenario": "Ms. Brunner wants you to prepare a budget for next month. Expected occupancy: Standard 70%, Superior 75%, Suite 60%.",
    "parts": [
      {
        "id": "part1",
        "question": "Calculate budgeted room nights for each category.\n\nStandard: 80 rooms x 30 days x 70%\nSuperior: 50 rooms x 30 days x 75%\nSuite: 20 rooms x 30 days x 60%",
        "answer_format": "numeric-list",
        "correct": [1680, 1125, 360],
        "explanation": "Standard: 80 x 30 x 0.70 = 1,680\nSuperior: 50 x 30 x 0.75 = 1,125\nSuite: 20 x 30 x 0.60 = 360"
      },
      {
        "id": "part2",
        "question": "Calculate total budgeted room revenue.",
        "answer_format": "numeric",
        "correct": 779250,
        "tolerance": 100,
        "explanation": "Revenue = (1,680 x 180) + (1,125 x 280) + (360 x 450)\n= 302,400 + 315,000 + 162,000 = CHF 779,400"
      },
      {
        "id": "part3",
        "question": "Calculate total budgeted variable costs for rooms.",
        "answer_format": "numeric",
        "correct": 182025,
        "tolerance": 100,
        "explanation": "VC = (1,680 x 45) + (1,125 x 65) + (360 x 95)\n= 75,600 + 73,125 + 34,200 = CHF 182,925"
      },
      {
        "id": "part4",
        "question": "Calculate budgeted contribution margin.",
        "answer_format": "numeric",
        "correct": 597075,
        "tolerance": 200,
        "explanation": "CM = Revenue - VC = 779,400 - 182,925 = CHF 596,475"
      },
      {
        "id": "part5",
        "question": "Calculate budgeted operating profit.\n\n(Fixed costs = CHF 325,000)",
        "answer_format": "numeric",
        "correct": 271475,
        "tolerance": 500,
        "explanation": "Profit = CM - FC = 596,475 - 325,000 = CHF 271,475"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0005-000000000006',
  'd0000000-0000-0000-0000-000000000008',
  '8.5.6',
  29,
  'Swiss Motel - Variance Analysis',
  'swiss-motel-variance-analysis',
  'challenge',
  30,
  80,
  'basic',
  '{
    "scenario": "The month has ended. Actual results are in. Time to analyze variances.\n\nActual Results:\n- Standard: 1,650 room nights @ CHF 175/night (actual variable cost CHF 48)\n- Superior: 1,100 room nights @ CHF 275/night (actual variable cost CHF 68)\n- Suite: 340 room nights @ CHF 440/night (actual variable cost CHF 92)\n\nActual Fixed Costs: CHF 332,000",
    "parts": [
      {
        "id": "part1",
        "question": "Calculate the Sales Volume Variance for Standard rooms.\n\nBudgeted: 1,680 rooms x CHF 135 CM\nActual: 1,650 rooms x CHF 135 standard CM",
        "answer_format": "numeric",
        "correct": -4050,
        "tolerance": 50,
        "explanation": "Volume Variance = (Actual units - Budgeted units) x Standard CM\n= (1,650 - 1,680) x 135 = -30 x 135 = CHF 4,050 U"
      },
      {
        "id": "part2",
        "question": "Calculate the Sales Price Variance for Standard rooms.\n\nActual price CHF 175 vs Standard CHF 180, for 1,650 rooms",
        "answer_format": "numeric",
        "correct": -8250,
        "tolerance": 50,
        "explanation": "Price Variance = (Actual Price - Standard Price) x Actual Volume\n= (175 - 180) x 1,650 = -5 x 1,650 = CHF 8,250 U"
      },
      {
        "id": "part3",
        "question": "Calculate the Variable Cost Variance for Standard rooms.\n\nActual VC CHF 48 vs Standard CHF 45, for 1,650 rooms",
        "answer_format": "numeric",
        "correct": -4950,
        "tolerance": 50,
        "explanation": "VC Variance = (Standard VC - Actual VC) x Actual Volume\n= (45 - 48) x 1,650 = -3 x 1,650 = CHF 4,950 U"
      },
      {
        "id": "part4",
        "question": "Calculate the Fixed Cost Variance.\n\nBudgeted: CHF 325,000, Actual: CHF 332,000",
        "answer_format": "numeric",
        "correct": -7000,
        "tolerance": 0,
        "explanation": "FC Variance = Budgeted - Actual = 325,000 - 332,000 = CHF 7,000 U"
      },
      {
        "id": "part5",
        "question": "What is the actual operating profit for rooms?\n\nActual Revenue - Actual VC - Actual FC",
        "answer_format": "numeric",
        "correct": 222010,
        "tolerance": 500,
        "explanation": "Actual Revenue = (1,650 x 175) + (1,100 x 275) + (340 x 440) = 288,750 + 302,500 + 149,600 = CHF 740,850\nActual VC = (1,650 x 48) + (1,100 x 68) + (340 x 92) = 79,200 + 74,800 + 31,280 = CHF 185,280\nProfit = 740,850 - 185,280 - 332,000 = CHF 223,570"
      },
      {
        "id": "part6",
        "question": "What was the budgeted operating profit?",
        "answer_format": "numeric",
        "correct": 271475,
        "tolerance": 500,
        "explanation": "From budgeting section: CHF 271,475"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0005-000000000007',
  'd0000000-0000-0000-0000-000000000008',
  '8.5.7',
  30,
  'Swiss Motel - Management Report',
  'swiss-motel-management-report',
  'lesson',
  15,
  50,
  'basic',
  '{"markdown": "# Swiss Motel - Management Report\n\n## Executive Summary\n\nCongratulations on completing the Swiss Motel case study! Here is a summary of your findings.\n\n---\n\n## Performance Summary\n\n| Metric | Budget | Actual | Variance |\n|--------|--------|--------|----------|\n| Room Nights | 3,165 | 3,090 | (75) U |\n| Room Revenue | CHF 779,400 | CHF 740,850 | (38,550) U |\n| Variable Costs | CHF 182,925 | CHF 185,280 | (2,355) U |\n| Contribution Margin | CHF 596,475 | CHF 555,570 | (40,905) U |\n| Fixed Costs | CHF 325,000 | CHF 332,000 | (7,000) U |\n| **Operating Profit** | **CHF 271,475** | **CHF 223,570** | **(47,905) U** |\n\n---\n\n## Variance Analysis\n\n### Volume Variances\n- Standard rooms: 30 fewer nights (CHF 4,050 U)\n- Superior rooms: 25 fewer nights (CHF 5,375 U)\n- Suite rooms: 20 fewer nights (CHF 7,100 U)\n- **Total Volume Variance: CHF 16,525 U**\n\n### Price Variances\n- Standard: CHF 5 below standard (CHF 8,250 U)\n- Superior: CHF 5 below standard (CHF 5,500 U)\n- Suite: CHF 10 below standard (CHF 3,400 U)\n- **Total Price Variance: CHF 17,150 U**\n\n### Cost Variances\n- Variable cost overruns: CHF 2,355 U\n- Fixed cost overrun: CHF 7,000 U\n- **Total Cost Variance: CHF 9,355 U**\n\n---\n\n## Key Findings\n\n1. **Volume shortfall** across all room categories impacted revenue\n2. **Pricing pressure** - actual rates below rack rates\n3. **Cost control** - variable costs slightly over, fixed costs CHF 7K over\n4. **Suite performance** - largest margin erosion in premium category\n\n---\n\n## Recommendations\n\n1. **Revenue Management** - Review pricing strategy for suites\n2. **Marketing** - Target campaigns to increase occupancy\n3. **Cost Control** - Investigate fixed cost increase (staffing?)\n4. **Mix Improvement** - Focus on higher-margin Superior and Suite rooms\n\n---\n\n## Skills Applied\n\nIn this case study, you successfully applied:\n\n- Cost classification (fixed vs. variable)\n- Contribution margin analysis\n- Break-even and CVP analysis\n- Pricing decisions using relevant costs\n- Budget preparation\n- Variance analysis and interpretation\n\n---\n\n:::takeaways\n- Real-world decisions integrate multiple MA concepts\n- Variance analysis guides management attention\n- Both revenue and cost variances matter\n- Understanding the WHY behind variances is key\n:::"}'::jsonb,
  NULL,
  false,
  true
);

-- ============================================
-- Link Swiss Motel Case Study to Multiple Skills
-- ============================================

-- The case study integrates concepts from multiple skills
INSERT INTO activity_skills (activity_id, skill_id, is_primary, weight) VALUES
-- Introduction - general overview
('d0800000-0000-0000-0005-000000000001', 'd0000000-0000-0000-0001-000000000001', false, 0.6),
('d0800000-0000-0000-0005-000000000001', 'd0000000-0000-0000-0002-000000000001', false, 0.6),

-- Cost Classification section
('d0800000-0000-0000-0005-000000000002', 'd0000000-0000-0000-0002-000000000001', true, 1.0),
('d0800000-0000-0000-0005-000000000002', 'd0000000-0000-0000-0002-000000000002', false, 0.7),
('d0800000-0000-0000-0005-000000000002', 'd0000000-0000-0000-0003-000000000001', false, 0.6),

-- CVP Analysis section
('d0800000-0000-0000-0005-000000000003', 'd0000000-0000-0000-0004-000000000002', true, 1.0),
('d0800000-0000-0000-0005-000000000003', 'd0000000-0000-0000-0004-000000000003', true, 1.0),
('d0800000-0000-0000-0005-000000000003', 'd0000000-0000-0000-0004-000000000004', false, 0.7),

-- Pricing Decision section
('d0800000-0000-0000-0005-000000000004', 'd0000000-0000-0000-0006-000000000001', true, 1.0),
('d0800000-0000-0000-0005-000000000004', 'd0000000-0000-0000-0006-000000000002', false, 0.8),

-- Budgeting section
('d0800000-0000-0000-0005-000000000005', 'd0000000-0000-0000-0007-000000000001', true, 1.0),
('d0800000-0000-0000-0005-000000000005', 'd0000000-0000-0000-0007-000000000002', false, 0.7),

-- Variance Analysis section
('d0800000-0000-0000-0005-000000000006', 'd0000000-0000-0000-0008-000000000001', true, 1.0),
('d0800000-0000-0000-0005-000000000006', 'd0000000-0000-0000-0008-000000000002', false, 0.8),
('d0800000-0000-0000-0005-000000000006', 'd0000000-0000-0000-0008-000000000003', false, 0.7),

-- Management Report - synthesis of all
('d0800000-0000-0000-0005-000000000007', 'd0000000-0000-0000-0001-000000000003', true, 1.0),
('d0800000-0000-0000-0005-000000000007', 'd0000000-0000-0000-0008-000000000004', false, 0.8);

