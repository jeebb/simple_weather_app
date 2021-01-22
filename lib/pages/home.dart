import 'package:flutter/material.dart';
import 'package:simple_weather_app/models/weather_info.dart';
import 'package:simple_weather_app/pages/city_lookup.dart';
import 'package:simple_weather_app/widgets/weather_card.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherHomePage();
}

class _WeatherHomePage extends State<WeatherHomePage> {
  /// TODO: remove this mocked data after implementing the service
  final weatherInfoList = <WeatherInfo>[
    WeatherInfo(
      city: 'Paris',
      condition: 'light rain',
      icon: '10d',
      temperatureInCelcius: 30,
      humidity: 50,
    ),
    WeatherInfo(
      city: 'Milan',
      condition: 'dizzle',
      icon: '09d',
      temperatureInCelcius: 32,
      humidity: 60,
    ),
    WeatherInfo(
      city: 'Lucene',
      condition: 'Thunderstorm',
      icon: '11d',
      temperatureInCelcius: 33,
      humidity: 66,
    ),
  ];

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

  Widget _pageBody() => Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: weatherInfoList
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

  void _openAddDialog() async {
    final selectedCity = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => CityLookupPage(),
        fullscreenDialog: true,
      ),
    );

    if (selectedCity != null) {
      print('Selected city: $selectedCity');
      // TODO: add a new weather card for it
    }
  }
}
