import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/feature/view/screens/details/widget/order_item.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:get/get.dart';

import '../../../../../util/app_shaerd_data.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key, required this.orderItems}) : super(key: key);
  Widget get bulkItem => Container(
        padding: EdgeInsets.symmetric(horizontal: sizeW20!, vertical: sizeH17!),
        decoration: BoxDecoration(
          color: colorSearchBox,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: <Widget>[
                SvgPicture.asset('assets/svgs/Folder_Shared.svg'),
                SizedBox(width: sizeW7),
                CustomTextView(
                  txt: txtBulkItem.tr,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
              ],
            ),
            SizedBox(height: sizeH10),
            CustomTextView(
              txt: txtAllItems.tr,
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            ),
            SizedBox(height: sizeH5),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeH10!, vertical: sizeH5!),
                  decoration: BoxDecoration(
                    color: colorBtnGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        CustomTextView(
                          txt: txtTV.tr,
                          textStyle: textStyleNormal()?.copyWith(
                              color: colorBlack, fontSize: fontSize13),
                        ),
                        SizedBox(width: sizeW10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorTextWhite,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeW10!, vertical: sizeH4!),
                          child: CustomTextView(
                            txt: '2',
                            textStyle: textStyleNormal()?.copyWith(
                                color: colorBlack, fontSize: fontSize13),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: sizeW5),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeH10!, vertical: sizeH5!),
                  decoration: BoxDecoration(
                    color: colorBtnGray,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        CustomTextView(
                          txt: 'Washer',
                          textStyle: textStyleNormal()?.copyWith(
                              color: colorBlack, fontSize: fontSize13),
                        ),
                        SizedBox(width: sizeW10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: colorTextWhite,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeW10!, vertical: sizeH4!),
                          child: CustomTextView(
                            txt: '2',
                            textStyle: textStyleNormal()?.copyWith(
                                color: colorBlack, fontSize: fontSize13),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: sizeH10),
            CustomTextView(
              txt: txtOptions.tr,
              textStyle: textStyleNormal()?.copyWith(color: colorBlack),
            ),
            SizedBox(height: sizeH5),
            Row(
              children: [
                SvgPicture.asset('assets/svgs/check_true.svg'),
                SizedBox(width: sizeW7),
                CustomTextView(
                  txt: txtValuableItem.tr,
                  textStyle: textStyleNormal()?.copyWith(fontSize: fontSize13),
                ),
              ],
            ),
            SizedBox(height: sizeH10),
            Row(
              children: [
                SvgPicture.asset('assets/svgs/check_true.svg'),
                SizedBox(width: sizeW7),
                CustomTextView(
                  txt: txtValuableItem.tr,
                  textStyle: textStyleNormal()?.copyWith(fontSize: fontSize13),
                ),
              ],
            ),
          ],
        ),
      );

  final List<OrderItem> orderItems;
  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: sizeH13),
          CustomTextView(
            txt: txtOrderList.tr,
            maxLine: Constance.maxLineOne,
            textStyle: textStyleNormal()?.copyWith(color: colorBlack),
          ),
          SizedBox(height: sizeH13),
          ListView(
              shrinkWrap: true,
              primary: false,
              children:
                  orderItems.map((e) => OrderListItem(orderItem: e)).toList()),
          SizedBox(height: sizeH13),
        ],
      ),
    );
  }
}
