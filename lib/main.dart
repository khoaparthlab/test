import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:home_module/home_module.dart';
import 'package:main_app/device_id_manager.dart';
import 'package:main_app/global_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final _storage = const FlutterSecureStorage();
  final _accountNameController =
      TextEditingController(text: 'flutter_secure_storage_service');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    bool jailbroken;
    bool developerMode;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;
      log('jailbroken: $jailbroken');
      log('developerMode: $developerMode');
    } on PlatformException {
      jailbroken = true;
      developerMode = true;
      log('jailbroken: $jailbroken');
      log('developerMode: $developerMode');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  @override
  Widget build(BuildContext context) {
    int one = Calculator().addOne(1);
    return ChangeNotifierProvider(
      create: (context) => GlobalState(),
      child: MaterialApp(
        title: GlobalState().sharedData,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AreaWidget(),
      ),
    );
  }
}

class AreaWidget extends StatefulWidget {
  const AreaWidget({
    super.key,
  });

  @override
  State<AreaWidget> createState() => _AreaWidgetState();
}

class _AreaWidgetState extends State<AreaWidget> {
  bool isSameDevice = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      isSameDevice = await getDeviceIdManager().checkDeviceId();
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getDeviceId();
  }

  void _getDeviceId() async {
    String deviceId = await getDeviceIdManager().getDeviceId();
    log(deviceId);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    log('webBrowserInfo: ${webBrowserInfo.platform?.runes.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    log('isSameDeviceMain3 ${isSameDevice.toString()}');

    return isSameDevice
        ? Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isSameDevice = true;
                    });
                  },
                  child: Text('press')),
              AreaChart(dataPoint: [data, data2, data3, data4]),
            ],
          )
        : SizedBox();
  }
}

enum _Actions { deleteAll, isProtectedDataAvailable }

enum _ItemActions { delete, edit, containsKey, read }

List<ChartData> data = [
  ChartData(DateTime(1964, 1, 1), 81),
  ChartData(DateTime(1965, 1, 1), 83),
  ChartData(DateTime(1966, 1, 1), 79),
  ChartData(DateTime(1967, 1, 1), 78),
  ChartData(DateTime(1968, 1, 1), 77),
  ChartData(DateTime(1969, 1, 1), 75),
  ChartData(DateTime(1970, 1, 1), 74),
];
List<ChartData> data2 = [
  ChartData(DateTime(1964, 1, 1), 70),
  ChartData(DateTime(1965, 1, 1), 90),
  ChartData(DateTime(1966, 1, 1), 30),
  ChartData(DateTime(1967, 1, 1), 70),
  ChartData(DateTime(1968, 1, 1), 40),
  ChartData(DateTime(1969, 1, 1), 60),
  ChartData(DateTime(1970, 1, 1), 80),
];
List<ChartData> data3 = [
  ChartData(DateTime(1964, 2, 1), 80),
  ChartData(DateTime(1965, 1, 1), 60),
  ChartData(DateTime(1966, 1, 1), 80),
  ChartData(DateTime(1967, 1, 1), 90),
  ChartData(DateTime(1968, 1, 1), 50),
  ChartData(DateTime(1969, 1, 1), 70),
  ChartData(DateTime(1970, 1, 1), 75),
];

List<ChartData> data4 = [
  ChartData(DateTime(1964, 2, 1), 50),
  ChartData(DateTime(1965, 1, 1), 30),
  ChartData(DateTime(1966, 1, 1), 20),
  ChartData(DateTime(1967, 1, 1), 30),
  ChartData(DateTime(1968, 1, 1), 40),
  ChartData(DateTime(1969, 1, 1), 60),
  ChartData(DateTime(1970, 1, 1), 75),
];
