create or replace package body test_k_importacion is

  procedure p_procesar_importacion_campos_fijos_ok is
    l_respuesta    varchar2(4000);
    l_archivo_blob blob;
    l_archivo_clob clob;
  begin
    l_archivo_clob := '422222   ARGENTINA           ARGENTINA           AR ARG 32
311111   PARAGUAY            PARAGUAY            PU PRU999
644444   BOLIVIA             BOLIVIANA           BU BUL998';
  
    l_archivo_blob := k_lob_util.f_obtener_blob_desde_clob(l_archivo_clob);
  
    -- Ejecutar el proceso principal
    l_respuesta := k_importacion.f_procesar_importacion(i_nombre                 => 'IMPORTAR_PAISES_CAMPOS_FIJOS',
                                                        i_dominio                => 'GEN',
                                                        i_archivo                => l_archivo_blob,
                                                        i_parametros_adicionales => '',
                                                        i_transaccion_autonoma   => false,
                                                        i_version                => null);
    ut.expect(l_respuesta).to_equal('{"codigo":"0","mensaje":"OK","mensaje_bd":"Filas insertadas : 2","lugar":null,"datos":null}');
  end;

  procedure p_procesar_importacion_campos_fijos_error is
    l_respuesta    varchar2(4000);
    l_archivo_blob blob;
    l_archivo_clob clob;
  begin
    l_archivo_clob := '422222   ARGENTINA           ARGENTINA           AR ARG 32
533333   BRASIL              BRASILERA           BR BRA 76
311111   PARAGUAY            PARAGUAY            PU PRU999
644444   BOLIVIA             BOLIVIANA           BU BUL998
755555   CHILE               CHILENA             CL CHL152';
  
    l_archivo_blob := k_lob_util.f_obtener_blob_desde_clob(l_archivo_clob);
  
    -- Ejecutar el proceso principal
    l_respuesta := k_importacion.f_procesar_importacion(i_nombre                 => 'IMPORTAR_PAISES_CAMPOS_FIJOS',
                                                        i_dominio                => 'GEN',
                                                        i_archivo                => l_archivo_blob,
                                                        i_parametros_adicionales => '',
                                                        i_transaccion_autonoma   => false,
                                                        i_version                => null);
    ut.expect(l_respuesta).to_equal('{"codigo":"import0001","mensaje":"Error al importar archivo en las líneas: [2, 5]. Verifique.","mensaje_bd":null,"lugar":null,"datos":{"contenido":null}}');
  end;

  procedure p_procesar_importacion_campos_separados_por_coma_ok is
    l_respuesta    varchar2(4000);
    l_archivo_blob blob;
    l_archivo_clob clob;
  begin
    l_archivo_clob := '1,"Asunción, ciudad de"
999999,Villeta
999998,Carapegua
999997, Villa Elisa';
  
    l_archivo_blob := k_lob_util.f_obtener_blob_desde_clob(l_archivo_clob);
  
    -- Ejecutar el proceso principal
    l_respuesta := k_importacion.f_procesar_importacion(i_nombre                 => 'IMPORTAR_CIUDADES_SEPARADOS_POR_COMA',
                                                        i_dominio                => 'GEN',
                                                        i_archivo                => l_archivo_blob,
                                                        i_parametros_adicionales => '{"id_pais":null}',
                                                        i_transaccion_autonoma   => false,
                                                        i_version                => null);
    ut.expect(l_respuesta).to_equal('{"codigo":"0","mensaje":"OK","mensaje_bd":"Filas insertadas : 4","lugar":null,"datos":null}');
  end;

  procedure p_procesar_importacion_campos_separados_por_coma_error is
    l_respuesta    varchar2(4000);
    l_archivo_blob blob;
    l_archivo_clob clob;
  begin
    l_archivo_clob := '1,"Asunción, ciudad de"
999999,Villeta
999998,Carapegua
999997, Villa Elisa';
  
    l_archivo_blob := k_lob_util.f_obtener_blob_desde_clob(l_archivo_clob);
  
    -- Ejecutar el proceso principal
    l_respuesta := k_importacion.f_procesar_importacion(i_nombre                 => 'IMPORTAR_CIUDADES_SEPARADOS_POR_COMA',
                                                        i_dominio                => 'GEN',
                                                        i_archivo                => l_archivo_blob,
                                                        i_parametros_adicionales => '',
                                                        i_transaccion_autonoma   => false,
                                                        i_version                => null);
    ut.expect(l_respuesta).to_equal('{"codigo":"import0001","mensaje":"Faltan parámetros adicionales: id_pais","mensaje_bd":null,"lugar":"Validando parámetros adicionales de la importación de archivo","datos":null}');
  end;

end;
/
