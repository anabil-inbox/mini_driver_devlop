import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';

import '../../../../../util/constance.dart';
import '../../../../../util/string.dart';
import '../../../../view_model/home_view_modle/home_view_modle.dart';
import '../../../widgets/primary_button.dart';
import '../instant_order/Widgets/box_need_scanned_item.dart';

class TrasfareContentScreen extends StatelessWidget {
  const TrasfareContentScreen({Key? key, required this.taskId})
      : super(key: key);

  final String taskId;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          'Trasfare',
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: GetBuilder<HomeViewModel>(builder: (home) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding20!),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: sizeH10),
              const BoxNeedScannedItem(
                isTransfare: true,
              ),
              
              SizedBox(height: sizeH32),
              GetBuilder<HomeViewModel>(
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
              SizedBox(height: sizeH32),

            ],
          ),
        );
      }),
    );
  }
}
