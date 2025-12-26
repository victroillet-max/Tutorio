---
name: Tutorio Platform Build
overview: Build a full-stack online tutoring platform for Swiss business school students using Next.js 14, Supabase (auth, database, storage), and Stripe for subscription payments. The platform features a freemium model with two subscription tiers and a complete admin dashboard.
todos:
  - id: setup-project
    content: Initialize Next.js 14 project with Tailwind CSS and shadcn/ui components
    status: completed
  - id: setup-supabase
    content: Configure Supabase project with database schema and authentication
    status: pending
  - id: build-auth
    content: Implement authentication pages (login, signup, password reset)
    status: pending
    dependencies:
      - setup-supabase
  - id: build-landing
    content: Create landing page with hero, features, and pricing sections
    status: completed
  - id: build-catalog
    content: Build course catalog with filtering and search functionality
    status: pending
    dependencies:
      - setup-supabase
  - id: build-course-detail
    content: Create course detail page with curriculum and free preview access
    status: pending
    dependencies:
      - build-catalog
  - id: integrate-stripe
    content: Set up Stripe with subscription products and checkout flow
    status: pending
    dependencies:
      - build-auth
  - id: build-lesson-viewer
    content: Implement lesson viewer with content, video, and exercise components
    status: pending
    dependencies:
      - build-course-detail
      - integrate-stripe
  - id: build-admin-dashboard
    content: Create admin dashboard with course and lesson management
    status: pending
    dependencies:
      - setup-supabase
  - id: add-media-upload
    content: Implement media upload for videos and podcasts via Supabase Storage
    status: pending
    dependencies:
      - build-admin-dashboard
  - id: polish-and-deploy
    content: Final polish, responsive design, SEO, and deployment setup
    status: pending
    dependencies:
      - build-lesson-viewer
      - build-admin-dashboard
---

# Tutorio - Online Tutoring Platform

## Architecture Overview

```mermaid
flowchart TB
    subgraph frontend [Frontend - Next.js 14]
        Landing[Landing Page]
        Catalog[Course Catalog]
        CourseDetail[Course Detail]
        Lessons[Lesson Viewer]
        Auth[Auth Pages]
        Checkout[Checkout Flow]
        Admin[Admin Dashboard]
    end
    
    subgraph backend [Backend Services]
        SupabaseAuth[Supabase Auth]
        SupabaseDB[(Supabase PostgreSQL)]
        SupabaseStorage[Supabase Storage]
        StripeAPI[Stripe API]
    end
    
    Landing --> Catalog
    Catalog --> CourseDetail
    CourseDetail --> Auth
    Auth --> SupabaseAuth
    CourseDetail --> Checkout
    Checkout --> StripeAPI
    Lessons --> SupabaseDB
    Lessons --> SupabaseStorage
    Admin --> SupabaseDB
```



## Tech Stack

| Layer | Technology ||-------|------------|| Framework | Next.js 14 (App Router) || Styling | Tailwind CSS + shadcn/ui components || Database | Supabase (PostgreSQL) || Authentication | Supabase Auth || File Storage | Supabase Storage (videos, podcasts, PDFs) || Payments | Stripe (Subscriptions + Checkout) || Deployment | Vercel (recommended) |

## Database Schema

```mermaid
erDiagram
    users ||--o{ subscriptions : has
    users ||--o{ course_progress : tracks
    courses ||--o{ lessons : contains
    courses }o--|| categories : belongs_to
    lessons ||--o{ course_progress : tracked_in
    subscriptions }o--|| subscription_tiers : references
    
    users {
        uuid id PK
        string email
        string full_name
        string avatar_url
        enum role
        timestamp created_at
    }
    
    courses {
        uuid id PK
        string title
        string slug
        text description
        string thumbnail_url
        uuid category_id FK
        enum tier_required
        boolean is_published
        timestamp created_at
    }
    
    lessons {
        uuid id PK
        uuid course_id FK
        string title
        text content_text
        string video_url
        string podcast_url
        jsonb exercises
        int order_index
        boolean is_free_preview
    }
    
    subscription_tiers {
        uuid id PK
        string name
        decimal price_chf
        string stripe_price_id
        jsonb features
    }
    
    subscriptions {
        uuid id PK
        uuid user_id FK
        uuid tier_id FK
        string stripe_subscription_id
        enum status
        timestamp current_period_end
    }
```



## Key Features Implementation

### 1. Authentication Flow

- Supabase Auth with email/password and magic link options
- Protected routes using Next.js middleware
- User profile management with role-based access (user/admin)

### 2. Landing Page and Course Catalog

- Hero section with value proposition
- Course grid with filtering by category
- Search functionality
- Pricing section showing both tiers (Basic: 10 CHF, Premium: 25 CHF)

### 3. Course Detail and Freemium Model

- Course overview with curriculum preview
- First lesson(s) marked as free preview
- Clear CTA to subscribe for full access
- Locked content indicators for premium lessons

### 4. Subscription and Payment Flow

- Stripe Checkout for seamless payment
- Webhook handlers for subscription events
- Automatic access management based on subscription status
- Support for both Basic and Premium tiers

### 5. Lesson Viewer

- Markdown/rich text content for lessons
- Embedded video player (for Premium tier)
- Audio player for podcasts (for Premium tier)
- Interactive exercises with answer checking
- Progress tracking

### 6. Admin Dashboard

- Course management (CRUD operations)
- Lesson editor with rich text and media uploads
- User management and subscription overview
- Analytics dashboard (subscribers, revenue, popular courses)

## Project Structure

```javascript
tutorio/
├── app/
│   ├── (auth)/
│   │   ├── login/
│   │   └── signup/
│   ├── (main)/
│   │   ├── courses/
│   │   │   ├── [slug]/
│   │   │   └── page.tsx
│   │   ├── lessons/
│   │   │   └── [id]/
│   │   └── pricing/
│   ├── (admin)/
│   │   └── admin/
│   │       ├── courses/
│   │       ├── users/
│   │       └── analytics/
│   ├── api/
│   │   ├── webhooks/
│   │   │   └── stripe/
│   │   └── checkout/
│   ├── layout.tsx
│   └── page.tsx
├── components/
│   ├── ui/
│   ├── courses/
│   ├── lessons/
│   └── admin/
├── lib/
│   ├── supabase/
│   ├── stripe/
│   └── utils/
├── types/
└── supabase/
    └── migrations/
```



## Implementation Phases

### Phase 1: Foundation

- Project setup with Next.js 14, Tailwind, shadcn/ui
- Supabase integration and database schema
- Authentication system
- Basic landing page

### Phase 2: Core Features

- Course catalog and detail pages
- Lesson viewer with free preview logic
- Stripe integration and checkout flow
- Subscription management

### Phase 3: Content and Admin

- Admin dashboard with course/lesson management
- Media upload functionality (videos, podcasts)
- Exercise builder
- Progress tracking

### Phase 4: Polish

- Responsive design refinements
- SEO optimization
- Performance optimization
- Analytics integration

## Legal Compliance Notes