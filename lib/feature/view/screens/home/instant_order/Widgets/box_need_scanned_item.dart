import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';

import 'box_on_order_item.dart';

class BoxNeedScannedItem extends StatelessWidget {
  const BoxNeedScannedItem({Key? key , this.isTransfare = false}) : super(key: key);

  final bool isTransfare;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
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
              txt: isTransfare ? txtBoxesNeedTransfer.tr : txtBoxesNeedScan.tr,
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
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
              child: GetBuilder<HomeViewModel>(
                builder: (home) {
                  if (home.operationTask.boxes == null ||
                      home.operationTask.boxes!.isEmpty) {
                    return const SizedBox();
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: home.operationTask.boxes?.length,
                      itemBuilder: (context, index) {
                        return BoxOnOrderItem(
                          isShowingOperations: false,
                          boxModel: home.operationTask.boxes![index],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: sizeH10),
          ],
        ),
      ),
    );
  
  
  }
}
