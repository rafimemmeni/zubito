import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  String _location;

  LocationProvider(this._location);

  getLocation() => _location;

  setLocation(String location) async {
    _location = location;
    notifyListeners();
  }
}
