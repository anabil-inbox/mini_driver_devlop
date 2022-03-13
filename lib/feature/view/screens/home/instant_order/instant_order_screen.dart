import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/Widgets/box_need_scanned_item.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/Widgets/scan_delivered_box.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/balance_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/contract_signature_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/scan_products_widget.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'Widgets/customer_signature_instant_order.dart';
import 'Widgets/scan_box_instant_order.dart';

class InstantOrderScreen extends StatelessWidget {
  const InstantOrderScreen(
      {Key? key,
      this.isNewCustomer = false,
      required this.taskId,
      required this.taskStatusId})
      : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  Widget get idVerification => Container(
        height: sizeH50,
        padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
        decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: GetBuilder<HomeViewModel>(
          builder: (home) {
            return (home.operationTask.isNew ?? false)
                ? const SizedBox()
                : Row(
                    children: [
                      CustomTextView(
                        txt: txtIDVerification.tr,
                        textStyle:
                            textStyleNormal()?.copyWith(color: colorBlack),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          await homeViewModel.getImage(ImageSource.camera,
                              customerId: home.operationTask.customerId,
                              taskId: taskId);
                        },
                        child: SvgPicture.asset("assets/svgs/Scan.svg",
                            color: colorRed, width: sizeW20, height: sizeH17),
                      )
                    ],
                  );
          },
        ),
      );

  final bool isNewCustomer;

  Widget get waitingTime => Container(
        height: sizeH140,
        decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextView(
              txt: txtWaitingTime.tr,
              textStyle: textStyleNormal(),
            ),
            SizedBox(
              height: sizeH7,
            ),
            CustomTextView(
              txt: txtTimer.tr,
              textStyle: textStylePrimaryBold()?.copyWith(color: colorBlack),
            ),
            SizedBox(
              height: sizeH7,
            ),
            TweenAnimationBuilder<Duration>(
                duration: homeViewModel.waiteTimeOperation,
                tween: Tween(begin: homeViewModel.waiteTimeOperation , end: Duration.zero),
                onEnd: () {
                  Logger().e('Timer ended');
                },
                builder: (BuildContext context, Duration value, Widget? child) {
                  final minutes = value.inMinutes;
                  final seconds = value.inSeconds % 60;
                  homeViewModel.waiteTimeOperation = Duration(minutes: minutes , seconds: seconds);

                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        '$minutes:$seconds',
                        style: Theme.of(context).textTheme.headline5,
                      ));
                })
          ],
        ),
      );
 
  final String taskId;
  final String taskStatusId;

  Widget scanDelivedBoxes({required HomeViewModel homeViewModel}) {
    if (homeViewModel.operationTask.processType == Constance.newStorageSv ||
        homeViewModel.operationTask.processType == Constance.fetchId) {
      return const SizedBox();
    } else {
      return const ScanDeliveredBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: CustomTextView(
          txt: txtInstantOrder.tr,
          maxLine: Constance.maxLineOne,
          textStyle: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: GetBuilder<HomeViewModel>(
        builder: (home) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: padding20!),
              child: ListView(
                shrinkWrap: true,
                children: [
                   home.operationTask.isNew == true
                      ? SizedBox(height: sizeH27)
                      : const SizedBox(),
                  home.operationTask.isNew == true
                      ? const ContractSignature()
                      : const SizedBox(),
                  SizedBox(height: sizeH10),
                  home.operationTask.isNew == true
                      ? idVerification
                      : const SizedBox(),
                  SizedBox(height: sizeH10),
                  const BoxNeedScannedItem(),
                  SizedBox(height: sizeH10),
                  const ScanBoxInstantOrder(),
                  SizedBox(height: sizeH10),
                  GetBuilder<HomeViewModel>(builder: (homeViewModel) {
                    return scanDelivedBoxes(homeViewModel: homeViewModel);
                  }),
                  SizedBox(height: sizeH10),
                  const ScanProducts(),
                  SizedBox(height: sizeH10),
                  const Balance(),
                  SizedBox(height: sizeH10),
                  const CustomerSignatureInstantOrder(),
                  SizedBox(height: sizeH20),
                  if(homeViewModel.operationTask.waitingTime != 0)...[
                  waitingTime,
                  SizedBox(height: sizeH20),
                  ],
                  GetBuilder<HomeViewModel>(
                    builder: (home) {
                      return Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                                textButton: "Requesting Time",
                                isLoading: homeViewModel.isLoading,
                                onClicked: () async {
                                  // await home.updateTaskStatus(
                                  //     newStatus: Constance.done,
                                  //     taskId: taskId,
                                  //     taskStatusId: taskStatusId);
                                  // await home.getSpecificTask(
                                  //     taskId: taskStatusId,
                                  //     taskSatus: Constance.inProgress);
                                  // await home.getSpecificTask(
                                  //     taskId: taskStatusId,
                                  //     taskSatus: Constance.done);
                                  // await home.getHomeTasks(taskType: Constance.done);
                                  // await home.getHomeTasks(
                                  //     taskType: Constance.inProgress);
                                },
                                isExpanded: false),
                          ),
                          SizedBox(width: sizeH20),
                          Expanded(
                            child: SeconderyFormButton(buttonText: "Done",onClicked: () async {
                              await home.updateTaskStatus(
                                  newStatus: Constance.done,
                                  taskId: taskId,
                                  taskStatusId: taskStatusId);
                              await home.getSpecificTask(
                                  taskId: taskStatusId,
                                  taskSatus: Constance.inProgress);
                              await home.getSpecificTask(
                                  taskId: taskStatusId,
                                  taskSatus: Constance.done);
                              await home.getHomeTasks(taskType: Constance.done);
                              await home.getHomeTasks(
                                  taskType: Constance.inProgress);
                            },),
                          )
                        ],
                      );
                    },
                  ),
                  SizedBox(height: sizeH20),
                ],
              ),
            );
          }        
      ),
    );
  }
}
