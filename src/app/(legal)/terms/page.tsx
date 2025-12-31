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
      <p>
        Subscription fees are billed monthly and processed securely through Stripe. 
        By subscribing, you agree to the following billing terms:
      </p>
      
      <h3>4.1 Subscription Tiers</h3>
      <p>
        We offer multiple subscription tiers (Basic and Advanced) with different features and pricing. 
        You may change your subscription tier at any time, subject to the terms below.
      </p>
      
      <h3>4.2 Upgrades</h3>
      <p>
        When you upgrade to a higher tier, the change takes effect immediately. You will be charged 
        a prorated amount for the remainder of your current billing period, and your new tier benefits 
        become available right away.
      </p>
      
      <h3>4.3 Downgrades</h3>
      <p>
        When you downgrade to a lower tier, your current subscription benefits remain active until the 
        end of your current billing period. The lower tier will take effect at the start of your next 
        billing period. <strong>No refunds or credits are issued for downgrades.</strong>
      </p>
      
      <h3>4.4 Cancellations</h3>
      <p>
        You may cancel your subscription at any time. Upon cancellation, you will retain access to 
        your subscription benefits until the end of your current billing period. After the billing 
        period ends, your subscription will expire and you will revert to free access. 
        <strong>No refunds are provided for cancellations.</strong>
      </p>
      
      <h3>4.5 No Refund Policy</h3>
      <p>
        Tutorio operates a strict no-refund policy. Once a payment is made, it is non-refundable. 
        This applies to all subscription payments, regardless of usage or early cancellation. 
        We encourage you to take advantage of any free trial or demo access before subscribing.
      </p>
      
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

