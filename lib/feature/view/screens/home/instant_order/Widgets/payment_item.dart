import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/model/payment/payment.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/sh_util.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({Key? key, required this.paymentMethod}) : super(key: key);

  final PaymentMethod paymentMethod;

  @override
  Widget build(BuildContext context) {
    return  Container(
          margin: EdgeInsets.symmetric(horizontal: padding4!),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(padding6!),
              border: Border.all(
                  width: 0.5,
                  color: SharedPref.instance.getCurrentTaskResponse()?.paymentMethod != paymentMethod.id
                      ? colorBorderContainer
                      : colorTrans),
              color: SharedPref.instance.getCurrentTaskResponse()?.paymentMethod != paymentMethod.id
                  ? colorTextWhite
                  : colorPrimary),
          padding: EdgeInsets.symmetric(
              vertical: padding9!, horizontal: padding14!),
          child: CustomTextView(txt: "${paymentMethod.name}" , 
          textStyle: SharedPref.instance.getCurrentTaskResponse()?.paymentMethod == paymentMethod.id
                  ? textStylebodyWhite()
                  : textStyleHints()!
                      .copyWith(fontSize: fontSize14, color: colorHint2),),
        );
     
  }
}
