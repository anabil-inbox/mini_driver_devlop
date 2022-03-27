import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/profile/log_model.dart';
import 'package:inbox_driver/feature/view/screens/profile/log/widgets/log_item.dart';

import '../../../../../util/app_dimen.dart';
import '../../../../../util/app_shaerd_data.dart';
import '../../../../../util/app_style.dart';
import '../../../../view_model/profile_view_modle/profile_view_modle.dart';
import '../../../widgets/appbar/custom_app_bar_widget.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({Key? key}) : super(key: key);

  static ProfileViewModle profileViewModle = Get.find<ProfileViewModle>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: Text(
          "Log",
          style: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding20!),
        child: GetBuilder<ProfileViewModle>(
            init: ProfileViewModle(),
            initState: (_) async {
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
                // await profileViewModle.getUserLog();
              });
            },
            builder: (log) {
              if (log.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // else if (log.userLogs.isEmpty) {
              //   return const SizedBox();
              // } else {

              return ListView.builder(
                padding: const EdgeInsets.only(top: padding10),
                itemCount: 20,
                itemBuilder: (context, index) =>
                    LogItem(log: Log(message: "", id: "")),
              );
            }
            // },
            ),
      ),
    );
  }
}
