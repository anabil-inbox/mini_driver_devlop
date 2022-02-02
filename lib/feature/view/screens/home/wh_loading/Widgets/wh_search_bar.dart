import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/icon_btn.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/constance.dart';

class WhSearchBar extends StatelessWidget {
  const WhSearchBar({Key? key, this.isHaveScan = true , required this.onChange ,  this.textEditingController}) : super(key: key);

  final bool isHaveScan;
  final Function onChange;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    if (isHaveScan) {
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
              )),
          leadingWidth: sizeW48,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: padding12!),
        child: SizedBox(
          child: searchWidget,
          // child: CustomAppBarWidget(
          //   elevation: 0,
          //   appBarColor: Colors.transparent,
          //   isCenterTitle: true,
          //   titleWidget: searchWidget,
          //   leadingWidget: const SizedBox(),
          // ),
        ),
      );
    }
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
        controller: textEditingController??TextEditingController(),
        maxLine: Constance.maxLineOne,
        icon: Icons.search,
        iconColor: colorHint2,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onSubmitted: (_) {},
        onChange: (value) {
          onChange;
        },
        isSmallPadding: false,
        isSmallPaddingWidth: true,
        fillColor: colorBackground,
        isFill: true,
        isBorder: true,
        label: "Search here ...",
      );
}
