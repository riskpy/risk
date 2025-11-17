CREATE OR REPLACE PACKAGE test_k_cadena IS

  --%suite(Tests unitarios del paquete k_cadena)
  --%tags(package)

  --%context(Tests unitarios de f_valor_posicion)
  --%name(f_valor_posicion)

  --%test()
  PROCEDURE f_valor_posicion_separador_por_defecto;
  --%test()
  PROCEDURE f_valor_posicion_separador_un_caracter;
  --%test()
  PROCEDURE f_valor_posicion_separador_varios_caracteres;
  --%test()
  PROCEDURE f_valor_posicion_fuera_de_rango_mayor;
  --%test()
  PROCEDURE f_valor_posicion_fuera_de_rango_menor;
  --%endcontext

  --%context(Tests unitarios de f_reemplazar_acentos)
  --%name(f_reemplazar_acentos)

  --%test()
  PROCEDURE f_reemplazar_acentos_uso_basico;
  --%endcontext

  --%context(Tests unitarios de f_formatear_titulo)
  --%name(f_formatear_titulo)

  --%test(Formateo básico de título)
  PROCEDURE f_formatear_titulo_uso_basico;
  --%endcontext

END;
/
