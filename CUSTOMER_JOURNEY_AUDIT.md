# Tutorio Customer Journey Audit

**Date:** December 30, 2025  
**Framework:** Journey Mapping for Experience Analysis  
**Analyst:** AI Journey Mapper  
**Type:** Current State Assessment

---

## Executive Summary

This customer journey audit maps the complete end-to-end experience for Tutorio users, from initial discovery through habit formation. The analysis identifies **28 touchpoints** across **6 journey phases**, with **14 pain points** and **18 opportunities** for improvement.

### Key Findings

- **Highest Emotional Point:** Completing first activity and seeing progress
- **Lowest Emotional Point:** Sign-up to first value (long time-to-value)
- **Critical Moment of Truth:** First learning activity experience
- **Top Recommendation:** Reduce friction in the awareness-to-first-value journey

---

## Persona Definition

### Persona: Alex - Swiss Business School Student

**Demographics:**
- Age: 21
- Role: 2nd year Business student
- Institution: HEC Lausanne / HSG / ZHAW
- Tech Savviness: High (digital native)
- Budget: Limited (CHF 80+/hour for tutoring is expensive)

**Goals:**
- Pass upcoming exams with good grades
- Understand complex concepts efficiently
- Save money compared to private tutoring
- Study flexibly around schedule

**Frustrations:**
- Overwhelmed by lecture notes volume
- Private tutoring is too expensive
- Existing resources don't match exam format
- Limited time to learn new platforms

**Quote:** "I need something that gets straight to the point and helps me pass my exam."

---

## Journey Definition

| Element | Description |
|---------|-------------|
| **Journey Name** | New User to Active Learner |
| **Goal** | Successfully complete learning activities and pass exam |
| **Trigger** | Searching for affordable exam prep / tutoring alternatives |
| **End State** | Regular platform usage and course completion |
| **Time Frame** | First 30 days |

---

## Journey Phases

### Phase 1: AWARENESS

**Touchpoints:**
- Google search results
- Social media / Word of mouth
- University forums
- Landing page (tutorio.ch)

**User Actions:**
1. Searches "affordable tutoring Switzerland" or similar
2. Finds Tutorio through search/referral
3. Lands on homepage
4. Scrolls through landing page content

**User Thoughts:**
- "Can this really replace expensive tutoring?"
- "Is this legit or just another generic platform?"
- "Do they cover my specific courses?"

**Emotions:**

```text
  Curious/Skeptical    Intensity: 0 (Neutral)
```

**Pain Points:**

| Pain Point | Severity | Evidence | Impact |
|------------|----------|----------|--------|
| Stats appear fabricated ("5,000+ students", "95% pass rate") | Medium | UX-015: Fake metrics | Trust erosion |
| Mock course data doesn't show real offerings | Medium | UX-014: Hardcoded courses | Mismatch with actual content |
| "Watch Demo" button doesn't work | High | UX-002: No handler | Missed conversion opportunity |

**Opportunities:**

| Opportunity | Impact | Effort | Priority |
|-------------|--------|--------|----------|
| Show real metrics or remove fake ones | High | Low | 1 |
| Dynamic course cards from database | Medium | Medium | 2 |
| Add working demo video/tour | High | Medium | 3 |

---

### Phase 2: CONSIDERATION

**Touchpoints:**
- Pricing section on landing page
- Course cards (mock data)
- Testimonials section
- Footer legal links

**User Actions:**
1. Scrolls to pricing section
2. Compares Basic vs Premium plans
3. Clicks on course cards to learn more
4. Attempts to read terms/privacy policy
5. Looks for demo or free trial info

**User Thoughts:**
- "CHF 10-25/month is reasonable compared to tutoring"
- "Which plan do I actually need?"
- "Let me see what's included before I commit"
- "Can I try before paying?"

**Emotions:**

```text
  Interested but Uncertain    Intensity: -1 (Slightly Negative)
```

**Pain Points:**

| Pain Point | Severity | Evidence | Impact |
|------------|----------|----------|--------|
| /courses page requires login | High | UX-005: Protected browsing | Friction before value demonstration |
| Testimonials look generic/fake | Medium | UX-023: Placeholder names | Reduced trust |
| Course cards lead to login, not previews | High | Landing page links | Breaks discovery flow |

**Opportunities:**

| Opportunity | Impact | Effort | Priority |
|-------------|--------|--------|----------|
| Make course browsing public | High | Low | 1 |
| Use real testimonials with photos | Medium | Low | 2 |
| Add course preview pages without login | High | Medium | 3 |
| Free trial messaging in pricing | Medium | Low | 4 |

---

### Phase 3: SIGN-UP

**Touchpoints:**
- Sign up page
- Email confirmation
- Welcome email (if exists)

**User Actions:**
1. Clicks "Start Free" or "Sign Up"
2. Enters name, email, password
3. Submits form
4. Checks email for confirmation
5. Confirms email and logs in

**User Thoughts:**
- "Quick signup, that's good"
- "Hope I don't need to enter my credit card yet"
- "Password strength indicator is helpful"

**Emotions:**

```text
  Hopeful/Cautious    Intensity: +1 (Slightly Positive)
```

**Pain Points:**

| Pain Point | Severity | Evidence | Impact |
|------------|----------|----------|--------|
| Login error clears email input | Critical | UX-003 | Frustration, higher abandonment |
| No OAuth options (Google/Apple) | Medium | Auth form analysis | Extra friction |
| Email confirmation required before access | Low | Standard flow | Slight delay |

**Opportunities:**

| Opportunity | Impact | Effort | Priority |
|-------------|--------|--------|----------|
| Preserve email on login error | High | Low | 1 |
| Add Google/Apple OAuth | Medium | Medium | 2 |
| Allow basic access before email confirm | Low | Medium | 3 |

---

### Phase 4: ONBOARDING / FIRST USE

**Touchpoints:**
- Dashboard (empty state)
- Course enrollment flow
- First activity

**User Actions:**
1. Lands on dashboard (no courses enrolled)
2. Sees onboarding checklist
3. Browses available courses
4. Enrolls in first course
5. Navigates to first activity
6. Completes first lesson

**User Thoughts:**
- "Where do I start?"
- "Good, there's a recommended course"
- "How do I actually begin learning?"
- "This is well-structured!"

**Emotions:**

```text
  Phase Start: Confused        Intensity: -1
  After First Activity: Relieved/Pleased    Intensity: +2
```

**Pain Points:**

| Pain Point | Severity | Evidence | Impact |
|------------|----------|----------|--------|
| No guided onboarding wizard | Medium | Dashboard analysis | User must self-navigate |
| Time-to-first-value is high | High | Multiple clicks to content | May abandon before seeing value |
| No progress saving on page navigation | Medium | No local storage | Context loss on back button |

**Opportunities:**

| Opportunity | Impact | Effort | Priority |
|-------------|--------|--------|----------|
| Auto-enroll in recommended beginner course | High | Medium | 1 |
| Add interactive onboarding tour | High | High | 2 |
| Quick-start button to first activity | High | Low | 3 |
| Show "What's Next" prominently | Medium | Low | 4 |

---

### Phase 5: LEARNING

**Touchpoints:**
- Activity pages (lessons, quizzes, code editors)
- Progress tracking UI
- AI tutor chatbot
- Navigation (prev/next)

**User Actions:**
1. Reads lesson content
2. Completes interactive exercises
3. Takes quizzes
4. Uses AI tutor for help
5. Tracks progress on skill pages
6. Returns for next session

**User Thoughts:**
- "This content is well-organized"
- "The AI tutor is helpful!"
- "I can see my progress - motivating"
- "Where did I leave off?"

**Emotions:**

```text
  Engaged/Satisfied    Intensity: +2 (Positive)
```

**Pain Points:**

| Pain Point | Severity | Evidence | Impact |
|------------|----------|----------|--------|
| Next activity navigation only at top | Medium | UX-010 | Extra scrolling after completion |
| No keyboard shortcuts | Minor | UX-016 | Power users slowed down |
| Chat messages lost on navigation | Minor | UX-022 | Context lost between activities |
| No loading indicators on transitions | Medium | UX-009 | Perceived slowness |

**Opportunities:**

| Opportunity | Impact | Effort | Priority |
|-------------|--------|--------|----------|
| Add "Next Activity" CTA at lesson end | High | Low | 1 |
| Add page transition progress bar | Medium | Low | 2 |
| Persist chat history | Medium | Medium | 3 |
| Add keyboard shortcuts (Enter to continue) | Low | Low | 4 |

---

### Phase 6: SUBSCRIPTION / UPGRADE

**Touchpoints:**
- Pricing page
- Stripe checkout
- Subscription management
- Locked content gates

**User Actions:**
1. Encounters locked content (beyond first 5 activities)
2. Navigates to pricing page
3. Selects plan (Basic or Advanced)
4. Completes Stripe checkout
5. Gains full access

**User Thoughts:**
- "I've seen value, ready to pay"
- "Which tier makes sense for me?"
- "Is the upgrade process quick?"

**Emotions:**

```text
  Deliberate/Committed    Intensity: +1
```

**Pain Points:**

| Pain Point | Severity | Evidence | Impact |
|------------|----------|----------|--------|
| Stripe not always configured (demo mode) | Variable | Pricing page check | No purchase possible |
| Must select course before seeing prices | Minor | Pricing flow | Extra step |
| No annual pricing option visible | Minor | Pricing analysis | Lost savings opportunity |

**Opportunities:**

| Opportunity | Impact | Effort | Priority |
|-------------|--------|--------|----------|
| Streamline course + plan selection | Medium | Medium | 1 |
| Add annual pricing discount | Medium | Low | 2 |
| Clearer value proposition per tier | Medium | Low | 3 |

---

### Phase 7: HABIT / RETENTION

**Touchpoints:**
- Dashboard (return visits)
- Email reminders (if implemented)
- Progress celebrations
- Course completion

**User Actions:**
1. Returns to platform regularly
2. Continues where left off
3. Completes courses/skills
4. Potentially refers others

**User Thoughts:**
- "Easy to pick up where I left off"
- "Making good progress"
- "Worth the subscription"

**Emotions:**

```text
  Satisfied/Loyal    Intensity: +2
```

**Pain Points:**

| Pain Point | Severity | Evidence | Impact |
|------------|----------|----------|--------|
| No streak/gamification incentives | Medium | Dashboard stats unused | Less motivation to return |
| No completion celebrations | Medium | No celebration UI | Missed dopamine moments |
| No referral program | Low | No referral feature | Organic growth limited |

**Opportunities:**

| Opportunity | Impact | Effort | Priority |
|-------------|--------|--------|----------|
| Add streak notifications/reminders | Medium | Medium | 1 |
| Celebrate milestones with confetti/badges | Medium | Low | 2 |
| Implement referral program | High | High | 3 |

---

## Emotion Curve Visualization

```text
EMOTION
  +2  |                                    ___/‾‾‾‾\___/‾‾‾‾‾‾‾‾‾‾‾
  +1  |              ___/\                /
   0  |____/‾‾‾‾\__/      \             /
  -1  |                     \___    ___/
  -2  |                         \__/

      |--Awareness--|--Consider--|--SignUp--|--Onboard--|--Learn--|--Habit--|
                                      ↑
                               Pain: Time to first value
```

**Emotional Journey Arc:** Neutral/Skeptical → Uncertain → Hopeful → Confused → Engaged → Satisfied

---

## Moments of Truth

### Zero Moment of Truth (ZMOT) - Pre-Discovery Research

| Aspect | Current State | Desired State |
|--------|---------------|---------------|
| **Phase** | Awareness | - |
| **Touchpoint** | Google search, landing page | - |
| **Current Experience** | Fake stats, non-working demo | Authentic proof, working demo |
| **Priority** | High |

### First Moment of Truth (FMOT) - Initial Engagement

| Aspect | Current State | Desired State |
|--------|---------------|---------------|
| **Phase** | Consideration → Sign-up | - |
| **Touchpoint** | Course browsing, signup | - |
| **Current Experience** | Login required to browse | Free course preview without login |
| **Priority** | Critical |

### Second Moment of Truth (SMOT) - Product Usage

| Aspect | Current State | Desired State |
|--------|---------------|---------------|
| **Phase** | Onboarding → Learning | - |
| **Touchpoint** | First activity completion | - |
| **Current Experience** | Takes 5+ clicks to reach content | 2-click path to first lesson |
| **Priority** | Critical |

### Ultimate Moment of Truth (UMOT) - Sharing/Advocacy

| Aspect | Current State | Desired State |
|--------|---------------|---------------|
| **Phase** | Habit | - |
| **Touchpoint** | Course completion, referral | - |
| **Current Experience** | No referral mechanism | Easy social sharing, referral rewards |
| **Priority** | Medium |

---

## Pain Point Summary by Severity

### Critical (Fix This Week)

1. **Broken conversion elements** - "Watch Demo" button, pricing buttons (resolved per UX report)
2. **Login error clears email** - High friction on failed auth
3. **Courses require login to browse** - Blocks discovery

### High Priority (Next 2 Weeks)

4. **Time-to-first-value too long** - Users must navigate 5+ screens to content
5. **Fake social proof** - Stats and testimonials reduce trust
6. **No mobile menu backdrop** - Visual polish issue
7. **No loading indicators** - Perceived slowness

### Medium Priority (Next Month)

8. **Empty dashboard lacks guidance** - Improved but still passive
9. **Activity navigation buried** - Only at top of page
10. **Chat history not persisted** - Context lost
11. **No gamification/streaks** - Less motivation to return

### Low Priority (Backlog)

12. **No keyboard shortcuts** - Power user feature
13. **Generic testimonials** - Trust improvement
14. **No referral program** - Growth feature

---

## Prioritized Recommendations

### Immediate Actions (This Week)

| # | Action | Impact | Effort | Owner |
|---|--------|--------|--------|-------|
| 1 | Preserve email input on login error | High | Low | Auth team |
| 2 | Make `/courses` page publicly accessible | High | Low | Routing |
| 3 | Replace fake stats with real data or remove | High | Low | Content |
| 4 | Ensure pricing buttons work (resolved per report) | Critical | Low | Stripe |

### Short-term (Next 2 Weeks)

| # | Action | Impact | Effort | Owner |
|---|--------|--------|--------|-------|
| 5 | Add "Quick Start" button on empty dashboard → first activity | High | Low | Dashboard |
| 6 | Add bottom "Next Activity" CTA on lesson completion | High | Low | Activity page |
| 7 | Add page transition loading indicator (NProgress) | Medium | Low | Layout |
| 8 | Create landing page course preview (no login) | High | Medium | Marketing |

### Medium-term (Next Month)

| # | Action | Impact | Effort | Owner |
|---|--------|--------|--------|-------|
| 9 | Interactive onboarding tour for new users | High | High | Onboarding |
| 10 | Persist AI chat history across activities | Medium | Medium | Chat |
| 11 | Add completion celebrations (confetti, badges) | Medium | Low | Gamification |
| 12 | Keyboard shortcuts for activity navigation | Low | Low | UX |

### Long-term (Backlog)

| # | Action | Impact | Effort | Owner |
|---|--------|--------|--------|-------|
| 13 | Referral program with rewards | High | High | Growth |
| 14 | Email re-engagement campaigns | Medium | Medium | Marketing |
| 15 | Annual subscription pricing | Medium | Low | Billing |

---

## Journey Map Summary (Tabular)

```text
PHASE:      | Awareness    | Consideration| Sign-up      | Onboarding   | Learning     | Habit
------------|--------------|--------------|--------------|--------------|--------------|--------
TOUCHPOINTS | Landing page | Pricing      | Auth forms   | Dashboard    | Activities   | Dashboard
            | Course cards | Testimonials |              | Course list  | AI tutor     | Progress
------------|--------------|--------------|--------------|--------------|--------------|--------
ACTIONS     | Scrolls,     | Compares     | Enters       | Enrolls      | Reads,       | Returns
            | evaluates    | plans        | credentials  | first course | practices    | continues
------------|--------------|--------------|--------------|--------------|--------------|--------
THOUGHTS    | "Is this     | "Which       | "Quick       | "Where do    | "This is     | "Easy to
            | legit?"      | plan?"       | and easy"    | I start?"    | helpful!"    | track"
------------|--------------|--------------|--------------|--------------|--------------|--------
EMOTIONS    |     😐       |      🤔      |      😌      |      😕      |     😊       |     😊
            |  Neutral     |   Uncertain  |   Hopeful    |   Confused   |   Engaged    |  Satisfied
------------|--------------|--------------|--------------|--------------|--------------|--------
PAIN POINTS | Fake stats   | Login to     | Email clear  | High TTF     | Nav at top   | No streaks
            | No demo      | browse       | on error     | value        | only         |
------------|--------------|--------------|--------------|--------------|--------------|--------
OPPORTUN-   | Real proof   | Public       | Preserve     | Quick start  | Bottom CTA   | Gamification
ITIES       | Working demo | browsing     | email        | button       | Persist chat | Referrals
```

---

## Appendix: Related Analysis

- **UX Review Report:** `UX_REVIEW_REPORT.md` - Nielsen's heuristics analysis with 23 issues
- **UX Implementation Guide:** `UX_IMPLEMENTATION_GUIDE.md` - Technical implementation details

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2025-12-30 | Initial customer journey audit |

---

*End of Customer Journey Audit*

