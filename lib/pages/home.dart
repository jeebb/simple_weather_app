import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather_app/models/location_data.dart';
import 'package:simple_weather_app/pages/bloc/weather_bloc.dart';
import 'package:simple_weather_app/pages/bloc/weather_event.dart';
import 'package:simple_weather_app/pages/bloc/weather_state.dart';
import 'package:simple_weather_app/pages/city_lookup.dart';
import 'package:simple_weather_app/widgets/weather_card.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherHomePage();
}

class _WeatherHomePage extends State<WeatherHomePage> {
  WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();

    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    _weatherBloc.add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.wb_sunny_rounded),
          title: Text('Mr. Weather'),
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
            IconButton(icon: Icon(Icons.add), onPressed: _openAddDialog),
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(child: _pageBody()),
      );

  Widget _pageBody() => BlocBuilder(
        cubit: _weatherBloc,
        builder: (_, state) {
          if (state is InitializingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FailureState) {
            return Center(
                child: Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.red),
            ));
          }

          final dataList = (state as DataInitializedState).dataList;
          if (dataList.isEmpty) {
            return Center(
                child: Text(
              'Location not found',
              style: TextStyle(color: Colors.grey),
            ));
          }

          return Container(
            margin: const EdgeInsets.all(20),
            child: ListView(
              children: dataList
                  .map((weather) => Row(
                        children: [
                          Expanded(child: WeatherCard(weatherInfo: weather)),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {},
                            color: Colors.red[200],
                          ),
                        ],
                      ))
                  .toList(),
            ),
          );
        },
      );

  void _openAddDialog() async {
    final selectedLocation = await Navigator.of(context).push<LocationData>(
      MaterialPageRoute(
        builder: (_) => CityLookupPage(),
        fullscreenDialog: true,
      ),
    );

    if (selectedLocation != null) {
      print('Selected location: $selectedLocation');

      _weatherBloc.add(AddLocationEvent(locationData: selectedLocation));
    }
  }
}
