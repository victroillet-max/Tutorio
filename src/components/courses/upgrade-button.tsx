"use client";

import { useRouter } from "next/navigation";
import { ArrowUpRight } from "lucide-react";

interface UpgradeButtonProps {
  courseSlug: string;
}

export function UpgradeButton({ courseSlug }: UpgradeButtonProps) {
  const router = useRouter();

  const handleClick = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    router.push(`/pricing?course=${courseSlug}`);
  };

  return (
    <button
      onClick={handleClick}
      className="flex items-center justify-center gap-1 px-4 py-1.5 border border-[var(--accent)] text-[var(--accent)] text-sm font-medium rounded-lg hover:bg-[var(--accent)] hover:text-white transition-colors"
    >
      <ArrowUpRight className="w-3 h-3" />
      Upgrade
    </button>
  );
}


