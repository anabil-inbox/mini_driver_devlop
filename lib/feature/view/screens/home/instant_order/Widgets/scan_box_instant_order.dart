import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/instant_order_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';

class ScanBoxInstantOrder extends StatelessWidget {
  const ScanBoxInstantOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          hasIcon: false,
          alignment: Alignment.topLeft,
          tapHeaderToExpand: true,
        ),
        header: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: colorBtnGray.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(padding4!),
              child: Transform.rotate(
                angle: 180 * math.pi / 180,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: colorBlack,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: sizeW10),
            CustomTextView(
              txt: txtScanBox.tr,
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(() => const ScanScreen());
              },
              child: SvgPicture.asset("assets/svgs/Scan.svg",
                  color: colorRed, width: sizeW20, height: sizeH17),
            ),
          ],
        ),
        collapsed: const SizedBox.shrink(),
        expanded: Column(
          children: [
            SizedBox(height: sizeH14),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: sizeW20!, vertical: sizeH17!),
              decoration: BoxDecoration(
                color: colorSearchBox,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      SvgPicture.asset('assets/svgs/Folder_Shared.svg'),
                      SizedBox(width: sizeW5),
                      CustomTextView(
                        txt: txtBoxes.tr,
                        textStyle:
                            textStyleNormal()?.copyWith(color: colorBlack),
                      )
                    ],
                  ),
                  SizedBox(height: sizeH10),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizeW10!, vertical: sizeH9!),
                    decoration: BoxDecoration(
                      color: colorTextWhite,
                      border: Border.all(color: colorBtnGray),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) =>
                                  const InstantOrderBottomSheet(),
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: colorBtnGray.withOpacity(0.4),
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(padding4!),
                                child: Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    color: colorBlack,
                                    size: 20,
                                  ),
                                ),
                              ),
                              SizedBox(width: sizeW10),
                              CustomTextView(
                                txt: txtSealed.tr,
                                textStyle: textStyleNormal()
                                    ?.copyWith(color: colorBlack),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ScanScreen());
                          },
                          child: SvgPicture.asset("assets/svgs/Scan.svg",
                              color: colorRed, width: sizeW20, height: sizeH17),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sizeH10),
                  CustomTextFormFiled(
                    label: txtWriteDownCaseRemarks,
                    isSmallPadding: true,
                    isSmallPaddingWidth: true,
                    isBorder: false,
                    isFill: true,
                    enabledBorderColor: colorBtnGray,
                    fillColor: colorTextWhite,
                    maxLine: 5,
                    minLine: 3,
                  ),
                  SizedBox(height: sizeH10),
                ],
              ),
            ),
            SizedBox(height: sizeH10),
          ],
        ),
      ),
    );
  }
}