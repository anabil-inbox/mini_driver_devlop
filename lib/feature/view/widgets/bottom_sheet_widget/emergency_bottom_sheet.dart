import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
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
    return SingleChildScrollView(
      child: Container(
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
                txtEmergency!.tr,
                style: textStyleTitle(),
              ),
              SizedBox(height: sizeH36),
              GetBuilder<HomeViewModel>(
                builder: (home) {
                  return ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: home.emEmergencyCases
                        .map((e) => Column(
                              children: [
                                e.name != home.selectedEmergencyCase?.name
                                    ? BottomSheetCard(
                                        text: e.name ?? "",
                                        onClicked: () {
                                          home.selectedEmergencyCase = e;
                                          home.update();
                                        },
                                        borderColor: colorBtnGray,
                                        containerColor: colorTextWhite,
                                      )
                                    : PrimaryButton(
                                        textButton: e.name ?? "",
                                        isLoading: false,
                                        onClicked: () {},
                                        isExpanded: true),
                                SizedBox(height: sizeH10),
                              ],
                            ))
                        .toList(),
                  );
                },
              ),
              SizedBox(height: sizeH10),
              GetBuilder<HomeViewModel>(
                builder: (home) {
                  return CustomTextFormFiled(
                    label: txtWriteDownCaseRemarks,
                    controller: home.tdEmergencyNote,
                    isSmallPadding: true,
                    isSmallPaddingWidth: false,
                    isFill: true,
                    fillColor: colorBottomSheetTextField,
                    maxLine: 5,
                    minLine: 3,
                  );
                },
              ),
              SizedBox(height: sizeH20),
              GetBuilder<HomeViewModel>(
                builder: (home) {
                  return BottomSheetCard(
                    text: txtTakePicture.tr,
                    containerColor: colorTextWhite,
                    borderColor: colorRed,
                    textStyleColor: colorRed,
                    onClicked: () async {
                      home.getImageBottomSheet();
                    },
                  );
                },
              ),
              SizedBox(
                height: sizeH18,
              ),
              GetBuilder<HomeViewModel>(
                builder: (logic) {
                  return PrimaryButton(
                      isLoading: logic.isLoading,
                      textButton: txtSubmitReport.tr,
                      onClicked: () async {
                        if (logic.validationEmergency()) {
                          await logic.createEmergancyReport();
                        }
                      },
                      isExpanded: true);
                },
              ),
              SizedBox(
                height: sizeH34,
              )
            ],
          )),
    );
  }
}
