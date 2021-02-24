@echo off
echo Criando pasta Imagens_copiadas
mkdir "Imagens_copiadas"
echo ...
echo OK!
echo ...
echo Copiando imagens
copy "\\172.20.55.250\TSC-Arquivos\Imagens\*_2.jpg" "%USERPROFILE%\Desktop\Imagens_copiadas"
copy "\\172.20.55.250\TSC-Arquivos\Imagens\*_3.jpg" "%USERPROFILE%\Desktop\Imagens_copiadas"
copy "\\172.20.55.250\TSC-Arquivos\Imagens\*_4.jpg" "%USERPROFILE%\Desktop\Imagens_copiadas"
copy "\\172.20.55.250\TSC-Arquivos\Imagens\*_5.jpg" "%USERPROFILE%\Desktop\Imagens_copiadas"
copy "\\172.20.55.250\TSC-Arquivos\Imagens\*_6.jpg" "%USERPROFILE%\Desktop\Imagens_copiadas"
echo Imagens copiadas com sucesso!!
echo Adeus...
exit