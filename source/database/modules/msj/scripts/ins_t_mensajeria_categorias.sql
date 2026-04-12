prompt Importing table t_mensajeria_categorias...
set feedback off
set define off

insert into t_mensajeria_categorias (ID_CATEGORIA, DESCRIPCION, DETALLE, ESTADO, FECHA_INICIO, FECHA_FIN, TELEFONIA, CLASIFICACION, PRIORIDAD)
values (269, 'Monitoreo de Conflictos', 'Monitoreo de Conflictos', 'A', to_date('13-04-2023', 'dd-mm-yyyy'), to_date('01-06-2100', 'dd-mm-yyyy'), 'TIG', 'AVISO', 1);

insert into t_mensajeria_categorias (ID_CATEGORIA, DESCRIPCION, DETALLE, ESTADO, FECHA_INICIO, FECHA_FIN, TELEFONIA, CLASIFICACION, PRIORIDAD)
values (270, 'Avisos Varios', 'Avisos Varios de SMS', 'A', to_date('10-01-2018', 'dd-mm-yyyy'), to_date('23-07-2040', 'dd-mm-yyyy'), 'TIG', 'AVISO', 4);

prompt Done.
