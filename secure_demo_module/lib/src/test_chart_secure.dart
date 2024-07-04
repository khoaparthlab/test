import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:home_module/home_module.dart';
import 'package:home_module/src/factory_manager/device_id_manager.dart';
import 'package:main_app/main.dart';

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
  }

  @override
  Widget build(BuildContext context) {
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
