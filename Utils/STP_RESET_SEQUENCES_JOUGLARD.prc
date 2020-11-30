CREATE OR REPLACE PROCEDURE STP_RESET_SEQUENCES_JOUGLARD(
    P_SEQUENCIA VARCHAR2
) AS
    RESETAR           NUMBER;
    SEQUENCIA VARCHAR2(4000);
    EXECUTAR  VARCHAR2(4000);
BEGIN
    SEQUENCIA := P_SEQUENCIA;
    EXECUTAR  := 'ALTER SEQUENCE '||SEQUENCIA||' MINVALUE 0';
    EXECUTE IMMEDIATE EXECUTAR;
    EXECUTAR  := 'SELECT '||SEQUENCIA||'.NEXTVAL FROM DUAL';
    EXECUTE IMMEDIATE EXECUTAR INTO RESETAR;
    RESETAR := (RESETAR * -1);
    EXECUTAR  := 'ALTER SEQUENCE '||SEQUENCIA||' INCREMENT BY '||RESETAR;
    EXECUTE IMMEDIATE EXECUTAR;
    EXECUTAR  := 'SELECT '||SEQUENCIA||'.NEXTVAL FROM DUAL';
    EXECUTE IMMEDIATE EXECUTAR INTO RESETAR;
    EXECUTAR  := 'ALTER SEQUENCE '||SEQUENCIA||' INCREMENT BY 1';
    EXECUTE IMMEDIATE EXECUTAR;
END;
/