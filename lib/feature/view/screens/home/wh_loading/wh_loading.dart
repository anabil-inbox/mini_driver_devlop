import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/home/Widgets/home_tabbar.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/Widgets/chart_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/Widgets/wh_search_bar.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:get/get.dart';

import 'Widgets/wh_loading_appbar.dart';

class WhLoading extends StatelessWidget {
  const WhLoading({Key? key}) : super(key: key);

  Widget get appBar => const WhLoadingAppBar();
  Widget get tabBar => const HomeTabBar();
  Widget get searchBar => const WhSearchBar();
  // Widget get chart => WhLoadingChart();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
        backgroundColor: scaffoldColor,
        body: GetBuilder<HomeViewModel>(
            init: HomeViewModel(),
            builder: (logic) {
              return Column(
                children: [
                  appBar,
                  const Divider(height: 3),
                  tabBar,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding20!),
                    child: Column(
                      children: [
                        searchBar,
                        SizedBox(
                          height: sizeH10,
                        ),
                        const ChartWidget(
                          firstGreenValue: 40,
                          firstRedValue: 60,
                          firstTitle: "12/15 \nBoxes",
                          secondGreenValue: 30,
                          secondRedValue: 100,
                          secondTitle: "4/5 \nOthers",
                          mainTitle: "22/6/2021 6:00 PM",
                        )
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}
