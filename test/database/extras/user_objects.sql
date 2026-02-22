select o.owner, count(*) count
  from all_objects o, all_users u
 where u.username = o.owner
   and u.oracle_maintained = 'N'
 group by o.owner
 order by 2 desc;
--
select o.*
  from all_objects o, all_users u
 where u.username = o.owner
   and u.oracle_maintained = 'N'
 order by 1, 2 desc;
--
select s.*
  from all_source s, all_users u
 where u.username = s.owner
   and u.oracle_maintained = 'N'
   and upper(text) like upper('%%');
--
SELECT 'plugin plsqldoc generate ' || lower(o.object_name) || ';' plsqldoc,
       o.*
  FROM user_objects o
 WHERE ((o.object_type = 'TYPE' AND lower(o.object_name) LIKE 'y\_%' ESCAPE '\') OR
       (o.object_type = 'TABLE' AND lower(o.object_name) LIKE 't\_%' ESCAPE '\') OR
       (o.object_type = 'PACKAGE' AND lower(o.object_name) LIKE 'k\_%'
        ESCAPE '\') OR (o.object_type = 'SEQUENCE' AND
       lower(o.object_name) LIKE 's\_%' ESCAPE '\') OR
       (o.object_type = 'TRIGGER' AND lower(o.object_name) LIKE 'g%\_%'
        ESCAPE '\'))
   AND o.object_type = 'TABLE'
 ORDER BY o.object_name;

