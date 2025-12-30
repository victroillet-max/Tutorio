import { ChevronDown } from "lucide-react";

export const metadata = {
  title: "FAQ | Tutorio",
  description: "Frequently asked questions about Tutorio learning platform.",
};

const faqs = [
  {
    question: "What is Tutorio?",
    answer: "Tutorio is an online learning platform designed for business school students. We offer AI-structured course summaries, exercises, video lessons, and interactive content to help you ace your exams."
  },
  {
    question: "How much does Tutorio cost?",
    answer: "We offer a free tier with preview content, a Basic plan at CHF 10/month for text summaries and exercises, and a Premium plan at CHF 25/month that includes video lessons, podcasts, and priority support."
  },
  {
    question: "Can I cancel my subscription anytime?",
    answer: "Yes! You can cancel your subscription at any time. You'll continue to have access until the end of your billing period. We also offer a 7-day money-back guarantee if you're not satisfied."
  },
  {
    question: "What courses do you offer?",
    answer: "We cover core business school subjects including Financial Accounting, Marketing Strategy, Corporate Finance, Microeconomics, Business Law, and more. New courses are added regularly."
  },
  {
    question: "How does the AI tutor work?",
    answer: "Our AI tutor, Bob, is available while you study. He can answer questions about your current activity, explain concepts, and guide you through difficult problems - all without giving away answers directly."
  },
  {
    question: "Can I access Tutorio on mobile?",
    answer: "Yes! Tutorio is fully responsive and works on all devices. Study on your laptop at home or review content on your phone while commuting."
  },
  {
    question: "Do you offer content for specific universities?",
    answer: "Our content is designed to cover core business concepts taught at Swiss universities including HEC, UNISG, ZHAW, and others. The fundamentals apply across institutions."
  },
  {
    question: "How do I track my progress?",
    answer: "Your dashboard shows your enrolled courses, completed activities, skill mastery levels, and study streaks. You can see exactly where you are in each course and what to focus on next."
  },
  {
    question: "What payment methods do you accept?",
    answer: "We accept all major credit cards, debit cards, and TWINT through our secure payment partner Stripe. All transactions are encrypted and secure."
  },
  {
    question: "I forgot my password. How do I reset it?",
    answer: "Click 'Forgot Password' on the login page and enter your email. You'll receive a link to reset your password. If you don't see the email, check your spam folder."
  }
];

export default function FAQPage() {
  return (
    <div className="max-w-2xl mx-auto">
      <h1 
        className="text-4xl font-bold mb-4 text-[var(--foreground)]"
        style={{ fontFamily: 'var(--font-heading)' }}
      >
        Frequently Asked Questions
      </h1>
      <p className="text-lg text-[var(--foreground-muted)] mb-8">
        Find answers to common questions about Tutorio.
      </p>
      
      <div className="space-y-4">
        {faqs.map((faq, index) => (
          <details 
            key={index}
            className="group bg-white rounded-xl border border-[var(--border)] overflow-hidden"
          >
            <summary className="flex items-center justify-between cursor-pointer p-5 font-medium text-[var(--foreground)] hover:bg-[var(--background-secondary)] transition-colors">
              {faq.question}
              <ChevronDown className="w-5 h-5 text-[var(--foreground-muted)] transition-transform group-open:rotate-180" />
            </summary>
            <div className="px-5 pb-5 text-[var(--foreground-muted)] border-t border-[var(--border)]">
              <p className="pt-4">{faq.answer}</p>
            </div>
          </details>
        ))}
      </div>
      
      <div className="mt-12 p-6 bg-[var(--progress-bg)]/50 rounded-xl border border-[var(--primary)]/20 text-center">
        <h3 className="font-semibold text-[var(--foreground)] mb-2">Still have questions?</h3>
        <p className="text-[var(--foreground-muted)] text-sm mb-4">
          Can&apos;t find what you&apos;re looking for? We&apos;re here to help.
        </p>
        <a 
          href="/contact" 
          className="inline-flex px-6 py-2.5 bg-[var(--primary)] text-white font-semibold rounded-lg hover:bg-[var(--primary-dark)] transition-colors"
        >
          Contact Us
        </a>
      </div>
    </div>
  );
}

