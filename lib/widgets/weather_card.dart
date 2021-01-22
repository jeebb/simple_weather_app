import 'package:flutter/material.dart';
import 'package:simple_weather_app/models/weather_info.dart';

class WeatherCard extends StatefulWidget {
  final WeatherInfo weatherInfo;

  WeatherCard({this.weatherInfo});

  @override
  State<StatefulWidget> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.network(widget.weatherInfo.iconUrl),
        title: Text(
          widget.weatherInfo.city,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.weatherInfo.description),
      );
}
