CREATE GLOBAL TEMPORARY TABLE IMPORTACODBARRAS(
            CODPROD NUMBER,
            CODBARRAS VARCHAR2(100)
        )
        ON COMMIT DELETE ROWS;
/* *** */
select * from IMPORTACODBARRAS;
/* *** */
DECLARE
    CONTACODIGO NUMBER;
    PARAMETRO NUMBER;
    RESULTB NUMBER := 0;
    RESULTI NUMBER := 0;
    RESULTJ NUMBER := 0;
    RESULTK NUMBER := 0;
    RESULTU NUMBER := 0;
BEGIN

    FOR I IN (SELECT * FROM TGFPRO)
    LOOP
        BEGIN
            SELECT COUNT(*)
              INTO CONTACODIGO
              FROM IMPORTACODBARRAS
             WHERE CODPROD = I.CODPROD;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            CONTACODIGO := 0;
        END;
        
        IF CONTACODIGO = 0 THEN
            UPDATE TGFPRO SET REFERENCIA = I.CODPROD
             WHERE CODPROD = I.CODPROD;
            RESULTB := RESULTB + 1;
        END IF;
        
        FOR J IN (SELECT * FROM IMPORTACODBARRAS WHERE CODPROD = I.CODPROD)
        LOOP
            FOR K IN 1..CONTACODIGO
            LOOP
                IF K = 1 THEN
                    UPDATE TGFPRO SET REFERENCIA = J.CODBARRAS
                     WHERE CODPROD = I.CODPROD;
                    RESULTU := RESULTU + 1; 
                ELSIF K >= 2 THEN
                    BEGIN
                        SELECT COUNT(CODBARRA)
                          INTO PARAMETRO
                          FROM TGFBAR
                         WHERE CODPROD = I.CODPROD
                           AND CODBARRA = J.CODBARRAS;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        PARAMETRO := 0; 
                    END;
                      
                    IF PARAMETRO = 0 THEN
                        INSERT INTO TGFBAR (CODBARRA, CODPROD, DHALTER, CODUSU, CODVOL)
                            VALUES(J.CODBARRAS, I.CODPROD, SYSDATE, 15, I.CODVOL);
                        RESULTK := RESULTK + 1;
                    END IF;
                END IF;
            END LOOP;  
            RESULTJ := RESULTJ + 1;  
        END LOOP;
        RESULTI := RESULTI + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('TOTAL DE PRODUTOS: '||RESULTI);
    DBMS_OUTPUT.PUT_LINE('TOTAL DE CODBARRAS: '||RESULTJ);
    DBMS_OUTPUT.PUT_LINE('TOTAL DE INSERÇÕES: '||RESULTK);
    DBMS_OUTPUT.PUT_LINE('TOTAL DE UPDATES: '||RESULTU);
    DBMS_OUTPUT.PUT_LINE('TOTAL S/ CÓDIGO: '||RESULTB);
    FOR I IN (SELECT * FROM TGFPRO WHERE REFERENCIA IS NOT NULL)
    LOOP
        FOR J IN (SELECT * FROM TGFBAR WHERE CODPROD = I.CODPROD)
        LOOP
            IF J.CODBARRA = I.REFERENCIA THEN
                DELETE FROM TGFBAR WHERE CODPROD = I.CODPROD AND CODBARRA = I.REFERENCIA;
            END IF;
        END LOOP;
    END LOOP;
END;
/
/* *** */
DELETE FROM IMPORTACODBARRAS;
DROP TABLE IMPORTACODBARRAS;
SELECT * FROM IMPORTACODBARRAS;
/* *** */
