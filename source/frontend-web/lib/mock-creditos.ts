// lib/mock-creditos.ts

export type EstadoSolicitud =
  | "APROBADA"
  | "EN_EVALUACION"
  | "RECHAZADA"
  | "PENDIENTE_ACEPTACION";

export interface SolicitudCredito {
  id: string;
  tipo: string;
  monto: number;
  plazoMeses: number;
  cuota: number;
  fecha: string; // YYYY-MM-DD
  estado: EstadoSolicitud;
  motivoRechazo?: string;

  // extras mock (para detalle)
  tasaAnual?: number;
  sistema?: "FRANCES" | "ALEMAN";
  canal?: "WEB" | "SUCURSAL" | "APP";
  observacion?: string;
}

export type EstadoCredito = "VIGENTE" | "MORA";

export interface Cuota {
  nro: number;
  vencimiento: string; // YYYY-MM-DD
  importe: number;
  capital: number;
  interes: number;
  estado: "PAGADA" | "PENDIENTE" | "VENCIDA";
  pagadoEl?: string; // YYYY-MM-DD
  mora?: number;
}

export interface Garantia {
  id: string;
  tipo: "HIPOTECA" | "PRENDA" | "CODEUDOR" | "DEPOSITO" | "CESION";
  descripcion: string;
  valorTasacion: number;
  fechaTasacion: string; // YYYY-MM-DD
  estado: "ACTIVA" | "SUSTITUIDA" | "EJECUTADA";
  documento?: string; // nombre / mock
}

export interface CreditoVigente {
  id: string;
  tipo: string;
  montoOriginal: number;
  saldoPendiente: number;
  cuota: number;
  fechaInicio: string; // YYYY-MM-DD
  estado: EstadoCredito;

  // detalle
  tasaAnual: number;
  plazoMeses: number;
  sistema: "FRANCES" | "ALEMAN";
  moneda: "PYG" | "USD";
  proximoVencimiento: string; // YYYY-MM-DD
  cuentaDebito: string;

  cuotas: Cuota[];
  garantias: Garantia[];
}

function buildCuotasMock(plazoMeses: number, cuota: number): Cuota[] {
  const today = new Date("2026-02-15"); // fijo para mock reproducible
  const cuotas: Cuota[] = [];

  for (let i = 1; i <= Math.min(plazoMeses, 24); i++) {
    const d = new Date(today);
    d.setMonth(d.getMonth() - (6 - i)); // hace que haya pagadas + pendientes + alguna vencida
    const venc = d.toISOString().slice(0, 10);

    const estado: Cuota["estado"] =
      i <= 4 ? "PAGADA" : i === 5 ? "VENCIDA" : "PENDIENTE";

    const capital = Math.round(cuota * 0.72);
    const interes = cuota - capital;

    cuotas.push({
      nro: i,
      vencimiento: venc,
      importe: cuota,
      capital,
      interes,
      estado,
      pagadoEl: estado === "PAGADA" ? venc : undefined,
      mora: estado === "VENCIDA" ? Math.round(cuota * 0.06) : undefined,
    });
  }

  return cuotas;
}

function buildGarantiasMock(): Garantia[] {
  return [
    {
      id: "GAR-001",
      tipo: "PRENDA",
      descripcion: "Vehículo Toyota Corolla 2020 · Chasis ABC123",
      valorTasacion: 48_000_000,
      fechaTasacion: "2025-02-10",
      estado: "ACTIVA",
      documento: "Tasación.pdf",
    },
    {
      id: "GAR-002",
      tipo: "CODEUDOR",
      descripcion: "Juan Pérez · CI 1.234.567",
      valorTasacion: 0,
      fechaTasacion: "2025-02-10",
      estado: "ACTIVA",
      documento: "Contrato_codeudor.pdf",
    },
  ];
}

export function getSolicitudesByPersona(_idPersona: string): SolicitudCredito[] {
  return [
    {
      id: "SOL-001",
      tipo: "Crédito Consumo",
      monto: 5_000_000,
      plazoMeses: 12,
      cuota: 520_000,
      fecha: "2026-02-10",
      estado: "APROBADA",
      tasaAnual: 24.5,
      sistema: "FRANCES",
      canal: "WEB",
      observacion: "Aprobación automática (mock).",
    },
    {
      id: "SOL-003",
      tipo: "Crédito Hipotecario",
      monto: 80_000_000,
      plazoMeses: 240,
      cuota: 1_250_000,
      fecha: "2026-02-01",
      estado: "EN_EVALUACION",
      tasaAnual: 13.9,
      sistema: "FRANCES",
      canal: "SUCURSAL",
      observacion: "Pendiente verificación de ingresos (mock).",
    },
    {
      id: "SOL-002",
      tipo: "Crédito Vehicular",
      monto: 25_000_000,
      plazoMeses: 36,
      cuota: 890_000,
      fecha: "2026-01-05",
      estado: "RECHAZADA",
      motivoRechazo: "Score crediticio insuficiente",
      tasaAnual: 22.0,
      sistema: "FRANCES",
      canal: "APP",
    },
  ];
}

export function getCreditosByPersona(_idPersona: string): CreditoVigente[] {
  return [
    {
      id: "CRE-001",
      tipo: "Crédito Consumo",
      montoOriginal: 10_000_000,
      saldoPendiente: 3_200_000,
      cuota: 560_000,
      fechaInicio: "2024-08-01",
      estado: "VIGENTE",
      tasaAnual: 23.5,
      plazoMeses: 18,
      sistema: "FRANCES",
      moneda: "PYG",
      proximoVencimiento: "2026-03-01",
      cuentaDebito: "CAJA AHORRO · 123-456-789",
      cuotas: buildCuotasMock(18, 560_000),
      garantias: [
        {
          id: "GAR-010",
          tipo: "DEPOSITO",
          descripcion: "Depósito a plazo · Certificado 778899",
          valorTasacion: 5_000_000,
          fechaTasacion: "2024-08-01",
          estado: "ACTIVA",
          documento: "Certificado.pdf",
        },
      ],
    },
    {
      id: "CRE-002",
      tipo: "Crédito Vehicular",
      montoOriginal: 35_000_000,
      saldoPendiente: 21_300_000,
      cuota: 1_120_000,
      fechaInicio: "2025-03-15",
      estado: "VIGENTE",
      tasaAnual: 19.9,
      plazoMeses: 48,
      sistema: "FRANCES",
      moneda: "PYG",
      proximoVencimiento: "2026-03-15",
      cuentaDebito: "CUENTA SUELDO · 555-222-111",
      cuotas: buildCuotasMock(48, 1_120_000),
      garantias: buildGarantiasMock(),
    },
  ];
}

export function getSolicitudById(idPersona: string, idSolicitud: string) {
  return getSolicitudesByPersona(idPersona).find((s) => s.id === idSolicitud);
}

export function getCreditoById(idPersona: string, idCredito: string) {
  return getCreditosByPersona(idPersona).find((c) => c.id === idCredito);
}
