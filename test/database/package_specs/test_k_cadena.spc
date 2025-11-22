create or replace package test_k_cadena is

  --%suite(Tests unitarios del paquete k_cadena)
  --%tags(package)

  --%context(Tests unitarios de f_valor_posicion)
  --%name(f_valor_posicion)

  --%test()
  procedure f_valor_posicion_separador_por_defecto;
  --%test()
  procedure f_valor_posicion_separador_un_caracter;
  --%test()
  procedure f_valor_posicion_separador_varios_caracteres;
  --%test()
  procedure f_valor_posicion_fuera_de_rango_mayor;
  --%test()
  procedure f_valor_posicion_fuera_de_rango_menor;
  --%endcontext

  --%context(Tests unitarios de f_reemplazar_acentos)
  --%name(f_reemplazar_acentos)

  --%test()
  procedure f_reemplazar_acentos_uso_basico;
  --%endcontext

  --%context(Tests unitarios de f_formatear_titulo)
  --%name(f_formatear_titulo)

  --%test(Formateo básico de título)
  procedure f_formatear_titulo_uso_basico;
  --%endcontext

end;
/
