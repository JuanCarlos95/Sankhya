DECLARE
    L_BLOB      BLOB;
    L_BFILE    BFILE;
    VERIFICA  NUMBER;
    CONTADOR  NUMBER;
    TAMFILE   NUMBER;
    ERRORES   NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO VERIFICA
      FROM ALL_TABLES
     WHERE TABLE_NAME LIKE 'ERROIMAGENS';

    IF VERIFICA = 0 THEN
        EXECUTE IMMEDIATE 'CREATE TABLE ERROIMAGENS( CODPROD NUMBER )';
    ELSE
        DELETE FROM ERROIMAGENS;
    END IF;
    
    CONTADOR := 0;
    
    FOR I IN (SELECT IMAGEM, CODPROD FROM TGFPRO)
    LOOP
        UPDATE TGFPRO SET IMAGEM = EMPTY_BLOB()
         WHERE CODPROD = I.CODPROD 
        RETURN IMAGEM INTO L_BLOB;
        
        L_BFILE := BFILENAME('IMAGENS', I.CODPROD||'_1.jpg');
        TAMFILE := FLENGTH('IMAGENS', I.CODPROD||'_1.jpg');
        
        IF TAMFILE > 0 THEN
            DBMS_LOB.FILEOPEN(L_BFILE);
            DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
            DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
            DBMS_LOB.FILECLOSE(L_BFILE);
            COMMIT;
            CONTADOR := CONTADOR + 1;
        ELSE
            L_BFILE := BFILENAME('IMAGENS', I.CODPROD||'_1.JPG');
            TAMFILE := FLENGTH('IMAGENS', I.CODPROD||'_1.JPG');
            
            IF TAMFILE > 0 THEN
                DBMS_LOB.FILEOPEN(L_BFILE);
                DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
                DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
                DBMS_LOB.FILECLOSE(L_BFILE);
                COMMIT;
                CONTADOR := CONTADOR + 1;
            ELSE
                L_BFILE := BFILENAME('IMAGENS', I.CODPROD||'_1.JPEG');
                TAMFILE := FLENGTH('IMAGENS', I.CODPROD||'_1.JPEG');
                
                IF TAMFILE > 0 THEN
                    DBMS_LOB.FILEOPEN(L_BFILE);
                    DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
                    DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
                    DBMS_LOB.FILECLOSE(L_BFILE);
                    COMMIT;
                    CONTADOR := CONTADOR + 1;
                ELSE
                    INSERT INTO ERROIMAGENS
                    VALUES (I.CODPROD);
                END IF;
            END IF;
        END IF;
        
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(CONTADOR);
    SELECT COUNT(*)
      INTO ERRORES 
      FROM ERROIMAGENS;
    DBMS_OUTPUT.PUT_LINE(ERRORES);
END;
/