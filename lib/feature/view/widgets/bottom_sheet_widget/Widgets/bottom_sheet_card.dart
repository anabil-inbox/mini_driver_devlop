import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';

class BottomSheetCard extends StatelessWidget {
  final String text;
  final Function onClicked;
  final Color? containerColor;
  final Color? borderColor;
  final Color? textStyleColor;
  const BottomSheetCard(
      {Key? key,
      required this.text,
      required this.onClicked,
      this.containerColor,
      this.borderColor,
      this.textStyleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked(),
      child: Container(
        height: sizeH50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: containerColor ?? colorBottomSheetContainer.withOpacity(0.5),
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Center(
          child: CustomTextView(
            txt: text,
            textStyle: textStyleNormal()
                ?.copyWith(color: textStyleColor ?? colorTextHint),
          ),
        ),
      ),
    );
  }
}
