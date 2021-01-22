class LocationData {
  String country;
  String state;
  String city;

  LocationData({this.country, this.state, this.city});

  @override
  String toString() => '$city, $state, $country';
}
