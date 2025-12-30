export const metadata = {
  title: "Terms of Service | Tutorio",
  description: "Terms and conditions for using the Tutorio learning platform.",
};

export default function TermsPage() {
  return (
    <article className="prose prose-slate max-w-none">
      <h1 style={{ fontFamily: 'var(--font-heading)' }}>Terms of Service</h1>
      <p className="text-[var(--foreground-muted)]">Last updated: {new Date().toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}</p>
      
      <h2>1. Acceptance of Terms</h2>
      <p>
        By accessing or using Tutorio, you agree to be bound by these Terms of Service. 
        If you do not agree to these terms, please do not use our platform.
      </p>
      
      <h2>2. Description of Service</h2>
      <p>
        Tutorio provides an online learning platform offering educational content, including lessons, 
        exercises, quizzes, and video content for business school students.
      </p>
      
      <h2>3. User Accounts</h2>
      <p>
        To access certain features, you must create an account. You are responsible for maintaining 
        the confidentiality of your account credentials and for all activities under your account.
      </p>
      
      <h2>4. Subscription and Payments</h2>
      <ul>
        <li>Subscription fees are billed monthly or annually as selected</li>
        <li>Payments are processed securely through Stripe</li>
        <li>You may cancel your subscription at any time</li>
        <li>Refunds are provided within 7 days of initial purchase if requested</li>
      </ul>
      
      <h2>5. Intellectual Property</h2>
      <p>
        All content on Tutorio, including text, graphics, logos, and software, is the property 
        of Tutorio or its content suppliers and is protected by intellectual property laws.
      </p>
      
      <h2>6. Prohibited Conduct</h2>
      <p>You agree not to:</p>
      <ul>
        <li>Share your account with others</li>
        <li>Copy or redistribute course content</li>
        <li>Use automated systems to access the platform</li>
        <li>Violate any applicable laws or regulations</li>
      </ul>
      
      <h2>7. Disclaimer of Warranties</h2>
      <p>
        Tutorio is provided &quot;as is&quot; without warranties of any kind. We do not guarantee 
        specific exam results or academic outcomes.
      </p>
      
      <h2>8. Limitation of Liability</h2>
      <p>
        To the maximum extent permitted by law, Tutorio shall not be liable for any indirect, 
        incidental, or consequential damages arising from your use of the platform.
      </p>
      
      <h2>9. Governing Law</h2>
      <p>
        These terms are governed by Swiss law. Any disputes shall be resolved in the courts of Switzerland.
      </p>
      
      <h2>10. Contact</h2>
      <p>
        For questions about these Terms, contact us at{" "}
        <a href="mailto:legal@tutorio.ch" className="text-[var(--primary)]">legal@tutorio.ch</a>.
      </p>
    </article>
  );
}

