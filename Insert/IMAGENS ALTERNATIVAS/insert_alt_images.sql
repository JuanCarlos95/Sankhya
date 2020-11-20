declare
    path_insert varchar2(255);
    path_image1 varchar2(255);
    path_image2 varchar2(255);
    path_image3 varchar2(255);
    path_image4 varchar2(255);
    tam_image1 number;
    tam_image2 number;
    tam_image3 number;
    tam_image4 number;
    contador number;
    nroimg number := 0;
begin
    contador := 0;
    for i in 2..6
    loop 
        for j in (select codprod from tgfpro)
        loop
            path_image1 := j.codprod||'_'||i||'.JPG';
            path_image2 := j.codprod||'_'||i||'.jpg';
            path_image3 := j.codprod||'_'||i||'.JPEG';
            path_image4 := j.codprod||'_'||i||'.jpeg';
            
            tam_image1 := FLENGTH('IMAGENS', path_image1);
            tam_image2 := FLENGTH('IMAGENS', path_image2);
            tam_image3 := FLENGTH('IMAGENS', path_image3);
            tam_image4 := FLENGTH('IMAGENS', path_image4);
             
            if tam_image1 > 0 then
                path_insert := path_image1;
            elsif tam_image2 > 0 then
                path_insert := path_image2;
            elsif tam_image3 > 0 then
                path_insert := path_image3;
            elsif tam_image4 > 0 then
                path_insert := path_image4;
            else
                path_insert := '404';
            end if;
            
            if path_insert != '404' then
                nroimg := nroimg + 1;
                contador := contador + 1;
                insert into tgfimal
                    values(nroimg, j.codprod, path_insert, 15, sysdate);
            end if;
        end loop;
    end loop;
    dbms_output.put_line(contador);
end;
/