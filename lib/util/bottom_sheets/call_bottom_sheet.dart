import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';

import '../app_color.dart';
import '../app_dimen.dart';
import '../string.dart';
import 'Widgets/bottom_sheet_card.dart';

class CallBottomSheet extends StatelessWidget {
  const CallBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: sizeH20!),
      child: GetBuilder<AuthViewModle>(
        init: AuthViewModle(),
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: sizeH20),
              SvgPicture.asset('assets/svgs/Indicator.svg'),
              SizedBox(height: sizeH17),
              Text(
                txtCall!.tr,
                style: textStyleTitle(),
              ),
              SizedBox(height: sizeH25),
              BottomSheetCard(
                text: txtWhatsApp!.tr,
                onClicked: () {},
              ),
              SizedBox(height: sizeH10),
              BottomSheetCard(
                text: txtPhoneCall!.tr,
                onClicked: () {},
              ),
              SizedBox(height: sizeH10),
              BottomSheetCard(
                text: txtSMSOnMyWay!.tr,
                onClicked: () {},
              ),
              SizedBox(height: sizeH10),
              BottomSheetCard(
                text: txtSMSArrivedOutside!.tr,
                onClicked: () {},
              ),
              SizedBox(height: sizeH10),
              BottomSheetCard(
                text: txtSMSReportNoShow!.tr,
                onClicked: () {},
              ),
              SizedBox(height: sizeH10),
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
          );
        },
      ),
    );
  }
}
