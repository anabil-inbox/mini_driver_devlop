import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/Widgets/wh_loading_chart.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';

import '../../../../../../util/app_shaerd_data.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget(
      {Key? key,
      required this.firstGreenValue,
      required this.firstRedValue,
      required this.firstTitle,
      required this.secondGreenValue,
      required this.secondRedValue,
      required this.secondTitle,
      required this.mainTitle,
      required this.isHaveItems
      })
      : super(key: key);

  final double firstRedValue;
  final double secondRedValue;
  final double firstGreenValue;
  final double secondGreenValue;
  final String firstTitle;
  final String secondTitle;
  final String mainTitle;
  final bool isHaveItems;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: padding16!),
      decoration: boxDecorationWghitBorderRaduis6(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Expanded(
                  child: WhLoadingChart(
                pieCharts: [
                  PieChartSectionData(
                      radius: padding6,
                      color: colorRed,
                      value: firstRedValue,
                      showTitle: false),
                  PieChartSectionData(
                      radius: padding6,
                      color: colorGreen,
                      value: firstGreenValue,
                      showTitle: false),
                ],
                title: firstTitle,
              )),
              SizedBox(
                width: sizeW15,
              ),
              isHaveItems
                  ? Expanded(
                      child: WhLoadingChart(
                      pieCharts: [
                        PieChartSectionData(
                            radius: padding6,
                            color: colorRed,
                            value: secondRedValue,
                            showTitle: false),
                        PieChartSectionData(
                            radius: padding6,
                            color: colorGreen,
                            value: secondGreenValue,
                            showTitle: false),
                      ],
                      title: secondTitle,
                    ))
                  : const SizedBox(),
              const Spacer(),
            ],
          ),
          SizedBox(
            height: sizeH12,
          ),
          Text(mainTitle)
        ],
      ),
    );
  }
}
