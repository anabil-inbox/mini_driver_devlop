import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

import '../../../../util/app_dimen.dart';
import '../../../../util/app_style.dart';
import '../../../../util/constance.dart';
import '../../../core/loading_circle.dart';
import '../../widgets/custome_text_view.dart';
import '../../widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: "Notifications",
          maxLine: Constance.maxLineOne,
          textStyle: textStyleAppBarTitle(),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GetBuilder<HomeViewModel>(
              initState: (_) {
                WidgetsBinding.instance
                    ?.addPostFrameCallback((timeStamp) async {
                  await homeViewModel.getNotification();
                });
              },
              builder: (home) {
                if (home.isLoading) {
                  return const LoadingCircle();
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: padding14!),
                    itemCount: home.notifications.length,
                    itemBuilder: (context, index) => NotificationItem(
                      notification: home.notifications[index],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
