import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';

class OrderSummeryWidget extends StatelessWidget {
  const OrderSummeryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
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
          Row(
            children: [
              Expanded(
                child: CustomTextView(
                  txt: txtOrderSummery.tr,
                  maxLine: Constance.maxLineOne,
                  textStyle:textStyleNormal()?.copyWith(color: colorBlack),
                ),
              ),
              Container(
                width: sizeW90,
                height: sizeH27,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorGryBackgroundContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: CustomTextView(
                    txt: txtPending.tr,
                    textStyle: textStyleNormal()?.copyWith(fontSize: fontSize13, color: seconderyButtonUnSelected),
                  ),
                ),
              ),
              SizedBox(width: sizeW5),
            ],
          ),
          SizedBox(
            height: sizeH10,
          ),
          SvgPicture.asset("assets/svgs/Folder_Shared.svg"),
          SizedBox(
            height: sizeH10,
          ),
          CustomTextView(
            txt: txtRecall.tr,
            maxLine: Constance.maxLineOne,
            textStyle:textStyleNormal()?.copyWith(color: colorBlack),
          ),
          SizedBox(
            height: sizeH1,
          ),
          CustomTextView(
            txt:txtBoxes0.tr,
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
