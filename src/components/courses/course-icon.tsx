"use client";

import Image from "next/image";

// Course slug to icon mapping
const courseIcons: Record<string, { src: string; alt: string }> = {
  "computational-thinking": {
    src: "/course-icon-ct.svg",
    alt: "Computational Thinking",
  },
  "financial-accounting": {
    src: "/course-icon-fa.svg",
    alt: "Financial Accounting",
  },
  "business-mathematics": {
    src: "/course-icon-bm.svg",
    alt: "Business Mathematics",
  },
  "managerial-accounting": {
    src: "/course-icon-ma.svg",
    alt: "Managerial Accounting",
  },
};

// Color schemes for each course (for fallback and styling)
export const courseColors: Record<string, { bg: string; text: string; gradient: string }> = {
  "computational-thinking": {
    bg: "bg-[#FEE2D5]",
    text: "text-[#E76F51]",
    gradient: "from-[#E76F51] to-[#F4A261]",
  },
  "financial-accounting": {
    bg: "bg-[#D1FAE5]",
    text: "text-[#2A9D8F]",
    gradient: "from-[#2A9D8F] to-[#40C9B4]",
  },
  "business-mathematics": {
    bg: "bg-[#FEF3C7]",
    text: "text-[#D97706]",
    gradient: "from-[#D97706] to-[#F59E0B]",
  },
  "managerial-accounting": {
    bg: "bg-[#E0E7FF]",
    text: "text-[#4F46E5]",
    gradient: "from-[#4F46E5] to-[#818CF8]",
  },
};

// Default colors for unknown courses
const defaultColors = {
  bg: "bg-slate-100",
  text: "text-slate-600",
  gradient: "from-slate-500 to-slate-400",
};

interface CourseIconProps {
  courseSlug: string;
  size?: "sm" | "md" | "lg" | "xl";
  className?: string;
}

const sizeClasses = {
  sm: "w-10 h-10",
  md: "w-12 h-12",
  lg: "w-14 h-14",
  xl: "w-16 h-16",
};

const imageSizes = {
  sm: 40,
  md: 48,
  lg: 56,
  xl: 64,
};

export function CourseIcon({ courseSlug, size = "md", className = "" }: CourseIconProps) {
  const icon = courseIcons[courseSlug];
  
  if (icon) {
    return (
      <Image
        src={icon.src}
        alt={icon.alt}
        width={imageSizes[size]}
        height={imageSizes[size]}
        className={`${sizeClasses[size]} ${className}`}
      />
    );
  }
  
  // Fallback to a gradient placeholder
  const colors = courseColors[courseSlug] || defaultColors;
  
  return (
    <div className={`${sizeClasses[size]} rounded-xl bg-gradient-to-br ${colors.gradient} flex items-center justify-center ${className}`}>
      <svg
        className="w-1/2 h-1/2 text-white"
        fill="none"
        viewBox="0 0 24 24"
        stroke="currentColor"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"
        />
      </svg>
    </div>
  );
}

// Utility function to get course colors
export function getCourseColors(courseSlug: string) {
  return courseColors[courseSlug] || defaultColors;
}

