import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inbox_driver/feature/model/home/sales_data.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/feature/view/screens/home/wh_loading/Widgets/primary_border_button.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/date/date_time_util.dart';
import 'package:inbox_driver/util/font_dimne.dart';
import 'package:inbox_driver/util/string.dart';

class WhLoadingCard extends StatelessWidget {
  const WhLoadingCard(
      {Key? key,
      required this.onRecivedClick,
      required this.salesOrder,
      required this.salesData})
      : super(key: key);

  final Function onRecivedClick;
  final SalesOrder salesOrder;
  final SalesData salesData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorTextWhite,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeW15!),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: sizeH17),
                Row(
                  children: <Widget>[
                    SizedBox(width: sizeW5),
                    Stack(
                      children: [
                        SvgPicture.asset('assets/svgs/folder.svg'),
                        PositionedDirectional(
                            top: padding6,
                            start: padding9,
                            child: Text(
                              "X ${salesOrder.totalBoxes}",
                              style: textStyleSmall()
                                  ?.copyWith(color: colorTextWhite),
                            ))
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: sizeH30,
                      color: colorGreen.withOpacity(0.1),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: sizeW7!),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset("assets/svgs/Tringle_Up.svg"),
                            SizedBox(width: sizeW5),
                            CustomTextView(
                              txt: salesOrder.contentStatus,
                              textStyle: textStyleNormal()?.copyWith(
                                  fontSize: fontSize12, color: colorGreenText),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: sizeH7),
                CustomTextView(
                  txt: salesOrder.customerId,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
                SizedBox(height: sizeH4),
                CustomTextView(
                  txt: salesOrder.orderShippingAddress ??
                      salesOrder.orderWarehouseAddress ??
                      "",
                  textStyle: textStyleNormal()?.copyWith(
                      color: seconderyButtonUnSelected, fontSize: fontSize13),
                ),
                SizedBox(height: sizeH4),
                CustomTextView(
                  txt: DateUtility.getChatTime(
                      salesOrder.deliveryDate.toString()),
                  textStyle: textStyleNormal()?.copyWith(fontSize: fontSize12),
                ),
                SizedBox(
                  height: sizeH10,
                ),
                PrimaryBorderButton(
                    buttonText: txtReceived,
                    function: () {
                      onRecivedClick();
                    }),
                SizedBox(height: sizeH16),
              ],
            ),
          ),
        ),
        SizedBox(height: sizeH10),
      ],
    );
  }

  // Widget get btn => Padding(
  //       padding: EdgeInsets.symmetric(horizontal: sizeW15!, vertical: sizeH10!),
  //       child: Container(
  //         height: sizeH40,
  //         decoration: BoxDecoration(
  //           color: colorTextWhite,
  //           borderRadius: BorderRadius.circular(10),
  //           border: Border.all(color: colorRed),
  //         ),
  //         child: Center(
  //             child: CustomTextView(
  //           txt: txtReceived,
  //           textStyle: textStyleNormal()?.copyWith(color: colorRed),
  //         )),
  //       ),
  //     );
}
