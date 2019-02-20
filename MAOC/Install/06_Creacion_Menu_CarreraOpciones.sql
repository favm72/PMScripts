insert into wfw_recurso
(recurso_id,
precurso_id, codigo,
tipo_id,
titulo, nombre, descripcion, url,
orden,
icono_url, tooltip, activo, usuario_crea, usuario_mod, fecha_crea, fecha_mod)
values
((select max(recurso_id)+1 from wfw_recurso),
(select recurso_id from wfw_recurso where titulo = 'Mantenedores'), 'GMTMAN',
(select codigo_num from wfw_maestro where codigo_str = 'GRMN' and nombre_tabla = 'TIPO_RECURSO'),
'Mant. Opciones Carrera', 'GMTMCO', 'Mant. Opciones Carrera', '/CarreraOpcion/Index',
(select max(orden)+1 from wfw_recurso where precurso_id = (select recurso_id from wfw_recurso where titulo = 'Mantenedores')),
null, 'Mant. Opciones Carrera', 1, 'SYSTEM WFW', null, sysdate, null);

insert into wfw_rol_recurso
(rol_recurso_id, rol_id, recurso_id, activo, usuario_crea, usuario_mod, fecha_crea, fecha_mod)
values
((select max(rol_recurso_id)+1 from wfw_rol_recurso),
(select rol_id from wfw_rol where nombre = 'Administrador'),
(select recurso_id from wfw_recurso where nombre = 'GMTMCO'),1,'SYSTEM WFW', null, sysdate, null);

COMMIT;
