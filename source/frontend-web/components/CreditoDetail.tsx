// components/CreditoDetail.tsx
"use client";

import { useMemo, useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import type { CreditoVigente, Cuota, Garantia } from "@/lib/mock-creditos";

function Pill({ label }: { label: string }) {
  const map: Record<string, string> = {
    VIGENTE: "bg-emerald-500/15 text-emerald-600",
    MORA: "bg-rose-500/15 text-rose-600",
    PAGADA: "bg-emerald-500/15 text-emerald-600",
    PENDIENTE: "bg-sky-500/15 text-sky-600",
    VENCIDA: "bg-rose-500/15 text-rose-600",
    ACTIVA: "bg-emerald-500/15 text-emerald-600",
    SUSTITUIDA: "bg-amber-500/15 text-amber-600",
    EJECUTADA: "bg-rose-500/15 text-rose-600",
  };
  return (
    <span className={`text-xs font-medium px-2 py-0.5 rounded-full ${map[label] ?? "bg-muted"}`}>
      {label.replaceAll("_", " ")}
    </span>
  );
}

function ProgressBar({ value }: { value: number }) {
  // value 0..1
  const pct = Math.max(0, Math.min(1, value));
  return (
    <div className="h-2 w-full rounded-full bg-black/5 dark:bg-white/10 overflow-hidden">
      <div
        className="h-full bg-black/20 dark:bg-white/20"
        style={{ width: `${Math.round(pct * 100)}%` }}
      />
    </div>
  );
}

function TabButton({
  active,
  label,
  onClick,
}: {
  active: boolean;
  label: string;
  onClick: () => void;
}) {
  return (
    <button
      onClick={onClick}
      className={`text-sm px-3 py-2 rounded-lg transition-colors ${
        active
          ? "bg-black/5 dark:bg-white/10"
          : "hover:bg-black/5 dark:hover:bg-white/5"
      }`}
      type="button"
    >
      {label}
    </button>
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

function CuotasTable({ cuotas }: { cuotas: Cuota[] }) {
  const chips = ["TODAS", "PENDIENTE", "VENCIDA", "PAGADA"] as const;
  const [filter, setFilter] = useState<(typeof chips)[number]>("TODAS");

  const shown = useMemo(() => {
    if (filter === "TODAS") return cuotas;
    return cuotas.filter((q) => q.estado === filter);
  }, [cuotas, filter]);

  return (
    <div className="rounded-xl border border-white/10 bg-white/70 dark:bg-slate-900/40 overflow-hidden">
      <div className="px-4 py-3 border-b border-white/10 flex items-center gap-2 flex-wrap">
        <div className="text-xs font-semibold tracking-wide mr-2">Cuotas</div>

        {chips.map((c) => (
          <button
            key={c}
            type="button"
            onClick={() => setFilter(c)}
            className={`text-xs px-2 py-1 rounded-full border border-white/10 transition-colors ${
              c === filter
                ? "bg-black/5 dark:bg-white/10"
                : "hover:bg-black/5 dark:hover:bg-white/5"
            }`}
          >
            {c}
          </button>
        ))}

        <span className="text-xs text-muted-foreground ml-auto">
          Mostrando: {filter}
        </span>
      </div>

      <div className="max-h-[420px] overflow-auto">
        <table className="w-full text-sm">
          <thead className="sticky top-0 bg-white/90 dark:bg-slate-950/90 backdrop-blur border-b border-white/10">
            <tr className="text-xs text-muted-foreground">
              <th className="text-left px-4 py-3 font-medium">N°</th>
              <th className="text-left px-4 py-3 font-medium">Vencimiento</th>
              <th className="text-left px-4 py-3 font-medium">Importe</th>
              <th className="text-left px-4 py-3 font-medium">Capital</th>
              <th className="text-left px-4 py-3 font-medium">Interés</th>
              <th className="text-left px-4 py-3 font-medium">Estado</th>
            </tr>
          </thead>

          <tbody>
            {shown.map((q) => (
              <tr key={q.nro} className="border-b border-white/10">
                <td className="px-4 py-3">{q.nro}</td>
                <td className="px-4 py-3">{q.vencimiento}</td>
                <td className="px-4 py-3">{q.importe.toLocaleString()}</td>
                <td className="px-4 py-3">{q.capital.toLocaleString()}</td>
                <td className="px-4 py-3">{q.interes.toLocaleString()}</td>
                <td className="px-4 py-3">
                  <div className="flex items-center gap-2">
                    <Pill label={q.estado} />
                    {q.mora ? (
                      <span className="text-xs text-rose-600">
                        mora {q.mora.toLocaleString()}
                      </span>
                    ) : null}
                  </div>
                </td>
              </tr>
            ))}

            {shown.length === 0 && (
              <tr>
                <td
                  className="px-4 py-6 text-xs text-muted-foreground"
                  colSpan={6}
                >
                  No hay cuotas para mostrar.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}

function GarantiasList({ garantias }: { garantias: Garantia[] }) {
  return (
    <div className="space-y-3">
      {garantias.map((g) => (
        <div
          key={g.id}
          className="rounded-xl border border-white/10 bg-white/70 dark:bg-slate-900/40 p-4"
        >
          <div className="flex items-start justify-between gap-3">
            <div>
              <div className="text-sm font-semibold">{g.tipo}</div>
              <div className="text-xs text-muted-foreground mt-1">{g.descripcion}</div>
            </div>
            <Pill label={g.estado} />
          </div>

          <div className="mt-3 grid grid-cols-2 gap-3 text-sm">
            <div>
              <div className="text-xs text-muted-foreground">Valor tasación</div>
              <div className="font-medium">
                {g.valorTasacion ? `Gs. ${g.valorTasacion.toLocaleString()}` : "-"}
              </div>
            </div>
            <div>
              <div className="text-xs text-muted-foreground">Fecha tasación</div>
              <div className="font-medium">{g.fechaTasacion}</div>
            </div>
          </div>

          {g.documento && (
            <div className="mt-3 text-xs text-muted-foreground">
              Documento: <span className="underline">{g.documento}</span> (mock)
            </div>
          )}
        </div>
      ))}

      {garantias.length === 0 && (
        <div className="text-xs text-muted-foreground">
          Este crédito no tiene garantías registradas.
        </div>
      )}
    </div>
  );
}

export function CreditoDetail({ c }: { c: CreditoVigente }) {
  const router = useRouter();
  const sp = useSearchParams();

  const tab = (sp.get("tab") ?? "general") as "general" | "cuotas" | "garantias";

  const setTab = (nextTab: "general" | "cuotas" | "garantias") => {
    const params = new URLSearchParams(sp.toString());
    params.set("tab", nextTab);
    router.replace(`?${params.toString()}`, { scroll: false });
  };

  const kpis = useMemo(
    () => [
      { k: "Saldo pendiente", v: `Gs. ${c.saldoPendiente.toLocaleString()}` },
      { k: "Cuota", v: `Gs. ${c.cuota.toLocaleString()}` },
      { k: "Próximo venc.", v: c.proximoVencimiento },
      { k: "Estado", v: <Pill label={c.estado} /> },
    ],
    [c]
  );

  const ratioPagado = 1 - c.saldoPendiente / c.montoOriginal;

  return (
    <div className="space-y-4">
      {/* KPIs */}
      <div className="grid grid-cols-2 gap-3">
        {kpis.map((x) => (
          <div
            key={x.k}
            className="rounded-xl border border-white/10 bg-white/70 dark:bg-slate-900/40 p-3"
          >
            <div className="text-xs text-muted-foreground">{x.k}</div>
            <div className="text-sm font-semibold mt-1">{x.v as any}</div>
          </div>
        ))}
      </div>

      {/* Barra de progreso del credito */}
      <div className="rounded-xl border border-white/10 bg-white/70 dark:bg-slate-900/40 p-4">
        <div className="flex items-center justify-between mb-2">
            <div className="text-xs font-semibold tracking-wide">Progreso del crédito</div>
            <div className="text-xs text-muted-foreground">
            {Math.round(ratioPagado * 100)}% pagado
            </div>
        </div>

        <ProgressBar value={ratioPagado} />

        <div className="mt-2 flex items-center justify-between text-xs text-muted-foreground">
            <span>Original: Gs. {c.montoOriginal.toLocaleString()}</span>
            <span>Saldo: Gs. {c.saldoPendiente.toLocaleString()}</span>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex items-center gap-2">
        <TabButton active={tab === "general"} label="Datos generales" onClick={() => setTab("general")} />
        <TabButton active={tab === "cuotas"} label="Cuotas" onClick={() => setTab("cuotas")} />
        <TabButton active={tab === "garantias"} label="Garantías" onClick={() => setTab("garantias")} />
      </div>

      {/* Content */}
      {tab === "general" && (
        <div className="rounded-xl border border-white/10 bg-white/70 dark:bg-slate-900/40 p-4">
          <div className="text-xs font-semibold tracking-wide mb-2">Detalle</div>
          <Row k="Producto" v={c.tipo} />
          <Row k="Moneda" v={c.moneda} />
          <Row k="Monto original" v={`Gs. ${c.montoOriginal.toLocaleString()}`} />
          <Row k="Saldo pendiente" v={`Gs. ${c.saldoPendiente.toLocaleString()}`} />
          <Row k="Tasa anual" v={`${c.tasaAnual}%`} />
          <Row k="Plazo" v={`${c.plazoMeses} meses`} />
          <Row k="Sistema" v={c.sistema} />
          <Row k="Fecha inicio" v={c.fechaInicio} />
          <Row k="Cuenta débito" v={c.cuentaDebito} />
        </div>
      )}

      {tab === "cuotas" && <CuotasTable cuotas={c.cuotas} />}

      {tab === "garantias" && <GarantiasList garantias={c.garantias} />}
    </div>
  );
}
