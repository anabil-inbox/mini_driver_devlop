import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/bottom_sheets/Widgets/bottom_sheet_card.dart';

import '../app_color.dart';
import '../app_dimen.dart';
import '../app_style.dart';
import '../string.dart';

class InstantOrderBottomSheet extends StatelessWidget {
  const InstantOrderBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
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
                          txt: txtSealed?.tr,
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
  }
}
