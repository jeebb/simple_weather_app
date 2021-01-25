import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_weather_app/pages/bloc/weather_bloc.dart';
import 'package:simple_weather_app/pages/home.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<int>('cities');

  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Weather',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (_) => WeatherBloc(),
          child: WeatherHomePage(),
        ),
      );
}
