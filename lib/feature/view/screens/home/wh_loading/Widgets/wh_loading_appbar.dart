import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/profile/profile_screen.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/icon_btn.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';

class WhLoadingAppBar extends StatelessWidget {
  const WhLoadingAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH20!),
      child: SizedBox(
        height: sizeH50,
        child: CustomAppBarWidget(
          elevation: 0,
          appBarColor: Colors.transparent,
          isCenterTitle: true,
          titleWidget: CustomTextView(
            txt: txtWHLoading,
            textStyle: textStyleBlack16(),
          ),
          leadingWidget: GestureDetector(
            onTap: () {
              Get.back();
            },
            child:

                // IconBtn(
                //   onPressed: () {
                //     Navigator.pop(Get.context!);
                //   },
                //   icon: isArabicLang()
                //       ? "assets/svgs/back_arrow_ar.svg"
                //       : "assets/svgs/back_arrow.svg",
                //   width: sizeW48,
                //   height: sizeH48,
                //   backgroundColor: colorBtnGray,
                //   iconColor: Colors.black,
                //   borderColor: Colors.transparent,
                // )

                IconButton(
              onPressed: () {
                Navigator.pop(Get.context!);
              },
              icon: isArabicLang()
                  ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
                  : SvgPicture.asset("assets/svgs/back_arrow.svg"),
            ),

            // IconBtn(
            //   iconColor: colorTextWhite,
            //   width: sizeW48,
            //   height: sizeH48,
            //   backgroundColor: colorRed,
            //   onPressed: () {
            //     // Get.to(() => QrScreen());
            //   },
            //   borderColor: colorTrans,
            //   icon: "assets/svgs/Scan.svg",
            // ),
          ),
          leadingWidth: sizeW48,
          actionsWidgets: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: sizeW2!, vertical: sizeH7!),
              child: IconBtn(
                icon: "assets/svgs/Call Missed.svg",
                iconColor: colorRed,
                width: sizeW36,
                height: sizeH36,
                backgroundColor: Colors.transparent,
                onPressed: () {
                  // Get.to(() => const CartScreen());
                },
                borderColor: colorRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
