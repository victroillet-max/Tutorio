-- Migration: Google Sheets Integration for Financial Analysis Course
-- This creates the schema for tracking user-specific Google Sheets copies

-- Table to store user's personal copies of template sheets
CREATE TABLE IF NOT EXISTS user_sheets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    activity_id UUID NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
    
    -- Google Sheets identifiers
    template_sheet_id TEXT NOT NULL,      -- Original template sheet ID
    user_sheet_id TEXT NOT NULL,          -- User's personal copy sheet ID
    user_sheet_url TEXT NOT NULL,         -- Direct URL to user's sheet
    
    -- Tracking
    sheet_title TEXT,                     -- Title of the sheet
    last_synced_at TIMESTAMPTZ,           -- Last time we synced data from sheet
    is_completed BOOLEAN DEFAULT FALSE,   -- Whether the exercise was completed
    completion_data JSONB,                -- Stores graded cell values and results
    
    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Each user can only have one copy per activity
    UNIQUE(user_id, activity_id)
);

-- Table to define grading criteria for sheet-based exercises
CREATE TABLE IF NOT EXISTS sheet_grading_criteria (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    activity_id UUID NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
    
    -- Cell reference for grading (e.g., "Sheet1!B15")
    cell_reference TEXT NOT NULL,
    cell_name TEXT,                       -- Human-readable name (e.g., "Cash from Operations")
    
    -- Expected value configuration
    expected_value TEXT,                  -- Expected value (can be number, text, or formula result)
    expected_type TEXT DEFAULT 'number',  -- 'number', 'text', 'formula', 'boolean'
    tolerance DECIMAL(10,4) DEFAULT 0,    -- Tolerance for numeric comparisons (e.g., 0.01 for 1%)
    is_required BOOLEAN DEFAULT TRUE,     -- Must this cell be correct to pass?
    
    -- Scoring
    points INTEGER DEFAULT 1,             -- Points awarded for correct answer
    partial_credit BOOLEAN DEFAULT FALSE, -- Allow partial credit?
    
    -- Display
    sort_order INTEGER DEFAULT 0,
    hint_on_error TEXT,                   -- Hint to show if this cell is wrong
    
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for fast lookups
CREATE INDEX IF NOT EXISTS idx_user_sheets_user_id ON user_sheets(user_id);
CREATE INDEX IF NOT EXISTS idx_user_sheets_activity_id ON user_sheets(activity_id);
CREATE INDEX IF NOT EXISTS idx_user_sheets_user_activity ON user_sheets(user_id, activity_id);
CREATE INDEX IF NOT EXISTS idx_sheet_grading_criteria_activity ON sheet_grading_criteria(activity_id);

-- Trigger to update updated_at
CREATE OR REPLACE FUNCTION update_user_sheets_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_user_sheets_updated_at
    BEFORE UPDATE ON user_sheets
    FOR EACH ROW
    EXECUTE FUNCTION update_user_sheets_updated_at();

CREATE TRIGGER trigger_sheet_grading_criteria_updated_at
    BEFORE UPDATE ON sheet_grading_criteria
    FOR EACH ROW
    EXECUTE FUNCTION update_user_sheets_updated_at();

-- RLS Policies
ALTER TABLE user_sheets ENABLE ROW LEVEL SECURITY;
ALTER TABLE sheet_grading_criteria ENABLE ROW LEVEL SECURITY;

-- Users can only see and modify their own sheets
CREATE POLICY "Users can view own sheets"
    ON user_sheets FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own sheets"
    ON user_sheets FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own sheets"
    ON user_sheets FOR UPDATE
    USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own sheets"
    ON user_sheets FOR DELETE
    USING (auth.uid() = user_id);

-- Anyone can view grading criteria (read-only)
CREATE POLICY "Anyone can view grading criteria"
    ON sheet_grading_criteria FOR SELECT
    USING (true);

-- Only admins can modify grading criteria
CREATE POLICY "Admins can manage grading criteria"
    ON sheet_grading_criteria FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'admin'
        )
    );

-- Function to get or create a user's sheet for an activity
CREATE OR REPLACE FUNCTION get_user_sheet(
    p_user_id UUID,
    p_activity_id UUID
) RETURNS TABLE(
    sheet_id TEXT,
    sheet_url TEXT,
    is_completed BOOLEAN,
    completion_data JSONB,
    created_at TIMESTAMPTZ
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        us.user_sheet_id,
        us.user_sheet_url,
        us.is_completed,
        us.completion_data,
        us.created_at
    FROM user_sheets us
    WHERE us.user_id = p_user_id
    AND us.activity_id = p_activity_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to mark a sheet exercise as completed
CREATE OR REPLACE FUNCTION complete_sheet_exercise(
    p_user_id UUID,
    p_activity_id UUID,
    p_completion_data JSONB
) RETURNS BOOLEAN AS $$
DECLARE
    v_total_points INTEGER;
    v_earned_points INTEGER;
    v_passing_score DECIMAL;
    v_score DECIMAL;
BEGIN
    -- Calculate score from completion data
    SELECT 
        COALESCE(SUM(CASE WHEN (p_completion_data->cell_reference->>'is_correct')::boolean THEN points ELSE 0 END), 0),
        COALESCE(SUM(points), 0)
    INTO v_earned_points, v_total_points
    FROM sheet_grading_criteria
    WHERE activity_id = p_activity_id;
    
    -- Get passing score from activity
    SELECT passing_score INTO v_passing_score
    FROM activities
    WHERE id = p_activity_id;
    
    IF v_total_points > 0 THEN
        v_score := (v_earned_points::DECIMAL / v_total_points::DECIMAL) * 100;
    ELSE
        v_score := 100;
    END IF;
    
    -- Update user sheet record
    UPDATE user_sheets
    SET 
        is_completed = v_score >= v_passing_score,
        completion_data = p_completion_data,
        last_synced_at = NOW()
    WHERE user_id = p_user_id
    AND activity_id = p_activity_id;
    
    RETURN v_score >= v_passing_score;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

COMMENT ON TABLE user_sheets IS 'Stores user-specific copies of Google Sheets templates for exercises';
COMMENT ON TABLE sheet_grading_criteria IS 'Defines which cells to check and their expected values for auto-grading';

