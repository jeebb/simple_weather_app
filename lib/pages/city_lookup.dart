import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';

class CityLookupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CityLookupPageState();
}

class _CityLookupPageState extends State<CityLookupPage> {
  String _selectedCity;

  var _selectKey = UniqueKey();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Select the city'),
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              SelectState(
                // add a key for resetting the values when tapping on 'Reset'
                key: _selectKey,
                onCountryChanged: (_) => _selectedCity = null,
                onStateChanged: (_) => _selectedCity = null,
                onCityChanged: (city) => setState(() {
                  _selectedCity = city;
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RaisedButton(
                      child: Text('Add'),
                      onPressed: _selectedCity != null &&
                              _selectedCity != 'Choose City'
                          ? _onAddingCity
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RaisedButton(
                      child: Text('Reset'),
                      onPressed: () => setState(() {
                        _selectKey = UniqueKey();
                        _selectedCity = null;
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  void _onAddingCity() => Navigator.pop(context, _selectedCity);
}
