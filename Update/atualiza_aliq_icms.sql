DECLARE
    CONTAGEM NUMBER := 0;
    NOVOCODIGO NUMBER;
BEGIN
    CONTAGEM := CONTAGEM + 1;
    FOR I IN (SELECT * FROM TGFICM) 
    LOOP                                                    
        IF    I.CODRESTRICAO = 51    THEN
            NOVOCODIGO := 1000000;
        ELSIF I.CODRESTRICAO = 2151  THEN
            NOVOCODIGO := 1000001;
        ELSIF I.CODRESTRICAO = 5151  THEN
            NOVOCODIGO := 1100000;
        ELSIF I.CODRESTRICAO = 10151 THEN
            NOVOCODIGO := 1208000;
        ELSIF I.CODRESTRICAO = 4045  THEN
            NOVOCODIGO := 1510600;
        ELSIF I.CODRESTRICAO = 1151  THEN
            NOVOCODIGO := 1204900; --1205100
        ELSIF I.CODRESTRICAO = 11151 THEN
            NOVOCODIGO := 2204900;
        ELSIF I.CODRESTRICAO = 9151  THEN
            NOVOCODIGO := 1203102;
        ELSIF I.CODRESTRICAO = 19151 THEN
            NOVOCODIGO := 2203102;
        ELSIF I.CODRESTRICAO = 3151  THEN
            NOVOCODIGO := 1203103;
        ELSIF I.CODRESTRICAO = 13151 THEN
            NOVOCODIGO := 2203103;
        ELSIF I.CODRESTRICAO = 4151  THEN
            NOVOCODIGO := 1206800;
        ELSIF I.CODRESTRICAO = 14151 THEN
            NOVOCODIGO := 2206800;
        ELSIF I.CODRESTRICAO = 6151  THEN
            NOVOCODIGO := 1206000;
        ELSIF I.CODRESTRICAO = 16151 THEN
            NOVOCODIGO := 2206000;
        ELSIF I.CODRESTRICAO = 1052  THEN
            NOVOCODIGO := 1202601;
        ELSIF I.CODRESTRICAO = 11052 THEN
            NOVOCODIGO := 2202601;
        ELSIF I.CODRESTRICAO = 1051  THEN
            NOVOCODIGO := 1205301;
        ELSIF I.CODRESTRICAO = 11051 THEN
            NOVOCODIGO := 2205301;
        ELSIF I.CODRESTRICAO = 7151  THEN
            NOVOCODIGO := 1704900;
        ELSIF I.CODRESTRICAO = 17151 THEN
            NOVOCODIGO := 2704900;
        ELSIF I.CODRESTRICAO = 8151  THEN
            NOVOCODIGO := 1706800;
        ELSIF I.CODRESTRICAO = 18151 THEN
            NOVOCODIGO := 2706800;
        ELSE
            NOVOCODIGO := I.CODRESTRICAO;
            DBMS_OUTPUT.PUT_LINE('ERRO AQUI, COD: '||I.CODRESTRICAO);
        END IF;
        
        UPDATE TGFICM SET CODRESTRICAO2 = CAST(NOVOCODIGO AS NUMBER)
         WHERE CODRESTRICAO = I.CODRESTRICAO
           AND UFORIG = I.UFORIG
           AND UFDEST = I.UFDEST
           AND TIPRESTRICAO = I.TIPRESTRICAO;
           
        CONTAGEM := CONTAGEM + 1;
    END LOOP;
END;
/

DECLARE
    CONTAGEM NUMBER := 0;
    NOVOCODIGO NUMBER;
BEGIN
    CONTAGEM := CONTAGEM + 1;
    
    FOR I IN (SELECT * FROM TGFICM) 
    LOOP                                                    
        IF    I.CODRESTRICAO2 = 51    THEN
            NOVOCODIGO := 1000000;
        ELSIF I.CODRESTRICAO2 = 2151  THEN
            NOVOCODIGO := 1000001;
        ELSIF I.CODRESTRICAO2 = 5151  THEN
            NOVOCODIGO := 1100000;
        ELSIF I.CODRESTRICAO2 = 10151 THEN
            NOVOCODIGO := 1208000;
        ELSIF I.CODRESTRICAO2 = 4045  THEN
            NOVOCODIGO := 1510600;
        ELSIF I.CODRESTRICAO2 = 1151  THEN
            NOVOCODIGO := 1204900; --1205100
        ELSIF I.CODRESTRICAO2 = 11151 THEN
            NOVOCODIGO := 2204900;
        ELSIF I.CODRESTRICAO2 = 9151  THEN
            NOVOCODIGO := 1203102;
        ELSIF I.CODRESTRICAO2 = 19151 THEN
            NOVOCODIGO := 2203102;
        ELSIF I.CODRESTRICAO2 = 3151  THEN
            NOVOCODIGO := 1203103;
        ELSIF I.CODRESTRICAO2 = 13151 THEN
            NOVOCODIGO := 2203103;
        ELSIF I.CODRESTRICAO2 = 4151  THEN
            NOVOCODIGO := 1206800;
        ELSIF I.CODRESTRICAO2 = 14151 THEN
            NOVOCODIGO := 2206800;
        ELSIF I.CODRESTRICAO2 = 6151  THEN
            NOVOCODIGO := 1206000;
        ELSIF I.CODRESTRICAO2 = 16151 THEN
            NOVOCODIGO := 2206000;
        ELSIF I.CODRESTRICAO2 = 1052  THEN
            NOVOCODIGO := 1202601;
        ELSIF I.CODRESTRICAO2 = 11052 THEN
            NOVOCODIGO := 2202601;
        ELSIF I.CODRESTRICAO2 = 1051  THEN
            NOVOCODIGO := 1205301;
        ELSIF I.CODRESTRICAO2 = 11051 THEN
            NOVOCODIGO := 2205301;
        ELSIF I.CODRESTRICAO2 = 7151  THEN
            NOVOCODIGO := 1704900;
        ELSIF I.CODRESTRICAO2 = 17151 THEN
            NOVOCODIGO := 2704900;
        ELSIF I.CODRESTRICAO2 = 8151  THEN
            NOVOCODIGO := 1706800;
        ELSIF I.CODRESTRICAO2 = 18151 THEN
            NOVOCODIGO := 2706800;
        ELSE
            NOVOCODIGO := I.CODRESTRICAO2;
            DBMS_OUTPUT.PUT_LINE('ERRO AQUI, COD: '||I.CODRESTRICAO2);
        END IF;
        
        UPDATE TGFICM SET CODRESTRICAO2 = CAST(NOVOCODIGO AS NUMBER)
         WHERE CODRESTRICAO2 = I.CODRESTRICAO2
           AND UFORIG = I.UFORIG
           AND UFDEST = I.UFDEST
           AND TIPRESTRICAO = I.TIPRESTRICAO;
           
        CONTAGEM := CONTAGEM + 1;
    END LOOP;
END;
/



            
