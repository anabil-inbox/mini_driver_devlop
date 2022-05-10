
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/date/date_time_util.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../../../../util/app_color.dart';

class BigChartWidget extends StatelessWidget {
  const BigChartWidget( {Key? key,required this.logic}) : super(key: key);
  final ProfileViewModle logic;
  final Duration animDuration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return chartBig();
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 60,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y:  y == 0 ? 0.6:y,
          borderRadius: BorderRadius.circular(10),
          width: width,
          colors:
              x == 0 ? [colorYellowLightChart] : [colorBlueLightChart],
        ),
      ],
      // showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(2, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0,double.tryParse("${logic.driverReportData?.averageForDriver??0.6}")!.toDouble(), isTouched: false); //this for my driver
          case 1:
            return makeGroupData(1, double.tryParse("${logic.driverReportData?.averageForOther??0.6}")!.toDouble(), isTouched: false); // this for all driver
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      backgroundColor: colorTextWhite,
      barTouchData: BarTouchData(
        enabled: false,
        allowTouchBarBackDraw: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: true , getTitles: (v){
          if(v == 0) {// 0 == my driver  || 1 == other driver
            if(logic.driverReportData?.averageForDriver == null || logic.driverReportData?.averageForDriver == 0.0) {
              return "";
            }else{
              Logger().d("averageForDriver:${logic.driverReportData?.averageForDriver}");

              var dateTime = DateTime.fromMillisecondsSinceEpoch(int.tryParse("${logic.driverReportData?.averageForDriver}")??0);
              // var format = DateFormat("yyyy-MM-dd hh:mm:ss").format(dateTime);
              // var chatTime = DateUtility.getChatTime(format);
              return handleDateTime(dateTime).toString();
            }
          }else{
            if(logic.driverReportData?.averageForOther == null || logic.driverReportData?.averageForOther == 0.0) {
              return "";
            }else{
              Logger().d("averageForOther:${logic.driverReportData?.averageForOther}");
              var dateTime = DateTime.fromMillisecondsSinceEpoch(int.tryParse("${logic.driverReportData?.averageForOther}")??0);
              // var format = DateFormat("yyyy-MM-dd hh:mm:ss").format(dateTime);
              // var chatTime = DateUtility.getChatTime(format);
              return handleDateTime(dateTime).toString();
            }
          }
        }),
        bottomTitles: SideTitles(
          showTitles: false,
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget chartBig() {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: colorTextWhite,
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String handleDateTime(DateTime dateTime) {
    if(dateTime.year == 1970 && dateTime.month == 1 && dateTime.day != 1){
      if(dateTime.hour != 0) {
        return "d  ${dateTime.day}, h  ${dateTime.hour}";
      }
      if(dateTime.hour != 0 && dateTime.minute != 0){
        return "d  ${dateTime.day}, h  ${dateTime.hour}, m  ${dateTime.minute}";
      }
      if(dateTime.hour != 0 && dateTime.minute != 0 && dateTime.second != 0){
        return "d  ${dateTime.day}, h  ${dateTime.hour}, m  ${dateTime.minute} , s ${dateTime.second}";
      }
    }else if(dateTime.year == 1970 && dateTime.month == 1 && dateTime.day == 1){
      if(dateTime.hour != 0) {
        return "h  ${dateTime.hour}";
      }
      if(dateTime.hour != 0 && dateTime.minute != 0){
        return "h  ${dateTime.hour}, m  ${dateTime.minute}";
      }
      if(dateTime.hour != 0 && dateTime.minute != 0 && dateTime.second != 0){
        return "d  ${dateTime.day}, h  ${dateTime.hour}, m  ${dateTime.minute} , s ${dateTime.second}";
      }
    }
    return "";
  }
}
