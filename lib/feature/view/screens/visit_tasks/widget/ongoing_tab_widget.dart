import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_driver/feature/view/screens/visit_tasks/widget/visit_lv_item_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';

class OngoingTabWidget extends StatelessWidget {
  const OngoingTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return 
    Text("data");
    // ListView.builder(
    //   physics: customScrollViewIOS(),
    //   shrinkWrap: true,
    //   itemCount: 7,
    //   itemBuilder: (context, index) => VisitLvItemWidget(isBlockContainer: index == 0 ? false : true,),);
  }


}
