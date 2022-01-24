import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/bottom_sheets/Widgets/widgets.dart';
import '../app_color.dart';
import '../app_style.dart';
import '../string.dart';

Widget callBottomSheet() => Container(
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

Widget instantOrderBottomSheet() => Container(
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.symmetric(horizontal: sizeH20!),
      child: GetBuilder<AuthViewModle>(
        init: AuthViewModle(),
        builder: (logic) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: sizeH12),
              SvgPicture.asset('assets/svgs/Indicator.svg'),
              SizedBox(height: sizeH25),
              GestureDetector(
                onTap: () {
                  logic.isSelected = !logic.isSelected;
                  logic.update();
                },
                child: Container(
                  height: sizeH50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorTextWhite,
                      border: Border.all(color: colorBtnGray)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeW10!),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: sizeH30,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    logic.isSelected ? colorRed : colorBtnGray),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              child: Container(
                                  decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: logic.isSelected
                                    ? colorRed
                                    : Colors.transparent,
                              )),
                              // backgroundColor: colorRed,
                            ),
                          ),
                        ),
                        SizedBox(width: sizeW5),
                        CustomTextView(
                          txt: txtSealed,
                          textStyle:
                              textStyleNormal()?.copyWith(color: colorBlack),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: sizeH18),
              GestureDetector(
                onTap: () {
                  logic.isSelected = !logic.isSelected;
                  logic.update();
                },
                child: Container(
                  height: sizeH50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorTextWhite,
                      border: Border.all(color: colorBtnGray)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeW10!),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: sizeH30,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    logic.isSelected ? colorRed : colorBtnGray),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              child: Container(
                                  decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: logic.isSelected
                                    ? colorRed
                                    : Colors.transparent,
                              )),
                              // backgroundColor: colorRed,
                            ),
                          ),
                        ),
                        SizedBox(width: sizeW5),
                        CustomTextView(
                          txt: txtTerminate,
                          textStyle:
                              textStyleNormal()?.copyWith(color: colorBlack),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: sizeH18),
              GestureDetector(
                onTap: () {
                  logic.isSelected = !logic.isSelected;
                  logic.update();
                },
                child: Container(
                  height: sizeH50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorTextWhite,
                      border: Border.all(color: colorBtnGray)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeW10!),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: sizeH30,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    logic.isSelected ? colorRed : colorBtnGray),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              child: Container(
                                  decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: logic.isSelected
                                    ? colorRed
                                    : Colors.transparent,
                              )),
                              // backgroundColor: colorRed,
                            ),
                          ),
                        ),
                        SizedBox(width: sizeW5),
                        CustomTextView(
                          txt: txtReschedule,
                          textStyle:
                              textStyleNormal()?.copyWith(color: colorBlack),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: sizeH18),
              BottomSheetCard(
                text: txtNextScan!.tr,
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

Widget emergencyBottomSheet() => Container(
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
                  text: txtTakePicture!.tr,
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
                    textButton: txtSubmitReport!.tr,
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

Widget noShowReportBottomSheet() => Container(
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
                txtNoShowReport!.tr,
                style: textStyleTitle(),
              ),
              SizedBox(height: sizeH12),
              Center(
                child: CustomTextView(
                  txt: txtTimer,
                  textStyle: textStyleLargeText()?.copyWith(fontSize: 48),
                ),
              ),
              SizedBox(height: sizeH20),
              BottomSheetCard(
                text: txtReSchedule!.tr,
                textStyleColor: colorRed,
                onClicked: () {},
              ),
              SizedBox(height: sizeH10),
              BottomSheetCard(
                text: txtNoShow!.tr,
                textStyleColor: colorRed,
                onClicked: () {},
              ),
              SizedBox(height: sizeH10),
              SizedBox(
                height: sizeH18,
              ),
              PrimaryButton(
                  isLoading: false,
                  textButton: txtCancelOrder!.tr,
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
