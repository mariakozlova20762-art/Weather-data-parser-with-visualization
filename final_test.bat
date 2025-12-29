@echo off 
chcp 65001 > nul 
echo ========================================== 
echo ФИНАЛЬНАЯ ПРОВЕРКА ПРОЕКТА 
echo ========================================== 
echo. 
 
echo 1. ПРОВЕРКА СТРУКТУРЫ ПРОЕКТА... 
dir src 
echo. 
dir tests 
echo. 
 
echo 2. ПРОВЕРКА ЛОКАЛЬНОГО ЗАПУСКА... 
python -m src.main --help 
echo. 
python -m src.main test 
echo. 
python -m src.main weather --city "Москва" 
echo. 
python -m src.main forecast --city "Санкт-Петербург" --days 3 
echo. 
 
echo 3. ПРОВЕРКА ТЕСТОВ... 
python tests/test_basic.py 
echo. 
python -m pytest tests/ -v 
echo. 
 
echo 4. ПРОВЕРКА DOCKER... 
docker --version 
echo. 
echo Сборка Docker образа... 
docker build -t weather-parser . 
echo. 
echo Тестирование Docker команд... 
docker run --rm weather-parser --help 
echo. 
docker run --rm weather-parser test 
echo. 
docker run --rm weather-parser weather --city "London" 
echo. 
docker run --rm -e DEFAULT_CITY="Berlin" weather-parser weather 
echo. 
docker run --rm -e DEFAULT_CITY="Madrid" -e DEFAULT_DAYS=4 weather-parser forecast 
echo. 
 
echo 5. ПРОВЕРКА DOCKER COMPOSE... 
if exist docker-compose.yml ( 
    echo docker-compose.yml найден 
    echo Тестирование docker-compose... 
    docker-compose run --rm weather-parser test 
) else ( 
    echo docker-compose.yml не найден 
) 
echo. 
 
echo ========================================== 
echo ? ПРОЕКТ ГОТОВ К СДАЧЕ! 
echo ========================================== 
echo. 
echo ?? Что сдавать: 
echo 1. Весь проект в ZIP архиве 
echo 2. Скриншоты работы команд 
echo 3. Результаты тестов 
echo. 
echo ?? Команды для демонстрации: 
echo - python -m src.main --help 
echo - python -m src.main test 
echo - python -m src.main weather --city "Москва" 
echo - python -m src.main forecast --city "London" --days 5 
echo - docker run --rm weather-parser --help 
echo - docker run --rm weather-parser test 
echo - python tests/test_basic.py 
echo. 
pause 
