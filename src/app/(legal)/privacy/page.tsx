export const metadata = {
  title: "Privacy Policy | Tutorio",
  description: "Learn how Tutorio collects, uses, and protects your personal information.",
};

export default function PrivacyPage() {
  return (
    <article className="prose prose-slate max-w-none">
      <h1 style={{ fontFamily: 'var(--font-heading)' }}>Privacy Policy</h1>
      <p className="text-[var(--foreground-muted)]">Last updated: {new Date().toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}</p>
      
      <h2>1. Introduction</h2>
      <p>
        Tutorio (&quot;we,&quot; &quot;our,&quot; or &quot;us&quot;) is committed to protecting your privacy. This Privacy Policy explains how we collect, 
        use, disclose, and safeguard your information when you use our learning platform.
      </p>
      
      <h2>2. Information We Collect</h2>
      <h3>2.1 Personal Information</h3>
      <p>We may collect personally identifiable information, such as:</p>
      <ul>
        <li>Name and email address</li>
        <li>Account credentials</li>
        <li>Payment information (processed securely by Stripe)</li>
        <li>Learning progress and activity data</li>
      </ul>
      
      <h3>2.2 Usage Data</h3>
      <p>
        We automatically collect certain information when you use our platform, including your IP address, 
        browser type, pages visited, and time spent on activities.
      </p>
      
      <h2>3. How We Use Your Information</h2>
      <p>We use the information we collect to:</p>
      <ul>
        <li>Provide and maintain our service</li>
        <li>Process your transactions</li>
        <li>Track your learning progress</li>
        <li>Send you updates and marketing communications (with your consent)</li>
        <li>Improve our platform and user experience</li>
      </ul>
      
      <h2>4. Data Security</h2>
      <p>
        We implement appropriate technical and organizational measures to protect your personal data. 
        However, no method of transmission over the Internet is 100% secure.
      </p>
      
      <h2>5. Your Rights</h2>
      <p>Under Swiss data protection law and GDPR (where applicable), you have the right to:</p>
      <ul>
        <li>Access your personal data</li>
        <li>Correct inaccurate data</li>
        <li>Request deletion of your data</li>
        <li>Object to processing of your data</li>
        <li>Data portability</li>
      </ul>
      
      <h2>6. Contact Us</h2>
      <p>
        If you have questions about this Privacy Policy, please contact us at{" "}
        <a href="mailto:privacy@tutorio.ch" className="text-[var(--primary)]">privacy@tutorio.ch</a>.
      </p>
    </article>
  );
}

