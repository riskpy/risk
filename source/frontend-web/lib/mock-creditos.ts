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
  fecha: string;
  estado: EstadoSolicitud;
  motivoRechazo?: string;
}

export interface CreditoVigente {
  id: string;
  tipo: string;
  montoOriginal: number;
  saldoPendiente: number;
  cuota: number;
  fechaInicio: string;
  estado: "VIGENTE" | "MORA";
}

export function getSolicitudesByPersona(
  _idPersona: string
): SolicitudCredito[] {
  return [
    {
      id: "SOL-001",
      tipo: "Crédito Consumo",
      monto: 5_000_000,
      plazoMeses: 12,
      cuota: 520_000,
      fecha: "2026-02-10",
      estado: "APROBADA",
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
    },
    {
      id: "SOL-003",
      tipo: "Crédito Hipotecario",
      monto: 80_000_000,
      plazoMeses: 240,
      cuota: 1_250_000,
      fecha: "2026-02-01",
      estado: "EN_EVALUACION",
    },
  ];
}

export function getCreditosByPersona(
  _idPersona: string
): CreditoVigente[] {
  return [
    {
      id: "CRE-001",
      tipo: "Crédito Consumo",
      montoOriginal: 10_000_000,
      saldoPendiente: 3_200_000,
      cuota: 560_000,
      fechaInicio: "2024-08-01",
      estado: "VIGENTE",
    },
    {
      id: "CRE-002",
      tipo: "Crédito Vehicular",
      montoOriginal: 35_000_000,
      saldoPendiente: 21_300_000,
      cuota: 1_120_000,
      fechaInicio: "2025-03-15",
      estado: "VIGENTE",
    },
  ];
}
