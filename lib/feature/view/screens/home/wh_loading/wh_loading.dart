import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/core/loading_circle.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/Widgets/wh_loading_tabbar.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/wh_completed_screen.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/wh_current_screen.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:get/get.dart';

import 'Widgets/wh_loading_appbar.dart';

// ignore: must_be_immutable
class WhLoading extends StatelessWidget {
  const WhLoading({Key? key, required this.task, required this.index})
      : super(key: key);

  Widget get appBar => WhLoadingAppBar(
        title: task.taskName ?? "",
      );
  Widget get tabBar => const WHLoadingTabBar();

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  final TaskModel task;
  final int index;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
        backgroundColor: scaffoldColor,
        body: GetBuilder<HomeViewModel>(
            init: HomeViewModel(),
            initState: (_) async {
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
                await homeViewModel.getSpecificTask(taskId: task.id ?? "");
              });
            },
            builder: (logic) {
              if (logic.isLoading) {
                return const LoadingCircle();
              } else {
                return RefreshIndicator(
                  color: colorPrimary,
                  onRefresh: () async {
                    return homeViewModel.getSpecificTask(taskId: task.id ?? "");
                  },
                  child: Column(
                    children: [
                      WhLoadingAppBar(
                        title: task.taskName ?? "",
                      ),
                      const Divider(height: 3),
                      tabBar,
                      Expanded(
                          child: logic.selectedTab == 0
                              ? WHCurrentScreen(
                                  i: index,
                                  task: task,
                                )
                              : const WHCompletedScreen()),
                    ],
                  ),
                );
              }
            }));
  }
}
