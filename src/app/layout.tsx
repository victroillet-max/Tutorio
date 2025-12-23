import type { Metadata } from "next";
import { Space_Grotesk, DM_Sans } from "next/font/google";
import "./globals.css";

const spaceGrotesk = Space_Grotesk({
  variable: "--font-heading",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
});

const dmSans = DM_Sans({
  variable: "--font-body",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
});

export const metadata: Metadata = {
  title: "Tutorio | Master Your Business Courses",
  description: "The smart way to ace your business school exams. AI-powered summaries, exercises, and premium content tailored for Swiss business students.",
  keywords: ["tutoring", "business school", "Switzerland", "online learning", "HEC", "UNISG", "exam preparation"],
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark">
      <body
        className={`${spaceGrotesk.variable} ${dmSans.variable} antialiased`}
        style={{ fontFamily: 'var(--font-body), system-ui, sans-serif' }}
      >
        {children}
      </body>
    </html>
  );
}
