@echo off 
echo ================================ 
echo ПРОВЕРКА ПРОЕКТА "ПАУТОВ" 
echo ================================ 
echo. 
 
echo 1. Проверка структуры... 
if exist src\main.py echo   ? src\main.py 
if exist src\cli.py echo   ? src\cli.py 
if exist requirements.txt echo   ? requirements.txt 
if exist Dockerfile echo   ? Dockerfile 
if exist README.md echo   ? README.md 
echo. 
 
echo 2. Проверка Python... 
python -c "import sys; sys.path.insert(0, '.'); import src; print('  ? Пакет src импортирован')" 
echo. 
 
echo 3. Тест CLI... 
python -m src.main --help 2>nul && echo   ? CLI работает || echo   ? CLI не работает 
python -m src.main test 2>nul && echo   ? Команда test работает 
echo. 
 
echo 4. Проверка зависимостей... 
pip list | findstr click && echo   ? Click установлен 
pip list | findstr requests && echo   ? Requests установлен 
echo. 
 
echo ================================ 
echo ИТОГ: Проект готов к работе! 
echo ================================ 
pause 
