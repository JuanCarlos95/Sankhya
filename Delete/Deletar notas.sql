/* AREA PARA DESATIVAR TRIGGERS */
DECLARE
    TEXTO VARCHAR2(999);
    J     NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('INICIANDO PROCESSO DE EXCLUS�O DE NOTAS...');
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESATIVANDO TRIGGERS...');
        FOR I IN 1..12 
        LOOP
            CASE WHEN I = 1 THEN TEXTO := 'TRG_DLT_TGFMBC';
                 WHEN I = 2 THEN TEXTO := 'TRG_DLT_TGFFIN';
                 WHEN I = 3 THEN TEXTO := 'TRG_DLT_TGFFRE';
                 WHEN I = 4 THEN TEXTO := 'TRG_DLT_TGFRAT';
                 WHEN I = 5 THEN TEXTO := 'TRG_BLQ_INS_PRODOS_JGD';
                 WHEN I = 6 THEN TEXTO := 'TRG_BLQ_INS_SERVOS_JGD';
                 WHEN I = 7 THEN TEXTO := 'TRG_BLQ_UPD_PRODOS_JGD';
                 WHEN I = 8 THEN TEXTO := 'TRG_BLQ_UPD_SERVOS_JGD';
                 WHEN I = 9 THEN TEXTO := 'TRG_BLQ_UPD_ORDSERV_JGD';
                 WHEN I = 10 THEN TEXTO := 'TRG_BLQ_PRODOS_JGD';
                 WHEN I = 11 THEN TEXTO := 'TRG_BLQ_SERVOS_JGD';
                 WHEN I = 12 THEN TEXTO := 'TRG_BLQ_ORDSERV_JGD';
            END CASE;
            DBMS_OUTPUT.PUT_LINE('Trigger   '||TEXTO||'   desativada com sucesso!!');
            EXECUTE IMMEDIATE 'ALTER TRIGGER '||TEXTO||' DISABLE';
            IF I = 12 THEN
                DBMS_OUTPUT.PUT_LINE('TODAS AS TRIGGERS FORAM DESATIVADAS COM SUCESSO!!');
            END IF;    
        END LOOP;
    END;
/* FIM DO BLOCO*/
/* Constraints */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DESATIVANDO CONSTRAINTS...');
        FOR I IN 1..4
        LOOP
            CASE WHEN I = 1 THEN TEXTO := 'ALTER TABLE TGFFIN MODIFY CONSTRAINT FK_TGFFIN_TGFMBC DISABLE';
                 WHEN I = 2 THEN TEXTO := 'ALTER TABLE TGFCAB MODIFY CONSTRAINT FK_TGFCAB_NUREM_TGFCAB DISABLE';
                 WHEN I = 3 THEN TEXTO := 'ALTER TABLE TGFCAB_EXC MODIFY CONSTRAINT CKC_TGFCAB_EXC_TGFCAB DISABLE';
                 WHEN I = 4 THEN TEXTO := 'ALTER TABLE TGFCAB MODIFY CONSTRAINT FK_TGFCAB_TGFCON2 DISABLE';
            END CASE;
            DBMS_OUTPUT.PUT_LINE('Comando '||TEXTO||' executado com sucesso!!');
            EXECUTE IMMEDIATE TEXTO;
            IF I = 4 THEN
                DBMS_OUTPUT.PUT_LINE('TODAS AS CONSTRAINTS FORAM DESATIVADAS COM SUCESSO!!');
            END IF;
        END LOOP;
    END;
/* FIM DO BLOCO */
/* DELETAR NOTAS/PARCEIROS */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('EXCLUINDO NOTAS...');
        DELETE FROM TGFMBC;
        DELETE FROM TGFREN;
        DELETE FROM TGFFRE;
        DELETE FROM AD_INTDDA;
        DELETE FROM AD_INTCARTAO;
        DELETE FROM AD_IMPTABITE;
        DELETE FROM AD_IMPTAB;
        DELETE FROM AD_IMPTABRES;
        DELETE FROM TCBINT;
        DELETE FROM TCIDIB;
        DELETE FROM TGFACF;
        DELETE FROM TGFFNF;
        DELETE FROM AD_COTFRETEVOL;
        DELETE FROM TGFRAT;
        DELETE FROM TGFCON2;
        DELETE FROM TGFFIN;
        DELETE FROM TGFITE_EXC;
        DELETE FROM TGFCAB_EXC;
        FOR I IN (SELECT NUNOTA FROM TGFCAB WHERE TIPMOV != 'Z' OR NUNOTA NOT IN (1,4,6,62,64,65,75,79,99,208,243,295,439,1023,4025,4388,4409,4410,6774))
        LOOP 
            DELETE FROM TCBINT WHERE NUNICO = I.NUNOTA;
            DELETE FROM AD_VOLS WHERE NUNOTA = I.NUNOTA;
            DELETE FROM AD_CONTGARCAB WHERE NUNOTA = I.NUNOTA;
            DELETE FROM AD_AVISARECEB WHERE NUNOTA = I.NUNOTA;
            DELETE FROM AD_TABENC WHERE NUNOTA = I.NUNOTA;
            DELETE FROM AD_SERVOS WHERE NOTAGERADA = I.NUNOTA;
            DELETE FROM AD_PRODOS WHERE NOTAGERADA = I.NUNOTA;
            DELETE FROM AD_ORDSERV WHERE NOTGERNF = I.NUNOTA OR NOTGERNFS = I.NUNOTA;
            DELETE FROM AD_VOLUMENTREG WHERE NUNOTA = I.NUNOTA;
            DELETE FROM AD_PENDPARC WHERE NUNOTA = I.NUNOTA;
            DELETE FROM AD_COTFRETECAB WHERE NUNOTA = I.NUNOTA;
            DELETE FROM TGFVAR WHERE NUNOTA = I.NUNOTA OR NUNOTAORIG = I.NUNOTA;
            DELETE FROM TGFFIN WHERE NUNOTA = I.NUNOTA;    
            DELETE FROM TGFLIV WHERE NUNOTA = I.NUNOTA;
            DELETE FROM TGFCAB WHERE NUNOTA = I.NUNOTA;
            J := J + 1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(J ||' NOTAS EXCLUIDAS COM SUCESSO!!');
    END;
/* FIM DO BLOCO */
/* Constraints */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ATIVANDO CONSTRAINTS...');
        FOR I IN 1..4
        LOOP
            CASE WHEN I = 1 THEN TEXTO := 'ALTER TABLE TGFFIN MODIFY CONSTRAINT FK_TGFFIN_TGFMBC ENABLE';
                 WHEN I = 2 THEN TEXTO := 'ALTER TABLE TGFCAB MODIFY CONSTRAINT FK_TGFCAB_NUREM_TGFCAB ENABLE';
                 WHEN I = 3 THEN TEXTO := 'ALTER TABLE TGFCAB_EXC MODIFY CONSTRAINT CKC_TGFCAB_EXC_TGFCAB ENABLE';
                 WHEN I = 4 THEN TEXTO := 'ALTER TABLE TGFCAB MODIFY CONSTRAINT FK_TGFCAB_TGFCON2 ENABLE';
            END CASE;
            DBMS_OUTPUT.PUT_LINE('Comando '||TEXTO||' executado com sucesso!!');
            EXECUTE IMMEDIATE TEXTO;
            IF I = 4 THEN
                DBMS_OUTPUT.PUT_LINE('TODAS AS CONSTRAINTS FORAM ATIVADAS COM SUCESSO!!');
            END IF;
        END LOOP;
    END;
/* FIM DO BLOCO */
/* AREA PARA ATIVAR TRIGGERS */
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ATIVANDO TRIGGERS...');
        FOR I IN 1..12 
        LOOP
            CASE WHEN I = 1 THEN TEXTO := 'TRG_DLT_TGFMBC';
                 WHEN I = 2 THEN TEXTO := 'TRG_DLT_TGFFIN';
                 WHEN I = 3 THEN TEXTO := 'TRG_DLT_TGFFRE';
                 WHEN I = 4 THEN TEXTO := 'TRG_DLT_TGFRAT';
                 WHEN I = 5 THEN TEXTO := 'TRG_BLQ_INS_PRODOS_JGD';
                 WHEN I = 6 THEN TEXTO := 'TRG_BLQ_INS_SERVOS_JGD';
                 WHEN I = 7 THEN TEXTO := 'TRG_BLQ_UPD_PRODOS_JGD';
                 WHEN I = 8 THEN TEXTO := 'TRG_BLQ_UPD_SERVOS_JGD';
                 WHEN I = 9 THEN TEXTO := 'TRG_BLQ_UPD_ORDSERV_JGD';
                 WHEN I = 10 THEN TEXTO := 'TRG_BLQ_PRODOS_JGD';
                 WHEN I = 11 THEN TEXTO := 'TRG_BLQ_SERVOS_JGD';
                 WHEN I = 12 THEN TEXTO := 'TRG_BLQ_ORDSERV_JGD';
            END CASE;
            DBMS_OUTPUT.PUT_LINE('Trigger   '||TEXTO||'   ativada com sucesso!!');
            EXECUTE IMMEDIATE 'ALTER TRIGGER '||TEXTO||' ENABLE';
            IF I = 12 THEN
                DBMS_OUTPUT.PUT_LINE('TODAS AS TRIGGERS FORAM ATIVADAS COM SUCESSO!!');
            END IF;    
        END LOOP;
    END;
    DBMS_OUTPUT.PUT_LINE('EXCLUSÃO DE NOTAS EXECUTADA COM SUCESSO!!');
END;
/* FIM DO BLOCO*/