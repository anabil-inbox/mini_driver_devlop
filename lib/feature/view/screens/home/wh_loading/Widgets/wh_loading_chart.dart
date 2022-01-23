import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inbox_driver/util/app_color.dart';

class WhLoadingChart extends StatelessWidget {
  List<PieChartSectionData> Fakedata = [
    PieChartSectionData(color: colorRed),
    PieChartSectionData(color: colorGreen),
  ];

  @override
  Widget build(BuildContext context) {
    return PieChart(PieChartData(sections: Fakedata));
  }
}
