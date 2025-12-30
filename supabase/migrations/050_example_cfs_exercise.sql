-- Example: Cash Flow Statement Builder Exercise
-- This demonstrates how to set up a Google Sheets exercise for the FA course

-- First, create an activity with interactive_type = 'google-sheets'
-- The content JSON should include the template_sheet_id

/*
Example activity content JSON:
{
  "template_sheet_id": "YOUR_GOOGLE_SHEET_TEMPLATE_ID_HERE",
  "exercise_title": "Wayne Enterprises Cash Flow Statement",
  "instructions": "Using the comparative balance sheets and income statement provided, prepare a complete Statement of Cash Flows for Wayne Enterprises using the indirect method. Your answers will be automatically checked when you click 'Check Answers'.",
  "hints": [
    "Start with Net Income from the Income Statement",
    "Add back non-cash expenses like Depreciation",
    "Analyze changes in current assets and liabilities",
    "Net change in cash should match the balance sheet change"
  ],
  "sheet_tab": "Student Work"
}
*/

-- Example: Insert grading criteria for a Cash Flow Statement exercise
-- Replace 'ACTIVITY_UUID' with the actual activity ID

-- Note: This is commented out as it's just an example template
/*
INSERT INTO sheet_grading_criteria (activity_id, cell_reference, cell_name, expected_value, expected_type, tolerance, is_required, points, sort_order, hint_on_error)
VALUES 
-- Operating Activities Section
('ACTIVITY_UUID', 'Sheet1!D8', 'Net Income', '125000', 'number', 0.01, true, 5, 1, 'Net Income should come from the Income Statement'),
('ACTIVITY_UUID', 'Sheet1!D9', 'Depreciation Expense', '45000', 'number', 0.01, true, 3, 2, 'Depreciation is a non-cash expense - add it back'),
('ACTIVITY_UUID', 'Sheet1!D12', 'Change in Accounts Receivable', '-15000', 'number', 0.01, true, 3, 3, 'An increase in A/R uses cash (subtract)'),
('ACTIVITY_UUID', 'Sheet1!D13', 'Change in Inventory', '8000', 'number', 0.01, true, 3, 4, 'A decrease in Inventory provides cash (add)'),
('ACTIVITY_UUID', 'Sheet1!D14', 'Change in Accounts Payable', '12000', 'number', 0.01, true, 3, 5, 'An increase in A/P provides cash (add)'),
('ACTIVITY_UUID', 'Sheet1!D18', 'Cash from Operating Activities', '175000', 'number', 0.01, true, 10, 6, 'Sum all operating adjustments with Net Income'),

-- Investing Activities Section
('ACTIVITY_UUID', 'Sheet1!D22', 'Purchase of Equipment', '-80000', 'number', 0.01, true, 5, 7, 'Equipment purchases use cash (negative)'),
('ACTIVITY_UUID', 'Sheet1!D23', 'Sale of Investments', '25000', 'number', 0.01, true, 5, 8, 'Investment sales provide cash (positive)'),
('ACTIVITY_UUID', 'Sheet1!D25', 'Cash from Investing Activities', '-55000', 'number', 0.01, true, 8, 9, 'Sum all investing activities'),

-- Financing Activities Section
('ACTIVITY_UUID', 'Sheet1!D29', 'Proceeds from Long-term Debt', '50000', 'number', 0.01, true, 5, 10, 'New borrowing provides cash'),
('ACTIVITY_UUID', 'Sheet1!D30', 'Dividends Paid', '-30000', 'number', 0.01, true, 5, 11, 'Dividends use cash (negative)'),
('ACTIVITY_UUID', 'Sheet1!D32', 'Cash from Financing Activities', '20000', 'number', 0.01, true, 8, 12, 'Sum all financing activities'),

-- Summary Section
('ACTIVITY_UUID', 'Sheet1!D36', 'Net Change in Cash', '140000', 'number', 0.01, true, 10, 13, 'CFO + CFI + CFF must equal net change'),
('ACTIVITY_UUID', 'Sheet1!D37', 'Beginning Cash Balance', '85000', 'number', 0.01, true, 3, 14, 'Use opening balance from Balance Sheet'),
('ACTIVITY_UUID', 'Sheet1!D38', 'Ending Cash Balance', '225000', 'number', 0.01, true, 5, 15, 'Must match the closing Balance Sheet cash');

-- Total possible points: 78
-- Passing score: 60 points (approximately 77%)
*/

-- Function to set up a new Google Sheets exercise
CREATE OR REPLACE FUNCTION setup_sheets_exercise(
    p_activity_id UUID,
    p_template_sheet_id TEXT,
    p_exercise_title TEXT,
    p_instructions TEXT,
    p_grading_cells JSONB -- Array of {cell, name, expected, type, points, hint}
) RETURNS VOID AS $$
DECLARE
    v_cell JSONB;
    v_sort_order INTEGER := 1;
BEGIN
    -- Update the activity content
    UPDATE activities
    SET 
        content = jsonb_build_object(
            'template_sheet_id', p_template_sheet_id,
            'exercise_title', p_exercise_title,
            'instructions', p_instructions
        ),
        interactive_type = 'google-sheets'
    WHERE id = p_activity_id;
    
    -- Clear existing grading criteria
    DELETE FROM sheet_grading_criteria WHERE activity_id = p_activity_id;
    
    -- Insert new grading criteria
    FOR v_cell IN SELECT * FROM jsonb_array_elements(p_grading_cells)
    LOOP
        INSERT INTO sheet_grading_criteria (
            activity_id,
            cell_reference,
            cell_name,
            expected_value,
            expected_type,
            tolerance,
            is_required,
            points,
            sort_order,
            hint_on_error
        ) VALUES (
            p_activity_id,
            v_cell->>'cell',
            v_cell->>'name',
            v_cell->>'expected',
            COALESCE(v_cell->>'type', 'number'),
            COALESCE((v_cell->>'tolerance')::DECIMAL, 0.01),
            COALESCE((v_cell->>'required')::BOOLEAN, true),
            COALESCE((v_cell->>'points')::INTEGER, 1),
            v_sort_order,
            v_cell->>'hint'
        );
        v_sort_order := v_sort_order + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Example usage:
/*
SELECT setup_sheets_exercise(
    'your-activity-uuid'::UUID,
    'your-template-sheet-id',
    'Wayne Enterprises CFS Exercise',
    'Build a complete Statement of Cash Flows using the indirect method.',
    '[
        {"cell": "D18", "name": "Cash from Operations", "expected": "175000", "points": 10, "hint": "Sum of operating adjustments"},
        {"cell": "D25", "name": "Cash from Investing", "expected": "-55000", "points": 8},
        {"cell": "D32", "name": "Cash from Financing", "expected": "20000", "points": 8},
        {"cell": "D36", "name": "Net Change in Cash", "expected": "140000", "points": 10, "hint": "Must equal CFO + CFI + CFF"}
    ]'::JSONB
);
*/

COMMENT ON FUNCTION setup_sheets_exercise IS 'Helper function to configure a Google Sheets exercise with grading criteria';

