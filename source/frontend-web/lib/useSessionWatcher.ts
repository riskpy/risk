"use client";

import { useEffect, useState } from "react";
import { useAuth } from "./auth-context";

export function useSessionWatcher() {
  const { session, refreshSession, logout } = useAuth();

  const [showWarning, setShowWarning] = useState(false);
  const [secondsRemaining, setSecondsRemaining] = useState<number | null>(null);

  // Nuevo flag: usuario ignoró el aviso ("X")
  const [ignoredWarning, setIgnoredWarning] = useState(false);

  const WARNING_SECONDS =
    Number(process.env.NEXT_PUBLIC_RISK_EXPIRATION_WARNING_SECONDS) || 45;

  useEffect(() => {
    if (!session) {
      setShowWarning(false);
      setSecondsRemaining(null);
      setIgnoredWarning(false);
      return;
    }

    // La expiración REAL debe venir del backend o calculada al iniciar sesión
    const expiresAt = session.expiryAt; // <-- timestamp absoluto en ms

    const interval = setInterval(() => {
      const remaining = Math.floor((expiresAt - Date.now()) / 1000);

      // Expiró → logout automático
      if (remaining <= 0) {
        clearInterval(interval);
        logout();
        return;
      }

      setSecondsRemaining(remaining);

      // Mostrar popup dentro del umbral elegido y si NO se ignoró
      if (remaining <= WARNING_SECONDS && !ignoredWarning) {
        setShowWarning(true);
      }
    }, 1000);

    return () => clearInterval(interval);
  }, [
    session?.expiryAt,          // se recalcula al refrescar token
    WARNING_SECONDS,
    logout,
    ignoredWarning              // si ignoró, no vuelve a mostrar popup
  ]);

  // -----------------------------------
  // HANDLERS PARA EL POPUP
  // -----------------------------------

  // Botón "Renovar sesión"
  const handleRefreshClick = async () => {
    const ok = await refreshSession();
    if (ok) {
      setShowWarning(false);
      setIgnoredWarning(false); // ← permitir mostrar popup nuevamente para la nueva ventana de tiempo
      setSecondsRemaining(null);
    } else {
      await logout();
    }
  };

  // Botón "Cerrar sesión"
  const handleLogoutClick = async () => {
    setShowWarning(false);
    setSecondsRemaining(null);
    setIgnoredWarning(false);
    await logout();
  };

  // Botón "X" → ignorar aviso pero no cerrar sesión
  const handleIgnoreWarning = () => {
    setShowWarning(false);
    setIgnoredWarning(true);  // ← no vuelve a mostrar el popup en esta sesión
  };

  return {
    showWarning,
    secondsRemaining: secondsRemaining ?? 0,
    handleRefreshClick,
    handleLogoutClick,      // cerrar sesión
    handleIgnoreWarning     // ignorar aviso
  };
}
