CREATE OR REPLACE PACKAGE BODY k_autorizacion IS

  FUNCTION f_validar_permiso(i_id_usuario IN NUMBER,
                             i_id_permiso IN VARCHAR2,
                             i_accion     IN VARCHAR2 DEFAULT NULL)
    RETURN BOOLEAN IS
    l_permiso VARCHAR2(1);
  BEGIN
    SELECT decode(i_accion,
                  NULL,
                  decode(nvl(COUNT(*), 0), 0, 'N', 'S'),
                  'C',
                  nvl(MAX(rp.consultar), 'N'),
                  'I',
                  nvl(MAX(rp.insertar), 'N'),
                  'A',
                  nvl(MAX(rp.actualizar), 'N'),
                  'E',
                  nvl(MAX(rp.eliminar), 'N'),
                  'N')
      INTO l_permiso
      FROM t_rol_permisos rp
     WHERE rp.id_rol IN (SELECT ru.id_rol
                           FROM t_rol_usuarios ru
                          WHERE ru.id_usuario = i_id_usuario)
       AND upper(rp.id_permiso) = upper(i_id_permiso);
    RETURN k_util.string_to_bool(l_permiso);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END;

END;
/
