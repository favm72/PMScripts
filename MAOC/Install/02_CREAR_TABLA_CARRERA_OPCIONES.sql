-- Create table
create table WFW_CARRERA_OPCIONES
(
    carrera_opc_id          NUMBER(10) NOT NULL,
    tipo_solicitud_mod_id   NUMBER(10) NOT NULL,
    cod_producto            CHAR(8) NOT NULL,
    excluir_flujo           NUMBER(1) DEFAULT 0 NOT NULL,
    comentario              VARCHAR2(500),
    usuario_crea            VARCHAR2(10) NOT NULL,
    fecha_crea              DATE NOT NULL,
    usuario_mod             VARCHAR2(10),
    fecha_mod               DATE
);
ALTER TABLE wfw_carrera_opciones ADD CHECK (excluir_flujo IN (0, 1));
/*
tablespace WSPWORK_DATA
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );*/
-- Add comments to the columns 
COMMENT ON COLUMN wfw_carrera_opciones.carrera_opc_id IS 'ID DE LA TABLA';
COMMENT ON COLUMN wfw_carrera_opciones.tipo_solicitud_mod_id IS 'CÓDIGO DEL TIPO DE SOLICITUD MODALIDAD';
COMMENT ON COLUMN wfw_carrera_opciones.cod_producto IS 'CÓDIGO DEL PRODUCTO';
COMMENT ON COLUMN wfw_carrera_opciones.excluir_flujo IS 'FLAG PARA EXCLUIR DEL FLUJO DEL TRÁMITE';
COMMENT ON COLUMN wfw_carrera_opciones.comentario IS 'COMENTARIO';
COMMENT ON COLUMN wfw_carrera_opciones.usuario_crea IS 'USUARIO DE CREACIÓN';
COMMENT ON COLUMN wfw_carrera_opciones.fecha_crea IS 'FECHA DE CREACIÓN';
COMMENT ON COLUMN wfw_carrera_opciones.usuario_mod IS 'USUARIO DE ACTUALIZACIÓN';
COMMENT ON COLUMN wfw_carrera_opciones.fecha_mod IS 'FECHA DE ACTUALIZACIÓN';
-- Create/Recreate primary, unique and foreign key constraints 
alter table WFW_CARRERA_OPCIONES
  add constraint PK_CARRERA_OPCIONES primary key (CARRERA_OPC_ID);
alter table WFW_CARRERA_OPCIONES
  add constraint UK_CARRERA_OPCIONES_01 unique (COD_PRODUCTO, TIPO_SOLICITUD_MOD_ID);
alter table WFW_CARRERA_OPCIONES
  add constraint FK_CARRERA_OPCIONES_01 foreign key (TIPO_SOLICITUD_MOD_ID)
  references wfw_tipo_solicitud_mod (TIPO_SOLICITUD_MOD_ID);

commit;

/