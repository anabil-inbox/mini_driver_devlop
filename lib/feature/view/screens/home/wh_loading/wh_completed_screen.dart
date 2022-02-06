import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:inbox_driver/feature/core/loading_circle.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view/screens/visit_tasks/widget/visit_lv_item_widget.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/constance.dart';

import 'Widgets/wh_loading_tabbar.dart';

class WHCompletedScreen extends StatelessWidget {
  const WHCompletedScreen(
      {Key? key, required this.task, required this.index, required this.i})
      : super(key: key);

  Widget get tabBar => const WHLoadingTabBar();
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  final TaskModel task;
  final int index;
  final int i;

  // Widget get lvSalesOrder {
  //   if (GetUtils.isNull(homeViewModel.operationsSalesDataCompleted)) {
  //     return const SizedBox();
  //   } else {
  //     return

  //     ListView.builder(
  //         shrinkWrap: true,
  //         primary: false,
  //         itemCount: 0,
  //         //  homeViewModel.operationsSalesDataCompleted!.salesOrders?.length,
  //         itemBuilder: (context, index) {
  //           if (task.taskName!
  //                   .toLowerCase()
  //                   .contains(Constance.taskWarehouseLoading.toLowerCase()) ||
  //               task.taskName!
  //                   .toLowerCase()
  //                   .contains(Constance.taskWarehouseClosure.toLowerCase())) {
  //             return WhLoadingCard(
  //               task: task,
  //               index: i,
  //               salesData: homeViewModel.operationsSalesDataCompleted!,
  //               salesOrder: homeViewModel
  //                       .operationsSalesDataCompleted!.salesOrders?[index] ??
  //                   SalesOrder(),
  //               onRecivedClick: i == 0
  //                   ? () async {
  //                       if (task.taskName!.toLowerCase().contains(
  //                           Constance.taskWarehouseLoading.toLowerCase())) {
  //                         await homeViewModel.recivedBoxes(
  //                             serial: homeViewModel
  //                                     .operationsSalesDataCompleted!
  //                                     .salesOrders![index]
  //                                     .orderId ??
  //                                 "",
  //                             taskName: Constance.taskWarehouseLoading);
  //                       } else {
  //                         await homeViewModel.recivedBoxes(
  //                             serial: homeViewModel
  //                                     .operationsSalesDataCompleted!
  //                                     .salesOrders![index]
  //                                     .orderId ??
  //                                 "",
  //                             taskName: Constance.taskWarehouseClosure);
  //                       }
  //                     }
  //                   : () {
  //                       snackError(txtError!.tr, txtPreviousTask.tr);
  //                     },
  //             );
  //           } else if (task.taskName!
  //               .toLowerCase()
  //               .contains(Constance.taskCustomerVisit.toLowerCase())) {
  //             return VisitLvItemWidget(
  //               task: task,
  //               index: i,
  //               salesData: homeViewModel.operationsSalesDataCompleted!,
  //               salesOrder: homeViewModel
  //                       .operationsSalesDataCompleted!.salesOrders?[index] ??
  //                   SalesOrder(),
  //               isBlockContainer: index == 0 ? false : true,
  //             );
  //           } else {
  //             return const Text("Else Case");
  //           }
  //         });

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
        backgroundColor: scaffoldColor,
        body: GetBuilder<HomeViewModel>(
            init: HomeViewModel(),
            initState: (_) async {
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
                await homeViewModel.getSpecificTask(
                    taskId: task.id ?? "", taskSatus: Constance.inProgress);
                await homeViewModel.getSpecificTask(
                    taskId: task.id ?? "", taskSatus: Constance.done);
              });
            },
            builder: (logic) {
              if (logic.isLoading) {
                return const LoadingCircle();
              } else {
                // return  const SizedBox();
                return RefreshIndicator(
                  color: colorPrimary,
                  onRefresh: () async {
                    await homeViewModel.getSpecificTask(
                        taskId: task.id ?? "", taskSatus: Constance.inProgress);
                  },
                  // child: const SizedBox(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: sizeH10,
                      ),
                      // lvSalesOrder
                      const SizedBox()
                    ],
                  ),
                );
              }
            }));
  }
}
