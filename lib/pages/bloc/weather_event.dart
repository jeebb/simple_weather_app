import 'package:simple_weather_app/models/location_data.dart';
import 'package:meta/meta.dart';

abstract class WeatherEvent {}

class FetchDataEvent extends WeatherEvent {}

class AddLocationEvent extends WeatherEvent {
  final LocationData locationData;

  AddLocationEvent({@required this.locationData});
}

class NotifyErrorEvent extends WeatherEvent {}
