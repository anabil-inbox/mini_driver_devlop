import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/home/un_compleated/un_compleated_tasks.dart';
import 'package:inbox_driver/feature/view/screens/notifications_screen/notifications_screen.dart';
import 'package:inbox_driver/feature/view/screens/profile/profile_screen.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/icon_btn.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:inbox_driver/util/string.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  static HomeViewModel get homeViewModel => Get.find<HomeViewModel>();

  Widget get _userProfileImage {
    return (SharedPref.instance.getCurrentUserData()?.image != null &&
            SharedPref.instance
                .getCurrentUserData()!
                .image
                .toString()
                .isNotEmpty)
        ? Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: imageNetwork(
                url: "${SharedPref.instance.getCurrentUserData()?.image}"))
        : CircleAvatar(
            backgroundColor: colorPrimary,
            radius: 30,
          );
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH20!),
      child: SizedBox(
        height: Platform.isIOS ? sizeH90 : sizeH70,
        child: CustomAppBarWidget(
          elevation: 0,
          appBarColor: Colors.transparent,
          isCenterTitle: false,
          titleWidget: Text(
            "${txtHi.tr} ${SharedPref.instance.getCurrentUserData()?.driverName}",
            style: TextStyle(color: colorBlack, fontSize: fontSize16),
          ),
          // titleWidget: searchWidget,
          // titleWidget:  !GetUtils.isNull(homeViewModel.selectedDateTime)
          //     ? InkWell(
          //   onTap: (){
          //
          //   },
          //       child: Container(
          //   padding: EdgeInsets.symmetric(
          //         horizontal: sizeH7!, vertical: sizeH7!),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(padding6!),
          //       color: colorBorderContainer,
          //   ),
          //   child: Row(
          //       children: [
          //         CustomTextView(
          //           txt:
          //           "${homeViewModel.selectedDateTime?.year}/${homeViewModel.selectedDateTime?.month}/${homeViewModel.selectedDateTime?.day}",
          //           textStyle: textStyleHints()!
          //               .copyWith(fontSize: fontSize13),
          //         ),
          //         SvgPicture.asset("assets/svgs/down_arrow.svg")
          //       ],
          //   ),
          // ),
          //     )
          //     : Container(
          //     padding: EdgeInsets.symmetric(
          //         horizontal: sizeH7!, vertical: sizeH7!),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(padding6!),
          //     color: colorBorderContainer,
          //   ),
          //     child:
          //     Row(
          //       children: [
          //         CustomTextView(
          //           txt: txtFilterByDate.tr,
          //           textStyle: textStyleHints()!
          //               .copyWith(fontSize: fontSize13),
          //         ),
          //         SvgPicture.asset("assets/svgs/down_arrow.svg")
          //       ],
          //     ),),
          leadingWidget: GestureDetector(
            onTap: () {
              Get.to(() => const ProfileScreen());
            },
            child: CircleAvatar(
              radius: sizeRadius5,
              child: _userProfileImage,
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
            // InkWell(
            //   onTap: (){
            //     Get.to(() => const UnCompletedScreen());
            //   },
            //   child: Container(
            //     alignment: Alignment.center,
            //     margin: EdgeInsets.symmetric(horizontal: sizeW4!),
            //     padding: EdgeInsets.symmetric(horizontal: sizeH7!, vertical: sizeH7!),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(padding6!),
            //       color: colorPrimaryOpcaityColor,
            //     ),
            //     child: SvgPicture.asset("assets/svgs/un_compleat.svg" ,width:sizeW28 ,color: colorPrimary,)/*Text(
            //       txtUnCompleted.tr,
            //       style: TextStyle(color: colorPrimary, fontSize: fontSize12),
            //     )*/,
            //   ),
            // ),
            IconBtn(
              icon: "assets/svgs/un_compleat.svg",
              iconColor: colorPrimary,
              width: sizeW48,
              height: sizeH48,
              backgroundColor: colorPrimaryOpcaityColor,
              onPressed: () {
                Get.to(() => const UnCompletedScreen());
              },
              borderColor: colorTrans,
            ),
            SizedBox(width: sizeW10,),
            IconBtn(
              icon: "assets/svgs/notification.svg",
              iconColor: colorPrimary,
              width: sizeW48,
              height: sizeH48,
              backgroundColor: colorPrimaryOpcaityColor,
              onPressed: () {
                Get.to(() => const NotificationScreen());
                //  Get.to(() => NewCustomer());
                // Get.to(() => const VisitTasksView());
              },
              borderColor: colorTrans,
            ),

          ],
        ),
      ),
    );
  }

  // Widget get searchWidget => Container(
  //       height: sizeH50,
  //       clipBehavior: Clip.hardEdge,
  //       padding: EdgeInsets.symmetric(horizontal: sizeW13!),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(sizeRadius10!),
  //         color: colorSearchBox,
  //         // border: Border.all(color: colorBorderContainer)
  //       ),
  //       child: Row(
  //         children: [
  //           SvgPicture.asset(
  //             "assets/svgs/search_icon.svg",
  //             color: const Color(0xFFB3B3B3),
  //           ),
  //           Expanded(
  //             child: CustomTextFormFiled(
  //               label: txtSearchHere,
  //               maxLine: Constance.maxLineOne,
  //               textInputAction: TextInputAction.search,
  //               keyboardType: TextInputType.text,
  //               onSubmitted: (_) {},
  //               onChange: (_) {},
  //               fun: _goToFilterNameView,
  //               isReadOnly: true,
  //               isSmallPadding: true,
  //               isSmallPaddingWidth: true,
  //               fillColor: Colors.transparent,
  //               isFill: true,
  //               isBorder: true,
  //             ),
  //           ),
  //         ],
  //       ),
  //     );

  Widget get searchWidget => CustomTextFormFiled(
        controller: homeViewModel.tdSearchHome,
        iconSize: sizeRadius20,
        maxLine: Constance.maxLineOne,
        icon: Icons.search,
        iconColor: colorHint2,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        onSubmitted: (_) {},
        onChange: (value) {
          homeViewModel.update();
        },
        isSmallPadding: false,
        isSmallPaddingWidth: true,
        fillColor: scaffoldColor,
        isFill: true,
        isBorder: true,
        label: txtSearchHere.tr,
      );

// void _goToFilterNameView() {
//   // Get.to(() => SearchScreen());
// }
}
