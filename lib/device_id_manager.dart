import 'package:main_app/device_manager_abstract.dart';
import 'web_secure_fuction.dart'
    if (dart.library.html) 'web_secure_fuction.dart'
    if (dart.library.io) 'mobile_secure_function.dart';

DeviceIdManagerInterface getDeviceIdManager() => DeviceIdManager();
