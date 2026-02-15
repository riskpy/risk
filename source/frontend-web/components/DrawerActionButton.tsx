// components/DrawerActionButton.tsx
"use client";

import { ReactNode } from "react";

export function DrawerActionButton({
  icon,
  label,
  disabledReason,
}: {
  icon: ReactNode;
  label: string;
  disabledReason?: string;
}) {
  const disabled = Boolean(disabledReason);

  return (
    <button
      type="button"
      disabled={disabled}
      title={disabledReason ?? label}
      className={`rounded-md px-2 py-2 text-xs border border-white/10
        ${disabled
          ? "opacity-50 cursor-not-allowed"
          : "hover:bg-black/5 dark:hover:bg-white/5 transition-colors"
        }`}
      aria-label={label}
    >
      <span className="flex items-center gap-2">
        {icon}
        <span className="hidden sm:inline">{label}</span>
      </span>
    </button>
  );
}
