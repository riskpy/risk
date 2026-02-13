"use client";

import { useMemo, useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

type Moneda = "PYG" | "USD";

type Cuota = {
  nroCuota: number;
  montoCapital: number;
  montoInteres: number;
  montoTotal: number;
};

type ResultadoSolicitud = {
  estado: "APROBADO" | "EN_PROCESO" | "RECHAZADO";
  mensaje: string;
  numeroSolicitud: string;
};

function formatMoney(v: number, moneda: Moneda) {
  // simple y claro para mock
  const symbol = moneda === "PYG" ? "₲" : "$";
  return `${symbol} ${Math.round(v).toLocaleString("es-PY")}`;
}

function simulateInstallments(params: {
  monto: number;
  meses: number;
  moneda: Moneda;
}) {
  const { monto, meses } = params;

  // Mock: interés mensual fijo (ej: 2.0% mensual)
  // Después lo conectás a tasa real del backend.
  const monthlyRate = 0.02;

  const capitalPorCuota = monto / meses;

  const cuotas: Cuota[] = [];
  for (let i = 1; i <= meses; i++) {
    // Interés simple sobre saldo aproximado (mock)
    const saldoEstimado = monto - capitalPorCuota * (i - 1);
    const interes = saldoEstimado * monthlyRate;
    const total = capitalPorCuota + interes;

    cuotas.push({
      nroCuota: i,
      montoCapital: capitalPorCuota,
      montoInteres: interes,
      montoTotal: total,
    });
  }

  return cuotas;
}

function mockSubmitSolicitud(idPersona: number): ResultadoSolicitud {
  const numeroSolicitud = `SOL-${idPersona}-${Date.now().toString().slice(-6)}`;

  if (idPersona === 1001) {
    return {
      estado: "APROBADO",
      mensaje: "Solicitud aprobada. Podés continuar con el alta del préstamo.",
      numeroSolicitud,
    };
  }

  if (idPersona === 1002) {
    return {
      estado: "EN_PROCESO",
      mensaje: "Solicitud ingresada. En proceso de análisis.",
      numeroSolicitud,
    };
  }

  if (idPersona === 1003) {
    return {
      estado: "RECHAZADO",
      mensaje: "Solicitud rechazada. El solicitante no cumple con los criterios actuales.",
      numeroSolicitud,
    };
  }

  // default
  return {
    estado: "EN_PROCESO",
    mensaje: "Solicitud ingresada. En proceso de análisis.",
    numeroSolicitud,
  };
}

function StatusPill({ estado }: { estado: ResultadoSolicitud["estado"] }) {
  const text =
    estado === "APROBADO"
      ? "Aprobado"
      : estado === "EN_PROCESO"
      ? "En proceso"
      : "Rechazado";

  const cls =
    estado === "APROBADO"
      ? `
        bg-emerald-600/15 text-emerald-700 border-emerald-600/30
        dark:bg-emerald-500/25 dark:text-emerald-200 dark:border-emerald-400/40
      `
      : estado === "EN_PROCESO"
      ? `
        bg-sky-600/15 text-sky-700 border-sky-600/30
        dark:bg-sky-500/25 dark:text-sky-200 dark:border-sky-400/40
      `
      : `
        bg-red-600/15 text-red-700 border-red-600/30
        dark:bg-red-500/25 dark:text-red-200 dark:border-red-400/40
      `;

  return (
    <span
      className={`inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs border font-medium ${cls}`}
    >
      <span className="h-1.5 w-1.5 rounded-full bg-current opacity-90" />
      {text}
    </span>
  );
}

export function LoanRequestCard({
  idPersona,
  variant = "card",
}: {
  idPersona: number;
  variant?: "card" | "modal";
}) {
  const [monto, setMonto] = useState<string>("");
  const [moneda, setMoneda] = useState<Moneda>("PYG");
  const [plazoMeses, setPlazoMeses] = useState<string>("12");

  const [cuotas, setCuotas] = useState<Cuota[] | null>(null);

  const [modalOpen, setModalOpen] = useState(false);
  const [locked, setLocked] = useState(false);
  const [resultado, setResultado] = useState<ResultadoSolicitud | null>(null);

  const montoNum = Number(monto);
  const mesesNum = Number(plazoMeses);

  const canSimulate = montoNum > 0 && mesesNum > 0 && mesesNum <= 120;
  const canSubmit = canSimulate && cuotas && cuotas.length > 0;

  const totalCuotas = useMemo(() => {
    if (!cuotas?.length) return 0;
    return cuotas.reduce((acc, c) => acc + c.montoTotal, 0);
  }, [cuotas]);

  const onSimular = () => {
    if (!canSimulate) return;
    setCuotas(simulateInstallments({ monto: montoNum, meses: mesesNum, moneda }));
  };

  const onSolicitar = async () => {
    if (!canSubmit) return;

    // Mock “envío”
    // Más adelante acá hacés fetch al backend y pasás idPersona + form + cuotas si corresponde.
    const r = mockSubmitSolicitud(idPersona);
    setResultado(r);
    setModalOpen(true);
    setLocked(true);
  };

  const onAceptar = () => {
    // UX recomendado: cerrar y permanecer en la pantalla
    setModalOpen(false);
  };

  const onCerrarSesionFlow = () => {
    // Si querés “limpiar” la solicitud al cerrar popup (opcional):
    // setCuotas(null);
    // setMonto("");
    // setPlazoMeses("12");
    setModalOpen(false);
  };

  const wrapperClass =
  variant === "modal"
    ? "" // el modal padre ya tiene borde/padding
    : "mt-6 p-6 rounded-2xl bg-elevated border border-borderSubtle shadow-lg";

  return (
    <div className={wrapperClass}>
      <div className="flex items-start justify-between gap-4">
        <div>
          <h2 className="text-lg font-semibold text-text-primary">Solicitud de crédito</h2>
          <p className="text-sm text-text-secondary mt-1">
            Iniciá el flujo de solicitud con simulación de cuotas (mock).
          </p>
        </div>

        {resultado?.estado ? <StatusPill estado={resultado.estado} /> : null}
      </div>

      <div className="mt-5 grid grid-cols-1 md:grid-cols-3 gap-3">
        <div>
          <label className="text-xs text-text-secondary">Monto solicitado</label>
          <Input
            disabled={locked}
            value={monto}
            onChange={(e) => setMonto(e.target.value.replace(/[^\d]/g, ""))}
            placeholder="Ej: 10000000"
          />
        </div>

        <div>
          <label className="text-xs text-text-secondary">Moneda</label>
          <select
            disabled={locked}
            className={`mt-1 w-full rounded-lg bg-surface border border-borderSubtle px-3 py-2 text-sm text-text-primary outline-none ${
              locked ? "opacity-70 cursor-not-allowed" : ""  }`}
            value={moneda}
            onChange={(e) => setMoneda(e.target.value as Moneda)}
          >
            <option value="PYG">PYG</option>
            <option value="USD">USD</option>
          </select>
        </div>

        <div>
          <label className="text-xs text-text-secondary">Plazo (meses)</label>
          <Input
            disabled={locked}
            value={plazoMeses}
            onChange={(e) => setPlazoMeses(e.target.value.replace(/[^\d]/g, ""))}
            placeholder="Ej: 12"
          />
          <p className="text-[11px] text-text-secondary mt-1">
            Máx. 120 (mock)
          </p>
        </div>
      </div>

      <div className="mt-5 flex items-center gap-3">
        <Button type="button" onClick={onSimular} disabled={!canSimulate || locked}>
          Simular
        </Button>

        <Button type="button" onClick={onSolicitar} disabled={!canSubmit || locked}>
          Solicitar
        </Button>

        {cuotas?.length ? (
          <div className="ml-auto text-sm text-text-secondary">
            Total estimado:{" "}
            <span className="text-text-primary font-semibold">
              {formatMoney(totalCuotas, moneda)}
            </span>
          </div>
        ) : null}
      </div>

        {/* Tabla de cuotas */}
        {cuotas?.length ? (
        <div className="mt-6 rounded-xl border border-borderSubtle overflow-hidden">
            {/* Scroll solo para la tabla */}
            <div className="max-h-[320px] overflow-auto">
            <table className="w-full text-sm [border-collapse:separate] [border-spacing:0]">
                <thead>
                <tr className="text-left text-text-secondary">
                    {["Nro", "Capital", "Interés", "Total"].map((h) => (
                    <th
                        key={h}
                        className="px-4 py-3 sticky top-0 z-10 bg-surface/95 backdrop-blur border-b border-borderSubtle"
                    >
                        {h}
                    </th>
                    ))}
                </tr>
                </thead>

                <tbody>
                {cuotas.map((c) => (
                    <tr key={c.nroCuota} className="border-t border-borderSubtle">
                    <td className="px-4 py-3 text-text-secondary">{c.nroCuota}</td>
                    <td className="px-4 py-3 text-text-primary">
                        {formatMoney(c.montoCapital, moneda)}
                    </td>
                    <td className="px-4 py-3 text-text-primary">
                        {formatMoney(c.montoInteres, moneda)}
                    </td>
                    <td className="px-4 py-3 text-text-primary font-medium">
                        {formatMoney(c.montoTotal, moneda)}
                    </td>
                    </tr>
                ))}
                </tbody>
            </table>
            </div>
        </div>
        ) : null}

      {/* Modal resultado */}
      {modalOpen && resultado ? (
        <div className="fixed inset-0 z-[60] flex items-center justify-center bg-black/40 backdrop-blur-sm">
          <div className="w-full max-w-md rounded-2xl bg-elevated border border-borderSubtle shadow-2xl p-6">
            <div className="flex items-start justify-between gap-4">
              <div>
                <h3 className="text-lg font-semibold text-text-primary">
                  Resultado de solicitud
                </h3>
                <p className="text-xs text-text-secondary mt-1">
                  Nro. solicitud: <span className="text-text-primary">{resultado.numeroSolicitud}</span>
                </p>
              </div>

              <StatusPill estado={resultado.estado} />
            </div>

            <p className="mt-4 text-sm text-text-secondary">
              {resultado.mensaje}
            </p>

            <div className="mt-6 flex justify-end gap-3">
              {/* Solo visible si APROBADO */}
              <button
                type="button"
                disabled={resultado.estado !== "APROBADO"}
                className={`px-3 py-2 rounded-lg text-sm border border-borderSubtle ${
                  resultado.estado === "APROBADO"
                    ? "hover:bg-surface"
                    : "opacity-50 cursor-not-allowed"
                }`}
                onClick={() => {
                  // no implementamos navegación todavía
                  setModalOpen(false);
                }}
              >
                Ir al préstamo
              </button>

              <button
                type="button"
                className="px-4 py-2 rounded-lg bg-brand-primary text-white text-sm hover:bg-brand-primary/90"
                onClick={onAceptar}
              >
                Aceptar
              </button>

              {/* Si querés un close “X” adicional */}
              <button
                type="button"
                className="ml-1 px-3 py-2 rounded-lg text-sm border border-borderSubtle hover:bg-surface"
                onClick={onCerrarSesionFlow}
              >
                Cerrar
              </button>
            </div>
          </div>
        </div>
      ) : null}
    </div>
  );
}
