# Stripe Payment Integration Setup Guide

This guide walks you through setting up Stripe payments for Tutorio.

## Prerequisites

- A Stripe account (create one at https://stripe.com)
- Access to your Stripe Dashboard
- Your Tutorio environment variables file

## Step 1: Get Your Stripe API Keys

1. Go to [Stripe Dashboard](https://dashboard.stripe.com)
2. Navigate to **Developers > API keys**
3. Copy your **Publishable key** (starts with `pk_test_` for test mode or `pk_live_` for production)
4. Copy your **Secret key** (starts with `sk_test_` for test mode or `sk_live_` for production)

Add to your `.env.local`:

```env
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_your_publishable_key_here
STRIPE_SECRET_KEY=sk_test_your_secret_key_here
```

> **Note**: The publishable key is used for the embedded checkout experience. It's safe to expose in the browser.

## Step 2: Create Products and Prices

### Per-Course Pricing (Recommended)

Create separate products for each course in Stripe:

1. Go to **Products** in Stripe Dashboard
2. Click **+ Add product**

For each course (e.g., Financial Accounting, Computational Thinking):

#### [Course Name] Basic
- **Name**: Tutorio [Course Name] Basic
- **Description**: Core course access with AI tutor (25 messages/day)
- **Price**: CHF 10.00 / month (recurring)
- Save the **Price ID** (starts with `price_`)

#### [Course Name] Advanced
- **Name**: Tutorio [Course Name] Advanced
- **Description**: Complete course access with unlimited AI tutor
- **Price**: CHF 25.00 / month (recurring)
- Save the **Price ID** (starts with `price_`)

### Configure Price IDs in Admin Dashboard

1. Go to Admin Dashboard → Courses
2. Click on a course
3. Find the "Stripe Pricing" section
4. Enter the Basic and Advanced Price IDs for that course
5. Click "Save Prices"

### Alternative: Global Fallback Prices (Optional)

If you want fallback prices that apply to all courses without specific pricing:

```env
STRIPE_BASIC_PRICE_ID=price_your_basic_price_id
STRIPE_ADVANCED_PRICE_ID=price_your_advanced_price_id
```

> Note: Course-specific prices take priority over global fallback prices.

## Step 3: Configure Webhook

Webhooks allow Stripe to notify your application about payment events.

### For Local Development (using Stripe CLI)

1. Install [Stripe CLI](https://stripe.com/docs/stripe-cli)

2. Login to Stripe:
   ```bash
   stripe login
   ```

3. Forward webhooks to your local server:
   ```bash
   stripe listen --forward-to localhost:3000/api/stripe/webhook
   ```

4. Copy the webhook signing secret (starts with `whsec_`) and add to `.env.local`:
   ```env
   STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret
   ```

### For Production

1. Go to **Developers > Webhooks** in Stripe Dashboard
2. Click **+ Add endpoint**
3. Enter your endpoint URL: `https://yourdomain.com/api/stripe/webhook`
4. Select events to listen for:
   - `checkout.session.completed`
   - `customer.subscription.created`
   - `customer.subscription.updated`
   - `customer.subscription.deleted`
   - `invoice.payment_succeeded`
   - `invoice.payment_failed`
   - `invoice.upcoming` (optional - for renewal reminders)
5. Copy the **Signing secret** and add to your production environment variables

## Step 4: Configure Customer Portal

The Customer Portal allows users to manage their subscriptions.

1. Go to **Settings > Billing > Customer portal** in Stripe Dashboard
2. Configure the portal settings:
   - Enable **Subscriptions** management
   - Allow customers to update payment methods
   - Allow customers to view invoice history
   - Configure cancellation options (allow cancellation with end-of-period access)
3. Save your settings

## Step 5: Test the Integration

### Test Mode Checklist

Before going live, test the following flows:

1. **New Subscription Flow**
   - Navigate to `/pricing`
   - Select a course
   - Click "Subscribe to Basic" or "Subscribe to Advanced"
   - Complete checkout using test card: `4242 4242 4242 4242`
   - Verify success redirect and toast notification

2. **Subscription Upgrade**
   - With an active Basic subscription, click "Upgrade Now"
   - Verify subscription is upgraded with immediate prorated charge
   - User should have immediate access to the higher tier

3. **Subscription Downgrade**
   - With an active Advanced subscription, click "Schedule Downgrade"
   - Verify downgrade is scheduled for end of billing period
   - User should retain current tier access until period ends
   - No refund should be issued

4. **Customer Portal**
   - Go to `/subscriptions`
   - Click "Open Billing Portal"
   - Test payment method update
   - Test subscription cancellation

5. **Subscription Cancellation**
   - Cancel subscription from subscriptions page
   - Verify access continues until billing period ends
   - No refund should be issued

6. **Webhook Events**
   - Verify `checkout.session.completed` creates subscription in database
   - Verify `customer.subscription.updated` updates subscription status
   - Verify `invoice.payment_failed` marks subscription as `past_due`

## Billing Policy

### Upgrades
- **Immediate effect**: User gets access to the higher tier immediately
- **Immediate payment**: Prorated amount is charged right away
- No waiting until the end of the billing period

### Downgrades
- **Scheduled for period end**: Downgrade takes effect at the end of the current billing period
- **No refund**: User is not reimbursed for the remaining time on their current plan
- **Continued access**: User retains current tier benefits until the billing period ends

### Cancellations
- **Access until period end**: User keeps access until the end of the paid period
- **No refund**: No reimbursement for the remaining time
- **Can resubscribe**: User can resubscribe at any time

### Test Card Numbers

| Card Number | Description |
|-------------|-------------|
| 4242 4242 4242 4242 | Successful payment |
| 4000 0000 0000 9995 | Declined (insufficient funds) |
| 4000 0000 0000 3220 | Requires 3D Secure authentication |

Use any future expiry date and any 3-digit CVC.

## Step 6: Go Live

When you're ready for production:

1. Switch to **Live mode** in Stripe Dashboard
2. Create live products/prices (same as test mode)
3. Update environment variables with live keys:
   ```env
   NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_live_...
   STRIPE_SECRET_KEY=sk_live_...
   STRIPE_BASIC_PRICE_ID=price_...
   STRIPE_ADVANCED_PRICE_ID=price_...
   STRIPE_WEBHOOK_SECRET=whsec_...
   ```
4. Create production webhook endpoint
5. Deploy your changes

## Environment Variables Summary

```env
# Stripe Configuration
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_...  # Your Stripe publishable key (public)
STRIPE_SECRET_KEY=sk_test_...                    # Your Stripe secret key (server-only)
STRIPE_WEBHOOK_SECRET=whsec_...                  # Webhook signing secret
STRIPE_BASIC_PRICE_ID=price_...                  # Price ID for Basic plan
STRIPE_ADVANCED_PRICE_ID=price_...               # Price ID for Advanced plan
```

## Troubleshooting

### "Stripe not configured" Error
- Verify `STRIPE_SECRET_KEY` is set in your environment
- Restart your development server after adding env variables

### "Price not configured" Error
- Ensure `STRIPE_BASIC_PRICE_ID` and `STRIPE_ADVANCED_PRICE_ID` are set
- Verify the price IDs exist in your Stripe account

### Webhook Events Not Received
- Check Stripe CLI is running for local development
- Verify webhook endpoint URL is correct in Stripe Dashboard
- Check `STRIPE_WEBHOOK_SECRET` matches your endpoint

### Subscription Not Created After Payment
- Check webhook logs in Stripe Dashboard
- Verify your Supabase service role key is configured
- Check server logs for errors

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/stripe/checkout` | POST | Create checkout session (redirect mode) |
| `/api/stripe/checkout` | GET | Redirect to checkout (query params) |
| `/api/stripe/embedded-checkout` | POST | Create embedded checkout session |
| `/api/stripe/webhook` | POST | Handle Stripe webhooks |
| `/api/stripe/portal` | GET | Redirect to customer portal |

## Database Schema

Subscriptions are stored in the `subscriptions` table with:
- `stripe_subscription_id` - Stripe subscription ID
- `stripe_customer_id` - Stripe customer ID
- `status` - active, trialing, cancelled, expired, past_due
- `current_period_start/end` - Billing period timestamps
- `cancel_at_period_end` - Whether subscription will cancel at period end

## Security Notes

- Never expose `STRIPE_SECRET_KEY` to the client
- Always verify webhook signatures using `STRIPE_WEBHOOK_SECRET`
- Use Supabase service role key only in webhook handler (bypasses RLS)
- All checkout sessions include user and course metadata for tracking

