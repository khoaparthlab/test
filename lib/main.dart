import 'dart:developer';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:home_module/home_module.dart';
import 'package:main_app/global_state.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';
import 'package:provider/provider.dart';

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
  bool? _jailbroken;
  bool? _developerMode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceIde();
    initPlatformState();
  }

  Future getDeviceIde() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    log(deviceId ?? '');
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
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
    if (!mounted) return;

    setState(() {
      _jailbroken = jailbroken;
      _developerMode = developerMode;
    });
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
        home: AreaChart(dataPoint: [data, data2, data3, data4]),
      ),
    );
  }

  SizedBox _renderSecond() {
    log('_renderSecond');
    return const SizedBox();
  }

  Column _renderText(String globalState, int one) {
    log('_renderText');
    return Column(
      children: [
        Text(globalState),
        HomePage(
          child: Text(one.toString()),
        ),
      ],
    );
  }
}

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
