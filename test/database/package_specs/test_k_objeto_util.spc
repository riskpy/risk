create or replace package test_k_objeto_util is

  --%suite(Tests unitarios del paquete k_objeto_util)
  --%tags(package)

  --%context(Tests unitarios de parse_json y to_json)
  --%name(parse_json_to_json)

  --%test()
  procedure parse_json_to_json_escenario_1;
  --%test()
  procedure parse_json_to_json_escenario_2;
  --%test()
  procedure parse_json_to_json_escenario_5;
  --%endcontext

end;
/
