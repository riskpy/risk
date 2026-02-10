"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useAuth } from "@/lib/auth-context";
import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

export default function LoginPage() {
  const { login, loggingIn, session } = useAuth();
  const [usuario, setUsuario] = useState("");
  const [clave, setClave] = useState("");
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const router = useRouter();

  // Si ya hay sesión, ir directo al dashboard
  useEffect(() => {
    if (session?.accessToken) {
      router.replace("/");
    }
  }, [session, router]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg(null);
    const res = await login(usuario, clave);
    if (!res.ok) {
      setErrorMsg(res.error ?? "Error al iniciar sesión.");
    }
  };

  return (
    <div className="min-h-screen">
      <div className="h-screen flex items-center justify-center bg-background relative overflow-hidden">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_20%_20%,_rgba(0,122,255,0.12),_transparent_40%),_radial-gradient(circle_at_80%_80%,_rgba(0,255,180,0.12),_transparent_40%)] bg-[#060b18]" />

        <div className="relative z-10 w-full max-w-sm p-8 rounded-2xl bg-elevated/60 backdrop-blur-2xl border border-borderSubtle shadow-2xl">
          <div className="flex flex-col items-center mb-6">
            <div className="h-14 w-14 rounded-2xl bg-brand-primary flex items-center justify-center text-white text-2xl font-bold">
              R
            </div>
            <h1 className="mt-3 text-2xl font-semibold text-text-primary">RISK</h1>
            <p className="text-text-secondary text-sm">
              Control total. Gestión inteligente.
            </p>
          </div>

          <form className="space-y-4" onSubmit={handleSubmit}>
            <Input
              placeholder="Usuario"
              value={usuario}
              onChange={(e) => setUsuario(e.target.value)}
            />
            <Input
              type="password"
              placeholder="Contraseña"
              value={clave}
              onChange={(e) => setClave(e.target.value)}
            />

            <div className="flex justify-end">
              <button
                type="button"
                className="text-xs text-brand-primary hover:underline"
              >
                ¿Olvidaste tu contraseña?
              </button>
            </div>

            {errorMsg && (
              <p className="text-xs text-red-400 bg-red-950/40 border border-red-500/40 rounded-md px-3 py-2">
                {errorMsg}
              </p>
            )}

            <Button className="w-full mt-2" type="submit" disabled={loggingIn}>
              {loggingIn ? "Ingresando..." : "Ingresar"}
            </Button>
          </form>
        </div>
      </div>
    </div>
  );
}
