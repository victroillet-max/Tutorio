"use client";

import Link from "next/link";
import { ArrowUpRight } from "lucide-react";

interface UpgradeButtonProps {
  courseSlug: string;
}

export function UpgradeButton({ courseSlug }: UpgradeButtonProps) {
  return (
    <span
      onClick={(e) => e.stopPropagation()}
      className="block"
    >
      <Link
        href={`/pricing?course=${courseSlug}`}
        className="flex items-center justify-center gap-1 px-4 py-1.5 border border-[var(--accent)] text-[var(--accent)] text-sm font-medium rounded-lg hover:bg-[var(--accent)] hover:text-white transition-colors"
        onClick={(e) => e.stopPropagation()}
      >
        <ArrowUpRight className="w-3 h-3" />
        Upgrade
      </Link>
    </span>
  );
}

