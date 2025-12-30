import { Mail, MapPin, Clock } from "lucide-react";

export const metadata = {
  title: "Contact Us | Tutorio",
  description: "Get in touch with the Tutorio team.",
};

export default function ContactPage() {
  return (
    <div className="max-w-2xl mx-auto">
      <h1 
        className="text-4xl font-bold mb-4 text-[var(--foreground)]"
        style={{ fontFamily: 'var(--font-heading)' }}
      >
        Contact Us
      </h1>
      <p className="text-lg text-[var(--foreground-muted)] mb-8">
        Have questions, feedback, or need support? We&apos;d love to hear from you.
      </p>
      
      <div className="space-y-6 mb-12">
        <div className="flex items-start gap-4 p-6 bg-white rounded-xl border border-[var(--border)]">
          <div className="w-12 h-12 rounded-lg bg-[var(--progress-bg)] flex items-center justify-center flex-shrink-0">
            <Mail className="w-6 h-6 text-[var(--primary)]" />
          </div>
          <div>
            <h3 className="font-semibold text-[var(--foreground)] mb-1">Email Us</h3>
            <p className="text-[var(--foreground-muted)] text-sm mb-2">
              For general inquiries and support
            </p>
            <a 
              href="mailto:hello@tutorio.ch" 
              className="text-[var(--primary)] font-medium hover:underline"
            >
              hello@tutorio.ch
            </a>
          </div>
        </div>
        
        <div className="flex items-start gap-4 p-6 bg-white rounded-xl border border-[var(--border)]">
          <div className="w-12 h-12 rounded-lg bg-[var(--progress-bg)] flex items-center justify-center flex-shrink-0">
            <MapPin className="w-6 h-6 text-[var(--primary)]" />
          </div>
          <div>
            <h3 className="font-semibold text-[var(--foreground)] mb-1">Location</h3>
            <p className="text-[var(--foreground-muted)] text-sm">
              Based in Switzerland
            </p>
          </div>
        </div>
        
        <div className="flex items-start gap-4 p-6 bg-white rounded-xl border border-[var(--border)]">
          <div className="w-12 h-12 rounded-lg bg-[var(--progress-bg)] flex items-center justify-center flex-shrink-0">
            <Clock className="w-6 h-6 text-[var(--primary)]" />
          </div>
          <div>
            <h3 className="font-semibold text-[var(--foreground)] mb-1">Response Time</h3>
            <p className="text-[var(--foreground-muted)] text-sm">
              We typically respond within 24-48 hours on business days.
            </p>
          </div>
        </div>
      </div>
      
      <div className="p-6 bg-[var(--progress-bg)]/50 rounded-xl border border-[var(--primary)]/20">
        <h3 className="font-semibold text-[var(--foreground)] mb-2">Need Immediate Help?</h3>
        <p className="text-[var(--foreground-muted)] text-sm">
          Check out our <a href="/faq" className="text-[var(--primary)] font-medium hover:underline">FAQ page</a> for 
          answers to common questions, or use the chat assistant available when you&apos;re logged in.
        </p>
      </div>
    </div>
  );
}

