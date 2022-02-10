import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/balance_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/new_customer/Widgets/scan_products_widget.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';
import 'Widgets/customer_signature_instant_order.dart';
import 'Widgets/scan_box_instant_order.dart';
import 'Widgets/scan_delivered_box.dart';

class InstantOrderScreen extends StatelessWidget {
  const InstantOrderScreen(
      {Key? key, this.isNewCustomer = false, required this.taskId , required this.taskStatusId})
      : super(key: key);
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  Widget get idVerification => Container(
        height: sizeH50,
        padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
        decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CustomTextView(
              txt: txtIDVerification.tr,
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                await homeViewModel.getImage(ImageSource.camera,
                    customerId: SharedPref.instance
                        .getCurrentTaskResponse()
                        ?.customerId);
              },
              child: SvgPicture.asset("assets/svgs/Scan.svg",
                  color: colorRed, width: sizeW20, height: sizeH17),
            ),
          ],
        ),
      );

  final bool isNewCustomer;
  Widget get waitingTime => Container(
        height: sizeH80,
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
          ],
        ),
      );
  final String taskId;
  final String taskStatusId;

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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padding20!),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: sizeH27),
                // if (SharedPref.instance.getCurrentTaskResponse()?.isNew ??
                //     false)
                // const ContractSignature(),
                idVerification,
                SizedBox(height: sizeH10),
                const ScanDeliveredBox(),
                SizedBox(height: sizeH10),
                const ScanBoxInstantOrder(),
                SizedBox(height: sizeH10),
                const ScanProducts(),
                SizedBox(height: sizeH10),
                const Balance(),
                SizedBox(height: sizeH10),
                const CustomerSignatureInstantOrder(),
                SizedBox(height: sizeH10),
                waitingTime,
                SizedBox(height: sizeH100),
              ],
            ),
          ),
          Positioned(
              bottom: padding20,
              right: padding20,
              left: padding20,
              child: GetBuilder<HomeViewModel>(
                builder: (home) {
                  return PrimaryButton(
                      textButton: "Done",
                      isLoading: homeViewModel.isLoading,
                      onClicked: () async {
                        await home.updateTaskStatus(
                          newStatus: Constance.done,
                          taskId: taskId,
                          taskStatusId: taskStatusId
                        );
                        await home.getSpecificTask(taskId: taskStatusId, taskSatus: Constance.inProgress);
                        await home.getSpecificTask(taskId: taskStatusId, taskSatus: Constance.done);
                        await home.getHomeTasks(taskType: Constance.done);
                        await home.getHomeTasks(taskType: Constance.inProgress);
                      },
                      isExpanded: true);
                },
              ))
        ],
      ),
    );
  }
}
