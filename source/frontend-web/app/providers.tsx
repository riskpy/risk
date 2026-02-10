"use client";

import { usePathname } from "next/navigation";
import { ThemeProvider } from "@/lib/theme-context";
import { AuthProvider } from "@/lib/auth-context";
import SessionExpiringModal from "@/components/SessionExpiringModal";
import { useSessionWatcher } from "@/lib/useSessionWatcher";

export function AppProviders({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const isLoginPage = pathname.startsWith("/login");

  // EN LOGIN: NO THEME PROVIDER → evita aplicar tema claro o leer localStorage
  if (isLoginPage) {
    return (
      <ThemeProvider>
        <AuthProvider>
          {children}
        </AuthProvider>
      </ThemeProvider>
    );
  }

  return (
    <ThemeProvider>
      <AuthProvider>
        <InnerProviders>{children}</InnerProviders>
      </AuthProvider>
    </ThemeProvider>
  );
}

function InnerProviders({ children }: { children: React.ReactNode }) {
  const {
    showWarning,
    secondsRemaining,
    handleRefreshClick,
    handleLogoutClick,
    handleIgnoreWarning,
  } = useSessionWatcher();

  return (
    <>
      {children}

      <SessionExpiringModal
        open={showWarning}
        secondsRemaining={secondsRemaining ?? 0}
        onRefresh={handleRefreshClick}     // botón "Renovar"
        onDismiss={handleLogoutClick}      // botón "Cerrar sesión"
        onIgnore={handleIgnoreWarning}     // botón "X"
      />
    </>
  );
}