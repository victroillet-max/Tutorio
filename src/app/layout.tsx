import type { Metadata } from "next";
import { Poppins } from "next/font/google";
import { Toaster } from "@/components/ui/sonner";
import "./globals.css";

const poppins = Poppins({
  variable: "--font-body",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
});

const poppinsHeading = Poppins({
  variable: "--font-heading",
  subsets: ["latin"],
  weight: ["600", "700"],
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
    <html lang="en">
      <body
        className={`${poppins.variable} ${poppinsHeading.variable} antialiased`}
        style={{ fontFamily: 'var(--font-body), system-ui, sans-serif' }}
      >
        {children}
        <Toaster position="top-right" />
      </body>
    </html>
  );
}
