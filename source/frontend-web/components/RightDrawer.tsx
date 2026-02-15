// components/RightDrawer.tsx
"use client";

import { ReactNode, useEffect } from "react";
import { X } from "lucide-react";

export function RightDrawer({
  open,
  title,
  subtitle,
  headerRight,
  onClose,
  children,
}: {
  open: boolean;
  title: string;
  subtitle?: string;
  headerRight?: ReactNode;
  onClose: () => void;
  children: ReactNode;
}) {
  useEffect(() => {
    if (!open) return;
    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose();
    };
    window.addEventListener("keydown", onKeyDown);
    return () => window.removeEventListener("keydown", onKeyDown);
  }, [open, onClose]);

  if (!open) return null;

  return (
    <div className="fixed inset-0 z-50">
      {/* overlay */}
      <button
        aria-label="Cerrar"
        onClick={onClose}
        className="absolute inset-0 bg-black/30 backdrop-blur-[1px]"
      />

      {/* panel */}
      <aside className="absolute right-0 top-0 h-full w-full
  sm:w-[600px] lg:w-[680px] 2xl:w-[820px]
  bg-white dark:bg-slate-950 border-l border-white/10 shadow-2xl flex flex-col">

        {/* header sticky */}
        <div className="sticky top-0 z-10 px-5 py-4 border-b border-white/10 bg-white/90 dark:bg-slate-950/90 backdrop-blur">
          <div className="flex items-start justify-between gap-4">
            <div className="min-w-0">
              <div className="text-sm font-semibold tracking-wide truncate">
                {title}
              </div>
              {subtitle && (
                <div className="text-xs text-muted-foreground truncate">
                  {subtitle}
                </div>
              )}
            </div>

            <div className="flex items-center gap-2">
              {headerRight}
              <button
                onClick={onClose}
                className="rounded-md p-2 hover:bg-black/5 dark:hover:bg-white/5 transition-colors"
                aria-label="Cerrar drawer"
              >
                <X className="h-4 w-4" />
              </button>
            </div>
          </div>
        </div>

        {/* body */}
        <div className="flex-1 overflow-y-auto px-5 py-4">{children}</div>
      </aside>
    </div>
  );
}
