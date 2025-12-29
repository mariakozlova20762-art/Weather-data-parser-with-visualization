import pytest
from unittest.mock import Mock, patch
from src.weather_parser import WeatherParser, WeatherData


class TestWeatherParser:
    
    @pytest.fixture
    def parser(self):
        return WeatherParser(api_key="test_key")
    
    def test_init_without_api_key(self):
        """Тест инициализации без API ключа."""
        with pytest.raises(ValueError, match="API key is required"):
            WeatherParser()
    
    def test_init_with_api_key(self):
        """Тест инициализации с API ключом."""
        parser = WeatherParser(api_key="test_key")
        assert parser.api_key == "test_key"
        assert parser.base_url == "https://api.openweathermap.org/data/2.5"
    
    @patch('requests.get')
    def test_get_current_weather_success(self, mock_get, parser):
        """Тест успешного получения текущей погоды."""
        # Мокируем ответ API
        mock_response = Mock()
        mock_response.json.return_value = {
            "name": "Moscow",
            "sys": {"country": "RU", "sunrise": 1614567890, "sunset": 1614612345},
            "weather": [{"description": "clear sky", "icon": "01d"}],
            "main": {
                "temp": 20.5,
                "feels_like": 19.8,
                "humidity": 65,
                "pressure": 1013
            },
            "wind": {"speed": 5.2, "deg": 180}
        }
        mock_response.raise_for_status.return_value = None
        mock_get.return_value = mock_response
        
        # Вызываем метод
        result = parser.get_current_weather("Moscow")
        
        # Проверяем результат
        assert isinstance(result, WeatherData)
        assert result.city == "Moscow"
        assert result.country == "RU"
        assert result.temperature == 20.5
        assert result.description == "clear sky"
    
    def test_get_wind_direction(self):
        """Тест определения направления ветра."""
        parser = WeatherParser(api_key="test_key")
        
        test_cases = [
            (0, "С"),
            (45, "СВ"),
            (90, "В"),
            (135, "ЮВ"),
            (180, "Ю"),
            (225, "ЮЗ"),
            (270, "З"),
            (315, "СЗ"),
            (360, "С"),
            (22.5, "С"),
            (67.5, "СВ"),
        ]
        
        for degrees, expected in test_cases:
            assert parser._get_wind_direction(degrees) == expected