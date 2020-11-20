@echo off
echo Criando pasta Imagens_copiadas
mkdir "Imagens_copiadas"
echo ...
echo OK!
echo ...
echo Copiando imagens
copy "T:\*_2.jpg" "%USERPROFILE%\Desktop\Imagens_copiadas"
copy "T:\*_3.jpg" "%USERPROFILE%\Desktop\Imagens_copiadas"
copy "T:\*_4.jpg" "%USERPROFILE%\Desktop\Imagens_copiadas"
copy "T:\*_5.jpg" "%USERPROFILE%\Desktop\Imagens_copiadas"
copy "T:\*_6.jpg" "%USERPROFILE%\Desktop\Imagens_copiadas"
echo Imagens copiadas com sucesso!!
echo Adeus...
exit