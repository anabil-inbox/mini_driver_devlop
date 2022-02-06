import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({Key? key, required this.orderItem}) : super(key: key);

  final OrderItem orderItem;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              SizedBox(
                width: sizeW172,
                child: CustomTextView(
                  txt: orderItem.item,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: sizeH10!, vertical: sizeH4!),
                decoration: BoxDecoration(
                  color: colorTextWhite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CustomTextView(
                    txt: "X ${orderItem.quantity.toString()}",
                    textStyle: textStyleNormal()
                        ?.copyWith(color: colorRed, fontSize: fontSize13),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: sizeH10),
          CustomTextView(
            txt: txtOptions.tr,
            textStyle: textStyleNormal()?.copyWith(color: colorBlack),
          ),
          SizedBox(height: sizeH5),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) => SizedBox(height: sizeH10),
            itemCount: orderItem.options!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  SvgPicture.asset('assets/svgs/check_true.svg'),
                  SizedBox(width: sizeW7),
                  CustomTextView(
                    txt: orderItem.options?[index],
                    textStyle:
                        textStyleNormal()?.copyWith(fontSize: fontSize13),
                  ),
                ],
              );
            },
          ),

          // Row(
          //   children: [
          //     SvgPicture.asset('assets/svgs/check_true.svg'),
          //     SizedBox(width: sizeW7),
          //     CustomTextView(
          //       txt: txtValuableItem.tr,
          //       textStyle: textStyleNormal()?.copyWith(fontSize: fontSize13),
          //     ),
          //   ],
          // ),
          // SizedBox(height: sizeH10),
          // Row(
          //   children: [
          //     SvgPicture.asset('assets/svgs/check_true.svg'),
          //     SizedBox(width: sizeW7),
          //     CustomTextView(
          //       txt: txtValuableItem.tr,
          //       textStyle: textStyleNormal()?.copyWith(fontSize: fontSize13),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
