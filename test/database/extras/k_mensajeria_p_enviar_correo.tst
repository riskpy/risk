PL/SQL Developer Test script 3.0
47
declare
  -- Non-scalar parameters require additional processing 
  l_adjuntos y_objetos;
  l_archivo  y_archivo;
begin
  l_adjuntos := new y_objetos();

  l_archivo           := new y_archivo();
  l_archivo.contenido := k_util.clob_to_blob('Este es un archivo de texto 1');
  l_archivo.nombre    := 'prueba1';
  l_archivo.extension := 'txt';
  k_archivo.p_calcular_propiedades(l_archivo.contenido,
                                   l_archivo.checksum,
                                   l_archivo.tamano);
  l_adjuntos.extend;
  l_adjuntos(l_adjuntos.count) := l_archivo;
  --
  l_archivo           := new y_archivo();
  l_archivo.contenido := k_util.clob_to_blob('Este es un archivo de texto 2');
  l_archivo.nombre    := 'prueba2';
  l_archivo.extension := 'txt';
  k_archivo.p_calcular_propiedades(l_archivo.contenido,
                                   l_archivo.checksum,
                                   l_archivo.tamano);
  l_adjuntos.extend;
  l_adjuntos(l_adjuntos.count) := l_archivo;
  --
  l_archivo           := new y_archivo();
  l_archivo.contenido := k_util.clob_to_blob('Este es un archivo de texto 3');
  l_archivo.nombre    := 'prueba3';
  l_archivo.extension := 'txt';
  k_archivo.p_calcular_propiedades(l_archivo.contenido,
                                   l_archivo.checksum,
                                   l_archivo.tamano);
  l_adjuntos.extend;
  l_adjuntos(l_adjuntos.count) := l_archivo;

  -- Call the procedure
  k_mensajeria.p_enviar_correo(i_id_plantilla      => :i_id_plantilla,
                               i_datos_extra       => :i_datos_extra,
                               i_id_usuario        => :i_id_usuario,
                               i_destinatario      => :i_destinatario,
                               i_destino_respuesta => :i_destino_respuesta,
                               i_destinatario_cc   => :i_destinatario_cc,
                               i_destinatario_bcc  => :i_destinatario_bcc,
                               i_adjuntos          => l_adjuntos);
end;
7
i_id_plantilla
1
PLANTILLA_DEMO
5
i_datos_extra
1
{"asunto":"Asunto de prueba", "contenido":"Mensaje de prueba"}
5
i_id_usuario
0
4
i_destinatario
1
demouser@risk.com
5
i_destino_respuesta
0
5
i_destinatario_cc
0
5
i_destinatario_bcc
0
5
0
