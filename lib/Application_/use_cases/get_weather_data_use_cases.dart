
import 'package:geolocator/geolocator.dart';
import '../../Domain_/Repo/weather_repo.dart';
import '../../Domain_/entities/weather.dart';

class GetWeatherByLocation {
  final WeatherRepository _repository;

  GetWeatherByLocation(this._repository);

  Future<Weather> execute(double latitude , double longitude) async {
    return await _repository.getWeatherByLocation();
  }
}


class GetWeatherByCity {
  final WeatherRepository _repository;

  GetWeatherByCity(this._repository);

  Future<Weather> execute(String cityName) {
    return _repository.getWeatherByCity(cityName);
  }
}