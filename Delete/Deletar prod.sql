/****************************************** DELETANDO PRODUTOS ******************************************/
/* DESATIVANDO TRIGGER */
DECLARE
    TEXTO  VARCHAR2(999);
BEGIN
    DBMS_OUTPUT.PUT_LINE('INICIANDO PROCESSO DE EXCLUS�O DE PRODUTOS...');
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESATIVANDO TRIGGERS...');
                FOR I IN 1..17 
        LOOP
            CASE WHEN I = 1 THEN TEXTO  := 'TRG_BLQALTERITC_COT_JGD';
                 WHEN I = 2 THEN TEXTO  := 'TRG_BLQ_INS_PRODOS_JGD';
                 WHEN I = 3 THEN TEXTO  := 'TRG_BLQ_INS_SERVOS_JGD';
                 WHEN I = 4 THEN TEXTO  := 'TRG_BLQ_UPD_PRODOS_JGD';
                 WHEN I = 5 THEN TEXTO  := 'TRG_BLQ_UPD_SERVOS_JGD';
                 WHEN I = 6 THEN TEXTO  := 'TRG_BLQ_PRODOS_JGD';
                 WHEN I = 7 THEN TEXTO  := 'TRG_BLQ_SERVOS_JGD';
                 WHEN I = 8 THEN TEXTO  := 'TRG_DLT_TCIBEM';
                 WHEN I = 9 THEN TEXTO  := 'TRG_DLT_AD_IMPTABITE_JGD';
                 WHEN I = 10 THEN TEXTO := 'TRG_DLT_UPD_TGFCUS';
                 WHEN I = 11 THEN TEXTO := 'TRG_DLT_TGFITE';
                 WHEN I = 12 THEN TEXTO := 'TRG_DLT_TGFITS';
                 WHEN I = 13 THEN TEXTO := 'TRG_INC_UPD_DLT_TGFITE_RASTEST';
                 WHEN I = 14 THEN TEXTO := 'TRG_INC_UPD_DLT_TGFITE_ESTTERC';
                 WHEN I = 15 THEN TEXTO := 'TRG_DLT_TCIMOV';
                 WHEN I = 16 THEN TEXTO := 'TRG_DLT_TCIBEM';
                 WHEN I = 17 THEN TEXTO := 'TRG_DLT_TCISAL';
            END CASE;
            EXECUTE IMMEDIATE 'ALTER TRIGGER '||TEXTO||' DISABLE';
            DBMS_OUTPUT.PUT_LINE('Trigger   '||TEXTO||'   desativada com sucesso!!');
            IF I = 17 THEN
                DBMS_OUTPUT.PUT_LINE('Todas as triggers foram desativadas com sucesso!!');
            END IF;
        END LOOP;
    END;
/* FIM DE BLOCO */
/* DESABILITAR CONSTRAINT'S */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESATIVANDO CONSTRAINTS...');
    /*  FOR I IN 1..1 
        LOOP */
            TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCIMOV_CODBEM_TCIBEM DISABLE';
    /*       --    WHEN I = 2 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCISAL_CODBEM_TCIBEM DISABLE';
             --    WHEN I = 3 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCICTA_CODPROD_TCIBEM DISABLE';
             --    WHEN I = 4 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCICTA_CODPROD_TGFPRO DISABLE';
             --    WHEN I = 5 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCITAX_CODBEM_TCIBEM DISABLE';
             --    WHEN I = 6 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCITAX_CODPROD_TGFPRO DISABLE';
             --    WHEN I = 7 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCIEST_CODPROD_TGFPRO DISABLE';
             --    WHEN I = 8 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCIDIBI_CODPROD_TGFPRO DISABLE';
             --    WHEN I = 9 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCIDIBI_CODBEM_TCIBEM DISABLE';
    */        
            EXECUTE IMMEDIATE TEXTO;
            DBMS_OUTPUT.PUT_LINE('Comando   '||TEXTO||'   executado com sucesso!!');
    /*      IF I = 9 THEN*/
                DBMS_OUTPUT.PUT_LINE('TODAS AS CONSTRAINTS FORAM DESATIVADAS COM SUCESSO!!');
    /*      END IF; */
    /*  END LOOP;  */
    END;
/* FIM DO BLOCO */
/* DELETAR PRODUTOS */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('...INICIANDO EXCLUS�O...');
        DBMS_OUTPUT.PUT_LINE('AGUARDE...');
        FOR I IN (SELECT CODPROD FROM TGFPRO)
        LOOP
            DELETE FROM TGFIMAL         WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFFAM          WHERE CODPRODPAI = I.CODPROD OR CODPRODFILHO = I.CODPROD;
            DELETE FROM TGFVCS          WHERE CODPRODSUG = I.CODPROD;
            DELETE FROM TCIBEM          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFPAP          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFEXC          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFITC          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFBAR          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFEST          WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_CONTGARITE   WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_AVISARECEB   WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_CENTPARAMPRO WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_DESCQTD      WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_GONDOLETIQ   WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_IMPTABITE    WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_IMPTABRES    WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_PRODCODNVL   WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_PRODOS       WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_PROITE       WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_RECEBETIQ    WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_SERVOS       WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_TABENC       WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFITS          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFCUS          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFITC_COT      WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFITC          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFITE          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFCOI2         WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFGIR1         WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFVOA          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFIRCST        WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFIVC          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFCTE          WHERE CODPROD    = I.CODPROD;        
            DELETE FROM TGFAID          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TCIDIBI         WHERE CODPROD    = I.CODPROD;
            DELETE FROM TCILOC          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TCIEST          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TCICTA          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TCIBEM          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TCISAL          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TCIMOV          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TCITAX          WHERE CODPROD    = I.CODPROD;
            DELETE FROM TGFPRO          WHERE CODPROD    = I.CODPROD;
            DELETE FROM AD_FABRICANTES  WHERE CODFAB NOT IN (SELECT AD_CODFAB FROM TGFPRO);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('EXCLUS�O REALIZADA COM SUCESSO!!');
    END;
/* FIM DO BLOCO */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ATIVANDO CONSTRAINTS...');
    /*  FOR I IN 1..9 
        LOOP*/
            TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCIMOV_CODBEM_TCIBEM ENABLE';
        --       WHEN I = 2 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCISAL_CODBEM_TCIBEM ENABLE';
        --       WHEN I = 3 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCICTA_CODPROD_TCIBEM ENABLE';
        --       WHEN I = 4 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCICTA_CODPROD_TGFPRO ENABLE';
        --       WHEN I = 5 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCITAX_CODBEM_TCIBEM ENABLE';
        --       WHEN I = 6 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCITAX_CODPROD_TGFPRO ENABLE';
        --       WHEN I = 7 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCIEST_CODPROD_TGFPRO ENABLE';
        --       WHEN I = 8 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCIDIBI_CODPROD_TGFPRO ENABLE';
        --       WHEN I = 9 THEN TEXTO  := 'ALTER TABLE TCIMOV MODIFY CONSTRAINT FK_TCIDIBI_CODBEM_TCIBEM ENABLE';
        --    END CASE;
            EXECUTE IMMEDIATE TEXTO;
            DBMS_OUTPUT.PUT_LINE('Comando   '||TEXTO||'   executado com sucesso!!');
        --  IF I = 9 THEN
                DBMS_OUTPUT.PUT_LINE('TODAS AS CONSTRAINTS FORAM ATIVADAS COM SUCESSO!!');
        --  END IF;
    --  END LOOP;
    END;
/* FIM DO BLOCO */
/* REATIVANDO TRIGGERS */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ATIVANDO TRIGGERS...');
        FOR I IN 1..17 
        LOOP
            CASE WHEN I = 1 THEN TEXTO  := 'TRG_BLQALTERITC_COT_JGD';
                 WHEN I = 2 THEN TEXTO  := 'TRG_BLQ_INS_PRODOS_JGD';
                 WHEN I = 3 THEN TEXTO  := 'TRG_BLQ_INS_SERVOS_JGD';
                 WHEN I = 4 THEN TEXTO  := 'TRG_BLQ_UPD_PRODOS_JGD';
                 WHEN I = 5 THEN TEXTO  := 'TRG_BLQ_UPD_SERVOS_JGD';
                 WHEN I = 6 THEN TEXTO  := 'TRG_BLQ_PRODOS_JGD';
                 WHEN I = 7 THEN TEXTO  := 'TRG_BLQ_SERVOS_JGD';
                 WHEN I = 8 THEN TEXTO  := 'TRG_DLT_TCIBEM';
                 WHEN I = 9 THEN TEXTO  := 'TRG_DLT_AD_IMPTABITE_JGD';
                 WHEN I = 10 THEN TEXTO := 'TRG_DLT_UPD_TGFCUS';
                 WHEN I = 11 THEN TEXTO := 'TRG_DLT_TGFITE';
                 WHEN I = 12 THEN TEXTO := 'TRG_DLT_TGFITS';
                 WHEN I = 13 THEN TEXTO := 'TRG_INC_UPD_DLT_TGFITE_RASTEST';
                 WHEN I = 14 THEN TEXTO := 'TRG_INC_UPD_DLT_TGFITE_ESTTERC';
                 WHEN I = 15 THEN TEXTO := 'TRG_DLT_TCIMOV';
                 WHEN I = 16 THEN TEXTO := 'TRG_DLT_TCIBEM';
                 WHEN I = 17 THEN TEXTO := 'TRG_DLT_TCISAL';
            END CASE;
            EXECUTE IMMEDIATE 'ALTER TRIGGER '||TEXTO||' ENABLE';
            DBMS_OUTPUT.PUT_LINE('Trigger   '||TEXTO||'   ativada com sucesso!!');
            IF I = 17 THEN
                DBMS_OUTPUT.PUT_LINE('Todas as triggers foram ativadas com sucesso!!');
            END IF;
        END LOOP;
    END;
    DBMS_OUTPUT.PUT_LINE('PROCESSO DE EXCLUS�O DE PRODUTOS FINALIZADO COM SUCESSO!!');
END;    
/* FIM DO BLOCO */
/**************************************************FIM!**************************************************/
