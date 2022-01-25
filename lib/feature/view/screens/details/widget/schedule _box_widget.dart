import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';

class ScheduleBox extends StatelessWidget {
  const ScheduleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH13,
          ),
          CustomTextView(
            txt: txtScheduleDelivery.tr,
            maxLine: Constance.maxLineOne,
            textStyle:textStyleNormal()?.copyWith(color: colorBlack),
          ),
          CustomTextView(
            txt: txtTime.tr,
            maxLine: Constance.maxLineOne,
            textStyle:textStyleNormal(),
          ),
          SizedBox(
            height: sizeH13,
          ),
        ],
      ),
    );
  }
}
