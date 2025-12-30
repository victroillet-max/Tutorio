-- Link the CFS activity to a relevant skill (Cash Flow Categories or similar)
-- This allows it to appear on the skills page

DO $$
DECLARE
    v_activity_id UUID;
    v_skill_id UUID;
BEGIN
    -- Find the CFS activity
    SELECT id INTO v_activity_id
    FROM activities
    WHERE external_id = 'FA-CFS-001';
    
    IF v_activity_id IS NULL THEN
        RAISE NOTICE 'Activity FA-CFS-001 not found. Please run 051_cfs_activity_sample.sql first.';
        RETURN;
    END IF;
    
    -- Find a relevant skill to link to (preferring "Cash Flow Categories" or similar)
    SELECT id INTO v_skill_id
    FROM skills
    WHERE slug IN ('cash-flow-categories', 'operating-activities', 'cash-flow-statement-interpretation')
      AND is_active = true
    ORDER BY 
        CASE slug 
            WHEN 'cash-flow-categories' THEN 1 
            WHEN 'operating-activities' THEN 2 
            ELSE 3 
        END
    LIMIT 1;
    
    IF v_skill_id IS NULL THEN
        -- Fallback: try to find any cash flow related skill
        SELECT id INTO v_skill_id
        FROM skills
        WHERE name ILIKE '%cash flow%'
          AND is_active = true
        LIMIT 1;
    END IF;
    
    IF v_skill_id IS NULL THEN
        RAISE NOTICE 'No suitable skill found to link the CFS activity to.';
        RETURN;
    END IF;
    
    -- Check if link already exists
    IF EXISTS (SELECT 1 FROM activity_skills WHERE activity_id = v_activity_id AND skill_id = v_skill_id) THEN
        RAISE NOTICE 'Activity is already linked to skill.';
        RETURN;
    END IF;
    
    -- Create the activity-skill link with is_owner = true so it appears in the skill's learning path
    INSERT INTO activity_skills (activity_id, skill_id, weight, is_primary, is_owner, order_index)
    VALUES (v_activity_id, v_skill_id, 1.0, true, true, 100);
    
    RAISE NOTICE '═══════════════════════════════════════════════════════════';
    RAISE NOTICE 'CFS ACTIVITY LINKED TO SKILL SUCCESSFULLY!';
    RAISE NOTICE '═══════════════════════════════════════════════════════════';
    RAISE NOTICE 'Activity ID: %', v_activity_id;
    RAISE NOTICE 'Skill ID: %', v_skill_id;
    RAISE NOTICE '';
    RAISE NOTICE 'The activity should now appear in the skill''s learning path.';
    
END $$;

