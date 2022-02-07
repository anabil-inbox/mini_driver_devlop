import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
import 'package:inbox_driver/feature/view/screens/visit_tasks/widget/visit_lv_item_widget.dart';
import 'package:inbox_driver/feature/core/loading_circle.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/Widgets/wh_loading_card.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';

class CompletedLevelOneScreen extends StatelessWidget {
  const CompletedLevelOneScreen(
      {Key? key, required this.title, required this.taskModel})
      : super(key: key);

  final String title;
  final TaskModel taskModel;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  Widget get listViewData {
    return Expanded(
      child: GetBuilder<HomeViewModel>(
        builder: (homeModel) {
          if (GetUtils.isNull(homeViewModel.completedSalesData)) {
            return const SizedBox();
          } else {
            return ListView(
              shrinkWrap: true,
              children: homeViewModel.completedSalesData!.salesOrders!.map((e) {
                if (taskModel.taskName!.toLowerCase().contains(
                        Constance.taskWarehouseLoading.toLowerCase()) ||
                    taskModel.taskName!.toLowerCase().contains(
                        Constance.taskWarehouseClosure.toLowerCase())) {
                  return WhLoadingCard(
                      isFromCompelted: true,
                      onRecivedClick: () {},
                      salesOrder: e,
                      salesData: homeViewModel.completedSalesData!,
                      index: 0,
                      task: taskModel);
                } else if (taskModel.taskName!
                    .toLowerCase()
                    .contains(Constance.taskCustomerVisit.toLowerCase())) {
                  return VisitLvItemWidget(
                    isFromCompleted: true,
                    task: taskModel,
                    index: 0,
                    salesData: homeViewModel.completedSalesData!,
                    salesOrder: e,
                    isBlockContainer: false,
                  );
                } else {}
                return const SizedBox();
              }).toList(),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: CustomTextView(
          txt: title,
          maxLine: Constance.maxLineOne,
          textStyle: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
        leadingWidget: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: isArabicLang()
              ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
      ),
      body: GetBuilder<HomeViewModel>(
        initState: (_) async {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
            await homeViewModel.getSpecificCompleted(
                taskId: taskModel.id ?? "", taskSatus: Constance.done);
          });
        },
        builder: (build) {
          if (build.isLoading) {
            return const LoadingCircle();
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: padding20!),
              child: Column(
                children: [SizedBox(height: sizeH17), listViewData],
              ),
            );
          }
        },
      ),
    );
  }
}
