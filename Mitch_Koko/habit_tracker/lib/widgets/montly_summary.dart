import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/datetime/date_time.dart';

class MontlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;
  const MontlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.opacity,
        showText: false,
        scrollable: true,
        colorsets: {
          1: Colors.red,
          3: Colors.orange,
          5: Colors.yellow,
          7: Colors.green,
          9: Colors.blue,
          11: Colors.indigo,
          13: Colors.purple,
        },
        onClick: (value) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
