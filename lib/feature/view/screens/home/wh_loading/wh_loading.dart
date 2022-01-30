import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/core/loading_circle.dart';
import 'package:inbox_driver/feature/model/home/Task_model.dart';
import 'package:inbox_driver/feature/view/screens/home/Widgets/home_tabbar.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/Widgets/chart_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/Widgets/wh_search_bar.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/date/date_time_util.dart';

import 'Widgets/wh_loading_appbar.dart';
import 'Widgets/wh_loading_card.dart';

class WhLoading extends StatelessWidget {
  const WhLoading({Key? key, required this.task}) : super(key: key);

  Widget get tabBar => const HomeTabBar();
  Widget get searchBar => const WhSearchBar();
  // Widget get chart => WhLoadingChart();
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  final Task task;
  // final SalesOrder salesOrder;

  Widget get lvSalesOrder {
    if (GetUtils.isNull(homeViewModel.operationsSalesData)) {
      return const SizedBox();
    } else {
      return ListView(
        shrinkWrap: true,
        primary: false,
        children: homeViewModel.operationsSalesData!.salesOrders!.map((e) {
          if (task.taskName!
                  .toLowerCase()
                  .contains(Constance.taskWarehouseLoading.toLowerCase()) ||
              task.taskName!
                  .toLowerCase()
                  .contains(Constance.taskWarehouseClosure.toLowerCase())) {
            return WhLoadingCard(
              salesData: homeViewModel.operationsSalesData!,
              salesOrder: e,
              onRecivedClick: () {},
            );
          } else if (task.taskName!
              .toLowerCase()
              .contains(Constance.taskCustomerVisit.toLowerCase())) {
            return const Text("Customer Vist");
          } else {
            return const Text("Else Case");
          }
        }).toList(),
      );
    }
  }

  Widget get flowChart {
    if (GetUtils.isNull(homeViewModel.operationsSalesData)) {
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
        redValue = 100 - greenValue;
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

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
        backgroundColor: scaffoldColor,
        body: GetBuilder<HomeViewModel>(
            init: HomeViewModel(),
            initState: (_) async {
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
                await homeViewModel.getSpecificTask(taskId: task.id ?? "");
              });
            },
            builder: (logic) {
              if (logic.isLoading) {
                return const LoadingCircle();
              } else {
                return Column(
                  children: [
                    WhLoadingAppBar(
                      title: task.taskName ?? "",
                    ),
                    const Divider(height: 3),
                    tabBar,
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding20!),
                        child: ListView(
                          padding: EdgeInsets.all(padding0!),
                          primary: true,
                          shrinkWrap: true,
                          children: [
                            searchBar,
                            SizedBox(
                              height: sizeH10,
                            ),
                            flowChart,
                            lvSalesOrder
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
