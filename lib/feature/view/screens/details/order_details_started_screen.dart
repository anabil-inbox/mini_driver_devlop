import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/home/sales_data.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/address_box_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/name_box_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/order_list_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/schedule%20_box_widget.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/no_show_report_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';

class OrderDetailsStarted extends StatelessWidget {
  const OrderDetailsStarted(
      {Key? key,
      required this.index,
      required this.salesOrder,
      required this.salesData,
      required this.task,
      required this.isFromCompleted})
      : super(key: key);

  final int index;
  final SalesOrder salesOrder;
  final SalesData salesData;
  final TaskModel task;
  final bool isFromCompleted;

  Widget get orderStatus => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(vertical: sizeH7!, horizontal: sizeW12!),
            decoration: BoxDecoration(
              color: colorRedTrans,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: CustomTextView(
              txt: txtCancel!.tr,
              textStyle: textStyleNormal()?.copyWith(color: colorRed),
            )),
          ),
        ],
      );

  Widget get previousTask => Container(
        height: sizeH25,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: sizeH5!),
        decoration: BoxDecoration(
          color: colorBlue,
        ),
        child: Center(
            child: CustomTextView(
          txt: txtPreviousTask.tr,
          textStyle: textStyleNormal()
              ?.copyWith(color: colorTextWhite, fontSize: fontSize13),
        )),
      );

  Widget primaryButton({required HomeViewModel home}) {
    if (isFromCompleted) {
      return const SizedBox();
    } else if (index == 0) {
      if (task.taskName!
              .toLowerCase()
              .contains(Constance.taskWarehouseLoading.toLowerCase()) ||
          task.taskName!
              .toLowerCase()
              .contains(Constance.taskWarehouseClosure.toLowerCase())) {
        return PrimaryButton(
          isExpanded: true,
          isLoading: home.isLoading,
          textButton: txtReceived.tr,
          onClicked: () async {
            // await home.updateTaskStatus(
            //   newStatus: Constance.taskStart,
            //   taskId: salesOrder.taskId ?? "",
            // );
            await home.recivedBoxes(
                serial: home.operationsSalesData!.salesOrders![index].orderId ?? "",
                taskName: Constance.taskWarehouseLoading);
            await home.getSpecificTask(
                taskId: task.id ?? "", taskSatus: Constance.inProgress);
            await home.getSpecificTask(
                taskId: task.id ?? "", taskSatus: Constance.done);
            await home.getHomeTasks(taskType: Constance.done);
            await home.getHomeTasks(taskType: Constance.inProgress);
          },
        );
      } else if (salesOrder.taskStatus == Constance.inProgress) {
        return PrimaryButton(
          isExpanded: true,
          isLoading: false,
          textButton: txtButtonStart.tr,
          onClicked: () async {
            await home.updateTaskStatus(
              newStatus: Constance.taskStart,
              taskId: salesOrder.taskId ?? "",
            );
            await home.getSpecificTask(
                taskId: task.id ?? "", taskSatus: Constance.inProgress);
            await home.getSpecificTask(
                taskId: task.id ?? "", taskSatus: Constance.done);
            await home.getHomeTasks(taskType: Constance.done);
            await home.getHomeTasks(taskType: Constance.inProgress);
          },
        );
      } else if (salesOrder.taskStatus == Constance.taskStart) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              isExpanded: false,
              width: sizeW150,
              isLoading: home.isLoading,
              onClicked: () async {
                // Get.to(() => const InstantOrder());
                await home.updateTaskStatus(
                  newStatus: Constance.taskdelivered,
                  taskId: salesOrder.taskId ?? "",
                );
                await home.getSpecificTask(
                    taskId: task.id ?? "", taskSatus: Constance.inProgress);
                await home.getSpecificTask(
                    taskId: task.id ?? "", taskSatus: Constance.done);
                await home.getHomeTasks(taskType: Constance.done);
                await home.getHomeTasks(taskType: Constance.inProgress);
              },
              textButton: "Delivered",
            ),
            SizedBox(
              width: sizeW12,
            ),
            SizedBox(
              width: sizeW150,
              child: SeconderyFormButton(
                buttonText: "No Show",
                onClicked: () {
                  showModalBottomSheet(
                    context: Get.context!,
                    builder: (BuildContext context) =>
                        const NoShowReportBottomSheet(),
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    )),
                  );
                },
              ),
            ),
          ],
        );
      } else {
        return const SizedBox();
      }
    } else if (index != 0) {
      return Stack(
        children: [
          PrimaryButton(
            isExpanded: true,
            isLoading: false,
            textButton: txtButtonStart.tr,
            onClicked: () {},
          ),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                color: colorBackground.withOpacity(0.32),
              ))
        ],
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWidget(
          titleWidget: CustomTextView(
            txt: txtOrderDetails.tr,
            maxLine: Constance.maxLineOne,
            textStyle: textStyleAppBarTitle(),
          ),
          isCenterTitle: true,
          leadingWidget: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: isArabicLang()
                ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
                : SvgPicture.asset("assets/svgs/back_arrow.svg"),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding20!),
              child: Column(
                children: [
                  SizedBox(height: sizeH17),
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(height: sizeH17),
                        // todo for order order Status scenario
                        //  orderStatus,
                        //   SizedBox(height: sizeH10),
                        NameClient(
                          clientName: salesOrder.customerId ?? "",
                        ),
                        SizedBox(height: sizeH10),
                        AddressBox(
                          address: salesOrder.orderShippingAddress ??
                              salesOrder.orderWarehouseAddress ??
                              "",
                        ),
                        SizedBox(height: sizeH10),
                        ScheduleBox(
                          dateTime: salesData.lastUpdate.toString(),
                        ),
                        // SizedBox(height: sizeH10),
                        // to Limit This Anthor Senario :
                        // const OrderSummeryWidget(),
                        SizedBox(height: sizeH10),
                        // todo for order list scenario
                        OrderList(
                          orderItems: salesOrder.orderItems ?? [],
                        ),
                        SizedBox(height: sizeH30),
                        // PhysicalModel(
                        //   color: colorPrimary,
                        //   clipBehavior: Clip.hardEdge,
                        // //  shape: BoxShape(),
                        //   elevation: 10,
                        //   child: primaryButton),
                        //   SizedBox(height: sizeH30),
                        SizedBox(height: sizeH10),
                      ],
                    ),
                  ),
                  // Visibility(
                  //   visible: true,
                  //   child: Center(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         PrimaryButton(
                  //           isExpanded: false,
                  //           isLoading: false,
                  //           onClicked: () {
                  //             Get.to(() => const InstantOrder());
                  //             logic.isSelected = !logic.isSelected;
                  //             logic.update();
                  //           },
                  //           textButton: "Delivered",
                  //         ),
                  //         SizedBox(
                  //           width: sizeW12,
                  //         ),
                  //         SizedBox(
                  //           width: sizeW150,
                  //           child: SeconderyFormButton(
                  //             buttonText: "No Show",
                  //             onClicked: () {
                  //               showModalBottomSheet(
                  //                 context: context,
                  //                 builder: (BuildContext context) =>
                  //                     const NoShowReportBottomSheet(),
                  //                 isScrollControlled: true,
                  //                 shape: const RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.vertical(
                  //                   top: Radius.circular(20),
                  //                 )),
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: sizeH27,
                  // ),
                ],
              ),
            ),
            Positioned(
              bottom: padding20,
              right: padding20,
              left: padding20,
              child: GetBuilder<HomeViewModel>(builder: (home) {
                return primaryButton(home: home);
              }),
            ),

            // Positioned(
            //     right: 0,
            //     left: 0,
            //     bottom: 0,
            //     child: Column(
            //       children:  [
            //         const LocationFarWdiget(),
            //         SizedBox(height: sizeH80,)
            //       ],
            //     ),
            //   ),

            // todo for order previous Task bar scenario
            if (index != 0)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: previousTask,
              ),
          ],
        ));
  }
}
