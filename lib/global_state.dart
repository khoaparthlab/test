import 'dart:developer';

import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  String _sharedData = 'Initial Data';
  String _second = 'second';

  String get sharedData => _sharedData;
  String get seconddata => _second;

  void updateData(String newData) {
    _sharedData = newData;
    log(newData);
    notifyListeners();
  }

  void setSecondUpdateData(String newData) {
    _second = newData;
    log(newData);
    notifyListeners();
  }
}
