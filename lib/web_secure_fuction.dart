import 'dart:developer';
import 'dart:html'
    if (dart.library.io) 'dart:io'
    if (dart.library.html) 'dart:html';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:main_app/device_manager_abstract.dart';
import 'package:main_app/utils/setting_storage_platform/setting_storage_plaltform.dart';
import 'package:uuid/uuid.dart'; // Import dart:html to use localStorage

class DeviceIdManager implements DeviceIdManagerInterface {
  static const String _deviceIdKey = 'device_id';
  static final DeviceIdManager _instance = DeviceIdManager._internal();
  final _storage = const FlutterSecureStorage();

  DeviceIdManager._internal();

  factory DeviceIdManager() {
    return _instance;
  }

  @override
  Future<String> getDeviceId() async {
    String? deviceId = window.localStorage[_deviceIdKey];
    if (deviceId == null) {
      var uuid = const Uuid();
      deviceId = uuid.v4();
      window.localStorage[_deviceIdKey] = deviceId;
      _addNewItem(deviceId);
    }

    return deviceId;
  }

  Future<void> _addNewItem(String deviceId) async {
    const String key = 'deviceId';
    final String value = deviceId;

    await _storage.write(
      key: key,
      value: value,
      iOptions: PlatformOptions().getIOSOptions(),
      aOptions: PlatformOptions().getAndroidOptions(),
      webOptions: PlatformOptions().getWebOptions(),
    );
  }

  @override
  Future<bool> checkDeviceId() async {
    String? deviceId = window.localStorage[_deviceIdKey];
    if (deviceId != null) {
      final listAll = await _storage.readAll(
        iOptions: PlatformOptions().getIOSOptions(),
        aOptions: PlatformOptions().getAndroidOptions(),
        webOptions: PlatformOptions().getWebOptions(),
      );
      log('deviceId: $deviceId');
      final isSameDevice = listAll.containsValue(deviceId);
      log('isSameDevice: $isSameDevice');
      if (isSameDevice) return true;
      return false;
    }
    return false;
  }
}
