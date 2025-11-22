create or replace package body test_k_cadena is

  procedure f_valor_posicion_separador_por_defecto is
  begin
    ut.expect(k_cadena.f_valor_posicion('hola-que-tal-como-estas-chau', 3)).to_equal('hola-que-tal-como-estas-chau');
  end;

  procedure f_valor_posicion_separador_un_caracter is
  begin
    ut.expect(k_cadena.f_valor_posicion('hola-que-tal-como-estas-chau',
                                        3,
                                        '-')).to_equal('tal');
  end;

  procedure f_valor_posicion_separador_varios_caracteres is
  begin
    ut.expect(k_cadena.f_valor_posicion('hola/*/que/*/tal/*/como/*/estas/*/chau',
                                        3,
                                        '/*/')).to_equal('tal');
  end;

  procedure f_valor_posicion_fuera_de_rango_mayor is
  begin
    ut.expect(k_cadena.f_valor_posicion('hola-que-tal-como-estas-chau',
                                        100,
                                        '-')).to_equal('chau');
  end;

  procedure f_valor_posicion_fuera_de_rango_menor is
  begin
    ut.expect(k_cadena.f_valor_posicion('hola-que-tal-como-estas-chau',
                                        0,
                                        '-')).to_equal('hola');
  end;

  procedure f_reemplazar_acentos_uso_basico is
  begin
    ut.expect(k_cadena.f_reemplazar_acentos('La cigüeña tocaba el saxofón detrás del palenque de paja')).to_equal('La cigueña tocaba el saxofon detras del palenque de paja');
  end;

  procedure f_formatear_titulo_uso_basico is
  begin
    ut.expect(k_cadena.f_formatear_titulo('ESte eS UN títULO DE pruEba srl')).to_equal('Este Es Un Título de Prueba SRL');
  end;

end;
/
