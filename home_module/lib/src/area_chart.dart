import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:home_module/home_module.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:collection/collection.dart';

class AreaChart extends StatefulWidget {
  const AreaChart({
    super.key,
    required this.dataPoint,
  });
  final List<List<ChartData>> dataPoint;
  @override
  State<AreaChart> createState() => _AreaChartState();
}

class _AreaChartState extends State<AreaChart> {
  var listData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listData = [
      getRandomData(4, 2019, 2020),
      getRandomData(4, 2019, 2020),
      getRandomData(4, 2019, 2020)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.yMMM(),
        intervalType: DateTimeIntervalType.years,
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 100,
        interval: 20,
        axisLine: AxisLine(width: 0, color: Colors.transparent),
        majorGridLines: MajorGridLines(width: 0),
      ),
      legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      series: [
        ...widget.dataPoint.mapIndexed(
          (index, e) {
            return SplineSeries<ChartData, DateTime>(
              dataSource: e,
              xValueMapper: (ChartData sales, _) => sales.year,
              yValueMapper: (ChartData sales, _) => sales.value,
              color: getRandomColor(),
              name: 'Pod${index + 1}',
            );
          },
        ).toList()
      ],
    );
  }
}

Color getRandomColor() {
  final random = math.Random();
  return Color.fromARGB(
    255, // Alpha value (fully opaque)
    random.nextInt(256), // Red value
    random.nextInt(256), // Green value
    random.nextInt(256), // Blue value
  );
}

List<ChartData> getRandomData(
  int itemCount,
  int startYear,
  int endYear,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  final random = math.Random();
  print(random.nextInt(12));
  print(random.nextInt(28));

  List<ChartData> data = [];
  for (int i = 0; i < itemCount; i++) {
    int year = startYear + random.nextInt(endYear - startYear + 1);
    int month = 1 + random.nextInt(12);
    int day = 1 + random.nextInt(28);
    DateTime date = DateTime(year, month, day);
    double value =
        random.nextDouble() * 90; // Generates a random double between 0 and 100

    data.add(ChartData(date, value));
  }
  print(data.toList().toString());

  return data;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
