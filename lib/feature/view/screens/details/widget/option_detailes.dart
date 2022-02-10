import 'package:flutter/material.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/show_option_item.dart';
import 'package:inbox_driver/util/app_dimen.dart';

class OptionDeatailes extends StatelessWidget {
  const OptionDeatailes({Key? key, required this.orderItem}) : super(key: key);

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: sizeH10,
          ),
          orderItem.options!.isEmpty
              ? const SizedBox()
              : const SizedBox(width: double.infinity, child: Text("options")),
          orderItem.options!.isEmpty
              ? const SizedBox()
              : SizedBox(
                  height: sizeH10,
                ),
          ListView(
            shrinkWrap: true,
            primary: false,
            children: orderItem.options!
                .map((option) => ShowOptionItem(
                    optionTitle: option, isShowingPrice: false , price: ""))
                .toList(),
          )
        ],
      ),
    );
  }
}
