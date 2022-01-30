import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/view/screens/visit_tasks/widget/visit_lv_item_widget.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';

class CompletedTabWidget extends StatelessWidget {
  const CompletedTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return ListView.builder(
      physics: customScrollViewIOS(),
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (context, index) => const VisitLvItemWidget(),);
  }
}
