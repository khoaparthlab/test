import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:main_app/device_manager_abstract.dart';
import 'package:main_app/utils/setting_storage_platform/setting_storage_plaltform.dart';

class DeviceIdManager implements DeviceIdManagerInterface {
  static const String _deviceIdKey = 'device_id';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    return androidInfo.id.toString();
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
    String deviceId = await getDeviceId();
    final listAll = await _storage.readAll(
      iOptions: PlatformOptions().getIOSOptions(),
      aOptions: PlatformOptions().getAndroidOptions(),
      webOptions: PlatformOptions().getWebOptions(),
    );
    if (listAll.isNotEmpty) {
      final isSameDevice = listAll.containsValue(deviceId);
      log('isSameDevice: $isSameDevice');
      if (isSameDevice) return true;
      return false;
    }
    _addNewItem(deviceId);
    return false;
  }
}
