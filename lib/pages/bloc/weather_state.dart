import 'package:equatable/equatable.dart';
import 'package:simple_weather_app/models/weather_info.dart';
import 'package:meta/meta.dart';

abstract class WeatherState extends Equatable {}

class InitializingState extends WeatherState {
  @override
  List<Object> get props => [];
}

class DataInitializedState extends WeatherState {
  final List<WeatherInfo> dataList;

  DataInitializedState({@required this.dataList});

  DataInitializedState withAdditionalDataList({
    List<WeatherInfo> additionalDataList,
  }) =>
      DataInitializedState(dataList: dataList + additionalDataList);

  @override
  List<Object> get props => [dataList];
}

class FailureState extends WeatherState {
  @override
  List<Object> get props => [];
}
