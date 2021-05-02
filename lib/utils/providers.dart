import 'package:flutter/material.dart';

class Providers extends ChangeNotifier {
  Map userdata = Map();

  setMap(Map data) {
    userdata = data;
    notifyListeners();
  }
}
