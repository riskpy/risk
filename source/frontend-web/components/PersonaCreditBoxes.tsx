// components/PersonaCreditBoxes.tsx

import {
  getSolicitudesByPersona,
  getCreditosByPersona,
} from "@/lib/mock-creditos";
import { DisclosureBox } from "@/components/DisclosureBox";
import Link from "next/link";

interface Props {
  idPersona: string | number;
}

function StatusPill({ label }: { label: string }) {
  const map: Record<string, string> = {
    APROBADA: "bg-emerald-500/15 text-emerald-600",
    EN_EVALUACION: "bg-amber-500/15 text-amber-600",
    RECHAZADA: "bg-rose-500/15 text-rose-600",
    PENDIENTE_ACEPTACION: "bg-sky-500/15 text-sky-600",
    VIGENTE: "bg-emerald-500/15 text-emerald-600",
    MORA: "bg-rose-500/15 text-rose-600",
  };

  return (
    <span
      className={`text-xs font-medium px-2 py-0.5 rounded-full ${
        map[label] ?? "bg-muted"
      }`}
    >
      {label.replace("_", " ")}
    </span>
  );
}

export function PersonaCreditBoxes({ idPersona }: Props) {
  const personaKey = String(idPersona);
  const solicitudes = getSolicitudesByPersona(personaKey);
  const creditos = getCreditosByPersona(personaKey);

  return (
    <div className="space-y-4 mt-6">
      {/* SOLICITUDES */}
      <DisclosureBox
        title="Solicitudes de crédito"
        subtitle={
          solicitudes[0]
            ? `Última: ${solicitudes[0].estado.toLowerCase()}`
            : "Sin solicitudes"
        }
        count={solicitudes.length}
      >
        <div className="space-y-3">
          {solicitudes.map((s) => (
            <Link key={s.id} href={`?solicitud=${encodeURIComponent(s.id)}`} scroll={false} className="block">
            <div className="rounded-lg border border-white/10 p-4 bg-white/70 dark:bg-slate-900/40 hover:bg-black/5 dark:hover:bg-white/5 transition-colors cursor-pointer">
              <div className="flex justify-between items-start gap-3">
                <div>
                  <p className="font-medium">{s.tipo}</p>
                  <p className="text-xs text-muted-foreground">
                    Monto: {s.monto.toLocaleString()} · {s.plazoMeses} meses
                  </p>
                </div>
                <StatusPill label={s.estado} />
              </div>

              {s.motivoRechazo && (
                <p className="mt-2 text-xs text-rose-600">
                  Motivo: {s.motivoRechazo}
                </p>
              )}
            </div>
            </Link>
          ))}
        </div>
      </DisclosureBox>

      {/* CRÉDITOS */}
      <DisclosureBox
        title="Créditos vigentes"
        subtitle={
          creditos.length
            ? `Saldo total: ${creditos
                .reduce((a, c) => a + c.saldoPendiente, 0)
                .toLocaleString()}`
            : "Sin créditos activos"
        }
        count={creditos.length}
      >
        <div className="space-y-3">
          {creditos.map((c) => (
            <Link key={c.id} href={`?credito=${encodeURIComponent(c.id)}&tab=general`} scroll={false} className="block">
            <div className="rounded-lg border border-white/10 p-4 bg-white/70 dark:bg-slate-900/40 hover:bg-black/5 dark:hover:bg-white/5 transition-colors cursor-pointer">
              <div className="flex justify-between items-start gap-3">
                <div>
                  <p className="font-medium">{c.tipo}</p>
                  <p className="text-xs text-muted-foreground">
                    Saldo: {c.saldoPendiente.toLocaleString()} ·
                    Cuota: {c.cuota.toLocaleString()}
                  </p>
                </div>
                <StatusPill label={c.estado} />
              </div>
            </div>
            </Link>
          ))}
        </div>
      </DisclosureBox>
    </div>
  );
}
