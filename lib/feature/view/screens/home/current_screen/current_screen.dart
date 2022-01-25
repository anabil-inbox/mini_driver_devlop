import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/screens/home/current_screen/Widgets/home_card.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

class CurrentScreen extends StatelessWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   Future.delayed(const Duration(seconds: 3)).then((value) {
    //     Get.to(() => const OrderDetailsStarted());
    //   });
    // });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<HomeViewModel>(builder: (home) {
            return Expanded(
                child: ListView(
                    padding: EdgeInsets.all(padding0!),
                    children: home.tasksInProgress
                        .asMap()
                        .map((i, element) => MapEntry(
                            i,
                            HomeCard(
                              index: i,
                              task: element,
                            )))
                        .values
                        .toList()));
          })
          // Expanded(
          //   child: ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: 4,
          //       itemBuilder: (context, index) {
          //         return card;
          //       }),
          // )
        ],
      ),
    );
  }
}
