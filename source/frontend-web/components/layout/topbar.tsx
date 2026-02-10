"use client";

import { useTheme } from "@/lib/theme-context";
import { useAuth } from "@/lib/auth-context";
import { Moon, Sun, LogOut } from "lucide-react";

export function Topbar() {
  const { theme, toggleTheme } = useTheme();
  const { user, logout } = useAuth();

  const initials =
    user?.username
      ?.split(" ")
      .map((p) => p[0])
      .join("")
      .slice(0, 2)
      .toUpperCase() || "U";

  return (
    <header className="h-16 flex items-center justify-between px-6 border-b border-borderSubtle bg-elevated">
      <input
        type="text"
        placeholder="Buscar..."
        className="hidden md:block w-64 px-3 py-2 rounded-lg bg-background border border-borderSubtle text-text-primary placeholder:text-text-secondary/40 text-sm"
      />

      <div className="flex items-center gap-4">
        {/* Toggle tema */}
        <button
          onClick={toggleTheme}
          className="flex items-center gap-1 px-3 py-1.5 rounded-full border border-borderSubtle bg-background text-xs text-text-secondary hover:bg-borderSubtle/30 transition-colors"
          title={theme === "dark" ? "Cambiar a modo claro" : "Cambiar a modo oscuro"}
        >
          {theme === "dark" ? (
            <>
              <Sun size={14} />
              <span>Claro</span>
            </>
          ) : (
            <>
              <Moon size={14} />
              <span>Oscuro</span>
            </>
          )}
        </button>

        {/* Avatar + logout */}
        <div className="flex items-center gap-2">
          <div className="h-8 w-8 rounded-full bg-brand-secondary flex items-center justify-center text-xs font-semibold text-white">
            {initials}
          </div>
          <button
            onClick={logout}
            className="hidden sm:inline-flex items-center gap-1 text-xs text-text-secondary hover:text-red-400"
          >
            <LogOut size={14} />
            <span>Salir</span>
          </button>
        </div>
      </div>
    </header>
  );
}
