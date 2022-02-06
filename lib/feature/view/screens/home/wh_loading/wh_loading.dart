import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/core/loading_circle.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/Widgets/wh_loading_tabbar.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/wh_completed_screen.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/wh_current_screen.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:logger/logger.dart';

import 'Widgets/wh_loading_appbar.dart';

// ignore: must_be_immutable
class WhLoading extends StatelessWidget {
  const WhLoading({Key? key, required this.task, required this.index , required this.isFromCurrent})
      : super(key: key);

  Widget get appBar => WhLoadingAppBar(
        title: task.taskName ?? "",
      );
  Widget get tabBar => const WHLoadingTabBar();
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  final TaskModel task;
  final int index;
  final bool isFromCurrent;

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              WhLoadingAppBar(
                title: task.taskName ?? "",
              ),
              const Divider(
                height: 3,
              ),
              Container(
                color: colorBackground,
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: colorPrimary,
                  labelPadding: const EdgeInsets.all(0),
                  onTap: (index){
                    Logger().e(index);
                  },
                  tabs: [
                    Tab(text: txtCurrent.tr ),
                    Tab(text: txtCompleted.tr,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    RefreshIndicator(
                      color: colorPrimary,
                      onRefresh: () async {
                        await homeViewModel.getSpecificTask(
                            taskId: task.id ?? "",
                            taskSatus: Constance.inProgress);
                      },
                      child: WHCurrentScreen(
                        i: index,
                        task: task,
                      ),
                    ),
                    RefreshIndicator(
                      color: colorPrimary,
                      onRefresh: () async {
                        await homeViewModel.getSpecificTask(
                            taskId: task.id ?? "", taskSatus: Constance.done);
                      },
                      child: WHCompletedScreen(
                        i: index,
                        index: index,
                        task: task,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Scaffold(
          //   body: Column(
          //     children: <Widget>[
          // WhLoadingAppBar(
          //   title: task.taskName ?? "",
          // ),
          //       const Divider(height: 3),
          //       SizedBox(
          //         height: 80,
          //         child: AppBar(
          //           backgroundColor: colorBackground,
          //           leading: const SizedBox(),
          //           bottom: TabBar(
          //             tabs: [
          // CustomTextView(
          //   txt: txtCompleted.tr,
          //   textStyle: textStyleNormal()?.copyWith(
          //       color: colorTextHint1, fontSize: fontSize13),
          // ),
          // CustomTextView(
          //   txt: txtCurrent.tr,
          //   textStyle: textStyleNormal()?.copyWith(
          //       color: colorTextHint1, fontSize: fontSize13),
          // ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Expanded(
          // child: TabBarView(
          //   children: [
          //     WHCurrentScreen(
          //       i: index,
          //       task: task,
          //     ),
          //     WHCompletedScreen(
          //       index: index,
          //       task: task,
          //     ),
          //   ],
          // ),
          //       ),
          //     ],
          //   ),
          // ),
        ));
  }
}
