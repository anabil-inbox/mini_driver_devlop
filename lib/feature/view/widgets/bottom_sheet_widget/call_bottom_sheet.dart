import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/Widgets/bottom_sheet_card.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:logger/logger.dart';

import '../../../../util/app_color.dart';
import '../../../../util/app_dimen.dart';
import '../../../../util/string.dart';

class CallBottomSheet extends StatelessWidget {
  const CallBottomSheet({Key? key, required this.phoneNumber})
      : super(key: key);

  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
        decoration: BoxDecoration(
            color: colorTextWhite,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: sizeH20!),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: sizeH20),
            SvgPicture.asset('assets/svgs/Indicator.svg'),
            SizedBox(height: sizeH17),
            Text(
              txtCall.tr,
              style: textStyleTitle(),
            ),
            SizedBox(height: sizeH25),
            BottomSheetCard(
              text: txtWhatsApp!.tr,
              onClicked: () {
                openwhatsapp(phoneNumber: phoneNumber);
              },
            ),
            SizedBox(height: sizeH10),
            BottomSheetCard(
              text: txtPhoneCall!.tr,
              onClicked: () {
                //  startPhoneCall(phoneNumber: phoneNumber);
                callNumber(phoneNumber: phoneNumber);
              },
            ),
            SizedBox(height: sizeH10),
            BottomSheetCard(
              text: txtSMSOnMyWay!.tr,
              onClicked: () {
                sendSmsOnMyWay(phoneNumber: phoneNumber);
              },
            ),
            SizedBox(height: sizeH10),
            BottomSheetCard(
              text: txtSMSArrivedOutside!.tr,
              onClicked: () {
                sendSmsArrivedHereOutside(phoneNumber: phoneNumber);
              },
            ),
            SizedBox(height: sizeH10),
            BottomSheetCard(
              text: txtSMSReportNoShow!.tr,
              onClicked: () {
                sendSmsNoShow(phoneNumber: phoneNumber);
              },
            ),
            SizedBox(height: sizeH10),
            BottomSheetCard(
                text: "Customize sms",
                onClicked: () {
                  sendCustomizeSMS(phoneNumber: phoneNumber);
                }),
            SizedBox(
              height: sizeH18,
            ),
            PrimaryButton(
                isLoading: false,
                textButton: txtCancel!.tr,
                onClicked: () {
                  Get.back();
                },
                isExpanded: true),
            SizedBox(
              height: sizeH34,
            )
          ],
        ));
  }
}
