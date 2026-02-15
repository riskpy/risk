// components/DisclosureBox.tsx
"use client";

import { useState, ReactNode } from "react";
import { ChevronDown } from "lucide-react";

interface DisclosureBoxProps {
  title: string;
  subtitle?: string;
  count?: number;
  children: ReactNode;
  defaultOpen?: boolean;
}

export function DisclosureBox({
  title,
  subtitle,
  count,
  children,
  defaultOpen = false,
}: DisclosureBoxProps) {
  const [open, setOpen] = useState(defaultOpen);

  return (
    <div className="rounded-xl border border-white/10 bg-white/90 dark:bg-slate-900/60 backdrop-blur">
      <button
        type="button"
        onClick={() => setOpen(!open)}
        className="w-full flex items-center justify-between gap-4 px-5 py-4 text-left hover:bg-black/5 dark:hover:bg-white/5 transition-colors"
      >
        <div className="flex flex-col">
          <span className="text-sm font-semibold tracking-wide">
            {title}
          </span>
          {subtitle && (
            <span className="text-xs text-muted-foreground">
              {subtitle}
            </span>
          )}
        </div>

        <div className="flex items-center gap-3">
          {typeof count === "number" && (
            <span className="text-xs rounded-full bg-black/5 dark:bg-white/10 px-2 py-0.5">
              {count}
            </span>
          )}
          <ChevronDown
            className={`h-4 w-4 transition-transform duration-300 ${
              open ? "rotate-180" : ""
            }`}
          />
        </div>
      </button>

      <div
        className={`grid transition-all duration-300 ease-out ${
          open
            ? "grid-rows-[1fr] opacity-100"
            : "grid-rows-[0fr] opacity-0"
        }`}
      >
        <div className="overflow-hidden px-5 pb-4">
          {children}
        </div>
      </div>
    </div>
  );
}
