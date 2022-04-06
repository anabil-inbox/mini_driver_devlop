import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';

class NameClient extends StatelessWidget {
  const NameClient({Key? key , required this.clientName}) : super(key: key);

  final String clientName;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH6,
          ),
          SizedBox(
            height: sizeH4,
          ),
          CustomTextView(
            txt: txtClientName.tr,
            maxLine: Constance.maxLineOne,
            textStyle:textStyleNormal()?.copyWith(color: colorBlack),
          ),
          SizedBox(
            height: sizeH1,
          ),
          CustomTextView(
            txt: clientName,
            maxLine: Constance.maxLineOne,
            textStyle:textStyleNormal(),
          ),
          SizedBox(
            height: sizeH12,
          ),
        ],
      ),
    );
  }
}
