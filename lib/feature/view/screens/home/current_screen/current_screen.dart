import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

import 'Widgets/home_card.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  State<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<HomeViewModel>(builder: (home) {
            if (!home.isLoading && home.tasksInProgress.isEmpty) {
              return Expanded(
                child: Center(
                  child: ListView(
                    children: [
                      SizedBox(height: sizeH50,),
                      Center(
                        child: Image.asset("assets/gif/empty_state.gif" ,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Expanded(
                child: ListView(
                    padding: EdgeInsets.all(padding0!),
                    children: home.tasksInProgress
                        .asMap()
                        .map((i, element) => MapEntry(
                            i,
                            (home.tdSearchHome.text.isEmpty ||
                                    element.taskName!.toLowerCase().contains(
                                        home.tdSearchHome.text.toLowerCase()))
                                ? HomeCard(
                                    isFromCompleted: false,
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
