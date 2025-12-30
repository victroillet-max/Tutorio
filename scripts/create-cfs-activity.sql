-- Create a sample CFS exercise activity using the Google Sheets template
-- Run this after the FA course is set up, or modify the module_id to match your setup

-- First, let's check if there's an FA module we can attach this to
-- If not, we'll create a temporary test module

DO $$
DECLARE
    v_course_id UUID;
    v_module_id UUID;
    v_activity_id UUID;
BEGIN
    -- Try to find the Financial Analysis course
    SELECT id INTO v_course_id 
    FROM courses 
    WHERE slug = 'financial-analysis' OR title ILIKE '%financial%'
    LIMIT 1;
    
    -- If no FA course exists, use any available course for testing
    IF v_course_id IS NULL THEN
        SELECT id INTO v_course_id FROM courses WHERE is_published = true LIMIT 1;
    END IF;
    
    IF v_course_id IS NULL THEN
        RAISE NOTICE 'No course found. Please create a course first.';
        RETURN;
    END IF;
    
    -- Try to find an existing module in that course
    SELECT id INTO v_module_id 
    FROM modules 
    WHERE course_id = v_course_id
    ORDER BY order_index DESC
    LIMIT 1;
    
    IF v_module_id IS NULL THEN
        RAISE NOTICE 'No module found. Please create a module first.';
        RETURN;
    END IF;
    
    -- Check if activity already exists
    SELECT id INTO v_activity_id
    FROM activities
    WHERE external_id = 'FA-CFS-001';
    
    IF v_activity_id IS NOT NULL THEN
        RAISE NOTICE 'Activity FA-CFS-001 already exists with id: %', v_activity_id;
    ELSE
        -- Create the CFS activity
        INSERT INTO activities (
            module_id,
            external_id,
            order_index,
            title,
            slug,
            type,
            interactive_type,
            minutes,
            xp,
            required_plan,
            passing_score,
            blocks_progress,
            is_published,
            content
        ) VALUES (
            v_module_id,
            'FA-CFS-001',
            100,  -- High order index to appear at the end
            'Cash Flow Statement Builder: Wayne Enterprises',
            'cfs-builder-wayne-enterprises',
            'interactive',
            'google-sheets',
            30,
            75,
            'basic',
            70,
            false,
            true,
            jsonb_build_object(
                'template_sheet_id', '1zuXG-b-pt_kKQfVVhp_roJpJG-MnIbcC2qkgDvIQeiw',
                'exercise_title', 'Wayne Enterprises Cash Flow Statement',
                'instructions', 'Using the comparative balance sheets and income statement provided in the Financial Data tab, prepare a complete Statement of Cash Flows for Wayne Enterprises using the indirect method. Enter your answers in the yellow-highlighted cells. Click "Check Answers" when ready to verify your work.',
                'hints', ARRAY[
                    'Start with Net Income from the Income Statement',
                    'Depreciation is a non-cash expense - add it back',
                    'Increases in current assets use cash (subtract)',
                    'Increases in current liabilities provide cash (add)',
                    'Check that Net Change in Cash + Beginning Cash = Ending Cash'
                ]
            )
        )
        RETURNING id INTO v_activity_id;
        
        RAISE NOTICE 'Created activity with id: %', v_activity_id;
    END IF;
    
    -- Delete existing grading criteria for this activity (in case we're updating)
    DELETE FROM sheet_grading_criteria WHERE activity_id = v_activity_id;
    
    -- Insert grading criteria
    INSERT INTO sheet_grading_criteria (
        activity_id, cell_reference, cell_name, expected_value, expected_type, 
        tolerance, is_required, points, sort_order, hint_on_error
    ) VALUES
    -- Operating Activities
    (v_activity_id, 'Your Answer!D10', 'Net Income', '125000', 'number', 0.01, true, 5, 1, 
     'Net Income comes from the Income Statement'),
    
    (v_activity_id, 'Your Answer!D13', 'Depreciation Expense', '45000', 'number', 0.01, true, 5, 2, 
     'Depreciation is shown on the Income Statement - add it back as a non-cash expense'),
    
    (v_activity_id, 'Your Answer!D16', 'Change in Accounts Receivable', '-15000', 'number', 0.01, true, 5, 3, 
     'A/R increased by 15,000 - this uses cash, so subtract it'),
    
    (v_activity_id, 'Your Answer!D17', 'Change in Inventory', '8000', 'number', 0.01, true, 5, 4, 
     'Inventory decreased by 8,000 - this provides cash, so add it'),
    
    (v_activity_id, 'Your Answer!D18', 'Change in Prepaid Expenses', '-6000', 'number', 0.01, true, 5, 5, 
     'Prepaid expenses increased by 6,000 - this uses cash, so subtract it'),
    
    (v_activity_id, 'Your Answer!D19', 'Change in Accounts Payable', '12000', 'number', 0.01, true, 5, 6, 
     'A/P increased by 12,000 - this provides cash, so add it'),
    
    (v_activity_id, 'Your Answer!D20', 'Change in Accrued Expenses', '4000', 'number', 0.01, true, 5, 7, 
     'Accrued expenses increased by 4,000 - this provides cash, so add it'),
    
    (v_activity_id, 'Your Answer!D22', 'Cash from Operating Activities', '173000', 'number', 0.01, true, 15, 8, 
     'Sum all operating items: 125,000 + 45,000 - 15,000 + 8,000 - 6,000 + 12,000 + 4,000 = 173,000'),
    
    -- Investing Activities
    (v_activity_id, 'Your Answer!D27', 'Purchase of PP&E', '-130000', 'number', 0.01, true, 5, 9, 
     'Equipment purchases use cash - enter as negative'),
    
    (v_activity_id, 'Your Answer!D28', 'Sale of Investments', '25000', 'number', 0.01, true, 5, 10, 
     'Investment sales provide cash - enter as positive'),
    
    (v_activity_id, 'Your Answer!D30', 'Cash from Investing Activities', '-105000', 'number', 0.01, true, 10, 11, 
     'Sum: -130,000 + 25,000 = -105,000'),
    
    -- Financing Activities
    (v_activity_id, 'Your Answer!D35', 'Proceeds from Long-term Debt', '50000', 'number', 0.01, true, 5, 12, 
     'Borrowing provides cash - enter as positive'),
    
    (v_activity_id, 'Your Answer!D36', 'Proceeds from Common Stock', '20000', 'number', 0.01, true, 5, 13, 
     'Stock issuance provides cash - enter as positive'),
    
    (v_activity_id, 'Your Answer!D37', 'Dividends Paid', '-30000', 'number', 0.01, true, 5, 14, 
     'Dividends use cash - enter as negative'),
    
    (v_activity_id, 'Your Answer!D39', 'Cash from Financing Activities', '40000', 'number', 0.01, true, 10, 15, 
     'Sum: 50,000 + 20,000 - 30,000 = 40,000'),
    
    -- Summary
    (v_activity_id, 'Your Answer!D42', 'Net Increase in Cash', '108000', 'number', 0.01, true, 15, 16, 
     'CFO + CFI + CFF = 173,000 - 105,000 + 40,000 = 108,000'),
    
    (v_activity_id, 'Your Answer!D44', 'Beginning Cash', '85000', 'number', 0.01, true, 5, 17, 
     'From the Balance Sheet: Cash at end of 2023'),
    
    (v_activity_id, 'Your Answer!D45', 'Ending Cash', '193000', 'number', 0.01, true, 10, 18, 
     'Beginning Cash + Net Change = 85,000 + 108,000 = 193,000');
    
    RAISE NOTICE 'Created % grading criteria for the activity', 18;
    RAISE NOTICE '';
    RAISE NOTICE '═══════════════════════════════════════════════════════════';
    RAISE NOTICE 'CFS ACTIVITY CREATED SUCCESSFULLY!';
    RAISE NOTICE '═══════════════════════════════════════════════════════════';
    RAISE NOTICE 'Activity ID: %', v_activity_id;
    RAISE NOTICE 'Total points: 120';
    RAISE NOTICE 'Passing score: 70%%';
    
END $$;

