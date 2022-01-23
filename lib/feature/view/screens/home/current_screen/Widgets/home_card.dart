import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/wh_loading.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return GestureDetector(
      onTap: () {
        Get.to(() => const WhLoading());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH13!),
        child: Container(
          decoration: BoxDecoration(
            color: colorTextWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH17!),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextView(
                  txt: txtWHLoading?.tr,
                  textStyle: textStyleBlack16(),
                ),
                SizedBox(height: sizeH5),
                CustomTextView(
                  txt: txtDate?.tr,
                  textStyle: textStyleNormal(),
                ),
                SizedBox(height: sizeH7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: sizeW90,
                      height: sizeH27,
                      decoration: BoxDecoration(
                        color: colorGryBackgroundContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CustomTextView(
                          txt: "5 ${txtTotalTask!.tr}",
                          textStyle: textStyleNormal()
                              ?.copyWith(fontSize: fontSize13, color: colorRed),
                        ),
                      ),
                    ),
                    SizedBox(width: sizeW5),
                    Container(
                      width: sizeW90,
                      height: sizeH27,
                      decoration: BoxDecoration(
                        color: colorGryBackgroundContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CustomTextView(
                          txt: "2 ${txtClosedTask!.tr}",
                          textStyle: textStyleNormal()?.copyWith(
                              fontSize: fontSize13, color: colorGreen),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
