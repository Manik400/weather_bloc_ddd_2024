import 'package:geolocator/geolocator.dart';
import 'package:weather_bloc_ddd_2024/Domain_/entities/weather.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Domain_/Repo/weather_repo.dart';

class WeatherRepoImpl implements WeatherRepository{
  static const apikey = '24e647fafc4ea1ac6ca0f989d069f3c3';
  @override
  Future<Weather> getWeatherByLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    double latitude = position.latitude;
    double longitude = position.longitude;
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return _mapWeatherData(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<Weather> getWeatherByCity(String cityName) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return _mapWeatherData(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Weather _mapWeatherData(Map<String, dynamic> data) {
    final String cityName = data['name'];
    final double temperature = (data['main']['temp'] - 273.15); // Convert temperature from Kelvin to Celsius
    final String condition = data['weather'][0]['main'];

    return Weather(cityName: cityName, temperature: temperature, condition: condition);
  }

}