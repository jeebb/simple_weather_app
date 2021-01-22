import 'package:bloc/bloc.dart';
import 'package:simple_weather_app/pages/bloc/weather_event.dart';
import 'package:simple_weather_app/pages/bloc/weather_state.dart';
import 'package:simple_weather_app/services/weather_service.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final _weatherService = WeatherService();

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
    // TODO: fetch the added locations and their weather info
    yield DataInitializedState(dataList: []);
  }

  Stream<WeatherState> _handleAddLocationEvent(AddLocationEvent event) async* {
    if (state is! DataInitializedState) {
      return;
    }

    final weatherInfo =
        await _weatherService.fetchWeatherInfo(location: event.locationData);
    // TODO: persist fetched data to local storage

    yield (state as DataInitializedState)
        .withAdditionalDataList(additionalDataList: [weatherInfo]);
  }

  Stream<WeatherState> _handleNotifyErrorEvent(NotifyErrorEvent event) async* {
    yield FailureState();
  }

  @override
  void onError(error, stackTrace) {
    super.onError(error, stackTrace);

    add(NotifyErrorEvent());
  }
}
