import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_driver/feature/view/screens/home/current_screen/Widgets/home_card.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({Key? key}) : super(key: key);
  // Widget get card => const HomeCard();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<HomeViewModel>(
            builder: (home) {
              return Expanded(
                child: ListView(
                    padding: EdgeInsets.all(padding0!),
                    children: home.tasksDone
                        .asMap()
                        .map((i, element) => MapEntry(
                            i,
                            HomeCard(
                              index: i,
                              task: element,
                            )))
                        .values
                        .toList()),
                // child: ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: 2,
                //     itemBuilder: (context, index) {
                //       return HomeCard();
                //     }),
              );
            },
          )
        ],
      ),
    );
  }
}
