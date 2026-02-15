// components/SolicitudDetail.tsx

import { SolicitudCredito } from "@/lib/mock-creditos";

function Pill({ label }: { label: string }) {
  const map: Record<string, string> = {
    APROBADA: "bg-emerald-500/15 text-emerald-600",
    EN_EVALUACION: "bg-amber-500/15 text-amber-600",
    RECHAZADA: "bg-rose-500/15 text-rose-600",
    PENDIENTE_ACEPTACION: "bg-sky-500/15 text-sky-600",
  };
  return (
    <span className={`text-xs font-medium px-2 py-0.5 rounded-full ${map[label] ?? "bg-muted"}`}>
      {label.replaceAll("_", " ")}
    </span>
  );
}

function Row({ k, v }: { k: string; v: React.ReactNode }) {
  return (
    <div className="flex items-start justify-between gap-4 py-2 border-b border-white/10">
      <div className="text-xs text-muted-foreground">{k}</div>
      <div className="text-sm font-medium text-right">{v}</div>
    </div>
  );
}

export function SolicitudDetail({ s }: { s: SolicitudCredito }) {
  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div className="text-sm font-semibold">{s.tipo}</div>
        <Pill label={s.estado} />
      </div>

      <div className="rounded-xl border border-white/10 bg-white/70 dark:bg-slate-900/40 p-4">
        <div className="text-xs font-semibold tracking-wide mb-2">Resumen</div>

        <Row k="Monto" v={`Gs. ${s.monto.toLocaleString()}`} />
        <Row k="Plazo" v={`${s.plazoMeses} meses`} />
        <Row k="Cuota estimada" v={`Gs. ${s.cuota.toLocaleString()}`} />
        <Row k="Fecha" v={s.fecha} />
        <Row k="Tasa anual" v={s.tasaAnual ? `${s.tasaAnual}%` : "-"} />
        <Row k="Sistema" v={s.sistema ?? "-"} />
        <Row k="Canal" v={s.canal ?? "-"} />

        {s.motivoRechazo && (
          <div className="mt-3 text-xs text-rose-600">
            Motivo rechazo: {s.motivoRechazo}
          </div>
        )}

        {s.observacion && (
          <div className="mt-2 text-xs text-muted-foreground">
            {s.observacion}
          </div>
        )}
      </div>

      <div className="rounded-xl border border-white/10 bg-white/70 dark:bg-slate-900/40 p-4">
        <div className="text-xs font-semibold tracking-wide mb-2">Trazabilidad (mock)</div>
        <ul className="text-sm space-y-2">
          <li className="flex gap-2">
            <span className="mt-1 h-2 w-2 rounded-full bg-emerald-500/60" />
            <span>Creada · {s.fecha}</span>
          </li>
          <li className="flex gap-2">
            <span className="mt-1 h-2 w-2 rounded-full bg-white/30" />
            <span>Evaluación · (mock)</span>
          </li>
          <li className="flex gap-2">
            <span className="mt-1 h-2 w-2 rounded-full bg-white/30" />
            <span>Resolución · {s.estado.replaceAll("_", " ").toLowerCase()}</span>
          </li>
        </ul>
      </div>
    </div>
  );
}
