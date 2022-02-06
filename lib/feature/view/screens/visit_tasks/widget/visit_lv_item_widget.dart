import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/home/sales_data.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/feature/model/home/task_model.dart';
import 'package:inbox_driver/feature/view/screens/details/order_details_started_screen.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/call_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';

class VisitLvItemWidget extends StatelessWidget {
  const VisitLvItemWidget(
      {Key? key,
      this.isBlockContainer = false,
      required this.salesData,
      required this.salesOrder,
      required this.task,
      required this.index})
      : super(key: key);
  final bool? isBlockContainer;

  final SalesOrder salesOrder;
  final SalesData salesData;
  final int index;
  final TaskModel task;

  Widget chipStatusWidget(
          {var title,
          Color? titleColor,
          Color? backgroundColor,
          bool? isOutBound}) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: sizeH4!),
        decoration: BoxDecoration(
          color: backgroundColor ?? colorBlueLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (isOutBound != null && isOutBound)
                SvgPicture.asset(
                  "assets/svgs/out_bound_fig.svg",
                  color: titleColor ?? colorBlue,
                ),
              if (isOutBound != null && !isOutBound)
                SvgPicture.asset(
                  "assets/svgs/in_bound_fig.svg",
                  color: titleColor ?? colorBlue,
                ),
              SizedBox(
                width: sizeW4!,
              ),
              CustomTextView(
                txt: title ?? "Out Bound",
                textStyle: textStyleNormal()?.copyWith(
                    color: titleColor ?? colorBlue, fontSize: fontSize13),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => OrderDetailsStarted(
                  task: task,
                  salesData: salesData,
                  salesOrder: salesOrder,
                  index: index,
                ));
          },
          child: Container(
            // margin: EdgeInsets.only(left: sizeW10!, right: sizeW10!, top: sizeH10!),
            padding:
                EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH17!),
            decoration: BoxDecoration(
              color: colorTextWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Stack(
                      children: [
                        SvgPicture.asset('assets/svgs/Folder_Shared.svg'),
                        PositionedDirectional(
                          start: 0,
                          top: 3,
                          end: 0,
                          bottom: 0,
                          child: CustomTextView(
                            txt: "X ${salesOrder.totalBoxes}",
                            textAlign: TextAlign.center,
                            textStyle: textStyleNormal()
                                ?.copyWith(color: colorTextWhite),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    chipStatusWidget(
                        isOutBound: false, title: salesOrder.contentStatus),
                    // chipStatusWidget(),
                  ],
                ),
                SizedBox(height: sizeH10),
                CustomTextView(
                  txt: salesOrder.customerId,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
                SizedBox(height: sizeH5),
                CustomTextView(
                  txt: salesOrder.orderShippingAddress ??
                      salesOrder.orderWarehouseAddress ??
                      "",
                  textStyle: textStyleNormal()?.copyWith(fontSize: fontSize13),
                  maxLine: Constance.maxLineTwo,
                ),
                SizedBox(height: sizeH10),
                CustomTextView(
                  txt: salesOrder.deliveryDate.toString().split(" ")[0],
                  textStyle: textStyleNormal()?.copyWith(
                      fontSize: fontSize12,
                      color: colorTextHint.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        ),
        // ignore: todo
        //TODO: this for Make CAll
        PositionedDirectional(
            bottom: sizeH20,
            end: sizeW30,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                Get.bottomSheet(
                    CallBottomSheet(
                      phoneNumber: salesOrder.customerMobile,
                    ),
                    isScrollControlled: true);
              },
              icon: SvgPicture.asset(
                "assets/svgs/call_red_fig.svg",
              ),
            )),
        // ignore: todo
        //TODO: this for block container
        if (isBlockContainer!)
          Container(
            margin:
                EdgeInsets.only(left: sizeW10!, right: sizeW10!, top: sizeH10!),
            width: double.infinity,
            height: sizeH140,
            decoration: BoxDecoration(
              color: colorTextWhite.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
      ],
    );
  }
}
