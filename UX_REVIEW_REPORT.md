# Tutorio UX Review Report

**Date:** December 30, 2025  
**Reviewer:** AI UX Analyst  
**Framework:** Nielsen's 10 Heuristics + Extended UX Principles

---

## Executive Summary

This comprehensive UX review identifies **23 issues** across the Tutorio learning platform, categorized by severity and mapped to specific heuristics. The issues span visual design, interaction patterns, accessibility, and content strategy.

### Severity Distribution
- **Critical (P0):** 3 issues - Fix immediately
- **Major (P1):** 8 issues - High priority
- **Minor (P2):** 7 issues - Medium priority  
- **Cosmetic (P3):** 5 issues - Low priority

---

## Issue Registry

### CRITICAL (P0) - Fix Immediately

---

#### UX-001: Footer Links Are Placeholder URLs
**Heuristic:** H3 - User Control and Freedom  
**Location:** `src/app/page.tsx` (lines 500-574)  
**Severity:** Critical

**Problem:** All footer links (Courses, Pricing, How It Works, FAQ, Privacy Policy, Terms of Service, Cookie Policy, Contact) use `href="#"` placeholder URLs. Users cannot access legal pages or navigate to important sections.

**User Impact:** 
- Users cannot read Terms/Privacy before signing up (legal/trust issue)
- Navigation breaks user expectations
- SEO penalty for broken links

**Fix:** Create actual pages or link to valid anchor IDs.

---

#### UX-002: "Watch Demo" Button Has No Handler
**Heuristic:** H7 - Flexibility and Efficiency of Use  
**Location:** `src/app/page.tsx` (line 114)  
**Severity:** Critical

**Problem:** The prominent "Watch Demo" button in the hero section has no `onClick` handler and no `href`. Clicking does nothing.

**User Impact:**
- Broken primary conversion path
- User frustration and loss of trust
- Wasted CTA real estate

**Fix:** Either implement a demo video modal or remove the button.

---

#### UX-003: Login Error Clears Email Input
**Heuristic:** H5 - Error Prevention  
**Location:** `src/components/auth/auth-form.tsx`  
**Severity:** Critical

**Problem:** When login fails with "Invalid login credentials", the email field is cleared, forcing users to re-type their email address.

**User Impact:**
- Frustration on failed login attempts
- Higher abandonment rate
- Accessibility issue for users with motor difficulties

**Fix:** Preserve email value on error; only clear password.

---

### MAJOR (P1) - High Priority

---

#### UX-004: Mobile Menu Doesn't Block Page Content
**Heuristic:** H4 - Consistency and Standards  
**Location:** `src/app/page.tsx` (mobile menu section)  
**Severity:** Major

**Problem:** When the mobile hamburger menu opens, page content is visible behind and beneath it. The menu doesn't use a backdrop or prevent scroll.

**User Impact:**
- Visual confusion with overlapping content
- Users may accidentally scroll the page behind the menu
- Unprofessional appearance

**Fix:** Add backdrop overlay and `body { overflow: hidden }` when menu is open.

---

#### UX-005: Course Browse Page Requires Login
**Heuristic:** H7 - Flexibility and Efficiency of Use  
**Location:** `src/app/(protected)/courses/page.tsx`  
**Severity:** Major

**Problem:** The `/courses` page is protected, but the landing page prominently links to it with "View All 50+ Courses". Users are redirected to login when they just want to browse.

**User Impact:**
- Friction in the discovery phase
- Lost potential conversions
- Inconsistent with landing page course cards being public

**Fix:** Either make `/courses` public for browsing, or change CTAs to link to `/#courses`.

---

#### UX-006: Generic Typography Lacks Distinctiveness
**Heuristic:** Aesthetic and Minimalist Design  
**Location:** `src/app/globals.css`, `src/app/layout.tsx`  
**Severity:** Major

**Problem:** The application uses Poppins as the primary font, which is overused and associated with generic/AI-generated designs. The color scheme is standard blue (#3b82f6) without distinctive character.

**User Impact:**
- Platform looks indistinguishable from competitors
- Reduced brand recall and memorability
- "AI-slop" aesthetic perception

**Fix:** Adopt a more distinctive font pairing and refined color palette.

---

#### UX-007: Pricing Cards "Get Started" Buttons Lack Action
**Heuristic:** H7 - Flexibility and Efficiency of Use  
**Location:** `src/app/page.tsx` (pricing section buttons)  
**Severity:** Major

**Problem:** The "Get Started" buttons on pricing cards are `<button>` elements with no `onClick` handler or navigation. They do nothing when clicked.

**User Impact:**
- Completely broken conversion funnel
- Users cannot purchase/subscribe
- Revenue loss

**Fix:** Link buttons to signup flow with plan preselection.

---

#### UX-008: Chat Widget Position Conflicts on Mobile
**Heuristic:** H4 - Consistency and Standards  
**Location:** `src/components/chat/chat-widget.tsx`  
**Severity:** Major

**Problem:** The chat widget is fixed at `bottom-6 right-6` (24px from edges). On mobile with bottom navigation bars (iOS Safari, some Android browsers), this may overlap with system UI.

**User Impact:**
- Chat button may be partially hidden
- Difficult to tap on some devices
- Inconsistent experience across devices

**Fix:** Use `env(safe-area-inset-bottom)` for proper mobile spacing.

---

#### UX-009: No Loading States on Page Transitions
**Heuristic:** H1 - Visibility of System Status  
**Location:** Various protected pages  
**Severity:** Major

**Problem:** When navigating between pages (especially in the protected area), there's no visible loading indicator. Server components render after a delay with no feedback.

**User Impact:**
- Users unsure if click registered
- Perceived slowness
- May double-click or abandon

**Fix:** Add NProgress or similar page transition indicator.

---

#### UX-010: Activity Navigation Is Buried
**Heuristic:** H6 - Recognition Rather Than Recall  
**Location:** `src/app/(protected)/skills/[skillSlug]/[activitySlug]/page.tsx`  
**Severity:** Major

**Problem:** Activity prev/next navigation is only visible at the sticky header top. When users complete a lesson, the "next activity" action requires scrolling up or looking at the top bar.

**User Impact:**
- Unclear path forward after completion
- Extra cognitive load to find navigation
- May abandon instead of continuing

**Fix:** Add prominent "Next Activity" CTA at the bottom after completion.

---

#### UX-011: Empty Dashboard State Lacks Personality
**Heuristic:** H10 - Help and Documentation  
**Location:** `src/app/(protected)/dashboard/page.tsx`  
**Severity:** Major

**Problem:** When users have no enrolled courses, the empty state shows a generic message. It lacks onboarding guidance, course recommendations, or a clear path forward.

**User Impact:**
- New users feel lost
- No personalized recommendations
- Missed opportunity for engagement

**Fix:** Add course recommendations, onboarding checklist, or quick-start wizard.

---

### MINOR (P2) - Medium Priority

---

#### UX-012: Inconsistent Border Radius Values
**Heuristic:** H4 - Consistency and Standards  
**Location:** Various components across the codebase  
**Severity:** Minor

**Problem:** Border radius values vary inconsistently: `rounded-lg` (8px), `rounded-xl` (12px), `rounded-2xl` (16px), `rounded-full` used without clear system.

**User Impact:**
- Visual inconsistency feels unpolished
- Design system appears ad-hoc

**Fix:** Establish design tokens: small (6px), medium (12px), large (16px), full.

---

#### UX-013: User Dropdown Uses CSS Hover Only
**Heuristic:** H8 - Accessibility  
**Location:** `src/app/(protected)/layout.tsx` (user menu)  
**Severity:** Minor

**Problem:** The user dropdown menu appears on hover only. Keyboard users cannot access it, and on touch devices behavior is inconsistent.

**User Impact:**
- Keyboard users cannot access profile/logout
- Touch device users experience inconsistent behavior
- Accessibility compliance issue

**Fix:** Convert to click-triggered dropdown with proper ARIA attributes.

---

#### UX-014: Landing Page Uses Mock Data
**Heuristic:** H2 - Match Between System and Real World  
**Location:** `src/app/page.tsx` (course cards section)  
**Severity:** Minor

**Problem:** The landing page course cards show hardcoded mock data (Financial Accounting, Marketing Strategy, etc.) instead of actual courses from the database.

**User Impact:**
- Disconnect between landing page and actual content
- Click on mock card leads to login, not that course
- Maintenance burden to keep in sync

**Fix:** Fetch real courses from database for landing page.

---

#### UX-015: Stats Section Shows Fake Numbers
**Heuristic:** H2 - Match Between System and Real World  
**Location:** `src/app/page.tsx` (stats section)  
**Severity:** Minor

**Problem:** The landing page shows "5,000+ Active Students", "50+ Courses", "95% Pass Rate", "4.9 Avg. Rating" - these appear to be aspirational rather than real metrics.

**User Impact:**
- Trust issues if users discover they're fabricated
- Legal/advertising compliance concerns

**Fix:** Either use real metrics from database or mark as "beta" with honest numbers.

---

#### UX-016: Missing Keyboard Shortcuts
**Heuristic:** H7 - Flexibility and Efficiency of Use  
**Location:** Activity viewers, code editor  
**Severity:** Minor

**Problem:** No keyboard shortcuts are provided for common actions (complete lesson, navigate to next, submit code).

**User Impact:**
- Power users have slower workflow
- Accessibility limitation for keyboard-only users

**Fix:** Add `Cmd/Ctrl + Enter` for submit, arrow keys for navigation.

---

#### UX-017: Form Validation Feedback Is Minimal
**Heuristic:** H9 - Help Users Recognize and Recover from Errors  
**Location:** Auth forms, profile page  
**Severity:** Minor

**Problem:** Form validation uses browser defaults. No inline validation, character counts, or helpful hints during input.

**User Impact:**
- Users only learn of errors after submission
- No password strength indicator
- Unclear requirements

**Fix:** Add inline validation with real-time feedback.

---

#### UX-018: No Skeleton Loaders
**Heuristic:** H1 - Visibility of System Status  
**Location:** Dashboard, courses page  
**Severity:** Minor

**Problem:** When data is loading, pages either show nothing or a simple spinner. No skeleton loaders to indicate content structure.

**User Impact:**
- Perceived longer load times
- Layout shift when content appears
- Less polished experience

**Fix:** Add skeleton loaders matching content structure.

---

### COSMETIC (P3) - Low Priority

---

#### UX-019: Horizontal Scrollbar Visible on Mobile
**Heuristic:** H8 - Aesthetic and Minimalist Design  
**Location:** Landing page on mobile viewport  
**Severity:** Cosmetic

**Problem:** A thin scrollbar is visible on the right edge of the mobile landing page, suggesting slight overflow.

**User Impact:**
- Unprofessional appearance
- May cause accidental horizontal scroll

**Fix:** Add `overflow-x: hidden` to body or fix the overflow source.

---

#### UX-020: Footer Copyright Uses Current Year Hardcoded
**Heuristic:** H4 - Consistency and Standards  
**Location:** `src/app/page.tsx` (footer)  
**Severity:** Cosmetic

**Problem:** Footer shows "2025 Tutorio" - this will need manual updates yearly.

**User Impact:**
- Outdated copyright looks abandoned
- Maintenance burden

**Fix:** Use `new Date().getFullYear()` for dynamic year.

---

#### UX-021: Missing Favicon Variants
**Heuristic:** H4 - Consistency and Standards  
**Location:** `src/app/layout.tsx`  
**Severity:** Cosmetic

**Problem:** Only basic favicon specified. Missing Apple touch icon, Safari pinned tab, manifest for PWA.

**User Impact:**
- Poor appearance when bookmarked
- Not optimized for mobile home screen

**Fix:** Add complete favicon set with manifest.

---

#### UX-022: Chat Widget Lacks Message Persistence
**Heuristic:** H6 - Recognition Rather Than Recall  
**Location:** `src/components/chat/chat-widget.tsx`  
**Severity:** Cosmetic

**Problem:** Chat messages are cleared when navigating to a different activity. Conversation history is lost.

**User Impact:**
- Users lose context when moving between activities
- Cannot reference previous AI assistance

**Fix:** Persist messages in localStorage or database.

---

#### UX-023: Testimonials Look Generic
**Heuristic:** H2 - Match Between System and Real World  
**Location:** `src/app/page.tsx` (testimonials section)  
**Severity:** Cosmetic

**Problem:** Testimonials use generic placeholder names (Marie L., Thomas B., Sarah K.) with initials-based avatars. No photos, no verifiable identities.

**User Impact:**
- Appears fabricated
- Reduced trust and social proof value

**Fix:** Use real testimonials with photos (or remove section until available).

---

## Heuristic Coverage Summary

| Heuristic | Issues Found |
|-----------|--------------|
| H1 - Visibility of System Status | 2 |
| H2 - Match Between System and Real World | 3 |
| H3 - User Control and Freedom | 1 |
| H4 - Consistency and Standards | 4 |
| H5 - Error Prevention | 1 |
| H6 - Recognition Rather Than Recall | 2 |
| H7 - Flexibility and Efficiency of Use | 4 |
| H8 - Aesthetic and Minimalist Design | 2 |
| H9 - Help Users Recognize and Recover | 1 |
| H10 - Help and Documentation | 1 |
| Accessibility | 2 |

---

## Priority Implementation Roadmap

### Immediate (This Week)
1. UX-001: Fix footer placeholder links
2. UX-002: Handle "Watch Demo" button
3. UX-003: Preserve email on login error
4. UX-007: Connect pricing buttons to signup

### Short-term (Next 2 Weeks)
5. UX-004: Fix mobile menu backdrop
6. UX-005: Make courses browsable without login
7. UX-008: Fix chat widget mobile positioning
8. UX-009: Add page transition loading indicator

### Medium-term (Next Month)
9. UX-006: Typography and color refresh
10. UX-010: Add bottom navigation in activities
11. UX-011: Enhanced empty states
12. UX-013: Accessible dropdown menus

### Backlog
- All P2 and P3 issues

---

*End of UX Review Report*

