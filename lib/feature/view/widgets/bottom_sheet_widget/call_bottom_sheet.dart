import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/Widgets/bottom_sheet_card.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
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

   static TextEditingController _messageEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SingleChildScrollView(
      child: GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          builder: (logic) {
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
                (!logic.isLoadingOnWay)?
                BottomSheetCard(
                  text: txtSMSOnMyWay!.tr,
                  onClicked: () {
                    logic.sendSmsMessage(message: "I\'m on my way", phoneNUmber: phoneNumber, type: 1);
                     // sendSmsOnMyWay(phoneNumber: phoneNumber);
                  },
                ):ThreeSizeDot(color_1: colorPrimary,color_2:colorPrimary ,color_3:colorPrimary ,),
                SizedBox(height: sizeH10),
                (!logic.isLoadingArrived)?
                BottomSheetCard(
                  text: txtSMSArrivedOutside!.tr,
                  onClicked: () {
                    // sendSmsArrivedHereOutside(phoneNumber: phoneNumber);
                    logic.sendSmsMessage(message: "I arrived here outside", phoneNUmber: phoneNumber, type: 2);
                  },
                ):ThreeSizeDot(color_1: colorPrimary,color_2:colorPrimary ,color_3:colorPrimary ,),
                SizedBox(height: sizeH10),
                (!logic.isLoadingNoShow)?
                BottomSheetCard(
                  text: txtSMSReportNoShow!.tr,
                  onClicked: () {
                    // sendSmsNoShow(phoneNumber: phoneNumber);
                    logic.sendSmsMessage(message: "I'll report no show within 5 mines", phoneNUmber: phoneNumber, type: 3);
                  },
                ):ThreeSizeDot(color_1: colorPrimary,color_2:colorPrimary ,color_3:colorPrimary ,),
                SizedBox(height: sizeH10),
                (!logic.isLoadingCustomize)?
                BottomSheetCard(
                    text: txtCustomizeSms.tr,
                    onClicked: () {
                      // sendCustomizeSMS(phoneNumber: phoneNumber);
                      // logic.sendSmsMessage(message: _messageEditingController.text.toString(), phoneNUmber: phoneNumber, type: 4);
                   logic.showCustomMessage();
                    }):ThreeSizeDot(color_1: colorPrimary,color_2:colorPrimary ,color_3:colorPrimary ,),
               if((!logic.isLoadingCustomize) && logic.isShowCustomMessage)...[
                 SizedBox(height: sizeH10),
                 CustomTextFormFiled(
                   controller: _messageEditingController,
                   label: txtNote.tr,
                   maxLine: 1000,
                   isFill: true,
                   isBorder: false,
                   fillColor: colorBottomSheetTextField,
                   isSmallPaddingWidth: true,
                   isSmallPadding: true,
                   minLine: 4,
                   onSubmitted: (value){
                     if(value.isNotEmpty) {
                       logic.sendSmsMessage(message: _messageEditingController.text.toString(), phoneNUmber: phoneNumber, type: 4);
                     }
                   },
                   keyboardType:TextInputType.text,
                   textInputAction: TextInputAction.send,
                 ),
               ],
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
      }),
    );
  }
}
