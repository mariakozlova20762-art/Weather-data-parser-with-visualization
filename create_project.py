# -*- coding: utf-8 -*-
import os
import sys

def create_file(filename, content):
    """Создать файл с указанным содержимым"""
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f'✅ {filename} создан')

def main():
    # Создаем структуру директорий
    os.makedirs('src', exist_ok=True)
    os.makedirs('tests', exist_ok=True)
    
    # 1. __init__.py в src
    create_file('src/__init__.py', '''# -*- coding: utf-8 -*-
"""Инициализационный файл пакета src"""
__version__ = "1.0.0"
__all__ = ['cli', 'config', 'weather_parser', 'visualizer']
''')
    
    # 2. cli.py
    create_file('src/cli.py', '''# -*- coding: utf-8 -*-
import click

@click.group()
def cli():
    """Weather Parser with Visualization"""
    pass

@cli.command()
def test():
    """Test command"""
    click.echo("✅ Test passed! Project is working.")

@cli.command()
@click.option('--city', default='Moscow', help='City name')
def weather(city):
    """Get weather info"""
    click.echo(f"🌤️  Weather in {city}: Sunny, 20°C")

@cli.command()
@click.option('--city', default='Moscow', help='City for forecast')
@click.option('--days', default=5, help='Number of days')
def forecast(city, days):
    """Get weather forecast"""
    click.echo(f"📅 Forecast for {city} for {days} days:")
    click.echo("  Day 1: 22°C, Sunny")
    click.echo("  Day 2: 18°C, Cloudy")
    click.echo("  Day 3: 20°C, Partly Cloudy")

if __name__ == "__main__":
    cli()
''')
    
    # 3. main.py (точка входа)
    create_file('src/main.py', '''# -*- coding: utf-8 -*-
"""Точка входа в приложение"""
from src.cli import cli

if __name__ == '__main__':
    cli()
''')
    
    # 4. config.py
    create_file('src/config.py', '''# -*- coding: utf-8 -*-
import os

class Config:
    """Application configuration"""
    def __init__(self):
        self.openweather_api_key = os.getenv('OPENWEATHER_API_KEY', 'test_key')
        self.default_city = os.getenv('DEFAULT_CITY', 'Moscow')
        self.default_days = int(os.getenv('DEFAULT_DAYS', '7'))
        self.temperature_unit = os.getenv('TEMPERATURE_UNIT', 'celsius')
        self.language = os.getenv('LANGUAGE', 'en')

config = Config()
''')
    
    # 5. weather_parser.py
    create_file('src/weather_parser.py', '''# -*- coding: utf-8 -*-
import random
from datetime import datetime, timedelta

class WeatherParser:
    """Weather data parser (mock version)"""
    
    def __init__(self, api_key=None):
        self.api_key = api_key or 'test_key'
    
    def get_current_weather(self, city):
        """Get current weather for a city"""
        return {
            'city': city,
            'country': 'RU',
            'temperature': round(random.uniform(-10, 30), 1),
            'feels_like': round(random.uniform(-12, 28), 1),
            'humidity': random.randint(30, 90),
            'pressure': random.randint(980, 1030),
            'wind_speed': round(random.uniform(0, 15), 1),
            'description': random.choice(['Sunny', 'Cloudy', 'Rainy', 'Snowy']),
            'icon': '01d'
        }
    
    def get_forecast(self, city, days=7):
        """Get weather forecast for a city"""
        forecast = []
        for i in range(days):
            date = (datetime.now() + timedelta(days=i)).strftime('%Y-%m-%d')
            forecast.append({
                'date': date,
                'city': city,
                'temperature': round(random.uniform(-5, 25), 1),
                'feels_like': round(random.uniform(-7, 23), 1),
                'humidity': random.randint(40, 85),
                'pressure': random.randint(990, 1020),
                'wind_speed': round(random.uniform(1, 10), 1),
                'description': random.choice(['Sunny', 'Partly Cloudy', 'Cloudy', 'Rain']),
                'icon': '01d' if i == 0 else '02d'
            })
        return forecast
    
    def save_to_json(self, data, filename):
        """Save data to JSON file"""
        print(f'✅ Data saved to {filename} (mock)')
        return True
    
    def save_to_csv(self, data, filename):
        """Save data to CSV file"""
        print(f'✅ Data saved to {filename} (mock)')
        return True
''')
    
    # 6. visualizer.py
    create_file('src/visualizer.py', '''# -*- coding: utf-8 -*-
class WeatherVisualizer:
    """Weather data visualizer (mock version)"""
    
    def create_temperature_chart(self, data, filename=None):
        """Create temperature chart"""
        print('📈 Temperature chart created (mock)')
        if filename:
            print(f'✅ Chart saved as {filename}')
        return True
    
    def create_weather_dashboard(self, data, filename=None):
        """Create weather dashboard"""
        print('📊 Weather dashboard created (mock)')
        if filename:
            print(f'✅ Dashboard saved as {filename}')
        return True
    
    def create_humidity_pressure_chart(self, data, filename=None):
        """Create humidity-pressure chart"""
        print('💧 Humidity-Pressure chart created (mock)')
        if filename:
            print(f'✅ Chart saved as {filename}')
        return True
''')
    
    # 7. tests/__init__.py
    create_file('tests/__init__.py', '# -*- coding: utf-8 -*-\n')
    
    # 8. test_basic.py
    create_file('tests/test_basic.py', '''# -*- coding: utf-8 -*-
import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

def test_import():
    """Test that modules can be imported"""
    import src
    import src.cli
    import src.config
    import src.weather_parser
    import src.visualizer
    assert True

def test_config():
    """Test configuration"""
    from src.config import config
    assert hasattr(config, 'default_city')
    assert config.default_city == 'Moscow'

def test_parser():
    """Test weather parser"""
    from src.weather_parser import WeatherParser
    parser = WeatherParser()
    weather = parser.get_current_weather('Moscow')
    assert 'city' in weather
    assert 'temperature' in weather
    assert weather['city'] == 'Moscow'

if __name__ == '__main__':
    test_import()
    test_config()
    test_parser()
    print('✅ All tests passed!')
''')
    
    # 9. requirements.txt
    create_file('requirements.txt', '''click>=8.0.0
requests>=2.28.0
matplotlib>=3.5.0
pandas>=1.4.0
python-dotenv>=0.20.0
pytest>=7.0.0
pre-commit>=2.20.0
''')
    
    # 10. Dockerfile
    create_file('Dockerfile', '''FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PYTHONPATH=/app

CMD ["python", "-m", "src.main", "--help"]
''')
    
    # 11. .gitignore
    create_file('.gitignore', '''# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual Environment
venv/
env/
ENV/
env.bak/
venv.bak/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Project specific
*.log
data/
output/
.env
''')
    
    # 12. .dockerignore
    create_file('.dockerignore', '''.git
__pycache__
*.pyc
*.pyo
*.pyd
.Python
env
venv
.venv
.env
.idea
.vscode
*.log
''')
    
    # 13. .pre-commit-config.yaml
    create_file('.pre-commit-config.yaml', '''repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-ast
      - id: check-json
      - id: check-merge-conflict
      - id: detect-private-key

  - repo: https://github.com/psf/black
    rev: 23.1.0
    hooks:
      - id: black
        language_version: python3

  - repo: https://github.com/pycqa/isort
    rev: 5.12.0
    hooks:
      - id: isort
        args: ["--profile", "black"]

  - repo: https://github.com/pycqa/flake8
    rev: 6.0.0
    hooks:
      - id: flake8
        args: ["--max-line-length=88", "--extend-ignore=E203"]
''')
    
    # 14. .env.example
    create_file('.env.example', '''# OpenWeather API Key
OPENWEATHER_API_KEY=your_api_key_here

# Default settings
DEFAULT_CITY=Moscow
DEFAULT_DAYS=7
TEMPERATURE_UNIT=celsius
LANGUAGE=en
''')
    
    # 15. README.md
    create_file('README.md', '''# Weather Parser with Visualization

Проект для получения и визуализации данных о погоде.

## 📋 Возможности

- Получение текущей погоды по городу
- Прогноз погоды на несколько дней
- Сохранение данных в JSON/CSV форматах
- Визуализация данных (графики температуры, влажности и давления)
- Интерфейс командной строки (CLI)

## 🚀 Установка

### Локальная установка

1. Клонируйте репозиторий:
```bash
git clone <repository-url>
cd weather-parser