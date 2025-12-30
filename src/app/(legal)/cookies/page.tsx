export const metadata = {
  title: "Cookie Policy | Tutorio",
  description: "Learn about how Tutorio uses cookies and similar technologies.",
};

export default function CookiesPage() {
  return (
    <article className="prose prose-slate max-w-none">
      <h1 style={{ fontFamily: 'var(--font-heading)' }}>Cookie Policy</h1>
      <p className="text-[var(--foreground-muted)]">Last updated: {new Date().toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}</p>
      
      <h2>1. What Are Cookies?</h2>
      <p>
        Cookies are small text files stored on your device when you visit a website. They help 
        the website remember your preferences and improve your experience.
      </p>
      
      <h2>2. How We Use Cookies</h2>
      <h3>2.1 Essential Cookies</h3>
      <p>
        These cookies are necessary for the platform to function properly. They enable features 
        like user authentication and session management.
      </p>
      
      <h3>2.2 Analytics Cookies</h3>
      <p>
        We use analytics cookies to understand how visitors interact with our platform. This helps 
        us improve our content and user experience.
      </p>
      
      <h3>2.3 Preference Cookies</h3>
      <p>
        These cookies remember your preferences, such as language settings and learning progress.
      </p>
      
      <h2>3. Third-Party Cookies</h2>
      <p>We may use third-party services that set their own cookies:</p>
      <ul>
        <li><strong>Stripe:</strong> For secure payment processing</li>
        <li><strong>Supabase:</strong> For authentication and data storage</li>
        <li><strong>Analytics providers:</strong> To understand usage patterns</li>
      </ul>
      
      <h2>4. Managing Cookies</h2>
      <p>
        You can control cookies through your browser settings. However, disabling certain cookies 
        may affect the functionality of our platform.
      </p>
      
      <h2>5. Updates to This Policy</h2>
      <p>
        We may update this Cookie Policy from time to time. We will notify you of significant changes 
        by posting the new policy on this page.
      </p>
      
      <h2>6. Contact Us</h2>
      <p>
        If you have questions about our use of cookies, please contact us at{" "}
        <a href="mailto:privacy@tutorio.ch" className="text-[var(--primary)]">privacy@tutorio.ch</a>.
      </p>
    </article>
  );
}

