"use client";

import Link from "next/link";
import { useEffect, useMemo } from "react";
import { useParams, useRouter } from "next/navigation";
import { ArrowLeft, Mail, Phone, CreditCard, Flag, Users, UserCircle2 } from "lucide-react";

import { Sidebar } from "@/components/layout/sidebar";
import { Topbar } from "@/components/layout/topbar";
import { useAuth } from "@/lib/auth-context";
import { getPersonaById } from "@/lib/mock-personas";

export default function PersonaDetailPage() {
  const { session, loadingSession } = useAuth();
  const router = useRouter();
  const params = useParams<{ idPersona: string }>();

  // Guard
  useEffect(() => {
    if (!loadingSession && !session?.accessToken) {
      router.replace("/login");
    }
  }, [loadingSession, session, router]);

  const id = Number(params?.idPersona);
  const persona = useMemo(() => (Number.isFinite(id) ? getPersonaById(id) : null), [id]);

  if (!persona) {
    return (
      <div className="flex min-h-screen bg-background">
        <Sidebar />
        <div className="flex-1 flex flex-col">
          <Topbar />
          <main className="p-8 text-text-primary">
            <Link href="/personas" className="inline-flex items-center gap-2 text-sm text-text-secondary hover:text-text-primary">
              <ArrowLeft className="h-4 w-4" />
              Volver a Personas
            </Link>

            <div className="mt-6 p-6 rounded-2xl bg-elevated border border-borderSubtle">
              <div className="text-xl font-semibold">Persona no encontrada</div>
              <div className="text-text-secondary mt-1">
                No existe el idPersona solicitado en los datos mock.
              </div>
            </div>
          </main>
        </div>
      </div>
    );
  }

  const initials = `${persona.nombre?.[0] ?? ""}${persona.apellido?.[0] ?? ""}`.toUpperCase();

  return (
    <div className="flex min-h-screen bg-background">
      <Sidebar />

      <div className="flex-1 flex flex-col">
        <Topbar />

        <main className="p-8">
          <div className="flex items-center justify-between gap-4">
            <Link
              href="/personas"
              className="inline-flex items-center gap-2 text-sm text-text-secondary hover:text-text-primary"
            >
              <ArrowLeft className="h-4 w-4" />
              Volver
            </Link>

            <span className="text-xs px-2 py-1 rounded-full border border-borderSubtle text-text-secondary">
              Mock · #{persona.idPersona}
            </span>
          </div>

          <div className="mt-6 grid grid-cols-1 xl:grid-cols-3 gap-6">
            {/* Card principal */}
            <div className="xl:col-span-1 rounded-2xl bg-elevated/60 backdrop-blur-xl border border-borderSubtle shadow-lg p-6">
              <div className="flex items-center gap-4">
                <div className="h-14 w-14 rounded-2xl bg-brand-primary/15 border border-brand-primary/25 flex items-center justify-center text-brand-primary font-bold text-xl">
                  {initials}
                </div>

                <div className="min-w-0">
                  <div className="text-xl font-semibold text-text-primary truncate">
                    {persona.nombre} {persona.apellido}
                  </div>
                  <div className="text-sm text-text-secondary truncate">
                    {persona.nacionalidad} · {persona.estadoCivil} · {persona.sexo}
                  </div>
                </div>
              </div>

              <div className="mt-6 space-y-3">
                <InfoRow icon={<CreditCard className="h-4 w-4" />} label="Documento" value={persona.numeroDocumento} />
                <InfoRow icon={<Flag className="h-4 w-4" />} label="Nacionalidad" value={persona.nacionalidad} />
                <InfoRow icon={<Mail className="h-4 w-4" />} label="Correo" value={persona.direccionCorreo} />
                <InfoRow icon={<Phone className="h-4 w-4" />} label="Teléfono" value={persona.numeroTelefono} />
              </div>
            </div>

            {/* Detalles */}
            <div className="xl:col-span-2 rounded-2xl bg-elevated/60 backdrop-blur-xl border border-borderSubtle shadow-lg p-6">
              <div className="flex items-center gap-2 text-text-primary font-semibold">
                <UserCircle2 className="h-5 w-5 text-text-secondary" />
                Detalle
              </div>

              <div className="mt-4 grid grid-cols-1 md:grid-cols-2 gap-4">
                <MiniCard title="Estado civil" value={persona.estadoCivil} icon={<Users className="h-4 w-4" />} />
                <MiniCard title="Sexo" value={persona.sexo} icon={<UserCircle2 className="h-4 w-4" />} />
                <MiniCard title="Correo" value={persona.direccionCorreo} icon={<Mail className="h-4 w-4" />} />
                <MiniCard title="Teléfono" value={persona.numeroTelefono} icon={<Phone className="h-4 w-4" />} />
              </div>

              <div className="mt-6 p-4 rounded-xl border border-borderSubtle bg-surface/30">
                <div className="text-sm text-text-secondary">
                  Próximo paso: reemplazar mock por backend real + paginación + filtros avanzados.
                </div>
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
  );
}

function InfoRow({
  icon,
  label,
  value,
}: {
  icon: React.ReactNode;
  label: string;
  value: string;
}) {
  return (
    <div className="flex items-start gap-3">
      <div className="mt-0.5 text-text-secondary">{icon}</div>
      <div className="min-w-0">
        <div className="text-xs text-text-secondary">{label}</div>
        <div className="text-sm text-text-primary truncate">{value}</div>
      </div>
    </div>
  );
}

function MiniCard({
  title,
  value,
  icon,
}: {
  title: string;
  value: string;
  icon: React.ReactNode;
}) {
  return (
    <div className="p-4 rounded-xl border border-borderSubtle bg-surface/30">
      <div className="flex items-center gap-2 text-xs text-text-secondary">
        <span className="text-text-secondary">{icon}</span>
        {title}
      </div>
      <div className="mt-1 text-text-primary font-semibold truncate">{value}</div>
    </div>
  );
}
