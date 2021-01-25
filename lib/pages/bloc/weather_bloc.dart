import 'package:bloc/bloc.dart';
import 'package:simple_weather_app/pages/bloc/weather_event.dart';
import 'package:simple_weather_app/pages/bloc/weather_state.dart';
import 'package:simple_weather_app/repository/city_repository.dart';
import 'package:simple_weather_app/services/weather_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final _weatherService = WeatherService();

  final _cityRepository = CityRepository();

  WeatherBloc() : super(InitializingState());

  Map get _eventHandler => {
        AddLocationEvent: _handleAddLocationEvent,
        FetchDataEvent: _handleFetchDataEvent,
        NotifyErrorEvent: _handleNotifyErrorEvent,
      };

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    yield* _eventHandler[event.runtimeType](event);
  }

  Stream<WeatherState> _handleFetchDataEvent(FetchDataEvent event) async* {
    final cityIdList = _cityRepository.cityIdList();
    final weatherInfoList =
        await _weatherService.fetchWeatherInfoByCityIds(cityIdList: cityIdList);

    yield DataInitializedState(dataList: weatherInfoList);
  }

  Stream<WeatherState> _handleAddLocationEvent(AddLocationEvent event) async* {
    if (state is! DataInitializedState) {
      return;
    }

    final weatherInfo =
        await _weatherService.fetchWeatherInfo(location: event.locationData);

    _cityRepository.saveCityId(cityId: weatherInfo.cityId);

    yield (state as DataInitializedState)
        .withAdditionalDataList(additionalDataList: [weatherInfo]);
  }

  Stream<WeatherState> _handleNotifyErrorEvent(NotifyErrorEvent event) async* {
    yield FailureState();
  }

  @override
  void onError(error, [stackTrace]) {
    add(NotifyErrorEvent());

    super.onError(error, stackTrace);
  }
}
