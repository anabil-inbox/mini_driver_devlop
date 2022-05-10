import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/core/loading_circle.dart';
import 'package:inbox_driver/feature/view/screens/profile/report/widget/big_chart_widget.dart';
import 'package:inbox_driver/feature/view/screens/profile/report/widget/report_chart.dart';
import 'package:inbox_driver/feature/view/screens/profile/report/widget/status_compleated_task_widget.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view_model/profile_view_modle/profile_view_modle.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../util/app_color.dart';
import '../../../../../util/app_style.dart';
import '../../../widgets/custome_text_view.dart';

// ignore: must_be_immutable
class ReportView extends StatelessWidget {
  ReportView({Key? key}) : super(key: key);

  var firstRedValue = 10.0;

  var firstGreenValue = 10.0;

  Widget headerChartTotalAVG(ProfileViewModle logic) {
    return Container(
      decoration: BoxDecoration(
          color: colorTextWhite,
          boxShadow: [boxShadowLight()!],
          borderRadius: BorderRadius.circular(sizeRadius10!)),
      padding: EdgeInsets.symmetric(horizontal: sizeW12!, vertical: sizeH22!),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Column(
            children: [
              CustomTextView(
                txt: "${logic.driverReportData?.doneTasks??0}/${logic.driverReportData?.totalTasks??0}",
                textAlign: TextAlign.center,
                textStyle: textStyleAppbar()!.copyWith(
                    fontWeight: FontWeight.normal, fontSize: fontSize16),
                textOverflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: sizeW15,
              ),
              CustomTextView(
                txt: txtCompletedTask.tr,
                textAlign: TextAlign.center,
                textStyle: textStyleAppbar()!.copyWith(
                    fontSize: fontSize12, fontWeight: FontWeight.normal),
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const Spacer(),
          Expanded(
            child: ReportChartWidget(
              pieCharts: [
                PieChartSectionData(
                    radius: padding6,
                    color: colorRed,
                    value: double.tryParse("${logic.driverReportData?.totalTasks??0.0}")?.toDouble() == 0.0 ? 100:double.tryParse("${logic.driverReportData?.totalTasks??0.0}")?.toDouble(),
                    showTitle: false),
                PieChartSectionData(
                    radius: padding6,
                    color: colorGreen,
                    value: double.tryParse(getUnCompleteTaskCount(logic))?.toDouble(),
                    showTitle: false),
              ],
              title: "${calcPercent(logic)}%",
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget textHintsWidget(text, color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.circle,
          size: sizeRadius16,
          color: color ?? colorYellowLightChart,
        ),
        SizedBox(
          width: sizeW4,
        ),
        CustomTextView(
          txt: text ?? "",
          maxLine: Constance.maxLineOne,
          textStyle: textStyleNormal()?.copyWith(fontSize: 8),
          textOverflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          width: sizeW10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          txtReport.tr,
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: GetBuilder<ProfileViewModle>(
          init: ProfileViewModle(),
          initState: (state) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              state.controller?.getDriverReport();
            });
          },
          builder: (logic) {
            if (logic.isLoading) {
              return const LoadingCircle();
            } else {
              return ListView(
                shrinkWrap: true,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(
                    top: sizeH22!, left: sizeW15!, right: sizeW15!),
                children: [
                  headerChartTotalAVG(logic),
                  SizedBox(
                    height: sizeH16!,
                  ),
                  Row(
                    children: [
                       Expanded(
                          child: StatusCompletedTaskWidget(
                        taskCount: logic.driverReportData?.doneTasks.toString() ??"0",
                        isTodo: true,
                      )),
                      SizedBox(
                        width: sizeH16!,
                      ),
                       Expanded(
                          child: StatusCompletedTaskWidget(
                        taskCount: logic.driverReportData?.inProgressTasks.toString() ??"0",
                        isTodo: false,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: sizeH16!,
                  ),
                  CustomTextView(
                    txt: txtAverageTimeCompleteTask.tr,
                    textAlign: TextAlign.center,
                    textStyle: textStyleAppbar()!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize16,
                    ),
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: sizeH16!,
                  ),
                   BigChartWidget(logic: logic,),
                  SizedBox(
                    height: sizeH16!,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textHintsWidget(txtYourTime.tr, colorYellowLightChart),
                      textHintsWidget(
                          txtOtherDriverTime.tr, colorBlueLightChart),
                    ],
                  ),
                ],
              );
            }
          }),
    );
  }

  String getUnCompleteTaskCount(ProfileViewModle logic) {//complete
    if(logic.driverReportData?.doneTasks != null && logic.driverReportData?.totalTasks != null){
      return "${logic.driverReportData?.doneTasks - logic.driverReportData?.totalTasks}";
    }else{
      return "0.0";
    }
  }

  String calcPercent(ProfileViewModle logic) {
    if(logic.driverReportData?.doneTasks != null && logic.driverReportData?.totalTasks != null){
      Logger().e(logic.driverReportData?.doneTasks);
      Logger().e(logic.driverReportData?.totalTasks);
      var resultDiv = logic.driverReportData?.doneTasks / logic.driverReportData?.totalTasks;
     var per = ((resultDiv ?? 0) * 100)??0;
     if(per.toString().toLowerCase() == "NaN".toLowerCase()){
       return "0.0";
     }else {
       return "${per??0}";
     }
    }else{
      return "0.0";
    }
  }

}
