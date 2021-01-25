import 'package:equatable/equatable.dart';

class WeatherInfo extends Equatable {
  final int cityId;
  final String city;
  final String condition;
  final String icon;
  final double temperatureInCelcius;
  final int humidity;

  WeatherInfo({
    this.cityId,
    this.city,
    this.condition,
    this.icon,
    this.temperatureInCelcius,
    this.humidity,
  });

  /// https://openweathermap.org/weather-conditions
  String get iconUrl => 'http://openweathermap.org/img/wn/$icon@2x.png';

  String get description =>
      '$condition - $temperatureInCelcius °C - $humidity%';

  @override
  List<Object> get props => [
        cityId,
        city,
        condition,
        icon,
        temperatureInCelcius,
        humidity,
      ];
}
