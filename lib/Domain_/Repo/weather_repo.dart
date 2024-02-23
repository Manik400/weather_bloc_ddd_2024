
import '../../Domain_/entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeatherByLocation();
  Future<Weather> getWeatherByCity(String cityName);
}