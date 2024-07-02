import 'dart:convert';
import 'dart:developer';
import 'dart:html'
    if (dart.library.io) 'dart:io'
    if (dart.library.html) 'dart:html';
import 'package:http/http.dart' as http;

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
      try {
        final response =
            await http.get(Uri.parse('https://api.ipify.org?format=json'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          deviceId = data['ip'];
        } else {
          throw Exception('Failed to get IP address');
        }
      } catch (e) {
        log(e.toString());
      }
      window.localStorage[_deviceIdKey] = deviceId ?? '';
      _addNewItem(deviceId ?? '');
    }

    return deviceId ?? '';
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
    String? deviceId = '';
    String? ipStorage = window.localStorage[_deviceIdKey];
    final response =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      deviceId = data['ip'];
    }
    if (ipStorage != null) {
      final listAll = await _storage.readAll(
        iOptions: PlatformOptions().getIOSOptions(),
        aOptions: PlatformOptions().getAndroidOptions(),
        webOptions: PlatformOptions().getWebOptions(),
      );
      final isSameDevice = listAll.containsValue(deviceId);
      log('isSameDevice: $isSameDevice');
      if (isSameDevice) return true;
      return false;
    } else {
      window.localStorage[_deviceIdKey] = deviceId ?? 'none';
    }
    return false;
  }
}
