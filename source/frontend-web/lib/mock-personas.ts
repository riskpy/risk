export type Persona = {
  idPersona: number;
  nombre: string;
  apellido: string;
  numeroDocumento: string;
  nacionalidad: string;
  estadoCivil: string;
  sexo: string;
  direccionCorreo: string;
  numeroTelefono: string;
};

export const PERSONAS_MOCK: Persona[] = [
  {
    idPersona: 1001,
    nombre: "Juan",
    apellido: "Pérez",
    numeroDocumento: "1234567",
    nacionalidad: "PY",
    estadoCivil: "Soltero",
    sexo: "M",
    direccionCorreo: "juan.perez@risk.com",
    numeroTelefono: "+595 981 111 222",
  },
  {
    idPersona: 1002,
    nombre: "María",
    apellido: "Gómez",
    numeroDocumento: "4567890",
    nacionalidad: "PY",
    estadoCivil: "Casada",
    sexo: "F",
    direccionCorreo: "maria.gomez@risk.com",
    numeroTelefono: "+595 982 333 444",
  },
  {
    idPersona: 1003,
    nombre: "John",
    apellido: "Doe",
    numeroDocumento: "A1234567",
    nacionalidad: "US",
    estadoCivil: "Divorciado",
    sexo: "M",
    direccionCorreo: "john.doe@risk.com",
    numeroTelefono: "+1 202 555 0101",
  },
  {
    idPersona: 1004,
    nombre: "Ana",
    apellido: "Sosa",
    numeroDocumento: "7890123",
    nacionalidad: "AR",
    estadoCivil: "Soltera",
    sexo: "F",
    direccionCorreo: "ana.sosa@risk.com",
    numeroTelefono: "+54 11 4444 5555",
  },
];

export function getPersonaById(idPersona: number) {
  return PERSONAS_MOCK.find((p) => p.idPersona === idPersona) ?? null;
}

export function searchPersonas(query: string) {
  const q = query.trim().toLowerCase();
  if (!q) return PERSONAS_MOCK;

  return PERSONAS_MOCK.filter((p) => {
    const blob = [
      p.idPersona,
      p.nombre,
      p.apellido,
      p.numeroDocumento,
      p.nacionalidad,
      p.estadoCivil,
      p.sexo,
      p.direccionCorreo,
      p.numeroTelefono,
    ]
      .join(" ")
      .toLowerCase();

    return blob.includes(q);
  });
}
