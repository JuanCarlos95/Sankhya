CREATE TABLE IMPORT_ESTOQUE(
    CODPROD NUMBER,
    ESTOQUE NUMBER,
    INSERIDO VARCHAR2(10) DEFAULT 'N'
);

CREATE TABLE NOTAS_GERADAS(
    NUNOTA NUMBER,
    HORA   TIMESTAMP
);  
/
DECLARE
    REGCAB TGFCAB%ROWTYPE;
    REGITE TGFITE%ROWTYPE;
    P_DHALTER TGFTOP.DHALTER%TYPE;
    PARAMETRO NUMBER := 1;
    SAIDA NUMBER;
    CONTADOR NUMBER;
    ACESSO NUMBER;
    V_NUNOTA NUMBER;
    P_RETORNO VARCHAR2(4000);
    P_CODVOL VARCHAR2(10);
    V_XML VARCHAR2(4000);
    P_SEQUENCIA NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO CONTADOR
      FROM IMPORT_ESTOQUE;
    
    SELECT *
      INTO REGCAB
      FROM TGFCAB
     WHERE NUNOTA = 2;
        
    SELECT MAX(DHALTER) 
      INTO P_DHALTER
      FROM TGFTOP
     WHERE CODTIPOPER = REGCAB.CODTIPOPER;
                
    REGCAB.DHTIPOPER := P_DHALTER;

    FOR I IN 1..CONTADOR 
    LOOP
        IF (I/(100 * PARAMETRO)) - 1 = 0 THEN
            ACESSO := 1;
            PARAMETRO := PARAMETRO + 1;
        ELSE
            ACESSO := 0;
        END IF;
        
        
        IF I = 1 OR ACESSO = 1 THEN
            SELECT MAX(NUNOTA) + 1
              INTO V_NUNOTA
              FROM TGFCAB;
          
            REGCAB.NUNOTA := V_NUNOTA;
            
            INSERT INTO TGFCAB
                VALUES REGCAB;
                
            INSERT INTO NOTAS_GERADAS
                VALUES (V_NUNOTA, SYSDATE);
        END IF;
        
        REGCAB.NUNOTA := V_NUNOTA;
        
        FOR J IN (SELECT * FROM IMPORT_ESTOQUE WHERE INSERIDO = 'N') 
        LOOP
            SELECT COUNT(CODPROD)
              INTO SAIDA
              FROM TGFITE
             WHERE NUNOTA = V_NUNOTA;
             
            IF SAIDA = 100 THEN
                EXIT;
            END IF;
            
            SELECT *
              INTO REGITE
              FROM TGFITE
             WHERE CODPROD = 2792
               AND NUNOTA = 2;
                
            SELECT CODVOL
              INTO P_CODVOL
              FROM TGFPRO
             WHERE CODPROD = J.CODPROD;
             
            REGITE.NUNOTA       := V_NUNOTA;
            REGITE.CODPROD      := J.CODPROD;
            REGITE.QTDNEG       := J.ESTOQUE;
            REGITE.PERCDESC     := 0;
            REGITE.VLRDESC      := 0;
            REGITE.CODLOCALORIG := 10;
            REGITE.VLRTOT       := 0;
            REGITE.CONTROLE     := ' ';
            REGITE.SEQUENCIA    := NULL;
            REGITE.CODVOL       := P_CODVOL;
             
            BEGIN       
                SELECT COUNT(CODPROD) + 1
                  INTO P_SEQUENCIA
                  FROM TGFITE
                 WHERE NUNOTA = REGITE.NUNOTA;
            EXCEPTION WHEN NO_DATA_FOUND THEN 
                P_SEQUENCIA := 1;
            END;
            
            REGITE.SEQUENCIA := P_SEQUENCIA;
            
            INSERT INTO TGFITE
                VALUES REGITE;
                
            UPDATE IMPORT_ESTOQUE SET INSERIDO = 'S'
             WHERE CODPROD = J.CODPROD;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(CONTADOR - I);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('CHUPA SANKHYA, SOU MELHOR QUE VCS!');
END;
/