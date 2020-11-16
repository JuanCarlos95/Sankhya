DECLARE
    TEXTO VARCHAR2(4000);
    SAIDA VARCHAR2(4000);   
    TYPE DINCURSOR IS REF CURSOR;
    ORIGEM DINCURSOR;
BEGIN
    FOR I IN (SELECT OWNER, OBJECT_NAME, OBJECT_TYPE, STATUS 
                FROM DBA_OBJECTS
               WHERE OWNER = 'SANKHYA'
                 AND STATUS != 'VALID'
                 AND OBJECT_NAME NOT IN ('FNC_RETPRECOTABELA_JGD',
                    'TRG_UPD_FISCAL_TABNCM_JGD', 'TRG_UPD_FISCAL_TGFPRO_JGD'))
    LOOP
        DBMS_OUTPUT.PUT_LINE(I.OBJECT_TYPE|| ' ' || I.OBJECT_NAME);
        TEXTO := 'ALTER '||I.OBJECT_TYPE||' '||I.OBJECT_NAME|| ' COMPILE';   
        EXECUTE IMMEDIATE TEXTO;
    END LOOP;
END;
/