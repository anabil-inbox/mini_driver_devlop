import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';

class WhLoadingChart extends StatelessWidget {
  const WhLoadingChart({Key? key, required this.pieCharts , required this.title}) : super(key: key);

  final List<PieChartSectionData> pieCharts;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeH80,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
                centerSpaceColor: colorTrans,
                borderData: FlBorderData(
                    show: false, border: Border.all(color: colorBackground)),
                sections: pieCharts),
          ),
          Positioned(
              top: (sizeH80! / 2) - padding16!,
              right: 0,
              left: 0,
              bottom: 0,
              child: Text(
                title,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
