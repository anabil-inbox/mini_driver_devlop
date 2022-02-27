import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';

class ScanBox extends StatelessWidget {
  const ScanBox({Key? key}) : super(key: key);

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
                Get.to(() => const ScanScreen(
                   isBoxSalesScan: false,
                    isProductScan: false,
                ));
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
              height: sizeH60,
              decoration: BoxDecoration(
                color: colorSearchBox,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset('assets/svgs/Folder_Shared.svg'),
                  SizedBox(width: sizeW5),
                  CustomTextView(
                    txt: txtBoxes.tr,
                    textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
