CREATE TABLE IMPORT_ESTOQUE(
    CODPROD  NUMBER,
    ESTOQUE  NUMBER,
    CODEMP   NUMBER,
    INSERIDO VARCHAR2(10) DEFAULT 'N'
);
CREATE TABLE NOTAS_GERADAS(
    NUNOTA NUMBER,
    HORA TIMESTAMP
);
DECLARE
    APAGAR NUMBER;
    DELETADOS NUMBER := 0;
BEGIN
    FOR I IN (SELECT * FROM IMPORT_ESTOQUE)
    LOOP
        BEGIN
            SELECT COUNT(*)
              INTO APAGAR
              FROM TGFPRO
             WHERE CODPROD = I.CODPROD;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            APAGAR := 0;
        END;

        IF APAGAR = 0 THEN
            DELETE FROM IMPORT_ESTOQUE
             WHERE CODPROD = I.CODPROD;
            COMMIT;
            DELETADOS := DELETADOS + 1;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('DELETADOS: '|| DELETADOS);
END;
DECLARE
    P_DHALTER   TGFTOP.DHALTER%TYPE;
    REGCAB      TGFCAB%ROWTYPE;
    REGITE      TGFITE%ROWTYPE;
    P_CODVOL    VARCHAR2(10);
    P_SEQUENCIA NUMBER;
    MODELONOTA  NUMBER;
    CONTADOR    NUMBER;
    V_NUNOTA    NUMBER;
    EMPRESAS    NUMBER;
    CENCUSTO    NUMBER;
    CODLOCAL    NUMBER;
    FORMULA     NUMBER;
    SAIDA       NUMBER;
    X           NUMBER; 
BEGIN
    MODELONOTA := :MODELO;
    
    SELECT COUNT(CODEMP) 
      INTO EMPRESAS 
      FROM TSIEMP;
    
    SELECT   *
      INTO REGITE
      FROM TGFITE
     WHERE CODPROD = 2792
       AND NUNOTA = MODELONOTA;
    
    SELECT * 
      INTO REGCAB 
      FROM TGFCAB 
     WHERE NUNOTA = MODELONOTA;
    
      
    FOR X IN 1..EMPRESAS
    LOOP
        CENCUSTO := X * 10000;
        
        SELECT MAX(DHALTER) 
          INTO P_DHALTER 
          FROM TGFTOP 
         WHERE CODTIPOPER = REGCAB.CODTIPOPER;   

        REGCAB.DHTIPOPER := P_DHALTER;
        REGCAB.CODEMP    := X;
        REGCAB.CODPARC   := X;
        REGCAB.CODCENCUS := CENCUSTO;
        REGCAB.DTNEG     := SYSDATE;
        
        SELECT COUNT(*) 
          INTO CONTADOR 
          FROM IMPORT_ESTOQUE 
         WHERE CODEMP = X;
          
        FORMULA := CEIL(CONTADOR / 100);
        
        IF X = 1 THEN
            CODLOCAL := 10;
        ELSE
            CODLOCAL := 20;
        END IF;
         
        
        FOR I IN 1..FORMULA
        LOOP
            SELECT MAX(NUNOTA) + 1
              INTO V_NUNOTA
              FROM TGFCAB;

            REGCAB.NUNOTA := V_NUNOTA;

            INSERT INTO TGFCAB
                VALUES REGCAB;

            INSERT INTO NOTAS_GERADAS
                VALUES (V_NUNOTA, SYSDATE);
                
            FOR J IN (SELECT * FROM IMPORT_ESTOQUE WHERE INSERIDO = 'N' AND CODEMP = X)
            LOOP
                SELECT COUNT(CODPROD)
                  INTO SAIDA
                  FROM TGFITE
                 WHERE NUNOTA = V_NUNOTA;

                IF SAIDA = 100 THEN
                    EXIT;
                END IF;

                SELECT CODVOL
                  INTO P_CODVOL
                  FROM TGFPRO
                 WHERE CODPROD = J.CODPROD;

                REGITE.NUNOTA       := V_NUNOTA;
                REGITE.CODPROD      := J.CODPROD;
                REGITE.QTDNEG       := J.ESTOQUE;
                REGITE.CODEMP       := X;
                REGITE.PERCDESC     := 0;
                REGITE.VLRDESC      := 0;
                REGITE.CODLOCALORIG := CODLOCAL;
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
                 WHERE CODPROD = J.CODPROD
                   AND CODEMP = X;
            END LOOP;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('IMPORTAÇÃO CONCLUIDA');
        EXECUTE IMMEDIATE 'DELETE FROM IMPORT_ESTOQUE';
        EXECUTE IMMEDIATE 'DROP TABLE IMPORT_ESTOQUE';
    END LOOP;
END;
/

select ceil(count(codprod)/100), count(codprod) from import_estoque where inserido = 'S' and codemp is not null;

select count(codprod) from tgfite where nunota in (select nunota from notas_Geradas);

select count(nunota) from tgfcab where nunota in (Select nunota from notas_geradas) or (trunc(dtneg) = trunc(sysdate) and nunota > 10); 

select count(distinct(codprod)) from import_estoque;

