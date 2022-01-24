import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/profile/profile_screen.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/icon_btn.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH20!),
      child: SizedBox(
        height: sizeH70,
        child: CustomAppBarWidget(
          elevation: 0,
          appBarColor: Colors.transparent,
          isCenterTitle: true,
          titleWidget: searchWidget,
          leadingWidget: GestureDetector(
            onTap: () {
              Get.to(() => const ProfileScreen());
            },
            child: const CircleAvatar(
              radius: sizeRadius25,
              backgroundImage:  AssetImage('assets/png/profile.png'),
              // child: Image.asset(
              //   'assets/png/profile.png',
              //   height: sizeH38,
              //   width: sizeW36,
              //   fit: BoxFit.cover,
              // ),
            ),
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
          leadingWidth: sizeW48,
          actionsWidgets: [
            IconBtn(
              icon: "assets/svgs/notification.svg",
              iconColor: colorRed,
              width: sizeW48,
              height: sizeH48,
              backgroundColor: colorRedTrans,
              onPressed: () {
                // Get.to(() => const CartScreen());
              },
              borderColor: colorTrans,
            ),
          ],
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
          color: colorSearchBox,
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
                fun: _goToFilterNameView,
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
  void _goToFilterNameView() {
    // Get.to(() => SearchScreen());
  }
}
