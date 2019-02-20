CREATE OR REPLACE TRIGGER T_I_CARRERA_OPCIONES
BEFORE INSERT ON WFW_CARRERA_OPCIONES
REFERENCING NEW AS NEW
  FOR EACH ROW
BEGIN
  SELECT WFWSQ_CARRRERA_OPCIONES.NEXTVAL INTO :NEW.CARRERA_OPC_ID FROM DUAL;
END;
/
commit;