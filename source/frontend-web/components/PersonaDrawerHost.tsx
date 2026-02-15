// components/PersonaDrawerHost.tsx
"use client";

import { useMemo } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { RightDrawer } from "@/components/RightDrawer";
import { getSolicitudById, getCreditoById } from "@/lib/mock-creditos";
import { SolicitudDetail } from "@/components/SolicitudDetail";
import { CreditoDetail } from "@/components/CreditoDetail";

import { FileText, Printer, Link2 } from "lucide-react";
import { DrawerActionButton } from "@/components/DrawerActionButton";

export function PersonaDrawerHost({ idPersona }: { idPersona: string | number }) {
  const personaKey = String(idPersona);

  const router = useRouter();
  const sp = useSearchParams();

  const solicitudId = sp.get("solicitud");
  const creditoId = sp.get("credito");

  const mode = solicitudId ? "solicitud" : creditoId ? "credito" : null;

  const solicitud = useMemo(() => {
    if (!solicitudId) return null;
    return getSolicitudById(personaKey, solicitudId) ?? null;
  }, [personaKey, solicitudId]);

  const credito = useMemo(() => {
    if (!creditoId) return null;
    return getCreditoById(personaKey, creditoId) ?? null;
  }, [personaKey, creditoId]);

  const open = Boolean(mode);

  const close = () => {
    const params = new URLSearchParams(sp.toString());
    params.delete("solicitud");
    params.delete("credito");
    params.delete("tab");
    const q = params.toString();
    router.replace(q ? `?${q}` : "?", { scroll: false });
  };

  const headerActionsSolicitud = (
    <div className="flex items-center gap-2">
      <DrawerActionButton
        icon={<Printer className="h-4 w-4" />}
        label="Imprimir"
        disabledReason="Disponible al conectar backend"
      />
      <DrawerActionButton
        icon={<Link2 className="h-4 w-4" />}
        label="Compartir"
        disabledReason="Disponible al conectar backend"
      />
    </div>
  );

  const headerActionsCredito = (
    <div className="flex items-center gap-2">
      <DrawerActionButton
        icon={<FileText className="h-4 w-4" />}
        label="Contrato"
        disabledReason="Disponible al conectar backend"
      />
      <DrawerActionButton
        icon={<Printer className="h-4 w-4" />}
        label="Imprimir"
        disabledReason="Disponible al conectar backend"
      />
      <DrawerActionButton
        icon={<Link2 className="h-4 w-4" />}
        label="Compartir"
        disabledReason="Disponible al conectar backend"
      />
    </div>
  );

  if (!open) return null;

  if (mode === "solicitud") {
    return (
      <RightDrawer
        open
        title={solicitud ? `Solicitud ${solicitud.id}` : "Solicitud"}
        subtitle={solicitud ? solicitud.tipo : "No encontrada"}
        headerRight={headerActionsSolicitud}
        onClose={close}
      >
        {solicitud ? (
          <SolicitudDetail s={solicitud} />
        ) : (
          <div className="text-sm text-muted-foreground">Solicitud no encontrada (mock).</div>
        )}
      </RightDrawer>
    );
  }

  return (
    <RightDrawer
      open
      title={credito ? `Crédito ${credito.id}` : "Crédito"}
      subtitle={credito ? credito.tipo : "No encontrado"}
      headerRight={headerActionsCredito}
      onClose={close}
    >
      {credito ? (
        <CreditoDetail c={credito} />
      ) : (
        <div className="text-sm text-muted-foreground">Crédito no encontrado (mock).</div>
      )}
    </RightDrawer>
  );
}
