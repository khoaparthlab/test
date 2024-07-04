import 'package:home_module/src/factory/device_manager_abstract.dart';
import 'package:home_module/src/method/web_secure_fuction.dart'
    if (dart.library.html) 'package:home_module/src/method/web_secure_fuction.dart'
    if (dart.library.io) 'package:home_module/src/method/mobile_secure_function.dart';

DeviceIdManagerInterface getDeviceIdManager() => DeviceIdManager();
