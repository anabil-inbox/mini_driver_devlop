import 'package:flutter/material.dart';

import '../../../../../../util/app_color.dart';
import '../../../../../../util/app_dimen.dart';
import '../../../../../../util/app_shaerd_data.dart';
import '../../../../../../util/app_style.dart';
import '../../../../../model/profile/log_model.dart';

class LogItem extends StatelessWidget {
  const LogItem({Key? key, required this.log}) : super(key: key);
  final Log log;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      margin: EdgeInsets.only(bottom: padding12!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH22,
          ),
          // Row(
          //   children: [
          //     SvgPicture.asset("assets/svgs/folder_icon.svg"),
          //     SizedBox(
          //       width: sizeW7,
          //     ),
          //     SvgPicture.asset("assets/svgs/right_arrow.svg"),
          //     SizedBox(
          //       width: sizeW7,
          //     ),
          //     SvgPicture.asset("assets/svgs/folder_shared.svg")
          //   ],
          // ),
          // SizedBox(
          //   height: sizeH12,
          // ),
          RichText(
            text: TextSpan(
              style: textStyleNormal(),
              children: [
                TextSpan(
                  text: log.message,
                ),
               // TextSpan(text: ' New Box 01 ', style: textStylebodyBlack()),
              ],
            ),
          ),
          // Text("You stored Meeting Notes in New Box 01"),
          SizedBox(
            height: sizeH5,
          ),
          Text(
            log.date.toString().split(" ")[0],
            style: textStyleHints(),
          ),
          SizedBox(
            height: sizeH22,
          ),
        ],
      ),
    );
  }
}
