"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { Search, ChevronRight } from "lucide-react";

import { Sidebar } from "@/components/layout/sidebar";
import { Topbar } from "@/components/layout/topbar";
import { Input } from "@/components/ui/input";
import { useAuth } from "@/lib/auth-context";
import { searchPersonas } from "@/lib/mock-personas";

export default function PersonasPage() {
  const { session, loadingSession } = useAuth();
  const router = useRouter();

  // Guard
  useEffect(() => {
    if (!loadingSession && !session?.accessToken) {
      router.replace("/login");
    }
  }, [loadingSession, session, router]);

  const [q, setQ] = useState("");

  const rows = useMemo(() => searchPersonas(q), [q]);

  return (
    <div className="flex min-h-screen bg-background">
      <Sidebar />

      <div className="flex-1 flex flex-col">
        <Topbar />

        <main className="p-8">
          <div className="flex items-start justify-between gap-6">
            <div>
              <h1 className="text-3xl font-bold text-text-primary">
                Personas
              </h1>
              <p className="text-text-secondary mt-1">
                Buscá y accedé al detalle de cada persona.
              </p>
            </div>

            <div className="w-full max-w-md">
              <div className="relative">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-text-secondary" />
                <Input
                  value={q}
                  onChange={(e) => setQ(e.target.value)}
                  placeholder="Buscar por nombre, documento, email, teléfono..."
                  className="pl-9"
                />
              </div>
            </div>
          </div>

          <div className="mt-6 rounded-2xl border border-borderSubtle bg-elevated/60 backdrop-blur-xl shadow-lg overflow-hidden">
            <div className="px-5 py-4 border-b border-borderSubtle flex items-center justify-between">
              <div className="text-sm text-text-secondary">
                Resultados:{" "}
                <span className="text-text-primary font-semibold">
                  {rows.length}
                </span>
              </div>

              <div className="text-xs text-text-secondary">
                Mock data · Diseño B
              </div>
            </div>

            <div className="divide-y divide-borderSubtle">
              {rows.map((p) => {
                const initials = `${p.nombre?.[0] ?? ""}${p.apellido?.[0] ?? ""}`.toUpperCase();

                return (
                  <Link
                    key={p.idPersona}
                    href={`/personas/${p.idPersona}`}
                    className="group block"
                  >
                    <div className="px-5 py-4 flex items-center justify-between hover:bg-surface/40 transition-colors">
                      <div className="flex items-center gap-4 min-w-0">
                        <div className="h-11 w-11 rounded-xl bg-brand-primary/15 border border-brand-primary/25 flex items-center justify-center text-brand-primary font-bold">
                          {initials}
                        </div>

                        <div className="min-w-0">
                          <div className="flex items-center gap-2">
                            <div className="text-text-primary font-semibold truncate">
                              {p.nombre} {p.apellido}
                            </div>
                            <span className="text-xs px-2 py-0.5 rounded-full border border-borderSubtle text-text-secondary">
                              #{p.idPersona}
                            </span>
                          </div>

                          <div className="text-sm text-text-secondary truncate">
                            Doc: {p.numeroDocumento} · {p.nacionalidad} · {p.estadoCivil} · {p.sexo}
                          </div>

                          <div className="text-sm text-text-secondary truncate">
                            {p.direccionCorreo} · {p.numeroTelefono}
                          </div>
                        </div>
                      </div>

                      <ChevronRight className="h-5 w-5 text-text-secondary group-hover:text-text-primary transition-colors" />
                    </div>
                  </Link>
                );
              })}

              {rows.length === 0 && (
                <div className="px-5 py-10 text-center">
                  <div className="text-text-primary font-semibold">
                    Sin resultados
                  </div>
                  <div className="text-text-secondary text-sm mt-1">
                    Probá con otro término (nombre, doc, email, teléfono).
                  </div>
                </div>
              )}
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}
