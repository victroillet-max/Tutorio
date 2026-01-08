# Originality Analysis: Flagged Items
## Financial Accounting Course QA

**Analysis Date:** January 7, 2026
**Status:** CRITICAL ISSUES IDENTIFIED
**Priority:** IMMEDIATE ACTION REQUIRED

---

## Executive Summary

| Severity | Count | Description |
|----------|-------|-------------|
| CRITICAL | 2 | Direct copy of company names from university exercises |
| HIGH | 0 | - |
| MEDIUM | 0 | - |
| LOW | 0 | - |

---

## Critical Findings

### FLAG OG-1: Wayne Enterprises Case Study

**Tutorio Activity:**
- **Title:** Cash Flow Statement Builder: Wayne Enterprises
- **Location:** Module 9 (Cash Flow Statement), Skill: cfs-categories
- **URL:** `/skills/cfs-categories/cfs-builder-wayne-enterprises`
- **Activity ID:** `fa900000-0000-0000-0009-000000000004`

**University Source Material:**
- **File:** `Wayne Enterprises Inc_2020.pdf`
- **Solution:** `Wayne Enterprises Inc Solution-2020.pdf`
- **Excel Template:** `CFS Wayne.xlsx`
- **Location:** `/LMS/Chap 12/Exercices CFS/`

**Evidence:**
```
University Files Found:
├── Wayne Enterprises Inc_2020.pdf
├── Wayne Enterprises Inc Solution-2020.pdf
└── CFS Wayne.xlsx
```

**Impact:** CRITICAL
- Direct intellectual property violation
- Students who used university material will recognize the exercise
- Could constitute academic dishonesty if used for grading
- Legal liability risk

**Recommendation:** 
- IMMEDIATE: Rename company to unique name (e.g., "Stark Industries", "Acme Corp", "Summit Holdings")
- Modify numerical data to differ from university version
- Create original scenario/company background

---

### FLAG OG-2: Spacely Sprockets Case Study

**Tutorio Activity:**
- **Title:** Activities referencing Spacely Sprockets
- **Location:** Module 9 (Cash Flow Statement)
- **Activity ID:** `fa900000-0000-0000-0009-000000000003` (Investing and Financing Activities)

**University Source Material:**
- **File:** `Spacely Sprockets Inc_2020.pdf`
- **Solution:** `Spacely Sprockets Inc. - solution -2020.pdf`
- **Excel Template:** `CFS Spacely Sprockets.xlsx`
- **Location:** `/LMS/Chap 12/Exercices CFS/`

**Evidence:**
```
University Files Found:
├── Spacely Sprockets Inc_2020.pdf
├── Spacely Sprockets Inc. - solution -2020.pdf
└── CFS Spacely Sprockets.xlsx
```

**Impact:** CRITICAL
- Same concerns as FLAG OG-1
- "Spacely Sprockets" is a reference to The Jetsons cartoon
- May be commonly used example, but still problematic

**Recommendation:**
- IMMEDIATE: Rename company to unique name
- Modify numerical data
- Create original scenario

---

## Other University Company Names (For Reference)

The following company names appear in university exercises but were NOT found in Tutorio course:

| Company Name | University File | Tutorio Status |
|--------------|-----------------|----------------|
| Almost Holidays Inc | Almost Holidays Inc_2020.pdf | NOT FOUND |
| Roger Murdock Inc | Roger Murdock Inc_2020.pdf | NOT FOUND |
| Carmabar | Carmabar - solution.pdf | NOT FOUND |
| Haribo | Haribo - students.pdf | NOT FOUND |
| Lindt | Lindt Case study.pdf | NOT FOUND |
| Venkman | Chap2 - Venkman - exercise.pdf | NOT FOUND |
| Bushwood | Bushwood - students.pdf | NOT FOUND |
| Cunningham | Cunningham - students.pdf | NOT FOUND |
| Playa | Playa - Students.pdf | NOT FOUND |

---

## Tutorio Original Company Names (VERIFIED SAFE)

The following company names appear in Tutorio but were NOT found in university material:

| Company Name | Tutorio Activity | Status |
|--------------|------------------|--------|
| Phantom Studios | Journal Entry Practice | SAFE - Original |
| Luxe Maison Group | Case Study (Module 3) | SAFE - Original |
| Coastal Resorts | Case Study (Module 4) | SAFE - Original |
| Summit Consulting | Case Study (Module 4) | SAFE - Original |

---

## Action Items

### Immediate (Before Next Release)

1. **RENAME Wayne Enterprises**
   - Database: Update `activities.content` JSON
   - Change all references to unique company name
   - Update financial data to differ from source

2. **RENAME Spacely Sprockets**
   - Same process as above
   - Verify no other references exist

3. **Audit All Module 9 Content**
   - Review all CFS activities for additional copied material
   - Compare numerical data with university templates

### Short-term (Within 1 Week)

4. **Content Comparison Script**
   - Create automated tool to compare activity text with reference PDFs
   - Flag any significant text overlap

5. **Document Originality Policy**
   - Establish guidelines for case study creation
   - Require originality verification for all fictional companies

### Long-term

6. **Reference Material Database**
   - Maintain list of university company names to avoid
   - Cross-reference before publishing new content

---

## Verification Method

1. Listed university reference files in `/LMS/Chap 12/Exercices CFS/`
2. Compared company names with Tutorio activity titles in database migrations
3. Confirmed exact match of company names: Wayne Enterprises, Spacely Sprockets
4. Cross-referenced with browser testing of live activities

---

## Sign-off Required

| Role | Name | Signature | Date |
|------|------|-----------|------|
| QA Lead | | | |
| Content Manager | | | |
| Course Developer | | | |
| Legal Review | | | |

---

## Appendix: File Hashes (For Evidence)

University Source Files:
```
/LMS/Chap 12/Exercices CFS/Wayne Enterprises Inc_2020.pdf
/LMS/Chap 12/Exercices CFS/Wayne Enterprises Inc Solution-2020.pdf
/LMS/Chap 12/Exercices CFS/CFS Wayne.xlsx
/LMS/Chap 12/Exercices CFS/Spacely Sprockets Inc_2020.pdf
/LMS/Chap 12/Exercices CFS/Spacely Sprockets Inc. - solution -2020.pdf
/LMS/Chap 12/Exercices CFS/CFS Spacely Sprockets.xlsx
```

Tutorio Database Entries:
```sql
-- Activity ID: fa900000-0000-0000-0009-000000000003
-- Title: "Investing and Financing Activities" (contains Spacely Sprockets)

-- Activity ID: fa900000-0000-0000-0009-000000000004  
-- Title: "CFS Case Study: Wayne Enterprises"
```
