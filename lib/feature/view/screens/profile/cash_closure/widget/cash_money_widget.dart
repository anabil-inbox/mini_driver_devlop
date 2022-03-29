import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../../../../../util/app_color.dart';
import '../../../../../../util/app_dimen.dart';
import '../../../../../../util/app_shaerd_data.dart';

class CashMoneyItem extends StatelessWidget {
  const CashMoneyItem({Key? key,required this.value,required this.title, this.valueColor}) : super(key: key);
  final String? value;
  final String? title;
  final Color? valueColor;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: colorTextWhite,
          borderRadius: BorderRadius.circular(padding6!)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(
            height: sizeH16,
          ),
          Text(
            formatStringWithCurrency(value.toString() , "\$"),
            style: TextStyle(color: colorPrimary),
          ),
          SizedBox(
            height: sizeH16,
          ),
          FittedBox(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: sizeW4!),
              child: Text(
                title.toString(),
              ),
            ),
          ),
          SizedBox(
            height: sizeH22,
          ),
        ],
      ),
    );
  }
}
