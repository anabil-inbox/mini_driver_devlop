import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';

class WhLoadingChart extends StatelessWidget {
  List<PieChartSectionData> Fakedata = [
    PieChartSectionData(
      color: colorRed,
      value: 10,
      radius: 10,
      showTitle: false,
    ),
    PieChartSectionData(
      color: colorGreen,
      value: 10,
      radius: 10,
      showTitle: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
              color: colorTextWhite,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: sizeW70!,
                      right: sizeW70!,
                      top: sizeH65!,
                      bottom: sizeH20!),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: sizeW20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox.shrink(
                            child: PieChart(PieChartData(
                              centerSpaceRadius: 45,
                              startDegreeOffset: 15,
                              sections: Fakedata,
                            )),
                          ),
                          CustomTextView(
                            txt: '12/15 ',
                            textStyle: textStyleNormal(),
                          ),
                          CustomTextView(
                            txt: txtBoxes!.tr,
                            textStyle: textStyleNormal(),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox.shrink(
                            child: PieChart(PieChartData(
                              centerSpaceRadius: 45,
                              startDegreeOffset: 15,
                              sections: Fakedata,
                            )),
                          ),
                          SizedBox(
                            child: CustomTextView(
                              txt: '12/15 \n ${txtOther!.tr}',
                              textStyle: textStyleNormal(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: sizeW20),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
