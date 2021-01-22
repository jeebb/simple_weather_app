class WeatherInfo {
  final String city;
  final String condition;
  final String icon;
  final double temperatureInCelcius;
  final double humidity;

  WeatherInfo({
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
}
