create or replace force view v_monitoreo_usu_responsables as
select s.id_monitoreo, jt.posicion, jt.valor usuario
  from t_monitoreos s,
       t_operaciones o,
       json_table(s.usuarios_responsables,
                  '$[*]' columns(posicion for ordinality,
                          valor varchar2(100) path '$')) jt
 where s.id_monitoreo = o.id_operacion
   and o.activo = 'S'
   and s.activo = 'S';

