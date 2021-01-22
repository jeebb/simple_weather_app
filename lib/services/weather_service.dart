import 'package:dio/dio.dart';
import 'package:simple_weather_app/models/location_data.dart';
import 'package:simple_weather_app/models/weather_info.dart';
import 'package:meta/meta.dart';

class WeatherService {
  /// https://home.openweathermap.org/api_keys
  final apiKey = '<FILL_YOUR_API_KEY>';

  Future<WeatherInfo> fetchWeatherInfo(
      {@required LocationData location}) async {
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=${location.city},${location.state},${location.country}&appid=$apiKey';
    final weatherData = (await Dio().get<Map<String, dynamic>>(apiUrl)).data;

    return WeatherInfo(
      city: location.city,
      icon: weatherData['weather'][0]['icon'],
      condition: weatherData['weather'][0]['description'],
      temperatureInCelcius: _temperatureInCelcius(weatherData['main']['temp']),
      humidity: weatherData['main']['humidity'],
    );
  }

  double _temperatureInCelcius(double kevinDegree) => kevinDegree - 273.15;
}
