-- ============================================
-- Fix Skill Mastery Calculation
-- Only count activities where is_owner = true
-- ============================================

-- Update calculate_skill_mastery to only consider owned activities
CREATE OR REPLACE FUNCTION calculate_skill_mastery(
  p_user_id UUID,
  p_skill_id UUID
)
RETURNS INT AS $$
DECLARE
  v_total_weight DECIMAL;
  v_weighted_score DECIMAL;
  v_mastery INT;
BEGIN
  -- Calculate weighted average of activity scores for this skill
  -- Only consider activities where is_owner = true
  SELECT 
    COALESCE(SUM(asks.weight), 0),
    COALESCE(SUM(
      CASE 
        WHEN ap.completed THEN asks.weight * COALESCE(ap.score, 100)
        ELSE 0
      END
    ), 0)
  INTO v_total_weight, v_weighted_score
  FROM activity_skills asks
  JOIN activities a ON asks.activity_id = a.id
  LEFT JOIN activity_progress ap ON a.id = ap.activity_id AND ap.user_id = p_user_id
  WHERE asks.skill_id = p_skill_id
    AND asks.is_owner = true;
  
  -- Calculate mastery (0-100)
  IF v_total_weight > 0 THEN
    v_mastery := ROUND(v_weighted_score / v_total_weight);
  ELSE
    v_mastery := 0;
  END IF;
  
  -- Update user skill progress
  INSERT INTO user_skill_progress (user_id, skill_id, mastery_level, last_practiced_at)
  VALUES (p_user_id, p_skill_id, v_mastery, now())
  ON CONFLICT (user_id, skill_id)
  DO UPDATE SET
    mastery_level = v_mastery,
    times_practiced = user_skill_progress.times_practiced + 1,
    last_practiced_at = now();
  
  RETURN v_mastery;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Also create a function to recalculate all skill mastery for a user
-- This can be called to fix existing data
CREATE OR REPLACE FUNCTION recalculate_all_skill_mastery(p_user_id UUID)
RETURNS void AS $$
DECLARE
  v_skill RECORD;
BEGIN
  -- Loop through all skills that the user has activity progress for
  FOR v_skill IN 
    SELECT DISTINCT asks.skill_id
    FROM activity_skills asks
    JOIN activity_progress ap ON asks.activity_id = ap.activity_id
    WHERE ap.user_id = p_user_id
      AND asks.is_owner = true
  LOOP
    PERFORM calculate_skill_mastery(p_user_id, v_skill.skill_id);
  END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

