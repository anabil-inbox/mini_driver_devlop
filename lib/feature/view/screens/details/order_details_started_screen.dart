import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/address_box_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/name_box_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/order_list_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/order_summery_widget.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/schedule%20_box_widget.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/instant_order_view.dart';
import 'package:inbox_driver/feature/view/widgets/appbar/custom_app_bar_widget.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/no_show_report_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view/widgets/secondery_form_button.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';

class OrderDetailsStarted extends StatelessWidget {
  const OrderDetailsStarted({Key? key}) : super(key: key);

  Widget get orderStatus => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(vertical: sizeH7!, horizontal: sizeW12!),
            decoration: BoxDecoration(
              color: colorRedTrans,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: CustomTextView(
              txt: txtCancel!.tr,
              textStyle: textStyleNormal()?.copyWith(color: colorRed),
            )),
          ),
        ],
      );
  Widget get previousTask => Container(
        height: sizeH25,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: sizeH5!),
        decoration: BoxDecoration(
          color: colorBlue,
        ),
        child: Center(
            child: CustomTextView(
          txt: txtPreviousTask.tr,
          textStyle: textStyleNormal()
              ?.copyWith(color: colorTextWhite, fontSize: fontSize13),
        )),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleWidget: CustomTextView(
          txt: txtOrderDetails.tr,
          maxLine: Constance.maxLineOne,
          textStyle: textStyleAppBarTitle(),
        ),
        isCenterTitle: true,
      ),
      body: GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          builder: (logic) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding20!),
                  child: Column(
                    children: [
                      SizedBox(height: sizeH17),
                      Expanded(
                        child: ListView(
                          children: [
                            SizedBox(height: sizeH17),
                            // todo for order order Status scenario
                            orderStatus,
                            SizedBox(height: sizeH10),
                            const NameBox(),
                            SizedBox(height: sizeH10),
                            const AddressBox(),
                            SizedBox(height: sizeH10),
                            const ScheduleBox(),
                            SizedBox(height: sizeH10),
                            const OrderSummeryWidget(),
                            SizedBox(height: sizeH10),
                            // todo for order list scenario
                            const OrderList(),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: logic.isSelected,
                        child: Center(
                          child: PrimaryButton(
                            isExpanded: true,
                            isLoading: false,
                            textButton: txtButtonStart.tr,
                            onClicked: () {
                              logic.isSelected = !logic.isSelected;
                              logic.update();
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !logic.isSelected,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryButton(
                                isExpanded: false,
                                isLoading: false,
                                onClicked: () {
                                  Get.to(() => const InstantOrder());
                                  logic.isSelected = !logic.isSelected;
                                  logic.update();
                                },
                                textButton: "Delivered",
                              ),
                              SizedBox(
                                width: sizeW12,
                              ),
                              SizedBox(
                                width: sizeW150,
                                child: SeconderyFormButton(
                                  buttonText: "No Show",
                                  onClicked: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const NoShowReportBottomSheet(),
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      )),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeH27,
                      ),
                    ],
                  ),
                ),
                // todo for order previous Task bar scenario
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: previousTask,
                ),
              ],
            );
          }),
    );
  }
}
