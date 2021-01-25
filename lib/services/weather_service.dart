import 'package:dio/dio.dart';
import 'package:quiver/iterables.dart';
import 'package:simple_weather_app/models/location_data.dart';
import 'package:simple_weather_app/models/weather_info.dart';
import 'package:meta/meta.dart';

class WeatherService {
  /// https://home.openweathermap.org/api_keys
  final apiKey = '09bfaf8012dd59f2c41a0bfe5bfe891c';

  final String baseApiUrl = 'https://api.openweathermap.org/data/2.5';

  Future<WeatherInfo> fetchWeatherInfo(
      {@required LocationData location}) async {
    final apiUrl =
        '$baseApiUrl/weather?q=${location.city},${location.state},${location.country}&appid=$apiKey';
    final weatherData = (await Dio().get<Map<String, dynamic>>(apiUrl)).data;

    return _fromMap(weatherData);
  }

  Future<List<WeatherInfo>> fetchWeatherInfoByCityIds(
      {@required List<int> cityIdList}) async {
    if ((cityIdList ?? []).isEmpty) {
      return [];
    }

    // https://openweathermap.org/current#severalid
    final cityIdChunks = partition(cityIdList, 20);

    final weatherInfoList = <WeatherInfo>[];
    for (final cityIdChunk in cityIdChunks) {
      final apiUrl =
          '$baseApiUrl/group?id=${cityIdChunk.join(',')}&appid=$apiKey';
      final weatherInfoListData =
          (await Dio().get<Map<String, dynamic>>(apiUrl)).data;

      if (weatherInfoListData['list'] != null) {
        weatherInfoList.addAll(
            List<Map<String, dynamic>>.from(weatherInfoListData['list'])
                .map(_fromMap)
                .toList());
      }
    }

    return weatherInfoList;
  }

  WeatherInfo _fromMap(Map<String, dynamic> weatherData) => WeatherInfo(
        cityId: weatherData['id'],
        city: weatherData['name'],
        icon: weatherData['weather'][0]['icon'],
        condition: weatherData['weather'][0]['description'],
        temperatureInCelcius:
            _temperatureInCelcius(weatherData['main']['temp']),
        humidity: weatherData['main']['humidity'],
      );

  double _temperatureInCelcius(double kevinDegree) => kevinDegree - 273.15;
}
