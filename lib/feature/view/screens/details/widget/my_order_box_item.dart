import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/feature/model/tasks/box_model.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/option_detailes.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';

class MyOrderBoxItem extends StatelessWidget {
  const MyOrderBoxItem({Key? key, required this.orderItem, required this.boxes})
      : super(key: key);

  final OrderItem orderItem;
  final List<BoxModel> boxes;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      margin: const EdgeInsets.only(bottom: padding10),
      padding: const EdgeInsets.symmetric(vertical: padding10),
      decoration: BoxDecoration(
        color: colorBackground,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: sizeW10,
              ),
              SvgPicture.asset("assets/svgs/folder_icon.svg"),
              SizedBox(
                width: sizeW10,
              ),
              SizedBox(width: sizeW200, child: Text(orderItem.item ?? "")),
              const Spacer(),
              Column(
                children: [
                  SizedBox(
                    height: sizeH16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(padding6!),
                      color: scaffoldColor,
                    ),
                    padding: const EdgeInsets.all(padding7),
                    child: Text(
                      "X ${orderItem.quantity?.toInt()}",
                      style:
                          textStylePrimarySmall()!.copyWith(color: colorBlack),
                    ),
                  ),
                  // SizedBox(
                  //   height: sizeH16,
                  // ),
                  // Container(
                  //   color: colorBackground,
                  //   child: Text(
                  //     getPriceWithFormate(price: orderItem.totalPrice ?? 0),
                  //     style: textStylePrimarySmall(),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                width: sizeW15,
              ),
            ],
          ),
          SizedBox(
            height: sizeH10,
          ),
          OptionDeatailes(
            orderItem: orderItem,
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              itemCount: boxes.length,
              padding:  EdgeInsets.symmetric(horizontal: padding20!),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Text(boxes[index].serial ?? ""),
              separatorBuilder: (context, index) => SizedBox(width : sizeW12),
            ),
          ),
          SizedBox(
            height: sizeH10,
          ),
          Row(
            children: [
              SizedBox(
                width: sizeW15,
              ),
               Text("${txtTotal.tr}:"),
              const Spacer(),
              Text(
                getPriceWithFormate(price: orderItem.totalPrice ?? 0),
                style: textStylePrimary()!.copyWith(fontSize: fontSize16),
              ),
              SizedBox(
                width: sizeW15,
              ),
            ],
          ),
          SizedBox(
            height: sizeH4,
          )
        ],
      ),
    );
  }
}
