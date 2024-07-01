abstract class DeviceIdManagerInterface {
  Future<String> getDeviceId();

  Future<bool> checkDeviceId();
}
