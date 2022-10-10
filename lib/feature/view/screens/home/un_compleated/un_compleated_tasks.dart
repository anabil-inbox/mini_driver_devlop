import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/core/loading_circle.dart';
import 'package:inbox_driver/feature/view/screens/home/current_screen/Widgets/home_card.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/icon_btn.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:intl/intl.dart';

class UnCompletedScreen extends StatelessWidget {
  const UnCompletedScreen({Key? key}) : super(key: key);

  // Widget get card => const HomeCard();
  static HomeViewModel get homeViewModel => Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: FittedBox(
          child: CustomTextView(
            txt: txtUnCompleted.tr,
            maxLine: Constance.maxLineOne,
            textStyle: textStyleAppBarTitle(),
          ),
        ),
        isCenterTitle: false,
        leadingWidget: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: isArabicLang()
              ? SvgPicture.asset("assets/svgs/back_arrow_ar.svg")
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        actionsWidgets: [
          GetBuilder<HomeViewModel>(
            // assignId: true,
            initState: (_){
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                homeViewModel.selectedDateTime = null;
              });
            },
            builder: (logic) {
              return InkWell(
                onTap: () {
                  homeViewModel.selectedDateTime = null;
                  homeViewModel.getUnCompletedTasks(taskDate: null);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: sizeW4!),
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeH7!, vertical: sizeH4!),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(padding6!),
                    color: colorPrimaryOpcaityColor,
                  ),
                  child: Text(
                    "${txtClear.tr} ${homeViewModel.selectedDateTime != null ?DateFormat("yyyy-MM-dd").format(
                        homeViewModel.selectedDateTime!  ):""}",
                    style: TextStyle(color: colorPrimary, fontSize: fontSize12),
                  ),
                ),
              );
            },
          ),
          SizedBox(width: sizeW12,),
          IconBtn(
            icon: "assets/svgs/Filter.svg",
            iconColor: colorPrimary,
            width: sizeW48,
            height: sizeH48,
            backgroundColor: colorPrimaryOpcaityColor,
            onPressed: () {
              homeViewModel.showDatePicker();
            },
            borderColor: colorTrans,
          ),
          SizedBox(width: sizeW12,),

        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<HomeViewModel>(
            initState: (_) {
              WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                _.controller?.getUnCompletedTasks(taskDate: null);
              });
            },
            builder: (home) {
              if (home.isLoading) {
                return Column(
                  children: [
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height / 3,),
                    const LoadingCircle(),
                  ],
                );
              } else if (!home.isLoading && home.tasksUnCompleted.isEmpty) {
                return Expanded(
                  child: Center(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: sizeH50,
                        ),
                        Center(
                          child: Image.asset(
                            "assets/gif/empty_state.gif",
                            // width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Expanded(
                child: ListView(
                    padding: EdgeInsets.all(padding0!),
                    children: home.tasksUnCompleted
                        .asMap()
                        .map((i, element) =>
                        MapEntry(
                            i,
                            HomeCard(
                              isFromCompleted: false,
                              index: i,
                              task: element,
                            )))
                        .values
                        .toList()),
              );
            },
          )
        ],
      ),
    );
  }
}
