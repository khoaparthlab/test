import 'dart:developer';

import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  String _sharedData = 'Initial Data';
  String _second = 'second';
  bool _isSameDevice = false;

  String get sharedData => _sharedData;
  String get seconddata => _second;
  bool get isSameDevice => _isSameDevice;

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

  void updateIsSameData(bool newData) {
    _isSameDevice = newData;
    log(_isSameDevice.toString());
    notifyListeners();
  }
}
