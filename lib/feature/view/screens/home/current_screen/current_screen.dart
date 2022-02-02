import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

import 'Widgets/home_card.dart';

class CurrentScreen extends StatelessWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
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
                            (home.tdSearchHome.text.isEmpty ||
                                    element.taskName!
                                        .toLowerCase()
                                        .contains(
                                            home.tdSearchHome.text.toLowerCase()))
                                ? HomeCard(
                                    index: i,
                                    task: element,
                                  )
                                : const SizedBox()))
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
