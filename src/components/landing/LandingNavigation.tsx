"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import { Menu, X } from "lucide-react";

export function LandingNavigation() {
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

