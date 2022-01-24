import 'package:flutter/material.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';

class ScheduleBox extends StatelessWidget {
  const ScheduleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH13,
          ),
          SizedBox(
            height: sizeH4,
          ),
          RichText(
            text: TextSpan(
              style: textStyleNormal(),
              children: const [
                TextSpan(
                  text: 'Schedule Delivery',
                ),
              ],
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
                enabled: false,
                suffixStyle: TextStyle(color: Colors.transparent),
                contentPadding: EdgeInsets.all(1.0),
                hintText: "22.6.2021 (6:00 PM)"),
          ),
          SizedBox(
            height: sizeH1,
          ),
          SizedBox(
            height: sizeH1,
          ),
        ],
      ),
    );
  }
}
