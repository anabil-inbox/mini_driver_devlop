import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_driver/feature/view/screens/home/qr_scan/scan_screen.dart';
import 'package:inbox_driver/feature/view/screens/visit_tasks/widget/completed_tab_widget.dart';
import 'package:inbox_driver/feature/view/screens/visit_tasks/widget/ongoing_tab_widget.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custom_text_filed.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/icon_btn.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';

class VisitTasksView extends StatefulWidget {
  const VisitTasksView({Key? key}) : super(key: key);

  @override
  State<VisitTasksView> createState() => _VisitTasksViewState();
}

class _VisitTasksViewState extends State<VisitTasksView>
    with SingleTickerProviderStateMixin {
  TabController? myTabController;

  PreferredSizeWidget get myAppbar => CustomAppBarWidget(
        elevation: 0,
        appBarColor: colorBackground,
        isCenterTitle: true,
        titleWidget: CustomTextView(
          txt: txtVisitTasks.tr,
          textStyle: textStyleBlack16(),
        ),
        actionsWidgets: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: sizeW2!, vertical: sizeH7!),
            child: IconBtn(
              icon: "assets/svgs/Call Missed.svg",
              iconColor: colorRed,
              width: sizeW36,
              height: sizeH36,
              backgroundColor: Colors.transparent,
              onPressed: () {
                // Get.to(() => const CartScreen());
              },
              borderColor: colorRed,
            ),
          ),
          SizedBox(
            width: sizeW20,
          )
        ],
      );

  Widget myTabBar() => Container(
        color: colorTextWhite,
        child: TabBar(
            labelPadding: EdgeInsets.all(sizeRadius10!),
            onTap: (value) {},
            indicatorColor: colorPrimary,
            labelStyle: textStyleNormal()
                ?.copyWith(color: colorRed, fontSize: fontSize14),
            unselectedLabelStyle: textStyleNormal()
                ?.copyWith(color: colorTextHint1, fontSize: fontSize13),
            labelColor: colorRed,
            unselectedLabelColor: colorTextHint1,
            controller: myTabController,
            tabs: [
              CustomTextView(
                txt: txtOngoing.tr,
              ),
              CustomTextView(
                txt: txtCompleted.tr,
              ),
            ]),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: myAppbar,
      body: Column(
        children: [
          //TODO: here we will add getX controller sa a parameter to [myTabBar]
          myTabBar(),
          Expanded(
            child: TabBarView(controller: myTabController, children: const [
              OngoingTabWidget(),
              CompletedTabWidget(),
            ]),
          ),
        ],
      ),
    );
  }
}
