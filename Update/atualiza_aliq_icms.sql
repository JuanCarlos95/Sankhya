DECLARE
    CONTAGEM NUMBER := 0;
    NOVOCODIGO NUMBER;
BEGIN
    CONTAGEM := CONTAGEM + 1;
    FOR I IN (SELECT * FROM TGFICM) 
    LOOP                                                    
        DBMS_OUTPUT.PUT_LINE(I.CODRESTRICAO);
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
            NOVOCODIGO := 1205100;
        ELSIF I.CODRESTRICAO = 11151 THEN
            NOVOCODIGO := 2205100;
        ELSIF I.CODRESTRICAO = 9151  THEN
            NOVOCODIGO := 1203302;
        ELSIF I.CODRESTRICAO = 19151 THEN
            NOVOCODIGO := 2203302;
        ELSIF I.CODRESTRICAO = 3151  THEN
            NOVOCODIGO := 1203303;
        ELSIF I.CODRESTRICAO = 13151 THEN
            NOVOCODIGO := 2203303;
        ELSIF I.CODRESTRICAO = 4151  THEN
            NOVOCODIGO := 1206800;
        ELSIF I.CODRESTRICAO = 14151 THEN
            NOVOCODIGO := 2206800;
        ELSIF I.CODRESTRICAO = 6151  THEN
            NOVOCODIGO := 1206100;
        ELSIF I.CODRESTRICAO = 16151 THEN
            NOVOCODIGO := 2206100;
        ELSIF I.CODRESTRICAO = 1052  THEN
            NOVOCODIGO := 1202601;
        ELSIF I.CODRESTRICAO = 11052 THEN
            NOVOCODIGO := 2202601;
        ELSIF I.CODRESTRICAO = 1051  THEN
            NOVOCODIGO := 1205301;
        ELSIF I.CODRESTRICAO = 11051 THEN
            NOVOCODIGO := 2205301;
        ELSIF I.CODRESTRICAO = 7151  THEN
            NOVOCODIGO := 1705100;
        ELSIF I.CODRESTRICAO = 17151 THEN
            NOVOCODIGO := 2705100;
        ELSIF I.CODRESTRICAO = 8151  THEN
            NOVOCODIGO := 1706800;
        ELSIF I.CODRESTRICAO = 18151 THEN
            NOVOCODIGO := 2706800;
        ELSE
            NOVOCODIGO := I.CODRESTRICAO;
            DBMS_OUTPUT.PUT_LINE('ERRO AQUI, C�D: '||I.CODRESTRICAO);
        END IF;
        
        UPDATE TGFICM SET CODRESTRICAO = CAST(NOVOCODIGO AS NUMBER)
         WHERE CODRESTRICAO = I.CODRESTRICAO
           AND UFORIG = I.UFORIG
           AND UFDEST = I.UFDEST
           AND TIPRESTRICAO = I.TIPRESTRICAO;
           
        CONTAGEM := CONTAGEM + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('ATUALIZADOS: ' ||CONTAGEM);
--    CONTAGEM := 0;
--    FOR J IN (SELECT * FROM TGFICM WHERE CODRESTRICAO NOT IN (1000000, 1000001,
--                1100000, 1208000, 1510600, 1205100, 2205100, 1203302, 2203302,
--                1203303, 2203303, 1206800, 2206800, 1206100, 2206100, 1202601,
--                2202601, 1205301, 2205301, 1705100, 2705100, 1706800, 2706800))
--    LOOP
--        DELETE FROM TGFICM WHERE CODRESTRICAO = J.CODRESTRICAO
--           AND UFORIG = I.UFORIG
--           AND UFDEST = I.UFDEST
--           AND TIPRESTRICAO = I.TIPRESTRICAO;
--           
--        CONTAGEM := CONTAGEM + 1;   
--    END LOOP;
--    DBMS_OUTPUT.PUT_LINE('DELETADOS: ' ||CONTAGEM);
END;
/
