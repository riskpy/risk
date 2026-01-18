create or replace package body test_k_importacion is

  procedure p_procesar_importacion_campos_fijos_ok is
    l_resultado    clob;
    l_respuesta    y_respuesta;
    l_archivo_blob blob;
    l_archivo_clob clob;
  begin
    l_archivo_clob := '422222   ARGENTINA           ARGENTINA           AR ARG 32
311111   PARAGUAY            PARAGUAY            PU PRU999
644444   BOLIVIA             BOLIVIANA           BU BUL998';
  
    l_archivo_blob := k_lob_util.f_obtener_blob_desde_clob(l_archivo_clob);
  
    -- Ejecutar el proceso principal
    l_resultado := k_importacion.f_procesar_importacion(i_nombre                 => 'IMPORTAR_PAISES_CAMPOS_FIJOS',
                                                        i_dominio                => 'GEN',
                                                        i_archivo                => l_archivo_blob,
                                                        i_parametros_adicionales => '',
                                                        i_transaccion_autonoma   => false,
                                                        i_version                => null);
  
    k_sistema.p_inicializar_cola;
    k_sistema.p_encolar('Y_DATO');
    l_respuesta := treat(y_respuesta.parse_json(l_resultado) as y_respuesta);
    ut.expect(l_respuesta.codigo).to_equal(k_operacion.c_ok);
  end;

  procedure p_procesar_importacion_campos_fijos_error is
    l_resultado    clob;
    l_respuesta    y_respuesta;
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
    l_resultado := k_importacion.f_procesar_importacion(i_nombre                 => 'IMPORTAR_PAISES_CAMPOS_FIJOS',
                                                        i_dominio                => 'GEN',
                                                        i_archivo                => l_archivo_blob,
                                                        i_parametros_adicionales => '',
                                                        i_transaccion_autonoma   => false,
                                                        i_version                => null);
  
    k_sistema.p_inicializar_cola;
    k_sistema.p_encolar('Y_DATO');
    l_respuesta := treat(y_respuesta.parse_json(l_resultado) as y_respuesta);
    ut.expect(l_respuesta.mensaje).to_equal('Error al importar archivo en las líneas: [2, 5]. Verifique.');
  end;

  procedure p_procesar_importacion_campos_separados_por_coma_ok is
    l_resultado    clob;
    l_respuesta    y_respuesta;
    l_archivo_blob blob;
    l_archivo_clob clob;
  begin
    l_archivo_clob := '1,"Asunción, ciudad de"
999999,Villeta
999998,Carapegua
999997, Villa Elisa';
  
    l_archivo_blob := k_lob_util.f_obtener_blob_desde_clob(l_archivo_clob);
  
    -- Ejecutar el proceso principal
    l_resultado := k_importacion.f_procesar_importacion(i_nombre                 => 'IMPORTAR_CIUDADES_SEPARADOS_POR_COMA',
                                                        i_dominio                => 'GEN',
                                                        i_archivo                => l_archivo_blob,
                                                        i_parametros_adicionales => '{"id_pais":null}',
                                                        i_transaccion_autonoma   => false,
                                                        i_version                => null);
  
    k_sistema.p_inicializar_cola;
    k_sistema.p_encolar('Y_DATO');
    l_respuesta := treat(y_respuesta.parse_json(l_resultado) as y_respuesta);
    ut.expect(l_respuesta.codigo).to_equal(k_operacion.c_ok);
  end;

  procedure p_procesar_importacion_campos_separados_por_coma_error is
    l_resultado    clob;
    l_respuesta    y_respuesta;
    l_archivo_blob blob;
    l_archivo_clob clob;
  begin
    l_archivo_clob := '1,"Asunción, ciudad de"
999999,Villeta
999998,Carapegua
999997, Villa Elisa';
  
    l_archivo_blob := k_lob_util.f_obtener_blob_desde_clob(l_archivo_clob);
  
    -- Ejecutar el proceso principal
    l_resultado := k_importacion.f_procesar_importacion(i_nombre                 => 'IMPORTAR_CIUDADES_SEPARADOS_POR_COMA',
                                                        i_dominio                => 'GEN',
                                                        i_archivo                => l_archivo_blob,
                                                        i_parametros_adicionales => '',
                                                        i_transaccion_autonoma   => false,
                                                        i_version                => null);
  
    k_sistema.p_inicializar_cola;
    k_sistema.p_encolar('Y_DATO');
    l_respuesta := treat(y_respuesta.parse_json(l_resultado) as y_respuesta);
    ut.expect(l_respuesta.mensaje).to_equal('Faltan parámetros adicionales: id_pais');
  end;

end;
/

