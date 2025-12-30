import Link from "next/link";
import { BookOpen, ChevronLeft } from "lucide-react";

export default function LegalLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen bg-[var(--background)]">
      {/* Header */}
      <header className="sticky top-0 z-50 bg-white border-b border-[var(--border)]">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            {/* Logo */}
            <Link href="/" className="flex items-center gap-2 group">
              <div className="w-9 h-9 rounded-lg bg-[var(--primary)] flex items-center justify-center transition-transform group-hover:scale-105">
                <BookOpen className="w-4 h-4 text-white" />
              </div>
              <span 
                className="text-lg font-bold tracking-tight text-[var(--foreground)]"
                style={{ fontFamily: 'var(--font-heading)' }}
              >
                Tutorio
              </span>
            </Link>
            
            {/* Back Link */}
            <Link
              href="/"
              className="flex items-center gap-1 text-sm text-[var(--foreground-muted)] hover:text-[var(--primary)] transition-colors"
            >
              <ChevronLeft className="w-4 h-4" />
              Back to Home
            </Link>
          </div>
        </div>
      </header>

      {/* Content */}
      <main className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {children}
      </main>
      
      {/* Footer */}
      <footer className="border-t border-[var(--border)] py-8">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center text-sm text-[var(--foreground-muted)]">
          <p>&copy; {new Date().getFullYear()} Tutorio. All rights reserved.</p>
        </div>
      </footer>
    </div>
  );
}

