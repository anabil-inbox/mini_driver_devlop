import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/core/loading_circle.dart';
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
import 'package:inbox_driver/util/string.dart';

import 'Widgets/chart_widget.dart';
import 'Widgets/wh_loading_card.dart';

class WHCurrentScreen extends StatelessWidget {
  const WHCurrentScreen({Key? key, required this.task, required this.i})
      : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  final TaskModel task;
  final int i;

  Widget lvSalesOrder({required HomeViewModel home}) {
    if (GetUtils.isNull(homeViewModel.operationsSalesData) ||
        GetUtils.isNull(homeViewModel.operationsSalesData!.salesOrders)) {
      return const SizedBox();
    } else {
      return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: homeViewModel.operationsSalesData!.salesOrders?.length,
          itemBuilder: (context, index) {
            if (home.isTaskWarwhouseLoadingOrClousre(task: task)) {
              return WhLoadingCard(
                isFromCompelted: true,
                task: task,
                index: i,
                salesData: home.operationsSalesData!,
                salesOrder: home.operationsSalesData!.salesOrders![index],
                onRecivedClick: i == 0
                    ? () async {
                        if (homeViewModel.isTaskWareHouseLoading(task: task)) {
                          await homeViewModel.recivedBoxes(
                              serial: homeViewModel.operationsSalesData!
                                      .salesOrders![index].orderId ??
                                  "",
                              taskName: Constance.taskWarehouseLoading);
                        } else if (homeViewModel.isTaskWorahouseClousre(
                            task: task)) {
                          await homeViewModel.recivedBoxes(
                              serial: homeViewModel.operationsSalesData!
                                      .salesOrders![index].orderId ??
                                  "",
                              taskName: Constance.taskWarehouseClosure);
                        } else {}
                        await homeViewModel.getSpecificTask(
                            taskId: task.id ?? "",
                            taskSatus: Constance.inProgress);
                      }
                    : () {
                        snackError(txtError!.tr, txtPreviousTask.tr);
                      },
              );
            } else if (home.isTaskCustomerVist(task: task)) {
              return VisitLvItemWidget(
                isFromCompleted: false,
                task: task,
                index: i,
                salesData: homeViewModel.operationsSalesData!,
                salesOrder:
                    homeViewModel.operationsSalesData!.salesOrders![index],
                isBlockContainer: index == 0 ? false : true,
              );
            } else {
              return WhLoadingCard(
                isFromCompelted: false,
                task: task,
                index: i,
                salesData: home.operationsSalesData!,
                salesOrder: home.operationsSalesData!.salesOrders![index],
                onRecivedClick: () {
                  
                },
              );
            }
          });
    }
  }

  Widget flowChart({required HomeViewModel homeViewModel}) {
    if (GetUtils.isNull(homeViewModel.operationsSalesData) ||
        task.taskName!
            .toLowerCase()
            .contains(Constance.taskCustomerVisit.toLowerCase()) ||
        GetUtils.isNull(homeViewModel.operationsSalesData?.taskName)) {
      return const SizedBox();
    } else {
      double greenValue = 0;
      double redValue = 0;
      if ((homeViewModel.operationsSalesData?.totalReceived == 0 &&
          homeViewModel.operationsSalesData?.totalBoxes == 0)) {
        return const SizedBox();
      } else if ((homeViewModel.operationsSalesData?.totalReceived == 0 &&
              homeViewModel.operationsSalesData?.totalBoxes == 0) ||
          (homeViewModel.operationsSalesData?.totalReceived ==
              homeViewModel.operationsSalesData?.totalBoxes)) {
        greenValue = 100;
        redValue = 0;
      } else if ((homeViewModel.operationsSalesData!.totalReceived! > 0 &&
          homeViewModel.operationsSalesData?.totalBoxes == 0)) {
        greenValue = 100;
        redValue = 0;
      } else {
        greenValue = ((homeViewModel.operationsSalesData?.totalReceived ?? 1) /
            (homeViewModel.operationsSalesData?.totalBoxes ?? 1));
        num i = (homeViewModel.operationsSalesData?.totalBoxes ?? 1) -
            (homeViewModel.operationsSalesData?.totalReceived ?? 1);
        redValue = double.parse(i.toString());
        greenValue = double.parse(
            homeViewModel.operationsSalesData!.totalReceived.toString());
      }

      return GetBuilder<HomeViewModel>(
        builder: (_) {
          var d = homeViewModel.operationsSalesData?.totalBoxes;
          d = (homeViewModel.operationsSalesData?.totalBoxes == 0)
              ? homeViewModel.operationsSalesData?.totalReceived
              : homeViewModel.operationsSalesData?.totalBoxes;
          return ChartWidget(
            firstGreenValue: greenValue,
            firstRedValue: redValue,
            firstTitle:
                "${homeViewModel.operationsSalesData?.totalReceived ?? 0} / ${d ?? 0} \nBoxes",
            secondGreenValue: 30,
            isHaveItems: false,
            secondRedValue: 100,
            secondTitle: "4/5 \nOthers",
            mainTitle: "",
          );
        },
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
                    Get.to(() => ScanScreen(
                          taskModel: task,
                          isFromScanSalesBoxs: false,
                          isProductScan: false,
                          isScanDeliverdBoxes: false,
                        ));
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
      child: GetBuilder<HomeViewModel>(
        initState: (_) async {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
            await homeViewModel.getSpecificTask(
                taskId: task.id ?? "", taskSatus: Constance.inProgress);
          });
        },
        builder: (build) {
          if (build.isLoading) {
            return const LoadingCircle();
          } else {
            return ListView(
              padding: EdgeInsets.all(padding0!),
              primary: true,
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: sizeH10,
                ),
                searchWidget,
                SizedBox(
                  height: sizeH10,
                ),
                GetBuilder<HomeViewModel>(builder: (build) {
                  return flowChart(homeViewModel: build);
                }),
                GetBuilder<HomeViewModel>(builder: (homeBuilder) {
                  return lvSalesOrder(home: homeBuilder);
                })
              ],
            );
          }
        },
      ),
    );
  }
}
