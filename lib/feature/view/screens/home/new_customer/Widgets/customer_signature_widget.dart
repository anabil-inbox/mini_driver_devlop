import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';

class CustomerSignature extends StatelessWidget {
  const CustomerSignature({Key? key}) : super(key: key);

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
              txt: txtCustomerSignature.tr,
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
        collapsed: SizedBox.shrink(),
        expanded: Column(
          children: [
            SizedBox(height: sizeH14),
            // Container(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: sizeW20!, vertical: sizeH17!),
            //   height: sizeH60,
            //   decoration: BoxDecoration(
            //     color: colorSearchBox,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Row(
            //     children: <Widget>[
            //       SvgPicture.asset('assets/svgs/Folder_Shared.svg'),
            //       SizedBox(width: sizeW5),
            //       CustomTextView(
            //         txt: txtBoxes.tr,
            //         textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            //       )
            //     ],
            //   ),
            // )
            card,
            SizedBox(height: sizeH14),
            PrimaryButton(
                isLoading: false,
                textButton: txtDone.tr,
                onClicked: () {
                  Get.back();
                },
                isExpanded: true),
            SizedBox(
              height: sizeH17,
            )
          ],
        ),
      ),
    );
  }

  Widget get card => Column(
        children: [
          Container(
            height: sizeH50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: colorTextWhite,
                border: Border.all(color: colorBtnGray)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeW10!),
              child: Row(
                children: <Widget>[
                  Container(
                    height: sizeH28,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorRed, width: 1.3),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: Container(
                            decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorRed,
                        )),
                        // backgroundColor: colorRed,
                      ),
                    ),
                  ),
                  SizedBox(width: sizeW5),
                  CustomTextView(
                    txt: txtDriverSide.tr,
                    textStyle:
                        textStyleNormal()?.copyWith(fontSize: fontSize13),
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(top: sizeH7!),
                            child: SvgPicture.asset('assets/svgs/signuter.svg'),
                          )),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(padding4!),
                            decoration: BoxDecoration(
                              color: colorPrimary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.clear,
                              size: 10,
                              color: colorTextWhite,
                            ),
                          ))
                    ],
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        isArabicLang() ? -5 : 5, 0, 0),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: colorBlack,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: sizeH10),
          Container(
            height: sizeH50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: colorTextWhite,
                border: Border.all(color: colorBtnGray)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeW10!),
              child: Row(
                children: <Widget>[
                  Container(
                    height: sizeH28,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorBtnGray, width: 1.3),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: Container(
                            decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorTrans,
                        )),
                        // backgroundColor: colorRed,
                      ),
                    ),
                  ),
                  SizedBox(width: sizeW5),
                  CustomTextView(
                    txt: txtClientSide.tr,
                    textStyle:
                        textStyleNormal()?.copyWith(fontSize: fontSize13),
                  ),
                  const Spacer(),
                  Transform(
                    transform: Matrix4.translationValues(
                        isArabicLang() ? -5 : 5, 0, 0),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: colorBlack,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: sizeH10),
          Container(
            height: sizeH50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: colorTextWhite,
                border: Border.all(color: colorBtnGray)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeW10!),
              child: Row(
                children: <Widget>[
                  Container(
                    height: sizeH28,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorRed, width: 1.3),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: Container(
                            decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorRed,
                        )),
                        // backgroundColor: colorRed,
                      ),
                    ),
                  ),
                  SizedBox(width: sizeW5),
                  CustomTextView(
                    txt: txtFingerprint.tr,
                    textStyle:
                        textStyleNormal()?.copyWith(fontSize: fontSize13),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset('assets/svgs/Finger_print.svg')),
                  Transform(
                    transform: Matrix4.translationValues(
                        isArabicLang() ? -5 : 5, 0, 0),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: colorBlack,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
}
