"use client";

import { useState } from "react";
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
    duration: "12 hours",
    rating: 4.9,
    students: 1240,
    thumbnail: "📊",
    color: "from-blue-500/20 to-purple-500/20",
    free: true,
  },
  {
    id: 2,
    title: "Marketing Strategy",
    category: "Marketing",
    lessons: 18,
    duration: "9 hours",
    rating: 4.8,
    students: 980,
    thumbnail: "📈",
    color: "from-emerald-500/20 to-teal-500/20",
    free: false,
  },
  {
    id: 3,
    title: "Corporate Finance",
    category: "Finance",
    lessons: 32,
    duration: "16 hours",
    rating: 4.9,
    students: 1560,
    thumbnail: "💰",
    color: "from-amber-500/20 to-orange-500/20",
    free: true,
  },
  {
    id: 4,
    title: "Business Law",
    category: "Law",
    lessons: 20,
    duration: "10 hours",
    rating: 4.7,
    students: 720,
    thumbnail: "⚖️",
    color: "from-rose-500/20 to-pink-500/20",
    free: false,
  },
  {
    id: 5,
    title: "Microeconomics",
    category: "Economics",
    lessons: 28,
    duration: "14 hours",
    rating: 4.8,
    students: 1100,
    thumbnail: "📉",
    color: "from-cyan-500/20 to-blue-500/20",
    free: true,
  },
  {
    id: 6,
    title: "Operations Management",
    category: "Management",
    lessons: 22,
    duration: "11 hours",
    rating: 4.6,
    students: 850,
    thumbnail: "⚙️",
    color: "from-violet-500/20 to-purple-500/20",
    free: false,
  },
];

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

// Navigation Component
function Navigation() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 glass">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* Logo */}
          <div className="flex items-center gap-2">
            <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-[var(--accent)] to-[var(--accent-dark)] flex items-center justify-center">
              <BookOpen className="w-5 h-5 text-black" />
            </div>
            <span className="text-xl font-bold tracking-tight" style={{ fontFamily: 'var(--font-heading)' }}>
              Tutorio
            </span>
          </div>

          {/* Desktop Navigation */}
          <div className="hidden md:flex items-center gap-8">
            <a href="#courses" className="text-[var(--foreground-muted)] hover:text-white transition-colors">
              Courses
            </a>
            <a href="#pricing" className="text-[var(--foreground-muted)] hover:text-white transition-colors">
              Pricing
            </a>
            <a href="#how-it-works" className="text-[var(--foreground-muted)] hover:text-white transition-colors">
              How It Works
            </a>
          </div>

          {/* CTA Buttons */}
          <div className="hidden md:flex items-center gap-4">
            <button className="px-4 py-2 text-sm text-[var(--foreground-muted)] hover:text-white transition-colors">
              Sign In
            </button>
            <button className="px-5 py-2.5 text-sm font-medium bg-gradient-to-r from-[var(--accent)] to-[var(--accent-dark)] text-black rounded-lg hover:opacity-90 transition-opacity">
              Start Free
            </button>
          </div>

          {/* Mobile Menu Button */}
          <button
            className="md:hidden p-2"
            onClick={() => setIsOpen(!isOpen)}
          >
            {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      {isOpen && (
        <div className="md:hidden glass border-t border-[var(--card-border)]">
          <div className="px-4 py-4 space-y-4">
            <a href="#courses" className="block text-[var(--foreground-muted)] hover:text-white">
              Courses
            </a>
            <a href="#pricing" className="block text-[var(--foreground-muted)] hover:text-white">
              Pricing
            </a>
            <a href="#how-it-works" className="block text-[var(--foreground-muted)] hover:text-white">
              How It Works
            </a>
            <div className="pt-4 border-t border-[var(--card-border)] space-y-3">
              <button className="w-full px-4 py-2 text-sm text-[var(--foreground-muted)]">
                Sign In
              </button>
              <button className="w-full px-4 py-2.5 text-sm font-medium bg-gradient-to-r from-[var(--accent)] to-[var(--accent-dark)] text-black rounded-lg">
                Start Free
              </button>
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
    <section className="relative min-h-screen flex items-center justify-center pt-16 overflow-hidden noise-overlay">
      {/* Background Effects */}
      <div className="absolute inset-0">
        <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-[var(--accent)]/10 rounded-full blur-3xl animate-float" />
        <div className="absolute bottom-1/4 right-1/4 w-80 h-80 bg-purple-500/10 rounded-full blur-3xl animate-float animation-delay-300" />
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-gradient-radial from-[var(--accent)]/5 to-transparent rounded-full" />
      </div>

      {/* Grid Pattern */}
      <div className="absolute inset-0 opacity-[0.02]" style={{
        backgroundImage: `linear-gradient(var(--foreground) 1px, transparent 1px), linear-gradient(90deg, var(--foreground) 1px, transparent 1px)`,
        backgroundSize: '60px 60px'
      }} />

      <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
        <div className="text-center max-w-4xl mx-auto">
          {/* Badge */}
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass mb-8 animate-fade-in-up">
            <Sparkles className="w-4 h-4 text-[var(--accent)]" />
            <span className="text-sm text-[var(--foreground-muted)]">
              AI-Powered Learning for Swiss Business Students
            </span>
          </div>

          {/* Main Heading */}
          <h1 
            className="text-5xl md:text-7xl font-bold tracking-tight mb-6 animate-fade-in-up animation-delay-100"
            style={{ fontFamily: 'var(--font-heading)' }}
          >
            Master Your Business
            <br />
            <span className="gradient-text">Courses with Ease</span>
          </h1>

          {/* Subheading */}
          <p className="text-xl text-[var(--foreground-muted)] mb-10 max-w-2xl mx-auto animate-fade-in-up animation-delay-200">
            Get AI-structured summaries, practice exercises, and premium video content.
            Study smarter, not harder—starting from just CHF 10/month.
          </p>

          {/* CTA Buttons */}
          <div className="flex flex-col sm:flex-row gap-4 justify-center items-center animate-fade-in-up animation-delay-300">
            <a
              href="#courses"
              className="group px-8 py-4 bg-gradient-to-r from-[var(--accent)] to-[var(--accent-dark)] text-black font-semibold rounded-xl hover:opacity-90 transition-all flex items-center gap-2 animate-pulse-glow"
            >
              Browse Courses
              <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
            </a>
            <button className="px-8 py-4 glass rounded-xl font-medium hover:bg-white/5 transition-colors flex items-center gap-2">
              <Play className="w-5 h-5 text-[var(--accent)]" />
              Watch Demo
            </button>
          </div>

          {/* Trust Badges */}
          <div className="mt-16 flex flex-wrap justify-center gap-8 text-sm text-[var(--foreground-muted)] animate-fade-in-up animation-delay-400">
            <div className="flex items-center gap-2">
              <Shield className="w-5 h-5 text-[var(--accent)]" />
              <span>Secure Payments</span>
            </div>
            <div className="flex items-center gap-2">
              <Users className="w-5 h-5 text-[var(--accent)]" />
              <span>5,000+ Students</span>
            </div>
            <div className="flex items-center gap-2">
              <Award className="w-5 h-5 text-[var(--accent)]" />
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
        <div className="w-6 h-10 rounded-full border-2 border-[var(--foreground-muted)]/30 flex items-start justify-center p-2">
          <div className="w-1.5 h-3 bg-[var(--accent)] rounded-full" />
        </div>
      </div>
    </section>
  );
}

// Course Card Component
function CourseCard({ course, index }: { course: typeof courses[0]; index: number }) {
  return (
    <div
      className="group relative gradient-border p-6 rounded-2xl hover:scale-[1.02] transition-all duration-300 cursor-pointer animate-fade-in-up"
      style={{ animationDelay: `${index * 0.1}s` }}
    >
      {/* Free Badge */}
      {course.free && (
        <div className="absolute top-4 right-4 px-3 py-1 bg-[var(--success)]/20 text-[var(--success)] text-xs font-medium rounded-full flex items-center gap-1">
          <Zap className="w-3 h-3" />
          Free Preview
        </div>
      )}

      {/* Thumbnail */}
      <div className={`w-16 h-16 rounded-2xl bg-gradient-to-br ${course.color} flex items-center justify-center text-3xl mb-4`}>
        {course.thumbnail}
      </div>

      {/* Category */}
      <div className="text-xs text-[var(--accent)] font-medium uppercase tracking-wider mb-2">
        {course.category}
      </div>

      {/* Title */}
      <h3 className="text-xl font-semibold mb-3 group-hover:text-[var(--accent)] transition-colors" style={{ fontFamily: 'var(--font-heading)' }}>
        {course.title}
      </h3>

      {/* Meta Info */}
      <div className="flex items-center gap-4 text-sm text-[var(--foreground-muted)] mb-4">
        <span className="flex items-center gap-1">
          <BookOpen className="w-4 h-4" />
          {course.lessons} lessons
        </span>
        <span className="flex items-center gap-1">
          <Clock className="w-4 h-4" />
          {course.duration}
        </span>
      </div>

      {/* Rating & Students */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-1">
          <Star className="w-4 h-4 text-[var(--accent)] fill-[var(--accent)]" />
          <span className="font-medium">{course.rating}</span>
          <span className="text-[var(--foreground-muted)]">({course.students.toLocaleString()})</span>
        </div>
        <ChevronRight className="w-5 h-5 text-[var(--foreground-muted)] group-hover:text-[var(--accent)] group-hover:translate-x-1 transition-all" />
      </div>
    </div>
  );
}

// Courses Section
function CoursesSection() {
  return (
    <section id="courses" className="py-24 relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass mb-6">
            <BookOpen className="w-4 h-4 text-[var(--accent)]" />
            <span className="text-sm text-[var(--foreground-muted)]">Popular Courses</span>
          </div>
          <h2 className="text-4xl md:text-5xl font-bold mb-6" style={{ fontFamily: 'var(--font-heading)' }}>
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
          <button className="group px-8 py-4 glass rounded-xl font-medium hover:bg-white/5 transition-colors inline-flex items-center gap-2">
            View All 50+ Courses
            <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
          </button>
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
    <section id="how-it-works" className="py-24 relative bg-[var(--background-secondary)]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass mb-6">
            <Sparkles className="w-4 h-4 text-[var(--accent)]" />
            <span className="text-sm text-[var(--foreground-muted)]">How It Works</span>
          </div>
          <h2 className="text-4xl md:text-5xl font-bold mb-6" style={{ fontFamily: 'var(--font-heading)' }}>
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
                <div className="hidden lg:block absolute top-12 left-[60%] w-full h-0.5 bg-gradient-to-r from-[var(--accent)]/50 to-transparent" />
              )}

              {/* Step Number */}
              <div className="text-6xl font-bold text-[var(--accent)]/10 mb-4" style={{ fontFamily: 'var(--font-heading)' }}>
                {step.step}
              </div>

              {/* Icon */}
              <div className="w-12 h-12 rounded-xl bg-gradient-to-br from-[var(--accent)] to-[var(--accent-dark)] flex items-center justify-center mb-4">
                <step.icon className="w-6 h-6 text-black" />
              </div>

              {/* Content */}
              <h3 className="text-xl font-semibold mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
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
    <section className="py-24 relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid lg:grid-cols-2 gap-16 items-center">
          {/* Left Content */}
          <div className="animate-slide-in-left">
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass mb-6">
              <Zap className="w-4 h-4 text-[var(--accent)]" />
              <span className="text-sm text-[var(--foreground-muted)]">Why Tutorio</span>
            </div>
            <h2 className="text-4xl md:text-5xl font-bold mb-6" style={{ fontFamily: 'var(--font-heading)' }}>
              Learn Smarter,
              <br />
              <span className="gradient-text">Not Harder</span>
            </h2>
            <p className="text-[var(--foreground-muted)] text-lg mb-8">
              Our AI-powered platform restructures complex business concepts into clear, 
              exam-focused content. No more wading through endless lecture notes.
            </p>

            <div className="space-y-6">
              {features.map((feature, index) => (
                <div key={feature.title} className="flex gap-4">
                  <div className="flex-shrink-0 w-12 h-12 rounded-xl bg-[var(--accent)]/10 flex items-center justify-center">
                    <feature.icon className="w-6 h-6 text-[var(--accent)]" />
                  </div>
                  <div>
                    <h3 className="font-semibold mb-1" style={{ fontFamily: 'var(--font-heading)' }}>
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
            <div className="absolute inset-0 bg-gradient-to-br from-[var(--accent)]/20 to-purple-500/20 rounded-3xl blur-3xl" />
            <div className="relative glass rounded-3xl p-8">
              {/* Mock Lesson Preview */}
              <div className="bg-[var(--background)] rounded-2xl p-6 mb-6">
                <div className="flex items-center gap-3 mb-4">
                  <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-blue-500/20 to-purple-500/20 flex items-center justify-center text-xl">
                    📊
                  </div>
                  <div>
                    <div className="font-semibold text-sm">Financial Accounting</div>
                    <div className="text-xs text-[var(--foreground-muted)]">Lesson 3: Balance Sheets</div>
                  </div>
                </div>
                
                {/* Progress Bar */}
                <div className="mb-4">
                  <div className="flex justify-between text-xs text-[var(--foreground-muted)] mb-1">
                    <span>Progress</span>
                    <span>65%</span>
                  </div>
                  <div className="h-2 bg-[var(--background-tertiary)] rounded-full overflow-hidden">
                    <div className="h-full w-[65%] bg-gradient-to-r from-[var(--accent)] to-[var(--accent-dark)] rounded-full" />
                  </div>
                </div>

                {/* Content Types */}
                <div className="grid grid-cols-3 gap-3">
                  <div className="p-3 rounded-xl bg-[var(--background-secondary)] text-center">
                    <FileText className="w-5 h-5 mx-auto mb-1 text-[var(--accent)]" />
                    <div className="text-xs text-[var(--foreground-muted)]">Summary</div>
                  </div>
                  <div className="p-3 rounded-xl bg-[var(--background-secondary)] text-center">
                    <Play className="w-5 h-5 mx-auto mb-1 text-[var(--accent)]" />
                    <div className="text-xs text-[var(--foreground-muted)]">Video</div>
                  </div>
                  <div className="p-3 rounded-xl bg-[var(--background-secondary)] text-center">
                    <Headphones className="w-5 h-5 mx-auto mb-1 text-[var(--accent)]" />
                    <div className="text-xs text-[var(--foreground-muted)]">Podcast</div>
                  </div>
                </div>
              </div>

              {/* Mini Stats */}
              <div className="grid grid-cols-2 gap-4">
                <div className="bg-[var(--background)] rounded-xl p-4">
                  <div className="text-2xl font-bold gradient-text mb-1">12</div>
                  <div className="text-xs text-[var(--foreground-muted)]">Exercises Completed</div>
                </div>
                <div className="bg-[var(--background)] rounded-xl p-4">
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
    <section id="pricing" className="py-24 relative bg-[var(--background-secondary)]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass mb-6">
            <Sparkles className="w-4 h-4 text-[var(--accent)]" />
            <span className="text-sm text-[var(--foreground-muted)]">Simple Pricing</span>
          </div>
          <h2 className="text-4xl md:text-5xl font-bold mb-6" style={{ fontFamily: 'var(--font-heading)' }}>
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
                  ? "bg-gradient-to-b from-[var(--accent)]/10 to-transparent border-2 border-[var(--accent)]/30"
                  : "glass"
              }`}
              style={{ animationDelay: `${index * 0.15}s` }}
            >
              {/* Popular Badge */}
              {plan.popular && (
                <div className="absolute -top-4 left-1/2 -translate-x-1/2 px-4 py-1 bg-gradient-to-r from-[var(--accent)] to-[var(--accent-dark)] text-black text-sm font-medium rounded-full">
                  Most Popular
                </div>
              )}

              {/* Plan Name */}
              <h3 className="text-2xl font-bold mb-2" style={{ fontFamily: 'var(--font-heading)' }}>
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
                    ? "bg-gradient-to-r from-[var(--accent)] to-[var(--accent-dark)] text-black hover:opacity-90"
                    : "glass hover:bg-white/5"
                }`}
              >
                Get Started
              </button>

              {/* Features */}
              <div className="space-y-4">
                {plan.features.map((feature) => (
                  <div key={feature} className="flex items-center gap-3">
                    <CheckCircle2 className="w-5 h-5 text-[var(--success)] flex-shrink-0" />
                    <span className="text-sm">{feature}</span>
                  </div>
                ))}
                {plan.notIncluded.map((feature) => (
                  <div key={feature} className="flex items-center gap-3 opacity-50">
                    <Lock className="w-5 h-5 flex-shrink-0" />
                    <span className="text-sm">{feature}</span>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>

        {/* Money Back Guarantee */}
        <div className="text-center mt-12">
          <div className="inline-flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
            <Shield className="w-5 h-5 text-[var(--accent)]" />
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
    <section className="py-24 relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass mb-6">
            <Star className="w-4 h-4 text-[var(--accent)]" />
            <span className="text-sm text-[var(--foreground-muted)]">Testimonials</span>
          </div>
          <h2 className="text-4xl md:text-5xl font-bold mb-6" style={{ fontFamily: 'var(--font-heading)' }}>
            Loved by <span className="gradient-text">Students</span>
          </h2>
        </div>

        {/* Testimonials Grid */}
        <div className="grid md:grid-cols-3 gap-8">
          {testimonials.map((testimonial, index) => (
            <div
              key={testimonial.name}
              className="gradient-border p-6 rounded-2xl animate-fade-in-up"
              style={{ animationDelay: `${index * 0.1}s` }}
            >
              {/* Stars */}
              <div className="flex gap-1 mb-4">
                {[...Array(testimonial.rating)].map((_, i) => (
                  <Star key={i} className="w-4 h-4 text-[var(--accent)] fill-[var(--accent)]" />
                ))}
              </div>

              {/* Content */}
              <p className="text-[var(--foreground-muted)] mb-6 leading-relaxed">
                &ldquo;{testimonial.content}&rdquo;
              </p>

              {/* Author */}
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-full bg-gradient-to-br from-[var(--accent)] to-[var(--accent-dark)] flex items-center justify-center text-black font-semibold text-sm">
                  {testimonial.avatar}
                </div>
                <div>
                  <div className="font-semibold text-sm">{testimonial.name}</div>
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
    <section className="py-24 relative overflow-hidden">
      <div className="absolute inset-0 bg-gradient-to-br from-[var(--accent)]/10 via-transparent to-purple-500/10" />
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-[var(--accent)]/10 rounded-full blur-3xl" />

      <div className="relative max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <h2 className="text-4xl md:text-6xl font-bold mb-6" style={{ fontFamily: 'var(--font-heading)' }}>
          Ready to <span className="gradient-text">Excel</span>?
        </h2>
        <p className="text-xl text-[var(--foreground-muted)] mb-10 max-w-2xl mx-auto">
          Join thousands of Swiss business students who are already studying smarter.
          Start with a free preview today.
        </p>
        <div className="flex flex-col sm:flex-row gap-4 justify-center">
          <button className="group px-8 py-4 bg-gradient-to-r from-[var(--accent)] to-[var(--accent-dark)] text-black font-semibold rounded-xl hover:opacity-90 transition-all flex items-center justify-center gap-2 animate-pulse-glow">
            Start Learning Free
            <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
          </button>
          <button className="px-8 py-4 glass rounded-xl font-medium hover:bg-white/5 transition-colors">
            View All Courses
          </button>
        </div>
      </div>
    </section>
  );
}

// Footer
function Footer() {
  return (
    <footer className="py-16 border-t border-[var(--card-border)]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid md:grid-cols-4 gap-12 mb-12">
          {/* Brand */}
          <div className="md:col-span-2">
            <div className="flex items-center gap-2 mb-4">
              <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-[var(--accent)] to-[var(--accent-dark)] flex items-center justify-center">
                <BookOpen className="w-5 h-5 text-black" />
              </div>
              <span className="text-xl font-bold tracking-tight" style={{ fontFamily: 'var(--font-heading)' }}>
                Tutorio
              </span>
            </div>
            <p className="text-[var(--foreground-muted)] max-w-sm mb-6">
              The smart way to ace your business school exams. AI-powered learning for Swiss students.
            </p>
            <div className="flex items-center gap-2 text-sm text-[var(--foreground-muted)]">
              <Shield className="w-4 h-4 text-[var(--accent)]" />
              <span>Swiss Data Protection Compliant</span>
            </div>
          </div>

          {/* Links */}
          <div>
            <h4 className="font-semibold mb-4" style={{ fontFamily: 'var(--font-heading)' }}>Platform</h4>
            <ul className="space-y-3 text-sm text-[var(--foreground-muted)]">
              <li><a href="#" className="hover:text-white transition-colors">Courses</a></li>
              <li><a href="#" className="hover:text-white transition-colors">Pricing</a></li>
              <li><a href="#" className="hover:text-white transition-colors">How It Works</a></li>
              <li><a href="#" className="hover:text-white transition-colors">FAQ</a></li>
            </ul>
          </div>

          <div>
            <h4 className="font-semibold mb-4" style={{ fontFamily: 'var(--font-heading)' }}>Legal</h4>
            <ul className="space-y-3 text-sm text-[var(--foreground-muted)]">
              <li><a href="#" className="hover:text-white transition-colors">Privacy Policy</a></li>
              <li><a href="#" className="hover:text-white transition-colors">Terms of Service</a></li>
              <li><a href="#" className="hover:text-white transition-colors">Cookie Policy</a></li>
              <li><a href="#" className="hover:text-white transition-colors">Contact</a></li>
            </ul>
          </div>
        </div>

        {/* Bottom */}
        <div className="pt-8 border-t border-[var(--card-border)] flex flex-col md:flex-row justify-between items-center gap-4 text-sm text-[var(--foreground-muted)]">
          <p>&copy; {new Date().getFullYear()} Tutorio. All rights reserved.</p>
          <p>Made with ❤️ in Switzerland</p>
        </div>
      </div>
    </footer>
  );
}

// Main Page Component
export default function Home() {
  return (
    <main className="min-h-screen">
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
