import pytest
import matplotlib
from src.visualizer import WeatherVisualizer
from src.weather_parser import WeatherData


class TestWeatherVisualizer:
    
    @pytest.fixture
    def visualizer(self):
        return WeatherVisualizer()
    
    @pytest.fixture
    def sample_weather_data(self):
        """Фикстура с тестовыми данными о погоде."""
        return [
            WeatherData(
                city="Moscow",
                country="RU",
                date="2024-01-01",
                temperature=20.0,
                feels_like=19.0,
                humidity=65,
                pressure=1013,
                wind_speed=5.0,
                wind_direction="С",
                description="clear sky",
                icon="01d"
            ),
            WeatherData(
                city="Moscow",
                country="RU",
                date="2024-01-02",
                temperature=18.5,
                feels_like=17.5,
                humidity=70,
                pressure=1010,
                wind_speed=4.5,
                wind_direction="ЮВ",
                description="cloudy",
                icon="03d"
            ),
        ]
    
    def test_initialization(self, visualizer):
        """Тест инициализации визуализатора."""
        assert visualizer.output_dir is not None
        # Проверяем, что тема seaborn установлена
        import seaborn as sns
        assert sns.axes_style()['axes.grid']  # Проверка что сетка включена
    
    def test_create_temperature_chart(self, visualizer, sample_weather_data):
        """Тест создания графика температуры."""
        # Используем non-interactive бэкенд для тестов
        matplotlib.use('Agg')
        
        try:
            visualizer.create_temperature_chart(sample_weather_data)
            # Если не возникло исключений, тест пройден
            assert True
        except Exception as e:
            pytest.fail(f"Создание графика вызвало исключение: {e}")