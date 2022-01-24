import 'package:flutter/material.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';

class NameBox extends StatelessWidget {
  const NameBox({Key? key}) : super(key: key);

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
            height: sizeH6,
          ),
          SizedBox(
            height: sizeH4,
          ),
          RichText(
            text: TextSpan(
              style: textStyleNormal(),
              children: const [
                TextSpan(
                  text: 'Client Name',
                ),
              ],
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
                enabled: false,
                suffixStyle: TextStyle(color: Colors.transparent),
                contentPadding: EdgeInsets.all(1.0),
                hintText: "Fabiana Capmany"),
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
