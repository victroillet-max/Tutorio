"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import {
  BookOpen,
  Play,
  ArrowRight,
  Sparkles,
  Clock,
  Star,
  Menu,
  X,
  Zap,
  Target,
  GraduationCap,
  Brain,
  Calculator,
  Trophy,
  Flame,
  Check,
  BarChart3,
  CreditCard,
} from "lucide-react";

// Course data with accent colors - Actual courses in the system
const courses = [
  {
    id: 1,
    slug: "financial-accounting",
    title: "Financial Accounting Fundamentals",
    category: "Business & Accounting",
    lessons: 45,
    duration: 45,
    rating: 4.9,
    students: 1240,
    accent: "coral",
    icon: Calculator,
    free: true,
    description: "Master financial statements, accounting principles, and analysis techniques through interactive exercises.",
  },
  {
    id: 2,
    slug: "computational-thinking",
    title: "Computational Thinking",
    category: "Computer Science",
    lessons: 32,
    duration: 25,
    rating: 4.8,
    students: 980,
    accent: "teal",
    icon: Brain,
    free: true,
    description: "Learn problem-solving and Python programming through decomposition, pattern recognition, and abstraction.",
  },
];

// Stats
const stats = [
  { value: "50", suffix: "+", label: "Students" },
  { value: "24", suffix: "/7", label: "Access" },
  { value: "100", suffix: "+", label: "Skills to Master" },
  { value: "CHF ", suffix: "10", label: "From/month" },
];

const features = [
  {
    icon: Sparkles,
    title: "AI-Powered Summaries",
    description: "Smart condensation of complex topics into digestible, exam-focused content.",
    color: "primary",
  },
  {
    icon: Target,
    title: "Exam-Focused Content",
    description: "Every lesson is structured to maximize your exam performance.",
    color: "accent",
  },
  {
    icon: Clock,
    title: "Learn at Your Pace",
    description: "Access content 24/7, study when and where it suits you best.",
    color: "success",
  },
  {
    icon: BarChart3,
    title: "Track Progress",
    description: "Monitor your learning journey with detailed analytics and insights.",
    color: "gold",
  },
];

// Accent color classes
const accentClasses: Record<string, { icon: string; badge: string; border: string }> = {
  coral: { 
    icon: "icon-gradient-coral", 
    badge: "bg-[#e76f51]/10 text-[#e76f51] border-[#e76f51]",
    border: "card-accent-coral"
  },
  teal: { 
    icon: "icon-gradient-teal", 
    badge: "bg-[#2a9d8f]/10 text-[#2a9d8f] border-[#2a9d8f]",
    border: "card-accent-teal"
  },
  gold: { 
    icon: "icon-gradient-gold", 
    badge: "bg-[#e9c46a]/20 text-[#b8860b] border-[#e9c46a]",
    border: "card-accent-gold"
  },
  navy: { 
    icon: "icon-gradient-navy", 
    badge: "bg-[#1e3a5f]/10 text-[#1e3a5f] border-[#1e3a5f]",
    border: "card-accent-navy"
  },
  purple: { 
    icon: "icon-gradient-purple", 
    badge: "bg-[#7c3aed]/10 text-[#7c3aed] border-[#7c3aed]",
    border: "card-accent-purple"
  },
  rose: { 
    icon: "icon-gradient-rose", 
    badge: "bg-[#f43f5e]/10 text-[#f43f5e] border-[#f43f5e]",
    border: "card-accent-rose"
  },
};

const featureColorClasses: Record<string, string> = {
  primary: "bg-[var(--progress-bg)] text-[var(--primary)]",
  accent: "bg-[#e76f51]/10 text-[var(--accent)]",
  success: "bg-[var(--success-light)] text-[var(--success)]",
  gold: "bg-[#e9c46a]/20 text-[#b8860b]",
};

// Navigation Component
function Navigation() {
  const [isOpen, setIsOpen] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 50);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  const handleNavClick = () => setIsOpen(false);

  useEffect(() => {
    if (isOpen) {
      document.body.classList.add('menu-open');
    } else {
      document.body.classList.remove('menu-open');
    }
    return () => {
      document.body.classList.remove('menu-open');
    };
  }, [isOpen]);

  return (
    <>
      {isOpen && (
        <div 
          className="fixed inset-0 bg-black/50 z-40 md:hidden"
          onClick={() => setIsOpen(false)}
          aria-hidden="true"
        />
      )}
      
      <nav className={`fixed top-0 left-0 right-0 z-50 py-4 transition-all duration-300 ${
        isScrolled 
          ? "bg-white/95 backdrop-blur-xl border-b border-[var(--card-border)]" 
          : "bg-[var(--background)]/80 backdrop-blur-xl border-b border-transparent"
      }`}>
        <div className="max-w-7xl mx-auto px-6">
          <div className="flex items-center justify-between">
            {/* Logo */}
            <Link href="/" className="flex items-center gap-3 group">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img 
                src="/logo-cropped.svg" 
                alt="Tutorio" 
                className="w-11 h-11 transition-transform duration-300 group-hover:rotate-[-5deg] group-hover:scale-105"
              />
              <span 
                className="text-2xl font-bold tracking-tight text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
              >
                Tutorio
              </span>
            </Link>

            {/* Desktop Navigation */}
            <div className="hidden md:flex items-center gap-2">
              <a href="#courses" className="nav-link-animated">
                Courses
              </a>
              <a href="#features" className="nav-link-animated">
                Features
              </a>
              <a href="#pricing" className="nav-link-animated">
                Pricing
              </a>
            </div>

            {/* CTA Buttons */}
            <div className="hidden md:flex items-center gap-3">
              <Link 
                href="/login" 
                className="px-5 py-2.5 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] hover:bg-[var(--background-secondary)] rounded-xl transition-all font-medium"
              >
                Sign In
              </Link>
              <Link 
                href="/signup"
                className="px-6 py-3 text-sm font-semibold bg-[var(--primary)] text-white rounded-xl hover:bg-[var(--primary-light)] transition-all shadow-md shadow-[var(--primary)]/25 hover:shadow-lg hover:-translate-y-0.5"
              >
                Start Free
              </Link>
            </div>

            {/* Mobile Menu Button */}
            <button
              className="md:hidden p-2 text-[var(--foreground)]"
              onClick={() => setIsOpen(!isOpen)}
              aria-label={isOpen ? "Close menu" : "Open menu"}
              aria-expanded={isOpen}
            >
              {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
            </button>
          </div>
        </div>

        {/* Mobile Menu */}
        {isOpen && (
          <div className="md:hidden bg-white border-t border-[var(--card-border)] absolute left-0 right-0 shadow-lg">
            <div className="px-4 py-4 space-y-4">
              <a 
                href="#courses" 
                className="block text-[var(--foreground-muted)] hover:text-[var(--primary)] font-medium py-2"
                onClick={handleNavClick}
              >
                Courses
              </a>
              <a 
                href="#features" 
                className="block text-[var(--foreground-muted)] hover:text-[var(--primary)] font-medium py-2"
                onClick={handleNavClick}
              >
                Features
              </a>
              <a 
                href="#pricing" 
                className="block text-[var(--foreground-muted)] hover:text-[var(--primary)] font-medium py-2"
                onClick={handleNavClick}
              >
                Pricing
              </a>
              <div className="pt-4 border-t border-[var(--border)] space-y-3">
                <Link 
                  href="/login" 
                  className="block w-full px-4 py-2.5 text-sm text-center text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors font-medium rounded-lg border border-[var(--border)]"
                  onClick={handleNavClick}
                >
                  Sign In
                </Link>
                <Link 
                  href="/signup"
                  className="block w-full px-4 py-2.5 text-sm font-semibold text-center bg-[var(--primary)] text-white rounded-xl hover:bg-[var(--primary-light)]"
                  onClick={handleNavClick}
                >
                  Start Free
                </Link>
              </div>
            </div>
          </div>
        )}
      </nav>
    </>
  );
}

// Hero Section with Asymmetric Layout
function HeroSection() {
  return (
    <section className="relative min-h-screen flex items-center pt-24 overflow-hidden">
      {/* Background Elements - Partial grey/blue gradient background like prototype */}
      <div className="absolute inset-0 -z-10 overflow-hidden">
        {/* Main background shape - matching prototype: gradient from primary to accent with curve */}
        <div 
          className="absolute"
          style={{
            top: '-20%',
            right: '-10%',
            width: '60%',
            height: '120%',
            background: 'linear-gradient(135deg, #1e3a5f 0%, #2d5a8b 50%, #e76f51 100%)',
            opacity: 0.06,
            borderRadius: '0 0 0 40%',
          }}
        />
        {/* Secondary visible grey layer for more visibility */}
        <div 
          className="absolute"
          style={{
            top: 0,
            right: 0,
            width: '55%',
            height: '100%',
            background: 'linear-gradient(135deg, #e8e5df 0%, #f5f3ef 100%)',
            opacity: 0.8,
            borderRadius: '0 0 0 50%',
            zIndex: -1,
          }}
        />
        {/* Accent glow - bottom left */}
        <div className="absolute bottom-[10%] left-[-5%] w-[400px] h-[400px] bg-[var(--accent)] opacity-5 rounded-full blur-[80px]" />
        {/* Primary glow - center right */}
        <div className="absolute top-[20%] right-[30%] w-[300px] h-[300px] bg-[var(--primary)] opacity-[0.04] rounded-full blur-[60px]" />
      </div>

      <div className="max-w-7xl mx-auto px-6 py-16">
        <div className="grid lg:grid-cols-2 gap-12 lg:gap-20 items-center">
          {/* Left Content */}
          <div className="animate-slide-in-left text-center lg:text-left">
            <div className="hero-badge mb-6 inline-flex">
              <Sparkles className="w-4 h-4" />
              <span>Made by Students, for Students</span>
            </div>

            <h1 
              className="text-4xl sm:text-5xl lg:text-6xl font-bold mb-6 text-[var(--foreground)]"
              style={{ letterSpacing: '-0.03em', lineHeight: 1.2 }}
            >
              Stop Overpaying
              <br />
              <span className="relative inline-block">
                <span className="text-[var(--accent)]">for Tutoring</span>
                <span className="absolute bottom-0 left-0 right-0 h-2 bg-[var(--accent)] opacity-20 rounded translate-y-1" />
              </span>
            </h1>

            <p className="text-lg lg:text-xl text-[var(--foreground-muted)] mb-10 max-w-lg leading-relaxed mx-auto lg:mx-0">
              Why spend CHF 80+/hour on private tutors? Access quality course summaries, 
              exercises, and video lessons - all for a fraction of the cost.
            </p>

            {/* CTA Buttons */}
            <div className="flex flex-col sm:flex-row gap-4 mb-12 justify-center lg:justify-start">
              <Link
                href="/explore"
                className="group px-8 py-4 bg-[var(--accent)] text-white font-semibold rounded-xl hover:bg-[var(--accent-dark)] transition-all flex items-center justify-center gap-2 shadow-lg shadow-[var(--accent)]/30 hover:shadow-xl hover:-translate-y-0.5"
              >
                <Play className="w-5 h-5" />
                Browse Courses
              </Link>
              <Link 
                href="/signup"
                className="group px-8 py-4 bg-white border-2 border-[var(--card-border)] rounded-xl font-semibold text-[var(--foreground)] hover:border-[var(--primary)] hover:text-[var(--primary)] transition-all flex items-center justify-center gap-2"
              >
                <Zap className="w-5 h-5" />
                Start Free Trial
              </Link>
            </div>

            {/* Social Proof & Trust Badges */}
            <div className="flex flex-col gap-6">
              {/* Student Avatars Widget */}
              <div className="flex items-center gap-3 justify-center lg:justify-start">
                <div className="flex">
                  <div className="w-9 h-9 rounded-full bg-[var(--primary)] text-white flex items-center justify-center text-sm font-semibold border-2 border-white">
                    M
                  </div>
                  <div className="w-9 h-9 rounded-full bg-[var(--success)] text-white flex items-center justify-center text-sm font-semibold border-2 border-white -ml-2.5">
                    S
                  </div>
                  <div className="w-9 h-9 rounded-full bg-[var(--accent)] text-white flex items-center justify-center text-sm font-semibold border-2 border-white -ml-2.5">
                    L
                  </div>
                  <div className="w-9 h-9 rounded-full bg-[#7c3aed] text-white flex items-center justify-center text-sm font-semibold border-2 border-white -ml-2.5">
                    A
                  </div>
                </div>
                <span className="text-sm text-[var(--foreground-muted)]">
                  <strong className="text-[var(--foreground)]">50+</strong> students learning
                </span>
              </div>
              
              {/* Trust Badges */}
              <div className="flex flex-wrap gap-6 justify-center lg:justify-start">
                <div className="flex items-center gap-2.5">
                  <div className="w-8 h-8 rounded-lg bg-[var(--background-secondary)] flex items-center justify-center text-[var(--primary)]">
                    <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
                    </svg>
                  </div>
                  <span className="text-sm text-[var(--foreground-muted)]">Secure Payments</span>
                </div>
                <div className="flex items-center gap-2.5">
                  <div className="w-8 h-8 rounded-lg bg-[var(--background-secondary)] flex items-center justify-center text-[var(--primary)]">
                    <Clock className="w-4 h-4" />
                  </div>
                  <span className="text-sm text-[var(--foreground-muted)]">Learn at Your Pace</span>
                </div>
                <div className="flex items-center gap-2.5">
                  <div className="w-8 h-8 rounded-lg bg-[var(--background-secondary)] flex items-center justify-center text-[var(--primary)]">
                    <svg className="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <rect x="3" y="11" width="18" height="10" rx="2"/>
                      <circle cx="12" cy="5" r="3"/>
                    </svg>
                  </div>
                  <span className="text-sm text-[var(--foreground-muted)]">AI Tutor Included</span>
                </div>
              </div>
            </div>
          </div>

          {/* Right Visual - Course Preview Card */}
          <div className="relative animate-slide-in-right animation-delay-200 max-w-[500px] mx-auto lg:mx-0">
            <div className="relative" style={{ perspective: '1000px' }}>
              {/* Background card */}
              <div className="absolute inset-0 bg-[var(--primary)] rounded-[28px] transform rotate-[6deg] translate-x-5 -translate-y-2.5 opacity-20" />
              
              {/* Main card */}
              <div className="relative bg-white rounded-[28px] p-8 shadow-2xl shadow-[var(--primary)]/10 border border-[var(--card-border)]">
                {/* Course Header */}
                <div className="flex items-center gap-4 mb-6">
                  <div className="w-14 h-14 rounded-[14px] bg-gradient-to-br from-[var(--primary)] to-[var(--primary-light)] flex items-center justify-center text-white">
                    <GraduationCap className="w-7 h-7" />
                  </div>
                  <div>
                    <h4 className="font-semibold text-lg text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
                      Computational Thinking
                    </h4>
                    <p className="text-sm text-[var(--foreground-muted)]">Module 3: Problem Decomposition</p>
                  </div>
                </div>

                {/* Progress */}
                <div className="mb-6">
                  <div className="flex justify-between text-sm mb-2">
                    <span className="text-[var(--foreground-muted)]">Your Progress</span>
                    <span className="font-semibold text-[var(--accent)]">68%</span>
                  </div>
                  <div className="h-2 bg-[var(--background-tertiary)] rounded-full overflow-hidden">
                    <div className="h-full bg-gradient-to-r from-[var(--accent)] to-[var(--accent-light)] rounded-full w-[68%] animate-progress" />
                  </div>
                </div>

                {/* Lesson List */}
                <div className="space-y-3">
                  <div className="flex items-center gap-3.5 p-3.5 bg-[var(--background)] rounded-xl hover:bg-[var(--background-secondary)] transition-colors cursor-pointer group">
                    <div className="w-6 h-6 rounded-full bg-[var(--success)] flex items-center justify-center text-white">
                      <Check className="w-3.5 h-3.5" />
                    </div>
                    <div className="flex-1">
                      <h5 className="font-semibold text-[15px] text-[var(--foreground)]">Breaking Down Complex Problems</h5>
                      <p className="text-xs text-[var(--foreground-muted)]">Lesson completed</p>
                    </div>
                    <span className="text-xs text-[var(--foreground-subtle)] font-medium">12 min</span>
                  </div>

                  <div className="flex items-center gap-3.5 p-3.5 bg-[var(--background)] rounded-xl hover:bg-[var(--background-secondary)] transition-colors cursor-pointer group">
                    <div className="w-6 h-6 rounded-full bg-[var(--accent)] flex items-center justify-center text-white animate-pulse-accent">
                      <Play className="w-3 h-3" />
                    </div>
                    <div className="flex-1">
                      <h5 className="font-semibold text-[15px] text-[var(--foreground)]">Pattern Recognition</h5>
                      <p className="text-xs text-[var(--foreground-muted)]">In progress</p>
                    </div>
                    <span className="text-xs text-[var(--foreground-subtle)] font-medium">18 min</span>
                  </div>

                  <div className="flex items-center gap-3.5 p-3.5 bg-[var(--background)] rounded-xl hover:bg-[var(--background-secondary)] transition-colors cursor-pointer group">
                    <div className="w-6 h-6 rounded-full border-2 border-[var(--card-border)] bg-[var(--background-tertiary)]" />
                    <div className="flex-1">
                      <h5 className="font-semibold text-[15px] text-[var(--foreground)]">Abstraction Techniques</h5>
                      <p className="text-xs text-[var(--foreground-muted)]">Up next</p>
                    </div>
                    <span className="text-xs text-[var(--foreground-subtle)] font-medium">15 min</span>
                  </div>
                </div>
              </div>

              {/* Floating Badges */}
              <div className="floating-badge top-[-20px] right-[-20px] lg:right-[-40px] animate-float hidden sm:flex">
                <div className="w-8 h-8 rounded-lg bg-[var(--success-light)] flex items-center justify-center text-[var(--success)]">
                  <Trophy className="w-[18px] h-[18px]" />
                </div>
                <span className="font-semibold text-[var(--foreground)]">5 Day Streak!</span>
              </div>

              <div className="floating-badge bottom-16 left-[-20px] lg:left-[-50px] animate-float animation-delay-1000 hidden sm:flex">
                <div className="w-8 h-8 rounded-lg bg-[var(--accent)]/15 flex items-center justify-center text-[var(--accent)]">
                  <Flame className="w-[18px] h-[18px]" />
                </div>
                <span className="font-semibold text-[var(--foreground)]">+250 XP Today</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

// Stats Section
function StatsSection() {
  return (
    <section className="stats-section py-20 relative z-10">
      <div className="max-w-7xl mx-auto px-6">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-8 lg:gap-10 relative z-10">
          {stats.map((stat, index) => (
            <div 
              key={stat.label} 
              className="text-center"
            >
              <div 
                className="text-4xl lg:text-[3.5rem] font-bold text-white mb-2"
                style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
              >
                {stat.value}<span className="text-[var(--accent-light)]">{stat.suffix}</span>
              </div>
              <div className="text-white/80">{stat.label}</div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}

// Course Card Component
function CourseCard({ course, index }: { course: typeof courses[0]; index: number }) {
  const colors = accentClasses[course.accent] || accentClasses.coral;
  const Icon = course.icon;
  
  return (
    <Link
      href={`/explore/${course.slug}`}
      className={`group card-elevated card-accent ${colors.border} p-7 hover:scale-[1.02] hover:-translate-y-2 transition-all duration-300 cursor-pointer block`}
      style={{ 
        opacity: 0, 
        transform: 'translateY(30px)',
        animation: `fade-in-up 0.6s ease ${index * 0.1}s forwards`
      }}
    >
      {/* Free Badge */}
      {course.free && (
        <div className="absolute top-5 right-5 flex items-center gap-1 px-3 py-1.5 bg-[var(--success-light)] text-[var(--success)] text-xs font-semibold rounded-full">
          <Zap className="w-3 h-3" />
          Free Preview
        </div>
      )}

      {/* Icon */}
      <div className={`w-[52px] h-[52px] rounded-[14px] ${colors.icon} flex items-center justify-center mb-5 relative`}>
        <Icon className="w-6 h-6" />
        <div className={`absolute inset-[-4px] rounded-[18px] ${colors.icon} opacity-20 -z-10`} />
      </div>

      {/* Category */}
      <div className="text-xs font-semibold text-[var(--accent)] uppercase tracking-[0.05em] mb-2">
        {course.category}
      </div>

      {/* Title */}
      <h3 
        className="text-xl font-bold mb-3 text-[var(--foreground)] group-hover:text-[var(--primary)] transition-colors"
        style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.01em' }}
      >
        {course.title}
      </h3>

      {/* Description */}
      <p className="text-sm text-[var(--foreground-muted)] mb-5 leading-relaxed">
        {course.description}
      </p>

      {/* Meta Info */}
      <div className="flex items-center gap-4 text-sm text-[var(--foreground-muted)] mb-5 pt-5 border-t border-[var(--card-border)]">
        <span className="flex items-center gap-1.5">
          <BookOpen className="w-3.5 h-3.5" />
          {course.lessons} lessons
        </span>
        <span className="flex items-center gap-1.5">
          <Clock className="w-3.5 h-3.5" />
          {course.duration} hours
        </span>
      </div>

      {/* Rating & Arrow */}
      <div className="flex items-center justify-between mt-5">
        <div className="flex items-center gap-1.5">
          <Star className="w-4 h-4 text-amber-500 fill-amber-500" />
          <span className="font-semibold text-[var(--foreground)]">{course.rating}</span>
          <span className="text-[var(--foreground-muted)]">({course.students.toLocaleString()})</span>
        </div>
        <div className="w-10 h-10 rounded-full bg-[var(--background)] flex items-center justify-center text-[var(--foreground-muted)] group-hover:bg-[var(--primary)] group-hover:text-white group-hover:translate-x-1 transition-all">
          <ArrowRight className="w-[18px] h-[18px]" />
        </div>
      </div>
    </Link>
  );
}

// Courses Section
function CoursesSection() {
  return (
    <section id="courses" className="py-28 relative bg-[var(--background)]">
      <div className="max-w-7xl mx-auto px-6">
        {/* Section Header */}
        <div className="text-center max-w-2xl mx-auto mb-16">
          <div className="section-label mb-5">
            <BookOpen className="w-3.5 h-3.5" />
            <span>Available Courses</span>
          </div>
          <h2 
            className="text-3xl md:text-4xl lg:text-5xl font-bold mb-4 text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
          >
            Start Learning Today
          </h2>
          <p className="text-lg text-[var(--foreground-muted)]">
            Interactive courses designed for business school students, structured for maximum retention and exam success.
          </p>
        </div>

        {/* Course Grid */}
        <div className="grid md:grid-cols-2 gap-7 max-w-4xl mx-auto">
          {courses.map((course, index) => (
            <CourseCard key={course.id} course={course} index={index} />
          ))}
        </div>
      </div>
    </section>
  );
}

// Features Section
function FeaturesSection() {
  return (
    <section id="features" className="py-28 relative section-alt">
      <div className="max-w-7xl mx-auto px-6">
        <div className="grid lg:grid-cols-2 gap-12 lg:gap-12 items-center">
          {/* Left Content */}
          <div className="lg:pr-10 text-center lg:text-left">
            <div className="section-label mb-5 inline-flex">
              <Sparkles className="w-3.5 h-3.5" />
              <span>Why Tutorio</span>
            </div>
            <h2 
              className="text-3xl md:text-4xl lg:text-5xl font-bold mb-4 text-[var(--foreground)]"
              style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
            >
              Learn Smarter, Not Harder
            </h2>
            <p className="text-lg text-[var(--foreground-muted)] mb-10 leading-relaxed">
              Our AI-powered platform restructures complex business concepts into clear, 
              exam-focused content. No more wading through endless lecture notes.
            </p>

            <div className="space-y-6">
              {features.map((feature, index) => (
                <div 
                  key={feature.title} 
                  className="flex gap-5 p-6 bg-white rounded-xl border border-[var(--card-border)] shadow-sm hover:shadow-lg hover:translate-x-2 transition-all cursor-pointer"
                  style={{ 
                    opacity: 0, 
                    transform: 'translateY(30px)',
                    animation: `fade-in-up 0.6s ease ${index * 0.1}s forwards`
                  }}
                >
                  <div className={`flex-shrink-0 w-[52px] h-[52px] rounded-[14px] ${featureColorClasses[feature.color]} flex items-center justify-center`}>
                    <feature.icon className="w-6 h-6" />
                  </div>
                  <div>
                    <h4 
                      className="font-semibold text-lg mb-1.5 text-[var(--foreground)]"
                      style={{ fontFamily: 'var(--font-heading)' }}
                    >
                      {feature.title}
                    </h4>
                    <p className="text-sm text-[var(--foreground-muted)] leading-relaxed">
                      {feature.description}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Right Visual - Dashboard Preview */}
          <div className="relative hidden lg:block">
            <div className="bg-gradient-to-br from-[var(--primary)] to-[var(--primary-light)] rounded-[28px] p-10 relative overflow-hidden">
              {/* Pattern overlay */}
              <div className="absolute inset-0" style={{
                backgroundImage: `url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.05'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E")`
              }} />
              
              <div className="bg-white rounded-xl p-6 relative z-10">
                <div className="flex items-center gap-3 mb-5">
                  <div className="w-10 h-10 rounded-full bg-gradient-to-br from-[var(--accent)] to-[var(--accent-light)] flex items-center justify-center text-white font-bold">
                    VT
                  </div>
                  <div>
                    <h4 className="font-semibold text-[var(--foreground)]" style={{ fontFamily: 'var(--font-heading)' }}>
                      Good morning, Victor
                    </h4>
                    <p className="text-xs text-[var(--foreground-muted)]">Ready to continue learning?</p>
                  </div>
                </div>

                <div className="grid grid-cols-3 gap-3 mb-5">
                  <div className="bg-[var(--background)] p-4 rounded-xl text-center">
                    <div className="text-2xl font-bold text-[var(--primary)]" style={{ fontFamily: 'var(--font-heading)' }}>12</div>
                    <div className="text-xs text-[var(--foreground-muted)]">Skills Mastered</div>
                  </div>
                  <div className="bg-[var(--background)] p-4 rounded-xl text-center">
                    <div className="text-2xl font-bold text-[var(--primary)]" style={{ fontFamily: 'var(--font-heading)' }}>4.2h</div>
                    <div className="text-xs text-[var(--foreground-muted)]">Study Time</div>
                  </div>
                  <div className="bg-[var(--background)] p-4 rounded-xl text-center">
                    <div className="text-2xl font-bold text-[var(--primary)]" style={{ fontFamily: 'var(--font-heading)' }}>5</div>
                    <div className="text-xs text-[var(--foreground-muted)]">Day Streak</div>
                  </div>
                </div>

                <div className="flex items-center gap-3 p-3 bg-[var(--background)] rounded-xl">
                  <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-[var(--success)] to-emerald-400 flex items-center justify-center text-white">
                    <BookOpen className="w-[18px] h-[18px]" />
                  </div>
                  <div className="flex-1">
                    <h5 className="text-sm font-medium text-[var(--foreground)]">Continue: Balance Sheets</h5>
                    <div className="h-1 bg-[var(--card-border)] rounded-full mt-1 overflow-hidden">
                      <div className="h-full bg-[var(--success)] rounded-full w-[65%]" />
                    </div>
                  </div>
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
        { text: "AI-structured text summaries", included: true },
        { text: "Practice exercises with solutions", included: true },
        { text: "Progress tracking", included: true },
        { text: "Access to all courses", included: true },
        { text: "Video lessons", included: false },
        { text: "Audio podcasts", included: false },
      ],
      popular: false,
    },
    {
      name: "Premium",
      price: "25",
      description: "The complete learning experience",
      features: [
        { text: "Everything in Basic", included: true },
        { text: "HD Video lessons", included: true },
        { text: "Audio podcasts for on-the-go", included: true },
        { text: "Downloadable resources", included: true },
        { text: "Priority support", included: true },
        { text: "Exam simulations", included: true },
      ],
      popular: true,
    },
  ];

  return (
    <section id="pricing" className="py-28 relative bg-[var(--background)]">
      <div className="max-w-7xl mx-auto px-6">
        {/* Section Header */}
        <div className="text-center max-w-2xl mx-auto mb-16">
          <div className="section-label mb-5">
            <CreditCard className="w-3.5 h-3.5" />
            <span>Simple Pricing</span>
          </div>
          <h2 
            className="text-3xl md:text-4xl lg:text-5xl font-bold mb-4 text-[var(--foreground)]"
            style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
          >
            Choose Your Learning Path
          </h2>
          <p className="text-lg text-[var(--foreground-muted)]">
            Start with a free preview on any course. No credit card required.
          </p>
        </div>

        {/* Pricing Cards */}
        <div className="grid md:grid-cols-2 gap-8 max-w-[900px] mx-auto">
          {plans.map((plan, index) => (
            <div
              key={plan.name}
              className={`relative rounded-[28px] p-10 transition-all hover:-translate-y-2 ${
                plan.popular
                  ? "bg-white border-2 border-[var(--accent)] shadow-2xl shadow-[var(--accent)]/15"
                  : "bg-white border border-[var(--card-border)] shadow-lg hover:shadow-xl"
              }`}
              style={{ 
                opacity: 0, 
                transform: 'translateY(30px)',
                animation: `fade-in-up 0.6s ease ${index * 0.15}s forwards`
              }}
            >
              {/* Popular Badge */}
              {plan.popular && (
                <div className="absolute -top-3.5 left-1/2 -translate-x-1/2 px-5 py-1.5 bg-[var(--accent)] text-white text-xs font-semibold rounded-full">
                  Most Popular
                </div>
              )}

              {/* Plan Name */}
              <h3 
                className="text-xl font-bold mb-2 text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                {plan.name}
              </h3>
              <p className="text-sm text-[var(--foreground-muted)] mb-6">
                {plan.description}
              </p>

              {/* Price */}
              <div className="flex items-baseline gap-1 mb-8">
                <span className="text-xl text-[var(--foreground-muted)]">CHF</span>
                <span 
                  className="text-[3.5rem] font-bold text-[var(--foreground)]"
                  style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
                >
                  {plan.price}
                </span>
                <span className="text-[var(--foreground-muted)]">/month</span>
              </div>

              {/* Features */}
              <div className="space-y-3.5 mb-8">
                {plan.features.map((feature) => (
                  <div 
                    key={feature.text} 
                    className={`flex items-center gap-3 ${!feature.included ? 'opacity-50' : ''}`}
                  >
                    {feature.included ? (
                      <Check className="w-[18px] h-[18px] text-[var(--success)]" />
                    ) : (
                      <X className="w-[18px] h-[18px] text-[var(--foreground-subtle)]" />
                    )}
                    <span className={feature.included ? 'text-[var(--foreground)]' : 'text-[var(--foreground-muted)]'}>
                      {feature.text}
                    </span>
                  </div>
                ))}
              </div>

              {/* CTA Button */}
              <Link
                href="/pricing"
                className={`block w-full py-4 rounded-xl font-semibold transition-all text-center ${
                  plan.popular
                    ? "bg-[var(--accent)] text-white hover:bg-[var(--accent-dark)]"
                    : "bg-white border-2 border-[var(--card-border)] text-[var(--foreground)] hover:border-[var(--primary)] hover:text-[var(--primary)]"
                }`}
              >
                Get Started
              </Link>
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
    <section className="cta-section py-28 relative">
      <div className="relative max-w-4xl mx-auto px-6 text-center z-10">
        <h2 
          className="text-4xl md:text-5xl lg:text-6xl font-bold mb-5 text-white"
          style={{ fontFamily: 'var(--font-heading)', letterSpacing: '-0.02em' }}
        >
          Ready to Excel?
        </h2>
        <p className="text-xl text-white/80 mb-10 max-w-lg mx-auto">
          Join thousands of students who are saving money while studying smarter.
          Start with a free preview today.
        </p>
        <div className="flex flex-col sm:flex-row gap-4 justify-center">
          <Link 
            href="/signup" 
            className="group px-8 py-4 bg-white text-[var(--primary)] font-semibold rounded-xl hover:bg-[var(--background)] transition-all flex items-center justify-center gap-2 shadow-lg hover:shadow-xl hover:-translate-y-0.5"
          >
            Start Learning Free
            <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
          </Link>
          <Link 
            href="/explore" 
            className="px-8 py-4 bg-transparent border-2 border-white/30 text-white rounded-xl font-semibold hover:bg-white/10 hover:border-white/50 transition-all"
          >
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
    <footer className="py-20 border-t border-[var(--card-border)] bg-white">
      <div className="max-w-7xl mx-auto px-6">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 lg:gap-16 mb-16">
          {/* Brand */}
          <div className="lg:col-span-1">
            <Link href="/" className="flex items-center gap-3 mb-4 group">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img 
                src="/logo-cropped.svg" 
                alt="Tutorio" 
                className="w-11 h-11 transition-transform duration-300 group-hover:rotate-[-5deg] group-hover:scale-105"
              />
              <span 
                className="text-xl font-bold tracking-tight text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                Tutorio
              </span>
            </Link>
            <p className="text-sm text-[var(--foreground-muted)] max-w-[280px] leading-relaxed">
              Quality tutoring content at a fraction of the cost. Stop overpaying for private lessons.
            </p>
          </div>

          {/* Platform */}
          <div>
            <h4 
              className="text-sm font-semibold mb-5 text-[var(--foreground)]"
            >
              Platform
            </h4>
            <ul className="space-y-3 text-sm">
              <li><a href="#courses" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">Courses</a></li>
              <li><a href="#pricing" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">Pricing</a></li>
              <li><a href="#features" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">How It Works</a></li>
              <li><Link href="/faq" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">FAQ</Link></li>
            </ul>
          </div>

          {/* Company */}
          <div>
            <h4 
              className="text-sm font-semibold mb-5 text-[var(--foreground)]"
            >
              Company
            </h4>
            <ul className="space-y-3 text-sm">
              <li><a href="#" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">About Us</a></li>
              <li><a href="#" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">Careers</a></li>
              <li><a href="#" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">Blog</a></li>
              <li><Link href="/contact" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">Contact</Link></li>
            </ul>
          </div>

          {/* Legal */}
          <div>
            <h4 
              className="text-sm font-semibold mb-5 text-[var(--foreground)]"
            >
              Legal
            </h4>
            <ul className="space-y-3 text-sm">
              <li><Link href="/privacy" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">Privacy Policy</Link></li>
              <li><Link href="/terms" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">Terms of Service</Link></li>
              <li><Link href="/cookies" className="text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors">Cookie Policy</Link></li>
            </ul>
          </div>
        </div>

        {/* Bottom */}
        <div className="pt-10 border-t border-[var(--card-border)] flex flex-col md:flex-row justify-between items-center gap-4 text-sm text-[var(--foreground-muted)]">
          <p>2025 Tutorio. All rights reserved.</p>
          <div className="flex gap-6">
            <span>Made by Students, for Students</span>
            <span>in Switzerland</span>
          </div>
        </div>
      </div>
    </footer>
  );
}

// Main Page Component
export default function Home() {
  return (
    <main className="min-h-screen bg-[var(--background)]">
      <Navigation />
      <HeroSection />
      <StatsSection />
      <CoursesSection />
      <FeaturesSection />
      <PricingSection />
      <CTASection />
      <Footer />
    </main>
  );
}
