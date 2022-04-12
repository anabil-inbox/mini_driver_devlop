import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/util/app_dimen.dart';

import '../../../../../util/constance.dart';
import '../../../../../util/string.dart';
import '../../../../view_model/home_view_modle/home_view_modle.dart';
import '../../../widgets/primary_button.dart';

class TrasfareContentScreen extends StatelessWidget {
  const TrasfareContentScreen({Key? key, required this.taskId})
      : super(key: key);

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: Center(
          child: GetBuilder<HomeViewModel>(
            builder: (home) {
              return PrimaryButton(
                isExpanded: true,
                isLoading: home.isLoading,
                textButton: txtConfirmTransfer.tr,
                onClicked: () async {
                  await home.confirmTransfer(
                      status: Constance.done, taskId: taskId);
                  // await home.getSpecificTask(
                  //     taskId: taskId, taskSatus: Constance.inProgress);
                  // await home.getSpecificTask(
                  //     taskId: taskId, taskSatus: Constance.done);
                  await home.getHomeTasks(taskType: Constance.done);
                  await home.getHomeTasks(taskType: Constance.inProgress);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
