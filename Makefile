.PHONY: build run test clean help 
 
# Docker команды 
build: 
    docker build -t weather-parser . 
 
run: build 
    docker run -it --rm weather-parser 
 
shell: 
    docker run -it --rm weather-parser /bin/bash 
 
test: 
    docker run -it --rm weather-parser test 
 
weather: 
    docker run -it --rm weather-parser weather --city "Moscow" 
 
forecast: 
    docker run -it --rm weather-parser forecast --city "London" --days 3 
 
compose-up: 
    docker-compose up 
 
compose-down: 
    docker-compose down 
 
clean: 
    docker system prune -f 
 
help: 
    @echo "Доступные команды:" 
    @echo "  make build      - Сборка Docker образа" 
    @echo "  make run        - Запуск контейнера" 
    @echo "  make shell      - Запуск контейнера с shell" 
    @echo "  make test       - Запуск тестов в контейнере" 
    @echo "  make weather    - Получение погоды в контейнере" 
    @echo "  make forecast   - Получение прогноза в контейнере" 
    @echo "  make compose-up - Запуск через docker-compose" 
    @echo "  make compose-down - Остановка docker-compose" 
    @echo "  make clean      - Очистка Docker" 
