// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/core/loading_circle.dart';
import 'package:inbox_driver/feature/view/screens/details/order_details_started_screen.dart';
import 'package:inbox_driver/feature/view/screens/home/Widgets/home_appbar.dart';
import 'package:inbox_driver/feature/view/screens/home/Widgets/home_tabbar.dart';
import 'package:inbox_driver/feature/view/screens/home/current_screen/current_screen.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:logger/logger.dart';

import 'completed_screen/completed_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Widget get appBar => const HomeAppBar();
  Widget get tabBar => const HomeTabBar();
  List<Widget> tabs = [const CurrentScreen(), const CompletedScreen()];

  HomeViewModel homeViewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    ScreenUtil();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: colorRed,
          onPressed: () {
            // Get.to(() => OrderDetailsStarted());
            // Logger().i(SharedPref.instance.getUserToken());
            // Get.to(() =>  OrderDetailsStarted());
          },
          child: SvgPicture.asset(
            "assets/svgs/Call Missed.svg",
            fit: BoxFit.cover,
          )),
      backgroundColor: colorTextWhite,
      body: GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          builder: (logic) {
            if (logic.isLoading) {
              return const LoadingCircle();
            } else {
              return Column(
                children: [
                  appBar,
                  const Divider(height: 3),
                  tabBar,
                  Expanded(child: tabs[logic.selectedTab])
                ],
              );
            }
          }),
    );
  }
}
