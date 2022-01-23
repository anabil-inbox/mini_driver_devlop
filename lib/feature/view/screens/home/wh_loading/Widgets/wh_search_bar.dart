import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/icon_btn.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/constance.dart';

class WhSearchBar extends StatelessWidget {
  const WhSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              Get.to(() => const ScanScreen());
            },
            borderColor: colorTrans,
            icon: "assets/svgs/Scan.svg",
          ),
        ),
        leadingWidth: sizeW48,
      ),
    );
  }

  // Widget get searchWidget => Container(
  //       height: sizeH50,
  //       clipBehavior: Clip.hardEdge,
  //      // padding: EdgeInsets.symmetric(horizontal: sizeW13!),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(sizeRadius10!),
  //         color: colorSearchBox,
  //         // border: Border.all(color: colorBorderContainer)
  //       ),
  //       child: Row(
  //         children: [
  //           SvgPicture.asset(
  //             "assets/svgs/search_icon.svg",
  //           ),
  //           Expanded(
  //             child: CustomTextFormFiled(
  //               label: txtSearchHere,
  //               maxLine: Constance.maxLineOne,
  //               textInputAction: TextInputAction.search,
  //               keyboardType: TextInputType.text,
  //               onSubmitted: (_) {},
  //               onChange: (_) {},
  //               isReadOnly: true,
  //               isSmallPadding: true,
  //               isSmallPaddingWidth: true,
  //               fillColor: colorBackground,
  //               isFill: true,
  //               isBorder: true,
  //             ),
  //           ),
  //         ],
  //       ),
  //     );

  // to do this for search Widget ::
  Widget get searchWidget => CustomTextFormFiled(
        iconSize: sizeRadius20,
        maxLine: Constance.maxLineOne,
        icon: Icons.search,
        iconColor: colorHint2,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onSubmitted: (_) {},
        onChange: (value) {},
        isSmallPadding: false,
        isSmallPaddingWidth: true,
        fillColor: colorBackground,
        isFill: true,
        isBorder: true,
        label: "Search here ...",
      );
}
