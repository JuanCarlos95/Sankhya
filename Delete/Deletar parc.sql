/* DESATIVAR TRIGGERS */
DECLARE
    TEXTO VARCHAR2(999);
    J     NUMBER;
    ALTERA_PARCEIROS BOOLEAN := FALSE;
    DELETA_TOPS BOOLEAN := FALSE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('INICIANDO PROCESSO DE EXCLUS�O DE PARCEIROS...');
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESATIVANDO TRIGGERS...');
        FOR I IN 1..2
        LOOP
            CASE WHEN I = 1 THEN TEXTO := 'TRG_BLQ_UPD_ORDSERV_JGD';
                 WHEN I = 2 THEN TEXTO := 'TRG_BLQ_ORDSERV_JGD';
            END CASE;
            EXECUTE IMMEDIATE 'ALTER TRIGGER '||TEXTO||' DISABLE';
            DBMS_OUTPUT.PUT_LINE('Trigger   '||TEXTO||'   desativada com sucesso!');
            IF I = 2 THEN
                DBMS_OUTPUT.PUT_LINE('TODAS AS TRIGGERS FORAM DESATIVADAS COM SUCESSO!!');
            END IF;
        END LOOP;
    END;
/* FIM DO BLOCO */
/* CONSTRAINTS */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESABILITANDO CONSTRAINTS...');
        TEXTO := 'ALTER TABLE TGFEMP MODIFY CONSTRAINT FK_TGFEMP_CODPARCNFCE_TGFPAR DISABLE';
        EXECUTE IMMEDIATE TEXTO;
        DBMS_OUTPUT.PUT_LINE('Comando '||TEXTO||'executado com sucesso!');
        DBMS_OUTPUT.PUT_LINE('TODAS AS CONSTRAINTS FORAM DESABILITADAS COM SUCESSO!!');
    END;
/* FIM DO BLOCO */
/* DELETANDO PARCEIROS */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('INICIANDO EXCLUS�O...');
        DBMS_OUTPUT.PUT_LINE('AGUARDE... ');
        UPDATE TSIUSU SET CODPARC = 0;
        DELETE FROM TGFGIR;
        DELETE FROM TGFTEL;
        DELETE FROM AD_ORDSERV;
        DELETE FROM TGFLIS;
        DELETE FROM AD_PENDPARC;
        DELETE FROM AD_CONTATOLIBCOMP;
        DELETE FROM TGFORD;
        FOR I IN (SELECT CODPARC FROM TGFPAR WHERE CODPARC NOT IN (SELECT CODPARC FROM TSIEMP))
        LOOP
            IF I.CODPARC NOT IN (0, 18, 50, 53, 75, 96) THEN
                DELETE FROM TGFPAR WHERE CODPARC = I.CODPARC;
                J := J + 1;
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(J||' PARCEIROS EXCLUIDOS COM SUCESSO!!');
    END;
/* FIM DO BLOCO */
/* ATIVANDO TRIGGERS */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ATIVANDO TRIGGERS...');
        FOR I IN 1..2
        LOOP
            CASE WHEN I = 1 THEN TEXTO := 'TRG_BLQ_UPD_ORDSERV_JGD';
                 WHEN I = 2 THEN TEXTO := 'TRG_BLQ_ORDSERV_JGD';
            END CASE;
            DBMS_OUTPUT.PUT_LINE('Trigger   '||TEXTO||'   ativada com sucesso!');
            EXECUTE IMMEDIATE 'ALTER TRIGGER '||TEXTO||' ENABLE';
            IF I = 2 THEN
                DBMS_OUTPUT.PUT_LINE('TODAS AS TRIGGERS FORAM ATIVANDO COM SUCESSO!!');
            END IF;
        END LOOP;
    END;
/* FIM DO BLOCO */
/* ALTERAR PARCEIROS DA EMPRESA */
    IF ALTERA_PARCEIROS THEN
        BEGIN
            DBMS_OUTPUT.PUT_LINE('ALTERANDO PARCEIROS DA EMPRESA...');
            UPDATE TGFCAB SET CODPARC = 0 WHERE CODPARC != 0;
            UPDATE TGFPAR SET CODPARCMATRIZ = 0 WHERE CODPARC != 0;
            UPDATE TGFPAR SET CODPARC = 1 WHERE CODPARC = 9;
            UPDATE TSIEMP SET CODPARC = 0 WHERE CODPARC != 0;
            UPDATE TGFEMP SET CODPARCNFCE = 0 WHERE CODPARCNFCE != 0;
            UPDATE TGFPAR SET CODPARC = 109 WHERE CODPARC = 2;
            UPDATE TGFPAR SET CODPARC = CODPARC - 8 WHERE CODPARC IN (10, 11);
            UPDATE TGFCAB SET CODPARC = 1 WHERE NUNOTA = 6774;
            UPDATE TGFPAR SET CODPARCMATRIZ = CODPARC WHERE CODPARC IN (1, 2, 3);
            UPDATE TSIEMP SET CODPARC = CODEMP;
            UPDATE TGFPAR SET CODPARC = 9 WHERE CODPARC = 109;
            UPDATE TGFPAR SET CODPARC = 10 WHERE CODPARC = 96;
            UPDATE TGFEMP SET CODPARCNFCE = 9;
            DBMS_OUTPUT.PUT_LINE('PARCEIROS ALTERADOS COM SUCESSO!!');
        END;
    END IF;
/* FIM DO BLOCO */
/* TOPPERSON'S DELETEIDES */
    IF DELETA_TOPS THEN
        DBMS_OUTPUT.PUT_LINE('DELETANDO TOPS...');
        DBMS_OUTPUT.PUT_LINE('DESATIVANDO TRIGGER...');
        EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_DLT_TGFTOP DISABLE';
        DBMS_OUTPUT.PUT_LINE('DELETANDO...');
            DELETE FROM TGFTOP_DLT WHERE CODTIPOPER = 9994;
            DELETE FROM TGFTOP WHERE CODTIPOPER = 9994;
        DBMS_OUTPUT.PUT_LINE('ATIVANDO TRIGGER...');    
        EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_DLT_TGFTOP ENABLE';
        DBMS_OUTPUT.PUT_LINE('TOPS DELETADAS COM SUCESSO!!');
    END IF;
    DBMS_OUTPUT.PUT_LINE('PARCEIROS EXCLUIDOS COM SUCESSO!!');
END;
/* FIM DO BLOCO */
