-- ============================================
-- Content Management System Migration
-- Adds contentadmin role and pending changes workflow
-- ============================================

-- ============================================
-- 1. Extend user_role enum to include contentadmin
-- ============================================

-- Add 'contentadmin' to the user_role enum
ALTER TYPE user_role ADD VALUE IF NOT EXISTS 'contentadmin';

-- ============================================
-- 2. Create content change status enum
-- ============================================

CREATE TYPE content_change_status AS ENUM (
  'pending',    -- Awaiting review by super admin
  'approved',   -- Change has been approved and applied
  'rejected'    -- Change was rejected with feedback
);

-- ============================================
-- 3. Create content change type enum
-- ============================================

CREATE TYPE content_change_type AS ENUM (
  'create',     -- Creating a new entity
  'update',     -- Updating existing entity
  'delete',     -- Deleting an entity
  'reorder'     -- Reordering entities within a parent
);

-- ============================================
-- 4. Create entity type enum for content changes
-- ============================================

CREATE TYPE content_entity_type AS ENUM (
  'activity',   -- Activity-level change
  'module',     -- Module-level change
  'course'      -- Course-level change
);

-- ============================================
-- 5. Create pending_content_changes table
-- ============================================

CREATE TABLE pending_content_changes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  
  -- What entity is being changed
  entity_type content_entity_type NOT NULL,
  entity_id UUID,                           -- NULL for new entities (create)
  parent_id UUID,                           -- Parent entity (e.g., module_id for activities)
  
  -- Type of change
  change_type content_change_type NOT NULL,
  
  -- Data snapshots
  current_data JSONB,                       -- Snapshot of current state (NULL for creates)
  proposed_data JSONB NOT NULL,             -- Proposed changes or new data
  
  -- Submission info
  submitted_by UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  submitted_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  title TEXT NOT NULL,                      -- Brief description of the change
  description TEXT,                         -- Detailed explanation
  
  -- Review info
  status content_change_status NOT NULL DEFAULT 'pending',
  reviewed_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  reviewed_at TIMESTAMPTZ,
  review_notes TEXT,                        -- Feedback from reviewer
  
  -- Timestamps
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================
-- 6. Create indexes for efficient queries
-- ============================================

-- Index for filtering by status (common query pattern)
CREATE INDEX idx_pending_changes_status ON pending_content_changes(status);

-- Index for filtering by submitter
CREATE INDEX idx_pending_changes_submitted_by ON pending_content_changes(submitted_by);

-- Index for filtering by entity
CREATE INDEX idx_pending_changes_entity ON pending_content_changes(entity_type, entity_id);

-- Index for sorting by submission date
CREATE INDEX idx_pending_changes_submitted_at ON pending_content_changes(submitted_at DESC);

-- ============================================
-- 7. Create updated_at trigger
-- ============================================

CREATE OR REPLACE FUNCTION update_pending_changes_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER pending_changes_updated_at
  BEFORE UPDATE ON pending_content_changes
  FOR EACH ROW
  EXECUTE FUNCTION update_pending_changes_updated_at();

-- ============================================
-- 8. Helper functions for role checks
-- ============================================

-- Check if current user is a content admin (includes super admin)
CREATE OR REPLACE FUNCTION is_content_admin()
RETURNS BOOLEAN AS $$
DECLARE
  user_role_val user_role;
BEGIN
  SELECT role INTO user_role_val
  FROM profiles
  WHERE id = auth.uid();
  
  RETURN user_role_val IN ('admin', 'contentadmin');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Check if current user is a super admin (full admin only)
CREATE OR REPLACE FUNCTION is_super_admin()
RETURNS BOOLEAN AS $$
DECLARE
  user_role_val user_role;
BEGIN
  SELECT role INTO user_role_val
  FROM profiles
  WHERE id = auth.uid();
  
  RETURN user_role_val = 'admin';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 9. Row Level Security Policies
-- ============================================

-- Enable RLS on pending_content_changes
ALTER TABLE pending_content_changes ENABLE ROW LEVEL SECURITY;

-- Content admins can view their own submissions
CREATE POLICY "Content admins can view own submissions"
  ON pending_content_changes
  FOR SELECT
  USING (
    submitted_by = auth.uid() OR
    is_super_admin()
  );

-- Content admins can create pending changes
CREATE POLICY "Content admins can create pending changes"
  ON pending_content_changes
  FOR INSERT
  WITH CHECK (
    is_content_admin() AND
    submitted_by = auth.uid()
  );

-- Content admins can update their own pending changes (only if still pending)
CREATE POLICY "Content admins can update own pending changes"
  ON pending_content_changes
  FOR UPDATE
  USING (
    (submitted_by = auth.uid() AND status = 'pending') OR
    is_super_admin()
  );

-- Only super admins can delete pending changes
CREATE POLICY "Super admins can delete pending changes"
  ON pending_content_changes
  FOR DELETE
  USING (is_super_admin());

-- ============================================
-- 10. Function to apply approved changes
-- ============================================

-- Apply an approved activity update
CREATE OR REPLACE FUNCTION apply_activity_change(change_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
  change_record pending_content_changes;
  proposed JSONB;
BEGIN
  -- Get the change record
  SELECT * INTO change_record
  FROM pending_content_changes
  WHERE id = change_id AND status = 'approved';
  
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Change not found or not approved';
  END IF;
  
  proposed := change_record.proposed_data;
  
  -- Apply based on change type
  CASE change_record.change_type
    WHEN 'update' THEN
      UPDATE activities
      SET
        title = COALESCE(proposed->>'title', title),
        slug = COALESCE(proposed->>'slug', slug),
        type = COALESCE((proposed->>'type')::activity_type, type),
        minutes = COALESCE((proposed->>'minutes')::INTEGER, minutes),
        xp = COALESCE((proposed->>'xp')::INTEGER, xp),
        required_plan = COALESCE((proposed->>'required_plan')::plan_tier, required_plan),
        content = COALESCE(proposed->'content', content),
        interactive_type = COALESCE(proposed->>'interactive_type', interactive_type),
        starter_code = COALESCE(proposed->>'starter_code', starter_code),
        passing_score = COALESCE((proposed->>'passing_score')::INTEGER, passing_score),
        time_limit = COALESCE((proposed->>'time_limit')::INTEGER, time_limit),
        blocks_progress = COALESCE((proposed->>'blocks_progress')::BOOLEAN, blocks_progress),
        is_published = COALESCE((proposed->>'is_published')::BOOLEAN, is_published),
        updated_at = NOW()
      WHERE id = change_record.entity_id;
      
    WHEN 'create' THEN
      INSERT INTO activities (
        id, module_id, external_id, order_index, title, slug, type,
        minutes, xp, required_plan, content, interactive_type,
        starter_code, passing_score, time_limit, blocks_progress, is_published
      ) VALUES (
        COALESCE((proposed->>'id')::UUID, gen_random_uuid()),
        (proposed->>'module_id')::UUID,
        COALESCE(proposed->>'external_id', 'NEW-' || gen_random_uuid()::TEXT),
        COALESCE((proposed->>'order_index')::INTEGER, 999),
        proposed->>'title',
        proposed->>'slug',
        (proposed->>'type')::activity_type,
        (proposed->>'minutes')::INTEGER,
        COALESCE((proposed->>'xp')::INTEGER, 10),
        COALESCE((proposed->>'required_plan')::plan_tier, 'basic'),
        proposed->'content',
        proposed->>'interactive_type',
        proposed->>'starter_code',
        COALESCE((proposed->>'passing_score')::INTEGER, 70),
        (proposed->>'time_limit')::INTEGER,
        COALESCE((proposed->>'blocks_progress')::BOOLEAN, FALSE),
        COALESCE((proposed->>'is_published')::BOOLEAN, TRUE)
      );
      
    WHEN 'delete' THEN
      -- Soft delete by unpublishing, or hard delete
      UPDATE activities
      SET is_published = FALSE, updated_at = NOW()
      WHERE id = change_record.entity_id;
      
    WHEN 'reorder' THEN
      -- Reorder is handled specially - proposed_data contains array of {id, order_index}
      DECLARE
        item JSONB;
      BEGIN
        FOR item IN SELECT * FROM jsonb_array_elements(proposed->'order')
        LOOP
          UPDATE activities
          SET order_index = (item->>'order_index')::INTEGER, updated_at = NOW()
          WHERE id = (item->>'id')::UUID;
        END LOOP;
      END;
  END CASE;
  
  RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- 11. Grant necessary permissions
-- ============================================

-- Grant usage on new types to authenticated users
GRANT USAGE ON TYPE content_change_status TO authenticated;
GRANT USAGE ON TYPE content_change_type TO authenticated;
GRANT USAGE ON TYPE content_entity_type TO authenticated;

-- Grant function execution to authenticated users
GRANT EXECUTE ON FUNCTION is_content_admin() TO authenticated;
GRANT EXECUTE ON FUNCTION is_super_admin() TO authenticated;
GRANT EXECUTE ON FUNCTION apply_activity_change(UUID) TO authenticated;

