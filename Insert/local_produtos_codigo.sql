--CRIA TABELA TEMPOR�RIA
CREATE TABLE IMPORT_LOCAL(
    CODPROD INT,
    CODEMP  INT,
    DETALHE VARCHAR2(4000)
);
CREATE TABLE LOCAL_TRATADO(
    CODPROD            INT,
    CODEMP             INT,
    CODLOC             INT
);
--INSERIR REGISTROS NA TABLEA IMPORT_LOCAL;
    /* *** */
 SELECT COUNT(*) FROM IMPORT_LOCAL;
--RODAR SCRIPT ABAIXO;
DECLARE
    RESULTI NUMBER := 0;
    RESULTJ NUMBER := 0;
BEGIN
    FOR I IN (SELECT * FROM IMPORT_LOCAL)
    LOOP
        FOR J IN (SELECT COLUMN_VALUE AS COL FROM TABLE(SPLIT(I.DETALHE, ';')))
        LOOP
            INSERT INTO LOCAL_TRATADO(CODPROD, CODEMP, CODLOC)
                VALUES(I.CODPROD, I.CODEMP, CAST(J.COL AS INT));
            RESULTJ := RESULTJ + 1;
        END LOOP;
        RESULTI := RESULTI + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('TOTAL DE LOCAL(IS): '|| RESULTI);
    DBMS_OUTPUT.PUT_LINE('TOTAL DE LOCAL(IS) TRATADO(S): '||RESULTJ);
END;
/
--LIMPA TABELA IMPORT_TABLE PARA PREVENIR ERROS 
SELECT COUNT(*) FROM LOCAL_TRATADO;
--ANALISA PRODUTOS E LOCAIS QUE EXISTAM E INSERE NA TABELA OFICIAL DE LOCAIS
DECLARE
    RESULTI NUMBER := 0;
    RESULTJ NUMBER := 0;
    RESULTERROR NUMBER := 0;
    CODIPROD NUMBER;
    CONTREG NUMBER;
BEGIN
    FOR I IN (SELECT * FROM LOCAL_TRATADO WHERE CODLOC IS NOT NULL)
    LOOP
        BEGIN
        SELECT COUNT(CODPROD)
          INTO CODIPROD
          FROM TGFPRO
         WHERE CODPROD = I.CODPROD;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            CODIPROD := 0;
        END;
        
        IF CODIPROD = 0 THEN
           RESULTJ := RESULTJ;
        ELSE
            BEGIN
                SELECT COUNT(*)
                  INTO CONTREG
                  FROM AD_PRODCODNVL
                 WHERE CODPROD = I.CODPROD
                   AND LOCALPROD = I.CODLOC;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                CONTREG := 0;
            END;
            
            IF CONTREG = 0 THEN
                INSERT INTO AD_PRODCODNVL (CODPROD, LOCALPROD)
                    VALUES(I.CODPROD, I.CODLOC);
                RESULTJ := RESULTJ + 1;
            ELSE
                RESULTERROR := RESULTERROR + 1;
                DBMS_OUTPUT.PUT_LINE('C�DIGO: '||I.CODPROD||'    LOCAL: '||I.CODLOC);
            END IF;
        END IF;
        RESULTI := RESULTI + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('TOTAL DE LINHAS: '|| RESULTI);
    DBMS_OUTPUT.PUT_LINE('TOTAL DE LOCAL(IS) INSERIDO(S): '||RESULTJ);
    DBMS_OUTPUT.PUT_LINE('TOTAL DE ERROS CORRIGIDOS: '||RESULTERROR);

    EXECUTE IMMEDIATE 'DELETE FROM IMPORT_LOCAL'; 
    EXECUTE IMMEDIATE 'DROP TABLE IMPORT_LOCAL';
    EXECUTE IMMEDIATE 'DELETE FROM LOCAL_TRATADO';
    EXECUTE IMMEDIATE 'DROP TABLE LOCAL_TRATADO';
END;
/
--FIM