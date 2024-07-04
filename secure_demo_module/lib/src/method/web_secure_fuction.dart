import 'dart:convert';
import 'dart:developer';
import 'dart:html'
    if (dart.library.io) 'dart:io'
    if (dart.library.html) 'dart:html';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_module/src/factory/device_manager_abstract.dart';
import 'package:home_module/utils/setting_storage_platform/setting_storage_plaltform.dart';
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

    return deviceId ?? '';
  }

  Future<void> _addNewItem(String deviceId, String token) async {
    await _storage.write(
      key: deviceId,
      value: token,
      iOptions: PlatformOptions().getIOSOptions(),
      aOptions: PlatformOptions().getAndroidOptions(),
      webOptions: PlatformOptions().getWebOptions(),
    );
  }

  @override
  Future<bool> checkDeviceId() async {
    String deviceId = '';
    final response =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      deviceId = data['ip'];
    }

    final listAll = await _storage.readAll(
      iOptions: PlatformOptions().getIOSOptions(),
      aOptions: PlatformOptions().getAndroidOptions(),
      webOptions: PlatformOptions().getWebOptions(),
    );
    final isSameDevice = listAll.containsKey(deviceId);
    log('isSameDevice: $isSameDevice');
    // Example JWT token
    String token =
        'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjAxNDg5ODYsImlhdCI6MTcyMDA2MjU4NiwiaXNzIjoidGVzdGluZ0BzZWN1cmUuaXN0aW8uaW8iLCJqdGkiOiI4NTViYTM4MC05ZTZlLTQ4YzItOTAxOC02YzZkY2I0NWM1OGYiLCJwZXJtaXNzaW9uIjoicnciLCJyb2xlIjoiU1lTVEVNLE1BTkFHRVIsT1JERVIiLCJzdWIiOiJ0ZXN0aW5nIiwidHlwZSI6MX0.hdIF8zopoXMw1IVGzBz_5gqLw0btKx5hQSrQaF1Sua-fpYeu8hj-Uml6I3nsBXL9vIXIzlEitroJuB5nk4CbJcjfCp9L92OLyGgAFcsoTlInZOTHscuxUiFOpjOc97RdLieuaZUpo4gjQixx_aySPrnTWbv5lJufXXziEY4-Cvfma_Qb1jnKqb4PEl0wRQl7r9VLFq96kBAtPq4T0yzOA58pKgP_NZQNfMLDO0FWer9cCgYcWuFsgQqT7AVpwGauYiZ99YLIxF7EUxHoTT--uNe6dIWCds70K1ZdyNiHHnp7OKW4smlko8hsh1EgGkgQkBkdq_Q0JSV57u1D6r-4ww';
    final jwt = JWT.decode(token);
    final exp = jwt.payload['exp'];
    log('$exp');
    final expDateTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    log(expDateTime.toString());
    if (isSameDevice) {
      log('storage ${await _storage.read(
            key: deviceId,
            iOptions: PlatformOptions().getIOSOptions(),
            aOptions: PlatformOptions().getAndroidOptions(),
            webOptions: PlatformOptions().getWebOptions(),
          ) ?? ''}');

      return true;
    }
    _storage.deleteAll();
    _addNewItem(deviceId, 'dsaofajdfoiajsfijof');
    return false;
  }
}
