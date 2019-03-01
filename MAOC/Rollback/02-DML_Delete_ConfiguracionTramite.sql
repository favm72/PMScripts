DECLARE
    C_COD_TIPO_SOL_TPADRE CONSTANT WFW_TIPO_SOLICITUD.COD_TIPO_SOL%TYPE := 'PM';

    C_COD_TIPO_SOL_MAOC CONSTANT WFW_TIPO_SOLICITUD.COD_TIPO_SOL%TYPE := 'MAOC';
    
    C_ROL_ALUMNO CONSTANT WFW_ROL.NOMBRE%TYPE := 'ALUMNO_UPC';
    C_ROL_COUNTER_PM CONSTANT WFW_ROL.NOMBRE%TYPE := 'COUNTER PM';
    C_ROL_BANDEJA CONSTANT WFW_ROL.NOMBRE%TYPE := 'BANDEJA MODALIDAD';
    
    --C_COD_GRUPO_TRAMITE CONSTANT WFW_GRUPO_TRAMITE.COD_GRUPO_TRAMITE%TYPE := 'GRP050';  -- Modificar aquí, real asignado GRP015
    C_COD_REQUISITO CONSTANT WFW_REQUISITO.COD_REQUISITO%TYPE := 'VALCONVAL';
    C_NOMBRE_ARCHIVO CONSTANT WFW_MAESTRO.DESCRIPCION%TYPE := 'Constancia_convalidacion';
  
    C_COD_REQUISITO_VPERMATR CONSTANT WFW_REQUISITO.COD_REQUISITO%TYPE := 'VALPERMAT2';--VALPERMATR observado
    C_COD_REQUISITO_VEGR CONSTANT WFW_REQUISITO.COD_REQUISITO%TYPE := 'VALEGRESA2';--VALEGRESAD observado
    C_COD_REQUISITO_VPERSOLI CONSTANT WFW_REQUISITO.COD_REQUISITO%TYPE := 'VALPERSOLI';--Nuevo
    C_COD_REQUISITO_VBAJA CONSTANT WFW_REQUISITO.COD_REQUISITO%TYPE := 'VALBAJAACA';--Nuevo
    C_COD_REQUISITO_VPERMANENCIA CONSTANT WFW_REQUISITO.COD_REQUISITO%TYPE := 'VALECARTAP';--Nuevo
    C_COD_REQUISITO_VCARGAHABIL CONSTANT WFW_REQUISITO.COD_REQUISITO%TYPE := 'VALCARGAHA';--Nuevo
    
BEGIN
  
     -- TABLAS NO TRANSACCIONALES    
    DELETE WFW_ROL_ACT_OPC
    WHERE ACTIVIDAD_ID IN (SELECT ACTIVIDAD_ID FROM WFW_ACTIVIDAD A WHERE A.TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC)));

    -- INICIO TRANSACCIONALES
    DELETE WFW_TRAMA_ANULACION
      WHERE
          SOLICITUD_ID IN (SELECT S.SOLICITUD_ID FROM WFW_SOLICITUD S INNER JOIN WFW_TIPO_SOLICITUD TS ON S.T_SOLICITUD_ID = TS.TIPO_SOLICITUD_ID WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));
    
    DELETE WFW_EVALUACION_SOL
      WHERE
          SOLICITUD_ID IN (SELECT S.SOLICITUD_ID FROM WFW_SOLICITUD S INNER JOIN WFW_TIPO_SOLICITUD TS ON S.T_SOLICITUD_ID = TS.TIPO_SOLICITUD_ID WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));
  	
    DELETE WFW_NOTIFICACION_DET
      WHERE
      NOTIFICACION_ID IN (SELECT NOTIFICACION_ID FROM WFW_NOTIFICACION WHERE ACTIVIDAD_ID IN (SELECT ACTIVIDAD_ID FROM WFW_ACTIVIDAD AT WHERE AT.TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC))));
  	
    DELETE WFW_SUSTENTO_SOL
      WHERE
          SOLICITUD_ID IN (SELECT S.SOLICITUD_ID FROM WFW_SOLICITUD S INNER JOIN WFW_TIPO_SOLICITUD TS ON S.T_SOLICITUD_ID = TS.TIPO_SOLICITUD_ID WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));
  	
    DELETE WFW_FORMULARIO
      WHERE
          SOLICITUD_ID IN (SELECT S.SOLICITUD_ID FROM WFW_SOLICITUD S INNER JOIN WFW_TIPO_SOLICITUD TS ON S.T_SOLICITUD_ID = TS.TIPO_SOLICITUD_ID WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));
  	
    DELETE WFW_SEMAFORO_DET
      WHERE
          SOLICITUD_ID IN (SELECT S.SOLICITUD_ID FROM WFW_SOLICITUD S INNER JOIN WFW_TIPO_SOLICITUD TS ON S.T_SOLICITUD_ID = TS.TIPO_SOLICITUD_ID WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));
  	
    DELETE WFW_TRAMA
      WHERE
          SOLICITUD_ID IN (SELECT S.SOLICITUD_ID FROM WFW_SOLICITUD S INNER JOIN WFW_TIPO_SOLICITUD TS ON S.T_SOLICITUD_ID = TS.TIPO_SOLICITUD_ID WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));
  	
    DELETE WFW_SEMAFORO_TRAMITE_DET STD
      WHERE
          SOLICITUD_ID IN (SELECT S.SOLICITUD_ID FROM WFW_SOLICITUD S INNER JOIN WFW_TIPO_SOLICITUD TS ON S.T_SOLICITUD_ID = TS.TIPO_SOLICITUD_ID WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));
  	
    DELETE WFW_SOL_DATO
      WHERE
          SOLICITUD_ID IN (SELECT S.SOLICITUD_ID FROM WFW_SOLICITUD S INNER JOIN WFW_TIPO_SOLICITUD TS ON S.T_SOLICITUD_ID = TS.TIPO_SOLICITUD_ID WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));
      
    DELETE WFW_DETALLE_SOLICITUD
      WHERE
          SOLICITUD_ID IN (SELECT S.SOLICITUD_ID FROM WFW_SOLICITUD S INNER JOIN WFW_TIPO_SOLICITUD TS ON S.T_SOLICITUD_ID = TS.TIPO_SOLICITUD_ID WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));
  	
    DELETE WFW_SOLICITUD
      WHERE
          T_SOLICITUD_ID IN (SELECT TS.TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));
    -- FIN TRANSACCIONALES  

    -- INICIO CONFIGURACIÓN SUBTRAMITE -- 
    
  	DELETE WFW_NOTF_TRAMITE_DEST
    WHERE NOTF_TRAMITE_ID IN (SELECT NOTF_TRAMITE_ID FROM WFW_NOTF_TRAMITE NT WHERE TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC)));
    
    DBMS_OUTPUT.PUT_LINE('1 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );
    
    DELETE FROM WFW_NOTF_TRAMITE_DET WHERE NOTF_TRAMITE_ID IN
           (SELECT NOTF_TRAMITE_ID FROM WFW_NOTF_TRAMITE WHERE TIPO_SOLICITUD_ID IN 
           (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN('MAOC')) );
           
    DBMS_OUTPUT.PUT_LINE('1-1 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );

  	DELETE WFW_NOTF_TRAMITE
    WHERE TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));

    DBMS_OUTPUT.PUT_LINE('2 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );
        
  	DELETE WFW_NOTF_DESTINATARIO 
    WHERE NOTIFICACION_ID IN (SELECT NOTIFICACION_ID FROM WFW_NOTIFICACION WHERE ACTIVIDAD_ID IN (SELECT ACTIVIDAD_ID FROM WFW_ACTIVIDAD AT WHERE AT.TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC))));

    DBMS_OUTPUT.PUT_LINE('3 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );
    
  	DELETE WFW_NOTIFICACION
    WHERE ACTIVIDAD_ID IN (SELECT ACTIVIDAD_ID FROM WFW_ACTIVIDAD AT WHERE AT.TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC)));

    DBMS_OUTPUT.PUT_LINE('4 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );
    
  	DELETE WFW_ACTIVIDAD
    WHERE	TIPO_SOLICITUD_ID IN (SELECT TS.TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));

    DBMS_OUTPUT.PUT_LINE('5 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );

  	DELETE WFW_AVISO_TIPO_SOL
    WHERE TIPO_SOLICITUD_MOD_ID IN (SELECT TIPO_SOLICITUD_MOD_ID FROM WFW_TIPO_SOLICITUD_MOD TSM WHERE TSM.TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC)));

    DBMS_OUTPUT.PUT_LINE('6 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );

    DELETE WFW_TIPO_SOL_CONFIG
    WHERE TIPO_SOLICITUD_MOD_ID IN (SELECT TSM.TIPO_SOLICITUD_MOD_ID FROM WFW_TIPO_SOLICITUD_MOD TSM WHERE TSM.TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC)));
    
    DBMS_OUTPUT.PUT_LINE('7 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  

    DELETE WFW_GLOSA_TRAMITE
    WHERE TIPO_SOLICITUD_MOD_ID IN (SELECT TIPO_SOLICITUD_MOD_ID FROM WFW_TIPO_SOLICITUD_MOD TSM WHERE TSM.TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC, C_COD_TIPO_SOL_TPADRE)));

    DBMS_OUTPUT.PUT_LINE('8 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
    
    DELETE WFW_REQUISITOS_TIPO_SOL
    WHERE TIPO_SOLICITUD_MOD_ID IN (SELECT TIPO_SOLICITUD_MOD_ID FROM WFW_TIPO_SOLICITUD_MOD TSM WHERE TSM.TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC)));

    DBMS_OUTPUT.PUT_LINE('9 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  

    DELETE WFW_GRUPO_TRAMITE_DET
    WHERE TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));

    DBMS_OUTPUT.PUT_LINE('10 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
    
    DELETE WFW_GRUPO_TRAMITE
    WHERE TIPO_SOLICITUD_ID_PADRE IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL = C_COD_TIPO_SOL_TPADRE AND TIPO_GRUPO_TRAMITE = (SELECT CODIGO_NUM FROM WFW_MAESTRO WHERE NOMBRE_TABLA = 'TIPO_GRUPO_TRAMITE' AND DESCRIPCION = 'SUB-GRUPO'));
    
    DBMS_OUTPUT.PUT_LINE('11 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
    
    DELETE WFW_VIGENCIA_TRAMITE
    WHERE TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));

    DBMS_OUTPUT.PUT_LINE('12 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
    
    DELETE WFW_REGISTRO_ROL 
    WHERE TIPO_SOLICITUD_MOD_ID IN (SELECT TIPO_SOLICITUD_MOD_ID FROM WFW_TIPO_SOLICITUD_MOD TSM WHERE TSM.TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC)));
    
    DBMS_OUTPUT.PUT_LINE('13 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  

    DELETE WFW_TIPO_SOLICITUD_MOD
    WHERE TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));

    DBMS_OUTPUT.PUT_LINE('14 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  

    DELETE WFW_TIPO_SOLICITUD_ROL
    WHERE TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));

    DBMS_OUTPUT.PUT_LINE('15 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
  
    DELETE WFW_MAESTRO
    WHERE NOMBRE_TABLA = 'LINK_MODELO' AND CODIGO_STR IN (SELECT TS.TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC));

    DBMS_OUTPUT.PUT_LINE('16 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
    
    DELETE WFW_TIPO_SOLICITUD
    WHERE COD_TIPO_SOL IN(C_COD_TIPO_SOL_MAOC);
    
    DBMS_OUTPUT.PUT_LINE('17 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
    
	  -- FIN CONFIGURACIÓN SUBTRAMITE -- 
  
    -- INICIO CONFIGURACIÓN COMUNES --
    
  	DELETE WFW_REQUISITO
    WHERE COD_REQUISITO IN (C_COD_REQUISITO_VPERMATR,C_COD_REQUISITO_VPERSOLI,C_COD_REQUISITO_VBAJA,C_COD_REQUISITO_VEGR,C_COD_REQUISITO_VPERMANENCIA,C_COD_REQUISITO_VCARGAHABIL);

    DBMS_OUTPUT.PUT_LINE('18 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  

    DELETE WFW_GRUPO_TRAMITE
    WHERE TIPO_SOLICITUD_ID_PADRE IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL = C_COD_TIPO_SOL_TPADRE) AND TIPO_GRUPO_TRAMITE = (SELECT CODIGO_NUM FROM WFW_MAESTRO WHERE NOMBRE_TABLA = 'TIPO_GRUPO_TRAMITE' AND DESCRIPCION = 'GRUPO');

    DBMS_OUTPUT.PUT_LINE('19 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  

    DELETE WFW_ROL_RECURSO
    WHERE
        ROL_ID IN (SELECT ROL_ID FROM WFW_ROL WHERE NOMBRE = C_ROL_COUNTER_PM);

    DBMS_OUTPUT.PUT_LINE('20 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  

    DELETE WFW_ROL    
    WHERE
        NOMBRE = C_ROL_COUNTER_PM AND
        TIPO_ROL_ID = (SELECT CODIGO_NUM FROM WFW_MAESTRO M WHERE M.NOMBRE_TABLA = 'TIPO_ROL' AND DESCRIPCION = 'COUNTER');

    DBMS_OUTPUT.PUT_LINE('21 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  

    DELETE WFW_ROL
    WHERE
        NOMBRE = C_ROL_BANDEJA AND
        TIPO_ROL_ID = (SELECT CODIGO_NUM FROM WFW_MAESTRO M WHERE M.NOMBRE_TABLA = 'TIPO_ROL' AND DESCRIPCION = 'EVALUADOR');

    DBMS_OUTPUT.PUT_LINE('21-1 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
      
    DELETE WFW_VIGENCIA_TRAMITE
    WHERE TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL = C_COD_TIPO_SOL_TPADRE);
    
    DBMS_OUTPUT.PUT_LINE('22 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
    
    DELETE FROM WFW_REGLAMENTO_TRAMITE WHERE TIPO_SOLICITUD_MOD_ID IN(
           SELECT TIPO_SOLICITUD_MOD_ID FROM WFW_TIPO_SOLICITUD_MOD WHERE TIPO_SOLICITUD_ID IN 
           (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL=C_COD_TIPO_SOL_TPADRE ));          
           
    DBMS_OUTPUT.PUT_LINE('22-1 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );
    
    DELETE WFW_TIPO_SOLICITUD_MOD
    WHERE TIPO_SOLICITUD_ID IN (SELECT TIPO_SOLICITUD_ID FROM WFW_TIPO_SOLICITUD TS WHERE TS.COD_TIPO_SOL = C_COD_TIPO_SOL_TPADRE);
    
    DBMS_OUTPUT.PUT_LINE('23 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
    
    DELETE WFW_TIPO_SOLICITUD
    WHERE COD_TIPO_SOL = C_COD_TIPO_SOL_TPADRE;
    
    DBMS_OUTPUT.PUT_LINE('24 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
    
    DELETE WFW_RECURSO
    WHERE NOMBRE = C_COD_TIPO_SOL_TPADRE AND TIPO_ID = (SELECT CODIGO_NUM FROM WFW_MAESTRO WHERE NOMBRE_TABLA = 'TIPO_RECURSO' AND CODIGO_STR = 'TRAM');
    
    DBMS_OUTPUT.PUT_LINE('25 '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );  
    
	-- FIN CONFIGURACIÓN COMUNES
  
    DBMS_OUTPUT.PUT_LINE('ELIMINACION DE LA CONFIGURACIÓN OK!!! ' || to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('PROBLEMA: ' ||  'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM||' '|| to_char(sysdate,'DD/MM/YYYY HH:MI:SS')  );
        ROLLBACK;
        RAISE;
END;

