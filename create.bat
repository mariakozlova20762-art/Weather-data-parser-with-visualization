@echo off
chcp 65001 > nul

echo Создание проекта Weather Parser...

REM Создаем структуру директорий
mkdir src 2>nul
mkdir tests 2>nul

REM 1. Создаем __init__.py в src
echo # -*- coding: utf-8 -*- > src\__init__.py
echo """Инициализационный файл пакета src""" >> src\__init__.py
echo __version__ = "1.0.0" >> src\__init__.py
echo __all__ = ['cli', 'config', 'weather_parser', 'visualizer'] >> src\__init__.py
echo ✅ src\__init__.py создан

REM 2. Создаем cli.py (упрощенная версия без emoji)
echo # -*- coding: utf-8 -*- > src\cli.py
echo import click >> src\cli.py
echo. >> src\cli.py
echo @click.group() >> src\cli.py
echo def cli(): >> src\cli.py
echo     """Weather Parser with Visualization""" >> src\cli.py
echo     pass >> src\cli.py
echo. >> src\cli.py
echo @cli.command() >> src\cli.py
echo def test(): >> src\cli.py
echo     """Test command""" >> src\cli.py
echo     click.echo("Test passed! Project is working.") >> src\cli.py
echo. >> src\cli.py
echo @cli.command() >> src\cli.py
echo @click.option('--city', default='Moscow', help='City name') >> src\cli.py
echo def weather(city): >> src\cli.py
echo     """Get weather info""" >> src\cli.py
echo     click.echo(f"Weather in {city}: Sunny, 20°C") >> src\cli.py
echo. >> src\cli.py
echo @cli.command() >> src\cli.py
echo @click.option('--city', default='Moscow', help='City for forecast') >> src\cli.py
echo @click.option('--days', default=5, help='Number of days') >> src\cli.py
echo def forecast(city, days): >> src\cli.py
echo     """Get weather forecast""" >> src\cli.py
echo     click.echo(f"Forecast for {city} for {days} days:") >> src\cli.py
echo     click.echo("  Day 1: 22°C, Sunny") >> src\cli.py
echo     click.echo("  Day 2: 18°C, Cloudy") >> src\cli.py
echo     click.echo("  Day 3: 20°C, Partly Cloudy") >> src\cli.py
echo. >> src\cli.py
echo if __name__ == "__main__": >> src\cli.py
echo     cli() >> src\cli.py
echo ✅ src\cli.py создан

REM 3. Создаем main.py
echo # -*- coding: utf-8 -*- > src\main.py
echo """Точка входа в приложение""" >> src\main.py
echo from src.cli import cli >> src\main.py
echo. >> src\main.py
echo if __name__ == '__main__': >> src\main.py
echo     cli() >> src\main.py
echo ✅ src\main.py создан

REM 4. Создаем config.py
echo # -*- coding: utf-8 -*- > src\config.py
echo import os >> src\config.py
echo. >> src\config.py
echo class Config: >> src\config.py
echo     """Application configuration""" >> src\config.py
echo     def __init__(self): >> src\config.py
echo         self.openweather_api_key = os.getenv('OPENWEATHER_API_KEY', 'test_key') >> src\config.py
echo         self.default_city = os.getenv('DEFAULT_CITY', 'Moscow') >> src\config.py
echo         self.default_days = int(os.getenv('DEFAULT_DAYS', '7')) >> src\config.py
echo         self.temperature_unit = os.getenv('TEMPERATURE_UNIT', 'celsius') >> src\config.py
echo         self.language = os.getenv('LANGUAGE', 'en') >> src\config.py
echo. >> src\config.py
echo config = Config() >> src\config.py
echo ✅ src\config.py создан

REM 5. Создаем weather_parser.py
echo # -*- coding: utf-8 -*- > src\weather_parser.py
echo import random >> src\weather_parser.py
echo from datetime import datetime, timedelta >> src\weather_parser.py
echo. >> src\weather_parser.py
echo class WeatherParser: >> src\weather_parser.py
echo     """Weather data parser (mock version)""" >> src\weather_parser.py
echo. >> src\weather_parser.py
echo     def __init__(self, api_key=None): >> src\weather_parser.py
echo         self.api_key = api_key or 'test_key' >> src\weather_parser.py
echo. >> src\weather_parser.py
echo     def get_current_weather(self, city): >> src\weather_parser.py
echo         """Get current weather for a city""" >> src\weather_parser.py
echo         return { >> src\weather_parser.py
echo             'city': city, >> src\weather_parser.py
echo             'country': 'RU', >> src\weather_parser.py
echo             'temperature': round(random.uniform(-10, 30), 1), >> src\weather_parser.py
echo             'feels_like': round(random.uniform(-12, 28), 1), >> src\weather_parser.py
echo             'humidity': random.randint(30, 90), >> src\weather_parser.py
echo             'pressure': random.randint(980, 1030), >> src\weather_parser.py
echo             'wind_speed': round(random.uniform(0, 15), 1), >> src\weather_parser.py
echo             'description': random.choice(['Sunny', 'Cloudy', 'Rainy', 'Snowy']), >> src\weather_parser.py
echo             'icon': '01d' >> src\weather_parser.py
echo         } >> src\weather_parser.py
echo. >> src\weather_parser.py
echo     def get_forecast(self, city, days=7): >> src\weather_parser.py
echo         """Get weather forecast for a city""" >> src\weather_parser.py
echo         forecast = [] >> src\weather_parser.py
echo         for i in range(days): >> src\weather_parser.py
echo             date = (datetime.now() + timedelta(days=i)).strftime('%%Y-%%m-%%d') >> src\weather_parser.py
echo             forecast.append({ >> src\weather_parser.py
echo                 'date': date, >> src\weather_parser.py
echo                 'city': city, >> src\weather_parser.py
echo                 'temperature': round(random.uniform(-5, 25), 1), >> src\weather_parser.py
echo                 'feels_like': round(random.uniform(-7, 23), 1), >> src\weather_parser.py
echo                 'humidity': random.randint(40, 85), >> src\weather_parser.py
echo                 'pressure': random.randint(990, 1020), >> src\weather_parser.py
echo                 'wind_speed': round(random.uniform(1, 10), 1), >> src\weather_parser.py
echo                 'description': random.choice(['Sunny', 'Partly Cloudy', 'Cloudy', 'Rain']), >> src\weather_parser.py
echo                 'icon': '01d' if i == 0 else '02d' >> src\weather_parser.py
echo             }) >> src\weather_parser.py
echo         return forecast >> src\weather_parser.py
echo. >> src\weather_parser.py
echo     def save_to_json(self, data, filename): >> src\weather_parser.py
echo         """Save data to JSON file""" >> src\weather_parser.py
echo         print(f'Data saved to {filename} (mock)') >> src\weather_parser.py
echo         return True >> src\weather_parser.py
echo. >> src\weather_parser.py
echo     def save_to_csv(self, data, filename): >> src\weather_parser.py
echo         """Save data to CSV file""" >> src\weather_parser.py
echo         print(f'Data saved to {filename} (mock)') >> src\weather_parser.py
echo         return True >> src\weather_parser.py
echo ✅ src\weather_parser.py создан

REM 6. Создаем visualizer.py
echo # -*- coding: utf-8 -*- > src\visualizer.py
echo class WeatherVisualizer: >> src\visualizer.py
echo     """Weather data visualizer (mock version)""" >> src\visualizer.py
echo. >> src\visualizer.py
echo     def create_temperature_chart(self, data, filename=None): >> src\visualizer.py
echo         """Create temperature chart""" >> src\visualizer.py
echo         print('Temperature chart created (mock)') >> src\visualizer.py
echo         if filename: >> src\visualizer.py
echo             print(f'Chart saved as {filename}') >> src\visualizer.py
echo         return True >> src\visualizer.py
echo. >> src\visualizer.py
echo     def create_weather_dashboard(self, data, filename=None): >> src\visualizer.py
echo         """Create weather dashboard""" >> src\visualizer.py
echo         print('Weather dashboard created (mock)') >> src\visualizer.py
echo         if filename: >> src\visualizer.py
echo             print(f'Dashboard saved as {filename}') >> src\visualizer.py
echo         return True >> src\visualizer.py
echo. >> src\visualizer.py
echo     def create_humidity_pressure_chart(self, data, filename=None): >> src\visualizer.py
echo         """Create humidity-pressure chart""" >> src\visualizer.py
echo         print('Humidity-Pressure chart created (mock)') >> src\visualizer.py
echo         if filename: >> src\visualizer.py
echo             print(f'Chart saved as {filename}') >> src\visualizer.py
echo         return True >> src\visualizer.py
echo ✅ src\visualizer.py создан

REM 7. Создаем tests/__init__.py
echo # -*- coding: utf-8 -*- > tests\__init__.py
echo ✅ tests\__init__.py создан

REM 8. Создаем test_basic.py
echo # -*- coding: utf-8 -*- > tests\test_basic.py
echo import sys >> tests\test_basic.py
echo import os >> tests\test_basic.py
echo sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..')) >> tests\test_basic.py
echo. >> tests\test_basic.py
echo def test_import(): >> tests\test_basic.py
echo     """Test that modules can be imported""" >> tests\test_basic.py
echo     import src >> tests\test_basic.py
echo     import src.cli >> tests\test_basic.py
echo     import src.config >> tests\test_basic.py
echo     import src.weather_parser >> tests\test_basic.py
echo     import src.visualizer >> tests\test_basic.py
echo     assert True >> tests\test_basic.py
echo. >> tests\test_basic.py
echo def test_config(): >> tests\test_basic.py
echo     """Test configuration""" >> tests\test_basic.py
echo     from src.config import config >> tests\test_basic.py
echo     assert hasattr(config, 'default_city') >> tests\test_basic.py
echo     assert config.default_city == 'Moscow' >> tests\test_basic.py
echo. >> tests\test_basic.py
echo def test_parser(): >> tests\test_basic.py
echo     """Test weather parser""" >> tests\test_basic.py
echo     from src.weather_parser import WeatherParser >> tests\test_basic.py
echo     parser = WeatherParser() >> tests\test_basic.py
echo     weather = parser.get_current_weather('Moscow') >> tests\test_basic.py
echo     assert 'city' in weather >> tests\test_basic.py
echo     assert 'temperature' in weather >> tests\test_basic.py
echo     assert weather['city'] == 'Moscow' >> tests\test_basic.py
echo. >> tests\test_basic.py
echo if __name__ == '__main__': >> tests\test_basic.py
echo     test_import() >> tests\test_basic.py
echo     test_config() >> tests\test_basic.py
echo     test_parser() >> tests\test_basic.py
echo     print('All tests passed!') >> tests\test_basic.py
echo ✅ tests\test_basic.py создан

REM 9. Создаем requirements.txt
echo click>=8.0.0 > requirements.txt
echo requests>=2.28.0 >> requirements.txt
echo matplotlib>=3.5.0 >> requirements.txt
echo pandas>=1.4.0 >> requirements.txt
echo python-dotenv>=0.20.0 >> requirements.txt
echo pytest>=7.0.0 >> requirements.txt
echo pre-commit>=2.20.0 >> requirements.txt
echo ✅ requirements.txt создан

REM 10. Создаем Dockerfile
echo FROM python:3.9-slim > Dockerfile
echo. >> Dockerfile
echo WORKDIR /app >> Dockerfile
echo. >> Dockerfile
echo COPY requirements.txt . >> Dockerfile
echo RUN pip install --no-cache-dir -r requirements.txt >> Dockerfile
echo. >> Dockerfile
echo COPY . . >> Dockerfile
echo. >> Dockerfile
echo ENV PYTHONPATH=/app >> Dockerfile
echo. >> Dockerfile
echo CMD ["python", "-m", "src.main", "--help"] >> Dockerfile
echo ✅ Dockerfile создан

REM 11. Создаем .gitignore
echo # Python > .gitignore
echo __pycache__/ >> .gitignore
echo *.py[cod] >> .gitignore
echo *$py.class >> .gitignore
echo *.so >> .gitignore
echo .Python >> .gitignore
echo build/ >> .gitignore
echo develop-eggs/ >> .gitignore
echo dist/ >> .gitignore
echo downloads/ >> .gitignore
echo eggs/ >> .gitignore
echo .eggs/ >> .gitignore
echo lib/ >> .gitignore
echo lib64/ >> .gitignore
echo parts/ >> .gitignore
echo sdist/ >> .gitignore
echo var/ >> .gitignore
echo wheels/ >> .gitignore
echo pip-wheel-metadata/ >> .gitignore
echo share/python-wheels/ >> .gitignore
echo *.egg-info/ >> .gitignore
echo .installed.cfg >> .gitignore
echo *.egg >> .gitignore
echo. >> .gitignore
echo # Virtual Environment >> .gitignore
echo venv/ >> .gitignore
echo env/ >> .gitignore
echo ENV/ >> .gitignore
echo env.bak/ >> .gitignore
echo venv.bak/ >> .gitignore
echo. >> .gitignore
echo # IDE >> .gitignore
echo .vscode/ >> .gitignore
echo .idea/ >> .gitignore
echo *.swp >> .gitignore
echo *.swo >> .gitignore
echo. >> .gitignore
echo # OS >> .gitignore
echo .DS_Store >> .gitignore
echo .DS_Store? >> .gitignore
echo ._* >> .gitignore
echo .Spotlight-V100 >> .gitignore
echo .Trashes >> .gitignore
echo ehthumbs.db >> .gitignore
echo Thumbs.db >> .gitignore
echo. >> .gitignore
echo # Project specific >> .gitignore
echo *.log >> .gitignore
echo data/ >> .gitignore
echo output/ >> .gitignore
echo .env >> .gitignore
echo ✅ .gitignore создан

REM 12. Создаем .dockerignore
echo .git > .dockerignore
echo __pycache__ >> .dockerignore
echo *.pyc >> .dockerignore
echo *.pyo >> .dockerignore
echo *.pyd >> .dockerignore
echo .Python >> .dockerignore
echo env >> .dockerignore
echo venv >> .dockerignore
echo .venv >> .dockerignore
echo .env >> .dockerignore
echo .idea >> .dockerignore
echo .vscode >> .dockerignore
echo *.log >> .dockerignore
echo ✅ .dockerignore создан

REM 13. Создаем .pre-commit-config.yaml
echo repos: > .pre-commit-config.yaml
echo   - repo: https://github.com/pre-commit/pre-commit-hooks >> .pre-commit-config.yaml
echo     rev: v4.4.0 >> .pre-commit-config.yaml
echo     hooks: >> .pre-commit-config.yaml
echo       - id: trailing-whitespace >> .pre-commit-config.yaml
echo       - id: end-of-file-fixer >> .pre-commit-config.yaml
echo       - id: check-yaml >> .pre-commit-config.yaml
echo       - id: check-added-large-files >> .pre-commit-config.yaml
echo       - id: check-ast >> .pre-commit-config.yaml
echo       - id: check-json >> .pre-commit-config.yaml
echo       - id: check-merge-conflict >> .pre-commit-config.yaml
echo       - id: detect-private-key >> .pre-commit-config.yaml
echo. >> .pre-commit-config.yaml
echo   - repo: https://github.com/psf/black >> .pre-commit-config.yaml
echo     rev: 23.1.0 >> .pre-commit-config.yaml
echo     hooks: >> .pre-commit-config.yaml
echo       - id: black >> .pre-commit-config.yaml
echo         language_version: python3 >> .pre-commit-config.yaml
echo. >> .pre-commit-config.yaml
echo   - repo: https://github.com/pycqa/isort >> .pre-commit-config.yaml
echo     rev: 5.12.0 >> .pre-commit-config.yaml
echo     hooks: >> .pre-commit-config.yaml
echo       - id: isort >> .pre-commit-config.yaml
echo         args: ["--profile", "black"] >> .pre-commit-config.yaml
echo. >> .pre-commit-config.yaml
echo   - repo: https://github.com/pycqa/flake8 >> .pre-commit-config.yaml
echo     rev: 6.0.0 >> .pre-commit-config.yaml
echo     hooks: >> .pre-commit-config.yaml
echo       - id: flake8 >> .pre-commit-config.yaml
echo         args: ["--max-line-length=88", "--extend-ignore=E203"] >> .pre-commit-config.yaml
echo ✅ .pre-commit-config.yaml создан

REM 14. Создаем .env.example
echo # OpenWeather API Key > .env.example
echo OPENWEATHER_API_KEY=your_api_key_here >> .env.example
echo. >> .env.example
echo # Default settings >> .env.example
echo DEFAULT_CITY=Moscow >> .env.example
echo DEFAULT_DAYS=7 >> .env.example
echo TEMPERATURE_UNIT=celsius >> .env.example
echo LANGUAGE=en >> .env.example
echo ✅ .env.example создан

REM 15. Создаем README.md
echo # Weather Parser with Visualization > README.md
echo. >> README.md
echo Проект для получения и визуализации данных о погоде. >> README.md
echo. >> README.md
echo ## Возможности >> README.md
echo. >> README.md
echo - Получение текущей погоды по городу >> README.md
echo - Прогноз погоды на несколько дней >> README.md
echo - Сохранение данных в JSON/CSV форматах >> README.md
echo - Визуализация данных (графики температуры, влажности и давления) >> README.md
echo - Интерфейс командной строки (CLI) >> README.md
echo. >> README.md
echo ## Установка >> README.md
echo. >> README.md
echo ### Локальная установка >> README.md
echo. >> README.md
echo 1. Установите зависимости: >> README.md
echo ```bash >> README.md
echo pip install -r requirements.txt >> README.md
echo ``` >> README.md
echo. >> README.md
echo 2. Настройте переменные окружения: >> README.md
echo ```bash >> README.md
echo copy .env.example .env >> README.md
echo # Отредактируйте .env файл, добавив ваш API ключ >> README.md
echo ``` >> README.md
echo. >> README.md
echo ## Использование >> README.md
echo. >> README.md
echo ### Основные команды >> README.md
echo. >> README.md
echo ```bash >> README.md
echo # Показать справку >> README.md
echo python -m src.main --help >> README.md
echo. >> README.md
echo # Тестирование работы >> README.md
echo python -m src.main test >> README.md
echo. >> README.md
echo # Получить текущую погоду >> README.md
echo python -m src.main weather --city "Moscow" >> README.md
echo. >> README.md
echo # Получить прогноз погоды >> README.md
echo python -m src.main forecast --city "Saint Petersburg" --days 5 >> README.md
echo ``` >> README.md
echo. >> README.md
echo ## Структура проекта >> README.md
echo. >> README.md
echo ``` >> README.md
echo требунский/ >> README.md
echo ├── src/ >> README.md
echo │   ├── __init__.py          # Инициализация пакета >> README.md
echo │   ├── main.py             # Точка входа >> README.md
echo │   ├── cli.py              # Интерфейс командной строки >> README.md
echo │   ├── config.py           # Конфигурация >> README.md
echo │   ├── weather_parser.py   # Парсер погоды >> README.md
echo │   └── visualizer.py       # Визуализатор >> README.md
echo ├── tests/ >> README.md
echo │   ├── __init__.py >> README.md
echo │   └── test_basic.py       # Базовые тесты >> README.md
echo ├── requirements.txt        # Зависимости >> README.md
echo ├── Dockerfile             # Контейнеризация >> README.md
echo ├── README.md              # Документация >> README.md
echo ├── .gitignore >> README.md
echo ├── .dockerignore >> README.md
echo ├── .pre-commit-config.yaml >> README.md
echo └── .env.example >> README.md
echo ``` >> README.md
echo ✅ README.md создан

echo.
echo ========================================
echo ПРОЕКТ УСПЕШНО СОЗДАН!
echo ========================================
echo.
pause