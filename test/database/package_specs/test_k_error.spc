create or replace package test_k_error is

  --%suite(Tests unitarios del paquete k_error)
  --%tags(package)

  --%context(Tests unitarios de f_tipo_excepcion)
  --%name(f_tipo_excepcion)

  --%test()
  procedure f_tipo_excepcion_ude_negativo;
  --%test()
  procedure f_tipo_excepcion_ude_positivo;
  --%test()
  procedure f_tipo_excepcion_ope;
  --%endcontext

  --%context(Tests unitarios de f_mensaje_excepcion)
  --%name(f_mensaje_excepcion)

  --%test()
  procedure f_mensaje_excepcion_ude;
  --%test()
  procedure f_mensaje_excepcion_ope;
  --%test()
  procedure f_mensaje_excepcion_ope_sin_plsql;
  --%endcontext

  --%context(Tests unitarios de f_mensaje_error)
  --%name(f_mensaje_error)

  --%test()
  procedure f_mensaje_error_default_wrap_char;
  --%test()
  procedure f_mensaje_error_custom_wrap_char;
  --%test()
  procedure f_mensaje_error_no_registrado;
  --%endcontext

end;
/
