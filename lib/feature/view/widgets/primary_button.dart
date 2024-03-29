import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/widgets/three_size_dot.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';

import '../../../util/app_shaerd_data.dart';
// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key? key,
    required this.textButton,
    required this.isLoading,
    required this.onClicked,
    required this.isExpanded, this.colorBtn, this.colorText, this.width, this.height,
  }) : super(key: key);
  final String textButton;
  final Function onClicked;
  final bool isExpanded;
  bool isLoading = false;
  final Color? colorBtn , colorText;
  final double? width , height;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SizedBox(
      width: isExpanded ? double.infinity : width??sizeW165,
      height: height??sizeH50,
      child: ElevatedButton(
        style: primaryButtonStyle?.copyWith(backgroundColor:MaterialStateProperty.all(colorBtn??colorPrimary) ),
        onPressed: !isLoading
            ? () {
                onClicked();
              }
            : () {},
        child: isLoading
            ? const ThreeSizeDot()
            : Text(
                textButton,
                style: textStylePrimary()!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize16,
                    color: colorText??colorTextWhite),
              ),
      ),
    );
  }
}


// ignore: must_be_immutable
class PrimaryButtonOpacityColor extends StatelessWidget {
  PrimaryButtonOpacityColor({
    Key? key,
    required this.textButton,
    required this.isLoading,
    required this.onClicked,
    required this.isExpanded,
  }) : super(key: key);
  final String textButton;
  final Function onClicked;
  final bool isExpanded;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return SizedBox(
      width: isExpanded ? double.infinity : sizeW165,
      height: sizeH50,
      child: ElevatedButton(
        style: primaryButtonOpacityStyle,
        onPressed: !isLoading
            ? () {
                onClicked();
              }
            : () {},
        child: isLoading
            ? const ThreeSizeDot()
            : Text(
                textButton,
                style: textStylePrimary()!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: fontSize15,
                    color: colorPrimary),
              ),
      ),
    );
  }
}
