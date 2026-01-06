-- ============================================
-- Module 8: Variance Analysis Activities
-- 4 Skills: Standard Costing, Materials Variances, Labor Variances, Overhead Variances
-- ~23 Activities with comprehensive content
-- ============================================

-- Clean up existing data to avoid conflicts
DELETE FROM activity_skills WHERE activity_id IN (
  SELECT id FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000008'
);
DELETE FROM activities WHERE module_id = 'd0000000-0000-0000-0000-000000000008';

-- ============================================
-- SKILL: Standard Costing Basics (MA-28)
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES

(
  'd0800000-0000-0000-0001-000000000001',
  'd0000000-0000-0000-0000-000000000008',
  '8.1.1',
  1,
  'Introduction to Standard Costs',
  'introduction-standard-costs',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Introduction to Standard Costs\n\n## What Are Standard Costs?\n\n**Standard costs** are predetermined costs for direct materials, direct labor, and overhead - what costs SHOULD be under efficient operations.\n\n---\n\n## The Standard Cost Card\n\nA summary of all standard costs for one unit:\n\n**Example: Hotel Room Night Standard Cost Card**\n\n| Component | Standard Qty/Hrs | Standard Rate | Standard Cost |\n|-----------|-----------------|---------------|---------------|\n| Amenities | 1 set | CHF 8.00 | CHF 8.00 |\n| Linens | 1 set | CHF 6.00 | CHF 6.00 |\n| Cleaning labor | 0.5 hrs | CHF 24/hr | CHF 12.00 |\n| Variable OH | 0.5 hrs | CHF 10/hr | CHF 5.00 |\n| **Total Standard Cost** | | | **CHF 31.00** |\n\n---\n\n## Types of Standards\n\n### Ideal Standards\n- Perfect efficiency, no waste\n- Rarely achievable\n- Can demotivate employees\n\n### Practical Standards\n- Attainable with reasonable effort\n- Allow for normal inefficiencies\n- Most commonly used\n\n---\n\n## Setting Standards\n\n| Input | How Standards Are Set |\n|-------|-----------------------|\n| Materials quantity | Engineering specs, historical data |\n| Materials price | Supplier quotes, purchasing contracts |\n| Labor hours | Time studies, industry benchmarks |\n| Labor rate | Wage agreements, job classifications |\n| Overhead rates | Budgeted OH / budgeted activity |\n\n---\n\n## Purpose of Standard Costing\n\n1. **Cost control** - Identify variances from plan\n2. **Pricing** - Base prices on efficient costs\n3. **Budgeting** - Build budgets from standards\n4. **Performance evaluation** - Measure efficiency\n5. **Inventory valuation** - Consistent unit costs\n\n---\n\n## Variance Analysis Overview\n\n$$\\text{Variance} = \\text{Actual Cost} - \\text{Standard Cost}$$\n\n- **Favorable (F)**: Actual < Standard (saved money)\n- **Unfavorable (U)**: Actual > Standard (spent more)\n\n---\n\n:::takeaways\n- Standard costs are predetermined target costs\n- Standard cost card shows all standards for one unit\n- Practical standards are most commonly used\n- Variances = Actual - Standard\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0001-000000000002',
  'd0000000-0000-0000-0000-000000000008',
  '8.1.2',
  2,
  'Standard Costing Concepts',
  'standard-costing-concepts',
  'quiz',
  8,
  30,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "basic",
        "question": "Standard costs represent:",
        "options": ["Actual costs incurred", "What costs should be", "Maximum allowable costs", "Minimum costs possible"],
        "correct": 1,
        "explanation": "Standards represent predetermined, expected costs under efficient conditions."
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "basic",
        "question": "A standard cost card shows standards for:",
        "options": ["All products", "One unit of product", "One department", "The whole company"],
        "correct": 1,
        "explanation": "The standard cost card details all cost components for one unit."
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Practical standards allow for:",
        "options": ["Zero defects", "Perfect efficiency", "Normal inefficiencies", "Unlimited waste"],
        "correct": 2,
        "explanation": "Practical standards are attainable with effort, allowing for normal inefficiency."
      },
      {
        "id": "q4",
        "type": "true_false",
        "difficulty": "basic",
        "question": "A favorable variance means actual costs exceeded standard costs.",
        "correct": false,
        "explanation": "False. Favorable means actual was LESS than standard (saved money)."
      },
      {
        "id": "q5",
        "type": "mcq",
        "difficulty": "applied",
        "question": "If standard cost is CHF 50 and actual is CHF 55, the variance is:",
        "options": ["CHF 5 F", "CHF 5 U", "CHF 50 U", "CHF 55 F"],
        "correct": 1,
        "explanation": "Actual > Standard = CHF 5 Unfavorable"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0001-000000000003',
  'd0000000-0000-0000-0000-000000000008',
  '8.1.3',
  3,
  'Standard Cost Card Builder',
  'standard-cost-card-builder',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Match each standard cost card component to its description.",
    "pairs": [
      {"left": "Standard Quantity", "right": "Amount of input per unit of output"},
      {"left": "Standard Price", "right": "Cost per unit of input"},
      {"left": "Standard Cost", "right": "Quantity x Price for the input"},
      {"left": "Total Standard Cost", "right": "Sum of all input standard costs"},
      {"left": "Variance", "right": "Actual cost minus standard cost"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

(
  'd0800000-0000-0000-0001-000000000004',
  'd0000000-0000-0000-0000-000000000008',
  '8.1.4',
  4,
  'Hotel Room Standard Costs',
  'hotel-room-standard-costs',
  'quiz',
  10,
  35,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Standard: 0.4 labor hrs @ CHF 28/hr. Standard labor cost per room:",
        "options": ["CHF 11.20", "CHF 28.00", "CHF 0.40", "CHF 70.00"],
        "correct": 0,
        "explanation": "Standard cost = 0.4 hrs x CHF 28 = CHF 11.20"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Standard materials CHF 8, labor CHF 11.20, OH CHF 5. Total standard cost per room:",
        "options": ["CHF 8.00", "CHF 24.20", "CHF 19.20", "CHF 11.20"],
        "correct": 1,
        "explanation": "Total = 8 + 11.20 + 5 = CHF 24.20"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "For 100 rooms, total standard cost should be:",
        "options": ["CHF 2,420", "CHF 242", "CHF 24.20", "CHF 8,000"],
        "correct": 0,
        "explanation": "100 rooms x CHF 24.20 = CHF 2,420"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Actual total cost was CHF 2,550. Total variance:",
        "options": ["CHF 130 F", "CHF 130 U", "CHF 2,420 F", "CHF 5,970 U"],
        "correct": 1,
        "explanation": "Variance = 2,550 - 2,420 = CHF 130 U (over budget)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0001-000000000005',
  'd0000000-0000-0000-0000-000000000008',
  '8.1.5',
  5,
  'Standard Costing Checkpoint',
  'standard-costing-checkpoint',
  'checkpoint',
  10,
  45,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Standard costs are used for all EXCEPT:",
        "options": ["Cost control", "Pricing decisions", "Recording actual transactions", "Budgeting"],
        "correct": 2,
        "explanation": "Standards are targets; actual transactions are recorded separately."
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Standard Qty: 2 kg, Standard Price: CHF 5/kg. Standard material cost:",
        "options": ["CHF 2", "CHF 5", "CHF 7", "CHF 10"],
        "correct": 3,
        "explanation": "Standard cost = 2 kg x CHF 5 = CHF 10"
      },
      {
        "id": "cp3",
        "type": "true_false",
        "question": "Ideal standards assume perfect efficiency with no waste.",
        "correct": true,
        "explanation": "True. Ideal standards represent theoretical perfection."
      },
      {
        "id": "cp4",
        "type": "mcq",
        "question": "Actual CHF 48, Standard CHF 50. This is a _____ variance.",
        "options": ["CHF 2 Unfavorable", "CHF 2 Favorable", "CHF 48 Favorable", "CHF 50 Unfavorable"],
        "correct": 1,
        "explanation": "Actual < Standard = CHF 2 Favorable (saved money)"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Direct Materials Variances (MA-29)
-- ============================================

(
  'd0800000-0000-0000-0002-000000000001',
  'd0000000-0000-0000-0000-000000000008',
  '8.2.1',
  6,
  'Materials Price and Quantity Variances',
  'materials-price-quantity-variances',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Materials Price and Quantity Variances\n\n## Two Types of Materials Variances\n\nThe total materials variance is split into:\n\n1. **Price Variance** - Did we pay more or less per unit?\n2. **Quantity Variance** - Did we use more or less material?\n\n---\n\n## Materials Price Variance (MPV)\n\n$$\\text{MPV} = (\\text{Actual Price} - \\text{Standard Price}) \\times \\text{Actual Quantity Purchased}$$\n\nOr: $$(AP - SP) \\times AQ$$\n\n---\n\n## Materials Quantity Variance (MQV)\n\n$$\\text{MQV} = (\\text{Actual Quantity Used} - \\text{Standard Quantity Allowed}) \\times \\text{Standard Price}$$\n\nOr: $$(AQ - SQ) \\times SP$$\n\n**Standard Quantity Allowed** = Standard qty per unit x Actual units produced\n\n---\n\n## The Three-Column Analysis\n\n```\n       Actual              Actual Qty            Standard Qty\n    AQ x AP           x Standard Price      x Standard Price\n       |                     |                      |\n       |---Price Variance----|---Quantity Variance--|\n       |_____________ Total Variance ______________|\n```\n\n---\n\n## Example: Restaurant Food Costs\n\n**Salmon Entree Standards:**\n- 0.25 kg per serving @ CHF 32/kg = CHF 8.00 per serving\n\n**Actual for 200 servings:**\n- Purchased 55 kg @ CHF 30/kg\n- Used 52 kg\n\n---\n\n## Calculate Variances\n\n### Standard Quantity Allowed:\n$$SQ = 0.25 \\text{ kg} \\times 200 = 50 \\text{ kg}$$\n\n### Materials Price Variance:\n$$MPV = (CHF 30 - CHF 32) \\times 55 = (CHF 2) \\times 55 = \\text{CHF 110 F}$$\n\nWe paid LESS per kg (favorable).\n\n### Materials Quantity Variance:\n$$MQV = (52 - 50) \\times CHF 32 = 2 \\times CHF 32 = \\text{CHF 64 U}$$\n\nWe used MORE kg than standard (unfavorable).\n\n---\n\n## Responsibility\n\n| Variance | Responsible Manager | Possible Causes |\n|----------|--------------------|-----------------|\n| Price | Purchasing | Supplier changes, volume discounts |\n| Quantity | Production | Waste, quality issues, training |\n\n---\n\n:::takeaways\n- MPV = (AP - SP) x AQ purchased\n- MQV = (AQ used - SQ allowed) x SP\n- Price variance isolates cost per unit\n- Quantity variance isolates usage efficiency\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0002-000000000002',
  'd0000000-0000-0000-0000-000000000008',
  '8.2.2',
  7,
  'Variance Calculator Interactive',
  'variance-calculator-interactive',
  'interactive',
  8,
  30,
  'basic',
  '{
    "instructions": "Put the materials variance calculation steps in order.",
    "sequence": [
      "Identify standard quantity per unit and standard price",
      "Calculate standard quantity allowed (Std qty x Actual production)",
      "Record actual quantity purchased and price paid",
      "Record actual quantity used in production",
      "Calculate Price Variance: (AP - SP) x AQ purchased",
      "Calculate Quantity Variance: (AQ used - SQ allowed) x SP",
      "Label variances as Favorable or Unfavorable"
    ]
  }'::jsonb,
  'sequence-order',
  false,
  true
),

(
  'd0800000-0000-0000-0002-000000000003',
  'd0000000-0000-0000-0000-000000000008',
  '8.2.3',
  8,
  'Materials Variance Questions',
  'materials-variance-questions',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "AP CHF 6, SP CHF 5, AQ purchased 1,000. Materials Price Variance:",
        "options": ["CHF 1,000 F", "CHF 1,000 U", "CHF 5,000 U", "CHF 6,000 F"],
        "correct": 1,
        "explanation": "MPV = (6-5) x 1,000 = CHF 1,000 U (paid more than standard)"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "AQ used 950, SQ allowed 900, SP CHF 5. Materials Quantity Variance:",
        "options": ["CHF 250 F", "CHF 250 U", "CHF 50 U", "CHF 50 F"],
        "correct": 1,
        "explanation": "MQV = (950-900) x 5 = CHF 250 U (used more than standard)"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Total materials variance from above (MPV + MQV):",
        "options": ["CHF 1,250 U", "CHF 750 U", "CHF 1,250 F", "CHF 750 F"],
        "correct": 0,
        "explanation": "Total = 1,000 U + 250 U = CHF 1,250 U"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Who is typically responsible for Materials Price Variance?",
        "options": ["Production manager", "Purchasing manager", "CEO", "Accountant"],
        "correct": 1,
        "explanation": "Purchasing negotiates prices and selects suppliers."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "A favorable price variance could lead to unfavorable quantity variance if lower quality materials cause waste.",
        "correct": true,
        "explanation": "True. Cheaper materials may require more usage due to waste or spoilage."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0002-000000000004',
  'd0000000-0000-0000-0000-000000000008',
  '8.2.4',
  9,
  'Restaurant Food Variances',
  'restaurant-food-variances',
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
        "question": "Standard: 0.5 kg @ CHF 20/kg per meal. 400 meals made. SQ allowed:",
        "options": ["200 kg", "400 kg", "800 kg", "0.5 kg"],
        "correct": 0,
        "explanation": "SQ = 0.5 x 400 = 200 kg"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Actual: 210 kg purchased @ CHF 19. MPV:",
        "options": ["CHF 210 F", "CHF 200 U", "CHF 210 U", "CHF 190 F"],
        "correct": 0,
        "explanation": "MPV = (19-20) x 210 = -1 x 210 = CHF 210 F"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "If 208 kg were used, MQV:",
        "options": ["CHF 160 F", "CHF 160 U", "CHF 8 U", "CHF 40 U"],
        "correct": 1,
        "explanation": "MQV = (208-200) x 20 = 8 x 20 = CHF 160 U"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Net materials variance:",
        "options": ["CHF 370 U", "CHF 50 U", "CHF 50 F", "CHF 370 F"],
        "correct": 1,
        "explanation": "Net = 210 F + 160 U = CHF 50 U"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0002-000000000005',
  'd0000000-0000-0000-0000-000000000008',
  '8.2.5',
  10,
  'Kitchen Ingredient Analysis',
  'kitchen-ingredient-analysis',
  'lesson',
  10,
  30,
  'basic',
  '{"markdown": "# Kitchen Ingredient Analysis\n\n## Multi-Material Variance Report\n\n**Mountain View Restaurant - January**\n\n| Ingredient | SQ Allowed | AQ Used | SP | MPV | MQV |\n|------------|-----------|---------|-----|-----|-----|\n| Beef | 100 kg | 108 kg | CHF 35 | (150) F | 280 U |\n| Vegetables | 80 kg | 75 kg | CHF 8 | 40 U | 40 F |\n| Seasonings | 10 kg | 11 kg | CHF 15 | 0 | 15 U |\n| **Totals** | | | | **110 F** | **255 U** |\n\n---\n\n## Interpretation\n\n### Beef:\n- **Price**: CHF 150 F - purchased at lower price\n- **Quantity**: CHF 280 U - used 8 kg more than standard (8% over)\n- Possible cause: Lower quality beef requiring trimming\n\n### Vegetables:\n- **Price**: CHF 40 U - paid more per kg\n- **Quantity**: CHF 40 F - used less than expected\n- Possible cause: Premium quality vegetables had less waste\n\n### Seasonings:\n- **Price**: On standard\n- **Quantity**: CHF 15 U - slight overuse\n- Possible cause: Recipe adjustments, training issue\n\n---\n\n## Net Result\n\nTotal Materials Variance = 110 F + 255 U = **CHF 145 U**\n\nKitchen is over budget on materials primarily due to beef usage.\n\n---\n\n## Action Items\n\n1. Investigate beef supplier quality\n2. Review portion control procedures\n3. Consider reverting to original beef supplier\n\n---\n\n:::takeaways\n- Analyze each major ingredient separately\n- Look for relationships between price and quantity\n- Cheaper inputs may cause higher usage\n- Use variance data for purchasing and training decisions\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0002-000000000006',
  'd0000000-0000-0000-0000-000000000008',
  '8.2.6',
  11,
  'Materials Variance Checkpoint',
  'materials-variance-checkpoint',
  'checkpoint',
  12,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Materials Price Variance formula: (AP - SP) x ___",
        "options": ["Standard Quantity", "Actual Quantity Purchased", "Production Volume", "Standard Price"],
        "correct": 1,
        "explanation": "MPV = (AP - SP) x Actual Quantity Purchased"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Materials Quantity Variance uses which price?",
        "options": ["Actual Price", "Standard Price", "Average Price", "Market Price"],
        "correct": 1,
        "explanation": "MQV = (AQ - SQ) x Standard Price"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "SP CHF 12, AP CHF 11, AQ purchased 500. Price variance:",
        "options": ["CHF 500 U", "CHF 500 F", "CHF 12 F", "CHF 11 U"],
        "correct": 1,
        "explanation": "MPV = (11-12) x 500 = -500 = CHF 500 F (paid less)"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Standard Quantity Allowed depends on actual production volume.",
        "correct": true,
        "explanation": "True. SQ allowed = Standard qty per unit x Actual units produced."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "An unfavorable quantity variance suggests:",
        "options": ["Materials were cheap", "More materials were used than standard", "Production was efficient", "Prices increased"],
        "correct": 1,
        "explanation": "Unfavorable MQV means actual usage exceeded standard."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Direct Labor Variances (MA-30)
-- ============================================

(
  'd0800000-0000-0000-0003-000000000001',
  'd0000000-0000-0000-0000-000000000008',
  '8.3.1',
  12,
  'Labor Rate and Efficiency Variances',
  'labor-rate-efficiency-variances',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Labor Rate and Efficiency Variances\n\n## Two Types of Labor Variances\n\n1. **Rate Variance** - Did we pay more or less per hour?\n2. **Efficiency Variance** - Did we work more or fewer hours?\n\n---\n\n## Labor Rate Variance (LRV)\n\n$$\\text{LRV} = (\\text{Actual Rate} - \\text{Standard Rate}) \\times \\text{Actual Hours}$$\n\nOr: $$(AR - SR) \\times AH$$\n\n---\n\n## Labor Efficiency Variance (LEV)\n\n$$\\text{LEV} = (\\text{Actual Hours} - \\text{Standard Hours Allowed}) \\times \\text{Standard Rate}$$\n\nOr: $$(AH - SH) \\times SR$$\n\n**Standard Hours Allowed** = Standard hours per unit x Actual units produced\n\n---\n\n## Example: Hotel Housekeeping\n\n**Standards:**\n- 0.5 hours per room @ CHF 24/hour = CHF 12 per room\n\n**Actual for 200 rooms:**\n- Actual hours worked: 110 hours\n- Actual wage rate: CHF 25/hour\n\n---\n\n## Calculate Variances\n\n### Standard Hours Allowed:\n$$SH = 0.5 \\text{ hrs} \\times 200 = 100 \\text{ hours}$$\n\n### Labor Rate Variance:\n$$LRV = (CHF 25 - CHF 24) \\times 110 = CHF 1 \\times 110 = \\text{CHF 110 U}$$\n\nWe paid MORE per hour (unfavorable).\n\n### Labor Efficiency Variance:\n$$LEV = (110 - 100) \\times CHF 24 = 10 \\times CHF 24 = \\text{CHF 240 U}$$\n\nWe worked MORE hours than standard (unfavorable).\n\n---\n\n## Total Labor Variance\n\n$$\\text{Total} = \\text{LRV} + \\text{LEV} = 110 U + 240 U = \\text{CHF 350 U}$$\n\n---\n\n## Causes of Variances\n\n| Variance | Possible Causes |\n|----------|----------------|\n| Rate U | Overtime, higher-skill workers used |\n| Rate F | Lower-skill workers, trainees |\n| Efficiency U | Untrained staff, complex tasks, equipment issues |\n| Efficiency F | Experienced staff, better methods |\n\n---\n\n## Interrelationship\n\n:::concept{title=\"Trade-offs\"}\nUsing skilled (expensive) workers may cause unfavorable rate but favorable efficiency.\n\nUsing trainees may cause favorable rate but unfavorable efficiency.\n:::\n\n---\n\n:::takeaways\n- LRV = (AR - SR) x AH\n- LEV = (AH - SH allowed) x SR\n- Rate variance measures wage rate differences\n- Efficiency variance measures time differences\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0003-000000000002',
  'd0000000-0000-0000-0000-000000000008',
  '8.3.2',
  13,
  'Labor Variance Calculator',
  'labor-variance-calculator',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Match each labor variance component.",
    "pairs": [
      {"left": "AR - SR", "right": "Rate difference per hour"},
      {"left": "AH - SH", "right": "Efficiency difference in hours"},
      {"left": "(AR - SR) x AH", "right": "Labor Rate Variance"},
      {"left": "(AH - SH) x SR", "right": "Labor Efficiency Variance"},
      {"left": "Standard Hours Allowed", "right": "Std hrs per unit x Actual production"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

(
  'd0800000-0000-0000-0003-000000000003',
  'd0000000-0000-0000-0000-000000000008',
  '8.3.3',
  14,
  'Labor Variance Questions',
  'labor-variance-questions',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "AR CHF 30, SR CHF 28, AH 500. Labor Rate Variance:",
        "options": ["CHF 1,000 F", "CHF 1,000 U", "CHF 500 U", "CHF 500 F"],
        "correct": 1,
        "explanation": "LRV = (30-28) x 500 = CHF 1,000 U (paid more)"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "AH 500, SH allowed 480, SR CHF 28. Labor Efficiency Variance:",
        "options": ["CHF 560 U", "CHF 560 F", "CHF 20 U", "CHF 20 F"],
        "correct": 0,
        "explanation": "LEV = (500-480) x 28 = CHF 560 U (worked more hours)"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Total labor variance from above:",
        "options": ["CHF 1,560 U", "CHF 440 U", "CHF 1,560 F", "CHF 440 F"],
        "correct": 0,
        "explanation": "Total = 1,000 U + 560 U = CHF 1,560 U"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Who is typically responsible for Labor Efficiency Variance?",
        "options": ["HR manager", "Production/Operations manager", "Payroll clerk", "CEO"],
        "correct": 1,
        "explanation": "Operations controls how efficiently labor is used."
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "Using overtime always results in unfavorable rate variance.",
        "correct": true,
        "explanation": "True. Overtime rates exceed standard hourly rates."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0003-000000000004',
  'd0000000-0000-0000-0000-000000000008',
  '8.3.4',
  15,
  'Housekeeping Labor Analysis',
  'housekeeping-labor-analysis',
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
        "question": "Standard: 0.4 hrs @ CHF 22/hr per room. 500 rooms cleaned. Standard hours allowed:",
        "options": ["200 hrs", "500 hrs", "220 hrs", "125 hrs"],
        "correct": 0,
        "explanation": "SH = 0.4 x 500 = 200 hours"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Actual: 210 hours @ CHF 23/hr. LRV:",
        "options": ["CHF 200 U", "CHF 210 U", "CHF 220 U", "CHF 230 U"],
        "correct": 1,
        "explanation": "LRV = (23-22) x 210 = CHF 210 U"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "LEV for the same data:",
        "options": ["CHF 220 U", "CHF 210 U", "CHF 200 U", "CHF 230 U"],
        "correct": 0,
        "explanation": "LEV = (210-200) x 22 = CHF 220 U"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Total labor variance:",
        "options": ["CHF 430 U", "CHF 430 F", "CHF 10 U", "CHF 10 F"],
        "correct": 0,
        "explanation": "Total = 210 U + 220 U = CHF 430 U"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0003-000000000005',
  'd0000000-0000-0000-0000-000000000008',
  '8.3.5',
  16,
  'Kitchen Staff Efficiency',
  'kitchen-staff-efficiency',
  'lesson',
  10,
  30,
  'basic',
  '{"markdown": "# Kitchen Staff Efficiency Analysis\n\n## Alpine Restaurant Labor Report\n\n**Standard: 0.25 hours per meal @ CHF 32/hour**\n\n| Week | Meals | SH Allowed | AH Worked | AR | LRV | LEV |\n|------|-------|------------|-----------|-----|-----|-----|\n| 1 | 800 | 200 | 195 | CHF 33 | 195 U | 160 F |\n| 2 | 750 | 187.5 | 200 | CHF 30 | 400 F | 400 U |\n| 3 | 900 | 225 | 220 | CHF 32 | 0 | 160 F |\n| 4 | 850 | 212.5 | 230 | CHF 34 | 460 U | 560 U |\n\n---\n\n## Analysis by Week\n\n### Week 1:\n- Paid slightly more (overtime?)\n- But efficient - finished early\n- Net: CHF 35 F (efficiency offset rate)\n\n### Week 2:\n- Paid less (trainees?)\n- But slow - took extra time\n- Net: Even (trade-off)\n\n### Week 3:\n- On standard rate\n- Efficient operations\n- Net: CHF 160 F\n\n### Week 4:\n- Paid more AND slow\n- Worst week\n- Investigate: Staff issues? Equipment?\n\n---\n\n## Monthly Summary\n\n| | Amount |\n|-|--------|\n| Total LRV | CHF 255 U |\n| Total LEV | CHF 160 U |\n| **Net** | **CHF 415 U** |\n\n---\n\n## Recommendations\n\n1. Week 4 needs immediate attention\n2. Week 1 strategy (experienced staff) works\n3. Week 2 trainee approach needs balance\n4. Maintain Week 3 practices\n\n---\n\n:::takeaways\n- Track variances weekly for faster response\n- Look for patterns and trade-offs\n- Rate and efficiency variances often interrelate\n- Investigate significant unfavorable weeks\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0003-000000000006',
  'd0000000-0000-0000-0000-000000000008',
  '8.3.6',
  17,
  'Labor Variance Checkpoint',
  'labor-variance-checkpoint',
  'checkpoint',
  12,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "Labor Rate Variance formula: (AR - SR) x ___",
        "options": ["Standard Hours", "Actual Hours", "Production Units", "Standard Rate"],
        "correct": 1,
        "explanation": "LRV = (AR - SR) x Actual Hours worked"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "Labor Efficiency Variance uses which rate?",
        "options": ["Actual Rate", "Standard Rate", "Overtime Rate", "Average Rate"],
        "correct": 1,
        "explanation": "LEV = (AH - SH) x Standard Rate"
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "SR CHF 25, AR CHF 24, AH 400. Rate variance:",
        "options": ["CHF 400 U", "CHF 400 F", "CHF 25 F", "CHF 24 U"],
        "correct": 1,
        "explanation": "LRV = (24-25) x 400 = -400 = CHF 400 F (paid less)"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "Standard Hours Allowed is based on actual production, not budgeted production.",
        "correct": true,
        "explanation": "True. SH allowed = Standard per unit x ACTUAL units produced."
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "An unfavorable efficiency variance indicates:",
        "options": ["Workers were overpaid", "More hours worked than standard", "Fewer hours worked than standard", "Materials were wasted"],
        "correct": 1,
        "explanation": "Unfavorable LEV means actual hours exceeded standard allowed."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  true,
  true
),

-- ============================================
-- SKILL: Overhead Variances (MA-31)
-- ============================================

(
  'd0800000-0000-0000-0004-000000000001',
  'd0000000-0000-0000-0000-000000000008',
  '8.4.1',
  18,
  'Overhead Variances Explained',
  'overhead-variances-explained',
  'lesson',
  15,
  35,
  'basic',
  '{"markdown": "# Overhead Variances Explained\n\n## Variable Overhead Variances\n\n### Spending Variance\n$$\\text{VOH Spending} = \\text{Actual VOH} - (\\text{AH} \\times \\text{Standard VOH Rate})$$\n\nDid we spend more or less on VOH per hour?\n\n### Efficiency Variance\n$$\\text{VOH Efficiency} = (\\text{AH} - \\text{SH}) \\times \\text{Standard VOH Rate}$$\n\nDid we use more or fewer hours (driving more/less VOH)?\n\n---\n\n## Fixed Overhead Variances\n\n### Budget Variance\n$$\\text{FOH Budget} = \\text{Actual FOH} - \\text{Budgeted FOH}$$\n\nDid we spend more or less on FOH than budgeted?\n\n### Volume Variance\n$$\\text{FOH Volume} = \\text{Budgeted FOH} - (\\text{SH Allowed} \\times \\text{Standard FOH Rate})$$\n\nDid we produce more or less than expected (affecting applied FOH)?\n\n---\n\n## Example: Hotel Housekeeping Overhead\n\n**Standards:**\n- Variable OH: CHF 8 per labor hour\n- Fixed OH: CHF 10,000/month (based on 500 hours capacity)\n- Standard FOH rate: CHF 20/hour\n\n**Actual (400 rooms, 0.5 SH/room = 200 SH allowed):**\n- Actual hours: 210\n- Actual VOH: CHF 1,750\n- Actual FOH: CHF 10,200\n\n---\n\n## Variable OH Variances\n\n### Spending:\n$$\\text{Spending} = 1,750 - (210 \\times 8) = 1,750 - 1,680 = \\text{CHF 70 U}$$\n\n### Efficiency:\n$$\\text{Efficiency} = (210 - 200) \\times 8 = 10 \\times 8 = \\text{CHF 80 U}$$\n\n---\n\n## Fixed OH Variances\n\n### Budget:\n$$\\text{Budget} = 10,200 - 10,000 = \\text{CHF 200 U}$$\n\n### Volume:\n$$\\text{Volume} = 10,000 - (200 \\times 20) = 10,000 - 4,000 = \\text{CHF 6,000 U}$$\n\nVolume variance is unfavorable because we produced less than capacity.\n\n---\n\n## Summary of All Variances\n\n| Variance | Amount |\n|----------|--------|\n| VOH Spending | CHF 70 U |\n| VOH Efficiency | CHF 80 U |\n| FOH Budget | CHF 200 U |\n| FOH Volume | CHF 6,000 U |\n| **Total OH Variance** | **CHF 6,350 U** |\n\n---\n\n:::takeaways\n- VOH has spending and efficiency variances\n- FOH has budget and volume variances\n- Volume variance reflects capacity utilization\n- Low production = unfavorable volume variance\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0004-000000000002',
  'd0000000-0000-0000-0000-000000000008',
  '8.4.2',
  19,
  'Overhead Variance Framework',
  'overhead-variance-framework',
  'interactive',
  6,
  25,
  'basic',
  '{
    "instructions": "Match each overhead variance to its focus.",
    "pairs": [
      {"left": "VOH Spending Variance", "right": "Cost per hour of variable overhead"},
      {"left": "VOH Efficiency Variance", "right": "Hours worked vs hours allowed"},
      {"left": "FOH Budget Variance", "right": "Actual vs budgeted fixed overhead"},
      {"left": "FOH Volume Variance", "right": "Capacity utilization vs plan"}
    ]
  }'::jsonb,
  'drag-drop-match',
  false,
  true
),

(
  'd0800000-0000-0000-0004-000000000003',
  'd0000000-0000-0000-0000-000000000008',
  '8.4.3',
  20,
  'Overhead Variance Questions',
  'overhead-variance-questions',
  'quiz',
  12,
  40,
  'basic',
  '{
    "questions": [
      {
        "id": "q1",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Actual VOH CHF 5,000, AH 400, Standard VOH rate CHF 12. VOH Spending:",
        "options": ["CHF 200 F", "CHF 200 U", "CHF 800 U", "CHF 800 F"],
        "correct": 1,
        "explanation": "Spending = 5,000 - (400 x 12) = 5,000 - 4,800 = CHF 200 U"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "applied",
        "question": "AH 400, SH 380, Standard VOH rate CHF 12. VOH Efficiency:",
        "options": ["CHF 240 U", "CHF 240 F", "CHF 20 U", "CHF 20 F"],
        "correct": 0,
        "explanation": "Efficiency = (400-380) x 12 = CHF 240 U"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "applied",
        "question": "Actual FOH CHF 25,000, Budgeted FOH CHF 24,000. FOH Budget:",
        "options": ["CHF 1,000 F", "CHF 1,000 U", "CHF 25,000 U", "CHF 24,000 F"],
        "correct": 1,
        "explanation": "Budget = 25,000 - 24,000 = CHF 1,000 U (spent more)"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Budgeted FOH CHF 24,000, SH allowed 800, Standard FOH rate CHF 30. Volume variance:",
        "options": ["CHF 0", "CHF 24,000 U", "CHF 800 F", "CHF 6,000 F"],
        "correct": 0,
        "explanation": "Applied = 800 x 30 = 24,000. Volume = 24,000 - 24,000 = CHF 0"
      },
      {
        "id": "q5",
        "type": "true_false",
        "difficulty": "applied",
        "question": "The FOH volume variance is unfavorable when production is below capacity.",
        "correct": true,
        "explanation": "True. Under-production means less FOH is applied, creating unfavorable volume variance."
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0004-000000000004',
  'd0000000-0000-0000-0000-000000000008',
  '8.4.4',
  21,
  'Hotel Overhead Analysis',
  'hotel-overhead-analysis',
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
        "question": "VOH rate CHF 6/hr. Actual VOH CHF 3,200, AH 500, SH allowed 480. VOH Spending:",
        "options": ["CHF 200 F", "CHF 200 U", "CHF 120 U", "CHF 120 F"],
        "correct": 1,
        "explanation": "Spending = 3,200 - (500 x 6) = 3,200 - 3,000 = CHF 200 U"
      },
      {
        "id": "q2",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Using same data, VOH Efficiency:",
        "options": ["CHF 120 U", "CHF 120 F", "CHF 200 U", "CHF 200 F"],
        "correct": 0,
        "explanation": "Efficiency = (500-480) x 6 = CHF 120 U"
      },
      {
        "id": "q3",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Budgeted FOH CHF 8,000 (budgeted 600 hrs). FOH rate:",
        "options": ["CHF 8.00", "CHF 13.33", "CHF 0.075", "CHF 600"],
        "correct": 1,
        "explanation": "FOH rate = 8,000 / 600 = CHF 13.33/hr"
      },
      {
        "id": "q4",
        "type": "mcq",
        "difficulty": "exam",
        "question": "Actual FOH CHF 8,100, SH allowed 480. Volume variance:",
        "options": ["CHF 1,600 U", "CHF 1,600 F", "CHF 100 U", "CHF 1,700 U"],
        "correct": 0,
        "explanation": "Applied = 480 x 13.33 = 6,400. Volume = 8,000 - 6,400 = CHF 1,600 U"
      }
    ],
    "passing_score": 70
  }'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0004-000000000005',
  'd0000000-0000-0000-0000-000000000008',
  '8.4.5',
  22,
  'Full Variance Report',
  'full-variance-report',
  'lesson',
  12,
  35,
  'basic',
  '{"markdown": "# Full Variance Report\n\n## Mountain View Hotel - Monthly Variance Analysis\n\n### Standard Cost Per Room Night\n\n| Component | Standard |\n|-----------|----------|\n| Materials (amenities) | CHF 8.00 |\n| Labor (0.4 hrs @ CHF 25) | CHF 10.00 |\n| Variable OH (0.4 hrs @ CHF 6) | CHF 2.40 |\n| Fixed OH (0.4 hrs @ CHF 15) | CHF 6.00 |\n| **Total** | **CHF 26.40** |\n\n---\n\n## Actual Results: 1,000 Room Nights\n\n| | Standard | Actual | Variance |\n|-|----------|--------|----------|\n| Materials | CHF 8,000 | CHF 8,300 | CHF 300 U |\n| Labor | CHF 10,000 | CHF 10,800 | CHF 800 U |\n| Variable OH | CHF 2,400 | CHF 2,600 | CHF 200 U |\n| Fixed OH | CHF 6,000 | CHF 6,200 | CHF 200 U |\n| **Total** | **CHF 26,400** | **CHF 27,900** | **CHF 1,500 U** |\n\n---\n\n## Detailed Variance Breakdown\n\n### Materials (CHF 300 U)\n- Price Variance: CHF 100 U\n- Quantity Variance: CHF 200 U\n\n### Labor (CHF 800 U)\n- Rate Variance: CHF 300 U\n- Efficiency Variance: CHF 500 U\n\n### Variable OH (CHF 200 U)\n- Spending: CHF 80 U\n- Efficiency: CHF 120 U\n\n### Fixed OH (CHF 200 U)\n- Budget: CHF 200 U\n- Volume: CHF 0 (at expected volume)\n\n---\n\n## Management Summary\n\n| Area | Assessment | Action |\n|------|-----------|--------|\n| Materials | Slight price increase + waste | Monitor supplier, review usage |\n| Labor | Overtime + inefficiency | Schedule review, training |\n| VOH | Follows labor pattern | Address labor issues first |\n| FOH | Minor overspend | Review expenses |\n\n---\n\n## Key Performance Indicators\n\n| Metric | Target | Actual |\n|--------|--------|--------|\n| Cost per room | CHF 26.40 | CHF 27.90 |\n| Labor hours per room | 0.40 | 0.44 |\n| Materials per room | CHF 8.00 | CHF 8.30 |\n\n---\n\n:::takeaways\n- Combine all variances for complete picture\n- Labor efficiency is biggest concern here\n- Variances guide management attention\n- Regular reporting enables corrective action\n:::"}'::jsonb,
  NULL,
  false,
  true
),

(
  'd0800000-0000-0000-0004-000000000006',
  'd0000000-0000-0000-0000-000000000008',
  '8.4.6',
  23,
  'Overhead Variances Checkpoint',
  'overhead-variances-checkpoint',
  'checkpoint',
  12,
  50,
  'basic',
  '{
    "questions": [
      {
        "id": "cp1",
        "type": "mcq",
        "question": "VOH Spending Variance = Actual VOH - (AH x ___)",
        "options": ["Actual VOH rate", "Standard VOH rate", "FOH rate", "Total OH rate"],
        "correct": 1,
        "explanation": "Spending = Actual VOH - (Actual Hours x Standard VOH rate)"
      },
      {
        "id": "cp2",
        "type": "mcq",
        "question": "FOH Volume Variance is caused by:",
        "options": ["Price increases", "Wage rate changes", "Production volume differences from plan", "Material waste"],
        "correct": 2,
        "explanation": "Volume variance reflects actual production vs planned capacity."
      },
      {
        "id": "cp3",
        "type": "mcq",
        "question": "Budgeted FOH CHF 15,000, Actual FOH CHF 14,500. Budget variance:",
        "options": ["CHF 500 U", "CHF 500 F", "CHF 15,000 F", "CHF 14,500 U"],
        "correct": 1,
        "explanation": "Budget = 14,500 - 15,000 = -500 = CHF 500 F (spent less)"
      },
      {
        "id": "cp4",
        "type": "true_false",
        "question": "VOH Efficiency Variance uses the same formula concept as Labor Efficiency Variance.",
        "correct": true,
        "explanation": "True. Both = (AH - SH) x Standard Rate"
      },
      {
        "id": "cp5",
        "type": "mcq",
        "question": "If actual production exceeds planned capacity, FOH Volume Variance is:",
        "options": ["Unfavorable", "Favorable", "Zero", "Not calculable"],
        "correct": 1,
        "explanation": "Over-production means more FOH applied, resulting in favorable volume variance."
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
-- Skill MA-28: Standard Costing Basics
('d0800000-0000-0000-0001-000000000001', 'd0000000-0000-0000-0008-000000000001', true, 1.0),
('d0800000-0000-0000-0001-000000000002', 'd0000000-0000-0000-0008-000000000001', true, 1.0),
('d0800000-0000-0000-0001-000000000003', 'd0000000-0000-0000-0008-000000000001', true, 1.0),
('d0800000-0000-0000-0001-000000000004', 'd0000000-0000-0000-0008-000000000001', true, 1.0),
('d0800000-0000-0000-0001-000000000005', 'd0000000-0000-0000-0008-000000000001', true, 1.0),

-- Skill MA-29: Direct Materials Variances
('d0800000-0000-0000-0002-000000000001', 'd0000000-0000-0000-0008-000000000002', true, 1.0),
('d0800000-0000-0000-0002-000000000002', 'd0000000-0000-0000-0008-000000000002', true, 1.0),
('d0800000-0000-0000-0002-000000000003', 'd0000000-0000-0000-0008-000000000002', true, 1.0),
('d0800000-0000-0000-0002-000000000004', 'd0000000-0000-0000-0008-000000000002', true, 1.0),
('d0800000-0000-0000-0002-000000000005', 'd0000000-0000-0000-0008-000000000002', true, 1.0),
('d0800000-0000-0000-0002-000000000006', 'd0000000-0000-0000-0008-000000000002', true, 1.0),

-- Skill MA-30: Direct Labor Variances
('d0800000-0000-0000-0003-000000000001', 'd0000000-0000-0000-0008-000000000003', true, 1.0),
('d0800000-0000-0000-0003-000000000002', 'd0000000-0000-0000-0008-000000000003', true, 1.0),
('d0800000-0000-0000-0003-000000000003', 'd0000000-0000-0000-0008-000000000003', true, 1.0),
('d0800000-0000-0000-0003-000000000004', 'd0000000-0000-0000-0008-000000000003', true, 1.0),
('d0800000-0000-0000-0003-000000000005', 'd0000000-0000-0000-0008-000000000003', true, 1.0),
('d0800000-0000-0000-0003-000000000006', 'd0000000-0000-0000-0008-000000000003', true, 1.0),

-- Skill MA-31: Overhead Variances
('d0800000-0000-0000-0004-000000000001', 'd0000000-0000-0000-0008-000000000004', true, 1.0),
('d0800000-0000-0000-0004-000000000002', 'd0000000-0000-0000-0008-000000000004', true, 1.0),
('d0800000-0000-0000-0004-000000000003', 'd0000000-0000-0000-0008-000000000004', true, 1.0),
('d0800000-0000-0000-0004-000000000004', 'd0000000-0000-0000-0008-000000000004', true, 1.0),
('d0800000-0000-0000-0004-000000000005', 'd0000000-0000-0000-0008-000000000004', true, 1.0),
('d0800000-0000-0000-0004-000000000006', 'd0000000-0000-0000-0008-000000000004', true, 1.0);

