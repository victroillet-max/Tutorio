-- ============================================
-- Activities for Module 3: Algorithms, Flowcharts & Pseudocode
-- ============================================

INSERT INTO activities (id, module_id, external_id, order_index, title, slug, type, minutes, xp, required_plan, content, interactive_type, blocks_progress, is_published) VALUES
  (
    'e0000000-0000-0000-0003-000000000001',
    'd0000000-0000-0000-0000-000000000003',
    '3.1',
    1,
    'What is an Algorithm?',
    'what-is-an-algorithm',
    'lesson',
    8,
    15,
    'basic',
    '{"markdown": "# What is an Algorithm?\n\nAn algorithm is a step-by-step procedure for solving a problem or accomplishing a task.\n\n## Key Characteristics\n\n1. **Finite** - Must have a clear ending\n2. **Well-defined** - Each step must be precise\n3. **Effective** - Must produce the correct result\n4. **Input/Output** - Takes inputs and produces outputs\n\n## Examples in Daily Life\n\n- A recipe for baking a cake\n- Directions to get somewhere\n- Instructions for assembling furniture\n- Morning routine steps\n\n## Why Algorithms Matter\n\nAlgorithms are the foundation of all computer programs. Before writing code, programmers design algorithms to ensure their solution is correct and efficient."}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0003-000000000002',
    'd0000000-0000-0000-0000-000000000003',
    '3.2',
    2,
    'Introduction to Flowcharts',
    'introduction-to-flowcharts',
    'lesson',
    10,
    20,
    'basic',
    '{"markdown": "# Introduction to Flowcharts\n\nA flowchart is a visual representation of an algorithm using standardized symbols.\n\n## Common Flowchart Symbols\n\n| Symbol | Name | Purpose |\n|--------|------|--------|\n| Oval | Terminal | Start/End of process |\n| Rectangle | Process | Action or operation |\n| Diamond | Decision | Yes/No question |\n| Parallelogram | Input/Output | Data entry or display |\n| Arrow | Flow Line | Direction of flow |\n\n## Benefits of Flowcharts\n\n- **Visual clarity** - Easy to understand at a glance\n- **Communication** - Share ideas with non-programmers\n- **Debugging** - Spot logic errors before coding\n- **Documentation** - Record how a system works\n\n## Example: Making Tea\n\n1. Start\n2. Boil water\n3. Put tea bag in cup\n4. Pour hot water\n5. Wait 3 minutes\n6. Remove tea bag\n7. Add milk? (Decision)\n8. If yes: Add milk\n9. End"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0003-000000000003',
    'd0000000-0000-0000-0000-000000000003',
    '3.3',
    3,
    'Flowchart Quiz',
    'flowchart-quiz',
    'quiz',
    5,
    15,
    'basic',
    '{
      "questions": [
        {
          "id": "q1",
          "type": "mcq",
          "question": "Which flowchart symbol represents a decision point?",
          "options": [
            "Rectangle",
            "Oval",
            "Diamond",
            "Parallelogram"
          ],
          "correct": 2,
          "explanation": "A diamond shape is used to represent decision points in flowcharts, where the flow can go in different directions based on a yes/no condition."
        },
        {
          "id": "q2",
          "type": "mcq",
          "question": "What does an oval symbol represent in a flowchart?",
          "options": [
            "A process or action",
            "Start or End of the algorithm",
            "A decision point",
            "Input or Output"
          ],
          "correct": 1,
          "explanation": "Oval (or rounded rectangle) symbols are used to mark the beginning and end of a flowchart."
        },
        {
          "id": "q3",
          "type": "true_false",
          "question": "Flowcharts can only be used by programmers.",
          "correct": false,
          "explanation": "Flowcharts are a universal visual tool that can be used by anyone to represent processes, not just programmers."
        }
      ],
      "passing_score": 70
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0003-000000000004',
    'd0000000-0000-0000-0000-000000000003',
    '3.4',
    4,
    'Introduction to Pseudocode',
    'introduction-to-pseudocode',
    'lesson',
    10,
    20,
    'basic',
    '{"markdown": "# Introduction to Pseudocode\n\nPseudocode is a way of writing algorithms using plain language that resembles programming code.\n\n## Why Use Pseudocode?\n\n- **Language-independent** - Not tied to any programming language\n- **Focus on logic** - Worry about the algorithm, not syntax\n- **Easy to understand** - Anyone can read it\n- **Quick to write** - Faster than actual code\n\n## Pseudocode Conventions\n\n```\nBEGIN\n  DECLARE variables\n  INPUT data from user\n  PROCESS the data\n  OUTPUT the results\nEND\n```\n\n## Common Keywords\n\n- **BEGIN/END** - Start and end of algorithm\n- **IF/THEN/ELSE** - Conditional statements\n- **WHILE/FOR** - Loops\n- **INPUT/OUTPUT** - Read and display data\n- **SET/DECLARE** - Create variables\n\n## Example: Calculate Average\n\n```\nBEGIN\n  SET sum = 0\n  SET count = 0\n  INPUT number\n  WHILE number != -1\n    SET sum = sum + number\n    SET count = count + 1\n    INPUT number\n  END WHILE\n  SET average = sum / count\n  OUTPUT average\nEND\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0003-000000000005',
    'd0000000-0000-0000-0000-000000000003',
    '3.5',
    5,
    'Pseudocode Practice',
    'pseudocode-practice',
    'quiz',
    8,
    20,
    'basic',
    '{
      "questions": [
        {
          "id": "q1",
          "type": "mcq",
          "question": "What is the main advantage of pseudocode over actual programming code?",
          "options": [
            "It runs faster on computers",
            "It is language-independent and focuses on logic",
            "It uses less memory",
            "It has better error handling"
          ],
          "correct": 1,
          "explanation": "Pseudocode is not tied to any specific programming language, allowing you to focus on the algorithm logic without worrying about syntax."
        },
        {
          "id": "q2",
          "type": "mcq",
          "question": "Which keyword pair typically marks the start and end of a pseudocode algorithm?",
          "options": [
            "START / STOP",
            "BEGIN / END",
            "OPEN / CLOSE",
            "INIT / FINISH"
          ],
          "correct": 1,
          "explanation": "BEGIN and END are the most common keywords used to mark the boundaries of a pseudocode algorithm."
        },
        {
          "id": "q3",
          "type": "true_false",
          "question": "Pseudocode must follow strict syntax rules like programming languages.",
          "correct": false,
          "explanation": "Pseudocode is flexible and does not have strict syntax rules. The goal is clarity of logic, not syntactic correctness."
        },
        {
          "id": "q4",
          "type": "mcq",
          "question": "What does IF/THEN/ELSE represent in pseudocode?",
          "options": [
            "A loop structure",
            "Variable declaration",
            "Conditional statement",
            "Input/Output operation"
          ],
          "correct": 2,
          "explanation": "IF/THEN/ELSE is used for conditional statements, allowing the algorithm to make decisions based on conditions."
        }
      ],
      "passing_score": 70
    }'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0003-000000000006',
    'd0000000-0000-0000-0000-000000000003',
    '3.6',
    6,
    'Algorithm Design Patterns',
    'algorithm-design-patterns',
    'lesson',
    12,
    25,
    'basic',
    '{"markdown": "# Algorithm Design Patterns\n\nCertain patterns appear repeatedly in algorithm design. Learning these patterns helps you solve new problems faster.\n\n## 1. Sequence Pattern\n\nSteps executed one after another in order.\n\n```\nStep 1\nStep 2\nStep 3\n```\n\n## 2. Selection Pattern\n\nChoosing between different paths based on a condition.\n\n```\nIF condition THEN\n  Do this\nELSE\n  Do that\nEND IF\n```\n\n## 3. Iteration Pattern\n\nRepeating steps until a condition is met.\n\n```\nWHILE condition\n  Repeat these steps\nEND WHILE\n```\n\n## 4. Accumulator Pattern\n\nBuilding up a result over multiple iterations.\n\n```\nSET total = 0\nFOR each item\n  SET total = total + item\nEND FOR\n```\n\n## 5. Search Pattern\n\nLooking for a specific item in a collection.\n\n```\nFOR each item\n  IF item matches target THEN\n    RETURN found\n  END IF\nEND FOR\nRETURN not found\n```"}'::jsonb,
    NULL,
    false,
    true
  ),
  (
    'e0000000-0000-0000-0003-000000000007',
    'd0000000-0000-0000-0000-000000000003',
    '3.7',
    7,
    'Module 3 Checkpoint',
    'module-3-checkpoint',
    'checkpoint',
    12,
    30,
    'basic',
    '{
      "questions": [
        {
          "id": "cp1",
          "type": "mcq",
          "question": "What is an algorithm?",
          "options": [
            "A type of computer",
            "A step-by-step procedure for solving a problem",
            "A programming language",
            "A type of flowchart"
          ],
          "correct": 1
        },
        {
          "id": "cp2",
          "type": "mcq",
          "question": "Which symbol is used for decision points in flowcharts?",
          "options": [
            "Rectangle",
            "Oval",
            "Diamond",
            "Arrow"
          ],
          "correct": 2
        },
        {
          "id": "cp3",
          "type": "mcq",
          "question": "What is the main purpose of pseudocode?",
          "options": [
            "To run programs faster",
            "To describe algorithms in plain language",
            "To create graphics",
            "To store data"
          ],
          "correct": 1
        },
        {
          "id": "cp4",
          "type": "true_false",
          "question": "A rectangle in a flowchart represents a process or action.",
          "correct": true
        },
        {
          "id": "cp5",
          "type": "mcq",
          "question": "Which pattern involves repeating steps until a condition is met?",
          "options": [
            "Sequence",
            "Selection",
            "Iteration",
            "Accumulator"
          ],
          "correct": 2
        }
      ],
      "passing_score": 70
    }'::jsonb,
    NULL,
    true,
    true
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content;

