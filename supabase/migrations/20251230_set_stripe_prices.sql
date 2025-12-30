-- Set Stripe price IDs for each course

-- Computational Thinking
UPDATE courses 
SET 
  stripe_basic_price_id = 'price_1SjzhkBlKOGAMufifgcvDy58',
  stripe_advanced_price_id = 'price_1SjziaBlKOGAMufiwYZz6iQh',
  updated_at = NOW()
WHERE slug = 'computational-thinking';

-- Financial Accounting
UPDATE courses 
SET 
  stripe_basic_price_id = 'price_1SjzjFBlKOGAMufiC59ionXM',
  stripe_advanced_price_id = 'price_1SjzjmBlKOGAMufizhDHZnRr',
  updated_at = NOW()
WHERE slug = 'financial-accounting';

