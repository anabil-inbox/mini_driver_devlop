import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';

class GlobalBottomSheet extends StatelessWidget {
  const GlobalBottomSheet(
      {Key? key,
      this.title,
      this.subTitle,
      this.isTwoBtn = true,
      this.onOkBtnClick,
      this.onCancelBtnClick})
      : super(key: key);
  final String? title, subTitle;
  final bool? isTwoBtn;
  final Function()? 
  onOkBtnClick,
  onCancelBtnClick;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      // height: sizeH300,
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: sizeH20!),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: sizeH25),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: sizeH5,
              width: sizeW50,
              decoration: BoxDecoration(
                  color: colorContainerGrayLight,
                  borderRadius: BorderRadius.circular(sizeRadius5!)),
            ),
          ),
          if (title.toString().isNotEmpty) ...[
            SizedBox(height: sizeH25),
            CustomTextView(
              txt: "$title",
              textStyle: textStyleTitle(),
            ),
          ],
          if (subTitle.toString().isNotEmpty && subTitle != null ) ...[
            SizedBox(height: sizeH25),
            CustomTextView(
              txt: "$subTitle",
              textStyle: textStyleTitle(),
            ),
          ],
          SizedBox(
            height: sizeH28,
          ),
             Row(
               children: [
                 Expanded(
                   child: PrimaryButton(
                    isLoading: false,
                    textButton: txtOk.tr,
                    width: double.infinity ,
                    onClicked: onOkBtnClick??(){},
                    isExpanded: false),
                 ),
                 SizedBox(
                   width: sizeW18,
                 ),
                !isTwoBtn! ? const SizedBox.shrink(): Expanded(
                  child: PrimaryButton(
                       isLoading: false,
                       textButton: txtCancel!.tr,
                       width: double.infinity ,
                       onClicked: onCancelBtnClick??(){},
                       colorBtn: colorBtnGray,
                       colorText: colorTextDark,
                       isExpanded: false),
                ),
               ],
             ),
          SizedBox(
            height: sizeH34,
          )
        ],
      ),
    );
  }
}
