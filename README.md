# Weather Parser with Visualization 
 
Проект для получения и визуализации данных о погоде. 
 
## Возможности 
 
- Получение текущей погоды по городу 
- Прогноз погоды на несколько дней 
- Сохранение данных в JSON/CSV форматах 
- Визуализация данных (графики температуры, влажности и давления) 
- Интерфейс командной строки (CLI) 
 
## Установка 
 
### Локальная установка 
 
1. Установите зависимости: 
```bash 
pip install -r requirements.txt 
``` 
 
2. Настройте переменные окружения: 
```bash 
copy .env.example .env 
# Отредактируйте .env файл, добавив ваш API ключ 
``` 
 
## Использование 
 
### Основные команды 
 
```bash 
# Показать справку 
python -m src.main --help 
 
# Тестирование работы 
python -m src.main test 
 
# Получить текущую погоду 
python -m src.main weather --city "Moscow" 
 
# Получить прогноз погоды 
python -m src.main forecast --city "Saint Petersburg" --days 5 
``` 
 
## Структура проекта 
 
``` 
требунский/ 
├── src/ 
│   ├── __init__.py          # Инициализация пакета 
│   ├── main.py             # Точка входа 
│   ├── cli.py              # Интерфейс командной строки 
│   ├── config.py           # Конфигурация 
│   ├── weather_parser.py   # Парсер погоды 
│   └── visualizer.py       # Визуализатор 
├── tests/ 
│   ├── __init__.py 
│   └── test_basic.py       # Базовые тесты 
├── requirements.txt        # Зависимости 
├── Dockerfile             # Контейнеризация 
├── README.md              # Документация 
├── .gitignore 
├── .dockerignore 
├── .pre-commit-config.yaml 
└── .env.example 
``` 
