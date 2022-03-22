import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    screenUtil(context);
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (logic) {
        return Container(
          color: colorTextWhite,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      logic.changeTab(0);
                      logic.isTabBarOutBox = false;
                    },
                    child: Container(
                      height: sizeH45,
                      padding: EdgeInsets.only(bottom: sizeH5!),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: logic.selectedTab == 0
                                      ? colorRed
                                      : colorTrans,
                                  style: BorderStyle.solid))),
                      child: Center(
                        child: CustomTextView(
                          txt: txtCurrent.tr,
                          textStyle: (logic.selectedTab == 0)
                              ? textStyleNormal()?.copyWith(
                                  color: colorRed, fontSize: fontSize14)
                              : textStyleNormal()?.copyWith(
                                  color: colorTextHint1, fontSize: fontSize13),
                        ),
                      ),
                    )),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    logic.changeTab(1);
                    logic.isTabBarOutBox = true;
                  },
                  child: Container(
                    height: sizeH50,
                    padding: EdgeInsets.only(bottom: sizeH5!),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: logic.selectedTab == 1
                                    ? colorRed
                                    : Colors.transparent,
                                style: BorderStyle.solid))),
                    child: Center(
                      child: CustomTextView(
                        txt: txtCompleted.tr,
                        textStyle: (logic.selectedTab == 1)
                            ? textStyleNormal()?.copyWith(
                                color: colorRed, fontSize: fontSize14)
                            : textStyleNormal()?.copyWith(
                                color: colorTextHint1, fontSize: fontSize13),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
