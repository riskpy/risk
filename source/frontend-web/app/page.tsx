"use client";

import { Sidebar } from "@/components/layout/sidebar";
import { Topbar } from "@/components/layout/topbar";
import { useAuth } from "@/lib/auth-context";
import { useEffect } from "react";
import { useRouter } from "next/navigation";

export default function Dashboard() {
  const { user, session, loadingSession } = useAuth();
  const router = useRouter();

  // Si no hay sesión -> login
  useEffect(() => {
    if (!loadingSession && !session?.accessToken) {
      router.replace("/login");
    }
  }, [session, router]);

  const displayName = user?.username ?? "Usuario";

  return (
    <div className="flex min-h-screen bg-background">
      <Sidebar />
      <div className="flex-1 flex flex-col">
        <Topbar />
        <main className="p-8 text-text-primary">
          <h1 className="text-3xl font-bold mb-2">Hola, {displayName} 👋</h1>
          <p className="text-text-secondary mb-6">
            Bienvenido a tu panel de control de RISK.
          </p>

          {/* Cards placeholder */}
          <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-4">
            {[1, 2, 3, 4].map((i) => (
              <div
                key={i}
                className="p-6 rounded-xl bg-elevated border border-borderSubtle shadow-lg"
              >
                <div className="h-4 w-24 bg-white/10 rounded mb-3" />
                <div className="h-6 w-16 bg-white/10 rounded mb-3" />
                <div className="h-3 w-32 bg-white/10 rounded" />
              </div>
            ))}
          </div>
        </main>
      </div>
    </div>
  );
}
