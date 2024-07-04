import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PlatformOptions {
  IOSOptions getIOSOptions() => IOSOptions();

  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      );

  WebOptions getWebOptions() =>
      const WebOptions(dbName: 'idKey', publicKey: '');
}
