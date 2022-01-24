import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';


class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: sizeH13,
                ),
                CustomTextView(
                  txt: 'Delivery Address',
                  maxLine: Constance.maxLineOne,
                  textStyle:textStyleNormal()?.copyWith(color: colorBlack),
                ),
                SizedBox(
                  height: sizeH1,
                ),

                InkWell(
                  onTap: () {
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                     // Get.bottomSheet(MapBottomSheet());
                    });
                  },
                  child: CustomTextView(
                    txt:"Fabiana Capmany",
                    maxLine: Constance.maxLineOne,
                    textStyle:textStyleNormal(),
                  ),
                ),

                SizedBox(
                  height: sizeH13,
                ),
              ],
            ),
          ),
          Image.asset("assets/png/Location.png",height: sizeH32,width: sizeW30,),
        ],
      ),
    );
  }
}
