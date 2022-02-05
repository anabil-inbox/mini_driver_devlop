import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/screens/visit_tasks/widget/visit_lv_item_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/icon_btn.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/date/date_time_util.dart';
import 'package:inbox_driver/util/string.dart';

import 'Widgets/chart_widget.dart';
import 'Widgets/wh_loading_card.dart';

class WHCurrentScreen extends StatelessWidget {
  const WHCurrentScreen({Key? key, required this.task, required this.i})
      : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  final TaskModel task;
  final int i;

  Widget get lvSalesOrder {
    if (GetUtils.isNull(homeViewModel.operationsSalesData)) {
      return const SizedBox();
    } else {
      return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: homeViewModel.operationsSalesData!.salesOrders?.length,
          itemBuilder: (context, index) {
            if (task.taskName!
                    .toLowerCase()
                    .contains(Constance.taskWarehouseLoading.toLowerCase()) ||
                task.taskName!
                    .toLowerCase()
                    .contains(Constance.taskWarehouseClosure.toLowerCase())) {
              return WhLoadingCard(
                task: task,
                index: i,
                salesData: homeViewModel.operationsSalesData!,
                salesOrder:
                    homeViewModel.operationsSalesData!.salesOrders![index],
                onRecivedClick: i == 0
                    ? () async {
                        if (task.taskName!.toLowerCase().contains(
                            Constance.taskWarehouseLoading.toLowerCase())) {
                          await homeViewModel.recivedBoxes(
                              serial: homeViewModel.operationsSalesData!
                                      .salesOrders![index].orderId ??
                                  "",
                              taskName: Constance.taskWarehouseLoading);
                        } else {
                          await homeViewModel.recivedBoxes(
                              serial: homeViewModel.operationsSalesData!
                                      .salesOrders![index].orderId ??
                                  "",
                              taskName: Constance.taskWarehouseClosure);
                        }
                      }
                    : () {
                        snackError(txtError!.tr, txtPreviousTask.tr);
                      },
              );
            } else if (task.taskName!
                .toLowerCase()
                .contains(Constance.taskCustomerVisit.toLowerCase())) {
              return VisitLvItemWidget(
                task: task,
                index: i,
                salesData: homeViewModel.operationsSalesData!,
                salesOrder:
                    homeViewModel.operationsSalesData!.salesOrders![index],
                isBlockContainer: index == 0 ? false : true,
              );
            } else {
              return const Text("Else Case");
            }
          });
    }
  }

  Widget get flowChart {
    if (GetUtils.isNull(homeViewModel.operationsSalesData) ||
        task.taskName!
            .toLowerCase()
            .contains(Constance.taskCustomerVisit.toLowerCase())) {
      return const SizedBox();
    } else {
      double greenValue = 0;
      double redValue = 0;
      if ((homeViewModel.operationsSalesData?.totalReceived == 0 &&
              homeViewModel.operationsSalesData?.totalBoxes == 0) ||
          (homeViewModel.operationsSalesData?.totalReceived ==
              homeViewModel.operationsSalesData?.totalBoxes)) {
        greenValue = 100;
        redValue = 0;
      } else {
        greenValue = ((homeViewModel.operationsSalesData?.totalReceived ?? 1) /
            (homeViewModel.operationsSalesData?.totalBoxes ?? 1));
        //[(New Price - Old Price)/Old Price] x 100
        // redValue = 50;
        // greenValue = ((homeViewModel.operationsSalesData?.totalReceived ?? 1) -
        //         (homeViewModel.operationsSalesData?.totalBoxes ?? 1)) *
        //     100;

        num i = (homeViewModel.operationsSalesData?.totalBoxes ?? 1) -
            (homeViewModel.operationsSalesData?.totalReceived ?? 1);
        redValue = double.parse(i.toString());

        greenValue = double.parse(
            homeViewModel.operationsSalesData!.totalReceived.toString());
      }

      return ChartWidget(
        firstGreenValue: greenValue,
        firstRedValue: redValue,
        firstTitle:
            "${homeViewModel.operationsSalesData?.totalReceived ?? 0} / ${homeViewModel.operationsSalesData?.totalBoxes ?? 0} \nBoxes",
        secondGreenValue: 30,
        isHaveItems: false,
        secondRedValue: 100,
        secondTitle: "4/5 \nOthers",
        mainTitle: DateUtility.getChatTime(
            homeViewModel.operationsSalesData!.lastUpdate.toString()),
      );
    }
  }

  // Widget get searchBar => WhSearchBar(
  //       textEditingController: homeViewModel.tdSearchWhLoading,
  //       onChange: homeViewModel.tdSearchWhLoading.text.isNotEmpty
  //           ? () {
  // homeViewModel.search(
  //     searchedText: homeViewModel.tdSearchWhLoading.text,
  //     taskId: task.id ?? "");
  //             }
  //           : () {},
  //       isHaveScan: !(task.taskName!
  //           .toLowerCase()
  //           .contains(Constance.taskCustomerVisit.toLowerCase())),
  //     );

  // Widget get chart => WhLoadingChart();
  
  
  Widget get searchWidget => Row(
        children: [
          !(task.taskName!
                  .toLowerCase()
                  .contains(Constance.taskCustomerVisit.toLowerCase()))
              ? IconBtn(
                  iconColor: colorTextWhite,
                  width: sizeW48,
                  height: sizeH48,
                  backgroundColor: colorRed,
                  onPressed: () {
                    Get.to(() => const ScanScreen());
                  },
                  borderColor: colorTrans,
                  icon: "assets/svgs/Scan.svg",
                )
              : const SizedBox(),
          !(task.taskName!
                  .toLowerCase()
                  .contains(Constance.taskCustomerVisit.toLowerCase()))
              ? SizedBox(
                  width: sizeW10,
                )
              : const SizedBox(),
          Expanded(
            child: CustomTextFormFiled(
              iconSize: sizeRadius20,
              controller: homeViewModel.tdSearchWhLoading,
              maxLine: Constance.maxLineOne,
              icon: Icons.search,
              iconColor: colorHint2,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
              onSubmitted: (_) {},
              onChange: (value) {
                homeViewModel.search(
                    searchedText: homeViewModel.tdSearchWhLoading.text,
                    taskId: task.id ?? "");
              },
              isSmallPadding: false,
              isSmallPaddingWidth: true,
              fillColor: colorBackground,
              isFill: true,
              isBorder: true,
              label: "Search here ...",
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      child: ListView(
        padding: EdgeInsets.all(padding0!),
        primary: true,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: sizeH10,
          ),
          searchWidget,
          flowChart,
          lvSalesOrder
        ],
      ),
    );
  }
}
