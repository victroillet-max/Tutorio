import * as React from "react"
import { Slot } from "@radix-ui/react-slot"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const buttonVariants = cva(
  "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-xl text-sm font-semibold transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none focus-visible:ring-2 focus-visible:ring-[var(--primary)]/50 focus-visible:ring-offset-2",
  {
    variants: {
      variant: {
        default: "bg-[var(--primary)] text-white hover:bg-[var(--primary-light)] shadow-md shadow-[var(--primary)]/25 hover:shadow-lg hover:-translate-y-0.5",
        accent: "bg-[var(--accent)] text-white hover:bg-[var(--accent-dark)] shadow-md shadow-[var(--accent)]/30 hover:shadow-lg hover:-translate-y-0.5",
        destructive:
          "bg-[var(--destructive)] text-white hover:bg-[var(--destructive)]/90 shadow-md shadow-[var(--destructive)]/25",
        outline:
          "border-2 border-[var(--card-border)] bg-white hover:bg-[var(--background-secondary)] hover:border-[var(--primary)] hover:text-[var(--primary)]",
        secondary:
          "bg-[var(--secondary)] text-[var(--secondary-foreground)] hover:bg-[var(--background-tertiary)]",
        ghost:
          "hover:bg-[var(--background-secondary)] hover:text-[var(--primary)]",
        link: "text-[var(--accent)] underline-offset-4 hover:underline",
      },
      size: {
        default: "h-11 px-5 py-2.5",
        sm: "h-9 rounded-lg gap-1.5 px-4 text-xs",
        lg: "h-13 rounded-xl px-7 text-base",
        icon: "size-11",
        "icon-sm": "size-9",
        "icon-lg": "size-13",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

function Button({
  className,
  variant = "default",
  size = "default",
  asChild = false,
  ...props
}: React.ComponentProps<"button"> &
  VariantProps<typeof buttonVariants> & {
    asChild?: boolean
  }) {
  const Comp = asChild ? Slot : "button"

  return (
    <Comp
      data-slot="button"
      data-variant={variant}
      data-size={size}
      className={cn(buttonVariants({ variant, size, className }))}
      {...props}
    />
  )
}

export { Button, buttonVariants }
