@echo off 
echo Создание архива проекта... 
echo. 
echo 1. Копируем проект во временную папку... 
if exist temp_zip rmdir /s /q temp_zip 
mkdir temp_zip 
xcopy /E /I . temp_zip 
 
echo 2. Создаем архив... 
powershell -Command "Compress-Archive -Path 'temp_zip/*' -DestinationPath 'требунский.zip'" 
 
echo 3. Удаляем временную папку... 
rmdir /s /q temp_zip 
 
echo ✅ Архив создан: требунский.zip 
dir *.zip 
pause 
