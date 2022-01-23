import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/icon_btn.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';

class WhSearchBar extends StatelessWidget {
  const WhSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH20!),
      child: SizedBox(
        height: sizeH50,
        child: CustomAppBarWidget(
          elevation: 0,
          appBarColor: Colors.transparent,
          isCenterTitle: true,
          titleWidget: searchWidget,
          leadingWidget: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: IconBtn(
              iconColor: colorTextWhite,
              width: sizeW48,
              height: sizeH48,
              backgroundColor: colorRed,
              onPressed: () {
                // Get.to(() => QrScreen());
              },
              borderColor: colorTrans,
              icon: "assets/svgs/Scan.svg",
            ),
          ),
          leadingWidth: sizeW48,
        ),
      ),
    );
  }

  Widget get searchWidget => Container(
        height: sizeH50,
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(horizontal: sizeW13!),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sizeRadius10!),
          color: colorTextWhite,
          // border: Border.all(color: colorBorderContainer)
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/svgs/search_icon.svg",
              color: const Color(0xFFB3B3B3),
            ),
            Expanded(
              child: CustomTextFormFiled(
                label: txtSearchHere,
                maxLine: Constance.maxLineOne,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                onSubmitted: (_) {},
                onChange: (_) {},
                isReadOnly: true,
                isSmallPadding: true,
                isSmallPaddingWidth: true,
                fillColor: Colors.transparent,
                isFill: true,
                isBorder: true,
              ),
            ),
          ],
        ),
      );
}
