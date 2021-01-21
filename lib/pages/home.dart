import 'package:flutter/material.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherHomePage();
}

class _WeatherHomePage extends State<WeatherHomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.wb_sunny_rounded),
          title: Text('Mr. Weather'),
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          actions: [
            IconButton(icon: Icon(Icons.add), onPressed: () {}),
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(child: _pageBody()),
      );

  Widget _pageBody() => Container();
}
