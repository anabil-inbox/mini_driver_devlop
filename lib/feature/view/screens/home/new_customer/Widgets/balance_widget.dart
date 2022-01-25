import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  Widget get btn => Row(
    children: <Widget>[
      GestureDetector(
        onTap: () {},
        child: Container(
          height: sizeH34,
          width: sizeW95,
          decoration: BoxDecoration(
            color: colorRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: CustomTextView(
              txt: txtCash.tr,
              textStyle: textStyleBtn(),
            ),
          ),
        ),
      ),
      SizedBox(width: sizeW15),
      GestureDetector(
        onTap: () {},
        child: Container(
          height: sizeH34,
          width: sizeW95,
          decoration: BoxDecoration(
            color: colorTextWhite,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: colorBtnGray),
          ),
          child: Center(
            child: CustomTextView(
              txt: txtCard.tr,
              textStyle: textStyleNormal(),
            ),
          ),
        ),
      ),
      SizedBox(width: sizeW15),
      GestureDetector(
        onTap: () {},
        child: Container(
          height: sizeH34,
          width: sizeW95,
          decoration: BoxDecoration(
            color: colorTextWhite,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: colorBtnGray),
          ),
          child: Center(
            child: CustomTextView(
              txt: txtApplication.tr,
              textStyle: textStyleNormal(),
            ),
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH13!),
      decoration: BoxDecoration(
        color: colorTextWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextView(
            txt: txtBoxes.tr,
            textStyle: textStyleNormal()?.copyWith(color: colorBlack),
          ),
          SizedBox(height: sizeH13),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextView(
                txt: txtTotal.tr,
                textStyle: textStyleNormal(),
              ),
              const Spacer(),
              CustomTextView(
                txt: '150 ',
                textStyle: textStylePrimaryBold(),
              ),
              Padding(
                padding: EdgeInsets.only(top: sizeH7!),
                child: CustomTextView(
                  txt: txtQR.tr,
                  textStyle:
                      textStylePrimaryBold()?.copyWith(fontSize: fontSize16),
                ),
              ),
            ],
          ),
          SizedBox(height: sizeH14),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextView(
                txt: txtPaid.tr,
                textStyle: textStyleNormal(),
              ),
              const Spacer(),
              CustomTextView(
                txt: '100 ',
                textStyle: textStylePrimaryBold(),
              ),
              Padding(
                padding: EdgeInsets.only(top: sizeH7!),
                child: CustomTextView(
                  txt: txtQR.tr,
                  textStyle:
                      textStylePrimaryBold()?.copyWith(fontSize: fontSize16),
                ),
              ),
            ],
          ),
          SizedBox(height: sizeH14),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextView(
                txt: txtAmountDue.tr,
                textStyle: textStyleNormal(),
              ),
              const Spacer(),
              CustomTextView(
                txt: '50 ',
                textStyle: textStylePrimaryBold(),
              ),
              Padding(
                padding: EdgeInsets.only(top: sizeH7!),
                child: CustomTextView(
                  txt: txtQR.tr,
                  textStyle:
                      textStylePrimaryBold()?.copyWith(fontSize: fontSize16),
                ),
              ),
            ],
          ),
          SizedBox(height: sizeH22),
          btn,
        ],
      ),
    );
  }


}
