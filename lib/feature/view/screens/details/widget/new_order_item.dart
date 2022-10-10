import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/util/string.dart';

class NewOrderItemTask extends StatelessWidget {
  const NewOrderItemTask(
      {Key? key, required this.index, required this.orderItem})
      : super(key: key);
  final int index;
  final OrderItem orderItem;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding16!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding6!),
        color: colorBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: sizeH16!),
          index == 0
              ? Row(
                  children: [
                    SvgPicture.asset("assets/svgs/folder_icon.svg"),
                    SizedBox(
                      width: sizeW10,
                    ),
                    Text(
                      orderItem.itemName ??orderItem.item ?? "",
                      style: textStyleMeduimPrimaryText()!.copyWith(
                        fontSize: fontSize16,
                      ),
                    )
                  ],
                )
              : const SizedBox(),
          index == 0 ? SizedBox(height: sizeH16!) : const SizedBox(),
          index == 0
              ? Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: padding16!, right: padding16!),
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        childAspectRatio: (2 / 0.4)),
                    itemCount: orderItem.boxes?.length,
                    itemBuilder: (context, index) {
                      return Text(orderItem.boxes?[index] ?? "");
                    },
                  ),
                )
              : const SizedBox(),
          index == 0 ? SizedBox(height: sizeH16!) : const SizedBox(),
          index == 0
              ? Row(
                  children: [
                     Text("${txtTotal.tr}:"),
                    const Spacer(),
                    Text(
                      getPriceWithFormate(price: orderItem.totalPrice ?? 0),
                      style: textStylePrimary()!.copyWith(fontSize: fontSize16),
                    ),
                  ],
                )
              : const SizedBox(),
          index == 0 ? SizedBox(height: sizeH16!) : const SizedBox(),
        ],
      ),
    );
  }
}
