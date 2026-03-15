-- Control de columnas de tablas para identificadores numéricos
select *
  from all_tab_columns c
 where c.column_name like 'ID_%'
   and c.data_type = 'NUMBER'
   and c.data_precision is not null
   and c.owner like '%RISK%';
-- Control de atributos de types para identificadores numéricos
select *
  from all_type_attrs a
 where a.attr_name like 'ID_%'
   and a.attr_type_name = 'NUMBER'
   and a.precision is not null
   and a.owner like '%RISK%';
-- Control de columnas de tablas con tipo CHAR
select *
  from all_tab_columns l
 where l.data_type = 'CHAR'
   and l.owner like '%RISK%'
 order by l.owner, l.table_name;
-- Control de atributos de types con tipo CHAR
select *
  from all_type_attrs l
 where l.attr_type_name = 'CHAR'
   and l.owner like '%RISK%'
 order by l.owner, l.type_name;
