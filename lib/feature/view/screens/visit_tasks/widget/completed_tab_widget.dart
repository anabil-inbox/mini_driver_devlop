import 'package:flutter/material.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';

class CompletedTabWidget extends StatelessWidget {
  const CompletedTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return 
    const Text("data");
    // ListView.builder(
    //   physics: customScrollViewIOS(),
    //   shrinkWrap: true,
    //   itemCount: 7,
    //   itemBuilder: (context, index) => const VisitLvItemWidget(),);
  }
}
