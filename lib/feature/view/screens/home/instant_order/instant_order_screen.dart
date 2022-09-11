import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_driver/feature/view/screens/home/home_screen.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/Widgets/box_need_scanned_item.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/Widgets/fetched_items.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/Widgets/scan_delivered_box.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/Widgets/watting_time.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/balance_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/contract_signature_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/scan_products_widget.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../widgets/green_button.dart';
import 'Widgets/customer_signature_instant_order.dart';
import 'Widgets/scan_box_instant_order.dart';

class InstantOrderScreen extends StatefulWidget {
  const InstantOrderScreen(
      {Key? key,
      required this.isFromNotification,
      this.isNewCustomer = false,
      required this.taskId,
      required this.taskStatusId})
      : super(key: key);

  final bool isNewCustomer;

  final String taskId;
  final String taskStatusId;
  final bool isFromNotification;

  @override
  State<InstantOrderScreen> createState() => _InstantOrderScreenState();
}

class _InstantOrderScreenState extends State<InstantOrderScreen> {
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
                ? Row(
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
                              taskId: widget.taskId);
                        },
                        child: SvgPicture.asset("assets/svgs/Scan.svg",
                            color: colorRed, width: sizeW20, height: sizeH17),
                      )
                    ],
                  )
                : const SizedBox();
          },
        ),
      );

  Widget scanDelivedBoxes({required HomeViewModel homeViewModel}) {
    if (homeViewModel.operationTask.processType == Constance.newStorageSv ||
        homeViewModel.operationTask.processType == Constance.fetchId) {
      return const SizedBox();
    } else {
      return const ScanDeliveredBox();
    }
  }

  Future<bool> onWillPop({required bool isFromNotification}) async {
    if (isFromNotification) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.close(2);
    }
    homeViewModel.operationTask.boxes?.forEach((element) {
      element.selectedBoxOperations?.operation = "";
    });
    homeViewModel.selectedBoxOperation = null;
    homeViewModel.update();

    return false;
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return WillPopScope(
      onWillPop: () => onWillPop(isFromNotification: widget.isFromNotification),
      child: Scaffold(
        appBar: CustomAppBarWidget(
          onBackBtnClick: () {
            onWillPop(isFromNotification: widget.isFromNotification);
          },
          titleWidget: FittedBox(
            child: CustomTextView(
              txt: txtInstantOrder.tr  + " " + homeViewModel.operationTask.salesOrder.toString(),
              maxLine: Constance.maxLineOne,
              textStyle: textStyleAppBarTitle(),
            ),
          ),
          isCenterTitle: true,
        ),
        body: GetBuilder<HomeViewModel>(builder: (home) {
          // Logger().w(home.operationTask.isNew);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20!),
            child: ListView(
              shrinkWrap: true,
              children: [
                if (home.operationTask.isNew ?? false) ...[
                  SizedBox(height: sizeH27),
                  const ContractSignature(),
                  SizedBox(height: sizeH10),
                  idVerification
                ],
                SizedBox(height: sizeH10),
                if (home.operationTask.processType != Constance.fetchId) ...[
                  const BoxNeedScannedItem(),
                ] else ...[
                  const FetchedItems(),
                ],
                if (home.operationTask.processType != Constance.fetchId) ...[
                  SizedBox(height: sizeH10),
                  const ScanBoxInstantOrder(),
                ],
                if (home.operationTask.processType == Constance.recallId ||
                    (home.operationTask.processType == Constance.terminateId &&
                        (homeViewModel.operationTask.hasDeliveredScan ??
                            false))) ...[
                  SizedBox(height: sizeH10),
                  GetBuilder<HomeViewModel>(builder: (homeViewModel) {
                    return scanDelivedBoxes(homeViewModel: homeViewModel);
                  })
                ],
                SizedBox(height: sizeH10),
                const ScanProducts(),
                SizedBox(height: sizeH10),
                const Balance(),
                SizedBox(height: sizeH10),
                CustomTextFormFiled(
                  label: txtNote.tr,
                  controller: home.tdNote,
                  isSmallPadding: true,
                  isSmallPaddingWidth: false,
                  isFill: true,
                  fillColor: colorTextWhite,
                  maxLine: 5,
                  minLine: 3,
                ),
                SizedBox(height: sizeH10),
                GetBuilder<HomeViewModel>(builder: (logic) {
                  return CustomerSignatureInstantOrder(
                      taskId: homeViewModel.operationTask.taskId.toString());
                }),
                SizedBox(height: sizeH20),
                if ((homeViewModel.operationTask.hasTimeRequest ?? false)) ...[
                  GetBuilder<HomeViewModel>(
                    builder: (controller) =>
                        const WattingTime(isFreeTime: false),
                  ),
                  SizedBox(height: sizeH20),
                ] else ...[
                  const WattingTime(isFreeTime: true),
                  SizedBox(height: sizeH20),
                ],
                GetBuilder<HomeViewModel>(
                  builder: (home) {
                    if (homeViewModel.operationTask.waitingTime! > 0.1) {
                      return Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                                textButton: txtRequestTime.tr,
                                isLoading: home.isLoadingRequestTime,
                                onClicked: () async {
                                  home.requestWaittingTime(
                                      taskId: widget.taskId,
                                      salesOrder:
                                          home.operationTask.salesOrder ?? "");
                                },
                                isExpanded: false),
                          ),
                          SizedBox(width: sizeH20),
                          Expanded(
                            child: GreenButton(
                                buttonText: txtDone.tr,
                                color: colorGreen,
                                isLoading: homeViewModel.isLoading,
                                onClicked: () async {
                                  bool isAllowed = true;

                                  homeViewModel.operationTask.scannedBoxes
                                      ?.forEach((element) {
                                    if (element.selectedBoxOperations
                                                ?.operation ==
                                            Constance.sealed &&
                                        element.newSeal == null) {
                                      snackError("",
                                          "${txtEnterSeal.tr} ${element.boxId}");
                                      isAllowed = false;
                                      return;
                                    }
                                  });

                                  if (!isAllowed) {
                                    return;
                                  }
                                  if(homeViewModel.operationTask.signatureFile ==null){
                                    snackError("",txtAddSignature.tr);
                                    return;
                                  }

                                  if(homeViewModel.operationTask.signatureFile !=null && homeViewModel.operationTask.signatureFile.toString().isEmpty){
                                    snackError("",txtAddSignature.tr);
                                    return;
                                  }
                                  await home.updateTaskStatus(
                                      seralOrder: homeViewModel
                                          .operationTask.salesOrder,
                                      customerId: homeViewModel
                                          .operationTask.customerId,
                                      newStatus: Constance.done,
                                      taskId: widget.taskId,
                                      taskStatusId: widget.taskStatusId);
                                  await home.getSpecificTask(
                                      taskId: widget.taskStatusId,
                                      taskSatus: Constance.inProgress);
                                  await home.getSpecificTask(
                                      taskId: widget.taskStatusId,
                                      taskSatus: Constance.done);
                                  await home.getHomeTasks(
                                      taskType: Constance.done);
                                  await home.getHomeTasks(
                                      taskType: Constance.inProgress);
                                }),
                          )
                        ],
                      );
                    } else {
                      return GreenButton(
                          buttonText: txtDone.tr,
                          color: colorGreen,
                          isLoading: homeViewModel.isLoading,
                          onClicked: () async {
                            bool isAllowed = true;

                            homeViewModel.operationTask.scannedBoxes
                                ?.forEach((element) {
                              if (element.selectedBoxOperations?.operation ==
                                      Constance.sealed &&
                                  element.newSeal == null) {
                                snackError("",
                                    "${txtEnterSeal.tr} ${element.boxId}");
                                isAllowed = false;
                                return;
                              }
                            });

                            if (!isAllowed) {
                              return;
                            }
                            await home.updateTaskStatus(
                                seralOrder:
                                    homeViewModel.operationTask.salesOrder,
                                customerId:
                                    homeViewModel.operationTask.customerId,
                                newStatus: Constance.done,
                                taskId: widget.taskId,
                                taskStatusId: widget.taskStatusId);
                            await home.getSpecificTask(
                                taskId: widget.taskStatusId,
                                taskSatus: Constance.inProgress);
                            await home.getSpecificTask(
                                taskId: widget.taskStatusId,
                                taskSatus: Constance.done);
                            await home.getHomeTasks(taskType: Constance.done);
                            await home.getHomeTasks(
                                taskType: Constance.inProgress);
                          });
                    }
                  },
                ),
                SizedBox(height: sizeH20),
              ],
            ),
          );
        }),
      ),
    );
  }
}
