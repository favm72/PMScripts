delete from wfw_rol_recurso where 
       recurso_id = (select recurso_id from wfw_recurso where nombre = 'GMTMCO');
       
delete from wfw_recurso where nombre = 'GMTMCO';

commit;
