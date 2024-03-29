import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../util/app_color.dart';
import '../../../../../util/app_dimen.dart';
import '../../../../../util/app_shaerd_data.dart';
import '../../../../../util/app_style.dart';
import '../../../widgets/custome_text_view.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: sizeH20!, vertical: sizeH5!),
      decoration: BoxDecoration(
          color: colorTextWhite, borderRadius: BorderRadius.circular(sizeH6!)),
      child: Row(
        children: [
          SizedBox(
            width: sizeW15,
          ),
          SvgPicture.asset("assets/svgs/orange_notifications.svg"),
          SizedBox(
            width: sizeW10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextView(
                  txt: "Lorem ipsum dolor sit ametconsectetur"),
              SizedBox(
                width: sizeW2,
              ),
              Text(
                "Mar 13, 2018",
                style: smallHintTextStyle(),
              )
            ],
          )
        ],
      ),
    );
  }
}
