-- Set Stripe price IDs for Managerial Accounting course

UPDATE courses 
SET 
  stripe_basic_price_id = 'price_1SnCf8BlKOGAMufiS1xqBLWe',
  stripe_advanced_price_id = 'price_1SnCfPBlKOGAMufiDfS5yy3H',
  updated_at = NOW()
WHERE slug = 'managerial-accounting';


