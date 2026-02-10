import "../styles/globals.css";
import "../styles/tokens.css";

import type { Metadata } from "next";
import { AppProviders } from "./providers";

export const metadata: Metadata = {
  title: "RISK",
  description: "Control total. Gestión inteligente.",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es" suppressHydrationWarning>

      <head>
        {/* Script para aplicar el tema ANTES de hidratar */}
        <script
          dangerouslySetInnerHTML={{
            __html: `
              (function() {
                var path = window.location.pathname;

                // Si estamos en /login → SIEMPRE dark
                if (path === "/login") {
                  document.documentElement.dataset.theme = "dark";
                  document.documentElement.classList.add("dark");
                  return;
                }

                // Para el resto, usar localStorage
                try {
                  var t = localStorage.getItem("risk-theme") || "light";
                  document.documentElement.dataset.theme = t;

                  if (t === "dark") {
                    document.documentElement.classList.add("dark");
                  } else {
                    document.documentElement.classList.remove("dark");
                  }
                } catch (e) {}
              })();
            `,
          }}
        />
      </head>

      <body className="min-h-screen">
        <AppProviders>{children}</AppProviders>
      </body>
    </html>
  );
}
