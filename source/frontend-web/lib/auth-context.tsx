"use client";

import React, { createContext, useContext, useRef, useEffect, useState } from "react";
import { useRouter } from "next/navigation";

// -------------------------------
// Types
// -------------------------------
type User = {
  username: string;
};

type SessionInfo = {
  idSesion: number;
  estado: string;
  accessToken: string;
  refreshToken: string;
  tiempoExpiracionAccessToken: number;     // segundos
  tiempoExpiracionRefreshToken: number;    // horas
  expiryAt: number;   // timestamp absoluto en milisegundos (Date.now())
};

type AuthContextType = {
  user: User | null;
  session: SessionInfo | null;
  loggingIn: boolean;
  loadingSession: boolean;

  login: (
    usuario: string,
    clave: string
  ) => Promise<{ ok: boolean; error?: string }>;

  logout: () => Promise<void>;

  // Nuevo: refrescar sesión manualmente (para el popup o 401)
  refreshSession: () => Promise<boolean>;
};

// -------------------------------
// Context
// -------------------------------
const AuthContext = createContext<AuthContextType>({
  user: null,
  session: null,
  loggingIn: false,
  loadingSession: true,
  login: async () => ({ ok: false }),
  logout: async () => {},
  refreshSession: async () => false,
});

// -------------------------------
// LocalStorage keys
// -------------------------------
const LS_USER = "risk-user";
const LS_SESSION = "risk-session";

// -------------------------------
// .ENV config
// -------------------------------
const API_BASE = process.env.NEXT_PUBLIC_API_BASE_URL ?? "";
const API_KEY_HEADER =
  process.env.NEXT_PUBLIC_RISK_API_KEY_HEADER ?? "Risk-App-Key";
const API_KEY_VALUE = process.env.NEXT_PUBLIC_RISK_API_KEY_VALUE ?? "";
const DEVICE_TOKEN = process.env.NEXT_PUBLIC_RISK_DEVICE_TOKEN ?? "FRONTEND";
const SERVICE_VERSION = process.env.NEXT_PUBLIC_RISK_SERVICE_VERSION ?? "";

// -------------------------------
// Helper: common headers
// -------------------------------
const buildCommonHeaders = () => {
  const headers: Record<string, string> = {
    "Content-Type": "application/json",
    "Risk-Device-Token": DEVICE_TOKEN,
    "Risk-Service-Version": SERVICE_VERSION,
  };

  if (API_KEY_VALUE) {
    headers[API_KEY_HEADER] = API_KEY_VALUE;
  }

  return headers;
};

// -------------------------------
// Helper: headers con Bearer token
// -------------------------------
const buildAuthHeaders = (session: SessionInfo | null) => {
  const h = buildCommonHeaders();

  if (session?.accessToken) {
    h["Authorization"] = `Bearer ${session.accessToken}`;
  }

  return h;
};

// -------------------------------
// Provider
// -------------------------------
export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [session, setSession] = useState<SessionInfo | null>(null);
  const [loggingIn, setLoggingIn] = useState(false);
  const [loadingSession, setLoadingSession] = useState(true);
  const router = useRouter();

  // -------------------------------
  // Helpers save / clear session
  // -------------------------------
  const saveSession = (s: SessionInfo, u: User) => {
    setSession(s);
    setUser(u);

    if (typeof window !== "undefined") {
      localStorage.setItem(LS_SESSION, JSON.stringify(s));
      localStorage.setItem(LS_USER, JSON.stringify(u));
    }
  };

  const clearSession = () => {
    setSession(null);
    setUser(null);
    if (typeof window !== "undefined") {
      localStorage.removeItem(LS_SESSION);
      localStorage.removeItem(LS_USER);
    }
  };

  // -------------------------------
  // Cargar sesión desde storage
  // -------------------------------
  useEffect(() => {
    if (typeof window === "undefined") return;

    try {
      const storedUser = localStorage.getItem(LS_USER);
      const storedSession = localStorage.getItem(LS_SESSION);

      if (storedUser) setUser(JSON.parse(storedUser));
      if (storedSession) setSession(JSON.parse(storedSession));
    } catch (e) {
      console.error("Error leyendo sesión almacenada:", e);
      clearSession();
    } finally {
        setLoadingSession(false);
    }
  }, []);

  // -----------------------------------------------
  // Refrescar sesión automáticamente al hacer F5
  // -----------------------------------------------
  const didAutoRefresh = useRef(false);

  useEffect(() => {
    if (!session) return;
    if (didAutoRefresh.current) return; // <-- ya lo hicimos antes, NO repetir

    didAutoRefresh.current = true; // <-- marcar como ejecutado

    const doRefreshOnMount = async () => {
      const ok = await refreshSession();
      if (!ok) {
        await logout();
      }
    };

    doRefreshOnMount();
  }, [session]);

  // -------------------------------
  // LOGIN
  // -------------------------------
  const login = async (usuario: string, clave: string) => {
    setLoggingIn(true);

    try {
      const res = await fetch(`${API_BASE}/Api/Aut/IniciarSesion`, {
        method: "POST",
        headers: buildCommonHeaders(),
        body: JSON.stringify({ Usuario: usuario, Clave: clave }),
      });

      if (!res.ok) {
        let msg = "Error al iniciar sesión.";

        try {
          const ct = res.headers.get("Content-Type") ?? "";
          if (ct.includes("application/json")) {
            const body = await res.json();
            if (typeof body.Mensaje === "string") msg = body.Mensaje;
          }
        } catch {}

        return { ok: false, error: msg };
      }

      const data = await res.json();

      if (!data?.Datos || !(data.Codigo === "0" || data.Codigo === "OK")) {
        return { ok: false, error: data?.Mensaje ?? "Error desconocido." };
      }

      const d = data.Datos;

      const now = Date.now();

      const newSession: SessionInfo = {
        idSesion: d.IdSesion,
        estado: d.Estado,
        accessToken: d.AccessToken,
        refreshToken: d.RefreshToken,
        tiempoExpiracionAccessToken: d.TiempoExpiracionAccessToken,
        tiempoExpiracionRefreshToken: d.TiempoExpiracionRefreshToken,
        expiryAt: now + d.TiempoExpiracionAccessToken * 1000,   // <--- NUEVO
      };

      const newUser: User = { username: usuario };

      saveSession(newSession, newUser);

      router.replace("/");

      return { ok: true };
    } catch (e) {
      console.error("Error login:", e);
      return { ok: false, error: "No se pudo conectar al servidor." };
    } finally {
      setLoggingIn(false);
    }
  };

  // -------------------------------
  // REFRESH SESSION (manual)
// -------------------------------
  const refreshSession = async (): Promise<boolean> => {
    if (!session || !user) return false;

    try {
      const res = await fetch(`${API_BASE}/Api/Aut/RefrescarSesion`, {
        method: "POST",
        headers: buildAuthHeaders(session), // Bearer con accessToken
        body: JSON.stringify({
          AccessToken: session.accessToken,
          RefreshToken: session.refreshToken,
        }),
      });

      if (!res.ok) {
        return false;
      }

      const data = await res.json();

      if (!data?.Datos || !(data.Codigo === "0" || data.Codigo === "OK")) {
        return false;
      }

      const d = data.Datos;

      const now = Date.now();

      const updated: SessionInfo = {
        idSesion: d.IdSesion,
        estado: d.Estado,
        accessToken: d.AccessToken,
        refreshToken: d.RefreshToken,
        tiempoExpiracionAccessToken: d.TiempoExpiracionAccessToken,
        tiempoExpiracionRefreshToken: d.TiempoExpiracionRefreshToken,
        expiryAt: now + d.TiempoExpiracionAccessToken * 1000,   // <--- NUEVO
      };

      saveSession(updated, user);

      return true;
    } catch (e) {
      console.error("Error refrescando sesión:", e);
      return false;
    }
  };

  // -------------------------------
  // LOGOUT
  // -------------------------------
  const logout = async () => {
    try {
      if (session?.accessToken) {
        await fetch(`${API_BASE}/Api/Aut/FinalizarSesion`, {
          method: "POST",
          headers: buildAuthHeaders(session),
          body: JSON.stringify({
            AccessToken: session.accessToken, // requerido por tu backend
          }),
        });
      }
    } catch (e) {
      console.error("Error en FinalizarSesion:", e);
    } finally {
      clearSession();
      router.replace("/login");
    }
  };

  // -------------------------------
  return (
    <AuthContext.Provider
      value={{
        user,
        session,
        loggingIn,
        loadingSession,
        login,
        logout,
        refreshSession,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

// -------------------------------
export function useAuth() {
  return useContext(AuthContext);
}