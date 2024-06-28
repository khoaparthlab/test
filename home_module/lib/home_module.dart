library home_module;

import 'dart:math';

export './src/homepage.dart';
export './src/area_chart.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class ChartData {
  ChartData(this.year, this.value);

  final DateTime year;
  final double value;
}

List<ChartData> newCustomFunction(
  int itemCout,
  int startYear,
  int endYear,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  final random = Random();
  List<ChartData> data = [];

  for (int i = 0; i < itemCout; i++) {
    int year = startYear + random.nextInt(endYear - startYear + 1);
    int month = 1 + random.nextInt(12);
    int day = 1 +
        random.nextInt(
            28); // To avoid issues with months having fewer than 31 days
    DateTime date = DateTime(year, month, day);
    double value = random.nextDouble() *
        100; // Generates a random double between 0 and 100

    data.add(ChartData(date, value));
  }

  return data;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
