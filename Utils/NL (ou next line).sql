CREATE OR REPLACE FUNCTION NL(P_TEXT VARCHAR2 DEFAULT NULL)
RETURN CHAR
AS
    RETORNO VARCHAR2(32767);
BEGIN
    IF P_TEXT = '}' THEN
        RETORNO := CHR(10) || P_TEXT;
    ELSE
        RETORNO := P_TEXT || CHR(10);
    END IF;
    
    RETURN RETORNO;
END;
/