CREATE OR REPLACE PROCEDURE "STP_COMPIL_OBJ_INVAL_JOUGLARD" (
    P_CODUSU         NUMBER,
    P_IDSESSAO     VARCHAR2,
    P_QTDLINHAS      NUMBER,
    P_MENSAGEM OUT VARCHAR2 
) AS
    COUNTER     NUMBER := 0;
    TEXTO VARCHAR2(4000);
BEGIN
    FOR I IN (SELECT OWNER, OBJECT_NAME, OBJECT_TYPE, STATUS 
                FROM DBA_OBJECTS 
                WHERE OWNER = 'SANKHYA'
                AND STATUS != 'VALID'
                AND OBJECT_NAME NOT IN ('FNC_RETPRECOTABELA_JGD',
                'TRG_UPD_FISCAL_TABNCM_JGD', 'TRG_UPD_FISCAL_TGFPRO_JGD'))
    LOOP
        TEXTO := 'ALTER  ' || I.OBJECT_TYPE ||' ' || I.OBJECT_NAME || ' COMPILE';
        COUNTER := COUNTER + 1;
        EXECUTE IMMEDIATE TEXTO; 
    END LOOP;

    P_MENSAGEM := COUNTER || ' objetos re-compilados!';
END;