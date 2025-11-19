create or replace package body k_autorizacion is

  function f_validar_permiso(i_id_usuario in number,
                             i_id_permiso in varchar2,
                             i_accion     in varchar2 default null)
    return boolean is
    l_permiso varchar2(1);
  begin
    select decode(i_accion,
                  null,
                  decode(nvl(count(*), 0), 0, 'N', 'S'),
                  'C',
                  nvl(max(rp.consultar), 'N'),
                  'I',
                  nvl(max(rp.insertar), 'N'),
                  'A',
                  nvl(max(rp.actualizar), 'N'),
                  'E',
                  nvl(max(rp.eliminar), 'N'),
                  'N')
      into l_permiso
      from t_rol_permisos rp
     where rp.id_rol in (select ru.id_rol
                           from t_rol_usuarios ru
                          where ru.id_usuario = i_id_usuario)
       and upper(rp.id_permiso) = upper(i_id_permiso);
    return k_util.string_to_bool(l_permiso);
  exception
    when others then
      return false;
  end;

end;
/
