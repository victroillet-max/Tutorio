"use client";

import { useState } from "react";
import Link from "next/link";
import {
  BookOpen,
  Play,
  Headphones,
  FileText,
  CheckCircle2,
  ArrowRight,
  Sparkles,
  Users,
  Clock,
  Shield,
  Star,
  ChevronRight,
  Menu,
  X,
  Zap,
  Target,
  TrendingUp,
  Award,
  Lock,
} from "lucide-react";

// Mock course data
const courses = [
  {
    id: 1,
    title: "Financial Accounting",
    category: "Accounting",
    lessons: 24,
    duration: 12,
    rating: 4.9,
    students: 1240,
    color: "blue",
    free: true,
  },
  {
    id: 2,
    title: "Marketing Strategy",
    category: "Marketing",
    lessons: 18,
    duration: 9,
    rating: 4.8,
    students: 980,
    color: "purple",
    free: false,
  },
  {
    id: 3,
    title: "Corporate Finance",
    category: "Finance",
    lessons: 32,
    duration: 16,
    rating: 4.9,
    students: 1560,
    color: "green",
    free: true,
  },
  {
    id: 4,
    title: "Business Law",
    category: "Law",
    lessons: 20,
    duration: 10,
    rating: 4.7,
    students: 720,
    color: "rose",
    free: false,
  },
  {
    id: 5,
    title: "Microeconomics",
    category: "Economics",
    lessons: 28,
    duration: 14,
    rating: 4.8,
    students: 1100,
    color: "cyan",
    free: true,
  },
  {
    id: 6,
    title: "Operations Management",
    category: "Management",
    lessons: 22,
    duration: 11,
    rating: 4.6,
    students: 850,
    color: "violet",
    free: false,
  },
];

// Max duration for progress bar calculation
const maxDuration = Math.max(...courses.map(c => c.duration));

const stats = [
  { value: "5,000+", label: "Active Students" },
  { value: "50+", label: "Courses" },
  { value: "95%", label: "Pass Rate" },
  { value: "4.9", label: "Avg. Rating" },
];

const features = [
  {
    icon: Sparkles,
    title: "AI-Powered Summaries",
    description: "Smart condensation of complex topics into digestible, exam-focused content.",
  },
  {
    icon: Target,
    title: "Exam-Focused Content",
    description: "Every lesson is structured to maximize your exam performance.",
  },
  {
    icon: Clock,
    title: "Learn at Your Pace",
    description: "Access content 24/7, study when and where it suits you best.",
  },
  {
    icon: TrendingUp,
    title: "Track Progress",
    description: "Monitor your learning journey with detailed analytics and insights.",
  },
];

const testimonials = [
  {
    name: "Marie L.",
    role: "HEC Lausanne Student",
    content: "Tutorio helped me pass my Financial Accounting exam with flying colors. The summaries are incredibly well-structured!",
    avatar: "ML",
    rating: 5,
  },
  {
    name: "Thomas B.",
    role: "HSG Student",
    content: "The premium videos are worth every franc. Complex concepts finally make sense.",
    avatar: "TB",
    rating: 5,
  },
  {
    name: "Sarah K.",
    role: "ZHAW Student",
    content: "I saved so much time with Tutorio. The exercises helped me identify my weak points quickly.",
    avatar: "SK",
    rating: 5,
  },
];

// Color mapping for category icons
const colorClasses: Record<string, { bg: string; text: string }> = {
  blue: { bg: "bg-blue-100", text: "text-blue-600" },
  purple: { bg: "bg-purple-100", text: "text-purple-600" },
  green: { bg: "bg-emerald-100", text: "text-emerald-600" },
  rose: { bg: "bg-rose-100", text: "text-rose-600" },
  cyan: { bg: "bg-cyan-100", text: "text-cyan-600" },
  violet: { bg: "bg-violet-100", text: "text-violet-600" },
};

// Navigation Component
function Navigation() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-white shadow-md border-b border-slate-200">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* Logo */}
          <div className="flex items-center gap-2">
            <div className="w-10 h-10 rounded-xl bg-[var(--primary)] flex items-center justify-center">
              <BookOpen className="w-5 h-5 text-white" />
            </div>
            <span className="text-xl font-bold tracking-tight text-slate-900" style={{ fontFamily: 'var(--font-heading)' }}>
              Tutorio
            </span>
          </div>

          {/* Desktop Navigation */}
          <div className="hidden md:flex items-center gap-8">
            <a href="#courses" className="text-slate-700 hover:text-[var(--primary)] transition-colors font-medium">
              Courses
            </a>
            <a href="#pricing" className="text-slate-700 hover:text-[var(--primary)] transition-colors font-medium">
              Pricing
            </a>
            <a href="#how-it-works" className="text-slate-700 hover:text-[var(--primary)] transition-colors font-medium">
              How It Works
            </a>
          </div>

          {/* CTA Buttons */}
          <div className="hidden md:flex items-center gap-4">
            <Link 
              href="/login" 
              className="px-4 py-2 text-sm text-slate-700 hover:text-[var(--primary)] transition-colors font-medium"
            >
              Sign In
            </Link>
            <Link 
              href="/signup"
              className="px-5 py-2.5 text-sm font-semibold bg-[var(--primary)] text-white rounded-lg hover:bg-[var(--primary-dark)] transition-colors shadow-sm"
            >
              Start Free
            </Link>
          </div>

          {/* Mobile Menu Button */}
          <button
            className="md:hidden p-2 text-slate-900"
            onClick={() => setIsOpen(!isOpen)}
          >
            {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      {isOpen && (
        <div className="md:hidden bg-white border-t border-slate-200">
          <div className="px-4 py-4 space-y-4">
            <a href="#courses" className="block text-slate-700 hover:text-[var(--primary)] font-medium">
              Courses
            </a>
            <a href="#pricing" className="block text-slate-700 hover:text-[var(--primary)] font-medium">
              Pricing
            </a>
            <a href="#how-it-works" className="block text-slate-700 hover:text-[var(--primary)] font-medium">
              How It Works
            </a>
            <div className="pt-4 border-t border-slate-200 space-y-3">
              <Link 
                href="/login" 
                className="block w-full px-4 py-2 text-sm text-center text-slate-700 hover:text-[var(--primary)] transition-colors font-medium"
              >
                Sign In
              </Link>
              <Link 
                href="/signup"
                className="block w-full px-4 py-2.5 text-sm font-semibold text-center bg-[var(--primary)] text-white rounded-lg hover:bg-[var(--primary-dark)]"
              >
                Start Free
              </Link>
            </div>
          </div>
        </div>
      )}
    </nav>
  );
}

// Hero Section
function HeroSection() {
  return (
    <section className="relative min-h-screen flex items-center justify-center pt-16 overflow-hidden bg-gradient-to-b from-[var(--background)] to-[var(--background-secondary)]">
      {/* Subtle Background Pattern */}
      <div className="absolute inset-0 opacity-[0.03]" style={{
        backgroundImage: `linear-gradient(var(--foreground) 1px, transparent 1px), linear-gradient(90deg, var(--foreground) 1px, transparent 1px)`,
        backgroundSize: '60px 60px'
      }} />

      {/* Decorative Elements */}
      <div className="absolute top-1/4 left-1/4 w-72 h-72 bg-[var(--primary)]/5 rounded-full blur-3xl animate-float" />
      <div className="absolute bottom-1/4 right-1/4 w-64 h-64 bg-[var(--primary)]/10 rounded-full blur-3xl animate-float animation-delay-300" />

      <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
        <div className="text-center max-w-4xl mx-auto">
          {/* Badge */}
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-[var(--progress-bg)] mb-8 animate-fade-in-up">
            <Sparkles className="w-4 h-4 text-[var(--primary)]" />
            <span className="text-sm text-[var(--primary)] font-medium">
              Made by Students, for Students
            </span>
          </div>

          {/* Main Heading */}
          <h1 
            className="text-5xl md:text-7xl font-bold tracking-tight mb-6 text-[var(--foreground)] animate-fade-in-up animation-delay-100"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Stop Overpaying
            <br />
            <span className="gradient-text">for Tutoring</span>
          </h1>

          {/* Subheading */}
          <p className="text-xl text-[var(--foreground-muted)] mb-10 max-w-2xl mx-auto animate-fade-in-up animation-delay-200">
            Why spend CHF 80+/hour on private tutors? Access quality course summaries, 
            exercises, and video lessons - all for a fraction of the cost. 
            Starting from just CHF 10/month.
          </p>

          {/* CTA Buttons */}
          <div className="flex flex-col sm:flex-row gap-4 justify-center items-center animate-fade-in-up animation-delay-300">
            <a
              href="#courses"
              className="group px-8 py-4 bg-[var(--primary)] text-white font-semibold rounded-xl hover:bg-[var(--primary-dark)] transition-all flex items-center gap-2 shadow-lg shadow-[var(--primary)]/25"
            >
              Browse Courses
              <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
            </a>
            <button className="px-8 py-4 bg-white border border-[var(--border)] rounded-xl font-medium text-[var(--foreground)] hover:border-[var(--primary)] hover:text-[var(--primary)] transition-colors flex items-center gap-2 shadow-sm">
              <Play className="w-5 h-5 text-[var(--primary)]" />
              Watch Demo
            </button>
          </div>

          {/* Trust Badges */}
          <div className="mt-16 flex flex-wrap justify-center gap-8 text-sm text-[var(--foreground-muted)] animate-fade-in-up animation-delay-400">
            <div className="flex items-center gap-2">
              <Shield className="w-5 h-5 text-[var(--primary)]" />
              <span>Secure Payments</span>
            </div>
            <div className="flex items-center gap-2">
              <Users className="w-5 h-5 text-[var(--primary)]" />
              <span>5,000+ Students</span>
            </div>
            <div className="flex items-center gap-2">
              <Award className="w-5 h-5 text-[var(--primary)]" />
              <span>95% Pass Rate</span>
            </div>
          </div>
        </div>

        {/* Stats Bar */}
        <div className="mt-20 grid grid-cols-2 md:grid-cols-4 gap-8 max-w-4xl mx-auto">
          {stats.map((stat, index) => (
            <div
              key={stat.label}
              className="text-center animate-fade-in-up"
              style={{ animationDelay: `${0.5 + index * 0.1}s` }}
            >
              <div className="text-3xl md:text-4xl font-bold gradient-text mb-1" style={{ fontFamily: 'var(--font-heading)' }}>
                {stat.value}
              </div>
              <div className="text-sm text-[var(--foreground-muted)]">{stat.label}</div>
            </div>
          ))}
        </div>
      </div>

      {/* Scroll Indicator */}
      <div className="absolute bottom-8 left-1/2 -translate-x-1/2 animate-bounce">
        <div className="w-6 h-10 rounded-full border-2 border-[var(--border)] flex items-start justify-center p-2">
          <div className="w-1.5 h-3 bg-[var(--primary)] rounded-full" />
        </div>
      </div>
    </section>
  );
}

// Duration Bar Component
function DurationBar({ duration, maxDuration }: { duration: number; maxDuration: number }) {
  const percentage = (duration / maxDuration) * 100;
  
  return (
    <div className="duration-bar">
      <div className="duration-bar-track">
        <div 
          className="duration-bar-fill" 
          style={{ width: `${percentage}%` }}
        />
      </div>
      <span className="duration-bar-label">{duration}h</span>
    </div>
  );
}

// Course Card Component
function CourseCard({ course, index }: { course: typeof courses[0]; index: number }) {
  const colors = colorClasses[course.color] || colorClasses.blue;
  
  return (
    <div
      className="group card-elevated p-6 hover:scale-[1.02] transition-all duration-300 cursor-pointer animate-fade-in-up"
      style={{ animationDelay: `${index * 0.1}s` }}
    >
      {/* Free Badge */}
      {course.free && (
        <div className="absolute top-4 right-4 badge-success flex items-center gap-1">
          <Zap className="w-3 h-3" />
          Free Preview
        </div>
      )}

      {/* Icon */}
      <div className={`w-14 h-14 rounded-2xl ${colors.bg} flex items-center justify-center mb-4`}>
        <BookOpen className={`w-6 h-6 ${colors.text}`} />
      </div>

      {/* Category */}
      <div className="text-xs text-[var(--primary)] font-medium uppercase tracking-wider mb-2">
        {course.category}
      </div>

      {/* Title */}
      <h3 className="text-xl font-semibold mb-3 text-[var(--foreground)] group-hover:text-[var(--primary)] transition-colors" style={{ fontFamily: 'var(--font-heading)' }}>
        {course.title}
      </h3>

      {/* Duration Bar */}
      <div className="mb-4">
        <DurationBar duration={course.duration} maxDuration={maxDuration} />
      </div>

      {/* Meta Info */}
      <div className="flex items-center gap-4 text-sm text-[var(--foreground-muted)] mb-4">
        <span className="flex items-center gap-1">
          <BookOpen className="w-4 h-4" />
          {course.lessons} lessons
        </span>
      </div>

      {/* Rating & Students */}
      <div className="flex items-center justify-between pt-4 border-t border-[var(--border)]">
        <div className="flex items-center gap-1">
          <Star className="w-4 h-4 text-amber-500 fill-amber-500" />
          <span className="font-medium text-[var(--foreground)]">{course.rating}</span>
          <span className="text-[var(--foreground-muted)]">({course.students.toLocaleString()})</span>
        </div>
        <ChevronRight className="w-5 h-5 text-[var(--foreground-muted)] group-hover:text-[var(--primary)] group-hover:translate-x-1 transition-all" />
      </div>
    </div>
  );
}

// Courses Section
function CoursesSection() {
  return (
    <section id="courses" className="py-24 relative bg-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-[var(--progress-bg)] mb-6">
            <BookOpen className="w-4 h-4 text-[var(--primary)]" />
            <span className="text-sm text-[var(--primary)] font-medium">Popular Courses</span>
          </div>
          <h2 className="text-4xl md:text-5xl font-bold mb-6 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
            Explore Our <span className="gradient-text">Course Library</span>
          </h2>
          <p className="text-[var(--foreground-muted)] text-lg">
            Comprehensive coverage of core business school subjects, structured for maximum retention and exam success.
          </p>
        </div>

        {/* Course Grid */}
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {courses.map((course, index) => (
            <CourseCard key={course.id} course={course} index={index} />
          ))}
        </div>

        {/* View All CTA */}
        <div className="text-center mt-12">
          <Link href="/courses" className="group px-8 py-4 bg-white border border-[var(--border)] rounded-xl font-medium text-[var(--foreground)] hover:border-[var(--primary)] hover:text-[var(--primary)] transition-colors inline-flex items-center gap-2 shadow-sm">
            View All 50+ Courses
            <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
          </Link>
        </div>
      </div>
    </section>
  );
}

// How It Works Section
function HowItWorksSection() {
  const steps = [
    {
      step: "01",
      title: "Choose Your Course",
      description: "Browse our library and select the courses you need. Preview content for free before committing.",
      icon: BookOpen,
    },
    {
      step: "02",
      title: "Sign Up & Subscribe",
      description: "Create your account and choose a plan that fits your needs. Cancel anytime.",
      icon: Users,
    },
    {
      step: "03",
      title: "Learn & Practice",
      description: "Access AI-structured content, videos, and exercises. Track your progress as you learn.",
      icon: Target,
    },
    {
      step: "04",
      title: "Ace Your Exams",
      description: "Apply your knowledge with confidence. Join thousands of successful students.",
      icon: Award,
    },
  ];

  return (
    <section id="how-it-works" className="py-24 relative section-alt">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-[var(--progress-bg)] mb-6">
            <Sparkles className="w-4 h-4 text-[var(--primary)]" />
            <span className="text-sm text-[var(--primary)] font-medium">How It Works</span>
          </div>
          <h2 className="text-4xl md:text-5xl font-bold mb-6 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
            Start Learning in <span className="gradient-text">4 Simple Steps</span>
          </h2>
        </div>

        {/* Steps Grid */}
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          {steps.map((step, index) => (
            <div
              key={step.step}
              className="relative animate-fade-in-up"
              style={{ animationDelay: `${index * 0.15}s` }}
            >
              {/* Connector Line */}
              {index < steps.length - 1 && (
                <div className="hidden lg:block absolute top-12 left-[60%] w-full h-0.5 bg-gradient-to-r from-[var(--primary)]/30 to-transparent" />
              )}

              {/* Step Number */}
              <div className="text-6xl font-bold text-[var(--primary)]/10 mb-4" style={{ fontFamily: 'var(--font-heading)' }}>
                {step.step}
              </div>

              {/* Icon */}
              <div className="w-12 h-12 rounded-xl bg-[var(--primary)] flex items-center justify-center mb-4 shadow-lg shadow-[var(--primary)]/25">
                <step.icon className="w-6 h-6 text-white" />
              </div>

              {/* Content */}
              <h3 className="text-xl font-semibold mb-2 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
                {step.title}
              </h3>
              <p className="text-[var(--foreground-muted)]">
                {step.description}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

// Features Section
function FeaturesSection() {
  return (
    <section className="py-24 relative bg-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid lg:grid-cols-2 gap-16 items-center">
          {/* Left Content */}
          <div className="animate-slide-in-left">
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-[var(--progress-bg)] mb-6">
              <Zap className="w-4 h-4 text-[var(--primary)]" />
              <span className="text-sm text-[var(--primary)] font-medium">Why Tutorio</span>
            </div>
            <h2 className="text-4xl md:text-5xl font-bold mb-6 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
              Learn Smarter,
              <br />
              <span className="gradient-text">Not Harder</span>
            </h2>
            <p className="text-[var(--foreground-muted)] text-lg mb-8">
              Our AI-powered platform restructures complex business concepts into clear, 
              exam-focused content. No more wading through endless lecture notes.
            </p>

            <div className="space-y-6">
              {features.map((feature) => (
                <div key={feature.title} className="flex gap-4">
                  <div className="flex-shrink-0 icon-container icon-container-primary">
                    <feature.icon className="w-6 h-6" />
                  </div>
                  <div>
                    <h3 className="font-semibold mb-1 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
                      {feature.title}
                    </h3>
                    <p className="text-[var(--foreground-muted)] text-sm">
                      {feature.description}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Right Content - Visual */}
          <div className="relative animate-slide-in-right">
            <div className="absolute inset-0 bg-gradient-to-br from-[var(--primary)]/10 to-[var(--primary)]/5 rounded-3xl blur-3xl" />
            <div className="relative card-elevated rounded-3xl p-8">
              {/* Mock Lesson Preview */}
              <div className="bg-[var(--background-secondary)] rounded-2xl p-6 mb-6">
                <div className="flex items-center gap-3 mb-4">
                  <div className="w-10 h-10 rounded-xl bg-blue-100 flex items-center justify-center">
                    <BookOpen className="w-5 h-5 text-blue-600" />
                  </div>
                  <div>
                    <div className="font-semibold text-sm text-[var(--foreground)]">Financial Accounting</div>
                    <div className="text-xs text-[var(--foreground-muted)]">Lesson 3: Balance Sheets</div>
                  </div>
                </div>
                
                {/* Progress Bar */}
                <div className="mb-4">
                  <div className="flex justify-between text-xs text-[var(--foreground-muted)] mb-1">
                    <span>Progress</span>
                    <span>65%</span>
                  </div>
                  <div className="progress-bar">
                    <div className="progress-bar-fill" style={{ width: '65%' }} />
                  </div>
                </div>

                {/* Content Types */}
                <div className="grid grid-cols-3 gap-3">
                  <div className="p-3 rounded-xl bg-white text-center shadow-sm">
                    <FileText className="w-5 h-5 mx-auto mb-1 text-[var(--primary)]" />
                    <div className="text-xs text-[var(--foreground-muted)]">Summary</div>
                  </div>
                  <div className="p-3 rounded-xl bg-white text-center shadow-sm">
                    <Play className="w-5 h-5 mx-auto mb-1 text-[var(--primary)]" />
                    <div className="text-xs text-[var(--foreground-muted)]">Video</div>
                  </div>
                  <div className="p-3 rounded-xl bg-white text-center shadow-sm">
                    <Headphones className="w-5 h-5 mx-auto mb-1 text-[var(--primary)]" />
                    <div className="text-xs text-[var(--foreground-muted)]">Podcast</div>
                  </div>
                </div>
              </div>

              {/* Mini Stats */}
              <div className="grid grid-cols-2 gap-4">
                <div className="bg-[var(--background-secondary)] rounded-xl p-4">
                  <div className="text-2xl font-bold gradient-text mb-1">12</div>
                  <div className="text-xs text-[var(--foreground-muted)]">Exercises Completed</div>
                </div>
                <div className="bg-[var(--background-secondary)] rounded-xl p-4">
                  <div className="text-2xl font-bold gradient-text mb-1">4.2h</div>
                  <div className="text-xs text-[var(--foreground-muted)]">Study Time</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

// Pricing Section
function PricingSection() {
  const plans = [
    {
      name: "Basic",
      price: "10",
      description: "Perfect for self-starters who prefer reading",
      features: [
        "AI-structured text summaries",
        "Practice exercises with solutions",
        "Progress tracking",
        "Access to all courses",
        "Mobile-friendly access",
      ],
      notIncluded: [
        "Video lessons",
        "Audio podcasts",
        "Priority support",
      ],
      popular: false,
    },
    {
      name: "Premium",
      price: "25",
      description: "The complete learning experience",
      features: [
        "Everything in Basic",
        "HD Video lessons",
        "Audio podcasts for on-the-go",
        "Downloadable resources",
        "Priority support",
        "Exam simulations",
      ],
      notIncluded: [],
      popular: true,
    },
  ];

  return (
    <section id="pricing" className="py-24 relative section-alt">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-[var(--progress-bg)] mb-6">
            <Sparkles className="w-4 h-4 text-[var(--primary)]" />
            <span className="text-sm text-[var(--primary)] font-medium">Simple Pricing</span>
          </div>
          <h2 className="text-4xl md:text-5xl font-bold mb-6 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
            Choose Your <span className="gradient-text">Learning Path</span>
          </h2>
          <p className="text-[var(--foreground-muted)] text-lg">
            Start with a free preview on any course. No credit card required.
          </p>
        </div>

        {/* Pricing Cards */}
        <div className="grid md:grid-cols-2 gap-8 max-w-4xl mx-auto">
          {plans.map((plan, index) => (
            <div
              key={plan.name}
              className={`relative rounded-3xl p-8 animate-fade-in-up ${
                plan.popular
                  ? "bg-white border-2 border-[var(--primary)] shadow-xl shadow-[var(--primary)]/10"
                  : "bg-white border border-[var(--border)] shadow-sm"
              }`}
              style={{ animationDelay: `${index * 0.15}s` }}
            >
              {/* Popular Badge */}
              {plan.popular && (
                <div className="absolute -top-4 left-1/2 -translate-x-1/2 px-4 py-1 bg-[var(--primary)] text-white text-sm font-medium rounded-full">
                  Most Popular
                </div>
              )}

              {/* Plan Name */}
              <h3 className="text-2xl font-bold mb-2 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
                {plan.name}
              </h3>
              <p className="text-[var(--foreground-muted)] text-sm mb-6">
                {plan.description}
              </p>

              {/* Price */}
              <div className="flex items-baseline gap-1 mb-8">
                <span className="text-sm text-[var(--foreground-muted)]">CHF</span>
                <span className="text-5xl font-bold gradient-text" style={{ fontFamily: 'var(--font-heading)' }}>
                  {plan.price}
                </span>
                <span className="text-[var(--foreground-muted)]">/month</span>
              </div>

              {/* CTA Button */}
              <button
                className={`w-full py-4 rounded-xl font-semibold mb-8 transition-all ${
                  plan.popular
                    ? "bg-[var(--primary)] text-white hover:bg-[var(--primary-dark)] shadow-lg shadow-[var(--primary)]/25"
                    : "bg-[var(--background-secondary)] text-[var(--foreground)] hover:bg-[var(--background-tertiary)]"
                }`}
              >
                Get Started
              </button>

              {/* Features */}
              <div className="space-y-4">
                {plan.features.map((feature) => (
                  <div key={feature} className="flex items-center gap-3">
                    <CheckCircle2 className="w-5 h-5 text-[var(--success)] flex-shrink-0" />
                    <span className="text-sm text-[var(--foreground)]">{feature}</span>
                  </div>
                ))}
                {plan.notIncluded.map((feature) => (
                  <div key={feature} className="flex items-center gap-3 opacity-50">
                    <Lock className="w-5 h-5 flex-shrink-0 text-[var(--foreground-muted)]" />
                    <span className="text-sm text-[var(--foreground-muted)]">{feature}</span>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>

        {/* Money Back Guarantee */}
        <div className="text-center mt-12">
          <div className="inline-flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
            <Shield className="w-5 h-5 text-[var(--primary)]" />
            <span>7-day money-back guarantee. Cancel anytime.</span>
          </div>
        </div>
      </div>
    </section>
  );
}

// Testimonials Section
function TestimonialsSection() {
  return (
    <section className="py-24 relative bg-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-[var(--progress-bg)] mb-6">
            <Star className="w-4 h-4 text-[var(--primary)]" />
            <span className="text-sm text-[var(--primary)] font-medium">Testimonials</span>
          </div>
          <h2 className="text-4xl md:text-5xl font-bold mb-6 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
            Loved by <span className="gradient-text">Students</span>
          </h2>
        </div>

        {/* Testimonials Grid */}
        <div className="grid md:grid-cols-3 gap-8">
          {testimonials.map((testimonial, index) => (
            <div
              key={testimonial.name}
              className="card-elevated p-6 animate-fade-in-up"
              style={{ animationDelay: `${index * 0.1}s` }}
            >
              {/* Stars */}
              <div className="flex gap-1 mb-4">
                {[...Array(testimonial.rating)].map((_, i) => (
                  <Star key={i} className="w-4 h-4 text-amber-500 fill-amber-500" />
                ))}
              </div>

              {/* Content */}
              <p className="text-[var(--foreground-muted)] mb-6 leading-relaxed">
                &ldquo;{testimonial.content}&rdquo;
              </p>

              {/* Author */}
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-[var(--primary)] flex items-center justify-center text-white font-semibold text-sm">
                  {testimonial.avatar}
                </div>
                <div>
                  <div className="font-semibold text-sm text-[var(--foreground)]">{testimonial.name}</div>
                  <div className="text-xs text-[var(--foreground-muted)]">{testimonial.role}</div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

// CTA Section
function CTASection() {
  return (
    <section className="py-24 relative overflow-hidden bg-gradient-to-br from-[var(--primary)] to-[var(--primary-dark)]">
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-white/10 rounded-full blur-3xl" />

      <div className="relative max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <h2 className="text-4xl md:text-6xl font-bold mb-6 text-white" style={{ fontFamily: 'var(--font-heading)' }}>
          Ready to Excel?
        </h2>
        <p className="text-xl text-white/80 mb-10 max-w-2xl mx-auto">
          Join thousands of students who are saving money while studying smarter.
          Start with a free preview today.
        </p>
        <div className="flex flex-col sm:flex-row gap-4 justify-center">
          <Link href="/signup" className="group px-8 py-4 bg-white text-[var(--primary)] font-semibold rounded-xl hover:bg-white/90 transition-all flex items-center justify-center gap-2 shadow-lg">
            Start Learning Free
            <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
          </Link>
          <Link href="/courses" className="px-8 py-4 bg-white/10 backdrop-blur-sm border border-white/20 text-white rounded-xl font-medium hover:bg-white/20 transition-colors">
            View All Courses
          </Link>
        </div>
      </div>
    </section>
  );
}

// Footer
function Footer() {
  return (
    <footer className="py-16 border-t border-[var(--border)] bg-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid md:grid-cols-4 gap-12 mb-12">
          {/* Brand */}
          <div className="md:col-span-2">
            <div className="flex items-center gap-2 mb-4">
              <div className="w-10 h-10 rounded-xl bg-[var(--primary)] flex items-center justify-center">
                <BookOpen className="w-5 h-5 text-white" />
              </div>
              <span className="text-xl font-bold tracking-tight text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
                Tutorio
              </span>
            </div>
            <p className="text-[var(--foreground-muted)] max-w-sm mb-6">
              Quality tutoring content at a fraction of the cost. Stop overpaying for private lessons.
            </p>
            <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
              <Shield className="w-4 h-4 text-[var(--primary)]" />
              <span>Swiss Data Protection Compliant</span>
            </div>
          </div>

          {/* Links */}
          <div>
            <h4 className="font-semibold mb-4 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>Platform</h4>
            <ul className="space-y-3 text-sm text-[var(--foreground-muted)]">
              <li><a href="#" className="hover:text-[var(--primary)] transition-colors">Courses</a></li>
              <li><a href="#" className="hover:text-[var(--primary)] transition-colors">Pricing</a></li>
              <li><a href="#" className="hover:text-[var(--primary)] transition-colors">How It Works</a></li>
              <li><a href="#" className="hover:text-[var(--primary)] transition-colors">FAQ</a></li>
            </ul>
          </div>

          <div>
            <h4 className="font-semibold mb-4 text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>Legal</h4>
            <ul className="space-y-3 text-sm text-[var(--foreground-muted)]">
              <li><a href="#" className="hover:text-[var(--primary)] transition-colors">Privacy Policy</a></li>
              <li><a href="#" className="hover:text-[var(--primary)] transition-colors">Terms of Service</a></li>
              <li><a href="#" className="hover:text-[var(--primary)] transition-colors">Cookie Policy</a></li>
              <li><a href="#" className="hover:text-[var(--primary)] transition-colors">Contact</a></li>
            </ul>
          </div>
        </div>

        {/* Bottom */}
        <div className="pt-8 border-t border-[var(--border)] flex flex-col md:flex-row justify-between items-center gap-4 text-sm text-[var(--foreground-muted)]">
          <p>&copy; {new Date().getFullYear()} Tutorio. All rights reserved.</p>
          <p>Made by Students, for Students in Switzerland</p>
        </div>
      </div>
    </footer>
  );
}

// Main Page Component
export default function Home() {
  return (
    <main className="min-h-screen bg-white">
      <Navigation />
      <HeroSection />
      <CoursesSection />
      <HowItWorksSection />
      <FeaturesSection />
      <PricingSection />
      <TestimonialsSection />
      <CTASection />
      <Footer />
    </main>
  );
}
