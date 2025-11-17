CREATE OR REPLACE PACKAGE test_k_error IS

  --%suite(Tests unitarios del paquete k_error)
  --%tags(package)

  --%context(Tests unitarios de f_tipo_excepcion)
  --%name(f_tipo_excepcion)

  --%test()
  PROCEDURE f_tipo_excepcion_ude_negativo;
  --%test()
  PROCEDURE f_tipo_excepcion_ude_positivo;
  --%test()
  PROCEDURE f_tipo_excepcion_ope;
  --%endcontext

  --%context(Tests unitarios de f_mensaje_excepcion)
  --%name(f_mensaje_excepcion)

  --%test()
  PROCEDURE f_mensaje_excepcion_ude;
  --%test()
  PROCEDURE f_mensaje_excepcion_ope;
  --%test()
  PROCEDURE f_mensaje_excepcion_ope_sin_plsql;
  --%endcontext

  --%context(Tests unitarios de f_mensaje_error)
  --%name(f_mensaje_error)

  --%test()
  PROCEDURE f_mensaje_error_default_wrap_char;
  --%test()
  PROCEDURE f_mensaje_error_custom_wrap_char;
  --%test()
  PROCEDURE f_mensaje_error_no_registrado;
  --%endcontext

END;
/
