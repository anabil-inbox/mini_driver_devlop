import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/string.dart';

import '../../../../util/app_dimen.dart';
import '../../../../util/app_style.dart';
import 'Widgets/bottom_sheet_card.dart';

class EmergencyBottomSheet extends StatelessWidget {
  const EmergencyBottomSheet({Key? key}) : super(key: key);

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
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: sizeH20),
                SvgPicture.asset('assets/svgs/Indicator.svg'),
                SizedBox(height: sizeH17),
                Text(
                  txtEmergency!.tr,
                  style: textStyleTitle(),
                ),
                SizedBox(height: sizeH25),
                BottomSheetCard(
                  text: txtCase1!.tr,
                  onClicked: () {},
                  borderColor: colorBtnGray,
                  containerColor: colorRed,
                  textStyleColor: colorTextWhite,
                ),
                SizedBox(height: sizeH10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        BottomSheetCard(
                          text: txtCase1!.tr,
                          onClicked: () {},
                          borderColor: colorBtnGray,
                          containerColor: colorTextWhite,
                        ),
                        SizedBox(height: sizeH10),
                      ],
                    );
                  },
                ),
                SizedBox(height: sizeH10),
                CustomTextFormFiled(
                  label: txtWriteDownCaseRemarks,
                  isSmallPadding: true,
                  isSmallPaddingWidth: false,

                  // textAlign: TextAlign.center,
                  isFill: true,
                  fillColor: colorBottomSheetTextField,
                  maxLine: 5,
                  minLine: 3,
                ),
                SizedBox(height: sizeH20),
                BottomSheetCard(
                  text: txtTakePicture.tr,
                  containerColor: colorTextWhite,
                  borderColor: colorRed,
                  textStyleColor: colorRed,
                  onClicked: () {},
                ),
                SizedBox(
                  height: sizeH18,
                ),
                PrimaryButton(
                    isLoading: false,
                    textButton: txtSubmitReport.tr,
                    onClicked: () {
                      Get.back();
                    },
                    isExpanded: true),
                SizedBox(
                  height: sizeH34,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
