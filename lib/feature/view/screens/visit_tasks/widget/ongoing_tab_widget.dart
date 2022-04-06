import 'package:flutter/material.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';


class OngoingTabWidget extends StatelessWidget {
  const OngoingTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return 
    const Text("data");
    // ListView.builder(
    //   physics: customScrollViewIOS(),
    //   shrinkWrap: true,
    //   itemCount: 7,
    //   itemBuilder: (context, index) => VisitLvItemWidget(isBlockContainer: index == 0 ? false : true,),);
  }


}
