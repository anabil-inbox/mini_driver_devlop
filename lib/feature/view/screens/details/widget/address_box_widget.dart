import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:inbox_driver/feature/model/home/sales_order.dart';
import 'package:inbox_driver/feature/view/widgets/bottom_sheet_widget/map_bottom_sheet.dart';
import 'package:inbox_driver/feature/view/widgets/custome_text_view.dart';
import 'package:inbox_driver/feature/view_model/map_view_model/map_view_model.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/string.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key, required this.salesOrder}) : super(key: key);

  final SalesOrder salesOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding20!),
      decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(padding16!)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: sizeH13,
                ),
                CustomTextView(
                  txt: txtDeliveryAddress.tr,
                  maxLine: Constance.maxLineOne,
                  textStyle: textStyleNormal()?.copyWith(color: colorBlack),
                ),
                SizedBox(
                  height: sizeH1,
                ),
                InkWell(
                  onTap: () => _goToMap(salesOrder: salesOrder),
                  child: CustomTextView(
                    txt: salesOrder.orderShippingAddress ??
                        salesOrder.orderWarehouseAddress,
                    maxLine: Constance.maxLineOne,
                    textStyle: textStyleNormal(),
                  ),
                ),
                SizedBox(
                  height: sizeH13,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => 
              _goToMap(salesOrder: salesOrder),
            
            child: Image.asset(
              "assets/png/Location.png",
              height: sizeH32,
              width: sizeW30,
            ),
          ),
        ],
      ),
    );
  }

  void _goToMap({required SalesOrder salesOrder}) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Get.put(MapViewModel());
      Get.bottomSheet(
          MapBottomSheet(
            salesOrder: salesOrder,
          ),
          enableDrag: true,
          isScrollControlled: true,
          clipBehavior: Clip.hardEdge);
    });
  }
}
