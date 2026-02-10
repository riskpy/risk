"use client";

import React, { createContext, useContext, useEffect, useState } from "react";
import { usePathname } from "next/navigation";

type Theme = "light" | "dark";

type ThemeContextType = {
  theme: Theme;
  toggleTheme: () => void;
};

const ThemeContext = createContext<ThemeContextType>({
  theme: "dark",
  toggleTheme: () => {},
});

const THEME_KEY = "risk-theme";

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();

  // ✔️ Siempre dark por defecto
  const [theme, setTheme] = useState<Theme>("dark");

  const isLoginPage = pathname === "/login";

  useEffect(() => {
    // En login NO aplicar preferencia del sistema ni leer localStorage
    if (isLoginPage) {
      applyTheme("dark");
      return;
    }

    const stored = localStorage.getItem(THEME_KEY) as Theme | null;

    const prefersDark =
      window.matchMedia &&
      window.matchMedia("(prefers-color-scheme: dark)").matches;

    const initial: Theme = stored ?? (prefersDark ? "dark" : "light");

    setTheme(initial);
    applyTheme(initial);
  }, [isLoginPage]);

  const applyTheme = (t: Theme) => {
    document.documentElement.setAttribute("data-theme", t);

    if (t === "dark") {
      document.documentElement.classList.add("dark");
    } else {
      document.documentElement.classList.remove("dark");
    }
  };

  const toggleTheme = () => {
    if (isLoginPage) return; // Bloqueado para login

    const next: Theme = theme === "dark" ? "light" : "dark";
    setTheme(next);
    localStorage.setItem(THEME_KEY, next);
    applyTheme(next);
  };

  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  return useContext(ThemeContext);
}
